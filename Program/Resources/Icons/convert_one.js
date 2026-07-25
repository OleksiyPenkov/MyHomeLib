// convert_one.js — re-render only the named icons, so touching one SVG does not
// rewrite all 644 PNGs. Usage: node convert_one.js remove-from-group tree-mode
const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

const sizes = [16, 20, 24, 32, 40, 48, 64];
const names = process.argv.slice(2);
if (!names.length) { console.error('usage: node convert_one.js <icon-name>...'); process.exit(1); }

(async () => {
  for (const theme of ['Light', 'Dark']) {
    const outDir = path.join(__dirname, theme, 'png');
    if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });
    for (const name of names) {
      const svgPath = path.join(__dirname, theme, name + '.svg');
      if (!fs.existsSync(svgPath)) { console.error('missing ' + svgPath); process.exit(1); }
      const svgBuf = fs.readFileSync(svgPath);
      for (const size of sizes)
        await sharp(svgBuf).resize(size, size).png().toFile(path.join(outDir, name + '_' + size + '.png'));
      console.log(theme + '/' + name + ': ' + sizes.length + ' sizes');
    }
  }
})();
