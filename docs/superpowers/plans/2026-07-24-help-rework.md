# Help Rework Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the 2011 Russian `MyHomeLib.chm` with a folder of Ukrainian UTF-8 HTML topics shipped beside the executable and opened in the user's default browser, rewritten against the current 2.6.0 UI.

**Architecture:** `Program/Help/` holds 54 hand-written topic pages plus one stylesheet. A Node script in `tools/help/` owns the shared navigation sidebar (injected between marker comments) so a TOC change never requires editing 54 files. A second Node script is the test harness: it validates links, encoding, TOC completeness, and the consistency of the Pascal context-ID table against both the topic files and the DFMs. On the Delphi side a new `unit_HelpTopics.pas` maps `HelpContext` IDs to topic file names and launches them with `ShellExecute`, replacing three `HtmlHelp()` call sites.

**Tech Stack:** Delphi 13 (RAD Studio 37.0) / VCL, Object Pascal; plain HTML5 + CSS (no JavaScript in shipped pages); Node.js v24 for build/verification tooling; Inno Setup 6 for packaging.

**Spec:** `docs/superpowers/specs/2026-07-24-help-rework-design.md`

## Global Constraints

- Help source of truth is `Program/Help/`, tracked in git. Build outputs (`Program/OUT/`) and installer staging (`Installer/Common/`) are gitignored and must never be the source.
- Every shipped HTML file is **UTF-8 without BOM**, declares `<meta charset="utf-8">`, and `<html lang="uk">`.
- Shipped pages contain **no JavaScript**, no external fonts, no CDN references, and **no `<img>` tags**. They must render correctly opened as `file://`.
- All help prose is **Ukrainian**. UI element names are quoted exactly as they appear in the Ukrainian DFM `Caption` values or in the `resourcestring` declarations of `Program/Units/unit_MHL_strings.pas` / `unit_Consts.pas`.
- Fixed terminology, established in `terms.html` and used consistently everywhere: колекція, книга, група, обране, жанр, серія, пристрій, читалка, скрипт.
- Delphi conventions (`~/.claude/skills/delphi-dev.md`): commit prefix `+` for additions, `*` for modifications/fixes. **Do not commit without a successful MSBuild first.** Do not modify `.dproj`/`.groupproj` unless the task explicitly says so.
- DFM edits are restricted to `HelpContext` values only. Never touch `Left`, `Top`, `Width`, `Height`, `ExplicitLeft/Top/Width/Height`, `Align`, `Anchors`, `PixelsPerInch`, `TextHeight`, `Margins.*`, `Padding.*`, `Constraints.*`.
- Build command (Release/Win32, main app only):
  ```
  cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MyhomeLib.dproj /t:Build /p:Config=Release /p:Platform=Win32 /nologo /v:minimal" 2>&1
  ```
- The verification script is run from the repo root as `node tools/help/check_help.js` and must exit 0.
- **Nothing in this plan is marked done until the user confirms it works in the running application.** A successful build is not confirmation.

---

### Task 1: Help tooling and page skeleton

Builds the TOC definition, the nav generator, the verification script, the stylesheet, and `index.html`. Nothing else can be verified until the checker exists, so it comes first.

**Files:**
- Create: `tools/help/topics.json`
- Create: `tools/help/build_nav.js`
- Create: `tools/help/check_help.js`
- Create: `Program/Help/help.css`
- Create: `Program/Help/index.html`

**Interfaces:**
- Consumes: nothing.
- Produces:
  - `tools/help/topics.json` — the ordered TOC. Shape: `{ "sections": [ { "title": string, "topics": [ { "file": string, "title": string } ] } ] }`. Every later task reads this to know the canonical file name and Ukrainian title of a topic.
  - `node tools/help/build_nav.js` — creates any topic file listed in `topics.json` that does not yet exist (from the standard template), then rewrites the `<!-- TOC:BEGIN -->…<!-- TOC:END -->` block in every `Program/Help/*.html`. Idempotent. Exit 0 on success.
  - `node tools/help/check_help.js` — the test harness. Exit 0 = pass, exit 1 = fail with a list of problems.
  - Standard page template, used by every topic file:
    ```html
    <!DOCTYPE html>
    <html lang="uk">
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{TITLE}} — Довідка MyHomeLib</title>
    <link rel="stylesheet" href="help.css">
    </head>
    <body>
    <nav id="toc">
    <!-- TOC:BEGIN -->
    <!-- TOC:END -->
    </nav>
    <main id="content">
    <h1>{{TITLE}}</h1>
    <!-- BODY:BEGIN -->
    <!-- BODY:END -->
    </main>
    </body>
    </html>
    ```
    Content tasks replace only what sits between `<!-- BODY:BEGIN -->` and `<!-- BODY:END -->`.

- [ ] **Step 1: Write the TOC definition**

Create `tools/help/topics.json`. This is the single source of truth for file names, titles and order.

```json
{
  "sections": [
    {
      "title": "Вступ",
      "topics": [
        { "file": "index.html", "title": "Довідка MyHomeLib" },
        { "file": "about.html", "title": "Про програму" },
        { "file": "terms.html", "title": "Основні терміни" },
        { "file": "faq.html", "title": "Часті запитання" },
        { "file": "donate.html", "title": "Підтримати розробку" }
      ]
    },
    {
      "title": "Встановлення",
      "topics": [
        { "file": "install.html", "title": "Встановлення" },
        { "file": "upgrade.html", "title": "Оновлення попередньої версії" },
        { "file": "portable.html", "title": "Portable-версія" }
      ]
    },
    {
      "title": "Інтерфейс",
      "topics": [
        { "file": "interface.html", "title": "Інтерфейс програми" },
        { "file": "main_window.html", "title": "Головне вікно" },
        { "file": "browsing.html", "title": "Перегляд колекції: автори, серії, жанри" },
        { "file": "toolbar.html", "title": "Панель інструментів" },
        { "file": "hotkeys.html", "title": "Гарячі клавіші" },
        { "file": "main_menu.html", "title": "Головне меню" },
        { "file": "menu_book.html", "title": "Меню «Книга»" },
        { "file": "menu_collection.html", "title": "Меню «Колекція»" },
        { "file": "menu_tools.html", "title": "Меню «Інструменти»" },
        { "file": "menu_view.html", "title": "Меню «Вигляд»" },
        { "file": "context_menus.html", "title": "Контекстні меню" }
      ]
    },
    {
      "title": "Робота з колекціями",
      "topics": [
        { "file": "collections.html", "title": "Робота з колекціями" },
        { "file": "coll_types.html", "title": "Типи колекцій" },
        { "file": "new_collection.html", "title": "Створення колекції" },
        { "file": "coll_params.html", "title": "Властивості колекції" },
        { "file": "copy_books.html", "title": "Копіювання книг між колекціями" },
        { "file": "delete_collection.html", "title": "Видалення колекції" },
        { "file": "export_inpx.html", "title": "Експорт колекції у формат INPX" },
        { "file": "update.html", "title": "Оновлення колекції" },
        { "file": "sync_folders.html", "title": "Синхронізація тек і файлів" },
        { "file": "genres.html", "title": "Списки жанрів" },
        { "file": "maintenance.html", "title": "Обслуговування бази даних" }
      ]
    },
    {
      "title": "Робота з книгами",
      "topics": [
        { "file": "books.html", "title": "Робота з книгами" },
        { "file": "add_books.html", "title": "Додавання книг до колекції" },
        { "file": "import_fb2.html", "title": "Імпорт книг у форматі FB2" },
        { "file": "import_nonfb2.html", "title": "Імпорт книг не-FB2 та FBD" },
        { "file": "download.html", "title": "Завантаження книг" },
        { "file": "reading.html", "title": "Читання книг" },
        { "file": "selection.html", "title": "Виділення та позначення книг" },
        { "file": "search.html", "title": "Пошук книг і фільтри" },
        { "file": "groups.html", "title": "Групи та обране" },
        { "file": "rating.html", "title": "Рейтинг і статус «Прочитано»" },
        { "file": "export_device.html", "title": "Надсилання книг на пристрій" },
        { "file": "export_html.html", "title": "Експорт списку книг" },
        { "file": "delete.html", "title": "Видалення книг" },
        { "file": "editing.html", "title": "Редагування описів книг" }
      ]
    },
    {
      "title": "Налаштування",
      "topics": [
        { "file": "settings.html", "title": "Налаштування програми" },
        { "file": "set_interface.html", "title": "Інтерфейс" },
        { "file": "set_readers.html", "title": "Типи файлів і програми для читання" },
        { "file": "set_device.html", "title": "Пристрої та експорт" },
        { "file": "set_internet.html", "title": "Інтернет і проксі" },
        { "file": "set_scripts.html", "title": "Скрипти" },
        { "file": "set_filesort.html", "title": "Сортування файлів" },
        { "file": "set_other.html", "title": "Поведінка" }
      ]
    },
    {
      "title": "Додаток",
      "topics": [
        { "file": "scripts_examples.html", "title": "Приклади скриптів" },
        { "file": "user_data.html", "title": "Експорт та імпорт даних користувача" }
      ]
    }
  ]
}
```

