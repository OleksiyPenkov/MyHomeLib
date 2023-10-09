  (* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             20.08.2008
  * Description
  *
  * $Id: unit_StaticTip.pas 1181 2015-04-01 02:06:36Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

{ TODO -oNickR : добавить поддержку тени }

unit unit_StaticTip;

interface

uses
  SysUtils,
  Classes,
  Controls,
  StdCtrls,
  Graphics,
  WinAPi.Windows,
  Forms,
  ImgList,
  Themes,
  WinAPi.UxTheme,
  WinAPi.DwmApi,
  System.UITypes,
  System.Types;

type
  TMHLStaticTip = class(TCustomLabel)
  private
    FArcSize: Integer;
    FTextMargin: Integer;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FImageIndex: TImageIndex;

    procedure SetArcSize(const Value: Integer);
    procedure SetTextMargin(const Value: Integer);
    procedure SetImages(const Value: TCustomImageList);

    procedure ImageListChange(Sender: TObject);
    procedure SetImageIndex(const Value: TImageIndex);

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property ArcSize: Integer read FArcSize write SetArcSize default 10;
    property TextMargin: Integer read FTextMargin write SetTextMargin default 10;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;

    property Align;
    property Caption;
  end;

implementation

{ TMHLStaticTip }

constructor TMHLStaticTip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Color := clInfoBk;
  Transparent := False;
  Layout := tlCenter;
  WordWrap := True;
  AutoSize := False;

  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;

  FImageIndex := -1;

  FArcSize := 10;
  FTextMargin := 10;
end;

destructor TMHLStaticTip.Destroy;
begin
  FreeAndNil(FImageChangeLink);
  inherited Destroy;
end;

procedure TMHLStaticTip.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FImages) then
    Images := nil;
end;

procedure FillGlassRect(Canvas: TCanvas; Rect: TRect);
var
  MemDC: HDC;
  PaintBuffer: HPAINTBUFFER;
begin
  PaintBuffer := BeginBufferedPaint(Canvas.Handle, Rect, BPBF_TOPDOWNDIB, nil, MemDC);
  try
    //
    // TODO -oNickR -cподдержка Vista : заменить на RoundRect
    //
    FillRect(MemDC, Rect, Canvas.Brush.Handle);
    BufferedPaintMakeOpaque(PaintBuffer, @Rect);
  finally
    EndBufferedPaint(PaintBuffer, True);
  end;
end;

procedure TMHLStaticTip.Paint;
var
  Rect, CalcRect, CaptionRect: TRect;
  DrawStyle: Longint;
  LForm: TCustomForm;
  LGlassEnabled: Boolean;
  ImageWidth, ImageHeight: Integer;
  ImageTop, ImageLeft: Integer;
begin
  LGlassEnabled := StyleServices.Enabled and DwmCompositionEnabled and not (csDesigning in ComponentState);

  if LGlassEnabled then
  begin
    LForm := GetParentForm(Self);
    LGlassEnabled := (LForm <> nil) and LForm.GlassFrame.FrameExtended and LForm.GlassFrame.IntersectsControl(Self);
  end;

  Rect := ClientRect;

  Canvas.Brush.Color := Self.Color;
  Canvas.Brush.Style := bsSolid;
  if LGlassEnabled then
    FillGlassRect(Canvas, Rect)
  else
    Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, FArcSize, FArcSize);

  if Assigned(Images) and (FImageIndex >= 0) then
  begin
    ImageWidth := FImages.Width;
    ImageHeight := FImages.Height;

    ImageLeft := Rect.Left + FTextMargin;
    ImageTop := Rect.Top + ((Height - ImageHeight) div 2);

    Inc(Rect.Left, FTextMargin);
    Inc(Rect.Left, ImageWidth);

    Images.Draw(Canvas, ImageLeft, ImageTop, FImageIndex);
  end;

  Canvas.Brush.Style := bsClear;
  { DoDrawText takes care of BiDi alignments }
  DrawStyle := DT_EXPANDTABS or DT_WORDBREAK or DT_LEFT;

  InflateRect(Rect, -FTextMargin, -FTextMargin);

  CaptionRect := Rect;

  CalcRect := Rect;
  DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
  Inc(Rect.Top, ((Rect.Bottom - Rect.Top) - (CalcRect.Bottom - CalcRect.Top)) div 2);

  IntersectRect(CaptionRect, CaptionRect, Rect);
  DoDrawText(CaptionRect, DrawStyle);
end;

procedure TMHLStaticTip.SetArcSize(const Value: Integer);
begin
  if FArcSize <> Value then
  begin
    FArcSize := Value;
    Invalidate;
  end;
end;

procedure TMHLStaticTip.SetTextMargin(const Value: Integer);
begin
  if FTextMargin <> Value then
  begin
    FTextMargin := Value;
    Invalidate;
  end;
end;

procedure TMHLStaticTip.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Invalidate;
  end;
end;

procedure TMHLStaticTip.SetImages(const Value: TCustomImageList);
begin
  if Value <> FImages then
  begin
    if Assigned(FImages) then
    begin
      FImages.UnRegisterChanges(FImageChangeLink);
      FImages.RemoveFreeNotification(Self);
    end;

    FImages := Value;

    if Assigned(FImages) then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
    end;

    Invalidate;
  end;
end;

procedure TMHLStaticTip.ImageListChange(Sender: TObject);
begin
  Invalidate;
end;

end.

