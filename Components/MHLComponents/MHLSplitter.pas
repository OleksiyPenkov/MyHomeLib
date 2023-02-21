(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Created             16.04.2010
  * Description         Сплиттер с улучшенной поддержкой тем и устранением некоторых проблем
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  *
  * $Id: MHLSplitter.pas 1166 2014-05-22 03:09:17Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit MHLSplitter;

interface

uses
  SysUtils, Classes, Types, Windows, Controls, Graphics, ExtCtrls;

type
  TMHLSplitter = class(TGraphicControl)
  private
    FActiveControl: TWinControl;
    FBrush: TBrush;
    FControl: TControl;
    FDownPos: TPoint;
    FLineDC: HDC;
    FLineVisible: Boolean;
    FMinSize: NaturalNumber;
    FMaxSize: Integer;
    FNewSize: Integer;
    FOldKeyDown: TKeyEvent;
    FOldSize: Integer;
    FPrevBrush: HBrush;
    FResizeStyle: TResizeStyle;
    FSplit: Integer;
    FResizeControl: TControl;
    FTransparentSet: Boolean;

    FOnCanResize: TCanResizeEvent;
    FOnMoved: TNotifyEvent;

    procedure AllocateLineDC;
    procedure CalcSplitSize(X, Y: Integer; var NewSize, Split: Integer);
    procedure DrawLine;
    function FindControl: TControl;
    procedure FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ReleaseLineDC;
    procedure UpdateControlSize;
    procedure UpdateSize(X, Y: Integer);
    procedure SetResizeControl(const Value: TControl);
    function GetTransparent: Boolean;
    procedure SetTransparent(const Value: Boolean);

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function CanResize(var NewSize: Integer): Boolean; reintroduce; virtual;
    function DoCanResize(var NewSize: Integer): Boolean; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure RequestAlign; override;
    procedure StopSizing; dynamic;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas;

  published
    property Align default alLeft;
    property Color;
    property Cursor default crHSplit;
    property Constraints;
    property MinSize: NaturalNumber read FMinSize write FMinSize default 30;
    property ParentColor;
    property ResizeControl: TControl read FResizeControl write SetResizeControl;
    property ResizeStyle: TResizeStyle read FResizeStyle write FResizeStyle default rsPattern;
    property Transparent: Boolean read GetTransparent write SetTransparent stored FTransparentSet;
    property Visible;
    property Width default 3;
    property OnCanResize: TCanResizeEvent read FOnCanResize write FOnCanResize;
    property OnMoved: TNotifyEvent read FOnMoved write FOnMoved;
  end;

implementation

uses
  Forms, Themes;

type
  TWinControlAccess = class(TWinControl);

constructor TMHLSplitter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csGestures];
  Height := 100;
  Align := alLeft;
  Width := 3;
  Cursor := crHSplit;
  FMinSize := 30;
  FResizeStyle := rsPattern;
  FOldSize := -1;
  if StyleServices.ThemesEnabled then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];
end;

destructor TMHLSplitter.Destroy;
begin
  FBrush.Free;
  inherited Destroy;
end;

procedure TMHLSplitter.AllocateLineDC;
begin
  FLineDC := GetDCEx(Parent.Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS or DCX_LOCKWINDOWUPDATE);
  if ResizeStyle = rsPattern then
  begin
    if FBrush = nil then
    begin
      FBrush := TBrush.Create;
      FBrush.Bitmap := AllocPatternBitmap(clBlack, clWhite);
    end;
    FPrevBrush := SelectObject(FLineDC, FBrush.Handle);
  end;
end;

procedure TMHLSplitter.DrawLine;
var
  P: TPoint;
begin
  FLineVisible := not FLineVisible;
  P := Point(Left, Top);
  if Align in [alLeft, alRight] then
    P.X := Left + FSplit
  else
    P.Y := Top + FSplit;

  with P do
    PatBlt(FLineDC, X, Y, Width, Height, PATINVERT);
end;

procedure TMHLSplitter.ReleaseLineDC;
begin
  if FPrevBrush <> 0 then
    SelectObject(FLineDC, FPrevBrush);
  ReleaseDC(Parent.Handle, FLineDC);
  if FBrush <> nil then
  begin
    FBrush.Free;
    FBrush := nil;
  end;
end;

function TMHLSplitter.FindControl: TControl;
var
  P: TPoint;
  I: Integer;
  R: TRect;
