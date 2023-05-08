(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov
  *
  * Authors             Oleksiy Penkov (oleksiy.penkov@gmail.com)
  *                     Nick Rymanov   (nrymanov@gmail.com)
  * Created             20.08.2008
  * Description
  *
  * $Id: frm_main.pas 1183 2015-04-01 04:32:39Z koreec $
  *
  * History
  * NickR 06.05.2010    Для уменьшения размера dfm и единообразия интерфейса некоторые компоненты
  *                     заменены своими версиями с заранее настроенными свойствами.
  *
  ****************************************************************************** *)

unit frm_main;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  VirtualTrees,
  StdCtrls,
  ComCtrls,
  Mask,
  ExtCtrls,
  ToolWin,
  ImgList,
  Clipbrd,
  Menus,
  ShellAPI,
  unit_Globals,
  unit_Interfaces,
  XMLIntf,
  XMLDoc,
  pngimage,
  jpeg,
  DB,
  unit_DownloadManagerThread,
  unit_Messages,
  files_list,
  ActiveX,
  idStack,
  idComponent,
  IdBaseComponent,
  IdHTTP,
  IdSocks,
  IdSSLOpenSSL,
  IdAntiFreezeBase,
  IdAntiFreeze,
  Buttons,
  MHLSplitter,
  ActnList,
  BookInfoPanel,
  ActnMan,
  MHLSimplePanel,
  BookTreeView,
  unit_SearchPresets,
  MHLButtonedEdit,
  unit_UserData,
  unit_treeController,
  unit_ColorTabs,
  System.Actions,
  System.ImageList;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    miBook: TMenuItem;
    miQuitApp: TMenuItem;
    pmMain: TPopupMenu;
    pmiReadBook: TMenuItem;
    pmiSendToDevice: TMenuItem;
    N19: TMenuItem;
    miAddFavorites: TMenuItem;
    miDelFavorites: TMenuItem;
    miRate: TMenuItem;
    miSetRate1: TMenuItem;
    miSetRate2: TMenuItem;
    miSetRate3: TMenuItem;
    miSetRate4: TMenuItem;
    miSetRate5: TMenuItem;
    N11: TMenuItem;
    miClearRate: TMenuItem;
    N20: TMenuItem;
    pmiCheckAll: TMenuItem;
    pmiDeselectAll: TMenuItem;
    N23: TMenuItem;
    miCopyClBrd: TMenuItem;
    pmiBookInfo: TMenuItem;
    N2: TMenuItem;
    miTools: TMenuItem;
    miSettings: TMenuItem;
    N5: TMenuItem;
    miCollSelect: TMenuItem;
    miDeleteCol: TMenuItem;
    N18: TMenuItem;
    miStat: TMenuItem;
    miRead: TMenuItem;
    miDevice: TMenuItem;
    N7: TMenuItem;
    miCollsettings: TMenuItem;
    miCopyToCollection: TMenuItem;
    miFb2Import: TMenuItem;
    miAbout: TMenuItem;
    miCheckUpdates: TMenuItem;
    N30: TMenuItem;
    miShowHelp: TMenuItem;
    IdAntiFreeze1: TIdAntiFreeze;
    N17: TMenuItem;
    pmAuthor: TPopupMenu;
    miCopyAuthor: TMenuItem;
    miPdfdjvu: TMenuItem;
    miBookEdit: TMenuItem;
    miRefreshGenres: TMenuItem;
    miDownloadBooks: TMenuItem;
    pmiDownloadBooks: TMenuItem;
    ilToolBar: TImageList;
    ilMainMenu: TImageList;
    pmCollection: TPopupMenu;
    miUpdate: TMenuItem;
    miGoToAuthor: TMenuItem;
    tlbrMain: TToolBar;
    tbtnRead: TToolButton;
    tbSendToDevice: TToolButton;
    tbtnRus: TToolButton;
    tbtnEng: TToolButton;
    tbSelectAll: TToolButton;
    tbCollapse: TToolButton;
    tbtnShowCover: TToolButton;
    tbtnShowDeleted: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    BtnFav_add: TToolButton;
    tbtnSettings: TToolButton;
    pmScripts: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    pmiScripts: TMenuItem;
    mmiScripts: TMenuItem;
    miSyncOnline: TMenuItem;
    btnSwitchTreeMode: TToolButton;
    tbtnWizard: TToolButton;
    tbtnShowLocalOnly: TToolButton;
    tbtnDownloadList_Add: TToolButton;
    N1: TMenuItem;
    miGoSite: TMenuItem;
    miGoForum: TMenuItem;
    pgControl: TPageControl;
    tsSearch: TTabSheet;
    tsByGroup: TTabSheet;
    ilFileTypes: TImageList;
    tsByAuthor: TTabSheet;
    tvAuthors: TVirtualStringTree;
    pnAuthorSearch: TMHLSimplePanel;
    lblAuthorsSearch: TLabel;
    tbClearEdAuthor: TSpeedButton;
    edLocateAuthor: TEdit;
    pnAuthorBooksTitle: TMHLSimplePanel;
    lblBooksTotalA: TLabel;
    ipnlAuthors: TInfoPanel;
    pmHeaders: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N8: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N25: TMenuItem;
    N27: TMenuItem;
    tsBySerie: TTabSheet;
    pnSeriesView: TMHLSimplePanel;
    tvSeries: TVirtualStringTree;
    pnSerieSearch: TMHLSimplePanel;
    lblSerieSearch: TLabel;
    btnClearEdSeries: TSpeedButton;
    edLocateSeries: TEdit;
    pnSerieBooksView: TMHLSimplePanel;
    pnSerieBooksTitle: TMHLSimplePanel;
    lblBooksTotalS: TLabel;
    ipnlSeries: TInfoPanel;
    tsByGenre: TTabSheet;
    pnGenresView: TMHLSimplePanel;
    tvGenres: TVirtualStringTree;
    pnGenreBooksView: TMHLSimplePanel;
    pnGenreBooksTitle: TMHLSimplePanel;
    lblBooksTotalG: TLabel;
    lblGenreTitle: TLabel;
    ipnlGenres: TInfoPanel;
    TrayIcon: TTrayIcon;
    pmTray: TPopupMenu;
    N29: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    tsDownload: TTabSheet;
    pmDownloadList: TPopupMenu;
    mi_dwnl_LocateAuthor: TMenuItem;
    N35: TMenuItem;
    mi_dwnl_Delete: TMenuItem;
    ilToolBar_Disabled: TImageList;
    N34: TMenuItem;
    tlbrDownloadList: TToolBar;
    BtnDwnldUp: TToolButton;
    BtnDwnldDown: TToolButton;
    BtnDelete: TToolButton;
    BtnFirstRecord: TToolButton;
    BtnLastRecord: TToolButton;
    RzSpacer2: TToolButton;
    ToolButton7: TToolButton;
    lblAuthor: TLabel;
    lblSeries: TLabel;
    btnStartDownload: TToolButton;
    btnPauseDownload: TToolButton;
    Panel1: TMHLSimplePanel;
    RzPanel2: TMHLSimplePanel;
    lblDownloadState: TLabel;
    lblDnldAuthor: TLabel;
    lblDnldTitle: TLabel;
    lblDownloadCount: TLabel;
    BtnSave: TToolButton;
    N28: TMenuItem;
    N37: TMenuItem;
    miAddToSearch: TMenuItem;
    miINPXCollectionExport: TMenuItem;
    N38: TMenuItem;
    pnGroupsView: TMHLSimplePanel;
    tvGroups: TVirtualStringTree;
    RzPanel8: TMHLSimplePanel;
    pnGroupBooksView: TMHLSimplePanel;
    ipnlFavorites: TInfoPanel;
    lblTotalBooksF: TLabel;
    pmGroups: TPopupMenu;
    GroupMenuItem: TMenuItem;
    btnAddGroup: TButton;
    btnDeleteGroup: TButton;
    btnClearGroup: TButton;
    pmiGroups: TMenuItem;
    pnGroupBooksTitle: TMHLSimplePanel;
    lblBooksTotalF: TLabel;
    lblGroups: TLabel;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    N14: TMenuItem;
    miImportUserData: TMenuItem;
    miExportUserData: TMenuItem;
    miReaded: TMenuItem;
    N44: TMenuItem;
    N42: TMenuItem;
    N45: TMenuItem;
    SearchParams: TCategoryPanelGroup;
    ctpOther: TCategoryPanel;
    Label30: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    cbDate: TComboBox;
    cbLang: TComboBox;
    cbDownloaded: TComboBox;
    cbDeleted: TCheckBox;
    ctpFile: TCategoryPanel;
    Label27: TLabel;
    Label29: TLabel;
    Label28: TLabel;
    edFFile: TMHLButtonedEdit;
    edFFolder: TMHLButtonedEdit;
    edFExt: TMHLButtonedEdit;
    pnSearchBooksView: TMHLSimplePanel;
    ipnlSearch: TInfoPanel;
    pnlFullSearch: TMHLSimplePanel;
    lblTotalBooksFL: TLabel;
    Label1: TLabel;
    cbPresetName: TComboBox;
    btnDeletePreset: TButton;
    btnSavePreset: TButton;
    btnClearFilterEdits: TButton;
    btnApplyFilter: TButton;
    BalloonHint1: TBalloonHint;
    miRepairDataBase: TMenuItem;
    N6: TMenuItem;
    miCompactDataBase: TMenuItem;
    ctpBook: TCategoryPanel;
    Label5: TLabel;
    edFFullName: TMHLButtonedEdit;
    Label24: TLabel;
    edFTitle: TMHLButtonedEdit;
    Label26: TLabel;
    edFSeries: TMHLButtonedEdit;
    edFGenre: TMHLButtonedEdit;
    Label6: TLabel;
    N31: TMenuItem;
    miFastBookSearch: TMenuItem;
    pmiSelectAll: TMenuItem;
    pbDownloadProgress: TProgressBar;
    miFBDImport: TMenuItem;
    miShowEditToolbar: TMenuItem;
    tlbrEdit: TToolBar;
    tbtnEditAuthor: TToolButton;
    tbtnEditSeries: TToolButton;
    tbtnEditGenre: TToolButton;
    tbtnEditBook: TToolButton;
    tbtnSplitter1: TToolButton;
    tbtnFBD: TToolButton;
    tbtnSplitter2: TToolButton;
    tbtnDeleteBook: TToolButton;
    tbtnAutoFBD: TToolButton;
    tbtnHelp: TToolButton;
    N46: TMenuItem;
    miExportToHTML: TMenuItem;
    txt1: TMenuItem;
    RTF1: TMenuItem;
    ToolButton5: TToolButton;
    edFAnnotation: TMHLButtonedEdit;
    Label7: TLabel;
    pnAuthorsView: TMHLSimplePanel;
    pnAuthorBooksView: TMHLSimplePanel;
    AuthorsViewSplitter: TMHLSplitter;
    AuthorBookInfoSplitter: TMHLSplitter;
    ilAlphabetNormal: TImageList;
    ilAlphabetActive: TImageList;
    Actions: TActionList;
    acShowRusAlphabet: TAction;
    acShowEngAlphabet: TAction;
    miShowRusAlphabet: TMenuItem;
    miShowEngAlphabet: TMenuItem;
    acShowEditToolbar: TAction;
    N49: TMenuItem;
    acShowMainToolbar: TAction;
    acShowStatusbar: TAction;
    miShowMainToolbar: TMenuItem;
    miShowStatusbar: TMenuItem;
    miView: TMenuItem;
    acShowBookInfoPanel: TAction;
    miShowBookInfo: TMenuItem;
    SeriesViewSplitter: TMHLSplitter;
    SerieBookInfoSplitter: TMHLSplitter;
    GenresViewSplitter: TMHLSplitter;
    GenreBookInfoSplitter: TMHLSplitter;
    SearchViewSplitter: TMHLSplitter;
    SearchBookInfoSplitter: TMHLSplitter;
    pnSearchView: TMHLSimplePanel;
    pnSearchControl: TMHLSimplePanel;
    GroupsViewSplitter: TMHLSplitter;
    GroupBookInfoSplitter: TMHLSplitter;
    ToolButton2: TToolButton;
    tbtnClear: TToolButton;
    tvBooksA: TBookTree;
    tvBooksS: TBookTree;
    tvBooksG: TBookTree;
    tvBooksSR: TBookTree;
    tvBooksF: TBookTree;
    tvDownloadList: TBookTree;
    acShowBookCover: TAction;
    acShowBookAnnotation: TAction;
    miViewExtra: TMenuItem;
    miShowBookCover: TMenuItem;
    miShowBookAnnotation: TMenuItem;
    acBookSetRate1: TAction;
    acBookSetRate2: TAction;
    acBookSetRate3: TAction;
    acBookSetRate4: TAction;
    acBookSetRate5: TAction;
    acBookSetRateClear: TAction;
    acGroupCreate: TAction;
    acGroupDelete: TAction;
    acGroupClear: TAction;
    StatusBar: TStatusBar;
    ilToolImages: TImageList;
    acSavePreset: TAction;
    acDeletePreset: TAction;
    acApplyPreset: TAction;
    acClearPreset: TAction;
    acEditAuthor: TAction;
    acEditSerie: TAction;
    acEditGenre: TAction;
    acEditBook: TAction;
    acEditConver2FBD: TAction;
    acEditAutoConver2FBD: TAction;
    N36: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    N50: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    FBD1: TMenuItem;
    FBD2: TMenuItem;
    acGroupEdit: TAction;
    pmGroupActions: TPopupMenu;
    N9: TMenuItem;
    N26: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    tbarAuthorsRus: TToolBar;
    tbarAuthorsEng: TToolBar;
    tbarSeriesEng: TToolBar;
    tbarSeriesRus: TToolBar;
    acBookRead: TAction;
    acBookSend2Device: TAction;
    acBookAdd2DownloadList: TAction;
    acBookMarkAsRead: TAction;
    acBookAdd2Favorites: TAction;
    acBookAdd2Group: TAction;
    acBookRemoveFromGroup: TAction;
    acBookShowInfo: TAction;
    acBookCopy2Collection: TAction;
    acBookDelete: TAction;
    acApplicationExit: TAction;
    acCollectionNew: TAction;
    acCollectionSelect: TAction;
    acCollectionProperties: TAction;
    acCollectionStatistics: TAction;
    acCollectionDelete: TAction;
    acViewTreeView: TAction;
    acViewTableView: TAction;
    acViewHideDeletedBooks: TAction;
    acViewShowLocalOnly: TAction;
    acToolsQuickSearch: TAction;
    acToolsUpdateOnlineCollections: TAction;
    acToolsClearReadFolder: TAction;
    acToolsRunScript: TAction;
    acToolsSettings: TAction;
    acHelpHelp: TAction;
    acHelpCheckUpdates: TAction;
    acHelpProgramSite: TAction;
    acHelpSupportForum: TAction;
    acHelpAbout: TAction;
    N60: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    miAdd2Favorites: TMenuItem;
    miAddToGroup: TMenuItem;
    miRemoveFromGroup: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    N75: TMenuItem;
    N76: TMenuItem;
    acViewTreeView1: TMenuItem;
    acViewTableView1: TMenuItem;
    acViewSelectColumns: TAction;
    N77: TMenuItem;
    N78: TMenuItem;
    N79: TMenuItem;
    N16: TMenuItem;
    acImportFb2Zip: TAction;
    acImportFb2: TAction;
    acImportNonFB2: TAction;
    acImportFBD: TAction;
    acImportUserData: TAction;
    acExport2HTML: TAction;
    acExport2Txt: TAction;
    acExport2RTF: TAction;
    acExport2INPX: TAction;
    acExportUserData: TAction;
    acCollectionUpdateGenres: TAction;
    acCollectionSyncFiles: TAction;
    acCollectionRepair: TAction;
    acCollectionCompact: TAction;
    N24: TMenuItem;
    N43: TMenuItem;
    N80: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    Label8: TLabel;
    cbLibRate: TComboBox;
    edFKeyWords: TMHLButtonedEdit;
    Label3: TLabel;
    tmrCheckUpdates: TTimer;
    BookID1: TMenuItem;
    miBookInfoPriority: TMenuItem;
    acViewSetInfoPriority: TAction;
    tmrSearchA: TTimer;
    tmrSearchS: TTimer;
    cbLangSelectA: TComboBox;  // Выбор языка отображения книг
    cbReaded: TCheckBox;
    cbLangSelectS: TComboBox;
    cbLangSelectG: TComboBox;
    cbLangSelectF: TComboBox;
    lblLang: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    pmMarkSelected: TMenuItem;      // Выбор в поиске прочитанных книг

    //
    // События формы
    //
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);

    //
    // Список авторов
    //
    procedure tvAuthorsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvAuthorsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    //
    // Список серий
    //
    procedure tvSeriesChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvSeriesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    //
    // Список жанров
    //
    procedure tvGenresChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvGenresKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    //
    // Список групп
    //
    procedure tvGroupsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvGroupsDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure tvGroupsDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure tvGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    //
    // Список книг
    //
    procedure tvBooksTreeHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure tvBooksTreeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure tvBooksTreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tvBooksTreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);

    //
    // Меню "Книга"
    //
    procedure ReadBookExecute(Sender: TObject);
    procedure SendToDeviceExecute(Sender: TObject);
    procedure Add2DownloadListExecute(Sender: TObject);
    procedure MarkAsReadedExecute(Sender: TObject);
    procedure BookSetRateExecute(Sender: TObject);
    procedure DeleteBookExecute(Sender: TObject);
    procedure QuitAppExecute(Sender: TObject);

    //
    // Меню "Коллекция"
    //
    procedure ShowNewCollectionWizard(Sender: TObject);
    procedure ShowCollectionSettingsExecute(Sender: TObject);
    procedure ShowCollectionStatisticsExecute(Sender: TObject);
    procedure ImportFb2Execute(Sender: TObject);
    procedure ImportFb2Update(Sender: TObject);
    procedure ImportNonFB2Execute(Sender: TObject);
    procedure ImportFBDExecute(Sender: TObject);
    procedure ImportNonFB2Update(Sender: TObject);
    procedure ImportUserDataExecute(Sender: TObject);
    procedure Export2HTMLExecute(Sender: TObject);
    procedure Export2INPXExecute(Sender: TObject);
    procedure ExportUserDataExecute(Sender: TObject);
    procedure UpdateGenresExecute(Sender: TObject);
    procedure SyncFilesExecute(Sender: TObject);
    procedure RepairDataBaseExecute(Sender: TObject);
    procedure CompactDataBaseExecute(Sender: TObject);
    procedure DeleteCollectionExecute(Sender: TObject);
    procedure AddGroupExecute(Sender: TObject);
    procedure AddGroupUpdate(Sender: TObject);
    procedure RenameGroupExecute(Sender: TObject);
    procedure EditGroupUpdate(Sender: TObject);
    procedure ClearGroupExecute(Sender: TObject);
    procedure ClearGroupUpdate(Sender: TObject);
    procedure DeleteGroupExecute(Sender: TObject);

    //
    // Меню "Редактирование"
    //
    procedure EditBookExecute(Sender: TObject);
    procedure Conver2FBDExecute(Sender: TObject);
    procedure EditAuthorExecute(Sender: TObject);
    procedure EditAuthorUpdate(Sender: TObject);
    procedure EditSeriesExecute(Sender: TObject);
    procedure EditSerieUpdate(Sender: TObject);
    procedure EditGenresExecute(Sender: TObject);
    procedure EditGenreUpdate(Sender: TObject);

    //
    // Меню "Вид"
    //
    procedure ShowMainToolbarExecute(Sender: TObject);
    procedure ShowMainToolbarUpdate(Sender: TObject);
    procedure ShowEditToolbarExecute(Sender: TObject);
    procedure ShowEditToolbarUpdate(Sender: TObject);
    procedure ShowRusAlphabetExecute(Sender: TObject);
    procedure ShowRusAlphabetUpdate(Sender: TObject);
    procedure ShowEngAlphabetExecute(Sender: TObject);
    procedure ShowEngAlphabetUpdate(Sender: TObject);
    procedure ShowStatusbarExecute(Sender: TObject);
    procedure ShowStatusbarUpdate(Sender: TObject);
    procedure ShowBookInfoPanelExecute(Sender: TObject);
    procedure ShowBookInfoPanelUpdate(Sender: TObject);
    procedure ShowBookCoverExecute(Sender: TObject);
    procedure ShowBookCoverUpdate(Sender: TObject);
    procedure ShowBookAnnotationExecute(Sender: TObject);
    procedure ShowBookAnnotationUpdate(Sender: TObject);
    procedure HideDeletedBooksExecute(Sender: TObject);
    procedure HideDeletedBooksUpdate(Sender: TObject);
    procedure ShowLocalOnlyExecute(Sender: TObject);
    procedure ShowLocalOnlyUpdate(Sender: TObject);

    //
    // Меню "Инструменты"
    //
    procedure QuickSearchExecute(Sender: TObject);
    procedure UpdateOnlineCollectionExecute(Sender: TObject);
    procedure ClearReadFolderExecute(Sender: TObject);
    procedure ChangeSettingsExecute(Sender: TObject);

    //
    // Меню "Помощь"
    //
    procedure ShowHelpExecute(Sender: TObject);
    procedure CheckUpdatesExecute(Sender: TObject);
    procedure GoForumExecute(Sender: TObject);
    procedure GoSiteExecute(Sender: TObject);
    procedure ShowAboutExecute(Sender: TObject);

    //
    //
    //
    procedure tbSelectAllClick(Sender: TObject);
    procedure pmiCheckAllClick(Sender: TObject);
    procedure pmiDeselectAllClick(Sender: TObject);
    procedure miCopyClBrdClick(Sender: TObject);

    //
    // Работа с группами
    //
    procedure AddBookToGroup(Sender: TObject);
    procedure DeleteBookFromGroup(Sender: TObject);

    //
    // Работа с Search Preset-ами
    //
    procedure cbPresetNameSelect(Sender: TObject);
    procedure DoClearFilter(KeepPreset: boolean);
    procedure DoApplyFilter(Sender: TObject);
    procedure PresetFieldKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ShowGenreEditor(Sender: TObject);
    procedure edFGenreKeyPress(Sender: TObject; var Key: Char);
    procedure ShowExpressionEditor(Sender: TObject);
    procedure SaveSearchPreset(Sender: TObject);
    procedure DeleteSearchPreset(Sender: TObject);
    procedure SavePresetUpdate(Sender: TObject);
    procedure DeletePresetUpdate(Sender: TObject);

    //
    //
    //
    procedure tbCollapseClick(Sender: TObject);
    procedure edLocateAuthorChange(Sender: TObject);
    procedure miActiveCollectionClick(Sender: TObject);
    procedure CopyToCollectionClick(Sender: TObject);
    procedure miGoToAuthorClick(Sender: TObject);
    procedure ShowBookInfo(Sender: TObject);
    procedure miCopyAuthorClick(Sender: TObject);
    procedure pgControlChange(Sender: TObject);

    procedure btnSwitchTreeModeClick(Sender: TObject);
    //
    //
    //
    procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure tbClearEdAuthorClick(Sender: TObject);
    procedure btnClearEdSeriesClick(Sender: TObject);
    procedure HeaderPopupItemClick(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure InfoPanelResize(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure btnStartDownloadClick(Sender: TObject);
    procedure btnPauseDownloadClick(Sender: TObject);
    procedure btnDeleteDownloadClick(Sender: TObject);
    procedure mi_dwnl_LocateAuthorClick(Sender: TObject);
    procedure btnClearDownloadClick(Sender: TObject);
    procedure MoveDwnldListNodes(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure edLocateAuthorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure miAddToSearchClick(Sender: TObject);
    procedure pmAuthorPopup(Sender: TObject);
    procedure GroupMenuItemClick(Sender: TObject);
    procedure miDeleteFilesClick(Sender: TObject);
    procedure pmiSelectAllClick(Sender: TObject);
    procedure tbtnAutoFBDClick(Sender: TObject);
    procedure AuthorLinkClicked(Sender: TObject; const Link: string; LinkType: TSysLinkType);
    procedure GenreLinkClicked(Sender: TObject; const Link: string; LinkType: TSysLinkType);
    procedure SeriesLinkClicked(Sender: TObject; const Link: string; LinkType: TSysLinkType);
    procedure UpdateBookAction(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure StatusBarResize(Sender: TObject);
    procedure tmrCheckUpdatesTimer(Sender: TObject);
    procedure acBookAdd2FavoritesExecute(Sender: TObject);
    procedure acBookAdd2GroupExecute(Sender: TObject);
    procedure acBookRemoveFromGroupExecute(Sender: TObject);
    procedure pgControlDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure tbtnWizardClick(Sender: TObject);
    procedure acViewSetInfoPriorityExecute(Sender: TObject);
    procedure tmrSearchSTimer(Sender: TObject);
    procedure tmrSearchATimer(Sender: TObject);
    procedure edLocateSeriesChange(Sender: TObject);
    procedure cbLangSelectAChange(Sender: TObject);
    procedure btnClearFilterEditsClick(Sender: TObject);
    procedure pmMarkSelectedClick(Sender: TObject);
    procedure tvAuthorsMeasureTextHeight(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      const Text: string; var Extent: Integer);  // Выбор языка в списке

  protected
    procedure WMGetSysCommand(var Message: TMessage); message WM_SYSCOMMAND;
    procedure OnChangeLocalStatus(var Message: TLocalStatusChangedMessage); message WM_MHL_CHANGELOCALSTATUS;

  private type
    TView = (AuthorsView, SeriesView, GenresView, SearchView, FavoritesView, DownloadView);

    TSortSetting = record
      Column: TColumnIndex;
      Direction: TSortDirection;
    end;

  private
    FDMThread: TDownloadManagerThread;
    FCurrentBookOnly: Boolean;
    FInvisible: Boolean;
    FTimerDone: Boolean;
    FIgnoreAuthorChange: Boolean;
    FLangSelected: Boolean;

    function IsSelectedBookNode(Node: PVirtualNode; Data: PBookRecord): Boolean;

    //
    // Построение деревьев
    //
    procedure FillBooksTree(
      const Tree: TBookTree;
      const LangSelector: TComboBox;
      const BookIterator: IBookIterator;
      ShowAuth: Boolean;
      ShowSer: Boolean;
      SelectedID: PBookKey
    ); overload;

    //
    // TODO -oNickR -cRefactoring : вынести эти методы в соответствующие датамодули
    //
    procedure ReadINIData;

    function GetViewTree(view: TView): TBookTree;
    procedure GetActiveTree(var Tree: TBookTree);
    procedure Selection(SelState: Boolean);
    procedure LocateAuthor(const Text: string);
    procedure LocateSeries(const Text: string);

    procedure CloseCollection;
    procedure InitCollection;

    procedure CreateCollectionMenu;
    procedure CreateScriptMenu;
    procedure SetColors;
    procedure CreateAlphabetToolbar;

    // Handlers:
    procedure OnReadBookHandler(const BookRecord: TBookRecord);
    procedure OnSelectBookHandler(MoveForward: Boolean);
    procedure OnGetBookHandler(var BookRecord: TBookRecord);
    procedure OnUpdateBookHandler(const BookRecord: TBookRecord);
    procedure OnChangeBook2ZipHandler(const BookRecord: TBookRecord);
    function OnHelpHandler(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean;
    procedure OnImportUserDataHandler(const UserDataSource: TUserData);

  private type
    TNodeProcessProc = reference to procedure(Tree: TBookTree; Node: PVirtualNode);
    TNodeUpdateProc = reference to procedure(Data: PBookRecord);

  strict private
    //
    // Проверяет возможность редактирования информации (о книге, если задано).
    // В случае если книга из онлайн коллекции предлагает перейти на сайт для изменения информации там
    //
    function IsLibRusecEdit(const BookKey: TBookKey): Boolean;

    //
    // Применяет операцию ProcessProc ко всем помеченным нодам или (ели ничего не отмечено) к текущей ноде.
    // Note: После применения ноды автоматически не обновляются!!!
    //
    procedure ProcessNodes(ProcessProc: TNodeProcessProc);

    //
    // Обновить во всех деревьях ноду BookID:DatabaseID (если есть).
    // Обновления не должны менять положение ноды в дереве.
    //
    procedure UpdateNodes(const BookKey: TBookKey; UpdateProc: TNodeUpdateProc);

    //
    // Обновить статус книги (присутствует локально)
    //
    procedure SetBookLocalStatus(const BookKey: TBookKey; IsLocal: Boolean);

    //
    // Восстанавить тулбар в правильной позиции
    //
    procedure ChangeToolbarVisability(ToolBars: array of TToolBar; ToolBar: TToolBar; ShowToolbar: Boolean);

    //
    // Проверяет, не является ли текущая коллекция онлайн-коллекцией.
    // Для онлайн-коллекции запрещает и прячет Action.
    // Результат: True - Action был обновлен
    //
    function UpdateEditAction(Action: TAction): Boolean;

    //
    // Проверяет, что текущий режим просмотра "по группа" и соответственно разрешает или запрещает
    //
    function InternalUpdateGroupAction(Action: TAction): Boolean;

    //
    // Возвращает кнопку, соответствующую заданному фильтру.
    //
    function GetFilterButton(ToolBars: array of TToolBar; const Filter: string): TToolButton;

    //
    // Обработчик события для кнопок алфавитного тулбара на странице "Авторы"
    //
    function InternalSetAuthorFilter(Button: TToolButton): string;
    procedure OnSetAuthorFilter(Sender: TObject);

    //
    // Обработчик события для кнопок алфавитного тулбара на странице "Серии"
    //
    function InternalSetSeriesFilter(Button: TToolButton): string;
    procedure OnSetSerieFilter(Sender: TObject);

  public
    procedure OnSetControlsStateHandler(State: Boolean);

    procedure LocateBook(const Text: string; MoveForward: Boolean);
    procedure LocateAuthorAndBook(const FullAuthorName: string; const BookKey: TBookKey);

    procedure SetFormState;

  private
    FController: TTreeController;
    FCollection: IBookCollection;

    FSelectionState: Boolean;

    FAutoCheck: Boolean;
    FFormBusy: Boolean;

    FFileOpMode: (fmFb2Zip, fmFb2);

    FMainBars: array [0 .. 1] of TToolBar;
    FAuthorBars: array [0 .. 1] of TToolBar;
    FSerieBars: array [0 .. 1] of TToolBar;

    FLastLetterA: TToolButton;
    FLastLetterS: TToolButton;

    FSortSettings: array [0 .. 5] of TSortSetting;

    FLastFoundBook: PVirtualNode;
    FFirstFoundBook: PVirtualNode;
    FLastDeviceDir: string;

    //
    // автор и серия, которым _реально_ принадлежат книги, показываемые сейчас в списке
    // т. к. обновление списка происходит с задержкой, значения могут не совпадать в ID выбранных элементов
    //
    FLastAuthorID: Integer;
    FLastAuthorStr: String;
    FLastAuthorBookID: TBookKey;
    FLastSeriesID: Integer;
    FLastSeriesStr: string;
    FLastSeriesBookID: TBookKey;
    FLastGenreCode: string;
    FLastGenreIsContainer: Boolean;
    FLastGenreBookID: TBookKey;
    FLastGroupID: Integer;
    FLastGroupBookID: TBookKey;

    // SB
    FStatusProgressBar: TProgressBar;
    // SB

    FPresets: TSearchPresets;

    // Filters for the iterators:
    FSearchCriteria: TBookSearchCriteria;

    FSystemData: ISystemData;

    function AuthorBookFilter: TFilterValue;
    function SeriesBookFilter: TFilterValue;
    function GenreBookFilter: TFilterValue;

    //
    function GetBookNode(const Tree: TBookTree; const BookKey: TBookKey): PVirtualNode; overload;

    procedure FillBookIdList(const Tree: TBookTree; var BookIDList: TBookIdList; const Uncheck: Boolean = True);
    procedure ClearLabels(Tag: Integer; Full: Boolean);
    procedure FillAllBooksTree;
    function CheckLibUpdates(Auto: Boolean): Boolean;
    procedure SetInfoPanelHeight(Height: Integer);
    procedure SetInfoPanelVisible(State: Boolean);
    procedure SetShowBookCover(State: Boolean);
    procedure SetShowBookAnnotation(State: Boolean);
    procedure SetColumns;
    procedure SaveColumns;
    procedure SetHeaderPopUp;
    procedure DownloadBooks(CurrentBookOnly: boolean = False);
    function CheckActiveDownloads: Boolean;

    function GetActiveView: TView;
    procedure StartLibUpdate;
    procedure CreateGroupsMenu;
    procedure SaveMainFormSettings;

    procedure UpdatePositions;

    function ShowNCWizard: Boolean;
    function LoadLastCollection: boolean;
    procedure SetShowStatusProgress(const Value: Boolean);
    procedure SetStatusProgress(const Value: Integer);
    function GetShowStatusProgress: Boolean;
    function GetStatusProgress: Integer;
    function GetStatusMessage: string;
    procedure SetStatusMessage(const Value: string);
    procedure UpdateAllEditActions;
    procedure AddCurrentToList(const Tree: TBookTree; var BookIDList: TBookIdList);
    procedure SavePositions;
    procedure SetBookInfoPriority(State: Boolean);
    procedure ShowBookDelete(Sender: TObject);
    procedure LoadPresets;
    procedure ConnectTreeControllers;
    procedure InitFormFileds;
    procedure UpdateSplashScreen(const AStatus: string);
    procedure LoadDownloadsList;
    procedure ClearDataFolder;
    property ActiveView: TView read GetActiveView;

    property ShowStatusProgress: Boolean read GetShowStatusProgress write SetShowStatusProgress;
    property StatusMessage: string read GetStatusMessage write SetStatusMessage;
    property StatusProgress: Integer read GetStatusProgress write SetStatusProgress;
  end;

var
  frmMain: TfrmMain;

const
  CHECK_FILE = 'TheFirstRun.check';

implementation

uses
  StrUtils,
  DateUtils,
  IOUtils,
  Character,
  Generics.Collections,
  Math,
  fictionbook_21,
  unit_FB2Utils,
  unit_Columns,
  frm_statistic,
  frm_splash,
  frm_settings,
  frm_genre_tree,
  frm_edit_book_info,
  frm_edit_author,
  frm_book_info,
  frm_bases,
  frm_add_nonfb2,
  frm_about,
  unit_MHLHelpers,
  unit_MHLGenerics,
  unit_TreeUtils,
  unit_MHL_strings,
  unit_Settings,
  dm_user,
  unit_Import,
  unit_Consts,
  unit_Export,
  unit_Utils,
  unit_ExportToDevice,
  unit_Helpers,
  unit_Errors,
  unit_Logger,
  frm_NewCollectionWizard,
  frm_editor,
  unit_SearchUtils,
  unit_WriteFb2Info,
  frm_ConverToFBD,
  frm_EditAuthorEx,
  unit_Lib_Updates,
  frm_EditGroup,
  unit_SystemDatabase_Abstract,
  unit_MHLArchiveHelpers,
  frm_DeleteCollection, unit_ImportOldUserData;

resourcestring
  rstrFileNotFoundMsg = 'Файл %s не найден!' + CRLF + 'Проверьте настройки коллекции!';
  rstrCreatingFilter = 'Подготовка фильтра ...';
  rstrApplyingFilter = 'Применяем фильтр ...';
  rstrNoUpdatesAvailable = 'Нет доступных обновлений';
  rstrNotFromDownloadsError = 'Операция недоступна из списка закачек.';
  rstrNotForExtension = 'Операция недоступна для файлов с расширением %s';
  rstrUnableDeleteBuiltinGroupError = 'Нельзя удалить встроенную группу!';
  rstrCheckingUpdates = 'Проверка обновлений ...';
  rstrGroupAlreadyExists = 'Группа с таким именем уже существует!';
  rstrAdding2GroupMessage = 'Добавляем книги в группу...';
  rstrRemovingFromGroupMessage = 'Удаляем книги из группы...';
  rstrBuildingListMessage = 'Построение списка ...';

  rstrHintTable = 'Переключится в режим "Таблица"';
  rstrHintTree = 'Переключится в режим "Дерево"';
  rstrShuttingDown = 'отключаемся';
  rstrNeedDBUpgrade = 'Вы успешно обновили программу. Для нормальной работы необходимо обновить струткуру таблиц БД. Сделать это прямо сейчас?';
  rstrFirstRun = 'MyHomeLib - первый запуск';
//  rstrToConvertChangeTab = 'Для конвертирования книги перейдите на другую страницу.';
  rstrCollectionFileNotFound = 'Файл коллекции не найден.' + CRLF + 'Невозможно запустить программу.';
  // rstrStartCollectionUpdate = 'Доступно обновление коллекций.' + CRLF + ' Начать обновление ?';
  rstrStarting = 'Старт ...';
  rstrUnfinishedDownloads = 'В списке есть незавершенные закачки!' + CRLF + 'Вы все еще хотите выйти из программы?';
  rstrSingleSeries = 'Серия: ';
  rstrDownloadStateWaiting = 'Ожидание';
  rstrDownloadStateDownloading = 'Закачка';
  rstrDownloadStateDone = 'Готово';
  rstrDownloadStateError = 'Ошибка';
  rstrNoBookSelected = 'Ни одной книги не выбрано!';
  rstrProvideThePath = 'Укажите путь';
  rstrCheckUsage = 'Проверить использование, возможна ошибка';
  rstrBuildingTheList = 'Построение списка ...';
  rstrChangeCollectionToRemoveABook = 'Для удаления книги перейдите в соответствующую коллекцию';
  rstrRemoveSelectedBooks = 'Удалить выбранные книги из базы?';
  rstrRemoveSelectedBooksFiles = 'Удалить выбранные книги из базы вместе с файлами?';
  rstrRemoveSelectedBooksOnLine = 'Удалить скачанные файлы?';
  rstrRemoveCollection = 'Удалить коллекцию ';
  rstrGoToLibrarySite = 'Изменения информации о книгах в онлайн-коллекциях возможно только на сайте.' + CRLF + 'Перейти на сайт электронной библиотеки "%s"?';
  rstrUnableToEditBooksFromFavourites = 'Редактирование книг из избранного невозможно.';
  rstrCreateMoveSeries = 'Создание серии / Перенос в серию';
  rstrTitle = 'Название:';
  rstrEditSeries = 'Редактирование серии';
  rstrAddingBookToGroup = 'Добавляем книги в группу...';
  rstrRemovingBookFromGroup = 'Удаляем книги из группы...';
  rstrNeedSpecialDataTypeForSeries = 'Необходимо использовать отдельный тип данных для серии';
  rstrBookNotFoundInArchive = 'В архиве "%s" не найдено описание книги!';
  rstrCollectionNotRegistered = 'Коллекция не зарегистрирована !';
  rstrRemoveFromGroup = 'Удалить из группы';
  rstrRemoveFromDownloadList = 'Удалить из списка закачек';
  rstrAddToFavorites = 'Добавить в избранное';
  rstrAddToDownloads = 'Добавить в список закачек';
  rstrCollectionUpdateAvailable = 'Доступно обновление для коллекций.' + CRLF + ' Начать обновление ?';
  rsrtNewCollectin = 'Новая коллекция ...';
  rstrSelectFolder = 'Выбор папки ...';
{$R *.dfm}

//
// Helpers
//

var
  IsPrivate: Boolean;
  IsOnline: Boolean;
  IsLocal: Boolean;
  IsFB2: Boolean;
  IsNonFB2: Boolean;

const
  TreeIcons: array [0 .. 1] of Integer = (10, 11);
  TreeHints: array [0 .. 1] of string = (rstrHintTable, rstrHintTree);

function TfrmMain.CheckActiveDownloads: Boolean;
var
  Data: PDownloadData;
  Node: PVirtualNode;
begin
  Result := False;
  Node := tvDownloadList.GetFirst;
  while Assigned(Node) do
  begin
    Data := tvDownloadList.GetNodeData(Node);
    if Data.State = dsRun then
    begin
      Result := True;
      Break;
    end;
    Node := tvDownloadList.GetNext(Node);
  end;
end;

procedure TfrmMain.WMGetSysCommand(var Message: TMessage);
begin
  if Message.Msg = WM_Destroy then
  begin
    ShowMessage(rstrShuttingDown);
    inherited;
  end;

  if (Message.wParam = SC_MINIMIZE) and Settings.MinimizeToTray then
  begin
    TrayIcon.Visible := True;
    Hide;
  end
  else
    inherited;
end;

procedure TfrmMain.SetColumns;
var
  Columns: TColumns;
begin
  Columns := TColumns.Create(Settings.SystemFileName[sfColumnsStore]);
  try

    if Settings.TreeModes[PAGE_AUTHORS] = tmTree then
      Columns.Load(SECTION_A_TREE, tmTree)
    else
      Columns.Load(SECTION_A_FLAT, tmFlat);
    Columns.SetColumns(tvBooksA.Header.Columns);

    if Settings.TreeModes[PAGE_SERIES] = tmTree then
      Columns.Load(SECTION_S_TREE, tmTree)
    else
      Columns.Load(SECTION_S_FLAT, tmFlat);
    Columns.SetColumns(tvBooksS.Header.Columns);

    if Settings.TreeModes[PAGE_GENRES] = tmTree then
      Columns.Load(SECTION_G_TREE, tmTree)
    else
      Columns.Load(SECTION_G_FLAT, tmFlat);
    Columns.SetColumns(tvBooksG.Header.Columns);

    if Settings.TreeModes[PAGE_FAVORITES] = tmTree then
      Columns.Load(SECTION_F_TREE, tmTree)
    else
      Columns.Load(SECTION_F_FLAT, tmFlat);
    Columns.SetColumns(tvBooksF.Header.Columns);

    if Settings.TreeModes[PAGE_SEARCH] = tmTree then
      Columns.Load(SECTION_SR_TREE, tmTree)
    else
      Columns.Load(SECTION_SR_FLAT, tmFlat);
    Columns.SetColumns(tvBooksSR.Header.Columns);

    (* REMOVE
    if Settings.TreeModes[PAGE_FILTER] = tmTree then
      Columns.Load(SECTION_FL_TREE, tmTree)
    else
      Columns.Load(SECTION_FL_FLAT, tmFlat);
    *)

    // -------------------------------------------------------------------------
    tvBooksA.Header.MainColumn := 1;
    tvBooksS.Header.MainColumn := 1;
    tvBooksG.Header.MainColumn := 1;
    tvBooksF.Header.MainColumn := 1;
    tvBooksSR.Header.MainColumn := 1;

  finally
    Columns.Free;
  end;
end;

procedure TfrmMain.SaveColumns;
var
  Columns: TColumns;
begin
  Columns := TColumns.Create(Settings.SystemFileName[sfColumnsStore]);
  try
    Columns.GetColumns(tvBooksA.Header.Columns);
    if Settings.TreeModes[PAGE_AUTHORS] = tmTree then
      Columns.Save(SECTION_A_TREE)
    else
      Columns.Save(SECTION_A_FLAT);

    Columns.GetColumns(tvBooksS.Header.Columns);
    if Settings.TreeModes[PAGE_SERIES] = tmTree then
      Columns.Save(SECTION_S_TREE)
    else
      Columns.Save(SECTION_S_FLAT);

    Columns.GetColumns(tvBooksG.Header.Columns);
    if Settings.TreeModes[PAGE_GENRES] = tmTree then
      Columns.Save(SECTION_G_TREE)
    else
      Columns.Save(SECTION_G_FLAT);

    Columns.GetColumns(tvBooksF.Header.Columns);
    if Settings.TreeModes[PAGE_FAVORITES] = tmTree then
      Columns.Save(SECTION_F_TREE)
    else
      Columns.Save(SECTION_F_FLAT);

    (* REMOVE
    if Settings.TreeModes[PAGE_FILTER] = tmTree then
      Columns.Save(SECTION_FL_TREE)
    else
      Columns.Save(SECTION_FL_FLAT);
    *)

    Columns.GetColumns(tvBooksSR.Header.Columns);
    if Settings.TreeModes[PAGE_SEARCH] = tmTree then
      Columns.Save(SECTION_SR_TREE)
    else
      Columns.Save(SECTION_SR_FLAT);
  finally
    Columns.Free;
  end;
end;

procedure TfrmMain.SetColors;
var
  BGColor: TColor;
  TreeFontSize: Integer;
  FontColor: TColor;
  ShortFontSize : Integer;

  procedure SetTreeViewColor(AControl: TBookTree);
  var
    Height: cardinal;
  begin
    AControl.Color := BGColor;
    AControl.Font.Size := TreeFontSize;
    AControl.ReinitNode(AControl.GetFirst, True);
    AControl.Font.Size := TreeFontSize;
    Height := AControl.Canvas.TextHeight('Щ');
    AControl.DefaultNodeHeight := round(Height  + TreeFontSize / 4);
    AControl.Header.Height := TreeFontSize * 2;
    AControl.Font.Color := FontColor;
  end;

  procedure SetTreeViewColor2(AControl: TVirtualStringTree);
  var
    Height: cardinal;
  begin
    AControl.Color := BGColor;
    AControl.ReinitNode(AControl.GetFirst, True);
    AControl.Font.Size := TreeFontSize;
    Height := AControl.Canvas.TextHeight('Щ');
    AControl.DefaultNodeHeight := round(Height  + TreeFontSize / 4);
    AControl.Font.Color := FontColor;
  end;

  procedure SetPnlColor(AControl: TInfoPanel);
  begin
    AControl.Color := BGColor;
    AControl.Font.Size := ShortFontSize;
    AControl.Font.Color := FontColor;
  end;

begin
  BGColor := Settings.BGColor;
  TreeFontSize := Settings.TreeFontSize;
  FontColor := Settings.FontColor;
  ShortFontSize := Settings.ShortFontSize;

  SetTreeViewColor2(tvAuthors);
  SetTreeViewColor(tvBooksA);
  SetTreeViewColor2(tvSeries);
  SetTreeViewColor(tvBooksS);
  SetTreeViewColor2(tvGenres);
  SetTreeViewColor(tvBooksG);
  SetTreeViewColor(tvBooksSR);
  SetTreeViewColor2(tvGroups);
  SetTreeViewColor(tvBooksF);
  SetTreeViewColor(tvDownloadList);

  edFFullName.Color := BGColor;
  edFTitle.Color := BGColor;
  edFSeries.Color := BGColor;
  edFGenre.Color := BGColor;
  edFFile.Color := BGColor;
  edFFolder.Color := BGColor;
  edFExt.Color := BGColor;
  edFKeyWords.Color := BGColor;
  edFAnnotation.Color := BGColor;

  cbDate.Color := BGColor;
  cbLang.Color := BGColor;
  cbLibrate.Color := BGColor;

  tsByAuthor.Color := clMenuBar;
  tsBySerie.Color := clMenuBar;
  tsByGenre.Color := clMenuBar;
  tsByGroup.Color := clMenuBar;
  tsSearch.Color := clMenuBar;
  tsDownload.Color := clMenuBar;

  edLocateAuthor.Color := BGColor;
  edLocateSeries.Color := BGColor;
  cbPresetName.Color := BGColor;

  SetPnlColor(ipnlAuthors);
  SetPnlColor(ipnlSeries);
  SetPnlColor(ipnlGenres);
  SetPnlColor(ipnlFavorites);
  SetPnlColor(ipnlSearch);

end;

procedure TfrmMain.ReadINIData;
begin
  //
  // Синхронизация с настройками
  //
  tlbrMain.Visible := Settings.ShowToolbar;
  tlbrEdit.Visible := Settings.EditToolBarVisible;
  tbarAuthorsRus.Visible := Settings.ShowRusBar;
  tbarSeriesRus.Visible := Settings.ShowRusBar;
  tbarAuthorsEng.Visible := Settings.ShowEngBar;
  tbarSeriesEng.Visible := Settings.ShowEngBar;
  StatusBar.Visible := Settings.ShowStatusBar;
  SetInfoPanelHeight(Settings.InfoPanelHeight);
  SetInfoPanelVisible(Settings.ShowInfoPanel);
  SetShowBookCover(Settings.ShowBookCover);
  SetShowBookAnnotation(Settings.ShowBookAnnotation);
  SetBookInfoPriority(Settings.Fb2InfoPriority);
  miBookInfoPriority.Checked := Settings.Fb2InfoPriority;

  if Settings.DefaultScript <> 0 then
  begin
    tbSendToDevice.Tag := 900 + Settings.DefaultScript;
    pmiSendToDevice.Tag := 900 + Settings.DefaultScript;
    miDevice.Tag := 900 + Settings.DefaultScript;
  end
  else
  begin
    tbSendToDevice.Tag := 0;
    pmiSendToDevice.Tag := 0;
    miDevice.Tag := 0;
  end;

  ipnlAuthors.Font.Size := Settings.ShortFontSize;
  ipnlSeries.Font.Size := Settings.ShortFontSize;
  ipnlGenres.Font.Size := Settings.ShortFontSize;
  ipnlFavorites.Font.Size := Settings.ShortFontSize;
  ipnlSearch.Font.Size := Settings.ShortFontSize;

  pnAuthorsView.Width := Settings.Splitters[0];
  pnSeriesView.Width := Settings.Splitters[1];
  pnGenresView.Width := Settings.Splitters[2];
  pnSearchView.Width := Settings.Splitters[3];
  pnGroupsView.Width := Settings.Splitters[4];

  ctpBook.Collapsed := Settings.BookSRCollapsed;
  ctpFile.Collapsed := Settings.FileSRCollapsed;
  ctpOther.Collapsed := Settings.OtherSRCollapsed;

  pgControl.ActivePageIndex := Settings.ActivePage;
  pgControlChange(nil); // update the toolbar, etc

  SetColors;
end;

procedure TfrmMain.DoApplyFilter(Sender: TObject);
var
  SavedCursor: TCursor;
  BookIterator: IBookIterator;
begin
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crSQLWait;
  try
    StatusMessage := rstrCreatingFilter;
    try
      tvBooksSR.Clear;
      ClearLabels(tvBooksSR.Tag, True);

      try
        FSearchCriteria.FullName := edFFullName.Text;
        FSearchCriteria.Series := edFSeries.Text;
        FSearchCriteria.Annotation := edFAnnotation.Text;
        FSearchCriteria.Genre := edFGenre.Hint;
        FSearchCriteria.Title := edFTitle.Text;
        FSearchCriteria.FileName := edFFile.Text;
        FSearchCriteria.Folder := edFFolder.Text;
        FSearchCriteria.FileExt := edFExt.Text;
        FSearchCriteria.Lang := cbLang.Text;
        FSearchCriteria.Keyword := edFKeyWords.Text;
        FSearchCriteria.DownloadedIdx := cbDownloaded.ItemIndex;
        FSearchCriteria.Deleted := cbDeleted.Checked;
        FSearchCriteria.LibRate := cbLibRate.Text;
        FSearchCriteria.Readed := cbReaded.Checked;

        FSearchCriteria.DateIdx := cbDate.ItemIndex;
        if FSearchCriteria.DateIdx= -1 then
          FSearchCriteria.DateText := cbDate.Text;

        Assert(Assigned(FCollection));
        BookIterator := FCollection.Search(FSearchCriteria, False);

        // Ставим фильтр
        StatusMessage := rstrApplyingFilter;
        FillBooksTree(tvBooksSR, nil, BookIterator, True, True, nil);
      except
        on E: Exception do
          MHLShowError(rstrFilterParamError);
      end;
    finally
      StatusMessage := rstrReadyMessage;
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.DoClearFilter(KeepPreset: boolean);
begin
  if not KeepPreset then   cbPresetName.ItemIndex := -1;

  edFFullName.Text := '';
  edFTitle.Text := '';
  edFSeries.Text := '';
  edFGenre.Text := '';
  edFGenre.Hint := '';
  edFAnnotation.Text := '';

  edFFile.Text := '';
  edFFolder.Text := '';
  edFExt.Text := '';

  cbDownloaded.ItemIndex := 0;
  edFKeyWords.Text := '';
  cbDeleted.Checked := False;
  cbDate.ItemIndex := -1;
  cbDate.Text := '';
  cbLang.ItemIndex := -1;
  cbLang.Text := '';
  cbLibRate.ItemIndex := -1;
  cbLibRate.Text := '';
  cbReaded.Checked := False;

  tvBooksSR.Clear;
  ClearLabels(PAGE_SEARCH, True);
end;

function TfrmMain.GetActiveView: TView;
const
  //
  // ВНИМАНИЕ!!! Порядок и количество элементов массива views должно совпадать с порядком и количеством закладок
  //
  views: array [0 .. 5] of TView = (AuthorsView, SeriesView, GenresView, SearchView, FavoritesView, DownloadView);

begin
  Result := views[pgControl.ActivePageIndex];
end;

procedure TfrmMain.OnSetControlsStateHandler(State: Boolean);
begin
  frmMain.Enabled := State;
end;

procedure TfrmMain.SavePositions;
begin
  if FCollection <> nil then
  begin
    FCollection.SetProperty(PROP_LAST_AUTHOR, FLastAuthorStr);
    FCollection.SetProperty(PROP_LAST_AUTHOR_BOOK, FLastAuthorBookID.BookID);
    FCollection.SetProperty(PROP_LAST_SERIES, FLastSeriesStr);
    FCollection.SetProperty(PROP_LAST_SERIES_BOOK, FLastSeriesBookID.BookID);

    FCollection.SetProperty(PROP_BOOKS_LANG_FILTER, cbLangSelectA.ItemIndex);
    FCollection.SetProperty(PROP_SERIES_LANG_FILTER, cbLangSelectS.ItemIndex);
    FCollection.SetProperty(PROP_GENRES_LANG_FILTER, cbLangSelectG.ItemIndex);
    FCollection.SetProperty(PROP_GROUPS_LANG_FILTER, cbLangSelectF.ItemIndex);
  end;
end;

procedure TfrmMain.CloseCollection;
var
  FCursor: TCursor;
begin
  FCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    SavePositions;

    tvAuthors.Clear;
    tvSeries.Clear;
    tvGenres.Clear;
    tvBooksSR.Clear;
    tvBooksF.Clear;

    SetTextNoChange(edLocateAuthor, '');
    SetTextNoChange(edLocateSeries, '');

    FLastAuthorID := MHL_INVALID_ID;
    FLastAuthorBookID.Clear;

    FLastSeriesID := MHL_INVALID_ID;
    FLastSeriesBookID.Clear;

    FLastGenreCode := '';
    FLastGenreIsContainer := False;
    FLastGenreBookID.Clear;

    FLastGroupID := MHL_INVALID_ID;
    FLastGroupBookID.Clear;

    FCollection := nil;
  finally
    Screen.Cursor := FCursor;
  end;
end;

procedure TfrmMain.InitCollection;
var
  SavedCursor: TCursor;
  CollectionType: Integer;
  EmptySearchCriteria: TBookSearchCriteria;
  Acount, Scount, GCount: integer;
  Button: TToolButton;
  FSA, FSS: string;

  procedure FindLastBook(ID: integer; Tree: TBookTree);
  var Node: PVirtualNode;
      Data: PBookRecord;
  begin
    if ID = 0 then Exit;
    
    Node := Tree.GetFirst;
    while Node <> Nil do
    begin
      Data := Tree.GetNodeData(Node);
      if Data.BookKey.BookID = ID then
      begin
        Tree.ClearSelection;
        Tree.Selected[Node] := True;
        Tree.FocusedNode := Node;
        Break;
      end;
      Node := Tree.GetNext(Node);
    end;
  end;

  procedure RestoreLangFilter(const Index: integer; LangComboBox: TComboBox);
  begin
    LangComboBox.ItemIndex := Index;
    cbLangSelectAChange(LangComboBox);
  end;


begin
  FIgnoreAuthorChange := True;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  FInvisible := True;
  try
    FSearchCriteria := EmptySearchCriteria;

    CloseCollection;

    //
    // Если коллекций нет - запустим мастера создания коллекции.
    //
    if (not LoadLastCollection)or (not FSystemData.HasCollections) then
    begin
      frmMain.Caption := 'MyHomeLib';
      Screen.Cursor := SavedCursor;

      if not ShowNCWizard then
        Application.Terminate;

      DeleteFile(Settings.WorkPath + CHECK_FILE);
      Exit;
    end;

    FCollection := FSystemData.GetCollection(Settings.ActiveCollection);

    Assert(Assigned(FCollection));
    frmMain.Caption := 'MyHomeLib - ' + FCollection.CollectionDisplayName;

    // определяем типы коллекции
    CollectionType := FCollection.CollectionCode;
    IsPrivate := isPrivateCollection(CollectionType);
    IsOnline := isOnlineCollection(CollectionType);
    IsLocal := isLocalCollection(CollectionType);
    IsFB2 := isFB2Collection(CollectionType);
    IsNonFB2 := isNonFB2Collection(CollectionType);

    acEditConver2FBD.Enabled := IsPrivate and not IsFB2;


    //
    // Поиск
    //
    edFAnnotation.Enabled := IsPrivate;

    // --------- Вкладки, прочее  -------------------------------------------------

    tsDownload.TabVisible := IsOnline;
    acBookAdd2DownloadList.Visible := IsOnline;

    if not IsOnline and (ActiveView = DownloadView) then
      pgControl.ActivePageIndex := PAGE_AUTHORS;

    CreateCollectionMenu;
    CreateScriptMenu;
    //
    // Действия, видимость которых зависит от типа коллекции и которые доступны через тулбар, необходимо обновить вручную
    //
    HideDeletedBooksUpdate(nil);
    ShowLocalOnlyUpdate(nil);
    ShowBookDelete(nil);

    FCollection.SetShowLocalOnly(IsOnline and Settings.ShowLocalOnly);
    FCollection.SetHideDeleted((not IsPrivate) and Settings.HideDeletedBooks);

    FCollection.GetStatistics(Acount, Scount, GCount);

    FSA := FCollection.GetProperty(PROP_LAST_AUTHOR);
    if FSA = '' then
      if Acount > 500 then FSA := 'А' else FSA := '*';

    FSS := FCollection.GetProperty(PROP_LAST_SERIES);
    if FSS = '' then
      if Scount > 500 then FSS := 'А' else FSS := '*';

    Button := GetFilterButton(FAuthorBars, Copy(FSA, 1, 1));
    InternalSetAuthorFilter(Button);

    FIgnoreAuthorChange := False;
    LocateAuthor(FSA);

    Button := GetFilterButton(FSerieBars, Copy(FSS, 1, 1));
    InternalSetSeriesFilter(Button);
    LocateSeries(FSS);

    // поскольку убрали обязательный FillBooksTree, нужно принудительно чистить список книг в случе пустого списка авторов
    // в противном случае FillBooksTree вызывалъся повторно

    if tvAuthors.GetFirst = nil then tvAuthorsChange(tvAuthors, nil);
     if tvSeries.GetFirst = nil then tvAuthorsChange(tvSeries, nil);

    //----------------------------------------------------------------------

    FillGenresTree(tvGenres, FCollection.GetGenreIterator(gmAll), False, FLastGenreCode);
    FillGroupsList(tvGroups, FSystemData.GetGroupIterator, FLastGroupID);
    CreateGroupsMenu;

    if ActiveView = AuthorsView then
      miGoToAuthor.Visible := False;

    UpdateActions;
    UpdateAllEditActions;

    // ---- Recover laguage filters
    RestoreLangFilter(FCollection.GetProperty(PROP_BOOKS_LANG_FILTER), cbLangSelectA);
    RestoreLangFilter(FCollection.GetProperty(PROP_SERIES_LANG_FILTER), cbLangSelectS);
    RestoreLangFilter(FCollection.GetProperty(PROP_GENRES_LANG_FILTER), cbLangSelectG);
    RestoreLangFilter(FCollection.GetProperty(PROP_GROUPS_LANG_FILTER), cbLangSelectF);

    FInvisible := False;
    FindLastBook(FCollection.GetProperty(PROP_LAST_AUTHOR_BOOK), tvBooksA);
    FindLastBook(FCollection.GetProperty(PROP_LAST_SERIES_BOOK), tvBooksS);

  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.SeriesLinkClicked(Sender: TObject; const Link: string; LinkType: TSysLinkType);
var
  savedCursor: TCursor;
  seriesID: Integer;
  seriesTitle: string;
  node: PVirtualNode;
  bookTree: TBookTree;
  bookData: PBookRecord;
  bookKey: TBookKey;
  filterValue: TFilterValue;
  Button : TToolButton;
begin
  Assert(Assigned(FCollection));

  // Get current book's key:
  GetActiveTree(bookTree);
  node := bookTree.GetFirstSelected;
  bookData := bookTree.GetNodeData(node);
  if not Assigned(bookData) or (bookData^.nodeType <> ntBookInfo) then
    Exit;
  bookKey := bookData^.BookKey;

  seriesID := StrToInt(Link);
  if bookData.SeriesID <> seriesID then
    Exit // shouldn't happen, just in case
  else
    seriesTitle := bookData^.Series;

  savedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    // Make sure current collection matches the book's one:
    if bookKey.DatabaseID <> FCollection.CollectionID then
    begin
      Settings.ActiveCollection := bookKey.DatabaseID;
      InitCollection;
    end;

    FLastSeriesID := seriesID;

    Button := GetFilterButton(FSerieBars, seriesTitle);
    if Assigned(Button) and (Button <> FLastLetterS) then
    begin
      InternalSetSeriesFilter(Button);
    end;
    LocateSeries(seriesTitle);


    // Fill book tree and locate the book:
    filterValue := SeriesBookFilter; // uses FLastSeriesID initialized earlier
    FLastSeriesBookID := bookKey;
    FillBooksTree(tvBooksS, cbLangSelectS, FCollection.GetBookIterator(bmBySeries, False, @FilterValue), False, False, @FLastSeriesBookID); // серии

    // Change page to Series:
    pgControl.ActivePageIndex := PAGE_SERIES;
    pgControlChange(nil);

  finally
    Screen.Cursor := savedCursor;
  end;
end;

procedure TfrmMain.GenreLinkClicked(Sender: TObject; const Link: string; LinkType: TSysLinkType);
var
  savedCursor: TCursor;
  genreCode: string;
  node: PVirtualNode;
  genreData: PGenreData;
  bookTree: TBookTree;
  bookData: PBookRecord;
  bookKey: TBookKey;
  filterValue: TFilterValue;
begin
  Assert(Assigned(FCollection));

  // Get current book's key:
  GetActiveTree(bookTree);
  node := bookTree.GetFirstSelected;
  bookData := bookTree.GetNodeData(node);
  if not Assigned(bookData) or (bookData^.nodeType <> ntBookInfo) then
    Exit;
  bookKey := bookData^.BookKey;

  savedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    // Make sure current collection matches the book's one:
    if bookKey.DatabaseID <> FCollection.CollectionID then
    begin
      Settings.ActiveCollection := bookKey.DatabaseID;
      InitCollection;
    end;

    // Change page to Genres:
    pgControl.ActivePageIndex := PAGE_GENRES;
    pgControlChange(nil);

    // Locate the genre:
    genreCode := Link;
    node := tvGenres.GetFirst;
    while Assigned(node) do
    begin
      genreData := tvGenres.GetNodeData(node);
      Assert(Assigned(genreData));
      if genreData^.GenreCode = genreCode then
      begin
        tvGenres.Selected[node] := True;
        tvGenres.FocusedNode := node;
        FLastGenreCode := genreCode;
        FLastGenreIsContainer := (node^.ChildCount > 0);
        Break;
      end;
      node := tvGenres.GetNext(node);
    end;

    // Fill book tree and locate the book:
    filterValue := GenreBookFilter; // uses FLastGenreCode initialized earlier
    FLastGenreBookID := bookKey;
    FillBooksTree(tvBooksG, cbLangSelectG, FCollection.GetBookIterator(bmByGenre, False, @filterValue),  True,  True, @FLastGenreBookID);
  finally
    Screen.Cursor := savedCursor;
  end;
end;

procedure TfrmMain.AuthorLinkClicked(Sender: TObject; const Link: string; LinkType: TSysLinkType);
var
  node: PVirtualNode;
  bookTree: TBookTree;
  bookData: PBookRecord;
  bookKey: TBookKey;
  authorData: TAuthorData;
  authorID: Integer;
  authorFullName: string;
begin
  // Get current book's key:
  GetActiveTree(bookTree);
  node := bookTree.GetFirstSelected;
  bookData := bookTree.GetNodeData(node);
  if not Assigned(bookData) or (bookData^.nodeType <> ntBookInfo) then
    Exit;
  bookKey := bookData^.BookKey;

  // decode the link into full author name:
  authorID := StrToInt(Link);
  authorFullName := '';
  for authorData in bookData.Authors do
  begin
    if authorData.AuthorID = authorID then
      authorFullName := authorData.GetFullName;
  end;

  // Locate author and book:
  if authorFullName <> '' then
    LocateAuthorAndBook(authorFullName, bookKey);
end;

procedure TfrmMain.CreateAlphabetToolbar;
const
  EngAlphabet: string = ALPHA_FILTER_ALL + ALPHA_FILTER_NON_ALPHA + LATIN_ALPHABET;
  RusAlphabet: string = ALPHA_FILTER_ALL + ALPHA_FILTER_NON_ALPHA + CYRILLIC_ALPHABET;

var
  Image: TBitmap;
  ImageCanvas: TCanvas;
  ImageRect: TRect;
  AlphaChar: Char;
  ImageIndex: Integer;
  ButtonPosA: Integer;
  ButtonPosS: Integer;
  Button: TToolButton;
  //s0, s1, s2: TSize;

  function CreateTextImage(ImageText: string): Integer;
  begin
    ImageCanvas.FillRect(ImageRect);
    ImageCanvas.Font.Color := clWindowText;
    ImageCanvas.TextRect(ImageRect, ImageText, [tfCenter, tfSingleLine, tfVerticalCenter]);
    ilAlphabetNormal.AddMasked(Image, clBtnFace);

    ImageCanvas.FillRect(ImageRect);
    ImageCanvas.Font.Color := clHotLight;
    ImageCanvas.TextRect(ImageRect, ImageText, [tfCenter, tfSingleLine, tfVerticalCenter]);
    Result := ilAlphabetActive.AddMasked(Image, clBtnFace);
  end;

  function CreateTextButton(
    ToolBar: TToolBar;
    const ACaption: string;
    ImageIndex: Integer;
    FOnClick: TNotifyEvent;
    Position: Integer
  ): Integer;
  begin
    Button := TToolButton.Create(ToolBar);
    Button.Caption := ACaption;
    Button.ImageIndex := ImageIndex;
    Button.OnClick := FOnClick;
    Button.Left := Position;
    Button.Parent := ToolBar;
    Result := Button.Left + Button.Width;
  end;

begin
  Image := TBitmap.Create;
  try
    ImageCanvas := Image.Canvas;

    ImageCanvas.Brush.Color := clBtnFace;
    ImageCanvas.Font := tbarAuthorsRus.Font;
    ImageCanvas.Font.Style := [fsBold];

    (** )
    s0.cx := ilAlphabetNormal.Width;
    s0.cy := ilAlphabetNormal.Height;
    s1 := ImageCanvas.TextExtent('AZ');
    s2 := ImageCanvas.TextExtent('АЯ');
    ilAlphabetNormal.Width := Max(s0.cx, Max(s1.cx, s2.cx));
    ilAlphabetNormal.Height := Max(s0.cy, Max(s1.cy, s2.cy));
    ( **)

    Image.Width := ilAlphabetNormal.Width;
    Image.Height := ilAlphabetNormal.Height;

    ImageRect := Bounds(0, 0, ilAlphabetNormal.Width, ilAlphabetNormal.Height);

    //
    //
    //
    ButtonPosA := 0;
    ButtonPosS := 0;
    for AlphaChar in RusAlphabet do
    begin
      ImageIndex := CreateTextImage(AlphaChar);
      ButtonPosA := CreateTextButton(tbarAuthorsRus, AlphaChar, ImageIndex, OnSetAuthorFilter, ButtonPosA);
      ButtonPosS := CreateTextButton(tbarSeriesRus, AlphaChar, ImageIndex, OnSetSerieFilter, ButtonPosS);
    end;

    ButtonPosA := 0;
    ButtonPosS := 0;
    for AlphaChar in EngAlphabet do
    begin
      ImageIndex := CreateTextImage(AlphaChar);
      ButtonPosA := CreateTextButton(tbarAuthorsEng, AlphaChar, ImageIndex, OnSetAuthorFilter, ButtonPosA);
      ButtonPosS := CreateTextButton(tbarSeriesEng, AlphaChar, ImageIndex, OnSetSerieFilter, ButtonPosS);
    end;
  finally
    Image.Free;
  end;
end;

procedure TfrmMain.CreateCollectionMenu;
var
  SubItem: TMenuItem;
  ActiveCollectionID: Integer;
  CollectionInfoIterator: ICollectionInfoIterator;
  CollectionInfo: TCollectionInfo;

  function GetCollectionTypeImageIndex(const CollectionType: COLLECTION_TYPE): Integer;
  begin
    case CollectionType of
      CT_PRIVATE_FB: Result := 18;
      CT_PRIVATE_NONFB: Result := 8;
      CT_EXTERNAL_LOCAL_FB: Result := 14;
      CT_EXTERNAL_LOCAL_NONFB: Result := 8;
      CT_EXTERNAL_ONLINE_FB: Result := 4;
      CT_EXTERNAL_ONLINE_NONFB: Result := 8;
    else
      // Assert(False);
      Result := 8; { TODO -oNickR -cUsability : нарисовать иконку }
    end;
  end;

begin
  Assert(Assigned(FCollection));
  ActiveCollectionID := FCollection.CollectionID;

  miCollSelect.Clear;
  miCopyToCollection.Clear;
  pmCollection.Items.Clear;

  CollectionInfoIterator := FSystemData.GetCollectionInfoIterator;
  while CollectionInfoIterator.Next(CollectionInfo) do
  begin
    if ActiveCollectionID <> CollectionInfo.ID then
    begin
      // ----------------------------
      SubItem := TMenuItem.Create(miCollSelect);
      SubItem.Caption := CollectionInfo.DisplayName;
      SubItem.Tag := CollectionInfo.ID;
      SubItem.OnClick := miActiveCollectionClick;
      SubItem.ImageIndex := GetCollectionTypeImageIndex(CollectionInfo.CollectionType);
      miCollSelect.Add(SubItem);

      // ----------------------------
      SubItem := TMenuItem.Create(pmCollection);
      SubItem.Caption := CollectionInfo.DisplayName;
      SubItem.Tag := CollectionInfo.ID;
      SubItem.OnClick := miActiveCollectionClick;
      SubItem.ImageIndex := GetCollectionTypeImageIndex(CollectionInfo.CollectionType);
      pmCollection.Items.Add(SubItem);

      // ----------------------------------
      if
        isPrivateCollection(CollectionInfo.CollectionType) and
        isFB2Collection(CollectionInfo.CollectionType) and
        IsFB2
      then
      begin
        SubItem := TMenuItem.Create(miCopyToCollection);
        SubItem.Caption := CollectionInfo.DisplayName;
        SubItem.Tag := CollectionInfo.ID;
        SubItem.OnClick := CopyToCollectionClick;
        SubItem.ImageIndex := GetCollectionTypeImageIndex(CollectionInfo.CollectionType);

        miCopyToCollection.Add(SubItem);
      end;
    end;
  end;

  // Добавляем пункт вызова визарда (сначала - разделитель)
  if pmCollection.Items.Count > 0 then
  begin
    SubItem := TMenuItem.Create(pmCollection);
    SubItem.Caption := '-';
    pmCollection.Items.Add(SubItem);
  end;

  SubItem := TMenuItem.Create(pmCollection);
  SubItem.Caption := rsrtNewCollectin;
  SubItem.Action := acCollectionNew;
  SubItem.ImageIndex := 1;
  pmCollection.Items.Add(SubItem);

  miCopyToCollection.Enabled := (miCopyToCollection.Count > 0);
  miCollSelect.Enabled := (miCollSelect.Count > 0);
end;

procedure TfrmMain.CreateGroupsMenu;
var
  Item, ItemP: TMenuItem;
  GroupIterator: IGroupIterator;
  Group: TGroupData;
begin
  pmGroups.Items.Clear;
  miAddToGroup.Clear;
  pmiGroups.Clear;

  GroupIterator := FSystemData.GetGroupIterator;
  while GroupIterator.Next(Group) do
  begin
    //
    // пропускаем "Избранное"
    //
    if Group.GroupID <> FAVORITES_GROUP_ID then
    begin
      // меню для кнопки
      Item := TMenuItem.Create(pmGroups);
      Item.Caption := Group.Text;
      Item.Tag := Group.GroupID;
      Item.OnClick := GroupMenuItemClick;
      pmGroups.Items.Add(Item);

      // подменю для контекстного
      ItemP := TMenuItem.Create(pmMain);
      ItemP.Caption := Group.Text;
      ItemP.Tag := Group.GroupID;
      ItemP.OnClick := GroupMenuItemClick;
      pmiGroups.Add(ItemP);

      // подменю для контекстного в главном меню
      ItemP := TMenuItem.Create(pmMain);
      ItemP.Caption := Group.Text;
      ItemP.Tag := Group.GroupID;
      ItemP.OnClick := GroupMenuItemClick;
      miAddToGroup.Add(ItemP);
    end;
  end;
end;

procedure TfrmMain.CreateScriptMenu;
const
  ExpCount = 6;
  ExpTypes: array [0 .. ExpCount] of string = ('  fb2', '  fb2.zip', '  LRF', '  txt', ' epub', '  pdf', ' .mobi');
  Icons: array [0 .. ExpCount] of Integer = (18, 19, 20, 21, 24, 25, 20);
  IconsSmall: array [0 .. ExpCount] of Integer = (0, 1, 2, 3, 4, 5, 11);
var
  Item, ItemP, ItemM: TMenuItem;
  F: Integer;
  i: Integer;
  fb2Collection: Boolean;
begin
  pmScripts.Items.Clear;
  pmiScripts.Clear;
  mmiScripts.Clear;

  //Assert(Assigned(FCollection));
  fb2Collection := Assigned(FCollection) and isFB2Collection(FCollection.CollectionCode);

  if fb2Collection or Settings.AllowMixed then
  begin
    for i := 0 to ExpCount do
    begin
      Item := TMenuItem.Create(pmScripts);
      Item.OnClick := SendToDeviceExecute;  // если присваивать свойство action,  то не передается tag, и ничего не работает
      Item.Caption := ExpTypes[i];
      Item.Tag := 850 + i;
      Item.ImageIndex := IconsSmall[i];
      pmScripts.Items.Insert(i, Item);
    end;

    if Settings.Scripts.Count > 0 then
    begin
      Item := TMenuItem.Create(pmScripts);
      Item.Caption := '-';
      Item.Tag := 0;
      pmScripts.Items.Insert(ExpCount + 1, Item);
    end;

    tbSendToDevice.ImageIndex := Icons[ord(Settings.ExportMode)];
    // pmScripts.Items[i].Caption := '>> ' + ExpTypes[i] + ' <<';
    F := ExpCount + 2;
  end
  else
  begin
    F := 0;
    tbSendToDevice.ImageIndex := 1;
  end;

  { TODO 1 -oNickR -cRefactoring :заменить этот код на создание TFileRun }
  for i := 0 to Settings.Scripts.Count - 1 do
  begin
    // ----  dropdown ----------------
    Item := TMenuItem.Create(pmScripts);
    Item.Caption := Settings.Scripts[i].Title;
    Item.Tag := 901 + i;
    Item.OnClick := SendToDeviceExecute;
    Item.ImageIndex := 6;
    pmScripts.Items.Insert(i + F, Item);

    // ------ context -----------------
    ItemP := TMenuItem.Create(pmiScripts);
    ItemP.Caption := Settings.Scripts[i].Title;
    ItemP.Tag := 901 + i;
    ItemP.OnClick := SendToDeviceExecute;
    pmiScripts.Insert(i, ItemP);

    // ------ main -----------------
    ItemM := TMenuItem.Create(MainMenu);
    ItemM.Caption := Settings.Scripts[i].Title;
    ItemM.Tag := 901 + i;
    ItemM.OnClick := SendToDeviceExecute;
    mmiScripts.Insert(i, ItemM);
  end;

  // Добавляем Выбор папки

  if pmScripts.Items.Count > 0 then
  begin
    Item := TMenuItem.Create(pmScripts);
    Item.Caption := '-';
    Item.tag := 0;
    pmScripts.Items.Add(Item);
  end;

  Item := TMenuItem.Create(pmScripts);
  Item.OnClick := SendToDeviceExecute;
  Item.Caption := rstrSelectFolder;
  Item.ImageIndex := 10;
  Item.tag := 799;
  pmScripts.Items.Add(Item);


  if pmiScripts.Count > 0 then
  begin
    mmiScripts.Visible := True;
    pmiScripts.Visible := True;
  end
  else
  begin
    mmiScripts.Visible := False;
    pmiScripts.Visible := False;
  end
end;

function TfrmMain.ShowNCWizard: Boolean;
var
  frmNCWizard: TNewCollectionWizard;
begin
  frmNCWizard := TNewCollectionWizard.Create(Application);
  try
    if frmNCWizard.ShowModal = mrOk then
    begin
      Settings.ActiveCollection := frmNCWizard.NewCollectionID;
      InitCollection;
      if frmNCWizard.Autoimport and IsFB2 then
      begin
        Assert(Assigned(FCollection));
        unit_Import.ImportFB2(FCollection.CollectionID, afZip);
        InitCollection;
      end;

      Result := True;
    end
    else
      Result := False;
  finally
    frmNCWizard.Free;
  end;
end;

procedure TfrmMain.ShowNewCollectionWizard(Sender: TObject);
begin
  ShowNCWizard;
end;

procedure TfrmMain.SetFormState;
begin
  WindowState := TWindowState(Settings.WindowState);
  if WindowState = wsNormal then
  begin
    Top := Settings.FormTop;
    Left := Settings.FormLeft;
    Width := Settings.FormWidth;
    Height := Settings.FormHeight;
  end;

  // костыль
  Visible := True;
  if WindowState = wsMinimized then
    WindowState := wsNormal;
  // конец костыля
  tmrCheckUpdates.Enabled := True;
end;

procedure TfrmMain.btnSwitchTreeModeClick(Sender: TObject);
var
  SavedCursor: TCursor;
  Page: Integer;
  FilterValue: TFilterValue;
begin
  Assert(Assigned(FCollection));
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    SaveColumns;

    Page := pgControl.ActivePageIndex;

    if Settings.TreeModes[Page] = tmFlat then
      Settings.TreeModes[Page] := tmTree
    else
      Settings.TreeModes[Page] := tmFlat;

    btnSwitchTreeMode.ImageIndex := TreeIcons[Ord(Settings.TreeModes[pgControl.ActivePageIndex])];
    btnSwitchTreeMode.Hint := TreeHints[Ord(Settings.TreeModes[pgControl.ActivePageIndex])];

    SetColumns;

    case Page of
      0:
      begin
        FilterValue := AuthorBookFilter;
        FillBooksTree(tvBooksA, cbLangSelectA, FCollection.GetBookIterator(bmByAuthor, False, @FilterValue), False, True, @FLastAuthorBookID);  // авторы
      end;

      1:
      begin
        FilterValue := SeriesBookFilter;
        FillBooksTree(tvBooksS, cbLangSelectS, FCollection.GetBookIterator(bmBySeries, False, @FilterValue), False, False, @FLastSeriesBookID); // серии
      end;

      2:
      begin
        FilterValue := GenreBookFilter;
        FillBooksTree(tvBooksG, cbLangSelectG, FCollection.GetBookIterator(bmByGenre, False, @FilterValue),  True,  True, @FLastGenreBookID);      // жанры
      end;

      3: FillBooksTree(tvBooksSR, nil, FCollection.Search(FSearchCriteria, False), True,  True, nil);  // поиск

      4: FillBooksTree(tvBooksF,cbLangSelectF,  FSystemData.GetBookIterator(FLastGroupID), True,  True, @FLastGroupBookID);  // избранное
    end;

    SetHeaderPopUp;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.ClearLabels(Tag: Integer; Full: Boolean);
begin
  case Tag of
    PAGE_AUTHORS:
      begin
        ipnlAuthors.Clear;
        if Full then
        begin
          lblAuthor.Caption := '...';
          lblBooksTotalA.Caption := '()';
        end;
      end;

    PAGE_SERIES:
      begin
        ipnlSeries.Clear;
        if Full then
        begin
          lblSeries.Caption := '...';
          lblBooksTotalS.Caption := '()';
        end;
      end;

    PAGE_GENRES:
      begin
        ipnlGenres.Clear;
        if Full then
        begin
          lblGenreTitle.Caption := '...';
          lblBooksTotalG.Caption := '()';
        end;
      end;

    PAGE_FAVORITES:
      begin
        ipnlFavorites.Clear;
        if Full then
        begin
          lblGroups.Caption := '...';
          lblBooksTotalF.Caption := '()';
        end;
      end;

    PAGE_SEARCH:
      begin
        ipnlSearch.Clear;
        if Full then
          lblTotalBooksFL.Caption := '()';
      end;

    PAGE_ALL:
      begin
        ClearLabels(PAGE_AUTHORS, Full);
        ClearLabels(PAGE_SERIES, Full);
        ClearLabels(PAGE_GENRES, Full);
        ClearLabels(PAGE_FAVORITES, Full);
        ClearLabels(PAGE_SEARCH, Full);
      end;
  end;
end;

procedure TfrmMain.FillAllBooksTree;
var
  SavedCursor: TCursor;
  FilterValue: TFilterValue;
begin
  Assert(Assigned(FCollection));
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FilterValue := AuthorBookFilter;
    FillBooksTree(tvBooksA, cbLangSelectA, FCollection.GetBookIterator(bmByAuthor, False, @FilterValue), False, True, @FLastAuthorBookID);  // авторы

    FilterValue := SeriesBookFilter;
    FillBooksTree(tvBooksS, cbLangSelectS, FCollection.GetBookIterator(bmBySeries, False, @FilterValue), False, False, @FLastSeriesBookID); // серии

    FilterValue := GenreBookFilter;
    FillBooksTree(tvBooksG, cbLangSelectG, FCollection.GetBookIterator(bmByGenre, False, @FilterValue),   True,  True, @FLastGenreBookID);  // жанры

    FillBooksTree(tvBooksF, cbLangSelectF, FSystemData.GetBookIterator(FLastGroupID), True,  True, @FLastGroupBookID);  // избранное
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

function TfrmMain.CheckLibUpdates(Auto: Boolean): Boolean;
var
  i: Integer;
  UpdatesInfo: TUpdateInfoList;
  CollectionInfoIterator: ICollectionInfoIterator;
  CollectionInfo: TCollectionInfo;
begin
  if not Auto then
    ShowPopup(rstrCheckingUpdates);

  Result := False;

  UpdatesInfo := Settings.Updates;

  UpdatesInfo.UpdateExternalVersions;

  CollectionInfoIterator := FSystemData.GetCollectionInfoIterator;
  while CollectionInfoIterator.Next(CollectionInfo) do
  begin
    for i := 0 to UpdatesInfo.Count - 1 do
      if UpdatesInfo[i].CheckCodes(CollectionInfo.DisplayName, CollectionInfo.CollectionType, CollectionInfo.ID) then
        if UpdatesInfo[i].CheckVersion(Settings.UpdatePath, CollectionInfo.DataVersion) then
        begin
          Result := True;
          Break;
        end;
  end;

  if not Auto then
  begin
    HidePopup;
    if not Result then
      MHLShowInfo(rstrNoUpdatesAvailable);
  end;
end;

procedure TfrmMain.CheckUpdatesExecute(Sender: TObject);
begin
  CheckUpdates(GetFileVersion(Application.ExeName), FAutoCheck);
end;

// ------------------------------------------------------------------------------
// Проверка обновлений
// ------------------------------------------------------------------------------
procedure TfrmMain.tmrCheckUpdatesTimer(Sender: TObject);
begin
  if not frmMain.Active then
    Exit;

  tmrCheckUpdates.Enabled := False;
  StatusMessage := rstrCheckingUpdates;

  if Settings.CheckUpdate then
  begin
    FAutoCheck := True;
    CheckUpdatesExecute(nil);
  end
  else
    FAutoCheck := False;

  if Settings.CheckExternalLibUpdate then
    if CheckLibUpdates(True) then
      if Settings.AutoRunUpdate then
        StartLibUpdate
      else if MHLShowInfo(rstrCollectionUpdateAvailable, mbYesNo) = mrYes then
        StartLibUpdate;

  StatusMessage := rstrDownloadStateDone;
end;

procedure TfrmMain.tmrSearchATimer(Sender: TObject);
var
  Button: TToolButton;
begin
  tmrSearchA.Enabled := False;
  FTimerDone := True;


  if FTimerDone then
  begin
    FTimerDone := False;

    Assert(Assigned(FLastLetterA));
    Button := GetFilterButton(FAuthorBars, edLocateAuthor.Text);

    if Assigned(Button) and (Button <> FLastLetterA) then
    begin
      InternalSetAuthorFilter(Button);
    end;
    LocateAuthor(edLocateAuthor.Text);
  end;
end;

procedure TfrmMain.edLocateAuthorChange(Sender: TObject);
begin
  if not tmrSearchA.Enabled then
  begin
    tmrSearchA.Enabled := True;
    FTimerDone := False;
  end;
end;


procedure TfrmMain.tmrSearchSTimer(Sender: TObject);
var
  Button: TToolButton;
begin
  tmrSearchS.Enabled := False;
  FTimerDone := True;


  if FTimerDone then
  begin
    //
    // Проверим текущий фильтр и изменим его если нужно
    //
    Assert(Assigned(FLastLetterS));
    Button := GetFilterButton(FSerieBars, edLocateSeries.Text);
    if Assigned(Button) and (Button <> FLastLetterS) then
    begin
      InternalSetSeriesFilter(Button);
    end;

    LocateSeries(edLocateSeries.Text);
  end;
end;


procedure TfrmMain.tbtnAutoFBDClick(Sender: TObject);
//var
//  Tree: TBookTree;
//  Node: PVirtualNode;
//  Data: PBookRecord;
begin
  //
  // Очень стремный метод. Режим редактирования\создания FBD для формы не ставиться, форма ничего не проверяет...
  //
  if (ActiveView = DownloadView) then
  begin
    MHLShowWarning(rstrNotFromDownloadsError);
    Exit;
  end;

  Assert(False, 'Not implemented yet');

  (*

  TODO : RESTORE

  OnSetControlsStateHandler(False);
  try
    GetActiveTree(Tree);
    Node := Tree.GetFirstSelected;
    Data := Tree.GetNodeData(Node);
    if not Assigned(Data) or (Data^.nodeType <> ntBookInfo) then
      Exit;

    frmConvertToFBD.AutoMode;
  finally
    OnSetControlsStateHandler(True);
  end;
  *)
end;

procedure TfrmMain.tbtnWizardClick(Sender: TObject);
begin

end;

//
// События формы
//

procedure TfrmMain.StartLibUpdate;
begin
  unit_Utils.LibrusecUpdate(Settings.SystemFileName[sfUpdateLog]);
end;

function TfrmMain.GetShowStatusProgress: Boolean;
begin
  Result := (psOwnerDraw = StatusBar.Panels[1].Style);
end;

procedure TfrmMain.SetShowStatusProgress(const Value: Boolean);
begin
  if Value then
    StatusBar.Panels[1].Style := psOwnerDraw
  else
    StatusBar.Panels[1].Style := psText;
end;

function TfrmMain.GetStatusMessage: string;
begin
  Result := StatusBar.Panels[0].Text;
end;

procedure TfrmMain.SetStatusMessage(const Value: string);
begin
  StatusBar.Panels[0].Text := Value;
  if StatusBar.Visible then
    StatusBar.Repaint;
end;

function TfrmMain.GetStatusProgress: Integer;
begin
  Result := FStatusProgressBar.Position;
end;

procedure TfrmMain.SetStatusProgress(const Value: Integer);
begin
  if FStatusProgressBar.Position <> Value then
  begin
    FStatusProgressBar.Position := Value;
    if StatusBar.Visible and ShowStatusProgress then
      StatusBar.Repaint;
  end;
end;

procedure TfrmMain.StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[1] then
  begin
    FStatusProgressBar.BoundsRect := Rect;
    FStatusProgressBar.PaintTo(StatusBar.Canvas.Handle, Rect.Left, Rect.Top);
  end;
end;

procedure TfrmMain.StatusBarResize(Sender: TObject);
begin
  StatusBar.Panels[0].Width :=
    StatusBar.Width - (StatusBar.Panels[1].Width + StatusBar.Panels[2].Width);
end;

function TfrmMain.LoadLastCollection: boolean;
var
  CollectionID: Integer;
begin
  Result := False;
  if FSystemData.HasCollections then
  begin
    CollectionID := FSystemData.FindFirstExistingCollectionID(Settings.ActiveCollection);
    if CollectionID < 0 then
    begin
      // if was unable to find CollectionID, do not know DBFileName either:
      MHLShowError(rstrCollectionFileNotFound);
      Exit;
    end;
    //
    // небольшой хак. Будет правильнее передавать ID коллекции в InitCollection
    //
    Settings.ActiveCollection := CollectionID;
    Result := True;
  end;
end;

// ----------------------------------------------------------------------------
//
// События формы
//
// ----------------------------------------------------------------------------
procedure TfrmMain.LoadPresets;
var
  PresetFile: string;
  preset: TSearchPreset;
begin
  //
  // загрузка списка пресетов для поиска
  //
  FPresets := TSearchPresets.Create;
  PresetFile := Settings.SystemFileName[sfPresets];
  if TFile.Exists(PresetFile) then
  begin
    try
      FPresets.Load(PresetFile);

      for preset in FPresets do
        cbPresetName.Items.Add(preset.DisplayName);
    except
      on e: Exception do
        Application.ShowException(e);
    end;
  end;
end;

procedure TfrmMain.ConnectTreeControllers;
begin
  FController := TTreeController.Create(FSystemData);

  //
  // Делегируем самые простые события контроллеру
  //
  FController.ConnectAuthorsTree(tvAuthors);
  FController.ConnectSeriesTree(tvSeries);
  FController.ConnectGenresTree(tvGenres);
  FController.ConnectGroupsTree(tvGroups);

  FController.ConnectBooksTree(tvBooksA);
  FController.ConnectBooksTree(tvBooksS);
  FController.ConnectBooksTree(tvBooksG);
  FController.ConnectBooksTree(tvBooksSR);
  FController.ConnectBooksTree(tvBooksF);

  FController.ConnectDownloadTree(tvDownloadList);

  // -----------------------------
end;

procedure TfrmMain.InitFormFileds;
begin
  Application.OnHelp := OnHelpHandler;
  UseLatestCommonDialogs := True;

  FSelectionState := False;
  FAutoCheck := False;
  FFormBusy := False;

  FFileOpMode := fmFb2Zip;

  FMainBars[0] := tlbrMain;
  FMainBars[1] := tlbrEdit;

  FAuthorBars[0] := tbarAuthorsRus;
  FAuthorBars[1] := tbarAuthorsEng;

  FSerieBars[0] := tbarSeriesRus;
  FSerieBars[1] := tbarSeriesEng;

  CreateAlphabetToolbar;

  FLastLetterA := tbarAuthorsRus.Buttons[0];
  FLastLetterS := tbarSeriesRus.Buttons[0];

  FLastAuthorID := MHL_INVALID_ID;
  FLastAuthorBookID.Clear;

  FLastSeriesID := MHL_INVALID_ID;
  FLastSeriesBookID.Clear;

  FLastGenreCode := '';
  FLastGenreIsContainer := False;
  FLastGenreBookID.Clear;

  FLastGroupID := MHL_INVALID_ID;
  FLastGroupBookID.Clear;

  // SB
  FStatusProgressBar := TProgressBar.Create(Self);
  FStatusProgressBar.Parent := StatusBar;
  FStatusProgressBar.Visible := False;
  StatusMessage := '';
  ShowStatusProgress := False;
  StatusProgress := 0;

  StatusBar.Panels[2].Text := unit_MHLHelpers.GetFileVersion(Application.ExeName);
  // SB
end;

procedure TfrmMain.UpdateSplashScreen(const AStatus: string);
begin
  frmSplash.lblState.Caption := AStatus;
  frmSplash.lblState.Update;
end;

procedure TfrmMain.LoadDownloadsList;
begin
  // загрузка списка закачек
  if FileExists(Settings.SystemFileName[sfDownloadsStore]) then
  begin
    tvDownloadList.LoadFromFile(Settings.SystemFileName[sfDownloadsStore]);
    lblDownloadCount.Caption := Format('(%d)', [tvDownloadList.ChildCount[nil]]);
  end;

  if Settings.AutoStartDwnld then
    btnStartDownloadClick(frmMain);
end;

procedure TfrmMain.ClearDataFolder;
begin
  // ------------------------ чистка папки дата если нужно ----------------------
  if (ParamCount > 0) and (ParamStr(1) = '/clear') then
    ClearDir(Settings.DataDir);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FSystemData := SystemDB;

  ConnectTreeControllers;

  InitFormFileds;

  ReadINIData;

  ClearDataFolder;

  LoadPresets;

  SetColumns;

  SetHeaderPopUp;

  UpdateSplashScreen(rstrMainLoadingCollection);

  InitCollection;

  LoadDownloadsList;

  SetFormState;

  UpdateSplashScreen(rstrStarting);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if CheckActiveDownloads then
    if MHLShowWarning(rstrUnfinishedDownloads, mbYesNo) = mrYes then
    begin
      if Assigned(FDMThread) then
        FDMThread.TerminateNow;
    end
    else
      CanClose := False;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  // SQ
  FreeAndNil(FPresets);

  tvDownloadList.SaveToFile(Settings.SystemFileName[sfDownloadsStore]);

  if DirectoryExists(Settings.TempDir) then
    ClearDir(Settings.TempDir);

  SavePositions;
  SaveMainFormSettings;
  Settings.SaveSettings;

  FreeAndNil(FController);
  FreeAndNil(FDMThread);
end;

procedure TfrmMain.UpdatePositions;
var
  AuthorData: PAuthorData;
  SerieData: PSeriesData;
  GenreData: PGenreData;
  GroupData: PGroupData;
  //BookData: PBookRecord;
begin
  AuthorData := tvAuthors.GetNodeData(tvAuthors.GetFirstSelected);
  if not Assigned(AuthorData) or (FLastAuthorID <> AuthorData^.AuthorID) then
  begin
    if Assigned(AuthorData) then
      FLastAuthorID := AuthorData^.AuthorID
    else
      FLastAuthorID := MHL_INVALID_ID;
    FLastAuthorBookID.Clear;
  end
  else
    FLastAuthorStr := AuthorData^.GetFullName;

  SerieData := tvSeries.GetNodeData(tvSeries.GetFirstSelected);
  if not Assigned(SerieData) or (FLastSeriesID <> SerieData^.SeriesID) then
  begin
    if Assigned(SerieData) then
      FLastSeriesID := SerieData^.SeriesID
    else
      FLastSeriesID := MHL_INVALID_ID;
    FLastSeriesBookID.Clear;
  end
  else
    FLastseriesStr:= SerieData^.SeriesTitle;

  GenreData := tvGenres.GetNodeData(tvGenres.GetFirstSelected);
  if not Assigned(GenreData) or (FLastGenreCode <> GenreData^.GenreCode) then
  begin
    if Assigned(GenreData) then
    begin
      FLastGenreCode := GenreData^.GenreCode;
      Assert(Assigned(tvGenres.GetFirstSelected()));
      FLastGenreIsContainer := (tvGenres.GetFirstSelected^.ChildCount > 0);
    end
    else
    begin
      FLastGenreCode := '';
      FLastGenreIsContainer := False;
    end;
    FLastGenreBookID.Clear;
  end;

  GroupData := tvGroups.GetNodeData(tvGroups.GetFirstSelected);
  if not Assigned(GroupData) or (FLastGroupID <> GroupData^.GroupID) then
  begin
    if Assigned(GroupData) then
      FLastGroupID := GroupData^.GroupID
    else
      FLastGroupID := MHL_INVALID_ID;
    FLastGroupBookID.Clear;
  end;
end;

procedure TfrmMain.SaveMainFormSettings;
begin
  SaveColumns;

  UpdatePositions;

  Settings.Splitters[0] := pnAuthorsView.Width;
  Settings.Splitters[1] := pnSeriesView.Width;
  Settings.Splitters[2] := pnGenresView.Width;
  Settings.Splitters[3] := pnSearchView.Width;
  Settings.Splitters[4] := pnGroupsView.Width;

  Settings.BookSRCollapsed := ctpBook.Collapsed;
  Settings.FileSRCollapsed := ctpFile.Collapsed;
  Settings.OtherSRCollapsed := ctpOther.Collapsed;

  Settings.InfoPanelHeight := ipnlAuthors.Height;

  Settings.WindowState := Ord(Self.WindowState);
  if WindowState = wsNormal then
  begin
    Settings.FormWidth := Width;
    Settings.FormHeight := Height;

    Settings.FormTop := Top;
    Settings.FormLeft := Left;
  end;

end;

procedure TfrmMain.tvBooksTreeHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
var
  Tree: TBookTree;
begin
  if (HitInfo.Button = mbLeft) then
  begin
    GetActiveTree(Tree);
    if (Settings.TreeModes[Tree.Tag] = tmTree) or (HitInfo.Column < 0) then
      Exit;

    //
    // Меняем индекс сортирующей колонки на индекс колонки, которая была нажата.
    //
    Tree.Header.SortColumn := HitInfo.Column;

    //
    // Сортируем всё дерево относительно этой колонки и изменяем порядок сортировки на противополжный
    //
    if Tree.Header.SortDirection = sdAscending then
      Tree.Header.SortDirection := sdDescending
    else
      Tree.Header.SortDirection := sdAscending;
    Tree.SortTree(HitInfo.Column, Tree.Header.SortDirection);

    // запоминаем параметры для активного дерева
    FSortSettings[Tree.Tag].Column := HitInfo.Column;
    FSortSettings[Tree.Tag].Direction := Tree.Header.SortDirection;
  end;
end;

// ----------------------------------------------------------------------------
//
// Список авторов
//
// ----------------------------------------------------------------------------
procedure TfrmMain.tvAuthorsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  SavedCursor: TCursor;
  Data: PAuthorData;
  FilterValue: TFilterValue;
{$IFDEF USELOGGER}
  logger: IScopeLogger;
{$ENDIF}

  procedure ClearScreen;
  begin
    lblAuthor.Caption := '...';
    lblBooksTotalA.Caption := '()';
    ipnlAuthors.Clear;
    tvBooksA.Clear;
  end;

begin
{$IFDEF USELOGGER}
//  logger := GetScopeLogger('TfrmMain.tvAuthorsChange');
{$ENDIF}

  if tvAuthors.RootNodeCount = 0 then ClearScreen;
  if (FIgnoreAuthorChange) or (Node = nil) then Exit;

  try
    Data := tvAuthors.GetNodeData(Node);
    if not Assigned(Data) then
    begin
      ClearScreen;
      Exit;
    end;

    SavedCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;

    if FLastAuthorID <> Data^.AuthorID then
    begin
      lblAuthor.Caption := Data^.GetFullName;
      FLastAuthorID := Data^.AuthorID;
      FLastAuthorStr:= Data^.GetFullName;
      FLastAuthorBookID.Clear;
    end;

    FilterValue := AuthorBookFilter;
    if Assigned(FCollection) then
      FillBooksTree(tvBooksA, cbLangSelectA, FCollection.GetBookIterator(bmByAuthor, False, @FilterValue), False, True, @FLastAuthorBookID); // авторы
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.tvAuthorsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    frmMain.ActiveControl := tvBooksA;
  end;
end;

procedure TfrmMain.tvAuthorsMeasureTextHeight(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; var Extent: Integer);
begin
end;

// ----------------------------------------------------------------------------
//
// Список серий
//
// ----------------------------------------------------------------------------
procedure TfrmMain.tvSeriesChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  SavedCursor: TCursor;
  Data: PSeriesData;
  FilterValue: TFilterValue;
{$IFDEF USELOGGER}
  logger: IScopeLogger;
{$ENDIF}

  procedure ClearScreen;
  begin
    lblSeries.Caption := '...';
    lblBooksTotalS.Caption := '()';
    ipnlSeries.Clear;
    tvBooksS.Clear;
  end;

begin
{$IFDEF USELOGGER}
  logger := GetScopeLogger('TfrmMain.tvSeriesChange');
{$ENDIF}

  if tvSeries.RootNodeCount = 0 then ClearScreen;
  if (Node = nil) then Exit;

  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Data := tvSeries.GetNodeData(Node);
    if not Assigned(Data) then
    begin
      ClearScreen;
      Exit;
    end;

    if FLastSeriesID <> Data^.SeriesID then
    begin
      lblSeries.Caption := Data^.SeriesTitle;
      FLastSeriesID := Data^.SeriesID;
      FLastSeriesStr := Data^.SeriesTitle;
      FLastSeriesBookID.Clear;
    end;

    FilterValue := SeriesBookFilter;
    if Assigned(FCollection) then
      FillBooksTree(tvBooksS, cbLangSelectS, FCollection.GetBookIterator(bmBySeries, False, @FilterValue), False, False, @FLastSeriesBookID); // авторы
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.tvSeriesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    frmMain.ActiveControl := tvBooksS;
  end;
end;

// ----------------------------------------------------------------------------
//
// Список жанров
//
// ----------------------------------------------------------------------------
procedure TfrmMain.tvGenresChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  SavedCursor: TCursor;
  Data: PGenreData;
  FilterValue: TFilterValue;
{$IFDEF USELOGGER}
  logger: IScopeLogger;
{$ENDIF}
begin
{$IFDEF USELOGGER}
  logger := GetScopeLogger('TfrmMain.tvGenresChange');
{$ENDIF}

  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Data := tvGenres.GetNodeData(Node);
    if not Assigned(Data) then
    begin
      lblGenreTitle.Caption := '...';
      lblBooksTotalG.Caption := '()';
      ipnlGenres.Clear;
      tvBooksG.Clear;
      Exit;
    end;

    if FLastGenreCode <> Data^.GenreCode then
    begin
      lblGenreTitle.Caption := Data^.GenreAlias;
      FLastGenreCode := Data^.GenreCode;
      FLastGenreIsContainer := (Node^.ChildCount > 0);
      FLastGenreBookID.Clear;
    end;

    FilterValue := GenreBookFilter;
    if Assigned(FCollection) then
      FillBooksTree(tvBooksG, cbLangSelectG, FCollection.GetBookIterator(bmByGenre, False, @FilterValue), True, True, @FLastGenreBookID);
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.tvGenresKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    frmMain.ActiveControl := tvBooksG;
  end;
end;

// ----------------------------------------------------------------------------
//
// Список групп
//
// ----------------------------------------------------------------------------

procedure TfrmMain.tvGroupsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  SavedCursor: TCursor;
  Data: PGroupData;
{$IFDEF USELOGGER}
  logger: IScopeLogger;
{$ENDIF}
begin
{$IFDEF USELOGGER}
  logger := GetScopeLogger('TfrmMain.tvGroupsChange');
{$ENDIF}

  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Data := tvGroups.GetNodeData(Node);
    if not Assigned(Data) then
    begin
      lblGroups.Caption := '...';
      lblBooksTotalF.Caption := '()';
      ipnlFavorites.Clear;
      tvBooksF.Clear;
      Exit;
    end;

    if FLastGroupID <> Data^.GroupID then
    begin
      lblGroups.Caption := FSystemData.GetGroup(Data^.GroupID).Text;
      FLastGroupID := Data^.GroupID;
      FLastGroupBookID.Clear;
    end;

    FillBooksTree(tvBooksF, cbLangSelectF, FSystemData.GetBookIterator(FLastGroupID), True, True, @FLastGroupBookID);
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.tvGroupsDragDrop(
  Sender: TBaseVirtualTree;
  Source: TObject;
  DataObject: IDataObject;
  Formats: TFormatArray;
  Shift: TShiftState;
  Pt: TPoint;
  var Effect: Integer;
  Mode: TDropMode
  );
var
  Nodes: TNodeArray;
  i: Integer;
  GroupData: PGroupData;
  SourceGroupID: Integer;
  TargetGroupID: Integer;
  BookData: PBookRecord;

  procedure SelectChildNodes(ParentNode: PVirtualNode);
  var
    Node: PVirtualNode;
  begin
    if ParentNode.ChildCount = 0 then
      Exit;
    Node := ParentNode.FirstChild;
    while Assigned(Node) do
    begin
      SelectChildNodes(Node);
      tvBooksF.Selected[Node] := True;
      Node := tvBooksF.GetNextSibling(Node);
    end;
  end;

begin

  SourceGroupID := FLastGroupID;

  GroupData := tvGroups.GetNodeData(tvGroups.DropTargetNode);
  Assert(Assigned(GroupData));
  TargetGroupID := GroupData^.GroupID;

  Nodes := tvBooksF.GetSortedSelection(False);

  // сканируем выделенные ноды.
  // если есть потомки, выделяем их тоже
  for i := 0 to High(Nodes) do
    SelectChildNodes(Nodes[i]);

  // составляем новый список выделенных
  Nodes := tvBooksF.GetSortedSelection(False);

  // переносим данные
  for i := 0 to High(Nodes) do
  begin
    BookData := tvBooksF.GetNodeData(Nodes[i]);
    if BookData^.nodeType = ntBookInfo then
    begin
      FSystemData.CopyBookToGroup(BookData^.BookKey, SourceGroupID, TargetGroupID, ssShift in Shift);
    end;
  end;
  FillBooksTree(tvBooksF, cbLangSelectF, FSystemData.GetBookIterator(FLastGroupID), True, True, @FLastGroupBookID);
end;

procedure TfrmMain.tvGroupsDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
 Data: PGroupData;
begin
// Where can we get a replacement for DMUser.GroupsGroupID.Value ?
//  Assert(False, 'Not implemented yet!')

  Data := tvGroups.GetNodeData(tvGroups.DropTargetNode);
  if Assigned(Data) then
    if Data^.GroupID <> FLastGroupID then
      Accept := True;
end;

procedure TfrmMain.tvGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    frmMain.ActiveControl := tvBooksF;
  end;
end;

procedure TfrmMain.tvBooksTreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PBookRecord;
  Tree: TBookTree;
  InfoPanel: TInfoPanel;
  bookStream: TStream;
  book: IXMLFictionBook;
  imgBookCover: TGraphic;
  isFBDDocument: Boolean;
  StoredBookKey: PBookKey;

begin
  if FInvisible or not Assigned(Node) then Exit;

  Tree := Sender as TBookTree;

  StoredBookKey := nil;

  if Tree = tvBooksA then
  begin
    InfoPanel := ipnlAuthors;
    StoredBookKey := @FLastAuthorBookID;
  end
  else if Tree = tvBooksS then
  begin
    InfoPanel := ipnlSeries;
    StoredBookKey := @FLastSeriesBookID;
  end
  else if Tree = tvBooksG then
  begin
    InfoPanel := ipnlGenres;
    StoredBookKey := @FLastGenreBookID;
  end
  else if Tree = tvBooksSR then
    InfoPanel := ipnlSearch
  else if Tree = tvBooksF then
  begin
    InfoPanel := ipnlFavorites;
    StoredBookKey := @FLastGroupBookID;
  end
  else
  begin
    Assert(False);
    Exit;
  end;


  InfoPanel.Clear;
  Data := Tree.GetNodeData(Node);

  if not Assigned(Data) or (Data^.nodeType <> ntBookInfo) then
  begin
    //
    // TODO : Может стоит показывать какую-нибудь информацию и в этом случае?
    //
    if Assigned(StoredBookKey) then
      StoredBookKey^.Clear;
    Exit;
  end;

  if Assigned(StoredBookKey) then
    StoredBookKey^ := Data^.BookKey;

  if Settings.ShowInfoPanel then
  begin
    InfoPanel.SetBookInfo(
      Data^.Title,
      TAuthorsHelper.GetLinkList(Data^.Authors),
      TSeriesHelper.GetLink(Data^.SeriesID, Data^.Series),
      TGenresHelper.GetLinkList(Data^.Genres)
    );

    if Settings.ShowBookCover or Settings.ShowBookAnnotation or Settings.Fb2InfoPriority then
    begin
      if (bpIsLocal in Data^.BookProps) and (bfRaw <> Data^.GetBookFormat) and (bfRawArchive <> Data^.GetBookFormat) then
      begin
        try
          bookStream := Data^.GetBookDescriptorStream;
          if Assigned(bookStream) then
            try
              book := LoadFictionBook(bookStream);

              //
              // Загрузим обложку
              //
              try
                imgBookCover := GetBookCover(book);
                InfoPanel.SetBookCover(imgBookCover);
              finally
                imgBookCover.Free;
              end;

              //
              // Загрузим аннотацию и информацию
              //
              InfoPanel.SetBookAnnotation(book);
              InfoPanel.SetFb2Info(book, Data.Folder, Data.FileName + Data.FileExt);
            finally
              FreeAndNil(bookStream);
            end
          else begin
            InfoPanel.SetBookCover(nil);
            InfoPanel.SetBookAnnotation(nil);
          end;
        except
          on E : Exception do
               begin
                InfoPanel.SetBookCover(nil);
                InfoPanel.SetBookAnnotation(nil);
               end;
        end;
      end
      else
      begin
        InfoPanel.SetBookCover(nil);
        InfoPanel.SetBookAnnotation(nil);
      end;
    end;
  end;

  if IsPrivate and IsNonFB2 then
  begin
    isFBDDocument := Data^.GetBookFormat = bfFbd;
    tbtnFBD.Caption := IfThen(isFBDDocument, rstrEditFBD, rstrConvert2FBD);
    tbtnAutoFBD.Visible := isFBDDocument;
  end;
end;

procedure TfrmMain.tvBooksTreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  CheckState: array [Boolean] of TCheckState = (csCheckedNormal, csUncheckedNormal);
var
  Tree: TBookTree;
  Left: TVirtualStringTree;
  Node: PVirtualNode;
  Data: PBookRecord;
begin
  if Key = VK_INSERT then
  begin
    Tree := (Sender as TBookTree);
    Node := Tree.FocusedNode;
    if Assigned(Node) then
    begin
      Data := Tree.GetNodeData(Node);
      if Data^.nodeType = ntBookInfo then
        Tree.CheckState[Node] := CheckState[Tree.CheckState[Node] = csCheckedNormal];
      Tree.Selected[Node] := False;
      Node := Tree.GetNext(Node);

      if Assigned(Node) then
      begin
        Tree.Selected[Node] := True;
        Tree.FocusedNode := Node;
      end;
    end;
  end
  else if (Key in [VK_RIGHT, VK_LEFT]) and (ssCtrl in Shift) then
  begin
    case ActiveView of
      AuthorsView:
        Left := tvAuthors;
      SeriesView:
        Left := tvSeries;
      GenresView:
        Left := tvGenres;
      FavoritesView:
        Left := tvGroups;
      SearchView:
        Exit;
    end;

    Node := Left.FocusedNode;
    Left.Selected[Node] := False;

    if (Key = VK_RIGHT) then
      Node := Left.GetNext(Node)
    else
      Node := Left.GetPrevious(Node);

    if Assigned(Node) then
    begin
      Left.Selected[Node] := True;
      Left.FocusedNode := Node;
    end;

    Tree := (Sender as TBookTree);
    Node := Tree.GetFirst;
    if Assigned(Node) then
      Tree.Selected[Node] := True;
  end;
end;

procedure TfrmMain.tvBooksTreeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: PVirtualNode;
  Data: PBookRecord;
  Tree: TBookTree;
  Selected: PVirtualNode;
begin
  if (Button = mbLeft) and (ssShift in Shift) then
  begin
    try
      Tree := Sender as TBookTree;
      ClearLabels(Tree.Tag, True);
      Node := Tree.GetFirstSelected;
      Selected := Node;
      while Assigned(Node) do
      begin
        Data := Tree.GetNodeData(Node);
        if Data^.nodeType = ntBookInfo then
        begin
          if Tree.CheckState[Node] = csCheckedNormal then
            Tree.CheckState[Node] := csUncheckedNormal
          else
            Tree.CheckState[Node] := csCheckedNormal;
          Tree.Selected[Node] := False;
        end;
        Node := Tree.GetNextSelected(Node);
      end; // while
    finally
      Tree.Selected[Selected] := True;
    end;
  end; // if
end;

//
// Menu handlers
//
procedure TfrmMain.btnClearDownloadClick(Sender: TObject);
begin
  btnPauseDownloadClick(Sender);
  tvDownloadList.Clear;
  lblDownloadCount.Caption := '(0)';
end;

procedure TfrmMain.btnClearEdSeriesClick(Sender: TObject);
begin
  edLocateSeries.Clear;
  frmMain.ActiveControl := edLocateSeries;
end;

procedure TfrmMain.btnClearFilterEditsClick(Sender: TObject);
begin
  DoClearFilter(False);
end;

procedure TfrmMain.MoveDwnldListNodes(Sender: TObject);
var
  i: Integer;
  List: TSelectionList;
begin
  GetSelections(tvDownloadList, List);
  for i := 0 to tvDownloadList.SelectedCount - 1 do
    case (Sender as TToolButton).Tag of
      20: tvDownloadList.MoveTo(List[tvDownloadList.SelectedCount - i - 1], tvDownloadList.GetFirst, amInsertBefore, False);
      21: tvDownloadList.MoveTo(List[i], tvDownloadList.GetPrevious(List[i]), amInsertBefore, False);
      22: tvDownloadList.MoveTo(List[tvDownloadList.SelectedCount - i - 1], tvDownloadList.GetNext(List[tvDownloadList.SelectedCount - i - 1]), amInsertAfter, False);
      23: tvDownloadList.MoveTo(List[i], tvDownloadList.GetLast, amInsertAfter, False);
    end;
end;

procedure TfrmMain.CopyToCollectionClick(Sender: TObject);
var
  R: TBookRecord;
  ID: Integer;
  Tree: TBookTree;
  Node: PVirtualNode;
  Data: PBookRecord;
  SavedCursor: TCursor;
  targetCollection: IBookCollection;
  bookIDList: TBookIdList;
  bookIDStruct: TBookIdStruct;
begin
  Assert(Assigned(FCollection));
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if ActiveView = FavoritesView then
    begin
      MHLShowWarning(rstrMainUnableToCopy);
      Exit;
    end;

    GetActiveTree(Tree);
    ID := (Sender as TMenuItem).Tag;
    targetCollection := FSystemData.GetCollection(ID);

    FillBookIdList(Tree, bookIDList, False); // do not uncheck

    Node := Tree.GetFirst;
    while Assigned(Node) do
    begin
      Data := Tree.GetNodeData(Node);
      for bookIDStruct in bookIDList do
      begin
        if bookIDStruct.BookKey.IsSameAs(Data^.BookKey) then
          break; // found a match
      end;
      if bookIDStruct.BookKey.IsSameAs(Data^.BookKey) then // match
      begin
        FCollection.GetBookRecord(Data^.BookKey, R, True);
        targetCollection.InsertBook(R, True, True);
      end;

      Node := Tree.GetNext(Node);
    end;

    // uncheck:
    SetLength(BookIDList, 0);
    FillBookIdList(Tree, bookIDList, True);
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.InfoPanelResize(Sender: TObject);
begin
  SetInfoPanelHeight((Sender as TWinControl).Height);
end;

procedure TfrmMain.AddCurrentToList(const Tree: TBookTree; var BookIDList: TBookIdList);
var
  Data: PBookRecord;
begin
  Data := Tree.GetNodeData(Tree.FocusedNode);
  SetLength(BookIDList, 1);
  BookIDList[0].BookKey := Data^.BookKey;
end;

procedure TfrmMain.FillBookIdList(const Tree: TBookTree; var BookIDList: TBookIdList; const Uncheck: Boolean);
var
  i: Integer;
  Node: PVirtualNode;
  Data: PBookRecord;
begin
  i := 0;
  Node := Tree.GetFirst;
  while Assigned(Node) do
  begin
    Data := Tree.GetNodeData(Node);
    Assert(Assigned(Data));
    if IsSelectedBookNode(Node, Data) then
    begin
      SetLength(BookIDList, i + 1);
      BookIDList[i].BookKey := Data^.BookKey;
      Inc(i);
      if Uncheck then
        Tree.CheckState[Node] := csUncheckedNormal;
    end;
    Node := Tree.GetNext(Node);
  end;
end;

procedure TfrmMain.SendToDeviceExecute(Sender: TObject);
var
  AFolder: string;
  SaveFolderTemplate: string;
  TMPParams: string;
  ScriptID: Integer;
  BookIDList: TBookIdList;
  Files: string;
  p: Integer;
  S: string;
  Tree: TBookTree;
  ExportMode: TExportMode;
begin
  Assert(Assigned(FCollection));
  GetActiveTree(Tree);
  FillBookIdList(Tree, BookIDList);

  if pgControl.ActivePage = tsByAuthor then
    CurrentSelectedAuthor := lblAuthor.Caption
  else
    CurrentSelectedAuthor := '';

  if Length(BookIDList) = 0 then
  begin
    MHLShowError(rstrNoBookSelected);
    Exit;
  end;

  AFolder := Settings.DeviceDir;
  SaveFolderTemplate := Settings.FolderTemplate;
  ScriptID := (Sender as TComponent).Tag;

  if isFB2Collection(FCollection.CollectionCode) or Settings.AllowMixed then
  begin
    case ScriptID of
      850: ExportMode := emFB2;
      851: ExportMode := emFB2Zip;
      852: ExportMode := emLrf;
      853: ExportMode := emTxt;
      854: ExportMode := emEpub;
      855: ExportMode := emPDF;
      856: ExportMode := emMobi;
    else
      ExportMode := Settings.ExportMode;
    end
  end
  else
    ExportMode := emFB2;

  if ScriptID = 799 then // выбор папки; не зависит от формата
  begin
    if not GetFolderName(Handle, 'Укажите путь', FLastDeviceDir) then
      Exit;
    AFolder := FLastDeviceDir;
    Dec(ScriptID, 901);
  end
  else
  begin
    Dec(ScriptID, 901);

    if (ScriptID < 1) and (Settings.PromptDevicePath) then
    begin
      if not GetFolderName(Handle, rstrProvideThePath, FLastDeviceDir) then
        Exit
      else
        AFolder := FLastDeviceDir;
    end;
  end;

  if ScriptID >= 0 then
  begin
    TMPParams := Settings.Scripts[ScriptID].Params;
    if Pos('%NFT%', Settings.Scripts[ScriptID].Params) <> 0 then
    begin
      Settings.FolderTemplate := '';
      StrReplace('%NFT%', '', TMPParams);
    end;

    if Pos('%TMP%', Settings.Scripts[ScriptID].Params) <> 0 then
      StrReplace('%TMP%', Settings.TempPath, TMPParams);

    if Pos('%DEST%', Settings.Scripts[ScriptID].Params) <> 0 then
      StrReplace('%DEST%', AFolder, TMPParams);

    if Pos('%FOLDER ', Settings.Scripts[ScriptID].Params) <> 0 then
    begin
      StrReplace('%FOLDER ', '', TMPParams);
      p := Pos('%', TMPParams);
      S := Copy(TMPParams, 1, p - 1);
      AFolder := S;
      Delete(TMPParams, 1, p);
    end;

    if (Settings.Scripts[ScriptID].Path = '%COPY%') and (Trim(TMPParams) <> '') then
      AFolder := Trim(TMPParams);

    Settings.Scripts[ScriptID].TMPParams := TMPParams;
  end;

  if isOnlineCollection(FCollection.CollectionCode) then
    unit_ExportToDevice.DownloadBooks(BookIDList);

  if (ScriptID >= 0) and (Settings.Scripts[ScriptID].Path <> '%COPY%') then
  begin
    unit_ExportToDevice.ExportToDevice(AFolder, BookIDList, ExportMode, True, Files);
    if Pos('%FILENAME%', Settings.Scripts[ScriptID].Params) <> 0 then
    begin
      StrReplace('%FILENAME%', Files, TMPParams);
      Settings.Scripts[ScriptID].TMPParams := TMPParams;
    end;
    Settings.Scripts[ScriptID].Run;
  end
  else
    unit_ExportToDevice.ExportToDevice(AFolder, BookIDList, ExportMode, False, Files);

  Settings.FolderTemplate := SaveFolderTemplate;
end;

procedure TfrmMain.HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  StatusMessage := rstrReadyMessage;
  ShowStatusProgress := False;
end;

procedure TfrmMain.DownloadBooks;
var
  BookIDList: TBookIdList;
  Tree: TBookTree;
begin
  GetActiveTree(Tree);

  if CurrentBookOnly then
    AddCurrentToList(Tree, BookIDList)
  else
    FillBookIdList(Tree, BookIDList);
  unit_ExportToDevice.DownloadBooks(BookIDList);
end;

procedure TfrmMain.ReadBookExecute(Sender: TObject);
var
  Tree: TBookTree;
  Data: PBookRecord;
begin
  GetActiveTree(Tree);

  Data := Tree.GetNodeData(Tree.GetFirstSelected);
  if Assigned(Data) and (Data^.nodeType = ntBookInfo) then
  begin
    FCurrentBookOnly := True;
    OnReadBookHandler(Data^);
    FCurrentBookOnly := False;
  end;
end;

procedure TfrmMain.OnReadBookHandler;
var
  SavedCursor: TCursor;
  BookFileName: string;
  BookFormat: TBookFormat;
  WorkFile: string;
  CollectionInfo: TCollectionInfo;
begin
  Assert(Assigned(FCollection));

  Assert(BookRecord.nodeType = ntBookInfo);

  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    BookFileName := BookRecord.GetBookFileName;
    BookFormat := BookRecord.GetBookFormat;

    if BookFormat in [bfFb2Archive, bfFbd, bfRawArchive] then
    begin
      if BookFormat = bfFb2Archive then
      begin
        CollectionInfo := FSystemData.GetCollectionInfo(BookRecord.BookKey.DatabaseID);

        if (not (bpIsLocal in BookRecord.BookProps)) and isOnlineCollection(CollectionInfo.CollectionType) then
        begin
          // Why do we need to verify this? The code doesn't even use FCollection
          //          // A not-yet-downloaded book of an online collection, can download only if book's collection is selected
          //          FCollection.VerifyCurrentCollection(BookRecord.BookKey.DatabaseID);

          DownloadBooks(FCurrentBookOnly);
          /// TODO : RESTORE ??? Tree.RepaintNode(Tree.GetFirstSelected);
          if not FileExists(BookFileName) then
            Exit; // если файла нет, значит закачка не удалась, и юзер об  этом уже знает
        end;
      end;

      Assert(Length(BookRecord.Authors) > 0);
      WorkFile := TPath.Combine(
        Settings.ReadPath,
        Format('%s - %s', [CheckSymbols(BookRecord.Authors[0].GetFullName),
                           CheckSymbols(BookRecord.Title)]));

      if Length(WorkFile) > 240 then
        WorkFile := Copy(WorkFile, 1, 240);

      WorkFile := Format('%s.%d%s',[WorkFile,
                                    BookRecord.BookKey.BookID,
                                    BookRecord.FileExt]);

      if not FileExists(WorkFile) then
        BookRecord.SaveBookToFile(WorkFile);
    end
    else // bfFb2 or bfRaw
      WorkFile := BookFileName;

    if Settings.OverwriteFB2Info and (BookFormat = bfFb2) then
      WriteFb2InfoToFile(BookRecord, WorkFile);

    Settings.Readers.RunReader(WorkFile);
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.HideDeletedBooksExecute(Sender: TObject);
var
  SavedCursor: TCursor;
begin
  Assert(Assigned(FCollection));
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    UpdatePositions;

    Settings.HideDeletedBooks := not Settings.HideDeletedBooks;

    FCollection.SetHideDeleted(Settings.HideDeletedBooks);

    FillAuthorTree(tvAuthors, FCollection.GetAuthorIterator(amFullFilter), FLastAuthorID);
    FillSeriesTree(tvSeries, FCollection.GetSeriesIterator(smFullFilter), FLastSeriesID);
    FillAllBooksTree;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.HideDeletedBooksUpdate(Sender: TObject);
begin
  acViewHideDeletedBooks.Visible := (not IsPrivate);
  acViewHideDeletedBooks.Checked := Settings.HideDeletedBooks;
end;

function TfrmMain.GetFilterButton(ToolBars: array of TToolBar; const Filter: string): TToolButton;
var
  RealFilter: string;
  barIndex: Integer;
  bar: TToolBar;
  i: Integer;
begin
  Result := nil;

  if Filter = '' then
    Exit;

  RealFilter := Character.ToUpper(Copy(Filter, 1, 1));

  if not Character.IsLetter(RealFilter, 1) then
    RealFilter := ALPHA_FILTER_ALL; //ALPHA_FILTER_NON_ALPHA;

  for barIndex := 0 to High(ToolBars) do
  begin
    bar := ToolBars[barIndex];

    for i := 0 to bar.ControlCount - 1 do
    begin
      if (bar.Controls[i] is TToolButton) and ((bar.Controls[i] as TToolButton).Caption = RealFilter) then
      begin
        Result := bar.Controls[i] as TToolButton;
        Exit;
      end;
    end;
  end;

  Assert(False);
end;

function TfrmMain.InternalSetAuthorFilter(Button: TToolButton): string;
begin
  Assert(Assigned(FCollection));
  if Assigned(FLastLetterA) then
    FLastLetterA.Down := False;
  FLastLetterA := Button;
  FLastLetterA.Down := True;

  Result := Character.ToUpper(Button.Caption);

  FCollection.SetAuthorFilterType(Result);

  FillAuthorTree(tvAuthors, FCollection.GetAuthorIterator(amFullFilter), FLastAuthorID);

  if (Result = ALPHA_FILTER_ALL) or (Result = ALPHA_FILTER_NON_ALPHA) then
  begin
    Result := '';
  end
  else
  begin
    Assert(Length(Result) = 1);
  end;
end;

procedure TfrmMain.OnSetAuthorFilter(Sender: TObject);
var
  SavedCursor: TCursor;
  Button: TToolButton;
  AFilter: string;
begin
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    UpdatePositions;

    Assert(Sender is TToolButton);
    Button := Sender as TToolButton;

    AFilter := InternalSetAuthorFilter(Button);

    Assert(Length(AFilter) < 2);
    SetTextNoChange(edLocateAuthor, AFilter);
    if AFilter <> '' then
    begin
      edLocateAuthor.SelStart := 1;
      edLocateAuthor.SelLength := 0;
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

function TfrmMain.InternalSetSeriesFilter(Button: TToolButton): string;
begin
  Assert(Assigned(FCollection));
  if Assigned(FLastLetterS) then
    FLastLetterS.Down := False;
  FLastLetterS := Button;
  FLastLetterS.Down := True;

  Result := Character.ToUpper(Button.Caption);

  FCollection.SetSeriesFilterType(Result);

  FillSeriesTree(tvSeries, FCollection.GetSeriesIterator(smFullFilter), FLastSeriesID);

  if (Result = ALPHA_FILTER_ALL) or (Result = ALPHA_FILTER_NON_ALPHA) then
  begin
    Result := '';
  end
  else
  begin
    Assert(Length(Result) = 1);
  end;
end;

procedure TfrmMain.OnSetSerieFilter(Sender: TObject);
var
  SaveCursor: TCursor;
  Button: TToolButton;
  AFilter: string;
begin
  Assert(Assigned(FCollection));
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    UpdatePositions;

    Assert(Sender is TToolButton);
    Button := Sender as TToolButton;

    AFilter := InternalSetSeriesFilter(Button);

    FillSeriesTree(tvSeries, FCollection.GetSeriesIterator(smFullFilter), FLastSeriesID);

    Assert(Length(AFilter) < 2);
    SetTextNoChange(edLocateSeries, AFilter);
    if AFilter <> '' then
    begin
      edLocateSeries.SelStart := 1;
      edLocateSeries.SelLength := 0;
    end;
  finally
    Screen.Cursor := SaveCursor;
  end;
end;

procedure TfrmMain.TrayIconDblClick(Sender: TObject);
begin
  Visible := not Visible;
  TrayIcon.Visible := not Visible;
end;

procedure TfrmMain.ShowLocalOnlyExecute(Sender: TObject);
var
  SavedCursor: TCursor;
begin
  Assert(Assigned(FCollection));
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    UpdatePositions;

    Settings.ShowLocalOnly := not Settings.ShowLocalOnly;

    FCollection.SetShowLocalOnly(Settings.ShowLocalOnly);

    FillAuthorTree(tvAuthors, FCollection.GetAuthorIterator(amFullFilter), FLastAuthorID);
    FillSeriesTree(tvSeries, FCollection.GetSeriesIterator(smFullFilter), FLastSeriesID);
    FillAllBooksTree;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.ShowLocalOnlyUpdate(Sender: TObject);
begin
  acViewShowLocalOnly.Visible := IsOnline;
  acViewShowLocalOnly.Checked := Settings.ShowLocalOnly;
end;

procedure TfrmMain.ShowBookDelete(Sender: TObject);
begin
  acBookDelete.Visible := IsPrivate or IsOnline;
  acCollectionSyncFiles.Visible := IsPrivate or IsOnline;
end;

procedure TfrmMain.SetInfoPanelHeight(Height: Integer);
begin
  ipnlAuthors.Height := Height;
  ipnlSeries.Height := Height;
  ipnlGenres.Height := Height;
  ipnlSearch.Height := Height;
  ipnlFavorites.Height := Height;
end;

procedure TfrmMain.SetInfoPanelVisible(State: Boolean);
begin
  ipnlAuthors.Visible := State;
  AuthorBookInfoSplitter.Visible := State;

  ipnlSeries.Visible := State;
  SerieBookInfoSplitter.Visible := State;

  ipnlGenres.Visible := State;
  GenreBookInfoSplitter.Visible := State;

  ipnlSearch.Visible := State;
  SearchBookInfoSplitter.Visible := State;

  ipnlFavorites.Visible := State;
  GroupBookInfoSplitter.Visible := State;
end;

procedure TfrmMain.SetShowBookCover(State: Boolean);
begin
  ipnlAuthors.ShowCover := State;
  ipnlSeries.ShowCover := State;
  ipnlGenres.ShowCover := State;
  ipnlSearch.ShowCover := State;
  ipnlFavorites.ShowCover := State;
end;

procedure TfrmMain.SetShowBookAnnotation(State: Boolean);
begin
  ipnlAuthors.ShowAnnotation := State;
  ipnlSeries.ShowAnnotation := State;
  ipnlGenres.ShowAnnotation := State;
  ipnlSearch.ShowAnnotation := State;
  ipnlFavorites.ShowAnnotation := State;
end;

procedure TfrmMain.SetBookInfoPriority(State: Boolean);
begin
  ipnlAuthors.InfoPriority := State;
  ipnlSeries.InfoPriority := State;
  ipnlGenres.InfoPriority := State;
  ipnlSearch.InfoPriority := State;
  ipnlFavorites.InfoPriority := State;
end;

procedure TfrmMain.tbClearEdAuthorClick(Sender: TObject);
begin
  SetTextNoChange(edLocateAuthor, '');
  frmMain.ActiveControl := edLocateAuthor;
end;

procedure TfrmMain.tbCollapseClick(Sender: TObject);
var
  Tree: TBookTree;
begin
  GetActiveTree(Tree);
  if Tree.Expanded[Tree.GetFirst] then
    Tree.FullCollapse(nil)
  else
    Tree.FullExpand(nil);
end;

function TfrmMain.GetViewTree(view: TView): TBookTree;
begin
  case view of
    AuthorsView:
      Result := tvBooksA;
    SeriesView:
      Result := tvBooksS;
    GenresView:
      Result := tvBooksG;
    SearchView:
      Result := tvBooksSR;
    FavoritesView:
      Result := tvBooksF;
  else
    begin
      Assert(False, rstrCheckUsage);
      Result := nil;
    end;
  end;
end;

procedure TfrmMain.GroupMenuItemClick(Sender: TObject);
begin
  AddBookToGroup(Sender);
end;

procedure TfrmMain.GetActiveTree(var Tree: TBookTree);
begin
  Tree := GetViewTree(ActiveView);
end;

procedure TfrmMain.Selection(SelState: Boolean);
var
  Node: PVirtualNode;
  Tree: TBookTree;
begin
  GetActiveTree(Tree);
  Tree.BeginUpdate;
  try
    Node := Tree.GetFirst;
    while Assigned(Node) do
    begin
      if SelState then
        Node.CheckState := csCheckedNormal
      else
        Node.CheckState := csUncheckedNormal;
      Node := Tree.GetNext(Node);
    end;
  finally
    Tree.EndUpdate;
  end;
end;

procedure TfrmMain.OnSelectBookHandler(MoveForward: Boolean);
var
  Tree: TBookTree;
  NewNode, OldNode: PVirtualNode;
  Data: PBookRecord;
begin
  GetActiveTree(Tree);
  OldNode := Tree.GetFirstSelected;
  NewNode := OldNode;

  repeat
    if MoveForward then
    begin
      NewNode := Tree.GetNext(NewNode);
      if not Assigned(NewNode) then
        NewNode := Tree.GetFirst;
    end
    else
    begin
      NewNode := Tree.GetPrevious(NewNode);
      if not Assigned(NewNode) then
        NewNode := Tree.GetLast;
    end;

    Data := Tree.GetNodeData(NewNode);
  until Data^.nodeType = ntBookInfo;

  Tree.Selected[OldNode] := False;
  Tree.Selected[NewNode] := True;
  Tree.FocusedNode := NewNode;
end;

procedure TfrmMain.tbSelectAllClick(Sender: TObject);
begin
  FSelectionState := not FSelectionState;
  Selection(FSelectionState);
end;

// - - - - - - Дерево книг для поиска, серий и избранного - - - - - - - - - - - -

procedure TfrmMain.FillBooksTree(
  const Tree: TBookTree;
  const LangSelector: TComboBox;
  const BookIterator: IBookIterator;
  ShowAuth: Boolean;
  ShowSer: Boolean;
  SelectedID: PBookKey
);
var
  AuthorNode: PVirtualNode;
  SerieNode: PVirtualNode;
  BookNode: PVirtualNode;
  SelectedNode: PVirtualNode;

  Data: PBookRecord;
  Max, i: Integer;
  Author: string;

  AuthorNodes: TDictionary<string, PVirtualNode>;

  SeriesID: Integer;

  BookRecord: TBookRecord;
  SavedCursor: TCursor;

  SelectedLang: string;

begin
  Assert(Assigned(Tree));
  Assert(Assigned(BookIterator));

  //
  // Если включен "плоский" режим отображения, принудительно сбрасываем ключи блокировки
  //
  if Settings.TreeModes[Tree.Tag] = tmFlat then
  begin
    ShowAuth := False;
    ShowSer := False;
  end;

  ShowStatusProgress := True;
  StatusProgress := 0;

  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Tree.BeginUpdate;
    try
      Tree.Clear;
      Tree.NodeDataSize := SizeOf(TBookRecord);

      SelectedNode := nil;

      StatusMessage := rstrBuildingTheList;

      if LangSelector <> nil then
      begin
        SelectedLang := LangSelector.Text;

        if not FLangSelected then
        begin
          LangSelector.Items.Clear;
          LangSelector.Items.Add('-');
          LangSelector.ItemIndex := 0;
          FLangSelected := False;
        end;

      end;

      i := 0;
      try
        AuthorNodes := TDictionary<string, PVirtualNode>.Create;
        try
          Max := BookIterator.RecordCount;

          while BookIterator.Next(BookRecord) do
          begin
            if LangSelector <> nil then
            begin
              // Добавление в ComboBox отсутствующего в нем языка.
              // Можно добавить сразу в список несколько языков как в cbLang
              // но скорость работы с диском невелирует этот if Pos(
              if Pos(BookRecord.Lang, LangSelector.Items.Text) = 0 then
                LangSelector.Items.Add(BookRecord.Lang);

              //    and ((BookRecord.Lang = 'ru') or (BookRecord.Lang = 'bg'))
              // Соответственно добавление в дерево узла с выбранным языком (или любым
              // при выборе '-') и пропуск всех остальных
              if (BookRecord.Lang <> SelectedLang) AND (SelectedLang <> '-')then Continue;
              SeriesID := BookRecord.SeriesID;
            end;

            AuthorNode := nil;
            if ShowAuth then
            begin
              Author := TAuthorsHelper.GetList(BookRecord.Authors);
              if not AuthorNodes.TryGetValue(Author, AuthorNode) then
              begin
                AuthorNode := Tree.AddChild(nil);
                Data := Tree.GetNodeData(AuthorNode);

                Initialize(Data^);
                Data^.nodeType := ntAuthorInfo;
                Data^.Authors := BookRecord.Authors;

                AuthorNodes.Add(Author, AuthorNode);
              end;
            end
            else
              AuthorNode := nil;

            Assert(ShowAuth = Assigned(AuthorNode));

            if ShowSer then
            begin
              if SeriesID = NO_SERIES_ID then
              begin
                //
                // книга без серии
                //
                SerieNode := AuthorNode;
              end
              else
              begin
                SerieNode := FindSeriesInTree(Tree, AuthorNode, SeriesID);
                if not Assigned(SerieNode) then
                begin
                  //
                  // Серия не найдена
                  //
                  //
                  Assert(not Assigned(SerieNode));

                  SerieNode := Tree.AddChild(AuthorNode);

                  //
                  // заполним данные о серии
                  //
                  Data := Tree.GetNodeData(SerieNode);

                  Data^.nodeType := ntSeriesInfo;
                  Data^.SeriesID := SeriesID;
                  Data^.Series := BookRecord.Series;
                end;
              end;
            end
            else
              SerieNode := AuthorNode;

            //
            // заполним данные о книге
            //
            BookNode := Tree.AddChild(SerieNode);
            Data := Tree.GetNodeData(BookNode);
            Data^ := BookRecord;

            if Assigned(SelectedID) and SelectedID^.IsSameAs(Data^.BookKey) then
              SelectedNode := BookNode;

            Inc(i);
            StatusProgress := i * 100 div Max;
          end; // while
          //
          // Отсортировать дерево
          //
          if (Settings.TreeModes[Tree.Tag] = tmFlat) then
            Tree.SortTree(FSortSettings[Tree.Tag].Column, FSortSettings[Tree.Tag].Direction)
          else
            Tree.SortTree(NoColumn, sdAscending);
        finally
          FreeAndNil(AuthorNodes);
        end;
      finally
        ShowStatusProgress := False;
        StatusMessage := rstrReadyMessage;
      end;

      //
      // Выбрать книгу
      //
      if not Assigned(SelectedNode) then
      begin
        SelectedNode := Tree.GetFirst;
        while Assigned(SelectedNode) do
        begin
          Data := Tree.GetNodeData(SelectedNode);
          if Data^.nodeType = ntBookInfo then
            Break;
          SelectedNode := Tree.GetNext(SelectedNode);
        end;
      end;

      if Assigned(SelectedNode) then
      begin
        Tree.Selected[SelectedNode] := True;
        Tree.FocusedNode := SelectedNode;
        Tree.FullyVisible[SelectedNode] := True;
        Tree.ScrollIntoView(SelectedNode, True);
      end;
    finally
      Tree.EndUpdate;
    end;

    case Tree.Tag of
      0: lblBooksTotalA.Caption := Format('(%d)', [i]);
      1: lblBooksTotalS.Caption := Format('(%d)', [i]);
      2: lblBooksTotalG.Caption := Format('(%d)', [i]);
      3: lblTotalBooksFL.Caption := Format('(%d)', [i]);
      4: lblBooksTotalF.Caption := Format('(%d)', [i]);
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.miCopyAuthorClick(Sender: TObject);
var
  AuthorData: PAuthorData;
  SerieData: PSeriesData;
  GenreData: PGenreData;
  strText: string;

  Node: PVirtualNode;

begin
  strText := '';

  case ActiveView of
    AuthorsView:
      begin
        Node := tvAuthors.GetFirstSelected;
        while Assigned(Node) do
        begin
          AuthorData := tvAuthors.GetNodeData(Node);
          if strText = '' then
            strText := AuthorData^.GetFullName
          else
            strText := strText + CRLF + AuthorData^.GetFullName;
          Node := tvAuthors.GetNextSelected(Node);
        end;
      end;

    SeriesView:
      begin
        Node := tvSeries.GetFirstSelected;
        while Assigned(Node) do
        begin
          SerieData := tvSeries.GetNodeData(Node);
          if strText = '' then
            strText := SerieData^.SeriesTitle
          else
            strText := strText + CRLF + SerieData^.SeriesTitle;
          Node := tvSeries.GetNextSelected(Node);
        end;
      end;

    GenresView:
      begin
        Node := tvGenres.GetFirstSelected;
        while Assigned(Node) do
        begin
          GenreData := tvGenres.GetNodeData(Node);
          if strText = '' then
            strText := GenreData.GenreAlias
          else
            strText := strText + CRLF + GenreData.GenreAlias;
          Node := tvGenres.GetNextSelected(Node);
        end;
      end;
  end;

  Clipboard.AsText := Trim(strText);
end;

procedure TfrmMain.miCopyClBrdClick(Sender: TObject);
var
  Tree: TBookTree;
  S, R: string;
  Data: PBookRecord;
  Node: PVirtualNode;

begin
  GetActiveTree(Tree);

  S := '';
  R := '';

  Node := Tree.GetFirstSelected;
  while Assigned(Node) do
  begin
    Data := Tree.GetNodeData(Node);

    case Data^.nodeType of
      ntSeriesInfo:
        S := TAuthorsHelper.GetList(Data^.Authors) + '. ' + rstrSingleSeries + Data^.Series;

      ntBookInfo:
        if NO_SERIES_TITLE = Data^.Series then
          S := TAuthorsHelper.GetList(Data^.Authors) + '. ' + Data^.Title
        else
          S := TAuthorsHelper.GetList(Data^.Authors) + '. ' + rstrSingleSeries + Data^.Series + '. ' + Data^.Title;
    end;
    if S = '' then
      R := S
    else
      R := R + CRLF + S;

    Node := Tree.GetNextSelected(Node);
  end;
  Clipboard.AsText := Trim(R);
end;

procedure TfrmMain.DeleteBookExecute(Sender: TObject);
var
  Tree: TBookTree;
  Node, OldNode: PVirtualNode;
  Data: PBookRecord;
  BookFileName: string;
  SavedCursor: TCursor;
  Msg: string;
begin
  Assert(Assigned(FCollection));
  if ActiveView = FavoritesView then
  begin
    MHLShowWarning(rstrChangeCollectionToRemoveABook);
    Exit;
  end;

  if IsOnline then Msg :=  rstrRemoveSelectedBooksOnLine
    else if Settings.DeleteFiles then Msg := rstrRemoveSelectedBooksFiles
    else Msg := rstrRemoveSelectedBooks;

  if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  GetActiveTree(Tree);

  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Node := Tree.GetFirst;
    while Assigned(Node) do
    begin
      Data := Tree.GetNodeData(Node);
      Assert(Assigned(Data));

      if (Data.nodeType = ntBookInfo) and (IsSelectedBookNode(Node, Data)) then
      begin
        BookFileName := Data^.GetBookFileName;

        if IsOnline then
        begin
          if (bpIsLocal in Data^.BookProps) and DeleteFile(BookFileName) then
          begin
            FCollection.SetLocal(Data^.BookKey, False);
            SetBookLocalStatus(Data^.BookKey, False);
          end;
          Node := Tree.GetNext(Node);
        end
        else
        begin
          OldNode := Node;
          Node := Tree.GetNext(Node);
          Tree.DeleteNode(OldNode);
          ClearLabels(Tree.Tag, False);

          if Settings.DeleteFiles then
          begin
            if not IsFB2 then
              DeleteFile(BookFileName)
              //MoveToRecycle(BookFileName) - работает странно. пока отключим
            else if IsFB2 and IsPrivate then
              DeleteFile(BookFileName);
              //MoveToRecycle(BookFileName);
          end;

          FCollection.BeginBulkOperation;
          try
            FCollection.DeleteBook(Data.BookKey);
            FCollection.EndBulkOperation(True);
          except
            FCollection.EndBulkOperation(False);
          end;
        end;
      end
      else
        Node := Tree.GetNext(Node);
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.DeleteCollectionExecute(Sender: TObject);
var
  CollectionID: Integer;
  deleteAction: TDeleteCollectionAction;
  CollectionInfoIterator: ICollectionInfoIterator;
  CollectionInfo: TCollectionInfo;
begin
  Assert(Assigned(FCollection));

  { TODO -oNickR -cUsability : Думаю, стоит сделать специальный диалог для этого случая. Тогда мы сможем спросить, удалять файл коллекции или нет. }
  deleteAction := AskDeleteCollectionAction;
  if deleteAction in [dcaDelete, dcaUnregister] then
  begin
    CollectionID := FCollection.CollectionID;

    //
    // TODO: необходимо закрыть коллекцию перед удалением и закрыть ее в менеджере закачек
    //
    CloseCollection;
    FSystemData.DeleteCollection(CollectionID, dcaDelete = deleteAction);

    CollectionInfoIterator := FSystemData.GetCollectionInfoIterator;
    if CollectionInfoIterator.Next(CollectionInfo) then
      Settings.ActiveCollection := CollectionInfo.ID
    else
      Settings.ActiveCollection := INVALID_COLLECTION_ID;

    InitCollection;
  end;

  //if MessageDlg(rstrRemoveCollection + '"' + FCollection.CollectionDisplayName + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  //  Exit;
end;

procedure TfrmMain.miDeleteFilesClick(Sender: TObject);
var
  DatabaseID: Integer;
  FilePath: string;
begin
  Assert(Assigned(FCollection));
  DatabaseID := FCollection.CollectionID;

  ProcessNodes(
    procedure (Tree: TBookTree; Node: PVirtualNode)
    var
      Data: PBookRecord;
    begin
      Data := Tree.GetNodeData(Node);
      if Assigned(Data) and (Data^.nodeType = ntBookInfo) and (Data^.BookKey.DatabaseID = DatabaseID) then
      begin
        FilePath := Data^.GetBookFileName;
        try
          if TFile.Exists(FilePath) then
            TFile.Delete(FilePath);
        except
          // игнорируем все ошибки
        end;

        if (bpIsLocal in Data^.BookProps) then
          FCollection.SetLocal(Data^.BookKey, False);

        UpdateNodes(
          Data^.BookKey,
          procedure(BookData: PBookRecord)
          begin
            Assert(Assigned(BookData));
            Exclude(BookData^.BookProps, bpIsLocal);
          end
        );
      end;
    end
  );
end;



procedure TfrmMain.acBookAdd2FavoritesExecute(Sender: TObject);
begin
  if ActiveView = FavoritesView then
    DeleteBookFromGroup(Sender)
  else if FSystemData.ActivateGroup(FAVORITES_GROUP_ID) then
    AddBookToGroup(Sender);
end;

procedure TfrmMain.acBookAdd2GroupExecute(Sender: TObject);
begin
  if FSystemData.ActivateGroup(FAVORITES_GROUP_ID) then AddBookToGroup(Sender);
end;

procedure TfrmMain.acBookRemoveFromGroupExecute(Sender: TObject);
begin
  if ActiveView = FavoritesView then DeleteBookFromGroup(Sender)
end;

procedure TfrmMain.acViewSetInfoPriorityExecute(Sender: TObject);
begin
  Settings.Fb2InfoPriority := not Settings.Fb2InfoPriority ;
  SetBookInfoPriority(Settings.Fb2InfoPriority);
end;

procedure TfrmMain.Add2DownloadListExecute(Sender: TObject);
var
  Tree: TBookTree;

  BookNode: PVirtualNode;
  BookData: PBookRecord;

  DownloadNode: PVirtualNode;
  DownloadData: PDownloadData;

  function BookInDownloadList(const BookKey: TBookKey): Boolean;
  var
    Node: PVirtualNode;
    Data: PDownloadData;
  begin
    Result := False;

    Node := tvDownloadList.GetFirst;
    while Assigned(Node) do
    begin
      Data := tvDownloadList.GetNodeData(Node);
      if (Data^.BookKey.IsSameAs(BookKey)) then
      begin
        Result := True;
        Break;
      end;

      Node := tvDownloadList.GetNext(Node);
    end;
  end;

begin
  Assert(Assigned(FCollection));
  if ActiveView = DownloadView then
  begin
    btnDeleteDownloadClick(Sender);
    Exit;
  end;

  GetActiveTree(Tree);

  BookNode := Tree.GetFirst;
  while Assigned(BookNode) do
  begin
    BookData := Tree.GetNodeData(BookNode);
    Assert(Assigned(BookData));
    if IsSelectedBookNode(BookNode, BookData) then
    begin
      if not (bpIsLocal in BookData^.BookProps) and (BookData^.BookKey.DatabaseID = FCollection.CollectionID) then
      begin
        if not BookInDownloadList(BookData^.BookKey) then
        begin
          DownloadNode := tvDownloadList.AddChild(nil);
          DownloadData := tvDownloadList.GetNodeData(DownloadNode);

          Initialize(DownloadData^);
          DownloadData^.BookKey := BookData^.BookKey;
          DownloadData^.Author := TAuthorsHelper.GetList(BookData^.Authors);
          DownloadData^.Title := BookData^.Title;
          DownloadData^.Size := BookData^.Size;
          DownloadData^.FileName := BookData^.GetBookFileName;
          DownloadData^.URL := Format(Settings.InpxURL + 'b/%s/get', [BookData^.LibID]);
          DownloadData^.State := dsWait;

        end;
      end;

      Tree.CheckState[BookNode] := csUncheckedNormal;
    end;
    BookNode := Tree.GetNext(BookNode);
  end;

  lblDownloadCount.Caption := Format('(%d)', [tvDownloadList.ChildCount[nil]]);

  if Settings.AutoStartDwnld then
    btnStartDownloadClick(Sender);
end;

procedure TfrmMain.EditAuthorExecute(Sender: TObject);
var
  Data: PAuthorData;
begin
  Data := tvAuthors.GetNodeData(tvAuthors.GetFirstSelected);
  try
    frmEditAuthorData := TfrmEditAuthorData.Create(Self);
    with frmEditAuthorData do
    begin
      FirstName := Data.FirstName;
      LastName := Data.LastName;
      MidName := Data.MiddleName;
      if ShowModal = mrOK then
      begin
        Data.FirstName := FirstName;
        Data.LastName := LastName;
        Data.MiddleName := MidName;

        FCollection.UpdateAuthor(Data);
        tvAuthors.RepaintNode(tvAuthors.GetFirstSelected);
      end;
    end;
  finally
    FreeAndNil(frmEditAuthorData);
  end;
end;

function TfrmMain.IsLibRusecEdit(const BookKey: TBookKey): Boolean;
var
  BookRecord: TBookRecord;
  URL: string;
  BookCollection: IBookCollection;
begin
  if BookKey.DatabaseID <> FCollection.CollectionID then
    BookCollection := FSystemData.GetCollection(BookKey.DatabaseID)
  else
    BookCollection := FCollection;

  Assert(Assigned(BookCollection));
  if isExternalCollection(BookCollection.CollectionCode) then
  begin
    //
    // DONE -oNickR : Думаю, стоит приделать к этому диалогу возможность запоминать выбор пользователя и переходить на сайт без вопроса
    //
    if MHLShowWarning(Format(rstrGoToLibrarySite, [BookCollection.CollectionURL]), mbYesNo) = mrYes then
    begin
      BookCollection.GetBookRecord(BookKey, BookRecord, False);
      { TODO -oNickR -cLibDesc : этот URL должен формироваться обвязкой библиотеки, т к его формат может меняться }
      URL := Format('%sb/%s/edit', [BookCollection.CollectionURL, BookRecord.LibID]);
      SimpleShellExecute(Handle, URL);
    end;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmMain.EditBookExecute(Sender: TObject);
var
  Tree: TBookTree;
  Data: PBookRecord;
  Node: PVirtualNode;
  frmEditBook: TfrmEditBookInfo;
begin
  Assert(Assigned(FCollection));
  if (ActiveView = DownloadView) then
  begin
    MHLShowWarning(rstrNotFromDownloadsError);
    Exit;
  end;

  GetActiveTree(Tree);
  Node := Tree.GetFirstSelected;
  Data := Tree.GetNodeData(Node);
  if not Assigned(Data) or (Data^.nodeType <> ntBookInfo) then
    Exit;

  if IsLibRusecEdit(Data^.BookKey) then
    Exit;

  frmEditBook := TfrmEditBookInfo.Create(Application);
  try
    if Data^.BookKey.DatabaseID <> FCollection.CollectionID then
      frmEditBook.Collection := FSystemData.GetCollection(Data^.BookKey.DatabaseID)
    else
      frmEditBook.Collection := FCollection;

    if ActiveView = AuthorsView then
       FCollection.SetProperty(PROP_LAST_AUTHOR_BOOK, Data.BookKey.BookID);

    if ActiveView = SeriesView then
       FCollection.SetProperty(PROP_LAST_SERIES_BOOK, Data.BookKey.BookID);

    frmEditBook.OnReadBook := OnReadBookHandler;
    frmEditBook.OnGetBook := OnGetBookHandler;
    frmEditBook.OnSelectBook := OnSelectBookHandler;
    frmEditBook.OnUpdateBook := OnUpdateBookHandler;
    frmEditBook.OnHelp := OnHelpHandler;

    if frmEditBook.ShowModal = mrOk then
    begin
      UpdatePositions;
      InitCollection;
    end;
  finally
    frmEditBook.Free;
  end;
end;

procedure TfrmMain.EditGenresExecute(Sender: TObject);
var
  NodeB: PVirtualNode;
  DataB: PBookRecord;
  Tree: TBookTree;
begin
  Assert(Assigned(FCollection));
  if ActiveView = FavoritesView then
  begin
    MHLShowWarning(rstrUnableToEditBooksFromFavourites);
    Exit;
  end;

  if IsLibRusecEdit(CreateBookKey(0, FCollection.CollectionID)) then
    Exit;

  GetActiveTree(Tree);

  FillGenresTree(frmGenreTree.tvGenresTree, FCollection.GetGenreIterator(gmAll));

  if frmGenreTree.ShowModal = mrOk then
  begin
    NodeB := Tree.GetFirst;
    while Assigned(NodeB) do
    begin
      DataB := Tree.GetNodeData(NodeB);
      if (DataB^.nodeType = ntBookInfo) and ((Tree.CheckState[NodeB] = csCheckedNormal) or (Tree.Selected[NodeB])) then
      begin
        frmGenreTree.GetSelectedGenres(DataB^);

        FCollection.BeginBulkOperation;
        try
          FCollection.SetBookGenres(DataB.BookKey.BookID, DataB^.Genres, True);

          FCollection.EndBulkOperation(True); // commit
        except
          FCollection.EndBulkOperation(False); // rollback
        end;
      end;
      Tree.RepaintNode(NodeB);
      NodeB := Tree.GetNext(NodeB);
    end;
    UpdatePositions;
    InitCollection;
  end;
end;

procedure TfrmMain.EditSeriesExecute(Sender: TObject);
var
  Tree: TBookTree;
  Data: PBookRecord;
  Node: PVirtualNode;
  S: string;
  SeriesID: Integer;
begin
  Assert(Assigned(FCollection));
  if ActiveView = FavoritesView then
  begin
    MHLShowWarning(rstrUnableToEditBooksFromFavourites);
    Exit;
  end;

  GetActiveTree(Tree);
  Node := Tree.GetFirstSelected;
  Data := Tree.GetNodeData(Node);
  if not Assigned(Data) then
    Exit;

  if IsLibRusecEdit(Data^.BookKey) then
    Exit;

//  if ActiveView = AuthorsView then
//       Settings.LastBookInAuthors := Data.BookKey.BookID;
//
//  if ActiveView = SeriesView then
//       Settings.LastBookInSeries := Data.BookKey.BookID;


  S := Data^.Series;

  if Data^.nodeType = ntBookInfo then // Standing on a book node, change/add series info
  begin
    if InputQuery(rstrCreateMoveSeries, rstrTitle, S) then
    begin
      SeriesID := FCollection.FindOrCreateSeries(S);
      Node := Tree.GetFirst;
      while Assigned(Node) do
      begin
        Data := Tree.GetNodeData(Node);
        if ((Tree.CheckState[Node] = csCheckedNormal) or (Tree.Selected[Node])) then
          FCollection.SetSeriesID(Data^.BookKey, SeriesID);
        Node := Tree.GetNext(Node);
      end;

      FillAllBooksTree;
    end;
  end
  else if InputQuery(rstrEditSeries, rstrTitle, S) then // Change a series node
  begin
    if S = NO_SERIES_TITLE then
    begin
      // Clear the series for all books in DB:
      FCollection.ChangeBookSeriesID(Data^.SeriesID, NO_SERIES_ID, FCollection.CollectionID);
      FillAllBooksTree;
    end
    else
    begin
      FCollection.SetSeriesTitle(Data^.SeriesID, S);
      Data^.Series := S;
      Tree.RepaintNode(Node);
    end;
  end;
end;

procedure TfrmMain.AddGroupExecute(Sender: TObject);
var
  GroupName: string;
begin
  if NewGroup(GroupName) then
  begin
    if FSystemData.AddGroup(GroupName) then
    begin
      CreateGroupsMenu;
      FillGroupsList(tvGroups, FSystemData.GetGroupIterator, FLastGroupID);
    end
    else
      MHLShowError(rstrGroupAlreadyExists);
  end;
end;

procedure TfrmMain.RenameGroupExecute(Sender: TObject);
var
  Data: PGroupData;
  GroupName: string;
begin
  Data := tvGroups.GetNodeData(tvGroups.GetFirstSelected());
  if not Assigned(Data) or not Data^.CanDelete then
    Exit;

  GroupName := Data^.Text;

  if EditGroup(GroupName) then
  begin
    if FSystemData.RenameGroup(Data^.GroupID, GroupName) then
    begin
      CreateGroupsMenu;
      FillGroupsList(tvGroups, FSystemData.GetGroupIterator, FLastGroupID);
    end
    else
      MHLShowError(rstrGroupAlreadyExists);
  end;
end;

procedure TfrmMain.DeleteGroupExecute(Sender: TObject);
var
  Data: PGroupData;
begin
  Data := tvGroups.GetNodeData(tvGroups.GetFirstSelected());
  if not Assigned(Data) then
    Exit;

  if Data^.CanDelete then
  begin
    FSystemData.DeleteGroup(Data^.GroupID);

    CreateGroupsMenu;
    FillGroupsList(tvGroups, FSystemData.GetGroupIterator, FLastGroupID);
  end
  else
    MHLShowError(rstrUnableDeleteBuiltinGroupError);
end;

//
// Очистить выделенную группу
//
procedure TfrmMain.ClearGroupExecute(Sender: TObject);
var
  GroupData: PGroupData;
  SavedCursor: TCursor;
begin
  GroupData := tvGroups.GetNodeData(tvGroups.GetFirstSelected());
  if not Assigned(GroupData) then
    Exit;

  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FSystemData.ClearGroup(GroupData^.GroupID);

    FillBooksTree(tvBooksF, cbLangSelectF, FSystemData.GetBookIterator(FLastGroupID), True, True, @FLastGroupBookID); // избранное
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.ChangeToolbarVisability(ToolBars: array of TToolBar; ToolBar: TToolBar; ShowToolbar: Boolean);
var
  BarTop: Integer;
  i: Integer;
begin
  DisableAlign;
  try
    if ShowToolbar then
    begin
      //
      // раздвигаем тулбары для правильного алигна
      // Располагаем текущий тулбар под первым видимым старшим
      // а все видимые младшие сдвигаем на 1 ниже
      //
      BarTop := 0;
      for i := 0 to High(ToolBars) do
      begin
        if ToolBars[i] = ToolBar then
          Break;
        if ToolBars[i].Visible then
          BarTop := ToolBars[i].BoundsRect.Bottom;
      end;

      ToolBar.Top := BarTop;

      for i := High(ToolBars) downto 0 do
      begin
        if ToolBars[i] = ToolBar then
          Break;
        if ToolBars[i].Visible then
          ToolBars[i].Top := ToolBars[i].Top + 1;
      end;
    end;
    ToolBar.Visible := ShowToolbar;
  finally
    EnableAlign;
  end;
end;

procedure TfrmMain.ShowRusAlphabetUpdate(Sender: TObject);
begin
  acShowRusAlphabet.Checked := Settings.ShowRusBar;
end;

procedure TfrmMain.ShowRusAlphabetExecute(Sender: TObject);
begin
  Settings.ShowRusBar := not Settings.ShowRusBar;
  ChangeToolbarVisability(FAuthorBars, tbarAuthorsRus, Settings.ShowRusBar);
  ChangeToolbarVisability(FSerieBars, tbarSeriesRus, Settings.ShowRusBar);
end;

procedure TfrmMain.ShowEngAlphabetUpdate(Sender: TObject);
begin
  acShowEngAlphabet.Checked := Settings.ShowEngBar;
end;

procedure TfrmMain.ShowEngAlphabetExecute(Sender: TObject);
begin
  Settings.ShowEngBar := not Settings.ShowEngBar;
  ChangeToolbarVisability(FAuthorBars, tbarAuthorsEng, Settings.ShowEngBar);
  ChangeToolbarVisability(FSerieBars, tbarSeriesEng, Settings.ShowEngBar);
end;

procedure TfrmMain.ShowEditToolbarUpdate(Sender: TObject);
begin
  acShowEditToolbar.Checked := Settings.EditToolBarVisible;
end;

procedure TfrmMain.ShowEditToolbarExecute(Sender: TObject);
begin
  Settings.EditToolBarVisible := not Settings.EditToolBarVisible;
  ChangeToolbarVisability(FMainBars, tlbrEdit, Settings.EditToolBarVisible);
end;

procedure TfrmMain.ShowMainToolbarUpdate(Sender: TObject);
begin
  acShowMainToolbar.Checked := Settings.ShowToolbar;
end;

procedure TfrmMain.ShowMainToolbarExecute(Sender: TObject);
begin
  Settings.ShowToolbar := not Settings.ShowToolbar;
  ChangeToolbarVisability(FMainBars, tlbrMain, Settings.ShowToolbar);
end;

procedure TfrmMain.ShowStatusbarUpdate(Sender: TObject);
begin
  acShowStatusbar.Checked := Settings.ShowStatusBar;
end;

procedure TfrmMain.ShowStatusbarExecute(Sender: TObject);
begin
  Settings.ShowStatusBar := not Settings.ShowStatusBar;
  StatusBar.Visible := Settings.ShowStatusBar;
end;

procedure TfrmMain.ShowBookInfoPanelUpdate(Sender: TObject);
begin
  acShowBookInfoPanel.Checked := Settings.ShowInfoPanel;
end;

procedure TfrmMain.ShowBookInfoPanelExecute(Sender: TObject);
begin
  Settings.ShowInfoPanel := not Settings.ShowInfoPanel;

  //
  // TODO: Принудительно обновим информацию о книге, т к если она не показывалась, то и не обновлялась
  //
  //if Settings.ShowInfoPanel then
  //  tvBooksTreeChange(nil, nil);

  SetInfoPanelVisible(Settings.ShowInfoPanel);
end;

procedure TfrmMain.ShowBookCoverExecute(Sender: TObject);
begin
  Settings.ShowBookCover := not Settings.ShowBookCover;

  //
  // TODO: Принудительно обновим информацию о книге, т к если она не показывалась, то и не обновлялась
  //
  //if Settings.ShowInfoPanel and Settings.ShowBookCover then
  //  tvBooksTreeChange(nil, nil);

  SetShowBookCover(Settings.ShowBookCover);
end;

procedure TfrmMain.ShowBookCoverUpdate(Sender: TObject);
begin
  acShowBookCover.Checked := Settings.ShowBookCover;
  acShowBookCover.Enabled := Settings.ShowInfoPanel;
end;

procedure TfrmMain.ShowBookAnnotationExecute(Sender: TObject);
begin
  Settings.ShowBookAnnotation := not Settings.ShowBookAnnotation;

  //
  // TODO: Принудительно обновим информацию о книге, т к если она не показывалась, то и не обновлялась
  //
  //if Settings.ShowInfoPanel and Settings.ShowBookAnnotation then
  //  tvBooksTreeChange(nil, nil);

  SetShowBookAnnotation(Settings.ShowBookAnnotation);
end;

procedure TfrmMain.ShowBookAnnotationUpdate(Sender: TObject);
begin
  acShowBookAnnotation.Checked := Settings.ShowBookAnnotation;
  acShowBookAnnotation.Enabled := Settings.ShowInfoPanel;
end;

procedure TfrmMain.BookSetRateExecute(Sender: TObject);
var
  NewRate: Integer;
begin
  Assert(Assigned(FCollection));
  if Sender = acBookSetRate1 then
    NewRate := 1
  else if Sender = acBookSetRate2 then
    NewRate := 2
  else if Sender = acBookSetRate3 then
    NewRate := 3
  else if Sender = acBookSetRate4 then
    NewRate := 4
  else if Sender = acBookSetRate5 then
    NewRate := 5
  else
    NewRate := 0;

  ProcessNodes(
    procedure (Tree: TBookTree; Node: PVirtualNode)
    var
      Data: PBookRecord;
    begin
      Data := Tree.GetNodeData(Node);
      if Assigned(Data) and (Data^.nodeType = ntBookInfo) then
      begin
        FCollection.SetRate(Data^.BookKey, NewRate);
        UpdateNodes(
          Data^.BookKey,
          procedure(BookData: PBookRecord)
          begin
            Assert(Assigned(BookData));
            BookData^.Rate := NewRate;
          end
        );
      end;
    end
  );
end;

procedure TfrmMain.UpdateBookAction(Sender: TObject);
var
  fBookNodesSelected: Boolean;
begin
  fBookNodesSelected := False;

  ProcessNodes(
    procedure (Tree: TBookTree; Node: PVirtualNode)
    var
      Data: PBookRecord;
    begin
      Data := Tree.GetNodeData(Node);
      if Assigned(Data) and (Data^.nodeType = ntBookInfo) then
      begin
        fBookNodesSelected := True;
      end;
    end
  );

  (Sender as TAction).Enabled := fBookNodesSelected;
end;

procedure TfrmMain.SavePresetUpdate(Sender: TObject);
begin
  acSavePreset.Enabled := (Trim(cbPresetName.Text) <> '');
end;

procedure TfrmMain.DeletePresetUpdate(Sender: TObject);
begin
  acDeletePreset.Enabled := cbPresetName.Items.IndexOf(cbPresetName.Text) <> -1;
end;

procedure TfrmMain.UpdateAllEditActions;
begin
  UpdateEditAction(acEditAuthor);
  UpdateEditAction(acEditSerie);
  UpdateEditAction(acEditGenre);

  tbtnAutoFBD.Visible := IsPrivate and not IsFB2;
  tbtnFBD.Visible := IsPrivate and not IsFB2;

  ChangeToolbarVisability(FMainBars, tlbrEdit, Settings.EditToolBarVisible);
end;

function TfrmMain.UpdateEditAction(Action: TAction): Boolean;
begin
  Assert(Assigned(FCollection));
  Result := isPrivateCollection(FCollection.CollectionCode);

  if Result then
    Action.Enabled := True;

  Action.Visible := Result;
end;

procedure TfrmMain.EditAuthorUpdate(Sender: TObject);
var
  Data: PAuthorData;
begin
  //
  // нельзя редактировать данные из онлайн коллекции
  //
  if UpdateEditAction(acEditAuthor) then
    Exit;

  //
  // только на старанице "по авторам"
  //
  if ActiveView <> AuthorsView then
  begin
    acEditAuthor.Enabled := False;
    Exit;
  end;

  Data := tvAuthors.GetNodeData(tvAuthors.GetFirstSelected);
  acEditAuthor.Enabled := Assigned(Data);
end;

procedure TfrmMain.EditSerieUpdate(Sender: TObject);
var
  Data: PSeriesData;
begin
  //
  // нельзя редактировать данные из онлайн коллекции
  //
  if UpdateEditAction(acEditSerie) then
    Exit;

  //
  // только на старанице "по сериям"
  //
  if ActiveView <> SeriesView then
  begin
    acEditSerie.Enabled := False;
    Exit;
  end;

  Data := tvSeries.GetNodeData(tvSeries.GetFirstSelected);
  acEditSerie.Enabled := Assigned(Data);
end;

procedure TfrmMain.EditGenreUpdate(Sender: TObject);
var
  Data: PGenreData;
begin
  //
  // нельзя редактировать данные из онлайн коллекции
  //
  if UpdateEditAction(acEditGenre) then
    Exit;

  //
  // только на старанице "по жанрам"
  //
  if ActiveView <> GenresView then
  begin
    acEditGenre.Enabled := False;
    Exit;
  end;

  Data := tvGenres.GetNodeData(tvGenres.GetFirstSelected);
  acEditGenre.Enabled := Assigned(Data);
end;

function TfrmMain.InternalUpdateGroupAction(Action: TAction): Boolean;
begin
  Result := ActiveView <> FavoritesView;
  if Result then
    Action.Enabled := False;
end;

procedure TfrmMain.AddGroupUpdate(Sender: TObject);
begin
  //
  // только на старанице "по группам"
  //
  if InternalUpdateGroupAction(acGroupCreate) then
    Exit;

  acGroupCreate.Enabled := True;
end;

procedure TfrmMain.EditGroupUpdate(Sender: TObject);
var
  Data: PGroupData;
begin
  //
  // только на старанице "по группам"
  //
  if InternalUpdateGroupAction(Sender as TAction) then
    Exit;

  Data := tvGroups.GetNodeData(tvGroups.GetFirstSelected);
  (Sender as TAction).Enabled := Assigned(Data) and Data^.CanDelete;
end;

procedure TfrmMain.ClearGroupUpdate(Sender: TObject);
var
  Data: PGroupData;
begin
  //
  // только на старанице "по группам"
  //
  if InternalUpdateGroupAction(acGroupClear) then
    Exit;

  Data := tvGroups.GetNodeData(tvGroups.GetFirstSelected);
  acGroupClear.Enabled := Assigned(Data);
end;

procedure TfrmMain.AddBookToGroup(Sender: TObject);
var
  Tree: TBookTree;
  booksToProcess: Integer;
  booksProcessed: Integer;
  GroupID: Integer;
  GroupData: PGroupData;
  SavedCursor: TCursor;
begin
  Assert(Assigned(FCollection));
  GetActiveTree(Tree);
  Assert(Assigned(Tree));

  booksToProcess := Tree.CheckedCount;
  if Assigned(Tree.FocusedNode) and (Tree.CheckState[Tree.FocusedNode] <> csCheckedNormal) then
    Inc(booksToProcess);
  if booksToProcess = 0 then
    Exit;
  booksProcessed := 0;

  if Sender is TMenuItem then
    GroupID := (Sender as TMenuItem).Tag
  else
    GroupID := FAVORITES_GROUP_ID;

  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    StatusMessage := rstrAddingBookToGroup;
    StatusProgress := 0;
    ShowStatusProgress := True;
    try
      ProcessNodes(
        procedure (Tree: TBookTree; Node: PVirtualNode)
        var
          Data: PBookRecord;
        begin
          Data := Tree.GetNodeData(Node);
          if Assigned(Data) and (Data^.nodeType = ntBookInfo) then
          begin
            FCollection.AddBookToGroup(Data^.BookKey, GroupID);
            Tree.CheckState[Node] := csUncheckedNormal;
            Inc(booksProcessed);
            StatusProgress := booksProcessed * 100 div booksToProcess;
          end;
        end
      );
    finally
      ShowStatusProgress := False;
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;

  //
  // если выделенная группа совпадает с той, куда добавляем книги, нужно перерисовать список
  //
  GroupData := tvGroups.GetNodeData(tvGroups.GetFirstSelected);
  if Assigned(GroupData) and (GroupData^.GroupID = GroupID) then
  begin
    FillBooksTree(tvBooksF, cbLangSelectF, FSystemData.GetBookIterator(FLastGroupID), True, True, @FLastGroupBookID); // Группы
  end;
end;

procedure TfrmMain.DeleteBookFromGroup(Sender: TObject);
var
  GroupData: PGroupData;
  booksToProcess: Integer;
  booksProcessed: Integer;
  SavedCursor: TCursor;
begin
  Assert(ActiveView = FavoritesView);

  booksToProcess := tvBooksF.CheckedCount;
  if Assigned(tvBooksF.FocusedNode) and (tvBooksF.CheckState[tvBooksF.FocusedNode] <> csCheckedNormal) then
    Inc(booksToProcess);
  if booksToProcess = 0 then
    Exit;
  booksProcessed := 0;

  GroupData := tvGroups.GetNodeData(tvGroups.GetFirstSelected);
  if not Assigned(GroupData) then
    Exit;

  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    StatusMessage := rstrRemovingBookFromGroup;
    StatusProgress := 0;
    ShowStatusProgress := True;
    try
      ProcessNodes(
        procedure (Tree: TBookTree; Node: PVirtualNode)
        var
          Data: PBookRecord;
        begin
          Data := Tree.GetNodeData(Node);
          if Assigned(Data) and (Data^.nodeType = ntBookInfo) then
          begin
            FSystemData.DeleteFromGroup(Data.BookKey, GroupData^.GroupID);

            Inc(booksProcessed);
            StatusProgress := booksProcessed * 100 div booksToProcess;
          end;
        end
      );

      //
      // удалить информацию о книгах, не входящих ни в одну группу
      //
      FSystemData.RemoveUnusedBooks;

      FillBooksTree(tvBooksF, cbLangSelectF, FSystemData.GetBookIterator(FLastGroupID), True, True, @FLastGroupBookID);
    finally
      ShowStatusProgress := False;
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.miAddToSearchClick(Sender: TObject);
var
  Edit: TMHLButtonedEdit;
  treeView: TVirtualStringTree;
  Node: PVirtualNode;
  Data: PAuthorData;
  // TODO : отдельный тип данных для серии
begin
  case ActiveView of
    AuthorsView:
      begin
        treeView := tvAuthors;
        Edit := edFFullName;
      end;
    SeriesView:
      begin
        Assert(False, rstrNeedSpecialDataTypeForSeries);
        Exit;
        treeView := tvSeries;
        Edit := edFSeries;
      end
    else
      Assert(False);
  end;

  Node := treeView.GetFirstSelected;
  while Assigned(Node) do
  begin
    Data := treeView.GetNodeData(Node);
    if Edit.Text = '' then
      Edit.Text := Format('="%s"', [Data^.GetFullName])
    else
      Edit.Text := Format('%s OR%s="%s"', [Edit.Text, CRLF, Data^.GetFullName]);
    Node := treeView.GetNextSelected(Node);
  end;
end;

procedure TfrmMain.QuickSearchExecute(Sender: TObject);
begin
  unit_Utils.LocateBook;
end;

procedure TfrmMain.ImportFb2Execute(Sender: TObject);
begin
  Assert(Assigned(FCollection));
  unit_Import.ImportFB2(FCollection.CollectionID, afZip);

  InitCollection;
end;

procedure TfrmMain.ImportFb2Update(Sender: TObject);
var
  Action: TAction;
begin
  Assert(Sender is TAction);

  Action := Sender as TAction;
  Action.Visible := IsPrivate and (IsFB2 or Settings.AllowMixed);
  Action.Enabled := Action.Visible;
end;

procedure TfrmMain.ImportFBDExecute(Sender: TObject);
begin
  Assert(Assigned(FCollection));
  unit_Import.ImportFBD(FCollection.CollectionID);

  InitCollection;
end;

procedure TfrmMain.SaveSearchPreset(Sender: TObject);
var
  presetName: string;
  preset: TSearchPreset;
begin
  presetName := Trim(cbPresetName.Text);
  if presetName = '' then
    Exit;

  preset := FPresets.GetPreset(presetName);
  preset.Clear;

  preset.AddOrSetValue(SF_AUTHORS, edFFullName.Text);
  preset.AddOrSetValue(SF_TITLE, edFTitle.Text);
  preset.AddOrSetValue(SF_SERIES, edFSeries.Text);
  preset.AddOrSetValue(SF_GENRE_TITLE, edFGenre.Text);
  preset.AddOrSetValue(SF_GENRE_CODES, edFGenre.Hint);
  preset.AddOrSetValue(SF_ANNOTATION, edFAnnotation.Text);

  preset.AddOrSetValue(SF_FILE, edFFile.Text);
  preset.AddOrSetValue(SF_FOLDER, edFFolder.Text);
  preset.AddOrSetValue(SF_EXTENSION, edFExt.Text);

  preset.AddOrSetValue(SF_DOWNLOADED, IntToStr(cbDownloaded.ItemIndex));
  preset.AddOrSetValue(SF_KEYWORDS, edFKeyWords.Text);
  preset.AddOrSetValue(SF_DELETED, BoolToStr(cbDeleted.Checked));

  if cbDate.ItemIndex = -1 then
  begin
    preset.AddOrSetValue(SF_DATE, IntToStr(-1));
    preset.AddOrSetValue(SF_DATE_STR, cbDate.Text);
  end
  else begin
    preset.AddOrSetValue(SF_DATE, IntToStr(cbDate.ItemIndex));
    preset.AddOrSetValue(SF_DATE_STR, '');
  end;

  if cbLibRate.ItemIndex = -1 then
  begin
    preset.AddOrSetValue(SF_LIBRATE, IntToStr(-1));
    preset.AddOrSetValue(SF_LIBRATE_STR, cbLibRate.Text);
  end
  else begin
    preset.AddOrSetValue(SF_LIBRATE, IntToStr(cbLibRate.ItemIndex));
    preset.AddOrSetValue(SF_LIBRATE_STR, '');
  end;


  preset.AddOrSetValue(SF_LANG, IntToStr(cbLang.ItemIndex));
  preset.AddOrSetValue(SF_READED, BoolToStr(cbReaded.Checked));

  FPresets.Save(Settings.SystemFileName[sfPresets]);

  if cbPresetName.Items.IndexOf(presetName) = -1 then
    cbPresetName.Items.Add(presetName);
end;

procedure TfrmMain.LocateAuthor(const Text: string);
var
  Node: PVirtualNode;
  Data: PAuthorData;
begin
  tvAuthors.ClearSelection;
  Node := tvAuthors.GetFirst;

  while Assigned(Node) do
  begin
    Data := tvAuthors.GetNodeData(Node);
    Assert(Assigned(Data));
    if StartsText(Text, Data^.GetFullName) then
    begin
      tvAuthors.Selected[Node] := True;
      tvAuthors.FocusedNode := Node;
      tvAuthors.TopNode := Node;
      tvAuthorsChange(tvAuthors, Node);
      Exit;
    end;
    Node := tvAuthors.GetNext(Node);
  end;
end;

procedure TfrmMain.LocateSeries(const Text: string);
var
  Node: PVirtualNode;
  Data: PSeriesData;
begin
  tvSeries.ClearSelection;
  Node := tvSeries.GetFirst;

  while Assigned(Node) do
  begin
    Data := tvSeries.GetNodeData(Node);
    Assert(Assigned(Data));
    if StartsText(Text, Data^.SeriesTitle) then
    begin
      tvSeries.Selected[Node] := True;
      tvSeries.FocusedNode := Node;
      tvSeries.TopNode := Node;
      tvSeriesChange(tvSeries, Node);
      Exit;
    end;
    Node := tvSeries.GetNext(Node);
  end;
end;

procedure TfrmMain.LocateBook(const Text: string; MoveForward: Boolean);
var
  Node: PVirtualNode;
  Data: PBookRecord;
  L: Integer;
  Tree: TBookTree;
  FixedText: string;
begin
  GetActiveTree(Tree);

  Tree.ClearSelection;

  if not MoveForward then
    FLastFoundBook := nil;

  if MoveForward and Assigned(FLastFoundBook) then
    Node := Tree.GetNext(FLastFoundBook)
  else
    Node := Tree.GetFirst;

  L := Length(Text);
  FixedText := AnsiUpperCase(Text);

  while Assigned(Node) do
  begin
    Data := Tree.GetNodeData(Node);
    Assert(Assigned(Data));
    if FixedText = Copy(AnsiUpperCase(Data.Title), 1, L) then
    begin
      Tree.Selected[Node] := True;
      Tree.FocusedNode := Node;
      Tree.TopNode     := Node;

      if not MoveForward then
        FFirstFoundBook := Node;

      FLastFoundBook := Node;

      Exit;
    end;
    Node := Tree.GetNext(Node);
  end;

  if Assigned(FFirstFoundBook) then
  begin
    FLastFoundBook := FFirstFoundBook;

    Tree.FocusedNode := FLastFoundBook;
    Tree.Selected[FLastFoundBook] := True;
  end;
end;

// Locate book in the Authors' panel
procedure TfrmMain.LocateAuthorAndBook(const FullAuthorName: string; const BookKey: TBookKey);
var
  authorData: PAuthorData;
  filterValue: TFilterValue;
  savedCursor: TCursor;
  Button : TToolButton;

begin
  savedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if BookKey.DatabaseID <> FCollection.CollectionID then
    begin
      Settings.ActiveCollection := BookKey.DatabaseID;
      InitCollection;
    end;

    // Locate the author :

    Button := GetFilterButton(FAuthorBars, FullAuthorName);
    if Assigned(Button) and (Button <> FLastLetterA) then
    begin
      FIgnoreAuthorChange := True;
      InternalSetAuthorFilter(Button);
    end;
    FIgnoreAuthorChange := False;
    LocateAuthor(FullAuthorName);

    authorData := tvAuthors.GetNodeData(tvAuthors.FocusedNode);
    FLastAuthorID := authorData.AuthorID;

    // Locate the book:
    filterValue := AuthorBookFilter; // uses FLastAuthorID
    FLastAuthorBookID := BookKey;
//    FillBooksTree(tvBooksA, FCollection.GetBookIterator(bmByAuthor, False, @filterValue), False, True, @FLastAuthorBookID);

    // Change current page:
    pgControl.ActivePageIndex := PAGE_AUTHORS;
    pgControlChange(nil);


  finally
    Screen.Cursor := savedCursor;
  end;
end;


procedure TfrmMain.edLocateAuthorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ActiveView = AuthorsView then
  begin
    if Key = VK_UP then
      tvAuthors.Perform(WM_KEYDOWN, VK_UP, 0)
    else if Key = VK_DOWN then
      tvAuthors.Perform(WM_KEYDOWN, VK_DOWN, 0)
    else if Key = VK_RETURN then
      frmMain.ActiveControl := tvBooksA;
  end
  else if ActiveView = SeriesView then
  begin
    if Key = VK_UP then
      tvSeries.Perform(WM_KEYDOWN, VK_UP, 0)
    else if Key = VK_DOWN then
      tvSeries.Perform(WM_KEYDOWN, VK_DOWN, 0)
    else if Key = VK_RETURN then
      frmMain.ActiveControl := tvBooksS;
  end;
end;

procedure TfrmMain.edLocateSeriesChange(Sender: TObject);
begin
  if not tmrSearchS.Enabled then
  begin
    tmrSearchS.Enabled := True;
    FTimerDone := False;
  end;
end;

procedure TfrmMain.ShowExpressionEditor(Sender: TObject);
var
  frmEditor: TfrmEditor;
begin
  frmEditor := TfrmEditor.Create(Self);
  try
    frmEditor.Text := (Sender as TMHLButtonedEdit).Text;
    if frmEditor.ShowModal = mrOk then
      (Sender as TMHLButtonedEdit).Text := frmEditor.Text;
  finally
    frmEditor.Free;
  end;
end;

procedure TfrmMain.PresetFieldKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    acApplyPreset.Execute;
end;

procedure TfrmMain.ShowGenreEditor(Sender: TObject);
var
  frmGenres: TfrmGenreTree;
  Genres: TBookGenres;
begin
  Assert(Assigned(FCollection));
  frmGenres := TfrmGenreTree.Create(Application);
  try
    FillGenresTree(frmGenres.tvGenresTree, FCollection.GetGenreIterator(gmAll));
    if frmGenres.ShowModal = mrOk then
    begin
      frmGenres.GetSelectedGenres(Genres);

      edFGenre.Text := TArrayUtils.Join<TGenreData>(
        Genres,
        ' / ',
        function(const Genre: TGenreData): string
        begin
          Result := Genre.GenreAlias;
        end
      );

      edFGenre.Hint := TArrayUtils.Join<TGenreData>(
        Genres,
        ' OR ',
        function(const Genre: TGenreData): string
        begin
          Result := Format('(g.GenreCode = "%s")', [Genre.GenreCode]);
        end
      );
    end;
  finally
    frmGenres.Free;
  end;
end;

procedure TfrmMain.edFGenreKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(8) then
  begin
    edFGenre.Text := '';
    edFGenre.Hint := '';
  end;
  Key := Chr(0);
end;

procedure TfrmMain.ShowAboutExecute(Sender: TObject);
var
  frmAbout: TfrmAbout;
begin
  frmAbout := TfrmAbout.Create(Application);
  try
    frmAbout.ShowModal;
  finally
    frmAbout.Free;
  end;
end;

procedure TfrmMain.miActiveCollectionClick(Sender: TObject);
var
  i: Integer;
begin
  i := (Sender as TMenuItem).Tag;
  (Sender as TMenuItem).Checked := True;
  Settings.ActiveCollection := i;
  InitCollection;
end;

procedure TfrmMain.ShowBookInfo(Sender: TObject);
var
  Tree: TBookTree;
  Data: PBookRecord;
  frmBookDetails: TfrmBookDetails;

  bookStream: TStream;
  ReviewEditable: Boolean;

  URL: string;

  strReview, strAnnotation: string;
  NewCode: Integer;
begin
  Assert(Assigned(FCollection));
  GetActiveTree(Tree);
  Assert(Assigned(Tree));

  Data := Tree.GetNodeData(Tree.FocusedNode);
  if not Assigned(Data) or (Data^.nodeType <> ntBookInfo) then
    Exit;

  FFormBusy := True;
  try
    //
    // ревью можно изменять только для книг из текущей коллекции
    //
    ReviewEditable := (Data^.BookKey.DatabaseID = FCollection.CollectionID);

    frmBookDetails := TfrmBookDetails.Create(Application);
    try
      //
      // загрузим книгу в стрим и отдадим его форме для чтения из него информации
      // сейчас мы грузим только fb2 или fbd, т к больше ничего разбирать не умеем
      //
      if (bpIsLocal in Data^.BookProps) then
      begin
        // Load FB2 info only for local files that can provide one
        try
          bookStream := Data^.GetBookDescriptorStream;
          try
            frmBookDetails.FillBookInfo(Data^, bookStream)
          finally
            FreeAndNil(bookStream);
          end;
        except
          //
          // Скорее всего произошла ошибка при чтении файла (не найден, а должен был быть)
          // или при парсинге книги (загрузили какую-то ерунду).
          // Покажем сообщение об ощибке и загрузим только библиотечную информацию
          //
          on e: Exception do
          begin
            if not (e is ENotSupportedException) then
              MHLShowError(e.Message);
            frmBookDetails.FillBookInfo(Data^, nil);
          end;
        end;
      end
      else
        frmBookDetails.FillBookInfo(Data^, nil);

      frmBookDetails.mmReview.ReadOnly := not ReviewEditable;

      //if IsOnline and ReviewEditable then         - логика нарушена
      if not IsPrivate then
      begin
        { TODO -oNickR -cLibDesc : этот URL должен формироваться обвязкой библиотеки, т к его формат может меняться }
        if FCollection.CollectionURL = '' then
          URL := Format('%sb/%s/', [Settings.InpxURL, Data^.LibID])
        else
          URL := Format('%sb/%s/', [FCollection.CollectionURL, Data^.LibID]);

        frmBookDetails.AllowOnlineReview(URL);
      end;

      if bpHasReview in Data^.BookProps then
        //
        // ревью уже есть - покажем его
        //
        frmBookDetails.Review := FCollection.GetReview(Data^.BookKey)

      else if IsOnline and ReviewEditable and Settings.AutoLoadReview then
        DownloadReview(frmBookDetails, URL);

      frmBookDetails.ShowModal;

      if not frmBookDetails.ReviewChanged then
        Exit;

      strReview := frmBookDetails.Review;
      strAnnotation := frmBookDetails.Annotation;
    finally
      FreeAndNil(frmBookDetails);
    end;

    NewCode := FCollection.SetReview(Data^.BookKey, strReview);
    FCollection.SetAnnotation(Data^.BookKey, strAnnotation);
    UpdateNodes(
      Data^.BookKey,
      procedure(BookData: PBookRecord)
      begin
        Assert(Assigned(BookData));
        if NewCode = 1 then
          Include(BookData^.BookProps, bpHasReview)
        else
          Exclude(BookData^.BookProps, bpHasReview);
      end
    );
  finally
    FFormBusy := False;
  end;
end;

procedure TfrmMain.QuitAppExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.pmiCheckAllClick(Sender: TObject);
begin
  Selection(True);
end;

procedure TfrmMain.pmAuthorPopup(Sender: TObject);
begin
  // actions
  miAddToSearch.Visible := (ActiveView <> GenresView);
end;

procedure TfrmMain.pmiDeselectAllClick(Sender: TObject);
begin
  Selection(False);
end;

procedure TfrmMain.pmiSelectAllClick(Sender: TObject);
var
  Tree: TBookTree;
begin
  GetActiveTree(Tree);
  Tree.SelectAll(False);
end;

procedure TfrmMain.pmMarkSelectedClick(Sender: TObject);
var
  Node: PVirtualNode;
  Tree: TBookTree;
begin
  GetActiveTree(Tree);
  Tree.BeginUpdate;
  try
    Node := Tree.GetFirstSelected;
    while Assigned(Node) do
    begin
      Node.CheckState := csCheckedNormal;
      Node := Tree.GetNextSelected(Node);
    end;
  finally
    Tree.EndUpdate;
  end;
end;

procedure TfrmMain.GoForumExecute(Sender: TObject);
begin
  SimpleShellExecute(Handle, PROGRAM_HOMEPAGE);
end;

procedure TfrmMain.GoSiteExecute(Sender: TObject);
begin
  SimpleShellExecute(Handle, PROGRAM_HOMEPAGE);
end;

procedure TfrmMain.miGoToAuthorClick(Sender: TObject);
var
  Tree: TBookTree;
  Node: PVirtualNode;
  Data: PBookRecord;
  BookKey: TBookKey;
  FullAuthorName: string;
begin
  Assert(Assigned(FCollection));
  GetActiveTree(Tree);

  Node := Tree.FocusedNode;
  Assert(Assigned(Node));

  Data := Tree.GetNodeData(Node);

  if not Assigned(Data) then
    Exit;

  if (Data^.nodeType <> ntBookInfo) then
  begin
    if not Tree.HasChildren[Node] then
      Exit;
    repeat
      Node := Tree.GetFirstChild(Node);
      Data := Tree.GetNodeData(Node);
    until (Data^.nodeType = ntBookInfo);
  end;

  Assert(Length(Data^.Authors) > 0);
  FullAuthorName := Data^.Authors[0].GetFullName;
  BookKey := Data^.BookKey;

  LocateAuthorAndBook(FullAuthorName, BookKey);
end;

procedure TfrmMain.ShowCollectionStatisticsExecute(Sender: TObject);
var
  frmStat: TfrmStat;
begin
  Assert(Assigned(FCollection));
  frmStat := TfrmStat.Create(Application);
  try
    frmStat.LoadCollectionInfo(FCollection);
    frmStat.ShowModal;
  finally
    frmStat.Free;
  end;
end;

procedure TfrmMain.SyncFilesExecute(Sender: TObject);
begin
  Assert(Assigned(FCollection));
  UpdatePositions;

  if isOnlineCollection(FCollection.CollectionCode) then
    unit_Utils.SyncOnLineFiles(FCollection.CollectionID)
  else
  begin
    unit_Utils.SyncFolders(FCollection.CollectionID);
    //
    // Пока это нужно, т к рабочий поток не сообщает основному об изменении свойств книги
    //
    InitCollection;
  end;
end;

procedure TfrmMain.UpdateOnlineCollectionExecute(Sender: TObject);
var
  ActiveCollectionID: Integer;
begin
  Assert(Assigned(FCollection));
  if CheckLibUpdates(False) then
  begin
    UpdatePositions;

    ActiveCollectionID := FCollection.CollectionID;
    StartLibUpdate;
    Settings.ActiveCollection := ActiveCollectionID;
    InitCollection;
  end;
end;

procedure TfrmMain.mi_dwnl_LocateAuthorClick(Sender: TObject);
var
  Data: PDownloadData;
begin
  Data := tvDownloadList.GetNodeData(tvDownloadList.FocusedNode);
  if Assigned(Data) then
  begin
    LocateAuthorAndBook(Data.Author, Data^.BookKey);
  end;
end;

procedure TfrmMain.N27Click(Sender: TObject);
begin
  DeleteFile(Settings.SystemFileName[sfColumnsStore]);
  SetColumns;
  SetHeaderPopUp;
end;

procedure TfrmMain.CompactDataBaseExecute(Sender: TObject);
begin
  Assert(Assigned(FCollection));
  FCollection.CompactDatabase;
end;

procedure TfrmMain.Conver2FBDExecute(Sender: TObject);
var
  Tree: TBookTree;
  Node: PVirtualNode;
  Data: PBookRecord;
  frmConvert: TfrmConvertToFBD;
begin
  if (ActiveView = DownloadView) then
  begin
    MHLShowWarning(rstrNotFromDownloadsError);
    Exit;
  end;

  //
  // Locate the selected book record and pass it to the edit form
  //
  GetActiveTree(Tree);
  Node := Tree.GetFirstSelected;
  Data := Tree.GetNodeData(Node);
  if not Assigned(Data) or (Data^.nodeType <> ntBookInfo) then
    Exit;

  if (AnsiLowerCase(Data^.FileExt) = FB2_EXTENSION) then
  begin
    MHLShowWarning(Format(rstrNotForExtension, [Data^.FileExt]));
    Exit;
  end;

  frmConvert := TfrmConvertToFBD.Create(Application);
  try
    frmConvert.OnGetBook := OnGetBookHandler;
    frmConvert.OnReadBook := OnReadBookHandler;
    frmConvert.OnSelectBook := OnSelectBookHandler;
    frmConvert.OnChangeBook2Zip := OnChangeBook2ZipHandler;

    frmConvert.ShowModal;
  finally
    frmConvert.Free;
  end;
end;

procedure TfrmMain.N33Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.ClearReadFolderExecute(Sender: TObject);
var
  dirPath: string;
begin
  dirPath := ExcludeTrailingPathDelimiter(Settings.ReadPath);
  if DirectoryExists(dirPath) then
    ClearDir(dirPath);
end;

procedure TfrmMain.Export2HTMLExecute(Sender: TObject);
var
  Tree: TBookTree;
begin
  GetActiveTree(Tree);
  SimpleShellExecute(Handle, Export2HTML((Sender as TAction).Tag, Settings.TempPath, Tree));
end;

procedure TfrmMain.ExportUserDataExecute(Sender: TObject);
var
  FileName: string;
  Data: TUserData;
begin
  Assert(Assigned(FCollection));
  if not unit_Helpers.GetFileName(fnSaveUserData, FileName) then
    Exit;

  Data := TUserData.Create;
  try
    FCollection.ExportUserData(Data);
    Data.Save(FileName);
  finally
    Data.Free;
  end;
end;

procedure TfrmMain.HeaderPopupItemClick(Sender: TObject);
var
  i: Integer;
  Tree: TBookTree;
  Tag: Integer;
  Column: TVirtualTreeColumn;

  S: string;
  MinWidth, MaxWidth: Integer;
  Options: TVTColumnOptions;
  Alignment: TAlignment;

begin
  GetActiveTree(Tree);

  Tag := (Sender as TMenuItem).Tag;

  if (Sender as TMenuItem).Checked then
  begin // удаляем
    for i := 0 to Tree.Header.Columns.Count - 1 do
      if Tree.Header.Columns[i].Tag = Tag then
      begin
        Tree.Header.Columns.Delete(i);
        (Sender as TMenuItem).Checked := False;
        Break;
      end;
  end
  else
  begin // добавляем
    Column := TVirtualTreeColumn.Create(Tree.Header.Columns);

    GetDefaultColumnProperties(Settings.TreeModes[Tree.Tag], Tag, S, MinWidth, MaxWidth, Alignment, Options);
    Column.Tag := Tag;
    Column.Text := S;
    Column.MinWidth := MinWidth;
    Column.MaxWidth := MaxWidth;
    Column.Alignment := Alignment;
    Column.Options := Options;
    (Sender as TMenuItem).Checked := True;
  end;

  SaveColumns;
end;

function TfrmMain.OnHelpHandler(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean;
begin
  if Data = 1 then
    HtmlHelp(Application.Handle, PChar(Settings.SystemFileName[sfAppHelp]), HH_DISPLAY_TOC, 0)
  else
    HtmlHelp(Application.Handle, PChar(Settings.SystemFileName[sfAppHelp]), HH_HELP_CONTEXT, Data);

  CallHelp := False;
end;

procedure TfrmMain.ShowCollectionSettingsExecute(Sender: TObject);
var
  frmBases: TfrmBases;
begin
  Assert(Assigned(FCollection));
  frmBases := TfrmBases.Create(Application);
  try
    frmBases.SetCollection(FSystemData, FCollection);
    if frmBases.ShowModal = mrOk then
    begin
      Assert(Settings.ActiveCollection = FCollection.CollectionID);
      // Refresh the collection cache (so that each book picks up the altered root path):
      FCollection := FSystemData.GetCollection(Settings.ActiveCollection, True);

      // Init the trees:
      InitCollection;
    end;
  finally
    frmBases.Free;
  end;
end;

procedure TfrmMain.MarkAsReadedExecute(Sender: TObject);
begin
  Assert(Assigned(FCollection));

  ProcessNodes(
    procedure (Tree: TBookTree; Node: PVirtualNode)
    var
      Data: PBookRecord;
      NewProgress: Integer;
    begin
      Data := Tree.GetNodeData(Node);
      if Assigned(Data) and (Data^.nodeType = ntBookInfo) then
      begin
        // заглушка
        NewProgress := IfThen(Data^.Progress = 0, 100, 0);

        FCollection.SetProgress(Data^.BookKey, NewProgress);
        UpdateNodes(
          Data^.BookKey,
          procedure(BookData: PBookRecord)
          begin
            Assert(Assigned(BookData));
            BookData^.Progress := NewProgress;
          end
        );
      end;
    end
  );
end;

procedure TfrmMain.UpdateGenresExecute(Sender: TObject);
var
  AFileName: string;
begin
  Assert(Assigned(FCollection));
  if isFB2Collection(FCollection.CollectionCode) then
    FCollection.ReloadGenres(Settings.SystemFileName[sfGenresFB2])
  else if unit_Helpers.GetFileName(fnGenreList, AFileName) then
    FCollection.ReloadGenres(AFileName);
  InitCollection;
end;

procedure TfrmMain.RepairDataBaseExecute(Sender: TObject);
begin
  Assert(Assigned(FCollection));
  FCollection.RepairDatabase;
end;

procedure TfrmMain.ChangeSettingsExecute(Sender: TObject);
var
  frmSettings: TfrmSettings;
begin
  SaveMainFormSettings;

  frmSettings := TfrmSettings.Create(Application);
  try
    frmSettings.LoadSetting;
    frmSettings.ShowModal;

    Settings.SaveSettings;

  finally
    frmSettings.Free;
  end;
  ReadINIData;
  CreateScriptMenu; // вынесено из readinidata во избежание дублирования
end;

procedure TfrmMain.SetHeaderPopUp;
var
  Tree: TBookTree;
  i: Integer;
begin
  if ActiveView = DownloadView then
    Exit;

  GetActiveTree(Tree);

  for i := 0 to pmHeaders.Items.Count - 1 do
  begin
    pmHeaders.Items[i].Checked := False;
    pmHeaders.Items[i].Tag := ColumnTags[i];
  end;

  for i := 0 to Tree.Header.Columns.Count - 1 do
  begin
    case Tree.Header.Columns[i].Tag of
      COL_AUTHOR:
        pmHeaders.Items[0].Checked := True;
      COL_TITLE:
        pmHeaders.Items[1].Checked := True;
      COL_SERIES:
        pmHeaders.Items[2].Checked := True;
      COL_NO:
        pmHeaders.Items[3].Checked := True;
      COL_GENRE:
        pmHeaders.Items[4].Checked := True;
      COL_SIZE:
        pmHeaders.Items[5].Checked := True;
      COL_RATE:
        pmHeaders.Items[6].Checked := True;
      COL_DATE:
        pmHeaders.Items[7].Checked := True;
      COL_TYPE:
        pmHeaders.Items[8].Checked := True;
      COL_COLLECTION:
        pmHeaders.Items[9].Checked := True;
      COL_LANG:
        pmHeaders.Items[10].Checked := True;
      COL_LIBRATE:
        pmHeaders.Items[11].Checked := True;
      COL_LIBID:
        pmHeaders.Items[12].Checked := True;
    end;
  end;
  pmHeaders.Items[9].Visible := (Tree.Tag = PAGE_FAVORITES);
end;

procedure TfrmMain.pgControlChange(Sender: TObject);
var
  ToolBuutonVisible: Boolean;
begin
  UpdateActions;

  // сбрасываем закладки быстрого поиска
  FLastFoundBook := nil;
  FFirstFoundBook := nil;

  // tbtnDownloadList_Add.Enabled := (ActiveView <> FavoritesView);
  ToolBuutonVisible := (ActiveView <> DownloadView);

  BtnFav_add.Enabled := ToolBuutonVisible;
  tbSelectAll.Enabled := ToolBuutonVisible;
  tbCollapse.Enabled := ToolBuutonVisible;
  tbtnRead.Enabled := ToolBuutonVisible;
//  btnRefreshCollection.Enabled := ToolBuutonVisible;

  tbSendToDevice.Enabled := ToolBuutonVisible;
  btnSwitchTreeMode.Enabled := not((ActiveView = SeriesView) or (ActiveView = DownloadView));
  miGoToAuthor.Visible := ActiveView in [SeriesView, GenresView, SearchView, FavoritesView];

  case ActiveView of
    FavoritesView:
      begin
        // actions
        miDelFavorites.Visible := True;
        miAddFavorites.Visible := False;
        BtnFav_add.Hint := rstrRemoveFromGroup;
        BtnFav_add.DropdownMenu := nil;
        BtnFav_add.ImageIndex := 16;
        pmiGroups.Visible := False;
        miAddToGroup.Visible := False;
        miAdd2Favorites.Visible := False;
        miRemoveFromGroup.Visible := True;
        ///miDeleteFiles.Visible := False;
      end;
    DownloadView:
      begin
        tbtnDownloadList_Add.ImageIndex := 23;
        tbtnDownloadList_Add.Hint := rstrRemoveFromDownloadList;
        // actions
        btnSwitchTreeMode.Enabled := False;
        Exit;
      end;
  else
    begin
      // actions
      miDelFavorites.Visible := False;
      miAddFavorites.Visible := True;
      BtnFav_add.Hint := rstrAddToFavorites;
      BtnFav_add.DropdownMenu := pmGroups;
      BtnFav_add.ImageIndex := 15;
      pmiGroups.Visible := True;
      miAddToGroup.Visible := True;
      miAdd2Favorites.Visible := True;
      miRemoveFromGroup.Visible := False;
      ///miDeleteFiles.Visible := isOnlineCollection(FSystemData.ActiveCollection.CollectionType);
    end;

  end;

  tbtnDownloadList_Add.ImageIndex := 2;
  tbtnDownloadList_Add.Hint := rstrAddToDownloads;

  ///miEditAuthor.Enabled := (ActiveView = AuthorsView);
  ///miEditSeries.Enabled := (ActiveView = AuthorsView);
  ///tbtnEditSeries.Enabled := (ActiveView = AuthorsView);
  ///tbtnEditAuthor.Enabled := (ActiveView = AuthorsView);
  ///tlbrEdit.Enabled := (ActiveView <> FavoritesView);
  ///miGoToAuthor.Visible := (ActiveView <> AuthorsView);

  SetHeaderPopUp;

  /// tvBooksTreeChange(nil, nil);

  ///btnSwitchTreeMode.ImageIndex := TreeIcons[ord(Settings.TreeModes[pgControl.ActivePageIndex])];
  ///btnSwitchTreeMode.Hint := TreeHints[ord(Settings.TreeModes[pgControl.ActivePageIndex])];

  Settings.ActivePage := pgControl.ActivePageIndex;
end;

procedure TfrmMain.pgControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  AText: string;
  APoint: TPoint;
begin
  with (Control as TPageControl).Canvas do
  begin
    Brush.Color := clMenuBar;
    FillRect(Rect);
    AText := TPageControl(Control).Pages[TabIndex].Caption;
    with Control.Canvas do
    begin
      APoint.x := (Rect.Right - Rect.Left) div 2 - TextWidth(AText) div 2;
      APoint.y := (Rect.Bottom - Rect.Top) div 2 - TextHeight(AText) div 2;
      TextRect(Rect, Rect.Left + APoint.x, Rect.Top + APoint.y, AText);

      if Active then
      begin
        Pen.Color := $00EFD3C6;
        Pen.Width := 3;
        MoveTo(Rect.Left + 3, Rect.Top + 4); LineTo(Rect.Right - 4, 4);
      end;
    end;
   end;
end;

procedure TfrmMain.ShowHelpExecute(Sender: TObject);
begin
  HtmlHelp(Application.Handle, PChar(Settings.SystemFileName[sfAppHelp]), HH_DISPLAY_TOC, 0);
end;

procedure TfrmMain.ImportNonFB2Execute(Sender: TObject);
var
  frmAddBooks: TfrmAddnonfb2;
begin
  Assert(Assigned(FCollection));
  frmAddBooks := TfrmAddnonfb2.Create(Application);
  try
    frmAddBooks.Collection := FCollection;
    frmAddBooks.ShowModal;
    InitCollection;
  finally
    frmAddBooks.Free;
  end;
end;

procedure TfrmMain.ImportNonFB2Update(Sender: TObject);
var
  Action: TAction;
begin
  Assert(Sender is TAction);

  Action := Sender as TAction;
  Action.Visible := IsPrivate and IsNonFB2;
  Action.Enabled := Action.Visible;
end;

procedure TfrmMain.OnChangeLocalStatus(var Message: TLocalStatusChangedMessage);
begin
  Assert(Assigned(Message.Params));

  SetBookLocalStatus(Message.Params^.BookKey, Message.Params^.LocalStatus);

  Dispose(Message.Params);
end;

procedure TfrmMain.SetBookLocalStatus(const BookKey: TBookKey; IsLocal: Boolean);
begin
  UpdateNodes(
    BookKey,
    procedure(BookData: PBookRecord)
    begin
      Assert(Assigned(BookData));
      if IsLocal then
        Include(BookData^.BookProps, bpIsLocal)
      else
        Exclude(BookData^.BookProps, bpIsLocal);
    end
  );
end;

procedure TfrmMain.ImportUserDataExecute(Sender: TObject);
var
  FileName: string;
  Data: TUserData;
  SavedCursor: TCursor;
begin
  if not GetFileName(fnOpenUserData, FileName) then
    Exit;


  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Data := TUserData.Create;
    try
      if ExtractFileExt(FileName) = '.mhlud' then
        LoadOldUserData(FileName, Data)
      else
        Data.Load(FileName);
      OnImportUserDataHandler(Data);
    finally
      Data.Free;
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;



// Load user data from an in-memory instance of TUserData
procedure TfrmMain.OnImportUserDataHandler(const UserDataSource: TUserData);
var
  SavedCursor: TCursor;
begin
  Assert(Assigned(FCollection));
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FCollection.ImportUserData(
      UserDataSource,
      procedure(const BookKey: TBookKey; extra: TBookExtra)
      begin
        //
        // На всех страницах (кроме "Группы") необходимо обновить список книг,
        // т к могли поменяться пользовательские данные
        //
        UpdateNodes(
          BookKey,
          procedure(BookData: PBookRecord)
          begin
            Assert(Assigned(BookData));
            if extra.Rating <> 0 then
              BookData^.Rate := extra.Rating;
            if extra.Progress <> 0 then
              BookData^.Progress := extra.Progress;
            if extra.Review <> '' then
              Include(BookData^.BookProps, bpHasReview);
          end
        );
      end
    );

    CreateGroupsMenu;

    //
    // Обновим список групп. Побочным эффектом будет перечитывание списка книг на странице "Группы"
    //
    FillGroupsList(tvGroups, FSystemData.GetGroupIterator, FLastGroupID);
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfrmMain.Export2INPXExecute(Sender: TObject);
var
  FileName: string;
begin
  Assert(Assigned(FCollection));
  if not GetFileName(fnSaveINPX, FileName) then
    Exit;

  unit_Export.Export2INPX(FCollection.CollectionID, FileName);
end;

procedure TfrmMain.cbLangSelectAChange(Sender: TObject);
var
  filterValue: TFilterValue;
begin
  FLangSelected := True;
  case (Sender as TComboBox).Tag of
    0:begin
        FilterValue := AuthorBookFilter;
        FillBooksTree(tvBooksA, cbLangSelectA, FCollection.GetBookIterator(bmByAuthor, False, @FilterValue), False, True, @FLastAuthorBookID);  // авторы
       end;


    1: begin
         FilterValue := SeriesBookFilter;
         FillBooksTree(tvBooksS, cbLangSelectS, FCollection.GetBookIterator(bmBySeries, False, @FilterValue), False, False, @FLastSeriesBookID); // серии
       end;
    2: begin
         FilterValue := GenreBookFilter;
         FillBooksTree(tvBooksG, cbLangSelectG, FCollection.GetBookIterator(bmByGenre, False, @FilterValue),   True,  True, @FLastGenreBookID);  // жанры
       end;
    4: FillBooksTree(tvBooksF, cbLangSelectF, FSystemData.GetBookIterator(FLastGroupID), True,  True, @FLastGroupBookID);  // избранное
  end;
end;

procedure TfrmMain.cbPresetNameSelect(Sender: TObject);
var
  preset: TSearchPreset;
  Value: string;
begin
  DoClearFilter(True);

  preset := FPresets.GetPreset(cbPresetName.Text);

  if preset.TryGetValue(SF_AUTHORS, Value) then edFFullName.Text := Value;
  if preset.TryGetValue(SF_TITLE, Value) then edFTitle.Text := Value;
  if preset.TryGetValue(SF_SERIES, Value) then edFSeries.Text := Value;
  if preset.TryGetValue(SF_GENRE_TITLE, Value) then edFGenre.Text := Value;
  if preset.TryGetValue(SF_GENRE_CODES, Value) then edFGenre.Hint := Value;
  if preset.TryGetValue(SF_ANNOTATION, Value) then edFAnnotation.Text := Value;

  if preset.TryGetValue(SF_FILE, Value) then edFFile.Text := Value;
  if preset.TryGetValue(SF_FOLDER, Value) then edFFolder.Text := Value;
  if preset.TryGetValue(SF_EXTENSION, Value) then edFExt.Text := Value;

  if preset.TryGetValue(SF_DOWNLOADED, Value) then
    cbDownloaded.ItemIndex := EnsureRange(StrToIntDef(Value, 0), 0, cbDownloaded.Items.Count - 1);
  if preset.TryGetValue(SF_KEYWORDS, Value) then edFKeyWords.Text := Value;
  if preset.TryGetValue(SF_DELETED, Value) then cbDeleted.Checked := StrToBoolDef(Value, False);

  if preset.TryGetValue(SF_DATE, Value) then
  begin
    cbDate.ItemIndex := EnsureRange(StrToIntDef(Value, -1), -1, cbDate.Items.Count - 1);
    if cbDate.ItemIndex = -1 then
     if preset.TryGetValue(SF_DATE_STR, Value) then cbDate.Text := Value;
  end;

  if preset.TryGetValue(SF_LIBRATE, Value) then
  begin
    cbLibRate.ItemIndex := EnsureRange(StrToIntDef(Value, -1), -1, cbLibRate.Items.Count - 1);
    if cbLibRate.ItemIndex = -1 then
     if preset.TryGetValue(SF_LIBRATE_STR, Value) then cbLibRate.Text := Value;
  end;

  if preset.TryGetValue(SF_LANG, Value) then
    cbLang.ItemIndex := EnsureRange(StrToIntDef(Value, -1), -1, cbLang.Items.Count - 1);
  if preset.TryGetValue(SF_READED, Value) then cbReaded.Checked := StrToBoolDef(Value, False);

end;

procedure TfrmMain.btnStartDownloadClick(Sender: TObject);
begin
  if tvDownloadList.GetFirst = nil then
    Exit;

  btnPauseDownload.Enabled := True;
  btnStartDownload.Enabled := False;

  // There is a memory leak caused by overwriting the variable without freeing the previous instance
  // Need to redesign the manager before resolving the leak
  FDMThread := TDownloadManagerThread.Create(False)
end;

procedure TfrmMain.btnPauseDownloadClick(Sender: TObject);
begin
  btnPauseDownload.Enabled := False;
  btnStartDownload.Enabled := True;
  if Assigned(FDMThread) then
    FDMThread.Stop;
end;

procedure TfrmMain.BtnSaveClick(Sender: TObject);
begin
  tvDownloadList.SaveToFile(Settings.SystemFileName[sfDownloadsStore]);
end;

procedure TfrmMain.btnDeleteDownloadClick(Sender: TObject);
var
  Data: PDownloadData;
  i: Integer;
  List: TSelectionList;
begin
  GetSelections(tvDownloadList, List);
  for i := 0 to tvDownloadList.SelectedCount - 1 do
  begin
    Data := tvDownloadList.GetNodeData(List[i]);
    if Data.State <> dsRun then
      tvDownloadList.DeleteNode(List[i]);
  end;
end;

procedure TfrmMain.DeleteSearchPreset(Sender: TObject);
var
  presetName: string;
begin
  presetName := cbPresetName.Items[cbPresetName.ItemIndex];
  FPresets.RemovePreset(presetName);
  FPresets.Save(Settings.SystemFileName[sfPresets]);

  cbPresetName.Items.Delete(cbPresetName.ItemIndex);
  cbPresetName.ItemIndex := -1;
  cbPresetName.Text := '';
end;

function TfrmMain.GetBookNode(const Tree: TBookTree; const BookKey: TBookKey): PVirtualNode;
var
  Data: PBookRecord;
  Node: PVirtualNode;
begin
  Assert(Assigned(Tree));

  Result := nil;

  Node := Tree.GetFirst;
  while Assigned(Node) do
  begin
    Data := Tree.GetNodeData(Node);
    Assert(Assigned(Data));
    if (Data^.nodeType = ntBookInfo) and (Data^.BookKey.IsSameAs(BookKey)) then
    begin
      Result := Node;
      Exit;
    end;
    Node := Tree.GetNext(Node);
  end;
end;

procedure TfrmMain.ProcessNodes(ProcessProc: TNodeProcessProc);
var
  Tree: TBookTree;
  FNode: PVirtualNode;
  Node: PVirtualNode;
begin
  GetActiveTree(Tree);
  Assert(Assigned(Tree));

  FNode := Tree.FocusedNode;

  Node := Tree.GetFirstChecked;
  while Assigned(Node) do
  begin
    if Node = FNode then
      FNode := nil;
    ProcessProc(Tree, Node);
    Node := Tree.GetNextChecked(Node);
  end;

  if Assigned(FNode) then
    ProcessProc(Tree, FNode);
end;

procedure TfrmMain.UpdateNodes(const BookKey: TBookKey; UpdateProc: TNodeUpdateProc);
type
  TTreeArray = array of TBookTree;
var
  BookTrees: TTreeArray;
  Tree: TBookTree;
  Node: PVirtualNode;
  Data: PBookRecord;
begin
  BookTrees := TTreeArray.Create(tvBooksA, tvBooksS, tvBooksG, tvBooksSR, tvBooksF {, tvDownloadList});
  for Tree in BookTrees do
  begin
    Node := GetBookNode(Tree, BookKey);
    if Assigned(Node) then
    begin
      Data := Tree.GetNodeData(Node);
      Assert(Assigned(Data));
      if Assigned(Data) then
      begin
        UpdateProc(Data);
        Tree.RepaintNode(Node);
      end;
    end;
  end;
end;

function TfrmMain.IsSelectedBookNode(Node: PVirtualNode; Data: PBookRecord): Boolean;
begin
  if Settings.SelectedIsChecked then
     Result :=
        Assigned(Node) and Assigned(Data) and
       (Data^.nodeType = ntBookInfo) and
       ((Node^.CheckState = csCheckedNormal) or (vsSelected in Node.States))
  else
    Result :=
      Assigned(Node) and Assigned(Data) and
     (Data^.nodeType = ntBookInfo) and ((Node^.CheckState = csCheckedNormal));
end;

procedure TfrmMain.OnGetBookHandler(var BookRecord: TBookRecord);
var
  Tree: TBookTree;
  Node: PVirtualNode;
  Data: PBookRecord;
  BookCollection: IBookCollection;
begin
  //
  // Locate the selected book record and pass it to the edit form
  //
  GetActiveTree(Tree);
  Node := Tree.GetFirstSelected;
  Data := Tree.GetNodeData(Node);

  Assert(Assigned(Data) and (Data^.nodeType = ntBookInfo));
  Assert(Assigned(FCollection));

  if (Data^.BookKey.DatabaseID <> FCollection.CollectionID) then
    BookCollection := FSystemData.GetCollection(Data^.BookKey.DatabaseID)
  else
    BookCollection := FCollection;

  BookCollection.GetBookRecord(Data^.BookKey, BookRecord, True);
end;

// Invoked when it's time to update the current book in DB
procedure TfrmMain.OnUpdateBookHandler;
var
  BookCollection: IBookCollection;
begin
  Assert(BookRecord.nodeType = ntBookInfo);

  Assert(Assigned(FCollection));
  if (BookRecord.BookKey.DatabaseID <> FCollection.CollectionID) then
    BookCollection := FSystemData.GetCollection(BookRecord.BookKey.DatabaseID)
  else
    BookCollection := FCollection;

  BookCollection.BeginBulkOperation;
  try
    BookCollection.UpdateBook(BookRecord);
    BookCollection.EndBulkOperation(True);
  except
    BookCollection.EndBulkOperation(False);
  end;

end;

// A raw file just became a zip archive (FBD + raw)
// Change the book's file name in both the database and the trees
procedure TfrmMain.OnChangeBook2ZipHandler;
var
  NewFileName: string;
  BookCollection: IBookCollection;
begin
  Assert(Assigned(FCollection));
  if (BookRecord.BookKey.DatabaseID <> FCollection.CollectionID) then
    BookCollection := FSystemData.GetCollection(BookRecord.BookKey.DatabaseID)
  else
    BookCollection := FCollection;

  Assert(BookRecord.nodeType = ntBookInfo);

  NewFileName := BookRecord.FileName + ZIP_EXTENSION;
  BookCollection.SetFileName(BookRecord.BookKey, NewFileName);
  UpdateNodes(
    BookRecord.BookKey,
    procedure(BookData: PBookRecord)
    begin
      Assert(Assigned(BookData));
      BookData^.FileName := NewFileName;
    end
  );
end;

function TfrmMain.AuthorBookFilter: TFilterValue;
begin
  Result.ValueInt := FLastAuthorID;
end;

function TfrmMain.SeriesBookFilter: TFilterValue;
begin
  Result.ValueInt := FLastSeriesID;
end;

function TfrmMain.GenreBookFilter: TFilterValue;
begin
  Assert(Assigned(FCollection));
  if isFB2Collection(FCollection.CollectionCode) or (not Settings.ShowSubGenreBooks) then
    Result.ValueString := FLastGenreCode
  else
    Result.ValueString := FLastGenreCode + IfThen(FLastGenreIsContainer, '.', '');
end;

end.
