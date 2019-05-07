unit unit_ImportOldUserData;

interface

uses
  unit_UserData,
  Classes,
  SysUtils,
  StrUtils,
  Generics.Collections;

procedure LoadOldUserData(const FileName: string;
  var UserDataSource: TUserData);

implementation

var
  Groups: TDictionary<string, integer>;

procedure LoadGroups(const SL: TStringList; var i: Integer;
  var UserDataSource: TUserData);
var
  k: Integer;
begin
  inc(i);
  k := 1;
  while pos('#', SL[i]) = 0 do
  begin
    UserDataSource.Groups.AddGroup(k, SL[i]);
    Groups.Add(SL[i], k - 1);
    inc(k);
    inc(i);
  end;
end;

procedure LoadRates(const SL: TStringList; var i: Integer;
  var UserDataSource: TUserData);
var
  p, Rate: Integer;
  ID: string;
begin
  // Рейтинги
  inc(i);
  while pos('#', SL[i]) = 0 do
  begin
    p := pos(' ', SL[i]);
    ID := copy(SL[i], 1, p - 1);
    Rate := StrToInt(copy(SL[i], p + 1));
    UserDataSource.Extras.AddExtra(0, ID, Rate, 0, '');
    inc(i);
  end;
end;

procedure LoadFinished(const SL: TStringList; var i: Integer;
  var UserDataSource: TUserData);
var
  p, Progress: Integer;
  ID: string;
begin
  // Прочитаное
  inc(i);
  while (i < SL.Count) and (pos('#', SL[i]) = 0) do
  begin
    p := pos(' ', SL[i]);
    ID := copy(SL[i], 1, p - 1);
    Progress := StrToInt(copy(SL[i], p + 1));
    UserDataSource.Extras.AddExtra(0, ID, 0, Progress, '');
    inc(i);
  end;
end;

procedure LoadReviews(const SL: TStringList; var i: Integer;
  var UserDataSource: TUserData);
var
  p: Integer;
  S: string;
  ID: string;
begin
  // Рецензии
  inc(i);
  while (i < SL.Count) and (pos('#', SL[i]) = 0) do
  begin
    p := pos(' ', SL[i]);
    ID := copy(SL[i], 1, p - 1);
    S := copy(SL[i], p + 1);

    // StrReplace('~',#13#10,S);
    UserDataSource.Extras.AddExtra(0, ID, 0, 0, S);
    inc(i);
  end;
end;

procedure LoadGroupedBooks(const SL: TStringList; var i: Integer;
  var UserDataSource: TUserData);
var
  p, GroupID: Integer;
  ID, Name: string;
begin
  // Избранное
  inc(i);
  while (i < SL.Count) and (pos('#', SL[i]) = 0) do
  begin
    p := pos(' ', SL[i]);
    if p <> 0 then
    begin
      ID := copy(SL[i], 1, p - 1);
      Name := copy(SL[i], p + 1);
      Groups.TryGetValue(Name, GroupID);
      try
        // GroupID := StrToInt(Name);
      except
        // on E: Exception do
        GroupID := 1;
      end;
    end
    else
    begin
      ID := SL[i];
      GroupID := 1;
      Name := '';
    end;

    UserDataSource.Groups.Items[GroupID].AddBook(0, ID);
    inc(i);
  end;
end;

procedure LoadOldUserData(const FileName: string;
  var UserDataSource: TUserData);
var
  SL: TStringList;
  i: Integer;
begin
  try
    SL := TStringList.Create;
    SL.LoadFromFile(FileName);
    Groups := TDictionary<string, integer>.Create;
    i := 0;
    while (i < SL.Count) do
    begin
      if pos('#', SL[i]) <> 0 then
      begin
        if SL[i] = '# Группы' then
          LoadGroups(SL, i, UserDataSource)
        else if SL[i] = '# Рейтинги' then
          LoadRates(SL, i, UserDataSource)
        else if SL[i] = '# Прочитанное' then
          LoadFinished(SL, i, UserDataSource)
        else if SL[i] = '# Рецензии' then
          LoadReviews(SL, i, UserDataSource)
        else if SL[i] = '# Избранное' then
          LoadGroupedBooks(SL, i, UserDataSource)
        else
          inc(i);
      end;
    end;
  finally
    FreeAndNil(SL);
    FreeAndNil(Groups);
  end;
end;

end.
