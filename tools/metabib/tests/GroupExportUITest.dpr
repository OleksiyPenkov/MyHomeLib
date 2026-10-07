program GroupExportUITest;

{$APPTYPE CONSOLE}
{$R '..\..\..\Program\MyhomeLib.res'}
{$R '..\..\..\Program\MyhomeLib.dres'}
{$R '..\..\..\Program\lang.res'}

uses
  System.SysUtils, System.Classes, System.IOUtils,
  Winapi.Windows, Winapi.Messages, Vcl.Forms, Vcl.ExtCtrls, Vcl.Menus,
  VirtualTrees, BookTreeView,
  unit_Globals, unit_Consts, unit_Interfaces, unit_Settings, unit_Localization,
  unit_MetabibReader, unit_ExportMetabibThread, frm_ImportProgressFormEx,
  dm_user, dm_Images, frm_splash, frm_main, frm_genre_tree;

type
  TDialogDriver = class
    Timer: TTimer;
    PickerSeen: Boolean;
    LastInfo: TMetabibExportResult;
    constructor Create;
    destructor Destroy; override;
    procedure Tick(Sender: TObject);
  end;

procedure Require(Condition: Boolean; const Message: string);
begin
  if not Condition then
    raise Exception.Create(Message);
end;

constructor TDialogDriver.Create;
begin
  inherited;
  Timer := TTimer.Create(nil);
  Timer.Interval := 25;
  Timer.OnTimer := Tick;
end;

destructor TDialogDriver.Destroy;
begin
  Timer.Free;
  inherited;
end;

procedure TDialogDriver.Tick(Sender: TObject);
var
  I: Integer;
  Progress: TImportProgressFormEx;
  Picker: HWND;
  ProcessID: Cardinal;
begin
  Picker := FindWindowEx(0, 0, '#32770', 'Тека експорту груп');
  while Picker <> 0 do
  begin
    GetWindowThreadProcessId(Picker, @ProcessID);
    if ProcessID = GetCurrentProcessId then
    begin
      PickerSeen := True;
      PostMessage(Picker, WM_CLOSE, 0, 0);
    end;
    Picker := FindWindowEx(0, Picker, '#32770', 'Тека експорту груп');
  end;
  for I := Screen.FormCount - 1 downto 0 do
    if (Screen.Forms[I] is TImportProgressFormEx) and Screen.Forms[I].Visible then
    begin
      Progress := TImportProgressFormEx(Screen.Forms[I]);
      if Progress.WorkerThread.Finished then
      begin
        LastInfo := TExportMetabibThread(Progress.WorkerThread).ResultInfo;
        Progress.btnCancel.Click;
      end;
    end;
end;

function AddBook(CollectionID, GroupID: Integer; const Name, Language: string): Integer;
var
  Collection: IBookCollection;
  R: TBookRecord;
begin
  Collection := SystemDB.GetCollection(CollectionID);
  R.Clear;
  R.Title := Name;
  R.FileName := Name;
  R.FileExt := '.fb2';
  R.LibID := Name;
  R.Lang := Language;
  R.Date := EncodeDate(2020, 1, 1);
  TAuthorsHelper.Add(R.Authors, 'Fixture', 'Author', '');
  Include(R.BookProps, bpIsLocal);
  Result := Collection.InsertBook(R, False, False);
  System.IOUtils.TFile.WriteAllText(TPath.Combine(Collection.CollectionRoot, Name + '.fb2'),
    'payload-' + Name, TEncoding.UTF8);
  if GroupID > 0 then
    Collection.AddBookToGroup(CreateBookKey(Result, CollectionID), GroupID);
end;

procedure SelectGroup(ID: Integer);
var
  Node: PVirtualNode;
  Data: PGroupData;
begin
  frmMain.tvGroups.ClearSelection;
  Node := frmMain.tvGroups.GetFirst;
  while Assigned(Node) do
  begin
    Data := frmMain.tvGroups.GetNodeData(Node);
    if Assigned(Data) and (Data^.GroupID = ID) then
    begin
      frmMain.tvGroups.Selected[Node] := True;
      frmMain.tvGroups.FocusedNode := Node;
      frmMain.tvGroupsChange(frmMain.tvGroups, Node);
      Exit;
    end;
    Node := frmMain.tvGroups.GetNext(Node);
  end;
  raise Exception.Create('Group is absent from the actual group tree');
end;

procedure VerifyTitles(const Directory: string);
var
  Reader: TMetabibReader;
  Book: TMetabibBook;
  Titles: TStringList;
begin
  Reader := TMetabibReader.Create(TPath.Combine(Directory, 'catalog.jsonl'));
  Titles := TStringList.Create;
  try
    while Reader.ReadNext(Book) = mrOk do
      Titles.Add(Book.Title);
    Titles.Sort;
    Require((Titles.Count = 3) and (Titles[0] = 'A ru') and
      (Titles[1] = 'A uk') and (Titles[2] = 'B uk'), 'UI exported visible rows instead of whole group membership');
  finally
    Titles.Free;
    Reader.Free;
  end;
end;

var
  A, B, GroupID: Integer;
  One, Two: IBookCollection;
  Groups: IGroupIterator;
  Group: TGroupData;
  Destination, Saved: string;
  Node: PVirtualNode;
  Driver: TDialogDriver;
  Item: TMenuItem;
