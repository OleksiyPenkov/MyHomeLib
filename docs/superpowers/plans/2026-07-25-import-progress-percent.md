# Real Progress Percentage in Import/Update Dialogs — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the INPX import/update progress bar track real progress from 0 to 100%, and draw the numeric percentage inside every determinate progress bar in the import, update and download dialogs.

**Architecture:** A `TProgressBar` interposer in a new unit paints the bar itself (via `StyleServices`) and draws the percentage over it, so no DFM is touched — `TReader` resolves component classes from the published field's RTTI, so adding the unit last in a form's `uses` is enough. Separately, `TImportInpxThreadBase.Import` gains a pre-pass that collects the archive's `.inp` members and their uncompressed sizes, and drives the bar with byte-weighted `Int64` arithmetic instead of the current broken member-count formula.

**Tech Stack:** Delphi 13 (RAD Studio 37.0), VCL, `Vcl.Themes` / `StyleServices`, `Winapi.CommCtrl`, `System.Zip` (via `TMHLZip`).

**Spec:** `docs/superpowers/specs/2026-07-25-import-progress-percent-design.md`

## Global Constraints

- **No automated test harness exists in this repository.** There is no DUnit/DUnitX project. Every task's verification is a successful build plus a described manual run in the built application. Do not fabricate test files.
- **Never run msbuild on `Program\MyhomeLib.dproj` directly.** It re-serialises the file and hoists the `CodeGear.Delphi.Targets` import above the config property groups, after which every build fails with `F2613 Unit 'SysUtils' not found`. Always build through `Program\MHL.groupproj`.
- **Win64 is the primary target.** Build Win64 first and treat it as the build that must pass; then build Win32. Both must pass before a task is complete.
- `C:\Windows\System32` must be on `PATH` — the post-build event calls `robocopy`.
- **New `.pas` files must be saved with a UTF-8 BOM.** Without one, Cyrillic/Ukrainian literals compile clean and render as mojibake at runtime.
- **Do not modify any `.dfm` file.** The whole point of the interposer is to avoid the four inherited DFMs that declare `inherited ProgressBar: TProgressBar`.
- Comments in new code follow the surrounding files: Ukrainian prose in `unit_ImportInpxThread.pas` and the new unit, matching the existing `//` block style.
- Commit message prefixes: `+` for a new feature/addition, `*` for a modification/fix/refactor.
- Do not commit without a successful build first.

**Build command (Win64):**

```
cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MHL.groupproj /t:Build /p:Config=Release /p:Platform=Win64 /nologo /v:minimal" 2>&1
```

**Build command (Win32):** identical, with `/p:Platform=Win32`.

## File Structure

| File | Responsibility |
|---|---|
| `Program/Units/unit_ProgressBarEx.pas` | **New.** `TProgressBar` interposer: self-paints the determinate bar and draws the percentage. Nothing else in the app knows it exists beyond a `uses` entry. |
| `Program/Units/unit_Consts.pas` | Add two INPX filename constants next to the existing `*_FILENAME` block. |
| `Components/MHLComponents/unit_MHLArchiveHelpers.pas` | `TMHLZip` gains a `FileSizes[]` indexed property exposing each member's uncompressed size. |
| `Program/ImportImpl/unit_ImportInpxThread.pas` | `.inp` pre-pass, byte-weighted `Int64` percentage, per-line ticking, explicit `pbstNormal` hint. |
| `Program/ImportImpl/frm_ImportProgressForm.pas` | `uses` the interposer. Covers this form and its four descendants. |
| `Program/DwnldImpl/frm_DownloadProgressForm.pas` | `uses` the interposer (`pbCurrent`, `pbTotal`). |
| `Program/Wizards/NewCollection/frame_NCWProgress.pas` | `uses` the interposer (`Bar`); gains `SetProgressHint`. |
| `Program/Wizards/NewCollection/frame_NCWDownload.pas` | `uses` the interposer (`Bar`). |
| `Program/Wizards/NewCollection/frm_NewCollectionWizard.pas` | Hook `FWorker.OnProgressHint`. |
| `Program/MyHomeLib.dpr`, `Program/MyhomeLib.dproj` | Register the new unit. |

---

### Task 1: Expose `.inp` member sizes from the zip

