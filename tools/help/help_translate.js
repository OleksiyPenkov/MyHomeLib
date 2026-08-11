'use strict';

// Exports the translatable text of the help, and assembles a translated tree
// from the pieces.
//
// Same principle as tools/lang/translate.js and tools/lang/glst_translate.js:
// a translator supplies text, never structure. `build` takes each Ukrainian
// page as the template and replaces exactly four things -- the lang attribute,
// the <title>, the <h1> and the BODY block -- then regenerates the navigation
// from topics.json. Everything else is copied byte for byte.
//
// The navigation is the reason this tool exists. All 55 pages carry the same
// TOC, differing only in which link is marked class="cur". Handing that block
// to 55 separate translators would produce 55 subtly different menus; deriving
// it from one title map cannot.
//
// Usage:
//   node tools/help/help_translate.js titles <out.json>
//   node tools/help/help_translate.js build <locale> <titles.json> <bodydir>
//
//   <bodydir> holds one <topic>.html per topic, each the translated BODY
//   content only -- no <html>, no TOC, no <h1>.
//
// Exit code: 0 = ok, 1 = failure.

const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..', '..');
const HELP = path.join(ROOT, 'Program', 'Help');
const TOPICS = path.join(__dirname, 'topics.json');

// The suffix appended to every page title except the index, whose own title is
// already the help's name. Must agree with TITLE_SUFFIX in check_help.js.
const TITLE_SUFFIX = {
  uk: 'Довідка MyHomeLib',
  en: 'MyHomeLib Help',
  bg: 'Помощ за MyHomeLib',
};

function fail(message) {
  console.error(message);
  process.exit(1);
}

function loadSpec() {
  return JSON.parse(fs.readFileSync(TOPICS, 'utf8'));
}

function cmdTitles(outFile) {
  if (!outFile) fail('Usage: help_translate.js titles <out.json>');

  const spec = loadSpec();
  const out = { sections: {}, topics: {} };

  for (const s of spec.sections) {
    out.sections[s.title] = s.title;
    for (const t of s.topics) out.topics[t.file] = t.title;
  }

  fs.mkdirSync(path.dirname(path.resolve(outFile)), { recursive: true });
  fs.writeFileSync(outFile, JSON.stringify(out, null, 2) + '\n', 'utf8');

  console.log(`wrote ${outFile}`);
  console.log(`${Object.keys(out.sections).length} section title(s), `
    + `${Object.keys(out.topics).length} topic title(s)`);
  process.exit(0);
}

// Rebuilds the navigation for one page. `cur` is the file that should carry
// the current-page marker.
function buildToc(spec, titles, cur, eol) {
  const lines = [''];
  const indexTitle = titles.topics['index.html'];

  lines.push(`<p class="nav-title"><a href="index.html">${indexTitle}</a></p>`);

  for (const s of spec.sections) {
    lines.push(`<p class="nav-section">${titles.sections[s.title]}</p>`);
    lines.push('<ul>');
    for (const t of s.topics) {
      if (t.file === 'index.html') continue;
      const label = titles.topics[t.file];
      const mark = t.file === cur ? ' class="cur" aria-current="page"' : '';
      lines.push(`<li><a href="${t.file}"${mark}>${label}</a></li>`);
    }
    lines.push('</ul>');
  }

  lines.push('');
  return lines.join(eol);
}

// The line endings the existing content between two markers uses. The pages
// are mixed on purpose-by-accident: the TOC blocks are LF because a generator
// wrote them, the hand-written bodies are CRLF, and git's autocrlf normalises
// both so the difference never shows up as a change. Preserving each block's
// own convention is what makes a rebuild byte-identical instead of producing a
// 55-file whitespace diff nobody asked for.
function blockEol(html, beginMarker, endMarker) {
  const a = html.indexOf(beginMarker);
  const b = html.indexOf(endMarker);
  if (a < 0 || b < 0 || b < a) return '\n';
  return html.slice(a + beginMarker.length, b).includes('\r\n') ? '\r\n' : '\n';
}