begin
  try
    Application.Initialize;
    InitLocalization;
    frmSplash := TfrmSplash.Create(Application);
    Application.CreateForm(TDMUser, DMUser);
    DMUser.Init;
    A := SystemDB.CreateCollection('UI source A', Settings.AppPath,
      'ui-source-a.hlc2', CT_EXTERNAL_LOCAL_FB, Settings.AppPath + 'genres_fb2.glst');
    B := SystemDB.CreateCollection('UI source B', Settings.AppPath,
      'ui-source-b.hlc2', CT_EXTERNAL_LOCAL_FB, Settings.AppPath + 'genres_fb2.glst');
    Require(SystemDB.AddGroup('Export group'), 'User group was not created');
    GroupID := -1;
    Groups := SystemDB.GetGroupIterator;
    while Groups.Next(Group) do
      if Group.Text = 'Export group' then
        GroupID := Group.GroupID;
    Groups := nil;
    Require(GroupID > 0, 'User group is missing');
    AddBook(A, GroupID, 'A uk', 'uk');
    AddBook(A, GroupID, 'A ru', 'ru');
    AddBook(B, GroupID, 'B uk', 'uk');
    AddBook(A, -1, 'Outside group', 'ru');
    One := SystemDB.GetCollection(A);
    Two := SystemDB.GetCollection(B);
    Settings.ActiveCollection := A;
    Settings.ActivePage := PAGE_FAVORITES;
    Destination := Settings.AppPath + 'ui-exports';
    ForceDirectories(Destination);
    Settings.GroupExportDir := Destination;
    Settings.SaveSettings;
    Settings.GroupExportDir := '';
    Settings.LoadSettings;
    Application.CreateForm(TdmImages, dmImages);
    dmImages.ApplyThemeIcons;
    Application.CreateForm(TfrmMain, frmMain);
    Application.CreateForm(TfrmGenreTree, frmGenreTree);
    frmSplash.Hide;
    frmMain.Show;
    frmMain.pgControl.ActivePageIndex := PAGE_FAVORITES;
    frmMain.pgControlChange(nil);
    SelectGroup(GroupID);
    frmMain.cbLangSelectF.ItemIndex := frmMain.cbLangSelectF.Items.IndexOf('ru');
    Require(frmMain.cbLangSelectF.ItemIndex >= 0, 'Fixture Russian books are absent from the language selector');
    frmMain.cbLangSelectF.OnChange(frmMain.cbLangSelectF);
    frmMain.tvBooksF.ClearSelection;
    Node := frmMain.tvBooksF.GetFirst;
    while Assigned(Node) do
    begin
      frmMain.tvBooksF.CheckState[Node] := csUncheckedNormal;
      Node := frmMain.tvBooksF.GetNext(Node);
    end;
    Driver := TDialogDriver.Create;
    try
      frmMain.acGroupExportMetabib.Update;
      Require(frmMain.acGroupExportMetabib.Execute, 'Group export action is disabled');
      Require(not Driver.PickerSeen, 'Saved destination was not reused');
      Require(Driver.LastInfo.Status = mesCompleted, 'Actual group command did not export');
      VerifyTitles(Driver.LastInfo.OutputDirectory);
      Writeln('PASS group_ignores_view_filters and saved destination through actual UI command');
      for Item in frmMain.miCollSelect do
        if Item.Tag = B then
        begin
          frmMain.miActiveCollectionClick(Item);
          Break;
        end;
      SelectGroup(GroupID);
      Driver.PickerSeen := False;
      frmMain.acGroupExportMetabib.Update;
      Require(frmMain.acGroupExportMetabib.Execute, 'Group export action disabled after collection switch');
      Require(not Driver.PickerSeen, 'Collection switch lost the saved destination');
      VerifyTitles(Driver.LastInfo.OutputDirectory);
      Writeln('PASS active collection does not restrict exported group members');
      Saved := Settings.GroupExportDir;
      Driver.PickerSeen := False;
      frmMain.acGroupExportDestination.Execute;
      Require(Driver.PickerSeen and (Settings.GroupExportDir = Saved), 'Destination-change cancellation altered the path');
      Settings.GroupExportDir := '';
      Driver.PickerSeen := False;
      frmMain.acGroupExportMetabib.Execute;
      Require(Driver.PickerSeen and (Settings.GroupExportDir = ''), 'First-use picker cancellation started an export');
      Settings.GroupExportDir := Settings.AppPath + 'does-not-exist';
      Driver.PickerSeen := False;
      frmMain.acGroupExportMetabib.Execute;
      Require(Driver.PickerSeen and (Settings.GroupExportDir = Settings.AppPath + 'does-not-exist'),
        'Invalid saved path did not request a new destination');
      Writeln('PASS first-use, destination-change and invalid-destination cancellation');
      frmMain.tvGroups.ClearSelection;
      frmMain.acGroupExportMetabib.Update;
      Require(not frmMain.acGroupExportMetabib.Enabled, 'Export remained enabled without a selected group');
      if ParamStr(1) = 'visual' then
      begin
        Settings.GroupExportDir := Saved;
        SelectGroup(GroupID);
        frmMain.acGroupExportMetabib.Update;
        Writeln('VISUAL READY');
        Flush(Output);
        Application.Run;
      end;
    finally
      Driver.Free;
    end;
    frmGenreTree.Free;
    frmMain.Free;
    One := nil;
    Two := nil;
    dmImages.Free;
    DMUser.Free;
    frmSplash.Free;
  except
    on E: Exception do
    begin
      Writeln('FAIL ', E.ClassName, ': ', E.Message);
      Halt(1);
    end;
  end;
end.
