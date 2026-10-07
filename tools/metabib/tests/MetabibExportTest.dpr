program MetabibExportTest;

{$APPTYPE CONSOLE}
{$R '..\..\..\Program\MyhomeLib.dres'}

uses
  System.SysUtils, System.Classes, System.IOUtils, System.DateUtils,
  System.JSON, Vcl.Forms,
  dm_user, unit_Settings, unit_Consts, unit_Globals, unit_Interfaces,
  unit_MetabibReader, unit_MetabibWriter, unit_ImportMetabibThread,
  unit_ExportMetabibThread, unit_MHLArchiveHelpers;

procedure Require(Condition: Boolean; const Message: string);
begin
  if not Condition then
    raise Exception.Create(Message);
end;

procedure RunImport(ID: Integer; const FileName: string);
var
  Worker: TImportMetabibThread;
begin
  Worker := TImportMetabibThread.Create(ID, FileName, gtFb2);
  try
    Worker.Start;
    Worker.WaitFor;
    if Assigned(Worker.FatalException) then
      raise Exception.Create(Exception(Worker.FatalException).Message);
  finally
    Worker.Free;
  end;
end;

function NewCollection(const Name: string): Integer;
var
  Root: string;
begin
  Root := IncludeTrailingPathDelimiter(Settings.AppPath + Name);
  ForceDirectories(Root);
  Result := SystemDB.CreateCollection(Name, Root, Name + '.hlc2',
    CT_EXTERNAL_LOCAL_FB, Settings.AppPath + 'genres_fb2.glst');
end;

function ReadOne(const FileName: string): TMetabibBook;
var
  Reader: TMetabibReader;
begin
  Reader := TMetabibReader.Create(FileName);
  try
    Require(Reader.RecordCount = 1, 'Wrong record count');
    Require(Reader.ReadNext(Result) = mrOk, 'Record could not be read');
  finally
    Reader.Free;
  end;
end;

procedure TestMetadata;
var
  R, Imported: TBookRecord;
  MB: TMetabibBook;
  Location: TMetabibExportLocation;
  Genres: TArray<TMetabibGenre>;
  Archives: TArray<TMetabibExportArchive>;
  Spool, Output: TFileStream;
  FileName: string;
  Collection: IBookCollection;
  ID: Integer;
  Iterator: IBookIterator;
begin
  R.Clear;
  R.Title := 'Назва "книги"';
  R.Annotation := 'Перший рядок' + #10 + 'Другий рядок з "лапками"';
  R.Translators := 'Іваненко Іван, Петренко Олена';
  R.Publisher := 'Видавництво';
  R.City := 'Київ';
  R.PubYear := 2005;
  R.ISBN := '978-0-123-45678-9';
  R.Series := 'Серія';
  R.SeqNumber := 12;
  R.Lang := 'uk';
  R.KeyWords := 'книга, проба';
  R.LibID := 'source-42';
  R.LibRate := 4;
  R.Date := EncodeDate(2020, 5, 6);
  Include(R.BookProps, bpIsDeleted);
  TAuthorsHelper.Add(R.Authors, 'Перший', 'Автор', '');
  TAuthorsHelper.Add(R.Authors, 'Другий', 'Автор', '');
  SetLength(Genres, 1);
  Genres[0].Code := 'custom';
  Genres[0].Description := 'Жанр';
  Genres[0].Category := 'Категорія';
  SetLength(Archives, 1);
  Archives[0].ID := 'arc1';
  Archives[0].Name := 'books-000001.zip';
  Archives[0].Ordinal := 0;
  Archives[0].Entries := 1;
  Archives[0].FB2Entries := 1;
  Location.ArchiveID := 'arc1';
  Location.EntryName := '1.fb2';
  Location.EntryIndex := 0;
  Location.ExportBookID := 1;
  Location.UncompressedSize := 123;
  FileName := Settings.AppPath + 'metadata.jsonl';
  Spool := TFileStream.Create(Settings.AppPath + 'records.tmp', fmCreate);
  try
    TMetabibWriter.WriteRecord(Spool, R, Genres, Location, 'derived-test', 'source-collection');
    Output := TFileStream.Create(FileName, fmCreate);
    try
      TMetabibWriter.WriteDataset(Output, Spool, 'dataset-test', 'derived-test',
        'test-version', EncodeDate(2026, 10, 7), 1, Archives);
    finally
      Output.Free;
    end;
  finally
    Spool.Free;
  end;
  MB := ReadOne(FileName);
  Require(MB.Title = R.Title, 'Title changed');
  Require(MB.Annotation = R.Annotation, 'Annotation changed');
  Require((Length(MB.Authors) = 2) and (MB.Authors[1].LastName = 'Другий'), 'Authors changed');
  Require((Length(MB.Genres) = 1) and (MB.Genres[0].Category = 'Категорія'), 'Genre category lost');
  Require((MB.SeriesName = R.Series) and (MB.SeriesNo = 12), 'Series changed');
  Require((MB.BookID = 1) and (MB.EntryIndex = 0) and (MB.EntryName = '1.fb2'), 'Output identity changed');
  Require(MB.Deleted and (MB.RatingAvg = 4), 'Catalog flags changed');
  ID := NewCollection('metadata-import');
  RunImport(ID, FileName);
  SystemDB.ClearCollectionCache;
  Collection := SystemDB.GetCollection(ID);
  Iterator := Collection.GetBookIterator(bmAll, True);
  Require(Iterator.Next(Imported), 'Imported book missing');
  Require(Imported.Translators = R.Translators, 'Translator display text lost');
  Require((Imported.Publisher = R.Publisher) and (Imported.City = R.City) and
    (Imported.PubYear = 2005) and (Imported.ISBN = R.ISBN), 'Publication metadata lost');
  Require(Imported.Annotation = R.Annotation, 'Imported annotation changed');
  Require(Imported.LibID = '1', 'Source identity overrode derived book ID');
  Iterator := nil;
  Collection := nil;
  Writeln('PASS metadata_roundtrip');
