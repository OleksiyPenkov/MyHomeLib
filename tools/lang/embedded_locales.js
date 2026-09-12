'use strict';

// The locales linked into the exe as RCDATA. One list, required by both the
// script that embeds them (embed.js) and the script that signs them
// (sign_shipped.js) -- they must never disagree, or a build embeds a catalog
// nobody signed and the language silently vanishes from the menu.
//
// 'uk' is deliberately absent. It is the language the source is written in, so
// its catalog is pure identity: every entry has target === source, the loader
// drops them all, and the index comes out empty. The menu pins Ukrainian from a
// constant rather than from a catalog, so embedding it bought nothing even
// before signatures -- and sign.js rightly refuses a catalog with no usable
// translations, so it cannot be signed either.
//
// The Ukrainian spellings ShippedRenderings needs still come from en and bg:
// catalogs are keyed by source text, and every source in them is Ukrainian.
module.exports = { EMBEDDED: ['en', 'bg'] };
