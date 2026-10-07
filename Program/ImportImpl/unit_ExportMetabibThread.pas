unit unit_ExportMetabibThread;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  unit_CollectionWorkerThread, unit_Globals, unit_Interfaces, unit_MetabibReader;

type
  TMetabibExportStatus = (mesCompleted, mesCompletedWithSkips, mesCanceled, mesFailed);

  TMetabibExportResult = record
    Status: TMetabibExportStatus;
    OutputDirectory, ErrorText: string;
    ExportedCount, SkippedCount: Integer;
  end;

  TExportMetabibThread = class(TCollectionWorker)
  private type
    TMember = record
      Key: TBookKey;
      LibID: string;
    end;
    TSource = class
      Collection: IBookCollection;
      Genres: TDictionary<string, TMetabibGenre>;
      Ordinal: Integer;
      ErrorText: string;
      constructor Create;
      destructor Destroy; override;
    end;
  private
    FGroupID: Integer;
    FDestinationParent, FGeneratorVersion: string;
    FResultInfo: TMetabibExportResult;
    FMembers: TList<TMember>;
    FSources: TObjectDictionary<Integer, TSource>;
    procedure CheckCanceled;
    procedure ReadMembers;
    procedure PrepareSources;
    function PrepareBook(const Member: TMember; out R: TBookRecord;
      out Stream: TStream; out Genres: TArray<TMetabibGenre>): Boolean;
  protected
    procedure Initialize; override;
    procedure Uninitialize; override;
    procedure WorkFunction; override;
  public
    constructor Create(GroupID: Integer; const DestinationParent: string);
    destructor Destroy; override;
    property ResultInfo: TMetabibExportResult read FResultInfo;
  end;

implementation

uses
  System.IOUtils, System.DateUtils, System.Generics.Defaults,
  Winapi.Windows, Winapi.ActiveX, Vcl.ComCtrls,
  unit_Consts, unit_MHLHelpers, unit_MHLArchiveHelpers, unit_MetabibWriter;

type
  EGroupExportCanceled = class(EAbort);

resourcestring
  rstrReadingGroup = 'Читаємо склад групи…';
  rstrPreparingGroupGenres = 'Готуємо метадані колекцій…';
  rstrWritingGroup = 'Експортуємо книги групи…';
  rstrPublishingGroup = 'Зберігаємо каталог похідної колекції…';
  rstrEmptyExportGroup = 'Група не містить книг.';
  rstrNoExportableBooks = 'У групі немає доступних для експорту книг.';
  rstrGroupExportSkipped = 'Книгу %d з колекції %d пропущено: %s';
  rstrGroupExportNoBook = 'Книгу не знайдено у вихідній колекції.';
  rstrGroupExportNoStream = 'Файл книги недоступний.';
  rstrGroupExportNoGenre = 'Визначення жанру не знайдено: %s';
  rstrGroupExportBadExtension = 'Неправильне розширення файлу книги: %s';
  rstrGroupExportTooLarge = 'Файл книги перевищує підтримуваний розмір: %s';
  rstrGroupExportBadDestination = 'Тека експорту недоступна: %s';
  rstrGroupExportCleanup = 'Не вдалося видалити тимчасову теку %s: %s';
  rstrGroupExportTotals = 'Експортовано: %d. Пропущено: %d. Тека: %s';
  rstrGroupExportCanceled = 'Експорт групи скасовано.';

constructor TExportMetabibThread.TSource.Create;
begin
  inherited Create;
  Genres := TDictionary<string, TMetabibGenre>.Create;
end;

destructor TExportMetabibThread.TSource.Destroy;
begin
  Genres.Free;
  inherited;
end;

constructor TExportMetabibThread.Create(GroupID: Integer; const DestinationParent: string);
begin
  inherited Create(MHL_INVALID_ID);
  FGroupID := GroupID;
  FDestinationParent := DestinationParent;
  FGeneratorVersion := GetFileVersion(ParamStr(0));
  FResultInfo.Status := mesFailed;
  FMembers := TList<TMember>.Create;
  FSources := TObjectDictionary<Integer, TSource>.Create([doOwnsValues]);
end;

destructor TExportMetabibThread.Destroy;
begin
  FSources.Free;
  FMembers.Free;
  inherited;
end;

procedure TExportMetabibThread.Initialize;
begin
  try
    inherited;
  except
    on E: Exception do
      FResultInfo.ErrorText := E.Message;
  end;
end;

procedure TExportMetabibThread.Uninitialize;
begin
  FSources.Clear;
  if Assigned(FSystemData) then
    inherited
  else
    CoUninitialize;
