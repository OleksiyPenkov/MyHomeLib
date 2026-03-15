# UI Modernization Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Modernize MyHomeLib's visual appearance to match Windows 10/11 native look using VCL Styles, SVG icons via TImageCollection, and PerMonitorV2 DPI awareness.

**Architecture:** Three-phase approach following the ELN project pattern (`D:\DelphiProjects\ELN\ELN3\`). Phase 1 adds VCL Styles with light/dark theme switching. Phase 2 migrates bitmap ImageLists to TImageCollection + TVirtualImageList with Fluent UI SVG icons loaded from files at runtime. Phase 3 enables PerMonitorV2 DPI and fixes layout issues.

**Tech Stack:** Delphi 13 (Studio 37.0), VCL Styles (`Win10Modern.Style` light / `Win10ModernDark.Style` dark), TImageCollection, TVirtualImageList, Fluent UI System Icons (SVG format).

**Reference project:** `D:\DelphiProjects\ELN\ELN3\ELN.Desktop\` — see `Views\dm_TreeImages.pas` for icon loading pattern, `Forms\frm_Main.pas:1112-1149` for theme menu/switching pattern.

---

## Chunk 1: VCL Styles + Theme Switching

### Task 1: Add VCL Style resources to the project

**Files:**
- Modify: `Program/MyhomeLib.dproj` — add `Custom_Styles` entries for Win10Modern and Win10ModernDark
- Modify: `Program/MyHomeLib.dpr` — add style application at startup

**Available styles (in `$(BDSCOMMONDIR)\Styles\`):**
- Light: `Win10Modern.Style`
- Dark: `Win10ModernDark.Style`

- [ ] **Step 1: Add Custom_Styles to dproj**

In `Program/MyhomeLib.dproj`, find the Release Win32 config section (the one with `<AppEnableRuntimeThemes>true</AppEnableRuntimeThemes>`) and add:
```xml
<Custom_Styles>Win10Modern|VCLSTYLE|$(BDSCOMMONDIR)\Styles\Win10Modern.Style;Win10ModernDark|VCLSTYLE|$(BDSCOMMONDIR)\Styles\Win10ModernDark.Style</Custom_Styles>
```

Also add `Custom_Styles` to the base config and Debug configs so styles are available in all build configurations.

- [ ] **Step 2: Apply default style at startup in MyHomeLib.dpr**

In `Program/MyHomeLib.dpr`, add after `Application.Initialize;`:
```pascal
  TStyleManager.TrySetStyle('Win10Modern');
```

- [ ] **Step 3: Build and verify**

Run:
```
cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MHL.groupproj /t:Build /p:Config=Release /p:Platform=Win32 /nologo /v:minimal" 2>&1
```
Expected: Build succeeds. App launches with Windows10 flat style.

- [ ] **Step 4: Commit**

```bash
git add Program/MyhomeLib.dproj Program/MyHomeLib.dpr
git commit -m "Add Windows10 VCL Style to the project"
```

---

### Task 2: Create theme manager unit

**Files:**
- Create: `Program/Units/unit_ThemeManager.pas`

Following the ELN pattern from `dm_TreeImages.pas:142-155` (DetectIconTheme), create a unit that detects the Windows system theme and applies the matching VCL style.

- [ ] **Step 1: Create unit_ThemeManager.pas**

```pascal
unit unit_ThemeManager;

interface

uses
  Vcl.Themes, Vcl.Styles;

type
  TMHLThemeMode = (tmSystem, tmLight, tmDark);

  TMHLThemeManager = class
  private
    class var FThemeMode: TMHLThemeMode;
  public
    class function DetectSystemDarkMode: Boolean; static;
    class procedure ApplyTheme(AMode: TMHLThemeMode); static;
    class property ThemeMode: TMHLThemeMode read FThemeMode write FThemeMode;
  end;

implementation

uses
  Winapi.Windows, System.SysUtils, Registry;

const
  CStyleLight = 'Win10Modern';
  CStyleDark  = 'Win10ModernDark';

class function TMHLThemeManager.DetectSystemDarkMode: Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize') then
    begin
      if Reg.ValueExists('AppsUseLightTheme') then
        Result := Reg.ReadInteger('AppsUseLightTheme') = 0;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

class procedure TMHLThemeManager.ApplyTheme(AMode: TMHLThemeMode);
var
  UseDark: Boolean;
  StyleName: string;
begin
  FThemeMode := AMode;
  case AMode of
    tmSystem: UseDark := DetectSystemDarkMode;
    tmDark:   UseDark := True;
    tmLight:  UseDark := False;
  else
    UseDark := False;
  end;

  if UseDark then
    StyleName := CStyleDark
  else
    StyleName := CStyleLight;

  TStyleManager.TrySetStyle(StyleName);
end;

end.
```

- [ ] **Step 2: Wire into startup**

In `Program/MyHomeLib.dpr`, replace the `TStyleManager.TrySetStyle('Windows10')` from Task 1 with:
```pascal
  TMHLThemeManager.ApplyTheme(tmSystem);
```

Add `unit_ThemeManager in 'Units\unit_ThemeManager.pas'` to the uses clause.

- [ ] **Step 3: Build and verify**

Build the project. Test:
1. With Windows light mode — app should use Win10Modern style
2. With Windows dark mode — app should use Win10ModernDark style

- [ ] **Step 4: Commit**

```bash
git add Program/Units/unit_ThemeManager.pas Program/MyHomeLib.dpr
git commit -m "Add theme manager with automatic light/dark detection"
```

---

### Task 3: Add theme preference to Settings

**Files:**
- Modify: `Program/Units/unit_Settings.pas` — add FThemeMode field, Load/Save
- Modify: `Program/Forms/frm_settings.pas` + `.dfm` — add theme selector to Interface tab

- [ ] **Step 1: Add FThemeMode to TMHLSettings**

In `Program/Units/unit_Settings.pas`, add field and property:
```pascal
// In private section, near other interface fields (~line 160 area):
FThemeMode: Integer; // 0=System, 1=Light, 2=Dark

// In public section:
property ThemeMode: Integer read FThemeMode write FThemeMode;
```

In `LoadSettings` procedure, in the `INTERFACE_SECTION` block (after `FEditToolBarVisible` ~line 709):
```pascal
FThemeMode := iniFile.ReadInteger(INTERFACE_SECTION, 'ThemeMode', 0);
```

In `SaveSettings` procedure, in the matching `INTERFACE_SECTION` block:
```pascal
iniFile.WriteInteger(INTERFACE_SECTION, 'ThemeMode', FThemeMode);
```

- [ ] **Step 2: Update startup to use saved preference**

In `Program/MyHomeLib.dpr`, replace `TMHLThemeManager.ApplyTheme(tmSystem)` with:
```pascal
  TMHLThemeManager.ApplyTheme(TMHLThemeMode(DMUser.Settings.ThemeMode));
```

Move this call to after `DMUser.Init;` since Settings must be loaded first. The call sequence becomes:
```pascal
  Application.CreateForm(TDMUser, DMUser);
  DMUser.Init;
  TMHLThemeManager.ApplyTheme(TMHLThemeMode(Settings.ThemeMode));
```

Note: Use the `Settings()` free function from `dm_user.pas`.

- [ ] **Step 3: Add theme ComboBox to Settings dialog**

In `Program/Forms/frm_settings.dfm`, inside `tsInterface` tab sheet, add a `TLabel` + `TComboBox`:
- Label caption: `Тема оформлення:` (Ukrainian for "Appearance theme:")
- ComboBox `cbThemeMode` with items: `Системна`, `Світла`, `Темна`
- Style: `csDropDownList`
- Place it after the existing font size controls

In `Program/Forms/frm_settings.pas`:
- In `FormShow` / init: `cbThemeMode.ItemIndex := Settings.ThemeMode;`
- In Save/OK handler: `Settings.ThemeMode := cbThemeMode.ItemIndex;`

- [ ] **Step 4: Build and test**

Build. Open Settings > Interface tab. Verify:
1. Theme ComboBox shows current setting
2. Changing theme and restarting applies the correct style

- [ ] **Step 5: Commit**

```bash
git add Program/Units/unit_Settings.pas Program/Forms/frm_settings.pas Program/Forms/frm_settings.dfm Program/MyHomeLib.dpr
git commit -m "Add theme preference (System/Light/Dark) to Settings"
```

---

### Task 4: Fix owner-drawn controls for VCL Styles

**Files:**
- Modify: `Program/Forms/frm_main.pas` — fix `pgControlDrawTab` to use style colors
- Modify: `Program/Units/unit_ColorTabs.pas` — make style-aware
- Review: `Program/Forms/frm_main.dfm` — StatusBar owner-draw

The current `pgControlDrawTab` (frm_main.pas:6602-6627) uses hardcoded colors (`clMenuBar`, `$00EFD3C6`). The `unit_ColorTabs.pas` `TTabSheet` uses `clBtnFace`. These need to respect VCL style colors.

- [ ] **Step 1: Fix pgControlDrawTab**

In `Program/Forms/frm_main.pas`, replace the `pgControlDrawTab` method body (~line 6602-6627):

```pascal
procedure TfrmMain.pgControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  AText: string;
  APoint: TPoint;
  LDetails: TThemedElementDetails;
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  with (Control as TPageControl).Canvas do
  begin
    if LStyle.Enabled and not LStyle.IsSystemStyle then
    begin
      // Let VCL style handle the drawing
      if Active then
        LDetails := LStyle.GetElementDetails(ttTabItemSelected)
      else
        LDetails := LStyle.GetElementDetails(ttTabItemNormal);
      LStyle.DrawElement(Handle, LDetails, Rect);
      Brush.Style := bsClear;
      Font.Color := LStyle.GetSystemColor(clBtnText);
    end
    else
    begin
      Brush.Color := clMenuBar;
      FillRect(Rect);
    end;

    AText := TPageControl(Control).Pages[TabIndex].Caption;
    APoint.X := (Rect.Right - Rect.Left) div 2 - TextWidth(AText) div 2;
    APoint.Y := (Rect.Bottom - Rect.Top) div 2 - TextHeight(AText) div 2;
    TextRect(Rect, Rect.Left + APoint.X, Rect.Top + APoint.Y, AText);

    if Active and (LStyle.IsSystemStyle or not LStyle.Enabled) then
    begin
      Pen.Color := $00EFD3C6;
      Pen.Width := 3;
      MoveTo(Rect.Left + 3, Rect.Top + 4);
      LineTo(Rect.Right - 4, 4);
    end;
  end;
end;
```

Add to the uses clause of frm_main.pas (if not already present):
```pascal
Vcl.Themes
```

- [ ] **Step 2: Update unit_ColorTabs.pas**

In `Program/Units/unit_ColorTabs.pas`, update `WMEraseBkGnd` to respect styles:

```pascal
procedure TTabSheet.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
var
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  if LStyle.Enabled and not LStyle.IsSystemStyle then
    inherited  // Let VCL style handle background
  else if FColor = clBtnFace then
    inherited
  else
  begin
    Brush.Color := FColor;
    Windows.FillRect(Msg.dc, ClientRect, Brush.Handle);
    Msg.Result := 1;
  end;
end;
```

Add `Vcl.Themes` to the uses clause.

- [ ] **Step 3: Review hardcoded colors in Settings**

Check `COLORS_SECTION` in `unit_Settings.pas` (lines 751-758). Colors like `FBookColor`, `FBGColor`, `FFontColor` default to `clWhite`/`clBlack`. These will need to be overridden when a dark theme is active. For now, document this as a known issue — Phase 3 will address it.

- [ ] **Step 4: Build and test**

Build. Test with both Win10Modern and Win10ModernDark styles:
1. Tab drawing should not look broken
2. Tab sheet backgrounds should match the style
3. Status bar should render correctly

- [ ] **Step 5: Commit**

```bash
git add Program/Forms/frm_main.pas Program/Units/unit_ColorTabs.pas
git commit -m "Fix owner-drawn controls to work with VCL Styles"
```

---

### Task 5: Disable OwnerDraw on PageControl when using VCL Styles

**Files:**
- Modify: `Program/Forms/frm_main.pas` — conditionally disable OwnerDraw

VCL Styles render tabs themselves. With OwnerDraw=True + VCL Style, you get double-drawing artifacts. The cleanest fix: disable OwnerDraw when a non-system style is active.

- [ ] **Step 1: Disable OwnerDraw at startup when style is active**

In `TfrmMain.FormCreate` (frm_main.pas), add near the beginning:
```pascal
if StyleServices.Enabled and not StyleServices.IsSystemStyle then
  pgControl.OwnerDraw := False;
```

- [ ] **Step 2: Build and test**

Build. Verify tabs render cleanly with Win10Modern style (no artifacts, no double borders).

- [ ] **Step 3: Commit**

```bash
git add Program/Forms/frm_main.pas
git commit -m "Disable tab OwnerDraw when VCL Style is active"
```

---

## Chunk 2: Icon Migration

### Task 6: Download and organize Fluent UI SVG icons

**Files:**
- Create: `Program/Resources/Icons/Light/` — SVG icons for light theme (dark strokes on light bg)
- Create: `Program/Resources/Icons/Dark/` — SVG icons for dark theme (light strokes on dark bg)

`TImageCollection` in Delphi 13 natively supports SVG format. Icons are loaded from SVG files at runtime — no resource DLL or .rc compilation needed.

For MyHomeLib, we need these icon categories based on the current ImageList inventory:

**Toolbar icons (ilToolBar — ~18 icons):**
Read, Add to Download, Send to Device, Rus Alphabet, Eng Alphabet, Select Collection, Add to Favorites, Select All, Collapse/Expand, Switch Tree/Table Mode, Show Deleted, Show Local Only, Show Cover/Info, Settings, Help, Edit toolbar icons

**Menu icons (ilMainMenu):**
All main menu item icons (need to catalog exact count from DFM)

**File type icons (ilFileTypes):**
FB2, FBD, RAW, Archive icons

**Severity icons (SeverityImages, SeverityImagesBig in dm_user):**
Error/warning/info indicator icons

- [ ] **Step 1: Catalog all icons needed**

Read `Program/Forms/frm_main.dfm` to extract:
1. All `ImageIndex` values used by toolbar buttons, menu items
2. Map each index to its purpose (from Action names and hints)
3. List required Fluent UI icon names for each

Create a mapping file at `Program/Resources/Icons/icon-mapping.md`.

- [ ] **Step 2: Download Fluent UI SVG icons**

Download needed icons from the Fluent UI System Icons repository (https://github.com/microsoft/fluentui-system-icons). Get SVG format in "regular" style (outline icons), 24px or 32px size.

For dark theme variants: Fluent UI SVGs use `currentColor` by default, so the same SVG can work in both themes if the VCL style sets the icon color. If not, create dark variants by replacing stroke/fill color in SVGs (e.g., `#212121` → `#FFFFFF`).

Organize in:
```
Program/Resources/Icons/Light/   — SVGs with dark strokes (for light theme)
Program/Resources/Icons/Dark/    — SVGs with light strokes (for dark theme)
```

- [ ] **Step 3: Commit icon files**

```bash
git add Program/Resources/Icons/
git commit -m "Add Fluent UI SVG icons for light and dark themes"
```

---

### Task 7: Create images data module

**Files:**
- Create: `Program/DataModules/dm_Images.pas` + `dm_Images.dfm`
- Modify: `Program/MyHomeLib.dpr` — add to uses and create at startup

Following ELN's `dm_TreeImages.pas` pattern, but using SVG files loaded directly into TImageCollection (Delphi 13 supports SVG natively).

- [ ] **Step 1: Create dm_Images data module**

Create `Program/DataModules/dm_Images.pas`:

```pascal
unit dm_Images;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.IOUtils,
  Vcl.Forms, Vcl.Controls, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList;

type
  TIconTheme = (itLight, itDark);

  TdmImages = class(TDataModule)
    ToolbarImageCollection: TImageCollection;
    vilToolbar: TVirtualImageList;
    MenuImageCollection: TImageCollection;
    vilMenu: TVirtualImageList;
    FileTypeImageCollection: TImageCollection;
    vilFileTypes: TVirtualImageList;
  private
    FCurrentTheme: TIconTheme;
    FThemeLoaded: Boolean;
    procedure LoadSVGCollection(ACollection: TImageCollection;
      const AIconDir: string;
      const ANames: array of string;
      const ACategoryPrefix: string);
  public
    procedure LoadIcons(ATheme: TIconTheme);
    procedure ApplyThemeIcons;
    class function DetectIconTheme: TIconTheme; static;
    property CurrentTheme: TIconTheme read FCurrentTheme;
  end;

var
  dmImages: TdmImages;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

// Icon name arrays — populated during Task 6 (names match SVG filenames without extension)

const
  CToolbarOrder: array[0..N] of string = (
    'book_open', 'arrow_download', 'send', ...
  );

  CMenuOrder: array[0..N] of string = (
    ...
  );

  CFileTypeOrder: array[0..N] of string = (
    'document', 'archive', ...
  );


class function TdmImages.DetectIconTheme: TIconTheme;
var
  C: COLORREF;
  R, G, B: Byte;
begin
  C := GetSysColor(COLOR_BTNFACE);
  R := GetRValue(C);
  G := GetGValue(C);
  B := GetBValue(C);
  if (0.299 * R + 0.587 * G + 0.114 * B) < 128 then
    Result := itDark
  else
    Result := itLight;
end;


procedure TdmImages.LoadSVGCollection(ACollection: TImageCollection;
  const AIconDir: string;
  const ANames: array of string;
  const ACategoryPrefix: string);
var
  I: Integer;
  Item: TImageCollectionItem;
  SVGPath: string;
begin
  for I := 0 to High(ANames) do
  begin
    SVGPath := AIconDir + ANames[I] + '.svg';
    Item := ACollection.Images.Add;
    Item.Name := ACategoryPrefix + ANames[I];
    if FileExists(SVGPath) then
    begin
      Item.SourceImages.Add;
      Item.SourceImages[0].Image.LoadFromFile(SVGPath);
    end;
  end;
end;


procedure TdmImages.LoadIcons(ATheme: TIconTheme);
var
  IconsDir, ThemeDir: string;
begin
  IconsDir := ExtractFilePath(Application.ExeName) + 'Resources\Icons\';
  if ATheme = itDark then
    ThemeDir := IconsDir + 'Dark\'
  else
    ThemeDir := IconsDir + 'Light\';

  ToolbarImageCollection.Images.Clear;
  LoadSVGCollection(ToolbarImageCollection, ThemeDir, CToolbarOrder, 'Toolbar\');

  MenuImageCollection.Images.Clear;
  LoadSVGCollection(MenuImageCollection, ThemeDir, CMenuOrder, 'Menu\');

  FileTypeImageCollection.Images.Clear;
  LoadSVGCollection(FileTypeImageCollection, ThemeDir, CFileTypeOrder, 'FileType\');

  FCurrentTheme := ATheme;
  FThemeLoaded := True;
end;


procedure TdmImages.ApplyThemeIcons;
var
  NewTheme: TIconTheme;
begin
  NewTheme := DetectIconTheme;
  if (not FThemeLoaded) or (NewTheme <> FCurrentTheme) then
    LoadIcons(NewTheme);
end;

end.
```

- [ ] **Step 2: Create the DFM**

Create `Program/DataModules/dm_Images.dfm` with empty TImageCollection and TVirtualImageList components:
```
object dmImages: TdmImages
  Height = 300
  Width = 500
  object ToolbarImageCollection: TImageCollection
    Images = <>
    Left = 56
    Top = 40
  end
  object vilToolbar: TVirtualImageList
    Images = <>
    ImageCollection = ToolbarImageCollection
    Width = 32
    Height = 32
    Left = 56
    Top = 120
  end
  object MenuImageCollection: TImageCollection
    Images = <>
    Left = 200
    Top = 40
  end
  object vilMenu: TVirtualImageList
    Images = <>
    ImageCollection = MenuImageCollection
    Width = 20
    Height = 20
    Left = 200
    Top = 120
  end
  object FileTypeImageCollection: TImageCollection
    Images = <>
    Left = 344
    Top = 40
  end
  object vilFileTypes: TVirtualImageList
    Images = <>
    ImageCollection = FileTypeImageCollection
    Width = 16
    Height = 16
    Left = 344
    Top = 120
  end
end
```

- [ ] **Step 3: Register in dpr and create at startup**

In `Program/MyHomeLib.dpr`:
1. Add `dm_Images in 'DataModules\dm_Images.pas' {dmImages: TDataModule}` to uses
2. Add creation after `DMUser.Init`:
```pascal
  Application.CreateForm(TdmImages, dmImages);
  dmImages.ApplyThemeIcons;
```

- [ ] **Step 4: Build and verify**

Build. Verify no crashes, data module created successfully.

- [ ] **Step 5: Commit**

```bash
git add Program/DataModules/dm_Images.pas Program/DataModules/dm_Images.dfm Program/MyHomeLib.dpr
git commit -m "Add images data module with theme-aware icon loading"
```

---

### Task 8: Migrate main form ImageLists to TVirtualImageList

**Files:**
- Modify: `Program/Forms/frm_main.pas` — switch Images properties
- Modify: `Program/Forms/frm_main.dfm` — remove old TImageList data, update references

This is the largest task. Each toolbar/menu that references an old TImageList needs to point to the new TVirtualImageList from dmImages instead.

- [ ] **Step 1: Update toolbar image references**

In `Program/Forms/frm_main.pas` or `FormCreate`, reassign:
```pascal
tlbrMain.Images := dmImages.vilToolbar;
// Remove DisabledImages assignment — TVirtualImageList handles disabled state
MainMenu.Images := dmImages.vilMenu;
```

- [ ] **Step 2: Update tree view image references**

For VirtualTreeView instances that use `ilFileTypes`:
```pascal
tvBooksA.Images := dmImages.vilFileTypes;
tvBooksS.Images := dmImages.vilFileTypes;
// ... all book tree views
```

- [ ] **Step 3: Remove old TImageList components**

Remove from `frm_main.dfm`:
- `ilToolBar` (line 3011) — large bitmap block
- `ilMainMenu` (line 6724) — large bitmap block
- `ilFileTypes` (line 8077) — large bitmap block
- `ilToolBar_Disabled` (line 8740) — entire component (no longer needed)
- `ilToolImages` (line 12917) — large bitmap block

Keep `ilAlphabetNormal` and `ilAlphabetActive` for now — alphabet buttons use a special rendering pattern.

Remove corresponding field declarations from `frm_main.pas`.

**WARNING:** ImageIndex values on toolbar buttons/menu items must match the order in the TVirtualImageList. Verify the mapping is correct by checking each Action/button's ImageIndex against the icon name array in dm_Images.

- [ ] **Step 4: Build and test**

Build. Verify:
1. All toolbar buttons show correct icons
2. All menu items show correct icons
3. File type icons appear in tree views
4. No blank/missing icons

- [ ] **Step 5: Commit**

```bash
git add Program/Forms/frm_main.pas Program/Forms/frm_main.dfm Program/DataModules/dm_Images.pas
git commit -m "Migrate main form ImageLists to TVirtualImageList"
```

---

### Task 9: Migrate dm_user ImageLists

**Files:**
- Modify: `Program/DataModules/dm_user.pas` + `dm_user.dfm`

- [ ] **Step 1: Replace SeverityImages and SeverityImagesBig**

In `dm_user.dfm`, remove old `SeverityImages` and `SeverityImagesBig` TImageList components.
In `dm_user.pas`, update references to use `dmImages.vilXxx` or add a severity collection to dm_Images.

- [ ] **Step 2: Build and test**

- [ ] **Step 3: Commit**

```bash
git add Program/DataModules/dm_user.pas Program/DataModules/dm_user.dfm Program/DataModules/dm_Images.pas
git commit -m "Migrate dm_user ImageLists to TVirtualImageList"
```

---

## Chunk 3: DPI Awareness + Polish

### Task 10: Enable PerMonitorV2 DPI awareness

**Files:**
- Modify: `Program/MyhomeLib.dproj` — set `AppDPIAwarenessMode` to `PerMonitorV2`

- [ ] **Step 1: Update dproj**

In `Program/MyhomeLib.dproj`, change all `<AppDPIAwarenessMode>none</AppDPIAwarenessMode>` entries (lines 96, 113, 162, 193) to:
```xml
<AppDPIAwarenessMode>PerMonitorV2</AppDPIAwarenessMode>
```

- [ ] **Step 2: Set Scaled=True on all forms**

Verify that all form DFMs either have `Scaled = True` (or omit it, since True is the default). Check each DFM for `Scaled = False` and remove those lines.

- [ ] **Step 3: Build and test at multiple DPI settings**

Build. Test at:
- 100% (96 DPI)
- 125% (120 DPI)
- 150% (144 DPI)

Check for: clipped text, overlapping controls, misaligned panels.

- [ ] **Step 4: Commit**

```bash
git add Program/MyhomeLib.dproj
git commit -m "Enable PerMonitorV2 DPI awareness"
```

---

### Task 11: Fix hardcoded sizes and colors for DPI/theme compatibility

**Files:**
- Modify: `Program/Forms/frm_main.pas` — fix hardcoded pixel values
- Modify: `Program/Units/unit_Settings.pas` — theme-aware color defaults

- [ ] **Step 1: Audit hardcoded pixel values in frm_main.pas**

Search for hardcoded pixel values (Width, Height assignments in code, not DFM). Replace with `MulDiv(Value, CurrentPPI, 96)` or `ScaleValue(Value)` where needed.

Key areas:
- Toolbar button sizes
- Splitter MinSize values
- Panel widths set in code

- [ ] **Step 2: Add theme-aware color defaults**

In `unit_Settings.pas`, the `COLORS_SECTION` defaults to `clWhite`/`clBlack`. When dark theme is active, these need sensible defaults. Add a method to `TMHLSettings`:

```pascal
procedure TMHLSettings.ApplyThemeColors(ADarkMode: Boolean);
begin
  if ADarkMode then
  begin
    if FBGColor = clWhite then FBGColor := $00303030;
    if FFontColor = clBlack then FFontColor := clWhite;
    // ... similar for other color fields
  end;
end;
```

Call this after loading settings and after theme detection.

- [ ] **Step 3: Build and test**

Test with both themes at 150% scaling. Verify colors and layout look correct.

- [ ] **Step 4: Commit**

```bash
git add Program/Forms/frm_main.pas Program/Units/unit_Settings.pas
git commit -m "Fix hardcoded sizes and add theme-aware color defaults"
```

---

### Task 12: Final polish and cleanup

**Files:**
- Review all forms for visual issues
- Clean up unused code

- [ ] **Step 1: Test all dialogs**

Open each dialog and verify it renders correctly with VCL Styles:
- Settings (`frm_settings`)
- About (`frm_about`)
- Book Info (`frm_book_info`)
- Search (`frm_search`)
- Statistics (`frm_statistic`)
- All editor dialogs
- All progress forms
- New Collection Wizard

- [ ] **Step 2: Fix any visual issues found**

Common issues:
- Hardcoded colors in DFMs (e.g., `Color = clWhite`) — remove or make style-aware
- `ParentColor = False` on labels — may need `StyleElements` adjustment
- Custom-drawn panels or speedbuttons

- [ ] **Step 3: Update .gitignore for .superpowers directory**

```bash
echo ".superpowers/" >> .gitignore
```

- [ ] **Step 4: Final commit**

```bash
git add -A
git commit -m "UI modernization: final polish and cleanup"
```