end;

procedure TestStoredLiteralText;
var
  R, Imported: TBookRecord;
  Location: TMetabibExportLocation;
  Archives: TArray<TMetabibExportArchive>;
  Genres: TArray<TMetabibGenre>;
  Spool, Output: TFileStream;
  FileName: string;
  ID: Integer;
  Collection: IBookCollection;
  Iterator: IBookIterator;
begin
  R.Clear;
  R.Title := 'Stored text';
  R.Annotation := '…!?';
  R.Publisher := '???';
  R.City := '—';
  R.Series := '…';
  R.SeqNumber := 12;
  R.LibID := 'literal-source';
  TAuthorsHelper.Add(R.Authors, 'Literal &amp; Author', 'A &lt; B', '');
  SetLength(Archives, 1);
  Archives[0].ID := 'arc1';
  Archives[0].Name := 'books.zip';
  Archives[0].Entries := 1;
  Archives[0].FB2Entries := 1;
  Location.ArchiveID := 'arc1';
  Location.EntryName := '1.fb2';
  Location.EntryIndex := 0;
  Location.ExportBookID := 1;
  Location.UncompressedSize := 0;
  FileName := Settings.AppPath + 'literal-text.jsonl';
  Spool := TFileStream.Create(Settings.AppPath + 'literal-records.tmp', fmCreate);
  try
    TMetabibWriter.WriteRecord(Spool, R, Genres, Location, 'literal-test', 'source');
    Output := TFileStream.Create(FileName, fmCreate);
    try
      TMetabibWriter.WriteDataset(Output, Spool, 'literal-test', 'literal-test',
        'test', EncodeDate(2026, 10, 7), 1, Archives);
    finally
      Output.Free;
    end;
  finally
    Spool.Free;
  end;
  ID := NewCollection('literal-import');
  RunImport(ID, FileName);
  Collection := SystemDB.GetCollection(ID);
  Iterator := Collection.GetBookIterator(bmAll, True);
  Require(Iterator.Next(Imported), 'Stored-text import lost its book');
  Require(Imported.Annotation = '…!?', 'Punctuation-only snapshot annotation was lost');
  Require((Length(Imported.Authors) = 1) and
    (Imported.Authors[0].LastName = 'Literal &amp; Author') and
    (Imported.Authors[0].FirstName = 'A &lt; B'), 'Snapshot author entity text was decoded twice');
  Require((Imported.Publisher = '???') and (Imported.City = '—') and
    (Imported.Series = '…') and (Imported.SeqNumber = 12), 'Stored snapshot text was discarded');
  Writeln('PASS snapshot_literal_text_roundtrip');
end;

procedure TestTranslatorPrecedence;
const
  DisplayClaim = '{"observation":"db","value":"Іван, Олена","raw":{"format":"myhomelib.translators-display/1"}}';
  PersonClaim = '{"observation":"fb2","value":[{"last_name":"Structured","first_name":"Translator"}]}';
var
  FileName, Payload: string;
  ID, CaseNo: Integer;
  Collection: IBookCollection;
  Iterator: IBookIterator;
  Imported: TBookRecord;
