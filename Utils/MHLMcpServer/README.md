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
      "command": "D:\\DelphiProjects\\MyHomeLib-mcp\\Program\\OUT\\Bin64\\MHLMcpServer.exe",
      "args": []
    }
  }
}
```

**The `command` path must point at the exe built from *this* checkout** —
not a copy elsewhere, and not another clone/worktree of this repo that may
be on a different branch or may not have `Utils\MHLMcpServer` built at all.
`Program\OUT\Bin64\` (or `Program\OUT\BIN\` for Win32) only exists once you
have built `Program\MHL.groupproj` yourself; adjust the drive/path above to
wherever your own checkout lives. The exe also needs a resolvable
`sqlite3.dll` sitting right beside it — see the load-time dependency note
below — so double-check that file is present at the same path before
registering the server.

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
- [ ] `search_books(title=…)` with a value containing a `"`, `'`, `%` or `_`
      matches literally instead of erroring or matching too broadly.
- [ ] `search_books(min_lib_rate=N)` returns books rated `N` and above, not
      only books rated exactly `N`.
- [ ] `list_genres` returns the same genre tree the app's genre panel shows.
- [ ] A genre code from `list_genres` used in `search_books(genre=…)` returns
      books of that genre.
- [ ] `list_series(filter=…)` finds a series you know exists.
- [ ] No output other than JSON-RPC lines ever appears on stdout, even during
      `DMUser` bootstrap (verified by the automated test suite in `tests/`,
      which fails loudly on any stray line).
- [ ] `get_book_toc` on a structured FB2 lists chapters matching the book's
      actual chapters (open the same file in the app or a text editor and
      compare titles/order).
- [ ] An offset from `get_book_toc` passed to `get_book_text` returns that
      chapter's opening text — the round trip that justifies returning
      offsets from the TOC at all.
- [ ] `get_book_text` with an `offset` past `total_length` returns
      `invalid_offset` rather than an empty slice or a crash.
- [ ] `get_book_text` on a non-FB2 book returns `unsupported_format`. (A
      library that is 100% FB2, e.g. a Lib.rus.ec/Flibusta dump, will have no
      such book to test with — that is expected, not a gap; skip this item
      with a note rather than forcing a non-FB2 book into the collection.)
- [ ] `search_in_book` finds a phrase you know is in the book, and its
      `offset` re-read via `get_book_text` shows the phrase at the very start
      of what comes back.
- [ ] A book whose archive (`.zip`) is missing or renamed returns
      `file_missing`, not a crash or an opaque internal error.
- [ ] The second `get_book_text` (or `get_book_toc`/`search_in_book`) call on
      the same book is noticeably faster than the first — the extraction
      itself is skipped and the cached `.txt`/`.json` pair under
      `%LOCALAPPDATA%\MyHomeLib\McpCache` is read instead. Confirm the pair's
      `LastWriteTime` does NOT change between the two calls (no rewrite on a
      hit) while its access time does.
- [ ] Every field in every tool's response — not just the ones called out
      above — matches what the app itself shows for the same book/collection.
      Spot-check at least one field per tool against the app's UI; the
      per-tool bullets above are examples, not the full extent of what should
      be compared.

## Diagnostic CLI modes

Both of these run before `Application.Initialize`/`DMUser` and write their
single JSON result through `TMcpTransport` (never raw `Writeln`) to keep the
"only the transport writes to stdout" rule mechanically true even in these
modes. Neither touches the database or the real machine-wide cache.

- **`MHLMcpServer.exe --extract <file.fb2>`** — runs `ExtractFb2` on a local
  FB2 file and prints `{"text":…,"sections":[…],"structured":…,
  "total_length":…}` as one JSON line. Useful for checking what the extractor
  produces for a specific file without going through a collection at all —
  e.g. `MHLMcpServer.exe --extract C:\some\book.fb2`. Exits non-zero with a
  message on stderr if extraction fails.
- **`MHLMcpServer.exe --cache-selftest`** — exercises
  `EnsureCached`/`ReadCachedSlice`/`EvictCache` end to end against a throwaway
  temp directory (never the real `%LOCALAPPDATA%\MyHomeLib\McpCache`) and
  prints a pass/fail line per scenario. This is what `tests/cache_tests.js`
  drives; run it directly for a quick sanity check of the cache logic in
  isolation.

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

### `search_books` deleted-books polarity pitfall

`TBookSearchCriteria.Deleted` is inverted relative to what its name suggests.
`TBookCollection_SQLite.PrepareSearchData` only adds a filter when `Deleted`
is `True`, and that filter is `b.IsDeleted = 0` — i.e. `Deleted = True` means
"hide deleted books", not "include deleted books" (it's set straight from a
"hide deleted" checkbox in `frm_main.pas`). `search_books` maps its
`include_deleted` argument as `Criteria.Deleted := not <include_deleted>`,
so `include_deleted: false` (the default) excludes deleted books and
`include_deleted: true` includes them, matching the tool's documented
meaning. Do not "simplify" this back to a direct assignment.

