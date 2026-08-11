program LangTest;

{$APPTYPE CONSOLE}

// The same embedded catalogs the application links, so the harness exercises
// the real embedded-vs-file precedence rather than a file-only subset.
// build.sh passes -R"Program" so this resolves.
{$R lang.res}

// Test harness for unit_Localization. Not shipped, not in any dproj.
//
// Usage:  LangTest.exe uselocaldata <report.json>
//
// Reads probe.json (a UTF-8 JSON array of source strings) from its own
// directory, runs InitLocalization, and writes a UTF-8 JSON report. The
// `uselocaldata` argument makes ResolveMHLPaths treat the exe's own directory
// as the work directory, so a scratch folder with its own myhomelib2.ini and
// Lang\ subfolder is a complete, isolated fixture.
//
// The report is written to a FILE rather than stdout on purpose: the probes
// and their translations are Cyrillic, and console output would go through
// the console code page.

uses
  System.SysUtils,
  System.IOUtils,
  System.JSON,
  Vcl.Forms,
  // No `in '...'` clauses: dcc64 resolves those against its working directory
  // rather than this file's, so they break the moment the compiler is invoked
  // from the repository root. The -U search path in build.sh finds them.
  unit_Settings,
  unit_Localization,
  unit_LangSignature;

var
  Report, LocaleObj, Translations, GenresObj: TJSONObject;
  Arr: TJSONArray;
  Probes: TJSONValue;
  Info: TLocaleInfo;
  I: Integer;
  ProbeFile, Source: string;
  Active: Boolean;
  TestSettings: TMHLSettings;
begin
  Report := TJSONObject.Create;
  try
    Active := InitLocalization;
    Report.AddPair('active', TJSONBool.Create(Active));
    Report.AddPair('status', LocalizationStatus);

    Arr := TJSONArray.Create;
    for Info in AvailableLocales do
    begin
      LocaleObj := TJSONObject.Create;
      LocaleObj.AddPair('code', Info.Code);
      LocaleObj.AddPair('name', Info.Name);
      Arr.AddElement(LocaleObj);
    end;
    Report.AddPair('locales', Arr);

    Translations := TJSONObject.Create;
    ProbeFile := ExtractFilePath(Application.ExeName) + 'probe.json';
    if FileExists(ProbeFile) then
    begin
      Probes := TJSONObject.ParseJSONValue(
        TFile.ReadAllText(ProbeFile, TEncoding.UTF8));
      try
        if Probes is TJSONArray then
          for I := 0 to TJSONArray(Probes).Count - 1 do
          begin
            Source := TJSONArray(Probes).Items[I].Value;
            Translations.AddPair(Source, TranslateText(Source));
          end;
      finally
        Probes.Free;
      end;
    end;
    Report.AddPair('translations', Translations);

    // Direct probe of the verifier, independent of whether the loader would
    // have chosen this catalog: verify.json is signed or not by the caller.
    Report.AddPair('verify', TJSONBool.Create(
      VerifyCatalogSignature(ExtractFilePath(Application.ExeName)
        + 'Lang' + PathDelim + 'verify.json')));

    // Which genre list the app would load for this locale. A dedicated
    // TMHLSettings instance, not the application's: the harness has no data
    // module. LoadSettings is the path the real app takes, so the locale
    // reaching SystemFileName is the one the fixture's ini actually set.
    //
    // File names only, never full paths -- the scratch directory differs on
    // every run, so a path would be untestable from Node.
    GenresObj := TJSONObject.Create;
    TestSettings := TMHLSettings.Create;
    try
      TestSettings.LoadSettings;
      GenresObj.AddPair('fb2',
        ExtractFileName(TestSettings.SystemFileName[sfGenresFB2]));
      GenresObj.AddPair('nonfb2',
        ExtractFileName(TestSettings.SystemFileName[sfGenresNonFB2]));
    finally
      TestSettings.Free;
    end;
    Report.AddPair('genres', GenresObj);

    TFile.WriteAllText(ParamStr(ParamCount), Report.ToJSON, TEncoding.UTF8);
  finally
    Report.Free;
  end;
end.