begin
  for CaseNo := 0 to 3 do
  begin
    case CaseNo of
      0: Payload := DisplayClaim + ',' + PersonClaim;
      1: Payload := '{"observation":"db","value":[{"last_name":"Structured","first_name":"Translator"}]},' +
        '{"observation":"fb2","value":"Іван, Олена","raw":{"format":"myhomelib.translators-display/1"}}';
      2: Payload := '{"observation":"db","value":"unmarked"},' + PersonClaim;
    else
      Payload := '{"observation":"db","value":"  —, ???  ","raw":{"format":"myhomelib.translators-display/1"}},' + PersonClaim;
    end;
    FileName := Settings.AppPath + 'translators.jsonl';
    System.IOUtils.TFile.WriteAllText(FileName,
      '{"schema":"metabib.dataset/1","record_schema":"metabib.dataset_record/1","library":"test","records":1,"archives":[{"id":"arc","name":"books.zip"}]}' + #10 +
      '{"schema":"metabib.dataset_record/1","record":{"library":"test","locator":{"kind":"archive_entry","source":"arc","index":0,"book_id":1}},"artifacts":[{"name":"1.fb2","occurrences":[{"archive":"arc","entry":"1.fb2","index":0}]}],"claims":{"bibliographic":{"title":[{"value":"Title"}],"translators":[' + Payload + ']}}}' + #10,
      TEncoding.UTF8);
    ID := NewCollection('translator-' + IntToStr(CaseNo));
    RunImport(ID, FileName);
    Collection := SystemDB.GetCollection(ID);
    Iterator := Collection.GetBookIterator(bmAll, True);
    Require(Iterator.Next(Imported), 'Translator book missing');
    if CaseNo = 0 then
      Require(Imported.Translators = 'Іван, Олена', 'Marked display did not win db precedence')
    else if CaseNo = 3 then
      Require(Imported.Translators = '  —, ???  ', 'Explicit translator display text was normalized or discarded')
    else
      Require(Imported.Translators = 'Structured Translator', 'Structured translator precedence changed');
    Iterator := nil;
    Collection := nil;
  end;
  Writeln('PASS translator_display_roundtrip and upstream_translators_unchanged');
end;

function NewGroup(const Name: string): Integer;
var
  Iterator: IGroupIterator;
  Group: TGroupData;
begin
  Require(SystemDB.AddGroup(Name), 'Group creation failed');
  Iterator := SystemDB.GetGroupIterator;
  while Iterator.Next(Group) do
    if Group.Text = Name then
      Exit(Group.GroupID);
  raise Exception.Create('Created group is missing');
end;

function AddPayload(CollectionID, GroupID: Integer; const Stem, Payload: string;
  const Ext: string = '.fb2'; const Folder: string = ''; InsideNo: Integer = 0): Integer;
var
  R: TBookRecord;
  Collection: IBookCollection;
begin
  Collection := SystemDB.GetCollection(CollectionID);
  R.Clear;
  R.Title := Stem;
  R.FileName := Stem;
  R.FileExt := Ext;
  R.LibID := Stem;
  R.Lang := 'uk';
  R.Annotation := 'Current source metadata ' + Stem;
  R.Date := EncodeDate(2020, 1, 1);
  R.Folder := Folder;
  R.InsideNo := InsideNo;
  TAuthorsHelper.Add(R.Authors, 'Author', 'Fixture', '');
  Include(R.BookProps, bpIsLocal);
  Result := Collection.InsertBook(R, False, False);
  Require(Result > 0, 'Payload metadata insert failed');
  if (Folder = '') and (Payload <> '') then
    System.IOUtils.TFile.WriteAllText(TPath.Combine(Collection.CollectionRoot, Stem + Ext),
      Payload, TEncoding.UTF8);
  if GroupID >= 0 then
    Collection.AddBookToGroup(CreateBookKey(Result, CollectionID), GroupID);
end;

function RunExport(GroupID: Integer; const Destination: string): TMetabibExportResult;
var
  Worker: TExportMetabibThread;
begin
  Worker := TExportMetabibThread.Create(GroupID, Destination);
  try
    Worker.Start;
    Worker.WaitFor;
    if Assigned(Worker.FatalException) then
      raise Exception.Create(Exception(Worker.FatalException).Message);
    Result := Worker.ResultInfo;
  finally
    Worker.Free;
  end;
end;

procedure VerifyPackage(const Package: string; Count: Integer);
var
  Reader: TMetabibReader;
  Book: TMetabibBook;
  Zip: TMHLZip;
  Payload: TMemoryStream;
  Actual, Source: TBytes;
  N: Integer;
  Archive: string;
begin
  Reader := TMetabibReader.Create(TPath.Combine(Package, 'catalog.jsonl'));
  try
    Require(Reader.RecordCount = Count, 'Header count does not match payload count');
    N := 0;
    while Reader.ReadNext(Book) = mrOk do
    begin
      Inc(N);
      Require(Book.BookID = N, 'Derived IDs are not unique and ordered');
      Archive := Format('books-%.6d.zip', [(N - 1) div 1000 + 1]);
      Require(Reader.ArchiveName(Book.ArchiveID) = Archive, 'Wrong archive assignment');
      Require(Book.EntryIndex = (N - 1) mod 1000, 'Wrong ZIP index');
      Require(Book.EntryName = IntToStr(N) + '.fb2', 'Wrong flat entry name');
      Zip := TMHLZip.Create(TPath.Combine(Package, Archive), True);
      try
        if N = Count then
          Require(Zip.FileCount = ((N - 1) mod 1000) + 1, 'Last archive has the wrong number of entries')
        else if N mod 1000 = 0 then
          Require(Zip.FileCount = 1000, 'Full archive is not a thousand-book archive');
        Payload := Zip.ExtractToStream(Book.EntryIndex);
        try
          Payload.Position := 0;
          SetLength(Actual, Payload.Size);
          if Payload.Size > 0 then
            Payload.ReadBuffer(Actual[0], Length(Actual));
          Source := TEncoding.UTF8.GetPreamble + TEncoding.UTF8.GetBytes('payload-' + Book.Title);
          Require(Length(Actual) = Length(Source), 'Payload size changed');
          Require(CompareMem(@Actual[0], @Source[0], Length(Source)), 'Payload bytes changed');
          Require(Book.UncompressedSize = Length(Source), 'Catalog payload size is wrong');
        finally
          Payload.Free;
        end;
      finally
        Zip.Free;
      end;
    end;
    Require(N = Count, 'Catalog lost or added a member');
  finally
    Reader.Free;
  end;
