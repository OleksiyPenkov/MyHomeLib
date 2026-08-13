# MyHomeLib

[Українська](README.md) · **English** · [Български](README.bg.md)

Manage your home e-book library: catalogue your own collection of book files, and work as a client for Librusec-engine online libraries.

[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.7.0-blue.svg)](https://github.com/OleksiyPenkov/MyHomeLib/releases)
[![Platform](https://img.shields.io/badge/platform-Windows%20x64%20%7C%20x86-lightgrey.svg)](#installation)
[![Built with Delphi](https://img.shields.io/badge/built%20with-Delphi%2013-red.svg)](#building-from-source)

## What it is

MyHomeLib is a Windows desktop application for cataloguing a collection of e-book files. Books are organised by author, series and genre, searchable by an arbitrary set of conditions, and open in whichever reader application you configure.

Beyond your own collections, MyHomeLib works as a client for libraries running the Librusec engine — Flibusta and similar sites. Such a library's catalogue is attached from an INPX file, after which you browse and search it locally and download from the server only the books you actually want.

Books are stored as FB2 (loose files or zip archives), FBD, or any other format; collection metadata lives in a SQLite database.

> **Note on interface language:** the UI is available in Ukrainian, English and Bulgarian (machine-translated). The bundled help is translated into all three languages too, and follows the interface language.

## Features

**Collections**

- Multiple collections at once, with instant switching between them.
- Collection types: local or network, your own or an attached external library, FB2 or non-FB2.
- New Collection wizard: an empty collection, one built from an INPX file, or an existing `.hlc2` file attached.
- Collection updates from the network and by hand, folder/file synchronisation, database maintenance.
- Copying books between FB2 collections, exporting a collection to INPX.

**Books**

- Import of FB2 (files and archives), FBD and other formats; bulk import from INPX.
- Browsing trees by author, series and genre, with Cyrillic and Latin alphabet filters.
- Search by author, title, series, genre, keywords, annotation, file name, date added, language and library rating — with `%text%`, `="exact value"`, `<`, `>`, `<>` and `OR` conditions — and named presets for reusable condition sets.
- Groups and favourites, ratings, reading progress and reviews; this user data exports and imports separately from the catalogue (matched by LibID).
- Downloading books from the online library, reading them in external applications chosen per file type.
- Sending books to a device with conversion: fb2mobi, fb2epub, fb2lrf, fb2pdf; file name and subfolder templates.
- Custom scripts run after a send-to-device, with `%DEST%`, `%TMP%`, `%FILENAME%` and other substitutions.
- Editing book and author details, exporting a book list to HTML.

**AI assistants**

- An MCP server (`MHLMcpServer.exe`) installs alongside the application and exposes the collection to assistants such as Claude: search books, browse authors, series and genres, read a book's table of contents and text, search inside a book. Read-only, and it does not need MyHomeLib to be running. Setup is covered in the help, under «MCP-сервер для AI-асистентів».

## Interface language

The UI is available in Ukrainian, English and Bulgarian. Switch it under **View → Interface language**; the change applies after a restart. All three languages are compiled into the executable, so no external file can replace or remove them. The bundled help is translated into all three languages too, and follows the interface language.

The genre tree follows the interface language too. Existing collections update themselves — genre names are stored inside the collection database, so they used to stay in whatever language the collection was created in.

**The Bulgarian translation is machine-made** and has not been reviewed by a native speaker; the language menu says so. If a string reads wrong, please open an [issue](https://github.com/OleksiyPenkov/MyHomeLib/issues) quoting it with a suggested replacement.

Additional languages load from translation catalogues placed next to the application (`Lang\<code>.json`). Only catalogues signed with the project key are loaded — an unsigned file is ignored and never appears in the menu. If you would like to translate the interface into your language, open an [issue](https://github.com/OleksiyPenkov/MyHomeLib/issues): a finished translation is signed and returned to you together with its signature file.

The project does not ship a Russian interface and does not sign Russian catalogues. This is a deliberate decision.

## Installation

Prebuilt installers for 64- and 32-bit Windows are published on the [Releases](https://github.com/OleksiyPenkov/MyHomeLib/releases) page. If the file you need is not there, you can build the installer yourself — see `Installer/build_installer.cmd` (requires [Inno Setup](https://jrsoftware.org/isinfo.php)).

Requirements: Windows 10 or newer. Disk space is driven mostly by the size of your book collections rather than by the application itself.

Portable mode is supported: if a `myhomelib2.ini` sits next to the executable, settings are read from it instead of `%APPDATA%`, so the application and its collection can travel together on removable media.

## Quick start

1. Install and launch the application.
2. **Collection → Create** — the wizard asks for the collection type, the book folder and the file format.
3. Fill the collection: import existing book files from disk, or build the catalogue from an online library's INPX file.
4. Browse the author, series and genre trees, search on the Search tab, and open books in your reader or send them to your device.

The bundled help covers all of this in detail.

## Help

The full help (55 pages, in Ukrainian, English and Bulgarian) ships with the application. **F1** is context-sensitive — it opens the page matching the active window or tab in your browser. The help sources live in [`Program/Help/`](Program/Help/); [`index.html`](Program/Help/index.html) is the table of contents and entry point.

## Building from source

**Prerequisites:**

- Delphi 13 (RAD Studio 37.0);
- [VirtualTreeView](https://github.com/JAM-Software/Virtual-TreeView) (install via GetIt);
- Konopka Signature VCL Controls (`BonusKSVC` 8.0.2, also via GetIt);
- `C:\Windows\System32` on `PATH` — the post-build event calls `robocopy`, and without it the build fails at `copy_help.cmd`;
- [Node.js](https://nodejs.org/) — optional. The pre-build event runs `Program\embed_lang.cmd`, which embeds the translation catalogues into the executable. Without Node.js the build still succeeds, but you get a Ukrainian-only application.

The translation catalogues (`Program/Lang/`) are not part of this repository. Without them the build succeeds and produces a Ukrainian-only application; see [`tools/lang/README.md`](tools/lang/README.md) for how to obtain them.

**Build through the group project only** — `Program\MHL.groupproj` builds the component package, the icon DLL, the main application and the MCP server in the right order:

```
cmd.exe /c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MHL.groupproj /t:Build /p:Config=Release /p:Platform=Win64 /nologo /v:minimal"
```

Swap `/p:Platform=Win64` for `/p:Platform=Win32` for the 32-bit build. Win64 is the primary target — build it first, but both must pass before a release.

> **Never run msbuild on `Program\MyhomeLib.dproj` directly.** It re-serialises the project file and moves the `CodeGear.Delphi.Targets` import above the config property groups, after which *every* subsequent build — the group build included — fails with `F2613 Unit 'SysUtils' not found`. The group project does not rewrite the file.

**Build output:** `Program/OUT/Bin64/` and `Program/OUT/BIN/` (executables), `Program/OUT/Units/` (DCUs). The post-build event stages the help folder and `Resources\Icons\<platform>\MHLIcons.dll` next to the exe — every icon is loaded from that DLL at runtime.

## Repository layout

```
Program/
  MyHomeLib.dpr        main project
  MHL.groupproj        group project (components + icons + app + MCP server)
  Forms/               VCL forms (frm_*.pas); Forms/Editors/ holds the editor dialogs
  DataModules/         dm_user.pas — global data module (settings, system DB)
  Units/               core: global types, settings, interfaces, helpers
  DAO/                 data access layer (abstract classes); DAO/SQLite/ is the implementation
  ImportImpl/          book import threads (FB2, FBD, INPX) and progress forms
  DwnldImpl/           book download threads
  UtilsImpl/           sync, export-to-device, collection update threads
  Wizards/             New Collection wizard
  Help/                bundled help (HTML, Ukrainian)
  Resources/           icons, images
Components/
  MHLComponents/       design-time component package (BookTreeView, FB2 parsing, archives)
Utils/                 helper utilities (see below)
Installer/             Inno Setup scripts
tools/                 development helper scripts (help, translation catalogues)
```

## Utilities

- **`Utils/MHLMcpServer`** — a read-only MCP (Model Context Protocol) server that exposes a MyHomeLib collection to clients such as Claude: search books, browse authors, series and genres, read a book's table of contents and text, search inside a book. It links the same DAO layer as the application, so it sees exactly the same collections. Unlike the other utilities it ships in the installer, next to `MyHomeLib.exe`. The user-facing description is in the help ([`mcp_server.html`](Program/Help/mcp_server.html)); the technical one is in [`Utils/MHLMcpServer/README.md`](Utils/MHLMcpServer/README.md).
- **`Utils/MHLSQLiteConsole`** — a standalone SQLite console for working with collection databases directly.
- **`Utils/MHLSQLiteExt`** — a C++ SQLite extension providing the custom functions the application uses.

## License

MIT — see [LICENSE](LICENSE). © 2008–2026 Oleksiy Penkov.

## Credits

Programming: Oleksiy Penkov, Nikolay Rymanov, eg.

Testing: eg, Evgeniy_V, albert, AlbanSpy, kaznelson, Olega.

## Feedback

Report bugs and suggest features on the [Issues](https://github.com/OleksiyPenkov/MyHomeLib/issues) page.
