(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  *
  ****************************************************************************** *)

unit unit_ExportToDevice;

interface

uses
  Controls,
  Forms,
  Dialogs,
  Windows,
  ShlObj,
  unit_Globals;

procedure ExportToDevice(
  const DeviceDir: string;
  const IdList: TBookIdList;
  const Mode: TExportMode;
  const ExtractOnly: Boolean;
  out ProcessedFiles: string;
  const ADeviceShellItem: IShellItem = nil;
  const AUseMTP: Boolean = False
  );

procedure DownloadBooks(const IdList: TBookIdList);

implementation

uses
  ActiveX,
  unit_ExportToDeviceThread,
  frm_ExportToDeviceProgressForm,
  unit_DownloadBooksThread,
  frm_DownloadProgressForm;

resourcestring
  rstrSendToDevice = 'Надсилання на пристрій';
  rstrDownloadingBooks = 'Скачування книг';

procedure ExportToDevice(
  const DeviceDir: string;
  const IdList: TBookIdList;
  const Mode: TExportMode;
  const ExtractOnly: Boolean;
  out ProcessedFiles: string;
  const ADeviceShellItem: IShellItem;
  const AUseMTP: Boolean
  );
var
  worker: TExportToDeviceThread;
  frmProgress: TExportToDeviceProgressForm;
  MarshalStream: IStream;
begin
  worker := TExportToDeviceThread.Create;
  try
    worker.DeviceDir := DeviceDir;
    worker.BookIdList := IdList;
    worker.ExportMode := Mode;
    worker.ExtractOnly := ExtractOnly;
    worker.UseMTP := AUseMTP;

    // Marshal IShellItem for cross-thread use (MTP devices)
    if AUseMTP and Assigned(ADeviceShellItem) then
    begin
      if Succeeded(CoMarshalInterThreadInterfaceInStream(IShellItem, ADeviceShellItem, MarshalStream)) then
        worker.MarshalStream := MarshalStream;
    end;

    frmProgress := TExportToDeviceProgressForm.Create(Application);
    try
      frmProgress.Caption := rstrSendToDevice;
      frmProgress.WorkerThread := worker;
      frmProgress.ShowModal;
      ProcessedFiles := worker.ProcessedFiles;
    finally
      frmProgress.Free;
    end;
  finally
    worker.Free;
  end;
end;

procedure DownloadBooks(const IdList: TBookIdList);
var
  worker: TDownloadBooksThread;
  frmProgress: TDownloadProgressForm;
begin
  worker := TDownloadBooksThread.Create;
  try
    worker.BookIdList := IdList;
    frmProgress := TDownloadProgressForm.Create(Application);
    try
      frmProgress.Caption := rstrDownloadingBooks;
      frmProgress.WorkerThread := worker;
      frmProgress.ShowModal;
    finally
      frmProgress.Free;
    end;
  finally
    worker.Free;
  end;
end;


end.
