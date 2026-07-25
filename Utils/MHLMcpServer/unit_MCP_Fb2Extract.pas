unit unit_MCP_Fb2Extract;

interface

uses
  System.Classes,
  System.SysUtils;

type
  EFb2ExtractError = class(Exception);

  TFb2Section = record
    Title: string;
    Level: Integer;
    Offset: Integer;
    Length: Integer;
  end;

  TFb2Sections = array of TFb2Section;

  TFb2Extraction = record
    Text: string;
    Sections: TFb2Sections;
    Structured: Boolean;
  end;

// Walks an FB2 DOM once, building Text and Sections from the same character
// space so a Sections[i].Offset always indexes correctly into Text. Falls
// back to a tag-stripping scan (Structured=False, Sections empty) when the
// DOM parse fails -- malformed FB2 is common in real libraries. Raises
// EFb2ExtractError only when neither path produces usable text.
function ExtractFb2(Stream: TStream): TFb2Extraction;

implementation

uses
  System.Variants,
  Xml.XMLIntf,
  Xml.XMLDoc,
  Xml.xmldom;

type
  // Walks the DOM exactly once, appending every bit of body text to FText and
  // recording each <section>'s start/end offsets into that same
  // TStringBuilder as it descends. This is what keeps a TOC offset and the
  // extracted text in the same character space -- see the unit header.
  TFb2Walker = class
  private
    FText: TStringBuilder;
    FSections: TFb2Sections;
    procedure WalkNode(const Node: IXMLNode; Level: Integer);
    function NodeText(const Node: IXMLNode): string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Walk(const Root: IXMLNode);
    property Text: TStringBuilder read FText;
    property Sections: TFb2Sections read FSections;
  end;

constructor TFb2Walker.Create;
begin
  inherited Create;
  FText := TStringBuilder.Create;
end;

destructor TFb2Walker.Destroy;
begin
  FText.Free;
  inherited Destroy;
end;

// Flatten a node's descendant text without recording sections. Used for
// <title> text (which is folded into a section's own title/offset span by
// WalkNode, not tracked as a nested section) and is not on the main text-walk
// path for anything else.
function TFb2Walker.NodeText(const Node: IXMLNode): string;
var
  I: Integer;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;
  try
    if Node.IsTextElement then
      SB.Append(Node.Text)
    else
      for I := 0 to Node.ChildNodes.Count - 1 do
      begin
        if Node.ChildNodes[I].NodeType = ntText then
          SB.Append(Node.ChildNodes[I].Text)
        else
          SB.Append(NodeText(Node.ChildNodes[I]));
        SB.Append(' ');
      end;
    Result := SB.ToString.Trim;
  finally
    SB.Free;
  end;
end;

procedure TFb2Walker.WalkNode(const Node: IXMLNode; Level: Integer);
var
  I, SectionIndex, StartOffset: Integer;
  Name, Title: string;
begin
  if Node.NodeType = ntText then
  begin
    FText.Append(Node.Text);
    Exit;
  end;

  Name := LowerCase(Node.LocalName);

  // <description> holds metadata, not body text.
  if Name = 'description' then
    Exit;

  if Name = 'section' then
  begin
    StartOffset := FText.Length;
    SectionIndex := System.Length(FSections);
    SetLength(FSections, SectionIndex + 1);
    FSections[SectionIndex].Level := Level;
    FSections[SectionIndex].Offset := StartOffset;
    FSections[SectionIndex].Title := '';

    for I := 0 to Node.ChildNodes.Count - 1 do
    begin
      if LowerCase(Node.ChildNodes[I].LocalName) = 'title' then
      begin
        Title := NodeText(Node.ChildNodes[I]);
        if FSections[SectionIndex].Title = '' then
          FSections[SectionIndex].Title := Title;
        FText.Append(Title);
        FText.AppendLine;
        FText.AppendLine;
        Continue;
      end;
      WalkNode(Node.ChildNodes[I], Level + 1);
    end;

    // Recorded AFTER the whole child loop (title included) has appended to
    // FText -- computing Length before the title text goes in would shrink
    // every section's span by its own title, and a get_book_text caller
    // slicing [Offset, Offset+Length) would silently lose the heading.
    FSections[SectionIndex].Length := FText.Length - StartOffset;
    Exit;
  end;

  if (Name = 'p') or (Name = 'v') or (Name = 'subtitle') then
  begin
    FText.Append(NodeText(Node));
    FText.AppendLine;
    if Name = 'subtitle' then
      FText.AppendLine;
    Exit;
  end;

  if Node.HasChildNodes then
    for I := 0 to Node.ChildNodes.Count - 1 do
      WalkNode(Node.ChildNodes[I], Level);
