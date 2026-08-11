# Language catalog tooling

Ukrainian is the source language and is compiled into the exe as the
resourcestrings and DFM literals themselves. English ships as an embedded
catalog. Any other language is a community catalog and must be signed.

## Where the catalogs live

`Program/Lang/` is **not** part of this repository — it is gitignored, and it
holds a clone of a separate repository:

```
cd Program
git clone https://gitee.com/aps_tech/mhl-language.git Lang
```

Git does not descend into an ignored directory, so the nested clone is
invisible to this repository: no submodule, no `.gitmodules`, nothing to keep
in sync. The tooling all resolves `Program/Lang` and needs no configuration.

Without it the build still succeeds and produces a **Ukrainian-only** exe —
`embed.js` reports `no catalogs` and links nothing. That is by design, so a
contributor's first build never fails, but it does mean a build without the
clone silently ships one language. Check `embed.js`'s line in the build output
if English is missing from a build you expected it in.

Two consequences worth knowing before they bite:

- **`git clean -xdf` in this repository deletes the entire clone**, unpushed
  commits included. Ignored files are exactly what that command removes.
- **A git worktree will not have it.** Ignored files are not copied into a
  worktree, so a worktree build is Ukrainian-only until you clone there too.

## Regenerating the catalogs

```
msbuild ... /p:DCC_OutputDRCFile=true      # MyHomeLib.drc must be fresh
node tools/lang/extract.js
node tools/lang/check_lang.js
```

`extract.js` only ever emits the locales in its `LOCALES` list. Russian is not
in it, by decision — see
`docs/superpowers/specs/2026-08-11-signed-lang-catalogs-design.md`.

Catalog changes are commits in the `mhl-language` repository, not this one.
Push them there — `git status` here will never remind you, because it cannot
see them.

## How a catalog reaches the running app

| Locale | How it travels | Verified |
| --- | --- | --- |
| `uk`, `en` | RCDATA resources in the exe, linked by `Program\embed_lang.cmd` before every build | Not needed — nothing outside the binary to trust |
| anything else | `Lang\<code>.json` + `Lang\<code>.json.sig` next to the exe | ECDSA P-256 against the key in `unit_LangSignature.pas` |

Embedded always wins. A `Lang\en.json` is ignored whether or not it is signed,
so there is no file a user can place that alters a language we ship. A
catalog's locale is what it **declares**, not what it is named, so renaming a
signed catalog into another slot does not work either.

## Accepting a community translation

1. Receive `<code>.json` from the translator and review it.
2. Put it in `Program/Lang/`.
3. `node tools/lang/sign.js Program/Lang/<code>.json`

   It refuses anything that would misbehave at runtime: a locale that does not
   match the filename, two targets for one source, no usable translations.
4. Send back the `.json` and `.json.sig` pair. Both go next to the exe in
   `Lang\`.

There is no way to load a catalog without a signature, and no debug bypass.
A translator iterating on wording round-trips through the maintainer.

Note this is **not** security. The repository is public, so anyone can delete
the check and rebuild. What it removes is the casual path — "drop this file in
your Lang folder" becomes "run this patched exe from a stranger", and that
difference is the whole point.

## The signing key

`sign.js` reads the key from `$MHL_LANG_KEY`, falling back to
`%USERPROFILE%\.myhomelib\lang-signing-key.pem`. The maintainer's actual
location is deliberately not recorded here.

**Never in either repository** — not this one, and not `mhl-language` either.
Private is not the same as safe: a private repo still gets cloned to laptops
and pulled by tooling. Back it up offline instead.

The `.sig` files themselves are fine to keep in `mhl-language`. They are
derived artifacts, but storing them lets a second machine produce a release
without needing the key at all.

Losing or leaking the key means: `keygen.js` again, paste the new constant into
`Program/Units/unit_LangSignature.pas`, rebuild, and re-sign every community
catalog. Users on the previous build keep trusting the previous key until they
update.

## Tests

```
node tools/lang/tests/sign_tests.js
bash tools/lang/tests/build.sh
MHL_LANG_KEY=<key> node tools/lang/tests/loader_tests.js "$TEMP/langtest/LangTest.exe"
```

`LangTest.exe` is a console harness that drives the real loader against
throwaway app directories; it is in no dproj and `build.sh` compiles it with
`dcc64`. That script carries the whole unit search path by hand because
`dcc64` does not read the IDE's library path — if a new third-party dependency
is added to the app, `build.sh` needs the same directory added to its `LIBS`
list or the harness stops compiling.