- [ ] **Step 2: Write the verification script**

Create `tools/help/check_help.js`. This is the test. It runs before the files it checks exist, and must fail.

```js
'use strict';
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..', '..');
const HELP = path.join(ROOT, 'Program', 'Help');
const TOPICS = path.join(__dirname, 'topics.json');
const MAP_UNIT = path.join(ROOT, 'Program', 'Units', 'unit_HelpTopics.pas');
const DFM_DIRS = ['Program/Forms', 'Program/Forms/Editors', 'Program/Wizards'];

const problems = [];
const fail = (m) => problems.push(m);

function listTopics() {
  const spec = JSON.parse(fs.readFileSync(TOPICS, 'utf8'));
  return spec.sections.flatMap((s) => s.topics);
}

function walk(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    if (e.name === '__history') continue;
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, out);
    else out.push(p);
  }
  return out;
}

// --- 1. every topic in topics.json exists on disk -------------------------
const topics = listTopics();
const declared = new Set(topics.map((t) => t.file));
for (const t of topics) {
  if (!fs.existsSync(path.join(HELP, t.file))) fail(`missing topic file: ${t.file}`);
}

// --- 2. no stray html in Help/ that topics.json does not declare ----------
const onDisk = fs.existsSync(HELP)
  ? fs.readdirSync(HELP).filter((f) => f.endsWith('.html'))
  : [];
for (const f of onDisk) {
  if (!declared.has(f)) fail(`undeclared file in Program/Help: ${f}`);
}

// --- 3. per-file content rules -------------------------------------------
for (const t of topics) {
  const p = path.join(HELP, t.file);
  if (!fs.existsSync(p)) continue;
  const buf = fs.readFileSync(p);
  const html = buf.toString('utf8');

  if (buf[0] === 0xef && buf[1] === 0xbb && buf[2] === 0xbf) fail(`${t.file}: has UTF-8 BOM`);
  if (Buffer.compare(Buffer.from(html, 'utf8'), buf) !== 0) fail(`${t.file}: not valid UTF-8`);
  if (!/<meta charset="utf-8">/i.test(html)) fail(`${t.file}: missing <meta charset="utf-8">`);
  if (!/<html lang="uk">/i.test(html)) fail(`${t.file}: missing <html lang="uk">`);
  if (/<img\b/i.test(html)) fail(`${t.file}: contains an <img> tag (help ships without images)`);
  if (/<script\b/i.test(html)) fail(`${t.file}: contains a <script> tag`);
  if (/https?:\/\/[^"']*\.(css|js|woff2?|ttf)/i.test(html)) fail(`${t.file}: references an external asset`);
  if (!html.includes('<!-- TOC:BEGIN -->') || !html.includes('<!-- TOC:END -->'))
    fail(`${t.file}: missing TOC markers`);
  if (!html.includes('<!-- BODY:BEGIN -->') || !html.includes('<!-- BODY:END -->'))
    fail(`${t.file}: missing BODY markers`);

  const expectedTitle = `<title>${t.title} — Довідка MyHomeLib</title>`;
  if (!html.includes(expectedTitle)) fail(`${t.file}: <title> should be ${expectedTitle}`);

  const body = html.split('<!-- BODY:BEGIN -->')[1]?.split('<!-- BODY:END -->')[0] ?? '';
  if (body.trim() === '' || body.includes('Розділ у роботі'))
    fail(`${t.file}: body not written yet`);

  // internal links resolve
  for (const m of html.matchAll(/href="([^"#:]+)(#[^"]*)?"/g)) {
    const target = m[1];
    if (target.startsWith('http') || target.startsWith('mailto:')) continue;
    if (target.endsWith('.htm')) fail(`${t.file}: legacy .htm link: ${target}`);
    if (!fs.existsSync(path.join(HELP, target))) fail(`${t.file}: dead link: ${target}`);
  }
}

// --- 4. stylesheet exists -------------------------------------------------
if (!fs.existsSync(path.join(HELP, 'help.css'))) fail('missing Program/Help/help.css');

// --- 5. Pascal context map (skipped until the unit exists) ---------------
if (fs.existsSync(MAP_UNIT)) {
  const pas = fs.readFileSync(MAP_UNIT, 'utf8');
  const entries = [...pas.matchAll(/\(ContextID:\s*(\d+);\s*FileName:\s*'([^']+)'\)/g)]
    .map((m) => ({ id: Number(m[1]), file: m[2] }));
  if (entries.length === 0) fail('unit_HelpTopics.pas: no map entries parsed');

  // the declared array bound must match the number of entries actually written
  const bound = pas.match(/HelpTopics:\s*array\s*\[0\s*\.\.\s*(\d+)\]/);
  if (!bound) fail('unit_HelpTopics.pas: cannot read the HelpTopics array bound');
  else if (Number(bound[1]) + 1 !== entries.length)
    fail(
      `unit_HelpTopics.pas: array bound [0 .. ${bound[1]}] declares ` +
        `${Number(bound[1]) + 1} entries but ${entries.length} were parsed`
    );

  const ids = new Set();
  for (const e of entries) {
    if (ids.has(e.id)) fail(`unit_HelpTopics.pas: duplicate ContextID ${e.id}`);
    ids.add(e.id);
    if (!declared.has(e.file)) fail(`unit_HelpTopics.pas: ContextID ${e.id} -> undeclared topic ${e.file}`);
  }

  // every HelpContext in a live DFM is either mapped or the 5001 sentinel
  const dfmIds = new Set();
  for (const dir of DFM_DIRS) {
    for (const f of walk(path.join(ROOT, dir))) {
      if (!f.endsWith('.dfm')) continue;
      const text = fs.readFileSync(f, 'latin1');
      for (const m of text.matchAll(/HelpContext = (\d+)/g)) dfmIds.add(Number(m[1]));
    }
  }
  for (const id of dfmIds) {
    if (id === 5001) continue;
    if (!ids.has(id)) fail(`HelpContext ${id} appears in a DFM but is not in unit_HelpTopics.pas`);
  }
}

// --- report ---------------------------------------------------------------
if (problems.length) {
  console.error(`check_help: ${problems.length} problem(s)`);
  for (const p of problems) console.error('  - ' + p);
  process.exit(1);
}
console.log(`check_help: OK (${topics.length} topics)`);
```

- [ ] **Step 3: Run the checker to verify it fails**

Run: `node tools/help/check_help.js`
Expected: exit 1, output listing `missing topic file: index.html` … through `missing topic file: user_data.html` (54 lines) plus `missing Program/Help/help.css`.

- [ ] **Step 4: Write the nav generator**

Create `tools/help/build_nav.js`.

```js
'use strict';
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..', '..');
const HELP = path.join(ROOT, 'Program', 'Help');
const spec = JSON.parse(fs.readFileSync(path.join(__dirname, 'topics.json'), 'utf8'));

const esc = (s) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');

function navFor(current) {
  const out = ['<p class="nav-title"><a href="index.html">Довідка MyHomeLib</a></p>'];
  for (const section of spec.sections) {
    out.push(`<p class="nav-section">${esc(section.title)}</p>`);
    out.push('<ul>');
    for (const t of section.topics) {
      if (t.file === 'index.html') continue; // already the nav title
      const cur = t.file === current ? ' class="cur" aria-current="page"' : '';
      out.push(`<li><a href="${t.file}"${cur}>${esc(t.title)}</a></li>`);
    }
    out.push('</ul>');
  }
  return out.join('\n');
}

function template(title) {
  return `<!DOCTYPE html>
<html lang="uk">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${esc(title)} — Довідка MyHomeLib</title>
<link rel="stylesheet" href="help.css">
</head>
<body>
<nav id="toc">
<!-- TOC:BEGIN -->
<!-- TOC:END -->
</nav>
<main id="content">
<h1>${esc(title)}</h1>
<!-- BODY:BEGIN -->
<p>Розділ у роботі.</p>
<!-- BODY:END -->
</main>
</body>
</html>
`;
}

fs.mkdirSync(HELP, { recursive: true });

let created = 0;
let updated = 0;
for (const section of spec.sections) {
  for (const t of section.topics) {
    const p = path.join(HELP, t.file);
    if (!fs.existsSync(p)) {
      fs.writeFileSync(p, template(t.title), 'utf8');
      created++;
    }
    const html = fs.readFileSync(p, 'utf8');
    const next = html.replace(
      /<!-- TOC:BEGIN -->[\s\S]*?<!-- TOC:END -->/,
      `<!-- TOC:BEGIN -->\n${navFor(t.file)}\n<!-- TOC:END -->`
    );
    if (next !== html) {
      fs.writeFileSync(p, next, 'utf8');
      updated++;
    }
  }
}
console.log(`build_nav: created ${created}, updated nav in ${updated}`);
```

- [ ] **Step 5: Write the stylesheet**

Create `Program/Help/help.css`.