begin
  if Assigned(FResizeControl) then
  begin
    Result := FResizeControl;
    Exit;
  end;

  Result := nil;
  P := Point(Left, Top);
  case Align of
    alLeft:
      if not AlignWithMargins then
        Dec(P.X)
      else
        Dec(P.X, Margins.Left + 1);
    alRight:
      if not AlignWithMargins then
        Inc(P.X, Width)
      else
        Inc(P.X, Width + Margins.Right + 1);
    alTop:
      if not AlignWithMargins then
        Dec(P.Y)
      else
        Dec(P.Y, Margins.Top + 1);
    alBottom:
      if not AlignWithMargins then
        Inc(P.Y, Height)
      else
        Inc(P.Y, Height + Margins.Bottom + 1);
  else
    Exit;
  end;
  for I := 0 to Parent.ControlCount - 1 do
  begin
    Result := Parent.Controls[I];
    if Result.Visible and Result.Enabled then
    begin
      R := Result.BoundsRect;
      if Result.AlignWithMargins then
      begin
        Inc(R.Right, Result.Margins.Right);
        Dec(R.Left, Result.Margins.Left);
        Inc(R.Bottom, Result.Margins.Bottom);
        Dec(R.Top, Result.Margins.Top);
      end;
      if (R.Right - R.Left) = 0 then
        if Align in [alTop, alLeft] then
          Dec(R.Left)
        else
          Inc(R.Right);
      if (R.Bottom - R.Top) = 0 then
        if Align in [alTop, alLeft] then
          Dec(R.Top)
        else
          Inc(R.Bottom);
      if PtInRect(R, P) then Exit;
    end;
  end;
  Result := nil;
end;

procedure TMHLSplitter.RequestAlign;
begin
  inherited RequestAlign;
  if (Cursor <> crVSplit) and (Cursor <> crHSplit) then
    Exit;
  if Align in [alBottom, alTop] then
    Cursor := crVSplit
  else
    Cursor := crHSplit;
end;

procedure DrawXPGrip(ACanvas: TCanvas; ARect: TRect; LoC, HiC: TColor);
var
  I, J: Integer;
  XCellCount, YCellCount: Integer;
  R: TRect;
  C: TColor;
begin
  //  4 x 4 cells (Grey, White, Null)
  //  GG--
  //  GGW-
  //  -WW-
  //  ----

  C := ACanvas.Brush.Color;

  XCellCount := (ARect.Right - ARect.Left) div 4;
  YCellCount := (ARect.Bottom - ARect.Top) div 4;
  if XCellCount = 0 then
    XCellCount := 1;
  if YCellCount = 0 then
    YCellCount := 1;

  for J := 0 to YCellCount - 1 do
    for I := 0 to XCellCount - 1 do
    begin
      R.Left := ARect.Left + (I * 4) + 1;
      R.Right := R.Left + 2;
      R.Top := ARect.Top + (J * 4) + 1;
      R.Bottom := R.Top + 2;

      ACanvas.Brush.Color := HiC;
      ACanvas.FillRect(R);
      OffsetRect(R, -1, -1);
      ACanvas.Brush.Color := LoC;
      ACanvas.FillRect(R);
    end;

  ACanvas.Brush.Color := C;
end;

procedure TMHLSplitter.Paint;
const
  XorColor = $00FFD8CE;
  DEF_GRIP_SIZE = 50;
var
  R: TRect;
begin
  if not Transparent then
  begin
    R := ClientRect;
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ClientRect);

    if csDesigning in ComponentState then
      { Draw outline }
      with Canvas do
      begin
        Pen.Style := psDot;
        Pen.Mode := pmXor;
        Pen.Color := XorColor;
        Brush.Style := bsClear;
        Rectangle(0, 0, ClientWidth, ClientHeight);
      end;
  end;

  // Paint grip
  if Align in [alLeft, alRight] then
  begin
    R := Bounds(0, (Height - DEF_GRIP_SIZE) div 2, Width, DEF_GRIP_SIZE);
    InflateRect(R, -1, -10)
  end
  else
  begin
    R := Bounds((Width - DEF_GRIP_SIZE) div 2, 0, DEF_GRIP_SIZE, Height);
    InflateRect(R, -10, -1);
  end;

  DrawXPGrip(Canvas, R, clBtnShadow, clWindow);
end;

function TMHLSplitter.DoCanResize(var NewSize: Integer): Boolean;
begin
  Result := CanResize(NewSize);
end;

function TMHLSplitter.CanResize(var NewSize: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnCanResize) then
    FOnCanResize(Self, NewSize, Result);
end;

