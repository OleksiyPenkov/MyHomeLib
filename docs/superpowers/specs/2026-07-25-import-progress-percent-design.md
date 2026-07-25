# Real progress percentage in the import/update dialogs

Date: 2026-07-25

## Problem

The progress dialogs for INPX import and collection update do not show usable
progress, and no dialog shows a numeric percentage at all.

### The bar never leaves marquee mode

`TWorker.OpenProgress` (`Program/ImportImpl/unit_WorkerThread.pas:132`) opens
every worker with:

```pascal
FProgressEngine.BeginOperation(0, '', '');
```

`Total = 0` makes `TProgressEngine.IsPreciseProgress` return `False`, so the
engine pushes `pbstMarquee` at the bar. FB2/FBD import later calls
`BeginOperation(FFiles.Count, ...)` with a real total and the engine flips the
style back to `pbstNormal`.

The INPX import path never does. `TImportInpxThreadBase.Import` bypasses the
progress engine entirely and calls the raw `TWorker.SetProgress`
(`Program/ImportImpl/unit_ImportInpxThread.pas:472`). Setting `Position` on a
bar whose `Style` is `pbstMarquee` has no visible effect, so the dialog shows an
endless barber pole for the whole import.

This affects `TImportProgressFormEx` — Librusec update (`LibrusecUpdate`),
update from file (`ManualCollectionUpdate`), both in
`Program/UtilsImpl/unit_Utils.pas` — because that form hooks `OnProgressHint`.

### The wizard bar under-reports

`frm_NewCollectionWizard.pas:434` hooks `OnProgress` but not `OnProgressHint`,
so the wizard's `Bar` keeps its designer default of `pbstNormal` and does render
a percentage. That percentage is wrong:

```pascal
SetProgress(Round((i + j / BookList.Count) * 100 / numFiles));
```

- `numFiles` is `Zip.FileCount` — **every** archive member, including
  `collection.info`, `version.info` and `structure.info`, not just the `.inp`
  members the loop actually processes.
- `i` is not incremented for `extra.inp`, which is skipped by `Continue` for
  non-online collections (the `Continue` jumps past the `Inc(i)`).

The bar therefore climbs too slowly and stops well short of 100%.

### Progress only ticks on successful inserts

```pascal
if (filesProcessed mod ProcessedItemThreshold) = 0 then
```

`filesProcessed` counts books that `InsertBook` actually inserted. An
incremental update whose records are mostly already present advances the bar
rarely or not at all, even while it is doing real work.

### `FindNext` walks past the `.inp` members

`TMHLZip.FindNext`
(`Components/MHLComponents/unit_MHLArchiveHelpers.pas:196`) is:

```pascal
if FLastID < High(FZip.FileInfos) then
begin
  Inc(FLastID);
  Result := True;
end;
```

No extension check. Once the `repeat ... until not Zip.FindNext` loop passes the
last `.inp` member it keeps feeding whatever follows — `version.info` and
friends — into `ParseData`, which raises `EConvertError` and logs
`rstrErrorInpStructure`. Latent, but it corrupts any member-count-based
denominator and produces spurious error-log entries.

### No numeric percentage anywhere

`frm_ImportProgressForm.dfm` holds a `TLabel` and a `TProgressBar`. The native
`TProgressBar` common control cannot render text, and no form draws a number.

## Goals

1. The INPX import/update bar tracks reality: starts at 0, climbs smoothly,
   reaches 100%.
2. Every determinate progress bar in the import/update/download dialogs shows
   its percentage as text inside the bar.

## Non-goals

- The genuinely indeterminate phases stay marquee: the FB2/FBD folder scan
  (`unit_ImportFB2ThreadBase.pas:238`) and the post-import "оновлення БД" tail
  (`unit_ImportInpxThread.pas:499`). Neither total is knowable in advance, and
  marquee correctly communicates "still working, duration unknown".
- `frm_main.dfm`'s `pbDownloadProgress` status-bar mini-bar — too short to fit
  legible text.
- No changes to `TProgressEngine`. Its counters are `Integer`; the byte-weighted
  totals below would overflow them (see "Why not the progress engine").

## Design

### 1. Percentage inside the bar

New unit `Program/Units/unit_ProgressBarEx.pas` declaring an **interposer**:

