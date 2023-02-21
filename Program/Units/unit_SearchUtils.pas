(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Created             12.02.2010
  * Description
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  *
  * $Id: unit_SearchUtils.pas 642 2010-08-26 13:04:37Z eg_ $
  *
  * History
  * NickR 15.02.2010     од переформатирован
  *
  ****************************************************************************** *)

unit unit_SearchUtils;

interface

procedure AddToFilter(const Field: string; Value: string; UP: Boolean; var FilterString: string);
function PrepareQuery(S: string; UP: Boolean; ConverToFull: Boolean = True): string;

procedure AddToWhere(var Where: string; const Filter: string);

implementation

uses
  StrUtils,
  SysUtils,
  unit_Globals,
  unit_Consts;

procedure AddToFilter(const Field: string; Value: string; UP: Boolean; var FilterString: string);
var
  FixedField: string;
begin
  if Value = '' then
    Exit;

  if UP then
    FixedField := 'UPPER(' + Field + ')'
  else
    FixedField := Field;

  Value := ' ' + Value; // this way the search for ' LIKE' and such is possible for the first expression as well
  StrReplace(CRLF, ' ', Value);
  StrReplace(LF, ' ', Value);
  StrReplace(' LIKE ', ' ' + FixedField + #7 + 'LIKE ', Value);
  StrReplace('(LIKE ', ' (' + FixedField + #7 + 'LIKE ', Value);
  StrReplace(' =', ' ' + FixedField + #7 + '=', Value);
  StrReplace(' <>', ' ' + FixedField + #7 + '<>', Value);
  StrReplace(' <', ' ' + FixedField + #7 + '<', Value);
  StrReplace(' >', ' ' + FixedField + #7 + '>', Value);
  StrReplace(#7, ' ', Value);

  if FilterString <> '' then
    FilterString := FilterString + ' AND (' + Value + ')'
  else
    FilterString := '(' + Value + ')';
end;

function Clear(const S: string): string; inline;
begin
  Result := S;
  StrReplace(CRLF, ' ', Result);
  Trim(Result);
end;

// провер€ем запрос, если нативный - преобразовывам в SQL
function PrepareQuery(S: string; UP: Boolean; ConverToFull: Boolean = True): string;
begin
  if UP then
    S := Trim(AnsiUpperCase(S));

  if S = '' then
  begin
    Result := '';
    Exit;
  end;

  if ConverToFull and (Pos('%', S) = 0) and (Pos('=', S) = 0) and (Pos('"', S) = 0) and (Pos('LIKE', S) = 0) then
    S := Format('%%%s%%', [S]);

  if (Pos('=', S) = 0) and (Pos('LIKE', S) = 0) and (Pos('"', S) = 0) then
  begin
    if Pos('%', S) = 0 then
      S := '="' + S + '"'
    else
      S := 'LIKE "' + S + '"';
  end;

  Result := Clear(S);
end;

procedure AddToWhere(var Where: string; const Filter: string);
begin
  if Where = '' then
    Where := ' WHERE '
  else
    Where := Where + ' AND ';
  Where := Where + Filter;
end;

end.
