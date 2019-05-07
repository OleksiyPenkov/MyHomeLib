unit SQLite3;

{
  Simplified interface for SQLite.

  This version :Ported to D2009 Unicode by Roger Lascelles (support@veecad.com)
  V2.0.0  29 June 2010

  History
  Reworked by Lukáš Gebauer at http://www.ararat.cz/doku.php/en:sqlitewrap.
  Updated for Sqlite 3 by Tim Anderson (tim@itwriting.com)
  Note: NOT COMPLETE for version 3, just minimal functionality
  Adapted from file created by Pablo Pissanetzky (pablo@myhtpc.net)
  which was based on SQLite.pas by Ben Hochstrasser (bhoc@surfeu.ch)

  Require: Delphi 6+, FreePascal
}

{$IFDEF FPC}
  {$MODE DELPHI}
  {$H+}            (* use AnsiString *)
  {$PACKENUM 4}    (* use 4-byte enums *)
  {$PACKRECORDS C} (* C/C++-compatible record packing *)
{$ELSE}
  {$MINENUMSIZE 4} (* use 4-byte enums *)
{$ENDIF}

interface

const
{$IF Defined(MSWINDOWS)}
  SQLiteDLL = 'sqlite3.dll';
{$ELSEIF Defined(DARWIN)}
  SQLiteDLL = 'libsqlite3.dylib';
  {$linklib libsqlite3}
{$ELSEIF Defined(UNIX)}
  SQLiteDLL = 'sqlite3.so';
{$IFEND}

// Return values for sqlite3_exec() and sqlite3_step()

const
  SQLITE_OK          =  0; // Successful result
  (* beginning-of-error-codes *)
  SQLITE_ERROR       =  1; // SQL error or missing database
  SQLITE_INTERNAL    =  2; // Internal logic error in SQLite
  SQLITE_PERM        =  3; // Access permission denied
  SQLITE_ABORT       =  4; // Callback routine requested an abort
  SQLITE_BUSY        =  5; // The database file is locked
  SQLITE_LOCKED      =  6; // A table in the database is locked
  SQLITE_NOMEM       =  7; // A malloc() failed
  SQLITE_READONLY    =  8; // Attempt to write a readonly database
  SQLITE_INTERRUPT   =  9; // Operation terminated by sqlite3_interrupt()
  SQLITE_IOERR       = 10; // Some kind of disk I/O error occurred
  SQLITE_CORRUPT     = 11; // The database disk image is malformed
  SQLITE_NOTFOUND    = 12; // NOT USED. Table or record not found
  SQLITE_FULL        = 13; // Insertion failed because database is full
  SQLITE_CANTOPEN    = 14; // Unable to open the database file
  SQLITE_PROTOCOL    = 15; // Database lock protocol error
  SQLITE_EMPTY       = 16; // Database is empty
  SQLITE_SCHEMA      = 17; // The database schema changed
  SQLITE_TOOBIG      = 18; // String or BLOB exceeds size limit
  SQLITE_CONSTRAINT  = 19; // Abort due to constraint violation
  SQLITE_MISMATCH    = 20; // Data type mismatch
  SQLITE_MISUSE      = 21; // Library used incorrectly
  SQLITE_NOLFS       = 22; // Uses OS features not supported on host
  SQLITE_AUTH        = 23; // Authorization denied
  SQLITE_FORMAT      = 24; // Auxiliary database format error
  SQLITE_RANGE       = 25; // 2nd parameter to sqlite3_bind out of range
  SQLITE_NOTADB      = 26; // File opened that is not a database file
  SQLITE_ROW         = 100; //sqlite3_step() has another row ready
  SQLITE_DONE        = 101; //sqlite3_step() has finished executing

  //
  // Fundamental Datatypes
  //
  SQLITE_INTEGER = 1;
  SQLITE_FLOAT   = 2;
  SQLITE_TEXT    = 3;
  SQLITE3_TEXT   = 3;
  SQLITE_BLOB    = 4;
  SQLITE_NULL    = 5;

  //
  // These constant define integer codes that represent the various text encodings supported by SQLite.
  //
  SQLITE_UTF8           = 1;
  SQLITE_UTF16LE        = 2;
  SQLITE_UTF16BE        = 3;
  SQLITE_UTF16          = 4; // Use native byte order
  SQLITE_ANY            = 5; // sqlite3_create_function only
  SQLITE_UTF16_ALIGNED  = 8; // sqlite3_create_collation only

  //
  // Constants Defining Special Destructor Behavior
  //
  SQLITE_STATIC    {: TSQLite3Destructor} = Pointer(0);
  SQLITE_TRANSIENT {: TSQLite3Destructor} = Pointer(-1);

  //
  // Flags For File Open Operations
  //
  SQLITE_OPEN_READONLY       =  $00000001;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_READWRITE      =  $00000002;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_CREATE         =  $00000004;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_DELETEONCLOSE  =  $00000008;  // VFS only
  SQLITE_OPEN_EXCLUSIVE      =  $00000010;  // VFS only
  SQLITE_OPEN_AUTOPROXY      =  $00000020;  // VFS only
  SQLITE_OPEN_MAIN_DB        =  $00000100;  // VFS only
  SQLITE_OPEN_TEMP_DB        =  $00000200;  // VFS only
  SQLITE_OPEN_TRANSIENT_DB   =  $00000400;  // VFS only
  SQLITE_OPEN_MAIN_JOURNAL   =  $00000800;  // VFS only
  SQLITE_OPEN_TEMP_JOURNAL   =  $00001000;  // VFS only
  SQLITE_OPEN_SUBJOURNAL     =  $00002000;  // VFS only
  SQLITE_OPEN_MASTER_JOURNAL =  $00004000;  // VFS only
  SQLITE_OPEN_NOMUTEX        =  $00008000;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_FULLMUTEX      =  $00010000;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_SHAREDCACHE    =  $00020000;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_PRIVATECACHE   =  $00040000;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_WAL            =  $00080000;  // VFS only


