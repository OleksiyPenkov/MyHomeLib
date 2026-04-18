unit frm_splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms;

type
  TfrmSplash = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    FStatus: string;
    FScale: Double;
    function S(Value: Integer): Integer; inline;
    procedure Render;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
  public
    procedure SetStatus(const AStatus: string);
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses
  Winapi.GDIPAPI, Winapi.GDIPOBJ;

const
  CCardMarginTop    = 16;
  CCardMarginBottom = 28;
  CCardMarginLR     = 22;
  CCornerRadius     = 0;
  CContentLeft      = 44;

procedure AddRoundedRect(Path: TGPGraphicsPath; X, Y, W, H, R: Single);
begin
  if R <= 0 then
  begin
    Path.AddRectangle(MakeRect(X, Y, W, H));
    Exit;
  end;
  Path.AddArc(X,               Y,               R * 2, R * 2, 180, 90);
  Path.AddArc(X + W - R * 2,   Y,               R * 2, R * 2, 270, 90);
  Path.AddArc(X + W - R * 2,   Y + H - R * 2,   R * 2, R * 2,   0, 90);
  Path.AddArc(X,               Y + H - R * 2,   R * 2, R * 2,  90, 90);
  Path.CloseFigure;
end;

procedure TfrmSplash.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_LAYERED or WS_EX_TOOLWINDOW;
end;

procedure TfrmSplash.CreateWnd;
begin
  inherited;
  SetWindowLong(Handle, GWL_EXSTYLE,
    GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED or WS_EX_TOOLWINDOW);
  Render;
end;

function TfrmSplash.S(Value: Integer): Integer;
begin
  Result := Round(Value * FScale);
end;

procedure TfrmSplash.WMSize(var Msg: TWMSize);
begin
  inherited;
  if HandleAllocated then
    Render;
end;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  FStatus := '';
end;

procedure TfrmSplash.SetStatus(const AStatus: string);
begin
  FStatus := AStatus;
  if HandleAllocated then
    Render;
end;

procedure TfrmSplash.Render;
var
  hdcScreen, hdcMem: HDC;
  Bmp, OldBmp: HBITMAP;
  BI: TBitmapInfo;
  PBits: Pointer;
  GPBitmap: TGPBitmap;
  Graphics: TGPGraphics;
  Brush: TGPLinearGradientBrush;
  SolidBrush: TGPSolidBrush;
  Path: TGPGraphicsPath;
  Font: TGPFont;
  FontLight: TGPFontFamily;
  FontRegular: TGPFontFamily;
  RectF: TGPRectF;
  SF: TGPStringFormat;
  BF: BLENDFUNCTION;
  P0, Size: TPoint;
  CardRect: TGPRectF;
  CornerRadius: Single;
  i: Integer;
  W, H: Integer;
  VersionText: string;
