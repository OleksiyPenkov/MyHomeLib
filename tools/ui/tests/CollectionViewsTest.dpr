program CollectionViewsTest;

{$APPTYPE CONSOLE}
{$R '..\..\..\Program\MyhomeLib.res'}
{$R '..\..\..\Program\MyhomeLib.dres'}
{$R '..\..\..\Program\lang.res'}

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
  VirtualTrees, BookTreeView,
  unit_Globals, unit_Consts, unit_Interfaces, unit_Localization, unit_TreeUtils,
  dm_user, dm_Images, frm_splash, frm_main, frm_genre_tree;

procedure Require(Condition: Boolean; const Message: string);
begin
  if not Condition then
    raise Exception.Create(Message);
end;

function AddBook(const Collection: IBookCollection; const Title, Author,
  Lang, Series, Genre: string; Deleted: Boolean = False): Integer;
var
  Book: TBookRecord;
begin
  Book.Clear;
  Book.Title := Title;
  Book.FileName := Title;
  Book.FileExt := '.fb2';
  Book.LibID := Title;
  Book.Lang := Lang;
  Book.Series := Series;
  Book.Date := EncodeDate(2020, 1, 1);
  TAuthorsHelper.Add(Book.Authors, Author, 'Alex', '');
  if Genre <> '' then
    if Pos('0.', Genre) = 1 then
      TGenresHelper.Add(Book.Genres, Genre, '', '')
    else
      TGenresHelper.Add(Book.Genres, '', '', Genre);
  Include(Book.BookProps, bpIsLocal);
  if Deleted then
    Include(Book.BookProps, bpIsDeleted);
  Result := Collection.InsertBook(Book, False, False);
  Require(Result > 0, 'Fixture book was not inserted');
end;

procedure ExpectTitles(Tree: TBookTree; const Expected: array of string);
var
  Actual, Wanted: TStringList;
  Node: PVirtualNode;
  Book: PBookRecord;
  Title: string;
begin
  Actual := TStringList.Create;
  Wanted := TStringList.Create;
  try
    Node := Tree.GetFirst;
    while Assigned(Node) do
    begin
      Book := Tree.GetNodeData(Node);
      if Assigned(Book) and (Book.NodeType = ntBookInfo) then
        Actual.Add(Book.Title);
      Node := Tree.GetNext(Node);
    end;
    for Title in Expected do
      Wanted.Add(Title);
    Actual.Sort;
    Wanted.Sort;
    Require(Actual.Text = Wanted.Text,
      'Wrong visible books. Expected: ' + Wanted.CommaText + '; actual: ' + Actual.CommaText);
  finally
    Wanted.Free;
    Actual.Free;
  end;
end;

procedure ChangeCollection(ID: Integer);
var
  Item: TMenuItem;
begin
  for Item in frmMain.miCollSelect do
    if Item.Tag = ID then
    begin
      frmMain.miActiveCollectionClick(Item);
      Exit;
    end;
  raise Exception.Create('Fixture collection is absent from the collection menu');
end;

procedure ShowPage(Index: Integer);
begin
  frmMain.pgControl.ActivePageIndex := Index;
  frmMain.pgControlChange(nil);
end;

procedure TestLanguageIsolation;
begin
  frmMain.cbLangSelectA.ItemIndex := frmMain.cbLangSelectA.Items.IndexOf('ru');
  frmMain.cbLangSelectAChange(frmMain.cbLangSelectA);
  ShowPage(PAGE_GENRES);
  ShowPage(PAGE_AUTHORS);
  frmMain.btnSwitchTreeModeClick(nil);
  Require(frmMain.cbLangSelectA.Text = 'ru', 'Another view reset the selected author language');
  ExpectTitles(frmMain.tvBooksA, ['Alpha ru']);
  frmMain.btnSwitchTreeModeClick(nil);
  ExpectTitles(frmMain.tvBooksA, ['Alpha ru']);
  Writeln('PASS language choice survives another view first load and repeated refreshes');
end;

