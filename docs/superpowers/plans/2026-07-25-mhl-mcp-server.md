# MyHomeLib MCP Server Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** A read-only MCP server, written in Delphi and reusing MyHomeLib's DAO layer, that lets Claude search the library catalogue and read the text of FB2 books.

**Architecture:** A console-mode Delphi app at `Utils/MHLMcpServer/` speaking MCP over stdio. It boots `DMUser` exactly as the app does, so it sees the same settings and the same registered collections, and reaches books through `IBookCollection` and `TBookRecord.GetBookStream`. FB2 text and section offsets come from a single DOM walk so both live in one character space, cached on disk per book.

**Tech Stack:** Delphi 13 (Studio 37.0), `System.JSON` for JSON-RPC, `Xml.XMLDoc` (MSXML) for FB2, Node.js for the golden-file test harness.

## Global Constraints

- Build **only** through `Program\MHL.groupproj`. Never run msbuild on `MyhomeLib.dproj` or `MHLMcpServer.dproj` directly — it re-serialises the file and breaks every later build with `F2613`.
- Build **Win64 first**, then Win32. Both must pass before any commit.
- `C:\Windows\System32` must be on `PATH` (post-build `robocopy`).
- Every new `.pas`/`.dpr` file must be saved **UTF-8 with BOM**, or Cyrillic strings compile clean and render as mojibake.
- Commit prefixes: `+` for new features, `*` for modifications and fixes.
- No commit without a successful build.
- **Stdout is owned solely by `unit_MCP_Transport`.** No `Write`/`WriteLn` anywhere else in the project. Diagnostics go to stderr or `unit_Logger`.
- The server never issues an SQL write. SQLiteWrap has no read-only open mode, so this is an invariant maintained by code review, not by the driver.
- Resource strings and comments follow the repo: Ukrainian for anything user-visible, English for code comments.
- **Task 1 Step 5 modifies `Program/MHL.groupproj`.** The standing convention is not to touch `.dproj`/`.groupproj` unasked; confirm before starting Task 1.

**Build command (Win64):**

```
cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MHL.groupproj /t:Build /p:Config=Release /p:Platform=Win64 /nologo /v:minimal" 2>&1
```

Swap `/p:Platform=Win32` for the 32-bit build.

---

## File Structure

| File | Responsibility |
|---|---|
| `Utils/MHLMcpServer/MHLMcpServer.dpr` | Bootstrap, CLI mode dispatch, DMUser lifecycle, main loop |
| `Utils/MHLMcpServer/MHLMcpServer.dproj` | Project file, added to `MHL.groupproj` |
| `Utils/MHLMcpServer/unit_MCP_Transport.pas` | Newline-delimited UTF-8 JSON on raw stdin/stdout handles |
| `Utils/MHLMcpServer/unit_MCP_Protocol.pas` | JSON-RPC 2.0 envelope, MCP handshake, tool registry, dispatch, error mapping |
| `Utils/MHLMcpServer/unit_MCP_Json.pas` | Argument extraction with clamping, record→JSON marshalling |
| `Utils/MHLMcpServer/unit_MCP_Tools_Library.pas` | `list_collections`, `search_books`, `get_book`, `list_series`, `list_genres`, `list_authors` |
| `Utils/MHLMcpServer/unit_MCP_Fb2Extract.pas` | FB2 → `(text, sections)` in one DOM walk, with tag-stripping fallback |
| `Utils/MHLMcpServer/unit_MCP_TextCache.pas` | On-disk UTF-16LE text cache + TOC sidecar, keyed and evicted |
| `Utils/MHLMcpServer/unit_MCP_Tools_Text.pas` | `get_book_toc`, `get_book_text`, `search_in_book` |
| `Utils/MHLMcpServer/tests/run_tests.js` | Golden-file harness: spawn exe, feed `.jsonl`, diff responses |
| `Utils/MHLMcpServer/tests/cases/*.jsonl` | Protocol golden cases |
| `Utils/MHLMcpServer/tests/fixtures/*.fb2` | FB2 fixtures for extractor tests |
| `Utils/MHLMcpServer/README.md` | Setup, `.mcp.json` snippet, manual test checklist |

---

## Task 1: Project skeleton and stdio transport

**Files:**
- Create: `Utils/MHLMcpServer/MHLMcpServer.dpr`
- Create: `Utils/MHLMcpServer/MHLMcpServer.dproj`
- Create: `Utils/MHLMcpServer/unit_MCP_Transport.pas`
- Create: `Utils/MHLMcpServer/tests/run_tests.js`
- Create: `Utils/MHLMcpServer/tests/cases/01_ping.jsonl`
- Modify: `Program/MHL.groupproj`

**Interfaces:**
- Consumes: nothing.
- Produces: `TMcpTransport` with `constructor Create`, `function ReadMessage(out Msg: string): Boolean`, `procedure WriteMessage(const Msg: string)`.

**Why raw handles:** `System.ReadLn`/`WriteLn` apply ANSI conversion and would mangle Cyrillic titles. The transport works on `THandleStream` over `GetStdHandle` and encodes UTF-8 itself.

- [ ] **Step 1: Write the failing test**

Create `Utils/MHLMcpServer/tests/cases/01_ping.jsonl`. Lines beginning `>` are sent, lines beginning `<` are expected:

```
> {"jsonrpc":"2.0","id":1,"method":"ping"}
< {"jsonrpc":"2.0","id":1,"result":{}}
```

Create `Utils/MHLMcpServer/tests/run_tests.js`:

```js
const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const exe = process.argv[2];
if (!exe || !fs.existsSync(exe)) {
  console.error(`Server exe not found: ${exe}`);
  process.exit(2);
}

const casesDir = path.join(__dirname, 'cases');
let failed = 0;

for (const file of fs.readdirSync(casesDir).filter(f => f.endsWith('.jsonl')).sort()) {
  const lines = fs.readFileSync(path.join(casesDir, file), 'utf8')
    .split(/\r?\n/).filter(l => l.trim());
  const sent = lines.filter(l => l.startsWith('>')).map(l => l.slice(1).trim());
  const want = lines.filter(l => l.startsWith('<')).map(l => JSON.parse(l.slice(1).trim()));

  const run = spawnSync(exe, [], { input: sent.join('\n') + '\n', encoding: 'utf8' });
  const got = run.stdout.split(/\r?\n/).filter(l => l.trim()).map(l => JSON.parse(l));

  let ok = got.length === want.length;
  if (ok) {
    for (let i = 0; i < want.length; i++) {
      if (JSON.stringify(got[i]) !== JSON.stringify(want[i])) { ok = false; break; }
    }
  }

  if (ok) {
    console.log(`PASS ${file}`);
  } else {
    failed++;
    console.log(`FAIL ${file}`);
    console.log(`  want: ${JSON.stringify(want)}`);
    console.log(`  got:  ${JSON.stringify(got)}`);
    if (run.stderr.trim()) console.log(`  stderr: ${run.stderr.trim()}`);
  }
}

process.exit(failed ? 1 : 0);
```

- [ ] **Step 2: Run the test to verify it fails**

Run:

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: exits 2 with `Server exe not found`.

- [ ] **Step 3: Write the transport unit**

Create `Utils/MHLMcpServer/unit_MCP_Transport.pas` (**UTF-8 with BOM**):

```pascal
unit unit_MCP_Transport;

interface

uses
  Winapi.Windows,
  System.Classes,
  System.SysUtils;

type
  // Newline-delimited UTF-8 JSON over the process's standard handles.
  // This is the ONLY class in the project permitted to write to stdout.
  TMcpTransport = class
  private
    FInput: THandleStream;
    FOutput: THandleStream;
    FPending: TBytes;
    FPendingLen: Integer;
    function TakeLine(out Line: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    // Blocks until a full line arrives. False means stdin reached EOF.
    function ReadMessage(out Msg: string): Boolean;
    procedure WriteMessage(const Msg: string);
  end;

implementation

const
  CHUNK_SIZE = 8192;

constructor TMcpTransport.Create;
begin
  inherited Create;
  FInput := THandleStream.Create(GetStdHandle(STD_INPUT_HANDLE));
  FOutput := THandleStream.Create(GetStdHandle(STD_OUTPUT_HANDLE));
  SetLength(FPending, CHUNK_SIZE);
  FPendingLen := 0;
end;

destructor TMcpTransport.Destroy;
begin
  FInput.Free;
  FOutput.Free;
  inherited Destroy;
end;

function TMcpTransport.TakeLine(out Line: string): Boolean;
var
  I, LineLen, Rest: Integer;
begin
  Result := False;
  Line := '';

  for I := 0 to FPendingLen - 1 do
    if FPending[I] = 10 then // LF
    begin
      LineLen := I;
      if (LineLen > 0) and (FPending[LineLen - 1] = 13) then // strip CR
        Dec(LineLen);

      Line := TEncoding.UTF8.GetString(FPending, 0, LineLen);

      Rest := FPendingLen - I - 1;
      if Rest > 0 then
        Move(FPending[I + 1], FPending[0], Rest);
      FPendingLen := Rest;

      Exit(True);
    end;
end;

function TMcpTransport.ReadMessage(out Msg: string): Boolean;
var
  Got: Integer;
begin
  if TakeLine(Msg) then
    Exit(True);

  repeat
    if FPendingLen + CHUNK_SIZE > Length(FPending) then
      SetLength(FPending, Length(FPending) * 2);

    Got := FInput.Read(FPending[FPendingLen], CHUNK_SIZE);
    if Got <= 0 then
      Exit(False); // EOF: the client closed the pipe

    Inc(FPendingLen, Got);

    if TakeLine(Msg) then
      Exit(True);
  until False;
end;

procedure TMcpTransport.WriteMessage(const Msg: string);
var
  Data: TBytes;
  LF: Byte;
begin
  Data := TEncoding.UTF8.GetBytes(Msg);
  if Length(Data) > 0 then
    FOutput.WriteBuffer(Data[0], Length(Data));
  LF := 10;
  FOutput.WriteBuffer(LF, 1);
end;

end.
```

