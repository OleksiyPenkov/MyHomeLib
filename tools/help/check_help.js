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

  // The index page's own title *is* "Довідка MyHomeLib" — appending the
  // suffix would double it up ("Довідка MyHomeLib — Довідка MyHomeLib").
  const expectedTitleText = t.file === 'index.html' ? t.title : `${t.title} — Довідка MyHomeLib`;
  const expectedTitle = `<title>${expectedTitleText}</title>`;
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
if (!fs.existsSync(MAP_UNIT)) {
  fail('missing Program/Units/unit_HelpTopics.pas');
} else {
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

// --- 6. nothing but declared topics and help.css anywhere under Help/ -----
// The help ships with no images at all, so Program/Help must contain only
// the .html files listed in topics.json plus help.css — no subdirectories
// (e.g. an img/ folder) and no other stray files, at any depth.
function walkAll(dir, base, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    const rel = path.relative(base, p).split(path.sep).join('/');
    if (e.isDirectory()) {
      out.push({ rel, isDir: true });
      walkAll(p, base, out);
    } else {
      out.push({ rel, isDir: false });
    }
  }
  return out;
}

for (const entry of walkAll(HELP, HELP)) {
  if (entry.isDir) {
    fail(`stray directory in Program/Help: ${entry.rel}`);
    continue;
  }
  if (entry.rel === 'help.css') continue;
  if (declared.has(entry.rel)) continue;
  fail(`stray file in Program/Help: ${entry.rel}`);
}

// --- report ---------------------------------------------------------------
if (problems.length) {
  console.error(`check_help: ${problems.length} problem(s)`);
  for (const p of problems) console.error('  - ' + p);
  process.exit(1);
}
console.log(`check_help: OK (${topics.length} topics)`);