```css
:root {
  --bg: #ffffff;
  --fg: #1c1c1e;
  --muted: #6b6b70;
  --rule: #e2e2e6;
  --nav-bg: #f6f6f8;
  --link: #0a5ca8;
  --code-bg: #f0f0f3;
}

@media (prefers-color-scheme: dark) {
  :root {
    --bg: #1b1b1d;
    --fg: #e6e6e8;
    --muted: #9a9aa0;
    --rule: #34343a;
    --nav-bg: #232327;
    --link: #6cb0f0;
    --code-bg: #2a2a30;
  }
}

* { box-sizing: border-box; }

body {
  margin: 0;
  display: flex;
  align-items: flex-start;
  background: var(--bg);
  color: var(--fg);
  font: 16px/1.6 "Segoe UI", system-ui, sans-serif;
}

#toc {
  flex: 0 0 300px;
  position: sticky;
  top: 0;
  height: 100vh;
  overflow-y: auto;
  padding: 24px 20px 40px;
  background: var(--nav-bg);
  border-right: 1px solid var(--rule);
  font-size: 14px;
}

.nav-title { margin: 0 0 20px; font-size: 16px; font-weight: 600; }
.nav-title a { color: var(--fg); text-decoration: none; }

.nav-section {
  margin: 20px 0 6px;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: .04em;
  text-transform: uppercase;
  color: var(--muted);
}

#toc ul { margin: 0; padding: 0; list-style: none; }
#toc li { margin: 0; }

#toc a {
  display: block;
  padding: 4px 8px;
  border-radius: 4px;
  color: var(--link);
  text-decoration: none;
}

#toc a:hover { background: rgba(127, 127, 127, .14); }

#toc a.cur {
  background: rgba(127, 127, 127, .2);
  color: var(--fg);
  font-weight: 600;
}

#content {
  flex: 1 1 auto;
  max-width: 46em;
  padding: 32px 40px 80px;
}

h1 {
  margin: 0 0 24px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--rule);
  font-size: 26px;
  font-weight: 600;
}

h2 { margin: 32px 0 10px; font-size: 19px; font-weight: 600; }
h3 { margin: 24px 0 8px; font-size: 16px; font-weight: 600; }

p, ul, ol, dl { margin: 0 0 14px; }
li { margin: 0 0 5px; }

a { color: var(--link); }

code, kbd {
  padding: 1px 5px;
  border-radius: 3px;
  background: var(--code-bg);
  font-family: Consolas, "Cascadia Mono", monospace;
  font-size: .9em;
}

kbd { border: 1px solid var(--rule); }

.ui { font-weight: 600; }

table {
  width: 100%;
  margin: 0 0 18px;
  border-collapse: collapse;
  font-size: 15px;
}

th, td {
  padding: 7px 10px;
  border-bottom: 1px solid var(--rule);
  text-align: left;
  vertical-align: top;
}

th { font-weight: 600; }

.note {
  margin: 0 0 16px;
  padding: 10px 14px;
  border-left: 3px solid var(--link);
  background: var(--code-bg);
  border-radius: 0 4px 4px 0;
}

@media (max-width: 860px) {
  body { display: block; }
  #toc {
    position: static;
    width: auto;
    height: auto;
    border-right: 0;
    border-bottom: 1px solid var(--rule);
  }
  #content { padding: 24px 20px 60px; }
}
```

- [ ] **Step 6: Scaffold all topic files**

Run: `node tools/help/build_nav.js`
Expected: `build_nav: created 54, updated nav in 54`

- [ ] **Step 7: Write the index page body**

Replace the body block of `Program/Help/index.html` (between the markers) with:

```html
<!-- BODY:BEGIN -->
<p>MyHomeLib — програма для керування домашньою бібліотекою електронних книг.
Вона каталогізує локальні збірки файлів і водночас працює як клієнт мережевих
бібліотек на рушії Лібрусек (Флібуста та подібні).</p>

<p>Оберіть розділ ліворуч або почніть із того, що вам потрібно зараз:</p>

<h2>Перші кроки</h2>
<ul>
<li><a href="install.html">Встановлення</a> — як поставити програму й куди вона пише свої дані.</li>
<li><a href="terms.html">Основні терміни</a> — колекція, група, обране, INPX: що означає кожне слово.</li>
<li><a href="new_collection.html">Створення колекції</a> — майстер, який проведе вас через усі кроки.</li>
</ul>

<h2>Найчастіші завдання</h2>
<ul>
<li><a href="add_books.html">Додати книги до колекції</a></li>
<li><a href="search.html">Знайти книгу</a></li>
<li><a href="reading.html">Прочитати книгу</a></li>
<li><a href="export_device.html">Надіслати книги на пристрій</a></li>
<li><a href="download.html">Завантажити книги з мережевої бібліотеки</a></li>
</ul>

<h2>Якщо щось не працює</h2>
<ul>
<li><a href="faq.html">Часті запитання</a></li>
<li><a href="maintenance.html">Обслуговування бази даних</a></li>
</ul>

<p class="note">Довідку можна відкрити будь-коли клавішею <kbd>F1</kbd>. У більшості
вікон <kbd>F1</kbd> одразу відкриває розділ, що стосується поточного вікна або вкладки.</p>
<!-- BODY:END -->
```

- [ ] **Step 8: Run the checker**

Run: `node tools/help/check_help.js`
Expected: exit 1, with 53 `body not written yet` problems (every topic except `index.html`) and no other problem types. This confirms the skeleton, titles, links, encoding and markers are all correct and only prose is missing.

- [ ] **Step 9: Commit**

```bash
git add tools/help Program/Help
git commit -m "+ Help tooling and page skeleton

Adds tools/help/topics.json (TOC definition), build_nav.js (nav
generator + scaffolder) and check_help.js (verification harness),
plus Program/Help/help.css and the 54 scaffolded topic pages.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 2: Content — Вступ

**Files:**
- Modify: `Program/Help/about.html`, `terms.html`, `faq.html`, `donate.html`

**Interfaces:**
- Consumes: page template and markers from Task 1.
- Produces: nothing later tasks depend on beyond the shared terminology fixed in `terms.html`.

Only the block between `<!-- BODY:BEGIN -->` and `<!-- BODY:END -->` is edited. Never edit the `<!-- TOC:… -->` block by hand — `build_nav.js` owns it.

- [ ] **Step 1: Read the sources**

Read before writing:
- `Program/Forms/frm_about.pas` and `frm_about.dfm` — what the About box actually shows.
- `Program/MyhomeLib.dproj` — `VerInfo_Keys` in the Release config, for the current version (2.6.0) and copyright.
- `README.md` — the project's own one-paragraph description.
- `Program/Units/unit_Consts.pas` — `SETTINGS_FILE_NAME`, `SYSTEM_DATABASE_FILENAME`, `COLLECTIONS_FILENAME` and the other predefined file names, for `terms.html`.
- `Program/Units/unit_Globals.pas` — `TBookFormat` (`bfFb2`, `bfFb2Archive`, `bfFbd`, `bfRaw`, `bfRawArchive`) and `COLLECTION_TYPE`, for the format vocabulary in `terms.html`.

- [ ] **Step 2: Write the four topics**

| File | Required sections |
|---|---|
| `about.html` | What MyHomeLib is; current version and licence (MIT); the project home `https://github.com/OleksiyPenkov/myhomelib`; credits as listed in `frm_about.dfm`; where to report problems. |
| `terms.html` | A definition list covering: **колекція**, **тип колекції** (локальна / мережева), **INPX**, **FB2 / FB2.ZIP / FBD / не-FB2**, **група**, **обране**, **жанр**, **серія**, **пристрій**, **читалка**, **скрипт**, **системна база** (`user.dbs2`). Each entry one or two sentences. This page fixes the vocabulary used by every other topic. |
| `faq.html` | At minimum: where settings and the system database live; why a book will not open; why a downloaded book is missing; what to do when the collection list looks wrong or empty; how to move a collection to another disk; how to move the whole library to a new computer. Each answer links to the topic that explains it fully. |
| `donate.html` | How to support the project. Take the current wording and links from `frm_about.dfm`; if the old CHM's `donate.htm` lists payment details that no longer appear anywhere in the current sources, omit them rather than carrying them over. |

Use `<dl>/<dt>/<dd>` for `terms.html`, `<h2>` per question for `faq.html`. Mark UI element names with `<span class="ui">«…»</span>`.

- [ ] **Step 3: Refresh nav and run the checker**

Run: `node tools/help/build_nav.js && node tools/help/check_help.js`
Expected: exit 1, with exactly 49 `body not written yet` problems and no other problem type. (53 minus the 4 written here.)

- [ ] **Step 4: Commit**

