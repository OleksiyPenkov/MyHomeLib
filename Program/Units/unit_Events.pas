(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           eg
  * Created             08.10.2010
  * Description
  *
  * $Id: unit_Events.pas 1100 2012-01-22 02:59:38Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_Events;

interface

uses
  Windows,
  ComCtrls,
  unit_Globals;

type
  TBookEvent = procedure(const BookRecord: TBookRecord) of object;
  TSelectBookEvent = procedure(MoveForward: Boolean) of object;
  TGetBookEvent = procedure(var BookRecord: TBookRecord) of object;
  TChangeStateEvent = procedure(State: Boolean) of object;
  TOnLocateBookEvent = procedure(const Text: string; MoveForward: Boolean) of object;
  TOnHelpEvent = function(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean of object;

  TProgressOpenEvent = procedure of object;
  TProgressHintEvent = procedure (Style: TProgressBarStyle; State: TProgressBarState) of object;
  TProgressEvent = procedure (Percent: Integer) of object;
  TProgressCloseEvent = procedure of object;
  TProgressTeletypeEvent = procedure (const Msg: string; Severity: TTeletypeSeverity) of object;
  TProgressSetCommentEvent = procedure (const Msg: string) of object;
  TProgressShowMessageEvent = function (const Text: string; Flags: Longint = MB_OK): Integer of object;

  TProgressEvent2 = procedure(Current, Total: Integer) of object;
  TProgressSetCommentEvent2 = procedure(const Current, Total: string) of object;

implementation

end.