**Files:**
- Modify: `Components/MHLComponents/unit_MHLArchiveHelpers.pas:33-69` (class declaration), `:233-241` (implementation)
- Modify: `Program/Units/unit_Consts.pas:101-111`
- Test: none — no test harness (see Global Constraints)

**Interfaces:**
- Consumes: nothing.
- Produces:
  - `TMHLZip.FileSizes[Index: Integer]: Integer` — uncompressed size of archive member `Index`, valid for `0 .. FileCount - 1`.
  - `INP_EXTENSION = '.inp'` and `EXTRA_INP_FILENAME = 'extra.inp'` in `unit_Consts`.

Task 3 consumes all three.

- [x] **Step 1: Add the `FileSizes` getter declaration**

In `unit_MHLArchiveHelpers.pas`, in the `private` section of `TMHLZip` (currently lines 34-42), add `GetFileSize` immediately after the existing `GetFileName`:

```pascal
    private
      FZip: TZipFile;
      FResult: Boolean;
      FLastID: Integer;
      FHeader: TZipHeader;
      function GetLastSize: Integer;
      function GetLastName: string;
      function GetFileName(Index: Integer): string;
      function GetFileSize(Index: Integer): Integer;
    function GetFileCount: Integer;
```

- [x] **Step 2: Add the `FileSizes` property**

In the `public` section, immediately after the existing `FileNames` property (line 66):

```pascal
      property LastName: string read GetLastName;
      property FileNames[Index: Integer]: string read GetFileName;
      property FileSizes[Index: Integer]: Integer read GetFileSize;
      property FileCount: Integer read GetFileCount;
      property LastSize: Integer read GetLastSize;
```

- [x] **Step 3: Implement the getter**

In the implementation section, immediately after `TMHLZip.GetFileName` (currently ending line 236):

```pascal
function TMHLZip.GetFileSize(Index: Integer): Integer;
begin
  Result := FZip.FileInfos[Index].UncompressedSize;
end;
```

This reads the zip central directory, which `TZipFile` has already parsed — it does not decompress anything.

- [x] **Step 4: Add the INPX filename constants**

In `unit_Consts.pas`, in the same `const` block, immediately after `COLLECTIONINFO_FILENAME` (line 111):

```pascal
  COLLECTIONINFO_FILENAME = 'collection.info'; // file holding URL, Script, etc
  INP_EXTENSION = '.inp';
  EXTRA_INP_FILENAME = 'extra.inp'; // on-line only: список книг, яких нема в основній базі
  TEMP_FOLDER_NAME = '_myhomelib';
```

- [x] **Step 5: Build Win64**

Run the Win64 build command from Global Constraints.
Expected: build succeeds, no errors. `MHLComponents` rebuilds first because the group project orders it ahead of the app.

- [x] **Step 6: Build Win32**

Run the same command with `/p:Platform=Win32`.
Expected: build succeeds, no errors.

- [x] **Step 7: Commit**

```bash
git add Components/MHLComponents/unit_MHLArchiveHelpers.pas Program/Units/unit_Consts.pas
git commit -m "+ Expose zip member sizes and INPX filename constants"
```

---

### Task 2: The percentage-drawing progress bar

**Files:**
- Create: `Program/Units/unit_ProgressBarEx.pas`
- Modify: `Program/MyHomeLib.dpr:136` (uses clause)
- Modify: `Program/MyhomeLib.dproj:205` (DCCReference item group)
- Modify: `Program/ImportImpl/frm_ImportProgressForm.pas:21-23` (uses clause)
- Test: none — manual visual verification (see Step 8)

**Interfaces:**
- Consumes: nothing from Task 1.
- Produces: unit `unit_ProgressBarEx` exporting `TProgressBar = class(Vcl.ComCtrls.TProgressBar)` with a published `ShowPercent: Boolean` property defaulting to `True`. Tasks 4 add this unit to three more `uses` clauses.

- [x] **Step 1: Create the interposer unit**

Create `Program/Units/unit_ProgressBarEx.pas`. **Save it with a UTF-8 BOM.**

