# MyHomeLib — TODO

| # | Task | Size | Status |
|---|------|------|--------|
| B7 | Decouple `TDownloadManagerThread` / `TDownloadBooksThread` from `frmMain` — extract an `IDownloadView` interface (progress, tray hint, download tree ops, button state) and route all UI access through it via `Synchronize`. Currently 40+ direct `frmMain.<control>` references from thread context. | 🔴 XL | 🔴 Open |
