(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Matvienko Sergei  matv84@mail.ru
  * Created             12.02.2010
  * Description         Класс работы с шаблонами
  *
  * $Id: unit_Templater.pas 1157 2014-04-16 15:57:13Z Demsa $
  *
  * History
  * NickR 15.02.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit unit_Templater;

interface

uses
  FictionBook_21,
  unit_Globals;

const
  COL_MASK_ELEMENTS = 13;

type
  TErrorType = (ErFine, ErTemplate, ErBlocks, ErElements);
  TTemplateType = (TpFile, TpPath, TpText);

  TElement = record
    name: string;
    BegBlock, EndBlock: Integer;
  end;

  TTemplater = class
  private
    FTemplate: string;
    FBlocksMap: array[0..255] of TElement;
    ColElements: byte;
  public
    constructor Create;

    function ValidateTemplate(const Template: string; TemplType: TTemplateType)
      : TErrorType;
    function SetTemplate(Template: string; TemplType: TTemplateType)
      : TErrorType;
    function ParseString(R: TBookRecord; TemplType: TTemplateType): string;
  end;

implementation

uses
  SysUtils,
  unit_Consts,
  dm_user;

constructor TTemplater.Create;
begin
  inherited;
  FTemplate := '';
end;

function TTemplater.ValidateTemplate(const Template: string;
  TemplType: TTemplateType): TErrorType;
const
  { DONE : совпадает с названием константы }
  MASK_ELEMENTS: array [1 .. COL_MASK_ELEMENTS] of string = ('f', 'fa', 't',
    's', 'n', 'id', 'g', 'ga', 'ff', 'fl', 'rg', 'fn', 'fc');
var
  stack: array [0..255] of TElement;
  h, k, i, j, StackPos, ElementPos, last_char,
    last_col_elements: Integer;
  bol, TemplEnd: boolean;
  TemplatePart: string;
begin
  if Template = '' then
  begin
    if TemplType <> TpPath then
      Result := ErTemplate
    else
      Result := ErFine;
    Exit;
  end;

  // Поправка на количество частей пути в карту элементов и блоков (используется при разборе путей)
  last_col_elements := 0;
  last_char := 0;

  // Определение количества элементов в шаблоне
  ColElements := 0;
  for i := 1 to Length(Template) do
    if Template[i] = '%' then
      Inc(ColElements);

  // Установка необходимой размерности и инициализация массивов
//  SetLength(stack, ColElements);
  //SetLength(FBlocksMap, ColElements);
  for i := 0 to ColElements - 1 do
  begin
    stack[i].name := '';
    FBlocksMap[i].name := '';
  end;

  TemplEnd := false;
  k := 1;
  while not(TemplEnd) do
  begin
    i := 1;
    TemplatePart := '';

    // Разбор пути к файлу на составляющие
    while (not(Template[k] = '\')) and (k <= Length(Template)) do
    begin
      TemplatePart := TemplatePart + Template[k];
      Inc(k);
    end;
    Inc(k);
    // Если больше нет элементов пути, то итеррация крайняя
    if k > Length(Template) then
      TemplEnd := True;

    // Инициализация счётчика глубины стека и элементов шаблона
    StackPos := 0;
    ElementPos := 0;
    while i <= Length(TemplatePart) do
    begin
      // Поиск открывающей скобки блока элемента
      if TemplatePart[i] = '[' then
      begin
        Inc(StackPos);
        if (StackPos >= ColElements) then
        begin
          Result := ErTemplate; // prevent an access violation (exceeding "stack" var size)
          Exit;
        end;
        stack[StackPos].BegBlock := i;
        stack[StackPos].name := '';

      end;

      // Поиск элемента шаблона
      if TemplatePart[i] = '%' then
      begin
        // Если внутри блока имеется более одного элемента, то шаблон неправильный
        if (stack[StackPos].name <> '') and (StackPos > 0) then
        begin
          Result := ErTemplate; // В блоке не может быть более одного элемента
          Exit;
        end;

        // Выделяем название элемента
        Inc(i);
        stack[StackPos].name := '';
        while CharInSet(TemplatePart[i], ['a' .. 'z', 'A' .. 'Z']) do
        begin
          stack[StackPos].name := stack[StackPos].name + TemplatePart[i];
          Inc(i);
        end;
        if stack[StackPos].name = '' then
        begin
          Result := ErElements;
          Exit;
        end;
        Dec(i);

        // Добавляем элемент в общий список элементов
        if StackPos = 0 then
        begin
          FBlocksMap[ElementPos + last_col_elements].name :=
            stack[StackPos].name;
          FBlocksMap[ElementPos + last_col_elements].BegBlock := 0;
          FBlocksMap[ElementPos + last_col_elements].EndBlock := 0;
          Inc(ElementPos);
        end;
      end;

      // Поиск окончания блока элемента
      if TemplatePart[i] = ']' then
      begin
        // Если на текущем уровне стека нет элемента или элемент на 0-м уровне
        // то шаблон неправильный
        if (stack[StackPos].name = '') or (StackPos <= 0) then
        begin
          Result := ErBlocks;
          // Проверьте соответствие открывающих и закрывающих скобок блоков элементов
          Exit;
        end;
        stack[StackPos].EndBlock := i;

        // Добавляем элемент в общий список элементов
        FBlocksMap[ElementPos + last_col_elements].name := stack[StackPos].name;
        FBlocksMap[ElementPos + last_col_elements].BegBlock :=
          stack[StackPos].BegBlock + last_char;
        FBlocksMap[ElementPos + last_col_elements].EndBlock :=
          stack[StackPos].EndBlock + last_char;
        Inc(ElementPos);
        Dec(StackPos);
      end;
      // Переход к очередному символу в шаблоне
      Inc(i);
    end;

    // Имеются незакрытые скобки блоков
    if StackPos > 0 then
    begin
      Result := ErBlocks;
      // Проверьте соответствие открывающих и закрывающих скобок блоков элементов
      Exit;
    end;

    // Проверка всех элементов на правильность написания
    for h := 0 to ColElements - 1 do
    begin
      if FBlocksMap[h].name <> '' then
      begin
        bol := false;
        for j := 1 to High(MASK_ELEMENTS) do
          if UpperCase(FBlocksMap[h].name) = UpperCase(MASK_ELEMENTS[j]) then
          begin
            bol := True;
            Break;
          end;

        if not(bol) then
          Break;
      end;
    end;

    // Имеются неверние элементы шаблона
    if not(bol) then
    begin
      Result := ErElements; // Неверные элементы шаблона
      Exit;
    end;

    Inc(last_col_elements, ElementPos);

    // Поправка на количество символов с начала строки шаблона в
    // карту элементов и блоков (используется при разборе путей)
    last_char := last_char + k - 1;

    // Переход к очередному символу в шаблоне с целью обработки следующей части пути к файлу
    Inc(i);
  end;

  // Если проверяем шаблон имени файла, то бэкслэш не допустим
  if TemplType = TpFile then
    if pos('\', Template) <> 0 then
    begin
      Result := ErTemplate;
      Exit;
    end;

  // Если замечаний нет, то шаблон валиден
  Result := ErFine;
end;

function TTemplater.SetTemplate(Template: String; TemplType: TTemplateType)
  : TErrorType;
begin
  Result := ValidateTemplate(Template, TemplType);

  // Спецсимволы чистим только для имени файла или пути к файлу
  if TemplType in [TpFile, TpPath] then
    Template := CheckSymbols(Template, False);

  if Result = ErFine then
    FTemplate := Trim(Template);
end;

function TTemplater.ParseString(R: TBookRecord;
  TemplType: TTemplateType): string;
type
  TMaskElement = record
    templ, value: string;
  end;

  TMaskElements = array [1 .. COL_MASK_ELEMENTS] of TMaskElement;
var
  AuthorName, s: string;
  i, j: Integer;
  MaskElements: TMaskElements;
  p1, p2: Integer;
begin
  Result := FTemplate;

  // Формирование массива значений элементов маски
  MaskElements[1].templ := 'ga';
  for i := Low(R.Genres) to High(R.Genres) do
  begin
    MaskElements[1].value := MaskElements[1].value +
      CheckSymbols(R.Genres[i].GenreAlias, True);
    if i < High(R.Genres) then
      MaskElements[1].value := MaskElements[1].value + ', ';
  end;

  MaskElements[2].templ := 'rg';
  MaskElements[2].value := Trim(CleanFileName(R.RootGenre.GenreAlias));

  MaskElements[3].templ := 'g';
  if R.GenreCount > 0 then
    MaskElements[3].value := Trim(CleanFileName(R.Genres[0].GenreAlias))
  else
    MaskElements[3].value := '';

  MaskElements[4].templ := 'ff';
  if R.AuthorCount > 0 then
  begin
    s := Trim(CheckSymbols(R.Authors[ Low(R.Authors)].FLastName, True));
    MaskElements[4].value := s[1];
  end
  else
    MaskElements[4].value := '';

  MaskElements[5].templ := 'fa';
  AuthorName := '';
  if R.AuthorCount > 0 then
    for i := 0 to High(R.Authors) do
    begin
      AuthorName := AuthorName + CleanFileName(R.Authors[i].GetFullName(True));
      if i < High(R.Authors) then
        AuthorName := AuthorName + ', ';
    end;
  MaskElements[5].value := CleanFileName(AuthorName);

  MaskElements[6].templ := 'fl';
  if R.AuthorCount > 0 then
    MaskElements[6].value := Trim(CleanFileName(R.Authors[0].FLastName))
  else
    MaskElements[6].value := '';

  MaskElements[7].templ := 'fn';
  if R.AuthorCount > 0 then
    MaskElements[7].value := Trim(CleanFileName(R.Authors[0].FLastName + ' ' + R.Authors[0].FFirstName))
  else
    MaskElements[7].value := '';

  MaskElements[8].templ := 'fc';
  if CurrentSelectedAuthor <> ''  then
    MaskElements[8].value := CurrentSelectedAuthor
  else
    // Повтор алгоритма из пункта 9
  if R.AuthorCount > 0 then
    MaskElements[8].value := Trim(CleanFileName(R.Authors[0].GetFullName))
  else
    MaskElements[8].value := '';

  // Может поменять шаблон? т.к. при добавлении шаблонов на f приходится менять структуру.
  MaskElements[9].templ := 'f';
  if R.AuthorCount > 0 then
    MaskElements[9].value := Trim(CleanFileName(R.Authors[0].GetFullName))
  else
    MaskElements[9].value := '';

  MaskElements[10].templ := 's';
  MaskElements[10].value := Trim(CleanFileName(R.Series));

  MaskElements[11].templ := 'n';
  if R.SeqNumber <> 0 then
    MaskElements[11].value := Format('%.2d', [R.SeqNumber])
  else
    MaskElements[11].value := '';

  MaskElements[12].templ := 't';
  MaskElements[12].value := Trim(CleanFileName(R.Title));

  MaskElements[13].templ := 'id';
  MaskElements[13].value := R.LibID;

  // Цикл удаления "пустых" блоков
  for i := Low(MaskElements) to High(MaskElements) do
    for j := 0 to ColElements - 1 do
      if (UpperCase(MaskElements[i].templ) = UpperCase(FBlocksMap[j].name)) and
        (MaskElements[i].value = '') then
        if (FBlocksMap[j].BegBlock <> 0) and (FBlocksMap[j].EndBlock <> 0) then
        begin
          Delete(Result, FBlocksMap[j].BegBlock, FBlocksMap[j].EndBlock -
            FBlocksMap[j].BegBlock + 1);
          // Здесь ещё продумаю вариант удаления записей о вложенных элементах без валидации
          ValidateTemplate(Result, TemplType);
        end;

  StrReplace('[', '', Result);
  StrReplace(']', '', Result);

  // Цикл замены элементов шаблона их значениями
  for i := 1 to COL_MASK_ELEMENTS do
  begin
    S := Transliterate(MaskElements[i].value);
    StrReplace('%' + UpperCase(MaskElements[i].templ), S, Result);
    StrReplace('%' + MaskElements[i].templ, MaskElements[i].value, Result);
  end;

  // Удаление содержимого квадратных скобок из названий (для либрусека)
  if Settings.RemoveSquarebrackets then
  begin
    p1 := pos('[', Result);
    p2 := pos(']', Result);
    if (p1 > 0) and (p2 > 0) and (p1 < p2) then
    begin
      Delete(Result, p1, p2 - p1 + 1);
      Trim(Result);
    end;
  end;
end;

end.
