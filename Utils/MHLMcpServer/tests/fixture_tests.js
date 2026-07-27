const { spawnSync } = require('child_process');
const fs = require('fs');
const os = require('os');
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

// The settings file must be the empty one --make-fixture writes, never a copy
// of the developer's myhomelib2.ini (TMHLSettings.Create seeds <user>.ini from
// it when missing). "Empty" here means: no sections and no keys.
const iniPath = path.join(path.dirname(exe), 'mcpfixture.ini');
const iniText = fs.existsSync(iniPath) ? fs.readFileSync(iniPath, 'utf8') : null;
check('mcpfixture.ini exists', iniText !== null, iniPath);
check('mcpfixture.ini carries no inherited settings',
  iniText !== null && !iniText.split(/\r?\n/).some(l => /^\s*[\[\w]/.test(l)),
  `${iniPath}: ${JSON.stringify((iniText || '').slice(0, 200))}`);

// ---------------------------------------------------------------------------
// The refusal guard (RequireFixtureTarget in unit_MCP_Fixture.pas).
//
// `--make-fixture` with the `uselocaldata user mcpfixture` switches omitted
// resolves to the REAL system database — Program\OUT\Bin64\Data\user.dbs2 on a
// dev box (the `uselocaldata` marker file sitting next to the exe forces the
// local branch), %APPDATA%\MyHomeLib\Data\user.dbs2 otherwise — and the wipe
// would delete it. That is precisely what the guard exists to prevent, so this
// test must be able to run against a build where the guard is MISSING without
// destroying anything.
//
// It therefore never runs the real exe in place. It copies the exe (plus the
// load-time-required sqlite3.dll) into a throwaway directory, drops a
// `uselocaldata` marker beside the copy so TMHLSettings.Create resolves
// <sandbox>\Data\user.dbs2 and can never reach %APPDATA%, and plants a
// sentinel file at exactly the path an unguarded build would delete. Against a
// broken build the sentinel is what dies, and the check below is what reports
// it; the developer's own database is not reachable from the sandbox at all.
const sandbox = fs.mkdtempSync(path.join(os.tmpdir(), 'mhlmcp-guard-'));
try {
  const exeDir = path.dirname(exe);
  const sandboxExe = path.join(sandbox, path.basename(exe));
  fs.copyFileSync(exe, sandboxExe);
  fs.copyFileSync(path.join(exeDir, 'sqlite3.dll'), path.join(sandbox, 'sqlite3.dll'));
  fs.writeFileSync(path.join(sandbox, 'uselocaldata'), '');

  const sentinelDir = path.join(sandbox, 'Data');
  const sentinel = path.join(sentinelDir, 'user.dbs2');
  const SENTINEL = 'stand-in for the real system database; must survive';
  fs.mkdirSync(sentinelDir);
  fs.writeFileSync(sentinel, SENTINEL);

  const bare = spawnSync(sandboxExe, ['--make-fixture'], { encoding: 'utf8' });
  const bareErr = (bare.stderr || '').trim();

  check('guard: bare --make-fixture exits non-zero', bare.status !== 0,
    `status=${bare.status}`);
  check('guard: bare --make-fixture writes nothing to stdout',
    (bare.stdout || '').trim() === '', JSON.stringify(bare.stdout));
  check('guard: stderr names the refusal and the required switches',
    /refuses to run against/.test(bareErr) &&
    /user\.dbs2/i.test(bareErr) &&
    /uselocaldata user mcpfixture/.test(bareErr),
    bareErr);
  check('guard: the system database was NOT deleted',
    fs.existsSync(sentinel) && fs.readFileSync(sentinel, 'utf8') === SENTINEL,
    sentinel);
  check('guard: the collection folder was NOT created',
    !fs.existsSync(path.join(sandbox, 'mcpfixture')),
    path.join(sandbox, 'mcpfixture'));
} finally {
  try { fs.rmSync(sandbox, { recursive: true, force: true }); } catch (e) { /* best effort */ }
}

process.exit(failed ? 1 : 0);
