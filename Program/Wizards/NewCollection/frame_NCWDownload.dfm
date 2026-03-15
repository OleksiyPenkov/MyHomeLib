inherited frameNCWDownload: TframeNCWDownload
  Height = 160
  Constraints.MinHeight = 160
  Constraints.MinWidth = 320
  ExplicitHeight = 160
  object lblStatus: TLabel [0]
    AlignWithMargins = True
    Left = 14
    Top = 65
    Width = 292
    Height = 15
    Margins.Left = 14
    Margins.Top = 7
    Margins.Right = 14
    Margins.Bottom = 0
    Align = alTop
    Caption = #1055#1110#1076#1082#1083#1102#1095#1077#1085#1085#1103' ...'
    ExplicitWidth = 86
  end
  object Bar: TProgressBar [1]
    AlignWithMargins = True
    Left = 14
    Top = 87
    Width = 292
    Height = 17
    Margins.Left = 14
    Margins.Top = 7
    Margins.Right = 14
    Margins.Bottom = 0
    Align = alTop
    TabOrder = 1
  end
  inherited pnTitle: TPanel
    inherited lblTitle: TLabel
      Caption = #1047#1072#1074#1072#1085#1090#1072#1078#1077#1085#1085#1103' '#1092#1072#1081#1083#1091' INPX'
      ExplicitWidth = 156
    end
    inherited lblSubTitle: TLabel
      Caption = #1047#1072#1095#1077#1082#1072#1081#1090#1077', '#1087#1086#1082#1080' '#1092#1072#1081#1083' '#1073#1091#1076#1077' '#1079#1072#1074#1072#1085#1090#1072#1078#1077#1085#1080#1081' '#1110#1079' '#1089#1077#1088#1074#1077#1088#1072
      ExplicitWidth = 287
    end
  end
end
