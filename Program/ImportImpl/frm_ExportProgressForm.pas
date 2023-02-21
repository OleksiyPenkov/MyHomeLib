(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov   oleksiy.penkov@gmail.com
  *                     Nick Rymanov     nrymanov@gmail.com
  * Created             
  * Description         
  *
  * $Id: frm_ExportProgressForm.pas 543 2010-07-29 06:34:09Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_ExportProgressForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frm_ImportProgressForm, StdCtrls, ComCtrls;

type
  TExportProgressForm = class(TImportProgressForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExportProgressForm: TExportProgressForm;

implementation

{$R *.dfm}

end.