### `search_books` genre-filter pitfall

`TBookSearchCriteria.Genre` is not a value to compare against a column — it is
spliced verbatim into a `WHERE` clause by
`TBookCollection_SQLite.PrepareSearchData`
(`' FROM Genre_List g JOIN Books b ON b.BookID = g.BookID WHERE (' +
SearchCriteria.Genre + ')'`). `frm_main.pas` builds this string as
`Format('(g.GenreCode = "%s")', [Genre.GenreCode])`, not as a bare code. A
bare code — which is exactly what `list_genres`'s `code` field is, and what
`search_books`'s `genre` argument is documented as taking — is invalid SQL on
its own; passing one straight through (as an earlier version of this tool
did) produced `near ".3": syntax error` for a real code like `0.3.3`.
`search_books` now builds the same condition itself from the caller's bare
code — `g.GenreCode = '...'` — but deliberately with single quotes rather
than `frm_main.pas`'s double quotes, doubling any embedded `'` first
(SQLite's escape for a literal quote inside a single-quoted string).

Double quotes were tried first and rejected: doubling `""` does contain the
value (not exploitable as written), but SQLite resolves a double-quoted
token as an *identifier* first, only falling back to a string literal when no
matching identifier exists. `frm_main.pas` can rely on double quotes because
it only ever quotes a real `GenreCode` value picked from its own genre tree.
This tool quotes arbitrary caller input, so a genre argument that happens to
match a column name — e.g. the literal string `GenreCode` — would become
`g.GenreCode = "GenreCode"`, comparing the column to itself and matching
every row instead of matching nothing. Single-quoted strings have no such
identifier fallback in SQLite, closing both the injection hole and this
identifier-collision trap. Confirmed contained against a real collection:
`search_books(genre: "x'); DROP TABLE Books; --")` returns
`{"books":[],"total_count":0,"has_more":false}` — a clean empty result, no
SQL error, no leaked SQL text — because the whole payload (quote, parens,
statement terminator, comment marker included) stays inert inside one string
literal. This proves containment for the `genre` field specifically, not
that the server is free of SQL-splicing elsewhere.

**This was also true of six other fields, fixed in a later task (below).**
`PrepareSearchData` built `Title`, `FullName` (author), `Series`,
`Annotation`, `Lang`, `KeyWord` the same unescaped way `Genre` used to, and
`LibRate` was a plain exact match instead of the "minimum rating" its name
promises. See "`search_books` free-text arguments: literal substring
matching" below for the fix and why a quoted-literal approach (the one used
for `genre` above) is not safe for these six fields the way it is for
`genre`.

## `search_books` free-text arguments: literal substring matching

`title`, `author`, `series`, `lang`, `keyword` and `annotation` are all
documented as plain, case-insensitive substring matches. Until this was
fixed, none of them were: every one of them went straight into
`Criteria.<Field> := ArgStr(Args, '<name>')`, so whatever the caller typed
was handed unescaped to `unit_SearchUtils.PrepareQuery`/`AddToFilter` (see
the genre section above for exactly how those two functions work). Two
concrete, confirmed-against-a-real-collection failures resulted:

- **Correctness**: a title containing a `"` (real example in this
  collection: `Вяртаньне ў "Тутэйшыя"`, `book_id` 786) defeated
  `PrepareQuery`'s own wrapping logic (it treats any `"` in the value as "the
  caller already wrote a hand-crafted condition") and was spliced through
  nearly verbatim — `AddToFilter` then had nothing to anchor the column name
  to, and the query broke.
- **Injection surface**: a value shaped like `x' OR '1'='1` (no `"`, so it
  still defeated the wrapping the same way, via the `=`) was spliced into the
  `WHERE` clause with no escaping of embedded quotes at all.