```pascal
(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov   oleksiy.penkov@gmail.com
  * Created             25.07.2026
  * Description         Смуга прогресу з відсотком усередині
  *
  ****************************************************************************** *)

unit unit_ProgressBarEx;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.CommCtrl,
  System.Classes,
  System.SysUtils,
  System.Types,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.ComCtrls,
  Vcl.Themes;

type
  //
  // Інтерпозер стандартного TProgressBar: домальовує відсоток усередині смуги.
  //
  // Підключається додаванням цього модуля ОСТАННІМ у uses модуля форми — після
  // ComCtrls. DFM не змінюється: TReader бере клас компонента з RTTI
  // опублікованого поля форми, тож потоковий читач створить саме цей клас.
  // Успадковані форми, які перевизначають `inherited ProgressBar: TProgressBar`,
  // теж отримують його — для успадкованого читання компонент шукається за
  // іменем, а ім'я класу в DFM ігнорується.
  //
  // Смуга з точним прогресом малюється власноруч, а не поверх рідного
  // контрола: тема Windows 10/11 плавно «доїжджає» до заданої позиції власною
  // анімацією, яка перемальовує контрол поза нашим WM_PAINT і стирала б текст.
  // Для pbstMarquee малювання віддається базовому класу — там Position не має
  // сенсу, і відсоток не показується.
  //
  TProgressBar = class(Vcl.ComCtrls.TProgressBar)
  private
    FShowPercent: Boolean;
    procedure SetShowPercent(Value: Boolean);
    function UseCustomPaint: Boolean;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;

  protected
    procedure PaintBar(DC: HDC);
    procedure PaintPercent(DC: HDC; const ABarRect, AFillRect: TRect);
    procedure WndProc(var Message: TMessage); override;

  public
    constructor Create(AOwner: TComponent); override;

  published
    property ShowPercent: Boolean read FShowPercent write SetShowPercent default True;
  end;

implementation

{ TProgressBar }

constructor TProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShowPercent := True;
  //
  // csOpaque - фон малюємо самі, батьківський не потрібен.
  // csOverrideStylePaint - TWinControl.WndProc віддає повідомлення хуку
  // TProgressBarStyleHook, щойно ввімкнено користувацький стиль VCL, і наш
  // обробник WM_PAINT туди б не дійшов. Зараз програма стилів не вмикає, але
  // цей прапорець лишає малювання за нами, якщо їх колись увімкнуть.
  //
  ControlStyle := ControlStyle + [csOpaque, csOverrideStylePaint];
end;

procedure TProgressBar.SetShowPercent(Value: Boolean);
begin
  if FShowPercent <> Value then
  begin
    FShowPercent := Value;
    Invalidate;
  end;
end;

//
// Стани pbsError/pbsPaused програма не використовує (TProgressEngine завжди
// шле pbsNormal), і власне малювання їх не відтворює. Віддамо такі випадки
// рідному контролу.
//
function TProgressBar.UseCustomPaint: Boolean;
begin
  Result := FShowPercent and (Style = pbstNormal) and (State = pbsNormal) and
    not (csDesigning in ComponentState);
end;

procedure TProgressBar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if UseCustomPaint then
    Message.Result := 1
  else
    inherited;
end;

procedure TProgressBar.WMPaint(var Message: TWMPaint);
var
  PS: TPaintStruct;
  DC: HDC;
begin
  if not UseCustomPaint then
  begin
    inherited;
    Exit;
  end;

  if Message.DC <> 0 then
  begin
    PaintBar(Message.DC);
    Exit;
  end;

  DC := BeginPaint(Handle, PS);
  try
    PaintBar(DC);
  finally
    EndPaint(Handle, PS);
  end;
end;

//
// Рідний контрол після PBM_* перемальовується сам, але покладатись на це не
// варто: явно просимо перемалювання, щоб відсоток не відставав від позиції.
// Мерехтіння немає - csOpaque плюс WM_ERASEBKGND, що нічого не стирає.
//
procedure TProgressBar.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);

  case Message.Msg of
    PBM_SETPOS, PBM_DELTAPOS, PBM_STEPIT, PBM_SETRANGE, PBM_SETRANGE32, PBM_SETSTATE:
      if UseCustomPaint and HandleAllocated then
        Invalidate;
  end;
end;

procedure TProgressBar.PaintBar(DC: HDC);
var
  BarRect, ChunkRect: TRect;
  Span: Integer;
  Details: TThemedElementDetails;
  LStyle: TCustomStyleServices;
  Brush: HBRUSH;
begin
  BarRect := ClientRect;

  ChunkRect := BarRect;
  InflateRect(ChunkRect, -1, -1);
  Span := Max - Min;
  if (Span > 0) and (Position > Min) then
    ChunkRect.Right := ChunkRect.Left + MulDiv(ChunkRect.Width, Position - Min, Span)
  else
    ChunkRect.Right := ChunkRect.Left;

  LStyle := StyleServices;
  if LStyle.Available then
  begin
    //
    // Ті самі елементи теми, якими малює штатний TProgressBarStyleHook:
    // tpBar - жолоб на всю площу, tpChunk - заповнення, вписане на 1 піксель.
    //
    Details := LStyle.GetElementDetails(tpBar);
    LStyle.DrawElement(DC, Details, BarRect);
    if ChunkRect.Right > ChunkRect.Left then
    begin
      Details := LStyle.GetElementDetails(tpChunk);
      LStyle.DrawElement(DC, Details, ChunkRect);
    end;
  end
  else
  begin
    //
    // Класична тема без uxtheme.
    //
    Brush := CreateSolidBrush(ColorToRGB(clBtnFace));
    try
      FillRect(DC, BarRect, Brush);
    finally
      DeleteObject(Brush);
    end;
    DrawEdge(DC, BarRect, BDR_SUNKENOUTER, BF_RECT);
    if ChunkRect.Right > ChunkRect.Left then
    begin
      Brush := CreateSolidBrush(ColorToRGB(clHighlight));
      try
        FillRect(DC, ChunkRect, Brush);
      finally
        DeleteObject(Brush);
      end;
    end;
  end;

  PaintPercent(DC, BarRect, ChunkRect);
end;

procedure TProgressBar.PaintPercent(DC: HDC; const ABarRect, AFillRect: TRect);
var
  S: string;
  OldFont: HGDIOBJ;
  Rgn: HRGN;
  R: TRect;
begin
  S := Format('%d%%', [Position]);

  OldFont := SelectObject(DC, Font.Handle);
  SetBkMode(DC, TRANSPARENT);
  try
    //
    // Текст малюється двічі з різним відсіканням: над заповненою частиною
    // світлим, над порожньою - звичайним кольором. Інакше цифри тонули б у
    // смузі, що наповзає.
    //
    Rgn := CreateRectRgn(ABarRect.Left, ABarRect.Top, AFillRect.Right, ABarRect.Bottom);
    try
      SelectClipRgn(DC, Rgn);
      SetTextColor(DC, ColorToRGB(clHighlightText));
      R := ABarRect;
      Winapi.Windows.DrawText(DC, PChar(S), Length(S), R,
        DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX);
    finally
      DeleteObject(Rgn);
    end;

    Rgn := CreateRectRgn(AFillRect.Right, ABarRect.Top, ABarRect.Right, ABarRect.Bottom);
    try
      SelectClipRgn(DC, Rgn);
      SetTextColor(DC, ColorToRGB(clWindowText));
      R := ABarRect;
      Winapi.Windows.DrawText(DC, PChar(S), Length(S), R,
        DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX);
    finally
      DeleteObject(Rgn);
    end;

    SelectClipRgn(DC, 0);
  finally
    SelectObject(DC, OldFont);
  end;
end;

end.
```

