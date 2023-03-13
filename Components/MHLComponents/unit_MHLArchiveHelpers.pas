(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2011 Aleksey Penkov
  *
  * Author(s)           Aleksey Penkov
  * Created             20.05.2011
  * Description
  *
  *
  * History
  *
  ****************************************************************************** *)

unit unit_MHLArchiveHelpers;

interface

uses
  Classes,
  System.Zip;
type

  TStreamSource = record
    Name: string;
    Stream: TStream;
  end;

  TSearchMode = (smFull, smExt);

  TMHLZip = class(TObject)
    private
      FZip: TZipFile;
      FResult: Boolean;
      FLastID: Integer;
      FHeader: TZipHeader;
      function GetLastSize: Integer;
      function GetLastName: string;
    function GetFileCount: Integer;


    public
      constructor Create(AFileName: string; RO: boolean);
      destructor Destroy; override;

      function ExtractToStream(No: integer): TMemoryStream; overload;
      procedure ExtractToStream(AFileName: string; out Stream: TMemoryStream) overload;
      procedure ExtractToStream(AFileName: string; out Stream: TStream) overload;

      function GetIdxByExt(const Ext: string):Integer;
      function ExtractToString(AFileName: string):string;

      function Find(AFileName: string): Boolean;
      function FindNext: Boolean;
      function Test(const AFileName: string): Boolean;


      procedure AddFiles(const FileNames: string);
      procedure AddFromStream(const AFileName: string; AStream: TStream);
      procedure RenameFile(const OldFileName, NewFileName: string);

      property LastName: string read GetLastName;
      property FileCount: Integer read GetFileCount;
      property LastSize: Integer read GetLastSize;
  end;

  // Supported archive formats (only ones that work for both input and output)
  TArchiveFormat = (
    afZip
  );

function IsArchiveExt(const FileName: string): Boolean;

const
  ZIP_EXTENSION = '.zip';

implementation

uses
  SysUtils,
  StrUtils,
  WideStrUtils,
  IOUtils;

function IsArchiveExt(const FileName: string): Boolean;
var
  ext: string;
begin
  ext := AnsiLowercase(ExtractFileExt(FileName));
  Result := (ext = ZIP_EXTENSION);
end;

{ TMHLZip }

function TMHLZip.ExtractToStream(No: integer): TMemoryStream;
var
  S: TStream;
begin
  try
    Result := TMemoryStream.Create;
    FZip.Read(No, S, FHeader);
    Result.CopyFrom(S);
  finally
    FreeAndNil(S);
  end;
end;

procedure TMHLZip.ExtractToStream(AFileName: string; out Stream: TMemoryStream);
var
  S: TStream;
begin
  try
    FZip.Read(AFileName, S, FHeader);
    Stream.CopyFrom(S);
  finally
    FreeAndNil(S);
  end;
end;

procedure TMHLZip.ExtractToStream(AFileName: string; out Stream: TStream);
begin
  FZip.Read(AFileName, Stream, FHeader);
end;

function TMHLZip.ExtractToString(AFileName: string): string;
var
  binStream: TStream;
  strStream: TStringStream;
  S: String;
begin
  try
    FZip.Read(AFileName, binStream, FHeader);
    strStream := TStringStream.Create;
    try
      strStream.CopyFrom(binStream);
      S := strStream.DataString;
      if HasUTF8BOM(strStream.DataString) then
      begin
        Delete(S, 1, 3);
        Result := UTF8ToString(S);
      end
      else Result := S;
    finally
      FreeAndNil(strStream);
    end;
  finally
    FreeAndNil(binStream);
  end;
end;

function TMHLZip.Find(AFileName: string): Boolean;
var
  i: Integer;
  FN, ext: string;
  Mode: TSearchMode;
begin
  Result := False;
  if Pos('*.', AFileName) > 0 then
  begin
    Mode := smExt;
    ext := AFileName;
    Delete(ext, 1, 1);
  end
  else
    Mode := smFull;


  for i := 0 to High(FZip.FileInfos) do
  begin
    FN := TEncoding.UTF8.GetString(FZip.FileInfos[i].FileName);
    case Mode of
      smFull: begin
                if FN = AFileName then
                begin
                  Result := True;
                  FLastID := FZip.GetFileIndex(FN);

                  Break;
                end;
              end;
      smExt: begin
                if ext = ExtractFileExt(FN) then
                begin
                  Result := True;
                  FLastID := FZip.GetFileIndex(FN);
                  Break;
                end;
              end;
    end;

  end;
end;

function TMHLZip.FindNext: Boolean;
begin
  Result := False;
  if FLastID < High(FZip.FileInfos) then
  begin
    Inc(FLastID);
    Result := True;
  end;
end;

function TMHLZip.GetFileCount: Integer;
begin
  Result := FZip.FileCount;
end;

function TMHLZip.GetIdxByExt(const Ext: string): Integer;
var
  i: Integer;
  FN: string;
begin
  Result := -1;
  for i := 0 to High(FZip.FileInfos) do
  begin
    FN := TEncoding.UTF8.GetString(FZip.FileInfos[i].FileName);
    if ExtractFileExt(FN) = Ext then
    begin
      Result := FZip.GetFileIndex(FN);
      Break;
    end;
  end;
end;

function TMHLZip.GetLastName: string;
begin
  Result := TEncoding.UTF8.GetString(FZip.FileInfos[FLastID].FileName);
end;

function TMHLZip.GetLastSize: Integer;
begin
  Result := FZip.FileInfos[FLastID].UncompressedSize;
end;

procedure TMHLZip.RenameFile(const OldFileName, NewFileName: string);
begin

end;

function TMHLZip.Test(const AFileName: string): Boolean;
begin
 //
  Result := FZip.IsValid(AFileName)
end;

procedure TMHLZip.AddFiles(const FileNames: string);
begin
  FZip.Add(FileNames);
end;

procedure TMHLZip.AddFromStream(const AFileName: string; AStream: TStream);
begin
  FZip.Add(AStream, AFileName);
end;

constructor TMHLZip.Create(AFileName: string; RO: boolean);
begin
  Inherited Create;

  if RO and not(FileExists(AFileName)) then
  begin
    FResult := False;
    raise Exception.Create(Format('Архив %s не найден!',[AFileName]));
  end;

  FZip := TZipFile.Create;
  if RO then
    FZip.Open(AFileName, zmRead)
  else
    FZip.Open(AFileName, zmWrite);

end;

destructor TMHLZip.Destroy;
begin
  FZip.Close;
  FreeAndNil(FZip);
  inherited;
end;

end.
