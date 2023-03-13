(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2011 Aleksey Penkov
  *
  * Author Oleksiy Penkov   oleksiy.penkov@gmail.com
  *
  ****************************************************************************** *)
unit unit_fb2ToText;

interface

uses
  Classes,
  Windows,
  SysUtils,
  unit_globals;

type

   TFb2ToText = class
   private
     function ProceedString(const FS: string; const TagStart: string; const TagEnd: string): string;
     procedure ClearString(var FS:String);
     function GetEncoding(const S: string):TEncoding;
     function ConvertEncoding(ResEncoding: TTXTEncoding):TEncoding;
  public
    procedure Convert(const FileOut: string; ResEncoding: TTXTEncoding; Stream: TStream);
  end;

implementation

{ TFb2ToText }

uses
  StrUtils;

procedure TFb2ToText.ClearString(var FS:String);
  procedure DelTags(TagStart, TagEnd: string);
  var
    p1, p2: integer;
  begin
    repeat
      p1 := pos(TagStart, FS);
      if p1 <> 0 then
      begin
        p2 := PosEx(TagEnd, FS, p1);
        Delete(FS, p1, p2 - p1 + Length(TagEnd));
      end;
    until p1 = 0;
  end;

begin
  FS := ReplaceStr(FS,'<strong>','');
  FS := ReplaceStr(FS,'</strong>','');
  FS := ReplaceStr(FS,'<i>','');
  FS := ReplaceStr(FS,'</i>','');
  FS := ReplaceStr(FS,'<emphasis>','');
  FS := ReplaceStr(FS,'</emphasis>','');
  FS := ReplaceStr(FS,'<stanza>','');
  FS := ReplaceStr(FS,'</stanza>','');
  FS := ReplaceStr(FS,'<poem>','');
  FS := ReplaceStr(FS,'</poem>','');
  FS := ReplaceStr(FS,'<v>','');
  FS := ReplaceStr(FS,'</v>','');
  FS := ReplaceStr(FS,'<code>','');
  FS := ReplaceStr(FS,'</code>','');

  DelTags('<a ','a>');
  DelTags('<image ','/>');

end;

procedure TFb2ToText.Convert(const FileOut: string; ResEncoding: TTXTEncoding; Stream: TStream);
var
  i: integer;
  S : string;
  SLIn, SlOut: TStringList;
  tmpStr: string;
begin
  try
    SlIn := TStringList.Create;
    SlOut := TStringList.Create;

    Stream.Seek(0, soFromBeginning);
    SlIn.LoadFromStream(Stream);
    Stream.Seek(0, soFromBeginning);
    SlIn.LoadFromStream(Stream, GetEncoding(SLIn[0]));


    i := 0;
    while (pos('<body',SlIn[i]) = 0) do inc(i);

    inc(i);

    while (pos('</body>',SlIn[i]) = 0) do
    begin
      S := SlIn[i];

      if (pos('</section>',S) <> 0)  or
         (pos('</title>',S)   <> 0)  or
         (pos('<empty-line',S)<> 0)   or
         (pos('<subtitle>',S) <> 0)
      then
        SLOut.Add('');

      ClearString(S);

      tmpStr := ProceedString(S,'<subtitle>','</subtitle>');
      if tmpStr <> '' then SLOut.Add(tmpStr);

      tmpStr := ProceedString(S,'<p>','</p>');
      if tmpStr <> '' then SLOut.Add(tmpStr);

      inc(i);
    end;
    SlOut.SaveToFile(FileOut, ConvertEncoding(ResEncoding));
  finally
    FreeAndNil(SlIn);
    FreeAndNil(SlOut);
  end;
end;

function TFb2ToText.ConvertEncoding(ResEncoding: TTXTEncoding): TEncoding;
begin
  case ResEncoding of
    enUTF8: Result := TEncoding.UTF8;
    en1251: Result := TEncoding.ANSI;
    enUnicode: Result := TEncoding.Unicode;
    enUnknown: Result := TEncoding.ASCII;
  end;
end;

function TFb2ToText.GetEncoding(const S: string):TEncoding;
begin
  if Pos('windows-1251', AnsiLowerCase(S)) <> 0 then
    Result := TEncoding.ANSI
  else if Pos('utf-8', AnsiLowerCase(S)) <> 0 then
    Result := TEncoding.UTF8
  else if Pos('unicode', AnsiLowerCase(S)) <> 0 then
    Result := TEncoding.Unicode;
end;

function TFb2ToText.ProceedString(const FS: string; const TagStart: string; const TagEnd: string): string;
var
 p1, p2: Integer;
 L: Integer;
 US: string;
 OS: string;
begin
  L := Length(TagStart);
  p1 := Pos(TagStart, FS);
  US := FS;
  Result := '';
  while p1 <> 0 do
  begin
    p2 := Pos(TagEnd, US);
    OS := Copy(US,p1 + L, p2 - p1 - L);
    Result := Result + OS;
    Delete(US, 1, p2 + 3);
    p1 := Pos(TagStart, US);
  end;
end;


end.