end;

procedure TestBatches;
const
  Counts: array[0..5] of Integer = (0, 1, 999, 1000, 1001, 2001);
var
  Count, I, GroupID, CollectionID: Integer;
  Info: TMetabibExportResult;
  Destination, Name: string;
begin
  Destination := Settings.AppPath + 'exports';
  ForceDirectories(Destination);
  for Count in Counts do
  begin
    Name := 'batch-' + IntToStr(Count);
    CollectionID := NewCollection(Name);
    GroupID := NewGroup(Name);
    for I := 1 to Count do
      AddPayload(CollectionID, GroupID, Name + '-' + IntToStr(I),
        'payload-' + Name + '-' + IntToStr(I));
    Info := RunExport(GroupID, Destination);
    if Count = 0 then
      Require((Info.OutputDirectory = '') and (Info.ExportedCount = 0), 'Empty group published a package')
    else
    begin
      Require(Info.Status = mesCompleted, 'Batch export failed: ' + Info.ErrorText);
      Require((Info.ExportedCount = Count) and (Info.SkippedCount = 0), 'Wrong export result counts');
      VerifyPackage(Info.OutputDirectory, Count);
    end;
  end;
  Writeln('PASS batch_boundaries');
end;

procedure TestMixedGroup;
var
  A, B, GroupID, FirstID, SecondID: Integer;
  Collection: IBookCollection;
  R: TBookRecord;
  Info: TMetabibExportResult;
  Reader: TMetabibReader;
  MB: TMetabibBook;
  N: Integer;
begin
  A := NewCollection('mixed-a');
  B := NewCollection('mixed-b');
  GroupID := NewGroup('mixed');
  FirstID := AddPayload(A, GroupID, 'shared', 'payload-shared-A');
  SecondID := AddPayload(B, GroupID, 'shared', 'payload-shared-B');
  Require(FirstID = SecondID, 'Fixture does not cover equal source BookIDs');
  AddPayload(A, -1, 'outside-group', 'not exported');
  Collection := SystemDB.GetCollection(A);
  Collection.GetBookRecord(CreateBookKey(FirstID, A), R, True);
  R.Title := 'Updated metadata';
  R.Annotation := 'Current annotation, not the cached group copy';
  Collection.UpdateBook(R);
  Collection := nil;
  Info := RunExport(GroupID, Settings.AppPath + 'exports');
  Require((Info.Status = mesCompleted) and (Info.ExportedCount = 2), 'Cross-collection group lost members');
  Reader := TMetabibReader.Create(TPath.Combine(Info.OutputDirectory, 'catalog.jsonl'));
  try
    N := 0;
    while Reader.ReadNext(MB) = mrOk do
    begin
      Inc(N);
      Require(MB.BookID = N, 'Colliding source IDs were reused');
      if N = 1 then
        Require((MB.Title = 'Updated metadata') and
          (MB.Annotation = 'Current annotation, not the cached group copy'), 'Cached group metadata was exported');
    end;
    Require(N = 2, 'Non-member exported or member missing');
  finally
    Reader.Free;
  end;
  Writeln('PASS mixed_collection_group');
end;

type
  TExportObserver = class
    Worker: TExportMetabibThread;
    Mode, Destination, CollisionDirectory: string;
    GroupID, ExtraCollection, ExtraBook: Integer;
    Applied: Boolean;
    procedure Progress(Percent: Integer);
  end;

procedure TExportObserver.Progress(Percent: Integer);
var
  Stage, Name: string;
begin
  if Applied then Exit;
  if (Mode = 'cancel') and (Worker.ResultInfo.ExportedCount > 0) then
  begin
    Applied := True;
    Worker.Cancel;
  end
  else if (Mode = 'snapshot') and (Worker.ResultInfo.ExportedCount > 0) then
  begin
    Applied := True;
    SystemDB.GetCollection(ExtraCollection).AddBookToGroup(
      CreateBookKey(ExtraBook, ExtraCollection), GroupID);
  end
  else if (Mode = 'write-failure') or (Mode = 'collision') then
    for Stage in TDirectory.GetDirectories(Destination, '.MHL-*.partial') do
    begin
      Applied := True;
      if Mode = 'write-failure' then
        Require(CreateDir(TPath.Combine(Stage, 'books-000001.zip')), 'Write-failure fixture failed')
      else
      begin
        Name := ExtractFileName(Stage);
        CollisionDirectory := TPath.Combine(Destination, Copy(Name, 2, Length(Name) - 9));
        Require(CreateDir(CollisionDirectory), 'Collision fixture failed');
        System.IOUtils.TFile.WriteAllText(TPath.Combine(CollisionDirectory, 'user.txt'), 'keep this');
      end;
      Break;
    end;
