(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors Nick Rymanov     nrymanov@gmail.com
  *         Oleksiy Penkov   oleksiy.penkov@gmail.com
  *
  * History
  *
  ****************************************************************************** *)

unit frame_NCWInpxSource;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  frame_InteriorPageBase,
  StdCtrls,
  ExtCtrls,
  unit_StaticTip,
  unit_NCWParams,
  Mask,
  ComCtrls,
  MHLSimplePanel,
  unit_AutoCompleteEdit;

type
  TCollectionDesc = record
    Group: integer;
    Title: string;
    Desc: string;
    INPX: string;
  end;

  TframeNCWInpxSource = class(TInteriorPageBase)
    Panel1: TMHLSimplePanel;
    pageHint: TMHLStaticTip;
    rbLocal: TRadioButton;
    edINPXPath: TMHLAutoCompleteEdit;
    rbDownload: TRadioButton;
    lvCollections: TListView;
    MHLSimplePanel1: TMHLSimplePanel;
    btnSelectINPX: TButton;
    procedure OnSetINPXSource(Sender: TObject);
    procedure edINPXPathButtonClick(Sender: TObject);
    procedure lvCollectionsChange(Sender: TObject; Item: TListItem; Change: TItemChange);

  private
    FGroups: array of string;
    FCollections: array of TCollectionDesc;

    FCollection: TCollectionDesc;

    procedure LoadDescriptions;
    procedure FillList;

  public
    function Activate(LoadData: Boolean): Boolean; override;
    function Deactivate(CheckData: Boolean): Boolean; override;
  end;

var
  frameNCWInpxSource: TframeNCWInpxSource;

implementation

uses
  IOUtils,
  unit_Settings,
  dm_user,
  unit_Helpers,
  IniFiles;

resourcestring
  rstrServerDownload = 'Выбранный файл INPX будет скачан с сервера.';
  rstrLocal = 'Коллекция на основе файла *.inpx. Укажите путь к файлу.';
  //rstrGroupLibrusec = 'Библиотека Lib.rus.ec';
  //rstrGroupFlibusta = 'Библиотека Flibusta';
  //rstrGroupTraum = 'Библиотека Траума';
  //rstrLibrusecFB2 = 'Архивы FB2 (fb2-xxxxxx-xxxxxx.zip)';
  //rstrLibrusecUSR = 'Архивы USR (usr-xxxxxx-xxxxxx.zip)';
  //rstrLibrusecAll = 'Все архивы (fb2-xxxxxx-xxxxxx.zip и usr-xxxxxx-xxxxxx.zip)';
  //rstrLibrusecOnline = 'Книги скачиваются по запросу с серввера lib.rus.ec (необходима регистрация)';
  //rstrFlibustaOnline = 'Книги скачиваются по запросу с сервера flibusta.net';
  //rstrTraum_2_11_FB2 = 'Библиотека Траума 2.11';
  //rstrTraum_2_12_FB2 = 'Библиотека Траума 2.12';
  //rstrTraum_2_13_FB2 = 'Библиотека Траума 2.13 (только FB2)';
  //rstrTraum_2_13_All = 'Библиотека Траума 2.13 (Полная)';

{$R *.dfm}

const
  INPX_SECTION = 'INPX';
  INPX_GROUP_SECTION = 'GROUPS';
  INPX_KEY_PREFIX = 'Inpx';
  INPX_GROUP_KEY_PREFIX = 'Group';

(*
  DefaultGroups: array [0 .. 2] of string = (rstrGroupLibrusec, rstrGroupFlibusta, rstrGroupTraum);

  DefaultCollections: array [0 .. 8] of TCollectionDesc =
  (
    (Group: 0; Title: 'Lib.rus.ec [FB2]';        Desc: rstrLibrusecFB2; INPX: 'librusec.inpx'),
    (Group: 0; Title: 'Lib.rus.ec [USR]';        Desc: rstrLibrusecUSR; INPX: 'librusec_usr.inpx'),
    (Group: 0; Title: 'Lib.rus.ec [ALLBOOKS]';   Desc: rstrLibrusecAll;    INPX: 'librusec_allbooks.inpx'),
    (Group: 0; Title: 'Lib.rus.ec Online [FB2]'; Desc: rstrLibrusecOnline; INPX: 'librusec_online.inpx'),
    (Group: 1; Title: 'Flibusta OnLine [FB2]';   Desc: rstrFlibustaOnline; INPX: 'flibusta_online.inpx'),
    (Group: 2; Title: 'Traum 2.11 [FB2]';        Desc: rstrTraum_2_11_FB2; INPX: 'Traum_2-11.inpx'),
    (Group: 2; Title: 'Traum 2.12 [FB2]';        Desc: rstrTraum_2_12_FB2; INPX: 'Traum_2-12.inpx'),
    (Group: 2; Title: 'Traum 2.13 [FB2]';        Desc: rstrTraum_2_13_FB2; INPX: 'Traum_2-13_fb2.inpx'),
    (Group: 2; Title: 'Traum 2.13 [ALLBOOKS]';   Desc: rstrTraum_2_13_All; INPX: 'Traum_2-13_full.inpx')
  );
*)

