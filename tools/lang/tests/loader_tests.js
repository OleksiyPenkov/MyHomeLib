'use strict';

// Runs LangTest.exe against generated scratch fixtures and asserts on the
// JSON report it writes. Every case builds a complete, isolated app
// directory: the exe, a myhomelib2.ini, an optional Lang\ folder, and
// probe.json.
//
// Usage: node tools/lang/tests/loader_tests.js <path-to-LangTest.exe>
// Exit code: 0 = pass, 1 = fail.
//
// Build the harness first -- it is in no dproj. See the build script named in
// docs/superpowers/plans/2026-08-11-signed-lang-catalogs.md, Task 2.

const fs = require('fs');
const os = require('os');
const path = require('path');
const crypto = require('crypto');
const { spawnSync } = require('child_process');

// The real signing key, so the tests prove the key compiled into the binary
// matches the one the maintainer signs with. A generated throwaway key would
// pass the negative cases and silently fail to prove the positive one.
const SIGN_KEY = process.env.MHL_LANG_KEY
  || path.join(os.homedir(), '.myhomelib', 'lang-signing-key.pem');

// Signs bytes the same way tools/lang/sign.js does.
function signBytes(bytes) {
  const key = crypto.createPrivateKey(fs.readFileSync(SIGN_KEY));
  return crypto.sign('sha256', bytes, { key, dsaEncoding: 'ieee-p1363' });
}

const EXE = process.argv[2];
if (!EXE || !fs.existsSync(EXE)) {
  console.error('usage: node loader_tests.js <path-to-LangTest.exe>');
  process.exit(1);
}

const PROBES = ['Автор', 'Назва', 'Серія'];

let caseNo = 0;

// Builds a scratch app directory and runs the harness in it.
//   opts.locale    -> written as [INTERFACE] Locale=<value>; omit for no key
//   opts.catalogs  -> { 'en.json': <object|string>, ... } placed in Lang\
//   opts.noLangDir -> true to omit the Lang folder entirely
function run(opts) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), `langtest${caseNo++}-`));
  fs.copyFileSync(EXE, path.join(dir, 'LangTest.exe'));
  fs.writeFileSync(path.join(dir, 'probe.json'),
    JSON.stringify(PROBES), 'utf8');

  const ini = opts.locale === undefined
    ? '[INTERFACE]\r\n'
    : `[INTERFACE]\r\nLocale=${opts.locale}\r\n`;
  fs.writeFileSync(path.join(dir, 'myhomelib2.ini'), ini, 'utf8');

  if (!opts.noLangDir) {
    const ld = path.join(dir, 'Lang');
    fs.mkdirSync(ld);
    for (const [name, body] of Object.entries(opts.catalogs || {})) {
      fs.writeFileSync(path.join(ld, name),
        typeof body === 'string' ? body : JSON.stringify(body), 'utf8');
    }
    for (const [name, sig] of Object.entries(opts.sigs || {})) {
      fs.writeFileSync(path.join(ld, name), sig);
    }
  }

  const report = path.join(dir, 'report.json');
  const r = spawnSync(path.join(dir, 'LangTest.exe'),
    ['uselocaldata', report], { encoding: 'utf8' });
  if (r.status !== 0) {
    throw new Error(`harness exit ${r.status}: ${r.stderr || r.stdout}`);
  }
  // TEncoding.UTF8 writes a BOM and JSON.parse refuses one. The same trap
  // applies to catalogs read out of the exe's resources -- see
  // EmbeddedCatalogText in unit_Localization.pas.
  return JSON.parse(fs.readFileSync(report, 'utf8').replace(/^﻿/, ''));
}

