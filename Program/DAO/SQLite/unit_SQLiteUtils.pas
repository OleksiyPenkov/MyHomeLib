(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           eg
  *                     Nick Rymanov    nrymanov@gmail.com
  * Created             04.09.2010
  * Description
  *
  * $Id: unit_SQLiteUtils.pas 774 2010-09-16 06:38:23Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_SQLiteUtils;

interface

uses
  Classes;

  function ReadResourceAsStringList(const ResourceName: string): TStringList;

implementation

uses
  Windows,
  unit_Consts,
  SysUtils,
  StrUtils;

const
  SQL_COMMENT = '--';
  SCRIPT_NEXT = SQL_COMMENT + '@@';

//
// Read provided resource file as a string list (split by '--@@')
// This is done as ExecSQL works with only one statement at a time
//
function ReadResourceAsStringList(const ResourceName: string): TStringList;
var
  rStream: TStream;
  rScript: TStringList;
  i: Integer;
  strStatement: string;
begin
  Result := TStringList.Create;
  try
    rStream := TResourceStream.Create(HInstance, ResourceName, RT_RCDATA);
    try
      rScript := TStringList.Create;
      try
        rScript.LoadFromStream(rStream);

        strStatement := '';
        for i := 0 to rScript.Count - 1 do
        begin
          //
          // Пропустим пустые строки
          //
          if Trim(rScript[i]) = '' then
            Continue;

          //
          // Нашли конец команды. Запомним и начнем следующий цикл.
          //
          if StartsText(SCRIPT_NEXT, rScript[i]) then
          begin
            if strStatement <> '' then
              Result.Add(strStatement);
            strStatement := '';
            Continue;
          end;

          //
          // Пропустим коментарии
          //
          if StartsText(SQL_COMMENT, TrimLeft(rScript[i])) then
            Continue;

          strStatement := strStatement + rScript[i] + CRLF;
        end;

        //
        // Последняя команда может не иметь маркера завершения.
        //
        if strStatement <> '' then
          Result.Add(strStatement);
      finally
        rScript.Free;
      end;
    finally
      rStream.Free;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;


end.
