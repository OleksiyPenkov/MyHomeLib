(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov aka Koreec (oleksiy.penkov@gmail.com)
  *
  * Author(s)           Oleksiy Penkov (oleksiy.penkov@gmail.com)
  * Created             24.07.2026
  * Description         Maps form/tab HelpContext IDs onto the HTML help topics
  *                     shipped in the Help subfolder, and opens them in the
  *                     default browser.
  *
  ****************************************************************************** *)

unit unit_HelpTopics;

interface

function HelpTopicFile(ContextID: Integer): string;
procedure ShowHelpTopic(ContextID: Integer);

implementation

uses
  Windows,
  SysUtils,
  Forms,
  Dialogs,
  ShellAPI,
  unit_Consts,
  unit_Settings,
  unit_MHL_strings,
  dm_user;

const
  HELP_TOPIC_INDEX = 'index.html';

type
  THelpTopic = record
    ContextID: Integer;
    FileName: string;
  end;

const
  //
  // Кожен ID узятий з властивості HelpContext відповідної форми, вкладки
  // або пункту меню. 5001 та будь-який невідомий ID відкривають зміст.
  //
  HelpTopics: array [0 .. 21] of THelpTopic = (
    (ContextID: 1;   FileName: 'index.html'),              // pgControl
    (ContextID: 2;   FileName: 'main_window.html'),        // frmMain
    (ContextID: 105; FileName: 'menu_book.html'),          // меню "Книга"
    (ContextID: 108; FileName: 'download.html'),           // tsDownload
    (ContextID: 110; FileName: 'collections.html'),        // frmBases
    (ContextID: 112; FileName: 'menu_collection.html'),    // меню "Колекція"
    (ContextID: 113; FileName: 'update.html'),             // dlgUpdateFromFile
    (ContextID: 117; FileName: 'editing.html'),            // frmEditAuthor
    (ContextID: 125; FileName: 'groups.html'),             // tsByGroup
    (ContextID: 126; FileName: 'search.html'),             // tsSearch
    (ContextID: 129; FileName: 'import_nonfb2.html'),      // frmAddNonFB2
    (ContextID: 132; FileName: 'set_interface.html'),      // tsInterface
    (ContextID: 133; FileName: 'set_internet.html'),       // tsInternet
    (ContextID: 135; FileName: 'browsing.html'),           // tsByAuthor/tsBySerie/tsByGenre
    (ContextID: 136; FileName: 'new_collection.html'),     // frmMHLWizardBase
    (ContextID: 137; FileName: 'set_readers.html'),        // tsReaders
    (ContextID: 140; FileName: 'set_scripts.html'),        // tsScripts
    (ContextID: 143; FileName: 'set_device.html'),         // tsDevices
    (ContextID: 144; FileName: 'settings.html'),           // frmSettings
    (ContextID: 145; FileName: 'set_internet.html'),       // tsProxy
    (ContextID: 147; FileName: 'set_other.html'),          // tsBehavour
    (ContextID: 148; FileName: 'set_filesort.html')        // tsFileSort
  );

function HelpTopicFile(ContextID: Integer): string;
var
  i: Integer;
begin
  for i := Low(HelpTopics) to High(HelpTopics) do
    if HelpTopics[i].ContextID = ContextID then
      Exit(HelpTopics[i].FileName);

  Result := HELP_TOPIC_INDEX;
end;

procedure ShowHelpTopic(ContextID: Integer);
var
  HelpDir: string;
  FullName: string;
begin
  HelpDir := ExtractFilePath(Settings.SystemFileName[sfAppHelp]);
  FullName := HelpDir + HelpTopicFile(ContextID);

  // A translated help tree may be incomplete -- pages are added to the
  // Ukrainian original over time and a translation lags. Fall back to the
  // Ukrainian page rather than refusing to show help at all, the same way a
  // partial catalog degrades to Ukrainian instead of blanking the UI.
  if not FileExists(FullName) then
    FullName := Settings.AppPath + APP_HELP_DIR_NAME + PathDelim
      + HelpTopicFile(ContextID);

  if not FileExists(FullName) then
  begin
    MessageDlg(Format(rstrHelpFileNotFound, [FullName]), mtWarning, [mbOK], 0);
    Exit;
  end;

  ShellExecute(Application.Handle, 'open', PChar(FullName), nil, nil, SW_SHOWNORMAL);
end;

end.
