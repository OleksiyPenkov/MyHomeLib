(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  * Created                  20.08.2008
  * Description              
  *
  * $Id: frm_info_popup.pas 543 2010-07-29 06:34:09Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_info_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmInfoPopup = class(TForm)
    lblText: TLabel;
  private

  protected
    procedure DoCreate; override;

  public

  end;

var
  frmInfoPopup: TfrmInfoPopup;

implementation

uses
  unit_Localization;

{$R *.dfm}

procedure TfrmInfoPopup.DoCreate;
begin
  inherited;
  Localize(Self);
end;

end.
