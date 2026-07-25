# Manual Collection Update Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Let the user pick an INPX/ZIP update file from disk and run it through the existing collection-update pipeline against the currently open collection.

**Architecture:** The per-collection update step (bulk operation, user-data backup, truncate, import, restore, book-ID remap) is currently inlined in `TLibUpdateThread.WorkFunction`. Extract it into `TCollectionUpdateThreadBase.UpdateCollection`, then add a second descendant `TManualUpdateThread` that calls it once with a user-supplied file. A small modal dialog collects the file name and the full-re-import flag; a new action on the main form drives it.

**Tech Stack:** Delphi 13 (RAD Studio 37.0), VCL, existing MyHomeLib DAO/worker-thread layers.

## Global Constraints

- **No automated test harness exists in this repository.** There is no DUnit/DUnitX project. Every task is verified by a successful build of both platforms plus the stated manual check in the running application. Do not invent a test project.
- **Build only through the group project.** Never run msbuild on `Program\MyhomeLib.dproj` directly — it re-serialises the file and breaks every later build with `F2613 Unit 'SysUtils' not found`.
- Win64 build command:
  ```
  cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MHL.groupproj /t:Build /p:Config=Release /p:Platform=Win64 /nologo /v:minimal" 2>&1
  ```
  Win32: same with `/p:Platform=Win32`. `C:\Windows\System32` must be on `PATH` or the post-build `robocopy` fails.
- **Win64 is the primary target** — build it first; both must pass before a commit.
- All user-visible strings are Ukrainian `resourcestring` constants in the `.pas` file, following the existing style in each unit.
- Copyright headers on new files use `Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)`.
- Git commit prefixes: `+` for a new feature/addition, `*` for a modification/fix/refactor.
- **Do not mark anything done until the user confirms it works in the running app.** A successful build means nothing.

---

### Task 1: Add the `fnOpenUpdate` file-dialog key

**Files:**
- Modify: `Program/Units/unit_Helpers.pas` (enum at :47-61, resourcestrings near :266-274, `DlgParams` array at :294-364)
- Test: none (no test harness — build only)

**Interfaces:**
- Consumes: nothing
- Produces: `fnOpenUpdate: TMHLFileName`, usable as `GetFileName(fnOpenUpdate, FileName): Boolean`

`DlgParams` is a positional `array[TMHLFileName] of TDialogParams`. Adding an enum member without adding the matching array entry in the same position is a compile error at best and a silently wrong dialog at worst. Add both **at the end**.

- [ ] **Step 1: Add the enum member**

In `Program/Units/unit_Helpers.pas`, extend the enum (currently ending `fnOpenCoverImage`):

```pascal
  TMHLFileName = (
    fnGenreList,
    fnOpenCollection,
    fnSelectReader,
    fnSelectScript,
    fnOpenImportFile,
    fnSaveCollection,
    fnSaveLog,
    fnSaveImportFile,
    fnOpenINPX,
    fnSaveINPX,
    fnOpenUserData,
    fnSaveUserData,
    fnOpenCoverImage,
    fnOpenUpdate
  );
```

- [ ] **Step 2: Add the resourcestrings**

In the same unit, after the `//fnOpenCoverImage` block (around :286-289):

```pascal
   //fnOpenUpdate
   rstrOpenUpdateDlgTitle = 'Вибір файлу оновлення';
   rstrOpenUpdateDlgFilter = 'Файл оновлення (*.inpx, *.zip)|*.inpx;*.zip|Всі типи|*.*';
   rstrOpenUpdateDlgDefaultExt = 'inpx';
```

- [ ] **Step 3: Add the `DlgParams` entry**

In `GetFileName`, append after the `fnOpenCoverImage` entry (note the comma added to the previous entry):

```pascal
    ( // fnOpenCoverImage
      Title:      rstrOpenCIDlgTitle;
      Filter:     rstrOpenCIDlgFilter;     DefaultExt: rstrOpenCIDlgDefaultExt;
      DialogKey:  'OpenCoverImage';        OpenFile: True
    ),
    ( // fnOpenUpdate
      Title:      rstrOpenUpdateDlgTitle;
      Filter:     rstrOpenUpdateDlgFilter; DefaultExt: rstrOpenUpdateDlgDefaultExt;
      DialogKey:  'OpenUpdateFile';        OpenFile: True
    )
  );
```