const checks = [
  ['uk: embedded identity catalog installs nothing', () => {
    const r = run({ locale: 'uk', noLangDir: true });
    return r.active === false && r.translations['Автор'] === 'Автор';
  }],

  ['uk is always offered even with no Lang directory at all', () => {
    const r = run({ locale: 'uk', noLangDir: true });
    return r.locales.some(l => l.code === 'uk' && l.name === 'Українська');
  }],

  ['en works with no Lang directory at all -- it is in the exe', () => {
    const r = run({ locale: 'en', noLangDir: true });
    return r.active === true
      && r.translations['Автор'] === 'Author'
      && r.translations['Назва'] === 'Title';
  }],

  ['en is offered with no Lang directory at all', () => {
    const r = run({ locale: 'en', noLangDir: true });
    return r.locales.some(l => l.code === 'en' && l.name === 'English');
  }],

  ['a file en.json cannot override the embedded English', () => {
    const r = run({ locale: 'en', catalogs: { 'en.json': {
      locale: 'en', name: 'English',
      strings: { k1: { source: 'Автор', target: 'HIJACKED' } }, dfm: {},
    } } });
    return r.active === true && r.translations['Автор'] === 'Author';
  }],

  ['a file catalog declaring a different locale is refused', () => {
    const r = run({ locale: 'pl', catalogs: { 'pl.json': {
      locale: 'de', name: 'Polski',
      strings: { k1: { source: 'Автор', target: 'Autor' } }, dfm: {},
    } } });
    return r.active === false && r.translations['Автор'] === 'Автор';
  }],

  ['a well-formed foreign-locale file catalog still loads', () => {
    const r = run({ locale: 'pl', catalogs: { 'pl.json': {
      locale: 'pl', name: 'Polski',
      strings: { k1: { source: 'Автор', target: 'Autor' } }, dfm: {},
    } } });
    return r.active === true && r.translations['Автор'] === 'Autor';
  }],

  ['malformed catalog does not crash and does not install', () => {
    const r = run({ locale: 'pl', catalogs: { 'pl.json': '{ this is not json' } });
    return r.active === false && r.translations['Автор'] === 'Автор';
  }],

  ['all-identity catalog yields an empty index, so nothing installs', () => {
    const r = run({ locale: 'pl', catalogs: { 'pl.json': {
      locale: 'pl', name: 'Polski',
      strings: { k1: { source: 'Автор', target: 'Автор' } }, dfm: {},
    } } });
    return r.active === false;
  }],

  ['empty target is ignored rather than blanking the string', () => {
    const r = run({ locale: 'pl', catalogs: { 'pl.json': {
      locale: 'pl', name: 'Polski',
      strings: {
        k1: { source: 'Автор', target: '   ' },
        k2: { source: 'Назва', target: 'Tytuł' },
      },
      dfm: {},
    } } });
    return r.active === true
      && r.translations['Автор'] === 'Автор'
      && r.translations['Назва'] === 'Tytuł';
  }],

  ['missing Locale key defaults to uk', () => {
    const r = run({ noLangDir: true });
    return r.active === false && r.translations['Автор'] === 'Автор';
  }],

  ['verifier accepts a correctly signed catalog', () => {
    const body = JSON.stringify({ locale: 'verify', name: 'V',
      strings: { k1: { source: 'Автор', target: 'A' } }, dfm: {} });
    const r = run({ locale: 'uk',
      catalogs: { 'verify.json': body },
      sigs: { 'verify.json.sig': signBytes(Buffer.from(body, 'utf8')) } });
    return r.verify === true;
  }],

  ['verifier rejects a catalog with no signature at all', () => {
    const body = JSON.stringify({ locale: 'verify', name: 'V',
      strings: {}, dfm: {} });
    const r = run({ locale: 'uk', catalogs: { 'verify.json': body } });
    return r.verify === false;
  }],

  ['verifier rejects a one-byte tampered catalog', () => {
    const body = JSON.stringify({ locale: 'verify', name: 'V',
      strings: { k1: { source: 'Автор', target: 'A' } }, dfm: {} });
    const sig = signBytes(Buffer.from(body, 'utf8'));
    const r = run({ locale: 'uk',
      catalogs: { 'verify.json': body.replace('"A"', '"B"') },
      sigs: { 'verify.json.sig': sig } });
    return r.verify === false;
  }],

  ['verifier rejects a truncated signature', () => {
    const body = JSON.stringify({ locale: 'verify', name: 'V',
      strings: {}, dfm: {} });
    const sig = signBytes(Buffer.from(body, 'utf8')).subarray(0, 32);
    const r = run({ locale: 'uk',
      catalogs: { 'verify.json': body }, sigs: { 'verify.json.sig': sig } });
    return r.verify === false;
  }],

  ['verifier rejects a signature made with a different key', () => {
    const body = JSON.stringify({ locale: 'verify', name: 'V',
      strings: {}, dfm: {} });
    const other = crypto.generateKeyPairSync('ec', { namedCurve: 'prime256v1' });
    const sig = crypto.sign('sha256', Buffer.from(body, 'utf8'),
      { key: other.privateKey, dsaEncoding: 'ieee-p1363' });
    const r = run({ locale: 'uk',
      catalogs: { 'verify.json': body }, sigs: { 'verify.json.sig': sig } });
    return r.verify === false;
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
