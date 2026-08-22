(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             22.08.2026
  * Description         Імпорт каталогу metabib (jsonl / jsonl.zst / jsonl.gz /
  *                     zip) до колекції. Дзеркалить unit_ImportInpxThread.
  *
  ****************************************************************************** *)

unit unit_ImportMetabibThread;

interface

uses
  Windows,
  unit_WorkerThread,
  unit_CollectionWorkerThread,
  unit_Globals,
  unit_Interfaces,
  unit_MetabibReader;

type
  TImportMetabibThreadBase = class(TCollectionWorker)
  protected
    FGenresType: TGenresType;

    procedure MapBook(const MB: TMetabibBook; var R: TBookRecord);
    procedure Import(const DatasetFileName: string; CheckFiles: Boolean;
      BookCollection: IBookCollection);
  end;

  TImportMetabibThread = class(TImportMetabibThreadBase)
  protected
    FDatasetFileName: string;
    procedure WorkFunction; override;

  public
    constructor Create(const CollectionID: Integer; const DatasetFileName: string;
      GenresType: TGenresType);
  end;

implementation

uses
  Classes,
  SysUtils,
  IOUtils,
  ComCtrls,
  unit_Consts,
  unit_Errors,
  dm_user;

resourcestring
  rstrMbProcessingFile = 'Імпортуємо каталог metabib %s (%s, %u записів)';
  rstrMbAddedBooks = 'Додано %u книг';
  rstrMbBadLine = 'Помилка структури каталогу. Рядок %u';
  rstrMbDBError = 'Помилка бази даних під час імпорту книги. Рядок %u';
  rstrMbSkippedNoFile = 'Пропущено записів без файлу в архівах: %u';
  rstrMbSkippedBadLines = 'Пропущено помилкових рядків: %u';
  rstrMbUpdatingDB = 'Оновлення бази даних. Будь ласка зачекайте ... ';

{ TImportMetabibThreadBase }

//
// Переносить розібраний запис metabib у TBookRecord.
// Розташування (Folder/IsLocal для онлайн-гілки) добудовує Import:
// воно залежить від типу колекції.
//
procedure TImportMetabibThreadBase.MapBook(const MB: TMetabibBook; var R: TBookRecord);
var
  i: Integer;
  s: string;
begin
  R.Clear;

  R.Title := MB.Title;
  if R.Title = '' then
    R.Title := MB.BookName;

  for i := 0 to High(MB.Authors) do
    TAuthorsHelper.Add(R.Authors, MB.Authors[i].LastName, MB.Authors[i].FirstName,
      MB.Authors[i].MiddleName);

  for i := 0 to High(MB.Genres) do
    if FGenresType = gtFb2 then
      TGenresHelper.Add(R.Genres, '', '', MB.Genres[i])
    else
      TGenresHelper.Add(R.Genres, MB.Genres[i], '', '');

  if MB.SeriesName <> '' then
  begin
    R.Series := MB.SeriesName;
    R.SeqNumber := MB.SeriesNo;
  end;

  R.Lang := LowerCase(Copy(MB.Lang, 1, 2));
  R.Annotation := MB.Annotation;
  R.KeyWords := MB.Keywords;
  R.LibRate := Round(MB.RatingAvg);

  if MB.Deleted then
    Include(R.BookProps, bpIsDeleted)
  else
    Exclude(R.BookProps, bpIsDeleted);

  if MB.Stamp <> 0 then
    R.Date := MB.Stamp
  else
    R.Date := Date; // дата імпорту, як домовлено у специфікації

  if MB.BookID > 0 then
    R.LibID := IntToStr(MB.BookID);

  // ---- нові поля
  s := '';
  for i := 0 to High(MB.Translators) do
  begin
    if s <> '' then
      s := s + ', ';
    s := s + Trim(MB.Translators[i].LastName + ' ' + MB.Translators[i].FirstName +
      ' ' + MB.Translators[i].MiddleName);
  end;
  R.Translators := s;
  R.Publisher := MB.Publisher;
  R.City := MB.City;
  R.PubYear := MB.PubYear;
  R.ISBN := MB.ISBN;

  R.Normalize; // автор/жанр/назва за замовчуванням, як у INPX-імпорті
end;

procedure TImportMetabibThreadBase.Import(const DatasetFileName: string;
  CheckFiles: Boolean; BookCollection: IBookCollection);
var
  Reader: TMetabibReader;
  MB: TMetabibBook;
  R: TBookRecord;
  IsOnline: Boolean;
  collectionCode: Integer;
  CollectionRoot: string;
  ArcName: string;
  idx, added, skippedNoFile, badLines: Integer;
  Skip: Boolean;
