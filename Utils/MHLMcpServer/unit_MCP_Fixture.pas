unit unit_MCP_Fixture;

interface

// Builds a small throwaway collection so the protocol suite in tests/cases
// stops depending on whatever library the machine happens to have.
//
// This mode contains NO path logic of its own. It is invoked as
//
//   MHLMcpServer.exe --make-fixture uselocaldata user mcpfixture
//
// and the server under test is later started as
//
//   MHLMcpServer.exe uselocaldata user mcpfixture
//
// TMHLSettings.Create scans the raw command line in BOTH processes
// (unit_Settings.pas:513-534), so both compute the same
// <exedir>\Data\mcpfixture.dbs. The fixture is therefore created exactly
// where the server under test will look for it, by construction rather than
// by agreement.
//
// mcpfixture.dbs / mcpfixture.ini do not collide with the real user.dbs2 /
// myhomelib2.ini in the same folder, so a developer's dev library in
// Program\OUT\Bin64 survives a test run untouched.
//
// Unlike --extract and --cache-selftest, this mode needs DMUser and so runs
// AFTER Application.Initialize. See the dispatch in MHLMcpServer.dpr.
procedure RunMakeFixtureMode;

const
  // The `user <name>` switch value the harness passes. Named here so the
  // README, the tests and this unit cannot drift apart.
  FIXTURE_USER_NAME = 'mcpfixture';

  FIXTURE_DISPLAY_NAME = 'MCP Fixture';

  // Book folder inside the collection root. The trailing separator is NOT
  // cosmetic: TBookRecord.GetBookFormat (unit_Globals.pas:993) only classifies
  // a row as bfFb2 when the container path is empty or ends in a separator.
  // Without it every fixture book degrades to bfRaw and the text tools refuse
  // it.
  FIXTURE_FOLDER = 'books\';

implementation

uses
  System.SysUtils,
  System.IOUtils,
  System.JSON,
  System.DateUtils,
  dm_user,
  unit_Settings,
  unit_Globals,
  unit_Consts,
  unit_Interfaces,
  unit_MCP_Transport;

// A private, local, FB2 collection. CONTENT_FB, LIBRARY_PRIVATE and
// LOCATION_LOCAL are all $00000000 (unit_Consts.pas:240-252), so the code is
// simply 0 -- spelled out rather than hard-coded so the intent survives.
const
  FIXTURE_COLLECTION_TYPE = CONTENT_FB or LIBRARY_PRIVATE or LOCATION_LOCAL;

// Minimal but valid FB2. Written as UTF-8 without a BOM, matching what
// unit_MCP_Fb2Extract already handles for tests/fixtures/structured.fb2.
// Sections is the list of section titles; an empty list produces a single
// untitled section (the "flat" shape).
function WriteFixtureBook(
  const Folder: string;
  const BaseName: string;
  const BookTitle: string;
  const Sections: TArray<string>
): Integer;
var
  Body: string;
  Text: string;
  I: Integer;
  FullPath: string;
  Bytes: TBytes;
begin
  Body := '';
  if Length(Sections) = 0 then
    Body := '<section><p>Текст без розділів.</p></section>'
  else
    for I := 0 to High(Sections) do
      Body := Body +
        '<section><title><p>' + Sections[I] + '</p></title>' +
        '<p>Абзац розділу ' + IntToStr(I + 1) + '.</p></section>';

  Text :=
    '<?xml version="1.0" encoding="utf-8"?>' + sLineBreak +
    '<FictionBook xmlns="http://www.gribuser.ru/xml/fictionbook/2.0">' + sLineBreak +
    ' <description><title-info><book-title>' + BookTitle +
    '</book-title></title-info></description>' + sLineBreak +
    ' <body>' + Body + '</body>' + sLineBreak +
    '</FictionBook>' + sLineBreak;

  FullPath := TPath.Combine(Folder, BaseName + '.fb2');
  Bytes := TEncoding.UTF8.GetBytes(Text);
  TFile.WriteAllBytes(FullPath, Bytes);
  Result := Length(Bytes);
end;

// One fixture book: writes the FB2 body, then inserts the matching row.
// Writing both from one routine is the point -- the on-disk bytes and the
// BookSize column cannot drift apart.
//
// Genres are given by FB2 code, not by internal code: InsertBook maps
// FB2GenreCode through the collection's genre cache
// (unit_Database_SQLite.pas:1694), so the fixture never has to know the
// numeric codes in genres_fb2.glst.
function AddFixtureBook(
  const Collection: IBookCollection;
  const Root: string;
  const BaseName: string;
  const BookTitle: string;
  const LastName, FirstName: string;
  const Series: string;
  SeqNumber: Integer;
  const FB2Genre: string;
  const Lang: string;
  LibRate: Integer;
  IsDeleted: Boolean;
  const Sections: TArray<string>
): Integer;
var
  Book: TBookRecord;
  BooksDir: string;
begin
  BooksDir := TPath.Combine(Root, ExcludeTrailingPathDelimiter(FIXTURE_FOLDER));
  TDirectory.CreateDirectory(BooksDir);

  Book.Clear;
  Book.Title := BookTitle;
  Book.Folder := FIXTURE_FOLDER;
  Book.FileName := BaseName;
  Book.FileExt := FB2_EXTENSION;
  Book.Series := Series;
  Book.SeqNumber := SeqNumber;
  Book.Lang := Lang;
  Book.LibRate := LibRate;
  Book.LibID := BaseName;
  Book.Date := EncodeDate(2026, 1, 1);
  Book.CollectionRoot := Root;

  SetLength(Book.Authors, 1);
  Book.Authors[0].LastName := LastName;
  Book.Authors[0].FirstName := FirstName;
  Book.Authors[0].MiddleName := '';

  SetLength(Book.Genres, 1);
  Book.Genres[0].FB2GenreCode := FB2Genre;

  Include(Book.BookProps, bpIsLocal);
  if IsDeleted then
    Include(Book.BookProps, bpIsDeleted);

  Book.Size := WriteFixtureBook(BooksDir, BaseName, BookTitle, Sections);

  // CheckFileName/FullCheck are False: every base name below is distinct by
  // construction, and the duplicate scan is a per-insert table walk this
  // fixture has no use for.
  Result := Collection.InsertBook(Book, False, False);
