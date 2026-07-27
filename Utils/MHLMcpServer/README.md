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

### `search_books` deep-paging performance pitfall

`offset` is not a `LIMIT ... OFFSET ...` clause pushed down to SQLite — the
paging loop in `SearchBooks` (`unit_MCP_Tools_Library.pas`) walks
`IBookIterator.Next` one row at a time and counts skipped rows in Delphi
until `Offset` is reached, then starts collecting. A large `offset` is
therefore linear in `offset` itself, not free: measured against the real
525k-book collection, `search_books(offset: 400000, ...)` takes about 18
seconds to return its first page, versus a near-instant response at
`offset: 0`. A client paging deep into a large result set (rather than
narrowing the filter) should expect this cost — it is documented on the
tool's own `offset` schema field for the same reason.

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

## Internal errors never leak exception text to the client

`unit_MCP_Protocol.pas`'s `DispatchRequest` used to send `E.Message` straight
into the JSON-RPC `-32603` response for any exception that was not
`EArgumentException` and did not go through `EMcpToolError` — the catch-all
for whatever every other sanitizing call site in this project (`LogToStderr`
plus `EMcpToolError`, throughout `unit_MCP_Tools_Library.pas` and
`unit_MCP_Tools_Text.pas`) did not anticipate. Two concrete leaks reached
that catch-all, confirmed against the real collection and the built exe:

- A NUL in `search_books`'s `genre` argument (see the next section) reached
  `sqlite3_prepare_v2` and produced an `ESQLiteException` whose message is
  the **entire generated SQL statement** (`SQLiteWrap.pas` formats the SQL
  into every error it raises) — hundreds of characters of the server's own
  query text, verbatim, in a client-facing `-32603`.
- A book's cached `.txt` held open under `FileShare.None` by another process
  (e.g. a second server instance mid-read of the same book) makes
  `get_book_text`'s `TFileStream.Create` raise an `EFOpenError` whose message
  is the **absolute cache file path** —
  `C:\Users\<user>\AppData\Local\MyHomeLib\McpCache\<key>.txt` — again
  verbatim in a client-facing `-32603`.

Fixed by making the catch-all itself sanitize: it now logs `E.ClassName` and
the full `E.Message` to stderr via a private `LogToStderr` (the same
one-line-per-unit pattern `unit_MCP_Tools_Library.pas`/`unit_MCP_TextCache.pas`
each already keep, kept private here too rather than imported, since this
unit sits *below* `unit_MCP_Tools_Library` in the dependency graph) and sends
the client only `Internal error while handling "<method>"` — the method name
plus nothing else. Every other exception class already reaching `SendError`
was already sanitized before this fix (an `EArgumentException`'s own message
is this project's own fixed text, never derived from caller data); this was
the one remaining gap, and it was the catch-all specifically because it is
where every future *unanticipated* leak would land too.

Measured before/after (`get_book_text` on a cache file locked under
`FileShare.None` by another handle):

```
before: {"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Cannot open file \"C:\\Users\\...\\AppData\\Local\\MyHomeLib\\McpCache\\1_487024_2710627584_20230222224011903.txt\". The process cannot access the file because it is being used by another process"}}
after:  {"jsonrpc":"2.0","id":1,"error":{"code":-32603,"message":"Internal error while handling \"tools/call\""}}
```

(stderr, developer-visible only, after the fix:
`DispatchRequest(tools/call): EFOpenError: Cannot open file "...\1_487024_..._....txt". The process cannot access the file because it is being used by another process`.)

## `search_books` argument type strictness

`ArgStr`/`ArgInt`/`ArgBool` (`unit_MCP_Json.pas`) used to call
`TJSONValue`'s *defaulting* `GetValue<T>(Name, Default)` overload, which
internally calls `TryGetValue<T>` and falls back to `Default` on **any**
failure — an absent argument and a present-but-wrong-typed one were
indistinguishable, both silently producing `Default`. `RequireInt` (used for
the required `collection_id`/`book_id` integers) never had this problem: it
already distinguished "absent" from "present" and raised `invalid_params` on
a genuine type mismatch. Measured against the real collection, before this
fix:

| call | result |
|---|---|
| `search_books{collection_id:1, title:"Белка"}` | `total_count: 26` |
| `search_books{collection_id:1, title:{"a":1}}` | `total_count: 439393` (the whole non-deleted collection — an object silently became `''`, i.e. no title filter at all) |
| `search_books{..., include_deleted:"yes"}` | silently `false` (the default, not `true`) |
| `search_books{..., limit:"abc"}` | silently `25` (the default), no `"clamped"` flag |

Fixed the same way `RequireInt` already worked: `Args.GetValue(Name) = nil`
(the key is genuinely absent) still returns `Default`; a present value goes
through the strict, non-defaulting `GetValue<T>(Name)` overload, which
raises `EJSONException` on a genuine type mismatch, mapped to
`EMcpToolError('invalid_params', ...)` naming the argument — identical shape
to `RequireInt`'s own except block. `ArgIntClamped` (used for
`limit`/`offset`/`length`/`max_hits`/`context_chars` across every tool) needed
no change of its own: it calls `ArgInt` internally, so the exception now
simply propagates through it.

