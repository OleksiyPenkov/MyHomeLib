(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
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
  Winapi.Windows, System.Types, SysUtils, Classes, Controls, ExtCtrls, Graphics;

type
  TMHLSimplePanel = class(TCustomPanel)
  private
    FFramedControl: TControl;
    procedure SetFramedControl(const Value: TControl);
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

procedure TMHLSimplePanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
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
