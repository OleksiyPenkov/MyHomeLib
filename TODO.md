# MyHomeLib — TODO

| # | Task | Size | Status |
|---|------|------|--------|
| B7 | Decouple `TDownloadManagerThread` / `TDownloadBooksThread` from `frmMain` — extract an `IDownloadView` interface (progress, tray hint, download tree ops, button state) and route all UI access through it via `Synchronize`. Currently 40+ direct `frmMain.<control>` references from thread context. | 🔴 XL | 🔴 Open |
| F1 | Restore batch `AutoMode` FBD-creation. The procedure at `frm_ConverToFBD.pas:324-348` and its toolbar handler `tbtnAutoFBDClick` (`frm_main.pas:2496-2511`) are both disabled. Previous note: "add normal logic with a mutex that never corrupts a book file". Needs a safe cross-process locking design before re-enabling. | 🟠 L | 🔴 Open |
| F6f | URL format for "Edit at library site" / "View at library site" is hardcoded (`%sb/%s/edit`, `%sb/%s/`) in `frm_main.pas:4820, 6023`. Works for Librusec/Flibusta but isn't a per-binding abstraction. Add `GetEditURL(LibID)` / `GetViewURL(LibID)` to `IBookCollection` when a library with a different URL scheme is added. | 🟡 M | 🔴 Open |
