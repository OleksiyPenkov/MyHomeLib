program LangTest;

{$APPTYPE CONSOLE}

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
  unit_Localization;

var
  Report, LocaleObj, Translations: TJSONObject;
  Arr: TJSONArray;
  Probes: TJSONValue;
  Info: TLocaleInfo;
  I: Integer;
  ProbeFile, Source: string;
  Active: Boolean;
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

    TFile.WriteAllText(ParamStr(ParamCount), Report.ToJSON, TEncoding.UTF8);
  finally
    Report.Free;
  end;
end.
