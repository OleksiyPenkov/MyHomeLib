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

// Caps the cache directory at CapBytes (defaulting to CACHE_CAP_BYTES),
// deleting whole .txt/.json pairs oldest-last-accessed-first until the
// directory is back under the cap. Also prunes any half-written pair (a
// .txt or .json with no matching sibling) unconditionally -- such a file can
// never serve as a cache hit (see EnsureCached below), so it is pure dead
// weight, and it is safe to remove any time EvictCache runs: the only
// caller is the server's own startup, once, before any request is served,
// so there is no other writer that could be racing an in-progress pair.
//
// CapBytes is a parameter (not baked in as CACHE_CAP_BYTES everywhere)
// solely so --cache-selftest can drive the real size-threshold and
// sort-and-delete logic with a throwaway few-KB cap instead of needing to
// write ~200 MB of fixture data; every production call site still calls
// EvictCache with no argument and gets exactly CACHE_CAP_BYTES.
//
// Deliberately NOT called from EnsureCached/ReadCachedSlice -- eviction is a
// filesystem-only, database-free sweep meant to run exactly once per process
// lifetime (see the server's startup sequence in MHLMcpServer.dpr), not on
// every request.
procedure EvictCache(const CapBytes: Int64 = CACHE_CAP_BYTES);

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

const
  // yyyy(4) mm(2) dd(2) hh(2) nn(2) ss(2) zzz(3) = 17 digits. Milliseconds
  // are load-bearing, not decoration: without them, a book cached at
  // 12:00:00.100 and re-extracted at 12:00:00.900 (same collection/book/
  // size, sub-second mtime difference) shares the same whole-second key and
  // silently serves the stale text -- measured, not hypothetical.
  CACHE_TIMESTAMP_DIGITS = 17;
  CACHE_TIMESTAMP_FORMAT = 'yyyymmddhhnnsszzz';

function CacheKey(const CollectionID, BookID: Integer;
  const SourceSize: Int64; const SourceStamp: TDateTime): string;
begin
  // Digits and underscores only -- filesystem-safe on every platform this
  // project targets, with no need to sanitise. SourceSize/SourceStamp make a
  // re-imported or hand-edited book (different file size, different mtime)
  // miss the cache instead of serving stale text.
  Result := Format('%d_%d_%d_%s',
    [CollectionID, BookID, SourceSize, FormatDateTime(CACHE_TIMESTAMP_FORMAT, SourceStamp)]);
end;

// True when BaseName (a file's name with its .txt/.json extension already
// stripped) has the exact shape CacheKey produces: three all-digit groups
// (CollectionID/BookID/SourceSize -- in practice never negative, since Task
// 10 resolves the collection via CollectionOrFail before ever calling into
// this unit, so a real key is never signed) then an underscore and exactly
// CACHE_TIMESTAMP_DIGITS more digits. EvictCache calls this before it will
// so much as look at a file's siblings, let alone delete it -- a directory
// this unit did not create (a user's own notes, an unrelated .json) must
// never be touched, regardless of what its extension or orphan-shaped
// pairing might otherwise suggest.
function IsValidCacheKeyName(const BaseName: string): Boolean;
var
  Parts: TArray<string>;

  function IsAllDigits(const S: string): Boolean;
  var
    K: Integer;
  begin
    Result := S <> '';
    if not Result then
      Exit;
    for K := 1 to Length(S) do
      if not CharInSet(S[K], ['0'..'9']) then
        Exit(False);
  end;

