'use strict';

// Validates translated genre lists against their Russian original.
//
// A .glst line is one of:
//   #...                      comment
//   <path> <name>             category   (e.g. "0.1 Фантастика")
//   <path> <code>;<name>      genre      (e.g. "0.1.0 sf_history;Альт...")
//
// The path and the fb2 code are KEYS: the collection database stores the code,
// and the tree position comes from the path. Only the name is translatable.
// If a translator perturbs a key the failure is silent -- genres simply stop
// matching and their books land in "Неотсортированное" -- so this tool
// compares structure positionally and refuses any drift.
//
// Names are never compared. Some Bulgarian genre names are spelled exactly as
// the Russian ("Драматургия"), so an identical name is not evidence of an
// untranslated line.
//
// Encoding and line endings are compared against the original, not against a
// fixed expectation -- see the note in compare().
//
// Usage:
//   node tools/lang/check_glst.js [dir]      dir defaults to Installer/Common
//
// Exit code: 0 = pass, 1 = fail.

const fs = require('fs');
const path = require('path');

const DIR = process.argv[2]
  || path.join(__dirname, '..', '..', 'Installer', 'Common');

const BASES = ['genres_fb2', 'genres_nonfb2'];

const problems = [];

function problem(file, message) {
  problems.push(`${file}: ${message}`);
}

// Splits a .glst into positional records. Returns { records, hadBom, hadCrLf }.
// A trailing newline produces a final empty element that is not a record.
function parse(raw) {
  const hadBom = raw.charCodeAt(0) === 0xfeff;
  const body = hadBom ? raw.slice(1) : raw;
  const hadCrLf = body.includes('\r\n');
  const lines = body.split(/\r?\n/);
  if (lines.length > 0 && lines[lines.length - 1] === '') lines.pop();

  const records = lines.map((text, i) => {
    const no = i + 1;
    if (text.startsWith('#')) return { no, kind: 'comment' };

    const sp = text.indexOf(' ');
    if (sp < 0) return { no, kind: 'malformed', text };

    const treePath = text.slice(0, sp);
    const rest = text.slice(sp + 1);
    const semi = rest.indexOf(';');
    if (semi < 0) return { no, kind: 'category', treePath, name: rest };

    return {
      no,
      kind: 'genre',
      treePath,
      code: rest.slice(0, semi),
      name: rest.slice(semi + 1),
    };
  });

  return { records, hadBom, hadCrLf };
}

function compare(originalFile, translatedFile) {
  const orig = parse(fs.readFileSync(path.join(DIR, originalFile), 'utf8'));
  const tr = parse(fs.readFileSync(path.join(DIR, translatedFile), 'utf8'));

  // Both properties are compared against the original rather than against a
  // fixed expectation. core.autocrlf is true in this repository, so the .glst
  // files are stored with LF and checked out with CRLF -- hard-coding either
  // one would fail on somebody's tree. What must hold is that a translation
  // matches its original in the tree it is sitting in.
  if (orig.hadBom !== tr.hadBom) {
    problem(translatedFile, tr.hadBom
      ? 'has a UTF-8 BOM, the original has none'
      : 'missing UTF-8 BOM (the original has one)');
  }
  if (orig.hadCrLf !== tr.hadCrLf) {
    problem(translatedFile,
      `line endings are ${tr.hadCrLf ? 'CRLF' : 'LF'}, `
      + `the original uses ${orig.hadCrLf ? 'CRLF' : 'LF'}`);
  }

  if (orig.records.length !== tr.records.length) {
    problem(translatedFile,
      `record count ${tr.records.length}, original has ${orig.records.length}`);
    return; // positional comparison past this point is meaningless
  }

  for (let i = 0; i < orig.records.length; i++) {
    const o = orig.records[i];
    const t = tr.records[i];

    if (t.kind === 'malformed') {
      problem(translatedFile, `line ${t.no}: cannot parse ${JSON.stringify(t.text)}`);
      continue;
    }
    if (o.kind !== t.kind) {
      problem(translatedFile,
        `line ${t.no}: is a ${t.kind}, original line ${o.no} is a ${o.kind}`);
      continue;
    }
    if (o.kind === 'comment') continue;

    if (o.treePath !== t.treePath) {
      problem(translatedFile,
        `line ${t.no}: tree path "${t.treePath}", original has "${o.treePath}"`);
    }
    if (o.kind === 'genre' && o.code !== t.code) {
      problem(translatedFile,
        `line ${t.no}: fb2 code "${t.code}", original has "${o.code}"`);
    }
    if (t.name.trim() === '') {
      problem(translatedFile, `line ${t.no}: empty name`);
    }
  }
}

let checked = 0;
for (const base of BASES) {
  const original = `${base}.glst`;
  if (!fs.existsSync(path.join(DIR, original))) continue;

  const translated = fs.readdirSync(DIR)
    .filter((f) => new RegExp(`^${base}_[a-z]{2}\\.glst$`).test(f))
    .sort();

  for (const file of translated) {
    compare(original, file);
    checked++;
  }
}

if (problems.length > 0) {
  console.error(`${problems.length} problem(s):`);
  for (const p of problems) console.error(`  ${p}`);
  process.exit(1);
}

console.log(`check_glst: ${checked} translated list(s) OK`);
process.exit(0);
