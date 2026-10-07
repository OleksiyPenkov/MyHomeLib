(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov    nrymanov@gmail.com
  *                     Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             22.02.2010
  * Description         
  *
  * $Id: unit_Export.pas 821 2010-09-29 05:46:48Z nrymanov@gmail.com $
  *
  * History
  * NickR 02.03.2010    Код переформатирован
  * NickR 08.04.2010    Убраны ненужные зависимости
  *
  ****************************************************************************** *)

unit unit_Export;

interface

uses
  unit_ExportMetabibThread;

procedure Export2INPX(const CollectionID: Integer; const FileName: string);
function ExportGroupCollection(const GroupID: Integer;
  const DestinationParent: string): TMetabibExportResult;

implementation

uses
  System.SysUtils,
  Forms,
  frm_ImportProgressFormEx,
  unit_ExportINPXThread,
  frm_ExportProgressForm;

resourcestring
  rstrGroupExportCaption = 'Експорт групи (metabib)';

procedure Export2INPX(const CollectionID: Integer; const FileName: string);
var
  worker: TExport2INPXThread;
  frmProgress: TExportProgressForm;
begin
  worker := TExport2INPXThread.Create(CollectionID, FileName);
  try
    frmProgress := TExportProgressForm.Create(Application);
    try
      frmProgress.WorkerThread := worker;
      frmProgress.ShowModal;
    finally
      frmProgress.Free;
    end;
  finally
    worker.Free;
  end;
end;

function ExportGroupCollection(const GroupID: Integer;
  const DestinationParent: string): TMetabibExportResult;
var
  Worker: TExportMetabibThread;
  Progress: TImportProgressFormEx;
begin
  Worker := TExportMetabibThread.Create(GroupID, DestinationParent);
  try
    Progress := TImportProgressFormEx.Create(Application);
    try
      Progress.Caption := rstrGroupExportCaption;
      Progress.WorkerThread := Worker;
      Progress.ShowModal;
    finally
      Progress.Free;
    end;
    Result := Worker.ResultInfo;
    if Assigned(Worker.FatalException) then
    begin
      Result.Status := mesFailed;
      Result.ErrorText := Exception(Worker.FatalException).Message;
    end;
  finally
    Worker.Free;
  end;
end;

end.

