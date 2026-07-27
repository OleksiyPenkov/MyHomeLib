/*
 * Builds the MyHomeLib application icon (.ico) from app-icon.svg and
 * app-icon-small.svg.
 *
 *   node make_app_icon.js
 *
 * Writes ..\home-lib.ico (referenced by MyhomeLib.dproj as Icon_MainIcon)
 * and ..\..\..\Installer\Images\Setup.ico.
 *
 * It also rewrites the RT_ICON / RT_GROUP_ICON resources inside
 * ..\..\MyhomeLib.res. Only the IDE regenerates that .res from Icon_MainIcon -
 * a command-line msbuild leaves it alone, so without this step the exe keeps
 * whatever icon it was last built with. Every other resource in the file
 * (VERSION, MANIFEST, PLATFORMTARGETS) is carried over untouched.
 *
 * Sizes 40 and up use the full artwork; 32 and below use the simplified cut -
 * below 40 the carcass and the spines start to merge into each other.
 * 256 and 128 are stored PNG-compressed (Vista+); everything smaller is a
 * classic 32bpp BMP entry so the icon still resolves in older shells and in
 * VCL's TIcon.
 */
const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

const HERE = __dirname;
const FULL = path.join(HERE, 'app-icon.svg');
const SMALL = path.join(HERE, 'app-icon-small.svg');

const TARGETS = [
  path.join(HERE, '..', 'home-lib.ico'),
  path.join(HERE, '..', '..', '..', 'Installer', 'Images', 'Setup.ico'),
];

// size -> [source svg, store as png]
const PLAN = [
  [256, FULL, true],
  [128, FULL, true],
  [64, FULL, false],
  [48, FULL, false],
  [40, FULL, false],
  [32, SMALL, false],
  [24, SMALL, false],
  [20, SMALL, false],
  [16, SMALL, false],
];

/* A 32bpp ICO image is a BITMAPINFOHEADER whose biHeight is doubled, followed
   by bottom-up BGRA rows and a 1bpp AND mask. The mask is unused for 32bpp
   images but Windows still expects the bytes to be there. */
function bmpEntry(rgba, w, h) {
  const header = Buffer.alloc(40);
  header.writeUInt32LE(40, 0);
  header.writeInt32LE(w, 4);
  header.writeInt32LE(h * 2, 8);
  header.writeUInt16LE(1, 12);
  header.writeUInt16LE(32, 14);
  header.writeUInt32LE(0, 16); // BI_RGB
  header.writeUInt32LE(w * h * 4, 20);

  const xor = Buffer.alloc(w * h * 4);
  for (let y = 0; y < h; y++) {
    for (let x = 0; x < w; x++) {
      const s = (y * w + x) * 4;
      const d = ((h - 1 - y) * w + x) * 4;
      xor[d] = rgba[s + 2];
      xor[d + 1] = rgba[s + 1];
      xor[d + 2] = rgba[s];
      xor[d + 3] = rgba[s + 3];
    }
  }

  const maskStride = ((w + 31) >> 5) * 4; // 1bpp rows padded to 32 bits
  const and = Buffer.alloc(maskStride * h); // all zero: every pixel opaque
  return Buffer.concat([header, xor, and]);
}

function buildIco(images) {
  const count = images.length;
  const dir = Buffer.alloc(6 + count * 16);
  dir.writeUInt16LE(0, 0);
  dir.writeUInt16LE(1, 2); // 1 = icon
  dir.writeUInt16LE(count, 4);

  let offset = dir.length;
  images.forEach((img, i) => {
    const e = 6 + i * 16;
    dir.writeUInt8(img.size >= 256 ? 0 : img.size, e); // 0 means 256
    dir.writeUInt8(img.size >= 256 ? 0 : img.size, e + 1);
    dir.writeUInt8(0, e + 2); // palette size
    dir.writeUInt8(0, e + 3); // reserved
    dir.writeUInt16LE(1, e + 4); // planes
    dir.writeUInt16LE(32, e + 6); // bpp
    dir.writeUInt32LE(img.data.length, e + 8);
    dir.writeUInt32LE(offset, e + 12);
    offset += img.data.length;
  });

  return Buffer.concat([dir, ...images.map((i) => i.data)]);
}

/* ---------------------------------------------------------------- .res ---- */

const RT_ICON = 3;
const RT_GROUP_ICON = 14;
const LANG_EN_US = 0x409;

function align4(n) {
  return (4 - (n % 4)) % 4;
}

// Walk a Win32 .RES file into a flat list of records.
function parseRes(buf) {
  const recs = [];
  let p = 0;
  const readName = (off) => {
    if (buf.readUInt16LE(off) === 0xffff) return [buf.readUInt16LE(off + 2), off + 4];
    let s = '';
    let o = off;
    for (;;) {
      const c = buf.readUInt16LE(o);
      o += 2;
      if (c === 0) break;
      s += String.fromCharCode(c);
    }
    return [s, o];
  };
  while (p + 8 <= buf.length) {
    const dataSize = buf.readUInt32LE(p);
    const hdrSize = buf.readUInt32LE(p + 4);
    if (hdrSize < 32) break;
    const [type, o1] = readName(p + 8);
    const [name] = readName(o1);
    const total = hdrSize + dataSize + align4(dataSize);
    recs.push({ type, name, raw: buf.subarray(p, p + total) });
    p += total;
  }
  return recs;
}

