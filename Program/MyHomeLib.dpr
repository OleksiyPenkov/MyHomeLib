(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2013 Aleksey Penkov (alex.penkov@gmail.com)
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * Author(s)           Aleksey Penkov (alex.penkov@gmail.com)
  *                     Nick Rymanov (nrymanov@gmail.com)
  *                     eg_
  *
  * Home: http://home-lib.net
  *   or: http://www.assembla.com/spaces/myhomelib
  *
  * $Id: MyhomeLib.dpr 1128 2013-06-27 08:07:15Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

program MyHomeLib;

{$R *.dres}

uses
  Forms,
  IMouse,
  frm_main in 'Forms\frm_main.pas' {frmMain},
  dm_user in 'DataModules\dm_user.pas' {DMUser: TDataModule},
  unit_Globals in 'Units\unit_Globals.pas',
  frm_settings in 'Forms\frm_settings.pas' {frmSettings},
  frm_about in 'Forms\frm_about.pas' {frmAbout},
  frm_statistic in 'Forms\frm_statistic.pas' {frmStat},
  unit_PrevInst in 'Units\unit_PrevInst.pas',
  frm_bases in 'Forms\frm_bases.pas' {frmBases},
  frm_book_info in 'Forms\frm_book_info.pas' {frmBookDetails},
  frm_splash in 'Forms\frm_splash.pas' {frmSplash},
  frm_add_nonfb2 in 'Forms\frm_add_nonfb2.pas' {frmAddnonfb2},
  frm_edit_book_info in 'Forms\Editors\frm_edit_book_info.pas' {frmEditBookInfo},
  frm_genre_tree in 'Forms\frm_genre_tree.pas' {frmGenreTree},
  unit_TreeUtils in 'Units\unit_TreeUtils.pas',
  frm_edit_reader in 'Forms\Editors\frm_edit_reader.pas' {frmEditReader},
  unit_MHL_strings in 'Units\unit_MHL_strings.pas',
  frm_edit_script in 'Forms\Editors\frm_edit_script.pas' {frmEditScript},
  unit_Settings in 'Units\unit_Settings.pas',
  unit_Readers in 'Units\unit_Readers.pas',
  unit_Scripts in 'Units\unit_Scripts.pas',
  unit_Errors in 'Units\unit_Errors.pas',
  unit_Consts in 'Units\unit_Consts.pas',
  unit_WorkerThread in 'ImportImpl\unit_WorkerThread.pas',
  unit_Import in 'ImportImpl\unit_Import.pas',
  frm_BaseProgressForm in 'ImportImpl\frm_BaseProgressForm.pas' {ProgressFormBase},
  frm_ImportProgressForm in 'ImportImpl\frm_ImportProgressForm.pas' {ImportProgressForm},
  unit_ImportFBDThread in 'ImportImpl\unit_ImportFBDThread.pas',
  unit_Helpers in 'Units\unit_Helpers.pas',
  frm_ImportProgressFormEx in 'ImportImpl\frm_ImportProgressFormEx.pas' {ImportProgressFormEx},
  unit_ImportFB2ThreadBase in 'ImportImpl\unit_ImportFB2ThreadBase.pas',
  unit_ImportInpxThread in 'ImportImpl\unit_ImportInpxThread.pas',
  unit_Export in 'ImportImpl\unit_Export.pas',
  frm_ExportProgressForm in 'ImportImpl\frm_ExportProgressForm.pas' {ExportProgressForm},
  frm_SyncOnLineProgressForm in 'UtilsImpl\frm_SyncOnLineProgressForm.pas' {SyncOnLineProgressForm},
  unit_SyncOnLineThread in 'UtilsImpl\unit_SyncOnLineThread.pas',
  unit_Utils in 'UtilsImpl\unit_Utils.pas',
  frm_ExportToDeviceProgressForm in 'UtilsImpl\frm_ExportToDeviceProgressForm.pas' {ExportToDeviceProgressForm},
  unit_ExportToDevice in 'UtilsImpl\unit_ExportToDevice.pas',
  unit_ExportToDeviceThread in 'UtilsImpl\unit_ExportToDeviceThread.pas',
  frame_DecorativePageBase in 'Wizards\Base\frame_DecorativePageBase.pas' {DecorativePageBase: TFrame},
  frame_InteriorPageBase in 'Wizards\Base\frame_InteriorPageBase.pas' {InteriorPageBase: TFrame},
  frame_NCWWelcom in 'Wizards\NewCollection\frame_NCWWelcom.pas' {frameNCWWelcom: TFrame},
  frm_MHLWizardBase in 'Wizards\Base\frm_MHLWizardBase.pas' {MHLWizardBase},
  frame_NCWOperation in 'Wizards\NewCollection\frame_NCWOperation.pas' {frameNCWOperation: TFrame},
  frame_NCWFinish in 'Wizards\NewCollection\frame_NCWFinish.pas' {frameNCWFinish: TFrame},
  frame_NCWInpxSource in 'Wizards\NewCollection\frame_NCWInpxSource.pas' {frameNCWInpxSource: TFrame},
  frame_NCWCollectionNameAndLocation in 'Wizards\NewCollection\frame_NCWCollectionNameAndLocation.pas' {frameNCWNameAndLocation: TFrame},
  frame_NCWSelectGenreFile in 'Wizards\NewCollection\frame_NCWSelectGenreFile.pas' {frameNCWSelectGenreFile: TFrame},
  frame_NCWProgress in 'Wizards\NewCollection\frame_NCWProgress.pas' {frameNCWProgress: TFrame},
  frame_WizardPageBase in 'Wizards\Base\frame_WizardPageBase.pas' {WizardPageBase: TFrame},
  unit_NCWParams in 'Wizards\NewCollection\unit_NCWParams.pas',
  frame_NCWCollectionFileTypes in 'Wizards\NewCollection\frame_NCWCollectionFileTypes.pas' {frameNCWCollectionFileTypes: TFrame},
  unit_fb2ToText in 'UtilsImpl\unit_fb2ToText.pas',
  unit_SyncFoldersThread in 'UtilsImpl\unit_SyncFoldersThread.pas',
  unit_libupdateThread in 'UtilsImpl\unit_libupdateThread.pas',
  unit_DownloadBooksThread in 'DwnldImpl\unit_DownloadBooksThread.pas',
  frm_DownloadProgressForm in 'DwnldImpl\frm_DownloadProgressForm.pas' {DownloadProgressForm},
  unit_Columns in 'Units\unit_Columns.pas',
  unit_DownloadManagerThread in 'DwnldImpl\unit_DownloadManagerThread.pas',
  unit_Messages in 'Units\unit_Messages.pas',
  unit_Lib_Updates in 'Units\unit_Lib_Updates.pas',
  frm_editor in 'Forms\Editors\frm_editor.pas' {frmEditor},
  unit_SearchUtils in 'Units\unit_SearchUtils.pas',
  unit_ExportINPXThread in 'ImportImpl\unit_ExportINPXThread.pas',
  frm_info_popup in 'Forms\frm_info_popup.pas' {frmInfoPopup},
  frm_search in 'Forms\frm_search.pas' {frmBookSearch},
  unit_ReviewParser in 'Units\unit_ReviewParser.pas',
  unit_WriteFb2Info in 'Units\unit_WriteFb2Info.pas',
  unit_ImportFB2Thread in 'ImportImpl\unit_ImportFB2Thread.pas',
  frm_ConverToFBD in 'Forms\frm_ConverToFBD.pas' {frmConvertToFBD},
  frm_author_list in 'Forms\frm_author_list.pas' {frmAuthorList},
  frm_edit_author in 'Forms\Editors\frm_edit_author.pas' {frmEditAuthorData},
  frm_create_mask in 'Forms\Editors\frm_create_mask.pas' {frmCreateMask},
  unit_Downloader in 'DwnldImpl\unit_Downloader.pas',
  frame_NCWDownload in 'Wizards\NewCollection\frame_NCWDownload.pas' {frameNCWDownload: TFrame},
  unit_Templater in 'Units\unit_Templater.pas',
  frm_EditAuthorEx in 'Forms\Editors\frm_EditAuthorEx.pas' {frmEditAuthorDataEx},
  unit_TemplaterInternal in 'Units\unit_TemplaterInternal.pas',
  unit_SearchPresets in 'Units\unit_SearchPresets.pas',
  unit_UserData in 'Units\unit_UserData.pas',
  unit_xmlUtils in 'Units\unit_xmlUtils.pas',
  frm_EditGroup in 'Forms\Editors\frm_EditGroup.pas' {frmEditGroup},
  unit_Logger in 'Units\unit_Logger.pas',
  unit_Interfaces in 'Units\unit_Interfaces.pas',
  SQLite3 in 'DAO\SQLite\Lib\SQLite3.pas',
  SQLite3UDF in 'DAO\SQLite\Lib\SQLite3UDF.pas',
  SQLiteWrap in 'DAO\SQLite\Lib\SQLiteWrap.pas',
  unit_Database_SQLite in 'DAO\SQLite\unit_Database_SQLite.pas',
  unit_SQLiteUtils in 'DAO\SQLite\unit_SQLiteUtils.pas',
  unit_ProgressEngine in 'Units\unit_ProgressEngine.pas',
  unit_MHLGenerics in 'Units\unit_MHLGenerics.pas',
  frm_NewCollectionWizard in 'Wizards\NewCollection\frm_NewCollectionWizard.pas' {NewCollectionWizard},
  unit_CollectionWorkerThread in 'ImportImpl\unit_CollectionWorkerThread.pas',
  unit_Events in 'Units\unit_Events.pas',
  frm_DeleteCollection in 'Forms\frm_DeleteCollection.pas' {dlgDeleteCollection},
  unit_ImportOldUserData in 'Units\unit_ImportOldUserData.pas',
  unit_SystemDatabase_SQLite in 'DAO\SQLite\unit_SystemDatabase_SQLite.pas',
  unit_ColorTabs in 'Units\unit_ColorTabs.pas',
  unit_Database_Abstract in 'DAO\unit_Database_Abstract.pas',
  unit_SystemDatabase_Abstract in 'DAO\unit_SystemDatabase_Abstract.pas',
  unit_treeController in 'Units\unit_treeController.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
{$IFOPT D+}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}

  Application.Initialize;

  if FirstHinstanceRunning(1) then
  begin
    Exit;
  end;

  Application.MainFormOnTaskbar := True;
  Application.Title := 'MyHomeLib';
  frmSplash := TfrmSplash.Create(Application);
  try
    frmSplash.Show;
    frmSplash.Update; // Update the splash screen to ensure it gets drawn

    // Важно! сначала создаем датамодули и главную форму, а потом - остальные формы!
    Application.CreateForm(TDMUser, DMUser);
  DMUser.Init;

    Application.CreateForm(TfrmMain, frmMain);
    Application.CreateForm(TfrmGenreTree, frmGenreTree);
    
    frmSplash.Hide;
  finally
    frmSplash.Free;
  end;

  Application.Run;
end.
