unit unit_MCP_TextCache;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.IOUtils,
  System.Generics.Collections,
  unit_MCP_Fb2Extract;

type
  TCachedBook = record
    TotalLength: Integer;
    Sections: TFb2Sections;
    Structured: Boolean;
  end;

const
  CACHE_CAP_BYTES = 200 * 1024 * 1024;

// %LOCALAPPDATA%\MyHomeLib\McpCache, created on demand. See
// SetCacheDirOverrideForTests below for how --cache-selftest redirects this
// away from the real machine-wide cache.
function CacheDir: string;

// Caps the cache directory at CACHE_CAP_BYTES, deleting whole .txt/.json
// pairs oldest-last-accessed-first. Also prunes any half-written pair (a
// .txt or .json with no matching sibling) unconditionally -- such a file can
// never serve as a cache hit (see EnsureCached below), so it is pure dead
// weight, and it is safe to remove any time EvictCache runs: the only
// caller is the server's own startup, once, before any request is served,
// so there is no other writer that could be racing an in-progress pair.
//
// Deliberately NOT called from EnsureCached/ReadCachedSlice -- eviction is a
// filesystem-only, database-free sweep meant to run exactly once per process
// lifetime (see the server's startup sequence in MHLMcpServer.dpr), not on
// every request.
procedure EvictCache;

// Returns the cached extraction for (CollectionID, BookID, SourceSize,
// SourceStamp), reading it from disk if both the .txt and .json sidecar
// already exist and parse cleanly, or else calling ExtractProc once, writing
// both files, and returning the fresh result. ExtractProc is expected to
// call into the DAO/FB2 layer; this unit never does so itself and never
// touches the database.
function EnsureCached(const CollectionID, BookID: Integer;
  const SourceSize: Int64; const SourceStamp: TDateTime;
  ExtractProc: TFunc<TFb2Extraction>): TCachedBook;

// Reads [Offset, Offset + Count) UTF-16 code units from the cached .txt file
// for the given key, clamping both to the file's actual length rather than
// raising when Count runs past the end. The result is then trimmed so it
// never starts on a low surrogate or ends on a high surrogate (see
// TrimSurrogateBoundaries), regardless of whether that unit is genuinely
// paired or a pre-existing lone surrogate in the source text.
//
// Assumes EnsureCached has already been called with the same key (Task 10's
// contract) so the .txt file exists; if it does not, this raises the same
// way TFileStream.Create always does for a missing file.
function ReadCachedSlice(const CollectionID, BookID: Integer;
  const SourceSize: Int64; const SourceStamp: TDateTime;
  Offset, Count: Integer): string;

// Test-only seam for the --cache-selftest CLI mode (see MHLMcpServer.dpr):
// redirects CacheDir to a throwaway directory instead of the real
// %LOCALAPPDATA%\MyHomeLib\McpCache, so the self-test can exercise
// EnsureCached/ReadCachedSlice/EvictCache end to end without ever touching
// or evicting the real cache. Never called from production code paths.
procedure SetCacheDirOverrideForTests(const Dir: string);

implementation

var
  GCacheDirOverride: string = '';

procedure SetCacheDirOverrideForTests(const Dir: string);
begin
  GCacheDirOverride := Dir;
end;

function CacheDir: string;
var
  LocalAppData: string;
begin
  if GCacheDirOverride <> '' then
    Result := GCacheDirOverride
  else
  begin
    // %LOCALAPPDATA%, not TPath.GetHomePath (which resolves to the ROAMING
    // profile, CSIDL_APPDATA) -- the task spec is explicit that this cache
    // belongs under %LOCALAPPDATA%. GetEnvironmentVariable is always set on
    // a normal interactive Windows session; the fallback only guards against
    // the exotic case of a stripped-down service environment.
    LocalAppData := GetEnvironmentVariable('LOCALAPPDATA');
    if LocalAppData = '' then
      LocalAppData := TPath.GetHomePath;
    Result := TPath.Combine(LocalAppData, 'MyHomeLib\McpCache');
  end;

  if not TDirectory.Exists(Result) then
    TDirectory.CreateDirectory(Result);
end;

function CacheKey(const CollectionID, BookID: Integer;
  const SourceSize: Int64; const SourceStamp: TDateTime): string;
