{******************************************************************************}
{                                                                              }
{ MyHomeLib                                                                    }
{                                                                              }
{ Version 0.9                                                                  }
{ 20.08.2008                                                                   }
{ Copyright (c) Oleksiy Penkov  oleksiy.penkov@gmail.com                          }
{                                                                              }
{ @author Nick Rymanov nrymanov@gmail.com                                      }
{                                                                              }
{******************************************************************************}

unit frame_NCWCollectionNameAndLocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frame_InteriorPageBase, StdCtrls, ExtCtrls, unit_StaticTip, unit_AutoCompleteEdit,
  dm_user, unit_Interfaces;

type
  TframeNCWNameAndLocation = class(TInteriorPageBase)
    Label1: TLabel;
    Panel2: TPanel;
    Label9: TLabel;
    edCollectionFile: TMHLAutoCompleteEdit;
    btnNewFile: TButton;
    Label5: TLabel;
    edCollectionRoot: TMHLAutoCompleteEdit;
    btnSelectRoot: TButton;
    Label8: TLabel;
    edCollectionName: TEdit;
    pageHint: TMHLStaticTip;
    procedure btnNewFileClick(Sender: TObject);
    procedure btnSelectRootClick(Sender: TObject);
    procedure CheckControlData(Sender: TObject);
    procedure edCollectionNameChange(Sender: TObject);
    procedure edCollectionFileChange(Sender: TObject);

  private
    procedure ShowPageMessage(const Message: string; AImageIndex: Integer);
    procedure HidePageMessage;
    function IsDataValid(Sender: TObject = nil): Boolean;
    function GetCollectionDataFromINPX:boolean;

  public
    function Activate(LoadData: Boolean): Boolean; override;
    function Deactivate(CheckData: Boolean): Boolean; override;
  end;

var
  frameNCWNameAndLocation: TframeNCWNameAndLocation;

implementation

uses
  unit_Helpers,
  unit_NCWParams,
  unit_Errors,
  unit_Consts,
  unit_Globals,
  unit_MHLArchiveHelpers;

resourcestring
  rstrShowCollectionType = 'Укажите название коллекции.';
  rstrShowCollectionFile = 'Укажите файл коллекции.';
  rstrShowCollectionFolder = 'Укажите расположение папки с книгами.';
  rstrSelectFolder = 'Выберите папку с книгами';
  rstrDamagedArchive = 'Архив поврежден или имеет неправильный формат!';
  rstrInvalidFormat = 'Неверный формат файла INPX!';

{$R *.dfm}

{ TframeNCWNameAndLocation }

function TframeNCWNameAndLocation.GetCollectionDataFromINPX: boolean;
var
  header: TINPXHeader;
  archiver: TMHLZip;
begin
  Result := False;
  Assert(FPParams^.INPXFile <> '');

  if (FPParams^.INPXFile = '') or not (FileExists(FPParams^.INPXFile)) then
    Exit;

  try
    try
      archiver := TMHLZip.Create(FPParams^.INPXFile, True);
      if archiver.Find(COLLECTIONINFO_FILENAME) then
        header.ParseString(archiver.ExtractToString(COLLECTIONINFO_FILENAME))
      else
        raise Exception.Create(rstrInvalidFormat);

      edCollectionName.Text := header.Name;
      edCollectionFile.Text := header.FileName;
      FPParams^.CollectionCode := header.ContentType;

      case FPParams^.CollectionCode of
        CT_PRIVATE_FB:
          FPParams^.CollectionType := ltUserFB;

        CT_PRIVATE_NONFB:
          FPParams^.CollectionType := ltUserAny;

        CT_EXTERNAL_LOCAL_FB:
          FPParams^.CollectionType := ltExternalLocalFB;

        CT_EXTERNAL_LOCAL_NONFB:
          FPParams^.CollectionType := ltExternalLocalAny;

        CT_EXTERNAL_ONLINE_FB:
          FPParams^.CollectionType := ltExternalOnlineFB;

        CT_EXTERNAL_ONLINE_NONFB:
          FPParams^.CollectionType := ltExternalOnlineAny;
      end;
      Result := True;
    except
      on E: Exception do
      begin
        MessageDlg(E.Message, mtError, [mbOK], 0);
        Exit;
      end;
    end;
  finally
    FreeAndNil(archiver);
  end;