procedure TMHLSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  I: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    FControl := FindControl;
    FDownPos := Point(X, Y);
    if Assigned(FControl) then
    begin
      if Align in [alLeft, alRight] then
      begin
        FMaxSize := Parent.ClientWidth - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Visible and (Align in [alLeft, alRight]) then
              Dec(FMaxSize, Width);
        Inc(FMaxSize, FControl.Width);
      end
      else
      begin
        FMaxSize := Parent.ClientHeight - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Align in [alTop, alBottom] then
              Dec(FMaxSize, Height);
        Inc(FMaxSize, FControl.Height);
      end;
      UpdateSize(X, Y);
      AllocateLineDC;
      with ValidParentForm(Self) do
        if ActiveControl <> nil then
        begin
          FActiveControl := ActiveControl;
          FOldKeyDown := TWinControlAccess(FActiveControl).OnKeyDown;
          TWinControlAccess(FActiveControl).OnKeyDown := FocusKeyDown;
        end;
      if ResizeStyle in [rsLine, rsPattern] then DrawLine;
    end;
  end;
end;

procedure TMHLSplitter.UpdateControlSize;
begin
  if FNewSize <> FOldSize then
  begin
    case Align of
      alLeft: FControl.Width := FNewSize;
      alTop: FControl.Height := FNewSize;
      alRight:
        begin
          Parent.DisableAlign;
          try
            FControl.Left := FControl.Left + (FControl.Width - FNewSize);
            FControl.Width := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
      alBottom:
        begin
          Parent.DisableAlign;
          try
            FControl.Top := FControl.Top + (FControl.Height - FNewSize);
            FControl.Height := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
    end;
    Update;
    if Assigned(FOnMoved) then
      FOnMoved(Self);
    FOldSize := FNewSize;
  end;
end;

procedure TMHLSplitter.CalcSplitSize(X, Y: Integer; var NewSize, Split: Integer);
var
  S: Integer;
begin
  if Align in [alLeft, alRight] then
    Split := X - FDownPos.X
  else
    Split := Y - FDownPos.Y;
  S := 0;
  case Align of
    alLeft: S := FControl.Width + Split;
    alRight: S := FControl.Width - Split;
    alTop: S := FControl.Height + Split;
    alBottom: S := FControl.Height - Split;
  end;
  NewSize := S;
  if S < FMinSize then
    NewSize := FMinSize
  else if S > FMaxSize then
    NewSize := FMaxSize;
  if S <> NewSize then
  begin
    if Align in [alRight, alBottom] then
      S := S - NewSize
    else
      S := NewSize - S;
    Inc(Split, S);
  end;
end;

procedure TMHLSplitter.UpdateSize(X, Y: Integer);
begin
  CalcSplitSize(X, Y, FNewSize, FSplit);
end;

procedure TMHLSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewSize, Split: Integer;
begin
  inherited;
  if (ssLeft in Shift) and Assigned(FControl) then
  begin
    CalcSplitSize(X, Y, NewSize, Split);
    if DoCanResize(NewSize) then
    begin
      if ResizeStyle in [rsLine, rsPattern] then
        DrawLine;
      FNewSize := NewSize;
      FSplit := Split;
      if ResizeStyle = rsUpdate then
        UpdateControlSize;
      if ResizeStyle in [rsLine, rsPattern] then
        DrawLine;
    end;
  end;
end;

procedure TMHLSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Assigned(FControl) then
  begin
    if ResizeStyle in [rsLine, rsPattern] then
      DrawLine;
    UpdateControlSize;
    StopSizing;
  end;
end;

procedure TMHLSplitter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FResizeControl) then
    FResizeControl := nil;
end;

procedure TMHLSplitter.FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    StopSizing
  else if Assigned(FOldKeyDown) then
    FOldKeyDown(Sender, Key, Shift);
end;

function TMHLSplitter.GetTransparent: Boolean;
begin
  Result := not (csOpaque in ControlStyle);
end;

procedure TMHLSplitter.SetTransparent(const Value: Boolean);
begin
  if Transparent <> Value then
  begin
    if Value then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
  FTransparentSet := True;
end;

procedure TMHLSplitter.SetResizeControl(const Value: TControl);
begin
  FResizeControl := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TMHLSplitter.StopSizing;
begin
  if Assigned(FControl) then
  begin
    if FLineVisible then
      DrawLine;
    FControl := nil;
    ReleaseLineDC;
    if Assigned(FActiveControl) then
    begin
      TWinControlAccess(FActiveControl).OnKeyDown := FOldKeyDown;
      FActiveControl := nil;
    end;
  end;
  if Assigned(FOnMoved) then
    FOnMoved(Self);
end;


end.
