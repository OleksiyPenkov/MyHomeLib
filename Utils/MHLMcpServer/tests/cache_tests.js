const { spawnSync } = require('child_process');

const exe = process.argv[2];

// unit_MCP_TextCache has no MCP-protocol surface of its own (Task 10 wires
// it into real tools), so there is nothing for run_tests.js's JSONL
// golden-file harness to call. Instead the exe itself runs the whole
// scenario list in Pascal -- against a throwaway temp directory, never the
// real %LOCALAPPDATA%\MyHomeLib\McpCache -- via `--cache-selftest`, and
// prints one JSON object with a "checks" array (mirroring how --extract
// prints one JSON object per run). This script's only job is turning that
// into the same PASS/FAIL console lines every other test script here uses.
const run = spawnSync(exe, ['--cache-selftest'], { encoding: 'utf8' });
if (run.status !== 0) {
  console.error(`--cache-selftest exited ${run.status}: ${run.stderr}`);
  process.exit(2);
}

let result;
try {
  result = JSON.parse(run.stdout.trim());
} catch (e) {
  console.error(`--cache-selftest did not print a single JSON line: ${e.message}`);
  console.error(`stdout: ${run.stdout}`);
  console.error(`stderr: ${run.stderr}`);
  process.exit(2);
}

let failed = 0;
for (const c of result.checks) {
  console.log(`${c.pass ? 'PASS' : 'FAIL'} ${c.name}${c.detail ? ' — ' + c.detail : ''}`);
  if (!c.pass) failed++;
}

process.exit(failed ? 1 : 0);
