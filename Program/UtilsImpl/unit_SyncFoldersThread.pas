(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov (oleksiy.penkov@gmail.com)
  *                     Nick Rymanov (nrymanov@gmail.com)
  * Created             20.08.2008
  * Description
  *
  * $Id: unit_SyncFoldersThread.pas 1119 2012-10-29 01:52:46Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_SyncFoldersThread;

interface

uses
  Windows,
  Classes,
  SysUtils,
  unit_WorkerThread,
  unit_CollectionWorkerThread,
  unit_MHLArchiveHelpers,
  files_list;

type
  TSyncFoldersThread = class(TCollectionWorker)
  private
    FFiles: TFilesList;
    FList: TStringList;
    procedure OnFile(Sender: TObject; const F: TSearchRec);
    function FindNewFolder(const FileName: string): string;

  protected
    procedure WorkFunction; override;
  end;

implementation

uses
  unit_Consts,
  unit_MHL_strings,
  unit_Globals,
  unit_Interfaces;

resourcestring
  rstrBuildingFileList = 'Построение списка файлов ...';

{ TImportXMLThread }

function TSyncFoldersThread.FindNewFolder(const FileName: string): string;
var
  i: Integer;
begin
  Result := '*';
  for i := 0 to FList.Count - 1 do
    if Pos(FileName, FList[i]) <> 0 then
      Result := ExtractRelativePath(FCollectionRoot, ExtractFilePath(FList[i]));
end;

procedure TSyncFoldersThread.OnFile(Sender: TObject; const F: TSearchRec);
var
  Archiver: TMHLZip;
  Size: integer;
begin
  if not IsArchiveExt(F.Name) then
     FList.Add(FFiles.LastDir + F.Name + ' ' + IntToStr(F.Size))
  else
  begin
    try
      Archiver := TMHLZip.Create(FFiles.LastDir + F.Name, True);
      Size := Archiver.LastSize;
      FList.Add(FFiles.LastDir + F.Name + ' ' + IntToStr(Size));
    finally
      FreeAndNil(archiver);
    end;
  end;
end;

procedure TSyncFoldersThread.WorkFunction;
var
  BookIterator: IBookIterator;
  BookRecord: TBookRecord;
  NewFolder: string;
  FileName: string;
  BookFormat: TBookFormat;
  BookContainer: string;
begin
  Assert(Assigned(FSystemData));
  Assert(Assigned(FCollection));

  FList := TStringList.Create;
  try
    FProgressEngine.BeginOperation(-1, rstrBuildingFileList, rstrBuildingFileList);
    try
      FFiles := TFilesList.Create(nil);
      try
        FFiles.OnFile := OnFile;
        FFiles.TargetPath := FCollectionRoot;
        FFiles.Process;
      finally
        FFiles.Free;
      end;
    finally
      FProgressEngine.EndOperation;
    end;

    BookIterator := FCollection.GetBookIterator(bmAll, True);
    FProgressEngine.BeginOperation(BookIterator.RecordCount, rstrBookProcessedMsg1, rstrBookProcessedMsg2);
    try
      while BookIterator.Next(BookRecord) do
      begin
        if Canceled then
          Exit;

        FileName := BookRecord.GetBookFileName;
        if not FileExists(FileName)  then
        begin
          //
          // Попробуем найти файл с таким же именем и размером. Если нашли, то заменим старый путь к файлу новым.
          //
          NewFolder := FindNewFolder(ExtractFileName(FileName) + ' ' + IntToStr(BookRecord.Size));
          if NewFolder <> '*' then
          begin
            BookFormat := BookRecord.GetBookFormat;
            BookContainer := BookRecord.GetBookContainer;
            if BookFormat = bfFBD then
              BookRecord.Folder := NewFolder
            else if BookFormat = bfFb2Archive then
                   BookRecord.Folder := NewFolder + ExtractFileName(FileName)
                 else // bfFb2 or bfRaw
                    BookRecord.Folder := NewFolder;
            FCollection.SetFolder(BookRecord.BookKey, BookRecord.Folder);
          end;
        end;

        FProgressEngine.AddProgress;
      end;
    finally
      FProgressEngine.EndOperation;
    end;
  finally
    FList.Free;
  end;
end;

end.