type
  PUTF8Char = PAnsiChar;
  PPUTF8Char = ^PUTF8Char;

  TSQLite3DB = Pointer;
  TSQLiteStmt = Pointer;
  TSQLite3Context = Pointer;
  TSQLite3Value = PPChar;

  TxFunc = procedure(pCtx: TSQLite3Context; cArg: Integer; Args: TSQLite3Value); cdecl;
  TxStep = procedure(pCtx: TSQLite3Context; cArg: Integer; Args: TSQLite3Value); cdecl;
  TxFinal = procedure(pCtx: TSQLite3Context); cdecl;

  TSQLite3Destructor = procedure(Ptr: Pointer); cdecl;

  //function prototype for define own collate
  TCollateXCompare = function(UserData: Pointer; Buf1Len: Integer; Buf1: Pointer; Buf2Len: Integer; Buf2: Pointer): integer; cdecl;

function SQLite3_Initialize: Integer; cdecl; external SQLiteDLL name 'sqlite3_initialize';
function SQLite3_Shutdown: Integer; cdecl; external SQLiteDLL name 'sqlite3_shutdown';
function SQLite3_Version: PUTF8Char; cdecl; external SQLiteDLL name 'sqlite3_libversion';

function SQLite3_Open(
  filename: PUTF8Char; // Database filename (UTF-8)
  var db: TSQLite3DB   // OUT: SQLite db handle
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_open';

function SQLite3_Open16(
  FileName: PWideChar; // Database filename (UTF-16)
  var db: TSQLite3DB   // OUT: SQLite db handle
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_open16';

function SQLite3_Open_v2(
  FileName: PUTF8Char; // Database filename (UTF-8) */
  var db: TSQLite3DB;  // OUT: SQLite db handle */
  flags: Integer;      // Flags
  zVfs: PUTF8Char      // Name of VFS module to use
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_open_v2';

function SQLite3_Close(
  db: TSQLite3DB
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_close';

function SQLite3_ErrMsg(
  db: TSQLite3DB
  ): PUTF8Char; cdecl; external SQLiteDLL name 'sqlite3_errmsg';

function SQLite3_ErrMsg16(
  db: TSQLite3DB
  ): PWideChar; cdecl; external SQLiteDLL name 'sqlite3_errmsg16';

function SQLite3_ErrCode(
  db: TSQLite3DB
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_errcode';

function SQLite3_Extended_ErrCode(
  db: TSQLite3DB
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_extended_errcode';

function SQlite3_Malloc(
  nBytes: Integer
  ): Pointer; cdecl; external SQLiteDLL name 'sqlite3_malloc';

function SQlite3_Realloc(
  pBuffer: Pointer;
  nBytes: Integer
  ): Pointer; cdecl; external SQLiteDLL name 'sqlite3_realloc';

procedure SQlite3_Free(
  P: Pointer
  ); cdecl; external SQLiteDLL name 'sqlite3_free';

function SQLite3_LastInsertRowID(
  db: TSQLite3DB
  ): Int64; cdecl; external SQLiteDLL name 'sqlite3_last_insert_rowid';

procedure SQLite3_BusyTimeout(
  db: TSQLite3DB;
  msTimeOut: Integer
  ); cdecl; external SQLiteDLL name 'sqlite3_busy_timeout';

function SQLite3_Changes(
  db: TSQLite3DB
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_changes';

function SQLite3_Prepare_v2(
  db: TSQLite3DB;            // Database handle
  SQLStatement: PUTF8Char;   // SQL statement, UTF-8 encoded
  nBytes: Integer;           // Maximum length of SQLStatement in bytes
  var hStmt: TSQLiteStmt;    // OUT: Statement handle
  var pzTail: PUTF8Char      // OUT: Pointer to unused portion of SQLStatement
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_prepare_v2';

function SQLite3_Prepare16_v2(
  db: TSQLite3DB;            // Database handle
  SQLStatement: PWideChar;   // SQL statement, UTF-16 encoded
  nBytes: Integer;           // Maximum length of SQLStatement in bytes
  var hStmt: TSQLiteStmt;    // OUT: Statement handle
  var pzTail: PWideChar      // OUT: Pointer to unused portion of SQLStatement
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_prepare16_v2';

function SQLite3_ColumnCount(
  hStmt: TSQLiteStmt
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_column_count';

function SQLite3_ColumnName(
  hStmt: TSQLiteStmt;
  iCol: Integer
  ): PUTF8Char; cdecl; external SQLiteDLL name 'sqlite3_column_name';

function SQLite3_ColumnName16(
  hStmt: TSQLiteStmt;
  iCol: Integer
  ): PWideChar; cdecl; external SQLiteDLL name 'sqlite3_column_name16';

function SQLite3_Step(
  hStmt: TSQLiteStmt
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_step';

function SQLite3_ColumnBlob(
  hStmt: TSQLiteStmt;
  iCol: Integer
  ): Pointer; cdecl; external SQLiteDLL name 'sqlite3_column_blob';

function SQLite3_ColumnBytes(
  hStmt: TSQLiteStmt;
  iCol: Integer
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_column_bytes';

function SQLite3_ColumnBytes16(
  hStmt: TSQLiteStmt;
  iCol: Integer
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_column_bytes16';

function SQLite3_ColumnDouble(
  hStmt: TSQLiteStmt;
  iCol: Integer
  ): Double; cdecl; external SQLiteDLL name 'sqlite3_column_double';

function SQLite3_ColumnText(
  hStmt: TSQLiteStmt;
  iCol: Integer
  ): PUTF8Char; cdecl; external SQLiteDLL name 'sqlite3_column_text';

function SQLite3_ColumnText16(
  hStmt: TSQLiteStmt;
  iCol: Integer
  ): PWideChar; cdecl; external SQLiteDLL name 'sqlite3_column_text16';

function SQLite3_ColumnInt64(
  hStmt: TSQLiteStmt;
  iCol: Integer
  ): Int64; cdecl; external SQLiteDLL name 'sqlite3_column_int64';

function SQLite3_Finalize(
  hStmt: TSQLiteStmt
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_finalize';

function SQLite3_Reset(
  hStmt: TSQLiteStmt
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_reset';

function SQLite3_Get_Autocommit(
  db: TSQLite3DB
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_get_autocommit';

function SQLite3_Bind_Blob(
  hStmt: TSQLiteStmt;
  ParamNum: Integer;
  ptrData: Pointer;
  numBytes: Integer;
  ptrDestructor: TSQLite3Destructor
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_bind_blob';

function SQLite3_bind_text(
  hStmt: TSQLiteStmt;
  ParamNum: Integer;
  Text: PUTF8Char;
  numBytes: Integer;
  ptrDestructor: TSQLite3Destructor
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_bind_text';

function SQLite3_bind_text16(
  hStmt: TSQLiteStmt;
  ParamNum: Integer;
  Text: PWideChar;
  numBytes: Integer;
  ptrDestructor: TSQLite3Destructor
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_bind_text16';

function SQLite3_bind_double(
  hStmt: TSQLiteStmt;
  ParamNum: integer;
  Data: Double
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_bind_double';

function SQLite3_bind_int64(
  hStmt: TSQLiteStmt;
  ParamNum: Integer;
  Data: Int64
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_bind_int64';

function SQLite3_bind_null(
  hStmt: TSQLiteStmt;
  ParamNum: integer
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_bind_null';

function SQLite3_bind_parameter_index(
  hStmt: TSQLiteStmt;
  zName: PUTF8Char
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_bind_parameter_index';

function SQLite3_clear_bindings(
  hStmt: TSQLiteStmt
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_clear_bindings';

function SQLite3_Create_Collation(
  db: TSQLite3DB;
  Name: PUTF8Char;
  eTextRep: Integer;
  UserData: Pointer;
  xCompare: TCollateXCompare
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_create_collation';

function SQLite3_Create_Collation16(
  db: TSQLite3DB;
  Name: PWideChar;
  eTextRep: Integer;
  UserData: Pointer;
  xCompare: TCollateXCompare
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_create_collation16';

function SQLite3_Create_Function(
  db: TSQLite3DB;
  functionName: PUTF8Char;
  nArg: Integer;
  eTextRep: Integer;
  pUserdata: Pointer;
  xFunc: TxFunc;
  xStep: TxStep;
  xFinal: TxFinal
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_create_function';

function SQLite3_Create_Function16(
  db: TSQLite3DB;
  functionName: PWideChar;
  nArg: Integer;
  eTextRep: Integer;
  pUserdata: Pointer;
  xFunc: TxFunc;
  xStep: TxStep;
  xFinal: TxFinal
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_create_function16';

function SQLite3_User_Data(
  pCtx: TSQLite3Context
  ): Pointer; cdecl; external SQLiteDLL name 'sqlite3_user_data';

procedure SQLite3_Result_Blob(
  pCtx: TSQLite3Context;
  Value: Pointer;
  nBytes: Integer;
  destroy: Pointer
  ); cdecl; external SQLiteDLL name 'sqlite3_result_blob';

procedure SQLite3_Result_Double(
  pCtx: TSQLite3Context;
  Value: Double
  ); cdecl; external SQLiteDLL name 'sqlite3_result_double';

procedure SQLite3_Result_Error(
  pCtx: TSQLite3Context;
  Value: PUTF8Char;
  nBytes: Integer
  ); cdecl; external SQLiteDLL name 'sqlite3_result_error';

procedure SQLite3_Result_Error16(
  pCtx: TSQLite3Context;
  Value: PWideChar;
  nBytes: Integer
  ); cdecl; external SQLiteDLL name 'sqlite3_result_error16';

procedure SQLite3_Result_Int(
  pCtx: TSQLite3Context;
  Value: Integer
  ); cdecl; external SQLiteDLL name 'sqlite3_result_int';

procedure SQLite3_Result_Int64(
  pCtx: TSQLite3Context;
  Value: Int64); cdecl; external SQLiteDLL name 'sqlite3_result_int64';

procedure SQLite3_Result_Null(
  pCtx: TSQLite3Context
  ); cdecl; external SQLiteDLL name 'sqlite3_result_null';

procedure SQLite3_Result_Text(
  pCtx: TSQLite3Context;
  value: PAnsiChar;
  nBytes: Integer;
  destroy: Pointer
  ); cdecl; external SQLiteDLL name 'sqlite3_result_text';

procedure SQLite3_Result_Text16(
  pCtx: TSQLite3Context;
  Value: PWideChar;
  nBytes: integer;
  destroy: Pointer
  ); cdecl; external SQLiteDLL name 'sqlite3_result_text16';

procedure SQLite3_Result_Value(
  pCtx: TSQLite3Context;
  Value: TSQLite3Value
  ); cdecl; external SQLiteDLL name 'sqlite3_result_value';

function SQLite3_Value_blob(
  Value: Pointer
  ): Pointer; cdecl; external SQLiteDLL name 'sqlite3_value_blob';

function SQLite3_Value_bytes(
  Value: Pointer
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_value_bytes';

function SQLite3_Value_bytes16(
  Value: Pointer
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_value_bytes16';

function SQLite3_Value_double(
  Value: Pointer
  ): Double; cdecl; external SQLiteDLL name 'sqlite3_value_double';

function SQLite3_Value_int(
  Value: Pointer
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_value_int';

function SQLite3_Value_int64(
  Value: Pointer
  ): Int64; cdecl; external SQLiteDLL name 'sqlite3_value_int64';

function SQLite3_Value_text(
  Value: Pointer
  ): PUTF8Char; cdecl; external SQLiteDLL name 'sqlite3_value_text';

function SQLite3_Value_text16(
  Value: pointer
  ): PWideChar; cdecl; external SQLiteDLL name 'sqlite3_value_text16';

function SQLite3_Value_type(
  Value: Pointer
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_value_type';

function SQLite3_Enable_Load_Extension(
  db: TSQLite3DB;
  nEnable: Integer
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_enable_load_extension';

function SQLite3_Load_Extension(
  db: TSQLite3DB;
  pszFile: PUTF8Char;
  pszProc: PUTF8Char;
  ppszErrMsg: PPUTF8Char
  ): Integer; cdecl; external SQLiteDLL name 'sqlite3_load_extension';

function SQLiteErrorStr(SQLiteErrorCode: Integer): string;

//type
//  TSQLiteResult = ^PAnsiChar;
//  PPAnsiCharArray = ^TPAnsiCharArray;
//  TPAnsiCharArray = array[0 .. (MaxInt div SizeOf(PAnsiChar))-1] of PAnsiChar;

//  TSQLiteExecCallback = function(UserData: Pointer; NumCols: integer; ColValues: PPAnsiCharArray; ColNames: PPAnsiCharArray): integer; cdecl;
//  TSQLiteBusyHandlerCallback = function(UserData: Pointer; P2: integer): integer; cdecl;
//function SQLite3_Exec(db: TSQLiteDB; SQLStatement: PAnsiChar; CallbackPtr: TSQLiteExecCallback; UserData: Pointer; var ErrMsg: PAnsiChar): integer; cdecl; external SQLiteDLL name 'sqlite3_exec';
//function SQLite3_GetTable(db: TSQLiteDB; SQLStatement: PAnsiChar; var ResultPtr: TSQLiteResult; var RowCount: Cardinal; var ColCount: Cardinal; var ErrMsg: PAnsiChar): integer; cdecl; external SQLiteDLL name 'sqlite3_get_table';
//procedure SQLite3_FreeTable(Table: TSQLiteResult); cdecl; external SQLiteDLL name 'sqlite3_free_table';
//function SQLite3_Complete(P: PAnsiChar): Boolean; cdecl; external SQLiteDLL name 'sqlite3_complete';
//procedure SQLite3_Interrupt(db: TSQLiteDB); cdecl; external SQLiteDLL name 'sqlite3_interrupt';
//procedure SQLite3_BusyHandler(db: TSQLiteDB; CallbackPtr: TSQLiteBusyHandlerCallback; UserData: Pointer); cdecl; external SQLiteDLL name 'sqlite3_busy_handler';
//function SQLite3_TotalChanges(db: TSQLiteDB): integer; cdecl; external SQLiteDLL name 'sqlite3_total_changes';
//function SQLite3_Prepare(db: TSQLiteDB; SQLStatement: PAnsiChar; nBytes: integer; var hStmt: TSqliteStmt; var pzTail: PAnsiChar): integer; cdecl; external SQLiteDLL name 'sqlite3_prepare';
//function SQLite3_ColumnDeclType(hStmt: TSqliteStmt; ColNum: integer): PAnsiChar; cdecl; external SQLiteDLL name 'sqlite3_column_decltype';
//function SQLite3_DataCount(hStmt: TSqliteStmt): integer; cdecl; external SQLiteDLL name 'sqlite3_data_count';
//function SQLite3_ColumnInt(hStmt: TSqliteStmt; ColNum: integer): integer; cdecl; external SQLiteDLL name 'sqlite3_column_int';
//function SQLite3_ColumnType(hStmt: TSqliteStmt; ColNum: integer): integer; cdecl; external SQLiteDLL name 'sqlite3_column_type';
//function SQLite3_bind_int(hStmt: TSqLiteStmt; ParamNum: integer; Data: integer): Integer; cdecl; external SQLiteDLL name 'sqlite3_bind_int';
//function sqlite3_enable_shared_cache(Value: integer): integer; cdecl; external SQLiteDLL name 'sqlite3_enable_shared_cache';
//function SQLiteFieldType(SQLiteFieldTypeCode: Integer): string;

implementation

uses
  SysUtils;

function SQLiteFieldType(SQLiteFieldTypeCode: Integer): String;
begin
  case SQLiteFieldTypeCode of
    SQLITE_INTEGER: Result := 'Integer';
    SQLITE_FLOAT: Result := 'Float';
    SQLITE_TEXT: Result := 'Text';
    SQLITE_BLOB: Result := 'Blob';
    SQLITE_NULL: Result := 'Null';
  else
    Result := 'Unknown SQLite Field Type Code "' + IntToStr(SQLiteFieldTypeCode) + '"';
  end;
end;

function SQLiteErrorStr(SQLiteErrorCode: Integer): String;
begin
  case SQLiteErrorCode of
    SQLITE_OK: Result := 'Successful result';
    SQLITE_ERROR: Result := 'SQL error or missing database';
    SQLITE_INTERNAL: Result := 'An internal logic error in SQLite';
    SQLITE_PERM: Result := 'Access permission denied';
    SQLITE_ABORT: Result := 'Callback routine requested an abort';
    SQLITE_BUSY: Result := 'The database file is locked';
    SQLITE_LOCKED: Result := 'A table in the database is locked';
    SQLITE_NOMEM: Result := 'A malloc() failed';
    SQLITE_READONLY: Result := 'Attempt to write a readonly database';
    SQLITE_INTERRUPT: Result := 'Operation terminated by sqlite3_interrupt()';
    SQLITE_IOERR: Result := 'Some kind of disk I/O error occurred';
    SQLITE_CORRUPT: Result := 'The database disk image is malformed';
    SQLITE_NOTFOUND: Result := '(Internal Only) Table or record not found';
    SQLITE_FULL: Result := 'Insertion failed because database is full';
    SQLITE_CANTOPEN: Result := 'Unable to open the database file';
    SQLITE_PROTOCOL: Result := 'Database lock protocol error';
    SQLITE_EMPTY: Result := 'Database is empty';
    SQLITE_SCHEMA: Result := 'The database schema changed';
    SQLITE_TOOBIG: Result := 'Too much data for one row of a table';
    SQLITE_CONSTRAINT: Result := 'Abort due to contraint violation';
    SQLITE_MISMATCH: Result := 'Data type mismatch';
    SQLITE_MISUSE: Result := 'Library used incorrectly';
    SQLITE_NOLFS: Result := 'Uses OS features not supported on host';
    SQLITE_AUTH: Result := 'Authorization denied';
    SQLITE_FORMAT: Result := 'Auxiliary database format error';
    SQLITE_RANGE: Result := '2nd parameter to sqlite3_bind out of range';
    SQLITE_NOTADB: Result := 'File opened that is not a database file';
    SQLITE_ROW: Result := 'sqlite3_step() has another row ready';
    SQLITE_DONE: Result := 'sqlite3_step() has finished executing';
  else
    Result := 'Unknown SQLite Error Code "' + IntToStr(SQLiteErrorCode) + '"';
  end;
end;


end.

