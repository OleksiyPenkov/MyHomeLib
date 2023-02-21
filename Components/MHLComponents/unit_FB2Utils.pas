(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov     nrymanov@gmail.com
  * Created             19.02.2010
  * Description         набор функций для получения информации из файлов в формате fb2
  *
  * $Id: unit_FB2Utils.pas 1064 2011-09-02 11:33:04Z eg_ $
  *
  * History
  * NickR 19.02.2010    создан
  *       07.05.2010    Формат обложки определяется более точно (не на основании расширения).
  *
  ****************************************************************************** *)

unit unit_FB2Utils;

interface

uses
  Classes,
  Graphics,
  fictionbook_21;

function GetBookCoverStream(book: IXMLFictionBook): TStream;
function GetBookCover(book: IXMLFictionBook): TGraphic;
function GetBookAnnotation(book: IXMLFictionBook): string;
function GetBookInfo(book: IXMLFictionBook): string;
function FormatName(const LastName: string; const FirstName: string; const MiddleName: string; const nickName: string = ''; onlyInitials: Boolean = False): string;

{ TODO -oNickR -cRefactoring : доделать эту функцию. Для этого необходимо вынести определение TBookRecord в доступное место }
// procedure GetBookInfo(book: IXMLFictionBook; var R: TBookRecord);

const
  dlmtr = ': ';

resourcestring
  rstrFileInfo = 'Информация о файле';
  rstrFolder = 'Папка';
  rstrFile = 'Файл';
  rstrSize = 'Размер';
  rstrAdded = 'Добавлен';
  rstrGeneralInfo = 'Общая информация';
  rstrSrclInfo = 'Информация об источнике';
  rstrTitle = 'Название';
  rstrAuthors = 'Автор(ы)';
  rstrSingleSeries = 'Серия';
  rstrGenre = 'Жанр';
  rstrKeywords = 'Ключевые слова';
  rstrDate = 'Дата';
  rstrBookLanguage = 'Язык книги';
  rstrSourceLanguage = 'Язык оригинала';
  rstrTranslators = 'Переводчик(и)';
  rstrPublisherInfo = 'Издательская информация';
  rstrPublisher = 'Издательство';
  rstrCity = 'Город';
  rstrYear = 'Год';
  rstrISBN = 'ISBN';
  rstrOCRInfo ='Информация о документе (OCR)';
  rstrProgram = 'Программа';
  rstrID = 'ID';
  rstrVersion = 'Версия';
  rstrSource = 'Источник';
  rstrSourceAuthor = 'Автор источника';
  rstrHistory = 'История';

implementation

uses
  Windows,
  SysUtils,
  ActiveX,
  UrlMon,
  unit_MHLHelpers,
  GIFImg,
  jpeg,
  pngimage;

function InternalGetBookCoverStream(book: IXMLFictionBook): TStream;
var
  coverID: string;
  i: Integer;
  outStr: AnsiString;
begin
  Result := nil;

  if book.Description.Titleinfo.Coverpage.Count > 0 then
  begin
    coverID := book.Description.Titleinfo.Coverpage[0].xlinkHref;
    if Pos('#', coverID) = 1 then
    begin
      // это локальная ссылка (начинается с #)
      coverID := Copy(coverID, 2, MaxInt);

      for i := 0 to book.Binary.Count - 1 do
      begin
        if book.Binary[i].Id = coverID then
        begin
          outStr := DecodeBase64(book.Binary[i].Text);

          Result := TMemoryStream.Create;
          try
            Result.Write(PAnsiChar(outStr)^, Length(outStr));
          except
            FreeAndNil(Result);
          end;
          Break;
        end;
      end;
    end;
  end;
end;

function IsSupportedImageFormat(StreamFormat: TStreamFormat): Boolean;
begin
  Result := StreamFormat in [sfBitmap, sfGif, sfJPEGImage, sfMetafile, sfPngImage, fsIcon];
end;

function InternalCreateGraphic(StreamFormat: TStreamFormat): TGraphic;
begin
  Assert(IsSupportedImageFormat(StreamFormat));
  Result := nil;

  case StreamFormat of
    sfBitmap: Result := Graphics.TBitmap.Create;
    sfGif: Result := TGIFImage.Create;
    sfJPEGImage: Result := TJPEGImage.Create;
    //sfTiff: ;
    sfPngImage: Result := TPngImage.Create;
    sfMetafile: Result := Graphics.TMetafile.Create;
    fsIcon: Result := Graphics.TIcon.Create;
  else
    Assert(False);
  end;
