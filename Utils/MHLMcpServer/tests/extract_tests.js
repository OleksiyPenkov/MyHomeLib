const { spawnSync } = require('child_process');
const path = require('path');

const exe = process.argv[2];
const fx = f => path.join(__dirname, 'fixtures', f);

function extract(file) {
  const run = spawnSync(exe, ['--extract', fx(file)], { encoding: 'utf8' });
  if (run.status !== 0) throw new Error(`exit ${run.status}: ${run.stderr}`);
  return JSON.parse(run.stdout);
}

// For fixtures where --extract is EXPECTED to fail (a genuinely unrecoverable
// or textless book) -- returns the raw exit status and stderr text instead of
// parsing stdout as JSON, since RunExtractMode never writes a JSON line in
// this case (MHLMcpServer.dpr's --extract dispatch prints
// 'FB2 extraction failed: ' + E.Message to stderr and exits 1).
function extractExpectFail(file) {
  const run = spawnSync(exe, ['--extract', fx(file)], { encoding: 'utf8' });
  return { status: run.status, stderr: run.stderr };
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
  // Regression coverage for the MCP fix-round-2 bug (unit_MCP_Tools_Text.pas):
  // a book that parses as valid XML but has no text at all (picture-only)
  // must raise EFb2ExtractError with Kind = eekNoText, not eekExtractionFailed
  // -- that Kind is what the MCP tool layer switches on to return
  // book_has_no_text (a textless-but-valid book) instead of extraction_failed
  // (a corrupt one). --extract itself doesn't expose Kind (RunExtractMode
  // catches generic Exception), so this only proves the message text --
  // which is 1:1 with Kind by construction, since eekNoText is the only
  // raise site producing this exact wording (see unit_MCP_Fb2Extract.pas).
  ['picture-only: valid XML, empty body -> "has no extractable text", not "extraction failed"', () => {
    const r = extractExpectFail('picture_only.fb2');
    return r.status === 1
      && r.stderr.includes('FB2 book has no extractable text (likely picture-only or an empty body)');
  }],
  // A genuinely empty (0-byte) file can't even be parsed as XML, so it falls
  // through to the fallback scanner, which also produces empty text --
  // Kind = eekExtractionFailed, the OTHER branch from the one above. Together
  // these two cases are the only way (short of fabricating a book inside a
  // real MyHomeLib collection, which the MCP server test suite deliberately
  // never does) to exercise both sides of the eekNoText/eekExtractionFailed
  // split the MCP tool layer depends on.
  ['empty file: 0 bytes -> "extraction failed", not "has no extractable text"', () => {
    const r = extractExpectFail('empty.fb2');
    return r.status === 1
      && r.stderr.includes('FB2 extraction failed: no text could be recovered from this file')
      && !r.stderr.includes('picture-only');
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