- [ ] **Step 4: Write the bootstrap with a `ping`-only loop**

Create `Utils/MHLMcpServer/MHLMcpServer.dpr` (**UTF-8 with BOM**):

```pascal
program MHLMcpServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.JSON,
  unit_MCP_Transport in 'unit_MCP_Transport.pas';

// IMPORTANT: nothing in this project may write to stdout except TMcpTransport.
// A single stray WriteLn corrupts every JSON-RPC response.

var
  Transport: TMcpTransport;
  Line: string;
  Request, Response: TJSONObject;

begin
  Transport := TMcpTransport.Create;
  try
    while Transport.ReadMessage(Line) do
    begin
      if Trim(Line) = '' then
        Continue;

      Request := TJSONObject.ParseJSONValue(Line) as TJSONObject;
      if not Assigned(Request) then
        Continue;
      try
        if Request.GetValue<string>('method', '') = 'ping' then
        begin
          Response := TJSONObject.Create;
          try
            Response.AddPair('jsonrpc', '2.0');
            Response.AddPair('id', Request.GetValue('id').Clone as TJSONValue);
            Response.AddPair('result', TJSONObject.Create);
            Transport.WriteMessage(Response.ToJSON);
          finally
            Response.Free;
          end;
        end;
      finally
        Request.Free;
      end;
    end;
  finally
    Transport.Free;
  end;
end.
```

- [ ] **Step 5: Create the project file and add it to the group**

Create `MHLMcpServer.dproj` by copying the structure of `Utils/MHLSQLiteConsole`'s dproj, changing the project name, and setting output to `..\..\Program\OUT\Bin64` (Win64) and `..\..\Program\OUT\BIN` (Win32). Unit search path must include:

```
..\..\Program\Units;..\..\Program\DAO;..\..\Program\DAO\SQLite;..\..\Program\DAO\SQLite\Lib;..\..\Program\DataModules;..\..\Program\UtilsImpl;..\..\Components\MHLComponents;..\..\Components\MHLComponents\Units
```

Then add to `Program/MHL.groupproj` a third `<Projects>` entry after `MHLComponents`, with the same dependency shape MyHomeLib uses.

Keep the `CodeGear.Delphi.Targets` import **below** the config property groups, matching `MyhomeLib.dproj`.

- [ ] **Step 6: Build both platforms**

Run the Win64 build command from Global Constraints, then the Win32 one.
Expected: `Build succeeded` for both, `MHLMcpServer.exe` present in `Program/OUT/Bin64/` and `Program/OUT/BIN/`.

- [ ] **Step 7: Run the test to verify it passes**

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: `PASS 01_ping.jsonl`, exit 0.

- [ ] **Step 8: Commit**

```bash
git add Utils/MHLMcpServer Program/MHL.groupproj
git commit -m "+ Add MCP server skeleton with stdio transport"
```

---

## Task 2: JSON-RPC envelope and MCP handshake

**Files:**
- Create: `Utils/MHLMcpServer/unit_MCP_Protocol.pas`
- Modify: `Utils/MHLMcpServer/MHLMcpServer.dpr`
- Create: `Utils/MHLMcpServer/tests/cases/02_initialize.jsonl`
- Create: `Utils/MHLMcpServer/tests/cases/03_unknown_method.jsonl`
- Create: `Utils/MHLMcpServer/tests/cases/04_unknown_tool.jsonl`

**Interfaces:**
- Consumes: `TMcpTransport` from Task 1.
- Produces:
  - `TMcpToolHandler = reference to function(const Args: TJSONObject): TJSONObject;` — returns the tool's payload; raising `EMcpToolError` signals a domain fault.
  - `EMcpToolError = class(Exception)` with `constructor Create(const ACode, AMessage: string)` and `property Code: string`.
  - `TMcpServer` with `procedure RegisterTool(const Name, Description: string; Schema: TJSONObject; Handler: TMcpToolHandler)` and `procedure Run`.

**Protocol version:** pin `PROTOCOL_VERSION = '2025-06-18'` as a constant. If the client's `initialize` sends a different `protocolVersion`, echo the client's value back — MCP requires the server to agree or reject, and echoing is the permissive choice. Verify against the installed Claude Code before finalising.

- [ ] **Step 1: Write the failing tests**

`tests/cases/02_initialize.jsonl`:

```
> {"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"test","version":"1"}}}
< {"jsonrpc":"2.0","id":1,"result":{"protocolVersion":"2025-06-18","capabilities":{"tools":{}},"serverInfo":{"name":"myhomelib","version":"1.0.0"}}}
> {"jsonrpc":"2.0","method":"notifications/initialized"}
> {"jsonrpc":"2.0","id":2,"method":"tools/list"}
< {"jsonrpc":"2.0","id":2,"result":{"tools":[]}}
```

Note the notification produces no response line — that is the assertion.

`tests/cases/03_unknown_method.jsonl`:

```
> {"jsonrpc":"2.0","id":1,"method":"nonsense/method"}
< {"jsonrpc":"2.0","id":1,"error":{"code":-32601,"message":"Method not found: nonsense/method"}}
```

`tests/cases/04_unknown_tool.jsonl`:

```
> {"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"no_such_tool","arguments":{}}}
< {"jsonrpc":"2.0","id":1,"error":{"code":-32602,"message":"Unknown tool: no_such_tool"}}
```

- [ ] **Step 2: Run tests to verify they fail**

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: `PASS 01_ping.jsonl`, `FAIL` for 02, 03 and 04.

- [ ] **Step 3: Write the protocol unit**

Create `Utils/MHLMcpServer/unit_MCP_Protocol.pas` (**UTF-8 with BOM**):