procedure TestAddBeforeFirstGroupVisit;
var
  Node: PVirtualNode;
  Book: PBookRecord;
begin
  Node := frmMain.tvBooksA.GetFirst;
  while Assigned(Node) do
  begin
    Book := frmMain.tvBooksA.GetNodeData(Node);
    if (Book.NodeType = ntBookInfo) and (Book.Title = 'Alpha extra uk') then
      Break;
    Node := frmMain.tvBooksA.GetNext(Node);
  end;
  Require(Assigned(Node), 'The book to add is absent');
  frmMain.tvBooksA.ClearSelection;
  frmMain.tvBooksA.Selected[Node] := True;
  frmMain.tvBooksA.FocusedNode := Node;
  frmMain.tvBooksTreeChange(frmMain.tvBooksA, Node);
  Require(frmMain.acBookAdd2Favorites.Execute, 'Add to Favorites action was disabled');
  ShowPage(PAGE_FAVORITES);
  Require(frmMain.cbLangSelectF.Text = 'ru', 'Adding a book lost the unopened group language filter');
  ExpectTitles(frmMain.tvBooksF, ['Alpha ru']);
  Writeln('PASS adding a book before first group visit preserves its language filter');
end;

procedure TestGenreLink;
var
  Book: PBookRecord;
  BookID: Integer;
  GenreCode: string;
begin
  Book := frmMain.tvBooksA.GetNodeData(frmMain.tvBooksA.FocusedNode);
  Require(Assigned(Book) and (Length(Book.Genres) = 1), 'The linked book has no genre');
  BookID := Book.BookKey.BookID;
  GenreCode := Book.Genres[0].GenreCode;
  frmMain.ipnlAuthors.OnGenreLinkClicked(frmMain.ipnlAuthors, GenreCode, Low(TSysLinkType));
  Require(frmMain.pgControl.ActivePageIndex = PAGE_GENRES, 'Genre link did not activate its page');
  ExpectTitles(frmMain.tvBooksG, ['Alpha ru']);
  Book := frmMain.tvBooksG.GetNodeData(frmMain.tvBooksG.FocusedNode);
  Require(Assigned(Book) and (Book.BookKey.BookID = BookID), 'Genre link did not retain the requested book');
  Writeln('PASS genre link restores the requested genre, language and book');
end;

procedure TestGenreOrder(const Collection: IBookCollection; UnknownBook: Integer);
var
  Node: PVirtualNode;
  Genre: PGenreData;
  Filter: TFilterValue;
begin
  Genre := frmMain.tvGenres.GetNodeData(frmMain.tvGenres.GetFirstSelected);
  Require(Assigned(Genre) and (Genre.GenreCode = '0.1'), 'First classified genre was not selected');
  Node := frmMain.tvGenres.GetFirst;
  while Assigned(frmMain.tvGenres.GetNextSibling(Node)) do
    Node := frmMain.tvGenres.GetNextSibling(Node);
  Genre := frmMain.tvGenres.GetNodeData(Node);
  Require(Assigned(Genre) and (Genre.GenreCode = UNKNOWN_GENRE_CODE), 'Unsorted is not the last tree category');
  ShowPage(PAGE_GENRES);
  ExpectTitles(frmMain.tvBooksG, ['Genre ru']);
  FillGenresTree(frmMain.tvGenres, Collection.GetGenreIterator(gmAll), False, UNKNOWN_GENRE_CODE);
  Genre := frmMain.tvGenres.GetNodeData(frmMain.tvGenres.GetFirstSelected);
  Require(Assigned(Genre) and (Genre.GenreCode = UNKNOWN_GENRE_CODE), 'Explicit Unsorted selection was lost');
  ExpectTitles(frmMain.tvBooksG, ['Unknown']);
  Filter.ValueInt := UnknownBook;
  FillGenresTree(frmMain.tvGenres, Collection.GetGenreIterator(gmByBook, @Filter));
  Genre := frmMain.tvGenres.GetNodeData(frmMain.tvGenres.GetFirstSelected);
  Require(Assigned(Genre) and (Genre.GenreCode = UNKNOWN_GENRE_CODE), 'Only-Unsorted tree has no selection');
  Writeln('PASS Unsorted is last, first genre is default, explicit selection and fallback work');
