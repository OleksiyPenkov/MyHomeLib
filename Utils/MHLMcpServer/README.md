# MyHomeLib MCP Server

A read-only MCP (Model Context Protocol) server exposing the MyHomeLib book
collection over stdio JSON-RPC. It links MyHomeLib's DAO layer directly
(`DMUser`), so it sees exactly the collections, settings and system database
the desktop app itself uses.

## Connecting from an MCP client

Add to your client's `.mcp.json` (paths below assume the Win64 build; swap in
`Program\OUT\BIN\MHLMcpServer.exe` for Win32):

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

The server takes no arguments and no environment configuration. It boots
`DMUser`, opens the same system database the installed app uses, and serves
JSON-RPC requests over stdin/stdout until stdin closes.

`sqlite3.dll` (matching the build's bitness) must sit next to the exe or
otherwise be resolvable by the loader — it is not produced by the group
project build and is only staged by the Inno Setup installer. When running
from a raw `Program\OUT\...` build output (rather than an installed copy),
copy `sqlite3.dll` there manually before invoking the server.

## Read-only guarantee

The server never issues an SQL write. Every registered tool wraps its handler
in `Guarded(...)`, which turns SQLite lock contention (the running app writing
while the server is querying) into the domain error `collection_busy` instead
of an opaque internal failure.

## Manual verification checklist

Run these against a Win64 build (`Program\OUT\Bin64\MHLMcpServer.exe`) while
comparing results with the MyHomeLib app itself:

- [ ] `list_collections` returns every collection visible in the app's
      collection list, with matching names and root folders.
- [ ] Collection `type` and `notes` match what the app shows for each
      collection (Collection Properties / collection tree tooltip).
- [ ] Closing the app and re-running `list_collections` still works — the
      server does not depend on the app being open.
- [ ] Opening the app and triggering an import while the server is mid-query
      surfaces `collection_busy` rather than crashing the server or hanging.
- [ ] No output other than JSON-RPC lines ever appears on stdout, even during
      `DMUser` bootstrap (verified by the automated test suite in `tests/`,
      which fails loudly on any stray line).

## Automated tests

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

These cover the JSON-RPC envelope, the MCP handshake and the JSON argument
helpers. They do not touch `DMUser` or real collection data — `list_collections`
and later data-reading tools are covered by the manual checklist above because
they require a real system database to be meaningful.
