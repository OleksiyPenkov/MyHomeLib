unit unit_ColorTabs;
interface

uses ComCtrls, StdCtrls, Classes, Graphics, Messages, Windows;

type
  TTabSheet = class(ComCtrls.TTabSheet)
  private
    FColor: TColor;
    procedure SetColor(Value: TColor);
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd);
      message WM_ERASEBKGND;
  public
    constructor Create(aOwner: TComponent); override;
    property Color: TColor read FColor write SetColor;
  end;

  {...}
 implementation
{...}

constructor TTabSheet.Create(aOwner: TComponent);
begin
  inherited;
  FColor := clBtnFace;
end;

procedure TTabSheet.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Invalidate;
  end;
end;

procedure TTabSheet.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  if FColor = clBtnFace then
    inherited
  else
  begin
    Brush.Color := FColor;
    Windows.FillRect(Msg.dc, ClientRect, Brush.Handle);
    Msg.Result := 1;
  end;
end;

end.
