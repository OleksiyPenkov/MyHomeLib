inherited frameNCWNameAndLocation: TframeNCWNameAndLocation
  Width = 460
  Height = 270
  Constraints.MinHeight = 270
  Constraints.MinWidth = 460
  ExplicitWidth = 460
  ExplicitHeight = 270
  object Label1: TLabel [0]
    AlignWithMargins = True
    Left = 14
    Top = 63
    Width = 432
    Height = 30
    Margins.Left = 14
    Margins.Top = 5
    Margins.Right = 14
    Align = alTop
    Caption = 
      #1059#1082#1072#1078#1080#1090#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1083#1083#1077#1082#1094#1080#1080', '#1092#1072#1081#1083' '#1082#1086#1083#1083#1077#1082#1094#1080#1080' '#1080' '#1087#1072#1087#1082#1091', '#1074' '#1082#1086#1090#1086#1088#1086#1081' '#1042#1099 +
      ' '#1087#1083#1072#1085#1080#1088#1091#1077#1090#1077' '#1093#1088#1072#1085#1080#1090#1100' '#1082#1085#1080#1075#1080'.'
    Transparent = True
    WordWrap = True
    ExplicitTop = 61
    ExplicitWidth = 422
  end
  object pageHint: TMHLStaticTip [1]
    AlignWithMargins = True
    Left = 14
    Top = 210
    Width = 432
    Height = 58
    Margins.Left = 14
    Margins.Right = 14
    TextMargin = 15
    Images = DMUser.SeverityImagesBig
    Align = alTop
  end
  inherited pnTitle: TPanel
    Width = 460
    Height = 58
    ExplicitWidth = 460
    inherited lblTitle: TLabel
      Width = 432
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
      ExplicitWidth = 120
    end
    inherited lblSubTitle: TLabel
      Width = 425
      Caption = #1059#1082#1072#1078#1080#1090#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1080' '#1088#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1092#1072#1081#1083#1086#1074' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
      ExplicitWidth = 302
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 7
    Top = 106
    Width = 446
    Height = 101
    Margins.Left = 7
    Margins.Top = 10
    Margins.Right = 7
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      446
      101)
    object Label9: TLabel
      Left = 21
      Top = 42
      Width = 95
      Height = 15
      Caption = '&'#1060#1072#1081#1083' '#1082#1086#1083#1083#1077#1082#1094#1080#1080':'
      FocusControl = edCollectionFile
    end
    object Label5: TLabel
      Left = 21
      Top = 69
      Width = 96
      Height = 15
      Caption = '&'#1055#1072#1087#1082#1072' '#1089' '#1082#1085#1080#1075#1072#1084#1080':'
      FocusControl = edCollectionRoot
    end
    object Label8: TLabel
      Left = 21
      Top = 15
      Width = 118
      Height = 15
      Caption = '&'#1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1083#1083#1077#1082#1094#1080#1080':'
      FocusControl = edCollectionName
    end
    object edCollectionFile: TMHLAutoCompleteEdit
      Left = 136
      Top = 39
      Width = 225
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      OnChange = edCollectionFileChange
      OnEnter = CheckControlData
      AutoCompleteOption = [acoFileSystem]
    end
    object btnNewFile: TButton
      Left = 367
      Top = 37
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      TabOrder = 2
      OnClick = btnNewFileClick
    end
    object edCollectionRoot: TMHLAutoCompleteEdit
      Left = 136
      Top = 66
      Width = 225
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      OnChange = CheckControlData
      OnEnter = CheckControlData
      AutoCompleteOption = [acoFileSystem]
    end
    object btnSelectRoot: TButton
      Left = 367
      Top = 64
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      TabOrder = 4
      OnClick = btnSelectRootClick
    end
    object edCollectionName: TEdit
      Left = 136
      Top = 12
      Width = 225
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = edCollectionNameChange
      OnEnter = CheckControlData
    end
  end
end
