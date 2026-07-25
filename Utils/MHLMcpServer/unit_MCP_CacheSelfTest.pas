unit unit_MCP_CacheSelfTest;

interface

// Exercises unit_MCP_TextCache end to end against a throwaway temp directory
// -- never the real %LOCALAPPDATA%\MyHomeLib\McpCache -- via
// SetCacheDirOverrideForTests. No database, no DMUser, and (like --extract)
// meant to run entirely before Application.Initialize; see the one-line
// dispatch in MHLMcpServer.dpr.
//
// Task 9's brief provides no automated coverage for the cache unit; this
// mode exists to close that gap. Each check is a self-contained assertion
// evaluated in Pascal (only Pascal has direct access to EnsureCached's
// invocation-count closures and to the cache's on-disk files), and the
// verdicts are reported as one JSON line for tests/cache_tests.js to turn
// into PASS/FAIL console lines, mirroring RunExtractMode/extract_tests.js.
//
// Lives in its own unit (moved out of MHLMcpServer.dpr in fix round 2)
// because it is, by a wide margin, the largest single block of code in the
// project's CLI dispatch story -- Task 10 adds more to the .dpr itself, and
// a ~500-line procedure sitting in the middle of the program file it does
// not otherwise touch was making that file hard to read.
procedure RunCacheSelfTestMode;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.DateUtils,
  System.JSON,
  unit_MCP_Transport,
  unit_MCP_Fb2Extract,
  unit_MCP_TextCache;

procedure RunCacheSelfTestMode;
type
  TCheckResult = record
    Name: string;
    Pass: Boolean;
    Detail: string;
  end;
var
  Checks: TArray<TCheckResult>;
  TempDir: string;
  Guid: TGUID;
  Crashed: Boolean;
  CrashDetail: string;
  Transport: TMcpTransport;
  Root: TJSONObject;
  Arr: TJSONArray;
  Entry: TJSONObject;
  I: Integer;

  Cached: TCachedBook;
  CallCount: Integer;
  Text1, Text3, Text4, Text6, S5, S5b, S7Text: string;
  Sections1: TFb2Sections;
  Stamp1, Stamp2, Stamp3, Stamp4, Stamp5, Stamp5b, Stamp6, Stamp7: TDateTime;
  OrphanTxtPath: string;

  StampMsA, StampMsB: TDateTime;
  CallCountMs: Integer;

  Stamp7b, Stamp7c, Stamp7d: TDateTime;
  CallCount7b, CallCount7c, CallCount7d: Integer;
  Txt7bPath, Json7bPath, Txt7cPath, Json7cPath, Txt7dPath: string;
  OriginalText7d: string;
  Cached7d: TCachedBook;

  K: Integer;
  Txt9, Json9: array[0..4] of string;
  AccessRank9: array[0..4] of Integer;
  PairBytes9, Total9, CapBig9, Cap3Of9: Int64;
  Stamp9: TDateTime;
  NonMatchTxt, NonMatchJson, NonMatchPairTxt, NonMatchPairJson: string;

  // Rebuilds the on-disk path for a key exactly the way
  // unit_MCP_TextCache.CacheKey does (the format is fixed by the task spec
  // plus fix round 2's millisecond widening), so this test can assert file
  // existence directly without the unit exporting its private key function.
  function TxtPathForTest(const CollectionID, BookID: Integer;
    const SourceSize: Int64; const Stamp: TDateTime): string;
  begin
    Result := TPath.Combine(TempDir, Format('%d_%d_%d_%s.txt',
      [CollectionID, BookID, SourceSize, FormatDateTime('yyyymmddhhnnsszzz', Stamp)]));
  end;

  function JsonPathForTest(const CollectionID, BookID: Integer;
    const SourceSize: Int64; const Stamp: TDateTime): string;
  begin
    Result := TPath.Combine(TempDir, Format('%d_%d_%d_%s.json',
      [CollectionID, BookID, SourceSize, FormatDateTime('yyyymmddhhnnsszzz', Stamp)]));
  end;

  procedure AddCheck(const Name: string; Pass: Boolean; const Detail: string = '');
  begin
    SetLength(Checks, Length(Checks) + 1);
    Checks[High(Checks)].Name := Name;
    Checks[High(Checks)].Pass := Pass;
    Checks[High(Checks)].Detail := Detail;
  end;

  // Wraps one boolean assertion so a bug in the code under test (e.g. an
  // out-of-range Seek) shows up as a named FAIL with the exception message,
  // instead of aborting every check that has not run yet.
  procedure CheckSafe(const Name: string; Fn: TFunc<Boolean>);
  var
    Pass: Boolean;
    Detail: string;
  begin
    Detail := '';
    try
      Pass := Fn();
    except
      on E: Exception do
      begin
        Pass := False;
        Detail := E.ClassName + ': ' + E.Message;
      end;
    end;
    AddCheck(Name, Pass, Detail);
  end;

  function SectionsEqual(const A, B: TFb2Sections): Boolean;
  var
    K2: Integer;
  begin
    Result := Length(A) = Length(B);
    if not Result then
      Exit;
    for K2 := 0 to High(A) do
      if (A[K2].Title <> B[K2].Title) or (A[K2].Level <> B[K2].Level) or
         (A[K2].Offset <> B[K2].Offset) or (A[K2].Length <> B[K2].Length) then
        Exit(False);
  end;

