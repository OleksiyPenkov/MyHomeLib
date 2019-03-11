unit MainForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  SQLiteWrap,
  SQLite3,
  ExtCtrls,
  ComCtrls,
  MHLSimplePanel,
  MHLSplitter,
  TimeSpan;

type
  TfrmMain = class(TForm)
    pnDBName: TMHLSimplePanel;
    btnOpen: TButton;
    dlgOpenDB: TOpenDialog;
    edQuery: TMemo;
    btnSelect: TButton;
    btnExecute: TButton;
    lv: TListView;
    pnButtons: TMHLSimplePanel;
    pnContent: TMHLSimplePanel;
    MHLSplitter1: TMHLSplitter;
    btnClear: TButton;
    dbName: TLabel;
    pnStat: TGridPanel;
    Label1: TLabel;
    prepareTime: TLabel;
    Label3: TLabel;
    execTime: TLabel;
    Label5: TLabel;
    rowsFetched: TLabel;
    btnExplain: TButton;
    procedure btnOpenClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnExplainClick(Sender: TObject);

  private const
    MAX_FETCH_ROW = 100;

  private
    FDatabase: TSQLiteDatabase;

    procedure Connect;
    procedure Disconnect;
    procedure DoSelect(const SQL: string);
    function FormatElapsedTime(const Elapsed: TTimeSpan): string;
  public

  end;

var
  frmMain: TfrmMain;

implementation

uses
  Diagnostics,
  Character;

{$R *.dfm}

procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  lv.Items.Clear;
  lv.Columns.Clear;

  prepareTime.Caption := '';
  execTime.Caption := '';
  rowsFetched.Caption := '';
end;

procedure TfrmMain.btnExecuteClick(Sender: TObject);
var
  q: TSQLiteQuery;
  sw: TStopwatch;
begin
  sw := TStopwatch.StartNew;
  q := FDatabase.NewQuery(edQuery.Lines.Text);
  try
    sw.Stop;
    prepareTime.Caption := FormatElapsedTime(sw.Elapsed);

    sw := TStopwatch.StartNew;
    q.ExecSQL;
    sw.Stop;
    execTime.Caption := FormatElapsedTime(sw.Elapsed);
    rowsFetched.Caption := IntToStr(0);
  finally
    q.Free;
  end;
end;

procedure TfrmMain.btnExplainClick(Sender: TObject);
begin
  DoSelect('EXPLAIN QUERY PLAN ' + edQuery.Lines.Text);
end;

procedure TfrmMain.btnOpenClick(Sender: TObject);
begin
  if Assigned(FDatabase) then
    Disconnect
  else
    Connect;

  btnSelect.Enabled := Assigned(FDatabase);
  btnExecute.Enabled := Assigned(FDatabase);
  btnExplain.Enabled := Assigned(FDatabase);
end;

procedure TfrmMain.btnSelectClick(Sender: TObject);
begin
  DoSelect(edQuery.Lines.Text);
end;

procedure TfrmMain.Connect;
begin
  if dlgOpenDB.Execute then
  begin
    FDatabase := TSQLiteDatabase.Create(dlgOpenDB.FileName);
    dbName.Caption := dlgOpenDB.FileName;
    btnOpen.Caption := 'Close';
  end;
end;

procedure TfrmMain.Disconnect;
begin
  FreeAndNil(FDatabase);
  dbName.Caption := 'No database opened';
  btnOpen.Caption := 'Open';
end;

procedure TfrmMain.DoSelect(const SQL: string);
var
  sw: TStopwatch;
  nColumns: Integer;
  item: TListItem;
  nRows: Integer;
  q: TSQLiteQuery;
  i: Integer;
  saveCursor: TCursor;
begin
  saveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    lv.Items.BeginUpdate;
    try
      btnClearClick(nil);

      sw := TStopwatch.StartNew;
      q := FDatabase.NewQuery(SQL);
      try
        sw.Stop;
        prepareTime.Caption := FormatElapsedTime(sw.Elapsed);

        sw := TStopwatch.StartNew;
        q.Open;
        nRows := 0;
        while not q.Eof do
        begin
          Inc(nRows);
          q.Next;
        end;
        sw.Stop;
        execTime.Caption := FormatElapsedTime(sw.Elapsed);
        rowsFetched.Caption := IntToStr(nRows);

        nColumns := q.ColCount;
        for i := 0 to nColumns - 1 do
          lv.Columns.Add.Caption := q.Columns[i];

        q.Reset;
        q.Open;
        nRows := 0;
        while not q.Eof do
        begin
          item := lv.Items.Add;
          item.Caption := q.Fields[0];
          for i := 1 to nColumns - 1 do
            item.SubItems.Add(q.Fields[i]);

          Inc(nRows);
          if nRows >= MAX_FETCH_ROW then
            Break;
          q.Next;
        end;
      finally
        q.Free;
      end;
    finally
      lv.Items.EndUpdate;
    end;
  finally
    Screen.Cursor := saveCursor;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Disconnect;
end;

function TfrmMain.FormatElapsedTime(const Elapsed: TTimeSpan): string;
begin
  Result := Format('%.2d:%.2d:%.2d.%.3d', [Elapsed.Hours, Elapsed.Minutes, Elapsed.Seconds, Elapsed.Milliseconds]);
end;

end.


{

select *
from Authors a
where
exists
(
select al.AuthorID
from
  Author_List al
  inner join Books b on al.BookID = b.BookID
where
  a.AuthorID = al.AuthorID AND
  b.IsLocal = 1 AND
  b.IsDeleted = 0
)

}