`DialogKey` is `'OpenUpdateFile'` — its own key, so this dialog remembers its own last folder and does not disturb the New Collection wizard's `'OpenINPXFile'`.

- [ ] **Step 4: Build Win64**

Run the Win64 command from Global Constraints.
Expected: builds with no errors. If you see `E2072 Number of elements differs from declaration`, the array entry count no longer matches the enum — recheck Steps 1 and 3.

- [ ] **Step 5: Build Win32**

Run the Win32 command. Expected: builds with no errors.

- [ ] **Step 6: Commit**

```bash
git add Program/Units/unit_Helpers.pas
git commit -m "+ Add fnOpenUpdate file dialog key for update files"
```

---

### Task 2: Extract the per-collection update step

**Files:**
- Modify: `Program/UtilsImpl/unit_libupdateThread.pas` (type block :34-49, `WorkFunction` :139-261)
- Test: none (build + manual regression of the existing online update)

**Interfaces:**
- Consumes: `TImportInpxThreadBase` (`Program/ImportImpl/unit_ImportInpxThread.pas:60`), `TCollectionWorker.FSystemData` / `Teletype` / `Import`
- Produces:
  ```pascal
  TCollectionUpdateThreadBase = class(TImportInpxThreadBase)
  protected
    procedure UpdateCollection(const AFileName: string; ACollectionID: Integer;
      AFull: Boolean; const ADisplayName: string);
  end;
  ```

**This task is a pure refactor — no behaviour change.** The online update must work exactly as before. File deletion, version checks, download and cancellation cleanup all stay in `TLibUpdateThread`; `UpdateCollection` must never delete the source file.

- [ ] **Step 1: Declare the new base class**

In the `type` block of `Program/UtilsImpl/unit_libupdateThread.pas`, insert before `TLibUpdateThread` and change `TLibUpdateThread`'s ancestor:

```pascal
  TCollectionUpdateThreadBase = class(TImportInpxThreadBase)
  protected
    procedure UpdateCollection(const AFileName: string; ACollectionID: Integer;
      AFull: Boolean; const ADisplayName: string);
  end;

  TLibUpdateThread = class(TCollectionUpdateThreadBase)
  private
    FHTTPClient: THTTPClient;
    FStartDate: TDateTime;
    FUpdated: Boolean;

  protected
    procedure Initialize; override;
    procedure Uninitialize; override;
    procedure WorkFunction; override;
    procedure HTTPReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var AAbort: Boolean);

  public
    constructor Create;
    property Updated: Boolean read FUpdated;
  end;
```

- [ ] **Step 2: Implement `UpdateCollection`**

Add in the implementation section, immediately before `{ TLibUpdateThread }`:

```pascal
{ TCollectionUpdateThreadBase }

//
// Оновлення однієї колекції з одного файлу списків.
// Файл AFileName не видаляється — про нього дбає викликач.
//
procedure TCollectionUpdateThreadBase.UpdateCollection(const AFileName: string;
  ACollectionID: Integer; AFull: Boolean; const ADisplayName: string);
var
  Collection: IBookCollection;
  UserDataBackup: TUserData;
begin
  //Truncate won't work with TBookCollection.Create(DBFileName, False)
  Collection := FSystemData.GetCollection(ACollectionID);
  Collection.BeginBulkOperation;
  try
    UserDataBackup := TUserData.Create;
    try
      if AFull then
      begin
        // Backup user data:
        Teletype(Format(rstrBackupUserData, [ADisplayName]), tsInfo);
        Collection.ExportUserData(UserDataBackup);

        // clear most tables in a collection
        Teletype(Format(rstrRemovingOldCollection, [ADisplayName]), tsInfo);
        Collection.TruncateTablesBeforeImport;
      end;

      Teletype(rstrImportIntoCollection, tsInfo);
      Import(AFileName, not AFull, Collection);

      if AFull then
      begin
        // Restore user data:
        Teletype(Format(rstrRestoreUserData, [ADisplayName]), tsInfo);
        Collection.ImportUserData(UserDataBackup, nil);
      end;
    finally
      FreeAndNil(UserDataBackup);
    end;

    Collection.EndBulkOperation(True);
  except
    Collection.EndBulkOperation(False);
    raise;
  end;

  //
  // При полном переимпорте BookID в коллекции переприсваиваются, и сохранённые
  // в группах BookID начинают указывать на чужие книги. Приводим их к новой
  // нумерации по LibID (при полном переимпорте заодно убираем книги, которых
  // в коллекции больше нет).
  // Делается только после коммита коллекции: системная БД - отдельный файл,
  // её изменения не откатятся вместе с импортом.
  //
  FSystemData.RemapCollectionBookIDs(ACollectionID, AFull);
end;
```

