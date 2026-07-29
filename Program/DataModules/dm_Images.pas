unit dm_Images;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Graphics,
  Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList;

type
  TIconTheme = (itLight, itDark);

  /// Raised when Icons\MHLIcons.dll cannot be loaded. Worth a dedicated class:
  /// a missing resource DLL leaves every image collection empty, which used to
  /// fail silently and shipped that way in 2.6.0 pre1.
  EIconResourceMissing = class(Exception);

  TdmImages = class(TDataModule)
    ToolbarImageCollection: TImageCollection;
    vilToolbar: TVirtualImageList;
    MenuImageCollection: TImageCollection;
    vilMenu: TVirtualImageList;
    DownloadImageCollection: TImageCollection;
    vilDownload: TVirtualImageList;
    FileTypeImageCollection: TImageCollection;
    vilFileType: TVirtualImageList;
  private
    FCurrentTheme: TIconTheme;
    FThemeLoaded: Boolean;
    FResModule: HMODULE;
    FLoadErrorReported: Boolean;
    procedure LoadResFile;
    procedure FreeResFile;
    function SanitizeName(const AName: string): string;
    procedure LoadCollection(ACollection: TImageCollection;
      AVirtualImageList: TVirtualImageList;
      const AResPrefix: string;
      const ANames: array of string);
  public
    destructor Destroy; override;
    procedure LoadIcons(ATheme: TIconTheme);
    procedure ApplyThemeIcons;
    procedure ScaleForDPI(APPI: Integer);
    class function DetectIconTheme: TIconTheme; static;
    property CurrentTheme: TIconTheme read FCurrentTheme;
  end;

var
  dmImages: TdmImages;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

resourcestring
  rstrIconResourceMissing =
    'Не вдалося завантажити ресурс піктограм:'#13#10'%s'#13#10#13#10 +
    'Помилка Windows %d: %s'#13#10#13#10 +
    'Програма працюватиме без піктограм. Перевстановіть MyHomeLib або ' +
    'скопіюйте теку Icons поруч із MyHomeLib.exe.';

const
  CIconResFile = 'Icons\MHLIcons.dll';

  // Main toolbar icon names — indices match old ilToolBar ImageIndex values
  CToolbarOrder: array[0..27] of string = (
    'book-read',          // 0
    'send-to-device',     // 1
    'add-to-download',    // 2
    'alphabet-cyrillic',  // 3
    'alphabet-latin',     // 4
    '',                   // 5 (unused)
    'collection-select',  // 6
    'select-all',         // 7
    'collapse-expand',    // 8
    '',                   // 9 (unused)
    'tree-table-mode',    // 10 — btnSwitchTreeMode, table state (TreeIcons[0])
    'tree-mode',          // 11 — btnSwitchTreeMode, tree state  (TreeIcons[1])
    'hide-deleted',       // 12
    'local-only',         // 13
    'info-panel',         // 14
    'add-to-favorites',   // 15
    'remove-from-group',  // 16 — BtnFav_add swaps to this on the Groups tab
    'settings',           // 17
    '',                   // 18 (separator)
    '', '', '', '',       // 19-22 (unused)
    'delete',             // 23 — tbtnDownloadList_Add swaps to this on the Downloads tab
    '', '',               // 24-25 (unused)
    'help',               // 26
    ''                    // 27 (separator)
  );

  // Menu/action icon names — indices match old ilMainMenu ImageIndex values
  CMenuOrder: array[0..35] of string = (
    'book-delete',            // 0  acBookDelete
    'collection-new',         // 1  acCollectionNew
    'collection-delete',      // 2  acCollectionDelete
    'collection-properties',  // 3  acCollectionProperties
    '',                       // 4  (unused)
    '',                       // 5  (unused)
    '',                       // 6  (unused)
    'send-to-device',         // 7  acBookSend2Device
    'import',                 // 8  miPdfdjvu
    'sync',                   // 9  acCollectionSyncFiles
    '',                       // 10 (unused)
    'settings',               // 11 acToolsSettings
    'book-read',              // 12 acBookRead
    'add-to-favorites',       // 13 acBookAdd2Favorites
    '',                       // 14 (unused)
    '',                       // 15 (unused)
    '',                       // 16 (unused)
    'help',                   // 17 acHelpHelp
    'import',                 // 18 miFb2Import
    '',                       // 19 (unused)
    'add-to-download',        // 20 acBookAdd2DownloadList
    'remove-from-group',      // 21 miDelFavorites
    '',                       // 22 (unused)
    'copy-to-collection',     // 23 miCopyToCollection
    'select-all',             // 24 pmiCheckAll
    '',                       // 25 (unused)
    '',                       // 26 (unused)
    'collection-select',      // 27 miCollSelect
    '',                       // 28 (unused)
    'script',                 // 29 mmiScripts
    'rating',                 // 30 miRate
    'copy-to-clipboard',      // 31 miCopyClBrd
    'deselect-all',           // 32 pmiDeselectAll
    'exit',                   // 33 acApplicationExit
    '',                       // 34 (unused)
    'go-to-author'            // 35 miGoToAuthor
  );

  // File type icon names for pmScripts dropdown menu
  CFileTypeOrder: array[0..7] of string = (
    'filetype-fb2',       // 0
    'filetype-fb2zip',    // 1
    'filetype-lrf',       // 2
    'filetype-txt',       // 3
    'filetype-epub',      // 4
    'filetype-pdf',       // 5
    'filetype-mobi',      // 6
    'script'              // 7
  );

  // Download toolbar icon names — indices match old ilToolImages ImageIndex values
  CDownloadOrder: array[0..9] of string = (
    '',              // 0 (unused)
    'play',          // 1 btnStartDownload
    'stop',          // 2 btnPauseDownload
    'move-first',    // 3 BtnFirstRecord
    'move-up',       // 4 BtnDwnldUp
    'move-down',     // 5 BtnDwnldDown
    'move-last',     // 6 BtnLastRecord
    'delete',        // 7 BtnDelete
    'save',          // 8 BtnSave
    'clear'          // 9 tbtnClear
  );


