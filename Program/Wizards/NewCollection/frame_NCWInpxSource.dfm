inherited frameNCWInpxSource: TframeNCWInpxSource
  Width = 330
  Height = 350
  Constraints.MinHeight = 350
  Constraints.MinWidth = 330
  ExplicitWidth = 330
  ExplicitHeight = 350
  object pageHint: TMHLStaticTip [0]
    AlignWithMargins = True
    Left = 14
    Top = 289
    Width = 302
    Height = 58
    Margins.Left = 14
    Margins.Right = 14
    TextMargin = 15
    Images = DMUser.SeverityImagesBig
    ImageIndex = 0
    Align = alBottom
    ExplicitTop = 276
  end
  inherited pnTitle: TPanel
    Width = 330
    ExplicitWidth = 330
    inherited lblTitle: TLabel
      Width = 302
      Caption = #1044#1078#1077#1088#1077#1083#1086' INPX'
      ExplicitWidth = 85
    end
    inherited lblSubTitle: TLabel
      Width = 295
      Caption = #1042#1080#1073#1077#1088#1110#1090#1100' '#1092#1072#1081#1083' inpx '#1076#1083#1103' '#1089#1090#1074#1086#1088#1077#1085#1085#1103' '#1082#1086#1083#1077#1082#1094#1110#1111
      ExplicitWidth = 236
    end
  end
  object Panel1: TMHLSimplePanel
    Left = 0
    Top = 58
    Width = 330
    Height = 228
    Align = alClient
    TabOrder = 1
    object rbLocal: TRadioButton
      AlignWithMargins = True
      Left = 14
      Top = 7
      Width = 302
      Height = 17
      Margins.Left = 14
      Margins.Top = 7
      Margins.Right = 14
      Margins.Bottom = 0
      Align = alTop
      Caption = #1051#1086#1082#1072#1083#1100#1085#1080#1081' '#1092#1072#1081#1083' INPX'
      TabOrder = 0
      OnClick = OnSetINPXSource
    end
    object rbDownload: TRadioButton
      AlignWithMargins = True
      Left = 14
      Top = 60
      Width = 302
      Height = 17
      Margins.Left = 14
      Margins.Top = 7
      Margins.Right = 14
      Margins.Bottom = 0
      Align = alTop
      Caption = #1047#1072#1074#1072#1085#1090#1072#1078#1080#1090#1080' '#1110#1079' '#1089#1072#1081#1090#1091
      TabOrder = 2
      OnClick = OnSetINPXSource
    end
    object lvCollections: TListView
      AlignWithMargins = True
      Left = 14
      Top = 80
      Width = 302
      Height = 138
      Margins.Left = 14
      Margins.Right = 14
      Margins.Bottom = 10
      Align = alClient
      Columns = <
        item
          Width = 450
        end>
      Enabled = False
      GroupView = True
      ReadOnly = True
      TabOrder = 3
      ViewStyle = vsReport
      OnChange = lvCollectionsChange
    end
    object MHLSimplePanel1: TMHLSimplePanel
      Left = 0
      Top = 24
      Width = 330
      Height = 29
      Margins.Left = 13
      Margins.Right = 13
      Align = alTop
      TabOrder = 1
      DesignSize = (
        330
        29)
      object edINPXPath: TMHLAutoCompleteEdit
        Left = 14
        Top = 3
        Width = 221
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object btnSelectINPX: TButton
        Left = 241
        Top = 1
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1042#1080#1073#1088#1072#1090#1080
        TabOrder = 1
        OnClick = edINPXPathButtonClick
      end
    end
  end
end
