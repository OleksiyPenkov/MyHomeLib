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

The server takes no arguments and no environment configuration. `DMUser` is
booted lazily, on the first tool call, against the same system database the
installed app uses, and the server serves JSON-RPC requests over
stdin/stdout until stdin closes.

`sqlite3.dll` (matching the build's bitness) must be resolvable next to the
exe **at process launch**, not just when a tool queries the database. The
DAO layer imports it via plain `external 'sqlite3.dll' name '...'`
declarations (`Program\DAO\SQLite\Lib\SQLite3.pas`), which the Windows loader
resolves before any Pascal code runs — confirmed by inspecting the built
exe's PE import table, where `sqlite3.dll` sits in the ordinary
load-time Import Directory, not in the Delay Import Descriptor table VCL
uses for a handful of its own optional dependencies. Without it, the process
fails to start at all (`STATUS_DLL_NOT_FOUND`), before it ever reads stdin.
This DLL is not produced by the group project build and is only staged by
the Inno Setup installer. When running from a raw `Program\OUT\...` build
output (rather than an installed copy), copy `sqlite3.dll` there manually
before invoking the server.

## Read-only guarantee

The server never issues an SQL write, including at startup. `DMUser` is only
initialized lazily, on first tool use, and only after confirming the system
database file already exists — if it does not, the tool call fails with
`system_db_missing` naming the path it looked for, rather than falling
through to `TDMUser.Init`'s behavior of creating a brand-new system database
(DDL plus two `INSERT`s) when the file is absent. Every registered tool wraps
its handler in `Guarded(...)`, which is both what triggers this lazy
initialization and what turns SQLite lock contention (the running app
writing while the server is querying) into the domain error
`collection_busy` instead of an opaque internal failure.

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
- [ ] `get_book` returns a book whose title, authors, series and annotation
      match the app's book details pane.
- [ ] `search_books(author=…)` returns the same books as the app's author
      filter.
- [ ] `search_books(limit=5000)` returns 200 books and `"clamped":true`.
- [ ] `search_books(offset=…)` pages without repeating or skipping books.
- [ ] No output other than JSON-RPC lines ever appears on stdout, even during
      `DMUser` bootstrap (verified by the automated test suite in `tests/`,
      which fails loudly on any stray line).

### `search_books` date-filter pitfall

`TBookSearchCriteria.DateIdx` defaults to `0` under `Default(TBookSearchCriteria)`,
but `0` is not "no date filter" in `TBookCollection_SQLite.PrepareSearchData`
(`Program\DAO\SQLite\unit_Database_SQLite.pas`) — it means "restrict to rows
whose `UpdateDate` is within the last calendar day". Left at its zeroed
default, every `search_books` call would silently return zero rows for any
collection that has not been touched in the last 24 hours (confirmed against
a real 525k-book collection during manual verification). `search_books`
explicitly sets `Criteria.DateIdx := -1` — the actual sentinel for "skip date
filtering" — right after `Default(TBookSearchCriteria)`.

## Automated tests

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

These cover the JSON-RPC envelope, the MCP handshake and the JSON argument
helpers. Six of the ten cases (`01_ping`, `02_initialize`,
`03_unknown_method`, `04_unknown_tool`, `05_non_object_line`,
`06_non_object_params`, `07_non_object_arguments` — everything that never
reaches a tool handler) never touch `DMUser` or the real system database.
`05_clamping.jsonl` calls the diagnostic `echo_args` tool, and every
registered tool — `echo_args` included — is wrapped in `Guarded(...)`, which
is what lazily boots `DMUser`; so that one case does depend on a real system
database existing on the machine running the tests, the same as
`list_collections` does. `08_get_book_invalid_params.jsonl` and
`09_get_book_collection_not_found.jsonl` exercise `get_book`'s argument
validation (`RequireInt` rejecting a non-integer `collection_id`) and
`CollectionOrFail`'s not-found path respectively; both still go through
`Guarded(...)` and so also depend on a real system database, even though
neither ever reaches a real collection. **All fourteen cases still require
`sqlite3.dll` to be resolvable next to the exe**, regardless of which tool
(if any) is called — see the load-time dependency note above — since the
process cannot start at all without it. `list_collections` is covered by the
manual checklist above because it needs a real, populated collection list to
be meaningful, not just any system database.

`10_search_books_found.jsonl`, `11_search_books_limit_clamped.jsonl`,
`12_search_books_collection_not_found.jsonl` and
`13_search_books_offset_paging.jsonl` exercise `search_books` against a real
collection (`collection_id: 1`) and assert byte-for-byte responses captured
from an actual run, not hand-written expectations. They depend on that
collection containing the exact two "Гудок парохода" rows the fixtures were
captured against; if collection 1's contents ever change on the machine
running the tests, these four cases (not the other ten) may need
recapturing the same way — run the request through the built exe and paste
back whatever it actually prints.
