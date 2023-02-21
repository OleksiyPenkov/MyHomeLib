(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             20.08.2008
  * Description
  *
  * $Id: unit_CollectionWorkerThread.pas 840 2010-10-06 07:37:58Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_CollectionWorkerThread;

interface

uses
  unit_WorkerThread,
  unit_Interfaces;

type
  TCollectionWorker = class(TWorker)
  protected
    FCollectionID: Integer;

  protected
    //
    // эти поля будут инициализированы только в рабочем потоке
    //
    FSystemData: ISystemData;
    FCollection: IBookCollection;
    FCollectionRoot: string;

    procedure Initialize; override;
    procedure Uninitialize; override;

  public
    constructor Create(const CollectionID: Integer);
  end;

implementation

uses
  unit_Consts,
  dm_user;

{ TCollectionWorker }

constructor TCollectionWorker.Create(const CollectionID: Integer);
begin
  inherited Create;
  FCollectionID := CollectionID;
end;

procedure TCollectionWorker.Initialize;
begin
  inherited Initialize;

  FSystemData := DMUser.GetSystemDBConnection;
  Assert(Assigned(FSystemData));

  if FCollectionID <> MHL_INVALID_ID then
  begin
    FCollection := FSystemData.GetCollection(FCollectionID);
    Assert(Assigned(FCollection));
    FCollectionRoot := FCollection.GetProperty(PROP_ROOTFOLDER);
  end;
end;

procedure TCollectionWorker.Uninitialize;
begin
  FSystemData.ClearCollectionCache;
  inherited Uninitialize;
end;

end.