The `genre` field's fix (single-quote the literal, double any embedded `'`)
does not carry over to these six fields, because `genre` only ever fills in
one bare `g.GenreCode = '...'` comparison, never arbitrary free text. Free
text can itself contain `AddToFilter`'s own trigger substrings — e.g. an
annotation containing `x < y` — and `AddToFilter` blindly text-searches the
*final* spliced value for space-bounded ` LIKE `, ` =`, ` <>`, ` <`, ` >`
tokens to decide where the column name goes, with no notion of "inside a
string literal" versus "a second real operator". A literal built the normal
way (quote it, double the embedded quotes) is exposed to exactly that
confusion if the caller's own text contains one of those substrings.

The fix (`LiteralLikeCondition` in `unit_MCP_Tools_Library.pas`) sidesteps
both hazards by never emitting the caller's characters into the SQL text at
all: the escaped, wildcard-wrapped pattern is rendered as SQLite
`CHAR(code, code, ...)` calls — decimal Unicode code points — concatenated
with `||`, chunked into groups of 100 codes per call to stay under SQLite's
default `SQLITE_MAX_FUNCTION_ARG` (127; a single `CHAR()` call would
otherwise reject any search value longer than ~125 characters, a real limit
for `annotation` in particular). A value built entirely from digits, commas,
parentheses and the fixed keywords `LIKE`/`CHAR`/`ESCAPE` contains none of
the caller's original characters anywhere in the spliced text, so neither
`PrepareQuery`'s wrapping decision nor `AddToFilter`'s blind token search can
ever be confused by what the caller typed, regardless of what that text
contains.

Two details this depends on:

- **Case.** The column side of the comparison (`b.SearchTitle` etc.) is
  precomputed by a custom `MHL_UPPER` SQLite UDF backed by `Char.ToUpper`
  (`System.Character`'s `TCharHelper.ToUpper`, see
  `Program\DAO\SQLite\Lib\SQLite3UDF.pas`), not Delphi's `AnsiUpperCase`.
  Because the caller's value is encoded as fixed code points, `PrepareQuery`'s
  own `UP=True` uppercasing step (which only touches the literal
  `LIKE CHAR(...)` text, not the characters the numbers represent) cannot
  perform the case-folding it normally would — so `LiteralLikeCondition`
  uppercases the value itself with the *same* function before escaping it,
  or the match would have silently become case-sensitive against an
  always-uppercase column.
- **Wildcard escaping.** `%` and `_` are `LIKE` metacharacters no matter how
  the pattern string was built, so a literal search escapes both (and the
  escape character itself, `\`, in case the caller's text already contains
  one) and declares `ESCAPE '\'` — otherwise a title containing a literal
  `%` or `_` would be (mis)interpreted as a wildcard.

**`lang`'s substring semantics changed.** Before this fix, `PrepareQuery` was
called with `ConverToFull=False` for `Lang`, meaning a plain value (no
special characters) became an *exact* match (`="value"`), not a substring —
the only one of the six fields where the tool's actual behavior didn't match
its "substring" billing even before considering the escaping bugs.
`LiteralLikeCondition` treats it exactly like the other five now, which is
what its schema entry says.

**`min_lib_rate` is now a true minimum.** It was
`Criteria.LibRate := IntToStr(MinRate)`, which `PrepareQuery(S, UP=False,
ConverToFull=False)` wraps as `="N"` — an *exact* match, so
`min_lib_rate: 4` silently meant "rated exactly 4", not "rated 4 or higher"
as the name and schema description say. `MinRate` is always this tool's own
`IntToStr` of a parsed `Integer`, never caller text, so no literal-escaping
is needed here — only the operator: `Criteria.LibRate := Format('>= %d',
[MinRate])` produces `b.LibRate >= N`. Confirmed against a real collection:
`min_lib_rate: 4` returns `total_count: 18914`, matching the independently
queried count of books rated 4 or 5 (11293 + 7621); the old code returned
only the 11293 rated exactly 4.

**A fully blank filter is now a domain error, not a raw internal one.**
`PrepareSearchData` raises a plain `Exception` (message
`rstrCheckFilterParams`, "Перевірте параметри фільтра") whenever every field
above is blank *and* `include_deleted: true` (only that combination skips
every filter `PrepareSearchData` can add, including the `b.IsDeleted = 0`
filter that `include_deleted: false`, the default, always contributes). That
exception is not an `EMcpToolError`, so it used to fall through
`Guarded`/`HandleToolsCall` uncaught and surface as a raw JSON-RPC `-32603`
carrying the DAO's own message text. `search_books` now detects the same
"nothing to filter on" condition itself, before calling `Collection.Search`,
and raises `EMcpToolError.Create('empty_filter', ...)` instead — a normal
tool result with `isError: true` and a stable, machine-readable `code`.

### Residual limitations of literal matching

Two documented, deliberate exceptions to "every character is matched
literally":

- **A NUL (`#0`, U+0000) anywhere in a text argument is rejected**, not matched.
  A NUL is not simply "another character" for this construction: SQLite's
  `char(0)` embeds a real zero byte into the pattern string, and the `LIKE`
  implementation's own UTF-8 reader stops at it, truncating the pattern.
  Before this was caught, `title: "\0"` alone returned
  `total_count: 439393` — the entire non-deleted collection, from a value
  that should match nothing — and `title: "Бел\0ка"` returned 11
  unrelated books matching the truncated pattern `%БЕЛ%`. Fixed by
  rejecting any value containing a NUL outright
  (`isError: true`, `"code":"invalid_params"`, naming the argument) rather
  than trying to patch around it: the stored, pre-uppercased text these
  arguments are compared against cannot contain a NUL either, so a value
  containing one could never legitimately match anything. See case `35`.
