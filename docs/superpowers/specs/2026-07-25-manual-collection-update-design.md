# Manual collection update from a user-selected file

Date: 2026-07-25

## Problem

A collection can only be updated from a file today if that file sits in
`Settings.UpdatePath` under the exact name configured for the collection
(`TUpdateInfo.UpdateFile`, typically `update.zip` — a renamed INPX).
`TUpdateInfo.CheckVersion` (`Program/Units/unit_Lib_Updates.pas:255`) sets
`FLocal := FileExists(Path + UpdateFile)`, and `TLibUpdateThread` then imports
that file instead of downloading. The path works, but nothing in the UI exposes
it: the user has to know both the folder and the expected file name.

Collections without a matching entry in `Settings.Updates` (name + type code)
cannot be updated from a file at all.

## Goal

Let the user pick any INPX/ZIP update file from disk and run it through the
existing update pipeline against the currently open collection.

## Non-goals

- Multi-file selection or batch update of several collections.
- Drag-and-drop.
- Remembering a per-collection update file.
- Detecting full-vs-incremental from the archive contents.

## Design

### 1. Extract the per-collection update step

`TLibUpdateThread.WorkFunction`
(`Program/UtilsImpl/unit_libupdateThread.pas:186-236`) currently inlines the
whole update of one collection: `BeginBulkOperation`, user-data backup,
`TruncateTablesBeforeImport` on a full update, `Import`, user-data restore,
`EndBulkOperation`, then `RemapCollectionBookIDs`.

Lift that into a protected method on a new intermediate class in the same unit:

```pascal
TCollectionUpdateThreadBase = class(TImportInpxThreadBase)
protected
  procedure UpdateCollection(const AFileName: string; ACollectionID: Integer;
    AFull: Boolean; const ADisplayName: string);
end;
```

`TLibUpdateThread` descends from it and calls `UpdateCollection` once per
update entry. Everything that is specific to the online path stays in
`TLibUpdateThread`: version checks, download, cancellation cleanup, and
**deleting the update file after a successful import**.

Deletion must not move into `UpdateCollection` — a user-picked file is never
deleted or moved.

### 2. `TManualUpdateThread`

New class in `unit_libupdateThread.pas`:

```pascal
TManualUpdateThread = class(TCollectionUpdateThreadBase)
public
  constructor Create(const ACollectionID: Integer; const AFileName: string;
    AFull: Boolean; AGenresType: TGenresType);
end;
```

`WorkFunction` emits one teletype header line naming the collection and the
source file, then calls `UpdateCollection`.

`AGenresType` is resolved by the caller (`ManualCollectionUpdate`, section 4)
from the target collection's `TCollectionInfo`, rather than hardcoded to
`gtFb2` the way `TLibUpdateThread.Create` does it:
`isFB2Collection(CollectionInfo.CollectionType)` → `gtFb2`, otherwise `gtAny`.
The same `TCollectionInfo` supplies the `ADisplayName` passed to
`UpdateCollection`. This is the same mapping the New Collection wizard applies
(`Program/Wizards/NewCollection/frm_NewCollectionWizard.pas:415-424`), driven
off the existing collection instead of wizard parameters.

Collection properties need no special handling: `Import` applies
`collection.info` and `version.info` only when the archive actually contains
them (`Program/ImportImpl/unit_ImportInpxThread.pas:498-512`), so an update
file without `version.info` leaves `DataVersion` alone.

### 3. Dialog

New form `frm_UpdateFromFile` (`Program/Forms/`):

- read-only file edit + `...` browse button
- checkbox `Повний переімпорт (очистити колекцію)`, unchecked by default
- warning label explaining that a full re-import clears the collection and
  re-imports it, preserving user data (read marks, groups, ratings)
- OK disabled until an existing file is selected

Browse calls `GetFileName` with a new `fnOpenUpdate` key added to
`TMHLFileName` in `Program/Units/unit_Helpers.pas`:

- Title: `Вибір файлу оновлення`
- Filter: `Файл оновлення (*.inpx, *.zip)|*.inpx;*.zip|Всі типи|*.*`
- DefaultExt: `inpx`
- DialogKey: `SelectUpdateFile`

A new key rather than a widened `fnOpenINPX` filter, so the New Collection
wizard's dialog and its remembered folder are unaffected.

A dedicated form is used instead of `TOpenDialog` plus a Yes/No prompt because
the full re-import choice is destructive and a Yes/No box describes it poorly.

### 4. Wiring

- Action `acToolsUpdateFromFile` in the `Інструменти` category, caption
  `Оновити колекцію з файлу...`, added to `frm_main.dfm`.
- Menu item under `miTools`, directly after `miUpdate`.
- Handler `UpdateCollectionFromFileExecute` in `frm_main.pas`, mirroring
  `UpdateOnlineCollectionExecute` (`frm_main.pas:6352`): assert `FCollection`,
  `UpdatePositions`, run the update, restore `Settings.ActiveCollection`, then
  `InitCollection`.
- Runner `ManualCollectionUpdate` in `Program/UtilsImpl/unit_Utils.pas`
  alongside `LibrusecUpdate`, using the same `TImportProgressFormEx` and
  `SaveErrorLog(Settings.SystemFileName[sfUpdateLog])`.

### 5. Error handling

- Action disabled when no collection is open.
- Selected file missing or unreadable → message, abort before any DB write.
- Archive with no `.inp` entries → existing `rstrInvalidFormat`
  (`Неправильний формат файлу INPX!`), abort before any DB write.
- Failure during import → existing `EndBulkOperation(False)` rollback path,
  unchanged.
- Cancellation → existing `Canceled` checks inside `Import`; the source file is
  left untouched.

## Testing

Manual, in the running application:

1. Incremental update of a Librusec collection from a picked `update.zip` —
   book count grows, user data intact.
2. Full re-import of the same collection from a full INPX — collection is
   replaced, read marks and groups survive, book IDs remap.
3. Update of a user collection with no entry in `Settings.Updates` — works,
   which is impossible today.
4. Picking a non-archive file — clear error, collection unchanged.
5. Cancelling mid-import — collection rolled back, picked file still on disk.
6. Existing online update via `Оновити колекції` still works and still deletes
   its downloaded file.
