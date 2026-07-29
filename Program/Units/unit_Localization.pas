unit unit_Localization;

interface

uses
  System.Classes;

const
  LANG_DIR_NAME = 'Lang';

function InitLocalization: Boolean;
procedure DoneLocalization;
function LocalizationActive: Boolean;
function LocalizationStatus: string;
function TranslateText(const AText: string): string;
procedure Localize(AComponent: TComponent);

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  System.IOUtils,
  System.JSON,
  System.Generics.Collections,
  System.IniFiles,
  System.TypInfo,
  unit_Settings;

var
  FIndex: TDictionary<string, string> = nil;
  FActive: Boolean = False;
  FStatus: string = '';

// unit_Logger is NOT usable here. TGlobalLogger is declared in that unit's
// implementation section, and the whole logger — GetLogger and ILogger
// included — is wrapped in {$IFDEF USELOGGER}, which MyhomeLib.dproj defines
// only for the Debug config. A Release build has no logging facility at all.
// The status therefore goes to the Windows debug channel, which is always
// available, and is kept in a variable the UI can surface later.
procedure SetStatus(const AMessage: string; const AExtra: string = '');
begin
  if AExtra <> '' then
    FStatus := AMessage + ' [' + AExtra + ']'
  else
    FStatus := AMessage;
  OutputDebugString(PChar('MyHomeLib ' + FStatus));
end;

function LocalizationStatus: string;
begin
  Result := FStatus;
end;

function TranslateText(const AText: string): string;
var
  V: string;
begin
  // Never pass Result to TryGetValue. Callers write `S := TranslateText(S)`,
  // where Result and AText both alias S; TryGetValue assigns Default(V) on a
  // miss, which would blank S before the fallback reads it back — returning
  // empty from the one routine whose job is to never return empty.
  if (FIndex <> nil) and FIndex.TryGetValue(AText, V) then
    Result := V
  else
    Result := AText;
end;

function LocalizationActive: Boolean;
begin
  Result := FActive;
end;

const
  // TextHint is a TEdit's grey placeholder text -- published, writable, and
  // visible to the user like Caption/Hint/Text, but its name doesn't fit the
  // obvious pattern, so it was left out when this list was first drawn up
  // and its strings never made it into a catalog.
  LOCALIZED_PROPS: array [0..3] of string = ('Caption', 'Hint', 'Text', 'TextHint');
  MAX_PERSISTENT_DEPTH = 4;

// True when AObject publishes an 'Items' property whose value is a TStrings.
// Used to keep TranslateProps off a list-like control's Text -- see the
// guard in TranslateProps for why.
function HasStringsItems(AObject: TObject): Boolean;
var
  Info: PPropInfo;
begin
  Info := GetPropInfo(AObject, 'Items', [tkClass]);
  Result := (Info <> nil) and (GetObjectProp(AObject, Info) is TStrings);
end;

// Rewrites one published string property in place, only when the current
// value actually has a translation.
procedure TranslateProps(AObject: TObject);
var
  I: Integer;
  Info: PPropInfo;
  Old, New: string;
begin
  if AObject = nil then
    Exit;
  for I := Low(LOCALIZED_PROPS) to High(LOCALIZED_PROPS) do
  begin
    // A list-like control's Text is a mirror of the selected item, not an
    // independent caption. Writing it can reset ItemIndex to -1 and change
    // behaviour that other code reads back (frm_main.pas:1519 -- cbDownloaded
    // is a csDropDownList TComboBox whose Text duplicates Items.Strings[0]).
    if (LOCALIZED_PROPS[I] = 'Text') and HasStringsItems(AObject) then
      Continue;

    Info := GetPropInfo(AObject, LOCALIZED_PROPS[I], [tkString, tkLString,
      tkWString, tkUString]);
    if Info = nil then
      Continue;
    // SetStrProp does not check SetProc: a read-only published property
    // whose current value happens to be a catalog hit would otherwise call
    // a nil setter -- an access violation during form construction.
    if Info^.SetProc = nil then
      Continue;
    Old := GetStrProp(AObject, Info);
    if Old = '' then
      Continue;
    New := TranslateText(Old);
    // Assign only on a real hit. TranslateText returns its argument unchanged
    // on a miss, so this keeps the walk free of pointless property writes,
    // each of which can invalidate a control and force a repaint.
    if New <> Old then
      SetStrProp(AObject, Info, New);
  end;
end;

// TStrings publishes no Caption/Hint/Text, so a dropdown's item text is
// unreachable from TranslateProps -- it has to be rewritten line by line.
//
// Rewriting a TComboBox or TListBox item goes through CB_DELETESTRING +
// CB_INSERTSTRING, which resets ItemIndex to -1. That is not cosmetic:
// frm_main.pas:1519 reads cbDownloaded.ItemIndex straight into
// FSearchCriteria.DownloadedIdx, so losing the selection would silently change
// which books the search returns. Save the index, restore it after.
procedure TranslateItems(AObject: TObject);
var
  Info, IdxInfo: PPropInfo;
  Sub: TObject;
  Items: TStrings;
  I, SavedIndex: Integer;
  Old, New: string;
  Changed: Boolean;
