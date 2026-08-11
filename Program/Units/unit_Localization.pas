unit unit_Localization;

interface

uses
  System.Classes;

const
  LANG_DIR_NAME = 'Lang';

type
  TLocaleInfo = record
    Code: string;
    Name: string;
  end;

function AvailableLocales: TArray<TLocaleInfo>;
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
  System.Generics.Defaults,
  System.IniFiles,
  System.TypInfo,
  unit_Settings,
  unit_LangSignature;

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

// True when reading this property touches nothing but a field. RTTI stores a
// field offset in the getter slot for such properties and a code address for
// every other kind, so this distinguishes a plain read from a method call.
function IsFieldGetter(AInfo: PPropInfo): Boolean;
begin
  Result := (IntPtr(AInfo^.GetProc) and PROPSLOT_MASK) = PROPSLOT_FIELD;
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
      // A getter is user code, and user code called from a read-only walk can
      // leave the UI changed behind it. TMenuItem.Bitmap is the case that hurt:
      // its getter allocates an empty TBitmap on first read, and Vcl.Menus then
      // reads FBitmap <> nil as "this item has a glyph" -- without checking
      // whether the bitmap is empty -- so MeasureItem and AdvancedDrawItem
      // reserve image-width space at the left of every menu-bar caption
      // (Vcl.Menus.pas: TMenuItem.MeasureItem, TMenuItem.AdvancedDrawItem).
      // The result was a menu bar indented by 16-24px in every locale except
      // the base one, where Localize exits before the walk ever runs.
      //
      // Nothing here needs a computed property: the walk is looking for
      // sub-objects a component owns, and those are plain fields. Skipping the
      // rest also drops Action, which is a TComponent the loop would discard
      // one line later anyway.
      if not IsFieldGetter(List^[I]) then
        Continue;

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

// Parses catalog TEXT. The caller supplies the bytes, so one parser and one
// set of guards serve both the resources embedded in the exe and the files in
// Lang\. ASourceName appears only in status messages.
function LoadCatalogText(const AText, ASourceName,
  AExpectedLocale: string): Boolean;
var
  Root: TJSONValue;
  Section: TJSONValue;
  Declared: string;
begin
  Result := False;
  Root := nil;
  try
    try
      Root := TJSONObject.ParseJSONValue(AText);
      if not (Root is TJSONObject) then
      begin
        SetStatus('Localization: catalog is not a JSON object', ASourceName);
        Exit;
      end;

      // A catalog's locale is what it DECLARES, never what it is named. This
      // is what stops a signed catalog being renamed into another language's
      // slot -- the signature stays valid, but the declaration does not match
      // and the catalog is refused.
      if AExpectedLocale <> '' then
      begin
        if not TJSONObject(Root).TryGetValue<string>('locale', Declared) then
        begin
          SetStatus('Localization: catalog declares no locale', ASourceName);
          Exit;
        end;
        if not SameText(Trim(Declared), AExpectedLocale) then
        begin
          SetStatus('Localization: catalog declares "' + Declared
            + '", expected "' + AExpectedLocale + '"', ASourceName);
          Exit;
        end;
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
        SetStatus('Localization: failed to parse catalog - ' + E.Message,
          ASourceName);
    end;
  finally
    // MUST be try..finally, not a bare call after the try..except: the Exit
    // above returns from the function and would skip it, leaking the parsed
    // tree. FastMM5 is linked (MyHomeLib.dpr:44) and reports such leaks.
    Root.Free;
  end;
end;

// Reading is guarded separately from parsing: TFile.ReadAllText raises on a
// locked or unreadable file, and that must degrade the same way malformed
// JSON does rather than escape to the caller.
function LoadCatalogFile(const AFileName, AExpectedLocale: string): Boolean;
begin
  Result := False;
  try
    Result := LoadCatalogText(
      TFile.ReadAllText(AFileName, TEncoding.UTF8), AFileName, AExpectedLocale);
  except
    on E: Exception do
      SetStatus('Localization: failed to read catalog - ' + E.Message,
        AFileName);
  end;
end;

const
  LANG_RES_PREFIX = 'LANG_';

// Reads an embedded catalog resource as text. TEncoding.UTF8.GetString does
// NOT strip a byte-order mark, so a catalog saved with one would reach the
// JSON parser with a leading U+FEFF and fail. extract.js writes them without,
// but a translator's editor will not necessarily agree.
function EmbeddedCatalogText(const AResName: string; out AText: string): Boolean;
var
  Stream: TResourceStream;
  Bytes: TBytes;
