(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
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
  Winapi.Windows,
  Classes,
  SysUtils,
  Controls,
  Graphics,
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
    FHeaderColor: TColor;

    function GetOptions: TBookTreeOptions;
    procedure SetOptions(const Value: TBookTreeOptions);
    procedure SetHeaderColor(const Value: TColor);

    function BaseHeaderColor: TColor;
    procedure HeaderDrawQueryElements(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
      var Elements: THeaderPaintElements);
    procedure AdvancedHeaderDraw(Sender: TVTHeader; var PaintInfo: THeaderPaintInfo;
      const Elements: THeaderPaintElements);
  protected
    function GetOptionsClass: TTreeOptionsClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;

    //
    // Background of the column header. clNone (the default) derives it from the
    // tree's own Color, so it stays a shade off the rows whatever background the
    // user picks in the settings.
    //
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor default clNone;
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

constructor TBookTree.Create(AOwner: TComponent);
begin
  inherited;
  FHeaderColor := clNone;
  //
  // VT only takes the advanced owner draw path when hoOwnerDraw is set and both
  // events are assigned. We claim the header background and add an overlay; the
  // captions, sort glyphs and drop marks stay VT's job.
  //
  OnHeaderDrawQueryElements := HeaderDrawQueryElements;
  OnAdvancedHeaderDraw := AdvancedHeaderDraw;
end;

procedure TBookTree.SetHeaderColor(const Value: TColor);
begin
  if FHeaderColor <> Value then
  begin
    FHeaderColor := Value;
    Header.Invalidate(nil);
  end;
end;

// Shifts a colour by APercent - negative darkens, positive lightens.
function ShadeColor(AColor: TColor; APercent: Integer): TColor;

  function Shift(AValue: Integer): Integer;
  begin
    Result := AValue + MulDiv(AValue, APercent, 100);
    if Result < 0 then
      Result := 0
    else if Result > 255 then
      Result := 255;
  end;

var
  Value: Longint;
begin
  Value := ColorToRGB(AColor);
  Result := RGB(Shift(GetRValue(Value)), Shift(GetGValue(Value)), Shift(GetBValue(Value)));
end;

function TBookTree.BaseHeaderColor: TColor;
begin
  if FHeaderColor <> clNone then
    Result := FHeaderColor
  else
    Result := ShadeColor(Color, -8);
end;

procedure TBookTree.HeaderDrawQueryElements(Sender: TVTHeader;
  var PaintInfo: THeaderPaintInfo; var Elements: THeaderPaintElements);
begin
  Elements := Elements + [hpeBackground, hpeOverlay];
end;

procedure TBookTree.AdvancedHeaderDraw(Sender: TVTHeader;
  var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
var
  Y: Integer;
  Base, Fill: TColor;
begin
  Base := BaseHeaderColor;

  if hpeBackground in Elements then
  begin
    // Called once for the whole header and again per column, so the pressed and
    // hot shades land on the column being drawn.
    if PaintInfo.IsDownIndex then
      Fill := ShadeColor(Base, -12)
    else if PaintInfo.IsHoverIndex then
      Fill := ShadeColor(Base, -6)
    else
      Fill := Base;

    PaintInfo.TargetCanvas.Brush.Color := Fill;
    PaintInfo.TargetCanvas.Brush.Style := bsSolid;
    PaintInfo.TargetCanvas.FillRect(PaintInfo.PaintRectangle);

    // A flat fill has no column separators of its own.
    if Assigned(PaintInfo.Column) then
    begin
      PaintInfo.TargetCanvas.Pen.Color := ShadeColor(Base, -18);
      PaintInfo.TargetCanvas.Pen.Style := psSolid;
      PaintInfo.TargetCanvas.Pen.Width := 1;
      PaintInfo.TargetCanvas.MoveTo(PaintInfo.PaintRectangle.Right - 1, PaintInfo.PaintRectangle.Top + 2);
      PaintInfo.TargetCanvas.LineTo(PaintInfo.PaintRectangle.Right - 1, PaintInfo.PaintRectangle.Bottom - 2);
    end;
  end;

  if not (hpeOverlay in Elements) then
    Exit;

  // A themed header has no bottom edge of its own, so the rows run straight
  // into it. Draw the missing divider in the same colour as the panel frame.
  //
  // VT clips painting to the current cell, which would end the divider at the
  // last column and leave the empty stretch beside it bare. This callback is
  // the last step of the cell paint and VT brackets it with SaveDC/RestoreDC,
  // so the clip can be dropped here to span the full header width.
  SelectClipRgn(PaintInfo.TargetCanvas.Handle, 0);

  Y := PaintInfo.PaintRectangle.Bottom - 1;
  PaintInfo.TargetCanvas.Pen.Color := clBtnShadow;
  PaintInfo.TargetCanvas.Pen.Style := psSolid;
  PaintInfo.TargetCanvas.Pen.Width := 1;
  PaintInfo.TargetCanvas.MoveTo(0, Y);
  PaintInfo.TargetCanvas.LineTo(ClientWidth, Y);
end;

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



