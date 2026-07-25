# MyHomeLib MCP Server — Design

**Date:** 2026-07-25
**Status:** Approved, ready for planning

## Purpose

A read-only MCP server that lets Claude search a MyHomeLib library and read the
text of FB2 books in it. Two use cases:

1. **Search and ask about the library** — "which Vernor Vinge do I have", "what's
   book 3 of this series", "find sci-fi I rated highly".
2. **Read book content** — summarize a book, answer questions about its text,
   compare passages.

Out of scope: modifying library data (ratings, groups, metadata, deletion) and
driving app actions (import, export to device, download). The server never opens
a database for write.

## Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Implementation | Delphi console app reusing the DAO layer | Inherits real path resolution, archive handling and FB2 parsing; one source of truth with the app |
| Transport | MCP over stdio | Standard for local servers; no ports or service |
| Collections | All registered, explicit `collection_id` | Unambiguous results; allows cross-collection comparison |
| Formats | FB2 only for text; all formats searchable by metadata | Reuses existing parsers; no new format work |
| Text access | Offset-windowed + in-book search + best-effort TOC | Never degrades on structureless FB2, unlike chapter-only access |
| Access mode | Read-only | Scope is search and read |

### Cost accepted

Delphi means hand-writing JSON-RPC with no MCP SDK, and every iteration is a full
Delphi build. This was weighed against a standalone Python server (~400 lines,
stdlib-only) and chosen deliberately for fidelity with the app's own file
resolution and FB2 handling.

## Architecture

### Process model

A console-mode Delphi app, `Utils/MHLMcpServer/MHLMcpServer.dpr`. Claude Code
launches it as a child process; it serves requests on stdin/stdout and exits when
stdin closes. One instance per session.

### Startup

```
DMUser.Create → DMUser.Init → SystemDB(): ISystemData
                            → GetCollection(id): IBookCollection  (per request)
```

The server reads the same settings and the same `Bases` table as the running app,
so the collections it lists are exactly the ones visible in the UI.

It links the VCL — `unit_Globals` uses `Forms`, `dm_user` uses `Controls` and
`ImgList` — but creates no forms and pumps no message loop. `DMUser.Init` shows
no dialogs, so it cannot block on stdio.

### Deployment

The exe ships next to `MyHomeLib.exe` in `Program/OUT/Bin64/`. This is required,
not cosmetic: `DMUser` and the DAO expect the app's directory layout, and
`MHLSQLiteExt` must be loadable from there. `.mcp.json` points at the absolute
path.

### Build

A new `MHLMcpServer.dproj`, added to `MHL.groupproj` as a third project after
`MHLComponents`. Built through the group project only — never directly, the same
rule that protects `MyhomeLib.dproj` from being re-serialised. Win64 first, Win32
must also pass.

**Requires explicit go-ahead:** the standing Delphi convention is not to modify
`.dproj`/`.groupproj` without being asked. Adding the project to the group is
such a modification and must be confirmed before implementation.

### Unit layout

| Unit | Responsibility |
|---|---|
| `MHLMcpServer.dpr` | Bootstrap, DMUser lifecycle, main loop |
| `unit_MCP_Transport` | Newline-delimited JSON on stdin/stdout, UTF-8 |
| `unit_MCP_Protocol` | JSON-RPC 2.0 + MCP handshake, `tools/list`, `tools/call` routing, error mapping |
| `unit_MCP_Tools_Library` | Catalogue tools over `ISystemData` / `IBookCollection` |
| `unit_MCP_Tools_Text` | TOC, text window, in-book search |
| `unit_MCP_TextCache` | FB2 → plain text extraction and on-disk cache |

### Invariants

**Stdout discipline.** `unit_MCP_Transport` is the only code permitted to write
to stdout. Diagnostics go to stderr and to `unit_Logger`'s file. A single stray
`WriteLn` anywhere else corrupts every response. This gets a comment in the
`.dpr` and must survive review.

**Concurrency.** Collection databases open read-only with a 5-second busy
timeout. `journal_mode = OFF` means no rollback journal, but SQLite's file
locking still applies, so a concurrent write by the app blocks the reader rather
than yielding torn data — the failure mode is a timeout, not corruption. On
timeout, tools return `collection_busy` rather than retrying indefinitely.

## Tool surface

Eight tools, all read-only. Responses are compact JSON in a single text content
block. MCP resources and prompts are deliberately excluded — tools cover every
use case, and each extra protocol surface is hand-written JSON in Delphi.

### Catalogue

| Tool | Arguments | Returns |
|---|---|---|
| `list_collections` | — | `id`, `name`, `root_folder`, `type`, `notes` for every row in `Bases` |
| `search_books` | `collection_id`, optional `title`, `author`, `series`, `genre`, `lang`, `keyword`, `annotation`, `min_lib_rate`, `include_deleted`, `limit`, `offset` | `book_id`, `title`, `authors`, `series`, `seq_number`, `genres`, `lang`, `ext`, `size`, `has_text` |
| `get_book` | `collection_id`, `book_id` | Full record incl. `annotation`, `review`, `keywords`, `rate`, `lib_rate`, `progress`, `folder`, `file_name`, `is_local`, `is_deleted` |
| `list_series` | `collection_id`, `filter`, `limit` | Series titles with book counts |
| `list_genres` | `collection_id` | Genre tree: `code`, `parent_code`, `alias` |
| `list_authors` | `collection_id`, `filter`, `limit` | Authors with book counts |