- [ ] **Step 3: Call it from `TLibUpdateThread.WorkFunction`**

Replace the block that currently runs from `InpxFileName := TPath.Combine(...)` down to and including `Teletype(rstrReady, tsInfo);` (`unit_libupdateThread.pas:186-236`) with:

```pascal
      InpxFileName := TPath.Combine(Settings.UpdatePath, updateInfo.UpdateFile);
      UpdateCollection(InpxFileName, updateInfo.CollectionID, updateInfo.Full, updateInfo.Name);
      Teletype(rstrReady, tsInfo);
```

Then trim the now-unused locals from `WorkFunction`'s `var` block. It becomes:

```pascal
var
  i: integer;
  InpxFileName: string;
  updateInfo: TUpdateInfo;
```

(`Collection` and `UserDataBackup` moved into `UpdateCollection`; `S: string` was already dead before this change.)

Leave everything else in `WorkFunction` untouched — the `Settings.Updates` loop, `DownloadUpdate`, the `Canceled` check that deletes a partially downloaded file, the post-loop cleanup loop that deletes update files, and the `except` block.

- [ ] **Step 4: Build Win64**

Expected: no errors. If you get `E2003 Undeclared identifier: 'IBookCollection'` or `'TUserData'`, both are already reachable — `unit_Interfaces` is in the implementation `uses` and `unit_UserData` in the interface `uses`; recheck you added the method to the implementation section of this unit.

- [ ] **Step 5: Build Win32**

Expected: no errors.

- [ ] **Step 6: Manual regression check (needs the user)**

In the running app: `Інструменти → Оновити колекції` against a collection that has an update available. Confirm it still downloads, imports, reports `Готово`, and that the downloaded update file is deleted from the updates folder afterwards.

- [ ] **Step 7: Commit**

```bash
git add Program/UtilsImpl/unit_libupdateThread.pas
git commit -m "* Extract the per-collection update step into a shared base class"
```

---

### Task 3: Add `TManualUpdateThread`

**Files:**
- Modify: `Program/UtilsImpl/unit_libupdateThread.pas`
- Test: none (build only; runtime verification arrives in Task 5)

**Interfaces:**
- Consumes: `TCollectionUpdateThreadBase.UpdateCollection` (Task 2), `TGenresType` from `unit_Globals`
- Produces:
  ```pascal
  TManualUpdateThread = class(TCollectionUpdateThreadBase)
  public
    constructor Create(const ACollectionID: Integer; const AFileName: string;
      AFull: Boolean; AGenresType: TGenresType);
  end;
  ```

- [ ] **Step 1: Add `unit_Globals` to the interface uses clause**

`TGenresType` lives in `unit_Globals`, which is currently only in the *implementation* uses of this unit. The constructor signature needs it in the interface:

```pascal
uses
  Windows,
  Classes,
  SysUtils,
  unit_ImportInpxThread,
  System.Net.HttpClient,
  unit_Globals,
  unit_UserData;
```

Then remove `unit_Globals` from the implementation `uses` list to avoid the duplicate (`W1005 Unit 'unit_Globals' is specified more than once`).

- [ ] **Step 2: Declare the class**

After `TLibUpdateThread`'s declaration:

```pascal
  TManualUpdateThread = class(TCollectionUpdateThreadBase)
  private
    FFileName: string;
    FFull: Boolean;
    FDisplayName: string;

  protected
    procedure WorkFunction; override;

  public
    constructor Create(const ACollectionID: Integer; const AFileName: string;
      AFull: Boolean; AGenresType: TGenresType);
    property DisplayName: string read FDisplayName write FDisplayName;
  end;
```

- [ ] **Step 3: Add the resourcestrings**

Append to the existing `resourcestring` block in this unit:

