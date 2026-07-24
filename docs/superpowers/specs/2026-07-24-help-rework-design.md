# Help rework: CHM → local HTML, Ukrainian

**Date:** 2026-07-24
**Status:** Approved

## Problem

The shipped help is `MyHomeLib.chm`, compiled September 2011 from a Help&Manual
project that no longer exists in this repo. It is:

- **Russian**, CP1251-encoded, while the application UI and README are Ukrainian.
- **Stale**: 43 topics describing the 1.x UI. Features added since (groups,
  ratings, VCL themes, view modes, INPX export, database maintenance, online
  sync, user-data export/import, file sorting) are absent; removed features
  (Fb2Fix integration, wolf-format conversion scripts, "upgrade from old
  versions") are still documented.
- **Broken**: `filter.htm` links to `search.htm`, which is not in the CHM.
- **Unbuildable**: no `.hhp` project, no HTML Help Workshop on the build
  machine, and the numeric-context-ID alias map is stored in a CHM section that
  `hh.exe -decompile` does not extract. Editing and recompiling would require
  re-authoring that map anyway.
- **Untracked**: `Installer/Common/` and `Program/OUT/` are both gitignored, so
  the only copies of the `.chm` are loose build artefacts.

## Solution

Replace the CHM with a folder of plain UTF-8 HTML shipped beside the
executable, opened in the user's default browser. Rewrite every topic in
Ukrainian against the current 2.6.0 UI.

### Why not the alternatives

- **Keep CHM** — requires installing a deprecated Microsoft tool, hand-rebuilding
  the lost context map, and Windows increasingly restricts the format.
- **Markdown → HTML build** — nicer authoring, but adds a build step to the
  release process for no user-visible gain.
- **Online docs only** — loses offline help, which a desktop library manager
  should have.

## Deliverable layout

Source of truth is `Program/Help/`, tracked in git.

```
Program/Help/
  index.html          TOC / welcome page
  help.css            single stylesheet; light + dark via prefers-color-scheme
  <topic>.html        one file per topic
```

(No `img/` directory — see **Screenshots** below.)

Every topic page has the same structure: a `<nav>` sidebar carrying the full
table of contents with the current entry marked, and a `<main>` content column.

The sidebar markup is **identical** on every page. It is generated once and
inserted into all pages, so a TOC change is a scripted find/replace between two
marker comments, not 50 hand edits:

```html
<!-- TOC:BEGIN -->
 ... generated nav ...
<!-- TOC:END -->
```

Pages are self-contained: no JavaScript, no external fonts, no CDN references.
They must render correctly when opened as `file://`.

## Code changes

Four files. Three existing `HtmlHelp()` call sites:

- `Forms/frm_main.pas` — `TfrmMain.OnHelpHandler` (~line 6392)
- `Forms/frm_main.pas` — `TfrmMain.ShowHelpExecute` (~line 6626)
- `Forms/frm_settings.pas` — `TfrmSettings.ShowHelpClick` (~line 549)

| File | Change |
|---|---|
| `Units/unit_Consts.pas` | `APP_HELP_FILENAME` becomes `'Help\index.html'` |
| `Units/unit_Settings.pas:1321` | `sfAppHelp` keeps resolving to `AppPath + APP_HELP_FILENAME`; no logic change, the constant carries it |
| **new** `Units/unit_HelpTopics.pas` | context-ID → topic-file table and the launcher; must also be registered in `MyHomeLib.dpr` |
| `Forms/frm_main.pas`, `Forms/frm_settings.pas` | call the launcher instead of `HtmlHelp`; drop `HTMLHelpViewer` / `HH_*` usage |

### `unit_HelpTopics.pas`

```pascal
function HelpTopicFile(ContextID: Integer): string;
procedure ShowHelpTopic(ContextID: Integer);
```

`HelpTopicFile` returns the bare file name for a context ID, or `index.html`
for any ID not in the table (including the `5001` sentinel already used on
controls that have no help). `ShowHelpTopic` resolves it against
`ExtractFilePath(Settings.SystemFileName[sfAppHelp])` and hands it to
`ShellExecute` with the `open` verb.

If the resolved file does not exist, show the standard "help file not found"
message rather than launching a browser at a dead path.

`OnHelpHandler` keeps its existing special case: `Data = 1` means "show the
table of contents", i.e. `index.html`.

### Context-ID map

Derived by inspecting the control that owns each `HelpContext` in the DFMs.

| ID | Owning control | Topic |
|---|---|---|
| 1 | `pgControl` (main tab control) | `index` |
| 2 | `frmMain` | `main_window` |
| 105 | menu «Книга» | `menu_book` |
| 108 | `tsDownload` | `download` |
| 110 | `frm_bases` | `collections` |
| 112 | menu «Колекція» | `menu_collection` |
| 117 | `frm_edit_author` | `editing` |
| 125 | `tsByGroup` | `groups` |
| 126 | `tsSearch` | `search` |
| 129 | `frm_add_nonfb2` | `import_nonfb2` |
| 132 | `tsInterface` | `set_interface` |
| 133 | `tsInternet` | `set_internet` |
| 135 | `tsByAuthor`, `tsBySerie`, `tsByGenre` | `browsing` |
| 136 | `frm_MHLWizardBase` | `new_collection` |
| 137 | `tsReaders` | `set_readers` |
| 140 | `tsScripts` | `set_scripts` |
| 143 | `tsDevices` | `set_device` |
| 144 | `frm_settings` | `settings` |
| 5001, unknown | — | `index` |

`146` appears only in `Forms/__history/frm_main.dfm.~1~` and is dead; it is not
in the table.

### DFM changes

The only DFM edits are three new `HelpContext` values on settings tabs that
currently have none and therefore fall through to the index:

| Tab | New ID | Topic |
|---|---|---|
| `tsProxy` | 145 | `set_internet` |
| `tsBehavour` | 147 | `set_other` |
| `tsFileSort` | 148 | `set_filesort` |

No other DFM is touched.

## Topics

54 files. One file per F1 target, so every context ID lands on a real page
rather than an anchor inside a shared page.

**Вступ** — `index`, `about`, `terms`, `faq`, `donate`

**Встановлення** — `install`, `upgrade`, `portable`

**Інтерфейс** — `interface`, `main_window`, `browsing`, `toolbar`, `hotkeys`,
`main_menu`, `menu_book`, `menu_collection`, `menu_tools`, `menu_view`,
`context_menus`

**Робота з колекціями** — `collections`, `coll_types`, `new_collection`,
`coll_params`, `copy_books`, `delete_collection`, `export_inpx`, `update`,
`sync_folders`, `genres`, `maintenance`

**Робота з книгами** — `books`, `add_books`, `import_fb2`, `import_nonfb2`,
`download`, `reading`, `selection`, `search`, `groups`, `rating`,
`export_device`, `export_html`, `delete`, `editing`

**Налаштування** — `settings`, `set_interface`, `set_readers`, `set_device`,
`set_internet`, `set_scripts`, `set_filesort`, `set_other`

**Додаток** — `scripts_examples`, `user_data`

### Mapping from the old CHM

| Old topic | Fate |
|---|---|
| `about`, `faq`, `termins`, `donate`, `install`, `portable` | rewritten, kept |
| `clear_setup` + `from_old` | merged into `upgrade` |
| `user_interfae` | renamed `interface` |
| `_.htm` | renamed `hotkeys` |
| `main_window`, `toolbar`, `main_menu`, `context_menu`, `book`, `collection`, `menu_tools` | rewritten; `context_menu` → `context_menus`, `book` → `menu_book`, `collection` → `menu_collection` |
| `author_list` + `book_list` | merged into `context_menus` |
| `collections`, `coll_types`, `col_param`, `book_copy`, `delete_collection`, `update`, `sync_folders`, `genrelist_structure` | rewritten; renamed to `coll_params`, `copy_books`, `genres` |
| `new_collections` | renamed `new_collection` |
| `exportxml` | renamed `export_inpx` |
| `books`, `add_books`, `importfb2`, `import_non_fb2`, `book_download`, `reading`, `book_selection`, `export_to_device`, `favorites`, `filter`, `delete`, `editing` | rewritten; renamed to `import_fb2`, `import_nonfb2`, `download`, `selection`, `export_device`, `groups`, `search` |
| `settings`, `interface`, `readers`, `set_export_device`, `internet`, `scripts_setttings`, `settings_other` | rewritten; renamed to `set_*` |
| `scripts_examples` | rewritten |
| `_fb2fix`, `scripts_wolf` | **dropped** — features gone |
| — | **new**: `browsing`, `menu_view`, `maintenance`, `rating`, `export_html`, `set_filesort`, `user_data` |

`search.htm` was referenced by `filter.htm` but never existed in the CHM. The
new `search` topic closes that gap.

The «Колекція → Імпорт» menu offers three entries — «Файли fb2 та fb2.zip»,
«Файли не-fb2», «Файли FBD (pdf.zip djvu.zip)». `import_fb2` covers the first;
`import_nonfb2` covers the second and third, since both drive the same
non-FB2 import dialog (`frm_add_nonfb2`, context ID 129) and differ only in
input format.

## Content method

Each topic is written by reading the current source — the relevant form, its
DFM captions, the menu actions, the settings tab — not by translating the 2011
prose. The old topic is a structural reference only.

UI element names are quoted **exactly** as they appear in the Ukrainian DFM
captions, so the documentation and the application agree literally. Where a
caption is assigned at runtime from a resource string, the resource string in
`unit_Consts.pas` / `unit_MHL_strings.pas` is the source.

Terminology is fixed once in `terms.html` and used consistently: колекція,
книга, група, обране, жанр, серія, пристрій, читалка, скрипт.

## Screenshots

The intent was to carry over any image that still matches the current UI. All
25 images in the old CHM were inspected; **none survive**, so the new Help
ships with no images at all and `Program/Help/img/` is not created.

| Group | Files | Why dropped |
|---|---|---|
| Full-window shots | `clip0001.png` (808×663), `clip0039.png` (768×570), `int_settings.jpg`, `set_readers.jpg`, `scripts_settings.jpg` | 2011 Russian UI, entirely superseded |
| Menu / dialog fragments | `clip0022`, `clip0023`, `clip0028`, `clip0029`, `clip0033`, `clip0034`, `clip0038`, `clip0040` | Russian menu text baked into the pixels; menu contents have also changed |
| 32×32 icon clips | `clip0002`–`clip0006`, `clip0008`–`clip0010`, `clip0013`, `clip0015`–`clip0018`, `clip0035`, `clip0036` | Pre-modernization raster icon style; the current set (`Program/Resources/Icons/Light|Dark/png/*_32.png`, 46 flat line-art icons) shares no artwork with them |

Prose is therefore written to stand alone. Where a topic would benefit from an
illustration, it describes the control by its exact caption and location
instead. Adding screenshots later is a separate piece of work and does not
block this one.

## Build and installer

`Program/Help/` is the source. A single copy step, implemented once in
`Program/copy_help.cmd`, stages it:

- `build_installer.cmd` — replace the `MyHomeLib.chm` copy in the "Collect
  Common redistributables" section with a call that stages `Program\Help` into
  `Installer\Common\Help`.
- `Program/MyhomeLib.dproj` — post-build event calls `copy_help.cmd` to copy
  `Program\Help` into the build output next to `MyHomeLib.exe`, so F1 works
  when running from the IDE.
- `Installer/Common.iss`:
  - `Source: Common\MyHomeLib.chm; DestDir: {app}; Flags: replacesameversion`
    → `Source: Common\Help\*; DestDir: {app}\Help; Flags: recursesubdirs`
  - Start-menu shortcut `Filename: {app}\{#MyAppName}.chm`
    → `Filename: {app}\Help\index.html`. The icon currently comes from
    `ieframe.dll` index 36, which is a browser icon and stays appropriate.

Stale `MyHomeLib.chm` files left in `Program/OUT/BIN`, `Program/OUT/Bin64` and
`Installer/Common` from previous builds are deleted. An upgrade install would
otherwise leave the old `.chm` orphaned in the user's install directory, so
`Common.iss` gains:

```
[InstallDelete]
Type: files; Name: {app}\MyHomeLib.chm
```

and the old Start-menu shortcut «Довідка MyHomeLib» is repointed rather than
duplicated.

## Verification

1. `Program/MHL.groupproj` builds clean, Release/Win32.
2. A link checker over `Program/Help/`: every `href` and `src` resolves to a
   file that exists; no `.htm` references survive; no `<img>` tags at all.
3. Every entry in the context-ID table resolves to a file that exists, and
   every topic file is reachable from the sidebar TOC.
4. Every page declares `charset=utf-8` and is actually UTF-8 encoded.
5. Manual confirmation in the running application (user): the Help menu opens
   the index, and F1 from the main window, each main tab, the collections
   manager, the new-collection wizard, the author editor, the non-FB2 import
   dialog, and each settings tab opens the expected page.

Item 5 is the acceptance gate. Per project convention, nothing here is marked
done until the user confirms it works in the running application.

## Out of scope

- Retaking screenshots of the current UI.
- Any Russian- or English-language version of the help.
- Changing the help *content* wording after the initial rewrite is reviewed.
- Reworking the `HelpContext` scheme itself; numeric IDs stay.