```bash
git add Program/Help
git commit -m "+ Help: Вступ section (about, terms, faq, donate)

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 3: Content — Встановлення

**Files:**
- Modify: `Program/Help/install.html`, `upgrade.html`, `portable.html`

- [ ] **Step 1: Read the sources**

- `Installer/Common.iss` and `Installer/Setup_Script_MyHomeLib.iss` / `Setup_Script_MyHomeLib_x64.iss` — what the installer places where, the `{app}` and `{userappdata}\MyHomeLib` split, the desktop-icon task, the offered languages.
- `Program/Units/unit_Settings.pas` — how `AppPath` and the data directory are chosen, and how portable mode is detected (search for the working-folder / portable logic around `sfAppHelp` and the other `sf…` cases).
- `Program/Units/unit_Consts.pas` — `SETTINGS_FILE_NAME`, `SYSTEM_DATABASE_FILENAME`, `COLLECTIONS_FILENAME`.
- The old `upgrade` material is the 2011 `clear_setup.htm` + `from_old.htm`; both describe migration from MyHomeLib 1.x. Do **not** carry that over — write `upgrade.html` about upgrading a current 2.x install.

- [ ] **Step 2: Write the three topics**

| File | Required sections |
|---|---|
| `install.html` | System requirements; x86 vs x64 installer; what the installer writes to the program folder versus `%APPDATA%\MyHomeLib`; the Start-menu entries created; how to uninstall; a note that collections themselves live wherever the user put them and are not removed by uninstalling. |
| `upgrade.html` | Installing a new version over an existing one; that settings, the system database and collections are preserved; that a backup of `user.dbs2` before a major upgrade is prudent, and where it is; what to do if a collection fails to open after an upgrade (link to `maintenance.html`). |
| `portable.html` | How to run MyHomeLib from a removable drive; which files must sit beside the executable; how the program decides between portable and installed data locations; the limitations. Verify every claim against `unit_Settings.pas` — if the current code no longer supports something the 2011 topic described, say so plainly instead of repeating it. |

- [ ] **Step 3: Refresh nav and run the checker**

Run: `node tools/help/build_nav.js && node tools/help/check_help.js`
Expected: exit 1, exactly 46 `body not written yet` problems, no other problem type.

- [ ] **Step 4: Commit**

```bash
git add Program/Help
git commit -m "+ Help: Встановлення section (install, upgrade, portable)

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 4: Content — Інтерфейс

The largest content task: 11 topics. Split the reading from the writing; do not start writing until every listed source has been read, because these topics must quote captions exactly.

**Files:**
- Modify: `Program/Help/interface.html`, `main_window.html`, `browsing.html`, `toolbar.html`, `hotkeys.html`, `main_menu.html`, `menu_book.html`, `menu_collection.html`, `menu_tools.html`, `menu_view.html`, `context_menus.html`

- [ ] **Step 1: Read the sources**

- `Program/Forms/frm_main.dfm` — the whole file. Menus, toolbars, tab sheets, popup menus, shortcuts. Captions are stored as `#NNNN` character escapes; decode them rather than guessing.
- `Program/Forms/frm_main.pas` — the action list and the `…Execute` handlers, to learn what each menu item actually does.
- `Program/Units/unit_treeController.pas` and `Program/Forms/unit_treeController.pas` — the author/series/genre tree behaviour behind the `tsByAuthor`, `tsBySerie`, `tsByGenre` tabs.
- `Program/Units/unit_Columns.pas` — the book-list columns and how they are configured.
- `Program/DataModules/dm_Images.pas` — the icon set, to name toolbar buttons by their action rather than by picture.
- `Program/Units/unit_MHL_strings.pas` and `unit_Consts.pas` — captions assigned at runtime.

To decode DFM captions reliably, use this helper (write it to the scratchpad, not the repo):

```js
// node decode.js <path-to.dfm>
const fs = require('fs');
const txt = fs.readFileSync(process.argv[2], 'latin1');
let stack = [];
for (const line of txt.split(/\r?\n/)) {
  const ind = line.match(/^ */)[0].length;
  const obj = line.match(/^\s*object\s+(\w+):\s*(\w+)/);
  if (obj) { stack = stack.filter((s) => s.ind < ind); stack.push({ ind, name: obj[1], cls: obj[2] }); continue; }
  const cap = line.match(/^\s*(Caption|Hint|ShortCut) = (.+)$/);
  if (cap && stack.length) {
    let out = '';
    for (const m of cap[2].matchAll(/'([^']*)'|#(\d+)/g)) out += m[1] !== undefined ? m[1] : String.fromCharCode(+m[2]);
    if (out && out !== '-') {
      const cur = stack[stack.length - 1];
      console.log('  '.repeat(stack.length - 1) + cur.cls + ' ' + cur.name + ' :: ' + cap[1] + ' = ' + out);
    }
  }
}
```

- [ ] **Step 2: Write the eleven topics**

| File | Required sections |
|---|---|
| `interface.html` | One-screen orientation: the parts of the window and links to the detailed topics. Short — it is a hub. |
| `main_window.html` | The main window's regions: the mode tabs, the tree panel, the book list, the book-info panel, the status bar. Names each region as the UI names it and links onward. This is the F1 target for the main form (context ID 2). |
| `browsing.html` | The «Автори», «Серії» and «Жанри» tabs: what the tree shows in each, how selecting a node filters the book list, the alphabet bars, collapse/expand. F1 target for context ID 135. |
| `toolbar.html` | Every button on the main and edit toolbars, in on-screen order: what it does and the equivalent menu command. Take the button list from `frm_main.dfm`, not from the 2011 topic. |
| `hotkeys.html` | A table of every `ShortCut` found in `frm_main.dfm`, grouped by area, with the command name. Do not invent shortcuts — list only what the DFM declares. |
| `main_menu.html` | The top-level menu structure and what each menu is for; links to the per-menu topics. |
| `menu_book.html` | Every item in the «Книга» menu. F1 target for context ID 105. |
| `menu_collection.html` | Every item in the «Колекція» menu, including the «Імпорт», «Експорт» and «Обслуговування» submenus. F1 target for context ID 112. |
| `menu_tools.html` | Every item in the «Інструменти» menu, including «Запустити скрипт». |
| `menu_view.html` | The «Вигляд» menu: panels, «Додатково» (cover, annotation, BookInfo priority), «Режим перегляду», status bar, alphabet bars. |
| `context_menus.html` | The popup menus: on the author/series/genre tree, on the book list, and on the download list. Merges the old `author_list.htm` and `book_list.htm`. |

Every menu topic uses a two-column table: command caption on the left, what it does on the right, with the shortcut in `<kbd>` where one exists.

- [ ] **Step 3: Refresh nav and run the checker**

Run: `node tools/help/build_nav.js && node tools/help/check_help.js`
Expected: exit 1, exactly 35 `body not written yet` problems, no other problem type.

- [ ] **Step 4: Commit**

```bash
git add Program/Help
git commit -m "+ Help: Інтерфейс section (11 topics)

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 5: Content — Робота з колекціями

**Files:**
- Modify: `Program/Help/collections.html`, `coll_types.html`, `new_collection.html`, `coll_params.html`, `copy_books.html`, `delete_collection.html`, `export_inpx.html`, `update.html`, `sync_folders.html`, `genres.html`, `maintenance.html`

- [ ] **Step 1: Read the sources**

- `Program/Forms/frm_bases.pas` / `.dfm` — the collection manager. F1 target for context ID 110.
- `Program/Wizards/NewCollection/frm_NewCollectionWizard.pas` and every `frame_NCW*.pas` in that folder — the wizard steps in order: `frame_NCWWelcom`, `frame_NCWOperation`, `frame_NCWCollectionNameAndLocation`, `frame_NCWCollectionFileTypes`, `frame_NCWInpxSource`, `frame_NCWSelectGenreFile`, `frame_NCWDownload`, `frame_NCWProgress`, `frame_NCWFinish`. Also `unit_NCWParams.pas`.
- `Program/Wizards/Base/frm_MHLWizardBase.pas` — F1 target for context ID 136.
- `Program/Units/unit_Interfaces.pas` — `ISystemData` and `IBookCollection`, for what a collection owns.
- `Program/Units/unit_Globals.pas` — `COLLECTION_TYPE` values, for `coll_types.html`.
- `Program/ImportImpl/unit_ExportINPXThread.pas` — INPX export.
- `Program/UtilsImpl/unit_libupdateThread.pas` — collection update.
- `Program/UtilsImpl/unit_SyncFoldersThread.pas` — folder/file synchronisation.
- `Program/Forms/frm_genre_tree.pas` and `Program/Units/unit_Consts.pas` (`GENRES_FB2_FILENAME`, `GENRES_NONFB2_FILENAME`, `GENRELIST_EXTENSION`) — genre lists.
- `Program/Forms/frm_DeleteCollection.pas` / `.dfm` — collection deletion.
- `frm_main.dfm` «Обслуговування» submenu plus the `miRepairDataBase` / `miCompactDataBase` handlers in `frm_main.pas` — database maintenance.
- `Program/Forms/frm_statistic.pas` — the statistics dialog, referenced from `collections.html`.

- [ ] **Step 2: Write the eleven topics**

| File | Required sections |
|---|---|
| `collections.html` | What a collection is, that several may coexist, how to switch between them, where the list is kept, and links onward. F1 target for context ID 110. |
| `coll_types.html` | Local versus online collections; which operations each supports; the `COLLECTION_TYPE` values as the UI presents them; how the type is chosen and that it cannot be changed afterwards. |
| `new_collection.html` | The wizard, step by step in the order the frames appear. Each step gets an `<h2>`. F1 target for context ID 136. |
| `coll_params.html` | The collection properties dialog: every field, what it affects, and which fields are read-only after creation. |
| `copy_books.html` | Copying books between collections: how to select the target, what is copied (file plus metadata plus user data), and the limits. |
| `delete_collection.html` | Removing a collection from the list versus deleting its files from disk — state clearly which one the command does and what is irreversible. |
| `export_inpx.html` | Exporting a collection to INPX: what INPX is, what ends up in the file, and what it is useful for. |
| `update.html` | Updating a collection from its source: what triggers an update, what changes, and what happens to user data (groups, ratings, read marks) during one. |
| `sync_folders.html` | Synchronising the collection with a folder of files: which direction, what is detected, what is left alone. |
| `genres.html` | The genre list files, the difference between the FB2 and non-FB2 lists, and how to refresh genres for a collection. |
| `maintenance.html` | «Перевірити базу» and «Стиснути базу»: what each does, when to run it, that the collection must be closed if that is the case, and how long it may take. Include the recovery path referenced from `faq.html` and `upgrade.html`. |

- [ ] **Step 3: Refresh nav and run the checker**

Run: `node tools/help/build_nav.js && node tools/help/check_help.js`
Expected: exit 1, exactly 24 `body not written yet` problems, no other problem type.

- [ ] **Step 4: Commit**

```bash
git add Program/Help
git commit -m "+ Help: Робота з колекціями section (11 topics)

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 6: Content — Робота з книгами