begin
  FScale := CurrentPPI / 96;
  W := Width;
  H := Height;

  FillChar(BI, SizeOf(BI), 0);
  BI.bmiHeader.biSize := SizeOf(TBitmapInfoHeader);
  BI.bmiHeader.biWidth := W;
  BI.bmiHeader.biHeight := -H; // top-down DIB
  BI.bmiHeader.biPlanes := 1;
  BI.bmiHeader.biBitCount := 32;
  BI.bmiHeader.biCompression := BI_RGB;

  hdcScreen := GetDC(0);
  try
    hdcMem := CreateCompatibleDC(hdcScreen);
    PBits := nil;
    Bmp := CreateDIBSection(hdcScreen, BI, DIB_RGB_COLORS, PBits, 0, 0);
    OldBmp := SelectObject(hdcMem, Bmp);
    try
      ZeroMemory(PBits, W * H * 4);
      GPBitmap := TGPBitmap.Create(W, H, W * 4, PixelFormat32bppPARGB, PByte(PBits));
      Graphics := TGPGraphics.Create(GPBitmap);
      try
        Graphics.SetSmoothingMode(SmoothingModeAntiAlias);
        Graphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
        Graphics.Clear(MakeColor(0, 0, 0, 0));

        CornerRadius := S(CCornerRadius);

        CardRect.X := S(CCardMarginLR);
        CardRect.Y := S(CCardMarginTop);
        CardRect.Width  := W - S(CCardMarginLR) * 2;
        CardRect.Height := H - S(CCardMarginTop) - S(CCardMarginBottom);

        // Drop shadow — concentric semi-transparent rounded rects
        for i := 12 downto 1 do
        begin
          Path := TGPGraphicsPath.Create;
          try
            AddRoundedRect(Path,
              CardRect.X - i,
              CardRect.Y - i + S(3),
              CardRect.Width + i * 2,
              CardRect.Height + i * 2,
              CornerRadius + i);
            SolidBrush := TGPSolidBrush.Create(MakeColor(10, 0, 0, 0));
            try
              Graphics.FillPath(SolidBrush, Path);
            finally
              SolidBrush.Free;
            end;
          finally
            Path.Free;
          end;
        end;

        // Card background — vertical gradient
        Path := TGPGraphicsPath.Create;
        try
          AddRoundedRect(Path, CardRect.X, CardRect.Y, CardRect.Width, CardRect.Height, CornerRadius);
          Brush := TGPLinearGradientBrush.Create(
            MakePoint(Single(0.0), CardRect.Y),
            MakePoint(Single(0.0), CardRect.Y + CardRect.Height),
            MakeColor(255, $2E, $5C, $9E),
            MakeColor(255, $17, $2F, $58));
          try
            Graphics.FillPath(Brush, Path);
          finally
            Brush.Free;
          end;
        finally
          Path.Free;
        end;

        // Top highlight — subtle inner glow along the top edge
        Path := TGPGraphicsPath.Create;
        try
          AddRoundedRect(Path, CardRect.X + 1, CardRect.Y + 1,
            CardRect.Width - 2, S(2), CornerRadius);
          SolidBrush := TGPSolidBrush.Create(MakeColor(64, 255, 255, 255));
          try
            Graphics.FillPath(SolidBrush, Path);
          finally
            SolidBrush.Free;
          end;
        finally
          Path.Free;
        end;

        // Ukrainian flag bottom strip (blue over yellow)
        Path := TGPGraphicsPath.Create;
        try
          AddRoundedRect(Path, CardRect.X, CardRect.Y, CardRect.Width, CardRect.Height, CornerRadius);
          Graphics.SetClip(Path);
          try
            SolidBrush := TGPSolidBrush.Create(MakeColor(255, $00, $57, $B7));
            try
              Graphics.FillRectangle(SolidBrush,
                MakeRect(CardRect.X, CardRect.Y + CardRect.Height - S(24),
                         CardRect.Width, Single(S(12))));
            finally
              SolidBrush.Free;
            end;
            SolidBrush := TGPSolidBrush.Create(MakeColor(255, $FF, $D5, $00));
            try
              Graphics.FillRectangle(SolidBrush,
                MakeRect(CardRect.X, CardRect.Y + CardRect.Height - S(12),
                         CardRect.Width, Single(S(12))));
            finally
              SolidBrush.Free;
            end;
          finally
            Graphics.ResetClip;
          end;
        finally
          Path.Free;
        end;

        FontLight := TGPFontFamily.Create('Segoe UI Light');
        FontRegular := TGPFontFamily.Create('Segoe UI');
        try
          SF := TGPStringFormat.Create;
          try
            SF.SetAlignment(StringAlignmentNear);
            SF.SetLineAlignment(StringAlignmentNear);

            // Title
            Font := TGPFont.Create(FontLight, S(40), FontStyleRegular, UnitPixel);
            try
              SolidBrush := TGPSolidBrush.Create(MakeColor(255, 255, 255, 255));
              try
                RectF.X := CardRect.X + S(CContentLeft);
                RectF.Y := CardRect.Y + S(36);
                RectF.Width  := CardRect.Width - S(CContentLeft) * 2;
                RectF.Height := S(52);
                Graphics.DrawString('MyHomeLib', -1, Font, RectF, SF, SolidBrush);
              finally
                SolidBrush.Free;
              end;
            finally
              Font.Free;
            end;

            // Tagline
            Font := TGPFont.Create(FontRegular, S(13), FontStyleRegular, UnitPixel);
            try
              SolidBrush := TGPSolidBrush.Create(MakeColor(220, 200, 225, 245));
              try
                RectF.X := CardRect.X + S(CContentLeft);
                RectF.Y := CardRect.Y + S(94);
                RectF.Width  := CardRect.Width - S(CContentLeft) * 2;
                RectF.Height := S(22);
                Graphics.DrawString('Менеджер домашньої електронної бібліотеки', -1, Font, RectF, SF, SolidBrush);
              finally
                SolidBrush.Free;
              end;
            finally
              Font.Free;
            end;

            // Version
            {$IFDEF WIN64}
            VersionText := 'Version 2.6.0  ·  x64';
            {$ELSE}
            VersionText := 'Version 2.6.0  ·  x32';
            {$ENDIF}
            Font := TGPFont.Create(FontRegular, S(11), FontStyleRegular, UnitPixel);
            try
              SolidBrush := TGPSolidBrush.Create(MakeColor(180, 160, 190, 220));
              try
                RectF.X := CardRect.X + S(CContentLeft);
                RectF.Y := CardRect.Y + CardRect.Height - S(84);
                RectF.Width  := CardRect.Width - S(CContentLeft) * 2;
                RectF.Height := S(20);
                Graphics.DrawString(PWideChar(VersionText), -1, Font, RectF, SF, SolidBrush);
              finally
                SolidBrush.Free;
              end;
            finally
              Font.Free;
            end;

            // Status line
            if FStatus <> '' then
            begin
              Font := TGPFont.Create(FontRegular, S(10), FontStyleRegular, UnitPixel);
              try
                SolidBrush := TGPSolidBrush.Create(MakeColor(170, 140, 180, 210));
                try
                  RectF.X := CardRect.X + S(CContentLeft);
                  RectF.Y := CardRect.Y + CardRect.Height - S(60);
                  RectF.Width  := CardRect.Width - S(CContentLeft) * 2;
                  RectF.Height := S(20);
                  Graphics.DrawString(PWideChar(FStatus), -1, Font, RectF, SF, SolidBrush);
                finally
                  SolidBrush.Free;
                end;
              finally
                Font.Free;
              end;
            end;
          finally
            SF.Free;
          end;
        finally
          FontRegular.Free;
          FontLight.Free;
        end;
      finally
        Graphics.Free;
        GPBitmap.Free;
      end;

      P0 := Point(0, 0);
      Size.X := W;
      Size.Y := H;
      FillChar(BF, SizeOf(BF), 0);
      BF.BlendOp := AC_SRC_OVER;
      BF.SourceConstantAlpha := 255;
      BF.AlphaFormat := AC_SRC_ALPHA;

      UpdateLayeredWindow(Handle, hdcScreen, nil, @Size, hdcMem, @P0, 0, @BF, ULW_ALPHA);
    finally
      SelectObject(hdcMem, OldBmp);
      DeleteObject(Bmp);
      DeleteDC(hdcMem);
    end;
  finally
    ReleaseDC(0, hdcScreen);
  end;
end;

end.
