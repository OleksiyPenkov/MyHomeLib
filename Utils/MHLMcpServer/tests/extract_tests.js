const { spawnSync } = require('child_process');
const path = require('path');

const exe = process.argv[2];
const fx = f => path.join(__dirname, 'fixtures', f);

function extract(file) {
  const run = spawnSync(exe, ['--extract', fx(file)], { encoding: 'utf8' });
  if (run.status !== 0) throw new Error(`exit ${run.status}: ${run.stderr}`);
  return JSON.parse(run.stdout);
}

const checks = [
  ['structured: two sections', () => {
    const r = extract('structured.fb2');
    return r.structured === true
      && r.sections.length === 2
      && r.sections[0].title === 'Chapter One'
      && r.sections[1].title === 'Chapter Two';
  }],
  ['structured: offsets land on their section text', () => {
    const r = extract('structured.fb2');
    const s = r.sections[1];
    return r.text.substr(s.offset, s.length).includes('Beta text.');
  }],
  ['flat: text extracted, no sections claimed', () => {
    const r = extract('flat.fb2');
    return r.text.includes('Текст без заголовків') && r.sections.length <= 1;
  }],
  ['broken: falls back to text, structured=false', () => {
    const r = extract('broken.fb2');
    return r.structured === false && r.text.includes('Salvageable text.');
  }],
];

let failed = 0;
for (const [name, fn] of checks) {
  let ok = false, err = '';
  try { ok = fn(); } catch (e) { err = e.message; }
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${err ? ' — ' + err : ''}`);
  if (!ok) failed++;
}
process.exit(failed ? 1 : 0);
