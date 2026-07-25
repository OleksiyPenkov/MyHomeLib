(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             25.07.2026
  * Description         Міжпроцесне блокування файлу книги на час його переписування
  *
  * History
  *
  ****************************************************************************** *)

unit unit_FileMutex;

interface

type
  //
  // Іменований м'ютекс, прив'язаний до конкретного файлу.
  //
  // Ім'я м'ютекса залежить лише від повного шляху до файлу, тож два екземпляри
  // MyHomeLib (як і два потоки одного екземпляра) отримують той самий об'єкт ядра
  // і ніколи не переписують книгу одночасно.
  //
  // Захоплення завжди неблокуюче: якщо файл уже комусь належить, книгу треба
  // пропустити, а не чекати на неї.
  //
  TFileMutex = class
  private
    FHandle: THandle;
    FAcquired: Boolean;
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;

    function TryAcquire: Boolean;
    procedure Release;

    property Acquired: Boolean read FAcquired;
  end;

implementation

uses
  Windows,
  SysUtils,
  System.Hash;

const
  MUTEX_PREFIX = 'MyHomeLib.File.';

//
// Ім'я об'єкта ядра не може містити '\', а довжина обмежена MAX_PATH, тому
// шлях згортається у хеш. Регістр прибираємо: у Windows шляхи регістронезалежні.
//
function MutexNameFor(const FileName: string): string;
begin
  Result := MUTEX_PREFIX + THashMD5.GetHashString(AnsiLowerCase(ExpandFileName(FileName)));
end;

{ TFileMutex }

constructor TFileMutex.Create(const FileName: string);
begin
  inherited Create;
  FHandle := CreateMutex(nil, False, PChar(MutexNameFor(FileName)));
  FAcquired := False;
end;

destructor TFileMutex.Destroy;
begin
  Release;
  if FHandle <> 0 then
    CloseHandle(FHandle);
  inherited;
end;

function TFileMutex.TryAcquire: Boolean;
var
  WaitResult: DWORD;
begin
  if FAcquired then
    Exit(True);

  Result := False;
  if FHandle = 0 then
    Exit;

  WaitResult := WaitForSingleObject(FHandle, 0);
  //
  // WAIT_ABANDONED означає, що попередній власник загинув, не звільнивши м'ютекс.
  // Володіння все одно переходить до нас, тому це успіх.
  //
  FAcquired := WaitResult in [WAIT_OBJECT_0, WAIT_ABANDONED];
  Result := FAcquired;
end;

procedure TFileMutex.Release;
begin
  if FAcquired then
  begin
    ReleaseMutex(FHandle);
    FAcquired := False;
  end;
end;

end.