begin
  // Digits and underscores only -- filesystem-safe on every platform this
  // project targets, with no need to sanitise. SourceSize/SourceStamp make a
  // re-imported or hand-edited book (different file size, different mtime)
  // miss the cache instead of serving stale text.
  Result := Format('%d_%d_%d_%s',
    [CollectionID, BookID, SourceSize, FormatDateTime('yyyymmddhhnnss', SourceStamp)]);
end;

function TextPathFor(const Key: string): string;
begin
  Result := TPath.Combine(CacheDir, Key + '.txt');
end;

function JsonPathFor(const Key: string): string;
begin
  Result := TPath.Combine(CacheDir, Key + '.json');
end;

// Keeps a pair's .txt/.json last-access times in lockstep on every hit,
// regardless of whether the OS is even tracking file-access times at all:
// Windows has disabled automatic last-access-time updates by default since
// Vista (NtfsDisableLastAccessUpdate), which would otherwise make
// EvictCache's oldest-last-accessed-first policy meaningless (every entry
// would carry its creation time forever). An explicit SetLastAccessTime
// call is not subject to that setting -- it always takes effect.
procedure TouchPair(const TxtPath, JsonPath: string);
var
  Stamp: TDateTime;
begin
  Stamp := Now;
  TFile.SetLastAccessTime(TxtPath, Stamp);
  TFile.SetLastAccessTime(JsonPath, Stamp);
end;

procedure WriteSidecar(const JsonPath: string; const Extraction: TFb2Extraction);
var
  Root: TJSONObject;
  Arr: TJSONArray;
  Entry: TJSONObject;
  I: Integer;
begin
  Arr := TJSONArray.Create;
  try
    for I := 0 to High(Extraction.Sections) do
    begin
      Entry := TJSONObject.Create;
      try
        Entry.AddPair('title', Extraction.Sections[I].Title);
        Entry.AddPair('level', TJSONNumber.Create(Extraction.Sections[I].Level));
        Entry.AddPair('offset', TJSONNumber.Create(Extraction.Sections[I].Offset));
        Entry.AddPair('length', TJSONNumber.Create(Extraction.Sections[I].Length));
      except
        Entry.Free;
        raise;
      end;
      Arr.AddElement(Entry);
    end;
  except
    Arr.Free;
    raise;
  end;

  Root := TJSONObject.Create;
  try
    Root.AddPair('total_length', TJSONNumber.Create(Length(Extraction.Text)));
    Root.AddPair('structured', TJSONBool.Create(Extraction.Structured));
    Root.AddPair('sections', Arr);
    // The 2-argument overload (not the one taking an explicit TEncoding) is
    // deliberate: TFile.WriteAllText(Path, Contents, Encoding) writes that
    // encoding's preamble, which would prepend a UTF-8 BOM to the sidecar.
    // This form defaults to UTF-8 with no preamble.
    TFile.WriteAllText(JsonPath, Root.ToJSON);
  finally
    Root.Free;
  end;
end;

// Reads and parses the sidecar. Any failure -- missing fields, a truncated
// file left by a crash mid-write, garbage content -- is reported back as
// False rather than propagated, so the caller (EnsureCached) can treat it
// exactly like a missing sidecar: a miss to be re-extracted, never a hit on
// corrupt data.
function TryReadSidecar(const JsonPath: string; out Cached: TCachedBook): Boolean;
var
  JsonText: string;
  Value: TJSONValue;
  Root: TJSONObject;
  SectionsValue: TJSONValue;
  Arr: TJSONArray;
  Entry: TJSONObject;
  I: Integer;
