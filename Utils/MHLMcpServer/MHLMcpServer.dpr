program MHLMcpServer;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  System.Classes,
  System.SysUtils,
  System.IOUtils,
  System.DateUtils,
  System.JSON,
  dm_user in '..\..\Program\DataModules\dm_user.pas' {DMUser: TDataModule},
  unit_MCP_Transport in 'unit_MCP_Transport.pas',
  unit_MCP_Protocol in 'unit_MCP_Protocol.pas',
  unit_MCP_Json in 'unit_MCP_Json.pas',
  unit_MCP_Tools_Library in 'unit_MCP_Tools_Library.pas',
  unit_MCP_Fb2Extract in 'unit_MCP_Fb2Extract.pas',
  unit_MCP_TextCache in 'unit_MCP_TextCache.pas';

// Extracts one FB2 file's text and section structure and prints it as a
// single JSON line, exactly like a tool result would look, but with no MCP
// envelope. Runs before the server/DMUser bootstrap (see the dispatch below)
// -- ExtractFb2 touches no database, so this needs neither DMUser nor a
// system database to exist. Still goes through TMcpTransport, not Writeln,
// so the same "only the transport writes to stdout" discipline holds here
// too.
procedure RunExtractMode(const FileName: string);
var
  Stream: TFileStream;
  Extraction: TFb2Extraction;
  Root: TJSONObject;
  Arr: TJSONArray;
  Entry: TJSONObject;
  Transport: TMcpTransport;
  I: Integer;
begin
  Transport := TMcpTransport.Create;
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    try
      Extraction := ExtractFb2(Stream);
    finally
      Stream.Free;
    end;

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
      Root.AddPair('text', Extraction.Text);
      Root.AddPair('sections', Arr);
      Root.AddPair('structured', TJSONBool.Create(Extraction.Structured));
      Root.AddPair('total_length', TJSONNumber.Create(Length(Extraction.Text)));
      Transport.WriteMessage(Root.ToJSON);
    finally
      Root.Free;
    end;
  finally
    Transport.Free;
  end;
end;