One nuance, common to all four helpers (including `RequireInt`, which
already exhibited it): the RTL's own `TJSONValue.AsTValue`/`StrToTValue`
performs some conversions before failing outright — a JSON string that
parses as a number (`"42"`) still succeeds as an `Integer` argument, and a
JSON number still succeeds as a `String` argument (rendered as its decimal
text). That coercion is left alone for consistency between all four
helpers; only an outright-incompatible value (an object/array where a
scalar is expected, a non-numeric string for an integer, a non-boolean-shaped
string for a boolean) raises. See cases `42`–`44`.

Measured before/after for `search_books{collection_id:1, title:{"a":1}}`
(the `books` array itself omitted below — before the fix it holds a full
25-book page of the collection's own real data, unrelated to the malformed
call that produced it):

```
before: {"jsonrpc":"2.0","id":2,"result":{"content":[{"type":"text","text":"{\"books\":[...25 real books, the whole non-deleted collection's first page...],\"total_count\":439393,\"has_more\":true}"}]}}
after:  {"jsonrpc":"2.0","id":2,"result":{"content":[{"type":"text","text":"{\"code\":\"invalid_params\",\"message\":\"Argument title must be a string\"}"}],"isError":true}}
```

## `null` means absent

All five helpers (`ArgStr`, `ArgInt`, `ArgBool`, `ArgIntClamped`, `RequireInt`)
treat an explicit JSON `null` the same as an omitted key: `IsAbsent`
(`unit_MCP_Json.pas`) checks `Args.GetValue(Name)` for both `nil` (key not in
the object at all) and `TJSONNull` (`"key": null`), since the RTL's
`TJSONObject.GetValue` returns the latter, not `nil`, for an explicit null.
`ArgStr`/`ArgInt`/`ArgBool` fall back to their `Default` for either;
`RequireInt` reports either as `invalid_params`, `"Missing required
argument: <name>"` — a `null` `book_id` is "missing", not "must be an
integer". This is deliberate: MCP clients generated from JSON Schema
routinely emit `"series": null` for an optional the caller left unset, and
rejecting those would make the server needlessly awkward to drive.

This is unrelated to the type-strictness fix above — that one is about
values that are wrong for the slot (`"abc"` for an integer) and still raises
`invalid_params`; `null` is a well-formed way of saying nothing. See cases
`45` (a `search_books` call with `limit`/`series`/`include_deleted` all
`null` returns exactly what omitting them does) and `46` (`get_book` with
`book_id: null` is reported missing, not mistyped).

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
None of the three touches a real collection: `extract_tests.js` and
`cache_tests.js` are entirely fixture/temp-dir based, and `run_tests.js`
builds — and then talks to — a throwaway collection of its own, described
next.

### The fixture `run_tests.js` builds for itself

`run_tests.js` starts by running the server once in `--make-fixture` mode and
then runs every case against that same private library:

```
Program\OUT\Bin64\MHLMcpServer.exe --make-fixture uselocaldata user mcpfixture
Program\OUT\Bin64\MHLMcpServer.exe uselocaldata user mcpfixture
```