begin
  Cached.TotalLength := 0;
  SetLength(Cached.Sections, 0);
  Cached.Structured := False;

  try
    JsonText := TFile.ReadAllText(JsonPath, TEncoding.UTF8);
    Value := TJSONObject.ParseJSONValue(JsonText);
    if not Assigned(Value) then
      Exit(False);
    try
      if not (Value is TJSONObject) then
        Exit(False);
      Root := TJSONObject(Value);

      Cached.TotalLength := Root.GetValue<Integer>('total_length');
      Cached.Structured := Root.GetValue<Boolean>('structured');

      SectionsValue := Root.Values['sections'];
      if not (SectionsValue is TJSONArray) then
        Exit(False);
      Arr := TJSONArray(SectionsValue);

      SetLength(Cached.Sections, Arr.Count);
      for I := 0 to Arr.Count - 1 do
      begin
        if not (Arr.Items[I] is TJSONObject) then
          Exit(False);
        Entry := TJSONObject(Arr.Items[I]);
        Cached.Sections[I].Title := Entry.GetValue<string>('title');
        Cached.Sections[I].Level := Entry.GetValue<Integer>('level');
        Cached.Sections[I].Offset := Entry.GetValue<Integer>('offset');
        Cached.Sections[I].Length := Entry.GetValue<Integer>('length');
      end;

      Result := True;
    finally
      Value.Free;
    end;
  except
    // Deliberately blanket: a half-written or corrupt sidecar must read as a
    // miss, not crash the caller.
    Result := False;
  end;
end;

function EnsureCached(const CollectionID, BookID: Integer;
  const SourceSize: Int64; const SourceStamp: TDateTime;
  ExtractProc: TFunc<TFb2Extraction>): TCachedBook;
var
  Key, TxtPath, JsonPath: string;
  Extraction: TFb2Extraction;
begin
  Key := CacheKey(CollectionID, BookID, SourceSize, SourceStamp);
  TxtPath := TextPathFor(Key);
  JsonPath := JsonPathFor(Key);

  // Both files must exist AND the sidecar must parse for this to count as a
  // hit -- a half-written pair (crash between the two writes below) or a
  // corrupt sidecar both fall through to re-extraction, which overwrites
  // both files and leaves a good pair behind.
  if TFile.Exists(TxtPath) and TFile.Exists(JsonPath) and TryReadSidecar(JsonPath, Result) then
  begin
    TouchPair(TxtPath, JsonPath);
    Exit;
  end;

  Extraction := ExtractProc();

  // .txt written first: if the process dies before the .json write below
  // completes, the next call sees a .txt with no matching .json, which the
  // check above already treats as a miss -- so the pair self-heals on the
  // very next call instead of ever being read as a false hit.
  TFile.WriteAllBytes(TxtPath, TEncoding.Unicode.GetBytes(Extraction.Text));
  WriteSidecar(JsonPath, Extraction);

  Result.TotalLength := Length(Extraction.Text);
  Result.Sections := Extraction.Sections;
  Result.Structured := Extraction.Structured;
end;

function IsLowSurrogate(C: Char): Boolean; inline;
begin
  Result := (Ord(C) >= $DC00) and (Ord(C) <= $DFFF);
end;

function IsHighSurrogate(C: Char): Boolean; inline;
begin
  Result := (Ord(C) >= $D800) and (Ord(C) <= $DBFF);
end;

// Applies exactly the two boundary rules from the task spec: drop a leading
// low surrogate and a trailing high surrogate. This is a purely positional,
// one-shot trim -- not a full surrogate validator -- by design: the source
// text can contain a LONE surrogate that was never part of a pair (Task 8's
// entity decoder emits a numeric character reference like &#xD800; or &#0;
// verbatim), and this function must not crash or "improve" that pre-existing
// state, only guarantee that slicing itself never introduces a new broken
// pair at a boundary it controls. A lone surrogate sitting in the interior
// of the slice (not the first or last code unit) is left completely alone,
// including when a lone high surrogate happens to land on the last unit --
// dropping it is always safe (it removes at most one already-invalid unit;
// it can never turn a valid character into a broken one).
function TrimSurrogateBoundaries(const S: string): string;
var
  Lo, Hi: Integer;
begin
  Lo := 1;
  Hi := Length(S);

  if (Hi >= Lo) and IsLowSurrogate(S[Lo]) then
    Inc(Lo);

  if (Hi >= Lo) and IsHighSurrogate(S[Hi]) then
    Dec(Hi);

  if Hi < Lo then
    Exit('');

  Result := Copy(S, Lo, Hi - Lo + 1);
end;

function ReadCachedSlice(const CollectionID, BookID: Integer;
  const SourceSize: Int64; const SourceStamp: TDateTime;
  Offset, Count: Integer): string;
var
  Key, TxtPath, JsonPath: string;
  Stream: TFileStream;
  MaxUnits: Int64;
  ClampedOffset, ClampedCount: Int64;
  ByteCount: Integer;
  Bytes: TBytes;
  Raw: string;