procedure TframeNCWInpxSource.LoadDescriptions;
var
  I: integer;
  sl: TStringList;
  slHelper: TStringList;
  INIFile: TMemIniFile;
begin
  INIFile := TMemIniFile.Create(Settings.SystemFileName[sfCollectionsStore]);
  try
    INIFile.Encoding := TEncoding.UTF8;

    sl := TStringList.Create;
    try
      INIFile.ReadSection(INPX_GROUP_SECTION, sl);
      // обрабатываем файл
      if sl.Count > 0 then
      begin
        SetLength(FGroups, sl.Count);
        for I := 0 to sl.Count - 1 do
          if Pos(INPX_GROUP_KEY_PREFIX, sl[I]) = 1 then
            FGroups[I] := INIFile.ReadString(INPX_GROUP_SECTION, sl[I], '');
      end // if
      else
      begin
        // Добавим группы по умолчанию
      end;

      INIFile.ReadSection(INPX_SECTION, sl);
      // обрабатываем файл
      if sl.Count > 0 then
      begin
        SetLength(FCollections, sl.Count);
        slHelper := TIniStringList.Create;
        try
          for I := 0 to sl.Count - 1 do
          begin
            if Pos(INPX_KEY_PREFIX, sl[I]) = 1 then
            begin
              slHelper.DelimitedText := INIFile.ReadString(INPX_SECTION, sl[I], '');
              if slHelper.Count > 4 then
              begin
                FCollections[I].Group := StrToInt(slHelper[0]);
                FCollections[I].Title := slHelper[1];
                FCollections[I].Desc := slHelper[2];
                FCollections[I].INPX := slHelper[3];
              end;
            end;
          end;
        finally
          slHelper.Free;
        end;
      end // if
      else
      begin
        // Добавим inpx по умолчанию
        // SetLength(FCollections, 9);
        // FCollections := DefaultCollections;
      end;
    finally
      sl.Free;
    end;
  finally
    INIFile.Free;
  end;
end;

procedure TframeNCWInpxSource.FillList;
var
  I: integer;
  G: TListGroup;
  Item: TListItem;
begin
  LoadDescriptions;

  lvCollections.Items.BeginUpdate;
  try
    lvCollections.Groups.Clear;
    lvCollections.Items.Clear;

    for I := 0 to High(FGroups) do
    begin
      G := lvCollections.Groups.Add;
      G.Header := FGroups[I];
    end;

    for I := 0 to High(FCollections) do
    begin
      Item := lvCollections.Items.Add;
      Item.Caption := FCollections[I].Title;
      Item.GroupID := FCollections[I].Group;
    end;

    if lvCollections.Items.Count > 0 then
    begin
      lvCollections.Selected := lvCollections.Items[0];
      lvCollections.ItemFocused := lvCollections.Selected;
      FCollection := FCollections[0];
    end;
  finally
    lvCollections.Items.EndUpdate;
  end;
end;

function TframeNCWInpxSource.Activate(LoadData: Boolean): Boolean;
begin
  Assert(FPParams^.Operation in [otInpx, otInpxDownload]);
  if LoadData then
  begin
    FillList;
    rbLocal.Checked := True;
    rbDownload.Enabled := (lvCollections.Items.Count > 0);

    OnSetINPXSource(rbLocal);
  end;
  Result := True;
end;

function TframeNCWInpxSource.Deactivate(CheckData: Boolean): Boolean;
begin
  Assert(Assigned(lvCollections.Selected));

  if rbLocal.Checked then
  begin
    FPParams^.INPXFile := edINPXPath.Text;
  end
  else
  begin
    FPParams^.Operation := otInpxDownload;
    FPParams^.INPXFile := TPath.Combine(Settings.WorkPath, FCollection.INPX);
    //
    // TODO: необходимо хранить URL для получения INPX. Иначе все INPX должны лежать на одном сервере.
    //
    FPParams^.INPXUrl := Settings.InpxURL + FCollection.INPX;
  end;

  Result := True;
end;

procedure TframeNCWInpxSource.edINPXPathButtonClick(Sender: TObject);
var
  AFileName: string;
begin
  if GetFileName(fnOpenINPX, AFileName) then
  begin
    edINPXPath.Text := AFileName;
  end;
end;

procedure TframeNCWInpxSource.lvCollectionsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  if (Change = ctState) and Assigned(lvCollections.Selected) then
  begin
    FCollection := FCollections[lvCollections.ItemIndex];
    pageHint.Caption := FCollection.Desc;
  end;
end;

procedure TframeNCWInpxSource.OnSetINPXSource(Sender: TObject);
begin
  if Sender = rbLocal then
    pageHint.Caption := rstrLocal
  else
  begin
    Assert(lvCollections.Items.Count > 0);

    if not Assigned(lvCollections.Selected) then
      lvCollections.Selected := lvCollections.ItemFocused;
    if not Assigned(lvCollections.Selected) then
      lvCollections.Selected := lvCollections.Items[0];

    Assert(Assigned(lvCollections.Selected));
    lvCollectionsChange(Self, lvCollections.Selected, ctState);
  end;

  edINPXPath.Enabled := rbLocal.Checked;
  btnSelectINPX.Enabled := rbLocal.Checked;
  lvCollections.Enabled := rbDownload.Checked;
end;

end.
