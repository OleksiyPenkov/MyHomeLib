# MyHomeLib — TODO

| # | Task | Size | Status |
|---|------|------|--------|
| 1 | MyHomeLib MCP server (`Utils/MHLMcpServer`, branch `mcp-server-impl`) — 9 tools (6 catalogue + `get_book_toc`/`get_book_text`/`search_in_book`), all automated tests pass (26 protocol + 8 extractor + 41 cache); awaiting manual verification against the running app per `Utils/MHLMcpServer/README.md`'s checklist, especially `collection_busy` under real lock contention and field-by-field comparison with the app's UI | 🟠 L | 🔴 Open |
| 2 | Add a `--make-fixture` CLI mode to `MHLMcpServer.exe` that builds a tiny SQLite collection via `TBookCollection_SQLite.CreateTemp`, so the 6 catalogue tools (currently manual-checklist-only) get automated coverage in `tests/run_tests.js` | 🟡 M | 🔴 Open |
| 3 | Escape the seven spliced `search_books` arguments (`title`, `author`, `series`, `lang`, `keyword`, `annotation`, `min_lib_rate`) the same way the `genre` field was fixed — see the "It is not free of it elsewhere" note in `Utils/MHLMcpServer/README.md` | 🟡 M | 🔴 Open |