```pascal
   rstrManualCollectionUpdate = 'Оновлення колекції %s з файлу %s:';
   rstrManualUpdateComplete = 'Оновлення завершено.';
   rstrManualUpdateFailed = 'Оновлення не вдалося.';
   rstrUpdateFileNotFound = 'Файл оновлення не знайдено: %s';
```

- [ ] **Step 4: Implement the class**

Add at the end of the implementation section, before `end.`:

```pascal
{ TManualUpdateThread }

constructor TManualUpdateThread.Create(const ACollectionID: Integer;
  const AFileName: string; AFull: Boolean; AGenresType: TGenresType);
begin
  inherited Create(ACollectionID);
  FFileName := AFileName;
  FFull := AFull;
  FGenresType := AGenresType;
end;

procedure TManualUpdateThread.WorkFunction;
begin
  if not FileExists(FFileName) then
  begin
    Teletype(Format(rstrUpdateFileNotFound, [FFileName]), tsError);
    Exit;
  end;

  try
    Teletype(Format(rstrManualCollectionUpdate, [FDisplayName, FFileName]), tsInfo);
    UpdateCollection(FFileName, FCollectionID, FFull, FDisplayName);
    Teletype(rstrManualUpdateComplete, tsInfo);
    SetComment(rstrReady);
  except
    on E: Exception do
    begin
      Teletype(rstrManualUpdateFailed, tsError);
      Teletype(E.Message, tsError);
    end;
  end;
end;
```

The source file is deliberately **not** deleted — this is the user's own file.

- [ ] **Step 5: Build Win64**

Expected: no errors.

- [ ] **Step 6: Build Win32**

Expected: no errors.

- [ ] **Step 7: Commit**

```bash
git add Program/UtilsImpl/unit_libupdateThread.pas
git commit -m "+ Add a worker thread for updating a collection from a picked file"
```

---

### Task 4: The `frm_UpdateFromFile` dialog

**Files:**
- Create: `Program/Forms/frm_UpdateFromFile.pas`
- Create: `Program/Forms/frm_UpdateFromFile.dfm`
- Modify: `Program/MyHomeLib.dpr` (uses list, near :141)
- Modify: `Program/MyhomeLib.dproj` (`DCCReference` list, near :212)
- Test: none (build; the dialog is exercised manually in Task 5)

**Interfaces:**
- Consumes: `GetFileName(fnOpenUpdate, ...)` from Task 1
- Produces:
  ```pascal
  function AskUpdateFile(out AFileName: string; out AFull: Boolean): Boolean;
  ```
  Returns `True` when the user confirmed with an existing file selected. Modelled on `AskDeleteCollectionAction` in `Program/Forms/frm_DeleteCollection.pas:74`.

The DFM is hand-written, so it is kept **ASCII-only**: every Ukrainian caption is assigned in `FormCreate` from a `resourcestring`. Do not type Cyrillic literals into the `.dfm` — the IDE writes them as `#NNNN` escape sequences and a hand-typed UTF-8 literal can load as mojibake. When the user later opens the form in the IDE it will re-save in the normal format.

Per the project's DFM rules, this is a brand-new file, so authoring coordinates here is fine — but do not touch geometry in any *existing* DFM.

- [ ] **Step 1: Create the DFM**

`Program/Forms/frm_UpdateFromFile.dfm` — 96 PPI, matching `frm_statistic.dfm`'s font conventions:

```
object dlgUpdateFromFile: TdlgUpdateFromFile
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 190
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object lblFile: TLabel
    Left = 12
    Top = 12
    Width = 3
    Height = 13
  end
  object lblWarning: TLabel
    Left = 30
    Top = 92
    Width = 438
    Height = 45
    AutoSize = False
    WordWrap = True
  end
  object edFile: TEdit
    Left = 12
    Top = 31
    Width = 380
    Height = 21
    ReadOnly = True
    TabOrder = 0
    OnChange = edFileChange
  end
  object btnBrowse: TButton
    Left = 400
    Top = 29
    Width = 68
    Height = 25
    TabOrder = 1
    OnClick = btnBrowseClick
  end
  object cbFull: TCheckBox
    Left = 12
    Top = 68
    Width = 456
    Height = 17
    TabOrder = 2
  end
  object btnOk: TButton
    Left = 296
    Top = 152
    Width = 80
    Height = 25
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 388
    Top = 152
    Width = 80
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 4
  end
end
```

- [ ] **Step 2: Create the unit**

