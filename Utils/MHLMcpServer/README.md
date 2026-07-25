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
- [ ] `list_genres` returns the same genre tree the app's genre panel shows.
- [ ] A genre code from `list_genres` used in `search_books(genre=…)` returns
      books of that genre.
- [ ] `list_series(filter=…)` finds a series you know exists.
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

**It is not free of it elsewhere.** `PrepareSearchData` builds `Title`,
`FullName` (author), `Series`, `Annotation`, `Lang`, `KeyWord`, `LibRate`,
plus the unused-by-this-tool `FileName`/`Folder`/`FileExt`, the same way:
each goes through `unit_SearchUtils.PrepareQuery`, which turns a bare value
into a raw SQL fragment (`="value"`, `LIKE "value"`, or the value verbatim if
it already contains `%`, `=`, `"`, or `LIKE`) with **no escaping of embedded
quotes at all**, and `AddToFilter` splices that fragment straight into the
WHERE clause. This is a deliberate app feature — `frm_main.pas`'s search
boxes let a user type native-ish query syntax (`="exact"`, `LIKE "%x%"`)
directly — but it means every one of those fields is exactly as spliced as
`Genre` was before this fix, and none of them received the same treatment
here. `search_books`'s `title`/`author`/`series`/`lang`/`keyword`/
`annotation`/`min_lib_rate` arguments are unescaped SQL-splice surfaces
today. Out of scope for this task (which only had to fix the field it needed
for the `list_genres` round trip to work at all) but a real gap, not a
hypothetical one.

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
of the server, and the README section above says plainly which other fields
(`title`, `author`, `series`, `lang`, `keyword`, `annotation`,
`min_lib_rate`) still splice caller input into SQL unescaped.
