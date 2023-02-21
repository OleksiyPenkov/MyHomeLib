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
  * $Id: frm_edit_author.pas 543 2010-07-29 06:34:09Z nrymanov@gmail.com $
  *
  * ¬Ќ»ћјЌ»≈!!! Ёта форма ¤вл¤етс¤ базовой дл¤ TfrmEditAuthorDataEx.
  *             Ћюбые изменени¤, сделанные в этой форме, будут вли¤ть и на производную.
  *
  * History
  *
  ****************************************************************************** *)

unit frm_edit_author;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls;

type
  TfrmEditAuthorData = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edLastName: TEdit;
    edFirstName: TEdit;
    edMiddleName: TEdit;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;

  private
    function GetFirstName: string;
    function GetLastName: string;
    function GetMidName: string;
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetMidName(const Value: string);

  public
    property LastName: string read GetLastName write SetLastName;
    property FirstName: string read GetFirstName write SetFirstName;
    property MidName: string read GetMidName write SetMidName;
  end;

var
  frmEditAuthorData: TfrmEditAuthorData;

implementation

{$R *.dfm}

{ TfrmEditAuthorData }

function TfrmEditAuthorData.GetFirstName: string;
begin
  Result := Trim(edFirstName.Text);
end;

function TfrmEditAuthorData.GetLastName: string;
begin
  Result := Trim(edLastName.Text);
end;

function TfrmEditAuthorData.GetMidName: string;
begin
  Result := Trim(edMiddleName.Text);
end;

procedure TfrmEditAuthorData.SetFirstName(const Value: string);
begin
  edFirstName.Text := Value;
end;

procedure TfrmEditAuthorData.SetLastName(const Value: string);
begin
  edLastName.Text := Value;
end;

procedure TfrmEditAuthorData.SetMidName(const Value: string);
begin
  edMiddleName.Text := Value;
end;

end.