end;

procedure TestInterruptions;
const
  Modes: array[0..2] of string = ('cancel', 'write-failure', 'collision');
var
  Mode, Destination: string;
  CollectionID, GroupID: Integer;
  Observer: TExportObserver;
  Worker: TExportMetabibThread;
  Info: TMetabibExportResult;
begin
  for Mode in Modes do
  begin
    Destination := Settings.AppPath + Mode;
    ForceDirectories(Destination);
    CollectionID := NewCollection('fault-' + Mode);
    GroupID := NewGroup('fault-' + Mode);
    AddPayload(CollectionID, GroupID, 'first', 'first bytes');
    AddPayload(CollectionID, GroupID, 'second', 'second bytes');
    Worker := TExportMetabibThread.Create(GroupID, Destination);
    Observer := TExportObserver.Create;
    try
      Observer.Worker := Worker;
      Observer.Mode := Mode;
      Observer.Destination := Destination;
      Worker.OnProgress := Observer.Progress;
      Worker.Start;
      Worker.WaitFor;
      Require(not Assigned(Worker.FatalException), 'Worker exception escaped failure handling');
      Info := Worker.ResultInfo;
      Require(Observer.Applied, 'Fault was not exercised');
      if Mode = 'cancel' then
        Require(Info.Status = mesCanceled, 'Cancellation was reported as success')
      else
        Require((Info.Status = mesFailed) and (Info.ErrorText <> ''), 'Output fault was not reported');
      Require((Info.OutputDirectory = '') and (Info.ExportedCount = 0), 'Interrupted package was published');
      Require(Length(TDirectory.GetDirectories(Destination, '.MHL-*.partial')) = 0, 'Staging data was not cleaned');
      if Mode = 'collision' then
        Require(System.IOUtils.TFile.ReadAllText(TPath.Combine(Observer.CollisionDirectory, 'user.txt')) =
          'keep this', 'Existing output was overwritten')
      else
        Require(Length(TDirectory.GetDirectories(Destination, 'MHL-*')) = 0, 'Aborted package remains');
    finally
      Worker.Free;
      Observer.Free;
    end;
  end;
  Writeln('PASS cancel_before_publish, archive_write_failure, destination_collision');
end;

procedure TestMembershipSnapshot;
var
  CollectionID, GroupID, Extra: Integer;
  Worker: TExportMetabibThread;
  Observer: TExportObserver;
  Info: TMetabibExportResult;
begin
  CollectionID := NewCollection('snapshot');
  GroupID := NewGroup('snapshot');
  AddPayload(CollectionID, GroupID, 'first', 'first bytes');
  Extra := AddPayload(CollectionID, -1, 'extra', 'extra bytes');
  Worker := TExportMetabibThread.Create(GroupID, Settings.AppPath + 'exports');
  Observer := TExportObserver.Create;
  try
    Observer.Worker := Worker;
    Observer.Mode := 'snapshot';
    Observer.GroupID := GroupID;
    Observer.ExtraCollection := CollectionID;
    Observer.ExtraBook := Extra;
    Worker.OnProgress := Observer.Progress;
    Worker.Start;
    Worker.WaitFor;
    Info := Worker.ResultInfo;
    Require(Observer.Applied, 'Membership change was not exercised');
    Require((Info.Status = mesCompleted) and (Info.ExportedCount = 1), 'Running export followed a changed group');
  finally
    Worker.Free;
    Observer.Free;
  end;
  Info := RunExport(GroupID, Settings.AppPath + 'exports');
  Require((Info.Status = mesCompleted) and (Info.ExportedCount = 2), 'Later export did not use new group membership');
  Writeln('PASS group_membership_snapshot');
end;

procedure TestMissingSources;
var
  A, B, GroupID: Integer;
  Collection: IBookCollection;
  DatabaseFile: string;
  Info: TMetabibExportResult;
begin
  A := NewCollection('missing-files');
  B := NewCollection('unavailable-collection');
  GroupID := NewGroup('missing-sources');
  AddPayload(A, GroupID, 'present', 'present bytes');
  AddPayload(A, GroupID, 'absent', '');
  AddPayload(A, GroupID, 'archived', '', '.fb2', 'absent.zip');
  AddPayload(B, GroupID, 'unavailable', 'bytes');
  Collection := SystemDB.GetCollection(B);
  DatabaseFile := Collection.GetProperty(PROP_DATAFILE);
  Collection := nil;
  SystemDB.ClearCollectionCache;
  Require(System.SysUtils.DeleteFile(DatabaseFile), 'Unavailable collection fixture did not remove its database');
  Info := RunExport(GroupID, Settings.AppPath + 'exports');
  Require(Info.Status = mesCompletedWithSkips, 'Skipped members were not reported');
  Require((Info.ExportedCount = 1) and (Info.SkippedCount = 3), 'Wrong missing-source counts');
  Require(ReadOne(TPath.Combine(Info.OutputDirectory, 'catalog.jsonl')).Title = 'present',
    'Missing book acquired a dangling catalog entry');
  Writeln('PASS missing_books, unavailable_collection, nil_stream');
