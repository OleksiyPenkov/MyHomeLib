inherited frameNCWProgress: TframeNCWProgress
  Width = 460
  Height = 300
  Constraints.MinHeight = 300
  Constraints.MinWidth = 460
  ExplicitWidth = 460
  ExplicitHeight = 300
  object txtComment: TLabel [0]
    AlignWithMargins = True
    Left = 14
    Top = 63
    Width = 432
    Height = 13
    Margins.Left = 14
    Margins.Top = 7
    Margins.Right = 14
    Margins.Bottom = 0
    Align = alTop
    AutoSize = False
    Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1091#1077#1084'...'
    EllipsisPosition = epEndEllipsis
    ExplicitLeft = -25
    ExplicitTop = 13
    ExplicitWidth = 345
  end
  object Bar: TProgressBar [1]
    AlignWithMargins = True
    Left = 14
    Top = 83
    Width = 432
    Height = 17
    Margins.Left = 14
    Margins.Top = 7
    Margins.Right = 14
    Margins.Bottom = 0
    Align = alTop
    TabOrder = 3
  end
  inherited pnTitle: TPanel
    Width = 460
    ExplicitWidth = 460
    inherited lblTitle: TLabel
      Width = 432
      Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
      ExplicitWidth = 121
    end
    inherited lblSubTitle: TLabel
      Width = 425
      Caption = #1055#1086#1076#1086#1078#1076#1080#1090#1077', '#1087#1086#1082#1072' '#1084#1072#1089#1090#1077#1088' '#1079#1072#1082#1086#1085#1095#1080#1090' '#1089#1086#1079#1076#1072#1085#1080#1077' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
      ExplicitWidth = 285
    end
  end
  object errorLog: TListView
    AlignWithMargins = True
    Left = 14
    Top = 107
    Width = 432
    Height = 150
    Margins.Left = 14
    Margins.Top = 7
    Margins.Right = 14
    Margins.Bottom = 7
    Align = alClient
    Columns = <
      item
        Width = 20
      end
      item
        AutoSize = True
      end>
    ColumnClick = False
    HoverTime = 65535
    Items.ItemData = {
      03C10000000400000000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF000000
      00000C49006E0066006F0020004D0065007300730061006700650001000000FF
      FFFFFFFFFFFFFF01000000FFFFFFFF00000000000F5700610072006E0069006E
      00670020004D0065007300730061006700650002000000FFFFFFFFFFFFFFFF01
      000000FFFFFFFF00000000000D4500720072006F00720020004D006500730073
      00610067006500FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF0000000000
      FFFFFFFFFFFF}
    RowSelect = True
    SmallImages = DMUser.SeverityImages
    TabOrder = 1
    ViewStyle = vsReport
  end
  object pnButtons: TPanel
    Left = 0
    Top = 264
    Width = 460
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    DesignSize = (
      460
      36)
    object btnSaveLog: TButton
      Left = 14
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
    end
  end
end
