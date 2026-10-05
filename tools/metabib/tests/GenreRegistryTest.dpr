program GenreRegistryTest;

{$APPTYPE CONSOLE}
{$R '..\..\..\Utils\MHLMcpServer\MHLMcpServer_SQL.res'}

// Isolated DAO contract tests. No DMUser bootstrap and no live-profile access.
// A fresh GUID directory holds the real SQLite system/collection databases.
uses
  System.SysUtils,
  System.IOUtils,
  System.Variants,
  SQLiteWrap,
  unit_Consts,
  unit_Globals,
  unit_Interfaces,
  unit_Database_SQLite,
  unit_SystemDatabase_SQLite;

procedure Require(const Condition: Boolean; const Message: string);
begin
  if not Condition then
    raise Exception.Create(Message);
end;

procedure RequireSame(const Actual, Expected: TGenreData; const Message: string);
begin
  Require((Actual.GenreCode = Expected.GenreCode) and
    (Actual.ParentCode = Expected.ParentCode) and
    (Actual.FB2GenreCode = Expected.FB2GenreCode) and
    (Actual.GenreAlias = Expected.GenreAlias), Message);
end;

function FindGenre(const Collection: IBookCollection; const Code: string): TGenreData;
var
  Iterator: IGenreIterator;
  Genre: TGenreData;
begin
  Iterator := Collection.GetGenreIterator(gmAll);
  while Iterator.Next(Genre) do
    if Genre.GenreCode = Code then
      Exit(Genre);
  raise Exception.Create('Missing genre ' + Code);
end;

function AddBook(const Collection: IBookCollection; const Name, FB2Code: string): Integer;
var
  Book: TBookRecord;
begin
  Book.Clear;
  Book.Title := Name;
  Book.FileName := Name;
  Book.FileExt := '.fb2';
  Book.LibID := Name;
  Book.Date := EncodeDate(2026, 1, 1);
  TAuthorsHelper.Add(Book.Authors, 'Fixture', 'Author', '');
  TGenresHelper.Add(Book.Genres, '', '', FB2Code);
  Result := Collection.InsertBook(Book, False, False);
  Require(Result > 0, 'Book insertion failed');
end;

procedure ExpectBookGenre(const Collection: IBookCollection; BookID: Integer;
  const Expected: TGenreData);
var
  Filter: TFilterValue;
  Iterator: IGenreIterator;
  Genre: TGenreData;
begin
  Filter.ValueInt := BookID;
  Iterator := Collection.GetGenreIterator(gmByBook, @Filter);
  Require(Iterator.Next(Genre), 'Book lost its genre');
  RequireSame(Genre, Expected, 'InsertBook did not map the registered FB2 code');
  Require(not Iterator.Next(Genre), 'Book has unexpected genre links');
end;

procedure RunTests(const Folder: string);
var
  SystemData: ISystemData;
  Collection: IBookCollection;
  DB: TSQLiteDatabase;
  DBName, GenreFile: string;
  Known, Added, Second, Fallback, Again, Unsorted, RolledBack: TGenreData;
  Root: TGenreData;
  ExistingBook, SourceBook, I: Integer;
  BeforeCount: Int64;
  Iterator: IGenreIterator;
  Genre, Last: TGenreData;
  Failed: Boolean;
  Info: TCollectionInfo;