end;

procedure TframeNCWNameAndLocation.ShowPageMessage(const Message: string; AImageIndex: Integer);
begin
  pageHint.Caption := Message;
  pageHint.ImageIndex := AImageIndex;
  pageHint.Visible := True;
end;

procedure TframeNCWNameAndLocation.HidePageMessage;
begin
  pageHint.Visible := False;
end;

function TframeNCWNameAndLocation.Activate(LoadData: Boolean): Boolean;
begin
  Result := True;
  if LoadData then
  begin
    if FPParams^.Operation = otInpx then
      Result := GetCollectionDataFromINPX;
    IsDataValid;
  end;
end;

function TframeNCWNameAndLocation.Deactivate(CheckData: Boolean): Boolean;
begin
  FPParams^.DisplayName := edCollectionName.Text;
  FPParams^.CollectionFile := edCollectionFile.Text;
  FPParams^.CollectionRoot := edCollectionRoot.Text;

  if CheckData then
  begin
    Result := IsDataValid;
    if not Result then
      Exit;
  end;

  Result := True;
end;

procedure TframeNCWNameAndLocation.edCollectionFileChange(Sender: TObject);
begin
  CheckControlData(Sender);
end;

procedure TframeNCWNameAndLocation.edCollectionNameChange(Sender: TObject);
begin
  CheckControlData(Sender);
end;

function TframeNCWNameAndLocation.IsDataValid(Sender: TObject = nil): Boolean;
var
  strValue: string;
  SystemData: ISystemData;

  function CheckThis(Control: TObject): Boolean;
  begin
    Result := not Assigned(Sender) or (Sender = Control);
  end;

begin
  Result := False;

  SystemData := SystemDB;

  //
  // Проверим название коллекции
  //
  if CheckThis(edCollectionName) then
  begin
    strValue := Trim(edCollectionName.Text);
    if strValue = '' then
    begin
      ShowPageMessage(rstrShowCollectionType, 0);
      Exit;
    end;

    if SystemData.HasCollectionWithProp(PROP_DISPLAYNAME, strValue) then
    begin
      ShowPageMessage(Format(rstrCollectionAlreadyExists, [strValue]), 2);
      Exit;
    end;
  end;

  //
  // Проверим файл коллекции
  //
  if CheckThis(edCollectionFile) then
  begin
    strValue := Trim(edCollectionFile.Text);
    if strValue = '' then
    begin
      ShowPageMessage(rstrShowCollectionFile, 0);
      Exit;
    end;

    if (FPParams^.Operation = otExisting) and not FileExists(strValue)  then
    begin
      ShowPageMessage(Format(rstrFileDoesntExists, [strValue]), 2);
      Exit;
    end;

    if SystemData.HasCollectionWithProp(PROP_DATAFILE, strValue) then
    begin
      ShowPageMessage(Format(rstrFileAlreadyExistsInDB, [strValue]), 2);
      Exit;
    end;
  end;

  //
  // Проверим корень библиотеки
  //
  if CheckThis(edCollectionRoot) then
  begin
    strValue := Trim(edCollectionRoot.Text);
    if strValue = '' then
    begin
      ShowPageMessage(rstrShowCollectionFolder, 0);
      Exit;
    end;
  end;

  HidePageMessage;

  Result := True;
end;

procedure TframeNCWNameAndLocation.btnNewFileClick(Sender: TObject);
var
  key: TMHLFileName;
  AFileName: string;
begin
  key := fnSaveCollection;
  if FPParams^.Operation = otExisting then
    key := fnOpenCollection;

  if GetFileName(key, AFileName) then
    edCollectionFile.Text := AFileName;
end;

procedure TframeNCWNameAndLocation.CheckControlData(Sender: TObject);
begin
  IsDataValid(Sender);
end;

procedure TframeNCWNameAndLocation.btnSelectRootClick(Sender: TObject);
var
  AFolder: string;
begin
  if GetFolderName(Handle, rstrSelectFolder, AFolder) then
    edCollectionRoot.Text := AFolder;
end;

end.