**Files:**
- Modify: `Program/Help/books.html`, `add_books.html`, `import_fb2.html`, `import_nonfb2.html`, `download.html`, `reading.html`, `selection.html`, `search.html`, `groups.html`, `rating.html`, `export_device.html`, `export_html.html`, `delete.html`, `editing.html`

- [ ] **Step 1: Read the sources**

- `Program/ImportImpl/unit_ImportFB2Thread.pas`, `unit_ImportFB2ThreadBase.pas`, `unit_ImportInpxThread.pas` — FB2 import.
- `Program/ImportImpl/unit_ImportFBDThread.pas` and `Program/Forms/frm_add_nonfb2.pas` / `.dfm` — non-FB2 and FBD import. F1 target for context ID 129.
- `Program/ImportImpl/frm_ImportProgressForm.pas`, `frm_ImportProgressFormEx.pas` — what the user sees during an import, and `IMPORT_ERRORLOG_FILENAME` from `unit_Consts.pas`.
- `Program/DwnldImpl/unit_DownloadBooksThread.pas`, `unit_DownloadManagerThread.pas`, `unit_Downloader.pas`, `frm_DownloadProgressForm.pas` — downloading, the download queue, and `DOWNLOAD_ERRORLOG_FILENAME`. F1 target for context ID 108 is the `tsDownload` tab in `frm_main.dfm`.
- `Program/Units/unit_Readers.pas` and `Program/Forms/Editors/frm_edit_reader.pas` — how a book is opened for reading.
- `Program/Forms/frm_search.pas` / `.dfm`, `Program/Units/unit_SearchUtils.pas`, `unit_SearchPresets.pas`, and the `tsSearch` tab in `frm_main.dfm` — search and presets. F1 target for context ID 126.
- `Program/Forms/Editors/frm_EditGroup.pas` and the `tsByGroup` tab in `frm_main.dfm` — groups. F1 target for context ID 125.
- `Program/Units/unit_UserData.pas` — ratings, read marks, group membership.
- `Program/UtilsImpl/unit_ExportToDevice.pas`, `unit_ExportToDeviceThread.pas`, `frm_ExportToDeviceProgressForm.pas` — sending to a device, and `EXPORT_ERRORLOG_FILENAME`.
- `Program/ImportImpl/unit_Export.pas` and the `miExportToHTML` handler in `frm_main.pas` — exporting a book list.
- `Program/Units/unit_Templater.pas`, `unit_TemplaterInternal.pas` — the file-name templates used by device export and by book-list export.
- `Program/Forms/Editors/frm_edit_book_info.pas`, `frm_edit_author.pas`, `frm_EditAuthorEx.pas` — editing descriptions. F1 target for context ID 117 is `frm_edit_author`.
- `Program/Units/unit_WriteFb2Info.pas` — what happens when an edit is written back into the FB2 file.
- The `pmMain` popup and the `pmiCheckAll` / `pmiSelectAll` / `pmMarkSelected` / `pmiDeselectAll` items in `frm_main.dfm` — selection versus marking.

- [ ] **Step 2: Write the fourteen topics**

| File | Required sections |
|---|---|
| `books.html` | Hub page: the operations available on books and links onward. |
| `add_books.html` | The three ways books enter a collection — import from files, download, folder synchronisation — and when to use each. |
| `import_fb2.html` | Importing FB2 and FB2.ZIP: choosing the source, what is read from the file, what happens to duplicates, where the error log is. |
| `import_nonfb2.html` | Importing non-FB2 files and FBD files. Cover both «Файли не-fb2» and «Файли FBD (pdf.zip djvu.zip)», since both use the same dialog and differ only in input. Explain what an FBD is and why it exists. F1 target for context ID 129. |
| `download.html` | Downloading from an online collection: adding to the queue, the «Завантаження» tab, pausing and resuming, retrying failures, where files land, the error log. F1 target for context ID 108. |
| `reading.html` | Opening a book: how the reader is chosen per file type, the built-in AlReader, and what to check when nothing opens (link to `set_readers.html`). |
| `selection.html` | The difference between the highlighted rows and the checkbox marks, and which commands act on which. Include «Відзначити все», «Виділити все», «Відзначити виділені», «Зняти позначки» with their shortcuts. |
| `search.html` | The «Пошук» tab: simple and advanced search, the available fields, presets, and how search interacts with the current collection. F1 target for context ID 126. This topic replaces the 2011 `filter.htm` and closes its dead `search.htm` link. |
| `groups.html` | Groups and «Обране»: creating a group, adding and removing books, that groups are user data stored in the system database and survive collection re-import. F1 target for context ID 125. |
| `rating.html` | Setting «Мій рейтинг», clearing it, the «Прочитано» mark, and where these values are stored. |
| `export_device.html` | Sending books to a device: choosing the device, the conversion step, the file-name template, what the progress window reports, the error log. |
| `export_html.html` | Exporting the current book list, including the available output formats and where the template comes from. |
| `delete.html` | Deleting books: removing from the collection versus deleting the file, what is irreversible, and how deleted entries behave afterwards. |
| `editing.html` | Editing a book description; editing an author; the extended author editor; and when changes are written back into the FB2 file. F1 target for context ID 117. |

- [ ] **Step 3: Refresh nav and run the checker**

Run: `node tools/help/build_nav.js && node tools/help/check_help.js`
Expected: exit 1, exactly 10 `body not written yet` problems, no other problem type.

- [ ] **Step 4: Commit**

```bash
git add Program/Help
git commit -m "+ Help: Робота з книгами section (14 topics)

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 7: Content — Налаштування and Додаток

**Files:**
- Modify: `Program/Help/settings.html`, `set_interface.html`, `set_readers.html`, `set_device.html`, `set_internet.html`, `set_scripts.html`, `set_filesort.html`, `set_other.html`, `scripts_examples.html`, `user_data.html`

**Interfaces:**
- Consumes: page template from Task 1.
- Produces: the settings topic file names that Task 8's context map binds to tabs. Task 8 assumes exactly these names: `settings.html`, `set_interface.html`, `set_readers.html`, `set_device.html`, `set_internet.html`, `set_scripts.html`, `set_filesort.html`, `set_other.html`.

- [ ] **Step 1: Read the sources**

- `Program/Forms/frm_settings.dfm` — every tab and every control on it. The tab objects are `tsDevices`, `tsReaders`, `tsInterface`, `tsInternet`, `tsProxy`, `tsScripts`, `tsBehavour`, `tsFileSort`. Their captions are assigned at runtime, so take the display names from `frm_settings.pas` / the resource strings, not from the DFM `Caption`.
- `Program/Forms/frm_settings.pas` — how each control maps onto a setting.
- `Program/Units/unit_Settings.pas` — `TMHLSettings`, the authoritative meaning and default of every setting.
- `Program/Units/unit_Readers.pas`, `Program/Forms/Editors/frm_edit_reader.pas` — the file-type/reader table.
- `Program/Units/unit_Scripts.pas`, `Program/Forms/Editors/frm_edit_script.pas` — scripts, their parameters and substitutions.
- `Program/Units/unit_Templater.pas` and `Program/Forms/Editors/frm_create_mask.pas` — the file-name mask editor used by device export and file sorting.
- `Program/Units/unit_MHLHttpClient.pas` — the proxy settings actually honoured.
- `Program/Units/unit_UserData.pas`, `Program/Units/unit_ImportOldUserData.pas`, and the `miExportUserData` / `miImportUserData` handlers in `frm_main.pas` — user-data export and import.

- [ ] **Step 2: Write the ten topics**

| File | Required sections |
|---|---|
| `settings.html` | How to open the settings dialog, that each tab has its own help page, and the note that <kbd>F1</kbd> on a tab opens that tab's page. F1 target for context ID 144. |
| `set_interface.html` | Every option on the «Інтерфейс» tab, including the visual theme selection and what a theme change requires. F1 target for context ID 132. |
| `set_readers.html` | The file-type-to-reader table: adding, editing and removing an entry; the built-in reader; what happens for a type with no reader. F1 target for context ID 137. |
| `set_device.html` | Device definitions and export options: the target folder, conversion, the file-name template, and the per-device overrides. F1 target for context ID 143. |
| `set_internet.html` | Connection settings and the proxy tab, covered together since both concern network access. F1 target for context IDs 133 and 145. |
| `set_scripts.html` | Registering a script, its parameters, the available substitutions, and when scripts run. F1 target for context ID 140. |
| `set_filesort.html` | The file-sorting rules and the mask editor. F1 target for context ID 148. |
| `set_other.html` | The «Поведінка» tab: startup behaviour, confirmations, update checks, and anything else on that tab. F1 target for context ID 147. |
| `scripts_examples.html` | Two or three worked examples using converters that actually ship or that the project documents today. Do **not** carry over the 2011 Fb2Fix or wolf-conversion examples — those features are gone. If no current example can be verified against the sources, say so and show the general shape of a script entry instead of inventing a specific converter. |
| `user_data.html` | Exporting and importing user data (groups, obране, ratings, read marks): what the file contains, when to use it, and how it relates to re-importing a collection. |

- [ ] **Step 3: Refresh nav and run the checker**

Run: `node tools/help/build_nav.js && node tools/help/check_help.js`
Expected: exit 0, output `check_help: OK (54 topics)`. All prose is now written.

- [ ] **Step 4: Commit**

```bash
git add Program/Help
git commit -m "+ Help: Налаштування and Додаток sections (10 topics)

