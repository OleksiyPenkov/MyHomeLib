(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  *         Matvienko Sergei matv84@mail.ru
  * Created                  20.08.2008
  * Description              
  *
  * $Id: frm_settings.pas 1166 2014-05-22 03:09:17Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_settings;

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
  StdCtrls,
  Mask,
  ExtCtrls,
  ComCtrls,
  ImgList,
  unit_AutoCompleteEdit;

type
  TfrmSettings = class(TForm)
    pcSetPages: TPageControl;
    tsDevices: TTabSheet;
    tsReaders: TTabSheet;
    tsInterface: TTabSheet;
    dlgColors: TColorDialog;
    tsInternet: TTabSheet;
    lvReaders: TListView;
    btnDeleteExt: TButton;
    btnChangeExt: TButton;
    btnAddExt: TButton;
    pnCT: TPanel;
    pnBS: TPanel;
    pnCS: TPanel;
    pnCA: TPanel;
    edShortFontSize: TEdit;
    Label9: TLabel;
    Label7: TLabel;
    edFontSize: TEdit;
    Button1: TButton;
    cbCheckColUpdate: TCheckBox;
    cbUpdates: TCheckBox;
    tvSections: TTreeView;
    tsScripts: TTabSheet;
    lvScripts: TListView;
    cbDefaultAction: TComboBox;
    tsBehavour: TTabSheet;
    cbShowSubGenreBooks: TCheckBox;
    cbMinimizeToTray: TCheckBox;
    cbAutoStartDwnld: TCheckBox;
    cbAllowMixedCollections: TCheckBox;
    pnDownloadedFontColor: TPanel;
    pnDeletedFontColor: TPanel;
    edTimeOut: TEdit;
    RzLabel7: TLabel;
    edReadTimeOut: TEdit;
    RzLabel8: TLabel;
    edDwnldInterval: TEdit;
    RzLabel9: TLabel;
    cbAutoRunUpdate: TCheckBox;
    cbDeleteDeleted: TCheckBox;
    cbAutoLoadReview: TCheckBox;
    tsFileSort: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    edFBDFolderTemplate: TEdit;
    edFBDFileTemplate: TEdit;
    Label4: TLabel;
    Label8: TLabel;
    edFB2FolderTemplate: TEdit;
    edFB2FileTemplate: TEdit;
    cbEnableFileSort: TCheckBox;
    edImportFolder: TMHLAutoCompleteEdit;
    cbDeleteFiles: TCheckBox;
    Label10: TLabel;
    cbOverwriteFB2Info: TCheckBox;
    edTitleTemplate: TEdit;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Panel1: TPanel;
    Label11: TLabel;
    Panel2: TPanel;
    btnAddScript: TButton;
    btnEditScript: TButton;
    btnDeleteScript: TButton;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    pnDeviceOptions: TPanel;
    edDeviceDir: TMHLAutoCompleteEdit;
    btnDeviceDir: TButton;
    pnReadDir: TPanel;
    Label15: TLabel;
    edReadDir: TMHLAutoCompleteEdit;
    btnSelectReadDir: TButton;
    cbPromptPath: TCheckBox;
    Label16: TLabel;
    pnDeviceDir: TPanel;
    pnFileFormat: TPanel;
    Label17: TLabel;
    rgDeviceFormat: TComboBox;
    pnNameFormat: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    btnFolderTemplate: TButton;
    btnFileNameTemplate: TButton;
    edFolderTemplate: TEdit;
    edFileNameTemplate: TEdit;
    pnOtherOpt: TPanel;
    Label5: TLabel;
    cbSquareFilter: TCheckBox;
    cbTXTEncoding: TComboBox;
    Label1: TLabel;
    Panel3: TPanel;
    Label6: TLabel;
    btnTitleTemplate: TButton;
    Panel4: TPanel;
    Label21: TLabel;
    btnImportFolder: TButton;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    btnFB2FolderTemplate: TButton;
    btnFB2FileTemplate: TButton;
    btnFBDFileTemplate: TButton;
    btnFBDFolderTemplate: TButton;
    Panel7: TPanel;
    Label27: TLabel;
    Label26: TLabel;
    edUpdateDir: TMHLAutoCompleteEdit;
    btnUpdateDir: TButton;
    Label28: TLabel;
    edINPXUrl: TMHLAutoCompleteEdit;
    Label29: TLabel;
    edUpdates: TMHLAutoCompleteEdit;
    Panel6: TPanel;
    Label30: TLabel;
    udTimeOut: TUpDown;
    udReadTimeOut: TUpDown;
    udDwnldInterval: TUpDown;
    Panel8: TPanel;
    Label31: TLabel;
    udFontSize: TUpDown;
    udShortFontSize: TUpDown;
    pnDefaultFontColor: TPanel;
    btnDownloadedFontColor: TButton;
    btnDeletedFontColor: TButton;
    Panel10: TPanel;
    Label32: TLabel;
    btnCA: TButton;
    btnCS: TButton;
    btnCT: TButton;
    btnBS: TButton;
    pnASG: TPanel;
    btnASG: TButton;
    cbSelectedIsChecked: TCheckBox;
    Panel9: TPanel;
    tsProxy: TTabSheet;
    cbUseIESettings: TCheckBox;
    lblProxyServer: TLabel;
    edProxyServer: TEdit;
    lblProxyPort: TLabel;
    edProxyPort: TEdit;
    edProxyPassword: TEdit;
    lblProxyPassword: TLabel;
    edProxyUsername: TEdit;
    lblProxyUser: TLabel;
    Label33: TLabel;
    rbDNotUseProxyForUpdate: TRadioButton;
    rbUseProxyForUpdate: TRadioButton;
    lblProxyServerUpdate: TLabel;
    edProxyServerUpdate: TEdit;
    lblProxyPortUpdate: TLabel;
    edProxyPortUpdate: TEdit;
    edProxyPasswordUpdate: TEdit;
    lblProxyPasswordUpdate: TLabel;
    edProxyUsernameUpdate: TEdit;
    lblProxyUserUpdate: TLabel;
    lbProxyType: TLabel;
    cbProxyType: TComboBox;
    cbIgnoreArchives: TCheckBox;
    Label25: TLabel;

    procedure SaveSettingsClick(Sender: TObject);
    procedure ShowHelpClick(Sender: TObject);

    procedure tvSectionsChange(Sender: TObject; Node: TTreeNode);

    procedure SetBackgroundColor(Sender: TObject);
    procedure SetDefaultFontColor(Sender: TObject);
    procedure SetCustomFontColor(Sender: TObject);

    procedure btnAddExtClick(Sender: TObject);
    procedure btnChangeExtClick(Sender: TObject);
    procedure btnDeleteExtClick(Sender: TObject);

    procedure btnAddScriptClick(Sender: TObject);
    procedure btnEditScriptClick(Sender: TObject);
    procedure btnDeleteScriptClick(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure cbUseIESettingsClick(Sender: TObject);
    procedure cbOverwriteFB2InfoClick(Sender: TObject);
    procedure EditFolderTemplate(Sender: TObject);
    procedure EditFileNameTemplate(Sender: TObject);
    procedure SelectFolder(Sender: TObject);
    procedure EditTextTemplate(Sender: TObject);
    procedure cbEnableFileSortClick(Sender: TObject);
    procedure cbPromptPathClick(Sender: TObject);
    procedure edTimeOutChange(Sender: TObject);
    procedure CheckNumValue(Sender: TObject);
    procedure rbUseProxyForUpdateClick(Sender: TObject);
    procedure cbIgnoreArchivesClick(Sender: TObject);

  private
    procedure SetPanelFontColor(Value: Graphics.TColor);

    procedure EditReader(AItem: TListItem);
    procedure EditScript(AItem: TListItem);

    procedure SaveReaders;
    procedure SaveScripts;

  public
    procedure LoadSetting;
    procedure SaveSettings;
  end;

var
  frmSettings: TfrmSettings;

implementation

uses
  StrUtils,
  Character,
  unit_Globals,
  unit_Readers,
  unit_Scripts,
  frm_edit_reader,
  frm_edit_script,
  unit_Settings,
  dm_user,
  unit_Helpers,
  frm_create_mask,
  unit_Templater;

resourcestring
  rstrStandart = 'Стандартное';
  rstrNeedTemplate = 'Необходимо задать шаблон для заголовка книги в разделе "Разное"';
  rstrChangeFileType = 'Изменение типа файлов';
  rstrAddFileType = 'Добавление типа файлов';
  rstrTypeAlreadyInTheList = 'Тип "%s" уже есть в списке!';
  rstrChangeScriptParams = 'Изменение параметров скрипта';
  rstrAddScript = 'Добавление скрипта';
  rstrProvideFolder = 'Укажите папку';

{$R *.dfm}

procedure TfrmSettings.LoadSetting;
var
  i: integer;
begin
  //
  // Page 1 - Device settings
  //
  cbPromptPath.Checked := Settings.PromptDevicePath;
  edDeviceDir.Text := Settings.DeviceDir;

  edReadDir.Text := Settings.ReadDir;

  rgDeviceFormat.ItemIndex := Ord(Settings.ExportMode);
  edFolderTemplate.Text := Settings.FolderTemplate;
  edFileNameTemplate.Text := Settings.FileNameTemplate;
  // TODO : REMOVE cbTranslit.Checked := Settings.TransliterateFileName;
  cbSquareFilter.Checked := Settings.RemoveSquarebrackets;
  cbTXTEncoding.ItemIndex := Ord(Settings.TXTEncoding);

  // Page 2 - Readers
  lvReaders.Items.Clear;
  for i := 0 to Settings.Readers.Count - 1 do
  begin
    with lvReaders.Items.Add do
    begin
      Caption := Settings.Readers[i].Extension;
      SubItems.Add(Settings.Readers[i].Path);
    end;
  end;

  //
  // Интерфейс
  //
  udFontSize.Position := Settings.TreeFontSize;
  udShortFontSize.Position := Settings.ShortFontSize;
  SetPanelFontColor(Settings.FontColor);
  pnDownloadedFontColor.Font.Color := Settings.LocalColor;
  pnDeletedFontColor.Font.Color := Settings.DeletedColor;

  pnCA.Color := Settings.AuthorColor;
  pnCS.Color := Settings.SeriesColor;
  pnASG.Color := Settings.BGColor;
  pnCT.Color := Settings.BookColor;
  pnBS.Color := Settings.SeriesBookColor;

  //
  // Page 4 - Internet
  //
  cbUseIESettings.Checked := Settings.UseIESettings;
  edProxyServer.Text := Settings.ProxyServer;
  edProxyPort.Text := IntToStr(Settings.ProxyPort);
  edProxyUsername.Text := Settings.ProxyUsername;
  edProxyPassword.Text := Settings.ProxyPassword;

  rbUseProxyForUpdate.Checked := Settings.UseProxyForUpdate;
  edProxyServerUpdate.Text := Settings.ProxyServerUpdate;
  edProxyPortUpdate.Text := IntToStr(Settings.ProxyPortUpdate);
  edProxyUsernameUpdate.Text := Settings.ProxyUsernameUpdate;
  edProxyPasswordUpdate.Text := Settings.ProxyPasswordUpdate;
  cbProxyType.ItemIndex := Settings.ProxyType;

  edUpdateDir.Text := Settings.UpdateDir;
  edINPXUrl.Text := Settings.InpxURL;
  edUpdates.Text := Settings.UpdateURL;

  cbCheckColUpdate.Checked := Settings.CheckExternalLibUpdate;
  cbUpdates.Checked := Settings.CheckUpdate;
  cbAutoRunUpdate.Checked := Settings.AutoRunUpdate;

  udTimeOut.Position := Settings.TimeOut;
  udReadTimeOut.Position := Settings.ReadTimeOut;
  udDwnldInterval.Position := Settings.DwnldInterval;

  //
  // Page 5 - Scripts
  //
  lvScripts.Items.Clear;
  cbDefaultAction.Items.Clear;
  cbDefaultAction.Items.Add(rstrStandart);

  for i := 0 to Settings.Scripts.Count - 1 do
  begin
    with lvScripts.Items.Add do
    begin
      Caption := Settings.Scripts[i].Title;
      SubItems.Add(Settings.Scripts[i].Path);
      SubItems.Add(Settings.Scripts[i].Params);
    end;

    cbDefaultAction.Items.Add(Settings.Scripts[i].Title);
  end;
  cbDefaultAction.ItemIndex := Settings.DefaultScript;

  //
  // Page 6 - Behavior
  //
  cbShowSubGenreBooks.Checked := Settings.ShowSubGenreBooks;
  cbMinimizeToTray.Checked := Settings.MinimizeToTray;
  cbAutoStartDwnld.Checked := Settings.AutoStartDwnld;
  cbAllowMixedCollections.Checked := Settings.AllowMixed;
  cbDeleteDeleted.Checked := Settings.DeleteDeleted;
  cbAutoLoadReview.Checked := Settings.AutoLoadReview;
  cbDeleteFiles.Checked := Settings.DeleteFiles;

  cbOverwriteFB2Info.Checked := Settings.OverwriteFB2Info;
  edTitleTemplate.Text := Settings.BookHeaderTemplate;
  cbSelectedIsChecked.Checked := Settings.SelectedIsChecked;
  cbIgnoreArchives.Checked := Settings.IgnoreAbsentArchives;

  //
  // Page 6 -  FileSort
  //
  cbEnableFileSort.Checked := Settings.EnableSort;
  edImportFolder.Text := Settings.ImportDir;
  edFB2FolderTemplate.Text := Settings.FB2FolderTemplate;
  edFB2FileTemplate.Text := Settings.FB2FileTemplate;
  edFBDFolderTemplate.Text := Settings.FBDFolderTemplate;
  edFBDFileTemplate.Text := Settings.FBDFileTemplate;

  //
  // настроим GUI - запретим или разрешим контролы
  //
  cbPromptPathClick(nil);
  cbUseIESettingsClick(nil);
  cbOverwriteFB2InfoClick(nil);
  cbEnableFileSortClick(nil);
  rbUseProxyForUpdateClick(nil);

  tvSections.Select(tvSections.Items[0]);
end;

procedure TfrmSettings.rbUseProxyForUpdateClick(Sender: TObject);
begin
  edProxyServerUpdate.Enabled := rbUseProxyForUpdate.Checked;
  edProxyPortUpdate.Enabled := rbUseProxyForUpdate.Checked;
  edProxyUsernameUpdate.Enabled := rbUseProxyForUpdate.Checked;
  edProxyPasswordUpdate.Enabled := rbUseProxyForUpdate.Checked;
end;

procedure TfrmSettings.SaveSettings;
begin
  // Page 1 - Device settings
  Settings.PromptDevicePath := cbPromptPath.Checked;
  Settings.DeviceDir := edDeviceDir.Text;

  Settings.ReadDir := edReadDir.Text;

  case rgDeviceFormat.ItemIndex of
    0: Settings.ExportMode := emFB2;
    1: Settings.ExportMode := emFB2Zip;
    2: Settings.ExportMode := emLrf;
    3: Settings.ExportMode := emTxt;
    4: Settings.ExportMode := emEpub;
    5: Settings.ExportMode := emPDF;
    6: Settings.ExportMode := emMobi;
  end;

  Settings.FolderTemplate := edFolderTemplate.Text;
  Settings.FileNameTemplate := edFileNameTemplate.Text;
  // TODO : REMOVE Settings.TransliterateFileName := cbTranslit.Checked;

  case cbTXTEncoding.ItemIndex of
    0: Settings.TXTEncoding := enUTF8;
    1: Settings.TXTEncoding := en1251;
    2: Settings.TXTEncoding := enUnicode;
  end;

  Settings.RemoveSquarebrackets := cbSquareFilter.Checked;

  // Page 2 - Readers
  SaveReaders;

  // Page 3 - Interface

  Settings.TreeFontSize := udFontSize.Position;
  Settings.ShortFontSize := udShortFontSize.Position;
  Settings.FontColor := pnDefaultFontColor.Font.Color;
  Settings.LocalColor := pnDownloadedFontColor.Font.Color;
  Settings.DeletedColor := pnDeletedFontColor.Font.Color;

  Settings.AuthorColor := pnCA.Color;
  Settings.SeriesColor := pnCS.Color;
  Settings.BGColor := pnASG.Color;
  Settings.BookColor := pnCT.Color;
  Settings.SeriesBookColor := pnBS.Color;

  // Page 4 - Internet
  Settings.UseIESettings := cbUseIESettings.Checked;
  Settings.ProxyServer := edProxyServer.Text;
  Settings.ProxyPort := StrToIntDef(edProxyPort.Text, 0);
  Settings.ProxyUsername := edProxyUsername.Text;
  Settings.ProxyPassword := edProxyPassword.Text;
  Settings.UpdateURL := edUpdates.Text;
  Settings.CheckExternalLibUpdate := cbCheckColUpdate.Checked;
  Settings.CheckUpdate := cbUpdates.Checked;
  Settings.TimeOut := udTimeOut.Position;
  Settings.ReadTimeOut := udReadTimeOut.Position;
  Settings.DwnldInterval := udDwnldInterval.Position;
  Settings.AutoRunUpdate := cbAutoRunUpdate.Checked;
  Settings.InpxURL := IncludeUrlSlash(edINPXUrl.Text);
  // Дополнительный прокси
  Settings.UseProxyForUpdate := rbUseProxyForUpdate.Checked;
  Settings.ProxyServerUpdate := edProxyServerUpdate.Text;
  Settings.ProxyPortUpdate := StrToIntDef(edProxyPortUpdate.Text, 0);
  Settings.ProxyUsernameUpdate := edProxyUsernameUpdate.Text;
  Settings.ProxyPasswordUpdate := edProxyPasswordUpdate.Text;

  Settings.ProxyType := cbProxyType.ItemIndex;

  Settings.UpdateDir := edUpdateDir.Text;

  // Page 5 - Scripts
  SaveScripts;
  Settings.DefaultScript := cbDefaultAction.ItemIndex;

  // Page 6 - Behavior

  Settings.ShowSubGenreBooks := cbShowSubGenreBooks.Checked;
  Settings.MinimizeToTray := cbMinimizeToTray.Checked;
  Settings.AutoStartDwnld := cbAutoStartDwnld.Checked;
  Settings.AllowMixed := cbAllowMixedCollections.Checked;
  Settings.DeleteDeleted := cbDeleteDeleted.Checked;
  Settings.AutoLoadReview := cbAutoLoadReview.Checked;
  Settings.DeleteFiles := cbDeleteFiles.Checked;
  Settings.OverwriteFB2Info := cbOverwriteFB2Info.Checked;
  Settings.BookHeaderTemplate := edTitleTemplate.Text;
  Settings.AutoStartDwnld := cbAutoStartDwnld.Checked;
  Settings.SelectedIsChecked := cbSelectedIsChecked.Checked;
  Settings.IgnoreAbsentArchives := cbIgnoreArchives.Checked;

  // Page 6 -  FileSort

  Settings.EnableSort := cbEnableFileSort.Checked;
  Settings.ImportDir := edImportFolder.Text;
  Settings.FB2FolderTemplate := edFB2FolderTemplate.Text;
  Settings.FB2FileTemplate := edFB2FileTemplate.Text;
  Settings.FBDFolderTemplate := edFBDFolderTemplate.Text;
  Settings.FBDFileTemplate := edFBDFileTemplate.Text;
end;

procedure TfrmSettings.SaveReaders;
var
  i: integer;
  Readers: TReaders;
begin
  Readers := Settings.Readers;
  Readers.Clear;
  for i := 0 to lvReaders.Items.Count - 1 do
  begin
    Readers.Add(lvReaders.Items[i].Caption, lvReaders.Items[i].SubItems[0]);
  end;
end;

procedure TfrmSettings.SaveScripts;
var
  i: integer;
  Scripts: TScripts;
begin
  Scripts := Settings.Scripts;
  Scripts.Clear;
  for i := 0 to lvScripts.Items.Count - 1 do
  begin
    Scripts.Add(lvScripts.Items[i].Caption, lvScripts.Items[i].SubItems[0], lvScripts.Items[i].SubItems[1]);
  end;
end;

procedure TfrmSettings.ShowHelpClick(Sender: TObject);
begin
  HtmlHelp(Application.Handle, PChar(Settings.SystemFileName[sfAppHelp]), HH_HELP_CONTEXT, pcSetPages.ActivePage.HelpContext);
  frmSettings.FocusControl(btnOk);
end;

procedure TfrmSettings.SaveSettingsClick(Sender: TObject);
begin
  if cbOverwriteFB2Info.Checked and (edTitleTemplate.Text = '') then
  begin
    ShowMessage(rstrNeedTemplate);
    tvSections.Select(tvSections.Items[5]);
    Exit;
  end;

  SaveSettings;

  Close;
end;

// ============================================================================
//
// Настройка читалок
//

procedure TfrmSettings.EditReader(AItem: TListItem);
var
  frmEditReader: TfrmEditReader;
begin
  frmEditReader := TfrmEditReader.Create(Self);
  try
    frmEditReader.Caption := IfThen(Assigned(AItem), rstrChangeFileType, rstrAddFileType);
    if Assigned(AItem) then
    begin
      frmEditReader.Extension := AItem.Caption;
      frmEditReader.Path := AItem.SubItems[0];
    end;

    if frmEditReader.ShowModal = mrOk then
    begin
      if Assigned(AItem) and (AnsiCompareText(AItem.Caption,
          frmEditReader.Extension) = 0) then
      begin
        // Расширение не поменялось -> обновим путь
        AItem.SubItems[0] := frmEditReader.Path;
        Exit;
      end;

      if lvReaders.FindCaption(0, frmEditReader.Extension, False, True, False) <> nil then
      begin
        // Это расширение уже зарегистрировано
        MessageDlg(Format(rstrTypeAlreadyInTheList, [frmEditReader.Extension]), mtError, [mbOk], 0);
        Exit;
      end;

      if Assigned(AItem) then
        AItem.SubItems[0] := frmEditReader.Path
      else
      begin
        AItem := lvReaders.Items.Add;
        AItem.SubItems.Add(frmEditReader.Path);
      end;

      AItem.Caption := frmEditReader.Extension;
    end;
  finally
    frmEditReader.Free;
  end;
end;

procedure TfrmSettings.btnAddExtClick(Sender: TObject);
begin
  EditReader(nil);
end;

procedure TfrmSettings.btnChangeExtClick(Sender: TObject);
var
  AItem: TListItem;
begin
  AItem := lvReaders.Selected;
  if not Assigned(AItem) then
    Exit;
  EditReader(AItem);
end;

procedure TfrmSettings.btnDeleteExtClick(Sender: TObject);
begin
  lvReaders.DeleteSelected;
end;

// ============================================================================
//
// Настройка скриптов
//

procedure TfrmSettings.EditScript(AItem: TListItem);
var
  frmEditScript: TfrmEditScript;
  nIndex: Integer;
begin
  frmEditScript := TfrmEditScript.Create(Self);
  try
    frmEditReader.Caption := IfThen(Assigned(AItem), rstrChangeScriptParams, rstrAddScript);
    if Assigned(AItem) then
    begin
      frmEditScript.Title := AItem.Caption;
      frmEditScript.Path := AItem.SubItems[0];
      frmEditScript.Params := AItem.SubItems[1];
    end;

    if frmEditScript.ShowModal = mrOk then
    begin
      if Assigned(AItem) then
      begin
        nIndex := cbDefaultAction.ItemIndex;
        cbDefaultAction.Items[AItem.Index + 1] := frmEditScript.Title;
        cbDefaultAction.ItemIndex := nIndex;
      end
      else
        cbDefaultAction.Items.Add(frmEditScript.Title);

      if Assigned(AItem) then
      begin
        AItem.SubItems[0] := frmEditScript.Path;
        AItem.SubItems[1] := frmEditScript.Params;
      end
      else
      begin
        AItem := lvScripts.Items.Add;
        AItem.SubItems.Add(frmEditScript.Path);
        AItem.SubItems.Add(frmEditScript.Params);
      end;

      AItem.Caption := frmEditScript.Title;
    end;

  finally
    frmEditScript.Free;
  end;
end;

procedure TfrmSettings.FormShow(Sender: TObject);
begin
  tvSections.Select(tvSections.Items[0], [ssLeft]);
end;

procedure TfrmSettings.btnAddScriptClick(Sender: TObject);
begin
  EditScript(nil);
end;

procedure TfrmSettings.btnEditScriptClick(Sender: TObject);
var
  Script: TListItem;
begin
  Script := lvScripts.Selected;
  if not Assigned(Script) then
    Exit;
  EditScript(Script);
end;

procedure TfrmSettings.btnDeleteScriptClick(Sender: TObject);
begin
  if lvScripts.Selected = nil then
    Exit;

  if cbDefaultAction.Items.Count > 1 then
  begin
    cbDefaultAction.Items.Delete(lvScripts.Selected.Index + 1);
    cbDefaultAction.ItemIndex := 0;
  end;
  lvScripts.DeleteSelected;
end;

//
// Настройки интерфейса
//
procedure TfrmSettings.SetBackgroundColor(Sender: TObject);
var
  PanelControl: TPanel;
begin
  if Sender = btnCA then
    PanelControl := pnCA
  else if Sender = btnCS then
    PanelControl := pnCS
  else if Sender = btnASG then
    PanelControl := pnASG
  else if Sender = btnCT then
    PanelControl := pnCT
  else if Sender = btnBS then
    PanelControl := pnBS
  else
  begin
    Assert(False);
    Exit;
  end;

  dlgColors.Color := PanelControl.Color;
  if dlgColors.Execute then
    PanelControl.Color := dlgColors.Color;
end;

procedure TfrmSettings.SetPanelFontColor(Value: Graphics.TColor);
begin
  pnDefaultFontColor.Font.Color := Value;
  pnCA.Font.Color := Value;
  pnCS.Font.Color := Value;
  pnASG.Font.Color := Value;
  pnCT.Font.Color := Value;
  pnBS.Font.Color := Value;
end;

procedure TfrmSettings.SetDefaultFontColor(Sender: TObject);
begin
  dlgColors.Color := pnDefaultFontColor.Font.Color;
  if dlgColors.Execute then
    SetPanelFontColor(dlgColors.Color);
end;

procedure TfrmSettings.SetCustomFontColor(Sender: TObject);
var
  PanelControl: TPanel;
begin
  if Sender = btnDownloadedFontColor then
    PanelControl := pnDownloadedFontColor
  else if Sender = btnDeletedFontColor then
    PanelControl := pnDeletedFontColor
  else
  begin
    Assert(False);
    Exit;
  end;

  dlgColors.Color := PanelControl.Font.Color;
  if dlgColors.Execute then
    PanelControl.Font.Color := dlgColors.Color;
end;

//
//
//
procedure TfrmSettings.tvSectionsChange(Sender: TObject; Node: TTreeNode);
begin
  pcSetPages.ActivePageIndex := tvSections.Selected.Index;
end;

procedure TfrmSettings.cbEnableFileSortClick(Sender: TObject);
begin
  edImportFolder.Enabled := cbEnableFileSort.Checked;
  edFB2FolderTemplate.Enabled := cbEnableFileSort.Checked;
  edFB2FileTemplate.Enabled := cbEnableFileSort.Checked;
  edFBDFolderTemplate.Enabled := cbEnableFileSort.Checked;
  edFBDFileTemplate.Enabled := cbEnableFileSort.Checked;
  btnImportFolder.Enabled := cbEnableFileSort.Checked;
  btnFB2FolderTemplate.Enabled := cbEnableFileSort.Checked;
  btnFB2FileTemplate.Enabled := cbEnableFileSort.Checked;
  btnFBDFolderTemplate.Enabled := cbEnableFileSort.Checked;
  btnFBDFileTemplate.Enabled := cbEnableFileSort.Checked;
end;

procedure TfrmSettings.cbOverwriteFB2InfoClick(Sender: TObject);
begin
  edTitleTemplate.Enabled := cbOverwriteFB2Info.Checked;
  btnTitleTemplate.Enabled := cbOverwriteFB2Info.Checked;
end;

procedure TfrmSettings.cbPromptPathClick(Sender: TObject);
begin
  edDeviceDir.Enabled := not cbPromptPath.Checked;
  btnDeviceDir.Enabled := not cbPromptPath.Checked;
end;

procedure TfrmSettings.cbUseIESettingsClick(Sender: TObject);
begin
  edProxyServer.Enabled := not cbUseIESettings.Checked;
  edProxyPort.Enabled := not cbUseIESettings.Checked;
  edProxyUsername.Enabled := not cbUseIESettings.Checked;
  edProxyPassword.Enabled := not cbUseIESettings.Checked;
end;

procedure TfrmSettings.CheckNumValue(Sender: TObject);
var
  EditControl: TEdit;
  UpDownControl: TUpDown;
  strValue: string;
  ch: Char;
  nValue: Integer;
  nMinValue: Integer;
  nMaxValue: Integer;
begin
  EditControl := Sender as TEdit;
  if (EditControl = edProxyPort) or (EditControl = edProxyPortUpdate) then
    UpDownControl := nil
  else if EditControl = edTimeOut then
    UpDownControl := udTimeOut
  else if EditControl = edDwnldInterval then
    UpDownControl := udDwnldInterval
  else if EditControl = edReadTimeOut then
    UpDownControl := udReadTimeOut
  else if EditControl = edFontSize then
    UpDownControl := udFontSize
  else if EditControl = edShortFontSize then
    UpDownControl := udShortFontSize
  else
  begin
    Assert(False);
    Exit;
  end;

  if (EditControl = edProxyPort) or (EditControl = edProxyPortUpdate) then
  begin
    nMinValue := 0;
    nMaxValue := 65535;
  end
  else
  begin
    Assert(Assigned(UpDownControl));
    nMinValue := UpDownControl.Min;
    nMaxValue := UpDownControl.Max;
  end;

  for ch in EditControl.Text do
  begin
    if IsNumber(ch) then
      strValue := strValue + ch;
  end;
  nValue := StrToIntDef(strValue, 0);

  if (nMinValue <= nValue) and (nValue <= nMaxValue) then
    Exit;

  if nValue < nMinValue then
    nValue := nMinValue
  else if nValue > nMaxValue then
    nValue := nMaxValue;

  EditControl.Text := IntToStr(nValue);
end;

procedure TfrmSettings.cbIgnoreArchivesClick(Sender: TObject);
begin

end;

// ============================================================================

procedure TfrmSettings.SelectFolder(Sender: TObject);
var
  EditControl: TEdit;
  AFolder: string;
begin
  if Sender = btnImportFolder then
    EditControl := edImportFolder
  else if Sender = btnSelectReadDir then
    EditControl := edReadDir
  else if Sender = btnDeviceDir then
    EditControl := edDeviceDir
  else if Sender = btnUpdateDir then
    EditControl := edUpdateDir
  else
  begin
    Assert(False);
    Exit;
  end;

  AFolder := EditControl.Text;
  if GetFolderName(Handle, rstrProvideFolder, AFolder) then
    EditControl.Text := AFolder;
end;

procedure TfrmSettings.EditFolderTemplate(Sender: TObject);
var
  EditControl: TEdit;
  s: string;
begin
  if Sender = btnFolderTemplate then
    EditControl := edFolderTemplate
  else if Sender = btnFB2FolderTemplate then
    EditControl := edFB2FolderTemplate
  else if Sender = btnFBDFolderTemplate then
    EditControl := edFBDFolderTemplate
  //else if Sender =  then
  else
  begin
    Assert(False);
    Exit;
  end;

  s := EditControl.Text;
  if EditTemplate(TpPath, s) then
    EditControl.Text := s;
end;

procedure TfrmSettings.EditFileNameTemplate(Sender: TObject);
var
  EditControl: TEdit;
  s: string;
begin
  if Sender = btnFileNameTemplate then
    EditControl := edFileNameTemplate
  else if Sender = btnFB2FileTemplate then
    EditControl := edFB2FileTemplate
  else if Sender = btnFBDFileTemplate then
    EditControl := edFBDFileTemplate
  //else if Sender =  then
  else
  begin
    Assert(False);
    Exit;
  end;

  s := EditControl.Text;
  if EditTemplate(TpFile, s) then
    EditControl.Text := s;
end;

procedure TfrmSettings.EditTextTemplate(Sender: TObject);
var
  s: string;
begin
  s := edTitleTemplate.Text;
  if EditTemplate(TpText, s) then
    edTitleTemplate.Text := s;
end;

procedure TfrmSettings.edTimeOutChange(Sender: TObject);
begin
//
end;

end.