// Exercises unit_MCP_TextCache end to end against a throwaway temp directory
// -- never the real %LOCALAPPDATA%\MyHomeLib\McpCache -- via
// SetCacheDirOverrideForTests. No database, no DMUser, and (like
// RunExtractMode) run entirely before Application.Initialize.
//
// Task 9's brief provides no automated coverage for the cache unit; this
// mode exists to close that gap. Each check is a self-contained assertion
// evaluated in Pascal (only Pascal has direct access to EnsureCached's
// invocation-count closures and to the cache's on-disk files), and the
// verdicts are reported as one JSON line for tests/cache_tests.js to turn
// into PASS/FAIL console lines, mirroring RunExtractMode/extract_tests.js.
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
  Text1, Text3, Text4, Text6, S5, S7Text: string;
  Sections1: TFb2Sections;
  Stamp1, Stamp2, Stamp3, Stamp4, Stamp5, Stamp6, Stamp7, Stamp9: TDateTime;
  OrphanTxtPath: string;

  K: Integer;
  Txt9, Json9: array[0..4] of string;
  PairBytes9, Total9, CapBig9, Cap3Of9: Int64;

  // Rebuilds the on-disk path for a key exactly the way
  // unit_MCP_TextCache.CacheKey does (the format is fixed by the task spec),
  // so this test can assert file existence directly without the unit
  // exporting its private key function.
  function TxtPathForTest(const CollectionID, BookID: Integer;
    const SourceSize: Int64; const Stamp: TDateTime): string;
  begin
    Result := TPath.Combine(TempDir, Format('%d_%d_%d_%s.txt',
      [CollectionID, BookID, SourceSize, FormatDateTime('yyyymmddhhnnss', Stamp)]));
  end;

  function JsonPathForTest(const CollectionID, BookID: Integer;
    const SourceSize: Int64; const Stamp: TDateTime): string;
  begin
    Result := TPath.Combine(TempDir, Format('%d_%d_%d_%s.json',
      [CollectionID, BookID, SourceSize, FormatDateTime('yyyymmddhhnnss', Stamp)]));
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
    K: Integer;
  begin
    Result := Length(A) = Length(B);
    if not Result then
      Exit;
    for K := 0 to High(A) do
      if (A[K].Title <> B[K].Title) or (A[K].Level <> B[K].Level) or
         (A[K].Offset <> B[K].Offset) or (A[K].Length <> B[K].Length) then
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
      // that does not re-extract; sections (including a nested Level) and
      // structured survive the round trip through the sidecar. ----
      CallCount := 0;
      Text1 := 'Root heading' + sLineBreak + 'Root body text. ' +
        'Child heading' + sLineBreak + 'Child body text.';
      SetLength(Sections1, 2);
      Sections1[0].Title := 'Root';
      Sections1[0].Level := 0;
      Sections1[0].Offset := 0;
      Sections1[0].Length := Length(Text1);
      Sections1[1].Title := 'Child';
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

      // ---- Scenario 2: a changed SourceSize or SourceStamp misses and
      // re-extracts, even though CollectionID/BookID stay the same. ----
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

      // ---- Scenario 3: slice boundaries on plain ASCII text. ----
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

      // ---- Scenario 5: surrogate safety. S5 packs a valid surrogate pair,
      // a lone low surrogate and a lone high surrogate into one string, none
      // of which came from a real decoder -- exactly the "may contain a lone
      // surrogate that was never part of a pair" case the brief calls out. ----
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
      CheckSafe('a lone (unpaired) high surrogate landing on the last unit is dropped without crashing',
        function: Boolean
        begin
          Result := ReadCachedSlice(5, 500, 1, Stamp5, 7, 3) = 'EF';
        end);
      CheckSafe('the full text -- valid pair plus both lone surrogates -- round-trips unchanged',
        function: Boolean
        begin
          Result := ReadCachedSlice(5, 500, 1, Stamp5, 0, Length(S5)) = S5;
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

      // ---- Scenario 8: the real size-cap / oldest-last-accessed-first
      // eviction path, driven with a throwaway few-KB cap instead of the
      // production 200 MB constant (EvictCache's CapBytes parameter exists
      // for exactly this reason -- the parameterless call site at server
      // startup still gets CACHE_CAP_BYTES unchanged). Five pairs, each
      // holding a unique short marker so a corrupted/cross-contaminated read
      // after eviction would actually be detectable, not masked by every
      // entry having identical content. Last-access times are set EXPLICITLY
      // here rather than relied upon from real read/write timing, so the
      // ordering assertion is deterministic and not a race against either
      // wall-clock granularity or the OS's own last-access-tracking policy
      // (see the report for this machine's measured behaviour). ----
      Stamp9 := EncodeDateTime(2026, 9, 9, 0, 0, 0, 0);
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

      // K=0 is stamped oldest, K=4 newest -- strictly increasing, minutes
      // apart, so there is no possible ambiguity in access-time ordering.
      for K := 0 to 4 do
      begin
        TFile.SetLastAccessTime(Txt9[K], IncMinute(Stamp9, K));
        TFile.SetLastAccessTime(Json9[K], IncMinute(Stamp9, K));
      end;

      PairBytes9 := TFile.GetSize(Txt9[0]) + TFile.GetSize(Json9[0]);
      Total9 := 0;
      for K := 0 to 4 do
        Inc(Total9, TFile.GetSize(Txt9[K]) + TFile.GetSize(Json9[K]));

      CapBig9 := Total9 + 1024;       // comfortably above the real total
      Cap3Of9 := 3 * PairBytes9;      // room for exactly the 3 newest pairs

      EvictCache(CapBig9);
      AddCheck('below the injected cap, EvictCache deletes nothing',
        TFile.Exists(Txt9[0]) and TFile.Exists(Json9[0]) and
        TFile.Exists(Txt9[1]) and TFile.Exists(Json9[1]) and
        TFile.Exists(Txt9[2]) and TFile.Exists(Json9[2]) and
        TFile.Exists(Txt9[3]) and TFile.Exists(Json9[3]) and
        TFile.Exists(Txt9[4]) and TFile.Exists(Json9[4]));

      EvictCache(Cap3Of9);
      AddCheck('over the injected cap, the two oldest-last-accessed pairs are deleted',
        (not TFile.Exists(Txt9[0])) and (not TFile.Exists(Json9[0])) and
        (not TFile.Exists(Txt9[1])) and (not TFile.Exists(Json9[1])));
      AddCheck('eviction stops once under the cap -- the newest pairs survive',
        TFile.Exists(Txt9[2]) and TFile.Exists(Json9[2]) and
        TFile.Exists(Txt9[3]) and TFile.Exists(Json9[3]) and
        TFile.Exists(Txt9[4]) and TFile.Exists(Json9[4]));
      AddCheck('an evicted pair is removed atomically -- never a lone .txt or .json left behind',
        (TFile.Exists(Txt9[0]) = TFile.Exists(Json9[0])) and
        (TFile.Exists(Txt9[1]) = TFile.Exists(Json9[1])));
      CheckSafe('a surviving entry still reads back its own exact content after eviction',
        function: Boolean
        begin
          Result := ReadCachedSlice(9004, 1, 1, Stamp9, 0, 7) = 'ENTRY4-';
        end);

      // ---- Scenario 9 (bonus, beyond the brief's required list): EvictCache
      // prunes a true orphan -- a .txt with no matching .json -- that was
      // never created through EnsureCached and so never self-heals. ----
      OrphanTxtPath := TPath.Combine(TempDir, '9999_9999_1_20260101000000.txt');
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

// IMPORTANT: nothing in this project may write to stdout except TMcpTransport.
// A single stray WriteLn corrupts every JSON-RPC response.
//
// This process links the VCL because the DAO layer does, but it creates no
// forms and runs no message loop.
//
// Note: unlike MyHomeLib.dpr, this does NOT call FirstHinstanceRunning —
// several server instances may run alongside the running app.
//
// DMUser is deliberately NOT created here. unit_MCP_Tools_Library boots it
// lazily, on the first tool call, via EnsureLibraryInitialized -- so a
// missing system database surfaces as a normal tool error (system_db_missing)
// instead of TDMUser.Init silently creating a brand-new one. That is also why
// every tool registration below is wrapped in Guarded(...): it is the one
// path by which DMUser gets initialized.

var
  Server: TMcpServer;

begin
  // --extract is a pure, database-free CLI mode (see RunExtractMode above),
  // so it is handled before Application.Initialize / DMUser ever come into
  // play. Any failure here is reported to stderr, never stdout -- the
  // transport already owns stdout for the (unused, in this mode) JSON line.
  //
  // Checked on ParamStr(1) alone, not on ParamCount = 2: an unquoted path
  // containing spaces is split by the OS into several ParamStr entries, and
  // falling through to server mode in that case would silently start a
  // JSON-RPC server that blocks forever reading stdin, with no indication
  // that --extract was even recognised. There is no reliable way to
  // reconstruct one path from several already-split arguments, so this
  // fails fast with a clear message instead of guessing.
  if (ParamCount >= 1) and (ParamStr(1) = '--extract') then
  begin
    if ParamCount <> 2 then
    begin
      Writeln(ErrOutput,
        Format('--extract requires exactly one file path argument (got %d). ' +
          'If the path contains spaces, quote it.', [ParamCount - 1]));
      Halt(1);
    end;

    try
      RunExtractMode(ParamStr(2));
    except
      on E: Exception do
      begin
        Writeln(ErrOutput, 'FB2 extraction failed: ' + E.Message);
        Halt(1);
      end;
    end;
    Exit;
  end;

  // --cache-selftest is likewise a pure, database-free CLI mode (see
  // RunCacheSelfTestMode above) -- it only exercises unit_MCP_TextCache
  // against a throwaway temp directory, so it runs before
  // Application.Initialize/DMUser exactly like --extract does, and it must
  // NOT run EvictCache below (that call targets the real cache directory,
  // which this mode never touches).
  if (ParamCount >= 1) and (ParamStr(1) = '--cache-selftest') then
  begin
    try
      RunCacheSelfTestMode;
    except
      on E: Exception do
      begin
        Writeln(ErrOutput, 'Cache self-test failed: ' + E.Message);
        Halt(1);
      end;
    end;
    Exit;
  end;

  Application.Initialize;

  // Filesystem-only, database-free, and idempotent-by-design (see
  // EvictCache's own comment): runs exactly once here, at process startup,
  // never inside --extract/--cache-selftest and never on the per-request
  // path a tool call would take.
  EvictCache;

  Server := TMcpServer.Create;
  try
    // echo_args is a temporary diagnostic tool from Task 3, removed in
    // Task 10. It never touches DMUser itself, but it is still wrapped in
    // Guarded(...) so "every registration is wrapped" stays mechanically
    // true rather than merely true by convention.
    Server.RegisterTool('echo_args', 'Test helper', TJSONObject.Create,
      Guarded(
        function(const Args: TJSONObject): TJSONObject
        var
          Limit: Integer;
          Clamped: Boolean;
        begin
          Limit := ArgIntClamped(Args, 'limit', 25, 1, 200, Clamped);
          Result := TJSONObject.Create;
          Result.AddPair('limit', TJSONNumber.Create(Limit));
          Result.AddPair('clamped', TJSONBool.Create(Clamped));
        end));

    RegisterLibraryTools(Server);
    Server.Run;
  finally
    Server.Free;
    if Assigned(DMUser) then
      FreeAndNil(DMUser);
  end;
end.
