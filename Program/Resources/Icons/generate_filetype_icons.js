// generate_filetype_icons.js — Generate file-type PNG icons for both themes
const { createCanvas } = require('canvas');
const fs = require('fs');
const path = require('path');

const SIZES = [16, 20, 24, 32, 40, 48, 64];

const FILE_TYPES = [
  { name: 'filetype-fb2',    label: 'FB2',  color: '#3498DB' },
  { name: 'filetype-fb2zip', label: 'FB2Z', color: '#3498DB', zip: true },
  { name: 'filetype-lrf',    label: 'LRF',  color: '#9B59B6' },
  { name: 'filetype-txt',    label: 'TXT',  color: '#7F8C8D' },
  { name: 'filetype-epub',   label: 'EPUB', color: '#27AE60' },
  { name: 'filetype-pdf',    label: 'PDF',  color: '#E74C3C' },
  { name: 'filetype-mobi',   label: 'MOBI', color: '#E67E22' },
];

const THEMES = {
  Light: {
    bodyTop: '#D8E6F2',
    bodyBot: '#B4C8DC',
    pageTop: '#F5F8FB',
    pageBot: '#E8EEF4',
    stroke: '#19375F',
    zipColor: '#FFD700',
  },
  Dark: {
    bodyTop: '#475E74',
    bodyBot: '#2E4256',
    pageTop: '#5A7088',
    pageBot: '#3E5568',
    stroke: '#9AACBB',
    zipColor: '#FFD700',
  },
};

function drawIcon(ctx, size, ft, theme) {
  const s = size / 40; // scale factor (SVG viewBox is 40x40)
  ctx.clearRect(0, 0, size, size);

  // Document body
  const bodyGrad = ctx.createLinearGradient(0, 6 * s, 0, 34 * s);
  bodyGrad.addColorStop(0, theme.bodyTop);
  bodyGrad.addColorStop(1, theme.bodyBot);

  ctx.fillStyle = bodyGrad;
  ctx.strokeStyle = theme.stroke;
  ctx.lineWidth = 1.5 * s;
  ctx.lineJoin = 'round';
  ctx.lineCap = 'round';

  // Document shape
  ctx.beginPath();
  ctx.moveTo(10 * s, 6 * s);
  ctx.lineTo(26 * s, 6 * s);
  ctx.lineTo(32 * s, 12 * s);
  ctx.lineTo(32 * s, 34 * s);
  ctx.lineTo(10 * s, 34 * s);
  ctx.closePath();
  ctx.fill();
  ctx.stroke();

  // Folded corner
  const pageGrad = ctx.createLinearGradient(26 * s, 6 * s, 26 * s, 12 * s);
  pageGrad.addColorStop(0, theme.pageTop);
  pageGrad.addColorStop(1, theme.pageBot);

  ctx.fillStyle = pageGrad;
  ctx.beginPath();
  ctx.moveTo(26 * s, 6 * s);
  ctx.lineTo(26 * s, 12 * s);
  ctx.lineTo(32 * s, 12 * s);
  ctx.closePath();
  ctx.fill();
  ctx.stroke();

  // Zip teeth (for fb2zip)
  if (ft.zip) {
    ctx.fillStyle = theme.zipColor;
    for (let y = 7; y <= 16; y += 3) {
      roundRect(ctx, 18 * s, y * s, 3 * s, 2 * s, 0.5 * s);
      ctx.fill();
    }
  }

  // Label badge
  const badgeY = 22 * s;
  const badgeH = 9 * s;
  const badgeX = 12 * s;
  const badgeW = 18 * s;
  const badgeR = 2 * s;

  ctx.fillStyle = ft.color;
  roundRect(ctx, badgeX, badgeY, badgeW, badgeH, badgeR);
  ctx.fill();

  // Label text
  ctx.fillStyle = '#FFFFFF';
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';

  const fontSize = ft.label.length > 3 ? 5.5 * s : 7 * s;
  ctx.font = `bold ${fontSize}px Arial, sans-serif`;
  ctx.fillText(ft.label, 21 * s, badgeY + badgeH / 2 + 0.5 * s);
}

function roundRect(ctx, x, y, w, h, r) {
  ctx.beginPath();
  ctx.moveTo(x + r, y);
  ctx.lineTo(x + w - r, y);
  ctx.arcTo(x + w, y, x + w, y + r, r);
  ctx.lineTo(x + w, y + h - r);
  ctx.arcTo(x + w, y + h, x + w - r, y + h, r);
  ctx.lineTo(x + r, y + h);
  ctx.arcTo(x, y + h, x, y + h - r, r);
  ctx.lineTo(x, y + r);
  ctx.arcTo(x, y, x + r, y, r);
  ctx.closePath();
}

for (const [themeName, theme] of Object.entries(THEMES)) {
  const outDir = path.join(__dirname, themeName, 'png');
  if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });

  for (const ft of FILE_TYPES) {
    for (const size of SIZES) {
      const canvas = createCanvas(size, size);
      const ctx = canvas.getContext('2d');
      drawIcon(ctx, size, ft, theme);
      const outPath = path.join(outDir, `${ft.name}_${size}.png`);
      fs.writeFileSync(outPath, canvas.toBuffer('image/png'));
    }
    console.log(`Done: ${themeName}/${ft.name}`);
  }
}
console.log('All filetype icons generated.');
