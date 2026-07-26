unit unit_MCP_Fb2Extract;

interface

uses
  System.Classes,
  System.SysUtils;

type
  // Distinguishes the two cases Task 10 must map to different MCP error
  // codes: eekNoText for a book that extracted cleanly but genuinely has no
  // text (picture-only, empty body -- not corrupt, just textless), and
  // eekExtractionFailed for everything else (both the DOM walk and the
  // tag-stripping fallback raised; nothing at all could be recovered, or a
  // nil stream was handed in). Set explicitly at each raise site below
  // rather than left for a caller to infer from message text, which is
  // fragile -- message text is free to change for clarity without silently
  // breaking a substring match on the consuming side.
  TFb2ExtractErrorKind = (eekExtractionFailed, eekNoText);

  EFb2ExtractError = class(Exception)
  private
    FKind: TFb2ExtractErrorKind;
  public
    constructor Create(const AKind: TFb2ExtractErrorKind; const AMessage: string); reintroduce;
    property Kind: TFb2ExtractErrorKind read FKind;
  end;

  // A section as found by one pre-order DOM/text walk. Sections form a
  // HIERARCHY, not a flat partition of Text: FB2 sections nest (<section>
  // inside <section>), and a parent's [Offset, Offset+Length) span strictly
  // CONTAINS every one of its descendants' spans -- entries are emitted in
  // pre-order with Level recording the nesting depth (0 = top-level). A
  // caller that slices a single section's span gets exactly that section's
  // own text (heading plus body, including any nested subsections). A
  // caller that concatenates every entry's slice instead of picking one
  // double-counts: each nested section's text is covered once by itself and
  // again by every ancestor's span.
  //
  // Offset is 0-BASED and, like Length, counts UTF-16 CODE UNITS of Text --
  // i.e. plain Delphi string/char indices (minus the usual Pascal 1-based
  // string-indexing convention: Offset 0 means "before the first
  // character"). It is NOT a byte count and NOT a Unicode codepoint count. A
  // consumer seeking into a UTF-16LE-encoded copy of Text must multiply by
  // SizeOf(Char) to get a byte offset.
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
// EFb2ExtractError (Kind = eekExtractionFailed) only when no usable text
// could be produced at all because both the DOM walk and the fallback scan
// raised, or Stream itself is nil (a defensive check for a caller that fails
// to resolve a book's stream but calls in anyway -- TBookRecord.GetBookStream
// can return nil without raising at all when Settings.IgnoreAbsentArchives is
// True, which is its default). Raises EFb2ExtractError (Kind = eekNoText)
// when extraction itself succeeded but the book genuinely has no text, e.g.
// a picture-only file.
function ExtractFb2(Stream: TStream): TFb2Extraction;

implementation

uses
  System.Variants,
  Xml.XMLIntf,
  Xml.XMLDoc,
  Xml.xmldom;

const
  // System.SysUtils declares CP_UTF7/CP_UTF8 but not KOI8-R's Windows code
  // page number.
  CP_KOI8R = 20866;

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

// ---------------------------------------------------------------------
// Fallback tag stripper for malformed FB2.
// ---------------------------------------------------------------------

// Scans the raw leading bytes for `encoding="..."` / `encoding='...'` in the
// XML prolog, entirely at the BYTE level -- no decode of the document is
// attempted before or during this scan. That is deliberate and safe for
// every real-world encoding this project sees (UTF-8, windows-1251, koi8-r,
// ...): the prolog, and the encoding name in particular, is always plain
// ASCII per the XML spec, even when the rest of the document is single-byte
// Cyrillic. A byte-for-byte Chr() mapping of just those bytes can never
// raise, regardless of what codec the rest of the file turns out to need.
function SniffDeclaredEncoding(const Bytes: TBytes): string;
const
  Needle: array[0..7] of Byte = (
    Ord('e'), Ord('n'), Ord('c'), Ord('o'), Ord('d'), Ord('i'), Ord('n'), Ord('g'));

  function LowerAsciiByte(B: Byte): Byte; inline;
  begin
    if (B >= Ord('A')) and (B <= Ord('Z')) then
      Result := B + 32
    else
      Result := B;
  end;

  function MatchesNeedle(Pos, N: Integer): Boolean;
  var
    K: Integer;
  begin
    Result := Pos + System.Length(Needle) <= N;
    if not Result then
      Exit;
    for K := 0 to High(Needle) do
      if LowerAsciiByte(Bytes[Pos + K]) <> Needle[K] then
        Exit(False);
  end;

var
  N, I, J, K: Integer;
  Quote: Byte;
  NameBytes: TBytes;