Both command lines carry the same `uselocaldata user mcpfixture` switches, and
that is the whole mechanism: `TMHLSettings.Create` scans the raw command line
in *both* processes (`unit_Settings.pas`), so both independently compute the
same `<exedir>\Data\mcpfixture.dbs` and the same
`<exedir>\mcpfixture\mcpfixture.hlc2`. The builder therefore writes the fixture
exactly where the server under test will look for it by construction, not by
the two sides agreeing on a path. `--make-fixture` mode itself contains no path
logic at all (see `unit_MCP_Fixture.pas`).

`mcpfixture.dbs` / `mcpfixture.ini` do not collide with the `user.dbs2` /
`myhomelib2.ini` a developer's real library uses in the same folder — a dev
library sitting in `Program\OUT\Bin64` survives a test run untouched, and the
suite in turn cannot see it. That is the point: before this, the DB-backed
cases were pinned to real book ids from one particular Librusec collection and
passed or failed depending on which library the exe happened to resolve at
startup.

`--make-fixture` wipes and rebuilds from scratch on every run — it deletes the
system database file and the collection folder first — which is what makes the
ids deterministic: the collection is always id 1 and the books are always
1..6, in insertion order. It prints a one-line JSON summary on stdout
(`collection_id`, `root`, `db`, `books`); the harness parses that line and
refuses to run the suite unless it reports collection 1 with six books.

The fixture, as built by `unit_MCP_Fixture.pas`:

| id | Title | Author | Series / seq | Genre (FB2 code) | Lang | LibRate | Deleted | Body |
|---|---|---|---|---|---|---|---|---|
| 1 | `Тихий вечер` | Іваненко Петро | `Хроніки` / 1 | `prose_contemporary` | `uk` | 0 | no | 2 sections |
| 2 | `Гроза 100% певна` | Іваненко Петро | `Хроніки` / 2 | `prose_contemporary` | `uk` | 4 | no | 3 sections |
| 3 | `Пісня_про_море` | Ковальчук Ольга | — | `sf_action` | `uk` | 0 | no | flat |
| 4 | `О'Генрі та інші` | Ковальчук Ольга | `Збірка "Класика"` / 1 | `love_history` | `ru` | 5 | no | flat |
| 5 | `Книга з "лапками"` | Шевченко Іван | — | `sf_action` | `en` | 0 | no | flat |
| 6 | `Вилучена книга` | Шевченко Іван | — | `prose_contemporary` | `uk` | 0 | **yes** | flat |

Every column is load-bearing:

- **Title** — carries the LIKE and quote metacharacters the literal-matching
  fix exists for: `%` (book 2), `_` (book 3), `'` (book 4) and `"` (book 5).
  Cases `28`–`31` and `37`–`38` search for those characters in both
  directions. Positively: a value containing `%`, `_`, `'` or `"` must still
  match the one book whose title really contains it, so an over-aggressive
  escape that matched nothing fails. Negatively: a value containing `%` or `_`
  that no title actually holds must match *nothing*, so a leaked wildcard —
  which would sweep in every book of two characters or more — fails too.
- **Author** — three authors over six books, each shared by exactly two, so an
  author filter is a genuine multi-row query (`39`) and `14`/`15` can vary only
  the `include_deleted` flag over one author's two books.
- **Series / seq** — one ordinary series (`Хроніки`, two books in sequence, the
  paging pair `10`/`11`/`13` use) plus one whose title contains a `"`
  (`Збірка "Класика"`), which case `34` searches in lowercase to prove `series`
  is still matched case-insensitively *and* literally after the escaping fix.
  Books 3, 5 and 6 have no series, so the empty-series shape is covered too.
- **Genre (FB2 code)** — the fixture names genres by their FB2 code and lets
  `InsertBook` map them through the collection's genre cache, so the internal
  codes (`prose_contemporary` = `0.3.3`, `sf_action` = `0.1.1`,
  `love_history` = `0.4.1`) are never hard-coded. Case `16` proves the codes
  `list_genres` reports really work as `search_books` input.
