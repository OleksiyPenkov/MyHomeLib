(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             22.08.2026
  * Description         Потік читання zstd через libzstd.dll (динамічне
  *                     завантаження: без DLL страждає лише імпорт metabib)
  *                     libzstd.dll: офіційні збірки facebook/zstd v1.5.7
  *                     (github.com/facebook/zstd/releases), Win32+Win64
  *
  ****************************************************************************** *)

unit unit_ZstdStream;

interface

uses
  Windows,
  SysUtils,
  Classes;

type
  EZstdError = class(Exception);

  TZstdDecompressionStream = class(TStream)
  private
    FSource: TStream;
    FOwnsSource: Boolean;
    FDStream: Pointer;
    FInBuf: TBytes;
    FOutBuf: TBytes;
    FInSize: NativeUInt;   // valid bytes in FInBuf
    FInPos: NativeUInt;    // consumed bytes in FInBuf
    FOutLen: Integer;      // valid bytes in FOutBuf
    FOutPos: Integer;      // consumed bytes in FOutBuf
    FPosition: Int64;
    FLastRet: NativeUInt;  // 0 = frame complete
    function FillOutBuffer: Boolean;
  public
    constructor Create(ASource: TStream; AOwnsSource: Boolean);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
  end;

implementation

uses
  IOUtils;

resourcestring
  rstrZstdDllMissing = 'Не знайдено бібліотеку %s. Імпорт каталогів metabib недоступний.';
  rstrZstdError = 'Помилка zstd: %s';
  rstrZstdTruncated = 'Файл zstd обірваний або пошкоджений.';

const
  ZSTD_DLL = 'libzstd.dll';

type
  ZSTD_inBuffer = record
    src: Pointer;
    size: NativeUInt;
    pos: NativeUInt;
  end;

  ZSTD_outBuffer = record
    dst: Pointer;
    size: NativeUInt;
    pos: NativeUInt;
  end;

var
  ZstdLib: HMODULE = 0;
  ZSTD_createDStream: function: Pointer; cdecl;
  ZSTD_freeDStream: function(zds: Pointer): NativeUInt; cdecl;
  ZSTD_initDStream: function(zds: Pointer): NativeUInt; cdecl;
  ZSTD_decompressStream: function(zds: Pointer; var output: ZSTD_outBuffer;
    var input: ZSTD_inBuffer): NativeUInt; cdecl;
  ZSTD_isError: function(code: NativeUInt): Cardinal; cdecl;
  ZSTD_getErrorName: function(code: NativeUInt): PAnsiChar; cdecl;
  ZSTD_DStreamInSize: function: NativeUInt; cdecl;
  ZSTD_DStreamOutSize: function: NativeUInt; cdecl;

procedure LoadZstd;
var
  Path: string;

  function Bind(const Name: string): Pointer;
  begin
    Result := GetProcAddress(ZstdLib, PChar(Name));
    if not Assigned(Result) then
    begin
      FreeLibrary(ZstdLib);
      ZstdLib := 0;
      raise EZstdError.CreateFmt(rstrZstdDllMissing, [ZSTD_DLL]);
    end;
  end;

begin
  if ZstdLib <> 0 then
    Exit;

  Path := TPath.Combine(ExtractFilePath(ParamStr(0)), ZSTD_DLL);
  ZstdLib := LoadLibrary(PChar(Path));
  if ZstdLib = 0 then
    raise EZstdError.CreateFmt(rstrZstdDllMissing, [ZSTD_DLL]);

  ZSTD_createDStream := Bind('ZSTD_createDStream');
  ZSTD_freeDStream := Bind('ZSTD_freeDStream');
  ZSTD_initDStream := Bind('ZSTD_initDStream');
  ZSTD_decompressStream := Bind('ZSTD_decompressStream');
  ZSTD_isError := Bind('ZSTD_isError');
  ZSTD_getErrorName := Bind('ZSTD_getErrorName');
  ZSTD_DStreamInSize := Bind('ZSTD_DStreamInSize');
  ZSTD_DStreamOutSize := Bind('ZSTD_DStreamOutSize');