begin
  Result := '';
  N := System.Length(Bytes);
  if N > 512 then
    N := 512; // the prolog is always within the first handful of bytes

  I := 0;
  while I < N do
  begin
    if MatchesNeedle(I, N) then
    begin
      J := I + System.Length(Needle);
      while (J < N) and (Bytes[J] in [Ord(' '), 9, 10, 13]) do
        Inc(J);
      if (J < N) and (Bytes[J] = Ord('=')) then
      begin
        Inc(J);
        while (J < N) and (Bytes[J] in [Ord(' '), 9, 10, 13]) do
          Inc(J);
        if (J < N) and ((Bytes[J] = Ord('"')) or (Bytes[J] = Ord(''''))) then
        begin
          Quote := Bytes[J];
          Inc(J);
          SetLength(NameBytes, 0);
          while (J < N) and (Bytes[J] <> Quote) do
          begin
            SetLength(NameBytes, System.Length(NameBytes) + 1);
            NameBytes[High(NameBytes)] := Bytes[J];
            Inc(J);
          end;
          SetLength(Result, System.Length(NameBytes));
          for K := 0 to High(NameBytes) do
            Result[K + 1] := Chr(NameBytes[K]);
          Result := Result.ToLower;
          Exit;
        end;
      end;
    end;
    Inc(I);
  end;
end;

// Maps a sniffed prolog encoding name to a Windows code page. Returns 0 for
// anything not recognised (including an absent declaration) -- the caller
// then falls back to a UTF-8 validity probe and, failing that, a windows-1251
// guess.
function CodePageForDeclaredEncoding(const Name: string): Integer;
begin
  if (Name = 'windows-1251') or (Name = 'cp1251') or (Name = 'x-cp1251') then
    Result := 1251
  else if (Name = 'koi8-r') or (Name = 'koi8r') then
    Result := CP_KOI8R
  else if (Name = 'utf-8') or (Name = 'utf8') then
    Result := CP_UTF8
  else
    Result := 0;
end;

// Resolves the real encoding of a raw FB2 byte stream and decodes it. Tried,
// in order:
//  1. A byte-order mark, which conclusively identifies UTF-8 / UTF-16LE /
//     UTF-16BE and is trusted over any prolog attribute (a BOM cannot lie
//     the way a stale or simply wrong encoding="..." can).
//  2. The declared encoding="..."/encoding='...' name from the prolog,
//     sniffed at the byte level by SniffDeclaredEncoding, so this step
//     itself cannot raise. windows-1251/cp1251 and koi8-r are decoded via
//     TEncoding.GetEncoding, which -- unlike TEncoding.UTF8 -- is created
//     with no MB_ERR_INVALID_CHARS flag (see TMBCSEncoding.Create(CodePage)
//     in System.SysUtils), so it never raises on an unmapped byte either.
//  3. When the declared name is absent, unrecognised, or names UTF-8 but the
//     bytes do not actually parse as UTF-8 (a real case: cp1251 bytes
//     mis-labelled utf-8), a non-raising UTF-8 validity probe
//     (TEncoding.UTF8.IsBufferValid) decides whether to trust UTF-8 anyway.
//  4. As an explicit last resort, windows-1251.
//
// Step 4 is a deliberate choice, not an oversight: for the Librusec/Flibusta
// corpus this project actually has to deal with, a file that is neither
// valid UTF-8 nor labelled with a recognised encoding is, empirically,
// windows-1251 far more often than anything else. Decoding with the wrong
// single-byte code page produces mojibake, which a human reader can still
// work around (and which a corrected re-extraction fixes outright) --
// raising here would instead turn a merely mislabelled file into an
// unrecoverable failure, for the one code path whose entire job is "text
// always works".
function DecodeFb2Bytes(const Bytes: TBytes): string;
var
  BomEncoding, GuessEncoding: TEncoding;
  Preamble, CodePage: Integer;
  Declared: string;
  OwnsGuess: Boolean;
begin
  BomEncoding := nil;
  Preamble := TEncoding.GetBufferEncoding(Bytes, BomEncoding, nil);
  if Assigned(BomEncoding) then
  begin
    try
      Exit(BomEncoding.GetString(Bytes, Preamble, System.Length(Bytes) - Preamble));
    except
      on E: EEncodingError do
        ; // Fall through to the declared/guessed path below rather than raise.
    end;
  end;

  Declared := SniffDeclaredEncoding(Bytes);
  CodePage := CodePageForDeclaredEncoding(Declared);

  GuessEncoding := nil;
  OwnsGuess := False;
  try
    if (CodePage = CP_UTF8) and TEncoding.UTF8.IsBufferValid(Bytes) then
      GuessEncoding := TEncoding.UTF8
    else if (CodePage <> 0) and (CodePage <> CP_UTF8) then
    begin
      GuessEncoding := TEncoding.GetEncoding(CodePage);
      OwnsGuess := True;
    end
    else if TEncoding.UTF8.IsBufferValid(Bytes) then
      GuessEncoding := TEncoding.UTF8
    else
    begin
      GuessEncoding := TEncoding.GetEncoding(1251);
      OwnsGuess := True;
    end;

    Result := GuessEncoding.GetString(Bytes);
  finally
    // GuessEncoding.Free only, not also a defensive := nil -- the variable
    // goes out of scope at the very next statement (this function's own
    // return), so re-assigning it here is dead by construction, not merely
    // in this run.
    if OwnsGuess then
      GuessEncoding.Free;
  end;
end;

// Decodes the handful of XML entities that survive into fallback-scanned
// text: the five predefined entities plus numeric character references. A
// bare '&' is itself a common reason the real DOM parse failed in the first
// place, so this path is exercised often, not hypothetically. Malformed or
// unrecognised entities are left verbatim rather than dropped -- this is a
// best-effort decode, not a validator.
function DecodeEntities(const S: string): string;
var
  SB: TStringBuilder;
  I, J, SemiPos, Code: Integer;
  Entity: string;
  Handled: Boolean;
begin
  SB := TStringBuilder.Create;
  try
    I := 1;
    while I <= System.Length(S) do
    begin
      if S[I] = '&' then
      begin
        SemiPos := 0;
        J := I + 1;
        // Real entities are short; capping the lookahead keeps a bare '&'
        // in ordinary text (not a real entity) from scanning arbitrarily far
        // ahead for a ';' that may never come.
        while (J <= System.Length(S)) and (J <= I + 12) do
        begin
          if S[J] = ';' then
          begin
            SemiPos := J;
            Break;
          end;
          Inc(J);
        end;

        if SemiPos > 0 then
        begin
          Entity := Copy(S, I + 1, SemiPos - I - 1);
          Handled := True;
          if Entity = 'amp' then
            SB.Append('&')
          else if Entity = 'lt' then
            SB.Append('<')
          else if Entity = 'gt' then
            SB.Append('>')
          else if Entity = 'quot' then
            SB.Append('"')
          else if Entity = 'apos' then
            SB.Append('''')
          else if (System.Length(Entity) > 1) and (Entity[1] = '#') then
          begin
            try
              if (System.Length(Entity) > 2) and CharInSet(Entity[2], ['x', 'X']) then
                Code := StrToInt('$' + Copy(Entity, 3, MaxInt))
              else
                Code := StrToInt(Copy(Entity, 2, MaxInt));
            except
              Code := -1;
            end;
            if (Code >= 0) and (Code <= $FFFF) then
              SB.Append(Char(Code))
            else
              Handled := False;
          end
          else
            Handled := False;

          if Handled then
          begin
            I := SemiPos + 1;
            Continue;
          end;
        end;
      end;

      SB.Append(S[I]);
      Inc(I);
    end;
    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

// True when Chunk (already lower-cased) has NameLen characters that are
// followed by a real tag boundary ('>', whitespace, or '/' for a self-closed
// tag) rather than continuing into a longer, unrelated tag name -- e.g. this
// is what stops a check for "binary" from also matching a hypothetical
// "binary-note" tag.
function TagBoundaryOk(const Chunk: string; NameLen: Integer): Boolean;
begin
  Result := (System.Length(Chunk) <= NameLen) or
    CharInSet(Chunk[NameLen + 1], ['>', ' ', #9, #10, #13, '/']);
end;

function StartsWithOpenTag(const Chunk, Name: string): Boolean;
var
  Prefix: string;
begin
  Prefix := '<' + Name;
  Result := Chunk.StartsWith(Prefix) and TagBoundaryOk(Chunk, System.Length(Prefix));
end;

function StartsWithCloseTag(const Chunk, Name: string): Boolean;
var
  Prefix: string;
begin
  Prefix := '</' + Name;
  Result := Chunk.StartsWith(Prefix) and TagBoundaryOk(Chunk, System.Length(Prefix));
end;

// Last resort for malformed FB2: strip tags, keep text, claim no structure.
// Decodes the raw bytes itself via DecodeFb2Bytes -- this path never sees a
// pre-decoded string, so it has to honour the prolog's encoding (or make a
// safe guess) exactly the way the DOM parser does when fed bytes directly.
//
// Tag tracking is a single Depth flag that is unconditionally SET (not
// incremented/decremented) to 1 on '<' and to 0 on '>': it tracks only
// "currently inside the nearest unmatched '<...>' span", not a nesting
// count. This is deliberately self-resynchronising. The previous
// Inc(Depth)/Dec(Depth) version could never recover from a single unescaped
// '<' in text content (illegal XML, but common in real files): Depth would
// sit at >=1 for the rest of the document and every remaining character,
// including entire later chapters, would be silently dropped. Measured
// before this fix, on a file whose only defect was a stray '<' in one
// paragraph: the extracted text was truncated at that paragraph and every
// later paragraph vanished with no signal beyond the unrelated
// Structured=False. With the set-not-count fix, only the characters between
// the stray '<' and the very next '>' in the byte stream are lost (the
// scanner cannot tell a real tag from a stray one), and every tag boundary
// after that point resynchronises correctly -- later paragraphs, including
// the very next one, are recovered. The same fix also stops a literal '>'
// legally occurring inside an XML attribute value (e.g.
// href="http://x/?a=1>2") from leaving Depth permanently unbalanced; some
// leakage of the attribute's own tail into the output can still occur for
// that specific case (this scanner does not parse quotes), but it no longer
// desynchronises tracking for the rest of the document the way unbounded
// Inc/Dec bookkeeping did.
function StripTags(Stream: TStream): string;
var
  Bytes: TBytes;
  Raw, Chunk: string;
  I, Depth: Integer;
  SB: TStringBuilder;
  Suppress: Boolean; // inside <description>/<binary>/<stylesheet>
begin
  Stream.Position := 0;
  SetLength(Bytes, Stream.Size);
  if System.Length(Bytes) > 0 then
    Stream.ReadBuffer(Bytes[0], System.Length(Bytes));

  Raw := DecodeFb2Bytes(Bytes);

  SB := TStringBuilder.Create;
  try
    Depth := 0;
    Suppress := False;
    I := 1;
    while I <= System.Length(Raw) do
    begin
      if Raw[I] = '<' then
      begin
        Chunk := Copy(Raw, I, 16).ToLower;
        // <description> is metadata (title/author/etc, not book text).
        // <binary> is a base64-encoded embedded file (almost always the
        // cover image) -- without this, its base64 payload, which can run
        // to hundreds of KB, comes out as "text" in the middle of the book.
        // <stylesheet> is CSS, not book text either. The DOM path already
        // excludes all of these structurally (TFb2Walker.Walk only descends
        // into <body>); this scanner has no such structure to rely on, so it
        // has to suppress them explicitly.
        if StartsWithOpenTag(Chunk, 'description') or
           StartsWithOpenTag(Chunk, 'binary') or
           StartsWithOpenTag(Chunk, 'stylesheet') then
          Suppress := True
        else if StartsWithCloseTag(Chunk, 'description') or
                StartsWithCloseTag(Chunk, 'binary') or
                StartsWithCloseTag(Chunk, 'stylesheet') then
          Suppress := False;
        Depth := 1;
      end
      else if Raw[I] = '>' then
        Depth := 0
      else if (Depth = 0) and (not Suppress) then
        SB.Append(Raw[I]);
      Inc(I);
    end;
    Result := DecodeEntities(SB.ToString);
  finally
    SB.Free;
  end;
end;

constructor EFb2ExtractError.Create(const AKind: TFb2ExtractErrorKind; const AMessage: string);
begin
  inherited Create(AMessage);
  FKind := AKind;
end;

function ExtractFb2(Stream: TStream): TFb2Extraction;
var
  Doc: IXMLDocument;
  Walker: TFb2Walker;
begin
  Result.Structured := False;
  SetLength(Result.Sections, 0);

  // Defensive: a nil Stream must never reach Stream.Position below (an
  // access violation, not a catchable EFb2ExtractError). The one real
  // caller this guards today is Task 10's LoadBookForText, which now checks
  // for nil itself right after GetBookStream and never calls in with nil --
  // but that check living correctly at one call site today is no guarantee
  // it will at every call site tomorrow, and an AV here would otherwise
  // reach an MCP client as a raw, unmapped JSON-RPC -32603.
  if not Assigned(Stream) then
    raise EFb2ExtractError.Create(eekExtractionFailed,
      'FB2 extraction failed: no stream provided (nil)');

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
          raise EFb2ExtractError.Create(eekExtractionFailed,
            Format('FB2 extraction failed: %s / %s', [E.Message, Inner.Message]));
      end;
    end;
  end;

  // Distinguish a genuinely empty book (DOM or fallback ran fine, there is
  // just no text -- e.g. a picture-only file) from an actual extraction
  // failure via Kind, not message text -- so Task 10 can switch on it
  // directly instead of matching a substring that is free to change.
  if Result.Text.Trim = '' then
  begin
    if Result.Structured then
      raise EFb2ExtractError.Create(eekNoText,
        'FB2 book has no extractable text (likely picture-only or an empty body)')
    else
      raise EFb2ExtractError.Create(eekExtractionFailed,
        'FB2 extraction failed: no text could be recovered from this file');
  end;
end;

end.
