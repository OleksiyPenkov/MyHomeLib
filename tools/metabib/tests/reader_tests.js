'use strict';

// Runs MetabibTest.exe against generated datasets and asserts on the report.
//
// The cases here are about ONE rule: a claim array holds several claims, and a
// claim that is present but empty is not an answer. metabib emits FB2, FBD and
// (since 2.1.0) database claims into the same array, so an empty FB2 annotation
// sitting in front of a populated database one is the realistic shape, not a
// contrived one.
//
// Usage: node tools/metabib/tests/reader_tests.js <path-to-MetabibTest.exe>
// Exit code: 0 = pass, 1 = fail.

const fs = require('fs');
const os = require('os');
const path = require('path');
const { spawnSync } = require('child_process');

const EXE = process.argv[2];
if (!EXE || !fs.existsSync(EXE)) {
  console.error('usage: node reader_tests.js <path-to-MetabibTest.exe>');
  process.exit(1);
}

const HEADER = {
  schema: 'metabib.dataset/1',
  id: 'test',
  record_schema: 'metabib.dataset_record/1',
  library: 'test-lib',
  created: '2026-09-12T00:00:00Z',
  records: 1,
  generator: { name: 'reader_tests', version: '1' },
  ordering: { mode: 'archive_entry', direction: 'ascending' },
  archives: [{ id: 'arc1', ordinal: 0, name: 'fb2-000001-000100.zip', entries: 1 }],
};

// claims are given as { bibliographic: {...}, publication: {...}, catalog: {...} }
function record(claims) {
  return {
    schema: 'metabib.dataset_record/1',
    record: {
      library: 'test-lib',
      locator: { kind: 'archive_entry', source: 'arc1', index: 0, book_id: 101 },
    },
    artifacts: [{
      name: '101.fb2',
      occurrences: [{ archive: 'arc1', entry: '101.fb2', index: 0, uncompressed_size: 100 }],
    }],
    observations: [],
    claims: Object.assign(
      { bibliographic: { title: [{ value: 'Проба' }] }, publication: {}, catalog: {} },
      claims),
  };
}

// The shape of a real 2.1.0+ archive-backed record: no book_id in the locator.
function idRecord(extra) {
  const rec = record({});
  delete rec.record.locator.book_id;
  return Object.assign(rec, extra);
}

let caseNo = 0;

// Runs any number of lines (records, or raw strings for malformed input)
// through the harness and returns the whole report.
function runReport(lines) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), `mbtest${caseNo++}-`));
  const data = path.join(dir, 'dataset.jsonl');
  const body = lines.map((l) => (typeof l === 'string' ? l : JSON.stringify(l))).join('\n');
  fs.writeFileSync(data, JSON.stringify(HEADER) + '\n' + body + '\n', 'utf8');
  const report = path.join(dir, 'report.json');
  const r = spawnSync(EXE, [data, report], { encoding: 'utf8' });
  if (r.status !== 0) {
    throw new Error(`harness exit ${r.status}: ${r.stderr || r.stdout}`);
  }
  const out = JSON.parse(fs.readFileSync(report, 'utf8').replace(/^﻿/, ''));
  if (out.error) throw new Error('reader error: ' + out.error);
  return out;
}

function run(rec) {
  const out = runReport([rec]);
  if (!out.books || out.books.length !== 1) {
    throw new Error('expected exactly 1 book, got ' + (out.books || []).length);
  }
  return out.books[0];
}

// A book whose FB2 carried no annotation but whose database row does. The empty
// claim comes first, exactly as an FB2-then-DB ordering would produce it.
const bib = (o) => ({ bibliographic: Object.assign({ title: [{ value: 'Проба' }] }, o) });