end;

procedure RunMakeFixtureMode;
var
  DbFileName: string;
  RootFolder: string;
  CollectionFile: string;
  CollectionID: Integer;
  Summary: TJSONObject;
  Transport: TMcpTransport;
  Collection: IBookCollection;
  Books: TJSONArray;
  Entry: TJSONObject;
  I: Integer;
  Ids: TArray<Integer>;
  Titles: TArray<string>;
begin
  if not Assigned(DMUser) then
    DMUser := TDMUser.Create(nil);

  DbFileName := DMUser.Settings.SystemFileName[sfSystemDB];
  RootFolder := TPath.Combine(ExtractFilePath(ParamStr(0)), FIXTURE_USER_NAME);
  CollectionFile := TPath.Combine(RootFolder, FIXTURE_USER_NAME + '.hlc2');

  // Wipe first. This is what makes the ids deterministic: a fresh system
  // database always hands the first registered collection id 1, and a fresh
  // collection always numbers books from 1 in insertion order. Every
  // expectation in tests/cases depends on that.
  if TFile.Exists(DbFileName) then
    TFile.Delete(DbFileName);
  if TDirectory.Exists(RootFolder) then
    TDirectory.Delete(RootFolder, True);
  TDirectory.CreateDirectory(RootFolder);

  // With the system database file absent, Init takes its create-if-missing
  // branch (TSystemData_SQLite.CreateSystemTables) -- the one branch
  // EnsureLibraryInitialized deliberately refuses to reach in server mode.
  // Here it is exactly what is wanted.
  DMUser.Init;

  CollectionID := SystemDB.CreateCollection(
    FIXTURE_DISPLAY_NAME,
    RootFolder,
    CollectionFile,
    FIXTURE_COLLECTION_TYPE,
    DMUser.Settings.SystemFileName[sfGenresFB2]
  );

  if CollectionID <> 1 then
    raise Exception.CreateFmt(
      'Fixture collection was registered as id %d, expected 1. ' +
      'The previous system database at %s was not removed.',
      [CollectionID, DbFileName]);

  Collection := SystemDB.GetCollection(CollectionID);

  SetLength(Ids, 6);
  SetLength(Titles, 6);

  Titles[0] := 'Тихий вечер';
  Ids[0] := AddFixtureBook(Collection, RootFolder, 'book1', Titles[0],
    'Іваненко', 'Петро', 'Хроніки', 1, 'prose_contemporary', 'uk', 0, False,
    ['Розділ перший', 'Розділ другий']);

  Titles[1] := 'Гроза 100% певна';
  Ids[1] := AddFixtureBook(Collection, RootFolder, 'book2', Titles[1],
    'Іваненко', 'Петро', 'Хроніки', 2, 'prose_contemporary', 'uk', 4, False,
    ['Вступ', 'Середина', 'Кінець']);

  Titles[2] := 'Пісня_про_море';
  Ids[2] := AddFixtureBook(Collection, RootFolder, 'book3', Titles[2],
    'Ковальчук', 'Ольга', '', 0, 'sf_action', 'uk', 0, False, []);

  Titles[3] := 'О''Генрі та інші';
  Ids[3] := AddFixtureBook(Collection, RootFolder, 'book4', Titles[3],
    'Ковальчук', 'Ольга', 'Збірка "Класика"', 1, 'love_history', 'ru', 5, False, []);

  Titles[4] := 'Книга з "лапками"';
  Ids[4] := AddFixtureBook(Collection, RootFolder, 'book5', Titles[4],
    'Шевченко', 'Іван', '', 0, 'sf_action', 'en', 0, False, []);

  Titles[5] := 'Вилучена книга';
  Ids[5] := AddFixtureBook(Collection, RootFolder, 'book6', Titles[5],
    'Шевченко', 'Іван', '', 0, 'prose_contemporary', 'uk', 0, True, []);

  Summary := TJSONObject.Create;
  try
    Summary.AddPair('collection_id', TJSONNumber.Create(CollectionID));
    Summary.AddPair('root', RootFolder);
    Summary.AddPair('db', DbFileName);

    Books := TJSONArray.Create;
    for I := 0 to 5 do
    begin
      if Ids[I] <> I + 1 then
        raise Exception.CreateFmt(
          'Fixture book %d was inserted as id %d; expected %d. ' +
          'The collection file was not removed before this run.',
          [I + 1, Ids[I], I + 1]);

      Entry := TJSONObject.Create;
      Entry.AddPair('book_id', TJSONNumber.Create(Ids[I]));
      Entry.AddPair('title', Titles[I]);
      Entry.AddPair('path', TPath.Combine(
        TPath.Combine(RootFolder, ExcludeTrailingPathDelimiter(FIXTURE_FOLDER)),
        'book' + IntToStr(I + 1) + '.fb2'));
      Books.AddElement(Entry);
    end;
    Summary.AddPair('books', Books);

    Transport := TMcpTransport.Create;
    try
      Transport.WriteMessage(Summary.ToJSON);
    finally
      Transport.Free;
    end;
  finally
    Summary.Free;
  end;
end;

end.
