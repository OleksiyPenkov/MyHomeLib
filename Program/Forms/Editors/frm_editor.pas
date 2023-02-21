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
  * $Id: frm_editor.pas 632 2010-08-26 05:48:28Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmEditor = class(TForm)
    mmMemo: TMemo;
    RzGroupBox4: TPanel;
    btnLike: TButton;
    btnNotEq: TButton;
    btnBraket: TButton;
    btnGreat: TButton;
    btnLess: TButton;
    btnAnd: TButton;
    btnOr: TButton;
    btnNot: TButton;
    btnCommas: TButton;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    btnEq: TButton;
    procedure btnLikeClick(Sender: TObject);

  private
    procedure SetText(const Value: string);
    function GetText: string;

  public
    property Text: string read GetText write SetText;
  end;

var
  frmEditor: TfrmEditor;

implementation

{$R *.dfm}

procedure TfrmEditor.btnLikeClick(Sender: TObject);
var
   OldText: string;
   p: integer;
   AddText, InsText: string;
   Offset : integer;
begin
  OldText := mmMemo.Lines.Text;

  p := mmMemo.SelStart;
  if mmMemo.SelLength > 0 then
  begin
    InsText := mmMemo.SelText;
    Delete(OldText, p + 1, mmMemo.SelLength);
  end
  else
    InsText := '';

  case (Sender as TButton).Tag of
      50: begin
            AddText := 'LIKE "%' + InsText + '%"';
            OffSet  := P + 7;
          end;
      51: begin
            AddText := '="' + InsText + '"';
            OffSet  := P + 2;
          end;
      52: begin
            AddText := '<> "' + InsText + '"';
            OffSet  := P + 4;
          end;
      53: begin
            AddText := '<"' + InsText + '"';
            OffSet  := P + 2;
          end;
      54: begin
            AddText := '>"' + InsText + '"';
            OffSet  := P + 2;
          end;
      55: begin
            AddText := '(' + InsText + '"")';
            OffSet  := P + 2;
          end;
      56: begin
            AddText := ' AND ';
            OffSet  := P + 5;
          end;
      57: begin
            AddText := ' OR ';
            OffSet  := P + 4;
          end;
       58: begin
            AddText := ' NOT ';
            OffSet  := P + 5;
          end;
       59: begin
            AddText := '"' + InsText + '"';
            OffSet  := P + 1;
          end;
    end;
  Insert(AddText + ' ',OldText, P + 1);

  mmMemo.Lines.Text := OldText;
  mmMemo.SelStart := Offset;
  mmMemo.SelLength := 0;

  ActiveControl := mmMemo;
end;

function TfrmEditor.GetText: string;
begin
  Result := mmMemo.Lines.Text;
end;

procedure TfrmEditor.SetText(const Value: string);
begin
  mmMemo.Lines.Text := Value;
end;

end.