begin
  Key := CacheKey(CollectionID, BookID, SourceSize, SourceStamp);
  TxtPath := TextPathFor(Key);
  JsonPath := JsonPathFor(Key);

  Stream := TFileStream.Create(TxtPath, fmOpenRead or fmShareDenyWrite);
  try
    MaxUnits := Stream.Size div SizeOf(Char);

    ClampedOffset := Offset;
    if ClampedOffset < 0 then
      ClampedOffset := 0;
    if ClampedOffset > MaxUnits then
      ClampedOffset := MaxUnits;

    ClampedCount := Count;
    if ClampedCount < 0 then
      ClampedCount := 0;
    if ClampedOffset + ClampedCount > MaxUnits then
      ClampedCount := MaxUnits - ClampedOffset;

    Stream.Position := ClampedOffset * SizeOf(Char);
    ByteCount := ClampedCount * SizeOf(Char);
    SetLength(Bytes, ByteCount);
    if ByteCount > 0 then
      Stream.ReadBuffer(Bytes[0], ByteCount);
  finally
    Stream.Free;
  end;

  // Keep the pair's access time current even though the sidecar itself is
  // not read here -- see TouchPair's comment on why this must be explicit.
  if TFile.Exists(JsonPath) then
    TouchPair(TxtPath, JsonPath)
  else
    TFile.SetLastAccessTime(TxtPath, Now);

  Raw := TEncoding.Unicode.GetString(Bytes);
  Result := TrimSurrogateBoundaries(Raw);
end;

type
  TCachePairInfo = record
    Key: string;
    TotalBytes: Int64;
    LastAccess: TDateTime;
  end;

procedure EvictCache;
var
  Dir, TxtPath, JsonPath: string;
  Pairs: TArray<TCachePairInfo>;
  PairCount: Integer;
  Info: TCachePairInfo;
  TotalSize: Int64;
  I, J: Integer;
  Tmp: TCachePairInfo;
begin
  Dir := CacheDir;
  TotalSize := 0;
  PairCount := 0;
  SetLength(Pairs, 0);

  // Pass 1: every .txt either forms a valid pair (matching .json present) or
  // is an orphan -- delete orphans outright, they can never be a cache hit.
  for TxtPath in TDirectory.GetFiles(Dir, '*.txt') do
  begin
    JsonPath := ChangeFileExt(TxtPath, '.json');
    if not TFile.Exists(JsonPath) then
      TFile.Delete(TxtPath)
    else
    begin
      Info.Key := TPath.GetFileNameWithoutExtension(TxtPath);
      Info.TotalBytes := TFile.GetSize(TxtPath) + TFile.GetSize(JsonPath);
      Info.LastAccess := TFile.GetLastAccessTime(TxtPath);

      SetLength(Pairs, PairCount + 1);
      Pairs[PairCount] := Info;
      Inc(PairCount);
      Inc(TotalSize, Info.TotalBytes);
    end;
  end;

  // Pass 2: a .json with no matching .txt is the other half of an orphan.
  for JsonPath in TDirectory.GetFiles(Dir, '*.json') do
  begin
    TxtPath := ChangeFileExt(JsonPath, '.txt');
    if not TFile.Exists(TxtPath) then
      TFile.Delete(JsonPath);
  end;

  if TotalSize <= CACHE_CAP_BYTES then
    Exit;

  // Simple ascending insertion sort by LastAccess -- the cache directory is
  // one user's book collection worth of recently-read texts, not a
  // performance-sensitive data set, so O(n^2) here is not a concern.
  for I := 1 to PairCount - 1 do
  begin
    J := I;
    while (J > 0) and (Pairs[J - 1].LastAccess > Pairs[J].LastAccess) do
    begin
      Tmp := Pairs[J - 1];
      Pairs[J - 1] := Pairs[J];
      Pairs[J] := Tmp;
      Dec(J);
    end;
  end;

  I := 0;
  while (TotalSize > CACHE_CAP_BYTES) and (I < PairCount) do
  begin
    TFile.Delete(TPath.Combine(Dir, Pairs[I].Key + '.txt'));
    TFile.Delete(TPath.Combine(Dir, Pairs[I].Key + '.json'));
    Dec(TotalSize, Pairs[I].TotalBytes);
    Inc(I);
  end;
end;

end.
