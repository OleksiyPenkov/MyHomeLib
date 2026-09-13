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

function run(rec) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), `mbtest${caseNo++}-`));
  const data = path.join(dir, 'dataset.jsonl');
  fs.writeFileSync(data,
    JSON.stringify(HEADER) + '\n' + JSON.stringify(rec) + '\n', 'utf8');
  const report = path.join(dir, 'report.json');
  const r = spawnSync(EXE, [data, report], { encoding: 'utf8' });
  if (r.status !== 0) {
    throw new Error(`harness exit ${r.status}: ${r.stderr || r.stdout}`);
  }
  const out = JSON.parse(fs.readFileSync(report, 'utf8').replace(/^﻿/, ''));
  if (out.error) throw new Error('reader error: ' + out.error);
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

  ['an ordinary record still parses', () => {
    const b = run(record({
      bibliographic: { title: [{ value: 'Проба' }], language: [{ value: 'uk' }] },
      publication: { publisher: [{ value: 'Вид' }], isbn: [{ value: '978-0' }] },
    }));
    return b.title === 'Проба' && b.lang === 'uk'
      && b.publisher === 'Вид' && b.isbn === '978-0' && b.deleted === false;
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
