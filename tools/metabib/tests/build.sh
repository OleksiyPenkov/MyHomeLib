#!/bin/bash
# Builds the MetabibTest harness (tools/metabib/tests/MetabibTest.dpr) with dcc64.
#
# unit_MetabibReader needs only the RTL plus unit_ZstdStream and
# unit_MHLArchiveHelpers, so the search path is far shorter than the lang
# harness's -- no VCL, no third-party components.
#
# Two Git Bash traps: unquoted backslashes are eaten before the compiler sees
# them (use forward slashes), and POSIX-looking arguments are rewritten into
# C:/Program Files/Git/... unless argument conversion is disabled.
export MSYS2_ARG_CONV_EXCL="*"
export MSYS_NO_PATHCONV=1
cd "D:/DelphiProjects/MyHomeLib" || exit 1

BDS="C:/Program Files (x86)/Embarcadero/Studio/37.0"
OUT="${METABIBTEST_OUT:-$TEMP/metabibtest}"
mkdir -p "$OUT/dcu"

DIRS="Program/Units Components/MHLComponents"

NS="System;Winapi;Xml;Data;System.Win;Xml.Win;Data.Win"

UNITS="$BDS/lib/Win64/release"
for d in $DIRS; do UNITS="$UNITS;$d"; done

"$BDS/bin/dcc64.exe" -B -E"$OUT" -N0"$OUT/dcu" -U"$UNITS" -NS"$NS" \
  tools/metabib/tests/MetabibTest.dpr 2>&1 | grep -Ev "^(Embarcadero|Copyright)|H2443" | tail -8
