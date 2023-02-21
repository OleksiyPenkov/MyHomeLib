(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors             Oleksiy Penkov   oleksiy.penkov@gmail.com
  *                     Nick Rymanov     nrymanov@gmail.com
  * Created             20.08.2008
  * Description         Набор вспомогательных функций.
  *
  * $Id: unit_MHLHelpers.pas 823 2010-09-30 12:30:39Z eg_ $
  *
  * History
  * NickR 07.05.2010         Добавил функцию определения формата стрима. Пока она не определяет ZIP.
  *
  ****************************************************************************** *)

unit unit_MHLHelpers;

interface

uses
  Classes,
  SysUtils;

//
// String helpers
//
function DecodeBase64(const CinLine: AnsiString): AnsiString;

//
// Stream helpers
//
type
  TStreamFormat = (
    sfUnknown,
    sfText,
    sfRichText,
    sfBitmap,
    sfGif,
    sfJPEGImage,
    sfTiff,
    sfPngImage,
    sfMetafile,
    sfPDF,
    sfHTML,
    fsIcon
  );

function DetectStreamFormat(Stream: TStream): TStreamFormat;

function GetFormattedSize(sizeInBytes: Integer; showBytes: Boolean = False): string;

function GetFileVersion(const FilePath: string): string;

function GetProgramUsed(const FilePath: string): string;

implementation

uses
  Windows,
  ActiveX,
  UrlMon,
  Graphics,
  StrUtils;

function DecodeBase64(const CinLine: AnsiString): AnsiString;
const
  RESULT_ERROR = -2;
var
  inLineIndex: Integer;
  c: AnsiChar;
  x: SmallInt;
  c4: Word;
  StoredC4: array [0 .. 3] of SmallInt;
  InLineLength: Integer;
begin
  Result := '';
  inLineIndex := 1;
  c4 := 0;
  InLineLength := Length(CinLine);

  while inLineIndex <= InLineLength do
  begin
    while (inLineIndex <= InLineLength) and (c4 < 4) do
    begin
      c := CinLine[inLineIndex];
      case c of
        '+':        x := 62;
        '/':        x := 63;
        '0' .. '9': x := Ord(c) - (Ord('0') - 52);
        '=':        x := -1;
        'A' .. 'Z': x := Ord(c) - Ord('A');
        'a' .. 'z': x := Ord(c) - (Ord('a') - 26);
      else
        x := RESULT_ERROR;
      end;
      if x <> RESULT_ERROR then
      begin
        StoredC4[c4] := x;
        Inc(c4);
      end;
      Inc(inLineIndex);
    end;

    if c4 = 4 then
    begin
      c4 := 0;
      Result := Result + AnsiChar((StoredC4[0] shl 2) or (StoredC4[1] shr 4));
      if StoredC4[2] = -1 then
        Exit;
      Result := Result + AnsiChar((StoredC4[1] shl 4) or (StoredC4[2] shr 2));
      if StoredC4[3] = -1 then
        Exit;
      Result := Result + AnsiChar((StoredC4[2] shl 6) or (StoredC4[3]));
    end;
  end;
end;

function DetectStreamFormat(Stream: TStream): TStreamFormat;
  function TestICO: Boolean;
  const
    RC3_STOCKICON = 0;
    RC3_ICON = 1;
  var
    Header: TCursorOrIcon;
  begin
    Stream.Seek(0, soFromBeginning);
    Result :=
      (Stream.Read(Header, SizeOf(Header)) = SizeOf(Header)) and
      (Header.wType in [RC3_STOCKICON, RC3_ICON]);
  end;

var
  Buffer: array[0..255] of Byte;
  sz: Longint;
  pwszMIME: PWideChar;
  strMIME: string;
begin
  Assert(Assigned(Stream));

  Result := sfUnknown;
  sz := Stream.Read(Buffer, SizeOf(Buffer));
  try
    if NOERROR = FindMimeFromData(nil, nil, @Buffer, sz, nil, 0, pwszMIME, 0) then
    try
      strMIME := pwszMIME;

      if (strMIME = CFSTR_MIME_TEXT) then
        Result := sfText
      else if (strMIME = CFSTR_MIME_RICHTEXT) then
        Result := sfRichText
      else if (strMIME = CFSTR_MIME_X_BITMAP) or (strMIME = CFSTR_MIME_BMP) then
        Result := sfBitmap
      else if (strMIME = CFSTR_MIME_GIF) then
        Result := sfGif
      else if (strMIME = CFSTR_MIME_PJPEG) or (strMIME = CFSTR_MIME_JPEG) then
        Result := sfJPEGImage
      else if (strMIME = CFSTR_MIME_TIFF) then
        Result := sfTiff
      else if (strMIME = CFSTR_MIME_X_PNG) then
        Result := sfPngImage
      else if (strMIME = CFSTR_MIME_X_EMF) or (strMIME = CFSTR_MIME_X_WMF) then
        Result := sfMetafile
      else if (strMIME = CFSTR_MIME_PDF) then
        Result := sfPDF
      else if (strMIME = CFSTR_MIME_HTML) then
        Result := sfHTML
      else if TestICO then
        Result := fsIcon;
    finally
      CoTaskMemFree(pwszMIME);
    end;
  finally
    Stream.Seek(0, soFromBeginning);
  end;
