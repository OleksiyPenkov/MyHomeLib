$ErrorActionPreference = 'Stop'
if (-not $env:BDS -or -not $env:BDSCOMMONDIR) {
    throw 'Set BDS and BDSCOMMONDIR for RAD Studio 37.0.'
}
$Root = (Resolve-Path (Join-Path $PSScriptRoot '../../..')).Path
$RunDir = Join-Path ([IO.Path]::GetTempPath()) ('mhl-view-tests-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $RunDir, (Join-Path $RunDir 'dcu') | Out-Null
$Bin = Join-Path $Root 'Program/OUT/Bin64'
$ComponentSource = Join-Path $Root 'Components/MHLComponents'
$Raize = Join-Path $env:BDSCOMMONDIR 'CatalogRepository/BonusKSVC/8.0.3'
$UnitDirs = @(
    (Join-Path $env:BDS 'lib/Win64/release'),
    (Join-Path $Root 'Program/OUT/Units64'),
    (Join-Path $Raize 'Lib/RX13/Win64'),
    $ComponentSource,
    (Join-Path $Raize 'Source'),
    (Join-Path $Root 'Program/Units'),
    (Join-Path $Root 'Program/DataModules'),
    (Join-Path $Root 'Program/Forms'),
    (Join-Path $Root 'Program/Forms/Editors'),
    (Join-Path $Root 'Program/ImportImpl'),
    (Join-Path $Root 'Program/DAO'),
    (Join-Path $Root 'Program/DAO/SQLite'),
    (Join-Path $Root 'Program/DAO/SQLite/Lib'),
    (Join-Path $Root 'Program/DwnldImpl'),
    (Join-Path $Root 'Program/UtilsImpl'),
    (Join-Path $Root 'Program/Wizards/NewCollection'),
    (Join-Path $Root 'Program/Wizards/Base')
)
$Namespaces = 'Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell;System;Xml;Data;Datasnap;Web;Soap;Winapi;Bde;Xml.Win;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win'
$Failed = $false
try {
    Push-Location $Root
    try {
        foreach ($Source in @('tools/ui/tests/CollectionViewsTest.dpr', 'tools/metabib/tests/GenreRegistryTest.dpr', 'tools/metabib/tests/MetabibImportTest.dpr')) {
            & (Join-Path $env:BDS 'bin/dcc64.exe') "-E$RunDir" "-N0$(Join-Path $RunDir 'dcu')" "-U$($UnitDirs -join ';')" "-I$ComponentSource" "-R$ComponentSource" "-NS$Namespaces" $Source
            if ($LASTEXITCODE -ne 0) { throw "Native test build failed: $Source" }
        }
    } finally {
        Pop-Location
    }
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
Locale=en
ActivePage=0
[BEHAVIOR]
CoverPanel=0
ShowCover=0
ShowAnnotation=0
AutoLoadReview=0
IgnoreAbsentArchives=1
'@ | Set-Content (Join-Path $RunDir 'myhomelib2.ini') -Encoding UTF8
    $OldPath = $env:PATH
    try {
        $env:PATH = "$env:SystemRoot\System32;$(Join-Path $env:BDS 'bin64');$(Join-Path $env:BDSCOMMONDIR 'Bpl/Win64');$OldPath"
        foreach ($Mode in @('genre-order', '', 'language-isolation', 'favorites-add', 'genre-link', 'source-genres')) {
            $Data = Join-Path $RunDir 'Data'
            if (Test-Path $Data) { Remove-Item $Data -Recurse -Force }
            & "$env:SystemRoot\System32\cmd.exe" /d /c (Join-Path $RunDir 'CollectionViewsTest.exe') $Mode
            if ($LASTEXITCODE -ne 0) { $Failed = $true }
        }
        & "$env:SystemRoot\System32\cmd.exe" /d /c (Join-Path $RunDir 'GenreRegistryTest.exe')
        if ($LASTEXITCODE -ne 0) { $Failed = $true }
        $Data = Join-Path $RunDir 'Data'
        if (Test-Path $Data) { Remove-Item $Data -Recurse -Force }
        & "$env:SystemRoot\System32\cmd.exe" /d /c (Join-Path $RunDir 'MetabibImportTest.exe')
        if ($LASTEXITCODE -ne 0) { $Failed = $true }
        if ($Failed) { throw 'Collection view regression failed.' }
    } finally {
        $env:PATH = $OldPath
    }
} finally {
    Remove-Item $RunDir -Recurse -Force
}