- **A value longer than 4000 characters is rejected**, also
  `"code":"invalid_params"`, naming the argument, its length, and the
  limit. Not a correctness bug the way NUL was, but adjacent and cheap to
  close: an unbounded value eventually hits SQLite's own `LIKE`
  pattern-length limit (50000 bytes) uncaught, and that raw SQLite error
  message contains the *entire generated SQL statement* — hundreds of
  thousands of characters — which would otherwise leak to the client as a
  plain JSON-RPC `-32603`, the same class of leak `LogToStderr`/
  `EMcpToolError` exist everywhere else in this file to prevent. 4000 is far
  larger than any genuine search term needs to be. See case `36`.
- **Characters outside the Basic Multilingual Plane (e.g. emoji, some
  historical scripts) never match, silently.** `LiteralLikeCondition`
  encodes each UTF-16 code unit of the argument as one `CHAR()` code point;
  for a surrogate pair, that encodes the two halves as two out-of-range
  code points rather than one combined one, which cannot occur in the
  stored UTF-8 text — so the match legitimately, safely fails closed
  (`total_count: 0`, no error, no crash), never widens. Confirmed against a
  real collection: `title: "😀"`, `title: "𝄞"` and `title: "Белка😀"` all
  return a clean `total_count: 0`. Not expected to matter for library
  metadata (titles/authors/annotations in this collection are Cyrillic,
  Latin and common CJK, all within the BMP) but stated here rather than
  left silent, and not automated as a fixture since a persistent
  fail-closed empty result is indistinguishable from "this book doesn't
  exist", which is exactly what makes it safe.

## `list_genres`, `list_series`, `list_authors`

`list_genres` returns the entire genre tree for a collection, unpaged — genre
lists are small and fixed, and the `code` field is exactly what
`search_books(genre=…)` needs and has no other way to discover.

`list_series` and `list_authors` take an optional `filter` (case-insensitive
substring match, applied in Delphi over the iterator — the `smAll`/`amAll`
iterator modes take no free-text filter of their own) and a `limit`
(default 100, hard max 500, clamped rather than rejected, reporting
`"clamped":true` when it fires).

Both loops check `Taken < Limit` before calling `Iterator.Next`, rather than
folding the check into the same expression as `Next` (e.g.
`Iterator.Next(X) and (Taken < Limit)`). Pascal's short-circuit `and` still
evaluates `Next` first since it is the left operand, so on the iteration
where `Taken` reaches `Limit`, that form would fetch and discard one more
record from the iterator before the condition as a whole came back `False`.
Checking `Limit` first means `Next` is only ever called when a record taken
from it can still be used.

`list_authors` renders names with `ComposeAuthorFullName`, not
`TAuthorData.GetFullName` — see that function's comment in
`unit_MCP_Tools_Library.pas` for why (a blank `LastName` would otherwise raise
`EAssertionFailed` carrying a build-machine path straight to the client).

## `get_book_toc`, `get_book_text`, `search_in_book`

These three are the only tools that read a book's actual text rather than its
catalogue metadata, and they only work for FB2 books (`ext` `.fb2`, whether
loose or inside a `.zip`) — anything else fails with `unsupported_format`.
All three share one preamble (`LoadBookForText` in
`unit_MCP_Tools_Text.pas`): resolve the collection and book, reject non-FB2,
resolve the book's real file via `TBookRecord.GetBookFileName` (**not**
`GetBookContainer`, which returns a directory for a loose `.fb2` and would
fail `FileExists` for every non-archived book), then hand that file's size
and timestamp to the on-disk text cache (`unit_MCP_TextCache.pas`) as the key
for `EnsureCached`. The first call for a given book pays for the FB2 parse;
every later call for the same book (as long as its underlying file's size and
mtime are unchanged) reads the cached `.txt`/`.json` pair instead.

`get_book_toc` returns the section hierarchy as a flat, pre-order list —
`{"sections":[{"title":…,"level":…,"offset":…,"length":…}],"structured":…,
"total_length":…}`. This is **not** a partition of the text: FB2 sections
nest, so a parent's `[offset, offset+length)` span strictly contains every
one of its descendants' spans, and `level` (0 = top-level) is what encodes
that nesting in the flat list. A client must pick the one section it wants,
never concatenate every entry — doing so would double-count every nested
section once for itself and again for each ancestor. An empty `sections`
array is a normal, successful result for an unstructured book (no
`<section>` markup, or recovered via the tag-stripping fallback) — it is not
an error.

