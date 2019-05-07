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
    Top = 148
    Width = 432
    Height = 59
    Margins.Left = 14
    Margins.Right = 14
    Images = DMUser.SeverityImagesBig
    ImageIndex = 0
    Align = alTop
    ExplicitTop = 126
  end
  inherited pnTitle: TPanel
    Width = 460
    ExplicitWidth = 460
    inherited lblTitle: TLabel
      Width = 91
      Caption = #1060#1086#1088#1084#1072#1090' '#1092#1072#1081#1083#1086#1074
      ExplicitWidth = 91
    end
    inherited lblSubTitle: TLabel
      Width = 361
      Caption = #1059#1082#1072#1078#1080#1090#1077', '#1082#1085#1080#1075#1080' '#1074' '#1082#1072#1082#1086#1084' '#1092#1086#1088#1084#1072#1090#1077' '#1042#1099' '#1087#1083#1072#1085#1080#1088#1091#1077#1090#1077' '#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
      ExplicitWidth = 361
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 56
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
      Caption = #1050#1085#1080#1075#1080' '#1074' &'#1076#1088#1091#1075#1080#1093' '#1092#1086#1088#1084#1072#1090#1072#1093' (fbd, pdf, djvu)'
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
      Caption = #1050#1085'&'#1080#1075#1080' '#1074' '#1092#1086#1088#1084#1072#1090#1077' FictionBook'
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
      Caption = #1053#1072#1095#1072#1090#1100' '#1080#1084#1087#1086#1088#1090' '#1082#1085#1080#1075' '#1087#1086#1089#1083#1077' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
end
