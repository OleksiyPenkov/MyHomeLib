inherited frameNCWCollectionFileTypes: TframeNCWCollectionFileTypes
  Width = 460
  Height = 216
  Constraints.MinHeight = 200
  Constraints.MinWidth = 460
  ExplicitWidth = 460
  ExplicitHeight = 216
  object pageHint: TMHLStaticTip [0]
    AlignWithMargins = True
    Left = 14
    Top = 150
    Width = 432
    Height = 59
    Margins.Left = 14
    Margins.Right = 14
    ImageIndex = 0
    Align = alTop
    ExplicitTop = 126
  end
  inherited pnTitle: TPanel
    Width = 460
    ExplicitWidth = 460
    inherited lblTitle: TLabel
      Width = 432
      Caption = #1060#1086#1088#1084#1072#1090' '#1092#1072#1081#1083#1110#1074
      ExplicitWidth = 87
    end
    inherited lblSubTitle: TLabel
      Width = 425
      Caption = #1042#1082#1072#1078#1110#1090#1100' '#1082#1085#1080#1075#1080' '#1074' '#1103#1082#1086#1084#1091' '#1092#1086#1088#1084#1072#1090#1110' '#1042#1080' '#1087#1083#1072#1085#1091#1108#1090#1077' '#1079#1073#1077#1088#1110#1075#1072#1090#1080' '#1074' '#1082#1086#1083#1077#1082#1094#1110#1111
      ExplicitWidth = 353
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 58
    Width = 460
    Height = 89
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinWidth = 460
    TabOrder = 1
    object rbSoreAnyFiles: TRadioButton
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
      Caption = #1050#1085#1080#1075#1080' '#1074' '#1110#1085#1096#1080#1093' '#1092#1086#1088#1084#1072#1090#1072#1093' (fbd, pdf, djvu)'
      TabOrder = 0
      OnClick = OnSetFileType
    end
    object rbSoreFB2Files: TRadioButton
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
      Caption = #1050#1085#1080#1075#1080' '#1091' '#1092#1086#1088#1084#1072#1090#1110' FictionBook'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = OnSetFileType
    end
    object cbAutoImport: TCheckBox
      Left = 14
      Top = 66
      Width = 403
      Height = 17
      Caption = #1056#1086#1079#1087#1086#1095#1072#1090#1080' '#1110#1084#1087#1086#1088#1090' '#1082#1085#1080#1075' '#1087#1110#1089#1083#1103' '#1089#1090#1074#1086#1088#1077#1085#1085#1103' '#1082#1086#1083#1077#1082#1094#1110#1111
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
end
