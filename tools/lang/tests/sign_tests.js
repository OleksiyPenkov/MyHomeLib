'use strict';

// Tests for keygen.js and sign.js. Everything runs in a scratch directory --
// no test may touch the real signing key or the real catalogs.
//
// Usage: node tools/lang/tests/sign_tests.js
// Exit code: 0 = pass, 1 = fail.

const fs = require('fs');
const os = require('os');
const path = require('path');
const crypto = require('crypto');
const { spawnSync } = require('child_process');

const TOOLS = path.join(__dirname, '..');
const scratch = fs.mkdtempSync(path.join(os.tmpdir(), 'langsign-'));
const KEY = path.join(scratch, 'key.pem');

function node(script, args, env) {
  return spawnSync(process.execPath, [path.join(TOOLS, script), ...args],
    { encoding: 'utf8', env: { ...process.env, ...(env || {}) } });
}

function validCatalog(locale) {
  return JSON.stringify({
    locale, name: 'Test', strings: { k1: { source: 'Автор', target: 'X' } },
    dfm: {},
  });
}

const checks = [
  ['keygen writes a private key and prints a Pascal constant', () => {
    const r = node('keygen.js', [KEY]);
    if (r.status !== 0) return false;
    const pem = fs.readFileSync(KEY, 'utf8');
    return pem.includes('BEGIN PRIVATE KEY')
      && /\$[0-9A-F]{2}/.test(r.stdout)
      && r.stdout.includes('LANG_PUBLIC_KEY');
  }],

  ['keygen refuses to overwrite an existing key', () => {
    const r = node('keygen.js', [KEY]);
    return r.status !== 0 && /exists/i.test(r.stderr + r.stdout);
  }],

  ['the printed constant holds exactly 64 bytes', () => {
    const k2 = path.join(scratch, 'key2.pem');
    const r = node('keygen.js', [k2]);
    const bytes = r.stdout.match(/\$[0-9A-F]{2}/g) || [];
    return bytes.length === 64;
  }],

  ['sign produces a 64-byte detached signature', () => {
    const cat = path.join(scratch, 'pl.json');
    fs.writeFileSync(cat, validCatalog('pl'), 'utf8');
    const r = node('sign.js', [cat], { MHL_LANG_KEY: KEY });
    if (r.status !== 0) return false;
    return fs.statSync(cat + '.sig').size === 64;
  }],

  ['the signature verifies against the public key', () => {
    const cat = path.join(scratch, 'pl.json');
    const sig = fs.readFileSync(cat + '.sig');
    const priv = crypto.createPrivateKey(fs.readFileSync(KEY));
    const pub = crypto.createPublicKey(priv);
    return crypto.verify('sha256', fs.readFileSync(cat), {
      key: pub, dsaEncoding: 'ieee-p1363',
    }, sig);
  }],

  ['a one-byte change to the catalog invalidates the signature', () => {
    const cat = path.join(scratch, 'pl.json');
    const sig = fs.readFileSync(cat + '.sig');
    const tampered = Buffer.from(validCatalog('pl').replace('X', 'Y'));
    const priv = crypto.createPrivateKey(fs.readFileSync(KEY));
    const pub = crypto.createPublicKey(priv);
    return !crypto.verify('sha256', tampered, {
      key: pub, dsaEncoding: 'ieee-p1363',
    }, sig);
  }],

  ['sign refuses a catalog that is not valid JSON', () => {
    const bad = path.join(scratch, 'bad.json');
    fs.writeFileSync(bad, '{ not json', 'utf8');
    const r = node('sign.js', [bad], { MHL_LANG_KEY: KEY });
    return r.status !== 0 && !fs.existsSync(bad + '.sig');
  }],

  ['sign refuses a catalog whose locale does not match its filename', () => {
    const bad = path.join(scratch, 'de.json');
    fs.writeFileSync(bad, validCatalog('pl'), 'utf8');
    const r = node('sign.js', [bad], { MHL_LANG_KEY: KEY });
    return r.status !== 0 && !fs.existsSync(bad + '.sig');
  }],

  ['sign refuses a catalog with two targets for one source', () => {
    const bad = path.join(scratch, 'cs.json');
    fs.writeFileSync(bad, JSON.stringify({
      locale: 'cs', name: 'Test',
      strings: {
        k1: { source: 'Автор', target: 'Autor' },
        k2: { source: 'Автор', target: 'Spisovatel' },
      },
      dfm: {},
    }), 'utf8');
    const r = node('sign.js', [bad], { MHL_LANG_KEY: KEY });
    return r.status !== 0 && !fs.existsSync(bad + '.sig');
  }],

  ['sign refuses when no key is available', () => {
    const cat = path.join(scratch, 'sk.json');
    fs.writeFileSync(cat, validCatalog('sk'), 'utf8');
    const r = node('sign.js', [cat], { MHL_LANG_KEY: path.join(scratch, 'nope.pem') });
    return r.status !== 0 && !fs.existsSync(cat + '.sig');
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