begin
  if AObject = nil then
    Exit;

  Info := GetPropInfo(AObject, 'Items', [tkClass]);
  if Info = nil then
    Exit;
  Sub := GetObjectProp(AObject, Info);
  if not (Sub is TStrings) then
    Exit;
  Items := TStrings(Sub);
  if Items.Count = 0 then
    Exit;

  IdxInfo := GetPropInfo(AObject, 'ItemIndex', [tkInteger]);
  if IdxInfo <> nil then
    SavedIndex := GetOrdProp(AObject, IdxInfo)
  else
    SavedIndex := -1;

  Changed := False;
  Items.BeginUpdate;
  try
    for I := 0 to Items.Count - 1 do
    begin
      Old := Items[I];
      if Old = '' then
        Continue;
      New := TranslateText(Old);
      if New <> Old then
      begin
        Items[I] := New;
        Changed := True;
      end;
    end;
  finally
    Items.EndUpdate;
  end;

  // Only when something actually moved: a list filled at runtime with book
  // data has no catalog hits, and must not have its selection disturbed.
  if Changed and (IdxInfo <> nil) and (IdxInfo^.SetProc <> nil) then
    SetOrdProp(AObject, IdxInfo, SavedIndex);
end;

// Grid column headers are the reason this exists. A TListView's Columns and a
// VirtualTree's Header.Columns are TCollections whose items are
// TCollectionItem, not TComponent -- so the Components array never reaches
// them. Rather than hard-coding VirtualTrees and ComCtrls into this unit,
// walk published TPersistent and TCollection properties generically.
procedure TranslateSubObjects(AObject: TObject; ADepth: Integer);
var
  Count, I, J: Integer;
  List: PPropList;
  Sub: TObject;
  Collection: TCollection;
begin
  if (AObject = nil) or (ADepth > MAX_PERSISTENT_DEPTH) then
    Exit;

  Count := GetPropList(PTypeInfo(AObject.ClassInfo), [tkClass], nil, False);
  if Count = 0 then
    Exit;
  GetMem(List, Count * SizeOf(Pointer));
  try
    GetPropList(PTypeInfo(AObject.ClassInfo), [tkClass], List, False);
    for I := 0 to Count - 1 do
    begin
      Sub := GetObjectProp(AObject, List^[I]);
      if Sub = nil then
        Continue;
      // Components are reached through the Components array instead. Following
      // them here would revisit them and can cycle (Owner, Parent, PopupMenu).
      if Sub is TComponent then
        Continue;

      if Sub is TCollection then
      begin
        Collection := TCollection(Sub);
        for J := 0 to Collection.Count - 1 do
        begin
          TranslateProps(Collection.Items[J]);
          TranslateSubObjects(Collection.Items[J], ADepth + 1);
        end;
      end
      else if Sub is TPersistent then
      begin
        TranslateProps(Sub);
        TranslateSubObjects(Sub, ADepth + 1);
      end;
    end;
  finally
    FreeMem(List);
  end;
end;

// Writes VCL properties directly (TranslateProps/SetStrProp), so this must
// only ever be called from the main thread.
procedure Localize(AComponent: TComponent);
var
  I: Integer;
begin
  // Rule 3 from step 1: with an empty index nothing can change, so do not pay
  // for an RTTI walk of 24 forms on a Ukrainian startup.
  if not FActive or (AComponent = nil) then
    Exit;

  TranslateProps(AComponent);
  // Deliberately not called from TranslateSubObjects: only components own an
  // Items: TStrings, and calling it there would revisit the same list.
  TranslateItems(AComponent);
  TranslateSubObjects(AComponent, 0);

  for I := 0 to AComponent.ComponentCount - 1 do
    Localize(AComponent.Components[I]);
end;

// Mirrors System.pas:41336-41348 exactly, then substitutes.
function LocalizedLoadResString(ResStringRec: PResStringRec): string;
var
  Buffer: array [0..4095] of Char;
  S: string;
begin
  Result := '';
  if ResStringRec = nil then
    Exit;

  if ResStringRec.Identifier < 64 * 1024 then
    SetString(Result, Buffer,
      LoadString(FindResourceHInstance(ResStringRec.Module^),
        ResStringRec.Identifier, Buffer, Length(Buffer)))
  else
    Result := PChar(ResStringRec.Identifier);

  // Note: TryGetValue assigns Default(T) to its out parameter on a miss,
  // so it must NOT be called with Result as the out parameter.
  if (FIndex <> nil) and FIndex.TryGetValue(Result, S) then
    Result := S;
end;

procedure LoadSection(ASection: TJSONObject);
var
  Pair: TJSONPair;
  Entry: TJSONObject;
  Src, Tgt: string;