const checks = [
  ['a populated annotation claim is read', () => {
    const b = run(record(bib({ annotation: [{ value: 'Текст анотації' }] })));
    return b.annotation === 'Текст анотації';
  }],

  ['an empty annotation claim does not shadow a populated one', () => {
    const b = run(record(bib({ annotation: [
      { value: '' },
      { value: 'Анотація з бази', raw: { nid: 42, title: 'Проба', body: 'Анотація з бази' } },
    ] })));
    return b.annotation === 'Анотація з бази';
  }],

  ['a whitespace-only annotation claim does not shadow a populated one', () => {
    const b = run(record(bib({ annotation: [
      { value: '   \n ' },
      { value: 'Анотація з бази' },
    ] })));
    return b.annotation === 'Анотація з бази';
  }],

  ['all-empty annotation claims yield an empty annotation', () => {
    const b = run(record(bib({ annotation: [{ value: '' }, { value: '  ' }] })));
    return b.annotation === '';
  }],

  ['the first populated claim wins when several are populated', () => {
    const b = run(record(bib({ annotation: [
      { value: 'З файлу FB2' },
      { value: 'З бази' },
    ] })));
    return b.annotation === 'З файлу FB2';
  }],

  // Annotation sources are ranked, not taken in array order. Real dumps put
  // the database claim first in every field, so "first populated" alone would
  // always hand the UI the libbannotations text.
  ['the FB2 annotation wins over the database one', () => {
    const b = run(record(bib({ annotation: [
      { value: 'З бази', observation: 'db', raw: { nid: 42, title: 'Проба', body: 'З бази' } },
      { value: 'З файлу FB2', observation: 'fb2' },
    ] })));
    return b.annotation === 'З файлу FB2';
  }],

  ['the FBD annotation wins over the database one', () => {
    const b = run(record(bib({ annotation: [
      { value: 'З бази', observation: 'db' },
      { value: 'З сайдкара FBD', observation: 'fbd' },
    ] })));
    return b.annotation === 'З сайдкара FBD';
  }],

  ['the FB2 annotation wins over the FBD one', () => {
    const b = run(record(bib({ annotation: [
      { value: 'З сайдкара FBD', observation: 'fbd' },
      { value: 'З файлу FB2', observation: 'fb2' },
    ] })));
    return b.annotation === 'З файлу FB2';
  }],

  ['the database annotation is used when the FB2 one is empty', () => {
    const b = run(record(bib({ annotation: [
      { value: '', observation: 'fb2' },
      { value: 'З бази', observation: 'db' },
    ] })));
    return b.annotation === 'З бази';
  }],

  // A source we have never seen beats no annotation at all.
  ['an annotation from an unranked source is still used', () => {
    const b = run(record(bib({ annotation: [
      { value: 'Зі стороннього джерела', observation: 'whatever' },
    ] })));
    return b.annotation === 'Зі стороннього джерела';
  }],

  ['ranking does not apply to other fields', () => {
    const b = run(record(bib({ language: [
      { value: 'ru', observation: 'db' },
      { value: 'uk', observation: 'fb2' },
    ] })));
    return b.lang === 'ru';
  }],

  // Not annotation-specific: the same helper serves every string field, so the
  // rule has to hold for all of them or the fix is a special case.
  ['an empty language claim does not shadow a populated one', () => {
    const b = run(record(bib({ language: [{ value: '' }, { value: 'uk' }] })));
    return b.lang === 'uk';
  }],

  ['an empty publisher claim does not shadow a populated one', () => {
    const b = run(record({
      bibliographic: { title: [{ value: 'Проба' }] },
      publication: { publisher: [{ value: '' }, { value: 'Видавництво' }] },
    }));
    return b.publisher === 'Видавництво';
  }],

  ['an empty deleted claim does not shadow a later true', () => {
    const b = run(record({
      bibliographic: { title: [{ value: 'Проба' }] },
      catalog: { deleted: [{ value: '' }, { value: true }] },
    }));
    return b.deleted === true;
  }],

  // Book id. Since metabib 2.1.0 an archive_entry locator carries only
  // source + index; the id sits in identities.catalog and in the db observation.
  ['book_id is read from the locator when present', () => {
    return run(record({})).book_id === 101;
  }],

  ['without locator.book_id the db catalog identity wins over the archive one', () => {
    const rec = idRecord({
      identities: { catalog: [
        { scheme: 'test-lib.book', value: '555', observation: 'archive', basis: 'numeric_entry_stem' },
        { scheme: 'test-lib.book', value: '888386', observation: 'db' },
      ] },
    });
    return run(rec).book_id === 888386;
  }],

  ['the db observation locator is used when there is no db identity', () => {
    const rec = idRecord({
      identities: { catalog: [
        { scheme: 'test-lib.book', value: '555', observation: 'archive' },
      ] },
      observations: [
        { id: 'db', status: 'present', kind: 'database_book', locator: { book_id: 777 } },
      ],
    });
    return run(rec).book_id === 777;
  }],

  ['an absent db observation is ignored', () => {
    const rec = idRecord({
      identities: { catalog: [
        { scheme: 'test-lib.book', value: '555', observation: 'archive' },
      ] },
      observations: [
        { id: 'db', status: 'absent', kind: 'database_book', locator: { book_id: 777 } },
      ],
    });
    return run(rec).book_id === 555;
  }],

  ['the archive catalog identity is the last fallback', () => {
    const rec = idRecord({
      identities: { catalog: [
        { scheme: 'test-lib.book', value: '555', observation: 'archive' },
      ] },
    });
    return run(rec).book_id === 555;
  }],

  ['a catalog identity from another library scheme is ignored', () => {
    const rec = idRecord({
      identities: { catalog: [
        { scheme: 'other.book', value: '999', observation: 'db' },
      ] },
    });
    return run(rec).book_id === 0;
  }],

  ['integer string locator IDs are valid', () => {
    const rec = record({});
    rec.record.locator.book_id = '101';
    const b = run(rec);
    return b.book_id === 101 && b.book_id_valid === true;
  }],

  ['fractional numeric and string locator IDs are invalid, not truncated', () => {
    return [101.5, '101.5'].every((id) => {
      const rec = record({});
      rec.record.locator.book_id = id;
      const b = run(rec);
      return b.book_id === 0 && b.book_id_valid === false;
    });
  }],

  ['malformed preferred locator IDs never silently use a catalog fallback', () => {
    return ['junk', 0, -1, null, true, {}, '9223372036854775808'].every((id) => {
      const rec = record({});
      rec.record.locator.book_id = id;
      rec.identities = { catalog: [
        { scheme: 'test-lib.book', value: '777', observation: 'db' },
      ] };
      const b = run(rec);
      return b.book_id === 0 && b.book_id_valid === false;
    });
  }],

  ['fractional database identities are invalid and do not use an archive fallback', () => {
    return [888.5, '888.5'].every((id) => {
      const rec = idRecord({ identities: { catalog: [
        { scheme: 'test-lib.book', value: '555', observation: 'archive' },
        { scheme: 'test-lib.book', value: id, observation: 'db' },
      ] } });
      const b = run(rec);
      return b.book_id === 0 && b.book_id_valid === false;
    });
  }],

  ['a malformed preferred identity is not replaced by a later identity from the same source', () => {
    const b = run(idRecord({ identities: { catalog: [
      { scheme: 'test-lib.book', observation: 'db' },
      { scheme: 'test-lib.book', value: '777', observation: 'db' },
    ] } }));
    return b.book_id === 0 && b.book_id_valid === false;
  }],

  ['fractional database observation IDs do not use an archive fallback', () => {
    const b = run(idRecord({
      observations: [{ id: 'db', status: 'present', locator: { book_id: '777.5' } }],
      identities: { catalog: [{ scheme: 'test-lib.book', value: '555', observation: 'archive' }] },
    }));
    return b.book_id === 0 && b.book_id_valid === false;
  }],

  ['a missing locator ID can resolve a valid catalog ID', () => {
    const b = run(idRecord({ identities: { catalog: [
      { scheme: 'test-lib.book', value: '777', observation: 'db' },
    ] } }));
    return b.book_id === 777 && b.book_id_valid === true;
  }],

  ['a book with no usable ID is reported as invalid', () => {
    const b = run(idRecord({}));
    return b.book_id === 0 && b.book_id_valid === false;
  }],

  ['a record library mismatch remains visible instead of using the header library', () => {
    const rec = idRecord({ identities: { catalog: [
      { scheme: 'other.book', value: '777', observation: 'db' },
    ] } });
    rec.record.library = 'other';
    const out = runReport([rec]);
    return out.library === 'test-lib' && out.books[0].library === 'other' &&
      out.books[0].book_id === 777 && out.books[0].book_id_valid === true;
  }],

  ['a missing record library uses the header library', () => {
    const rec = idRecord({ identities: { catalog: [
      { scheme: 'test-lib.book', value: '777', observation: 'db' },
    ] } });
    delete rec.record.library;
    const b = run(rec);
    return b.library === 'test-lib' && b.book_id === 777 && b.book_id_valid === true;
  }],

  ['an explicitly empty record library is not hidden by the header fallback', () => {
    const rec = record({});
    rec.record.library = '';
    return run(rec).library === '';
  }],

  ['an ordinary record still parses', () => {
    const b = run(record({
      bibliographic: { title: [{ value: 'Проба' }], language: [{ value: 'uk' }] },
      publication: { publisher: [{ value: 'Вид' }], isbn: [{ value: '978-0' }] },
    }));
    return b.title === 'Проба' && b.lang === 'uk'
      && b.publisher === 'Вид' && b.isbn === '978-0' && b.deleted === false;
  }],

  ['normalized genre objects keep their FB2 codes instead of becoming Unsorted', () => {
    const b = run(record(bib({ genres: [
      { observation: 'db', value: [
        { code: 'prose_contemporary', description: 'Проза', meta: 'Проза' },
        { code: 'sf_fantasy' },
      ] },
      { observation: 'fb2', value: [{ code: 'prose_contemporary' }] },
    ] })));
    return JSON.stringify(b.genres) === JSON.stringify(['prose_contemporary', 'sf_fantasy']);
  }],

  ['legacy string genres and normalized objects can coexist', () => {
    const b = run(record(bib({ genres: [{ value: [
      'sf_fantasy', { code: 'prose_contemporary' }, null, {}, { code: '' }, { code: 42 },
    ] }] })));
    return JSON.stringify(b.genres) === JSON.stringify(['sf_fantasy', 'prose_contemporary']);
  }],
  ['curated database genres preserve their labels, categories and provenance', () => {
    const b = run(record(bib({ genres: [{ observation: 'db', value: [
      { code: 'popadancy', description: 'Попаданці', meta: 'Фантастика' },
      { code: 'det_lady', description: 'Жіночий детектив', meta: 'Детективи' },
      { code: 'dark_fantasy', description: 'Темне фентезі', meta: 'Фантастика' },
    ] }] })));
    return JSON.stringify(b.genre_details) === JSON.stringify([
      { code: 'popadancy', description: 'Попаданці', category: 'Фантастика', catalog: true },
      { code: 'det_lady', description: 'Жіночий детектив', category: 'Детективи', catalog: true },
      { code: 'dark_fantasy', description: 'Темне фентезі', category: 'Фантастика', catalog: true },
    ]);
  }],

  ['database genres win over different FB2 and FBD lists without a union', () => {
    const b = run(record(bib({ genres: [
      { observation: 'fb2', value: ['sf_fantasy', 'junk_tag'] },
      { observation: 'fbd', value: ['prose_contemporary'] },
      { observation: 'db', value: [{ code: 'popadancy', description: 'Попаданці', meta: 'Фантастика' }] },
    ] })));
    return JSON.stringify(b.genres) === JSON.stringify(['popadancy']);
  }],

  ['empty and malformed database genre claims fall back to usable FB2 genres', () => {
    const b = run(record(bib({ genres: [
      { observation: 'db', value: [] },
      { observation: 'db', value: [null, {}, { code: 42 }, { code: '' }, { code: '  ' }, '���'] },
      { observation: 'fbd', value: ['prose_contemporary'] },
      { observation: 'fb2', value: [{ code: 'sf_fantasy', description: 'Фентезі', meta: 'Фантастика' }] },
    ] })));
    return JSON.stringify(b.genres) === JSON.stringify(['sf_fantasy']) &&
      JSON.stringify(b.genre_details) === JSON.stringify([
        { code: 'sf_fantasy', description: 'Фентезі', category: 'Фантастика', catalog: false },
      ]);
  }],

  ['FBD genres win over unknown and legacy claims when DB and FB2 are unusable', () => {
    const b = run(record(bib({ genres: [
      { value: ['legacy'] },
      { observation: 'other', value: ['unknown'] },
      { observation: 'db', value: null },
      { observation: 'fb2', value: { code: false } },
      { observation: 'fbd', value: 'det_lady' },
    ] })));
    return JSON.stringify(b.genre_details) === JSON.stringify([
      { code: 'det_lady', description: '', category: '', catalog: false },
    ]);
  }],

  ['legacy and unknown source genres never acquire catalog provenance', () => {
    const legacy = run(record(bib({ genres: [{ value: [
      'sf_fantasy', { code: 'dark_fantasy', description: 'Темне фентезі', meta: 'Фантастика' },
    ] }] })));
    const unknown = run(record(bib({ genres: [{ observation: 'other', value: [
      { code: 'det_lady', description: 'Жіночий детектив', meta: 'Детективи' },
    ] }] })));
    return JSON.stringify(legacy.genre_details) === JSON.stringify([
      { code: 'sf_fantasy', description: '', category: '', catalog: false },
      { code: 'dark_fantasy', description: 'Темне фентезі', category: 'Фантастика', catalog: false },
    ]) && unknown.genre_details[0].catalog === false;
  }],

  ['exact duplicate genre codes keep only the first definition', () => {
    const b = run(record(bib({ genres: [{ observation: 'db', value: [
      { code: 'popadancy', description: 'Попаданці', meta: 'Фантастика' },
      'popadancy',
      { code: 'popadancy', description: 'Друга назва', meta: 'Інша категорія' },
      { code: 'POPADANCY' },
    ] }] })));
    return JSON.stringify(b.genres) === JSON.stringify(['popadancy', 'POPADANCY']) &&
      JSON.stringify(b.genre_details) === JSON.stringify([
        { code: 'popadancy', description: 'Попаданці', category: 'Фантастика', catalog: true },
        { code: 'POPADANCY', description: '', category: '', catalog: true },
      ]);
  }],

  ['malformed genre labels do not invalidate a usable code or invent metadata', () => {
    const b = run(record(bib({ genres: [{ observation: 'db', value: [
      { code: 'popadancy', description: 42, meta: { name: 'Фантастика' } },
    ] }] })));
    return JSON.stringify(b.genre_details) === JSON.stringify([
      { code: 'popadancy', description: '', category: '', catalog: true },
    ]);
  }],

  ['all unusable genre claims leave both genre arrays empty', () => {
    const b = run(record(bib({ genres: [
      { observation: 'db', value: [null, {}, { code: [] }] },
      { observation: 'fb2', value: ['', '  ', '���', '()'] },
    ] })));
    return JSON.stringify(b.genres) === '[]' && JSON.stringify(b.genre_details) === '[]';
  }],


  ['normalized deleted state hides deleted books', () => {
    const b = run(record({ catalog: { deleted: [
      { observation: 'db', value: { raw: '1', state: 'deleted' } },
    ] } }));
    return b.deleted === true;
  }],

  ['normalized active state is an answer, not a fallback to a later deleted claim', () => {
    const b = run(record({ catalog: { deleted: [
      { observation: 'db', value: { raw: '0', state: 'active' } },
      { value: true },
    ] } }));
    return b.deleted === false;
  }],

  ['a malformed normalized state does not hide a later usable deleted claim', () => {
    const b = run(record({ catalog: { deleted: [
      { value: { raw: '1', state: 42 } },
      { value: { raw: '1', state: 'deleted' } },
    ] } }));
    return b.deleted === true;
  }],

  // A database series claim stores its number as {"value": n}, and n is not
  // always an integer: 28.6 occurs in a real Flibusta dump. TJSONNumber.AsInt64
  // is StrToInt64, so reading it raised "'28.6' is not a valid integer value",
  // and that exception aborted a whole 705,399-record import.
  ['a fractional database series number is truncated, not an error', () => {
    const b = run(record(bib({
      sequences: [{ value: { name: 'Хроніки', number: { value: 28.6 } }, observation: 'db' }],
    })));
    return b.series === 'Хроніки' && b.series_no === 28;
  }],

  ['a fractional series number in a string is truncated too', () => {
    const b = run(record(bib({
      sequences: [{ value: { name: 'Хроніки', number: '28.6' } }],
    })));
    return b.series === 'Хроніки' && b.series_no === 28;
  }],

  ['a fractional year does not abort the record', () => {
    const b = run(record({
      bibliographic: { title: [{ value: 'Проба' }] },
      publication: { year: [{ value: 2005.5 }] },
    }));
    return b.pub_year === 2005;
  }],

  ['a fractional deleted flag is read as zero', () => {
    const b = run(record({
      bibliographic: { title: [{ value: 'Проба' }] },
      catalog: { deleted: [{ value: 0.5 }] },
    }));
    return b.deleted === false;
  }],

  // The risk is not the bad record itself but the run around it: one
  // unparseable line must cost that line only, not the lines after it.
  ['a malformed line is skipped, not fatal', () => {
    const out = runReport([record({}), '{ "schema": "metabib.dataset', record({})]);
    return out.books.length === 2 && out.bad_lines === 1;
  }],
];

let failed = 0;
for (const [name, fn] of checks) {
  let ok = false, err = null;
  try { ok = fn(); } catch (e) { err = e; }
  if (!ok) failed++;
  console.log(`${ok ? 'PASS' : 'FAIL'}  ${name}${err ? ` (${err.message})` : ''}`);
}
console.log(`\n${checks.length - failed}/${checks.length} passed`);
process.exit(failed ? 1 : 0);