- [x] **Step 2: Register the unit in the `.dpr`**

In `Program/MyHomeLib.dpr`, immediately after the `unit_ProgressEngine` line (line 136):

```pascal
  unit_ProgressEngine in 'Units\unit_ProgressEngine.pas',
  unit_ProgressBarEx in 'Units\unit_ProgressBarEx.pas',
  unit_MHLGenerics in 'Units\unit_MHLGenerics.pas',
```

- [x] **Step 3: Register the unit in the `.dproj`**

In `Program/MyhomeLib.dproj`, immediately after line 205:

```xml
        <DCCReference Include="Units\unit_ProgressEngine.pas"/>
        <DCCReference Include="Units\unit_ProgressBarEx.pas"/>
```

Hand-edit only. Do not let msbuild touch this file directly.

- [x] **Step 4: Wire it into the shared import progress form**

In `Program/ImportImpl/frm_ImportProgressForm.pas`, the `uses` clause is currently:

```pascal
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unit_WorkerThread, frm_BaseProgressForm, StdCtrls, ComCtrls, unit_Globals;
```

Change it to put `unit_ProgressBarEx` **last**, after `ComCtrls`:

```pascal
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unit_WorkerThread, frm_BaseProgressForm, StdCtrls, ComCtrls, unit_Globals,
  unit_ProgressBarEx;
```

