(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  * Created                  20.08.2008
  * Description              
  *
  * $Id: frm_search.pas 854 2010-10-08 13:43:19Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_search;

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
  Mask,
  ExtCtrls,
  MHLSimplePanel,
  unit_Globals,
  unit_Events;

type
  TfrmBookSearch = class(TForm)
    RzPanel1: TMHLSimplePanel;
    Label1: TLabel;
    edText: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edTextChange(Sender: TObject);
    procedure edTextKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    FBusy: boolean;
    FOnLocateBook: TOnLocateBookEvent;

  public
    property OnLocateBook: TOnLocateBookEvent read FOnLocateBook write FOnLocateBook;

  end;

implementation

{$R *.dfm}

procedure TfrmBookSearch.FormCreate(Sender: TObject);
begin
  FBusy := False;
end;

procedure TfrmBookSearch.edTextChange(Sender: TObject);
begin
  if not FBusy then
  begin
    FBusy := True;
    try
      Assert(Assigned(FOnLocateBook));
      FOnLocateBook(edText.Text, False)
    finally
      FBusy := False;
    end;
  end;
end;

procedure TfrmBookSearch.edTextKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RIGHT) and not FBusy then
  begin
    FBusy := True;
    try
      Assert(Assigned(FOnLocateBook));
      FOnLocateBook(edText.Text, True)
    finally
      FBusy := False;
    end;
  end;
end;

procedure TfrmBookSearch.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) or (Key = VK_ESCAPE) then
    Close;
end;

end.
