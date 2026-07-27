const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const exe = process.argv[2];
if (!exe || !fs.existsSync(exe)) {
  console.error(`Server exe not found: ${exe}`);
  process.exit(2);
}

const casesDir = path.join(__dirname, 'cases');

const SERVER_ARGS = ['uselocaldata', 'user', 'mcpfixture'];

// Build the throwaway collection before any case runs. Without this the
// suite silently falls back to whatever library the machine has, which is
// exactly the failure mode this replaces.
const setup = spawnSync(exe, ['--make-fixture', ...SERVER_ARGS], { encoding: 'utf8' });
if (setup.status !== 0) {
  console.error(`Fixture creation failed (exit ${setup.status}): ${setup.stderr.trim()}`);
  process.exit(2);
}
try {
  const summary = JSON.parse(setup.stdout.split(/\r?\n/).filter(l => l.trim())[0]);
  if (summary.collection_id !== 1 || summary.books.length !== 6) {
    console.error(`Unexpected fixture: ${setup.stdout.trim()}`);
    process.exit(2);
  }
} catch (e) {
  console.error(`Fixture summary did not parse: ${setup.stdout.trim()}`);
  process.exit(2);
}

let failed = 0;

for (const file of fs.readdirSync(casesDir).filter(f => f.endsWith('.jsonl')).sort()) {
  const lines = fs.readFileSync(path.join(casesDir, file), 'utf8')
    .split(/\r?\n/).filter(l => l.trim());
  const sent = lines.filter(l => l.startsWith('>')).map(l => l.slice(1).trim());
  const want = lines.filter(l => l.startsWith('<')).map(l => JSON.parse(l.slice(1).trim()));

  const run = spawnSync(exe, SERVER_ARGS, { input: sent.join('\n') + '\n', encoding: 'utf8' });
  const got = run.stdout.split(/\r?\n/).filter(l => l.trim()).map(l => JSON.parse(l));

  let ok = got.length === want.length;
  if (ok) {
    for (let i = 0; i < want.length; i++) {
      if (JSON.stringify(got[i]) !== JSON.stringify(want[i])) { ok = false; break; }
    }
  }

  if (ok) {
    console.log(`PASS ${file}`);
  } else {
    failed++;
    console.log(`FAIL ${file}`);
    console.log(`  want: ${JSON.stringify(want)}`);
    console.log(`  got:  ${JSON.stringify(got)}`);
    if (run.stderr.trim()) console.log(`  stderr: ${run.stderr.trim()}`);
  }
}

process.exit(failed ? 1 : 0);
