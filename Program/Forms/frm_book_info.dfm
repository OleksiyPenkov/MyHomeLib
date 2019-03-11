object frmBookDetails: TfrmBookDetails
  Left = 0
  Top = 0
  ActiveControl = pcBookInfo
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1085#1080#1075#1077
  ClientHeight = 481
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcBookInfo: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 622
    Height = 394
    ActivePage = tsReview
    Align = alClient
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    object tsFileInfo: TTabSheet
      Caption = #1060#1072#1081#1083
      ImageIndex = 2
      object lvFileInfo: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 608
        Height = 360
        Align = alClient
        Columns = <
          item
            Caption = #1055#1086#1083#1077
            Width = 175
          end
          item
            Caption = #1047#1085#1072#1095#1077#1085#1080#1077
            Width = 150
          end>
        ColumnClick = False
        GroupView = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmBookInfo
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object tsInfo: TTabSheet
      Caption = 'Fb2 '#1080#1085#1092#1086
      object imgCover: TImage
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 214
        Height = 239
        Hint = #1054#1073#1083#1086#1078#1082#1072
        Align = alLeft
        Center = True
        IncrementalDisplay = True
        ParentShowHint = False
        Proportional = True
        ShowHint = True
        Stretch = True
        ExplicitHeight = 310
      end
      object mmShort: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 248
        Width = 608
        Height = 115
        Align = alBottom
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
        WantReturns = False
      end
      object lvInfo: TListView
        AlignWithMargins = True
        Left = 223
        Top = 3
        Width = 388
        Height = 239
        Align = alClient
        Columns = <
          item
            Caption = #1055#1086#1083#1077
            Width = 175
          end
          item
            AutoSize = True
            Caption = #1047#1085#1072#1095#1077#1085#1080#1077
          end>
        ColumnClick = False
        GroupView = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmBookInfo
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object tsReview: TTabSheet
      Caption = #1056#1077#1094#1077#1085#1079#1080#1080' '#1089' '#1089#1072#1081#1090#1072
      object mmReview: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 608
        Height = 327
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = mmReviewChange
      end
      object pnReviewButtons: TPanel
        Left = 0
        Top = 333
        Width = 614
        Height = 33
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnReviewButtons'
        ShowCaption = False
        TabOrder = 1
        Visible = False
        DesignSize = (
          614
          33)
        object btnLoadReview: TButton
          Left = 416
          Top = 3
          Width = 115
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089' '#1089#1072#1081#1090#1072
          TabOrder = 0
          OnClick = btnLoadReviewClick
        end
        object btnClearReview: TButton
          Left = 537
          Top = 3
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #1054#1095#1080#1089#1090#1080#1090#1100
          TabOrder = 1
          OnClick = btnClearReviewClick
        end
      end
    end
    object tsAnnotation: TTabSheet
      Caption = #1040#1085#1085#1086#1090#1072#1094#1080#1103' '#1089' '#1089#1072#1081#1090#1072
      ImageIndex = 3
      object mmoAnnotation: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 608
        Height = 360
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = mmReviewChange
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 444
    Width = 628
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      628
      37)
    object btnClose: TButton
      Left = 545
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
    end
  end
  object pnTitle: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 44
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Caption = 'pnTitle'
    Color = clWindow
    Padding.Left = 6
    Padding.Top = 6
    Padding.Right = 6
    Padding.Bottom = 6
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object lblAuthors: TLabel
      AlignWithMargins = True
      Left = 9
      Top = 25
      Width = 610
      Height = 13
      Align = alTop
      Caption = #1040#1074#1090#1086#1088'('#1099')'
      ShowAccelChar = False
      Transparent = True
      ExplicitWidth = 47
    end
    object lblTitle: TLabel
      AlignWithMargins = True
      Left = 9
      Top = 9
      Width = 610
      Height = 13
      Align = alTop
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ShowAccelChar = False
      ExplicitWidth = 55
    end
  end
  object pmBookInfo: TPopupMenu
    Left = 64
    Top = 120
    object miCopyValue: TMenuItem
      Action = acCopyValue
    end
  end
  object alBookInfo: TActionList
    Left = 136
    Top = 120
    object acCopyValue: TAction
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1074' '#1073#1091#1092#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ShortCut = 16451
      OnExecute = acCopyValueExecute
      OnUpdate = acCopyValueUpdate
    end
  end
end
