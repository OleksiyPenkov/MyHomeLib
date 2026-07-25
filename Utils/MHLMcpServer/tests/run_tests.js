const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const exe = process.argv[2];
if (!exe || !fs.existsSync(exe)) {
  console.error(`Server exe not found: ${exe}`);
  process.exit(2);
}

const casesDir = path.join(__dirname, 'cases');
let failed = 0;

for (const file of fs.readdirSync(casesDir).filter(f => f.endsWith('.jsonl')).sort()) {
  const lines = fs.readFileSync(path.join(casesDir, file), 'utf8')
    .split(/\r?\n/).filter(l => l.trim());
  const sent = lines.filter(l => l.startsWith('>')).map(l => l.slice(1).trim());
  const want = lines.filter(l => l.startsWith('<')).map(l => JSON.parse(l.slice(1).trim()));

  const run = spawnSync(exe, [], { input: sent.join('\n') + '\n', encoding: 'utf8' });
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
