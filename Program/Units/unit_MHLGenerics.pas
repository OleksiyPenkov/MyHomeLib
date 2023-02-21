(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             23.09.2010
  * Description
  *
  * $Id: unit_MHLGenerics.pas 807 2010-09-23 06:42:24Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_MHLGenerics;

interface

uses
  Windows,
  Generics.Collections;

type
  TInterfaceCache<TKey; TValue: IInterface> = class
  private type
    TInterfaceAdapter = class
    public
      constructor Create(const Value: TValue);

    private
      FValue: TValue;
    end;

  private
    FMap: TObjectDictionary<TKey, TInterfaceAdapter>;
    FLock: TRTLCriticalSection;

  public
    constructor Create;
    destructor Destroy; override;

    procedure LockMap; inline;
    procedure UnlockMap; inline;

    function ContainsKey(const key: TKey): Boolean;
    procedure Add(const key: TKey; const Value: TValue);
    procedure AddOrSetValue(const Key: TKey; const Value: TValue);
    function Get(const key: TKey): TValue;
    procedure Remove(const key: TKey);
    procedure Clear;
  end;

  TConversion<T> = reference to function(const items: T): string;
  TValueSetter<T> = reference to procedure(var Item: T; const Value: string);

  TArrayUtils = class
  public type
    TStringArray = array of string;
    TValuesArray<T> = array of T;

  public
    class function Join(
      const Values: array of string;
      const itemDelimeter: string
    ): string; overload;

    class function Join<T>(
      const Values: array of T;
      const itemDelimeter: string;
      const Converter: TConversion<T>
    ): string; overload;

    class function Join<T>(
      const Values: TEnumerable<T>;
      const itemDelimeter: string;
      const Converter: TConversion<T>
    ): string; overload;

    class procedure Split(
      const Value: string;
      const itemDelimeter: string;
      var Items: TStringArray
    ); overload;

    class procedure Split<T>(
      const Value: string;
      const itemDelimeter: string;
      var Items: TValuesArray<T>;
      const Setter: TValueSetter<T>
    ); overload;
  end;

implementation

uses
  StrUtils;

{ TInterfaceCache<TKey, TValue>.TInterfaceAdapter }

constructor TInterfaceCache<TKey, TValue>.TInterfaceAdapter.Create(const Value: TValue);
begin
  inherited Create;
  FValue := Value;
end;

{ TInterfaceCache<TKey, TValue> }

constructor TInterfaceCache<TKey, TValue>.Create;
begin
  inherited Create;
  InitializeCriticalSection(FLock);
  FMap := TObjectDictionary<TKey, TInterfaceAdapter>.Create([doOwnsValues]);
end;

destructor TInterfaceCache<TKey, TValue>.Destroy;
begin
  LockMap;    // Make sure nobody else is inside the list.
  try
    FMap.Free;
    inherited Destroy;
  finally
    UnlockMap;
    DeleteCriticalSection(FLock);
  end;
end;

procedure TInterfaceCache<TKey, TValue>.LockMap;
begin
  EnterCriticalSection(FLock);
end;

procedure TInterfaceCache<TKey, TValue>.UnlockMap;
begin
  LeaveCriticalSection(FLock);
end;

function TInterfaceCache<TKey, TValue>.ContainsKey(const key: TKey): Boolean;
begin
  LockMap;
  try
    Result := FMap.ContainsKey(key);
  finally
    UnlockMap;
  end;
end;

procedure TInterfaceCache<TKey, TValue>.Add(const key: TKey; const Value: TValue);
begin
  LockMap;
  try
    FMap.Add(key, TInterfaceAdapter.Create(Value));
  finally
    UnlockMap;
  end;
end;

procedure TInterfaceCache<TKey, TValue>.AddOrSetValue(const Key: TKey; const Value: TValue);
begin
  LockMap;
  try
    FMap.AddOrSetValue(key, TInterfaceAdapter.Create(Value));
  finally
    UnlockMap;
  end;
end;

function TInterfaceCache<TKey, TValue>.Get(const key: TKey): TValue;
begin
  LockMap;
  try
    Result := FMap[key].FValue;
  finally
    UnlockMap;
  end;
end;

procedure TInterfaceCache<TKey, TValue>.Remove(const key: TKey);
begin
  LockMap;
  try
    FMap.Remove(key);
  finally
    UnlockMap;
  end;
end;

procedure TInterfaceCache<TKey, TValue>.Clear;
begin
  LockMap;
  try
    FMap.Clear;
  finally
    UnlockMap;
  end;
end;

{ TArrayUtils }

class function TArrayUtils.Join(const Values: array of string; const itemDelimeter: string): string;
var
  L, R: Integer;
begin
  if Length(Values) = 0 then
    Exit;

  L := Low(Values);
  R := High(Values);

  Result := Values[L];
  Inc(L);

  while L <= R do
  begin
    Result := Result + itemDelimeter + Values[L];
    Inc(L);
  end;
end;

class function TArrayUtils.Join<T>(const Values: array of T; const itemDelimeter: string; const Converter: TConversion<T>): string;
var
  i, L, R: Integer;
begin
  if Length(Values) = 0 then
    Exit;

  L := Low(Values);
  R := High(Values);

  Result := Converter(Values[L]);
  Inc(L);

  while L <= R do
  begin
    Result := Result + itemDelimeter + Converter(Values[L]);
    Inc(L);
  end;
end;

class function TArrayUtils.Join<T>(
  const Values: TEnumerable<T>;
  const itemDelimeter: string;
  const Converter: TConversion<T>
  ): string;
var
  Enum: TEnumerator<T>;
begin
  Enum := Values.GetEnumerator();
  try
    if Enum.MoveNext then
    begin
      Result := Converter(Enum.Current);
      while Enum.MoveNext do
        Result := Result + itemDelimeter + Converter(Enum.Current);
    end;
  finally
    Enum.Free;
  end;
end;

class procedure TArrayUtils.Split(
  const Value: string;
  const itemDelimeter: string;
  var Items: TStringArray
);
var
  ValueLen: Integer;
  SeparatorLen: Integer;
  StartPos: Integer;
  SeparatorPos: Integer;

  ItemsLen: Integer;

  s: string;
begin
  ValueLen := Length(Value);
  SeparatorLen := Length(itemDelimeter);
  StartPos := 1;
  ItemsLen := Length(Items);

  SeparatorPos := PosEx(itemDelimeter, Value, StartPos);
  while SeparatorPos <> 0 do
  begin
    s := Copy(Value, StartPos, SeparatorPos - StartPos);
    StartPos := SeparatorPos + SeparatorLen;
    SeparatorPos := PosEx(itemDelimeter, Value, StartPos);

    SetLength(Items, ItemsLen + 1);
    Items[ItemsLen] := s;
    Inc(ItemsLen);
  end;

  if StartPos < ValueLen then
  begin
    s := Copy(Value, StartPos, ValueLen);
    SetLength(Items, ItemsLen + 1);
    Items[ItemsLen] := s;
  end;
end;

class procedure TArrayUtils.Split<T>(
  const Value: string;
  const itemDelimeter: string;
  var Items: TValuesArray<T>;
  const Setter: TValueSetter<T>
);
var
  ValueLen: Integer;
  SeparatorLen: Integer;
  StartPos: Integer;
  SeparatorPos: Integer;

  ItemsLen: Integer;

  s: string;
begin
  ValueLen := Length(Value);
  SeparatorLen := Length(itemDelimeter);
  StartPos := 1;
  ItemsLen := Length(Items);

  SeparatorPos := PosEx(itemDelimeter, Value, StartPos);
  while SeparatorPos <> 0 do
  begin
    s := Copy(Value, StartPos, SeparatorPos - StartPos);
    StartPos := SeparatorPos + SeparatorLen;
    SeparatorPos := PosEx(itemDelimeter, Value, StartPos);
    SetLength(Items, ItemsLen + 1);
    Setter(Items[ItemsLen], s);
    Inc(ItemsLen);
  end;

  if StartPos < ValueLen then
  begin
    s := Copy(Value, StartPos, ValueLen);
    SetLength(Items, ItemsLen + 1);
    Setter(Items[ItemsLen], s);
  end;
end;

end.