end;

function GetFormattedSize(sizeInBytes: Integer; showBytes: Boolean = False): string;
const
  KILOBYTE = 1024;
  MEGABYTE = KILOBYTE * KILOBYTE;
  GIGABYTE = MEGABYTE * KILOBYTE;

  strSizes: array [0 .. 3] of string = ('GB', 'MB', 'KB', 'Bytes');
var
  c1: Extended;
  c2: Integer;
  nIndex: Integer;
  strSz: string;
  eSize: Extended;
begin
  if (sizeInBytes div GIGABYTE) <> 0 then
  begin
    c1 := sizeInBytes / GIGABYTE;
    c2 := (sizeInBytes mod GIGABYTE * 10) div GIGABYTE;
    nIndex := 0;
  end
  else if (sizeInBytes div MEGABYTE) <> 0 then
  begin
    c1 := sizeInBytes / MEGABYTE;
    c2 := (sizeInBytes mod MEGABYTE * 10) div MEGABYTE;
    nIndex := 1;
  end
  else if (sizeInBytes div KILOBYTE) <> 0 then
  begin
    c1 := sizeInBytes / KILOBYTE;
    c2 := (sizeInBytes mod KILOBYTE * 10) div KILOBYTE;
    nIndex := 2;
  end
  else
  begin
    c1 := sizeInBytes;
    c2 := 0;
    nIndex := 3;
  end;

  Assert((Low(strSizes) <= nIndex) and (nIndex <= High(strSizes)));

  if c2 = 0 then
    strSz := Format('%.0n', [c1])
  else
    strSz := Format('%.1n', [c1]);

  if (nIndex < 3) and showBytes then
  begin
    eSize := sizeInBytes;
    Result := Format('%s %s (%.0n Bytes)', [strSz, strSizes[nIndex], eSize])
  end
  else
    Result := Format('%s %s', [strSz, strSizes[nIndex]]);
end;

function GetFileVersion(const FilePath: string): string;
var
  InfoSize: DWord;
  Temp: DWord;
  Len: DWord;
  InfoBuf: Pointer;
  TranslationTable: Pointer;
  TranslationLength: Cardinal;
  CodePage: string;
  LanguageID: string;
  Value: PChar;
  LookupString: string;
begin
  Result := '';

  InfoSize := GetFileVersionInfoSize(PChar(FilePath), Temp);
  if InfoSize > 0 then
  begin
    InfoBuf := AllocMem(InfoSize);
    try
      GetFileVersionInfo(PChar(FilePath), 0, InfoSize, InfoBuf);

      if VerQueryValue(InfoBuf, '\VarFileInfo\Translation', TranslationTable, TranslationLength) then
      begin
        CodePage := Format('%.4x', [HiWord(PLongInt(TranslationTable)^)]);
        LanguageID := Format('%.4x', [LoWord(PLongInt(TranslationTable)^)]);
      end;

      LookupString := 'StringFileInfo\' + LanguageID + CodePage + '\';

      //if VerQueryValue( InfoBuf, PChar( LookupString + 'CompanyName' ), Pointer( Value ), Len ) then
      //  CompanyName := Value;
      //if VerQueryValue( InfoBuf, PChar( LookupString + 'FileDescription' ), Pointer( Value ), Len ) then
      //  FileDescription := Value;
      if VerQueryValue(InfoBuf, PChar(LookupString + 'FileVersion'), Pointer(Value), Len) then
        Result := Value;
      //if VerQueryValue( InfoBuf, PChar( LookupString + 'InternalName' ), Pointer( Value ), Len ) then
      //  InternalName := Value;
      //if VerQueryValue( InfoBuf, PChar( LookupString + 'LegalCopyright' ), Pointer( Value ), Len ) then
      //  LegalCopyright := Value;
      //if VerQueryValue( InfoBuf, PChar( LookupString + 'LegalTrademarks' ), Pointer( Value ), Len ) then
      //  LegalTradeMarks := Value;
      //if VerQueryValue( InfoBuf, PChar( LookupString + 'OriginalFilename' ), Pointer( Value ), Len ) then
      //  OriginalFilename := Value;
      //if VerQueryValue( InfoBuf, PChar( LookupString + 'ProductName' ), Pointer( Value ), Len ) then
      //  ProductName := Value;
      //if VerQueryValue( InfoBuf, PChar( LookupString + 'ProductVersion' ), Pointer( Value ), Len ) then
      //  ProductVersion := Value;
      //if VerQueryValue( InfoBuf, PChar( LookupString + 'Comments' ), Pointer( Value ), Len ) then
      //  Comments := Value;
    finally
      FreeMem(InfoBuf, InfoSize);
    end;
  end;
end;

function GetProgramUsed(const FilePath: string): string;
begin
  Result := 'MyHomeLib ' + GetFileVersion(FilePath);
end;

end.