end;

procedure TestPayloadFormats;
var
  CollectionID, GroupID: Integer;
  Collection: IBookCollection;
  Zip: TMHLZip;
  Bytes: TStringStream;
  Info: TMetabibExportResult;
  Reader: TMetabibReader;
  MB: TMetabibBook;
  Payload: TMemoryStream;
  Actual: TBytes;
  N: Integer;
  Root: string;
begin
  CollectionID := NewCollection('formats');
  GroupID := NewGroup('formats');
  AddPayload(CollectionID, GroupID, 'loose', 'payload-loose');
  AddPayload(CollectionID, GroupID, 'loose-raw', 'payload-raw', '.txt');
  Collection := SystemDB.GetCollection(CollectionID);
  Root := Collection.CollectionRoot;
  Zip := TMHLZip.Create(TPath.Combine(Root, 'source.zip'), False);
  try
    Bytes := TStringStream.Create('payload-archived', TEncoding.UTF8);
    try
      Zip.AddFromStream('archived.fb2', Bytes);
    finally
      Bytes.Free;
    end;
  finally
    Zip.Free;
  end;
  AddPayload(CollectionID, GroupID, 'archived', '', '.fb2', 'source.zip');
  Zip := TMHLZip.Create(TPath.Combine(Root, 'fbd-book.zip'), False);
  try
    Bytes := TStringStream.Create('payload-fbd-raw', TEncoding.UTF8);
    try
      Zip.AddFromStream('original.pdf', Bytes);
    finally
      Bytes.Free;
    end;
    Bytes := TStringStream.Create('<FictionBook><description/></FictionBook>', TEncoding.UTF8);
    try
      Zip.AddFromStream('original.fbd', Bytes);
    finally
      Bytes.Free;
    end;
  finally
    Zip.Free;
  end;
  AddPayload(CollectionID, GroupID, 'fbd-book.zip', '', '.pdf');
  Collection := nil;
  Info := RunExport(GroupID, Settings.AppPath + 'exports');
  Require((Info.Status = mesCompleted) and (Info.ExportedCount = 4), 'Payload format was omitted');
  Reader := TMetabibReader.Create(TPath.Combine(Info.OutputDirectory, 'catalog.jsonl'));
  try
    N := 0;
    while Reader.ReadNext(MB) = mrOk do
    begin
      Inc(N);
      Zip := TMHLZip.Create(TPath.Combine(Info.OutputDirectory, Reader.ArchiveName(MB.ArchiveID)), True);
      try
        Payload := Zip.ExtractToStream(MB.EntryIndex);
        try
          Payload.Position := 0;
          SetLength(Actual, Payload.Size);
          Payload.ReadBuffer(Actual[0], Length(Actual));
          if N = 3 then
            Require(TEncoding.UTF8.GetString(Actual) = 'payload-archived', 'Archived FB2 bytes changed');
          if N = 4 then
          begin
            Require(ExtractFileExt(MB.EntryName) = '.pdf', 'FBD payload extension changed');
            Require(TEncoding.UTF8.GetString(Actual) = 'payload-fbd-raw', 'FBD descriptor exported instead of book');
          end;
        finally
          Payload.Free;
        end;
      finally
        Zip.Free;
      end;
    end;
    Require(N = 4, 'Format catalog count is wrong');
  finally
    Reader.Free;
  end;
  Writeln('PASS fb2_raw_and_fbd_payloads');
end;

procedure TestWizardDefaultDatabasePath;
var
  SourceID, GroupID, ImportedID, Authors, Books, Series: Integer;
  Info: TMetabibExportResult;
  Reader: TMetabibReader;
  LibraryName, Catalog: string;
  Collection: IBookCollection;
begin
  SourceID := NewCollection('wizard-default-source');
  GroupID := NewGroup('wizard-default-source');
  AddPayload(SourceID, GroupID, 'book', 'book bytes');
  Info := RunExport(GroupID, Settings.AppPath + 'exports');
  Require(Info.Status = mesCompleted, 'Wizard filename fixture export failed');
  Catalog := TPath.Combine(Info.OutputDirectory, 'catalog.jsonl');
  Reader := TMetabibReader.Create(Catalog);
  try
    LibraryName := Reader.LibraryName;
  finally
    Reader.Free;
  end;
  ImportedID := SystemDB.CreateCollection(LibraryName, Info.OutputDirectory,
    LibraryName + COLLECTION_EXTENSION, CT_EXTERNAL_LOCAL_FB,
    Settings.AppPath + 'genres_fb2.glst');
  SystemDB.ClearCollectionCache;
  Collection := SystemDB.GetCollection(ImportedID);
  Collection.GetStatistics(Authors, Books, Series);
  Require(Books = 0, 'Fresh wizard-default database is not empty');
  Collection := nil;
  RunImport(ImportedID, Catalog);
  Collection := SystemDB.GetCollection(ImportedID);
  Collection.GetStatistics(Authors, Books, Series);
  Require(Books = 1, 'Wizard-default database did not import its package');
  Writeln('PASS wizard_default_database_path_create_reopen_import');