end;

procedure TExportMetabibThread.CheckCanceled;
begin
  if Canceled then
    raise EGroupExportCanceled.Create(rstrGroupExportCanceled);
end;

procedure TExportMetabibThread.ReadMembers;
var
  Iterator: IBookIterator;
  R: TBookRecord;
  Member: TMember;
  I, Count: Integer;
begin
  SetComment(rstrReadingGroup);
  SetProgressHint(pbstMarquee);
  Iterator := FSystemData.GetBookIterator(FGroupID);
  try
    while Iterator.Next(R) do
    begin
      CheckCanceled;
      Member.Key := R.BookKey;
      Member.LibID := R.LibID;
      FMembers.Add(Member);
    end;
  finally
    Iterator := nil;
  end;
  FMembers.Sort(TComparer<TMember>.Construct(
    function(const A, B: TMember): Integer
    begin
      if A.Key.DatabaseID < B.Key.DatabaseID then Exit(-1);
      if A.Key.DatabaseID > B.Key.DatabaseID then Exit(1);
      if A.Key.BookID < B.Key.BookID then Exit(-1);
      if A.Key.BookID > B.Key.BookID then Exit(1);
      Result := 0;
    end));
  Count := 0;
  for I := 0 to FMembers.Count - 1 do
    if (Count = 0) or not FMembers[I].Key.IsSameAs(FMembers[Count - 1].Key) then
    begin
      if I <> Count then
        FMembers[Count] := FMembers[I];
      Inc(Count);
    end;
  FMembers.Count := Count;
end;

procedure TExportMetabibThread.PrepareSources;
var
  Source: TSource;
  Member: TMember;
  Iterator: IGenreIterator;
  Registry: TDictionary<string, TGenreData>;
  Definitions: TDictionary<string, TMetabibGenre>;
  Conflicts, Reserved: TDictionary<string, Boolean>;
  Data, Parent: TGenreData;
  Genre, First: TMetabibGenre;
  Pair: TPair<string, TGenreData>;
  GenrePair: TPair<string, TMetabibGenre>;
  SourceIDs: TList<Integer>;
  Code, Candidate: string;
  I, Suffix: Integer;
begin
  SetComment(rstrPreparingGroupGenres);
  Registry := TDictionary<string, TGenreData>.Create;
  Definitions := TDictionary<string, TMetabibGenre>.Create;
  Conflicts := TDictionary<string, Boolean>.Create;
  Reserved := TDictionary<string, Boolean>.Create;
  SourceIDs := TList<Integer>.Create;
  try
    for Member in FMembers do
    begin
      CheckCanceled;
      if FSources.ContainsKey(Member.Key.DatabaseID) then
        Continue;
      Source := TSource.Create;
      FSources.Add(Member.Key.DatabaseID, Source);
      Source.Ordinal := FSources.Count;
      SourceIDs.Add(Member.Key.DatabaseID);
      try
        Source.Collection := FSystemData.GetCollection(Member.Key.DatabaseID);
        Iterator := Source.Collection.GetGenreIterator(gmAll);
        Registry.Clear;
        try
          while Iterator.Next(Data) do
          begin
            CheckCanceled;
            Registry.AddOrSetValue(Data.GenreCode, Data);
          end;
        finally
          Iterator := nil;
        end;
        for Pair in Registry do
        begin
          Genre := Default(TMetabibGenre);
          Data := Pair.Value;
          Genre.Code := Data.FB2GenreCode;
          if Genre.Code = '' then
            Genre.Code := Data.GenreCode;
          Genre.Description := Data.GenreAlias;
          if Registry.TryGetValue(Data.ParentCode, Parent) then
            Genre.Category := Parent.GenreAlias;
          Genre.Catalog := True;
          Source.Genres.Add(Pair.Key, Genre);
          Reserved.AddOrSetValue(Genre.Code, True);
          if Definitions.TryGetValue(Genre.Code, First) then
          begin
            if (First.Description <> Genre.Description) or (First.Category <> Genre.Category) then
              Conflicts.AddOrSetValue(Genre.Code, True);
          end
          else
            Definitions.Add(Genre.Code, Genre);
        end;
      except
        on E: EGroupExportCanceled do raise;
        on E: Exception do
        begin
          Source.ErrorText := E.Message;
          Source.Collection := nil;
          Source.Genres.Clear;
        end;
      end;
    end;
    for I := 0 to SourceIDs.Count - 1 do
    begin
      Source := FSources[SourceIDs[I]];
      for GenrePair in Source.Genres.ToArray do
      begin
        Genre := GenrePair.Value;
        if not Conflicts.ContainsKey(Genre.Code) then
          Continue;
        Code := Format('mhl-%d-%s', [Source.Ordinal, Genre.Code]);
        Candidate := Code;
        Suffix := 0;
        while Reserved.ContainsKey(Candidate) do
        begin
          Inc(Suffix);
          Candidate := Code + '-' + IntToStr(Suffix);
        end;
        Reserved.Add(Candidate, True);
        Genre.TranslatedCode := Genre.Code;
        Genre.Code := Candidate;
        Source.Genres[GenrePair.Key] := Genre;
      end;
    end;
  finally
    SourceIDs.Free;
    Reserved.Free;
    Conflicts.Free;
    Definitions.Free;
    Registry.Free;
  end;
