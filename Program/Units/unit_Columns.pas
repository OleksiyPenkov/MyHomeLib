(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  *                     Nick Rymanov (nrymanov@gmail.com)
  * Created             12.02.2010
  * Description
  *
  * $Id: unit_Columns.pas 1115 2012-04-23 07:37:40Z koreec $
  *
  * History
  * NickR 15.02.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit unit_Columns;

interface

uses
  Windows,
  Classes,
  SysUtils,
  VirtualTrees,
  VirtualTrees.Types,
  IniFiles,
  unit_Globals;          // для TTreeMode

type
  TColumnDesc = class(TCollectionItem)
  private
    FCaption: string;
    FTag: Integer;
    FWidth: Integer;
    FMaxWidth: Integer;
    FMinWidth: Integer;
    FAlignment: TAlignment;
    FOptions: TVTColumnOptions;
    FPosition: Integer;

  public
    property Caption: string read FCaption write FCaption;
    property Tag: Integer read FTag write FTag;
    property Width: Integer read FWidth write FWidth;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property MinWidth: Integer read FMinWidth write FMinWidth;
    property Alignment: TAlignment read FAlignment write FAlignment;
    property Options: TVTColumnOptions read FOptions write FOptions;
    property Position: Integer read FPosition write FPosition;
  end;

  TColumns = class(TCollection)
  private
    FIniFile: TIniFile;
    FMode: TTreeMode;

    function GetColumn(Index: Integer): TColumnDesc;
    procedure SetColumn(Index: Integer; const Value: TColumnDesc);

    function AddColumn: TColumnDesc;

    procedure LoadDefault(const Section: string);

  public
    constructor Create(const FileName: string);
    destructor Destroy; override;

    procedure Add(const Tag: Integer; const Width: Integer; const Position: Integer);

    procedure Load(const Section: string; Mode: TTreeMode);
    procedure Save(const Section: string);

    procedure SetColumns(Obj: TVirtualTreeColumns);
    procedure GetColumns(Obj: TVirtualTreeColumns);

    property Mode: TTreeMode read FMode write FMode;
    property Items[Index: Integer]: TColumnDesc read GetColumn write SetColumn; default;
  end;

procedure GetDefaultColumnProperties(
  Mode: TTreeMode;
  Tag: Integer;
  out Caption: string;
  out MinWidth: Integer;
  out MaxWidth: Integer;
  out Alignment: TAlignment;
  out Options: TVTColumnOptions
  );

implementation

uses
  unit_Consts,
  unit_Helpers;

resourcestring
  rstrAuthor = 'Автор';
  rstrTitle = 'Название';
  rstrSeries = 'Серия';
  rstrNO = '№';
  rstrSize = 'Размер';
  rstrRate = 'Моя оценка';
  rstrDate = 'Добавлено';
  rstrGenre = 'Жанр';
  rstrCollection = 'Коллекция';
  rstrType = 'Тип';
  rstrLang = 'Язык';
  rstrLibrate = 'Рейтинг';
  rstrLibID = 'BookID';

const
  //
  // Наборы опций для изменяемых и неизменяемых колонок
  //
  BASE_COLUMN_OPTIONS              = [coDraggable, coEnabled, coParentColor, coVisible, coShowDropMark];

  RESIZABLE_COLUMN_OPTIONS         = BASE_COLUMN_OPTIONS + [coResizable, coAutoSpring];
  RESIZABLE_CLICK_COLUMN_OPTIONS   = BASE_COLUMN_OPTIONS + [coResizable, coAllowClick];

  FIXED_COLUMN_OPTIONS             = BASE_COLUMN_OPTIONS + [];
  FIXED_CLICK_COLUMN_OPTIONS       = BASE_COLUMN_OPTIONS + [coAllowClick];

procedure GetDefaultColumnProperties(
  Mode: TTreeMode;
  Tag: Integer;
  out Caption: string;
  out MinWidth: Integer;
  out MaxWidth: Integer;
  out Alignment: TAlignment;
  out Options: TVTColumnOptions
  );
var
  Fix: TVTColumnOptions;
  Rez: TVTColumnOptions;
begin
  if Mode = tmTree then
  begin
    Rez := RESIZABLE_COLUMN_OPTIONS;
    Fix := FIXED_COLUMN_OPTIONS;
  end
  else
  begin
    Rez := RESIZABLE_CLICK_COLUMN_OPTIONS;
    Fix := FIXED_CLICK_COLUMN_OPTIONS;
  end;

  case Tag of
    COL_AUTHOR:
      begin
        Caption := rstrAuthor;
        MaxWidth := 900;
        MinWidth := 30;
        Alignment := taLeftJustify;
        Options := Rez;
      end;

    COL_TITLE:
      begin
        Caption := rstrTitle;
        MaxWidth := 900;
        MinWidth := 30;
        Alignment := taLeftJustify;
        Options := Rez;
      end;

    COL_SERIES:
      begin
        Caption := rstrSeries;
        MaxWidth := 900;
        MinWidth := 30;
        Alignment := taLeftJustify;
        Options := Rez;
      end;

    COL_NO:
      begin
        Caption := rstrNO;
        MaxWidth := 900;
        MinWidth := 20;
        Alignment := taRightJustify;
        Options := Rez;
      end;

    COL_SIZE:
      begin
        Caption := rstrSize;
        MaxWidth := 900;
        MinWidth := 20;
        Alignment := taRightJustify;
        Options := Rez;
      end;

    COL_RATE:
      begin
        Caption := rstrRate;
        MaxWidth := 100;
        MinWidth := 70;
        Alignment := taCenter;
        Options := Rez;
      end;

    COL_DATE:
      begin
        Caption := rstrDate;
        MaxWidth := 900;
        MinWidth := 40;
        Alignment := taLeftJustify;
        Options := Rez;
      end;

    COL_GENRE:
      begin
        Caption := rstrGenre;
        MaxWidth := 900;
        MinWidth := 30;
        Alignment := taLeftJustify;
        Options := Rez;
      end;

    COL_COLLECTION:
      begin
        Caption := rstrCollection;
        MaxWidth := 900;
        MinWidth := 30;
        Alignment := taLeftJustify;
        Options := Rez;
      end;

    COL_TYPE:
      begin
        Caption := rstrType;
        MaxWidth := 55;
        MinWidth := 55;
        Alignment := taCenter;
        Options := Fix;
      end;

    COL_LANG:
      begin
        Caption := rstrLang;
        MaxWidth := 55;
        MinWidth := 55;
        Alignment := taCenter;
        Options := Fix;
      end;

    COL_LIBRATE:
      begin
        Caption := rstrLibrate;
        MaxWidth := 100;
        MinWidth := 70;
        Alignment := taCenter;
        Options := Rez;
      end;

    COL_STATE:
      begin
        Caption := '';
        MaxWidth := 35;
        MinWidth := 35;
        Alignment := taCenter;
        Options := Fix - [coDraggable] + [coFixed];
      end;

    COL_LIBID:
      begin
        Caption := rstrLibID;
        MaxWidth := 100;
        MinWidth := 55;
        Alignment := taCenter;
        Options := Rez;
      end;
  end;
end;

{ TColumns }

constructor TColumns.Create(const FileName: string);
begin
  inherited Create(TColumnDesc);
  FIniFile := TIniFile.Create(FileName);
end;

destructor TColumns.Destroy;
begin
  FreeAndNil(FIniFile);
  inherited Destroy;
end;

procedure TColumns.Add(const Tag: Integer; const Width: Integer; const Position: Integer);
var
  Column: TColumnDesc;
begin
  BeginUpdate;
  try
    Column := AddColumn;
    try
      Column.Tag := Tag;
      Column.Width := Width;
      Column.Position := Position;
      //
      // не изменяемые пользователем значения
      //
      GetDefaultColumnProperties(FMode, Tag, Column.FCaption, Column.FMinWidth, Column.FMaxWidth, Column.FAlignment, Column.FOptions);
    except
      Column.Free;
      raise ;
    end;
  finally
    EndUpdate;
  end;
end;

function TColumns.AddColumn: TColumnDesc;
begin
  Result := TColumnDesc(inherited Add);
end;

function TColumns.GetColumn(Index: Integer): TColumnDesc;
begin
  Result := TColumnDesc(inherited Items[Index]);
end;

procedure TColumns.SetColumn(Index: Integer; const Value: TColumnDesc);
begin
  inherited Items[Index] := Value;
end;

procedure TColumns.GetColumns(Obj: TVirtualTreeColumns);
var
  i: Integer;
  Column: TColumnDesc;
begin
  BeginUpdate;
  try
    Clear;

    for i := 0 to Obj.Count - 1 do
    begin
      Column := AddColumn;
      Column.Caption := Obj.Items[i].Text;
      Column.Width := Obj.Items[i].Width;
      Column.MaxWidth := Obj.Items[i].MaxWidth;
      Column.MinWidth := Obj.Items[i].MinWidth;
      Column.Alignment := Obj.Items[i].Alignment;
      Column.Options := Obj.Items[i].Options;
      Column.Tag := Obj.Items[i].Tag;
      Column.Position := Obj.Items[i].Position;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TColumns.Load(const Section: string; Mode: TTreeMode);
var
  sl: TStringList;
  slHelper: TStringList;
  i: Integer;
begin
  Clear;
  FMode := Mode;
  sl := TStringList.Create;
  try
    FIniFile.ReadSection(Section, sl);
    if sl.Count > 0 then
    begin
      slHelper := TIniStringList.Create;
      try
        for i := 0 to sl.Count - 1 do
        begin
          if Pos('Column', sl[i]) = 1 then
          begin
            slHelper.DelimitedText := FIniFile.ReadString(Section, sl[i], '');
            if slHelper.Count = 3 then
              Add(StrToInt(slHelper[0]), StrToInt(slHelper[1]), StrToInt(slHelper[2]));
          end;
        end;
      finally
        slHelper.Free;
      end;
    end
    else
      LoadDefault(Section);
  finally
    sl.Free;
  end;
end;

procedure TColumns.LoadDefault(const Section: string);
begin
  if Section = SECTION_A_FLAT then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_TITLE, 200, 1);
    Add(COL_SERIES, 200, 2);
    Add(COL_NO, 30, 3);
    Add(COL_SIZE, 70, 4);
    Add(COL_RATE, 80, 5);
    Add(COL_DATE, 200, 6);
    Add(COL_GENRE, 200, 7);
  end
  else if Section = SECTION_A_TREE then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_TITLE, 200, 1);
    Add(COL_NO, 30, 2);
    Add(COL_SIZE, 70, 3);
    Add(COL_RATE, 80, 4);
    Add(COL_DATE, 200, 5);
    Add(COL_GENRE, 200, 6);
  end
  else if Section = SECTION_S_FLAT then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_AUTHOR, 200, 1);
    Add(COL_TITLE, 200, 2);
    Add(COL_NO, 40, 3);
    Add(COL_SIZE, 70, 4);
    Add(COL_RATE, 80, 5);
    Add(COL_DATE, 200, 7);
    Add(COL_GENRE, 200, 6);
  end
  else if Section = SECTION_S_TREE then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_AUTHOR, 200, 1);
    Add(COL_TITLE, 200, 2);
    Add(COL_NO, 40, 3);
    Add(COL_SIZE, 70, 4);
    Add(COL_RATE, 80, 5);
    Add(COL_DATE, 200, 7);
    Add(COL_GENRE, 200, 6);
  end
  else if Section = SECTION_G_FLAT then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_AUTHOR, 200, 1);
    Add(COL_TITLE, 200, 2);
    Add(COL_SERIES, 200, 3);
    Add(COL_NO, 30, 4);
    Add(COL_SIZE, 70, 5);
    Add(COL_RATE, 80, 6);
    Add(COL_DATE, 200, 8);
    Add(COL_GENRE, 200, 7);
  end
  else if Section = SECTION_G_TREE then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_TITLE, 300, 1);
    Add(COL_NO, 30, 2);
    Add(COL_SIZE, 70, 3);
    Add(COL_RATE, 80, 4);
    Add(COL_GENRE, 200, 5);
  end
  else if Section = SECTION_F_FLAT then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_AUTHOR, 200, 1);
    Add(COL_TITLE, 200, 2);
    Add(COL_SERIES, 200, 3);
    Add(COL_NO, 30, 4);
    Add(COL_SIZE, 70, 5);
    Add(COL_RATE, 80, 6);
    Add(COL_DATE, 200, 8);
    Add(COL_GENRE, 200, 7);
  end
  else if Section = SECTION_F_TREE then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_TITLE, 300, 1);
    Add(COL_NO, 30, 2);
    Add(COL_SIZE, 70, 3);
    Add(COL_RATE, 80, 4);
    Add(COL_DATE, 200, 6);
    Add(COL_GENRE, 200, 5);
    Add(COL_COLLECTION, 200, 7);
  end
  else if Section = SECTION_SR_FLAT then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_AUTHOR, 200, 1);
    Add(COL_TITLE, 200, 2);
    Add(COL_SERIES, 200, 3);
    Add(COL_NO, 30, 4);
    Add(COL_SIZE, 70, 5);
    Add(COL_RATE, 80, 6);
    Add(COL_DATE, 200, 8);
    Add(COL_GENRE, 200, 7);
  end
  else if Section = SECTION_SR_TREE then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_TITLE, 300, 1);
    Add(COL_NO, 30, 2);
    Add(COL_SIZE, 70, 3);
    Add(COL_RATE, 80, 4);
    Add(COL_DATE, 200, 6);
    Add(COL_GENRE, 200, 5);
  end
  else if Section = SECTION_FL_FLAT then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_AUTHOR, 200, 1);
    Add(COL_TITLE, 200, 2);
    Add(COL_SERIES, 200, 3);
    Add(COL_NO, 30, 4);
    Add(COL_SIZE, 70, 5);
    Add(COL_RATE, 80, 6);
    Add(COL_DATE, 200, 8);
    Add(COL_GENRE, 200, 7);
  end
  else if Section = SECTION_FL_TREE then
  begin
    Add(COL_STATE, 15, 0);
    Add(COL_TITLE, 300, 1);
    Add(COL_NO, 30, 2);
    Add(COL_SIZE, 70, 3);
    Add(COL_RATE, 80, 4);
    Add(COL_DATE, 200, 6);
    Add(COL_GENRE, 200, 5);
  end;