end;

procedure TestPortableRoundTrip;
const
  BoundaryIDs: array[0..2] of Integer = (1, 1000, 1001);
  BoundaryTitles: array[0..2] of string = ('portable-a-1', 'portable-b-500', 'portable-b-501');
var
  A, B, GroupID, I, ImportID, ID: Integer;
  Collection: IBookCollection;
  SourceA, SourceB: string;
  DataA, DataB: TGenreData;
  Genres: TBookGenres;
  R: TBookRecord;
  Info: TMetabibExportResult;
  Moved: string;
  Payload: TStream;
  Actual, Wanted: TBytes;
  ImportedA, ImportedB: TGenreData;
  GenreIterator: IGenreIterator;
  Filter: TFilterValue;
begin
  A := NewCollection('portable-a');
  B := NewCollection('portable-b');
  GroupID := NewGroup('portable');
  for I := 1 to 500 do
    AddPayload(A, GroupID, 'portable-a-' + IntToStr(I), 'payload-portable-a-' + IntToStr(I));
  for I := 1 to 501 do
    AddPayload(B, GroupID, 'portable-b-' + IntToStr(I), 'payload-portable-b-' + IntToStr(I));
  Collection := SystemDB.GetCollection(A);
  SourceA := Collection.CollectionRoot;
  DataA := Collection.EnsureGenre('shared-source-code', 'Source A genre', 'Source A category');
  SetLength(Genres, 1);
  Genres[0] := DataA;
  Collection.SetBookGenres(1, Genres, True);
  Collection := SystemDB.GetCollection(B);
  SourceB := Collection.CollectionRoot;
  DataB := Collection.EnsureGenre('shared-source-code', 'Source B genre', 'Source B category');
  Genres[0] := DataB;
  Collection.SetBookGenres(501, Genres, True);
  Collection := nil;
  Info := RunExport(GroupID, Settings.AppPath + 'exports');
  Require((Info.Status = mesCompleted) and (Info.ExportedCount = 1001), 'Portable export failed');
  Moved := Settings.AppPath + 'moved-package';
  TDirectory.Move(Info.OutputDirectory, Moved);
  SystemDB.ClearCollectionCache;
  TDirectory.Delete(SourceA, True);
  TDirectory.Delete(SourceB, True);
  ImportID := SystemDB.CreateCollection('Portable import', Moved, 'portable-import.hlc2',
    CT_EXTERNAL_LOCAL_FB, Settings.AppPath + 'genres_fb2.glst');
  RunImport(ImportID, TPath.Combine(Moved, 'catalog.jsonl'));
  Collection := SystemDB.GetCollection(ImportID);
  for I := 0 to High(BoundaryIDs) do
  begin
    ID := Collection.ResolveBookID(IntToStr(BoundaryIDs[I]), 0);
    Require(ID > 0, 'Imported boundary book is missing');
    Collection.GetBookRecord(CreateBookKey(ID, ImportID), R, True);
    Require(R.Title = BoundaryTitles[I], 'Portable metadata is wrong');
    Payload := R.GetBookStream;
    try
      Payload.Position := 0;
      SetLength(Actual, Payload.Size);
      Payload.ReadBuffer(Actual[0], Length(Actual));
      Wanted := TEncoding.UTF8.GetPreamble + TEncoding.UTF8.GetBytes('payload-' + BoundaryTitles[I]);
      Require((Length(Actual) = Length(Wanted)) and CompareMem(@Actual[0], @Wanted[0], Length(Wanted)),
        'Moved collection still depends on source files or has wrong bytes');
    finally
      Payload.Free;
    end;
  end;
  Filter.ValueInt := Collection.ResolveBookID('1', 0);
  GenreIterator := Collection.GetGenreIterator(gmByBook, @Filter);
  Require(GenreIterator.Next(ImportedA), 'Source A genre missing');
  GenreIterator := nil;
  Filter.ValueInt := Collection.ResolveBookID('1001', 0);
  GenreIterator := Collection.GetGenreIterator(gmByBook, @Filter);
  Require(GenreIterator.Next(ImportedB), 'Source B genre missing');
  GenreIterator := nil;
  Require((ImportedA.GenreAlias = 'Source A genre') and (ImportedB.GenreAlias = 'Source B genre') and
    (ImportedA.GenreCode <> ImportedB.GenreCode), 'Conflicting source genre definitions were merged');
  Writeln('PASS portable_import_and_open with conflicting source genres');
end;

procedure TestSavedDestination;
var
  Destination: string;
  CollectionID, GroupID: Integer;
  Info: TMetabibExportResult;