Completes all 54 help topics; check_help passes.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 8: Context-ID map unit

**Files:**
- Create: `Program/Units/unit_HelpTopics.pas`
- Modify: `Program/Units/unit_MHL_strings.pas`
- Modify: `Program/Units/unit_Consts.pas:100`
- Modify: `Program/MyHomeLib.dpr`

**Interfaces:**
- Consumes: the topic file names produced by Tasks 2–7, exactly as listed in `tools/help/topics.json`.
- Produces:
  - `unit_HelpTopics.HelpTopicFile(ContextID: Integer): string` — returns the bare topic file name, or `'index.html'` for any unmapped ID.
  - `unit_HelpTopics.ShowHelpTopic(ContextID: Integer)` — resolves the topic against the help directory and opens it. Task 9 calls only this.
  - `unit_MHL_strings.rstrHelpFileNotFound` — format string with one `%s`.
  - `unit_Consts.APP_HELP_FILENAME = 'Help\index.html'` — `unit_Settings.pas:1321` already builds `AppPath + APP_HELP_FILENAME`, so no change is needed there.

- [ ] **Step 1: Extend the checker to require the map**

The checker's section 5 is currently skipped because `unit_HelpTopics.pas` does not exist. Make its absence a failure. In `tools/help/check_help.js`, replace:

```js
if (fs.existsSync(MAP_UNIT)) {
```

with:

```js
if (!fs.existsSync(MAP_UNIT)) {
  fail('missing Program/Units/unit_HelpTopics.pas');
} else {
```

- [ ] **Step 2: Run the checker to verify it fails**

Run: `node tools/help/check_help.js`
Expected: exit 1, single problem `missing Program/Units/unit_HelpTopics.pas`.

- [ ] **Step 3: Add the resource string**

In `Program/Units/unit_MHL_strings.pas`, add to the `resourcestring` block, after `rstrReadyMessage`:

```pascal
  rstrHelpFileNotFound = 'Файл довідки не знайдено:'#13#10'%s';
```

- [ ] **Step 4: Change the help file name constant**

In `Program/Units/unit_Consts.pas:100`, change:

```pascal
  APP_HELP_FILENAME = 'MyHomeLib.chm';
```

to:

```pascal
  APP_HELP_FILENAME = 'Help\index.html';
```

- [ ] **Step 5: Write the map unit**

Create `Program/Units/unit_HelpTopics.pas`. The header comment follows the house style used by the other units in `Program/Units/`.

```pascal
(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov aka Koreec (oleksiy.penkov@gmail.com)
  *
  * Author(s)           Oleksiy Penkov (oleksiy.penkov@gmail.com)
  * Created             24.07.2026
  * Description         Maps form/tab HelpContext IDs onto the HTML help topics
  *                     shipped in the Help subfolder, and opens them in the
  *                     default browser.
  *
  ****************************************************************************** *)

unit unit_HelpTopics;

interface

function HelpTopicFile(ContextID: Integer): string;
procedure ShowHelpTopic(ContextID: Integer);

implementation

uses
  Windows,
  SysUtils,
  Forms,
  Dialogs,
  ShellAPI,
  unit_Settings,
  unit_MHL_strings,
  dm_user;

const
  HELP_TOPIC_INDEX = 'index.html';

type
  THelpTopic = record
    ContextID: Integer;
    FileName: string;
  end;

const
  //
  // Кожен ID узятий з властивості HelpContext відповідної форми, вкладки
  // або пункту меню. 5001 та будь-який невідомий ID відкривають зміст.
  //
  HelpTopics: array [0 .. 19] of THelpTopic = (
    (ContextID: 1;   FileName: 'index.html'),              // pgControl
    (ContextID: 2;   FileName: 'main_window.html'),        // frmMain
    (ContextID: 105; FileName: 'menu_book.html'),          // меню "Книга"
    (ContextID: 108; FileName: 'download.html'),           // tsDownload
    (ContextID: 110; FileName: 'collections.html'),        // frmBases
    (ContextID: 112; FileName: 'menu_collection.html'),    // меню "Колекція"
    (ContextID: 117; FileName: 'editing.html'),            // frmEditAuthor
    (ContextID: 125; FileName: 'groups.html'),             // tsByGroup
    (ContextID: 126; FileName: 'search.html'),             // tsSearch
    (ContextID: 129; FileName: 'import_nonfb2.html'),      // frmAddNonFB2
    (ContextID: 132; FileName: 'set_interface.html'),      // tsInterface
    (ContextID: 133; FileName: 'set_internet.html'),       // tsInternet
    (ContextID: 135; FileName: 'browsing.html'),           // tsByAuthor/tsBySerie/tsByGenre
    (ContextID: 136; FileName: 'new_collection.html'),     // frmMHLWizardBase
    (ContextID: 137; FileName: 'set_readers.html'),        // tsReaders
    (ContextID: 140; FileName: 'set_scripts.html'),        // tsScripts
    (ContextID: 143; FileName: 'set_device.html'),         // tsDevices
    (ContextID: 144; FileName: 'settings.html'),           // frmSettings
    (ContextID: 145; FileName: 'set_internet.html'),       // tsProxy
    (ContextID: 147; FileName: 'set_other.html')           // tsBehavour
  );

function HelpTopicFile(ContextID: Integer): string;
var
  i: Integer;
begin
  for i := Low(HelpTopics) to High(HelpTopics) do
    if HelpTopics[i].ContextID = ContextID then
      Exit(HelpTopics[i].FileName);

  Result := HELP_TOPIC_INDEX;
end;

procedure ShowHelpTopic(ContextID: Integer);
var
  HelpDir: string;
  FullName: string;
begin
  HelpDir := ExtractFilePath(Settings.SystemFileName[sfAppHelp]);
  FullName := HelpDir + HelpTopicFile(ContextID);

  if not FileExists(FullName) then
  begin
    MessageDlg(Format(rstrHelpFileNotFound, [FullName]), mtWarning, [mbOK], 0);
    Exit;
  end;

  ShellExecute(Application.Handle, 'open', PChar(FullName), nil, nil, SW_SHOWNORMAL);
end;

end.
```

Two details the checker depends on:

- Every `FileName` in the array is a **string literal**, including ID 1 — `check_help.js` parses the entries with a regex and would silently skip an entry written as `HELP_TOPIC_INDEX`. The constant is used only as the fallback in `HelpTopicFile`.
- The array bound `[0 .. 19]` declares 20 entries and the checker verifies that it matches the number of entries actually present. Widening the array without adding an entry (or the reverse) fails the check.

`148` (`tsFileSort`) is deliberately absent here; Task 10 adds it together with the DFM change that introduces the ID, so the checker's DFM cross-check stays meaningful.

- [ ] **Step 6: Register the unit in the project**

In `Program/MyHomeLib.dpr`, add to the `uses` clause immediately after the `unit_Helpers` entry (line 74):

```pascal
  unit_HelpTopics in 'Units\unit_HelpTopics.pas',
```

Do **not** edit `MyhomeLib.dproj` — adding a `<DCCReference>` is an IDE bookkeeping concern and the project convention is to leave `.dproj` alone. MSBuild compiles the unit from the `.dpr` uses clause.