- **Lang** — three distinct values (`uk`, `ru`, `en`) so case `40` can pin
  `lang`'s substring (not exact-match) semantics with a value, `"r"`, that
  matches exactly one of them and would have matched none under the old
  behaviour.
- **LibRate** — 4 on book 2 and 5 on book 4, nothing else rated, so case `32`
  can prove `min_lib_rate` is a *minimum*: `5` returns only book 4, `4` returns
  both.
- **Deleted** — exactly one deleted book, sharing an author with a live one, so
  `14`/`15` isolate the `include_deleted` polarity fix.
- **Body** — books 1 and 2 are the only ones with `<section>` titles (two and
  three respectively); the rest are a single untitled section. That gives the
  text tools a real table of contents to walk (`22`), real section offsets to
  round-trip through `get_book_text` (`23`) and `search_in_book` (`26`), while
  keeping the whole library a few hundred bytes.

The two structured books' extracted texts are 70 and 85 UTF-16 code units
long. That is deliberately tiny and still sufficient for `24`/`25`: the text
tools' clamps are on the *argument range*, not on the text size
(`length` → [1, 50000], `offset` → [0, MaxInt], `max_hits` → [1, 50],
`context_chars` → [0, 2000]), so `length: 999999` still sets `"clamped":true`
against a 70-character book.

