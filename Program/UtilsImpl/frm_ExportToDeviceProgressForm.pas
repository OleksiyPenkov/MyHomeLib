unit frm_ExportToDeviceProgressForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frm_ImportProgressForm, StdCtrls, ComCtrls;

type
  TExportToDeviceProgressForm = class(TImportProgressForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExportToDeviceProgressForm: TExportToDeviceProgressForm;

implementation

{$R *.dfm}

end.