```pascal
unit unit_MCP_Protocol;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.JSON,
  unit_MCP_Transport;

const
  PROTOCOL_VERSION = '2025-06-18';
  SERVER_NAME      = 'myhomelib';
  SERVER_VERSION   = '1.0.0';

  JSONRPC_METHOD_NOT_FOUND = -32601;
  JSONRPC_INVALID_PARAMS   = -32602;
  JSONRPC_INTERNAL_ERROR   = -32603;

type
  // A domain fault. Surfaces as a tool result with isError=true and a
  // machine-readable code, NOT as a JSON-RPC error.
  EMcpToolError = class(Exception)
  private
    FCode: string;
  public
    constructor Create(const ACode, AMessage: string);
    property Code: string read FCode;
  end;

  TMcpToolHandler = reference to function(const Args: TJSONObject): TJSONObject;

  TMcpTool = record
    Name: string;
    Description: string;
    Schema: TJSONObject;   // owned by TMcpServer
    Handler: TMcpToolHandler;
  end;

  TMcpServer = class
  private
    FTransport: TMcpTransport;
    FTools: TList<TMcpTool>;
    function FindTool(const Name: string; out Tool: TMcpTool): Boolean;
    function HandleInitialize(const Params: TJSONObject): TJSONObject;
    function HandleToolsList: TJSONObject;
    function HandleToolsCall(const Params: TJSONObject): TJSONObject;
    procedure SendResult(Id: TJSONValue; Payload: TJSONObject);
    procedure SendError(Id: TJSONValue; Code: Integer; const Msg: string);
    procedure Dispatch(const Request: TJSONObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterTool(const Name, Description: string; Schema: TJSONObject;
      Handler: TMcpToolHandler);
    procedure Run;
  end;

implementation

constructor EMcpToolError.Create(const ACode, AMessage: string);
begin
  inherited Create(AMessage);
  FCode := ACode;
end;

constructor TMcpServer.Create;
begin
  inherited Create;
  FTransport := TMcpTransport.Create;
  FTools := TList<TMcpTool>.Create;
end;

destructor TMcpServer.Destroy;
var
  Tool: TMcpTool;
begin
  for Tool in FTools do
    Tool.Schema.Free;
  FTools.Free;
  FTransport.Free;
  inherited Destroy;
end;

procedure TMcpServer.RegisterTool(const Name, Description: string;
  Schema: TJSONObject; Handler: TMcpToolHandler);
var
  Tool: TMcpTool;
begin
  Tool.Name := Name;
  Tool.Description := Description;
  Tool.Schema := Schema;
  Tool.Handler := Handler;
  FTools.Add(Tool);
end;

function TMcpServer.FindTool(const Name: string; out Tool: TMcpTool): Boolean;
var
  Candidate: TMcpTool;
begin
  for Candidate in FTools do
    if Candidate.Name = Name then
    begin
      Tool := Candidate;
      Exit(True);
    end;
  Result := False;
end;

function TMcpServer.HandleInitialize(const Params: TJSONObject): TJSONObject;
var
  Version: string;
  Caps, Info: TJSONObject;
begin
  Version := PROTOCOL_VERSION;
  if Assigned(Params) then
    Version := Params.GetValue<string>('protocolVersion', PROTOCOL_VERSION);

  Caps := TJSONObject.Create;
  Caps.AddPair('tools', TJSONObject.Create);

  Info := TJSONObject.Create;
  Info.AddPair('name', SERVER_NAME);
  Info.AddPair('version', SERVER_VERSION);

  Result := TJSONObject.Create;
  Result.AddPair('protocolVersion', Version);
  Result.AddPair('capabilities', Caps);
  Result.AddPair('serverInfo', Info);
end;

function TMcpServer.HandleToolsList: TJSONObject;
var
  Arr: TJSONArray;
  Tool: TMcpTool;
  Entry: TJSONObject;
begin
  Arr := TJSONArray.Create;
  for Tool in FTools do
  begin
    Entry := TJSONObject.Create;
    Entry.AddPair('name', Tool.Name);
    Entry.AddPair('description', Tool.Description);
    Entry.AddPair('inputSchema', Tool.Schema.Clone as TJSONObject);
    Arr.AddElement(Entry);
  end;

  Result := TJSONObject.Create;
  Result.AddPair('tools', Arr);
end;

function TMcpServer.HandleToolsCall(const Params: TJSONObject): TJSONObject;
var
  Tool: TMcpTool;
  ToolName: string;
  Args, Payload, ErrObj: TJSONObject;
  Content: TJSONArray;
  Block: TJSONObject;
  IsError: Boolean;
  Text: string;
begin
  if not Assigned(Params) then
    raise EArgumentException.Create('Missing params');

  ToolName := Params.GetValue<string>('name', '');
  if not FindTool(ToolName, Tool) then
    raise EArgumentException.CreateFmt('Unknown tool: %s', [ToolName]);

  Args := Params.GetValue('arguments') as TJSONObject; // may be nil

  IsError := False;
  Payload := nil;
  try
    Payload := Tool.Handler(Args);
    Text := Payload.ToJSON;
  except
    on E: EMcpToolError do
    begin
      IsError := True;
      ErrObj := TJSONObject.Create;
      try
        ErrObj.AddPair('code', E.Code);
        ErrObj.AddPair('message', E.Message);
        Text := ErrObj.ToJSON;
      finally
        ErrObj.Free;
      end;
    end;
  end;
  Payload.Free;

  Block := TJSONObject.Create;
  Block.AddPair('type', 'text');
  Block.AddPair('text', Text);

  Content := TJSONArray.Create;
  Content.AddElement(Block);

  Result := TJSONObject.Create;
  Result.AddPair('content', Content);
  if IsError then
    Result.AddPair('isError', TJSONBool.Create(True));
end;

procedure TMcpServer.SendResult(Id: TJSONValue; Payload: TJSONObject);
var
  Response: TJSONObject;
begin
  Response := TJSONObject.Create;
  try
    Response.AddPair('jsonrpc', '2.0');
    Response.AddPair('id', Id.Clone as TJSONValue);
    Response.AddPair('result', Payload);
    FTransport.WriteMessage(Response.ToJSON);
  finally
    Response.Free;
  end;
end;

procedure TMcpServer.SendError(Id: TJSONValue; Code: Integer; const Msg: string);
var
  Response, ErrObj: TJSONObject;
begin
  ErrObj := TJSONObject.Create;
  ErrObj.AddPair('code', TJSONNumber.Create(Code));
  ErrObj.AddPair('message', Msg);

  Response := TJSONObject.Create;
  try
    Response.AddPair('jsonrpc', '2.0');
    Response.AddPair('id', Id.Clone as TJSONValue);
    Response.AddPair('error', ErrObj);
    FTransport.WriteMessage(Response.ToJSON);
  finally
    Response.Free;
  end;
end;

procedure TMcpServer.Dispatch(const Request: TJSONObject);
var
  Method: string;
  Id: TJSONValue;
  Params: TJSONObject;
begin
  Method := Request.GetValue<string>('method', '');
  Id := Request.GetValue('id'); // nil for notifications
  Params := Request.GetValue('params') as TJSONObject;

  // Notifications never get a response.
  if not Assigned(Id) then
    Exit;

  try
    if Method = 'initialize' then
      SendResult(Id, HandleInitialize(Params))
    else if Method = 'ping' then
      SendResult(Id, TJSONObject.Create)
    else if Method = 'tools/list' then
      SendResult(Id, HandleToolsList)
    else if Method = 'tools/call' then
      SendResult(Id, HandleToolsCall(Params))
    else
      SendError(Id, JSONRPC_METHOD_NOT_FOUND, 'Method not found: ' + Method);
  except
    on E: EArgumentException do
      SendError(Id, JSONRPC_INVALID_PARAMS, E.Message);
    on E: Exception do
      SendError(Id, JSONRPC_INTERNAL_ERROR, E.Message);
  end;
end;

procedure TMcpServer.Run;
var
  Line: string;
  Request: TJSONObject;
begin
  while FTransport.ReadMessage(Line) do
  begin
    if Trim(Line) = '' then
      Continue;

    Request := TJSONObject.ParseJSONValue(Line) as TJSONObject;
    if not Assigned(Request) then
      Continue;
    try
      Dispatch(Request);
    finally
      Request.Free;
    end;
  end;
end;

end.
```

- [ ] **Step 4: Replace the bootstrap loop**

Rewrite the body of `MHLMcpServer.dpr` to use the server:

```pascal
program MHLMcpServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  unit_MCP_Transport in 'unit_MCP_Transport.pas',
  unit_MCP_Protocol in 'unit_MCP_Protocol.pas';

// IMPORTANT: nothing in this project may write to stdout except TMcpTransport.
// A single stray WriteLn corrupts every JSON-RPC response.

var
  Server: TMcpServer;

begin
  Server := TMcpServer.Create;
  try
    Server.Run;
  finally
    Server.Free;
  end;
end.
```

- [ ] **Step 5: Build both platforms**

Run the Win64 build, then Win32. Expected: `Build succeeded` for both.

- [ ] **Step 6: Run tests to verify they pass**

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: `PASS` for 01 through 04, exit 0.

- [ ] **Step 7: Commit**

```bash
git add Utils/MHLMcpServer
git commit -m "+ Add JSON-RPC dispatch and MCP handshake to the MCP server"
```

---

## Task 3: JSON argument helpers

**Files:**
- Create: `Utils/MHLMcpServer/unit_MCP_Json.pas`
- Create: `Utils/MHLMcpServer/tests/cases/05_clamping.jsonl`
- Modify: `Utils/MHLMcpServer/MHLMcpServer.dpr` (register a temporary `echo_args` tool)

**Interfaces:**
- Consumes: `EMcpToolError` from Task 2.
- Produces:
  - `function ArgStr(const Args: TJSONObject; const Name: string; const Default: string = ''): string`
  - `function ArgInt(const Args: TJSONObject; const Name: string; Default: Integer): Integer`
  - `function ArgBool(const Args: TJSONObject; const Name: string; Default: Boolean): Boolean`
  - `function ArgIntClamped(const Args: TJSONObject; const Name: string; Default, Min, Max: Integer; out Clamped: Boolean): Integer`
  - `function RequireInt(const Args: TJSONObject; const Name: string): Integer` — raises `EMcpToolError('invalid_params', …)` when absent

**Why clamping and not rejecting:** an over-large `limit` should still return useful data. The response carries a `clamped` note so the caller learns the real bound instead of silently believing it got everything.

- [ ] **Step 1: Write the failing test**

`tests/cases/05_clamping.jsonl`:

```
> {"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"echo_args","arguments":{"limit":5000}}}
< {"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\"limit\":200,\"clamped\":true}"}]}}
> {"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"echo_args","arguments":{}}}
< {"jsonrpc":"2.0","id":2,"result":{"content":[{"type":"text","text":"{\"limit\":25,\"clamped\":false}"}]}}
```

- [ ] **Step 2: Run the test to verify it fails**

Expected: `FAIL 05_clamping.jsonl` with an `Unknown tool: echo_args` error.

- [ ] **Step 3: Write the helper unit**

Create `Utils/MHLMcpServer/unit_MCP_Json.pas` (**UTF-8 with BOM**):

```pascal
unit unit_MCP_Json;

interface

uses
  System.SysUtils,
  System.JSON,
  unit_MCP_Protocol;

function ArgStr(const Args: TJSONObject; const Name: string; const Default: string = ''): string;
function ArgInt(const Args: TJSONObject; const Name: string; Default: Integer): Integer;
function ArgBool(const Args: TJSONObject; const Name: string; Default: Boolean): Boolean;
function ArgIntClamped(const Args: TJSONObject; const Name: string;
  Default, Min, Max: Integer; out Clamped: Boolean): Integer;
function RequireInt(const Args: TJSONObject; const Name: string): Integer;

implementation

function ArgStr(const Args: TJSONObject; const Name: string; const Default: string): string;
begin
  if not Assigned(Args) then
    Exit(Default);
  Result := Args.GetValue<string>(Name, Default);
end;

function ArgInt(const Args: TJSONObject; const Name: string; Default: Integer): Integer;
begin
  if not Assigned(Args) then
    Exit(Default);
  Result := Args.GetValue<Integer>(Name, Default);
end;

function ArgBool(const Args: TJSONObject; const Name: string; Default: Boolean): Boolean;
begin
  if not Assigned(Args) then
    Exit(Default);
  Result := Args.GetValue<Boolean>(Name, Default);
end;

function ArgIntClamped(const Args: TJSONObject; const Name: string;
  Default, Min, Max: Integer; out Clamped: Boolean): Integer;
begin
  Result := ArgInt(Args, Name, Default);
  Clamped := False;

  if Result < Min then
  begin
    Result := Min;
    Clamped := True;
  end
  else if Result > Max then
  begin
    Result := Max;
    Clamped := True;
  end;
end;

function RequireInt(const Args: TJSONObject; const Name: string): Integer;
begin
  if (not Assigned(Args)) or (Args.GetValue(Name) = nil) then
    raise EMcpToolError.Create('invalid_params',
      Format('Missing required argument: %s', [Name]));
  Result := Args.GetValue<Integer>(Name);
end;

end.
```

