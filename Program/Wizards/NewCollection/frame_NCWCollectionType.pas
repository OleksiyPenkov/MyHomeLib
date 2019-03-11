{******************************************************************************}
{                                                                              }
{ MyHomeLib                                                                    }
{                                                                              }
{ Version 0.9                                                                  }
{ 20.08.2008                                                                   }
{ Copyright (c) Aleksey Penkov  alex.penkov@gmail.com                          }
{                                                                              }
{ @author Nick Rymanov nrymanov@gmail.com                                      }
{                                                                              }
{******************************************************************************}

unit frame_NCWCollectionType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frame_InteriorPageBase, StdCtrls, ExtCtrls, unit_StaticTip, unit_NCWParams,
  Mask, RzEdit, RzBtnEdt;

type
  TframeNCWInpxSource = class(TInteriorPageBase)
    Panel1: TPanel;
    pageHint: TMHLStaticTip;
    rbThirdParty: TRadioButton;
    edINPXPath: TRzButtonEdit;
    RadioButton1: TRadioButton;
    procedure OnSetCollectionType(Sender: TObject);
    procedure edINPXPathButtonClick(Sender: TObject);
    procedure GetCollectionDataFromINPX;
  private
    FColTitle : string;
    FColFile  : string;
    FColDescr : string;
    FColCode  : integer;
    FURL      : string;
    FScript   : string;
    FINPXFileName : string;
  public
    function Activate(LoadData: Boolean): Boolean; override;
    function Deactivate(CheckData: Boolean): Boolean; override;
  end;

var
  frameNCWInpxSource: TframeNCWInpxSource;

resourcestring
  EMPTYCOLLECTION = 'Пустая коллекция';
  PRIVATECOLLECTION = 'Частная коллекция';
  LISTBASED = 'Создание коллекции на основе списков книг';
  SELECTTYPE = 'Укажите тип поключаемой коллекции';

  FROMDIFFERNTSOURCES = 'Создавайте такую коллекцию для хранения книг, полученных из различных источников.';
  FROMLIBRUSECARCH = 'Создавайте такую коллекцию если вы уже скачали  Fb2 архивы lib.rus.ec.';
  LIBRUSECDOWNLOAD = 'Книги будут скачиваться с сервера lib.rus.ec по мере необходимости.';
  SERVERDOWNLOAD = 'Книги будут скачиваться с сервера по мере необходимости.';
  THIRDPARTY = 'Коллекция на основе файла *.inpx. Укажите путь к файлу.';

implementation

uses dm_user,unit_settings, unit_globals, unit_Helpers, ZipForge;

{$R *.dfm}

function TframeNCWInpxSource.Activate(LoadData: Boolean): Boolean;
var
  rb: TRadioButton;
begin
  if LoadData then
  begin
    if FPParams^.Operation = otNew then
    begin
        rbEmpty.Caption := EMPTYCOLLECTION;
        SubTitle :=  LISTBASED
    end
    else
    begin
      SubTitle := PRIVATECOLLECTION;
      rbEmpty.Caption := SELECTTYPE;
    end;

    case FPParams^.CollectionType of
      ltEmpty: rb := rbEmpty;
      ltLRELocal: rb := rbLocal;
      ltLREOnline: rb := rbOnline;
//      ltGenesis: rb := rbGenesis;
      ltUserFB2: rb := rbThirdParty;
    else
      Assert(False);
      Result := False;
      Exit;
    end;

    Assert(Assigned(rb));

    rb.Checked := True;
    OnSetCollectionType(rb);
  end;

  Result := True;
end;