`get_book_text` returns a slice of the book's plain text starting at
`offset` (default `0`) for `length` code units (default `8000`, hard max
`50000`, clamped rather than rejected — `"clamped":true` when it fires). An
`offset` past `total_length` is the one thing this tool does NOT clamp: it
fails with `invalid_offset`, because silently clamping it would return an
empty slice that looks indistinguishable from "the book ends exactly here".
`offset`/`length` count **UTF-16 code units**, matching `get_book_toc`'s
`offset`/`length` fields exactly — feeding a TOC offset straight into
`get_book_text` lands on that section's own opening text, which is the round
trip the whole tool pair exists for.

`search_in_book` does a case-insensitive substring scan of the whole cached
text for `query`, returning up to `max_hits` (default 10, max 50) hits, each
`{"offset":…,"passage":…}` — `offset` is the 0-based position of the match
itself (so it, too, can be fed straight into `get_book_text`), `passage` is
`query` padded by `context_chars` (default 200, max 2000) on each side and
clamped to the text's own bounds. `total_hits` counts every match in the
book, even past `max_hits`, so a caller can tell there were more than it got
back.

### Error codes these three tools can return

- `unsupported_format` — the book's format is not `bfFb2`/`bfFb2Archive`.
- `file_missing` — the resolved book file does not exist on disk. Two
  distinct routes land here: a plain `FileExists` check right after
  resolving `GetBookFileName`, and (inside the cache-miss extraction
  closure) `TBookRecord.GetBookStream` either raising `EBookNotFound` or —
  the case that used to slip through uncaught — returning `nil` with **no**
  exception at all. `GetBookStream` (`Program\Units\unit_Globals.pas`) only
  raises when `Settings.IgnoreAbsentArchives` is `False`, and that setting
  **defaults to `True`** (`Program\Units\unit_Settings.pas`), so under the
  default a missing/renamed archive returns `nil` silently. Both routes are
  now checked and both map to `file_missing`.
- `book_has_no_text` — extraction itself succeeded (the DOM parsed cleanly)
  but the book genuinely has no text, e.g. picture-only or an empty body.
  This is deliberately **not** `extraction_failed` — a textless book is not
  a corrupt one, and a caller needs to be able to tell the two apart. Client
  message: `"Book <book_id> in collection <collection_id> has no
  extractable text (likely picture-only or an empty body)"` — stable text
  plus the caller's own arguments only.
- `extraction_failed` — nothing usable could be recovered at all (both the
  DOM walk and the tag-stripping fallback failed). `unit_MCP_Fb2Extract.pas`
  distinguishes the two via a structural `TFb2ExtractErrorKind` field on
  `EFb2ExtractError` (`eekNoText` vs. `eekExtractionFailed`), set explicitly
  at each raise site — not by pattern-matching the exception's message text,
  which is free to change for clarity without that match silently breaking.
  Client message: `"Could not extract text from book <book_id> in
  collection <collection_id>"`. Neither of these two messages interpolates
  `EFb2ExtractError.Message` — that message can itself embed the DOM
  parser's or the fallback scanner's own caught exception text (potentially
  an MSXML error or a Delphi assertion carrying a build-machine source
  path), the same class of leak fixed once already on the `book_not_found`
  path. `E.Message` (plus which `Kind` fired) goes to stderr via
  `LogToStderr` only.
- `invalid_offset` (`get_book_text` only) — `offset` is past `total_length`.
- `book_not_found` — the book ID does not exist in the collection. The
  underlying lookup can raise an assertion carrying a build-machine source
  path (`unit_Database_SQLite.pas`) for a sufficiently invalid ID; that
  detail goes to stderr only (`LogToStderr`), never into the client-facing
  message, the same discipline `unit_MCP_Tools_Library.pas`'s `GetBook`
  already follows.

## Automated tests

```
node Utils/MHLMcpServer/tests/run_tests.js Program/OUT/Bin64/MHLMcpServer.exe
node Utils/MHLMcpServer/tests/extract_tests.js Program/OUT/Bin64/MHLMcpServer.exe
node Utils/MHLMcpServer/tests/cache_tests.js Program/OUT/Bin64/MHLMcpServer.exe
```

(Swap in `Program/OUT/BIN/MHLMcpServer.exe` to run the same three suites
against the Win32 build.)

`run_tests.js` covers the JSON-RPC envelope, the MCP handshake and the JSON
argument helpers, one case per `.jsonl` file under `tests/cases/`.
`extract_tests.js` drives `--extract` against the fixtures under
`tests/fixtures/` to cover the FB2 extractor in isolation (structured
sections, encoding detection, malformed-file fallback, and — via
`picture_only.fb2`/`empty.fb2` — the `eekNoText`/`eekExtractionFailed` split
`EFb2ExtractError.Kind` depends on, see the error-codes section above).
`cache_tests.js` drives `--cache-selftest` to cover the on-disk text cache
in isolation (hit/miss keying, surrogate-boundary trimming, eviction).
None of the three touches a real collection or `DMUser` — `extract_tests.js`
and `cache_tests.js` never did (they are entirely fixture/temp-dir based);
`run_tests.js`'s cases that do reach a real collection are called out
individually further down.