begin
  if ASection = nil then
    Exit;

  for Pair in ASection do
  begin
    if not (Pair.JsonValue is TJSONObject) then
      Continue;
    Entry := TJSONObject(Pair.JsonValue);

    if not Entry.TryGetValue<string>('source', Src) then
      Continue;
    if not Entry.TryGetValue<string>('target', Tgt) then
      Continue;

    // Rule 1: only non-empty targets enter the index — this is what makes a
    // blank caption structurally impossible.
    if Trim(Tgt) = '' then
      Continue;
    // Rule 2: an entry that translates to itself is a no-op.
    if Tgt = Src then
      Continue;
    if Src = '' then
      Continue;

    if FIndex.ContainsKey(Src) then
    begin
      if FIndex[Src] <> Tgt then
        SetStatus('Localization: conflicting targets for one source',
          Pair.JsonString.Value);
      Continue; // first one wins
    end;

    FIndex.Add(Src, Tgt);
  end;
end;

function LoadCatalog(const AFileName: string): Boolean;
var
  Root: TJSONValue;
  Section: TJSONValue;
begin
  Result := False;
  Root := nil;
  try
    try
      Root := TJSONObject.ParseJSONValue(TFile.ReadAllText(AFileName, TEncoding.UTF8));
      if not (Root is TJSONObject) then
      begin
        SetStatus('Localization: catalog is not a JSON object', AFileName);
        Exit;
      end;

      // `is` is false for nil, so a missing section is simply skipped, and a
      // section of the wrong type no longer raises EInvalidCast and discards
      // the sections already loaded.
      Section := TJSONObject(Root).GetValue('strings');
      if Section is TJSONObject then
        LoadSection(TJSONObject(Section));

      Section := TJSONObject(Root).GetValue('dfm');
      if Section is TJSONObject then
        LoadSection(TJSONObject(Section));

      Result := True;
    except
      // A malformed catalog must never reach the user as a startup exception:
      // this runs before the splash screen exists.
      on E: Exception do
        SetStatus('Localization: failed to read catalog - ' + E.Message, AFileName);
    end;
  finally
    // MUST be try..finally, not a bare call after the try..except: the Exit
    // above returns from the function and would skip it, leaking the parsed
    // tree. FastMM5 is linked (MyHomeLib.dpr:44) and reports such leaks.
    Root.Free;
  end;
end;

function ReadLocale(const APaths: TMHLPathInfo): string;
var
  Ini: TMemIniFile;
begin
  Result := '';
  try
    Ini := TMemIniFile.Create(IncludeTrailingPathDelimiter(APaths.WorkDir)
      + APaths.IniFileName, TEncoding.UTF8);
    try
      Result := LowerCase(Trim(Ini.ReadString('INTERFACE', 'Locale', '')));
    finally
      Ini.Free;
    end;
  except
    on E: Exception do
      SetStatus('Localization: failed to read locale - ' + E.Message, '');
  end;

  if Result = '' then
    Result := DEFAULT_LOCALE;
end;

function InitLocalization: Boolean;
var
  Paths: TMHLPathInfo;
  Locale, FileName: string;
begin
  Result := False;
  if FActive then
    Exit(True);   // already installed; report that fact truthfully

  Paths := ResolveMHLPaths;
  Locale := ReadLocale(Paths);

  // Ukrainian is compiled into the exe: no catalog, no hook, no overhead.
  if Locale = DEFAULT_LOCALE then
  begin
    SetStatus('Localization: base locale, hook not installed', Locale);
    Exit;
  end;

  FileName := Paths.AppPath + LANG_DIR_NAME + PathDelim + Locale + '.json';
  if not FileExists(FileName) then
  begin
    SetStatus('Localization: catalog not found, falling back to '
      + DEFAULT_LOCALE, FileName);
    Exit;
  end;

  FIndex := TDictionary<string, string>.Create;
  if not LoadCatalog(FileName) then
  begin
    FreeAndNil(FIndex);
    Exit;
  end;

  // Rule 3: an empty index cannot change anything, so do not pay for the hook.
  if FIndex.Count = 0 then
  begin
    SetStatus('Localization: catalog has no usable entries, falling back to '
      + DEFAULT_LOCALE, FileName);
    FreeAndNil(FIndex);
    Exit;
  end;

  LoadResStringFunc := LocalizedLoadResString;
  FActive := True;
  Result := True;
  SetStatus(Format('Localization: %s active, %d strings',
    [Locale, FIndex.Count]), FileName);
end;

procedure DoneLocalization;
begin
  // Only unassign a hook this unit actually installed, so we never clobber
  // someone else's. Unassign BEFORE freeing the index: the reverse order
  // would leave a live hook reading a dangling dictionary.
  if FActive then
    LoadResStringFunc := nil;
  FActive := False;
  FreeAndNil(FIndex);
end;

initialization

finalization
  DoneLocalization;

end.
