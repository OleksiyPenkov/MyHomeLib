const { spawnSync } = require('child_process');
const path = require('path');

const exe = process.argv[2];
const fx = f => path.join(__dirname, 'fixtures', f);

function extract(file) {
  const run = spawnSync(exe, ['--extract', fx(file)], { encoding: 'utf8' });
  if (run.status !== 0) throw new Error(`exit ${run.status}: ${run.stderr}`);
  return JSON.parse(run.stdout);
}

const checks = [
  ['structured: two sections', () => {
    const r = extract('structured.fb2');
    return r.structured === true
      && r.sections.length === 2
      && r.sections[0].title === 'Chapter One'
      && r.sections[1].title === 'Chapter Two';
  }],
  // Not just "does the slice contain its own text" (satisfiable by an
  // extractor that reports one giant span for everything) but "does it
  // ALSO exclude the sibling's text" -- that is the actual load-bearing
  // property Task 9/10 depend on: a TOC offset must land on ONLY its own
  // section, never bleed into a neighbour.
  ['structured: section 0 slice has its own text, not section 1\'s', () => {
    const r = extract('structured.fb2');
    const slice = r.text.substr(r.sections[0].offset, r.sections[0].length);
    return slice.includes('Alpha text.') && !slice.includes('Beta text.');
  }],
  ['structured: section 1 slice has its own text, not section 0\'s', () => {
    const r = extract('structured.fb2');
    const slice = r.text.substr(r.sections[1].offset, r.sections[1].length);
    return slice.includes('Beta text.') && !slice.includes('Alpha text.');
  }],
  // Exactly one section (not "<= 1", which a zero-section extractor would
  // also satisfy), untitled, and its own slice actually covers the text --
  // makes this assertion meaningful rather than trivially satisfiable by an
  // extractor that reports no structure at all.
  ['flat: one untitled section whose slice covers the (windows-1251) text', () => {
    const r = extract('flat.fb2');
    if (r.sections.length !== 1) return false;
    const s = r.sections[0];
    return r.text.includes('Текст без заголовків')
      && s.title === ''
      && r.text.substr(s.offset, s.length).includes('Текст без заголовків');
  }],
  ['broken: falls back to text, structured=false', () => {
    const r = extract('broken.fb2');
    return r.structured === false && r.text.includes('Salvageable text.');
  }],
  // The intersection that hid the original encoding bug: malformed XML
  // (forces the fallback scanner) AND windows-1251 (forces prolog-driven
  // decoding inside that same fallback). Must decode correctly, not just
  // "produce some text" -- mojibake would still pass a looser check.
  ['broken + windows-1251: fallback decodes Cyrillic correctly, not mojibake', () => {
    const r = extract('broken_cp1251.fb2');
    return r.structured === false
      && r.text.includes('Пошкоджений текст без закриття тегів.');
  }],
  // Regression test for the silent-truncation bug: a single unescaped '<'
  // in text content must not lock the tag-depth tracker forever and drop
  // every later paragraph. The text between the stray '<' and the next '>'
  // is expected to be lost (the scanner cannot tell a real tag from a
  // stray one) -- what must NOT happen is the rest of the book vanishing
  // with it, which is exactly what the old Inc/Dec bookkeeping did.
  ['broken: raw unescaped < resynchronises instead of truncating the rest of the book', () => {
    const r = extract('broken_raw_lt.fb2');
    return r.structured === false
      && r.text.includes('Price is 5')
      && r.text.includes('Second paragraph survives after resync.');
  }],
  // <binary> (typically a cover image) must never leak its base64 payload
  // into extracted text -- hundreds of KB of base64 in the middle of a book
  // would otherwise reach get_book_text once Task 10 serves this.
  ['broken: <binary> base64 payload is not emitted as text', () => {
    const r = extract('broken_binary.fb2');
    return r.structured === false
      && r.text.includes('Real content paragraph.')
      && !r.text.includes('QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVo=');
  }],
];

let failed = 0;
for (const [name, fn] of checks) {
  let ok = false, err = '';
  try { ok = fn(); } catch (e) { err = e.message; }
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${err ? ' — ' + err : ''}`);
  if (!ok) failed++;
}
process.exit(failed ? 1 : 0);