```pascal
type
  TProgressBar = class(Vcl.ComCtrls.TProgressBar)
  private
    FShowPercent: Boolean;
    procedure SetShowPercent(Value: Boolean);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure PaintBar;
  public
    constructor Create(AOwner: TComponent); override;
    property ShowPercent: Boolean read FShowPercent write SetShowPercent default True;
  end;
```

The unit is added **last** in the `uses` clause of each form unit that declares a
progress bar field — after `ComCtrls`, so the interposer wins name resolution.
`TReader` resolves a component's class from the published field's RTTI, so the
DFM streams into the interposer without any DFM edit. Descendant forms that
re-declare `inherited ProgressBar: TProgressBar` are unaffected: for inherited
streaming the reader matches the existing component by name and ignores the
class token, and the component was already created by the ancestor using the
interposer type.

This matters because `ProgressBar` is declared in `frm_ImportProgressForm.dfm`
and re-declared in three inherited DFMs
(`frm_ImportProgressFormEx.dfm`, `frm_ExportToDeviceProgressForm.dfm`,
`frm_SyncOnLineProgressForm.dfm`). The delphi-dev skill flags inherited DFMs as
especially fragile; the interposer avoids touching any of them.

**Painting.** For `Style = pbstMarquee`, delegate to `inherited` and draw no
text — `Position` is meaningless there.

For `Style = pbstNormal`, the interposer paints the entire control itself rather
than drawing text over the native one. The Win10/11 themed progress bar glides
toward its target position using an internal animation that repaints outside our
`WM_PAINT`, which would wipe overlaid text intermittently. Self-painting is
deterministic and has no animation to fight.

Painting uses `Vcl.Themes.StyleServices` so the active VCL style is honoured:

- background: `tpBar`
- chunk, clipped to `ClientWidth * (Position - Min) / (Max - Min)`:
  `tpFill` / `tpFillError` / `tpFillPaused`, selected from the `State` property
  (`pbsNormal` / `pbsError` / `pbsPaused`)

`ControlStyle` gains `csOpaque` and `WM_ERASEBKGND` returns 1, to avoid flicker.

**Text.** `Format('%d%%', [Position])`, centred via
`DT_CENTER or DT_VCENTER or DT_SINGLELINE`, drawn twice with the clip region set
so it stays legible as the chunk passes under it:

- clipped to the filled region: `clHighlightText`
- clipped to the unfilled region: `clWindowText`

Only horizontal orientation is supported; every bar in this application is
horizontal.

Units gaining the interposer in `uses`:

| Unit | Bar fields |
|---|---|
| `Program/ImportImpl/frm_ImportProgressForm.pas` | `ProgressBar` (inherited by four descendant forms) |
| `Program/DwnldImpl/frm_DownloadProgressForm.pas` | `pbCurrent`, `pbTotal` |
| `Program/Wizards/NewCollection/frame_NCWProgress.pas` | `Bar` |
| `Program/Wizards/NewCollection/frame_NCWDownload.pas` | `Bar` |

### 2. Byte-weighted INPX progress

`TMHLZip` gains one read-only indexed property in
`Components/MHLComponents/unit_MHLArchiveHelpers.pas`:

```pascal
property FileSizes[Index: Integer]: Integer read GetFileSize;
```

backed by `FZip.FileInfos[Index].UncompressedSize` — already parsed from the zip
central directory, so reading it costs nothing.

`TImportInpxThreadBase.Import` gains a pre-pass over `0 .. Zip.FileCount - 1`
that collects the `.inp` members into a local list of `(Name, Size)`, skipping
`extra.inp` for non-online collections under the same condition the main loop
uses today. It sums the sizes into `TotalBytes: Int64`.

The main loop then iterates that list by index instead of the
`Find('*.inp')` / `FindNext` dance, which removes the `FindNext` overrun
described above.

Progress, evaluated on **every parsed line** rather than every hundredth
successful insert:

```
SetProgress((BytesDone + Round(ThisSize * j / BookList.Count)) * 100 div TotalBytes)
```

`BytesDone` accumulates the sizes of completed members. All of it in `Int64`.
`TWorker.SetProgress` already suppresses the `Synchronize` unless the integer
percent changed, so the per-line cost is one division. `SetComment` stays
throttled at `ProcessedItemThreshold`, since it synchronises unconditionally.

`TotalBytes = 0` (an archive with no usable `.inp` members) skips the
`SetProgressHint` call below and leaves the bar in marquee — the existing
`IsValidUpdateArchive` guard in `TManualUpdateThread` already rejects that case
for the manual path.