Order matters: the interposer must shadow `ComCtrls.TProgressBar`. This one edit covers `TImportProgressFormEx`, `TExportProgressForm`, `TSyncOnLineProgressForm` and `TExportToDeviceProgressForm`, which all inherit the `ProgressBar` field from this form.

- [x] **Step 5: Build Win64**

Run the Win64 build command.
Expected: build succeeds. If you get `E2010 Incompatible types: 'TProgressBar' and 'TProgressBar'` anywhere, a unit is referring to the wrong one — check `uses` ordering in the file named by the error.

- [x] **Step 6: Build Win32**

Run the Win32 build command.
Expected: build succeeds.

- [ ] **Step 7: Manual verification**

Run `Program\OUT\Bin64\MyHomeLib.exe`. Start an FB2 folder import into any collection (this path already reports a real percentage, so it exercises the new painting without depending on Task 3).

Expected:
- During the folder-scan phase the bar is a marquee with **no** number (correct — `Position` is meaningless there).
- During the file-processing phase the bar is solid and shows a centred number that climbs to `100%`.
- The number stays legible as the filled region passes under it.
- No flicker.

- [x] **Step 8: Commit**

```bash
git add Program/Units/unit_ProgressBarEx.pas Program/MyHomeLib.dpr Program/MyhomeLib.dproj Program/ImportImpl/frm_ImportProgressForm.pas
git commit -m "+ Draw the percentage inside determinate progress bars"
```

---

### Task 3: Byte-weighted INPX import progress

**Files:**
- Modify: `Program/ImportImpl/unit_ImportInpxThread.pas:375-500` (the `Import` method)
- Test: none — manual verification (see Step 6)

**Interfaces:**
- Consumes: `TMHLZip.FileSizes[]`, `INP_EXTENSION`, `EXTRA_INP_FILENAME` from Task 1.
- Produces: nothing consumed by later tasks.

**Background — what is broken.** `TWorker.OpenProgress` (`unit_WorkerThread.pas:132`) opens every worker with `FProgressEngine.BeginOperation(0, '', '')`. `Total = 0` makes the engine push `pbstMarquee`, and `Position` is invisible on a marquee bar. FB2/FBD import later calls `BeginOperation(FFiles.Count, ...)` and the engine flips back to `pbstNormal`; the INPX path bypasses the engine entirely and never does. Separately, `numFiles` is `Zip.FileCount` (**all** members, including `collection.info`, `structure.info`, `version.info`), `i` is skipped for `extra.inp`, and progress only ticks every 100 *successfully inserted* books. Finally `TMHLZip.FindNext` has no extension check — it just does `Inc(FLastID)` — so the loop walks past the last `.inp` and feeds `version.info` into `ParseData`, producing spurious `rstrErrorInpStructure` entries.

- [x] **Step 1: Add the entry record and new locals**

In `unit_ImportInpxThread.pas`, replace the `Import` declaration header and `var` block (lines 375-392) with:

```pascal
procedure TImportInpxThreadBase.Import(const INPXFileName: string; CheckFiles: Boolean; BookCollection: IBookCollection);
type
  TInpEntry = record
    Name: string;
    Size: Integer;
  end;
var
  CollectionRoot: string;
  BookList: TStringList;
  i: Integer;
  j: Integer;
  R: TBookRecord;
  filesProcessed: Integer;
  CurrentFile: string;
  IsOnline: Boolean;
  inpStream: TMemoryStream;
  StructureInfo: string;
  header: TINPXHeader;
  strVersion: string;
  strCollection: string;
  Zip: TMHLZip;
  collectionCode: Integer;
  InpEntries: TArray<TInpEntry>;
  EntryCount: Integer;
  TotalBytes: Int64;
  BytesDone: Int64;
begin
```

