program MetabibImportTest;
{$APPTYPE CONSOLE}
{$R '..\..\..\Utils\MHLMcpServer\MHLMcpServer_SQL.res'}
uses
  System.SysUtils, System.IOUtils, System.Variants, Vcl.Forms,
  dm_user, unit_Consts, unit_Globals, unit_Interfaces, unit_ImportMetabibThread, SQLiteWrap;
procedure RunImport(ID: Integer; const Filename: string);
var
  Thread: TImportMetabibThread;
begin
  Thread := TImportMetabibThread.Create(ID, Filename, gtFb2);
  try
    Thread.Start;
    Thread.WaitFor;
    if Assigned(Thread.FatalException) then
      raise Exception.Create(Exception(Thread.FatalException).Message);
  finally
    Thread.Free;
  end;
end;
var
  Collection: IBookCollection;
  CollectionID, A, B, S: Integer;
  Filter: TFilterValue;
  Iterator: IGenreIterator;
  Genre, First: TGenreData;
  Dataset: string;
  DB: TSQLiteDatabase;
  Payload: string;
begin
  try
    Application.Initialize;
    DMUser := TDMUser.Create(nil);
    try
      DMUser.Init;
      CollectionID := SystemDB.CreateCollection('Import test', Settings.AppPath,
        'import-test.hlc2', CT_EXTERNAL_LOCAL_FB, Settings.AppPath + 'genres_fb2.glst');
      Dataset := Settings.AppPath + 'import.jsonl';
      System.IOUtils.TFile.WriteAllText(Dataset,
        '{"schema":"metabib.dataset/1","record_schema":"metabib.dataset_record/1","library":"flibusta","records":2,"archives":[{"id":"arc","name":"fixture.zip"}]}' + sLineBreak +
        '{"schema":"metabib.dataset_record/1","record":{"library":"flibusta","locator":{"kind":"archive_entry","source":"arc","index":0,"book_id":101}},"artifacts":[{"occurrences":[{"archive":"arc","entry":"101.fb2","index":0,"uncompressed_size":100}]}],"claims":{"bibliographic":{"title":[{"value":"First"}],"genres":[{"observation":"db","value":[{"code":"popadancy","description":"Source genre","meta":"Source category"}]},{"observation":"fb2","value":[{"code":"untrusted_tag"}]}]}}}' + sLineBreak +
        '{"schema":"metabib.dataset_record/1","record":{"library":"flibusta","locator":{"kind":"archive_entry","source":"arc","index":1,"book_id":102}},"artifacts":[{"occurrences":[{"archive":"arc","entry":"102.fb2","index":1,"uncompressed_size":100}]}],"claims":{"bibliographic":{"title":[{"value":"Second"}],"genres":[{"observation":"db","value":[{"code":"popadancy","description":"Source genre","meta":"Source category"}]}]}}}' + sLineBreak,
        TEncoding.UTF8);
      RunImport(CollectionID, Dataset);
      SystemDB.ClearCollectionCache;
      Collection := SystemDB.GetCollection(CollectionID);
      Collection.GetStatistics(A, B, S);
      if B <> 2 then raise Exception.Create('Import did not preserve both books');
      if not Boolean(Collection.GetProperty(PROP_SOURCE_GENRES)) then
        raise Exception.Create('Source taxonomy provenance was not saved');
      if string(Collection.GetProperty(PROP_SOURCE_LIBRARY)) <> 'flibusta' then
        raise Exception.Create('Source library identity was not saved');
      Filter.ValueInt := 1;
      Iterator := Collection.GetGenreIterator(gmByBook, @Filter);
      if not Iterator.Next(First) then raise Exception.Create('First book has no genre');
      if (First.FB2GenreCode <> 'popadancy') or (First.GenreAlias <> 'Source genre') then
        raise Exception.Create('Curated genre was not mapped');
      if Iterator.Next(Genre) then raise Exception.Create('Untrusted FB2 genre was merged');
      Filter.ValueInt := 2;
      Iterator := Collection.GetGenreIterator(gmByBook, @Filter);
      if not Iterator.Next(Genre) or (Genre.GenreCode <> First.GenreCode) then
        raise Exception.Create('Repeated source genre was duplicated');
      Writeln('PASS production import registers curated definitions and preserves source identity');
      Iterator := nil;
      Collection := nil;
      CollectionID := SystemDB.CreateCollection('Wrong source', Settings.AppPath,
        'wrong-source.hlc2', CT_EXTERNAL_LOCAL_FB, Settings.AppPath + 'genres_fb2.glst');
      Collection := SystemDB.GetCollection(CollectionID);
      Collection.SetProperty(PROP_SOURCE_LIBRARY, 'other-library');
      RunImport(CollectionID, Dataset);
      Collection.GetStatistics(A, B, S);
      if (B <> 0) or (string(Collection.GetProperty(PROP_SOURCE_LIBRARY)) <> 'other-library') then
        raise Exception.Create('Conflicting source import changed the collection');
      Writeln('PASS conflicting source import leaves data unchanged');
      Collection := nil;
      CollectionID := SystemDB.CreateCollection('Lost transaction', Settings.AppPath,
        'lost-transaction.hlc2', CT_EXTERNAL_LOCAL_FB, Settings.AppPath + 'genres_fb2.glst');
      Collection := SystemDB.GetCollection(CollectionID);
      DB := TSQLiteDatabase.Create(string(Collection.GetProperty(PROP_DATAFILE)));
      try
        DB.ExecSQL('CREATE TRIGGER stop_import BEFORE INSERT ON Genres WHEN NEW.FB2Code = ''boom'' BEGIN SELECT RAISE(ROLLBACK, ''Lost transaction''); END');
        Payload := StringReplace(System.IOUtils.TFile.ReadAllText(Dataset),
          '"code":"popadancy"', '"code":"boom"', []);
        System.IOUtils.TFile.WriteAllText(Dataset, Payload, TEncoding.UTF8);
        RunImport(CollectionID, Dataset);
        if DB.QuerySingleInt('SELECT COUNT(*) FROM Books') <> 0 then
          raise Exception.Create('Importer continued writing after losing its transaction');
        if DB.QuerySingleInt('SELECT COUNT(*) FROM Genres WHERE FB2Code IN (''boom'', ''popadancy'')') <> 0 then
          raise Exception.Create('Lost import transaction left source genres behind');
      finally
        DB.Free;
      end;
      Writeln('PASS production importer stops after losing the outer transaction');
      Collection := nil;
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
