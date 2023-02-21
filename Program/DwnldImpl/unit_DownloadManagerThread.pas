(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors             Oleksiy Penkov   oleksiy.penkov@gmail.com
  *                     Nick Rymanov     nrymanov@gmail.com
  * Created             
  * Description         
  *
  * $Id: unit_DownloadManagerThread.pas 953 2011-02-18 02:12:22Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_DownloadManagerThread;

interface

uses
  Classes,
  Forms,
  VirtualTrees,
  unit_Globals,
  unit_Downloader,
  unit_Interfaces;

type
  TDownloadManagerThread = class(TThread)
  private
    FDownloader : TDownloader;

    FCanceled : boolean;
    FFinished : boolean;
    FIgnoreErrors : boolean;

    FProcessed: integer;
    FTotal: integer;

    FBookKey: TBookKey;

    FCurrentNode : PVirtualNode;
    FCurrentData : PDownloadData;

    FError : boolean;
    FControlState: boolean;

  protected
    procedure SetComment(const Current, Total: string);
    procedure SetProgress(Current, Total: Integer);
    procedure GetCurrentFile;
    procedure Finished;
    procedure Canceled;
    procedure Execute; override;
    procedure WorkFunction;

    procedure SetControlsState;

  public
    procedure Stop;
    procedure TerminateNow;
   end;

implementation

uses
  frm_main,
  SysUtils,
  DateUtils,
  IdStack,
  IdStackConsts,
  IdException,
  Windows,
  dm_user,
  IdMultipartFormData;

resourcestring
  rstrDone = 'Готово';
  rstrConnecting = 'Подключение ...';
  rstrConnectingWithInfo = '%s %s %s Подключение ...';
  rstrDownloading = '%s. %s %s Загрузка: %s Kb/s    %d %%';
  rstrIgnoreDownloadErrors = 'Игнорировать ошибки загрузки ?';

procedure TDownloadManagerThread.TerminateNow;
begin
  try
    FDownloader.Stop;
    Terminate;
  except
    // подавляем ETreminate
  end;
end;

procedure TDownloadManagerThread.Canceled;
begin
  FCurrentData.State := dsError;
  frmMain.tvDownloadList.RepaintNode(FCurrentNode);

  frmMain.pbDownloadProgress.Position := 0;
  frmMain.lblDownloadState.Caption := rstrDone;
  frmMain.lblDnldAuthor.Caption := '';
  frmMain.lblDnldTitle.Caption :=  '';

  frmMain.btnPauseDownload.Enabled := False;
  frmMain.btnStartDownload.Enabled := True;
end;

procedure TDownloadManagerThread.Execute;
begin
  WorkFunction;
end;

procedure TDownloadManagerThread.Finished;
var
  node: PVirtualNode;
begin
  if FCurrentData <> nil then
    if Not FError then
    begin
      FCurrentData.State := dsOk ;

      // Need to search before delete, to prevent Access Violation
      node := frmMain.tvDownloadList.GetFirst;
      while Assigned(node) do
      begin
        if node = FCurrentNode then
        begin
          frmMain.tvDownloadList.DeleteNode(FCurrentNode);
          break;
        end;
        node := frmMain.tvDownloadList.GetNext(node);
      end;

      FCurrentNode := nil;
      FCurrentData := nil;
      inc(FProcessed);
    end
    else
    begin
      FCurrentData.State := dsError;
      frmMain.tvDownloadList.RepaintNode(FCurrentNode);
    end;

  frmMain.pbDownloadProgress.Position := 0;
  frmMain.lblDownloadState.Caption := rstrDone;
  frmMain.lblDnldAuthor.Caption := '';
  frmMain.lblDnldTitle.Caption :=  '';

  frmMain.lblDownloadCount.Caption := Format('(%d)',[frmMain.tvDownloadList.ChildCount[Nil]]);

  frmMain.pbDownloadProgress.Visible := False;
  frmMain.btnPauseDownload.Enabled := False;
  frmMain.btnStartDownload.Enabled := True;
end;

procedure TDownloadManagerThread.GetCurrentFile;
var
  ErrorCount : integer;

begin
  FFinished := True;
  if FCanceled then Exit;

  if FCurrentNode <> nil then
    FCurrentNode := frmMain.tvDownloadList.GetNext(FCurrentNode);
  if FCurrentNode = nil then
  begin
    ErrorCount := 0;
    FCurrentNode := frmMain.tvDownloadList.GetFirst;
    FCurrentData := frmMain.tvDownloadList.GetNodeData(FCurrentNode);
    while (FCurrentData <> nil) and
          ((FCurrentData.State = dsError) and (FCurrentNode <> nil)) do
    begin
      FCurrentNode := frmMain.tvDownloadList.GetNext(FCurrentNode);
      FCurrentData := frmMain.tvDownloadList.GetNodeData(FCurrentNode);
      Inc(ErrorCount);
    end;

    if (ErrorCount > 0) and (FCurrentNode = Nil) then
        FCurrentNode := frmMain.tvDownloadList.GetFirst;

  end;

  while FCurrentNode <> nil do
  begin
    FCurrentData := frmMain.tvDownloadList.GetNodeData(FCurrentNode);
    if FCurrentData.State <> dsOk then
    begin
      FBookKey := FCurrentData^.BookKey;

      FCurrentData.State := dsRun;
      frmMain.tvDownloadList.RepaintNode(FCurrentNode);

      if frmMain.Visible then
      begin
        frmMain.lblDownloadState.Caption := rstrConnecting;
        frmMain.lblDnldAuthor.Caption := FCurrentData.Author;
        frmMain.lblDnldTitle.Caption := FCurrentData.Title;
        frmMain.pbDownloadProgress.Visible := True;
      end
      else
        frmMain.TrayIcon.Hint := Format(rstrConnectingWithInfo,
                                            [FCurrentData.Author,
                                             FCurrentData.Title,
                                             CRLF]);
      frmMain.btnPauseDownload.Enabled := True;
      frmMain.btnStartDownload.Enabled := False;

      frmMain.TrayIcon.Hint := 'MyHomeLib';

      FFinished := False;
      Break;
    end;
    FCurrentNode := frmMain.tvDownloadList.GetNext(FCurrentNode);
  end;
end;


procedure TDownloadManagerThread.SetComment(const Current, Total: string);
begin
  frmMain.lblDownloadState.Caption := Current;
end;

procedure TDownloadManagerThread.SetControlsState;
begin
  frmMain.BtnFirstRecord.Enabled := FControlState;
  frmMain.BtnDwnldUp.Enabled := FControlState;
  frmMain.BtnDwnldDown.Enabled := FControlState;
  frmMain.BtnLastRecord.Enabled := FControlState;

//  frmMain.BtnDelete.Enabled := FControlState;
  frmMain.BtnSave.Enabled := FControlState;

  frmMain.mi_dwnl_Delete.Enabled := FControlState;
end;

procedure TDownloadManagerThread.SetProgress(Current, Total: Integer);
begin
  if frmMain.Visible then
  begin
    frmMain.pbDownloadProgress.Position := Current;
  end
  else
    frmMain.TrayIcon.Hint := Format(rstrDownloading,
                                    [FCurrentData.Author,
                                     FCurrentData.Title,
                                     CRLF,
                                     '',
                                     Current])

end;

procedure TDownloadManagerThread.Stop;
begin
  FCanceled := True;
  Synchronize(Canceled);
  FControlState := True;
  Synchronize(SetControlsState);
  Terminate;
end;

procedure TDownloadManagerThread.WorkFunction;
var
  Res: integer;
  FSystemDB: ISystemData;
begin
  FSystemDB := DMUser.GetSystemDBConnection;
  try
    FControlState := False;
    Synchronize(SetControlsState);

    FCanceled := False;
    FIgnoreErrors := False;
    FError := False;

    FProcessed := 0;
    FTotal := frmMain.tvDownloadList.AbsoluteIndex(frmMain.tvDownloadList.GetLast);

    FDownloader := TDownloader.Create;
    try
      FDownloader.OnSetComment := SetComment;
      FDownloader.OnProgress := SetProgress;
      try
        Synchronize(GetCurrentFile);
        repeat
          if FError then
            Sleep(30000);
          Sleep(Settings.DwnldInterval);
          FDownloader.IgnoreErrors := FIgnoreErrors;
          FError := not FDownloader.Download(FSystemDB, FBookKey);
          Synchronize(Finished);

          Synchronize(GetCurrentFile);
          if FError and not FIgnoreErrors and not FCanceled then
          begin
            Res := Application.MessageBox(PWideChar(rstrIgnoreDownloadErrors),'', MB_YESNOCANCEL);
            FCanceled := (Res = IDCANCEL);
            FIgnoreErrors := (Res = IDYES);
          end;
        until FFinished or FCanceled;
        Synchronize(Finished);
      finally
        FControlState := True;
        Synchronize(SetControlsState);
      end;
    finally
      FreeAndNil(FDownloader)
    end;
  finally
    FSystemDB.ClearCollectionCache;
    FSystemDB := nil;
  end;
end;

end.