begin
  Result := False;
  AText := '';
  if FindResource(HInstance, PChar(AResName), RT_RCDATA) = 0 then
    Exit;
  try
    Stream := TResourceStream.Create(HInstance, AResName, RT_RCDATA);
    try
      SetLength(Bytes, Stream.Size);
      if Stream.Size > 0 then
        Stream.ReadBuffer(Bytes[0], Stream.Size);
      AText := TEncoding.UTF8.GetString(Bytes);
      if (AText <> '') and (AText[1] = #$FEFF) then
        Delete(AText, 1, 1);
      Result := True;
    finally
      Stream.Free;
    end;
  except
    on E: Exception do
      SetStatus('Localization: failed to read embedded catalog - ' + E.Message,
        AResName);
  end;
end;

function HasEmbeddedCatalog(const ACode: string): Boolean;
begin
  Result := (ACode <> '')
    and (FindResource(HInstance,
      PChar(LANG_RES_PREFIX + UpperCase(ACode)), RT_RCDATA) <> 0);
end;

function LoadEmbeddedCatalog(const ACode: string): Boolean;
var
  Text: string;
  ResName: string;
begin
  ResName := LANG_RES_PREFIX + UpperCase(ACode);
  Result := EmbeddedCatalogText(ResName, Text)
    and LoadCatalogText(Text, 'resource:' + ResName, ACode);
end;

// Enumerated rather than listed in a constant: the resources are generated
// from whatever catalogs were present at build time, and a hand-maintained
// list beside them would eventually disagree with the binary.
function EnumLangResNames(hModule: HMODULE; lpszType, lpszName: PChar;
  lParam: NativeInt): BOOL; stdcall;
var
  Name: string;
begin
  Result := True;
  // Integer-id resources arrive as a value packed into the low word, not a
  // pointer. Ours are all named, so anything without a high word is not ours
  // and dereferencing it would fault.
  if (NativeUInt(lpszName) shr 16) = 0 then
    Exit;
  Name := string(lpszName);
  if Name.StartsWith(LANG_RES_PREFIX) then
    TList<string>(lParam).Add(Name);
end;

function EmbeddedLocales: TArray<TLocaleInfo>;
var
  Names: TList<string>;
  ResName, Text, Code, LocaleName: string;
  Root: TJSONValue;
  Info: TLocaleInfo;
  List: TList<TLocaleInfo>;
begin
  Result := nil;
  Names := TList<string>.Create;
  List := TList<TLocaleInfo>.Create;
  try
    EnumResourceNames(HInstance, RT_RCDATA, @EnumLangResNames, NativeInt(Names));
    Names.Sort;

    for ResName in Names do
    begin
      if not EmbeddedCatalogText(ResName, Text) then
        Continue;
      Root := nil;
      try
        try
          Root := TJSONObject.ParseJSONValue(Text);
          if not (Root is TJSONObject) then
            Continue;
          if not TJSONObject(Root).TryGetValue<string>('locale', Code) then
            Continue;
          if not TJSONObject(Root).TryGetValue<string>('name', LocaleName) then
            Continue;
          Info.Code := LowerCase(Trim(Code));
          Info.Name := Trim(LocaleName);
          if (Info.Code <> '') and (Info.Name <> '') then
            List.Add(Info);
        except
          // Must never raise: this runs while the main form is being built.
          on E: Exception do
            SetStatus('Localization: bad embedded catalog - ' + E.Message,
              ResName);
        end;
      finally
        Root.Free;
      end;
    end;

    Result := List.ToArray;
  finally
    List.Free;
    Names.Free;
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

// The language menu's source of truth: which locales can actually be offered.
//
// Ukrainian is pinned first from a constant, never from a catalog. It is
// embedded in the exe like English, but the pin is what guarantees a user can
// always get back to it even if the resource is somehow absent -- listing it
// conditionally would let a partial install strand someone in a language they
// cannot leave.
//
// Embedded locales come next and claim their codes, so a file in Lang\ can
// never shadow a language we ship. Everything after that is discovered.
//
// This must never raise: it runs while the main form is being built, and a
// malformed file dropped into Lang\ has to degrade to "that language is not
// offered", the same way a malformed catalog already degrades to Ukrainian.
function AvailableLocales: TArray<TLocaleInfo>;
var
  Paths: TMHLPathInfo;
  Dir, FileName, Code, LocaleName: string;
  Files: TArray<string>;
  Root: TJSONValue;
  Obj: TJSONObject;
  Seen: TDictionary<string, Boolean>;
  Rest: TList<TLocaleInfo>;
  Info, Base: TLocaleInfo;
begin
  Base.Code := DEFAULT_LOCALE;
  Base.Name := BASE_LOCALE_NAME;
  Result := [Base];

  Seen := TDictionary<string, Boolean>.Create;
  Rest := TList<TLocaleInfo>.Create;
  try
    Seen.Add(LowerCase(DEFAULT_LOCALE), True);

    // Embedded locales are offered whether or not a Lang\ directory exists --
    // they are inside the exe. Collecting them before the scan also means
    // they claim their codes first, so a file declaring one of them is
    // dropped by the duplicate rule below rather than needing a special case.
    for Info in EmbeddedLocales do
      if not Seen.ContainsKey(Info.Code) then
      begin
        Seen.Add(Info.Code, True);
        Rest.Add(Info);
      end;

    Paths := ResolveMHLPaths;
    Dir := Paths.AppPath + LANG_DIR_NAME + PathDelim;
    Files := nil;
    if DirectoryExists(Dir) then
      try
        Files := TDirectory.GetFiles(Dir, '*.json');
      except
        // An unreadable directory is the same as no directory.
        Files := nil;
      end;

    // GetFiles gives no ordering guarantee, and the duplicate rule below is
    // "first one wins" -- so the order has to be made deterministic here,
    // rather than depending on how the filesystem happened to enumerate.
    TArray.Sort<string>(Files);

    for FileName in Files do
    begin
      // The menu must offer only what InitLocalization would actually load,
      // or a user picks a language and gets Ukrainian with a tick left on the
      // wrong entry. Checked before the file is even parsed.
      if not VerifyCatalogSignature(FileName) then
        Continue;

      Root := nil;
      try
        try
          Root := TJSONObject.ParseJSONValue(
            TFile.ReadAllText(FileName, TEncoding.UTF8));
          if not (Root is TJSONObject) then
            Continue;
          Obj := TJSONObject(Root);

          if not Obj.TryGetValue<string>('locale', Code) then
            Continue;
          if not Obj.TryGetValue<string>('name', LocaleName) then
            Continue;

          Code := LowerCase(Trim(Code));
          LocaleName := Trim(LocaleName);
          if (Code = '') or (LocaleName = '') then
            Continue;

          // A signed catalog renamed into another slot must not be listed
          // under the name it was given: InitLocalization looks it up by
          // filename and would then refuse it for declaring something else.
          if not SameText(Code,
            TPath.GetFileNameWithoutExtension(FileName)) then
            Continue;

          // The pinned base entry already covers uk, and a second file
          // claiming a code we have seen loses to the first.
          if Seen.ContainsKey(Code) then
            Continue;
          Seen.Add(Code, True);

          Info.Code := Code;
          Info.Name := LocaleName;
          Rest.Add(Info);
        except
          // A catalog that cannot be read or parsed is simply not offered.
          Continue;
        end;
      finally
        Root.Free;
      end;
    end;

    // Display order, applied after deduplication so that which duplicate won
    // depends on the filename, not on the display names.
    Rest.Sort(TComparer<TLocaleInfo>.Construct(
      function(const L, R: TLocaleInfo): Integer
      begin
        Result := CompareText(L.Name, R.Name);
      end));

    Result := Result + Rest.ToArray;
  finally
    Rest.Free;
    Seen.Free;
  end;
end;

function InitLocalization: Boolean;
var
  Paths: TMHLPathInfo;
  Locale, FileName: string;
  Loaded: Boolean;
begin
  Result := False;
  if FActive then
    Exit(True);   // already installed; report that fact truthfully

  Paths := ResolveMHLPaths;
  Locale := ReadLocale(Paths);

  FIndex := TDictionary<string, string>.Create;

  // Embedded catalogs win unconditionally. A file in Lang\ declaring a locale
  // we ship is ignored -- there is no file a user can place that alters one
  // of our languages.
  //
  // Ukrainian takes this path too, now that it has no short-circuit. Its
  // catalog is pure identity, so rule 2 drops every entry, the index comes
  // out empty, and rule 3 below declines to install the hook -- the same
  // outcome the short-circuit produced, reached by a general rule.
  if HasEmbeddedCatalog(Locale) then
    Loaded := LoadEmbeddedCatalog(Locale)
  else
  begin
    FileName := Paths.AppPath + LANG_DIR_NAME + PathDelim + Locale + '.json';
    if not FileExists(FileName) then
    begin
      SetStatus('Localization: catalog not found, falling back to '
        + DEFAULT_LOCALE, FileName);
      Loaded := False;
    end
    // A catalog for a locale we do not ship is somebody else's file. It loads
    // only if it carries a signature made with the project's key -- see
    // unit_LangSignature. The project does not sign Russian catalogs.
    else if not VerifyCatalogSignature(FileName) then
    begin
      SetStatus('Localization: catalog is not signed, falling back to '
        + DEFAULT_LOCALE, FileName);
      Loaded := False;
    end
    else
      Loaded := LoadCatalogFile(FileName, Locale);
  end;

  if not Loaded then
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