`numFiles` is gone — it was the broken denominator and nothing else uses it.

- [x] **Step 2: Replace the archive walk with the pre-pass**

Replace lines 415-418 — currently:

```pascal
    GetFields(StructureInfo);
    numFiles := Zip.FileCount;

    if Zip.Find('*.inp') then
    repeat
      CurrentFile:= Zip.LastName;
      if not IsOnline and (CurrentFile = 'extra.inp') then Continue;
```

with:

```pascal
    GetFields(StructureInfo);

    //
    // Попередній прохід: збираємо .inp-члени архіву та їхні розпаковані
    // розміри. Розмір лежить у центральному каталозі zip, читання нічого не
    // коштує, а важити прогрес байтами точніше, ніж кількістю членів: рядки
    // .inp майже однакової довжини, а самі члени дуже різні за обсягом.
    //
    // Заразом це прибирає давню ваду обходу: TMHLZip.FindNext не перевіряє
    // розширення, тож старий цикл, проминувши останній .inp, згодовував
    // ParseData version.info і collection.info та засмічував журнал помилок.
    //
    SetLength(InpEntries, Zip.FileCount);
    EntryCount := 0;
    TotalBytes := 0;
    for i := 0 to Zip.FileCount - 1 do
    begin
      CurrentFile := Zip.FileNames[i];
      if not SameText(ExtractFileExt(CurrentFile), INP_EXTENSION) then
        Continue;
      if not IsOnline and SameText(CurrentFile, EXTRA_INP_FILENAME) then
        Continue;

      InpEntries[EntryCount].Name := CurrentFile;
      InpEntries[EntryCount].Size := Zip.FileSizes[i];
      Inc(TotalBytes, InpEntries[EntryCount].Size);
      Inc(EntryCount);
    end;
    SetLength(InpEntries, EntryCount);

    //
    // TWorker.OpenProgress відкриває операцію з Total = 0, і TProgressEngine
    // виставляє смузі pbstMarquee. Поки стиль marquee, Position не видно -
    // саме через це діалог оновлення показував нескінченну «біжучу доріжку»
    // замість прогресу.
    //
    if TotalBytes > 0 then
      SetProgressHint(pbstNormal, pbsNormal);

    BytesDone := 0;
    for i := 0 to High(InpEntries) do
    begin
      CurrentFile := InpEntries[i].Name;
```

- [x] **Step 3: Extract from the entry name instead of `Zip.LastName`**

Replace line 428 — currently `Zip.ExtractToStream(Zip.LastName, inpStream);` — with:

```pascal
          Zip.ExtractToStream(CurrentFile, inpStream);
```

`Zip.LastName` tracked the `Find`/`FindNext` cursor, which no longer exists.

- [x] **Step 4: Move the progress block out of the per-book `try` and fix its arithmetic**

The old progress block sits *inside* the `try` that wraps one book (lines 470-477), gated on `filesProcessed`:

```pascal
              if (filesProcessed mod ProcessedItemThreshold) = 0 then
              begin
                SetProgress(Round((i + j / BookList.Count) * 100 / numFiles));
                SetComment(Format(rstrAddedBooks, [filesProcessed]));

                if Canceled then
                  Break;
              end;

            except
              on E: EConvertError do
```

Delete it, so `except` follows the `InsertBook` block directly, and put the replacement **after** the `except`'s closing `end;` — i.e. in the `for j` loop body but outside the per-book `try`, so a book that raised still advances the bar. Lines 470-487 become:

```pascal
            except
              on E: EConvertError do
                Teletype(Format(rstrErrorInpStructure, [CurrentFile, j]), tsError);
              on E: EDBError do
                Teletype(Format(rstrDBErrorInp, [CurrentFile, j]), tsError);
              on E: Exception do
                Teletype(E.Message, tsError);
            end;

            //
            // Крутимо смугу на кожному розібраному рядку, а не на кожній сотій
            // *вставленій* книзі: інкрементальне оновлення, де майже все вже є
            // в колекції, інакше стоїть на місці. SetProgress сам гасить
            // Synchronize, доки ціле число відсотків не змінилось, тож ціна -
            // одне ділення на рядок.
            //
            if TotalBytes > 0 then
              SetProgress(Integer(
                (BytesDone + Round(InpEntries[i].Size * (j + 1) / BookList.Count)) * 100 div TotalBytes));

            if (j mod ProcessedItemThreshold) = 0 then
            begin
              SetComment(Format(rstrAddedBooks, [filesProcessed]));

              if Canceled then
                Break;
            end;
          end;
```