- [ ] **Step 4: Register the temporary `echo_args` tool**

In `MHLMcpServer.dpr`, before `Server.Run`, add `System.JSON`, `unit_MCP_Json` to uses and register:

```pascal
  Server.RegisterTool('echo_args', 'Test helper', TJSONObject.Create,
    function(const Args: TJSONObject): TJSONObject
    var
      Limit: Integer;
      Clamped: Boolean;
    begin
      Limit := ArgIntClamped(Args, 'limit', 25, 1, 200, Clamped);
      Result := TJSONObject.Create;
      Result.AddPair('limit', TJSONNumber.Create(Limit));
      Result.AddPair('clamped', TJSONBool.Create(Clamped));
    end);
```

This tool is removed in Task 10.

- [ ] **Step 5: Build both platforms**

Expected: `Build succeeded` for Win64 and Win32.

- [ ] **Step 6: Run tests to verify they pass**

Expected: `PASS` for 01 through 05.

- [ ] **Step 7: Commit**

```bash
git add Utils/MHLMcpServer
git commit -m "+ Add JSON argument helpers with clamping to the MCP server"
```

---

## Task 4: DMUser bootstrap and `list_collections`

**Files:**
- Create: `Utils/MHLMcpServer/unit_MCP_Tools_Library.pas`
- Modify: `Utils/MHLMcpServer/MHLMcpServer.dpr`
- Modify: `Utils/MHLMcpServer/README.md` (create)

**Interfaces:**
- Consumes: `TMcpServer.RegisterTool`, `EMcpToolError`, the arg helpers.
- Produces:
  - `procedure RegisterLibraryTools(Server: TMcpServer)`
  - `function CollectionOrFail(const CollectionID: Integer): IBookCollection` — raises `EMcpToolError('collection_not_found', …)`

**Why `DMUser` and not a bare DAO:** `TBookRecord.GetBookStream` reads `Settings.ReadPath` and `Settings.IgnoreAbsentArchives`, and `TBookCollection_SQLite` needs an `ISystemData`. Booting `DMUser` is what makes the whole DAO usable, and it is what guarantees the server sees the same collections as the app.

This task has **no automated test** — it needs a real system database. Verification is the manual checklist in Step 6.

- [ ] **Step 1: Write the library tools unit**

Create `Utils/MHLMcpServer/unit_MCP_Tools_Library.pas` (**UTF-8 with BOM**):

```pascal
unit unit_MCP_Tools_Library;

interface

uses
  System.SysUtils,
  System.JSON,
  unit_Globals,
  unit_Interfaces,
  unit_MCP_Protocol;

procedure RegisterLibraryTools(Server: TMcpServer);
function CollectionOrFail(const CollectionID: Integer): IBookCollection;
function Guarded(Handler: TMcpToolHandler): TMcpToolHandler;

implementation

uses
  dm_user,
  SQLiteWrap,
  unit_MCP_Json;

// Wraps a handler so SQLite lock contention becomes a domain error instead of
// an opaque internal one. SQLiteWrap exposes no read-only or busy-timeout open
// mode, so a write by the running app surfaces here as "database is locked".
function Guarded(Handler: TMcpToolHandler): TMcpToolHandler;
begin
  Result :=
    function(const Args: TJSONObject): TJSONObject
    begin
      try
        Result := Handler(Args);
      except
        on E: ESQLiteException do
        begin
          if E.Message.ToLower.Contains('locked') or
             E.Message.ToLower.Contains('busy') then
            raise EMcpToolError.Create('collection_busy',
              'Колекція зайнята — можливо, MyHomeLib саме імпортує книги.');
          raise;
        end;
      end;
    end;
end;

function CollectionOrFail(const CollectionID: Integer): IBookCollection;
begin
  try
    Result := SystemDB.GetCollection(CollectionID);
  except
    on E: Exception do
      raise EMcpToolError.Create('collection_not_found',
        Format('Collection %d not found: %s', [CollectionID, E.Message]));
  end;

  if not Assigned(Result) then
    raise EMcpToolError.Create('collection_not_found',
      Format('Collection %d not found', [CollectionID]));
end;

function ListCollections(const Args: TJSONObject): TJSONObject;
var
  Iterator: ICollectionInfoIterator;
  Info: TCollectionInfo;
  Arr: TJSONArray;
  Entry: TJSONObject;
begin
  Arr := TJSONArray.Create;

  Iterator := SystemDB.GetCollectionInfoIterator;
  while Iterator.Next(Info) do
  begin
    Entry := TJSONObject.Create;
    Entry.AddPair('id', TJSONNumber.Create(Info.ID));
    Entry.AddPair('name', Info.DisplayName);
    Entry.AddPair('root_folder', Info.RootFolder);
    Entry.AddPair('type', TJSONNumber.Create(Info.CollectionType));
    Entry.AddPair('notes', Info.Notes);
    Arr.AddElement(Entry);
  end;

  Result := TJSONObject.Create;
  Result.AddPair('collections', Arr);
end;

procedure RegisterLibraryTools(Server: TMcpServer);
begin
  Server.RegisterTool(
    'list_collections',
    'Список усіх зареєстрованих колекцій MyHomeLib.',
    TJSONObject.ParseJSONValue('{"type":"object","properties":{}}') as TJSONObject,
    Guarded(ListCollections));
end;

end.
```

**Every** tool registration from here on — Tasks 5, 6, 7 and 10 included — wraps its
handler in `Guarded(…)`. That is the only path by which `collection_busy` can be
produced.

- [ ] **Step 2: Boot DMUser in the bootstrap**

Rewrite `MHLMcpServer.dpr`:

```pascal
program MHLMcpServer;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  System.SysUtils,
  System.JSON,
  dm_user in '..\..\Program\DataModules\dm_user.pas' {DMUser: TDataModule},
  unit_MCP_Transport in 'unit_MCP_Transport.pas',
  unit_MCP_Protocol in 'unit_MCP_Protocol.pas',
  unit_MCP_Json in 'unit_MCP_Json.pas',
  unit_MCP_Tools_Library in 'unit_MCP_Tools_Library.pas';

// IMPORTANT: nothing in this project may write to stdout except TMcpTransport.
// A single stray WriteLn corrupts every JSON-RPC response.
//
// This process links the VCL because the DAO layer does, but it creates no
// forms and runs no message loop.

var
  Server: TMcpServer;

begin
  Application.Initialize;

  DMUser := TDMUser.Create(nil);
  try
    DMUser.Init;

    Server := TMcpServer.Create;
    try
      RegisterLibraryTools(Server);
      Server.Run;
    finally
      Server.Free;
    end;
  finally
    DMUser.Free;
  end;
end.
```

Note: unlike `MyHomeLib.dpr`, this must **not** call `FirstHinstanceRunning` — several server instances may run alongside the app.

- [ ] **Step 3: Build both platforms**

Expected: `Build succeeded` for Win64 and Win32.

Likely failure: missing units on the search path. Fix by extending the dproj search path from the Task 1 list rather than by copying units.

- [ ] **Step 4: Run the protocol tests**

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: still `PASS` for 01 through 05. If the server now emits startup noise on stdout, the tests catch it here — that is the stdout-discipline check.

- [ ] **Step 5: Write the README with the manual checklist**

Create `Utils/MHLMcpServer/README.md` containing the `.mcp.json` snippet:

```json
{
  "mcpServers": {
    "myhomelib": {
      "command": "D:\\DelphiProjects\\MyHomeLib\\Program\\OUT\\Bin64\\MHLMcpServer.exe",
      "args": []
    }
  }
}
```

and a manual checklist section, starting with:

- `list_collections` returns every collection visible in the app's collection list, with matching names and root folders.

- [ ] **Step 6: Verify manually**

```
echo {"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"list_collections","arguments":{}}} | Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: one JSON line listing your real collections. Compare against the app's collection list.

- [ ] **Step 7: Commit**

```bash
git add Utils/MHLMcpServer
git commit -m "+ Add DMUser bootstrap and list_collections to the MCP server"
```

---

## Task 5: `get_book` and record marshalling

**Files:**
- Modify: `Utils/MHLMcpServer/unit_MCP_Tools_Library.pas`
- Modify: `Utils/MHLMcpServer/README.md`

**Interfaces:**
- Consumes: `CollectionOrFail` from Task 4.
- Produces:
  - `function BookToJson(const Book: TBookRecord; Full: Boolean): TJSONObject` — `Full=False` yields the search-result summary, `Full=True` adds annotation, review, keywords, rate, progress, folder, file name and flags. Used by Task 6.
  - `function AuthorsToJson(const Authors: TBookAuthors): TJSONArray`
  - `function GenresToJson(const Genres: TBookGenres): TJSONArray`

**Field mapping** (from `TBookRecord` in `unit_Globals.pas`): `BookKey.BookID` → `book_id`, `Title`, `Series`, `SeqNumber`, `Lang`, `Size`, `FileExt` → `ext`, `LibRate` → `lib_rate`, `Rate`, `Progress`, `KeyWords` → `keywords`, `Folder`, `FileName` → `file_name`, `Annotation`, `Review`. Flags come from the `BookProps` set: `bpIsLocal` → `is_local`, `bpIsDeleted` → `is_deleted`, `bpHasReview` → `has_review`.

`has_text` is `Book.GetBookFormat in [bfFb2, bfFb2Archive]`.

- [ ] **Step 1: Write the marshalling functions**

Add to the implementation of `unit_MCP_Tools_Library.pas`:

```pascal
function AuthorsToJson(const Authors: TBookAuthors): TJSONArray;
var
  I: Integer;
  Entry: TJSONObject;
