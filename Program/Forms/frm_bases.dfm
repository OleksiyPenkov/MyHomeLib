object frmBases: TfrmBases
  Left = 0
  Top = 0
  HelpContext = 110
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = #1042#1083#1072#1089#1090#1080#1074#1086#1089#1090#1110' '#1082#1086#1083#1077#1082#1094#1110#1111
  ClientHeight = 281
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object pcCollectionInfo: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 432
    Height = 235
    ActivePage = tsGeneralInfo
    Align = alTop
    TabOrder = 0
    object tsGeneralInfo: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1110
      DesignSize = (
        424
        207)
      object warningMessage: TMHLStaticTip
        AlignWithMargins = True
        Left = 10
        Top = 122
        Width = 407
        Height = 62
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 7
        Caption = 
          #1059#1074#1072#1075#1072'! '#1053#1077#1082#1086#1088#1077#1082#1090#1085#1072' '#1079#1084#1110#1085#1072' '#1074#1083#1072#1089#1090#1080#1074#1086#1089#1090#1077#1081' '#1082#1086#1083#1077#1082#1094#1110#1111' '#1084#1086#1078#1077' '#1087#1088#1080#1079#1074#1077#1089#1090#1080' '#1076#1086' ' +
          #1111#1111' '#1085#1077#1087#1088#1072#1094#1077#1079#1076#1072#1090#1085#1086#1089#1090#1110'!'
      end
      object lblCollectionDescription: TLabel
        Left = 10
        Top = 91
        Width = 72
        Height = 13
        Caption = #1054#1087#1080#1089' '#1082#1086#1083#1077#1082#1094#1110#1111':'
        FocusControl = edCollectionRoot
      end
      object lblCollectionRoot: TLabel
        Left = 10
        Top = 64
        Width = 87
        Height = 13
        Caption = '&'#1055#1072#1087#1082#1072' '#1079' '#1082#1085#1080#1075#1072#1084#1080':'
        FocusControl = edCollectionRoot
      end
      object lblCollectionFile: TLabel
        Left = 10
        Top = 37
        Width = 73
        Height = 13
        Caption = '&'#1060#1072#1081#1083' '#1082#1086#1083#1077#1082#1094#1110#1111':'
        FocusControl = edCollectionFile
      end
      object lblCollectionName: TLabel
        Left = 10
        Top = 10
        Width = 77
        Height = 13
        Caption = '&'#1053#1072#1079#1074#1072' '#1082#1086#1083#1077#1082#1094#1110#1111':'
        FocusControl = edCollectionName
      end
      object edDescription: TEdit
        Left = 126
        Top = 88
        Width = 291
        Height = 21
        TabOrder = 4
      end
      object edCollectionRoot: TMHLAutoCompleteEdit
        Left = 126
        Top = 61
        Width = 206
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        AutoCompleteOption = [acoFileSystem]
        ExplicitWidth = 202
      end
      object edCollectionFile: TMHLAutoCompleteEdit
        Left = 126
        Top = 34
        Width = 287
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ParentColor = True
        ReadOnly = True
        TabOrder = 1
        AutoCompleteOption = [acoFileSystem]
        ExplicitWidth = 283
      end
      object edCollectionName: TEdit
        Left = 126
        Top = 7
        Width = 287
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        ExplicitWidth = 283
      end
      object btnSelectRoot: TButton
        Left = 342
        Top = 59
        Width = 75
        Height = 25
        Caption = #1042#1080#1073#1088#1072#1090#1080
        TabOrder = 3
        OnClick = edDBFolderButtonClick
      end
    end
    object tsConnectionInfo: TTabSheet
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      object lblUser: TLabel
        Left = 10
        Top = 37
        Width = 60
        Height = 13
        Caption = #1050#1086#1088#1080#1089#1090#1091#1074#1072#1095
        FocusControl = edUser
        Transparent = True
      end
      object lblPassword: TLabel
        Left = 235
        Top = 37
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = #1055#1072#1088#1086#1083#1100
        Color = clMenuBar
        FocusControl = edPass
        ParentColor = False
        Transparent = True
      end
      object lblURL: TLabel
        Left = 10
        Top = 10
        Width = 19
        Height = 13
        Alignment = taRightJustify
        Caption = 'URL'
        Color = clMenuBar
        FocusControl = edURL
        ParentColor = False
        Transparent = True
      end
      object lblScript: TLabel
        Left = 18
        Top = 61
        Width = 114
        Height = 13
        Alignment = taRightJustify
        Caption = #1057#1094#1077#1085#1072#1088#1110#1081' '#1087#1110#1076#1082#1083#1102#1095#1077#1085#1085#1103
        Color = clMenuBar
        FocusControl = mmScript
        ParentColor = False
        Transparent = True
      end
      object mmScript: TMemo
        Left = 10
        Top = 80
        Width = 407
        Height = 120
        Lines.Strings = (
          '')
        ScrollBars = ssVertical
        TabOrder = 3
      end
      object edUser: TEdit
        Left = 88
        Top = 34
        Width = 115
        Height = 21
        TabOrder = 1
      end
      object edPass: TEdit
        Left = 278
        Top = 34
        Width = 139
        Height = 21
        PasswordChar = '*'
        TabOrder = 2
      end
      object edURL: TEdit
        Left = 44
        Top = 7
        Width = 373
        Height = 21
        TabOrder = 0
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 240
    Width = 438
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnButtons'
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 239
    ExplicitWidth = 434
    DesignSize = (
      438
      41)
    object btnOk: TButton
      Left = 270
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&'#1047#1073#1077#1088#1077#1075#1090#1080
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnSaveClick
      ExplicitLeft = 266
    end
    object btnCancel: TButton
      Left = 351
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1042#1110#1076#1084#1110#1085#1072
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 347
    end
  end
end
