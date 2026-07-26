# Ship the MCP server and document it in the help

**Date:** 2026-07-26
**Status:** Approved

## Problem

`Utils/MHLMcpServer` exposes the MyHomeLib collection to AI assistants over
MCP, but it reaches no user: `Installer/Common.iss` does not package
`MHLMcpServer.exe`, and the help says nothing about it. The only description
is `Utils/MHLMcpServer/README.md`, which is developer-facing English aimed at
someone building from source.

## Scope

1. Package `MHLMcpServer.exe` in both installers.
2. Add one end-user help topic describing it, in Ukrainian.

Out of scope: any change to the server itself, and any `build_installer.cmd`
change (not needed, see below).

## Design

### 1. Installer

`SourceFolder` already resolves to the build output that contains the server:
`..\Program\Out\Bin64\` in `Setup_Script_MyHomeLib_x64.iss` and
`..\Program\Out\Bin\` in `Setup_Script_MyHomeLib.iss`. The group project
already builds `MHLMcpServer.exe` into both. So a single `[Files]` entry in
`Installer/Common.iss`, following the existing `MHLIcons.dll` pattern, is
enough:

```
Source: {#SourceFolder + 'MHLMcpServer.exe'}; DestDir: {app}; Flags: replacesameversion
```

Placed after the `sqlite3.dll` line. Both installers `#include "common.iss"`,
so both pick it up.

`build_installer.cmd` needs no change. It stages only files Inno cannot reach
directly (help from source, licences from `Licenses\`, SQLite from a
platform-specific folder); this exe sits in the build output Inno already
points at.

`sqlite3.dll` — the server's load-time dependency, without which the process
will not start at all — is already installed into `{app}` for the app itself,
so the server works as soon as it is installed.

The server installs unconditionally rather than behind a `[Tasks]` checkbox.
It is inert unless an MCP client launches it, this matches how AlReader and
the converters already ship, and a wizard checkbox would ask users to decide
about "MCP" before the help page explaining it exists on disk.

### 2. Help topic

New file `Program/Help/mcp_server.html`, declared in
`tools/help/topics.json` under the «Додаток» section after
«Експорт та імпорт даних користувача»:

```json
{ "file": "mcp_server.html", "title": "MCP-сервер для AI-асистентів" }
```

Then `node tools/help/build_nav.js` scaffolds the file from its template and
rewrites the `<!-- TOC:BEGIN -->` block in every existing page. That produces
a 55-file diff — one added `<li>` per page — which is mechanical and expected,
not a sign something went wrong.

### 3. Page content

Ukrainian, end-user prose in the register the existing pages use: `<h2>`
headings, full-sentence paragraphs, `<code>` for paths and file names.

| Heading | Covers |
| --- | --- |
| Що це таке | An AI assistant can read the library and answer questions about it. The server is a companion executable the assistant launches on demand, not a background service and not something with a window of its own. |
| Що сервер уміє | Catalogue side: list collections, authors, series, genres; search books; fetch one book's details. Text side: table of contents, book text, search inside a book. |
| Як підключити | The `.mcp.json` snippet pointing at `C:\Program Files\MyHomeLib\MHLMcpServer.exe`. The server takes no arguments and has no settings of its own. |
| Сервер лише читає | It never writes to the database and never changes books. It works with MyHomeLib closed. |
| Обмеження | Text tools work only with FB2 (loose or zipped); the collection is briefly unavailable while the app imports or updates it; search matches literal substrings, not fuzzy; long result lists are paged and capped; extracted text is cached under `%LOCALAPPDATA%\MyHomeLib\McpCache`. |

### 4. `help.css`

No existing page uses `<pre>`, and `help.css` styles only inline `code`/`kbd`.
The `.mcp.json` snippet is the first code block in the help, so add a minimal
`pre` rule reusing the existing `--code-bg` custom property, which already has
a dark-mode value under the file's `prefers-color-scheme` block. Reusing the
variable means the block matches inline `code` and inherits dark mode without
a second declaration.

### 5. No `unit_HelpTopics.pas` change

That unit maps F1 `HelpContext` IDs from forms to help files. No form points
at this topic, and `check_help.js` only requires the reverse direction (every
mapped file must be declared in `topics.json`), so nothing there needs
touching. The page is reachable from the TOC rendered on every page.

## Files touched

| File | Change |
| --- | --- |
| `Installer/Common.iss` | One `[Files]` entry for `MHLMcpServer.exe` |
| `tools/help/topics.json` | One topic under «Додаток» |
| `Program/Help/mcp_server.html` | New page |
| `Program/Help/help.css` | `pre` rule |
| `Program/Help/*.html` (54 files) | Regenerated TOC block, one added `<li>` each |

## Known caveat

This publishes a component that TODO item 1 still lists as Open, awaiting
manual verification against the running app. Accepted deliberately: both
shipping the exe and documenting it are reversible.

## Verification

- `node tools/help/check_help.js` passes. It enforces the `<title>` format,
  the TOC and BODY markers, `lang="uk"`, absence of a BOM, absence of `<img>`
  and `<script>`, that no undeclared file sits in `Program/Help`, and that
  every internal link resolves.
- Read the rendered page in a browser, light and dark, and confirm the code
  block and the TOC entry look right.
- Installer packaging is verified by building it (`Installer/build_installer.cmd`)
  and confirming `MHLMcpServer.exe` lands next to `MyHomeLib.exe`, or by
  inspecting the compiled setup. This needs Inno Setup 6 at
  `C:\Program Files (x86)\Inno Setup 6\ISCC.exe`.
