(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             05.07.2010
  * Description
  *
  * $Id: BookTreeView.pas 1185 2015-04-10 08:17:34Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit BookTreeView;

interface

uses
  Classes,
  SysUtils,
  Controls,
  VirtualTrees,
  VirtualTrees.Types,
  VirtualTrees.Colors,
  VirtualTrees.DragImage,
  VirtualTrees.Header,
  VirtualTrees.Classes;

const
  DefaultSelectionOptions = [
    toFullRowSelect,
    toRightClickSelect,
    toMultiSelect
    //toSimpleDrawSelection
  ];

  DefaultMiscOptions = [
    toCheckSupport,
    toFullRepaintOnResize,
    toInitOnSave,
    toToggleOnDblClick,
    toWheelPanning,
    toEditOnClick
  ];

  DefaultPaintOptions = [
    toPopupMode,
    toShowButtons,
    toShowDropmark,
    toShowHorzGridLines,
    toShowRoot,
    toShowTreeLines,
    //toShowVertGridLines,
    toThemeAware,
    toUseBlendedImages
  ];

type
  TBookTreeOptions = class(TCustomStringTreeOptions)
  public
    constructor Create(AOwner: TCustomControl); override;

  published
    //property AnimationOptions;
    //property AutoOptions;
    //property ExportMode;
    property MiscOptions default DefaultMiscOptions;
    property PaintOptions default DefaultPaintOptions;
    property SelectionOptions default DefaultSelectionOptions;
  end;

  TBookTree = class(TCustomVirtualStringTree)
  private
    function GetOptions: TBookTreeOptions;
    procedure SetOptions(const Value: TBookTreeOptions);
  protected
    function GetOptionsClass: TTreeOptionsClass; override;
  public
    property Canvas;
  published
    property AccessibleName;
    property Action;
    property Align;
    property Alignment;
    property Anchors;
    //property AnimationDuration;
    //property AutoExpandDelay;
    //property AutoScrollDelay;
    //property AutoScrollInterval;
    //property Background;
    //property BackgroundOffsetX;
    //property BackgroundOffsetY;
    property BiDiMode;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderStyle;
    //property BottomSpace;
    //property ButtonFillMode;
    //property ButtonStyle;
    property BorderWidth;
    property ChangeDelay;
    //property CheckImageKind;
    //property ClipboardFormats;
    property Color;
    property Colors;
    property Constraints;
    property Ctl3D;
    //property CustomCheckImages;
    property DefaultNodeHeight;
    //property DefaultPasteMode;
    //property DefaultText;
    property DragCursor;
    property DragHeight;
    property DragKind;
    property DragImageKind;
    property DragMode;
    property DragOperations;
    property DragType;
    property DragWidth;
    //property DrawSelectionMode;
    //property EditDelay;
    property Enabled;
    property Font;
    property Header;
   // property HintAnimation;
    property HintMode;
    property HotCursor;
    property Images;
    property IncrementalSearch;
    property IncrementalSearchDirection;
    property IncrementalSearchStart;
    property IncrementalSearchTimeout;
    property Indent;
    property LineMode;
    property LineStyle;
    property Margin;
    //property NodeAlignment;
    property NodeDataSize;
    //property OperationCanceled;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    //property RootNodeCount;
    //property ScrollBarOptions;
    //property SelectionBlendFactor;
    //property SelectionCurveRadius;
    property ShowHint;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    //property TextMargin;
    property TreeOptions: TBookTreeOptions read GetOptions write SetOptions;
    property Visible;
    property WantTabs;
    //property OnAdvancedHeaderDraw;
    //property OnAfterAutoFitColumn;
    //property OnAfterAutoFitColumns;
    property OnAfterCellPaint;
    //property OnAfterColumnExport;
    //property OnAfterColumnWidthTracking;
    //property OnAfterGetMaxColumnWidth;
    //property OnAfterHeaderExport;
    //property OnAfterHeaderHeightTracking;
    //property OnAfterItemErase;
    //property OnAfterItemPaint;
    //property OnAfterNodeExport;
    //property OnAfterPaint;
    //property OnAfterTreeExport;
    //property OnBeforeAutoFitColumn;
    //property OnBeforeAutoFitColumns;
    property OnBeforeCellPaint;
    //property OnBeforeColumnExport;
    //property OnBeforeColumnWidthTracking;
    //property OnBeforeGetMaxColumnWidth;
    //property OnBeforeHeaderExport;
    //property OnBeforeHeaderHeightTracking;
    //property OnBeforeItemErase;
    //property OnBeforeItemPaint;
    //property OnBeforeNodeExport;
    //property OnBeforePaint;
    //property OnBeforeTreeExport;
    //property OnCanSplitterResizeColumn;
    property OnChange;
    //property OnChecked;
    //property OnChecking;
    property OnClick;
    //property OnCollapsed;
    //property OnCollapsing;
    //property OnColumnClick;
    //property OnColumnDblClick;
    //property OnColumnExport;
    //property OnColumnResize;
    //property OnColumnWidthDblClickResize;
    //property OnColumnWidthTracking;
    property OnCompareNodes;
    {$ifdef COMPILER_5_UP}
      property OnContextPopup;
    {$endif COMPILER_5_UP}
    //property OnCreateDataObject;
    //property OnCreateDragManager;
    //property OnCreateEditor;
    property OnDblClick;
    property OnDragAllowed;
    property OnDragOver;
    property OnDragDrop;
    //property OnDrawText;
    //property OnEditCancelled;
    //property OnEdited;
    //property OnEditing;
    //property OnEndDock;
    property OnEndDrag;
    //property OnEnter;
    //property OnExit;
    //property OnExpanded;
    //property OnExpanding;
    //property OnFocusChanged;
    //property OnFocusChanging;
    property OnFreeNode;
    property OnGetCellIsEmpty;
    //property OnGetCursor;
    //property OnGetHeaderCursor;
    property OnGetText;
    property OnPaintText;
    property OnGetHelpContext;
    //property OnGetImageIndex;
    //property OnGetImageIndexEx;
    //property OnGetImageText;
    property OnGetHint;
    //property OnGetLineStyle;
    property OnGetNodeDataSize;
    property OnGetPopupMenu;
    //property OnGetUserClipboardFormats;
    //property OnHeaderCheckBoxClick;
    property OnHeaderClick;
    //property OnHeaderDblClick;
    //property OnHeaderDragged;
    //property OnHeaderDraggedOut;
    //property OnHeaderDragging;
    //property OnHeaderDraw;
    //property OnHeaderDrawQueryElements;
    //property OnHeaderHeightDblClickResize;
    //property OnHeaderHeightTracking;
    //property OnHeaderImageClick;
    //property OnHeaderMouseDown;
    //property OnHeaderMouseMove;
    //property OnHeaderMouseUp;
    //property OnHotChange;
    //property OnIncrementalSearch;
    //property OnInitChildren;
    property OnInitNode;
    //property OnKeyAction;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLoadNode;
    //property OnMeasureItem;
    //property OnMeasureTextWidth;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    //property OnNewText;
    //property OnNodeCopied;
    //property OnNodeCopying;
    //property OnNodeExport;
    //property OnNodeHeightDblClickResize;
    //property OnNodeHeightTracking;
    //property OnNodeMoved;
    //property OnNodeMoving;
    //property OnPaintBackground;
    //property OnRenderOLEData;
    //property OnResetNode;
    //property OnResize;
    property OnSaveNode;
    //property OnScroll;
    //property OnShortenString;
    //property OnShowScrollbar;
    property OnStartDock;
    property OnStartDrag;
    //property OnStateChange;
    //property OnStructureChange;
    //property OnUpdating;
  end;

implementation

{ TBookTreeOptions }

constructor TBookTreeOptions.Create(AOwner: TCustomControl);
begin
  inherited;
  AutoOptions := AutoOptions + [toAutoSpanColumns];
  MiscOptions := DefaultMiscOptions;
  PaintOptions := DefaultPaintOptions;
  SelectionOptions := DefaultSelectionOptions;
end;

type
  TCustomVirtualStringTreeHack = class(TCustomVirtualStringTree);

function TBookTree.GetOptions: TBookTreeOptions;
begin
  Result := TCustomVirtualStringTreeHack(Self).TreeOptions as TBookTreeOptions;
end;
procedure TBookTree.SetOptions(const Value: TBookTreeOptions);
begin
  TCustomVirtualStringTreeHack(Self).TreeOptions := Value;
end;
function TBookTree.GetOptionsClass: TTreeOptionsClass;
begin
  Result := TBookTreeOptions;
end;

end.



