'use strict';

// Generates the pseudo-locale catalog used for the step-4 coverage sweep.
//
// Every source string becomes "[<source> ····]": bracketed so a string that
// went through the catalog is unmistakable, and padded ~30% wider so a layout
// that cannot hold a longer translation shows up as visibly clipped text
// rather than as something you have to measure.
//
// It writes into the BUILD OUTPUT, never into Program/Lang. Only uk and en are
// ever embedded into the exe, so a qa.json in Program/Lang would not ship --
// but it would sit in the catalog repository pretending to be a translation.
// Written to the output instead, it is regenerated after each build, which is
// exactly when you want a fresh one anyway.
//
// Each catalog is SIGNED after being written: since 2026-08-11 the loader
// refuses any unsigned file catalog, and the pseudo-locale is a file catalog
// like any other. There is no bypass, by design -- see tools/lang/README.md.
// Signing needs the private key, so this only works on the maintainer's
// machine, which is also the only place the sweep happens.

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const SOURCE_CATALOG = path.join(REPO_ROOT, 'Program', 'Lang', 'uk.json');
const OUT_DIRS = [
  path.join(REPO_ROOT, 'Program', 'OUT', 'Bin64', 'Lang'),
  path.join(REPO_ROOT, 'Program', 'OUT', 'BIN', 'Lang'),
];

const PAD_CHAR = '·'; // MIDDLE DOT: visible, narrow, unambiguously not ours
const PAD_RATIO = 0.3;

// Format specifiers are stripped before asking "is there any text here?" so
// that "%s" and "%d" are not mistaken for words.
const FORMAT_SPEC = /%[-+ #0-9.*:]*[a-zA-Z]/g;

function fail(message) {
  console.error(message);
  process.exit(1);
}

// Entries with no letters left after removing format specifiers -- "%s", "-",
// "...", "1" -- are not screen text and get an identity target. The runtime
// skips identity entries (LoadSection rule 2), so they are absent from the
// index and stay unbracketed, which is the correct outcome: bracketing them
// would just add noise to the sweep.
function isTextual(source) {
  return /\p{L}/u.test(source.replace(FORMAT_SPEC, ''));
}

function pseudo(source) {
  const padLength = Math.max(1, Math.round(source.length * PAD_RATIO));
  return '[' + source + ' ' + PAD_CHAR.repeat(padLength) + ']';
}

function convert(section) {
  const out = {};
  for (const [key, entry] of Object.entries(section)) {
    const source = entry.source;
    out[key] = { source, target: isTextual(source) ? pseudo(source) : source };
  }
  return out;
}

function main() {
  if (!fs.existsSync(SOURCE_CATALOG)) {
    fail(`Base catalog not found: ${SOURCE_CATALOG}. Run tools/lang/extract.js first.`);
  }

  let base;
  try {
    base = JSON.parse(fs.readFileSync(SOURCE_CATALOG, 'utf8'));
  } catch (e) {
    fail(`${SOURCE_CATALOG} is not valid JSON (${e.message}).`);
  }

  const catalog = {
    locale: 'qa',
    name: 'Pseudo (QA)',
    strings: convert(base.strings || {}),
    dfm: convert(base.dfm || {}),
  };

  const entries = [
    ...Object.values(catalog.strings),
    ...Object.values(catalog.dfm),
  ];
  const bracketed = entries.filter((e) => e.target !== e.source).length;

  let written = 0;
  for (const dir of OUT_DIRS) {
    if (!fs.existsSync(dir)) {
      console.log(`skipped ${dir} (not built yet)`);
      continue;
    }
    const target = path.join(dir, 'qa.json');
    fs.writeFileSync(target, JSON.stringify(catalog, null, 2), { encoding: 'utf8' });

    // Reuse sign.js rather than duplicating the signing here: it also runs the
    // validity checks, so a pseudo-catalog that the loader would reject is
    // caught now instead of looking like a walker bug during the sweep.
    const signed = spawnSync(process.execPath,
      [path.join(__dirname, 'sign.js'), target], { encoding: 'utf8' });
    if (signed.status !== 0) {
      fail(`could not sign ${target}:\n${signed.stderr || signed.stdout}`);
    }

    console.log(`wrote and signed ${target}`);
    written++;
  }

  if (written === 0) {
    fail('No output Lang directory exists. Build first, then re-run.');
  }

  console.log(
    `${bracketed}/${entries.length} entries pseudo-translated ` +
    `(${entries.length - bracketed} left as identity: no letters outside format specifiers)`
  );
}

if (require.main === module) {
  main();
}

module.exports = { pseudo, isTextual, convert };
