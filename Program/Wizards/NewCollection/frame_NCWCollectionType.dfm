inherited frameNCWInpxSource: TframeNCWInpxSource
  Width = 330
  Constraints.MinHeight = 240
  Constraints.MinWidth = 330
  ExplicitWidth = 330
  object pageHint: TMHLStaticTip [0]
    AlignWithMargins = True
    Left = 14
    Top = 156
    Width = 302
    Height = 58
    Margins.Left = 14
    Margins.Right = 14
    TextMargin = 15
    Images = DMUser.SeverityImagesBig
    ImageIndex = 0
    Align = alTop
    ExplicitTop = 204
  end
  inherited pnTitle: TPanel
    Width = 330
    ExplicitWidth = 330
    inherited lblTitle: TLabel
      Width = 302
      Caption = #1042#1099#1073#1086#1088' '#1090#1080#1087#1072' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
      ExplicitWidth = 133
    end
    inherited lblSubTitle: TLabel
      Width = 295
      Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1082#1086#1083#1083#1077#1082#1094#1080#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1077' '#1089#1087#1080#1089#1082#1086#1074' '#1082#1085#1080#1075
      ExplicitWidth = 228
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 56
    Width = 330
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object rbThirdParty: TRadioButton
      AlignWithMargins = True
      Left = 17
      Top = 10
      Width = 306
      Height = 17
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 0
      Caption = #1051#1086#1082#1072#1083#1100#1085#1099#1081' '#1092#1072#1081#1083' INPX'
      TabOrder = 0
      OnClick = OnSetCollectionType
    end
    object edINPXPath: TRzButtonEdit
      AlignWithMargins = True
      Left = 18
      Top = 66
      Width = 294
      Height = 21
      Margins.Left = 18
      Margins.Right = 18
      Margins.Bottom = 10
      Align = alBottom
      TabOrder = 1
      AltBtnWidth = 15
      ButtonWidth = 15
      OnButtonClick = edINPXPathButtonClick
      ExplicitTop = 114
    end
    object RadioButton1: TRadioButton
      AlignWithMargins = True
      Left = 17
      Top = 34
      Width = 306
      Height = 17
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 0
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089' '#1089#1072#1081#1090#1072
      TabOrder = 2
      OnClick = OnSetCollectionType
    end
  end
end