Immediately before the loop:

```pascal
SetProgressHint(pbstNormal, pbsNormal);
```

undoing the `pbstMarquee` that `TWorker.OpenProgress` pushed unconditionally.
This is what makes the bar visible at all in the update dialogs.

The comment line keeps reporting `rstrAddedBooks` (books inserted so far); the
percentage lives in the bar.

#### Why not the progress engine

Routing this through `TProgressEngine.BeginOperation(TotalBytes, ...)` would be
the tidier shape, but `TProgressEngine.ProgressChanged` computes
`FCurrent * 100 div FTotal` in `Integer` arithmetic. That overflows once
`FCurrent` passes ~21.4 MB, and a full Flibusta INPX carries on the order of
150 MB of uncompressed `.inp`. Widening the engine to `Int64` is out of scope
for this change; the INPX path already bypasses the engine, so it keeps doing so
with local `Int64` math.

### 3. Wizard progress-hint wiring

`TframeNCWProgress` gains:

```pascal
procedure SetProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
```

mirroring `TImportProgressForm.SetProgressHint`, and
`frm_NewCollectionWizard.pas:434` hooks it:

```pascal
FWorker.OnProgressHint := FProgressPage.SetProgressHint;
```

Without this the wizard bar would sit frozen at 100% through the "оновлення БД"
tail instead of going marquee, now that the main loop actually reaches 100%.

## Files touched

| File | Change |
|---|---|
| `Program/Units/unit_ProgressBarEx.pas` | **new** — interposer `TProgressBar` with `ShowPercent` |
| `Components/MHLComponents/unit_MHLArchiveHelpers.pas` | add `FileSizes[]` indexed property |
| `Program/ImportImpl/unit_ImportInpxThread.pas` | `.inp` pre-pass, byte-weighted `Int64` percent, per-line ticking, `SetProgressHint(pbstNormal)` |
| `Program/ImportImpl/frm_ImportProgressForm.pas` | interposer in `uses` |
| `Program/DwnldImpl/frm_DownloadProgressForm.pas` | interposer in `uses` |
| `Program/Wizards/NewCollection/frame_NCWProgress.pas` | interposer in `uses`, add `SetProgressHint` |
| `Program/Wizards/NewCollection/frame_NCWDownload.pas` | interposer in `uses` |
| `Program/Wizards/NewCollection/frm_NewCollectionWizard.pas` | hook `OnProgressHint` |

No DFM is modified.

Registering the new unit follows the pattern every other `Program/Units/` file
uses — it is listed in both places, not found via a search path:

- `Program/MyHomeLib.dpr` — add
  `unit_ProgressBarEx in 'Units\unit_ProgressBarEx.pas',` to the `uses` clause
- `Program/MyhomeLib.dproj` — add
  `<DCCReference Include="Units\unit_ProgressBarEx.pas"/>` to the item group

Edit the `.dproj` by hand. Never run msbuild on it directly and always build
through `MHL.groupproj`; msbuild re-serialises the file and hoists the
`CodeGear.Delphi.Targets` import above the config property groups, after which
every build fails with `F2613 Unit 'SysUtils' not found` (see CLAUDE.md).

The new `.pas` file needs a UTF-8 BOM. Without one, Cyrillic literals compile
clean and render as mojibake at runtime.

## Verification

This project has no automated test harness, so verification is a build plus
manual runs.

Build, Win64 first, then Win32, both through `MHL.groupproj`.

Manual checks:

1. **Update from file** (`ManualCollectionUpdate`) on a real INPX — the bar
   climbs from 0 to 100 with a legible number, then switches to marquee for the
   "оновлення БД" tail. Confirm the error log has no
   `rstrErrorInpStructure` entries naming `version.info` or `collection.info`.
2. **New Collection wizard** import — same climb, and the bar goes marquee for
   the tail rather than freezing.
3. **Incremental update** where most records already exist — the bar still
   advances, confirming the tick no longer depends on `filesProcessed`.
4. **FB2 folder import** — the scan phase is still marquee with no number, the
   processing phase shows a number. Confirms the shared form did not regress.
5. **Download progress form** — both bars show numbers.
6. Switch VCL style light/dark and confirm the number stays readable over both
   the filled and unfilled parts of the bar.
