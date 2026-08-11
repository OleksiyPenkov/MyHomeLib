'use strict';

// Signs a language catalog. This is the ONLY route into Lang\ for a locale
// the project does not ship, so it is also where validity is enforced: a
// catalog that would misbehave at runtime must not become a signed catalog.
//
// Usage: node tools/lang/sign.js <path-to-catalog.json>
// Key:   $MHL_LANG_KEY, or %USERPROFILE%\.myhomelib\lang-signing-key.pem
//
// Writes <path-to-catalog.json>.sig -- 64 raw bytes, r||s.
// Exit code: 0 = signed, 1 = refused.
//
// The checks below are deliberately NOT delegated to check_lang.js: that tool
// validates the catalog set ACROSS files, including "a catalog is missing keys
// another catalog has", which is true of every community translation by
// construction. Reusing it would refuse every catalog this tool exists to
// admit.

const fs = require('fs');
const os = require('os');
const path = require('path');
const crypto = require('crypto');

const DEFAULT_KEY = path.join(os.homedir(), '.myhomelib', 'lang-signing-key.pem');
const target = process.argv[2];
const keyPath = process.env.MHL_LANG_KEY || DEFAULT_KEY;

function refuse(why) {
  console.error(`REFUSED: ${why}`);
  process.exit(1);
}

if (!target) refuse('usage: node tools/lang/sign.js <path-to-catalog.json>');
if (!fs.existsSync(target)) refuse(`${target} does not exist`);
if (!fs.existsSync(keyPath)) {
  refuse(`no signing key at ${keyPath} (set MHL_LANG_KEY to override)`);
}

const bytes = fs.readFileSync(target);

let doc;
try {
  doc = JSON.parse(bytes.toString('utf8').replace(/^﻿/, ''));
} catch (e) {
  refuse(`not valid JSON: ${e.message}`);
}

// The runtime refuses a catalog whose declared locale disagrees with its
// filename, so signing one would produce a signature that can never be used.
const stem = path.basename(target).replace(/\.json$/i, '').toLowerCase();
if (String(doc.locale || '').trim().toLowerCase() !== stem) {
  refuse(`declares locale "${doc.locale}" but is named ${path.basename(target)}`);
}
if (!String(doc.name || '').trim()) {
  refuse('has no "name" -- the language menu would have nothing to show');
}

// Lookup is by source text, so two keys sharing a source must share a target.
// The loader keeps whichever it indexed first and discards the rest silently;
// catching it here is the only place it is visible.
const bySource = new Map();
for (const section of ['strings', 'dfm']) {
  for (const [key, entry] of Object.entries(doc[section] || {})) {
    if (!entry || typeof entry !== 'object') {
      refuse(`${section}.${key} is not an object`);
    }
    const { source, target: tgt } = entry;
    if (typeof source !== 'string' || typeof tgt !== 'string') {
      refuse(`${section}.${key} has a non-string source or target`);
    }
    if (!tgt.trim() || tgt === source) continue;
    if (bySource.has(source) && bySource.get(source) !== tgt) {
      refuse(`source ${JSON.stringify(source)} has two different targets: `
        + `${JSON.stringify(bySource.get(source))} and ${JSON.stringify(tgt)}`);
    }
    bySource.set(source, tgt);
  }
}

if (bySource.size === 0) {
  refuse('has no usable translations -- the loader would ignore it entirely');
}

const key = crypto.createPrivateKey(fs.readFileSync(keyPath));
// ieee-p1363 gives raw r||s, which is what BCryptVerifySignature expects.
// The default DER encoding would need unwrapping in Pascal.
const sig = crypto.sign('sha256', bytes, { key, dsaEncoding: 'ieee-p1363' });

if (sig.length !== 64) {
  refuse(`produced a ${sig.length}-byte signature, expected 64`);
}

fs.writeFileSync(`${target}.sig`, sig);
console.log(`Signed ${path.basename(target)} (${bySource.size} usable translations)`);
