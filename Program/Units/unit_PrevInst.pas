(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             12.02.2010
  * Description
  *
  * $Id: unit_PrevInst.pas 543 2010-07-29 06:34:09Z nrymanov@gmail.com $
  *
  * History
  * NickR 15.02.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit unit_PrevInst;

interface

uses
  Windows,
  Forms,
  StrUtils,
  SysUtils;

function FirstHinstanceRunning(RunMode: Integer = 0): boolean;

implementation

function FirstHinstanceRunning(RunMode: Integer = 0): boolean;
const
  MemFileSize = 127;

var
  MemHnd: HWND;
  MemFileName: string;
  lpBaseAddress: ^HWND;
  FirstAppHandle: HWND;

begin
  Result := False;
  MemFileName := Application.ExeName;
  case RunMode of
    0: MemFileName := AnsiReplaceText(MemFileName, '\', '/');
    1: MemFileName := ExtractFileName(MemFileName);
  else
    Exit;
  end;

  // если FileMapping есть - то происходит OpenFileMapping
  MemHnd := CreateFileMapping(HWND($FFFFFFFF), nil, PAGE_READWRITE, 0, MemFileSize, PChar(MemFileName));
  if GetLastError <> ERROR_ALREADY_EXISTS then
  begin
    if MemHnd <> 0 then
    begin
      lpBaseAddress := MapViewOfFile(MemHnd, FILE_MAP_WRITE, 0, 0, 0);
      if lpBaseAddress <> nil then
        lpBaseAddress^ := Application.Handle;
    end;
  end
  else
  begin
    // MemFileHnd := OpenFileMapping(FILE_MAP_READ, False, PChar(MemFileName));
    Result := True;
    if MemHnd <> 0 then
    begin
      lpBaseAddress := MapViewOfFile(MemHnd, FILE_MAP_READ, 0, 0, 0);
      if lpBaseAddress <> nil then
      begin
        FirstAppHandle := lpBaseAddress^;
        ShowWindow(FirstAppHandle, SW_RESTORE);
        SetForegroundWindow(FirstAppHandle);
      end;
    end;
  end;

  if lpBaseAddress <> nil then
    UnMapViewOfFile(lpBaseAddress);
end;

end.
