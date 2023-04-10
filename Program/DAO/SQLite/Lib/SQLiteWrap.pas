(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov    nrymanov@gmail.com
  *                     eg
  * Created             04.09.2010
  * Description         Simple SQLite wrapper.
  *                     Based on work by
  *                     Lukбљ Gebauer at http://www.ararat.cz/doku.php/en:sqlitewrap and
  *                     Tim Anderson (tim@itwriting.com)
  *
  * $Id: SQLiteWrap.pas 1126 2013-03-29 03:42:19Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit SQLiteWrap;

interface

uses
  {$IFDEF WIN32}
  Windows,
  {$ENDIF}
  SQLite3,
  Classes,
  SysUtils;

type
  {: @abstract(Exception Class for SQLite based errors)}
  ESQLiteException = class(Exception);

  TSQLiteQuery = class;

  {: @abstract(Class for handling SQLite database)}
  TSQLiteDatabase = class(TObject)
  private
    FDB: TSQLite3DB;

  protected
    procedure SetParams(query: TSQLiteQuery; const Params: array of const);
    procedure RegisterSystemCollateAndFunc;
    procedure RaiseError(const s, SQL: string);

  public
    {: Class constructor. Pass filename of database. If databas not exists, then new one is created.
    If you pass empty string as filename, then temporary database is created.
    If you pass ':memory:' as filename, then temporary database in memory is created.

    Warning:
      Pass FileName as AnsiString (if you are not using Unicode Delphi version)
      or as UnicodeString (on Delphi 2009 and higher)!
    }
    constructor Create(const FileName: string);

    {: Class descructor. Call Free instead.}
    destructor Destroy; override;

    { Run SQL command with result. }
    function NewQuery(const SQL: string): TSQLiteQuery; overload; inline;
    function NewQuery(const SQL: string; const Params: array of const): TSQLiteQuery; overload;

    { Run SQL command without result. }
    procedure ExecSQL(const SQL : string); overload; inline;
    procedure ExecSQL(const SQL : string; const Params: array of const); overload;

    procedure CompactDatabase; inline;
    procedure ReindexDatabase; inline;

    { Run SQL command and number from first field in first row is returned. }
    function QuerySingleInt(const SQL: string): Int64; overload; inline;
    function QuerySingleInt(const SQL: string; const Params: array of const): Int64; overload;

    function QuerySingleString(const SQL: string): string; overload; inline;
    function QuerySingleString(const SQL: string; const Params: array of const): string; overload;

    { Return @True if database is in transaction state.}
    function InTransaction: Boolean; inline;
    procedure Start(const name: string = ''; const param: string = '');
    procedure Commit(const name: string = '');
    procedure Rollback(const name: string = '');

    { Get ROWID of last inserted row.}
    function LastInsertRowID: Int64; inline;

    { Return number of modified rows by last query.}
    function LastChangedRows: Int64; inline;

    { Set wait timeout. if database is locked, then it wait this timeout.
       If database is not released within this timeout, then error is returned.}
    procedure SetTimeout(Value: Integer);

    { Return SQLite engine version.}
    function Version: string; inline;

    { Add custom sorting procedure as new Collate.}
    procedure AddCustomCollate(
      const CollateName: string;
      xCompare: TCollateXCompare;
      PrefferedEncoding: Integer = SQLITE_UTF16_ALIGNED
    );

    procedure AddFunction(
      const FunctionName: string;
      const nArg: Integer;
      xFunc: TxFunc;
      PrefferedEncoding: Integer = SQLITE_ANY;
      pUserDate: Pointer = nil
    );

    { SQLite database handler.}
    property DB: TSQLite3DB read FDB;
  end;

  {: @abstract(Class for handling SQLite query result)}
  TSQLiteQuery = class(TObject)
  private
    FDatabase: TSQLiteDatabase;
    FStmt: TSQLiteStmt;
    FColCount: Longint;
    FCols: TStringList;
    FRow: Cardinal;
    FEof: Boolean;
    FSQL: string;

    function GetParamIndex(const ParamName: string): Integer; inline;
    function GetColumns(const I: Integer): string; inline;
    function GetFields(const I: Integer): string; inline;
    function GetFieldIndex(const FieldName: string): Integer;
    function GetFieldByName(const FieldName: string): string;

    procedure LoadBlob(I: Integer; Stream: TStream);

  public
    {: Class constructor. Called internally by @link(TSqliteDatabase)}
    constructor Create(const DB: TSQLiteDatabase; const SQL: string);

    {: Class descructor. Call Free instead.}
    destructor Destroy; override;

    //
    // Установка параметров
    //
    procedure ParamsClear; inline;

    procedure SetParam(const ParamIndex: Integer; const Value: Int64); overload; inline;
    procedure SetParam(const ParamIndex: Integer; const Value: Double); overload; inline;
    procedure SetParam(const ParamIndex: Integer; const Value: string); overload; inline;
    procedure SetParam(const ParamIndex: Integer; const Value: Boolean); overload; inline;
    procedure SetParam(const ParamIndex: Integer; const Value: TDateTime); overload;

    procedure SetBlobParam(const ParamIndex: Integer; const Value: TStream); overload;
    procedure SetBlobParam(const ParamIndex: Integer; const Value: string); overload;

    procedure SetNullParam(const ParamIndex: Integer); overload; inline;

    procedure SetParam(const ParamName: string; const Value: Int64); overload; inline;
    procedure SetParam(const ParamName: string; const Value: Double); overload; inline;
    procedure SetParam(const ParamName: string; const Value: string); overload; inline;
    procedure SetParam(const ParamName: string; const Value: Boolean); overload; inline;
    procedure SetParam(const ParamName: string; const Value: TDateTime); overload; inline;

    procedure SetBlobParam(const ParamName: string; const Value: TStream); overload; inline;
    procedure SetBlobParam(const ParamName: string; const Value: string); overload; inline;

    procedure SetNullParam(const ParamName: string); overload; inline;

    //
    // Fields access
    //
    function FieldIsNull(I: Integer): Boolean; inline;
    function FieldAsString(I: Integer): string;
    function FieldAsInt(I: Integer): Int64; inline;
    function FieldAsBoolean(I: Integer): Boolean;
    function FieldAsDateTime(I: Integer): TDateTime;
    function FieldAsDouble(I: Integer): Double; inline;
    function FieldAsBlob(I: Integer): TStream;
    function FieldAsBlobPtr(I: Integer; out iNumBytes: Integer): Pointer; inline; deprecated;
    function FieldAsBlobString(I: Integer): string;

    //
    // Навигация и выплнение запросов
    //
    procedure ExecSQL; inline;
    procedure Open; inline;
    function Next: Boolean;
    procedure Reset; inline;

    //
    // Свойства, для упрощения текста. В большинстве своем бесполезные.
    //
    {: Return value of some field in current row.}
    property Fields[const I: Integer]: string read GetFields;

    {: Return value of named field in current row.}
    property FieldByName[const FieldName: string]: string read GetFieldByName;

    {: Return index of some named field.}
    property FieldIndex[const FieldName: string]: Integer read GetFieldIndex;

    {: Return field type of some field.}
    property Columns[const I: Integer]: string read GetColumns;

    {: Indicate last row in result set.}
    property Eof: Boolean read FEof;

    {: Return number of fields in row.}
    property ColCount: longint read FColCount;

    {: Number of current row.}
    property Row: Cardinal read FRow;
  end;

resourcestring
  c_unknown = 'Unknown error';
  c_failopen = 'Failed to open database "%s" : %s';
  c_error = '.' + sLineBreak + 'Error [%d]: %s.' + sLineBreak + '"%s": %s';
  c_nomessage = 'No message';
  c_errorsql = 'Error executing SQL';
  c_errorprepare = 'Could not prepare SQL statement';
  c_errorexec = 'Error executing SQL statement';
  c_errorempty = 'Field %s not found. Empty dataset';
  c_errorfield = 'Field not found in dataset: %s';
  c_errordata = 'Could not retrieve data';
  c_errorparam = 'SQL must include a ? parameter';
  c_errormemoryblob = 'Error getting memory to save blob';
  c_errorbindingblob = 'Error binding blob to database';
  c_errorbindingparam = 'Error binding param';

implementation

uses
{$IFDEF USELOGGER}
  unit_Logger,
  unit_Interfaces,
{$ENDIF}
  Math,
  SQLite3UDF;

const
  DATE_FORMAT = 'yyyy-mm-dd';
  TIME_FORMAT = 'hh:nn:ss.zzz';
  DATE_TIME_FORMAT = DATE_FORMAT + ' ' + TIME_FORMAT;

var
  SQLite_FormatSettings: TFormatSettings;

{ TSQLiteDatabase }

constructor TSQLiteDatabase.Create(const FileName: string);
var
  s: string;
begin
  inherited Create;

  if SQLite3_Open(PUTF8Char(UTF8String(FileName)), FDB) <> SQLITE_OK then
  begin
    if Assigned(FDB) then
      s := string(UTF8String(SQLite3_ErrMsg(FDB)))
    else
      s := c_unknown;
    raise ESQLiteException.CreateFmt(c_failopen, [FileName, s]);
  end;

  //
  // !!!!!!!! TEST ONLY !!!!!!!!
  //
  ExecSQL('PRAGMA synchronous = NORMAL');
  // Slow down:
  //  ExecSQL('PRAGMA cache_size = 16000');
  //  ExecSQL('PRAGMA count_changes = 0');
  //
  // !!!!!!!! TEST ONLY !!!!!!!!
  //

  RegisterSystemCollateAndFunc;
end;

destructor TSQLiteDatabase.Destroy;
begin
  if Assigned(FDB) then
    SQLite3_Close(FDB);

  inherited Destroy;
end;

procedure TSQLiteDatabase.RaiseError(const s, SQL: string);
var
  Msg: PAnsiChar;
  ret: Integer;
begin
  Msg := nil;
  ret := SQLite3_ErrCode(FDB);
  if ret <> SQLITE_OK then
    Msg := SQLite3_ErrMsg(FDB);

  if Assigned(Msg) then
    raise ESQLiteException.CreateFmt(s + c_error, [ret, SQLiteErrorStr(ret), SQL, Msg])
  else
    raise ESQLiteException.CreateFmt(s, [SQL, c_nomessage]);
end;

procedure TSQLiteDatabase.SetParams(query: TSQLiteQuery; const Params: array of const);
var
  i: Integer;
begin
  Assert(Assigned(query));

  for i := 0 to High(Params) do
  case Params[i].VType of
    vtInteger:       query.SetParam(i, Params[i].VInteger);
    vtBoolean:       query.SetParam(i, Params[i].VBoolean);
    //vtChar:          query.SetParam(i, Params[i].VChar);
    //vtExtended:      query.SetParam(i, Params[i].VExtended^);
    //vtString:        query.SetParam(i, Params[i].VString^);
    //vtPChar:         query.SetParam(i, Params[i].VPChar);
    //vtObject:        query.SetParam(i, Params[i].VObject.ClassName);
    //vtClass:         query.SetParam(i, Params[i].VClass.ClassName);
    //vtWideChar:;
    //vtPWideChar:;
    vtAnsiString:    query.SetParam(i, string(Params[i].VAnsiString));
    //vtCurrency:      query.SetParam(i, Params[i].VCurrency^);
    //vtVariant:       query.SetParam(i, Params[i].VVariant^);
    vtInt64:         query.SetParam(i, Params[i].VInt64^);
    vtUnicodeString: query.SetParam(i, string(Params[i].VUnicodeString));
  else
    raise ESQLiteException.Create('Unsupported param type');
  end;
end;

function TSQLiteDatabase.NewQuery(const SQL: string): TSQLiteQuery;
begin
  Result := TSQLiteQuery.Create(Self, SQL);
end;

function TSQLiteDatabase.NewQuery(const SQL: string; const Params: array of const): TSQLiteQuery;
begin
  Result := TSQLiteQuery.Create(Self, SQL);
  SetParams(Result, Params);
end;

procedure TSQLiteDatabase.ExecSQL(const SQL: string);
begin
  ExecSQL(SQL, []);
end;

procedure TSQLiteDatabase.ExecSQL(const SQL : string; const Params: array of const);
var
  query: TSQLiteQuery;
begin
  query := NewQuery(SQL, Params);
  try
    query.ExecSQL;
  finally
    query.Free;
  end;
end;

procedure TSQLiteDatabase.CompactDatabase;
const
  SQL = 'VACUUM';
begin
  ExecSQL(SQL);
end;

procedure TSQLiteDatabase.ReindexDatabase;
const
  SQL = 'ANALYZE';
begin
  ExecSQL(SQL);
end;

function TSQLiteDatabase.QuerySingleInt(const SQL: string): Int64;
begin
  Result := QuerySingleInt(SQL, []);
end;

function TSQLiteDatabase.QuerySingleInt(const SQL: string; const Params: array of const): Int64;
var
  query: TSQLiteQuery;
begin
  Result := 0;
  query := NewQuery(SQL, Params);
  try
    query.Open;
    if not query.EOF then
      Result := query.FieldAsInt(0);
  finally
    query.Free;
  end;
end;

function TSQLiteDatabase.QuerySingleString(const SQL: string): string;
begin
  Result := QuerySingleString(SQL, []);
end;

function TSQLiteDatabase.QuerySingleString(const SQL: string; const Params: array of const): string;
var
  query: TSQLiteQuery;
begin
  Result := '';
  query := NewQuery(SQL, Params);
  try
    query.Open;
    if not query.EOF then
      Result := query.FieldAsString(0);
  finally
    query.Free;
  end;
end;

function TSQLiteDatabase.InTransaction: Boolean;
begin
  Result := SQLite3_Get_Autocommit(FDB) = 0;
end;

procedure TSQLiteDatabase.Start(const name: string = ''; const param: string = '');
var
  s: string;
begin
  if name = '' then
  begin
    s := 'BEGIN';
    if param <> '' then
      s := s + ' ' + param;
    ExecSQL(s);
  end
  else
    ExecSQL('SAVEPOINT ' + name);
end;

procedure TSQLiteDatabase.Commit(const name: string = '');
begin
  if name = '' then
    ExecSQL('COMMIT')
  else
    ExecSQL('RELEASE ' + name);
end;

procedure TSQLiteDatabase.Rollback(const name: string = '');
begin
  if name = '' then
    ExecSQL('ROLLBACK')
  else
    ExecSQL('ROLLBACK TO ' + name);
end;

function TSQLiteDatabase.LastInsertRowID: int64;
begin
  Result := SQLite3_LastInsertRowID(FDB);
end;

function TSQLiteDatabase.LastChangedRows: int64;
begin
  Result := SQLite3_Changes(FDB);
end;

procedure TSQLiteDatabase.SetTimeout(Value: Integer);
begin
  SQLite3_BusyTimeout(FDB, Value);
end;

function TSQLiteDatabase.Version: string;
begin
  Result := string(UTF8String(SQLite3_Version));
end;

procedure TSQLiteDatabase.AddCustomCollate(const CollateName: string; xCompare: TCollateXCompare; PrefferedEncoding: Integer = SQLITE_UTF16_ALIGNED);
var
  nRc: Integer;
begin
  nRc := SQLite3_Create_Collation(FDB, PUTF8Char(UTF8String(CollateName)), PrefferedEncoding, nil, xCompare);
  if SQLITE_OK <> nRc then
    RaiseError('', 'CollateName');
end;

procedure TSQLiteDatabase.AddFunction(const FunctionName: string; const nArg: Integer; xFunc: TxFunc; PrefferedEncoding: Integer = SQLITE_ANY; pUserDate: Pointer = nil);
var
  nRc: Integer;
begin
  nRc := SQLite3_Create_Function(FDB, PUTF8Char(UTF8String(FunctionName)), nArg, PrefferedEncoding, pUserDate, @xFunc, nil, nil);
  if SQLITE_OK <> nRc then
    RaiseError('', FunctionName);
end;

procedure TSQLiteDatabase.RegisterSystemCollateAndFunc;
begin
  AddCustomCollate('MHL_SYSTEM',        SystemCollate);
  AddCustomCollate('MHL_SYSTEM_NOCASE', SystemCollateNoCase);

  AddFunction('MHL_UPPER', 1, SystemUpperString);
  AddFunction('MHL_LOWER', 1, SystemLowerString);
end;

{ TSQLiteQuery }

constructor TSQLiteQuery.Create(const DB: TSQLiteDatabase; const SQL: string);
var
  NextSQLStatement: PUTF8Char;
  i: Integer;
begin
  inherited Create;

  FDatabase := db;
  FEof := False;
  FRow := 0;
  FColCount := 0;
  FSQL := SQL;

  if SQLITE_OK <> Sqlite3_Prepare_v2(FDatabase.FDB, PUTF8Char(UTF8String(FSQL)), -1, FStmt, NextSQLStatement) then
    DB.RaiseError(c_errorsql, FSQL);

  if not Assigned(FStmt) then
    DB.RaiseError(c_errorprepare, FSQL);

  //get data types
  FCols := TStringList.Create;
  FColCount := SQLite3_ColumnCount(FStmt);
  for i := 0 to FColCount - 1 do
    FCols.Add(string(UTF8String(SQLite3_ColumnName(FStmt, i))));
end;

destructor TSQLiteQuery.Destroy;
begin
  if Assigned(FStmt) then
  begin
    Sqlite3_Finalize(FStmt);
    FStmt := nil;
  end;

  if Assigned(FCols) then
    FreeAndNil(FCols);

  inherited;
end;

function TSQLiteQuery.GetColumns(const I: Integer): string;
begin
  Assert(Assigned(FCols));
  Result := FCols[I];
end;

procedure TSQLiteQuery.ParamsClear;
begin
  SQLite3_clear_bindings(FStmt);
end;

function TSQLiteQuery.GetParamIndex(const ParamName: string): Integer;
var
  i: Integer;
begin
  i := SQLite3_bind_parameter_index(FStmt, PUTF8Char(UTF8String(ParamName)));
  if i > 0 then
    Result := i - 1
  else
    FDatabase.RaiseError(c_errorbindingparam, FSQL);
end;

procedure TSQLiteQuery.SetParam(const ParamIndex: Integer; const Value: Int64);
begin
  if SQLITE_OK <> SQLite3_bind_int64(FStmt, ParamIndex + 1, Value) then
    FDatabase.RaiseError(c_errorbindingparam, FSQL);
end;

procedure TSQLiteQuery.SetParam(const ParamIndex: Integer; const Value: Double);
begin
  if SQLITE_OK <> SQLite3_bind_double(FStmt, ParamIndex + 1, Value) then
    FDatabase.RaiseError(c_errorbindingparam, FSQL);
end;

procedure TSQLiteQuery.SetParam(const ParamIndex: Integer; const Value: string);
var
  valueUTF8: UTF8String;
begin
  valueUTF8 := UTF8String(Value);
  if SQLITE_OK <> SQLite3_bind_text(FStmt, ParamIndex + 1, PUTF8Char(valueUTF8), Length(valueUTF8), SQLITE_TRANSIENT) then
    FDatabase.RaiseError(c_errorbindingparam, FSQL);
end;

procedure TSQLiteQuery.SetParam(const ParamIndex: Integer; const Value: Boolean);
begin
  if Value then
    SetParam(ParamIndex, 1)
  else
    SetParam(ParamIndex, 0);
end;

procedure TSQLiteQuery.SetParam(const ParamIndex: Integer; const Value: TDateTime);
begin
  SetParam(ParamIndex, DateTimeToStr(Value, SQLite_FormatSettings));
end;

procedure TSQLiteQuery.SetBlobParam(const ParamIndex: Integer; const Value: TStream);
var
  iSize: Integer;
  ptrBuff: Pointer;
begin
  Value.Position := 0;
  iSize := Value.Size;

  if iSize <> 0 then
  begin
    ptrBuff := SQlite3_Malloc(iSize);
    if not Assigned(ptrBuff) then
      FDatabase.RaiseError(c_errormemoryblob, '');

    Value.Read(ptrBuff^, iSize);
    if SQLITE_OK <> SQLite3_Bind_Blob(FStmt, ParamIndex + 1, ptrBuff, iSize, SQLite3_Free) then
      FDatabase.RaiseError(c_errorbindingparam, FSQL);
  end
  else
    SetNullParam(ParamIndex);
end;

procedure TSQLiteQuery.SetBlobParam(const ParamIndex: Integer; const Value: string);
var
  strStream: TStringStream;
begin
  if Value = '' then
    SetNullParam(ParamIndex)
  else
  begin
    strStream := TStringStream.Create(Value, TEncoding.UTF8, False);
    try
      SetBlobParam(ParamIndex, strStream);
    finally
      strStream.Free;
    end;
  end;
end;

procedure TSQLiteQuery.SetNullParam(const ParamIndex: Integer);
begin
  if SQLITE_OK <> SQLite3_bind_null(FStmt, ParamIndex + 1) then
    FDatabase.RaiseError(c_errorbindingparam, FSQL);
end;

procedure TSQLiteQuery.SetParam(const ParamName: string; const Value: Int64);
begin
  SetParam(GetParamIndex(ParamName), Value);
end;

procedure TSQLiteQuery.SetParam(const ParamName: string; const Value: Double);
begin
  SetParam(GetParamIndex(ParamName), Value);
end;

procedure TSQLiteQuery.SetParam(const ParamName: string; const Value: string);
begin
  SetParam(GetParamIndex(ParamName), Value);
end;

procedure TSQLiteQuery.SetParam(const ParamName: string; const Value: Boolean);
begin
  SetParam(GetParamIndex(ParamName), Value);
end;

procedure TSQLiteQuery.SetParam(const ParamName: string; const Value: TDateTime);
begin
  SetParam(GetParamIndex(ParamName), Value);
end;

procedure TSQLiteQuery.SetBlobParam(const ParamName: string; const Value: TStream);
begin
  SetBlobParam(GetParamIndex(ParamName), Value);
end;

procedure TSQLiteQuery.SetBlobParam(const ParamName: string; const Value: string);
begin
  SetBlobParam(GetParamIndex(ParamName), Value);
end;

procedure TSQLiteQuery.SetNullParam(const ParamName: string);
begin
  SetNullParam(GetParamIndex(ParamName));
end;

function TSQLiteQuery.GetFields(const I: Integer): string;
begin
  Result := string(UTF8String(Sqlite3_ColumnText(FStmt, i)));
end;

function TSQLiteQuery.GetFieldIndex(const FieldName: string): Integer;
begin
  if not Assigned(FCols) or (FCols.Count = 0) then
    raise ESQLiteException.Create(Format(c_errorempty, [FieldName]));

  Result := FCols.IndexOf(AnsiUpperCase(FieldName));

  if (Result < 0) then
    raise ESQLiteException.Create(Format(c_errorfield, [FieldName]))
end;

function TSQLiteQuery.GetFieldByName(const FieldName: string): string;
begin
  Result := GetFields(GetFieldIndex(FieldName));
end;

function TSQLiteQuery.FieldIsNull(I: Integer): Boolean;
begin
  Result := SQLite3_ColumnText(FStmt, i) = nil;
end;

function TSQLiteQuery.FieldAsString(I: Integer): string;
begin
  Result := GetFields(I);
end;

function TSQLiteQuery.FieldAsInt(I: Integer): Int64;
begin
  Result := SQLite3_ColumnInt64(FStmt, i);
end;

function TSQLiteQuery.FieldAsBoolean(I: Integer): Boolean;
var
  IntVal: Integer;
begin
  IntVal := FieldAsInt(I);
  Result := (IntVal = 1);
end;

function TSQLiteQuery.FieldAsDateTime(I: Integer): TDateTime;
var
  StringVal: string;
begin
  StringVal := FieldAsString(I);
  Result := StrToDateTime(StringVal, SQLite_FormatSettings);
end;

function TSQLiteQuery.FieldAsDouble(I: Integer): Double;
begin
  Result := SQLite3_ColumnDouble(FStmt, i);
end;

procedure TSQLiteQuery.LoadBlob(I: Integer; Stream: TStream);
var
  iNumBytes: Integer;
  ptr: Pointer;
begin
  Assert(Assigned(Stream));
  iNumBytes := SQLite3_ColumnBytes(FStmt, i);
  if iNumBytes > 0 then
  begin
    ptr := Sqlite3_ColumnBlob(FStmt, i);
    Stream.WriteBuffer(ptr^, iNumBytes);
    Stream.Position := 0;
  end;
end;

function TSQLiteQuery.FieldAsBlob(I: Integer): TStream;
begin
  Result := TMemoryStream.Create;
  LoadBlob(i, Result);
end;

function TSQLiteQuery.FieldAsBlobPtr(I: Integer; out iNumBytes: Integer): Pointer;
begin
  iNumBytes := SQLite3_ColumnBytes(FStmt, i);
  Result := SQLite3_ColumnBlob(FStmt, i);
end;

function TSQLiteQuery.FieldAsBlobString(I: Integer): string;
var
  strStream: TStringStream;
begin
  strStream := TStringStream.Create('', TEncoding.UTF8, False);
  try
    LoadBlob(i, strStream);
    Result := strStream.DataString;
  finally
    strStream.Free;
  end;
end;

procedure TSQLiteQuery.ExecSQL;
{$IFDEF USELOGGER}
var
  Logger: IIntervalLogger;
begin
  Logger := GetIntervalLogger('TSQLiteQuery.ExecSQL', FSQL);
{$ELSE}
begin
{$ENDIF}
  try
    if SQLITE_DONE <> SQLite3_Step(FStmt) then
      FDatabase.RaiseError(c_errorexec, FSQL);
  finally
    Reset;
  end;
end;

procedure TSQLiteQuery.Open;
{$IFDEF USELOGGER}
var
  Logger: IIntervalLogger;
begin
  Logger := GetIntervalLogger('TSQLiteQuery.Open', FSQL);
{$ELSE}
begin
{$ENDIF}
  Next;
end;

function TSQLiteQuery.Next: Boolean;
begin
  FEof := True;
  case SQLite3_Step(FStmt) of
    SQLITE_ROW:
      begin
        FEof := False;
        Inc(fRow);
      end;

    SQLITE_DONE:
      // we are on the end of dataset
      // return EOF=true only
      ;

    else
      begin
        Reset;
        FDatabase.RaiseError(c_errordata, FSQL);
      end;
  end;
  Result := not FEof;
end;

procedure TSQLiteQuery.Reset;
begin
  SQLite3_Reset(FStmt);
end;

initialization
  SQLite3_Initialize;
  {$IFDEF  WIN32}
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, SQLite_FormatSettings);
  {$ELSE}
    GetLocaleFormatSettings($0800, SQLite_FormatSettings);
  {$ENDIF}

  SQLite_FormatSettings.ShortDateFormat := DATE_FORMAT;
  SQLite_FormatSettings.LongDateFormat := DATE_FORMAT;
  SQLite_FormatSettings.DateSeparator := '-';
  SQLite_FormatSettings.ShortTimeFormat := TIME_FORMAT;
  SQLite_FormatSettings.LongTimeFormat := TIME_FORMAT;
  SQLite_FormatSettings.TimeSeparator := ':';

finalization
  SQLite3_Shutdown;
end.