end;

function TExportMetabibThread.PrepareBook(const Member: TMember; out R: TBookRecord;
  out Stream: TStream; out Genres: TArray<TMetabibGenre>): Boolean;
var
  Source: TSource;
  Key: TBookKey;
  I: Integer;
begin
  Result := False;
  Stream := nil;
  try
    Source := FSources[Member.Key.DatabaseID];
    if Source.ErrorText <> '' then
      raise Exception.Create(Source.ErrorText);
    Key := Member.Key;
    Key.BookID := Source.Collection.ResolveBookID(Member.LibID, Key.BookID);
    if Key.BookID <= 0 then
      raise Exception.Create(rstrGroupExportNoBook);
    Source.Collection.GetBookRecord(Key, R, True);
    if (R.Title = '') or (R.FileName = '') then
      raise Exception.Create(rstrGroupExportNoBook);
    if (R.FileExt = '') or (R.FileExt[1] <> '.') or
      (Pos('/', R.FileExt) <> 0) or (Pos('\', R.FileExt) <> 0) or
      (Pos(':', R.FileExt) <> 0) then
      raise Exception.CreateFmt(rstrGroupExportBadExtension, [R.FileExt]);
    SetLength(Genres, Length(R.Genres));
    for I := 0 to High(R.Genres) do
      if not Source.Genres.TryGetValue(R.Genres[I].GenreCode, Genres[I]) then
        raise Exception.CreateFmt(rstrGroupExportNoGenre, [R.Genres[I].GenreCode]);
    Stream := R.GetBookStream;
    if Stream = nil then
      raise Exception.Create(rstrGroupExportNoStream);
    Stream.Position := 0;
    Result := True;
  except
    on E: Exception do
    begin
      FreeAndNil(Stream);
      Inc(FResultInfo.SkippedCount);
      Teletype(Format(rstrGroupExportSkipped,
        [Member.Key.BookID, Member.Key.DatabaseID, E.Message]), tsWarning);
    end;
  end;
end;

procedure TExportMetabibThread.WorkFunction;
var
  GUID: TGUID;
  DatasetID, LibraryName, Stage, FinalPath: string;
  OwnsStage, Published: Boolean;
  Spool, Output: TFileStream;
  Zip: TMHLZip;
  Archives: TList<TMetabibExportArchive>;
  Archive: TMetabibExportArchive;
  Location: TMetabibExportLocation;
  R: TBookRecord;
  Member: TMember;
  Payload: TStream;
  Genres: TArray<TMetabibGenre>;
  I: Integer;
begin
  Stage := '';
  OwnsStage := False;
  Published := False;
  Spool := nil;
  Zip := nil;
  Archives := TList<TMetabibExportArchive>.Create;
  try
    try
      if FResultInfo.ErrorText <> '' then
        raise Exception.Create(FResultInfo.ErrorText);
      CheckCanceled;
      ReadMembers;
      if FMembers.Count = 0 then
        raise Exception.Create(rstrEmptyExportGroup);
      PrepareSources;
      CheckCanceled;
      if not DirectoryExists(FDestinationParent) then
        raise Exception.CreateFmt(rstrGroupExportBadDestination, [FDestinationParent]);
      CreateGUID(GUID);
      DatasetID := Copy(GUIDToString(GUID), 2, 36);
      LibraryName := 'myhomelib-derived-' + DatasetID;
      FinalPath := TPath.Combine(FDestinationParent, 'MHL-' + DatasetID);
      Stage := TPath.Combine(FDestinationParent, '.MHL-' + DatasetID + '.partial');
      if not CreateDir(Stage) then
        RaiseLastOSError;
      OwnsStage := True;
      Spool := TFileStream.Create(TPath.Combine(Stage, 'records.tmp'), fmCreate);
      SetComment(rstrWritingGroup);
      SetProgressHint(pbstNormal);
      SetProgress(1);
      for I := 0 to FMembers.Count - 1 do
      begin
        CheckCanceled;
        Member := FMembers[I];
        if PrepareBook(Member, R, Payload, Genres) then
        try
          if Payload.Size > High(Integer) then
            raise Exception.CreateFmt(rstrGroupExportTooLarge, [R.GetBookFileName]);
          if Zip = nil then
          begin
            Archive := Default(TMetabibExportArchive);
            Archive.Ordinal := Archives.Count;
            Archive.ID := 'arc' + IntToStr(Archives.Count + 1);
            Archive.Name := Format('books-%.6d.zip', [Archives.Count + 1]);
            Zip := TMHLZip.Create(TPath.Combine(Stage, Archive.Name), False);
          end;
          Location.ArchiveID := Archive.ID;
          Location.EntryIndex := Archive.Entries;
          Location.ExportBookID := FResultInfo.ExportedCount + 1;
          Location.EntryName := IntToStr(Location.ExportBookID) + R.FileExt;
          Location.UncompressedSize := Payload.Size;
          Zip.AddFromStream(Location.EntryName, Payload);
          TMetabibWriter.WriteRecord(Spool, R, Genres, Location, LibraryName,
            'myhomelib.collection:' + IntToStr(Member.Key.DatabaseID));
          Inc(Archive.Entries);
          if SameText(R.FileExt, '.fb2') then
            Inc(Archive.FB2Entries);
          Inc(FResultInfo.ExportedCount);
          if Archive.Entries = 1000 then
          begin
            FreeAndNil(Zip);
            Archives.Add(Archive);
          end;
        finally
          Payload.Free;
        end;
        if (I = 0) or ((I + 1) mod ProcessedItemThreshold = 0) or (I = FMembers.Count - 1) then
          SetProgress(1 + Integer(Int64(I + 1) * 97 div FMembers.Count));
      end;
      CheckCanceled;
      if FResultInfo.ExportedCount = 0 then
        raise Exception.Create(rstrNoExportableBooks);
      if Zip <> nil then
      begin
        FreeAndNil(Zip);
        Archives.Add(Archive);
      end;
      SetComment(rstrPublishingGroup);
      Output := TFileStream.Create(TPath.Combine(Stage, 'catalog.jsonl'), fmCreate);
      try
        TMetabibWriter.WriteDataset(Output, Spool, DatasetID, LibraryName,
          FGeneratorVersion, TTimeZone.Local.ToUniversalTime(Now), FResultInfo.ExportedCount,
          Archives.ToArray);
      finally
        Output.Free;
      end;
      FreeAndNil(Spool);
      if not System.SysUtils.DeleteFile(TPath.Combine(Stage, 'records.tmp')) then
        RaiseLastOSError;
      CheckCanceled;
      if not MoveFile(PChar(Stage), PChar(FinalPath)) then
        RaiseLastOSError;
      Published := True;
      FResultInfo.OutputDirectory := FinalPath;
      if FResultInfo.SkippedCount = 0 then
        FResultInfo.Status := mesCompleted
      else
        FResultInfo.Status := mesCompletedWithSkips;
      SetProgress(100);
      Teletype(Format(rstrGroupExportTotals,
        [FResultInfo.ExportedCount, FResultInfo.SkippedCount, FinalPath]));
    except
      on E: EGroupExportCanceled do
      begin
        FResultInfo.Status := mesCanceled;
        Teletype(E.Message, tsWarning);
      end;
      on E: Exception do
      begin
        FResultInfo.Status := mesFailed;
        FResultInfo.ErrorText := E.Message;
        Teletype(E.Message, tsError);
      end;
    end;
  finally
    try
      FreeAndNil(Zip);
    finally
      Spool.Free;
      Archives.Free;
      if not Published then
      begin
        FResultInfo.OutputDirectory := '';
        FResultInfo.ExportedCount := 0;
      end;
      if OwnsStage and not Published then
        try
          TDirectory.Delete(Stage, True);
        except
          on E: Exception do
          begin
            FResultInfo.Status := mesFailed;
            FResultInfo.ErrorText := FResultInfo.ErrorText + sLineBreak +
              Format(rstrGroupExportCleanup, [Stage, E.Message]);
            Teletype(FResultInfo.ErrorText, tsError);
          end;
        end;
    end;
  end;
end;

end.