begin
  SetProgress(0);
  collectionCode := BookCollection.CollectionCode;
  IsOnline := isOnlineCollection(collectionCode);
  CollectionRoot := BookCollection.GetProperty(PROP_ROOTFOLDER);

  idx := 0;
  added := 0;
  skippedNoFile := 0;
  badLines := 0;

  Reader := nil;
  BookCollection.StartBatchUpdate;
  try
    Reader := TMetabibReader.Create(DatasetFileName);

    Teletype(Format(rstrMbProcessingFile,
      [ExtractFileName(DatasetFileName), Reader.LibraryName,
      Cardinal(Reader.RecordCount)]), tsInfo);

    if Reader.RecordCount > 0 then
      SetProgressHint(pbstNormal, pbsNormal); // інакше смуга лишиться marquee

    while True do
    begin
      case Reader.ReadNext(MB) of
        mrEof:
          Break;

        mrBadLine:
          begin
            Inc(badLines);
            Teletype(Format(rstrMbBadLine, [Cardinal(Reader.LineNo)]), tsError);
          end;

        mrOk:
          try
            MapBook(MB, R);
            Skip := False;

            if IsOnline then
            begin
              //
              // Онлайн-колекція: файл ще не завантажено, LibID - ключ
              // завантаження. Записи без book_id завантажити неможливо.
              //
              if MB.BookID <= 0 then
              begin
                Inc(skippedNoFile);
                Skip := True;
              end
              else
              begin
                R.FileName := IntToStr(MB.BookID);
                R.FileExt := FB2_EXTENSION;
                R.InsideNo := 0;
                R.Size := MB.UncompressedSize;
                if 0 = (CONTENT_NONFB and collectionCode) then
                  R.Folder := R.GenerateLocation + FB2ZIP_EXTENSION;
                if FileExists(TPath.Combine(CollectionRoot, R.Folder)) then
                  Include(R.BookProps, bpIsLocal)
                else
                  Exclude(R.BookProps, bpIsLocal);
              end;
            end
            else
            begin
              //
              // Локальна колекція: без артефакта запису нема на що вказувати.
              //
              ArcName := '';
              if MB.HasArtifact then
                ArcName := Reader.ArchiveName(MB.ArchiveID);
              // Ім'я архіву з каталогу не сміє бути шляхом: захист від обходу тек
              if (not MB.HasArtifact) or (ArcName = '') or (MB.EntryName = '') or
                (Pos('\', ArcName) > 0) or (Pos('/', ArcName) > 0) or (Pos('..', ArcName) > 0) then
              begin
                Inc(skippedNoFile);
                Skip := True;
              end
              else
              begin
                R.Folder := ArcName;
                R.FileName := TPath.GetFileNameWithoutExtension(MB.EntryName);
                R.FileExt := ExtractFileExt(MB.EntryName);
                if R.FileExt = '' then
                  R.FileExt := FB2_EXTENSION;
                R.InsideNo := MB.EntryIndex;
                R.Size := MB.UncompressedSize;
                Include(R.BookProps, bpIsLocal);
                if R.LibID = '' then
                  R.LibID := R.FileName;
              end;
            end;

            if not Skip then
              try
                if BookCollection.InsertBook(R, CheckFiles, False) <> 0 then
                  Inc(added);
              except
                on E: Exception do
                  raise EDBError.Create(E.Message);
              end;
          except
            on E: EDBError do
              Teletype(Format(rstrMbDBError, [Cardinal(Reader.LineNo)]), tsError);
            on E: Exception do
              Teletype(E.Message, tsError);
          end;
      end;

      Inc(idx);
      if Reader.RecordCount > 0 then
        SetProgress(idx * 100 div Reader.RecordCount);

      if (idx mod ProcessedItemThreshold) = 0 then
      begin
        SetComment(Format(rstrMbAddedBooks, [Cardinal(added)]));
        if Canceled then
          Break;
      end;
    end;

    Teletype(Format(rstrMbAddedBooks, [Cardinal(added)]), tsInfo);
    if skippedNoFile > 0 then
      Teletype(Format(rstrMbSkippedNoFile, [Cardinal(skippedNoFile)]), tsWarning);
    if badLines > 0 then
      Teletype(Format(rstrMbSkippedBadLines, [Cardinal(badLines)]), tsWarning);

    FProgressEngine.BeginOperation(-1, rstrMbUpdatingDB, '');
    BookCollection.AfterBatchUpdate;
  finally
    FreeAndNil(Reader);
    BookCollection.FinishBatchUpdate;
  end;
end;

{ TImportMetabibThread }

constructor TImportMetabibThread.Create(const CollectionID: Integer;
  const DatasetFileName: string; GenresType: TGenresType);
begin
  inherited Create(CollectionID);
  FDatasetFileName := DatasetFileName;
  FGenresType := GenresType;
end;

procedure TImportMetabibThread.WorkFunction;
begin
  Assert(Assigned(FCollection));

  FCollection.BeginBulkOperation;
  try
    Import(FDatasetFileName, False, FCollection);
    FCollection.EndBulkOperation(True);
  except
    on E: Exception do
    begin
      Teletype(E.Message, tsError);
      FCollection.EndBulkOperation(False);
    end;
  end;
end;

end.
