inherited frameNCWOperation: TframeNCWOperation
  Width = 330
  Height = 210
  Constraints.MinHeight = 210
  Constraints.MinWidth = 330
  ExplicitWidth = 330
  ExplicitHeight = 210
  object pageHint: TMHLStaticTip [0]
    AlignWithMargins = True
    Left = 14
    Top = 142
    Width = 302
    Height = 58
    Margins.Left = 14
    Margins.Right = 14
    Images = DMUser.SeverityImagesBig
    ImageIndex = 0
    Align = alTop
    ExplicitTop = 245
  end
  inherited pnTitle: TPanel
    Width = 330
    ExplicitWidth = 330
    inherited lblTitle: TLabel
      Width = 302
      Caption = #1058#1080#1087' '#1082#1086#1083#1077#1082#1094#1110#1111
      ExplicitWidth = 72
    end
    inherited lblSubTitle: TLabel
      Width = 295
      Caption = #1042#1082#1072#1078#1110#1090#1100' '#1090#1080#1087' '#1085#1086#1074#1086#1111' '#1082#1086#1083#1077#1082#1094#1110#1111
      ExplicitWidth = 145
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 58
    Width = 330
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object rbNew: TRadioButton
      AlignWithMargins = True
      Left = 14
      Top = 14
      Width = 195
      Height = 17
      Margins.Left = 14
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 0
      Caption = #1053#1086#1074#1072' '#1087#1086#1088#1086#1078#1085#1103' '#1082#1086#1083#1077#1082#1094#1110#1103
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = OnSetCollectionType
    end
    object rbExisting: TRadioButton
      AlignWithMargins = True
      Left = 14
      Top = 38
      Width = 195
      Height = 17
      Margins.Left = 14
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 0
      Caption = #1030#1089#1085#1091#1102#1095#1072' '#1082#1086#1083#1077#1082#1094#1110#1103' (hlc2)'
      TabOrder = 1
      OnClick = OnSetCollectionType
    end
    object rbInpx: TRadioButton
      AlignWithMargins = True
      Left = 14
      Top = 62
      Width = 306
      Height = 17
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 0
      Caption = #1050#1086#1083#1077#1082#1094#1110#1103' '#1079' '#1092#1072#1081#1083#1091' inpx'
      TabOrder = 2
      OnClick = OnSetCollectionType
    end
  end
end