`Program/Forms/frm_UpdateFromFile.pas`:

```pascal
(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             25.07.2026
  * Description         Вибір файлу для ручного оновлення колекції
  *
  ****************************************************************************** *)

unit frm_UpdateFromFile;

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
  StdCtrls;

type
  TdlgUpdateFromFile = class(TForm)
    lblFile: TLabel;
    lblWarning: TLabel;
    edFile: TEdit;
    btnBrowse: TButton;
    cbFull: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure edFileChange(Sender: TObject);
  end;

function AskUpdateFile(out AFileName: string; out AFull: Boolean): Boolean;

implementation

uses
  unit_Helpers;

{$R *.dfm}

resourcestring
   rstrUpdateFromFileCaption = 'Оновлення колекції з файлу';
   rstrUpdateFileLabel = 'Файл оновлення (*.inpx, *.zip):';
   rstrBrowseCaption = 'Огляд...';
   rstrFullReimportCaption = 'Повний переімпорт (очистити колекцію)';
   rstrFullReimportWarning = 'Колекцію буде очищено й наповнено заново з вибраного ' +
     'файлу. Дані користувача (прочитане, оцінки, групи) буде збережено та ' +
     'відновлено. Без цієї опції записи з файлу лише додаються до колекції.';
   rstrOkCaption = 'OK';
   rstrCancelCaption = 'Скасувати';

procedure TdlgUpdateFromFile.FormCreate(Sender: TObject);
begin
  Caption := rstrUpdateFromFileCaption;
  lblFile.Caption := rstrUpdateFileLabel;
  btnBrowse.Caption := rstrBrowseCaption;
  cbFull.Caption := rstrFullReimportCaption;
  lblWarning.Caption := rstrFullReimportWarning;
  btnOk.Caption := rstrOkCaption;
  btnCancel.Caption := rstrCancelCaption;
end;

procedure TdlgUpdateFromFile.btnBrowseClick(Sender: TObject);
var
  FileName: string;
begin
  if GetFileName(fnOpenUpdate, FileName) then
    edFile.Text := FileName;
end;

procedure TdlgUpdateFromFile.edFileChange(Sender: TObject);
begin
  btnOk.Enabled := (edFile.Text <> '') and FileExists(edFile.Text);
end;

function AskUpdateFile(out AFileName: string; out AFull: Boolean): Boolean;
var
  Dlg: TdlgUpdateFromFile;
begin
  AFileName := '';
  AFull := False;

  Dlg := TdlgUpdateFromFile.Create(Application);
  try
    Result := (mrOk = Dlg.ShowModal);
    if Result then
    begin
      AFileName := Dlg.edFile.Text;
      AFull := Dlg.cbFull.Checked;
    end;
  finally
    Dlg.Free;
  end;
end;

end.
```

- [ ] **Step 3: Register the unit in the .dpr**

In `Program/MyHomeLib.dpr`, next to the other form units (e.g. after the `frm_DeleteCollection` line at :141):

```pascal
  frm_UpdateFromFile in 'Forms\frm_UpdateFromFile.pas' {dlgUpdateFromFile},
```

- [ ] **Step 4: Register the unit in the .dproj**

In `Program/MyhomeLib.dproj`, next to the other `DCCReference` entries (e.g. after the `frm_DeleteCollection.pas` block at :212-214):

```xml
        <DCCReference Include="Forms\frm_UpdateFromFile.pas">
            <Form>dlgUpdateFromFile</Form>
        </DCCReference>
```

Hand-edit this block only. Do **not** run msbuild against `MyhomeLib.dproj` directly and do not let anything else re-serialise the file — the `CodeGear.Delphi.Targets` import must stay below the config property groups.

- [ ] **Step 5: Build Win64**

Expected: no errors. `E2161 Record or class field expected` or a missing-DFM error means the form class name in the `.dfm` (`TdlgUpdateFromFile`) and the `.pas` disagree.

- [ ] **Step 6: Build Win32**

Expected: no errors.

- [ ] **Step 7: Commit**

```bash
git add Program/Forms/frm_UpdateFromFile.pas Program/Forms/frm_UpdateFromFile.dfm Program/MyHomeLib.dpr Program/MyhomeLib.dproj
git commit -m "+ Add the update-from-file dialog"
```

---

### Task 5: Wire the action into the main form