`Program/OUT` is build output, so a `git clean` there removes
`Data\mcpfixture.dbs` and the `mcpfixture\` folder along with everything else.
Nothing needs restoring by hand — the next `run_tests.js` run rebuilds both
before the first case, and would have rebuilt them anyway.

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

Seven of `run_tests.js`'s cases (`01_ping`, `02_initialize`,
`03_unknown_method`, `04_unknown_tool`, `05_non_object_line`,
`06_non_object_params`, `07_non_object_arguments` — everything that never
reaches a tool handler) never touch `DMUser` or the system database at all.
`05_tool_error.jsonl` calls `get_book_text` with a nonexistent
`collection_id: -1`, exercising the domain-error path (`collection_not_found`)
without reaching a collection; every registered tool is wrapped in
`Guarded(...)`, which is what lazily boots `DMUser`, so this case still needs
a system database to exist — which, since the harness builds the fixture
first, it always does. `08_get_book_invalid_params.jsonl` and
`09_get_book_collection_not_found.jsonl` exercise `get_book`'s argument
validation (`RequireInt` rejecting a non-integer `collection_id`) and
`CollectionOrFail`'s not-found path respectively; both go through
`Guarded(...)` the same way. **All cases in this suite still
require `sqlite3.dll` to be resolvable next to the exe**, regardless of which tool
(if any) is called — see the load-time dependency note above — since the
process cannot start at all without it. `list_collections` is covered by the
manual checklist above because it needs a real, populated collection list to
be meaningful, not the fixture's single entry.

`10_search_books_found.jsonl`, `11_search_books_limit_clamped.jsonl`,
`12_search_books_collection_not_found.jsonl` and
`13_search_books_offset_paging.jsonl` exercise `search_books` against the
fixture collection (`collection_id: 1`). `10`, `11` and `13` share one
two-row query — `series: "Хроніки"`, the fixture's sequence pair, books 1 and
2 — so that the plain search, the limit clamp and the offset skip are all
measured on the same result set. `include_deleted: true` is kept for the
reason it was originally there: it takes the deleted-books filter out of play
entirely, so these three test search/clamping/paging mechanics and nothing
else — `14`/`15` own the deleted-books behavior. `10` expects both books,
`total_count: 2`; `11` adds `limit: 5000` and expects the same two rows plus
`"clamped":true` (clamping is decided from the requested limit alone, before
any row is fetched, so it shows up even though only two rows exist); `13`
walks the same result set as two single-row pages, so both polarities of
`has_more` are pinned — `limit: 1` returns book 1 with `has_more: true`, and
`limit: 1, offset: 1` returns book 2 with `has_more: false`, both reporting
the same `total_count: 2`.

`14_search_books_excludes_deleted_by_default.jsonl` and
`15_search_books_include_deleted.jsonl` prove the `include_deleted` polarity
fix behaviourally: both search `author: "Шевченко"`, whose two books are 5
(live) and 6 (`Вилучена книга`, the fixture's one deleted row). The two cases
differ by exactly the flag. `14` (no `include_deleted`) expects only book 5,
`total_count: 1`; `15` (`include_deleted: true`) expects both,
`total_count: 2`.

`16_list_genres_and_search_genre_round_trip.jsonl` calls `list_genres` on
collection 1 (asserting the full 317-entry tree byte-for-byte — the tool has
no `limit`/`filter` by design, see above) and then `search_books` with
`genre: "0.3.3"`, a code taken from that tree, proving the whole point of
`list_genres`: that its codes actually work as `search_books` input. The
expected tree is not a capture — it is derived from
`Installer/Common/genres_fb2.glst`, the same file the fixture collection is
created from, sorted by genre code. This is also the case that caught the
genre-filter pitfall documented above — without that fix, the `search_books`
call in this file fails with a SQL syntax error instead of returning a book.
`17_list_series_filter_found.jsonl` and `18_list_authors_filter_found.jsonl`
prove `filter` finds rows (`"Хроніки"` for series, `"Ковальчук"` for authors).
`19_list_authors_limit_clamped.jsonl` reuses the single-match `"Ковальчук"`
filter with `limit: 5000` — clamping is decided from the requested limit alone
(`ArgIntClamped` compares it against `Max` before any row is fetched), so
`"clamped":true` shows up even though the actual result set here is one row.
`20_list_series_collection_not_found.jsonl` exercises `CollectionOrFail`'s
not-found path through `list_series`, standing in for all three new tools
(they all call `CollectionOrFail` first, identically to `get_book` and
`search_books`).

`21_search_books_genre_injection_contained.jsonl` proves the single-quote
escaping fix contains a hostile `genre` value: `"x'); DROP TABLE Books; --"`
(a single quote plus a destructive-looking `DROP TABLE`/comment-marker tail)
against the fixture collection returns a clean
`{"books":[],"total_count":0,"has_more":false}` — zero matches, no
`isError`, no SQL error text, no build path. It proves containment for this
one field on this one query shape; it is not a general injection-free proof
of the server. The other fields it names (`title`, `author`, `series`,
`lang`, `keyword`, `annotation`, `min_lib_rate`) were fixed in a later task —
see "`search_books` free-text arguments: literal substring matching" above
and cases `28`–`34` below.

`22_get_book_toc.jsonl` through `27_get_book_toc_book_not_found_no_path_leak.jsonl`
cover the three text tools against the fixture's two structured books: book 2
(three titled sections, `total_length: 85`) and book 1 (two titled sections,
`total_length: 70`). Every offset and length below is derived from the FB2
template in `unit_MCP_Fixture.pas` run through `TFb2Walker`'s rules — a
section's span is recorded *after* its own title has been appended, and each
`<p>` contributes its text plus one line break — not read back off a run.
`22_get_book_toc.jsonl` asserts `get_book_toc`'s full section list for book 2
byte-for-byte, including `level` on every entry: `Вступ` at offset 0
(length 27), `Середина` at 27 (length 30), `Кінець` at 57 (length 28), with
`structured: true`.
`23_get_book_text_toc_round_trip.jsonl` feeds section 2's own `offset` (`27`)
and its own `length` (`30`) back into `get_book_text` and asserts the returned
text is exactly that section — its title, then its paragraph — the round trip
the whole `get_book_toc`/`get_book_text` pair exists to support.
`24_get_book_text_clamped.jsonl` requests `length: 999999` on book 1 at
`offset: 40` (near the end, so the returned slice is 30 characters, not the
whole book) and asserts `"clamped":true`. The clamp is on the *argument*
(`length` is compared against 50000 before any text is sliced), so a
70-character book exercises it exactly as a 200K-character one would.
`25_get_book_text_invalid_offset.jsonl` requests `offset: 99999` against
book 1's `total_length: 70` and asserts `isError:true` with
`"code":"invalid_offset"` and the total in the message.
`26_search_in_book_round_trip.jsonl` searches book 2 for
`"Абзац розділу 2."` with `context_chars: 10`, asserts the single hit's
`offset` (`39`) and its padded `passage` (the 10 characters either side,
clamped to the text's bounds), then feeds that same `offset` into a second
`get_book_text` call with `length: 16` and asserts what comes back is exactly
the phrase — the match offset really is the phrase's own start, not the
passage's. `27_get_book_toc_book_not_found_no_path_leak.jsonl`
requests a nonexistent `book_id: 999999999` and asserts the response is
exactly `{"code":"book_not_found","message":"Book 999999999 not found"}` —
no build-machine path, no assertion text; a fixed point release regressed
this (interpolating the caught exception's own message, which for an
invalid ID reaches an `Assert` deep in `unit_Database_SQLite.pas` carrying
its source path) and this case pins the sanitized shape going forward.

`28_search_books_title_double_quote_literal.jsonl` through
`34_search_books_series_case_insensitive_literal.jsonl` cover the
literal-substring-matching fix described above. The fixture's titles carry the
metacharacters on purpose, so each of these searches for a character that
really occurs in exactly one book. `28` searches `title: "\"лапками\""` (with
the quote characters as part of the value) and gets exactly book 5
(`total_count: 1`) — a title containing a `"` no longer breaks the query or
widens the match. `29` covers `_` in both directions in two calls:
`title: "_%_"` gets `total_count: 0`, since no fixture title contains that
three-character sequence, whereas treating both characters as wildcards would
make `%_%_%` match every title of two characters or more, i.e. all five
non-deleted books; then `title: "_про_"` gets exactly book 3
(`Пісня_про_море`, `total_count: 1`), the positive half — an escape so
aggressive that it matched nothing would pass the first call and fail this
one. `30` searches `title: "О'Генрі"` (an embedded literal
single quote) and gets exactly book 4 (`total_count: 1`). `31` searches
`title: "x' OR '1'='1"` — the classic injection shape — and gets a clean
`total_count: 0`, no `isError`, no SQL text, no build path: the payload is
matched as an inert literal, not executed as SQL. `32` proves `min_lib_rate`
is a *minimum* rather than the equality the old code silently produced, in
two calls against the only two rated books: `min_lib_rate: 5` returns book 4
alone (`total_count: 1`), `min_lib_rate: 4` returns books 2 *and* 4
(`total_count: 2`). Under the old exact-match behaviour the second call would
have returned book 2 only. `33` calls `search_books` with only
`collection_id`/`include_deleted: true` (no other field set) and gets
`isError: true`, `"code":"empty_filter"` instead of a raw `-32603`. `34`
searches `series: "збірка \"класика\""` — the fixture's quoted series title,
in lowercase — and gets book 4 (`total_count: 1`), confirming in one call that
`series` is still matched case-insensitively *and* that the `"` inside it is
matched literally.

