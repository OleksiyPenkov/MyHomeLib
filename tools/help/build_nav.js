'use strict';
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..', '..');
const HELP = path.join(ROOT, 'Program', 'Help');
const spec = JSON.parse(fs.readFileSync(path.join(__dirname, 'topics.json'), 'utf8'));

const esc = (s) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');

function navFor(current) {
  const out = ['<p class="nav-title"><a href="index.html">Довідка MyHomeLib</a></p>'];
  for (const section of spec.sections) {
    out.push(`<p class="nav-section">${esc(section.title)}</p>`);
    out.push('<ul>');
    for (const t of section.topics) {
      if (t.file === 'index.html') continue; // already the nav title
      const cur = t.file === current ? ' class="cur" aria-current="page"' : '';
      out.push(`<li><a href="${t.file}"${cur}>${esc(t.title)}</a></li>`);
    }
    out.push('</ul>');
  }
  return out.join('\n');
}

function template(title) {
  return `<!DOCTYPE html>
<html lang="uk">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${esc(title)} — Довідка MyHomeLib</title>
<link rel="stylesheet" href="help.css">
</head>
<body>
<nav id="toc">
<!-- TOC:BEGIN -->
<!-- TOC:END -->
</nav>
<main id="content">
<h1>${esc(title)}</h1>
<!-- BODY:BEGIN -->
<p>Розділ у роботі.</p>
<!-- BODY:END -->
</main>
</body>
</html>
`;
}

fs.mkdirSync(HELP, { recursive: true });

let created = 0;
let updated = 0;
for (const section of spec.sections) {
  for (const t of section.topics) {
    const p = path.join(HELP, t.file);
    if (!fs.existsSync(p)) {
      fs.writeFileSync(p, template(t.title), 'utf8');
      created++;
    }
    const html = fs.readFileSync(p, 'utf8');
    const next = html.replace(
      /<!-- TOC:BEGIN -->[\s\S]*?<!-- TOC:END -->/,
      `<!-- TOC:BEGIN -->\n${navFor(t.file)}\n<!-- TOC:END -->`
    );
    if (next !== html) {
      fs.writeFileSync(p, next, 'utf8');
      updated++;
    }
  }
}
console.log(`build_nav: created ${created}, updated nav in ${updated}`);
