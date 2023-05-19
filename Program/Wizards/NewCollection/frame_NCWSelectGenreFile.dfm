inherited frameNCWSelectGenreFile: TframeNCWSelectGenreFile
  Width = 460
  Height = 280
  Constraints.MinHeight = 220
  Constraints.MinWidth = 460
  ExplicitWidth = 460
  ExplicitHeight = 280
  object pageHint: TMHLStaticTip [0]
    AlignWithMargins = True
    Left = 14
    Top = 174
    Width = 432
    Height = 58
    Margins.Left = 14
    Margins.Right = 14
    Images = DMUser.SeverityImagesBig
    ImageIndex = 0
    Align = alTop
    ExplicitTop = 336
    ExplicitWidth = 469
  end
  inherited pnTitle: TPanel
    Width = 460
    ExplicitWidth = 460
    inherited lblTitle: TLabel
      Width = 432
      Caption = #1060#1072#1081#1083' '#1086#1087#1080#1089#1091' '#1078#1072#1085#1088#1110#1074
      ExplicitWidth = 110
    end
    inherited lblSubTitle: TLabel
      Width = 425
      Caption = #1042#1082#1072#1078#1110#1090#1100' '#1092#1072#1081#1083' '#1086#1087#1080#1089#1091' '#1078#1072#1085#1088#1110#1074' '#1076#1083#1103' '#1082#1086#1083#1077#1082#1094#1110#1111
      ExplicitWidth = 221
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 58
    Width = 460
    Height = 113
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinWidth = 460
    TabOrder = 1
    DesignSize = (
      460
      113)
    object Label10: TLabel
      Left = 28
      Top = 65
      Width = 73
      Height = 15
      Caption = #1060#1072#1081#1083' &'#1078#1072#1085#1088#1110#1074':'
      FocusControl = edGenreList
    end
    object rbSpecialGenreFile: TRadioButton
      AlignWithMargins = True
      Left = 14
      Top = 38
      Width = 439
      Height = 17
      Margins.Left = 14
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 0
      Align = alTop
      Caption = #1057#1087#1077#1094#1110#1072#1083#1100#1085#1080#1081' '#1092#1072#1081#1083' '#1078#1072#1085#1088#1110#1074
      TabOrder = 1
      OnClick = OnSetFileType
    end
    object rbDefaultGenreFile: TRadioButton
      AlignWithMargins = True
      Left = 14
      Top = 14
      Width = 439
      Height = 17
      Margins.Left = 14
      Margins.Top = 14
      Margins.Right = 7
      Margins.Bottom = 0
      Align = alTop
      Caption = #1047#1072' '#1079#1072#1084#1086#1074#1095#1091#1074#1072#1085#1085#1103#1084
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = OnSetFileType
    end
    object edGenreList: TMHLAutoCompleteEdit
      Left = 105
      Top = 62
      Width = 260
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 2
    end
    object btnGenreList: TButton
      Left = 371
      Top = 60
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1080#1073#1088#1072#1090#1080
      Enabled = False
      TabOrder = 3
      OnClick = btnGenreListClick
    end
    object cbAutoImport: TCheckBox
      Left = 14
      Top = 89
      Width = 283
      Height = 17
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1080' '#1110#1084#1087#1086#1088#1090' '#1087#1110#1089#1083#1103' '#1089#1090#1074#1086#1088#1077#1085#1085#1103' '#1082#1086#1083#1077#1082#1094#1110#1111
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
end
