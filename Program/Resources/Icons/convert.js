const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

// Render sizes: 16 for menus, 20 for 125% DPI, 24 for 150%, 32 for 200%, 40 for toolbar, 48 for toolbar at 125%
const sizes = [16, 20, 24, 32, 40, 48, 64];

async function convertFolder(theme) {
  const srcDir = path.join(__dirname, theme);
  const outDir = path.join(__dirname, theme, 'png');

  if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });

  const files = fs.readdirSync(srcDir).filter(f => f.endsWith('.svg'));
  console.log(theme + ': ' + files.length + ' SVG files');

  for (const file of files) {
    const name = path.basename(file, '.svg');
    const svgPath = path.join(srcDir, file);
    const svgBuf = fs.readFileSync(svgPath);

    for (const size of sizes) {
      const outPath = path.join(outDir, name + '_' + size + '.png');
      await sharp(svgBuf)
        .resize(size, size)
        .png()
        .toFile(outPath);
    }
  }
  console.log(theme + ': done');
}

(async () => {
  await convertFolder('Light');
  await convertFolder('Dark');
  console.log('All conversions complete');
})();