begin
  Destination := Settings.AppPath + 'saved-destination';
  ForceDirectories(Destination);
  Settings.GroupExportDir := Destination;
  Settings.SaveSettings;
  Settings.GroupExportDir := '';
  Settings.LoadSettings;
  CollectionID := NewCollection('saved-destination-source');
  GroupID := NewGroup('saved-destination-group');
  AddPayload(CollectionID, GroupID, 'book', 'book bytes');
  Info := RunExport(GroupID, Settings.GroupExportDir);
  Require((Info.Status = mesCompleted) and (ExtractFileDir(Info.OutputDirectory) = Destination),
    'Reloaded destination did not drive the export');
  Writeln('PASS saved_export_destination');
end;

procedure TestStaleMemberKey;
var
  CollectionID, GroupID, OriginalID, NewID: Integer;
  Collection: IBookCollection;
  Info: TMetabibExportResult;
  MB: TMetabibBook;
begin
  CollectionID := NewCollection('stale-membership');
  GroupID := NewGroup('stale-membership');
  OriginalID := AddPayload(CollectionID, GroupID, 'intended', 'original bytes');
  Collection := SystemDB.GetCollection(CollectionID);
  Collection.TruncateTablesBeforeImport;
  AddPayload(CollectionID, -1, 'imposter', 'wrong bytes');
  NewID := AddPayload(CollectionID, -1, 'intended', 'reimported intended bytes');
  Require((OriginalID = 1) and (NewID = 2), 'Reimport fixture did not reassign BookIDs');
  Collection := nil;
  Info := RunExport(GroupID, Settings.AppPath + 'exports');
  Require((Info.Status = mesCompleted) and (Info.ExportedCount = 1), 'Reimported member did not export');
  MB := ReadOne(TPath.Combine(Info.OutputDirectory, 'catalog.jsonl'));
  Require(MB.Title = 'intended', 'Stale group key exported the replacement book');
  Writeln('PASS stale_group_key_after_reimport');
end;

procedure TestOnlineLocalFiles;
var
  CollectionID, GroupID: Integer;
  Root: string;
  Zip: TMHLZip;
  Stream: TStringStream;
  Info: TMetabibExportResult;
  MB: TMetabibBook;
begin
  Root := IncludeTrailingPathDelimiter(Settings.AppPath + 'online-local-files');
  ForceDirectories(Root);
  CollectionID := SystemDB.CreateCollection('Online source', Root, 'online-local-files.hlc2',
    CT_EXTERNAL_ONLINE_FB, Settings.AppPath + 'genres_fb2.glst');
  GroupID := NewGroup('online-local-files');
  Zip := TMHLZip.Create(TPath.Combine(Root, 'downloaded.zip'), False);
  try
    Stream := TStringStream.Create('already downloaded bytes', TEncoding.UTF8);
    try
      Zip.AddFromStream('downloaded.fb2', Stream);
    finally
      Stream.Free;
    end;
  finally
    Zip.Free;
  end;
  AddPayload(CollectionID, GroupID, 'downloaded', '', '.fb2', 'downloaded.zip');
  AddPayload(CollectionID, GroupID, 'not-downloaded', '', '.fb2', 'not-downloaded.zip');
  Info := RunExport(GroupID, Settings.AppPath + 'exports');
  Require((Info.Status = mesCompletedWithSkips) and (Info.ExportedCount = 1) and
    (Info.SkippedCount = 1), 'Online source did not use available local files only');
  MB := ReadOne(TPath.Combine(Info.OutputDirectory, 'catalog.jsonl'));
  Require(MB.Title = 'downloaded', 'Unavailable online book received a catalog entry');
  Writeln('PASS downloaded_online_book and unavailable_online_book');
end;

var
  TestCase: string;
begin
  try
    TestCase := LowerCase(ParamStr(1));
    if (ParamCount > 1) or ((TestCase <> '') and (TestCase <> 'all') and
      (TestCase <> 'metadata') and (TestCase <> 'worker')) then
      raise EArgumentException.Create('Unknown export test selector: ' + ParamStr(1));
    Application.Initialize;
    DMUser := TDMUser.Create(nil);
    try
      DMUser.Init;
      if (TestCase = '') or (TestCase = 'all') or (TestCase = 'metadata') then
      begin
        TestMetadata;
        TestTranslatorPrecedence;
        TestStoredLiteralText;
      end;
      if (TestCase = '') or (TestCase = 'all') or (TestCase = 'worker') then
      begin
        TestBatches;
        TestMixedGroup;
        TestInterruptions;
        TestMembershipSnapshot;
        TestMissingSources;
        TestPayloadFormats;
        TestPortableRoundTrip;
        TestSavedDestination;
        TestStaleMemberKey;
        TestOnlineLocalFiles;
        TestWizardDefaultDatabasePath;
      end;
    finally
      DMUser.Free;
      DMUser := nil;
    end;
  except
    on E: Exception do
    begin
      Writeln('FAIL ', E.ClassName, ': ', E.Message);
      Halt(1);
    end;
  end;
end.
