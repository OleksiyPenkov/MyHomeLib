# UI Modernization Design Spec

## Goal

Modernize MyHomeLib's visual appearance to match Windows 10/11 native look & feel, while keeping the existing layout and navigation structure intact.

## Design Decisions

- **Target style:** Windows 11 Modern Light & Dark (built-in VCL Styles)
- **Theme switching:** Auto-detect Windows system theme; user override in Settings (Light / Dark / System)
- **Icons:** Fluent UI System Icons (Microsoft, open source SVGs) via `TImageCollection` + `TVirtualImageList`
- **DPI:** PerMonitorV2 DPI awareness, all forms scaled
- **Scope:** Visual refresh only — no changes to layout, navigation, or functionality

## Current State

- `Vcl.Themes` and `Vcl.Styles` in uses clause but no style applied (classic Windows controls)
- 10 `TImageList` instances with embedded bitmap data across 3 forms/data modules
- No DPI awareness configured, no `PixelsPerInch` set on forms
- VirtualTreeView used for data display (needs theme-aware color adjustments)

### ImageList Inventory

| # | Location | Name | Purpose |
|---|----------|------|---------|
| 1 | frm_main | ilToolBar | Main toolbar icons |
| 2 | frm_main | ilMainMenu | Main menu icons |
| 3 | frm_main | ilFileTypes | File type icons in tree |
| 4 | frm_main | ilToolBar_Disabled | Disabled toolbar icons (can be removed with SVG) |
| 5 | frm_main | ilAlphabetNormal | Alphabet bar normal state |
| 6 | frm_main | ilAlphabetActive | Alphabet bar active state |
| 7 | frm_main | ilToolImages | Additional tool icons |
| 8 | dm_user | SeverityImages | Severity indicator icons |
| 9 | dm_user | SeverityImagesBig | Large severity icons |
| 10 | frm_ConverToFBD | ilButtonImages | FBD converter button icons |

## Phased Implementation

### Phase 1: VCL Styles + Theme Switching (foundation)

1. Add `Windows11 Modern Light` and `Windows11 Modern Dark` style resources to `MyhomeLib.dproj`
2. Create a `unit_ThemeManager.pas` utility:
   - Detect Windows system theme (light/dark) via registry or `dwmapi`
   - Apply matching VCL Style at startup
   - Expose `TMHLThemeMode = (tmSystem, tmLight, tmDark)` for user preference
3. Add theme preference to `TMHLSettings` and Settings dialog
4. Enable `PerMonitorV2` DPI awareness in app manifest (`MyhomeLib.dproj`)
5. Set `Scaled = True` on all forms, set `PixelsPerInch = 96`
6. Adjust VirtualTreeView colors for dark mode (background, font, selection)

**Risk:** Custom-drawn controls and VirtualTreeView may need style hooks. Alphabet toolbar buttons use owner-draw — needs testing.

### Phase 2: Icon Migration (visual refresh)

1. Download Fluent UI System Icons SVGs (only needed icons, ~30-40 icons)
2. Store SVGs in `Program/Resources/Icons/` directory
3. Create a shared `TImageCollection` + `TVirtualImageList` on `DMUser` data module
4. Migrate all toolbar, menu, and tree ImageList references to `TVirtualImageList`
5. Remove `ilToolBar_Disabled` (SVG handles disabled state automatically)
6. Remove embedded bitmap data from DFMs

### Phase 3: Polish & Testing

1. Test all forms at 100%, 125%, 150%, 200% scaling
2. Fix hardcoded pixel sizes and layout issues
3. Fine-tune VirtualTreeView colors for both themes
4. Update alphabet toolbar button rendering for new style
5. Verify all dialogs (Settings, About, Search, Book Info, etc.)
6. Test with both light and dark Windows system themes

## Out of Scope

- Layout or navigation changes (tabs, splitters, panels stay as-is)
- Functional changes
- New controls or components
- Localization changes