end;

procedure TestSourceGenrePreservation(const Expected: TGenreData);
var
  Node: PVirtualNode;
  Genre: PGenreData;
begin
  Node := frmMain.tvGenres.GetFirst;
  while Assigned(Node) do
  begin
    Genre := frmMain.tvGenres.GetNodeData(Node);
    if Genre.GenreCode = Expected.GenreCode then
    begin
      Require((Genre.GenreAlias = Expected.GenreAlias) and
        (Genre.ParentCode = Expected.ParentCode), 'Locale update changed imported genre metadata');
      Writeln('PASS imported source genre survives locale synchronization');
      Exit;
    end;
    Node := frmMain.tvGenres.GetNext(Node);
  end;
  raise Exception.Create('Locale synchronization removed an imported genre');
end;

var
  One, Two: IBookCollection;
  OneID, TwoID, FirstBook, LastBook, UnknownBook, I: Integer;
  Book: PBookRecord;
  ImportedGenre: TGenreData;
begin
  try
    Application.Initialize;
    InitLocalization;
    frmSplash := TfrmSplash.Create(Application);
    try
      Application.CreateForm(TDMUser, DMUser);
      DMUser.Init;
      OneID := SystemDB.CreateCollection('One', Settings.AppPath,
        'one.hlc2', CT_EXTERNAL_LOCAL_FB, Settings.AppPath + 'genres_fb2.glst');
      TwoID := SystemDB.CreateCollection('Two', Settings.AppPath,
        'two.hlc2', CT_EXTERNAL_LOCAL_FB, Settings.AppPath + 'genres_fb2.glst');
      One := SystemDB.GetCollection(OneID);
      Two := SystemDB.GetCollection(TwoID);
      FirstBook := AddBook(One, 'Alpha uk', 'Alpha', 'uk', 'Alpha series', 'prose_contemporary');
      LastBook := AddBook(One, 'Alpha ru', 'Alpha', 'ru', 'Alpha series', 'prose_contemporary');
      One.AddBookToGroup(CreateBookKey(FirstBook, OneID), FAVORITES_GROUP_ID);
      One.AddBookToGroup(CreateBookKey(LastBook, OneID), FAVORITES_GROUP_ID);
      AddBook(One, 'Alpha extra uk', 'Alpha', 'uk', '', 'prose_contemporary');
      AddBook(One, 'Genre uk', 'Beta', 'uk', '', '0.1');
      AddBook(One, 'Genre ru', 'Beta', 'ru', '', '0.1');
      AddBook(One, 'Genre deleted', 'Beta', 'ru', '', '0.1', True);
      UnknownBook := AddBook(One, 'Unknown', 'Gamma', 'ru', '', '');
      AddBook(Two, 'Other uk', 'Other', 'uk', '', '0.1');
      AddBook(Two, 'Other ru', 'Other', 'ru', '', '0.1');
      if ParamStr(1) = 'source-genres' then
      begin
        ImportedGenre := One.EnsureGenre('popadancy', 'Imported genre', 'Imported category');
        One.SetProperty(PROP_GENRE_FILE, 'genres_fb2_uk.glst');
      end;
      One.SetProperty(PROP_LAST_AUTHOR_BOOK, LastBook);
      if ParamStr(1) = 'language-isolation' then
        One.SetProperty(PROP_GENRES_LANG_FILTER, 0)
      else
        One.SetProperty(PROP_GENRES_LANG_FILTER, 2);
      One.SetProperty(PROP_SERIES_LANG_FILTER, 1);
      One.SetProperty(PROP_GROUPS_LANG_FILTER, 2);
      Two.SetProperty(PROP_GENRES_LANG_FILTER, 1);
      Settings.ActiveCollection := OneID;
      Settings.ActivePage := PAGE_AUTHORS;
      Application.CreateForm(TdmImages, dmImages);
      dmImages.ApplyThemeIcons;
      Application.CreateForm(TfrmMain, frmMain);
      Application.CreateForm(TfrmGenreTree, frmGenreTree);
      ExpectTitles(frmMain.tvBooksA, ['Alpha uk', 'Alpha ru', 'Alpha extra uk']);
      Book := frmMain.tvBooksA.GetNodeData(frmMain.tvBooksA.FocusedNode);
      Require(Assigned(Book) and (Book.BookKey.BookID = LastBook),
        'The saved author book was not restored');
      Writeln('PASS default author selection and saved book');
      if ParamStr(1) = 'language-isolation' then
        TestLanguageIsolation
      else if ParamStr(1) = 'favorites-add' then
        TestAddBeforeFirstGroupVisit
      else if ParamStr(1) = 'genre-link' then
        TestGenreLink
      else if ParamStr(1) = 'genre-order' then
        TestGenreOrder(One, UnknownBook)
      else if ParamStr(1) = 'source-genres' then
      begin
        TestSourceGenrePreservation(ImportedGenre);
        ChangeCollection(TwoID);
        ChangeCollection(OneID);
        TestSourceGenrePreservation(ImportedGenre);
      end
      else
      begin
        ChangeCollection(TwoID);
        Require(One.GetProperty(PROP_GENRES_LANG_FILTER) = 2,
          'Switching collections overwrote an unopened genre language filter');
        ChangeCollection(OneID);
        ShowPage(PAGE_GENRES);
        ExpectTitles(frmMain.tvBooksG, ['Genre ru']);
        Require(frmMain.cbLangSelectG.Text = 'ru', 'Saved genre language was not restored');
        Writeln('PASS unopened genre filter survives collection switches');
        ShowPage(PAGE_SERIES);
        ExpectTitles(frmMain.tvBooksS, ['Alpha uk']);
        Require(frmMain.cbLangSelectS.Text = 'uk', 'Saved series language was not restored');
        Writeln('PASS first series visit restores its language filter');
        ShowPage(PAGE_AUTHORS);
        frmMain.HideDeletedBooksExecute(nil);
        ShowPage(PAGE_GENRES);
        ExpectTitles(frmMain.tvBooksG, ['Genre ru', 'Genre deleted']);
        Writeln('PASS changed deletion filter refreshes previously visited views');
        ChangeCollection(TwoID);
        ExpectTitles(frmMain.tvBooksG, ['Other uk']);
        ChangeCollection(OneID);
        ExpectTitles(frmMain.tvBooksG, ['Genre ru', 'Genre deleted']);
        Writeln('PASS visible genre view refreshes across collections');
        ShowPage(PAGE_FAVORITES);
        ExpectTitles(frmMain.tvBooksF, ['Alpha ru']);
        Require(frmMain.cbLangSelectF.Text = 'ru', 'Saved group language was not restored');
        Writeln('PASS first group visit restores its language filter');
        ShowPage(PAGE_AUTHORS);
        for I := 0 to frmMain.tbarAuthorsEng.ButtonCount - 1 do
          if frmMain.tbarAuthorsEng.Buttons[I].Caption = 'Z' then
            frmMain.tbarAuthorsEng.Buttons[I].OnClick(frmMain.tbarAuthorsEng.Buttons[I]);
        ExpectTitles(frmMain.tvBooksA, []);
        frmMain.HideDeletedBooksExecute(nil);
        ExpectTitles(frmMain.tvBooksA, []);
        Writeln('PASS empty author selection stays empty after a global refresh');
      end;
      frmGenreTree.Free;
      frmGenreTree := nil;
      frmMain.Free;
      frmMain := nil;
      One := nil;
      Two := nil;
      dmImages.Free;
      dmImages := nil;
      DMUser.Free;
      DMUser := nil;
    finally
      frmSplash.Free;
      frmSplash := nil;
    end;
  except
    on E: Exception do
    begin
      Writeln('FAIL ', E.ClassName, ': ', E.Message);
      Halt(1);
    end;
  end;
end.
