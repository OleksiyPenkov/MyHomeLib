(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov     nrymanov@gmail.com
  * Created
  * Description         ������� ������ ��� ������� � ���������. ������������� ��� ��������� ����� :)
  *
  * $Id: MHLSimplePanel.pas 785 2010-09-17 09:06:06Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit MHLSimplePanel;

interface

uses
  Winapi.Windows, System.Types, SysUtils, Classes, Controls, ExtCtrls, Graphics,
  MHLSplitter;

type
  TMHLSimplePanel = class(TCustomPanel)
  private
    FFramedControl: TControl;
    FEnforcingOrder: Boolean;

    procedure SetFramedControl(const Value: TControl);
    procedure EnforceSplitterOrder;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property DockManager;

    //
    // Draws a flat rounded frame around the given child, in the gap its
    // Margins leave free. Lets a borderless child (a tree, say) get the same
    // frame TRzPanel paints with BorderOuter = fsFlatRounded, without wrapping
    // it in another window.
    //
    property FramedControl: TControl read FFramedControl write SetFramedControl;

  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter default bvNone;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    //property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    //property ShowCaption;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property VerticalAlignment;
    property Visible;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

implementation

procedure Register;
begin
  RegisterComponents('mHLComponents', [TMHLSimplePanel]);
end;

{ TMHLSimplePanel }

constructor TMHLSimplePanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csSetCaption];
  BevelOuter := bvNone;
end;

procedure TMHLSimplePanel.SetFramedControl(const Value: TControl);
begin
  if FFramedControl <> Value then
  begin
    FFramedControl := Value;
    if Value <> nil then
      Value.FreeNotification(Self);
    Invalidate;
  end;
end;

procedure TMHLSimplePanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFramedControl) then
    FFramedControl := nil;
end;

//
// Keeps every splitter on the correct side of the control it resizes.
//
// The VCL orders same-aligned siblings by their trailing edge (for alBottom:
// Top + Height, bottom-most first) and places them in that order. Nothing keeps
// a splitter's edge on the right side of its ResizeControl, so any operation
// that moves their bounds out of step - a drag, which sets Top and Height with
// alignment disabled, or a height assignment from an OnResize handler - can
// swap the two. The state is self-perpetuating: once the splitter sorts last it
// is parked at the far edge of the panel, below the control it is supposed to
// resize, and stays there. Re-asserting the order here means every realign
// starts from a sane state instead of the layout depending on the order the
// bounds happened to change in.
//
procedure TMHLSimplePanel.EnforceSplitterOrder;
var
  I: Integer;
  Splitter: TMHLSplitter;
  Target: TControl;
begin
  for I := 0 to ControlCount - 1 do
  begin
    if not (Controls[I] is TMHLSplitter) then
      Continue;

    Splitter := TMHLSplitter(Controls[I]);
    Target := Splitter.ResizeControl;

    if (Target = nil) or (Target.Parent <> Self) or not Target.Visible or
       not Splitter.Visible or (Target.Align <> Splitter.Align) then
      Continue;

    // Only the ordering matters - the align pass right after this computes the
    // exact position, so it is enough to put the splitter clear of the target.
    case Splitter.Align of
      alBottom:
        if Splitter.Margins.ControlTop + Splitter.Margins.ControlHeight >=
           Target.Margins.ControlTop + Target.Margins.ControlHeight then
          Splitter.Top := Target.Margins.ControlTop - Splitter.Margins.ControlHeight +
            (Splitter.Top - Splitter.Margins.ControlTop);

      alTop:
        if Splitter.Margins.ControlTop <= Target.Margins.ControlTop then
          Splitter.Top := Target.Margins.ControlTop + Target.Margins.ControlHeight +
            (Splitter.Top - Splitter.Margins.ControlTop);

      alRight:
        if Splitter.Margins.ControlLeft + Splitter.Margins.ControlWidth >=
           Target.Margins.ControlLeft + Target.Margins.ControlWidth then
          Splitter.Left := Target.Margins.ControlLeft - Splitter.Margins.ControlWidth +
            (Splitter.Left - Splitter.Margins.ControlLeft);

      alLeft:
        if Splitter.Margins.ControlLeft <= Target.Margins.ControlLeft then
          Splitter.Left := Target.Margins.ControlLeft + Target.Margins.ControlWidth +
            (Splitter.Left - Splitter.Margins.ControlLeft);
    end;
  end;
end;

procedure TMHLSimplePanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  if not FEnforcingOrder then
  begin
    FEnforcingOrder := True;
    try
      EnforceSplitterOrder;
    finally
      FEnforcingOrder := False;
    end;
  end;

  inherited;

  // The child moves whenever the panel is realigned - a splitter drag resizes
  // it without resizing the panel - so the old frame has to be repainted.
  if Assigned(FFramedControl) then
    Invalidate;
end;

procedure TMHLSimplePanel.Paint;
const
  FrameRadius = 6;
var
  R: TRect;
begin
  inherited;

  if not Assigned(FFramedControl) or not FFramedControl.Visible then
    Exit;

  R := FFramedControl.BoundsRect;
  InflateRect(R, 1, 1);

  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := clBtnShadow;
  Canvas.Pen.Style := psSolid;
  Canvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, FrameRadius, FrameRadius);
end;

end.