class function TdmImages.DetectIconTheme: TIconTheme;
var
  C: COLORREF;
  R, G, B: Byte;
begin
  C := GetSysColor(COLOR_BTNFACE);
  R := GetRValue(C);
  G := GetGValue(C);
  B := GetBValue(C);
  if (0.299 * R + 0.587 * G + 0.114 * B) < 128 then
    Result := itDark
  else
    Result := itLight;
end;


destructor TdmImages.Destroy;
begin
  FreeResFile;
  inherited;
end;


procedure TdmImages.LoadResFile;
var
  ResPath: string;
  LastError: Cardinal;
begin
  if FResModule <> 0 then
    Exit;
  ResPath := ExtractFilePath(Application.ExeName) + CIconResFile;
  FResModule := LoadLibraryEx(PChar(ResPath), 0, LOAD_LIBRARY_AS_DATAFILE);
  if FResModule = 0 then
  begin
    LastError := GetLastError;
    raise EIconResourceMissing.CreateFmt(rstrIconResourceMissing,
      [ResPath, LastError, SysErrorMessage(LastError)]);
  end;
end;


procedure TdmImages.FreeResFile;
begin
  if FResModule <> 0 then
  begin
    FreeLibrary(FResModule);
    FResModule := 0;
  end;
end;


function TdmImages.SanitizeName(const AName: string): string;
begin
  Result := UpperCase(StringReplace(AName, '-', '_', [rfReplaceAll]));
end;


procedure TdmImages.LoadCollection(ACollection: TImageCollection;
  AVirtualImageList: TVirtualImageList;
  const AResPrefix: string;
  const ANames: array of string);
var
  I: Integer;
  RS: TResourceStream;
  Item: TImageCollectionItem;
  ResName, ItemName: string;
begin
  ACollection.Images.Clear;
  AVirtualImageList.Images.Clear;

  for I := 0 to High(ANames) do
  begin
    Item := ACollection.Images.Add;

    if ANames[I] <> '' then
      ItemName := ANames[I] + '_' + IntToStr(I)
    else
      ItemName := '_empty_' + IntToStr(I);

    Item.Name := ItemName;

    if ANames[I] <> '' then
    begin
      ResName := AResPrefix + SanitizeName(ANames[I]);
      try
        RS := TResourceStream.Create(FResModule, ResName, RT_RCDATA);
        try
          Item.SourceImages.Add;
          Item.SourceImages[0].Image.LoadFromStream(RS);
        finally
          RS.Free;
        end;
      except
        on E: EResNotFound do
          ; // leave empty placeholder
      end;
    end;

    with AVirtualImageList.Images.Add do
    begin
      CollectionIndex := I;
      CollectionName := ItemName;
      Name := ItemName;
    end;
  end;
end;


procedure TdmImages.LoadIcons(ATheme: TIconTheme);
var
  ThemePrefix: string;
begin
  // Raises EIconResourceMissing if the DLL is absent, so FResModule is valid here.
  LoadResFile;

  FCurrentTheme := ATheme;

  if ATheme = itDark then
    ThemePrefix := 'DARK_'
  else
    ThemePrefix := 'LIGHT_';

  LoadCollection(ToolbarImageCollection, vilToolbar,
    ThemePrefix + 'TOOLBAR_', CToolbarOrder);
  LoadCollection(MenuImageCollection, vilMenu,
    ThemePrefix + 'MENU_', CMenuOrder);
  LoadCollection(DownloadImageCollection, vilDownload,
    ThemePrefix + 'DOWNLOAD_', CDownloadOrder);
  LoadCollection(FileTypeImageCollection, vilFileType,
    ThemePrefix + 'FILETYPE_', CFileTypeOrder);

  FThemeLoaded := True;
end;


procedure TdmImages.ApplyThemeIcons;
var
  NewTheme: TIconTheme;
begin
  NewTheme := DetectIconTheme;
  if (not FThemeLoaded) or (NewTheme <> FCurrentTheme) then
  begin
    try
      LoadIcons(NewTheme);
    except
      on E: EIconResourceMissing do
      begin
        // Missing icons must not stop the application, but they must not pass
        // unnoticed either. Report once so theme re-checks stay quiet.
        if not FLoadErrorReported then
        begin
          FLoadErrorReported := True;
          Application.MessageBox(PChar(E.Message), 'MyHomeLib',
            MB_ICONWARNING or MB_OK);
        end;
      end;
    end;
  end;
end;


procedure TdmImages.ScaleForDPI(APPI: Integer);

  function Scale(ABase: Integer): Integer;
  begin
    Result := MulDiv(ABase, APPI, 96);
  end;

begin
  vilToolbar.SetSize(Scale(32), Scale(32));
  vilMenu.SetSize(Scale(24), Scale(24));
  vilDownload.SetSize(Scale(24), Scale(24));
  vilFileType.SetSize(Scale(24), Scale(24));
end;

end.
