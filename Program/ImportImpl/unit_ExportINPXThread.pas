(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov    nrymanov@gmail.com
  *                     Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             22.02.2010
  * Description
  *
  * $Id: unit_ExportINPXThread.pas 1143 2014-03-26 04:50:02Z ENikS $
  *
  * History
  * NickR 08.04.2010    Информация из глобальных переменных зачитывается в контексте основного потока.
  *
  ****************************************************************************** *)

unit unit_ExportINPXThread;

interface

uses
  Classes,
  unit_Globals,
  unit_WorkerThread,
  unit_CollectionWorkerThread;

type
  TExport2INPXThread = class(TCollectionWorker)
  strict private
    FTempPath: string;
    FINPXFileName: string;

    FGenresType: TGenresType;
    FCollectionVersion: string;

    procedure INPRecordCreate(const R: TBookRecord; writer: TStreamWriter);

  protected
    procedure Initialize; override;
    procedure WorkFunction; override;

  public
    constructor Create(const CollectionID: Integer; const INPXFileName: string);
  end;

implementation

uses
  Windows,
  Variants,
  SysUtils,
  StrUtils,
  IOUtils,
  unit_Consts,
  unit_MHLGenerics,
  dm_user,
  unit_MHL_strings,
  unit_Interfaces,
  unit_MHLArchiveHelpers;

resourcestring
  rstrVersionFrom = 'Версия от ddddd';
  rstrExportingCollection = 'Экспортируем коллекцию.';
  rstrSaving = 'Сохраняем документ. Подождите, пожалуйста.';

const
  BOOKS_INFO_FILE = 'books.inp'; { TODO -oNickR -cRefactoring : добавить в систебные файлы? }

  { TImportXMLThread }

constructor TExport2INPXThread.Create(const CollectionID: Integer; const INPXFileName: string);
begin
  inherited Create(CollectionID);
  FINPXFileName := INPXFileName;
  FTempPath := Settings.TempPath;
end;

procedure TExport2INPXThread.Initialize;
var
  vVersion: Variant;
begin
  inherited Initialize;
  Assert(Assigned(FCollection));

  if isFB2Collection(FCollection.CollectionCode) then
    FGenresType := gtFb2
  else
    FGenresType := gtAny;

  vVersion := FCollection.GetProperty(PROP_DATAVERSION);
  if VarIsEmpty(vVersion) then
    FCollectionVersion := FormatDateTime('yyyymmdd', Now)
  else
    FCollectionVersion := IntToStr(vVersion);
end;

procedure TExport2INPXThread.WorkFunction;
var
  R: TBookRecord;
  BookIterator: IBookIterator;

  inpxStream: TMemoryStream;
  inpxWriter: TStreamWriter;
  header: TINPXHeader;
  sources: array[0 .. 3] of TStreamSource;
  i: Integer;
  archiver: TMHLZip;
