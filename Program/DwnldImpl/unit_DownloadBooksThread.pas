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
  * $Id: unit_DownloadBooksThread.pas 875 2010-10-25 09:10:20Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_DownloadBooksThread;

interface

uses
  Classes,
  unit_WorkerThread,
  unit_Globals,
  Dialogs,
  Forms,
  unit_Interfaces,
  unit_Events,
  unit_Downloader;

type
  TDownloadBooksThread = class(TWorker)
  private
    FDownloader: TDownloader;

    FBookIdList: TBookIdList;

    FOnSetProgress2: TProgressEvent2;
    FOnSetComment2: TProgressSetCommentEvent2;

    FCurrentComment: string;
    FTotalComment: string;
    FCurrentProgress: Integer;
    FTotalProgress: Integer;

    FIgnoreErrors: Boolean;

    FNoPause: Boolean;

    procedure DoSetComment2;
    procedure SetComment2(const Current, Total: string);

    procedure DoSetProgress2;
    procedure SetProgress2(Current, Total: integer);
    //procedure SetCancelledOperation;

  protected
    procedure WorkFunction; override;

  public
    property BookIdList: TBookIdList read FBookIdList write FBookIdList;

    property OnProgress2: TProgressEvent2 read FOnSetProgress2 write FOnSetProgress2;
    property OnSetComment2: TProgressSetCommentEvent2 read FOnSetComment2 write FOnSetComment2;
  end;

implementation

uses
  Windows,
  SysUtils,
  dm_user,
  frm_main;

resourcestring
  rstrDownloaded = 'Скачано файлов: %u из %u';
  rstrConnecting = 'Подключение...';
  rstrIgnoreDownloadErrors = 'Игнорировать ошибки загрузки ?';
  rstrDone = 'Готово';
  rstrOperationCompleted = 'Завершение операции ...';

procedure TDownloadBooksThread.WorkFunction;
var
  i: Integer;
  totalBooks: Integer;
  Res: integer;
  FSystemDB: ISystemData;
begin
  FSystemDB := DMUser.GetSystemDBConnection;
  try
    Canceled := False;
    FIgnoreErrors := False;

    FDownloader := TDownloader.Create;
    try
      FDownloader.OnSetComment := SetComment2;
      FDownloader.OnProgress := SetProgress2;

      totalBooks := High(FBookIdList) + 1;
      SetComment2(' ', Format(rstrDownloaded, [0, totalBooks]));

      for i := 0 to totalBooks - 1 do
      begin
        SetComment2(rstrConnecting, '');

        FBookIdList[i].Res := FDownloader.Download(FSystemDB, FBookIdList[i].BookKey);
        if
          (not Canceled) and                // это реальная ошибка, а не отмена операции пользователем
          (not FBookIdList[i].Res) and      //
          (i < totalBooks - 1) and          // для последней книги вопрос смысла не имеет
          (not Settings.ErrorLog) and       //
          (not FIgnoreErrors)               //
        then
        begin
          Res := ShowMessage(rstrIgnoreDownloadErrors, MB_ICONQUESTION or MB_YESNO);
          FIgnoreErrors := (Res = IDYES);
        end;

        SetComment2(rstrDone, Format(rstrDownloaded, [i + 1, totalBooks]));
        SetProgress2(100, (i + 1) * 100 div totalBooks);

        if Canceled then
        begin
          SetComment2(' ', rstrOperationCompleted);
          Break;
        end;

        if FNoPause then
          Sleep(Settings.DwnldInterval);
      end;
    finally
      FreeAndNil(FDownloader);
    end;
  finally
    FSystemDB.ClearCollectionCache;
    FSystemDB := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure TDownloadBooksThread.DoSetComment2;
begin
  if Assigned(FOnSetComment2) then
    FOnSetComment2(FCurrentComment, FTotalComment);
end;

{
procedure TDownloadBooksThread.SetCancelledOperation;
begin
  frmMain.FCancelled := True;
end;
}

procedure TDownloadBooksThread.SetComment2(const Current, Total: string);
begin
  FCurrentComment := Current;
  FTotalComment := Total;
  Synchronize(DoSetComment2);
end;

procedure TDownloadBooksThread.SetProgress2(Current, Total: integer);
begin
  FCurrentProgress := Current;
  FTotalProgress := Total;
  Synchronize(DoSetProgress2);
end;


procedure TDownloadBooksThread.DoSetProgress2;
begin
  if Assigned(FOnSetProgress2) then
    FOnSetProgress2(FCurrentProgress, FTotalProgress);
end;

end.
