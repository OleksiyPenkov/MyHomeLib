/*
 * Builds preview-app-icon.html - a self-contained page showing every size
 * actually stored in home-lib.ico.
 *
 *   node make_app_icon_preview.js
 *
 * Run it after make_app_icon.js. It reads the packed .ico rather than the
 * SVGs, so what the page shows is what Windows will show: the same
 * rasterisation, the same cut per size.
 *
 * Every entry is embedded as a data URI, so the page can be opened straight
 * from disk with no server and nothing beside it.
 */
const fs = require('fs');
const path = require('path');

const HERE = __dirname;
const ICO = path.join(HERE, '..', 'home-lib.ico');
const OUT = path.join(HERE, 'preview-app-icon.html');

// Which SVG each size is cut from - mirrors PLAN in make_app_icon.js.
const CUT = { 256: 'full', 128: 'full', 64: 'full', 48: 'full', 40: 'mid', 32: 'mid', 24: 'small', 20: 'small', 16: 'small' };

/* A 32bpp ICO image is a BITMAPINFOHEADER with a doubled biHeight followed by
   bottom-up BGRA rows. Repack one as a PNG so the browser can show it. */
function bmpToPng(data, w, h) {
  const hdr = data.readUInt32LE(0);
  const stride = w * 4;
  const raw = Buffer.alloc((w * 4 + 1) * h);
  for (let y = 0; y < h; y++) {
    raw[y * (w * 4 + 1)] = 0; // filter: none
    for (let x = 0; x < w; x++) {
      const s = hdr + (h - 1 - y) * stride + x * 4;
      const d = y * (w * 4 + 1) + 1 + x * 4;
      raw[d] = data[s + 2];
      raw[d + 1] = data[s + 1];
      raw[d + 2] = data[s];
      raw[d + 3] = data[s + 3];
    }
  }
  return png(w, h, raw);
}

function crc32(buf) {
  let c, crc = 0xffffffff;
  for (let n = 0; n < buf.length; n++) {
    c = (crc ^ buf[n]) & 0xff;
    for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
    crc = c ^ (crc >>> 8);
  }
  return (crc ^ 0xffffffff) >>> 0;
}

function chunk(type, data) {
  const len = Buffer.alloc(4);
  len.writeUInt32BE(data.length, 0);
  const body = Buffer.concat([Buffer.from(type, 'ascii'), data]);
  const crc = Buffer.alloc(4);
  crc.writeUInt32BE(crc32(body), 0);
  return Buffer.concat([len, body, crc]);
}

function png(w, h, raw) {
  const ihdr = Buffer.alloc(13);
  ihdr.writeUInt32BE(w, 0);
  ihdr.writeUInt32BE(h, 4);
  ihdr[8] = 8; // bit depth
  ihdr[9] = 6; // colour type: RGBA
  return Buffer.concat([
    Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]),
    chunk('IHDR', ihdr),
    chunk('IDAT', require('zlib').deflateSync(raw, { level: 9 })),
    chunk('IEND', Buffer.alloc(0)),
  ]);
}

function readIco(file) {
  const buf = fs.readFileSync(file);
  const out = [];
  for (let i = 0, n = buf.readUInt16LE(4); i < n; i++) {
    const e = 6 + i * 16;
    const size = buf.readUInt8(e) || 256;
    const off = buf.readUInt32LE(e + 12);
    const data = buf.subarray(off, off + buf.readUInt32LE(e + 8));
    const isPng = data.readUInt32BE(0) === 0x89504e47;
    out.push({ size, png: isPng ? data : bmpToPng(data, size, size), stored: isPng ? 'png' : 'bmp' });
  }
  return out.sort((a, b) => b.size - a.size);
}

/* ------------------------------------------------------------------------- */

const entries = readIco(ICO);
const uri = (e) => `data:image/png;base64,${e.png.toString('base64')}`;

const native = entries
  .filter((e) => e.size <= 64)
  .map(
    (e) => `      <figure class="cell">
        <div class="swatch"><img src="${uri(e)}" width="${e.size}" height="${e.size}" alt="${e.size}px"></div>
        <figcaption>${e.size}<span class="cut ${CUT[e.size]}">${CUT[e.size]}</span></figcaption>
      </figure>`
  )
  .join('\n');

const zoomed = entries
  .filter((e) => e.size <= 48)
  .map(
    (e) => `      <figure class="cell">
        <div class="swatch zoom"><img src="${uri(e)}" style="width:${e.size * Math.floor(160 / e.size)}px" alt="${e.size}px magnified"></div>
        <figcaption>${e.size}<span class="cut ${CUT[e.size]}">${CUT[e.size]}</span></figcaption>
      </figure>`
  )
  .join('\n');

const hero = entries
  .filter((e) => e.size >= 128)
  .map((e) => `      <figure class="cell"><div class="swatch"><img src="${uri(e)}" width="${Math.min(e.size, 200)}" alt="${e.size}px"></div><figcaption>${e.size}<span class="cut full">full</span></figcaption></figure>`)
  .join('\n');