- [ ] **Step 7: Build**

Run:
```
cmd.exe //c "set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0&& set BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\37.0&& C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe Program\MyhomeLib.dproj /t:Build /p:Config=Release /p:Platform=Win32 /nologo /v:minimal" 2>&1
```
Expected: no errors. The three `HtmlHelp` call sites still compile — they are rewired in Task 9.

- [ ] **Step 8: Run the checker**

Run: `node tools/help/check_help.js`
Expected: exit 0, `check_help: OK (54 topics)`. The DFM cross-check passes because ID 148 does not yet exist in any DFM.

- [ ] **Step 9: Commit**

```bash
git add Program/Units/unit_HelpTopics.pas Program/Units/unit_MHL_strings.pas Program/Units/unit_Consts.pas Program/MyHomeLib.dpr tools/help/check_help.js
git commit -m "+ Add unit_HelpTopics: HelpContext ID to HTML topic map

APP_HELP_FILENAME now points at Help\\index.html. check_help.js
verifies the map against topics.json and against the HelpContext
values declared in the DFMs.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 9: Rewire the three help call sites

**Files:**
- Modify: `Program/Forms/frm_main.pas:6392-6399` (`TfrmMain.OnHelpHandler`)
- Modify: `Program/Forms/frm_main.pas:6626-6629` (`TfrmMain.ShowHelpExecute`)
- Modify: `Program/Forms/frm_settings.pas:549-553` (`TfrmSettings.ShowHelpClick`)

**Interfaces:**
- Consumes: `unit_HelpTopics.ShowHelpTopic(ContextID: Integer)` from Task 8.
- Produces: nothing further.

`HtmlHelp`, `HH_DISPLAY_TOC` and `HH_HELP_CONTEXT` resolve through `Winapi.Windows`, which both units already use for other reasons. There is no help-specific unit to remove from either `uses` clause.

- [ ] **Step 1: Rewrite `TfrmMain.OnHelpHandler`**

Replace:

```pascal
function TfrmMain.OnHelpHandler(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean;
begin
  if Data = 1 then
    HtmlHelp(Application.Handle, PChar(Settings.SystemFileName[sfAppHelp]), HH_DISPLAY_TOC, 0)
  else
    HtmlHelp(Application.Handle, PChar(Settings.SystemFileName[sfAppHelp]), HH_HELP_CONTEXT, Data);

  CallHelp := False;
end;
```

with:

```pascal
function TfrmMain.OnHelpHandler(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean;
begin
  ShowHelpTopic(Data);

  CallHelp := False;
  Result := True;
end;
```

`HelpTopicFile` already maps `Data = 1` onto `index.html`, so the old branch is redundant.

- [ ] **Step 2: Rewrite `TfrmMain.ShowHelpExecute`**

Replace:

```pascal
procedure TfrmMain.ShowHelpExecute(Sender: TObject);
begin
  HtmlHelp(Application.Handle, PChar(Settings.SystemFileName[sfAppHelp]), HH_DISPLAY_TOC, 0);
end;
```

with:

```pascal
procedure TfrmMain.ShowHelpExecute(Sender: TObject);
begin
  ShowHelpTopic(1);
end;
```

- [ ] **Step 3: Add the unit to `frm_main.pas`'s implementation uses**

In the implementation-section `uses` clause of `Program/Forms/frm_main.pas` (starting at line 969), add:

```pascal
  unit_HelpTopics,
```

- [ ] **Step 4: Rewrite `TfrmSettings.ShowHelpClick`**

In `Program/Forms/frm_settings.pas`, replace:

```pascal
procedure TfrmSettings.ShowHelpClick(Sender: TObject);
begin
  HtmlHelp(Application.Handle, PChar(Settings.SystemFileName[sfAppHelp]), HH_HELP_CONTEXT, pcSetPages.ActivePage.HelpContext);
  frmSettings.FocusControl(btnOk);
end;
```

with:

```pascal
procedure TfrmSettings.ShowHelpClick(Sender: TObject);
begin
  ShowHelpTopic(pcSetPages.ActivePage.HelpContext);
  frmSettings.FocusControl(btnOk);
end;
```

- [ ] **Step 5: Add the unit to `frm_settings.pas`'s implementation uses**

In the implementation-section `uses` clause of `Program/Forms/frm_settings.pas` (starting at line 257), add:

```pascal
  unit_HelpTopics,
```

- [ ] **Step 6: Verify no HtmlHelp references remain**

Run: `grep -rn "HtmlHelp\|HH_DISPLAY_TOC\|HH_HELP_CONTEXT" --include=*.pas Program`
Expected: no output.

- [ ] **Step 7: Build**

Run the build command from the Global Constraints.
Expected: no errors.

- [ ] **Step 8: Commit**

```bash
git add Program/Forms/frm_main.pas Program/Forms/frm_settings.pas
git commit -m "* Open HTML help in the browser instead of HtmlHelp API

Routes the three help call sites through ShowHelpTopic.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 10: Help context for the three unmapped settings tabs

`tsProxy`, `tsBehavour` and `tsFileSort` have no `HelpContext`, so <kbd>F1</kbd> on them currently falls through to the index. IDs 145 and 147 are already in the map from Task 8; this task adds the DFM values and the missing 148 entry together.

**Files:**
- Modify: `Program/Forms/frm_settings.dfm` (three `object` blocks only)
- Modify: `Program/Units/unit_HelpTopics.pas`

**Interfaces:**
- Consumes: `set_filesort.html` from Task 7; the `HelpTopics` array from Task 8.
- Produces: `HelpContext` 145 / 147 / 148 on the three tabs.

Only a `HelpContext` line is added to each `object` block. Do not touch any other property. `HelpContext` is not a geometry property, so this is a safe hand-edit under the DFM rules — but the user still needs to reopen the form in the IDE afterwards to confirm nothing shifted.

- [ ] **Step 1: Add `HelpContext` to `tsProxy`**

Find the `object tsProxy: TTabSheet` block in `Program/Forms/frm_settings.dfm`. Add, as the first property line inside the block, matching the indentation of the neighbouring `Caption` line:

```
      HelpContext = 145
```

- [ ] **Step 2: Add `HelpContext` to `tsBehavour`**

Find the `object tsBehavour: TTabSheet` block. Add:

```
      HelpContext = 147
```

- [ ] **Step 3: Add `HelpContext` to `tsFileSort`**

Find the `object tsFileSort: TTabSheet` block. Add:

```
      HelpContext = 148
```

- [ ] **Step 4: Run the checker to verify it fails**

Run: `node tools/help/check_help.js`
Expected: exit 1, single problem `HelpContext 148 appears in a DFM but is not in unit_HelpTopics.pas`. (145 and 147 are already mapped.)

- [ ] **Step 5: Add the 148 entry to the map**

In `Program/Units/unit_HelpTopics.pas`, widen the array bound and append the entry. Change:

```pascal
  HelpTopics: array [0 .. 19] of THelpTopic = (
```

to:

```pascal
  HelpTopics: array [0 .. 20] of THelpTopic = (
```

and change the last entry from:

```pascal
    (ContextID: 147; FileName: 'set_other.html')           // tsBehavour
  );
```

to:

```pascal
    (ContextID: 147; FileName: 'set_other.html'),          // tsBehavour
    (ContextID: 148; FileName: 'set_filesort.html')        // tsFileSort
  );
```

- [ ] **Step 6: Run the checker**

Run: `node tools/help/check_help.js`
Expected: exit 0, `check_help: OK (54 topics)`.

- [ ] **Step 7: Build**

Run the build command from the Global Constraints.
Expected: no errors.

- [ ] **Step 8: Commit**

```bash
git add Program/Forms/frm_settings.dfm Program/Units/unit_HelpTopics.pas
git commit -m "+ Help context for the Proxy, Behaviour and File sorting tabs

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 11: Staging script and installer

**Files:**
- Create: `Program/copy_help.cmd`
- Modify: `Installer/build_installer.cmd`
- Modify: `Installer/Common.iss`

**Interfaces:**
- Consumes: `Program/Help/` from Tasks 1–7.
- Produces: `copy_help.cmd <destination>` — copies `Program/Help` into `<destination>\Help`, mirroring (so removed topics disappear). Used by `build_installer.cmd` and, optionally, by Task 12.

- [ ] **Step 1: Write the staging script**

Create `Program/copy_help.cmd`:

```bat
@echo off
setlocal
:: ============================================================================
:: Copies the HTML help from Program\Help into <destination>\Help.
::
:: Usage: copy_help.cmd <destination-folder>
::
:: Mirrors, so topics removed from the source disappear from the destination.
:: ============================================================================

set "SRC=%~dp0Help"
set "DEST=%~1"

if "%DEST%"=="" (
    echo ERROR: destination folder not specified.
    exit /b 1
)

if not exist "%SRC%" (
    echo ERROR: help source not found at "%SRC%".
    exit /b 1
)

robocopy "%SRC%" "%DEST%\Help" /mir /njh /njs /ndl /nc /ns /np >nul
if errorlevel 8 (
    echo ERROR: failed to copy help to "%DEST%\Help".
    exit /b 1
)

exit /b 0
```

`robocopy` exit codes below 8 indicate success with varying amounts of copying, so only `errorlevel 8` is an error.

- [ ] **Step 2: Stage help in the installer build**

In `Installer/build_installer.cmd`, in the "Collect Common redistributables" section, replace:

```bat
:: Help, URL, License
copy /y "%BIN_DIR%\MyHomeLib.chm" "%COMMON_DIR%\" >nul
copy /y "%BIN_DIR%\MyHomeLib.url" "%COMMON_DIR%\" >nul
copy /y "%BIN_DIR%\License.txt"   "%COMMON_DIR%\" >nul
```

with:

```bat
:: Help (staged from source, not from the build output), URL, License
call "%ROOT_DIR%\Program\copy_help.cmd" "%COMMON_DIR%"
if errorlevel 1 exit /b 1
copy /y "%BIN_DIR%\MyHomeLib.url" "%COMMON_DIR%\" >nul
copy /y "%BIN_DIR%\License.txt"   "%COMMON_DIR%\" >nul
```

- [ ] **Step 3: Ship the help folder**

In `Installer/Common.iss`, in the `[Files]` section, replace:

```
Source: Common\MyHomeLib.chm; DestDir: {app}; Flags: replacesameversion
```

with:

```
Source: Common\Help\*; DestDir: {app}\Help; Flags: recursesubdirs
```

- [ ] **Step 4: Repoint the Start-menu shortcut**

In `Installer/Common.iss`, in the `[Icons]` section, replace:

```
Name: {group}\Довідка {#MyAppName}; Filename: {app}\{#MyAppName}.chm; WorkingDir: {app}; IconFilename: {sys}\ieframe.dll; IconIndex: 36; Comment: {#MyAppName} Help
```

with:

```
Name: {group}\Довідка {#MyAppName}; Filename: {app}\Help\index.html; WorkingDir: {app}; IconFilename: {sys}\ieframe.dll; IconIndex: 36; Comment: {#MyAppName} Help
```

- [ ] **Step 5: Remove the orphaned CHM on upgrade**

In `Installer/Common.iss`, add a new section immediately before `[Files]`:

```
[InstallDelete]
Type: files; Name: {app}\MyHomeLib.chm
```

- [ ] **Step 6: Verify the staging script**

Stage into the real target, `Installer/Common`, which is gitignored so nothing is left dirty:

Run: `cmd.exe //c "Program\copy_help.cmd Installer\Common"`
Then: `ls Installer/Common/Help | wc -l`
Expected: exit 0 and `55` (54 topics plus `help.css`).

- [ ] **Step 7: Commit**

```bash
git add Program/copy_help.cmd Installer/build_installer.cmd Installer/Common.iss
git commit -m "* Ship the HTML help folder instead of MyHomeLib.chm

Adds Program/copy_help.cmd, stages Program/Help into the installer's
Common folder, repoints the Start-menu shortcut at Help/index.html and
removes the orphaned .chm on upgrade.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 12: Development-run help copy

`Program/OUT/BIN/` is gitignored and is where `MyHomeLib.exe` runs from during development, so <kbd>F1</kbd> will not find the help there unless it is copied. This task wires that up.

The project convention in `~/.claude/skills/delphi-dev.md` is **"do not modify `.dproj` or `.groupproj` unless specifically asked"**. The approved design does ask for a post-build event, so Step 2 is sanctioned — but it is isolated here so it can be dropped without affecting anything else. If it is dropped, `copy_help.cmd` is run by hand after a build instead.

**Files:**
- Modify: `Program/MyhomeLib.dproj` (post-build event only)

- [ ] **Step 1: Confirm the manual path works**

Run: `cmd.exe //c "Program\copy_help.cmd Program\OUT\BIN"`
Then: `ls Program/OUT/BIN/Help/index.html`
Expected: exit 0 and the file listed. <kbd>F1</kbd> in a locally built executable now works.

- [ ] **Step 2: Add the post-build event**

In `Program/MyhomeLib.dproj`, inside the `<PropertyGroup>` that holds the build events (search for `PostBuildEvent`; if none exists, add the property group after the last `<PropertyGroup Condition="'$(Base)'!=''">`), add:

```xml
  <PropertyGroup>
    <PostBuildEvent>call "$(PROJECTDIR)\copy_help.cmd" "$(OUTPUTDIR)."</PostBuildEvent>
  </PropertyGroup>
```

The trailing `.` is deliberate. `$(OUTPUTDIR)` expands with a trailing backslash, and `"…\"` in a cmd argument escapes the closing quote and swallows the rest of the line. `"…\."` is the same directory and quotes cleanly.

- [ ] **Step 3: Verify the post-build event runs**

Run: `rm -rf Program/OUT/BIN/Help` then the build command from the Global Constraints.
Then: `ls Program/OUT/BIN/Help/index.html`
Expected: build succeeds and the file exists again, this time placed by the post-build event.

- [ ] **Step 4: Commit**

```bash
git add Program/MyhomeLib.dproj
git commit -m "* Copy the HTML help into the build output after a build

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

### Task 13: Remove the old CHM and final verification

**Files:**
- Delete: `Program/OUT/BIN/MyHomeLib.chm`, `Program/OUT/Bin64/MyHomeLib.chm`, `Installer/Common/MyHomeLib.chm` (all untracked build artefacts)
- Modify: `TODO.md`

- [ ] **Step 1: Delete the stale CHM artefacts**

Run:
```bash
rm -f Program/OUT/BIN/MyHomeLib.chm Program/OUT/Bin64/MyHomeLib.chm Installer/Common/MyHomeLib.chm
```
These are all in gitignored directories, so nothing is staged by this.

- [ ] **Step 2: Confirm no CHM references remain**

Run: `grep -rni "\.chm" --include=*.pas --include=*.dpr --include=*.iss --include=*.cmd --include=*.dfm Program Installer`
Expected: exactly one line — the `[InstallDelete]` entry in `Installer/Common.iss` that removes the orphaned file on upgrade.

- [ ] **Step 3: Full verification pass**

Run each and confirm:

| Check | Command | Expected |
|---|---|---|
| Help content | `node tools/help/check_help.js` | exit 0, `check_help: OK (54 topics)` |
| Nav is current | `node tools/help/build_nav.js && git diff --exit-code Program/Help` | `created 0`, no diff |
| Full group build | the group build command from `CLAUDE.md`, Release/Win32 | no errors |
| Help staged | `ls Program/OUT/BIN/Help/index.html` | file exists |

- [ ] **Step 4: Record the outstanding item in TODO.md**

Add a row to the table in `TODO.md`:

```markdown
| D1 | Screenshots for the HTML help. All 25 images from the old 2011 CHM were dropped (Russian UI, pre-modernization icons); `Program/Help/` currently ships text-only. Capture current 2.6.0 shots for `main_window`, `browsing`, `new_collection`, `search`, `set_readers`, `set_device` and wire them in. | 🟡 M | 🔴 Open |
```

- [ ] **Step 5: Commit**

```bash
git add TODO.md
git commit -m "* Note outstanding help screenshots in TODO

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

- [ ] **Step 6: Hand over for user confirmation**

Nothing above counts as done until confirmed in the running application. Ask the user to check, and report exactly what was and was not verified:

1. Build and run `Program/OUT/BIN/MyHomeLib.exe`.
2. **Допомога → Довідка** opens `Help/index.html` in the browser.
3. <kbd>F1</kbd> from each of these opens the page named:
   - main window → `main_window.html`
   - «Автори» / «Серії» / «Жанри» tabs → `browsing.html`
   - «Пошук» tab → `search.html`
   - «Групи» tab → `groups.html`
   - «Завантаження» tab → `download.html`
   - collection manager → `collections.html`
   - new-collection wizard → `new_collection.html`
   - author editor → `editing.html`
   - non-FB2 import dialog → `import_nonfb2.html`
   - settings dialog, each tab → the matching `set_*.html`
4. The pages read correctly in both a light and a dark system theme.
5. Reopen `frm_settings` in the IDE and confirm the three `HelpContext` additions did not disturb the layout; commit any geometry the IDE rewrites.

Only after the user confirms may any of this be described as working.

---

## Notes for the implementer

- **`build_nav.js` owns the sidebar.** Never hand-edit anything between `<!-- TOC:BEGIN -->` and `<!-- TOC:END -->`. To change the TOC, edit `tools/help/topics.json` and re-run the script.
- **The body markers are the contract.** Content tasks replace only what sits between `<!-- BODY:BEGIN -->` and `<!-- BODY:END -->`.
- **Read before writing.** Every content task lists its sources. The 2011 CHM is a structural reference only; its prose describes software that no longer exists. When a source contradicts the old topic, the source wins.
- **Do not invent behaviour.** If reading the sources does not settle what an option does, say what is verifiable and flag the gap for the user rather than writing a plausible guess into the help.
- **Ukrainian throughout**, including comments added to `unit_HelpTopics.pas`, matching the existing style of `unit_MHL_strings.pas`.