begin
  Parts := BaseName.Split(['_']);
  Result := (Length(Parts) = 4) and
    IsAllDigits(Parts[0]) and IsAllDigits(Parts[1]) and IsAllDigits(Parts[2]) and
    IsAllDigits(Parts[3]) and (Length(Parts[3]) = CACHE_TIMESTAMP_DIGITS);
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
  // Root is created FIRST and its try/finally spans everything else,
  // including Arr's own construction: Arr.AddElement(Entry) is added to Root
  // ('sections') the INSTANT its own try/except block finishes, with no
  // other statement in between. That closes the leak window a previous
  // version of this function had -- Arr built successfully but not yet a
  // child of anything, with nothing left between it and the next
  // fallible call to free it if that call raised. Every other exit path is
  // still covered: if Arr's own build fails, its own except frees Arr and
  // re-raises before Root ever sees it, and Root.Free (below) does not
  // touch it since it was never added; if anything fails afterwards, Arr is
  // already Root's child and Root.Free frees both together, once.
  Root := TJSONObject.Create;
  try
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
    Root.AddPair('sections', Arr);

    Root.AddPair('total_length', TJSONNumber.Create(Length(Extraction.Text)));
    Root.AddPair('structured', TJSONBool.Create(Extraction.Structured));
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

  // Both files must exist, the sidecar must parse, AND the sidecar's claimed
  // total_length must match the .txt file's actual size for this to count as
  // a hit. That last check is what makes external corruption self-heal the
  // same way every other inconsistency here does: nothing internal to this
  // unit can desync the two (the .txt and its total_length are written from
  // the same in-memory Extraction.Text in the miss path below), so a
  // mismatch means something outside this unit truncated or rewrote the
  // .txt after the fact -- e.g. measured by truncating a cached 30-code-unit
  // .txt down to 10 and confirming the old sidecar used to keep reporting
  // total_length: 30 forever. A half-written pair (crash between the two
  // writes below) or a corrupt/incomplete sidecar both already fall through
  // the same way, via TryReadSidecar returning False.
  if TFile.Exists(TxtPath) and TFile.Exists(JsonPath) and TryReadSidecar(JsonPath, Result) and
     ((TFile.GetSize(TxtPath) div SizeOf(Char)) = Result.TotalLength) then
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

// Applies the two boundary rules from the task spec -- drop a leading low
// surrogate, drop a trailing high surrogate -- but ONLY on the side(s) the
// caller says is an actual cut. TrimLeading/TrimTrailing must be False
// whenever that end of S is the true start/end of the whole cached text, not
// a cut point Offset/Count introduced: a slice that IS the whole text (e.g.
// ReadCachedSlice(..., 0, TotalLength), exactly what search_in_book uses) may
// legitimately begin or end on a lone surrogate that was already there
// before caching -- e.g. Task 8's entity decoder emitting &#xD800; verbatim
// at the very start or end of a book -- and trimming it there would silently
// drop a real code unit from the ONLY read that is supposed to return every
// one of them, corrupting every downstream offset search_in_book computes.
// Trimming is only correct, and only needed, where Offset/Count actually cut
// the text at that unit -- which is exactly what TrimLeading/TrimTrailing
// mean (see ReadCachedSlice's ClampedOffset > 0 / < MaxUnits checks below).
//
// This is a purely positional, one-shot trim -- not a full surrogate
// validator -- by design: the source text can contain a LONE surrogate that
// was never part of a pair, and this function must not crash or "improve"
// that pre-existing state, only guarantee that a genuine cut never produces
// a newly-broken pair at the boundary it controls. A lone surrogate sitting
// in the interior of the slice (not the first or last code unit) is left
// completely alone, including when a lone high surrogate happens to land on
// the last unit of a genuine cut -- dropping it there is always safe (it
// removes at most one already-invalid unit; it can never turn a valid
// character into a broken one).
function TrimSurrogateBoundaries(const S: string;
  TrimLeading, TrimTrailing: Boolean): string;
var
  Lo, Hi: Integer;
begin
  Lo := 1;
  Hi := Length(S);

  if TrimLeading and (Hi >= Lo) and IsLowSurrogate(S[Lo]) then
    Inc(Lo);

  if TrimTrailing and (Hi >= Lo) and IsHighSurrogate(S[Hi]) then
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
  // TrimLeading/TrimTrailing are True only where this slice actually CUT the
  // text -- i.e. the clamped bounds differ from the text's true [0,
  // MaxUnits) extent. A full read (ClampedOffset = 0 and ClampedOffset +
  // ClampedCount = MaxUnits, exactly what search_in_book's
  // ReadCachedSlice(..., 0, TotalLength) produces) gets both flags False, so
  // a lone surrogate that was already sitting at the very start or end of
  // the cached text is never dropped.
  Result := TrimSurrogateBoundaries(Raw,
    ClampedOffset > 0, ClampedOffset + ClampedCount < MaxUnits);
end;

type
  TCachePairInfo = record
    Key: string;
    TxtBytes: Int64;
    JsonBytes: Int64;
    LastAccess: TDateTime;
  end;

