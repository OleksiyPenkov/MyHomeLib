(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             08.09.2010
  * Description
  *
  * $Id: unit_ProgressEngine.pas 875 2010-10-25 09:10:20Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

(*

Достаточка простая progress engine.

Назначение:
  - установка хинтов прогресса в зависимости от возможности показать точный прогресс
  - генерация сообщений о ходе прогресса только в случае реального изменения прогресса

TODO:
  - названия методов не очень удачные
  - плохо обрабатывается Total = 0
  - необходимо иметь возможность менять сообщение вместе с основным прогрессом

*)

unit unit_ProgressEngine;

interface

uses
  ComCtrls,
  unit_Events;

type
  TProgressEngine = class
  private const
    DefaultThreshold = 500;

  private
    FParentEngine: TProgressEngine;

    FTotal: Integer;
    FCurrent: Integer;
    FPercent: Integer;
    FThreshold: Integer;
    FShortCommentFormat: string;
    FLongCommentFormat: string;

    FUseSubPercent: Boolean;
    FSubPercent: Integer;

    FProgressHint: TProgressHintEvent;
    FSetComment: TProgressSetCommentEvent;
    FSetProgress: TProgressEvent;

    FSubProgressHint: TProgressHintEvent;
    FSetSubComment: TProgressSetCommentEvent;
    FSetSubProgress: TProgressEvent;

    function IsPreciseProgress: Boolean; inline;
    function IsSubOperation: Boolean; inline;

    procedure ProgressChanged;

    procedure DoSetProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
    procedure DoSetComment(const Value: string);
    procedure DoSetProgress(const Value: Integer);

    procedure DoSetSubProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
    procedure DoSetSubComment(const Value: string);
    procedure DoSetSubProgress(const Value: Integer);

    procedure BeginSubOperation(const PreciseProgress: Boolean);
    procedure SetSubProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
    procedure SetSubComment(const Value: string);
    procedure SetSubProgress(const Value: Integer);

  public
    constructor Create(BaseEngine: TProgressEngine = nil);
    //destructor Done; override;

    procedure BeginOperation(const Total: Integer; const ShortCommentFormat: string; const LongCommentFormat: string);
    procedure EndOperation;
    procedure AddProgress(const Value: Integer = 1);

    function GetProgress: Integer; inline;
    function GetComment: string; inline;

    property OnProgressHint: TProgressHintEvent read FProgressHint write FProgressHint;
    property OnSetComment: TProgressSetCommentEvent read FSetComment write FSetComment;
    property OnSetProgress: TProgressEvent read FSetProgress write FSetProgress;

    property OnSubProgressHint: TProgressHintEvent read FSubProgressHint write FSubProgressHint;
    property OnSetSubComment: TProgressSetCommentEvent read FSetSubComment write FSetSubComment;
    property OnSetSubProgress: TProgressEvent read FSetSubProgress write FSetSubProgress;
  end;

implementation

uses
  SysUtils,
  StrUtils,
  Math;

{ TProgressInfo }

constructor TProgressEngine.Create(BaseEngine: TProgressEngine = nil);
begin
  inherited Create;
  FParentEngine := BaseEngine;
end;

function TProgressEngine.IsPreciseProgress: Boolean;
begin
  Result := (FTotal > 0);
end;

function TProgressEngine.IsSubOperation: Boolean;
begin
  Result := Assigned(FParentEngine);
end;

procedure TProgressEngine.DoSetProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
begin
  if IsSubOperation then
    FParentEngine.SetSubProgressHint(Style, State)
  else if Assigned(FProgressHint) then
    FProgressHint(Style, State);
end;

procedure TProgressEngine.DoSetComment(const Value: string);
begin
  if IsSubOperation then
    FParentEngine.SetSubComment(Value)
  else if Assigned(FSetComment) then
    FSetComment(Value);
end;

procedure TProgressEngine.DoSetProgress(const Value: Integer);
begin
  if IsSubOperation then
    FParentEngine.SetSubProgress(Value)
  else if Assigned(FSetProgress) then
    FSetProgress(Value);
end;

procedure TProgressEngine.DoSetSubProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
begin
  if not IsSubOperation and Assigned(FSubProgressHint) then
    FSubProgressHint(Style, State);
end;

procedure TProgressEngine.DoSetSubProgress(const Value: Integer);
begin
  if not IsSubOperation and Assigned(FSetSubProgress) then
    FSetSubProgress(Value);
end;

procedure TProgressEngine.DoSetSubComment(const Value: string);
begin
  if not IsSubOperation and Assigned(FSetSubComment) then
    FSetSubComment(Value);
end;

procedure TProgressEngine.BeginOperation(const Total: Integer; const ShortCommentFormat, LongCommentFormat: string);
begin
  FTotal := Total;
  FCurrent := 0;
  FPercent := 0;

  FUseSubPercent := False;
  FSubPercent := 0;

  FThreshold := 0;
  if IsPreciseProgress then
  begin
    FThreshold := Min(FTotal div 20, DefaultThreshold);
    if FThreshold = 0 then
      FThreshold := 1;
  end;
  if FThreshold = 0 then
    FThreshold := 1;

  FShortCommentFormat := ShortCommentFormat;
  FLongCommentFormat := LongCommentFormat;

  //
  // Это вложенная операция. Сообщим родительской операции о своем начале.
  //
  if IsSubOperation then
    FParentEngine.BeginSubOperation(IsPreciseProgress);

  //
  // Настроим GUI и приведем его в начальное состояние.
  //
  if IsPreciseProgress then
    DoSetProgressHint(pbstNormal, pbsNormal)
  else
    DoSetProgressHint(pbstMarquee, pbsNormal);
  DoSetProgress(GetProgress);
  DoSetComment(GetComment);
end;

procedure TProgressEngine.EndOperation;
begin
  DoSetProgressHint(pbstNormal, pbsNormal);
  DoSetProgress(100);
  DoSetComment(GetComment);
end;

procedure TProgressEngine.ProgressChanged;
var
  Percent: Integer;
begin
  if IsPreciseProgress then
  begin
    //
    // Эта операция использует точный прогресс
    //
    Percent := Min(FCurrent * 100 div FTotal, 100);

    //
    // Вложенная операция использует точный прогресс. Учтем его.
    //
    if FUseSubPercent then
    begin
      Inc(Percent, FSubPercent div FTotal);
    end;

    if Percent > FPercent then
    begin
      FPercent := Percent;
      DoSetProgress(GetProgress);
    end;
    if ((FCurrent mod FThreshold) = 0) then
    begin
      DoSetComment(GetComment);
    end;
  end
  else
  begin
    //
    // цикличный прогресс. Прогресс вложенно й операции не учитываем.
    //
    if ((FCurrent mod FThreshold) = 0) then
    begin
      DoSetComment(GetComment);
    end;
    if (FThreshold < 100) and (FCurrent >= (FThreshold * 10)) then
      FThreshold := Min(FCurrent div 5, DefaultThreshold);
  end;
end;

procedure TProgressEngine.AddProgress(const Value: Integer);
begin
  //
  // Считаем, что подоперация закончена и пока не начнется новая операция игнорируем подпрогресс.
  //
  FSubPercent := 0;
  FUseSubPercent := False;
  Inc(FCurrent, Value);
  ProgressChanged;
end;

function TProgressEngine.GetProgress: Integer;
begin
  Result := Min(IfThen(IsPreciseProgress, FPercent, FCurrent), 100);
end;

function TProgressEngine.GetComment: string;
begin
  Result := Format(IfThen(IsPreciseProgress, FLongCommentFormat, FShortCommentFormat), [FCurrent, FTotal]);
end;

procedure TProgressEngine.BeginSubOperation(const PreciseProgress: Boolean);
begin
  FUseSubPercent := PreciseProgress;
  FSubPercent := 0;
end;

procedure TProgressEngine.SetSubProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
begin
  DoSetSubProgressHint(Style, State);
end;

procedure TProgressEngine.SetSubComment(const Value: string);
begin
  DoSetSubComment(Value);
end;

procedure TProgressEngine.SetSubProgress(const Value: Integer);
begin
  FSubPercent := Value;
  DoSetSubProgress(Value);
  ProgressChanged;
end;

end.