`35_search_books_title_nul_rejected.jsonl` through
`40_search_books_lang_substring_semantics.jsonl` were added in a fix round
after review flagged that `29`/`31` prove only containment (they assert
`total_count: 0`, so they would still pass if the escaping were
*over*-aggressive and matched nothing at all) and that a NUL in a text
argument was a real regression this task's own diff introduced. `35`
searches `title` containing a single NUL character and gets
`isError: true`, `"code":"invalid_params"` naming `title` — before this fix
the same call returned the entire non-deleted collection (see "Residual
limitations of literal matching" above for the full before/after). `36`
searches a 4001-character `title` and gets `isError: true`,
`"code":"invalid_params"` naming the argument, its length, and the
4000-character limit. `37` searches `title: "100% певна"` — a substring of
book 2's title that straddles its `%` — and gets that one book, a
**positive** literal match (as opposed to `29`'s proof-by-absence): if the
escaping were over-aggressive and matched nothing, this case fails. `38`
makes the same point with a value that is *entirely* a bare `%`, in two calls
against two different fields: `title: "%"` returns book 2 alone
(`total_count: 1`), the one title that really contains a percent sign — not
all five non-deleted books, which is what a live wildcard would return — and
`series: "%"` returns `total_count: 0`, because no series title contains one,
rather than the three series-bearing books a live wildcard would match. `39`
searches `author: "Ковальчук"` and gets books 3 and 4 (`total_count: 2`),
covering a field other than `title`/`series` with a positive match. `40`
searches `lang: "r"` and gets book 4 (`total_count: 1`) — the fixture's only
`lang: "ru"` row. No fixture `Lang` value *is* `"r"`, so under `lang`'s old
*exact*-match behavior this call matched nothing; the case pins the
exact-to-substring semantics change as a deliberate, tested decision rather
than an unverified side effect.

`41_search_books_genre_nul_rejected.jsonl` through
`44_search_books_limit_wrong_type_rejected.jsonl` were added in the final
pre-merge fix round. `41` searches `genre` containing a NUL and gets
`isError: true`, `"code":"invalid_params"` naming `genre` — before this fix
`genre` was the one free-text argument that never called the NUL/length
guard at all (it never went through `LiteralLikeCondition`, see that
function's comment and `ValidateFreeTextArg` above), so the same call used
to reach `sqlite3_prepare_v2` with a truncated statement and surface a raw
`-32603` carrying the entire generated SQL text. `42` searches
`title: {"a":1}` (a JSON object where the schema documents a string) and
gets `isError: true`, `"code":"invalid_params"`, `"message":"Argument title
must be a string"` — before the `ArgStr`/`ArgInt`/`ArgBool` fix (see
"`search_books` argument type strictness" above) this silently became an
empty title filter and returned the whole non-deleted
collection. `43` and `44` cover the same fix for `ArgBool`
(`include_deleted: "yes"`, previously silently `false`) and `ArgInt`
(`limit: "abc"`, previously silently `25` with no `"clamped"` flag)
respectively, both now `isError: true`/`"code":"invalid_params"` naming the
argument.

`45_null_optional_treated_as_absent.jsonl` and
`46_null_required_reports_missing.jsonl` cover the `null`-means-absent
convention (see "`null` means absent" above). `45` runs the same
`search_books` call twice — once omitting `limit`/`series`/`include_deleted`,
once passing all three as explicit `null` — and asserts the two responses are
identical (modulo `id`); before the fix, the second call answered
`invalid_params` instead, because a `null` handed to `ArgInt`/`ArgBool`
reached the strict `GetValue<T>` and raised. `46` calls `get_book` with
`book_id: null` and gets `isError: true`, `"code":"invalid_params"`,
`"message":"Missing required argument: book_id"` — before the fix the same
call answered `"Argument book_id must be an integer"`, a genuine type
mismatch, since `RequireInt` did not yet distinguish `null` from a merely
absent key.

There is no automated case for `get_book_text`'s `unsupported_format` path:
the fixture writes every one of its six books as an FB2 file, so nothing in
it can produce that code. `unsupported_format` is covered by unit-level
reasoning instead (`Book.GetBookFormat in [bfFb2, bfFb2Archive]` in
`LoadBookForText`) and belongs on the manual checklist above for whoever next
runs this against a mixed-format collection. Likewise there is no automated
case for `file_missing` on a text tool directly through `run_tests.js` (it
needs an archive to go missing/renamed underneath a registered collection —
verified manually instead during the fix rounds below, by temporarily
renaming a real archive and restoring it) — see the manual checklist.

**Correction to an earlier draft of this note, kept because of what it
taught:** back when `unsupported_format` was ruled out by scanning the
maintainer's real Librusec collection rather than by construction, the very
first version of that scan used `search_books` with no filter field at all
besides
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
later fix round. The re-run that finally supported the claim (2,200 books
sampled across the ID range, 0 non-FB2) used `lang:"ru"` as a real, non-blank
filter, which is not rejected.
`search_books` itself was not touched by any of this at the time —
the bug was in `PrepareSearchData`'s pre-existing "at least one filter
required" behavior, not a regression from Task 10's own work — but the
original claim, resting on a scan that never actually ran, should not have
been stated as confirmed. This specific combination (every field blank plus
`include_deleted: true`) is fixed as of the literal-substring-matching task
above: `search_books` now detects it itself and returns
`isError: true`/`"code":"empty_filter"` instead of letting
`PrepareSearchData`'s raw exception text reach the client — see case `33`.