end;

procedure TColumns.Save(const Section: string);
var
  i: Integer;
  sl: TStringList;
begin
  FIniFile.EraseSection(Section);

  if Count > 0 then
  begin
    sl := TIniStringList.Create;
    try
      for i := 0 to Count - 1 do
      begin
        sl.Clear;
        sl.Add(IntToStr(Items[i].Tag));
        sl.Add(IntToStr(Items[i].Width));
        sl.Add(IntToStr(Items[i].Position));

        FIniFile.WriteString(Section, Format('%s%u', ['Column', i]), sl.DelimitedText);
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TColumns.SetColumns(Obj: TVirtualTreeColumns);
var
  i: Integer;
  Column: TVirtualTreeColumn;
begin
  Obj.BeginUpdate;
  try
    Obj.Clear;
    for i := 0 to Count - 1 do
    begin
      Column := TVirtualTreeColumn.Create(Obj);
      Column.Text := Items[i].Caption;
      Column.Position := i;
      Column.Width := Items[i].Width;
      Column.MaxWidth := Items[i].MaxWidth;
      Column.MinWidth := Items[i].MinWidth;
      Column.Alignment := Items[i].Alignment;
      Column.Options := Items[i].Options;
      Column.Tag := Items[i].Tag;
      Column.Position := Items[i].Position;
    end;
  finally
    Obj.EndUpdate;
  end;
end;

end.