**A note on what `picture_only.fb2`/`empty.fb2` do and do not prove:**
they exercise `ExtractFb2` directly through `--extract`, confirming the
`Kind` a real `EFb2ExtractError` carries for a textless-but-valid book vs.
a genuinely unrecoverable one — the precondition the MCP tool layer's
`book_has_no_text`/`extraction_failed` switch depends on. `--extract` is a
database-free CLI mode that bypasses `unit_MCP_Tools_Text.pas` entirely
(see "Diagnostic CLI modes" below), so neither case exercises the
*sanitized client-facing message* those two codes return — there is no
automated, end-to-end case for that, because doing so would require either
a genuinely textless/unrecoverable FB2 already sitting in the one
registered real collection (none was found; see the note further down on
`unsupported_format`) or inserting a fabricated book into that real
collection to force the failure, which this test suite deliberately never
does. The sanitized-message guarantee for these two codes — stable text
plus `book_id`/`collection_id` only, no interpolated `EFb2ExtractError.Message`
— is verified by code inspection instead (see `unit_MCP_Tools_Text.pas`'s
`EFb2ExtractError` catch block) and manually, the same way `collection_busy`
and the archive-missing scenarios are.

Six of `run_tests.js`'s cases (`01_ping`, `02_initialize`,
`03_unknown_method`, `04_unknown_tool`, `05_non_object_line`,
`06_non_object_params`, `07_non_object_arguments` — everything that never
reaches a tool handler) never touch `DMUser` or the real system database.
`05_tool_error.jsonl` calls `get_book_text` with a nonexistent
`collection_id: -1`, exercising the domain-error path (`collection_not_found`)
without needing a real collection; every registered tool is wrapped in
`Guarded(...)`, which is what lazily boots `DMUser`, so this case still
depends on a real system database existing on the machine running the tests,
the same as `list_collections` does — even though it never reaches a real
collection. `08_get_book_invalid_params.jsonl` and
`09_get_book_collection_not_found.jsonl` exercise `get_book`'s argument
validation (`RequireInt` rejecting a non-integer `collection_id`) and
`CollectionOrFail`'s not-found path respectively; both still go through
`Guarded(...)` and so also depend on a real system database, even though
neither ever reaches a real collection. **All cases in this suite still
require `sqlite3.dll` to be resolvable next to the exe**, regardless of which tool
(if any) is called — see the load-time dependency note above — since the
process cannot start at all without it. `list_collections` is covered by the
manual checklist above because it needs a real, populated collection list to
be meaningful, not just any system database.

`10_search_books_found.jsonl`, `11_search_books_limit_clamped.jsonl`,
`12_search_books_collection_not_found.jsonl` and
`13_search_books_offset_paging.jsonl` exercise `search_books` against a real
collection (`collection_id: 1`) and assert byte-for-byte responses captured
from an actual run, not hand-written expectations. They all search for
`title: "Гудок парохода"` with `include_deleted: true`, because both real
matches for that title (`book_id` 4 and 111933) happen to be deleted rows in
this collection — `include_deleted: true` is there so these cases keep
testing search/clamping/paging mechanics independently of the deleted-books
behavior, which `14`/`15` cover instead. They depend on collection 1 still
containing those exact two rows; if collection 1's contents ever change on
the machine running the tests, these four cases (not the other twelve) may
need recapturing the same way — run the request through the built exe and
paste back whatever it actually prints.

`14_search_books_excludes_deleted_by_default.jsonl` and
`15_search_books_include_deleted.jsonl` prove the `include_deleted` polarity
fix behaviourally: both search `title: "Белка", author: "Аббасзаде"` against
collection 1, which has three real matches — `book_id` 1 and 111931 (both
`is_deleted: true`, confirmed via `get_book`) and 487024 (`is_deleted:
false`). `14` (no `include_deleted`) expects only `book_id` 487024,
`total_count: 1`; `15` (`include_deleted: true`) expects all three,
`total_count: 3`. Depend on the same collection-1 stability as `10`–`13`.