begin
  Assert(Assigned(FCollection));

  SetComment(rstrExportingCollection);

  inpxStream := TMemoryStream.Create;
  try
    inpxWriter := TStreamWriter.Create(inpxStream, TEncoding.UTF8);
    try
      BookIterator := FCollection.GetBookIterator(bmAll, True);
      try
        FProgressEngine.BeginOperation(BookIterator.RecordCount, rstrBookProcessedMsg1, rstrBookProcessedMsg2);
        try
          while BookIterator.Next(R) do
          begin
            if Canceled then
              Exit;

            INPRecordCreate(R, inpxWriter);

            FProgressEngine.AddProgress;
          end;
        finally
          FProgressEngine.EndOperation;
        end;
      finally
        BookIterator := nil;
      end;
    finally
      inpxWriter.Free;
    end;

    FProgressEngine.BeginOperation(-1, rstrSaving, rstrSaving);
    try
      inpxStream.Position := 0;
      for i := 0 to 3 do
        sources[i].Stream := nil;

      try
        sources[0].Name := BOOKS_INFO_FILE;
        sources[0].Stream := inpxStream;

        sources[1].Name := VERINFO_FILENAME;
        sources[1].Stream := TStringStream.Create(FCollectionVersion);

        sources[2].Name := STRUCTUREINFO_FILENAME;
        sources[2].Stream := TStringStream.Create('AUTHOR;GENRE;TITLE;SERIES;SERNO;FILE;SIZE;LIBID;DEL;EXT;DATE;INSNO;FOLDER;LANG;KEYWORDS;');

        //
        // Устанавливаем комментарий для INPX-файла
        //
        header.Name := FCollection.GetProperty(PROP_DISPLAYNAME);
        header.FileName := ExtractFileName(FCollection.GetProperty(PROP_DATAFILE));
        header.ContentType := FCollection.CollectionCode;
        header.Notes := FCollection.GetProperty(PROP_NOTES);
        header.URL := FCollection.GetProperty(PROP_URL);
        header.Script := FCollection.GetProperty(PROP_CONNECTIONSCRIPT);
        //
        sources[3].Name := COLLECTIONINFO_FILENAME;
        sources[3].Stream := TStringStream.Create(header.AsString);

        archiver := TMHLZip.Create(FINPXFileName, False);
        archiver.AddFromStream(sources[0].Name, sources[0].Stream);
        archiver.AddFromStream(sources[1].Name, sources[1].Stream);
        archiver.AddFromStream(sources[2].Name, sources[2].Stream);
        archiver.AddFromStream(sources[3].Name, sources[3].Stream);
      finally
        FreeAndNil(archiver);
        for i := 1 to 3 do // the 0-index INPX stream will be freed later
          FreeAndNil(sources[i].Stream);
      end;
    finally
      FProgressEngine.EndOperation;
    end;
  finally
    FreeAndNil(inpxStream);
  end;
end;

procedure TExport2INPXThread.INPRecordCreate(const R: TBookRecord; writer: TStreamWriter);
var
  strAuthors: string;
  strGenres: string;
  strFileExt: string;
  title: string;
begin
  //
  // Список авторов
  //
  strAuthors :=
    TArrayUtils.Join<TAuthorData>(
      R.Authors,
      INPX_ITEM_DELIMITER,
      function(const a: TAuthorData): string
      begin
        Result := a.LastName + INPX_SUBITEM_DELIMITER + a.FirstName + INPX_SUBITEM_DELIMITER + a.MiddleName;
      end
    ) + INPX_ITEM_DELIMITER;

  //
  // Список жанров
  //
  strGenres :=
    TArrayUtils.Join<TGenreData>(
      R.Genres,
      INPX_ITEM_DELIMITER,
      function(const g: TGenreData): string
      begin
        Result := IfThen(FGenresType = gtFb2, g.FB2GenreCode, g.GenreCode);
      end
    ) + INPX_ITEM_DELIMITER;

  strFileExt := R.FileExt;
  Delete(strFileExt, 1, 1);

  // Cleanup title, slows it down but preserves integrity
  title := R.Title;
  StrReplace(AnsiString(#13#10), ' ', title);
  StrReplace(AnsiString(#10), ' ', title);

  writer.Write(strAuthors);                           writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(strGenres);                            writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(Trim(title));                        writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(Trim(R.Series));                       writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(R.SeqNumber);                          writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(CheckSymbols(Trim(R.FileName)));       writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(R.Size);                               writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(R.LibID);                              writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(IfThen(bpIsDeleted in R.BookProps, '1', '0')); writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(strFileExt);                           writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(FormatDateTime('yyyy-mm-dd', R.Date)); writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(R.InsideNo);                           writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(R.Folder);                             writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(R.Lang);                               writer.Write(INPX_FIELD_DELIMITER);
  writer.Write(R.KeyWords);                           writer.Write(INPX_FIELD_DELIMITER);
  writer.WriteLine;
end;

end.