function TframeNCWInpxSource.Deactivate(CheckData: Boolean): Boolean;
begin
  if rbEmpty.Checked then
    FPParams^.CollectionType := ltEmpty
  else if rbLocal.Checked then
      FPParams^.CollectionType := ltLRELocal
  else if rbOnline.Checked then
  begin
    FPParams^.CollectionType := ltLREOnline;
    FPParams^.URL := FURL;
    FPParams^.Script := FScript;
  end
  else {if rbGenesis.Checked then
    FPParams^.CollectionType := ltGenesis
  else} if rbThirdParty.Checked then
  begin

    case FColCode of
              0: FPParams^.CollectionType := ltUserFB2;
              1: FPParams^.CollectionType := ltUserAny;
      134283264: FPParams^.CollectionType := ltLREOnline;
    end;

    FPParams^.DisplayName := FColTitle;
    FPParams^.UseDefaultName := False;
    FPParams^.CollectionFile := FColFile;
    FPParams^.UseDefaultLocation := False;
    FPParams^.INPXFile := edINPXPath.Text;
    FPParams^.CollectionCode := FColCode;
    FPParams^.Notes := FColDescr;
    FPParams^.URL := FURL;
    FPParams^.Script := FScript;
  end;
  Result := True;
end;

procedure TframeNCWInpxSource.edINPXPathButtonClick(Sender: TObject);
var
  key: TMHLFileName;
  AFileName: string;
begin
  key := fnOpenINPX;
  if FPParams^.Operation = otExisting then
    key := fnOpenCollection;

  if GetFileName(key, AFileName) then
  begin
    edINPXPath.Text := AFileName;
    FInpxFileName := AFileName;
    GetCollectionDataFromINPX;
  end;
end;

procedure TframeNCWInpxSource.GetCollectionDataFromINPX;
var
  Zip: TZipForge;
  S  : ansistring;

  function GetParam(var S: ansistring): string;
  var
    p: integer;
  begin
    p := pos(#13#10,S);
    if p <> 0 then
    begin
      Result := copy(S,1,p - 1);
      delete(S,1,p + 1);
    end
    else begin
      Result := S;
      S := '';
    end;
  end;


begin
  if FINPXFileName = '' then Exit;

  Zip := TZipForge.Create(self);
  try
    Zip.FileName := FINPXFileName;
    Zip.OpenArchive;
    S := Zip.Comment;
    Zip.CloseArchive;
  finally
    Zip.Free;
  end;

  try
    FColTitle := GetParam(S);
    FColFile := GetParam(S);
    FColCode := StrToInt(GetParam(S));
    FColDescr := GetParam(S);
    if S <> '' then FURL := GetParam(S);
    FScript := '';
    while S <> '' do
      FScript := FScript + GetParam(S) + #13#10;
  except
  end;

end;

procedure TframeNCWInpxSource.OnSetCollectionType(Sender: TObject);
begin
//  FInpxFileName := '';
//  if Sender = rbEmpty then
//    pageHint.Caption := FROMDIFFERNTSOURCES
//  else if Sender = rbLocal then
//    pageHint.Caption := FROMLIBRUSECARCH
//  else if Sender = rbOnline then
//  begin
//    pageHint.Caption := LIBRUSECDOWNLOAD;
//    if edINPXPath.Text <> '' then
//      FInpxFileName := edINPXPath.Text
//    else
//      FINPXFileName := Settings.WorkPath + 'librusec.inpx';
//  end
//  else {if Sender = rbGenesis then
//    pageHint.Caption := SERVERDOWNLOAD
//  else} if Sender = rbThirdParty then
//  begin
//    pageHint.Caption := THIRDPARTY;
//    FInpxFileName := edINPXPath.Text;
//  end;

  if Sender = rbEmpty then
    pageHint.Caption := FROMDIFFERNTSOURCES
  else if Sender = rbLocal then
    pageHint.Caption := FROMLIBRUSECARCH
  else if Sender = rbOnline then
  begin
    pageHint.Caption := LIBRUSECDOWNLOAD;
    FINPXFileName := Settings.SystemFileName[sfLibRusEcInpx];
  end
  else {if Sender = rbGenesis then
    pageHint.Caption := SERVERDOWNLOAD
  else} if Sender = rbThirdParty then
  begin
    pageHint.Caption := THIRDPARTY;
  end;

  GetCollectionDataFromINPX;
  edINPXPath.Visible := (Sender = rbThirdParty );

end;

end.