begin
  CreateGUID(Guid);
  TempDir := TPath.Combine(TPath.GetTempPath,
    'mhl_mcp_cache_selftest_' + GUIDToString(Guid).Replace('{', '').Replace('}', ''));
  TDirectory.CreateDirectory(TempDir);

  Crashed := False;
  CrashDetail := '';
  try
    SetCacheDirOverrideForTests(TempDir);
    try
      // ---- Scenario 1: miss populates both files; a repeat call is a hit
      // that does not re-extract; sections (including a nested Level AND a
      // non-ASCII title, so a sidecar-encoding regression would be visible)
      // survive the round trip through the sidecar. ----
      CallCount := 0;
      Text1 := 'Root heading' + sLineBreak + 'Root body text. ' +
        'Child heading' + sLineBreak + 'Child body text.';
      SetLength(Sections1, 2);
      Sections1[0].Title := 'Root';
      Sections1[0].Level := 0;
      Sections1[0].Offset := 0;
      Sections1[0].Length := Length(Text1);
      Sections1[1].Title := 'Розділ перший'; // Ukrainian: "Chapter One"
      Sections1[1].Level := 1;
      Sections1[1].Offset := 30;
      Sections1[1].Length := Length(Text1) - 30;
      Stamp1 := EncodeDateTime(2026, 1, 1, 0, 0, 0, 0);

      Cached := EnsureCached(1, 100, 5000, Stamp1,
        function: TFb2Extraction
        begin
          Inc(CallCount);
          Result.Text := Text1;
          Result.Sections := Sections1;
          Result.Structured := True;
        end);
      AddCheck('miss calls the extractor exactly once and reports the right total_length',
        (CallCount = 1) and (Cached.TotalLength = Length(Text1)));
      AddCheck('miss writes both the .txt and .json sidecar to disk',
        TFile.Exists(TxtPathForTest(1, 100, 5000, Stamp1)) and
        TFile.Exists(JsonPathForTest(1, 100, 5000, Stamp1)));

      Cached := EnsureCached(1, 100, 5000, Stamp1,
        function: TFb2Extraction
        begin
          Inc(CallCount);
          Result.Text := Text1;
          Result.Sections := Sections1;
          Result.Structured := True;
        end);
      AddCheck('second call with the same key is a hit and does not call the extractor again',
        CallCount = 1);
      AddCheck('hit reconstructs sections from the sidecar, nested Level values included',
        SectionsEqual(Cached.Sections, Sections1));
      AddCheck('hit reconstructs structured=True from the sidecar', Cached.Structured);
      AddCheck('a non-ASCII (Ukrainian) section title survives the sidecar round trip',
        (Length(Cached.Sections) = 2) and (Cached.Sections[1].Title = 'Розділ перший'));

      // ---- Scenario 2: a changed SourceSize or SourceStamp misses and
      // re-extracts, even though CollectionID/BookID stay the same. Also
      // regression-tests fix round 2's millisecond-widened key: a stamp
      // differing only in milliseconds must miss too. ----
      CallCount := 0;
      Stamp2 := EncodeDateTime(2026, 2, 2, 0, 0, 0, 0);

      EnsureCached(2, 200, 1000, Stamp2,
        function: TFb2Extraction
        begin
          Inc(CallCount);
          Result.Text := 'abc';
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      EnsureCached(2, 200, 1000, Stamp2,
        function: TFb2Extraction
        begin
          Inc(CallCount);
          Result.Text := 'abc';
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('unchanged key is a hit on the 2nd call', CallCount = 1);

      EnsureCached(2, 200, 1234, Stamp2,
        function: TFb2Extraction
        begin
          Inc(CallCount);
          Result.Text := 'abc';
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('a changed SourceSize misses and re-extracts', CallCount = 2);

      EnsureCached(2, 200, 1234, IncSecond(Stamp2),
        function: TFb2Extraction
        begin
          Inc(CallCount);
          Result.Text := 'abc';
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('a changed SourceStamp misses and re-extracts', CallCount = 3);

      CallCountMs := 0;
      StampMsA := EncodeDateTime(2026, 2, 2, 12, 0, 0, 100);
      StampMsB := EncodeDateTime(2026, 2, 2, 12, 0, 0, 900);
      EnsureCached(2500, 1, 1, StampMsA,
        function: TFb2Extraction
        begin
          Inc(CallCountMs);
          Result.Text := 'ms-a';
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      EnsureCached(2500, 1, 1, StampMsB,
        function: TFb2Extraction
        begin
          Inc(CallCountMs);
          Result.Text := 'ms-b';
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('a sub-second (millisecond-only) SourceStamp difference misses and re-extracts',
        CallCountMs = 2);

      // ---- Scenario 3: slice boundaries on plain ASCII text, including the
      // exact Offset = total_length edge (must return empty, not fail). ----
      Text3 := 'ABCDEFGHIJ'; // 10 code units
      Stamp3 := EncodeDateTime(2026, 3, 3, 0, 0, 0, 0);
      EnsureCached(3, 300, 10, Stamp3,
        function: TFb2Extraction
        begin
          Result.Text := Text3;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);

      CheckSafe('slice at offset 0 is exact',
        function: Boolean
        begin
          Result := ReadCachedSlice(3, 300, 10, Stamp3, 0, 3) = 'ABC';
        end);
      CheckSafe('an interior slice is exact',
        function: Boolean
        begin
          Result := ReadCachedSlice(3, 300, 10, Stamp3, 3, 4) = 'DEFG';
        end);
      CheckSafe('a slice ending exactly at total_length is exact',
        function: Boolean
        begin
          Result := ReadCachedSlice(3, 300, 10, Stamp3, 7, 3) = 'HIJ';
        end);
      CheckSafe('a Count running past the end clamps instead of failing',
        function: Boolean
        begin
          Result := ReadCachedSlice(3, 300, 10, Stamp3, 8, 100) = 'IJ';
        end);
      CheckSafe('Offset = total_length exactly returns an empty slice, not an error',
        function: Boolean
        begin
          Result := ReadCachedSlice(3, 300, 10, Stamp3, 10, 5) = '';
        end);

      // ---- Scenario 4: non-ASCII (Cyrillic) round-trips identically. ----
      Text4 := 'Привіт, світ! Це тестовий рядок.';
      Stamp4 := EncodeDateTime(2026, 4, 4, 0, 0, 0, 0);
      EnsureCached(4, 400, 999, Stamp4,
        function: TFb2Extraction
        begin
          Result.Text := Text4;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      CheckSafe('Cyrillic text round-trips identically across its full length',
        function: Boolean
        begin
          Result := ReadCachedSlice(4, 400, 999, Stamp4, 0, Length(Text4)) = Text4;
        end);
      CheckSafe('a Cyrillic interior slice round-trips identically',
        function: Boolean
        begin
          Result := ReadCachedSlice(4, 400, 999, Stamp4, 2, 5) = Copy(Text4, 3, 5);
        end);

      // ---- Scenario 5: surrogate safety at a genuine CUT. S5 packs a valid
      // surrogate pair, a lone low surrogate and a lone high surrogate into
      // one string, none of which came from a real decoder -- exactly the
      // "may contain a lone surrogate that was never part of a pair" case
      // the brief calls out. Every slice below is a real cut (its clamped
      // bounds differ from S5's true [0, Length) extent), so trimming is
      // expected to fire on whichever side is actually cut. ----
      S5 := 'AB' + Char($D83D) + Char($DE00) + 'CD' + Char($DC00) + 'EF' + Char($D800) + 'GH';
      Stamp5 := EncodeDateTime(2026, 5, 5, 0, 0, 0, 0);
      EnsureCached(5, 500, 1, Stamp5,
        function: TFb2Extraction
        begin
          Result.Text := S5;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);

      CheckSafe('a slice starting on the low half of a valid pair drops it instead of emitting a broken pair',
        function: Boolean
        begin
          Result := ReadCachedSlice(5, 500, 1, Stamp5, 3, 3) = 'CD';
        end);
      CheckSafe('a slice ending on the high half of a valid pair drops it instead of emitting a broken pair',
        function: Boolean
        begin
          Result := ReadCachedSlice(5, 500, 1, Stamp5, 0, 3) = 'AB';
        end);
      CheckSafe('a lone surrogate strictly inside a slice is left untouched and neighbouring text survives',
        function: Boolean
        begin
          Result := ReadCachedSlice(5, 500, 1, Stamp5, 5, 3) = 'D' + Char($DC00) + 'E';
        end);
      CheckSafe('a lone (unpaired) high surrogate landing on the last unit of a real cut is dropped without crashing',
        function: Boolean
        begin
          Result := ReadCachedSlice(5, 500, 1, Stamp5, 7, 3) = 'EF';
        end);

      // ---- Scenario 5b (fix round 2 / Important 4 regression): a text that
      // BEGINS and ENDS with a lone surrogate. A full read
      // (Offset=0, Count=TotalLength -- exactly what search_in_book uses)
      // must return EVERY unit, including both boundary lone surrogates,
      // because neither end of this read is an actual cut. The original S5
      // fixture above starts with 'A' and ends with 'H', so it could never
      // have caught the bug where TrimSurrogateBoundaries fired
      // unconditionally regardless of whether a boundary was a real cut or
      // the true start/end of the text -- this fixture exists specifically
      // to close that blind spot. ----
      S5b := Char($DC00) + 'MID' + Char($D800); // lone low ... lone high, 5 units total
      Stamp5b := EncodeDateTime(2026, 5, 6, 0, 0, 0, 0);
      EnsureCached(5, 501, 1, Stamp5b,
        function: TFb2Extraction
        begin
          Result.Text := S5b;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      CheckSafe('a full read of text bounded by lone surrogates at both true ends returns every unit unchanged',
        function: Boolean
        begin
          Result := ReadCachedSlice(5, 501, 1, Stamp5b, 0, Length(S5b)) = S5b;
        end);

      // ---- Scenario 6: an embedded NUL code unit (Task 8's decoder emits
      // one verbatim for &#0;) must not truncate the text. ----
      Text6 := 'X' + Char(0) + 'Y';
      Stamp6 := EncodeDateTime(2026, 6, 6, 0, 0, 0, 0);
      EnsureCached(6, 600, 1, Stamp6,
        function: TFb2Extraction
        begin
          Result.Text := Text6;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      CheckSafe('an embedded NUL code unit survives a full round trip',
        function: Boolean
        begin
          Result := ReadCachedSlice(6, 600, 1, Stamp6, 0, 3) = Text6;
        end);

      // ---- Scenario 7: a sidecar without its text file, and a text file
      // without its sidecar, must each be treated as a miss, and the pair
      // must self-heal on the very next call. ----
      CallCount := 0;
      Stamp7 := EncodeDateTime(2026, 7, 7, 0, 0, 0, 0);
      S7Text := 'hello world';

      EnsureCached(7, 700, 11, Stamp7,
        function: TFb2Extraction
        begin
          Inc(CallCount);
          Result.Text := S7Text;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('scenario 7 initial cache call extracted once', CallCount = 1);

      TFile.Delete(JsonPathForTest(7, 700, 11, Stamp7));
      EnsureCached(7, 700, 11, Stamp7,
        function: TFb2Extraction
        begin
          Inc(CallCount);
          Result.Text := S7Text;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('a .txt with its .json sidecar deleted is treated as a miss', CallCount = 2);
      AddCheck('re-extracting after a missing sidecar restores both files',
        TFile.Exists(TxtPathForTest(7, 700, 11, Stamp7)) and
        TFile.Exists(JsonPathForTest(7, 700, 11, Stamp7)));

      TFile.Delete(TxtPathForTest(7, 700, 11, Stamp7));
      EnsureCached(7, 700, 11, Stamp7,
        function: TFb2Extraction
        begin
          Inc(CallCount);
          Result.Text := S7Text;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('a .json with its .txt deleted is treated as a miss', CallCount = 3);
      AddCheck('re-extracting after a missing .txt restores both files',
        TFile.Exists(TxtPathForTest(7, 700, 11, Stamp7)) and
        TFile.Exists(JsonPathForTest(7, 700, 11, Stamp7)));

      // ---- Scenario 7b: TryReadSidecar's corrupt/missing-field path --
      // previously the unit's most defensive code (a blanket try/except
      // meant to turn any parse problem into "treat as a miss") had no
      // dedicated test at all. Both a syntactically-broken sidecar and a
      // syntactically-valid one missing a required field must be treated as
      // a miss, exactly like an absent sidecar, and self-heal. ----
      CallCount7b := 0;
      Stamp7b := EncodeDateTime(2026, 7, 11, 0, 0, 0, 0);
      Txt7bPath := TxtPathForTest(7100, 1, 1, Stamp7b);
      Json7bPath := JsonPathForTest(7100, 1, 1, Stamp7b);
      TFile.WriteAllBytes(Txt7bPath, TEncoding.Unicode.GetBytes('placeholder'));
      TFile.WriteAllText(Json7bPath, '{not valid json at all');

      EnsureCached(7100, 1, 1, Stamp7b,
        function: TFb2Extraction
        begin
          Inc(CallCount7b);
          Result.Text := 'fresh text after corrupt sidecar';
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('a syntactically invalid JSON sidecar is treated as a miss and re-extracted',
        (CallCount7b = 1) and
        TFile.Exists(Txt7bPath) and TFile.Exists(Json7bPath));

      EnsureCached(7100, 1, 1, Stamp7b,
        function: TFb2Extraction
        begin
          Inc(CallCount7b);
          Result.Text := 'fresh text after corrupt sidecar';
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('after self-healing from an invalid sidecar, the next call is a hit', CallCount7b = 1);

      CallCount7c := 0;
      Stamp7c := EncodeDateTime(2026, 7, 12, 0, 0, 0, 0);
      Txt7cPath := TxtPathForTest(7200, 1, 1, Stamp7c);
      Json7cPath := JsonPathForTest(7200, 1, 1, Stamp7c);
      TFile.WriteAllBytes(Txt7cPath, TEncoding.Unicode.GetBytes('placeholder'));
      TFile.WriteAllText(Json7cPath, '{"structured":false,"sections":[]}'); // total_length missing

      EnsureCached(7200, 1, 1, Stamp7c,
        function: TFb2Extraction
        begin
          Inc(CallCount7c);
          Result.Text := 'fresh text after field-missing sidecar';
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('a sidecar missing a required field (total_length) is treated as a miss',
        CallCount7c = 1);

      // ---- Scenario 7d: the total_length/actual-.txt-size integrity check.
      // External truncation of the .txt behind an otherwise-valid, unchanged
      // sidecar must be detected and treated as a miss, not served forever
      // as a stale hit reporting the old (now-wrong) total_length. ----
      CallCount7d := 0;
      Stamp7d := EncodeDateTime(2026, 7, 13, 0, 0, 0, 0);
      OriginalText7d := StringOfChar('X', 30);
      EnsureCached(7300, 1, 1, Stamp7d,
        function: TFb2Extraction
        begin
          Inc(CallCount7d);
          Result.Text := OriginalText7d;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('scenario 7d initial cache call extracted once', CallCount7d = 1);

      Txt7dPath := TxtPathForTest(7300, 1, 1, Stamp7d);
      // Truncate the .txt directly to 10 code units behind the still-intact
      // sidecar, which keeps claiming total_length: 30 -- simulating
      // external corruption this unit itself never causes.
      TFile.WriteAllBytes(Txt7dPath, TEncoding.Unicode.GetBytes(Copy(OriginalText7d, 1, 10)));

      Cached7d := EnsureCached(7300, 1, 1, Stamp7d,
        function: TFb2Extraction
        begin
          Inc(CallCount7d);
          Result.Text := OriginalText7d;
          SetLength(Result.Sections, 0);
          Result.Structured := False;
        end);
      AddCheck('a .txt truncated behind a stale sidecar is detected and re-extracted, not served as a permanent stale hit',
        (CallCount7d = 2) and (Cached7d.TotalLength = 30));

      // ---- Scenario 8: the real size-cap / oldest-last-accessed-first
      // eviction path, driven with a throwaway few-KB cap instead of the
      // production 200 MB constant (EvictCache's CapBytes parameter exists
      // for exactly this reason -- the parameterless call site at server
      // startup still gets CACHE_CAP_BYTES unchanged). Five pairs, each
      // holding a unique short marker so a corrupted/cross-contaminated read
      // after eviction would actually be detectable, not masked by every
      // entry having identical content.
      //
      // AccessRank9 is a deliberately SCRAMBLED permutation of 0..4, not the
      // ascending order the entries are created in and not their filename
      // order either (both of those already ascend with K, since
      // CollectionID = 9000+K) -- so an implementation that accidentally
      // sorted by filename or creation order instead of the actually-stamped
      // access time would fail this, rather than passing it by coincidence.
      // Last-access times are set EXPLICITLY rather than relied upon from
      // real read/write timing, so the ordering assertion is deterministic
      // and not a race against wall-clock granularity or the OS's own
      // last-access-tracking policy (see the report for this machine's
      // measured behaviour). ----
      Stamp9 := EncodeDateTime(2026, 9, 9, 0, 0, 0, 0);
      AccessRank9[0] := 2;
      AccessRank9[1] := 4;
      AccessRank9[2] := 0;
      AccessRank9[3] := 3;
      AccessRank9[4] := 1;

      for K := 0 to 4 do
      begin
        EnsureCached(9000 + K, 1, 1, Stamp9,
          function: TFb2Extraction
          begin
            Result.Text := Format('ENTRY%d-', [K]) + StringOfChar('Q', 1020);
            SetLength(Result.Sections, 0);
            Result.Structured := False;
          end);
        Txt9[K] := TxtPathForTest(9000 + K, 1, 1, Stamp9);
        Json9[K] := JsonPathForTest(9000 + K, 1, 1, Stamp9);
      end;

      for K := 0 to 4 do
      begin
        TFile.SetLastAccessTime(Txt9[K], IncMinute(Stamp9, AccessRank9[K]));
        TFile.SetLastAccessTime(Json9[K], IncMinute(Stamp9, AccessRank9[K]));
      end;

      // A file this unit did not create and whose name does not match its
      // key pattern must survive eviction untouched, regardless of shape:
      // a lone .txt with no sidecar, a lone .json with no text file, and a
      // same-named pair that merely happens to have both extensions.
      NonMatchTxt := TPath.Combine(TempDir, 'my important notes.txt');
      NonMatchJson := TPath.Combine(TempDir, 'settings.json');
      NonMatchPairTxt := TPath.Combine(TempDir, 'readme.txt');
      NonMatchPairJson := TPath.Combine(TempDir, 'readme.json');
      TFile.WriteAllBytes(NonMatchTxt, TEncoding.Unicode.GetBytes('these are not cache files'));
      TFile.WriteAllText(NonMatchJson, '{"not":"a cache sidecar"}');
      TFile.WriteAllBytes(NonMatchPairTxt, TEncoding.Unicode.GetBytes('readme body'));
      TFile.WriteAllText(NonMatchPairJson, '{"also":"not ours"}');

      PairBytes9 := TFile.GetSize(Txt9[0]) + TFile.GetSize(Json9[0]);
      Total9 := 0;
      for K := 0 to 4 do
        Inc(Total9, TFile.GetSize(Txt9[K]) + TFile.GetSize(Json9[K]));

      CapBig9 := Total9 + 1024;       // comfortably above the real total
      Cap3Of9 := 3 * PairBytes9;      // room for exactly the 3 newest-by-access pairs

      EvictCache(CapBig9);
      AddCheck('below the injected cap, EvictCache deletes nothing',
        TFile.Exists(Txt9[0]) and TFile.Exists(Json9[0]) and
        TFile.Exists(Txt9[1]) and TFile.Exists(Json9[1]) and
        TFile.Exists(Txt9[2]) and TFile.Exists(Json9[2]) and
        TFile.Exists(Txt9[3]) and TFile.Exists(Json9[3]) and
        TFile.Exists(Txt9[4]) and TFile.Exists(Json9[4]));

      EvictCache(Cap3Of9);
      // Ranks: K=2 is oldest (rank 0), K=4 is rank 1 -- these two are evicted.
      // K=0 (rank 2), K=3 (rank 3), K=1 (rank 4, newest) survive.
      AddCheck('over the injected cap, the two oldest-by-STAMPED-ACCESS-TIME pairs are deleted (scrambled name/creation order)',
        (not TFile.Exists(Txt9[2])) and (not TFile.Exists(Json9[2])) and
        (not TFile.Exists(Txt9[4])) and (not TFile.Exists(Json9[4])));
      AddCheck('eviction stops once under the cap -- the newest-by-access pairs survive',
        TFile.Exists(Txt9[0]) and TFile.Exists(Json9[0]) and
        TFile.Exists(Txt9[3]) and TFile.Exists(Json9[3]) and
        TFile.Exists(Txt9[1]) and TFile.Exists(Json9[1]));
      AddCheck('an evicted pair is removed atomically -- never a lone .txt or .json left behind',
        (TFile.Exists(Txt9[2]) = TFile.Exists(Json9[2])) and
        (TFile.Exists(Txt9[4]) = TFile.Exists(Json9[4])));
      CheckSafe('a surviving entry still reads back its own exact content after eviction',
        function: Boolean
        begin
          Result := ReadCachedSlice(9001, 1, 1, Stamp9, 0, 7) = 'ENTRY1-';
        end);

      AddCheck('a non-cache-pattern file with no sidecar survives eviction untouched',
        TFile.Exists(NonMatchTxt));
      AddCheck('a non-cache-pattern sidecar with no text file survives eviction untouched',
        TFile.Exists(NonMatchJson));
      AddCheck('a non-cache-pattern same-named .txt/.json pair survives eviction untouched',
        TFile.Exists(NonMatchPairTxt) and TFile.Exists(NonMatchPairJson));

      // ---- Scenario 9 (bonus, beyond the brief's required list): EvictCache
      // prunes a true orphan -- a .txt with no matching .json -- that was
      // never created through EnsureCached and so never self-heals, as long
      // as its name matches the cache key pattern (17-digit timestamp tail,
      // matching fix round 2's millisecond-widened format). ----
      OrphanTxtPath := TPath.Combine(TempDir, '9999_9999_1_20260101000000000.txt');
      TFile.WriteAllBytes(OrphanTxtPath, TEncoding.Unicode.GetBytes('orphan'));
      EvictCache;
      AddCheck('EvictCache prunes an orphan .txt with no matching .json',
        not TFile.Exists(OrphanTxtPath));
    except
      on E: Exception do
      begin
        Crashed := True;
        CrashDetail := E.ClassName + ': ' + E.Message;
      end;
    end;
  finally
    try
      TDirectory.Delete(TempDir, True);
    except
      // Best-effort cleanup of our own OS-temp scratch directory; a failure
      // here must never mask the self-test's own result below.
    end;
  end;
  AddCheck('self-test ran to completion without an unhandled exception',
    not Crashed, CrashDetail);

  Transport := TMcpTransport.Create;
  try
    Arr := TJSONArray.Create;
    try
      for I := 0 to High(Checks) do
      begin
        Entry := TJSONObject.Create;
        try
          Entry.AddPair('name', Checks[I].Name);
          Entry.AddPair('pass', TJSONBool.Create(Checks[I].Pass));
          Entry.AddPair('detail', Checks[I].Detail);
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
      Root.AddPair('checks', Arr);
      Transport.WriteMessage(Root.ToJSON);
    finally
      Root.Free;
    end;
  finally
    Transport.Free;
  end;
end;

end.