begin
  Result := TJSONArray.Create;
  for I := 0 to High(Authors) do
  begin
    Entry := TJSONObject.Create;
    Entry.AddPair('author_id', TJSONNumber.Create(Authors[I].AuthorID));
    Entry.AddPair('last_name', Authors[I].LastName);
    Entry.AddPair('first_name', Authors[I].FirstName);
    Entry.AddPair('middle_name', Authors[I].MiddleName);
    Entry.AddPair('full_name', Authors[I].GetFullName);
    Result.AddElement(Entry);
  end;
end;

function GenresToJson(const Genres: TBookGenres): TJSONArray;
var
  I: Integer;
  Entry: TJSONObject;
begin
  Result := TJSONArray.Create;
  for I := 0 to High(Genres) do
  begin
    Entry := TJSONObject.Create;
    Entry.AddPair('code', Genres[I].GenreCode);
    Entry.AddPair('alias', Genres[I].GenreAlias);
    Result.AddElement(Entry);
  end;
end;

function BookToJson(const Book: TBookRecord; Full: Boolean): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('book_id', TJSONNumber.Create(Book.BookKey.BookID));
  Result.AddPair('title', Book.Title);
  Result.AddPair('authors', AuthorsToJson(Book.Authors));
  Result.AddPair('genres', GenresToJson(Book.Genres));
  Result.AddPair('series', Book.Series);
  Result.AddPair('seq_number', TJSONNumber.Create(Book.SeqNumber));
  Result.AddPair('lang', Book.Lang);
  Result.AddPair('ext', Book.FileExt);
  Result.AddPair('size', TJSONNumber.Create(Book.Size));
  Result.AddPair('has_text',
    TJSONBool.Create(Book.GetBookFormat in [bfFb2, bfFb2Archive]));

  if Full then
  begin
    Result.AddPair('lib_rate', TJSONNumber.Create(Book.LibRate));
    Result.AddPair('rate', TJSONNumber.Create(Book.Rate));
    Result.AddPair('progress', TJSONNumber.Create(Book.Progress));
    Result.AddPair('keywords', Book.KeyWords);
    Result.AddPair('folder', Book.Folder);
    Result.AddPair('file_name', Book.FileName);
    Result.AddPair('annotation', Book.Annotation);
    Result.AddPair('review', Book.Review);
    Result.AddPair('is_local', TJSONBool.Create(bpIsLocal in Book.BookProps));
    Result.AddPair('is_deleted', TJSONBool.Create(bpIsDeleted in Book.BookProps));
    Result.AddPair('has_review', TJSONBool.Create(bpHasReview in Book.BookProps));
  end;
end;
```

Declare `BookToJson`, `AuthorsToJson` and `GenresToJson` in the unit's `interface` section so Task 6 and Task 9 can use them.

- [ ] **Step 2: Write the `get_book` handler**

```pascal
function GetBook(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  BookKey: TBookKey;
  Book: TBookRecord;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));

  BookKey.BookID := RequireInt(Args, 'book_id');
  BookKey.DatabaseID := RequireInt(Args, 'collection_id');

  try
    Collection.GetBookRecord(BookKey, Book, True);
  except
    on E: Exception do
      raise EMcpToolError.Create('book_not_found',
        Format('Book %d not found: %s', [BookKey.BookID, E.Message]));
  end;

  Result := BookToJson(Book, True);
end;
```

- [ ] **Step 3: Register the tool**

Add to `RegisterLibraryTools`:

```pascal
  Server.RegisterTool(
    'get_book',
    'Повні відомості про книгу за її ідентифікатором.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer","description":"ID колекції"},' +
      '"book_id":{"type":"integer","description":"ID книги"}},' +
      '"required":["collection_id","book_id"]}') as TJSONObject,
    Guarded(GetBook));
```

- [ ] **Step 4: Build both platforms**

Expected: `Build succeeded` for Win64 and Win32.

- [ ] **Step 5: Verify manually and extend the checklist**

Pick a real book id from your library and call `get_book`. Expected: title, authors and annotation match what the app shows for that book.

Add to the README checklist:

- `get_book` returns a book whose title, authors, series and annotation match the app's book details pane.

- [ ] **Step 6: Commit**

```bash
git add Utils/MHLMcpServer
git commit -m "+ Add get_book and record marshalling to the MCP server"
```

---

## Task 6: `search_books`

**Files:**
- Modify: `Utils/MHLMcpServer/unit_MCP_Tools_Library.pas`
- Modify: `Utils/MHLMcpServer/README.md`

**Interfaces:**
- Consumes: `CollectionOrFail`, `BookToJson` from Task 5.
- Produces: nothing consumed by later tasks.

**Mapping.** `IBookCollection.Search(SearchCriteria: TBookSearchCriteria; LoadMemos: Boolean): IBookIterator`. Argument → field: `title`→`Title`, `author`→`FullName`, `series`→`Series`, `genre`→`Genre`, `lang`→`Lang`, `keyword`→`KeyWord`, `annotation`→`Annotation`, `min_lib_rate`→`LibRate` (as a string), `include_deleted`→`Deleted`.

Call `Criteria := Default(TBookSearchCriteria)` first — the record has string and Boolean fields that must start empty, and a stack-garbage `Deleted` would silently change results.

Paging uses `IIterator<T>.Next` plus `RecordCount`: skip `offset` records, take `limit`.

- [ ] **Step 1: Write the handler**

```pascal
function SearchBooks(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  Criteria: TBookSearchCriteria;
  Iterator: IBookIterator;
  Book: TBookRecord;
  Arr: TJSONArray;
  Limit, Offset, Skipped, Taken, MinRate: Integer;
  Clamped, ClampedAny: Boolean;
  Total: Integer;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));

  Criteria := Default(TBookSearchCriteria);
  Criteria.Title      := ArgStr(Args, 'title');
  Criteria.FullName   := ArgStr(Args, 'author');
  Criteria.Series     := ArgStr(Args, 'series');
  Criteria.Genre      := ArgStr(Args, 'genre');
  Criteria.Lang       := ArgStr(Args, 'lang');
  Criteria.KeyWord    := ArgStr(Args, 'keyword');
  Criteria.Annotation := ArgStr(Args, 'annotation');
  Criteria.Deleted    := ArgBool(Args, 'include_deleted', False);

  MinRate := ArgInt(Args, 'min_lib_rate', 0);
  if MinRate > 0 then
    Criteria.LibRate := IntToStr(MinRate);

  Limit := ArgIntClamped(Args, 'limit', 25, 1, 200, ClampedAny);
  Offset := ArgIntClamped(Args, 'offset', 0, 0, MaxInt, Clamped);
  ClampedAny := ClampedAny or Clamped;

  Iterator := Collection.Search(Criteria, False);
  Total := Iterator.RecordCount;

  Arr := TJSONArray.Create;
  Skipped := 0;
  Taken := 0;
  while Iterator.Next(Book) do
  begin
    if Skipped < Offset then
    begin
      Inc(Skipped);
      Continue;
    end;

    if Taken >= Limit then
      Break;

    Arr.AddElement(BookToJson(Book, False));
    Inc(Taken);
  end;

  Result := TJSONObject.Create;
  Result.AddPair('books', Arr);
  Result.AddPair('total_count', TJSONNumber.Create(Total));
  Result.AddPair('has_more', TJSONBool.Create(Offset + Taken < Total));
  if ClampedAny then
    Result.AddPair('clamped', TJSONBool.Create(True));
end;
```

- [ ] **Step 2: Register the tool**

```pascal
  Server.RegisterTool(
    'search_books',
    'Пошук книг у колекції за назвою, автором, серією, жанром чи мовою.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer","description":"ID колекції"},' +
      '"title":{"type":"string"},' +
      '"author":{"type":"string","description":"Повне або часткове ім''я автора"},' +
      '"series":{"type":"string"},' +
      '"genre":{"type":"string","description":"Код жанру зі списку list_genres"},' +
      '"lang":{"type":"string"},' +
      '"keyword":{"type":"string"},' +
      '"annotation":{"type":"string"},' +
      '"min_lib_rate":{"type":"integer"},' +
      '"include_deleted":{"type":"boolean"},' +
      '"limit":{"type":"integer","description":"Типово 25, максимум 200"},' +
      '"offset":{"type":"integer"}},' +
      '"required":["collection_id"]}') as TJSONObject,
    Guarded(SearchBooks));