`16_list_genres_and_search_genre_round_trip.jsonl` calls `list_genres` on
collection 1 (asserting the full, real 317-entry tree byte-for-byte — the
tool has no `limit`/`filter` by design, see above) and then `search_books`
with `genre: "0.3.3"` (a real code taken from that tree), proving the whole
point of `list_genres`: that its codes actually work as `search_books` input.
This is also the case that caught the genre-filter pitfall documented above —
without that fix, the `search_books` call in this file fails with a SQL
syntax error instead of returning a book. `17_list_series_filter_found.jsonl`
and `18_list_authors_filter_found.jsonl` prove `filter` finds real rows in
collection 1 (`"Гарри Поттер"` for series, `"Аббасзаде"` for the same author
`10`–`15` use). `19_list_authors_limit_clamped.jsonl` reuses the
single-match `"Аббасзаде"` filter with `limit: 5000` — clamping is decided
from the requested limit alone (`ArgIntClamped` compares it against `Max`
before any row is fetched), so `"clamped":true` shows up even though the
actual result set here is one row, keeping this fixture small on purpose.
`20_list_series_collection_not_found.jsonl` exercises `CollectionOrFail`'s
not-found path through `list_series`, standing in for all three new tools
(they all call `CollectionOrFail` first, identically to `get_book` and
`search_books`). Depend on the same collection-1 stability as `10`–`15`.

`21_search_books_genre_injection_contained.jsonl` proves the single-quote
escaping fix contains a hostile `genre` value: `"x'); DROP TABLE Books; --"`
(a single quote plus a destructive-looking `DROP TABLE`/comment-marker tail)
against collection 1 returns a clean
`{"books":[],"total_count":0,"has_more":false}` — zero matches, no
`isError`, no SQL error text, no build path. It proves containment for this
one field on this one query shape; it is not a general injection-free proof
of the server. The other fields it names (`title`, `author`, `series`,
`lang`, `keyword`, `annotation`, `min_lib_rate`) were fixed in a later task —
see "`search_books` free-text arguments: literal substring matching" above
and cases `28`–`34` below.

`22_get_book_toc.jsonl` through `27_get_book_toc_book_not_found_no_path_leak.jsonl`
cover the three text tools, all captured byte-for-byte from an actual run against
`book_id: 487024` in collection 1 (`Сборник "Белка"`, a real multi-story FB2
anthology — `total_length: 198707`, 11 flat top-level sections) or
`book_id: 4` (a much shorter FB2, `total_length: 13846`, chosen for the
clamping/invalid-offset cases specifically so the fixture stays small rather
than embedding a whole ~14–200K-character book where only the response shape
matters). `22_get_book_toc.jsonl` asserts `get_book_toc`'s full section list
for book 487024 byte-for-byte, including `level` on every entry.
`23_get_book_text_toc_round_trip.jsonl` feeds section 2's own `offset`
(`101182`, the "Гудок парохода" chapter) into `get_book_text` and asserts the
returned text opens with that chapter's title and first sentence — the round
trip the whole `get_book_toc`/`get_book_text` pair exists to support.
`24_get_book_text_clamped.jsonl` requests `length: 999999` on book 4 at
`offset: 13800` (near the very end, so the returned slice stays a few dozen
characters instead of the whole book) and asserts `"clamped":true`.
`25_get_book_text_invalid_offset.jsonl` requests `offset: 99999` against
book 4's `total_length: 13846` and asserts `isError:true` with
`"code":"invalid_offset"`. `26_search_in_book_round_trip.jsonl` searches book
487024 for the phrase `"Баку такой мягкой зимы"`, asserts the single real
hit's `offset` and padded `passage`, then feeds that same `offset` into a
second `get_book_text` call and asserts the phrase appears at the very start
of what comes back. `27_get_book_toc_book_not_found_no_path_leak.jsonl`
requests a nonexistent `book_id: 999999999` and asserts the response is
exactly `{"code":"book_not_found","message":"Book 999999999 not found"}` —
no build-machine path, no assertion text; a fixed point release regressed
this (interpolating the caught exception's own message, which for an
invalid ID reaches an `Assert` deep in `unit_Database_SQLite.pas` carrying
its source path) and this case pins the sanitized shape going forward.

`28_search_books_title_double_quote_literal.jsonl` through
`34_search_books_series_case_insensitive_literal.jsonl` cover the
literal-substring-matching fix described above, all captured byte-for-byte
against real collection 1. `28` searches `title: "\"Тутэйшыя\""` (with the
quote characters as part of the value) and gets exactly `book_id: 786`
(`total_count: 1`) — a title containing a `"` no longer breaks the query or
widens the match. `29` searches `title: "_%_"` and gets `total_count: 0`,
proving `%`/`_` are matched literally — independently confirmed against the
same collection that an *unescaped* `%_%` (i.e. treating both as wildcards)
would have matched 439,362 of the 439,393 non-deleted books, essentially the
whole collection. `30` searches `title: "'третьим"` (a leading literal
single quote) and gets exactly `book_id: 181` (`total_count: 1`). `31`
searches `title: "x' OR '1'='1"` — the classic injection shape — and gets a
clean `total_count: 0`, no `isError`, no SQL text, no build path: the
payload is matched as an inert literal, not executed as SQL. `32` calls
`min_lib_rate: 4` (`limit: 3` to keep the fixture small) and gets
`total_count: 18914` — independently confirmed as the count of books rated 4
*or 5* (11293 + 7621), not the 11293 rated exactly 4 the old exact-match
code returned — with all three returned books (`119`, `120`, `323`)
independently confirmed rated 5, i.e. above the requested minimum. `33`
calls `search_books` with only `collection_id`/`include_deleted: true` (no
other field set) and gets `isError: true`, `"code":"empty_filter"` instead
of a raw `-32603`. `34` searches `series: "гарри поттер"` (lowercase) and
gets the same real match (`book_id: 65006`, `total_count: 104`) that
`17_list_series_filter_found.jsonl` established for `"Гарри Поттер"`,
confirming `series` is still case-insensitive after the fix.

