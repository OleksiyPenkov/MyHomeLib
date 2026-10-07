param(
    [ValidateSet('Win64', 'Win32')][string]$Platform = 'Win64',
    [ValidateSet('all', 'metadata', 'worker', 'ui')][string]$Case = 'all',
    [switch]$KeepArtifacts
)
$Case = $Case.ToLowerInvariant()
$ErrorActionPreference = 'Stop'
if (-not $env:BDS -or -not $env:BDSCOMMONDIR) {
    throw 'Set BDS and BDSCOMMONDIR for RAD Studio 37.0.'
}
$Root = (Resolve-Path (Join-Path $PSScriptRoot '../../..')).Path
$RunDir = Join-Path ([IO.Path]::GetTempPath()) ('mhl-export-tests-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $RunDir, (Join-Path $RunDir 'dcu') | Out-Null
$Is64 = $Platform -eq 'Win64'
$Bin = Join-Path $Root $(if ($Is64) { 'Program/OUT/Bin64' } else { 'Program/OUT/BIN' })
$Compiler = Join-Path $env:BDS $(if ($Is64) { 'bin/dcc64.exe' } else { 'bin/dcc32.exe' })
$ComponentSource = Join-Path $Root 'Components/MHLComponents'
$Raize = Join-Path $env:BDSCOMMONDIR 'CatalogRepository/BonusKSVC/8.0.3'
$UnitDirs = @(
    (Join-Path $env:BDS "lib/$Platform/release"),
    (Join-Path $Raize "Lib/RX13/$Platform"),
    $ComponentSource,
    (Join-Path $Raize 'Source')
)
foreach ($Dir in @('Units', 'DataModules', 'Forms', 'Forms/Editors', 'ImportImpl', 'DAO', 'DAO/SQLite', 'DAO/SQLite/Lib', 'DwnldImpl', 'UtilsImpl', 'Wizards/NewCollection', 'Wizards/Base')) {
    $UnitDirs += Join-Path $Root "Program/$Dir"
}
$UnitDirs += Join-Path $Root $(if ($Is64) { 'Program/OUT/Units64' } else { 'Program/OUT/Units' })
$Namespaces = 'Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell;System;Xml;Data;Datasnap;Web;Soap;Winapi;Bde;Xml.Win;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win'
$OldPath = $env:PATH
try {
    Push-Location $Root
    try {
        $Sources = @()
        if ($Case -ne 'ui') { $Sources += 'tools/metabib/tests/MetabibExportTest.dpr' }
        if ($Case -eq 'all' -or $Case -eq 'ui') { $Sources += 'tools/metabib/tests/GroupExportUITest.dpr' }
        foreach ($Source in $Sources) {
            & $Compiler -B "-E$RunDir" "-N0$(Join-Path $RunDir 'dcu')" "-U$($UnitDirs -join ';')" "-I$ComponentSource" "-R$ComponentSource" "-NS$Namespaces" $Source
            if ($LASTEXITCODE -ne 0) { throw "Export test build failed: $Source" }
        }
    } finally { Pop-Location }
    foreach ($Name in @('sqlite3.dll', 'libzstd.dll', 'libeay32.dll', 'ssleay32.dll')) {
        Copy-Item (Join-Path $Bin $Name) $RunDir
    }
    Copy-Item (Join-Path $Bin 'Icons') $RunDir -Recurse
    Copy-Item (Join-Path $Bin '*.glst') $RunDir
    New-Item -ItemType File -Path (Join-Path $RunDir 'uselocaldata') | Out-Null
    @'
[SYSTEM]
CheckUpdates=0
CheckLibrusecUpdates=0
[INTERFACE]
Locale=uk
[BEHAVIOR]
IgnoreAbsentArchives=1
'@ | Set-Content (Join-Path $RunDir 'myhomelib2.ini') -Encoding UTF8
    $BdsBin = if ($Is64) { 'bin64' } else { 'bin' }
    $env:PATH = "$env:SystemRoot\System32;$(Join-Path $env:BDS $BdsBin);$(Join-Path $env:BDSCOMMONDIR "Bpl/$Platform");$OldPath"
    if ($Case -ne 'ui') {
        & "$env:SystemRoot\System32\cmd.exe" /d /c (Join-Path $RunDir 'MetabibExportTest.exe') $Case
        if ($LASTEXITCODE -ne 0) { throw 'Export regression failed.' }
    }
    if ($Case -eq 'all' -or $Case -eq 'ui') {
        & "$env:SystemRoot\System32\cmd.exe" /d /c (Join-Path $RunDir 'GroupExportUITest.exe')
        if ($LASTEXITCODE -ne 0) { throw 'Group export UI regression failed.' }
    }
    Write-Output "PASS export regressions ($Platform)"
} finally {
    $env:PATH = $OldPath
    if ($KeepArtifacts) {
        Write-Output "Artifacts: $RunDir"
    } else {
        Remove-Item $RunDir -Recurse -Force
    }
}