// Diagnostic-only: EvictCache runs at server startup, long before
// TMcpTransport exists, and must never touch stdout (see the "only the
// transport writes to stdout" rule in MHLMcpServer.dpr) -- so failures here
// go to stderr directly, the same discipline unit_MCP_Tools_Library's own
// LogToStderr follows, kept as a private copy rather than an import so this
// unit stays free of that unit's DAO/database dependencies.
procedure LogToStderr(const Msg: string);
begin
  Writeln(ErrOutput, Msg);
end;

// Best-effort delete: eviction is advisory housekeeping, not a correctness
// requirement, so a single file that cannot be removed (locked open by
// another server instance sharing this cache -- ReadCachedSlice itself opens
// with fmShareDenyWrite, so two instances mid-read on the same book is a
// real, reachable case, not exotic -- or made read-only, or caught by an AV
// scanner) must be skipped and logged, never allowed to raise past this
// point. A previous version let TFile.Delete raise straight out of
// EvictCache, which (called unguarded at server startup) turned "another
// process has this file open" or "read-only attribute" into the server
// failing to start at all -- the read-only case permanently, since nothing
// ever cleared the attribute.
function SafeDeleteFile(const Path: string): Boolean;
begin
  Result := False;
  try
    TFile.Delete(Path);
    Result := True;
  except
    on E: Exception do
      LogToStderr(Format('EvictCache: could not delete %s: %s', [Path, E.Message]));
  end;
end;

procedure EvictCache(const CapBytes: Int64);
var
  Dir, TxtPath, JsonPath, BaseName: string;
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

  // Pass 1: every .txt whose name matches this unit's own key pattern either
  // forms a valid pair (matching .json present) or is an orphan half of one
  // -- delete orphans outright, they can never be a cache hit. A file whose
  // name does NOT match (a user's own notes, anything this unit did not
  // create) is skipped entirely: not deleted, not counted toward TotalSize,
  // regardless of its extension or whether it happens to have a same-named
  // sibling of the other extension. Measured without this check: a 6 KB
  // cache directory containing an unrelated "my important notes.txt" (no
  // matching .json) and "settings.json" (no matching .txt) had both deleted
  // by the old orphan sweep, entirely unconditionally.
  for TxtPath in TDirectory.GetFiles(Dir, '*.txt') do
  begin
    BaseName := TPath.GetFileNameWithoutExtension(TxtPath);
    if not IsValidCacheKeyName(BaseName) then
      Continue;

    JsonPath := ChangeFileExt(TxtPath, '.json');
    if not TFile.Exists(JsonPath) then
      SafeDeleteFile(TxtPath)
    else
    begin
      Info.Key := BaseName;
      Info.TxtBytes := TFile.GetSize(TxtPath);
      Info.JsonBytes := TFile.GetSize(JsonPath);
      Info.LastAccess := TFile.GetLastAccessTime(TxtPath);

      SetLength(Pairs, PairCount + 1);
      Pairs[PairCount] := Info;
      Inc(PairCount);
      Inc(TotalSize, Info.TxtBytes + Info.JsonBytes);
    end;
  end;

  // Pass 2: a .json with no matching .txt is the other half of an orphan --
  // same name-pattern guard as pass 1.
  for JsonPath in TDirectory.GetFiles(Dir, '*.json') do
  begin
    BaseName := TPath.GetFileNameWithoutExtension(JsonPath);
    if not IsValidCacheKeyName(BaseName) then
      Continue;

    TxtPath := ChangeFileExt(JsonPath, '.txt');
    if not TFile.Exists(TxtPath) then
      SafeDeleteFile(JsonPath);
  end;

  if TotalSize <= CapBytes then
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

  // TotalSize is decremented only by bytes actually freed (not by a pair's
  // nominal size regardless of outcome), so if one file of a pair cannot be
  // deleted, the loop keeps evicting further pairs as needed to still reach
  // the cap rather than silently stopping early on inaccurate bookkeeping.
  I := 0;
  while (TotalSize > CapBytes) and (I < PairCount) do
  begin
    if SafeDeleteFile(TPath.Combine(Dir, Pairs[I].Key + '.txt')) then
      Dec(TotalSize, Pairs[I].TxtBytes);
    if SafeDeleteFile(TPath.Combine(Dir, Pairs[I].Key + '.json')) then
      Dec(TotalSize, Pairs[I].JsonBytes);
    Inc(I);
  end;
end;

end.