// Emit one .RES record. Ordinal type/name are numbers, string names are strings.
function makeRes(type, name, data, memFlags) {
  const enc = (v) => {
    if (typeof v === 'number') {
      const b = Buffer.alloc(4);
      b.writeUInt16LE(0xffff, 0);
      b.writeUInt16LE(v, 2);
      return b;
    }
    const b = Buffer.alloc((v.length + 1) * 2);
    for (let i = 0; i < v.length; i++) b.writeUInt16LE(v.charCodeAt(i), i * 2);
    return b;
  };
  const ident = Buffer.concat([enc(type), enc(name)]);
  const identPad = Buffer.alloc(align4(8 + ident.length));
  const tail = Buffer.alloc(16);
  tail.writeUInt32LE(0, 0); // DataVersion
  tail.writeUInt16LE(memFlags, 4);
  tail.writeUInt16LE(LANG_EN_US, 6);
  tail.writeUInt32LE(0, 8); // Version
  tail.writeUInt32LE(0, 12); // Characteristics

  const hdrSize = 8 + ident.length + identPad.length + tail.length;
  const size = Buffer.alloc(8);
  size.writeUInt32LE(data.length, 0);
  size.writeUInt32LE(hdrSize, 4);
  return Buffer.concat([size, ident, identPad, tail, data, Buffer.alloc(align4(data.length))]);
}

/* RT_GROUP_ICON is the ICONDIR with each entry's 4-byte file offset replaced
   by the 2-byte resource id of the matching RT_ICON. */
function groupIcon(images) {
  const b = Buffer.alloc(6 + images.length * 14);
  b.writeUInt16LE(0, 0);
  b.writeUInt16LE(1, 2);
  b.writeUInt16LE(images.length, 4);
  images.forEach((img, i) => {
    const e = 6 + i * 14;
    b.writeUInt8(img.size >= 256 ? 0 : img.size, e);
    b.writeUInt8(img.size >= 256 ? 0 : img.size, e + 1);
    b.writeUInt8(0, e + 2);
    b.writeUInt8(0, e + 3);
    b.writeUInt16LE(1, e + 4);
    b.writeUInt16LE(32, e + 6);
    b.writeUInt32LE(img.data.length, e + 8);
    b.writeUInt16LE(i + 1, e + 12); // RT_ICON resource id
  });
  return b;
}

function patchRes(resPath, images) {
  const recs = parseRes(fs.readFileSync(resPath));
  const out = [];
  let iconsWritten = false;
  for (const r of recs) {
    if (r.type === RT_ICON) {
      if (!iconsWritten) {
        images.forEach((img, i) => out.push(makeRes(RT_ICON, i + 1, img.data, 0x1010)));
        iconsWritten = true;
      }
      continue; // drop the old RT_ICON records
    }
    if (r.type === RT_GROUP_ICON) {
      out.push(makeRes(RT_GROUP_ICON, r.name, groupIcon(images), 0x1030));
      continue;
    }
    out.push(r.raw);
  }
  if (!iconsWritten) throw new Error(`no RT_ICON resources found in ${resPath}`);
  fs.writeFileSync(resPath, Buffer.concat(out));
  return out.length;
}

/* ---------------------------------------------------------------- .dfm ---- */

/* frm_main carries its own 16x16 Icon.Data - that one wins in the title bar,
   so it has to be replaced too. This is a targeted rewrite of the hex block
   only; never re-save frm_main.dfm from the IDE designer to do this, that
   reorders toolbar actions and Rz spacing. */
function patchDfmIcon(dfmPath, image) {
  const lines = fs.readFileSync(dfmPath, 'utf8').split(/\r?\n/);
  const start = lines.findIndex((l) => l.startsWith('  Icon.Data = {'));
  if (start < 0) throw new Error(`no Icon.Data in ${dfmPath}`);
  let end = start;
  while (!lines[end].trimEnd().endsWith('}')) end++;

  const hex = buildIco([image]).toString('hex').toUpperCase();
  const body = [];
  for (let i = 0; i < hex.length; i += 64) body.push('    ' + hex.slice(i, i + 64));
  body[body.length - 1] += '}';

  lines.splice(start, end - start + 1, '  Icon.Data = {', ...body);
  fs.writeFileSync(dfmPath, lines.join('\r\n'));
  return hex.length / 2;
}

/* ------------------------------------------------------------------------- */

(async () => {
  const images = [];
  for (const [size, src, asPng] of PLAN) {
    // Rasterise from the SVG at the target size rather than downscaling a big
    // bitmap - the navy outline stays crisp that way.
    const pipe = sharp(src, { density: Math.ceil((size / 256) * 96 * 8) })
      .resize(size, size, { fit: 'contain', background: { r: 0, g: 0, b: 0, alpha: 0 } });

    if (asPng) {
      images.push({ size, data: await pipe.png({ compressionLevel: 9 }).toBuffer() });
    } else {
      const { data } = await pipe.raw().toBuffer({ resolveWithObject: true });
      images.push({ size, data: bmpEntry(data, size, size) });
    }
    console.log(`  ${size}x${size}  ${asPng ? 'png' : 'bmp'}  ${path.basename(src)}`);
  }

  const ico = buildIco(images);
  const root = path.join(HERE, '..', '..', '..');
  for (const t of TARGETS) {
    fs.writeFileSync(t, ico);
    console.log(`wrote ${path.relative(root, t)}  ${ico.length} bytes`);
  }

  const res = path.join(HERE, '..', '..', 'MyhomeLib.res');
  const n = patchRes(res, images);
  console.log(`wrote ${path.relative(root, res)}  ${n} resources`);

  const dfm = path.join(HERE, '..', '..', 'Forms', 'frm_main.dfm');
  const bytes = patchDfmIcon(dfm, images.find((i) => i.size === 16));
  console.log(`wrote ${path.relative(root, dfm)}  Icon.Data ${bytes} bytes`);
})();