end;

procedure TFb2Walker.Walk(const Root: IXMLNode);
var
  I: Integer;
begin
  for I := 0 to Root.ChildNodes.Count - 1 do
    if LowerCase(Root.ChildNodes[I].LocalName) = 'body' then
      WalkNode(Root.ChildNodes[I], 0);
end;

// Last resort for malformed FB2: strip tags, keep text, claim no structure.
// Does its own encoding detection from the raw bytes -- this path never sees
// a pre-decoded string, so it has to honour the prolog's encoding="..."
// itself, the same way the DOM parser does when it is fed bytes.
function StripTags(Stream: TStream): string;
var
  Bytes: TBytes;
  Raw, Chunk: string;
  Encoding: TEncoding;
  Preamble, I, Depth: Integer;
  SB: TStringBuilder;
  InDescription: Boolean;
begin
  Stream.Position := 0;
  SetLength(Bytes, Stream.Size);
  if System.Length(Bytes) > 0 then
    Stream.ReadBuffer(Bytes[0], System.Length(Bytes));

  Encoding := nil;
  Preamble := TEncoding.GetBufferEncoding(Bytes, Encoding, TEncoding.UTF8);
  Raw := Encoding.GetString(Bytes, Preamble, System.Length(Bytes) - Preamble);

  // Honour an explicit prolog encoding when it is not UTF-8. GetEncoding(1251)
  // returns a fresh TMBCSEncoding instance owned by the caller (unlike the
  // TEncoding.UTF8/ASCII/... singletons), so it must be freed here -- there is
  // no TEncoding.FreeEncoding class method in this RTL, only the unrelated
  // FreeEncodings (plural), which tears down the shared singleton cache.
  if Raw.ToLower.Contains('encoding="windows-1251"') then
  begin
    Encoding := TEncoding.GetEncoding(1251);
    try
      Raw := Encoding.GetString(Bytes);
    finally
      Encoding.Free;
    end;
  end;

  SB := TStringBuilder.Create;
  try
    Depth := 0;
    InDescription := False;
    I := 1;
    while I <= System.Length(Raw) do
    begin
      if Raw[I] = '<' then
      begin
        Chunk := Copy(Raw, I, 14).ToLower;
        if Chunk.StartsWith('<description') then
          InDescription := True
        else if Chunk.StartsWith('</description') then
          InDescription := False;
        Inc(Depth);
      end
      else if Raw[I] = '>' then
      begin
        if Depth > 0 then
          Dec(Depth);
      end
      else if (Depth = 0) and (not InDescription) then
        SB.Append(Raw[I]);
      Inc(I);
    end;
    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

function ExtractFb2(Stream: TStream): TFb2Extraction;
var
  Doc: IXMLDocument;
  Walker: TFb2Walker;
begin
  Result.Structured := False;
  SetLength(Result.Sections, 0);

  try
    Doc := TXMLDocument.Create(nil);
    Doc.ParseOptions := [poPreserveWhiteSpace];
    Stream.Position := 0;
    Doc.LoadFromStream(Stream);
    Doc.Active := True;

    Walker := TFb2Walker.Create;
    try
      Walker.Walk(Doc.DocumentElement);
      Result.Text := Walker.Text.ToString;
      Result.Sections := Walker.Sections;
      Result.Structured := True;
    finally
      Walker.Free;
    end;
  except
    on E: Exception do
    begin
      // Malformed FB2 is common. Serve text, admit there is no structure.
      try
        Result.Text := StripTags(Stream);
        Result.Structured := False;
        SetLength(Result.Sections, 0);
      except
        on Inner: Exception do
          raise EFb2ExtractError.CreateFmt(
            'FB2 extraction failed: %s / %s', [E.Message, Inner.Message]);
      end;
    end;
  end;

  if Result.Text.Trim = '' then
    raise EFb2ExtractError.Create('FB2 extraction produced no text');
end;

end.