**Files:**
- Modify: `Program/UtilsImpl/unit_Utils.pas` (interface :26-35, implementation uses :39-50, near `LibrusecUpdate` :93-114)
- Modify: `Program/Forms/frm_main.pas` (action field near :430, method declaration near :625, implementation near :6352, uses clause near :1032)
- Modify: `Program/Forms/frm_main.dfm` (action list `Actions` at :3779, action near :4091, menu `miTools` at :2870)
- Test: none automated — manual verification below

**Interfaces:**
- Consumes: `TManualUpdateThread` (Task 3), `AskUpdateFile` (Task 4)
- Produces: `procedure ManualCollectionUpdate(const CollectionID: Integer; const LogFileName: string);` in `unit_Utils`

- [ ] **Step 1: Declare the runner in `unit_Utils`**

Add to the interface section of `Program/UtilsImpl/unit_Utils.pas`, after `LibrusecUpdate`:

```pascal
procedure ManualCollectionUpdate(const CollectionID: Integer; const LogFileName: string);
```

Add `unit_Globals` and `frm_UpdateFromFile` to the implementation `uses` list (`unit_Interfaces`, `unit_Settings`, `unit_libupdateThread`, `frm_ImportProgressFormEx` and `Forms` are already there):

```pascal
uses
  Forms,
  unit_SyncOnLineThread,
  frm_SyncOnLineProgressForm,
  unit_SyncFoldersThread,
  frm_ImportProgressFormEx,
  unit_libupdateThread,
  frm_info_popup,
  frm_search,
  frm_main,
  frm_UpdateFromFile,
  unit_Globals,
  unit_Interfaces,
  unit_Settings,
  dm_user;
```

- [ ] **Step 2: Add the resourcestring**

Extend the existing `resourcestring` block in `unit_Utils.pas`:

```pascal
resourcestring
  rstrUpdateCollections = 'Оновлення колекцій';
  rstrUpdateFromFile = 'Оновлення колекції з файлу';
```

- [ ] **Step 3: Implement `ManualCollectionUpdate`**

Add after `LibrusecUpdate`:

```pascal
procedure ManualCollectionUpdate(const CollectionID: Integer; const LogFileName: string);
var
  FileName: string;
  Full: Boolean;
  GenresType: TGenresType;
  CollectionInfo: TCollectionInfo;
  worker: TManualUpdateThread;
  ProgressForm: TImportProgressFormEx;
begin
  if not AskUpdateFile(FileName, Full) then
    Exit;

  CollectionInfo := DMUser.GetSystemDBConnection.GetCollectionInfo(CollectionID);

  if isFB2Collection(CollectionInfo.CollectionType) then
    GenresType := gtFb2
  else
    GenresType := gtAny;

  worker := TManualUpdateThread.Create(CollectionID, FileName, Full, GenresType);
  try
    worker.DisplayName := CollectionInfo.DisplayName;

    ProgressForm := TImportProgressFormEx.Create(Application);
    ProgressForm.Caption := rstrUpdateFromFile;
    try
      ProgressForm.btnSaveLog.Visible := True;
      ProgressForm.WorkerThread := worker;
      ProgressForm.ShowModal;
      ProgressForm.SaveErrorLog(LogFileName);
    finally
      ProgressForm.Free;
    end;
  finally
    worker.Free;
  end;
end;
```

Note `CloseOnTimer` is deliberately **not** set (unlike `LibrusecUpdate`): the user should read the result of a manual operation before the window closes.

- [ ] **Step 4: Add the action field and method declaration in `frm_main.pas`**

In the published field list, after `acToolsUpdateOnlineCollections: TAction;` (:430):

```pascal
    acToolsUpdateFromFile: TAction;
```

In the method declaration list, after `procedure UpdateOnlineCollectionExecute(Sender: TObject);` (:625):

```pascal
    procedure UpdateCollectionFromFileExecute(Sender: TObject);
    procedure UpdateCollectionFromFileUpdate(Sender: TObject);
```

- [ ] **Step 5: Implement the handler**

In `frm_main.pas`, immediately after `UpdateOnlineCollectionExecute` (which ends at :6366):