function replaceBetween(html, beginMarker, endMarker, replacement, what) {
  const a = html.indexOf(beginMarker);
  const b = html.indexOf(endMarker);
  if (a < 0 || b < 0 || b < a) fail(`${what}: markers not found or out of order`);
  return html.slice(0, a + beginMarker.length) + replacement + html.slice(b);
}

function cmdBuild(locale, titlesFile, bodyDir) {
  if (!locale || !titlesFile || !bodyDir) {
    fail('Usage: help_translate.js build <locale> <titles.json> <bodydir>');
  }
  if (!/^[a-z]{2}$/.test(locale)) fail(`locale must be two lowercase letters, got "${locale}"`);
  const suffix = TITLE_SUFFIX[locale];
  if (!suffix) fail(`no title suffix defined for "${locale}" -- add one here and in check_help.js`);

  const spec = loadSpec();
  const titles = JSON.parse(fs.readFileSync(titlesFile, 'utf8'));
  const allTopics = spec.sections.flatMap((s) => s.topics);

  // Validate everything before writing a single file: a half-built tree that
  // passes some checks is harder to reason about than one that was refused.
  const missing = [];
  for (const s of spec.sections) {
    if (!titles.sections?.[s.title]) missing.push(`section title: ${s.title}`);
  }
  for (const t of allTopics) {
    if (!titles.topics?.[t.file]) missing.push(`topic title: ${t.file}`);
    if (!fs.existsSync(path.join(bodyDir, t.file))) missing.push(`body: ${t.file}`);
    if (!fs.existsSync(path.join(HELP, t.file))) missing.push(`source page: ${t.file}`);
  }
  if (missing.length > 0) {
    console.error(`${missing.length} missing input(s):`);
    for (const m of missing.slice(0, 20)) console.error(`  ${m}`);
    if (missing.length > 20) console.error(`  ... and ${missing.length - 20} more`);
    process.exit(1);
  }

  const outDir = path.join(HELP, locale);
  fs.mkdirSync(outDir, { recursive: true });
  fs.copyFileSync(path.join(HELP, 'help.css'), path.join(outDir, 'help.css'));

  for (const t of allTopics) {
    let html = fs.readFileSync(path.join(HELP, t.file), 'utf8');
    const title = titles.topics[t.file];

    // Per block, not per file -- see blockEol. A translated body arrives with
    // whatever endings the writer used, so it is normalised to the block it
    // replaces.
    const tocEol = blockEol(html, '<!-- TOC:BEGIN -->', '<!-- TOC:END -->');
    const bodyEol = blockEol(html, '<!-- BODY:BEGIN -->', '<!-- BODY:END -->');
    const body = fs.readFileSync(path.join(bodyDir, t.file), 'utf8')
      .trim()
      .replace(/\r?\n/g, bodyEol);

    html = html.replace('<html lang="uk">', `<html lang="${locale}">`);

    const fullTitle = t.file === 'index.html' ? title : `${title} — ${suffix}`;
    html = html.replace(/<title>[^<]*<\/title>/, `<title>${fullTitle}</title>`);

    // Only the first <h1>, which is the page heading immediately before
    // BODY:BEGIN. A body is free to contain its own headings.
    html = html.replace(/<h1>[\s\S]*?<\/h1>/, `<h1>${title}</h1>`);

    html = replaceBetween(html, '<!-- TOC:BEGIN -->', '<!-- TOC:END -->',
      buildToc(spec, titles, t.file, tocEol), `${t.file} TOC`);
    html = replaceBetween(html, '<!-- BODY:BEGIN -->', '<!-- BODY:END -->',
      bodyEol + body + bodyEol, `${t.file} body`);

    fs.writeFileSync(path.join(outDir, t.file), html, 'utf8');
  }

  console.log(`wrote ${allTopics.length} page(s) + help.css to ${outDir}`);
  console.log('run `node tools/help/check_help.js` to validate');
  process.exit(0);
}

const [, , cmd, ...rest] = process.argv;
switch (cmd) {
  case 'titles': cmdTitles(rest[0]); break;
  case 'build': cmdBuild(rest[0], rest[1], rest[2]); break;
  default:
    fail('Usage:\n'
      + '  node tools/help/help_translate.js titles <out.json>\n'
      + '  node tools/help/help_translate.js build <locale> <titles.json> <bodydir>');
}