```

Note the doubled apostrophe in `ім''я` — a Pascal string literal escape, not a typo.

- [ ] **Step 3: Build both platforms**

Expected: `Build succeeded` for Win64 and Win32.

- [ ] **Step 4: Verify manually and extend the checklist**

Search by an author you know has several books. Expected: the same set the app shows when filtering by that author.

Add to the README checklist:

- `search_books(author=…)` returns the same books as the app's author filter.
- `search_books(limit=5000)` returns 200 books and `"clamped":true`.
- `search_books(offset=…)` pages without repeating or skipping books.

- [ ] **Step 5: Commit**

```bash
git add Utils/MHLMcpServer
git commit -m "+ Add search_books to the MCP server"
```

---

## Task 7: `list_genres`, `list_series`, `list_authors`

**Files:**
- Modify: `Utils/MHLMcpServer/unit_MCP_Tools_Library.pas`
- Modify: `Utils/MHLMcpServer/README.md`

**Interfaces:**
- Consumes: `CollectionOrFail`.
- Produces: nothing consumed by later tasks.

**Iterators:** `GetGenreIterator(gmAll, nil)` yields `TGenreData` (`GenreCode`, `ParentCode`, `FB2GenreCode`, `GenreAlias`); `GetSeriesIterator(smAll)` yields `TSeriesData` (`SeriesID`, `SeriesTitle`); `GetAuthorIterator(amAll, nil)` yields `TAuthorData`.

`list_genres` returns the whole tree unpaged — genre lists are small and fixed, and Claude needs the full code set to build `search_books(genre=…)` calls.

`filter` on series and authors is a case-insensitive substring match applied in Delphi over the iterator, since the iterator modes do not take a free-text filter.

- [ ] **Step 1: Write the three handlers**

```pascal
function ListGenres(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  Iterator: IGenreIterator;
  Genre: TGenreData;
  Arr: TJSONArray;
  Entry: TJSONObject;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));

  Arr := TJSONArray.Create;
  Iterator := Collection.GetGenreIterator(gmAll, nil);
  while Iterator.Next(Genre) do
  begin
    Entry := TJSONObject.Create;
    Entry.AddPair('code', Genre.GenreCode);
    Entry.AddPair('parent_code', Genre.ParentCode);
    Entry.AddPair('alias', Genre.GenreAlias);
    Arr.AddElement(Entry);
  end;

  Result := TJSONObject.Create;
  Result.AddPair('genres', Arr);
end;

function ListSeries(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  Iterator: ISeriesIterator;
  Series: TSeriesData;
  Arr: TJSONArray;
  Entry: TJSONObject;
  Filter: string;
  Limit, Taken: Integer;
  Clamped: Boolean;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));
  Filter := ArgStr(Args, 'filter').ToLower;
  Limit := ArgIntClamped(Args, 'limit', 100, 1, 500, Clamped);

  Arr := TJSONArray.Create;
  Taken := 0;
  Iterator := Collection.GetSeriesIterator(smAll);
  while Iterator.Next(Series) and (Taken < Limit) do
  begin
    if (Filter <> '') and (not Series.SeriesTitle.ToLower.Contains(Filter)) then
      Continue;

    Entry := TJSONObject.Create;
    Entry.AddPair('series_id', TJSONNumber.Create(Series.SeriesID));
    Entry.AddPair('title', Series.SeriesTitle);
    Arr.AddElement(Entry);
    Inc(Taken);
  end;

  Result := TJSONObject.Create;
  Result.AddPair('series', Arr);
  if Clamped then
    Result.AddPair('clamped', TJSONBool.Create(True));
end;

function ListAuthors(const Args: TJSONObject): TJSONObject;
var
  Collection: IBookCollection;
  Iterator: IAuthorIterator;
  Author: TAuthorData;
  Arr: TJSONArray;
  Entry: TJSONObject;
  Filter: string;
  Limit, Taken: Integer;
  Clamped: Boolean;
begin
  Collection := CollectionOrFail(RequireInt(Args, 'collection_id'));
  Filter := ArgStr(Args, 'filter').ToLower;
  Limit := ArgIntClamped(Args, 'limit', 100, 1, 500, Clamped);

  Arr := TJSONArray.Create;
  Taken := 0;
  Iterator := Collection.GetAuthorIterator(amAll, nil);
  while Iterator.Next(Author) and (Taken < Limit) do
  begin
    if (Filter <> '') and (not Author.GetFullName.ToLower.Contains(Filter)) then
      Continue;

    Entry := TJSONObject.Create;
    Entry.AddPair('author_id', TJSONNumber.Create(Author.AuthorID));
    Entry.AddPair('full_name', Author.GetFullName);
    Entry.AddPair('last_name', Author.LastName);
    Arr.AddElement(Entry);
    Inc(Taken);
  end;

  Result := TJSONObject.Create;
  Result.AddPair('authors', Arr);
  if Clamped then
    Result.AddPair('clamped', TJSONBool.Create(True));
end;
```

- [ ] **Step 2: Register all three tools**

```pascal
  Server.RegisterTool(
    'list_genres',
    'Дерево жанрів колекції. Коди жанрів потрібні для search_books.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"}},' +
      '"required":["collection_id"]}') as TJSONObject,
    Guarded(ListGenres));

  Server.RegisterTool(
    'list_series',
    'Перелік серій у колекції.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"filter":{"type":"string","description":"Підрядок назви серії"},' +
      '"limit":{"type":"integer","description":"Типово 100, максимум 500"}},' +
      '"required":["collection_id"]}') as TJSONObject,
    Guarded(ListSeries));

  Server.RegisterTool(
    'list_authors',
    'Перелік авторів у колекції.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"filter":{"type":"string","description":"Підрядок імені автора"},' +
      '"limit":{"type":"integer","description":"Типово 100, максимум 500"}},' +
      '"required":["collection_id"]}') as TJSONObject,
    Guarded(ListAuthors));
```

- [ ] **Step 3: Build both platforms**

Expected: `Build succeeded` for Win64 and Win32.

- [ ] **Step 4: Verify manually and extend the checklist**

Add to the README checklist:

- `list_genres` returns the same genre tree the app's genre panel shows.
- A genre code from `list_genres` used in `search_books(genre=…)` returns books of that genre.
- `list_series(filter=…)` finds a series you know exists.

- [ ] **Step 5: Commit**

```bash
git add Utils/MHLMcpServer
git commit -m "+ Add list_genres, list_series and list_authors to the MCP server"
```

---

## Task 8: FB2 extractor

**Files:**
- Create: `Utils/MHLMcpServer/unit_MCP_Fb2Extract.pas`
- Create: `Utils/MHLMcpServer/tests/fixtures/structured.fb2`
- Create: `Utils/MHLMcpServer/tests/fixtures/flat.fb2`
- Create: `Utils/MHLMcpServer/tests/fixtures/broken.fb2`
- Create: `Utils/MHLMcpServer/tests/extract_tests.js`
- Modify: `Utils/MHLMcpServer/MHLMcpServer.dpr` (add `--extract` mode)

**Interfaces:**
- Consumes: nothing from earlier tasks.
- Produces:
  - `TFb2Section = record Title: string; Level: Integer; Offset: Integer; Length: Integer; end;`
  - `TFb2Sections = array of TFb2Section;`
  - `TFb2Extraction = record Text: string; Sections: TFb2Sections; Structured: Boolean; end;`
  - `function ExtractFb2(Stream: TStream): TFb2Extraction` — raises `EFb2ExtractError` when both the DOM walk and the fallback fail.
  - `EFb2ExtractError = class(Exception)`

**The core constraint.** Text and section offsets must come from the **same** pass. Producing the TOC from a DOM and the text from a separate tag-stripper yields offsets in two different character spaces, so a TOC offset handed to `get_book_text` lands in the wrong place. `ExtractFb2` therefore walks the DOM once, appending to a `TStringBuilder` and recording each section's start and end as it descends.

**Parser choice.** Use generic `Xml.XMLDoc`/`Xml.XMLIntf` node walking, **not** the `fictionbook_21` schema binding. The binding is generated from the FB2 schema and rejects the malformed files that are common in real libraries; a generic walk tolerates them.

**Fallback.** When `LoadFromStream` raises, strip tags with a regex-free scanner and return `Structured := False` with an empty `Sections` array. Text always works; structure is best-effort.

**Testability.** `ExtractFb2` touches no database, so `--extract <path>` exposes it to automated tests over fixture files. This is the one data-level path with real automated coverage.

- [ ] **Step 1: Write the fixtures**

`tests/fixtures/structured.fb2` — two titled sections, UTF-8:

```xml
<?xml version="1.0" encoding="utf-8"?>
<FictionBook xmlns="http://www.gribuser.ru/xml/fictionbook/2.0">
 <description><title-info><book-title>Structured</book-title></title-info></description>
 <body>
  <section><title><p>Chapter One</p></title><p>Alpha text.</p></section>
  <section><title><p>Chapter Two</p></title><p>Beta text.</p></section>
 </body>
</FictionBook>
```

`tests/fixtures/flat.fb2` — one untitled section, **encoded windows-1251** with Cyrillic body text, to prove encoding comes from the prolog:

```xml
<?xml version="1.0" encoding="windows-1251"?>
<FictionBook xmlns="http://www.gribuser.ru/xml/fictionbook/2.0">
 <description><title-info><book-title>Flat</book-title></title-info></description>
 <body><section><p>Текст без заголовків.</p></section></body>
</FictionBook>
```

`tests/fixtures/broken.fb2` — unclosed tag, forcing the fallback:

```xml
<?xml version="1.0" encoding="utf-8"?>
<FictionBook>
 <body><section><p>Salvageable text.</p></section>
</FictionBook>
```

- [ ] **Step 2: Write the failing test**

Create `tests/extract_tests.js`:

```js
const { spawnSync } = require('child_process');
const path = require('path');

const exe = process.argv[2];
const fx = f => path.join(__dirname, 'fixtures', f);

function extract(file) {
  const run = spawnSync(exe, ['--extract', fx(file)], { encoding: 'utf8' });
  if (run.status !== 0) throw new Error(`exit ${run.status}: ${run.stderr}`);
  return JSON.parse(run.stdout);
}

