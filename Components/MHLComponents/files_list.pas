(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors             Oleksiy Penkov   oleksiy.penkov@gmail.com
  *                     Nick Rymanov     nrymanov@gmail.com
  * Created             20.08.2008
  * Description
  *
  * $Id: files_list.pas 1181 2015-04-01 02:06:36Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit files_list;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  SysUtils,
  Classes;

type
  TOnDirectoryEvent = procedure(Sender: TObject; const Dir: string) of object;
  TOnFileEvent = procedure(Sender: TObject; const F: TSearchRec) of object;

type
  TFilesList = class(TComponent)
  private
    FTargetPath: string;
    FLastDir: string;

    FOnDirectory: TOnDirectoryEvent;
    FOnFile: TOnFileEvent;
    FTerminate: boolean;
    FMask : string;

    procedure SetTargetPath(const S: string);

    procedure Recurs(const S: string; Level: Integer);
  public
    procedure Process;
    procedure Stop;
  published
    property TargetPath: string read FTargetPath write SetTargetPath;
    property LastDir: string read FLastDir;

    property OnDirectory: TOnDirectoryEvent read FOnDirectory write FOnDirectory;
    property OnFile: TOnFileEvent read FOnFile write FOnFile;
    property Terminate: boolean read FTerminate;
    property Mask: string write FMask;
  end;

implementation

procedure TFilesList.SetTargetPath(const S: string);
begin
  FTargetPath := IncludeTrailingPathDelimiter(S);
end;

procedure TFilesList.Stop;
begin
  FTerminate := True;
end;

procedure TFilesList.Process;
begin
  FTerminate := False;
  if FMask = '' then FMask := '*.*';
  Recurs(FTargetPath, 0);
end;

procedure TFilesList.Recurs(const S: string; Level: Integer);
var
  F: TSearchRec;
begin
  if (Level > 512) then
    Exit;

  if Assigned(FOnDirectory) then
    FOnDirectory(Self, S);

  if FindFirst(S + FMask, faAnyFile, F) = 0 then
  begin
    repeat
      if FTerminate then Break;

      FLastDir := S;
      if Assigned(FOnFile) then
        FOnFile(Self, F);

      if (F.Attr and faDirectory = faDirectory) and (F.Name <> '.') and (F.Name <> '..') then
        Recurs(IncludeTrailingPathDelimiter(S + F.Name), Level + 1);
    until FindNext(F) <> 0;

    FindClose(F);
  end;
end;

end.
