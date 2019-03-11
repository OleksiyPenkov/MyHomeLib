program MHLSQLiteConsole;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain},
  SQLite3 in '..\..\Program\DAO\SQLite\Lib\SQLite3.pas',
  SQLiteWrap in '..\..\Program\DAO\SQLite\Lib\SQLiteWrap.pas',
  SQLite3UDF in '..\..\Program\DAO\SQLite\Lib\SQLite3UDF.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