begin
  GenreFile := TPath.Combine(Folder, 'fixture.glst');
  TFile.WriteAllText(GenreFile,
    '0.0 ;Unsorted' + sLineBreak +
    '0.1 Фантастика' + sLineBreak +
    '0.1.2 sf;Наукова фантастика' + sLineBreak +
    '0.1.99 occupied;Existing high child' + sLineBreak +
    '0.50 Existing high root' + sLineBreak, TEncoding.UTF8);
  DBName := TPath.Combine(Folder, 'collection.hlc2');
  TSystemData_SQLite.CreateSystemTables(TPath.Combine(Folder, 'system.dbs2'));
  SystemData := TSystemData_SQLite.Create(TPath.Combine(Folder, 'system.dbs2'));
  TBookCollection_SQLite.CreateCollection(SystemData, DBName, CT_PRIVATE_FB, GenreFile);
  DB := TSQLiteDatabase.Create(DBName);
  try
    Info.Clear;
    Info.ID := 1;
    Info.DBFileName := DBName;
    Collection := TBookCollection_SQLite.Create(Info, SystemData);
    Known := FindGenre(Collection, '0.1.2');
    Unsorted := FindGenre(Collection, '0.0');
    ExistingBook := AddBook(Collection, 'Existing book', 'sf');
    BeforeCount := DB.QuerySingleInt('SELECT COUNT(*) FROM Genres');
    Again := Collection.EnsureGenre('sf', 'Do not overwrite', 'Different category');
    RequireSame(Again, Known, 'Known genre ID or alias changed');
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres') = BeforeCount,
      'Known genre created a category');
    Require(VarIsEmpty(Collection.GetProperty(PROP_SOURCE_GENRES)),
      'Known genre incorrectly marked source extensions');

    Collection.BeginBulkOperation;
    Collection.EnsureGenre('first_rollback', 'First rollback', 'First rollback category');
    Collection.EndBulkOperation(False);
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres') = BeforeCount,
      'First registration rollback retained genre rows');
    Require(VarIsEmpty(Collection.GetProperty(PROP_SOURCE_GENRES)),
      'First registration rollback retained provenance');

    // RAISE(ROLLBACK) removes the outer transaction and its savepoints.
    // Registry cleanup must preserve this error and remove all pending cache data.
    DB.ExecSQL('CREATE TRIGGER reject_outer_genre BEFORE INSERT ON Genres ' +
      'WHEN NEW.FB2Code = ''outer_rejected'' ' +
      'BEGIN SELECT RAISE(ROLLBACK, ''fixture outer rollback''); END');
    Collection.BeginBulkOperation;
    Require(Collection.InBulkOperation, 'Bulk transaction was not reported active');
    RolledBack := Collection.EnsureGenre('outer_pending', 'Pending leaf', 'Pending category');
    Require(Boolean(Collection.GetProperty(PROP_SOURCE_GENRES)), 'Pending provenance was not set');
    Failed := False;
    try
      Collection.EnsureGenre('outer_rejected', 'Rejected leaf', 'Rejected outer category');
    except
      on E: ESQLiteException do
      begin
        Failed := True;
        Require(Pos('fixture outer rollback', E.Message) > 0,
          'Savepoint cleanup replaced the original trigger exception');
      end;
    end;
    Require(Failed, 'Fixture did not roll back the outer transaction');
    Require(not Collection.InBulkOperation, 'Lost outer transaction was still reported active');
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres') = BeforeCount,
      'Outer rollback retained genre rows');
    Require(VarIsEmpty(Collection.GetProperty(PROP_SOURCE_GENRES)),
      'Outer rollback retained provenance');
    Require(Collection.GetTopGenreAlias('outer_pending') = '',
      'Outer rollback retained a previously successful pending leaf in the cache');
    Require(Collection.GetTopGenreAlias('outer_rejected') = '',
      'Outer rollback retained the rejected leaf in the cache');
    RequireSame(Collection.EnsureGenre('sf', 'Do not overwrite', ''), Known,
      'Outer rollback lost the existing standard genre cache');
    ExpectBookGenre(Collection, ExistingBook, Known);
    DB.ExecSQL('DROP TRIGGER reject_outer_genre');
    Collection.BeginBulkOperation;
    Again := Collection.EnsureGenre('outer_pending', 'New pending description', 'Pending category');
    Require((Again.GenreCode = RolledBack.GenreCode) and
      (Again.GenreAlias = 'New pending description'),
      'Outer rollback poisoned numeric allocation or returned a ghost leaf');
    Require(not VarIsEmpty(Collection.GetProperty(PROP_SOURCE_GENRES)),
      'Outer rollback left stale provenance state that skipped registration');
    Require(Boolean(Collection.GetProperty(PROP_SOURCE_GENRES)),
      'Re-registration after outer rollback did not mark provenance');
    Collection.EndBulkOperation(False);
    Require(not Collection.InBulkOperation, 'Completed rollback was reported active');
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres') = BeforeCount,
      'Recovery check retained genre rows');
    Require(VarIsEmpty(Collection.GetProperty(PROP_SOURCE_GENRES)),
      'Recovery check retained provenance');

    Collection.SetProperty(PROP_SOURCE_LIBRARY, 'Flibusta');
    Require(string(Collection.GetProperty(PROP_SOURCE_LIBRARY)) = 'Flibusta',
      'Source-library property did not round-trip');

    Added := Collection.EnsureGenre('popadancy', 'Попаданці', 'Фантастика');
    Require(Added.ParentCode = '0.1', 'Exact existing category was not reused');
    Require(Added.GenreCode = '0.1.100', 'Existing numeric leaf collision was not avoided');
    Require(Added.GenreAlias = 'Попаданці', 'Source description was not retained');
    Require(Boolean(Collection.GetProperty(PROP_SOURCE_GENRES)), 'Missing provenance flag');
    // Any later registration must not rewrite the already-true property.
    DB.ExecSQL('CREATE TRIGGER preserve_source_marker BEFORE DELETE ON Settings ' +
      'WHEN OLD.SettingID = ' + IntToStr(PROP_SOURCE_GENRES) +
      ' BEGIN SELECT RAISE(ABORT, ''source marker was rewritten''); END');
    BeforeCount := DB.QuerySingleInt('SELECT COUNT(*) FROM Genres');
    for I := 1 to 1000 do
    begin
      Again := Collection.EnsureGenre('popadancy', 'Changed description', 'Changed category');
      RequireSame(Again, Added, 'Repeated registration changed the leaf');
    end;
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres') = BeforeCount,
      'Repeated registration duplicated a genre');
    ExpectBookGenre(Collection, ExistingBook, Known);
    SourceBook := AddBook(Collection, 'Source book', 'popadancy');
    ExpectBookGenre(Collection, SourceBook, Added);
    Require(Collection.GetTopGenreAlias('popadancy') = 'Фантастика', 'Root traversal failed');

    Second := Collection.EnsureGenre('dark_fantasy', 'Темне фентезі', 'Source-only category');
    Root := FindGenre(Collection, Second.ParentCode);
    Require((Root.ParentCode = '0') and (Root.GenreCode = '0.51') and
      (Root.GenreAlias = 'Source-only category') and (Root.FB2GenreCode = ''),
      'New category is not a unique numeric root with its exact source name');
    Again := Collection.EnsureGenre('det_lady', 'Жіночий детектив', 'Source-only category');
    Require(Again.ParentCode = Second.ParentCode, 'Same category created multiple roots');
    Fallback := Collection.EnsureGenre('without_description', '', '');
    Require(Fallback.GenreAlias = 'without_description', 'Empty description lost code fallback');
    Require(Collection.GetTopGenreAlias('without_description') = 'Жанри каталогу',
      'Missing category lost Ukrainian fallback');
    Again := Collection.EnsureGenre('', 'No code', 'Should not exist');
    Require(Again.GenreCode = UNKNOWN_GENRE_CODE, 'Empty code created a leaf');
    I := AddBook(Collection, 'Unknown book', 'fb2-only-junk');
    ExpectBookGenre(Collection, I, Unsorted);
    Require(Collection.GetTopGenreAlias('fb2-only-junk') = '', 'Unknown-code fallback changed');

    Collection.BeginBulkOperation;
    RolledBack := Collection.EnsureGenre('rolled_back', 'Rollback leaf', 'Rollback category');
    Collection.EndBulkOperation(False);
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres WHERE FB2Code = ?',
      ['rolled_back']) = 0, 'Rollback retained the leaf');
    Again := Collection.EnsureGenre('rolled_back', 'Rollback leaf', 'Rollback category');
    RequireSame(Again, RolledBack, 'Rollback left stale registration or numeric counters');
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres WHERE FB2Code = ?',
      ['rolled_back']) = 1, 'Rollback cache returned a non-persisted genre');

    BeforeCount := DB.QuerySingleInt('SELECT COUNT(*) FROM Genres');
    DB.ExecSQL('CREATE TRIGGER reject_genre BEFORE INSERT ON Genres ' +
      'WHEN NEW.FB2Code = ''rejected'' BEGIN SELECT RAISE(ABORT, ''fixture failure''); END');
    Failed := False;
    try
      Collection.EnsureGenre('rejected', 'Rejected leaf', 'Rejected category');
    except
      on E: ESQLiteException do
        Failed := True;
    end;
    Require(Failed, 'Fixture did not reject insertion');
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres') = BeforeCount,
      'Failed leaf registration left an orphan category');
    DB.ExecSQL('DROP TRIGGER reject_genre');
    Again := Collection.EnsureGenre('rejected', 'Accepted leaf', 'Rejected category');
    Require(Again.GenreAlias = 'Accepted leaf', 'Failed registration poisoned the cache');

    Collection := nil;
    Collection := TBookCollection_SQLite.Create(Info, SystemData);
    BeforeCount := DB.QuerySingleInt('SELECT COUNT(*) FROM Genres');
    Again := Collection.EnsureGenre('popadancy', 'Reopen overwrite', 'Reopen category');
    RequireSame(Again, Added, 'Reopening changed or duplicated the source leaf');
    RequireSame(Collection.EnsureGenre('sf', 'Reopen overwrite', ''), Known,
      'Reopening changed an existing standard genre');
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres') = BeforeCount,
      'Reopening failed idempotency');
    Require(Boolean(Collection.GetProperty(PROP_SOURCE_GENRES)), 'Reopening lost provenance');
    Require(string(Collection.GetProperty(PROP_SOURCE_LIBRARY)) = 'Flibusta',
      'Reopening lost source-library provenance');
    ExpectBookGenre(Collection, ExistingBook, Known);
    ExpectBookGenre(Collection, SourceBook, Added);
    Require(Collection.GetTopGenreAlias('dark_fantasy') = 'Source-only category',
      'Reopening lost source category traversal');
    Iterator := Collection.GetGenreIterator(gmAll);
    while Iterator.Next(Genre) do
      Last := Genre;
    Iterator := nil;
    Require(Last.GenreCode = UNKNOWN_GENRE_CODE, 'Unsorted is no longer last');
    Require(DB.QuerySingleString('SELECT Title FROM Books WHERE BookID = ?',
      [ExistingBook]) = 'Existing book', 'Registration changed book metadata');
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Books') = 3, 'Registration changed book rows');
    Require(Collection.CheckDatabase = 'ok', 'SQLite integrity check failed');
    Again := Collection.EnsureGenre('reopened_new', 'New after reopening', 'Source-only category');
    Require(Again.ParentCode = Second.ParentCode, 'Reopening duplicated an existing category root');
    DB.ExecSQL('DROP TRIGGER preserve_source_marker');

    // Explicit reload must clear every lookup index, not only internal IDs.
    Collection.ReloadGenres(GenreFile);
    Again := Collection.EnsureGenre('popadancy', 'Fresh description', 'Fresh category');
    Require(Again.GenreAlias = 'Fresh description', 'Reload retained stale FB2 lookup');
    Require(Collection.GetTopGenreAlias('popadancy') = 'Fresh category',
      'Reload retained stale category lookup');
    Require(DB.QuerySingleInt('SELECT COUNT(*) FROM Genres WHERE FB2Code = ?',
      ['popadancy']) = 1, 'Reload lookup returned a non-persisted leaf');
    Collection := nil;
  finally
    Collection := nil;
    DB.Free;
    SystemData := nil;
  end;
end;

var
  Folder: string;
  ID: TGUID;
begin
  try
    CreateGUID(ID);
    Folder := TPath.Combine(TPath.GetTempPath, 'mhl-genre-registry-' + GUIDToString(ID));
    TDirectory.CreateDirectory(Folder);
    try
      RunTests(Folder);
    finally
      TDirectory.Delete(Folder, True);
    end;
    Writeln('PASS registry preservation, registration, mapping, idempotence, rollback, reopen and reload');
  except
    on E: Exception do
    begin
      Writeln(E.ClassName + ': ' + E.Message);
      ExitCode := 1;
    end;
  end;
end.