const checks = [
  ['structured: two sections', () => {
    const r = extract('structured.fb2');
    return r.structured === true
      && r.sections.length === 2
      && r.sections[0].title === 'Chapter One'
      && r.sections[1].title === 'Chapter Two';
  }],
  ['structured: offsets land on their section text', () => {
    const r = extract('structured.fb2');
    const s = r.sections[1];
    return r.text.substr(s.offset, s.length).includes('Beta text.');
  }],
  ['flat: text extracted, no sections claimed', () => {
    const r = extract('flat.fb2');
    return r.text.includes('Текст без заголовків') && r.sections.length <= 1;
  }],
  ['broken: falls back to text, structured=false', () => {
    const r = extract('broken.fb2');
    return r.structured === false && r.text.includes('Salvageable text.');
  }],
];

let failed = 0;
for (const [name, fn] of checks) {
  let ok = false, err = '';
  try { ok = fn(); } catch (e) { err = e.message; }
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${err ? ' — ' + err : ''}`);
  if (!ok) failed++;
}
process.exit(failed ? 1 : 0);
```

- [ ] **Step 3: Run the test to verify it fails**

```
node Utils/MHLMcpServer/tests/extract_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: all four `FAIL` (the `--extract` argument is ignored, so stdout is empty and `JSON.parse` throws).

- [ ] **Step 4: Write the extractor**

Create `Utils/MHLMcpServer/unit_MCP_Fb2Extract.pas` (**UTF-8 with BOM**). The walk:

```pascal
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

function ExtractFb2(Stream: TStream): TFb2Extraction;

implementation

uses
  System.Variants,
  Xml.XMLIntf,
  Xml.XMLDoc,
  Xml.xmldom;

type
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

// Flatten a node's descendant text without recording sections.
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
    SectionIndex := Length(FSections);
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
  if Length(Bytes) > 0 then
    Stream.ReadBuffer(Bytes[0], Length(Bytes));

  Encoding := nil;
  Preamble := TEncoding.GetBufferEncoding(Bytes, Encoding, TEncoding.UTF8);
  Raw := Encoding.GetString(Bytes, Preamble, Length(Bytes) - Preamble);

  // Honour an explicit prolog encoding when it is not UTF-8.
  if Raw.ToLower.Contains('encoding="windows-1251"') then
  begin
    Encoding := TEncoding.GetEncoding(1251);
    try
      Raw := Encoding.GetString(Bytes);
    finally
      TEncoding.FreeEncoding(Encoding);
    end;
  end;

  SB := TStringBuilder.Create;
  try
    Depth := 0;
    InDescription := False;
    I := 1;
    while I <= Length(Raw) do
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
```

- [ ] **Step 5: Add the `--extract` CLI mode**

In `MHLMcpServer.dpr`, before creating `DMUser`, add:

```pascal
  if (ParamCount = 2) and (ParamStr(1) = '--extract') then
  begin
    RunExtractMode(ParamStr(2));
    Exit;
  end;
```

and implement `RunExtractMode` in the `.dpr`, writing through a transport instance so stdout discipline holds:

```pascal
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
    for I := 0 to High(Extraction.Sections) do
    begin
      Entry := TJSONObject.Create;
      Entry.AddPair('title', Extraction.Sections[I].Title);
      Entry.AddPair('level', TJSONNumber.Create(Extraction.Sections[I].Level));
      Entry.AddPair('offset', TJSONNumber.Create(Extraction.Sections[I].Offset));
      Entry.AddPair('length', TJSONNumber.Create(Extraction.Sections[I].Length));
      Arr.AddElement(Entry);
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
```

`--extract` needs no `DMUser`, so it must run before the bootstrap.

- [ ] **Step 6: Build both platforms**

Expected: `Build succeeded` for Win64 and Win32.

- [ ] **Step 7: Run the extractor tests to verify they pass**

```
node Utils/MHLMcpServer/tests/extract_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: four `PASS`, exit 0.

If `structured.fb2` offsets are off, the bug is almost certainly section `Length` being recorded before the title text is appended — check the ordering in `WalkNode`.

- [ ] **Step 8: Re-run the protocol tests**

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: still `PASS` for 01 through 05.

- [ ] **Step 9: Commit**

```bash
git add Utils/MHLMcpServer
git commit -m "+ Add FB2 text and section extractor to the MCP server"
```

---

## Task 9: Text cache

**Files:**
- Create: `Utils/MHLMcpServer/unit_MCP_TextCache.pas`

**Interfaces:**
- Consumes: `TFb2Extraction`, `ExtractFb2` from Task 8.
- Produces:
  - `TCachedBook = record TotalLength: Integer; Sections: TFb2Sections; Structured: Boolean; end;`
  - `function EnsureCached(const CollectionID, BookID: Integer; const SourceSize: Int64; const SourceStamp: TDateTime; ExtractProc: TFunc<TFb2Extraction>): TCachedBook`
  - `function ReadCachedSlice(const CollectionID, BookID: Integer; const SourceSize: Int64; const SourceStamp: TDateTime; Offset, Count: Integer): string`

`search_in_book` reads the whole text with `ReadCachedSlice(…, 0, Cached.TotalLength)` and scans in memory — no separate cache-search entry point.

**Why UTF-16LE on disk:** Delphi strings are UTF-16, and offsets are UTF-16 code-unit indices, so a slice is `Seek(Offset * 2)` plus a read of `Count * 2` bytes — no scan. Storing UTF-8 would force a full scan per call to convert a character index to a byte index.

**Key:** `Format('%d_%d_%d_%s', [CollectionID, BookID, SourceSize, FormatDateTime('yyyymmddhhnnss', SourceStamp)])`, so a re-imported or edited book misses the cache and re-extracts.

**Layout:** `%LOCALAPPDATA%\MyHomeLib\McpCache\<key>.txt` (UTF-16LE, no BOM) and `<key>.json` (`total_length`, `structured`, `sections`).

**Surrogate safety:** before returning a slice, if the first unit is a low surrogate advance by one, and if the last is a high surrogate drop it. A split surrogate produces invalid UTF-8 on the way out and can break the client's JSON parse.

**Eviction:** at startup, if the directory exceeds 200 MB, delete `.txt`/`.json` pairs oldest-last-access-first until under the cap.

- [ ] **Step 1: Write the cache unit**

Create `Utils/MHLMcpServer/unit_MCP_TextCache.pas` (**UTF-8 with BOM**) implementing the interface above:

```pascal
unit unit_MCP_TextCache;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.IOUtils,
  unit_MCP_Fb2Extract;

type
  TCachedBook = record
    TotalLength: Integer;
    Sections: TFb2Sections;
    Structured: Boolean;
  end;

const
  CACHE_CAP_BYTES = 200 * 1024 * 1024;

function CacheDir: string;
procedure EvictCache;
function EnsureCached(const CollectionID, BookID: Integer;
  const SourceSize: Int64; const SourceStamp: TDateTime;
  ExtractProc: TFunc<TFb2Extraction>): TCachedBook;
function ReadCachedSlice(const CollectionID, BookID: Integer;
  const SourceSize: Int64; const SourceStamp: TDateTime;
  Offset, Count: Integer): string;

implementation
```

Implement:

- `CacheDir` → `TPath.Combine(TPath.GetHomePath, 'MyHomeLib\McpCache')`, created on demand.
- `CacheKey(CollectionID, BookID, SourceSize, SourceStamp)` → the format above.
- `EnsureCached`: if both `<key>.txt` and `<key>.json` exist, read the sidecar and return. Otherwise call `ExtractProc`, write the text as UTF-16LE bytes via `TFile.WriteAllBytes(Path, TEncoding.Unicode.GetBytes(Text))`, write the sidecar, then return.
- `ReadCachedSlice`: open `<key>.txt` as `TFileStream`, `Seek(Offset * SizeOf(Char), soBeginning)`, read `Count * SizeOf(Char)` bytes (clamped to the file length), decode with `TEncoding.Unicode`, then apply the surrogate trim described above.
- `EvictCache`: enumerate the directory, sum sizes, and if over `CACHE_CAP_BYTES` delete pairs by ascending `TFile.GetLastAccessTime` until under it.

- [ ] **Step 2: Call `EvictCache` at startup**

In `MHLMcpServer.dpr`, after `DMUser.Init`, add `EvictCache;`.

- [ ] **Step 3: Build both platforms**

Expected: `Build succeeded` for Win64 and Win32.

- [ ] **Step 4: Run both test suites**

Expected: all existing cases still `PASS`. The cache has no protocol surface yet; this step guards against regressions.

- [ ] **Step 5: Verify the cache directory manually**

After Task 10's first `get_book_text` call, confirm `%LOCALAPPDATA%\MyHomeLib\McpCache` contains a `.txt`/`.json` pair, and that a second call to the same book does not rewrite them (compare file timestamps).

- [ ] **Step 6: Commit**

```bash
git add Utils/MHLMcpServer
git commit -m "+ Add on-disk FB2 text cache to the MCP server"
```

---

## Task 10: Text tools and cleanup

**Files:**
- Create: `Utils/MHLMcpServer/unit_MCP_Tools_Text.pas`
- Modify: `Utils/MHLMcpServer/MHLMcpServer.dpr` (register text tools, remove `echo_args`)
- Modify: `Utils/MHLMcpServer/tests/cases/05_clamping.jsonl` (retarget off `echo_args`)
- Modify: `Utils/MHLMcpServer/README.md`

**Interfaces:**
- Consumes: `CollectionOrFail` (Task 4), `ExtractFb2` (Task 8), `EnsureCached`/`ReadCachedSlice` (Task 9).
- Produces: `procedure RegisterTextTools(Server: TMcpServer)`.

**Shared preamble** for all three tools: resolve the collection, load the book record, reject non-FB2 with `unsupported_format`, obtain the source file's size and timestamp for the cache key, then `EnsureCached` with a closure that calls `BookRecord.GetBookStream` and `ExtractFb2`. `EBookNotFound` maps to `file_missing`; `EFb2ExtractError` maps to `extraction_failed`.

- [ ] **Step 1: Retarget the clamping test**

`echo_args` disappears in this task, so rewrite `tests/cases/05_clamping.jsonl` to assert clamping through a real tool instead. Replace its contents with a `tools/list` assertion that all eight tools are registered:

```
> {"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"get_book_text","arguments":{"collection_id":-1,"book_id":1,"length":999999}}}
< {"jsonrpc":"2.0","id":1,"result":{"content":[{"type":"text","text":"{\"code\":\"collection_not_found\",\"message\":\"Collection -1 not found\"}"}],"isError":true}}
```

This exercises the domain-error path without needing a real collection. Rename the file to `05_tool_error.jsonl`.

- [ ] **Step 2: Run the test to verify it fails**

Expected: `FAIL 05_tool_error.jsonl` — `get_book_text` is not registered yet.

- [ ] **Step 3: Write the text tools unit**

Create `Utils/MHLMcpServer/unit_MCP_Tools_Text.pas` (**UTF-8 with BOM**) with a shared helper:

```pascal
function LoadBookForText(const Args: TJSONObject;
  out CollectionID, BookID: Integer; out Cached: TCachedBook): TBookRecord;
var
  Collection: IBookCollection;
  BookKey: TBookKey;
  Book: TBookRecord;
  SourcePath: string;
  SourceSize: Int64;
  SourceStamp: TDateTime;
begin
  CollectionID := RequireInt(Args, 'collection_id');
  BookID := RequireInt(Args, 'book_id');

  Collection := CollectionOrFail(CollectionID);

  BookKey.BookID := BookID;
  BookKey.DatabaseID := CollectionID;
  try
    Collection.GetBookRecord(BookKey, Book, False);
  except
    on E: Exception do
      raise EMcpToolError.Create('book_not_found',
        Format('Book %d not found: %s', [BookID, E.Message]));
  end;

  if not (Book.GetBookFormat in [bfFb2, bfFb2Archive]) then
    raise EMcpToolError.Create('unsupported_format',
      Format('Text extraction supports FB2 only; this book is "%s"', [Book.FileExt]));

  // GetBookFileName resolves to a real file for both FB2 shapes: the .fb2 for
  // bfFb2, the .zip for bfFb2Archive. GetBookContainer would give a DIRECTORY
  // for loose files, so it must not be used here.
  SourcePath := Book.GetBookFileName;
  if not FileExists(SourcePath) then
    raise EMcpToolError.Create('file_missing',
      Format('Book file not found: %s', [SourcePath]));

  SourceSize := TFile.GetSize(SourcePath);
  SourceStamp := TFile.GetLastWriteTime(SourcePath);

  Cached := EnsureCached(CollectionID, BookID, SourceSize, SourceStamp,
    function: TFb2Extraction
    var
      Stream: TStream;
    begin
      try
        Stream := Book.GetBookStream;
      except
        on E: EBookNotFound do
          raise EMcpToolError.Create('file_missing', E.Message);
      end;
      try
        try
          Result := ExtractFb2(Stream);
        except
          on E: EFb2ExtractError do
            raise EMcpToolError.Create('extraction_failed', E.Message);
        end;
      finally
        Stream.Free;
      end;
    end);

  Result := Book;
end;
```

Then the three handlers:

- `GetBookToc` — returns `{"sections":[{title,level,offset,length}],"structured":bool,"total_length":int}` from `Cached`.
- `GetBookText`:

```pascal
function GetBookText(const Args: TJSONObject): TJSONObject;
var
  CollectionID, BookID, Offset, Count: Integer;
  Cached: TCachedBook;
  Book: TBookRecord;
  SourceSize: Int64;
  SourceStamp: TDateTime;
  Slice: string;
  ClampedOffset, ClampedCount: Boolean;
begin
  Book := LoadBookForText(Args, CollectionID, BookID, Cached);

  SourceSize := TFile.GetSize(Book.GetBookFileName);
  SourceStamp := TFile.GetLastWriteTime(Book.GetBookFileName);

  Offset := ArgIntClamped(Args, 'offset', 0, 0, MaxInt, ClampedOffset);
  Count := ArgIntClamped(Args, 'length', 8000, 1, 50000, ClampedCount);

  if Offset > Cached.TotalLength then
    raise EMcpToolError.Create('invalid_offset',
      Format('Offset %d is past the end of the text (total_length %d)',
        [Offset, Cached.TotalLength]));

  Slice := ReadCachedSlice(CollectionID, BookID, SourceSize, SourceStamp,
    Offset, Count);

  Result := TJSONObject.Create;
  Result.AddPair('text', Slice);
  Result.AddPair('offset', TJSONNumber.Create(Offset));
  Result.AddPair('length', TJSONNumber.Create(Length(Slice)));
  Result.AddPair('total_length', TJSONNumber.Create(Cached.TotalLength));
  Result.AddPair('has_more',
    TJSONBool.Create(Offset + Length(Slice) < Cached.TotalLength));
  if ClampedOffset or ClampedCount then
    Result.AddPair('clamped', TJSONBool.Create(True));
end;
```

`Length(Slice)` may come back one shorter than requested when the surrogate trim
fires — that is why the response reports the actual length rather than echoing
the argument.
- `SearchInBook` — read the whole cached text, case-insensitive scan for `query`, collect up to `max_hits` (default 10, max 50) passages each padded by `context_chars` (default 200, max 2000) either side and clamped to text bounds; return `{"hits":[{"offset":…,"passage":…}],"total_hits":…}`.

- [ ] **Step 4: Register the tools and drop `echo_args`**

In `MHLMcpServer.dpr`, call `RegisterTextTools(Server)` after `RegisterLibraryTools(Server)`, and delete the `echo_args` registration and the now-unused `System.JSON`/`unit_MCP_Json` uses if nothing else needs them.

Schemas:

```pascal
  Server.RegisterTool(
    'get_book_toc',
    'Зміст книги FB2: розділи з їхніми зміщеннями для get_book_text.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"book_id":{"type":"integer"}},' +
      '"required":["collection_id","book_id"]}') as TJSONObject,
    Guarded(GetBookToc));

  Server.RegisterTool(
    'get_book_text',
    'Фрагмент тексту книги FB2 від заданого зміщення.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"book_id":{"type":"integer"},' +
      '"offset":{"type":"integer","description":"Типово 0"},' +
      '"length":{"type":"integer","description":"Типово 8000, максимум 50000"}},' +
      '"required":["collection_id","book_id"]}') as TJSONObject,
    Guarded(GetBookText));

  Server.RegisterTool(
    'search_in_book',
    'Пошук фрагментів у тексті книги FB2 із зазначенням їхніх зміщень.',
    TJSONObject.ParseJSONValue(
      '{"type":"object","properties":{' +
      '"collection_id":{"type":"integer"},' +
      '"book_id":{"type":"integer"},' +
      '"query":{"type":"string"},' +
      '"max_hits":{"type":"integer","description":"Типово 10, максимум 50"},' +
      '"context_chars":{"type":"integer","description":"Типово 200, максимум 2000"}},' +
      '"required":["collection_id","book_id","query"]}') as TJSONObject,
    Guarded(SearchInBook));
```

- [ ] **Step 5: Build both platforms**

Expected: `Build succeeded` for Win64 and Win32.

- [ ] **Step 6: Run both test suites**

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
node Utils/MHLMcpServer/tests/extract_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

Expected: every case `PASS`, both exit 0.

- [ ] **Step 7: Complete the README**

Finish the manual checklist with the text-tool cases:

- `get_book_toc` on a structured FB2 lists chapters matching the book's actual chapters.
- An offset from `get_book_toc` passed to `get_book_text` returns that chapter's opening text.
- `get_book_text` past `total_length` returns `invalid_offset`.
- `get_book_text` on a non-FB2 book returns `unsupported_format`.
- `search_in_book` finds a phrase you know is in the book, and its offset re-read via `get_book_text` shows the phrase.
- A book whose archive is missing returns `file_missing`.
- The second `get_book_text` call on the same book is noticeably faster than the first (cache hit).

Also document that the server must live beside `MyHomeLib.exe` and that `--extract <file.fb2>` exists for debugging extraction.

- [ ] **Step 8: Commit**

```bash
git add Utils/MHLMcpServer
git commit -m "+ Add get_book_toc, get_book_text and search_in_book to the MCP server"
```

- [ ] **Step 9: Register the server with Claude Code**

Create or update `.mcp.json` in the repo root with the snippet from the README, restart Claude Code, and confirm the `myhomelib` server connects and lists eight tools.

- [ ] **Step 10: Update TODO.md and commit separately**

Per repo convention, `TODO.md` is committed on its own:

```bash
git add TODO.md
git commit -m "* Update the TODO after the MCP server work"
```

---

## Verification Summary

**Automated:**
- `tests/run_tests.js` — transport framing, `initialize`, `tools/list`, notification silence, unknown method, unknown tool, domain-error shape.
- `tests/extract_tests.js` — FB2 section detection, offset/text alignment, windows-1251 decoding, malformed-file fallback.

**Manual (README checklist):** every catalogue tool against the real library, and every text tool against a real FB2.

**Known gap, carried from the spec:** the catalogue tools have no automated coverage, because a fixture collection database must be created with the `MHL_*` collations registered. The follow-up is a `--make-fixture` mode that builds a tiny collection via `TBookCollection_SQLite.CreateTemp`, after which the catalogue tools become testable in `run_tests.js`. Treat this as the next piece of work, not as optional polish.