const html = `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>MyHomeLib Application Icon</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Segoe UI', system-ui, sans-serif; transition: background 0.3s, color 0.3s; }
  body.light { background: #f0f2f5; color: #1a1a2e; }
  body.dark { background: #1a1f2e; color: #d0d8e0; }

  .header {
    display: flex; align-items: center; justify-content: space-between;
    padding: 20px 32px; border-bottom: 1px solid rgba(128,128,128,0.2);
  }
  .header h1 { font-size: 22px; font-weight: 600; }
  .header .subtitle { font-size: 13px; opacity: 0.6; margin-top: 2px; }

  .toggle-group { display: flex; gap: 4px; background: rgba(128,128,128,0.15); border-radius: 8px; padding: 3px; }
  .toggle-btn {
    padding: 6px 16px; border: none; border-radius: 6px; cursor: pointer;
    font-size: 13px; font-weight: 500; background: transparent; color: inherit; transition: all 0.2s;
  }
  .toggle-btn.active { background: #3CB4DC; color: #fff; }

  .section { padding: 20px 32px 28px; }
  .section h2 { font-size: 15px; font-weight: 600; margin-bottom: 4px; opacity: 0.8; text-transform: uppercase; letter-spacing: 0.5px; }
  .section p { font-size: 13px; opacity: 0.55; margin-bottom: 16px; max-width: 62ch; line-height: 1.5; }

  .row { display: flex; flex-wrap: wrap; gap: 14px; align-items: flex-end; }
  .cell { text-align: center; }
  .swatch {
    display: flex; align-items: center; justify-content: center;
    min-width: 84px; min-height: 84px; padding: 12px;
    border-radius: 10px; border: 1px solid rgba(128,128,128,0.22);
  }
  .swatch.zoom { min-width: 184px; min-height: 184px; }
  .swatch img { image-rendering: pixelated; display: block; }
  body.light .swatch { background: #ffffff; }
  body.dark .swatch { background: #202020; }

  figcaption { font-size: 12px; opacity: 0.7; margin-top: 7px; display: flex; gap: 6px; justify-content: center; align-items: center; }
  .cut { font-size: 10px; padding: 1px 6px; border-radius: 999px; font-weight: 600; letter-spacing: 0.3px; }
  .cut.full  { background: rgba(60,180,220,0.18); color: #2C93B4; }
  .cut.mid   { background: rgba(232,185,60,0.20); color: #9C7A14; }
  .cut.small { background: rgba(232,98,46,0.18);  color: #C4501F; }
  body.dark .cut.full  { color: #6FD0EE; }
  body.dark .cut.mid   { color: #E8B93C; }
  body.dark .cut.small { color: #F0865A; }

  /* A strip at true 1:1 against the two backgrounds Windows actually uses. */
  .bar { display: flex; align-items: center; gap: 18px; padding: 10px 18px; border-radius: 8px; width: fit-content; }
  .bar.dark  { background: #202020; }
  .bar.light { background: #f3f3f3; border: 1px solid rgba(128,128,128,0.25); }
  .bar img { image-rendering: pixelated; }
  .bar-label { font-size: 11px; opacity: 0.5; margin: 0 0 6px; }

  .foot { padding: 0 32px 32px; font-size: 12px; opacity: 0.5; line-height: 1.6; }
  code { font-family: Consolas, monospace; font-size: 11.5px; background: rgba(128,128,128,0.15); padding: 1px 5px; border-radius: 4px; }
</style>
</head>
<body class="light">

<div class="header">
  <div>
    <h1>MyHomeLib Application Icon</h1>
    <div class="subtitle">${entries.length} sizes, read back out of home-lib.ico &mdash; not re-rendered from the SVGs</div>
  </div>
  <div class="toggle-group">
    <button class="toggle-btn active" onclick="setTheme('light')">Light</button>
    <button class="toggle-btn" onclick="setTheme('dark')">Dark</button>
  </div>
</div>

<div class="section">
  <h2>Actual size</h2>
  <p>Each entry at 1:1. This is the only view that tells you whether a size works &mdash; magnified pixels always look better than they read.</p>
  <div class="row">
${native}
  </div>
</div>

<div class="section">
  <h2>In context, 1:1</h2>
  <p>The sizes Windows picks for the taskbar, the title bar and Explorer lists, on the two backgrounds it puts them on.</p>
  <p class="bar-label">Dark taskbar &mdash; the Windows 11 default</p>
  <div class="bar dark">
${entries.filter((e) => e.size <= 40).map((e) => `    <img src="${uri(e)}" width="${e.size}" height="${e.size}" alt="${e.size}px">`).join('\n')}
  </div>
  <p class="bar-label" style="margin-top:16px">Light taskbar / Explorer</p>
  <div class="bar light">
${entries.filter((e) => e.size <= 40).map((e) => `    <img src="${uri(e)}" width="${e.size}" height="${e.size}" alt="${e.size}px">`).join('\n')}
  </div>
</div>

<div class="section">
  <h2>Magnified</h2>
  <p>Nearest-neighbour, so every pixel decision is visible. Watch the bezel: at 16 it has to survive as a solid ring, which is why the small cut widens the band instead of thickening the outline.</p>
  <div class="row">
${zoomed}
  </div>
</div>

<div class="section">
  <h2>Large</h2>
  <p>Stored PNG-compressed. Used by Explorer's large icon views and by the installer.</p>
  <div class="row">
${hero}
  </div>
</div>

<div class="foot">
  Generated by <code>make_app_icon_preview.js</code> from <code>home-lib.ico</code>.
  Rebuild the icon with <code>node make_app_icon.js</code>, then this page with <code>node make_app_icon_preview.js</code>.
</div>

<script>
  function setTheme(t) {
    document.body.className = t;
    document.querySelectorAll('.toggle-btn').forEach(function (b) {
      b.classList.toggle('active', b.textContent.toLowerCase() === t);
    });
  }
</script>
</body>
</html>
`;

fs.writeFileSync(OUT, html);
console.log(`wrote ${path.relative(path.join(HERE, '..', '..', '..'), OUT)}  ${(html.length / 1024).toFixed(1)} KB, ${entries.length} sizes`);
