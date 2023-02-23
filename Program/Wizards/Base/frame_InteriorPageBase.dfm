inherited InteriorPageBase: TInteriorPageBase
  object pnTitle: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 56
    Align = alTop
    AutoSize = True
    BevelEdges = [beBottom]
    BevelKind = bkTile
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object lblTitle: TLabel
      AlignWithMargins = True
      Left = 14
      Top = 7
      Width = 141
      Height = 13
      Margins.Left = 14
      Margins.Top = 7
      Margins.Right = 14
      Margins.Bottom = 0
      Align = alTop
      Caption = '<'#1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1089#1090#1088#1072#1085#1080#1094#1099'>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSubTitle: TLabel
      AlignWithMargins = True
      Left = 28
      Top = 27
      Width = 151
      Height = 15
      Margins.Left = 28
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 14
      Align = alTop
      Caption = '<'#1055#1086#1076#1079#1072#1075#1086#1083#1086#1074#1086#1082' '#1089#1090#1088#1072#1085#1080#1094#1099'>'
    end
  end
end
