const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const exe = process.argv[2];
if (!exe || !fs.existsSync(exe)) {
  console.error(`Server exe not found: ${exe}`);
  process.exit(2);
}

const ARGS = ['--make-fixture', 'uselocaldata', 'user', 'mcpfixture'];

let failed = 0;
function check(name, ok, detail) {
  if (ok) { console.log(`PASS ${name}`); }
  else { failed++; console.log(`FAIL ${name}`); if (detail) console.log(`  ${detail}`); }
}

const run = spawnSync(exe, ARGS, { encoding: 'utf8' });
check('exit code 0', run.status === 0, `status=${run.status} stderr=${run.stderr.trim()}`);

const lines = (run.stdout || '').split(/\r?\n/).filter(l => l.trim());
check('exactly one stdout line', lines.length === 1, `got ${lines.length} lines`);

let summary = null;
try { summary = JSON.parse(lines[0]); } catch (e) { /* reported below */ }
check('summary parses as JSON', summary !== null, lines[0]);

if (summary) {
  check('collection_id is 1', summary.collection_id === 1, `got ${summary.collection_id}`);
  check('system db exists', fs.existsSync(summary.db), summary.db);
  check('collection root exists', fs.existsSync(summary.root), summary.root);
  check('books is an array', Array.isArray(summary.books), typeof summary.books);
}

if (summary && Array.isArray(summary.books)) {
  check('six books', summary.books.length === 6, `got ${summary.books.length}`);
  check('ids are 1..6',
    summary.books.every((b, i) => b.book_id === i + 1),
    JSON.stringify(summary.books.map(b => b.book_id)));
  check('every book file exists',
    summary.books.every(b => fs.existsSync(b.path)),
    JSON.stringify(summary.books.map(b => b.path)));
  check('deleted book is last',
    summary.books[5] && summary.books[5].title === 'Вилучена книга',
    JSON.stringify(summary.books[5]));
}

// Running it twice must be safe and must still yield collection_id 1.
const again = spawnSync(exe, ARGS, { encoding: 'utf8' });
let second = null;
try { second = JSON.parse((again.stdout || '').split(/\r?\n/).filter(l => l.trim())[0]); } catch (e) {}
check('second run is idempotent', again.status === 0 && second && second.collection_id === 1,
  `status=${again.status} stderr=${again.stderr.trim()}`);

process.exit(failed ? 1 : 0);
