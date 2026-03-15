# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Delphi Skill

All Delphi conventions (DFM editing rules, MSBuild commands, VCL gotchas, naming conventions, git commit prefixes, etc.) are in `~/.claude/skills/delphi-dev.md`. Always load and follow that skill when working in this repo.

## Project Overview

MyHomeLib is a Delphi VCL desktop application for managing a home e-book library. It supports cataloging local book collections and working with online libraries (Librusec/Flibusta). Books are stored as FB2, FBD, or raw formats in SQLite databases.

## Build

Build the full project group (components package + main app):
```
cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MHL.groupproj /t:Build /p:Config=Release /p:Platform=Win32 /nologo /v:minimal" 2>&1
```

Build only the main app (when components haven't changed):
```
cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MyhomeLib.dproj /t:Build /p:Config=Release /p:Platform=Win32 /nologo /v:minimal" 2>&1
```

Build output: `Program/OUT/BIN/` (executables), `Program/OUT/Units/` (DCUs).

## Architecture

### Project Structure
```
Program/
  MyHomeLib.dpr          - Main project file
  MHL.groupproj          - Group project (MHLComponents + MyHomeLib)
  Forms/                 - VCL forms (frm_*.pas)
  Forms/Editors/         - Editor dialogs (frm_edit_*.pas, frm_EditAuthorEx.pas)
  DataModules/           - dm_user.pas (global data module, settings + system DB)
  Units/                 - Core units (globals, settings, interfaces, helpers)
  DAO/                   - Data access layer (abstract base classes)
  DAO/SQLite/            - SQLite implementation of DAO interfaces
  ImportImpl/            - Book import threads and progress forms (FB2, FBD, INPX)
  DwnldImpl/             - Book download threads and progress forms
  UtilsImpl/             - Sync, export-to-device, library update threads
  Wizards/               - New Collection wizard (multi-step frame-based wizard)
  Resources/             - Icons, images
Components/
  MHLComponents/         - Design-time component package (BookTreeView, FB2 parsing, archive helpers)
Utils/
  MHLSQLiteConsole/      - Standalone SQLite console utility
  MHLSQLiteExt/          - C++ SQLite extension DLL (custom functions)
Installer/               - Inno Setup scripts (.iss)
```

### Key Architectural Patterns

**DAO Layer (Interface-based):**
- `ISystemData` — manages collections, groups, user data, book metadata (defined in `unit_Interfaces.pas`)
- `IBookCollection` — per-collection operations: CRUD for books/authors/genres/series, search, import/export
- Abstract base classes: `TSystemData` (in `unit_SystemDatabase_Abstract.pas`), `TBookCollection` (in `unit_Database_Abstract.pas`)
- Concrete implementation: `DAO/SQLite/` — only SQLite backend exists
- Iterator pattern: `IIterator<T>`, `IBookIterator`, `IAuthorIterator`, `IGenreIterator`, `ISeriesIterator`

**Global Access Pattern:**
- `DMUser` (TDataModule) — created first at startup, holds `TMHLSettings` and `ISystemData`
- Free functions `Settings()` and `SystemDB()` in `dm_user.pas` provide global access
- Startup order: `DMUser.Init` -> `frmMain` -> `frmGenreTree`

**Core Domain Types (in `unit_Globals.pas`):**
- `TBookRecord`, `TBookKey` (BookID + DatabaseID), `TAuthorData`, `TGenreData`, `TSeriesData`
- `TBookFormat` — bfFb2, bfFb2Archive, bfFbd, bfRaw, bfRawArchive
- `COLLECTION_TYPE` — integer-based collection type identifier

**Threading:**
- Background operations use `TWorkerThread` base class (in `ImportImpl/unit_WorkerThread.pas`)
- Import, export, download, sync — all run in separate threads with progress forms
- Progress forms inherit from `TProgressFormBase`

**MHLComponents Package:**
- Must be built before the main app (group project handles this)
- Contains: `BookTreeView` (VirtualTreeView-based), FB2/FBD parsers, archive helpers, custom UI controls
- Uses VirtualTreeView library (`VirtualTrees` unit)

### UI Strings Language

Resource strings in the codebase are in Ukrainian (`unit_Consts.pas`, `unit_MHL_strings.pas`). UI captions are also in Ukrainian.
