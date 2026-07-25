(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
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
  unit_Globals,
  unit_Downloader,
  unit_DownloadView,
  unit_Interfaces;

type
  //
  // Менеджер черги завантажень.
  //
  // Потік не знає ані про головну форму, ані про дерево черги: усе спілкування
  // з інтерфейсом іде через IDownloadView і тільки в межах Synchronize.
  //
  TDownloadManagerThread = class(TThread)
  private
    FView: IDownloadView;
    FDownloader : TDownloader;

    FCanceled : boolean;
    FFinished : boolean;
    FIgnoreErrors : boolean;

    FProcessed: integer;

    FCurrentItem: TDownloadItem;
    FHasCurrentItem: Boolean;

    FError : boolean;

    //
    // Обгортки над IDownloadView: кожна виконується у головному потоці.
    //
    procedure ShowState(const State: string);
    procedure ShowProgress(Position: Integer);
    procedure ShowCurrentItem;
    procedure SetQueueControlsEnabled(Enabled: Boolean);
    function AskIgnoreErrors: Integer;

    //
    // Кроки черги
    //
    procedure SelectNextFile;
    procedure FinishCurrentFile;
    procedure CancelCurrentFile;

    procedure InterruptibleSleep(Milliseconds: Integer);

    //
    // Зворотні виклики завантажувача. Приходять з фонового потоку, тому
    // всередині лише Synchronize.
    //
    procedure SetComment(const Current, Total: string);
    procedure SetProgress(Current, Total: Integer);

  protected
    procedure Execute; override;
    procedure WorkFunction;

  public
    constructor Create(const View: IDownloadView);

    procedure Stop;
    procedure TerminateNow;
   end;

implementation

uses
  SysUtils,
  DateUtils,
  Math,
  Windows,
  dm_user,
  unit_Consts;

resourcestring
rstrConnecting = 'Підключення...';
  rstrConnectingWithInfo = '%s %s %s Підключення...';
  rstrDownloading = '%s. %s %s Завантаження: %s Kb/s %d %%';

constructor TDownloadManagerThread.Create(const View: IDownloadView);
begin
  //
  // Створюємо призупиненим: потік не має стартувати, доки не отримає View.
  //
  inherited Create(True);
  Assert(Assigned(View));
  FView := View;
  Start;
end;

procedure TDownloadManagerThread.TerminateNow;
begin
  try
    //
    // Завантажувача може вже не бути: потік міг завершити роботу сам.
    //
    if Assigned(FDownloader) then
      FDownloader.Stop;
    Terminate;
  except
    on EAbort do ; // swallow thread-termination abort; rethrow everything else
  end;
end;

//
// Пауза, яку можна перервати.
//
// Звичайний Sleep змусив би і закриття програми, і перезапуск черги чекати до
// 30 секунд - саме стільки триває пауза після помилки завантаження.
//
procedure TDownloadManagerThread.InterruptibleSleep(Milliseconds: Integer);
const
  SLICE = 100;
var
  Elapsed: Integer;
begin
  Elapsed := 0;
  while (Elapsed < Milliseconds) and not Terminated and not FCanceled do
  begin
    Sleep(Min(SLICE, Milliseconds - Elapsed));
    Inc(Elapsed, SLICE);
  end;
end;

//
// - - - - - - - - - - - Обгортки над представленням - - - - - - - - - - - - - -
//

procedure TDownloadManagerThread.ShowState(const State: string);
begin
  Synchronize(
    procedure
    begin
      FView.ShowDownloadState(State);
    end
  );
end;

procedure TDownloadManagerThread.ShowProgress(Position: Integer);
begin
  Synchronize(
    procedure
    begin
      if FView.IsMainFormVisible then
        FView.ShowDownloadProgress(Position)
      else
        FView.SetTrayHint(Format(rstrDownloading,
                                 [FCurrentItem.Author,
                                  FCurrentItem.Title,
                                  CRLF,
                                  '',
                                  Position]));
    end
  );
end;

procedure TDownloadManagerThread.ShowCurrentItem;
begin
  Synchronize(
    procedure
    begin
      if FView.IsMainFormVisible then
      begin
        FView.ShowDownloadState(rstrConnecting);
        FView.ShowDownloadInfo(FCurrentItem.Author, FCurrentItem.Title);
      end
      else
        FView.SetTrayHint(Format(rstrConnectingWithInfo,
                                 [FCurrentItem.Author,
                                  FCurrentItem.Title,
                                  CRLF]));

      FView.SetDownloadRunning(True);
    end
  );
end;

procedure TDownloadManagerThread.SetQueueControlsEnabled(Enabled: Boolean);
begin
  Synchronize(
    procedure
    begin
      FView.SetQueueControlsEnabled(Enabled);
    end
  );
end;

function TDownloadManagerThread.AskIgnoreErrors: Integer;
var
  Res: Integer;
begin
  Synchronize(
    procedure
    begin
      Res := FView.AskIgnoreDownloadErrors;
    end
  );
  Result := Res;
end;

//
// - - - - - - - - - - - - - - - Кроки черги - - - - - - - - - - - - - - - - - -
//

procedure TDownloadManagerThread.SelectNextFile;
var
  HasItem: Boolean;
  Item: TDownloadItem;
begin
  FFinished := True;
  if FCanceled then
    Exit;

  Synchronize(
    procedure
    begin
      HasItem := FView.SelectNextDownload(Item);
    end
  );

  FHasCurrentItem := HasItem;
  if not HasItem then
    Exit;

  FCurrentItem := Item;
  FFinished := False;
  ShowCurrentItem;
end;

procedure TDownloadManagerThread.FinishCurrentFile;
var
  Success: Boolean;
  HadItem: Boolean;
begin
  HadItem := FHasCurrentItem;
  Success := not FError;
  if HadItem and Success then
    Inc(FProcessed);

  Synchronize(
    procedure
    begin
      if HadItem then
        FView.CompleteCurrentDownload(Success);
      FView.ResetDownloadState;
      FView.SetDownloadRunning(False);
    end
  );

  if Success then
    FHasCurrentItem := False;
end;

procedure TDownloadManagerThread.CancelCurrentFile;
begin
  Synchronize(
    procedure
    begin
      FView.CancelCurrentDownload;
      FView.ResetDownloadState;
      FView.SetDownloadRunning(False);
    end
  );
end;

//
// - - - - - - - - - - - Зворотні виклики завантажувача - - - - - - - - - - - - -
//

procedure TDownloadManagerThread.SetComment(const Current, Total: string);
begin
  ShowState(Current);
end;

procedure TDownloadManagerThread.SetProgress(Current, Total: Integer);
begin
  ShowProgress(Current);
end;

//
// - - - - - - - - - - - - - - - - Робота - - - - - - - - - - - - - - - - - - - -
//

procedure TDownloadManagerThread.Execute;
begin
  WorkFunction;
end;

procedure TDownloadManagerThread.Stop;
begin
  FCanceled := True;
  CancelCurrentFile;
  SetQueueControlsEnabled(True);
  Terminate;
end;

procedure TDownloadManagerThread.WorkFunction;
var
  Res: integer;
  FSystemDB: ISystemData;
begin
  FSystemDB := DMUser.GetSystemDBConnection;
  try
    SetQueueControlsEnabled(False);

    FCanceled := False;
    FIgnoreErrors := False;
    FError := False;

    FProcessed := 0;

    FDownloader := TDownloader.Create;
    try
      FDownloader.OnSetComment := SetComment;
      FDownloader.OnProgress := SetProgress;
      try
        SelectNextFile;
        //
        // Нічого не качаємо, поки черга не дала книгу: інакше перший прохід
        // пішов би завантажувати порожній ключ.
        //
        while not (FFinished or FCanceled) do
        begin
          if FError then
            InterruptibleSleep(30000);
          InterruptibleSleep(Settings.DwnldInterval);
          FDownloader.IgnoreErrors := FIgnoreErrors;
          FError := not FDownloader.Download(FSystemDB, FCurrentItem.BookKey);
          FinishCurrentFile;

          SelectNextFile;
          if FError and not FIgnoreErrors and not FCanceled then
          begin
            Res := AskIgnoreErrors;
            FCanceled := (Res = IDCANCEL);
            FIgnoreErrors := (Res = IDYES);
          end;
        end;
        FinishCurrentFile;
      finally
        SetQueueControlsEnabled(True);
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