`35_search_books_title_nul_rejected.jsonl` through
`40_search_books_lang_substring_semantics.jsonl` were added in a fix round
after review flagged that `29`/`31` prove only containment (they assert
`total_count: 0`, so they would still pass if the escaping were
*over*-aggressive and matched nothing at all) and that a NUL in a text
argument was a real regression this task's own diff introduced. `35`
searches `title` containing a single NUL character and gets
`isError: true`, `"code":"invalid_params"` naming `title` — before this fix
the same call returned `total_count: 439393`, the entire non-deleted
collection (see "Residual limitations of literal matching" above for the
full before/after). `36` searches a 4001-character `title` and gets
`isError: true`, `"code":"invalid_params"` naming the argument, its length,
and the 4000-character limit. `37` searches `title: "на 100%"` and gets
`total_count: 23`, a **positive** literal match (as opposed to `29`'s
proof-by-absence) independently confirmed against the collection. `38`
searches `series: "%"` and gets `total_count: 6` — another positive match,
and proof that a value which is *entirely* an unescaped LIKE wildcard
character still matches only the real literal `%` substring. `39` searches
`author: "Аббасзаде"` (no `title` filter, unlike `14`/`15`) and gets
`total_count: 6`, covering a field other than `title`/`series` with a
positive match. `40` searches `lang: "r"` — a substring nothing would match
under `lang`'s old *exact*-match behavior (no real `Lang` value is just
`"r"`) — and gets `total_count: 376101`, pinning the exact-to-substring
semantics change as a deliberate, tested decision with a real number, not an
unverified side effect.

There is no automated case for `get_book_text`'s `unsupported_format` path:
the only collection registered on the machine these tests were captured on
is `Lib.rus.ec Local [FB2]` — a collection that is, by name and by a sampled
scan of 2,200 of its 452,816 `lang:"ru"` books spread across the whole ID
range, 100% FB2 (`has_text:false` count: 0). `unsupported_format` is
covered by unit-level reasoning instead (`Book.GetBookFormat in [bfFb2,
bfFb2Archive]` in `LoadBookForText`) and belongs on the manual checklist
above for whoever next runs this against a mixed-format collection.
Likewise there is no automated case for `file_missing` on a text tool
directly through `run_tests.js` (it needs a real archive to go
missing/renamed underneath a real collection — verified manually instead
during the fix rounds below, by temporarily renaming a real archive and
restoring it) — see the manual checklist.

**Correction to an earlier draft of this note:** the very first version of
this scan used `search_books` with no filter field at all besides
`limit`/`offset`/`include_deleted` — which, it turns out,
`TBookCollection_SQLite.PrepareSearchData` (`unit_Database_SQLite.pas`)
rejects outright with `"Перевірте параметри фільтра"` when *every* criteria
field is blank (its `FilterString`/`SQLRows` end up empty, and it explicitly
raises rather than run an unconstrained `SELECT *`). Every one of those
original scan calls was silently failing with that JSON-RPC error, and the
"0 non-FB2 books found" conclusion was actually "0 books returned at all,
every page" misread as a clean negative — the substring check
(`grep -o '"has_text":false'`) returns an empty count either way, so the bug
went unnoticed until this was rediscovered independently while working on a
later fix round. The number above (2,200 books, 0 non-FB2) is from a
corrected scan using `lang:"ru"` as a real, non-blank filter, which is not
rejected. `search_books` itself was not touched by any of this at the time —
the bug was in `PrepareSearchData`'s pre-existing "at least one filter
required" behavior, not a regression from Task 10's own work — but the
original claim, resting on a scan that never actually ran, should not have
been stated as confirmed. This specific combination (every field blank plus
`include_deleted: true`) is fixed as of the literal-substring-matching task
above: `search_books` now detects it itself and returns
`isError: true`/`"code":"empty_filter"` instead of letting
`PrepareSearchData`'s raw exception text reach the client — see case `33`.
