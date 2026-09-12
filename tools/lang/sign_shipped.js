'use strict';

// Signs every catalog that gets embedded in the exe.
//
// Since unit_Localization verifies LANG_<CODE> against LANG_<CODE>_SIG, an
// unsigned shipped catalog is a language that will not appear in the menu --
// and embed.js refuses to build rather than let that happen quietly. This is
// the one command that clears it, so preparing a release is not an exercise in
// remembering which locales exist.
//
// Community catalogs are NOT signed here. Those go one at a time through
// sign.js, after review -- see "Accepting a community translation" in
// tools/lang/README.md. Signing the shipped set is bookkeeping; signing
// somebody else's translation is a decision.
//
// Usage: node tools/lang/sign_shipped.js [path-to-key.pem]
// Key:   the argument, else $MHL_LANG_KEY, else the sign.js default
//        (%USERPROFILE%\.myhomelib\lang-signing-key.pem)
//
// Exit code: 0 = every shipped catalog is signed, 1 = at least one was not.

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');
const { EMBEDDED } = require('./embedded_locales');

const ROOT = path.join(__dirname, '..', '..');
const LANG_DIR = path.join(ROOT, 'Program', 'Lang');
const SIGN = path.join(__dirname, 'sign.js');

const keyPath = process.argv[2] || process.env.MHL_LANG_KEY;
if (keyPath && !fs.existsSync(keyPath)) {
  console.error(`ERROR: no key at ${keyPath}`);
  process.exit(1);
}

let failed = 0;
let signed = 0;

for (const code of EMBEDDED) {
  const file = path.join(LANG_DIR, `${code}.json`);
  if (!fs.existsSync(file)) {
    // Same rule as embed.js: a clone without the private catalog repository
    // is not broken, it just builds with fewer languages.
    console.log(`SKIP  ${code}.json is not present`);
    continue;
  }

  const r = spawnSync(process.execPath, [SIGN, file], {
    encoding: 'utf8',
    // sign.js reads the key from the environment, so pass it that way rather
    // than teaching it a second interface.
    env: keyPath ? { ...process.env, MHL_LANG_KEY: keyPath } : process.env,
  });
  process.stdout.write(r.stdout || '');
  process.stderr.write(r.stderr || '');

  if (r.status !== 0 || !fs.existsSync(`${file}.sig`)) {
    failed++;
  } else {
    signed++;
  }
}

console.log('');
console.log(`${signed} signed, ${failed} failed`);
if (failed > 0) {
  console.log('The build will keep refusing until every shipped catalog is signed.');
}
process.exit(failed > 0 ? 1 : 0);