end;

function GetBookCoverStream(book: IXMLFictionBook): TStream;
var
  StreamFormat: TStreamFormat;
begin
  Result := InternalGetBookCoverStream(book);
  if Assigned(Result) then
  begin
    Result.Seek(0, soFromBeginning);
    StreamFormat := DetectStreamFormat(Result);
    if not IsSupportedImageFormat(StreamFormat) then
      FreeAndNil(Result);
  end;
end;

function GetBookCover(book: IXMLFictionBook): TGraphic;
var
  coverStream: TStream;
  StreamFormat: TStreamFormat;
begin
  Result := nil;

  coverStream := InternalGetBookCoverStream(book);
  if Assigned(coverStream) then
  try
    coverStream.Seek(0, soFromBeginning);
    StreamFormat := DetectStreamFormat(coverStream);
    if not IsSupportedImageFormat(StreamFormat) then
      Exit;

    Result := InternalCreateGraphic(StreamFormat);
    if Assigned(Result) then
    try
      coverStream.Seek(0, soFromBeginning);
      Result.LoadFromStream(coverStream);
    except
      FreeAndNil(Result);
    end;
  finally
    coverStream.Free;
  end;
end;

function GetBookAnnotation(book: IXMLFictionBook): string;
var
  i: Integer;
  sl: TStringList;
begin
  Result := '';

  sl := TStringList.Create;
  try
    with book.Description.Titleinfo do
    begin
      for i := 0 to Annotation.p.Count - 1 do
        sl.Add(Annotation.p[i].OnlyText);
    end;

    Result := sl.Text;
  finally
    sl.Free;
  end;
end;

function GetBookInfo(book: IXMLFictionBook): string;
var
  i: Integer;
  sl: TStringList;
begin
  Result := '';

  sl := TStringList.Create;
  try

    with book.Description.Titleinfo do
    begin
      sl.Add(rstrYear + dlmtr + Date.Text);

      sl.Add('');
      sl.Add(rstrSingleSeries + dlmtr);
      for i := 0 to Sequence.Count - 1 do
        sl.Add(Sequence[i].Name);

      sl.Add('');
      sl.Add(rstrTranslators + dlmtr);
      for i := 0 to Translator.Count - 1 do
        with Translator[i] do
          sl.Add(LastName.Text + Firstname.Text + Middlename.Text + NickName.Text);
    end;
    sl.Add('');

    with book.Description.Publishinfo do
    begin
      sl.Add(rstrTitle + dlmtr + Bookname.Text);
      sl.Add(rstrPublisher + dlmtr + Publisher.Text);
      sl.Add(rstrCity + dlmtr + City.Text);
      sl.Add(rstrYear + dlmtr + Year);
      sl.Add(rstrISBN + dlmtr + Isbn.Text);
    end;

    with book.Description.Documentinfo do
    begin
      sl.Add('');
      sl.Add(rstrAuthors + dlmtr);
      for i := 0 to Author.Count - 1 do
        with Author[i] do
          sl.Add(LastName.Text + Firstname.Text + Middlename.Text + NickName.Text);

      sl.Add(rstrProgram + dlmtr + Programused.Text);
      sl.Add(rstrDate + dlmtr + Date.Text);
      sl.Add(rstrID + dlmtr + book.Description.Documentinfo.Id);
      sl.Add(rstrVersion + dlmtr + Version);

      sl.Add('');
      sl.Add(rstrSource + dlmtr);
      for i := 0 to Srcurl.Count - 1 do
      begin
        sl.Add('URL :' + Srcurl[i]);
      end;
      sl.Add(rstrSourceAuthor + dlmtr + Srcocr.Text);

      sl.Add('');
      sl.Add(rstrHistory + dlmtr);
      for i := 0 to History.p.Count - 1 do
        sl.Add(History.p[i].OnlyText);
    end;

    Result := sl.Text;
  finally
    sl.Free;
  end;
end;

function FormatName;
begin
  Result := LastName;

  if FirstName <> '' then
  begin
    if onlyInitials then
      Result := Result + ' ' + FirstName[1] + '.'
    else
      Result := Result + ' ' + FirstName;
  end;

  if MiddleName <> '' then
  begin
    if onlyInitials then
      Result := Result + ' ' + MiddleName[1] + '.'
    else
      Result := Result + ' ' + MiddleName;
  end;

  if nickName <> '' then
  begin
    if Result = '' then
      Result := nickName
    else
      Result := Result + '(' + nickName + ')';
  end;
end;

end.