end;

procedure CheckZstd(Code: NativeUInt);
begin
  if ZSTD_isError(Code) <> 0 then
    raise EZstdError.CreateFmt(rstrZstdError, [string(AnsiString(ZSTD_getErrorName(Code)))]);
end;

{ TZstdDecompressionStream }

constructor TZstdDecompressionStream.Create(ASource: TStream; AOwnsSource: Boolean);
begin
  inherited Create;
  FSource := ASource;
  FOwnsSource := AOwnsSource;
  LoadZstd;
  FDStream := ZSTD_createDStream;
  if not Assigned(FDStream) then
    raise EZstdError.CreateFmt(rstrZstdError, ['ZSTD_createDStream']);
  CheckZstd(ZSTD_initDStream(FDStream));
  SetLength(FInBuf, ZSTD_DStreamInSize);
  SetLength(FOutBuf, ZSTD_DStreamOutSize);
  FLastRet := 1; // усередині кадру, поки не доведено інше
end;

destructor TZstdDecompressionStream.Destroy;
begin
  if Assigned(FDStream) then
    ZSTD_freeDStream(FDStream);
  if FOwnsSource then
    FreeAndNil(FSource);
  inherited Destroy;
end;

//
// Наповнює FOutBuf наступною порцією. False - дані скінчились.
//
function TZstdDecompressionStream.FillOutBuffer: Boolean;
var
  InBuf: ZSTD_inBuffer;
  OutBuf: ZSTD_outBuffer;
  BytesRead: Integer;
begin
  FOutLen := 0;
  FOutPos := 0;

  repeat
    if FInPos >= FInSize then
    begin
      BytesRead := FSource.Read(FInBuf[0], Length(FInBuf));
      if BytesRead <= 0 then
      begin
        if FLastRet = 0 then
          Exit(False); // кадр завершено, джерело вичерпано - штатний кінець
        raise EZstdError.Create(rstrZstdTruncated);
      end;
      FInSize := NativeUInt(BytesRead);
      FInPos := 0;
    end;

    InBuf.src := @FInBuf[0];
    InBuf.size := FInSize;
    InBuf.pos := FInPos;

    OutBuf.dst := @FOutBuf[0];
    OutBuf.size := NativeUInt(Length(FOutBuf));
    OutBuf.pos := 0;

    FLastRet := ZSTD_decompressStream(FDStream, OutBuf, InBuf);
    CheckZstd(FLastRet);

    FInPos := InBuf.pos;
    FOutLen := Integer(OutBuf.pos);
  until FOutLen > 0;

  Result := True;
end;

function TZstdDecompressionStream.Read(var Buffer; Count: Longint): Longint;
var
  Dest: PByte;
  Chunk: Integer;
begin
  Dest := @Buffer;
  Result := 0;
  while Count > 0 do
  begin
    if FOutPos >= FOutLen then
      if not FillOutBuffer then
        Break;

    Chunk := FOutLen - FOutPos;
    if Chunk > Count then
      Chunk := Count;
    Move(FOutBuf[FOutPos], Dest^, Chunk);
    Inc(FOutPos, Chunk);
    Inc(Dest, Chunk);
    Dec(Count, Chunk);
    Inc(Result, Chunk);
  end;
  Inc(FPosition, Result);
end;

function TZstdDecompressionStream.Write(const Buffer; Count: Longint): Longint;
begin
  raise EZstdError.Create('TZstdDecompressionStream is read-only');
end;

function TZstdDecompressionStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  // Підтримуємо лише запит позиції (TStream.Position); перемотування нема.
  if (Origin = soCurrent) and (Offset = 0) then
    Result := FPosition
  else if (Origin = soBeginning) and (Offset = FPosition) then
    Result := FPosition
  else
    raise EZstdError.Create('TZstdDecompressionStream: seek is not supported');
end;

initialization

finalization
  if ZstdLib <> 0 then
    FreeLibrary(ZstdLib);

end.
