# Reset settings section to defaults

**Date:** 2026-07-26
**Status:** Approved

## Problem

The settings dialog (`frm_settings`) offers no way to undo accumulated
customisation. A user who has scrambled the tree colours or the export templates
must either edit `myhomelib2.ini` by hand or delete it and lose every other
setting with it.

## Scope

A reset control for two sections of the dialog:

- **Папки/Пристрої** (`tsDevices`, tree node 0)
- **Інтерфейс** (`tsInterface`, tree node 2)

The remaining six sections (Типи файлів, Інтернет, Проксі, Скрипти, Різне,
Сортування файлів) are out of scope. Their defaults stay as inline literals.

## Design

### 1. Single source of truth for defaults

Defaults currently exist only as literals inside `TMHLSettings.LoadSettings`,
as the third argument of each `iniFile.Read*` call. A reset needs the same
values in a second place, so they are extracted into named constants in the
interface section of `unit_Settings.pas`. `LoadSettings` is rewritten to use
those names as its ini fallbacks, so a reset and a fresh install can never
disagree.

`Graphics` is already in that unit's interface `uses`, so the colour constants
resolve without a new dependency.

| Constant | Value | Was inline at |
| --- | --- | --- |
| `DEF_PROMPT_DEVICE_PATH` | `True` | `unit_Settings.pas:671` |
| `DEF_DEVICE_DIR` | `''` | `:660` |
| `DEF_READ_DIR` | `''` | `:661` |
| `DEF_EXPORT_FORMAT` | `0` (`emFB2`) | `:678` |
| `DEF_FOLDER_TEMPLATE` | `'%fc\%s'` | `:674` |
| `DEF_FILE_NAME_TEMPLATE` | `'[%n - ]%t'` | `:675` |
| `DEF_REMOVE_SQUARE_BRACKETS` | `True` | `:676` |
| `DEF_TXT_ENCODING` | `0` (UTF-8) | `:688` |
| `DEF_TREE_FONT_SIZE` | `8` | `:697` |
| `DEF_SHORT_FONT_SIZE` | `8` | `:698` |
| `DEF_FONT_COLOR` | `clBlack` | `:758` |
| `DEF_LOCAL_COLOR` | `clBlack` | `:760` |
| `DEF_DELETED_COLOR` | `clGray` | `:761` |
| `DEF_BOOK_COLOR` | `clWhite` | `:753` |
| `DEF_SERIES_COLOR` | `clWhite` | `:754` |
| `DEF_AUTHOR_COLOR` | `clWhite` | `:755` |
| `DEF_SERIES_BOOK_COLOR` | `clWhite` | `:756` |
| `DEF_BG_COLOR` | `clWhite` | `:757` |

Only these are extracted. Other tabs' literals are left alone.

### 2. One shared button

`btnReset: TButton`, caption «Скинути», added to `pnButtons` in
`frm_settings.dfm` beside «Довідка». `frm_settings.dfm` is a 96 DPI form
(`TextHeight = 13`, no `PixelsPerInch`), so it takes the same metrics as
`btnHelp`: `Left = 93` (12 + 75 + 6), `Top = 10`, `Width = 75`, `Height = 25`,
no anchors, `TabOrder = 3`, `OnClick = btnResetClick`.

The button acts on whichever section is currently active. This keeps one
handler and makes adding a third section a single `case` branch.

### 3. Enabled only where a reset exists

`tvSectionsChange` sets, after the existing `ActivePageIndex` assignment:

```pascal
btnReset.Enabled := (pcSetPages.ActivePage = tsDevices) or
                    (pcSetPages.ActivePage = tsInterface);
```

`FormShow` already selects node 0, so the state is correct when the dialog
opens. On the other six sections the button is visible but greyed out.

### 4. Reset touches controls only, never `Settings`

`btnResetClick` confirms, then dispatches to `ResetDevicesTab` or
`ResetInterfaceTab`. Both write **only to form controls**. Consequences:

- «Відміна» still discards a reset, because `Settings` was never mutated.
- «Зберегти» commits it through the existing `SaveSettings`, so no new
  persistence path is introduced and nothing new can go wrong on save.

`ResetDevicesTab` assigns the eight device constants, then calls
`cbPromptPathClick(nil)` so the enable/disable rule for `edDeviceDir` and
`btnDeviceDir` is re-applied.

`ResetInterfaceTab` sets `udFontSize.Position` and `udShortFontSize.Position`
— their `Associate` edits update themselves — then calls the existing
`SetPanelFontColor(DEF_FONT_COLOR)`, then the two custom font colours and the
five background colours.

### 5. Confirmation

Resetting Папки/Пристрої clears both saved folder paths (their factory default
is an empty string), so the action is confirmed first:

```pascal
rstrConfirmReset = 'Скинути налаштування цього розділу до типових значень?';
```

shown via `MessageDlg(rstrConfirmReset, mtConfirmation, [mbYes, mbNo], 0)`.

## Files touched

| File | Change |
| --- | --- |
| `Program/Units/unit_Settings.pas` | Add `DEF_*` const block; rewrite 18 `LoadSettings` fallbacks to use it |
| `Program/Forms/frm_settings.dfm` | Add `btnReset` to `pnButtons` |
| `Program/Forms/frm_settings.pas` | Declare `btnReset` + handlers, add `rstrConfirmReset`, implement `btnResetClick` / `ResetDevicesTab` / `ResetInterfaceTab`, extend `tvSectionsChange` |

## Notes

- `edFontSize` and `edShortFontSize` carry `Text = '10'` in the DFM, but the
  loader's default is `8`. The DFM value is design-time noise overwritten by
  `LoadSetting` on every open. Reset uses `8`, matching a fresh install.
- Font size changes require an app restart. The tab already states this
  («* Потрібен перезапуск програми»), so reset needs no extra warning.

## Verification

No test framework in this repo. Verification is a Win64 build followed by a
Win32 build, both clean, plus a manual pass:

1. Change several values on Папки/Пристрої, press «Скинути», confirm — controls
   return to the table above, and the device-folder edit follows the
   «Запитувати шлях» checkbox.
2. Same on Інтерфейс, including all five colour swatches and both font sizes.
3. Press «Відміна» after a reset, reopen — the old values are still there.
4. Press «Зберегти» after a reset, reopen — the defaults persisted.
5. Click through the other six sections — «Скинути» is greyed out.