```pascal
procedure TfrmMain.UpdateCollectionFromFileExecute(Sender: TObject);
var
  ActiveCollectionID: Integer;
begin
  Assert(Assigned(FCollection));
  UpdatePositions;

  ActiveCollectionID := FCollection.CollectionID;
  unit_Utils.ManualCollectionUpdate(ActiveCollectionID, Settings.SystemFileName[sfUpdateLog]);
  Settings.ActiveCollection := ActiveCollectionID;
  InitCollection;
end;
```

`unit_Utils` is already in the `frm_main.pas` uses clause (:1032).

- [ ] **Step 6: Implement the enable-state handler**

The spec requires the action to be disabled when no collection is open. Follow the
existing per-action `OnUpdate` pattern (`ImportNonFB2Update`, `frm_main.pas:6781`).
Add immediately after `UpdateCollectionFromFileExecute`:

```pascal
procedure TfrmMain.UpdateCollectionFromFileUpdate(Sender: TObject);
var
  Action: TAction;
begin
  Assert(Sender is TAction);

  Action := Sender as TAction;
  Action.Enabled := Assigned(FCollection);
end;
```

- [ ] **Step 7: Add the action to `frm_main.dfm`**

Actions and menu items are non-visual — safe to hand-edit. Captions here **must** use the `#NNNN` escape form the IDE uses, matching every other entry in this file.

After the `acToolsUpdateOnlineCollections` action block (:4091-4095), insert:

```
    object acToolsUpdateFromFile: TAction
      Category = #1030#1085#1089#1090#1088#1091#1084#1077#1085#1090#1080
      Caption = #1054#1085#1086#1074#1080#1090#1080' '#1082#1086#1083#1077#1082#1094#1110#1102' '#1079' '#1092#1072#1081#1083#1091'...'
      OnExecute = UpdateCollectionFromFileExecute
      OnUpdate = UpdateCollectionFromFileUpdate
    end
```

`Category` is the same `Інструменти` string as the neighbouring actions. `Caption` decodes to `Оновити колекцію з файлу...`.

- [ ] **Step 8: Add the menu item to `frm_main.dfm`**

Inside `object miTools: TMenuItem`, immediately after the `miUpdate` item (:2876-2878):

```
      object miUpdateFromFile: TMenuItem
        Action = acToolsUpdateFromFile
      end
```

Add the matching published field to `frm_main.pas`, next to `miUpdate: TMenuItem;` (:128):

```pascal
    miUpdateFromFile: TMenuItem;
```

- [ ] **Step 9: Build Win64**

Expected: no errors. A runtime `Error reading ...` on startup means a DFM/pas field mismatch — every object in the DFM needs a published field of the same name and type.

- [ ] **Step 10: Build Win32**

Expected: no errors.

- [ ] **Step 11: Manual verification (needs the user)**

Run the app and check each of these:

1. `Інструменти → Оновити колекцію з файлу...` appears under `Оновити колекції` and opens the dialog.
2. Browse shows the INPX/ZIP filter; OK stays disabled until an existing file is picked.
3. Incremental update (checkbox off) of a Librusec collection from an `update.zip` — book count grows, read marks and groups intact.
4. Full re-import (checkbox on) from a full INPX — collection replaced, user data survives, books open correctly (book-ID remap worked).
5. A collection with no entry in `Settings.Updates` (a plain user collection) can be updated — impossible before this change.
6. Pick a file that is not an archive → `Неправильний формат файлу INPX!` in the log, collection unchanged.
7. Cancel mid-import → collection rolled back, and **the picked file is still on disk**.
8. `Інструменти → Оновити колекції` (online) still works and still deletes its downloaded file.

- [ ] **Step 12: Commit (only after the user confirms the checks above)**

```bash
git add Program/UtilsImpl/unit_Utils.pas Program/Forms/frm_main.pas Program/Forms/frm_main.dfm
git commit -m "+ Add manual collection update from a user-selected file"
```

---

## Notes for the implementer

- If the user opens `frm_main.dfm` in the IDE at any point, check `git diff` before committing: saving that form from the high-DPI designer silently reorders toolbar `Action` properties and damages Rz spacing. Revert such a diff rather than patching it.
- `TCollectionInfo` is a record returned by value from `ISystemData.GetCollectionInfo` (`Program/Units/unit_Interfaces.pas:100`); no freeing needed.
- The progress form for imports is `TImportProgressFormEx` (`Program/ImportImpl/frm_ImportProgressFormEx.pas`), which is what both `LibrusecUpdate` and the import paths already use.