`search_books` maps onto `IBookCollection.Search(TBookSearchCriteria,
LoadMemos)`. The criteria record already carries `FullName`, `Series`,
`Annotation`, `Genre`, `Title`, `Lang`, `KeyWord`, `LibRate`, `Deleted` and
`Readed`, so the tool is largely a JSON→record marshal plus draining the
returned `IBookIterator`.

`list_genres` is not optional: `search_books(genre=…)` takes a genre code, and
those codes cannot be guessed.

`list_authors` is the **cut candidate** if implementation effort runs long —
`search_books(author=…)` covers most of its value, and it earns its place mainly
for disambiguating common surnames.

### Text

FB2 only (`bfFb2`, `bfFb2Archive`). Any other format returns `unsupported_format`.

| Tool | Arguments | Returns |
|---|---|---|
| `get_book_toc` | `collection_id`, `book_id` | Sections: `title`, `level`, `offset`, `length`. An empty array is a valid answer, not an error |
| `get_book_text` | `collection_id`, `book_id`, `offset`, `length` | Text window plus `total_length` |
| `search_in_book` | `collection_id`, `book_id`, `query`, `max_hits`, `context_chars` | Matching passages, each with its `offset` |

Offsets returned by `get_book_toc` and `search_in_book` feed directly into
`get_book_text`.

### Sizing rules

- `search_books`: `limit` defaults to 25, hard max 200.
- `get_book_text`: `length` defaults to 8000 characters, hard max 50000.
- Over-large requests are **clamped, not rejected**, and the response says the
  value was clamped.
- `search_books` returns `total_count` when the iterator provides it cheaply;
  otherwise it returns `has_more` and the client pages with `offset`.

## Text pipeline

```
GetBookRecord → TBookRecord.GetBookStream → DOM parse → single walk → cache → slice
```

`TBookRecord.GetBookStream` (`Program/Units/unit_Globals.pas:1060`) already
resolves loose files, zip archives and FBD, raises `EBookNotFound`, and honours
`Settings.IgnoreAbsentArchives`. No path or archive logic is reimplemented.

### One extractor, one character space

The tempting build — TOC from the `fictionbook_21` data binding, text from
`TFb2ToText` — produces offsets in two different character spaces that do not
line up, so a TOC offset fed to `get_book_text` lands in the wrong place.

Instead: a **single DOM walk** emits the plain text and records each section's
start and end as it goes, so offsets are consistent by construction.
`TFb2ToText` is left untouched, serving the app's export feature; the server does
not use it.

### Degradation

Real-world FB2 is frequently malformed and a schema-bound parse will fail on part
of any large library. When the DOM parse fails, fall back to a raw tag-stripping
pass: text is still served, TOC comes back empty. Text always works; structure is
best-effort. Books that fail even the fallback return `extraction_failed`.

Encoding is resolved from the XML prolog by feeding the parser bytes, not a
pre-decoded string — FB2 files in the wild are commonly windows-1251.

### Cache

Extraction is expensive (inflate a zip entry, parse several MB of XML) and
`get_book_text` will be called repeatedly, so each book is extracted once.

- **Location:** `%LOCALAPPDATA%\MyHomeLib\McpCache\`
- **Key:** collection id + book id + source file size + mtime, so a re-imported
  or updated book invalidates itself
- **Contents:** the extracted text, plus a sidecar JSON holding the TOC and
  `total_length`
- **Encoding:** UTF-16LE, with offsets as UTF-16 code-unit indices, making
  `get_book_text` a seek and a read rather than a scan. Slices clamp so they
  never split a surrogate pair
- **Eviction:** total-size cap of 200 MB, enforced at startup, oldest-accessed
  first

## Error handling

Split by kind:

- **Protocol faults** (unknown method, malformed params) → JSON-RPC errors.
- **Domain faults** → a normal tool result with `isError` and a machine-readable
  `code`, so the client can adapt rather than parse prose.

Codes: `collection_not_found`, `book_not_found`, `file_missing` (from
`EBookNotFound`), `unsupported_format`, `collection_busy`, `extraction_failed`,
`invalid_offset`.

## Testing

**Automated — protocol level.** Golden-file tests covering `initialize`,
`tools/list`, error shapes, argument clamping and message framing: `.jsonl` in,
expected `.jsonl` out, driven by a Node script (the repo already uses Node for
`tools/help`). These need no database.

**Manual — data level.** Testing the catalogue and text tools properly requires a
fixture collection database, and building one means creating it *with* the
`MHLSQLiteExt` collations. That is real work, so v1 covers these tools with a
documented manual checklist run against a real library.

**Known gap:** the automated suite does not cover the catalogue or text tools. A
fixture collection is the obvious follow-up and should be treated as such rather
than as a stretch goal.

## Open items for implementation

1. Confirm the MCP protocol version advertised by the installed Claude Code and
   pin it in `unit_MCP_Protocol`.
2. Confirm adding `MHLMcpServer.dproj` to `MHL.groupproj` (see Build above).
3. Decide whether `SQLiteWrap` exposes a read-only open mode or whether the
   server opens its own connection with `mode=ro`.