The percentage must stay in `Int64`: a full Flibusta INPX carries on the order of 150 MB of uncompressed `.inp`, and `FCurrent * 100` in 32-bit arithmetic overflows past ~21 MB. `BytesDone` and `TotalBytes` are `Int64`, `Round` returns `Int64`, so the whole expression is `Int64`; the explicit `Integer(...)` cast is safe because the result is bounded by 0..100.

`BookList.Count = 0` cannot divide by zero — the `for j` loop body does not execute at all in that case.

- [x] **Step 5: Close the member loop by advancing the byte counter**

Replace lines 488-496 — currently:

```pascal
        finally
          FreeAndNil(BookList);
        end;

        Inc(i);
        if Canceled then
          Break;

    until not Zip.FindNext;
```

with:

```pascal
      finally
        FreeAndNil(BookList);
      end;

      Inc(BytesDone, InpEntries[i].Size);
      if Canceled then
        Break;
    end;
```

Everything from `Teletype(Format(rstrAddedBooks, ...))` at line 498 onward — including the `BeginOperation(-1, rstrUpdatingDB, '')` marquee tail and the `collection.info` / `version.info` handling — is unchanged. The tail deliberately stays a marquee: its duration is not knowable.

Re-indent the `for i` loop body consistently (the old `repeat` body was indented inconsistently — two of its blocks sat at six spaces and the rest at eight).

- [x] **Step 6: Build Win64, then Win32**

Run both build commands.
Expected: both succeed. Watch for `H2077 Value assigned to 'numFiles' never used` — if it appears, a reference to `numFiles` was missed.

- [ ] **Step 7: Manual verification**

Run `Program\OUT\Bin64\MyHomeLib.exe`.

1. **Update a collection from a file** (the update-from-file dialog, `ManualCollectionUpdate`) using a real INPX.
   Expected: the bar is solid from the start, climbs steadily from `0%` to `100%`, then switches to a marquee for the "оновлення БД" tail. No barber pole during the import itself.
2. Check the dialog's error log.
   Expected: **no** `rstrErrorInpStructure` entries naming `version.info`, `collection.info` or `structure.info`.
3. **Run the same update a second time**, so nearly every record already exists.
   Expected: the bar still advances smoothly — this is what the per-line tick fixes.
4. **Cancel** an import midway.
   Expected: it stops promptly (cancel is still checked every 100 lines) and the collection is rolled back as before.

- [x] **Step 8: Commit**

```bash
git add Program/ImportImpl/unit_ImportInpxThread.pas
git commit -m "* Drive INPX import progress from real .inp byte weights"
```

---

### Task 4: Remaining bars and the wizard progress hint

**Files:**
- Modify: `Program/DwnldImpl/frm_DownloadProgressForm.pas:22-35` (uses clause)
- Modify: `Program/Wizards/NewCollection/frame_NCWDownload.pas:17-30` (uses clause)
- Modify: `Program/Wizards/NewCollection/frame_NCWProgress.pas:17-20` (uses clause), `:41-46` (public section), implementation
- Modify: `Program/Wizards/NewCollection/frm_NewCollectionWizard.pas:433-438`
- Test: none — manual verification (see Step 6)

**Interfaces:**
- Consumes: `unit_ProgressBarEx` from Task 2; the working INPX percentage from Task 3.
- Produces: `TframeNCWProgress.SetProgressHint(Style: TProgressBarStyle; State: TProgressBarState)`.

- [x] **Step 1: Wire the download progress form**

In `Program/DwnldImpl/frm_DownloadProgressForm.pas`, add `unit_ProgressBarEx` as the last entry of the `uses` clause:

```pascal
uses
  Windows,
  Messages,
  Classes,
  Controls,
  StdCtrls,
  ComCtrls,
  SysUtils,
  Forms,
  Dialogs,
  unit_Globals,
  frm_BaseProgressForm,
  unit_WorkerThread,
  unit_DownloadBooksThread,
  unit_ProgressBarEx;
```

- [x] **Step 2: Wire the wizard download frame**

In `Program/Wizards/NewCollection/frame_NCWDownload.pas`:

```pascal
uses
  Windows,
  Messages,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  frame_InteriorPageBase,
  StdCtrls,
  ExtCtrls,
  ComCtrls,
  System.Net.HttpClient,
  unit_ProgressBarEx;
```

- [x] **Step 3: Wire the wizard progress frame and give it a hint handler**

In `Program/Wizards/NewCollection/frame_NCWProgress.pas`, change the `uses` clause (lines 17-20) to:

```pascal
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frame_WizardPageBase, frame_InteriorPageBase, StdCtrls, ExtCtrls, ComCtrls,
  unit_WorkerThread, unit_NCWParams, unit_Globals, unit_ProgressBarEx;
```

Add the method to the `public` section, immediately after `OpenProgress` (line 41):

```pascal
    procedure OpenProgress;
    procedure SetProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
    procedure ShowProgress(Percent: Integer);
```

And implement it immediately after `TframeNCWProgress.OpenProgress` (which currently ends at line 91), mirroring `TImportProgressForm.SetProgressHint`:

```pascal
procedure TframeNCWProgress.SetProgressHint(Style: TProgressBarStyle; State: TProgressBarState);
begin
  Bar.Style := Style;
  Bar.State := State;
end;
```

- [x] **Step 4: Hook the hint in the wizard**

In `Program/Wizards/NewCollection/frm_NewCollectionWizard.pas`, the worker wiring at lines 433-438 is currently:

```pascal
  FWorker.OnOpenProgress := FProgressPage.OpenProgress;
  FWorker.OnProgress := FProgressPage.ShowProgress;
  FWorker.OnCloseProgress := FProgressPage.CloseProgress;
```

Add the missing hint hook:

```pascal
  FWorker.OnOpenProgress := FProgressPage.OpenProgress;
  FWorker.OnProgressHint := FProgressPage.SetProgressHint;
  FWorker.OnProgress := FProgressPage.ShowProgress;
  FWorker.OnCloseProgress := FProgressPage.CloseProgress;
```

Until now the wizard never hooked `OnProgressHint`, so its `Bar` kept the designer default `pbstNormal` and rendered the old skewed percentage. With Task 3 in place the bar reaches 100% and would then sit frozen through the "оновлення БД" tail; this hook makes it go marquee instead.

- [x] **Step 5: Build Win64, then Win32**

Run both build commands.
Expected: both succeed.

- [ ] **Step 6: Manual verification**

Run `Program\OUT\Bin64\MyHomeLib.exe`.

1. **New Collection wizard**, importing from an INPX.
   Expected: the download page's bar shows a number; the import page's bar climbs `0%` → `100%`, then goes marquee for the tail.
2. **Download some books** (the download progress form).
   Expected: both `pbCurrent` and `pbTotal` show numbers.
3. **Librusec update** (`LibrusecUpdate`).
   Expected: the download phase shows a climbing number with the Kb/s comment, then the import phase climbs `0%` → `100%`, then marquee.
4. Re-run the FB2 import check from Task 2 Step 7 to confirm nothing regressed on the shared form.

- [x] **Step 7: Commit**

```bash
git add Program/DwnldImpl/frm_DownloadProgressForm.pas Program/Wizards/NewCollection/frame_NCWDownload.pas Program/Wizards/NewCollection/frame_NCWProgress.pas Program/Wizards/NewCollection/frm_NewCollectionWizard.pas
git commit -m "* Show the percentage on the download and wizard progress bars"
```

---

## Deferred / out of scope

- `frm_main.dfm`'s `pbDownloadProgress` status-bar mini-bar — too short to fit legible text; deliberately left native.
- The FB2/FBD folder scan (`unit_ImportFB2ThreadBase.pas:238`) and the post-import "оновлення БД" tail (`unit_ImportInpxThread.pas:499`) stay marquee. Neither total is knowable in advance.
- `TProgressEngine` keeps its `Integer` counters. Widening it to `Int64` would be the tidier home for byte-weighted totals, but the INPX path already bypasses the engine and this change keeps it that way.
