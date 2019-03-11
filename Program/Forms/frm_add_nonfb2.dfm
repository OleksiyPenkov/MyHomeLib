object frmAddnonfb2: TfrmAddnonfb2
  Left = 0
  Top = 0
  HelpContext = 129
  ActiveControl = pcPages
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1082#1085#1080#1075' '#1074' '#1082#1086#1083#1083#1077#1082#1094#1080#1102
  ClientHeight = 532
  ClientWidth = 752
  Color = clBtnFace
  Constraints.MinHeight = 565
  Constraints.MinWidth = 760
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    752
    532)
  PixelsPerInch = 96
  TextHeight = 13
  object pcPages: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 746
    Height = 490
    Margins.Bottom = 39
    ActivePage = tsFiles
    Align = alClient
    TabOrder = 0
    object tsFiles: TTabSheet
      Caption = #1060#1072#1081#1083#1099
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Tree: TVirtualStringTree
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 732
        Height = 365
        Align = alClient
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
        PopupMenu = pmMain
        TabOrder = 0
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnChange = TreeChange
        OnDblClick = TreeDblClick
        OnFreeNode = TreeFreeNode
        OnGetText = TreeGetText
        OnPaintText = TreePaintText
        Columns = <
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus]
            Position = 0
            Width = 500
            WideText = #1060#1072#1081#1083
          end
          item
            Position = 1
            Width = 60
            WideText = #1058#1080#1087
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus]
            Position = 2
            Width = 100
            WideText = #1056#1072#1079#1084#1077#1088
          end>
      end
      object gbOptions: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 374
        Width = 732
        Height = 85
        Align = alBottom
        Caption = #1054#1087#1094#1080#1080
        TabOrder = 1
        object Label1: TLabel
          Left = 219
          Top = 40
          Width = 126
          Height = 13
          Caption = #1055#1086#1089#1083#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1082#1085#1080#1075#1080
        end
        object cbAutoSeries: TCheckBox
          Left = 8
          Top = 62
          Width = 169
          Height = 17
          Caption = #1059#1074#1077#1083#1080#1095#1080#1074#1072#1090#1100' '#1085#1086#1084#1077#1088' '#1074' '#1089#1077#1088#1080#1080
          TabOrder = 2
        end
        object cbSelectFileName: TCheckBox
          Left = 8
          Top = 16
          Width = 145
          Height = 17
          Caption = #1042#1099#1076#1077#1083#1103#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1077
          TabOrder = 0
        end
        object cbNoAuthorAllowed: TCheckBox
          Left = 8
          Top = 39
          Width = 145
          Height = 17
          Caption = #1044#1086#1073#1072#1074#1083#1103#1090#1100' '#1073#1077#1079' '#1072#1074#1090#1086#1088#1072
          TabOrder = 1
        end
        object cbClearOptions: TComboBox
          Left = 355
          Top = 37
          Width = 190
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 3
          Text = #1054#1095#1080#1097#1072#1090#1100' '#1074#1089#1077' '#1087#1086#1083#1103
          Items.Strings = (
            #1054#1095#1080#1097#1072#1090#1100' '#1074#1089#1077' '#1087#1086#1083#1103
            #1054#1095#1080#1097#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1072#1074#1090#1086#1088#1086#1074
            #1054#1095#1080#1097#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1087#1086#1083#1077' '#1085#1072#1079#1074#1072#1085#1080#1103
            #1053#1077' '#1086#1095#1080#1097#1072#1090#1100' '#1087#1086#1083#1103)
        end
        object cbForceConvertToFBD: TCheckBox
          Left = 219
          Top = 19
          Width = 135
          Height = 14
          Caption = #1050#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074' FBD'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
      end
    end
    object tsBookInfo: TTabSheet
      Caption = #1050#1085#1080#1075#1072
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label2: TLabel
        Left = 8
        Top = 17
        Width = 30
        Height = 13
        Caption = #1060#1072#1081#1083':'
      end
      object Label3: TLabel
        Left = 8
        Top = 75
        Width = 52
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
      end
      object gbExtraInfo: TGroupBox
        Left = 3
        Top = 350
        Width = 578
        Height = 108
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' &'#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
        TabOrder = 0
        object lblGenre: TLabel
          Left = 103
          Top = 24
          Width = 353
          Height = 16
          AutoSize = False
          Caption = '-------'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 7
          Top = 24
          Width = 40
          Height = 13
          Caption = '&'#1046#1072#1085#1088#1099':'
          FocusControl = lblGenre
        end
        object Label4: TLabel
          Left = 7
          Top = 53
          Width = 35
          Height = 13
          Caption = #1057'&'#1077#1088#1080#1103':'
          FocusControl = lblGenre
        end
        object Label5: TLabel
          Left = 440
          Top = 53
          Width = 76
          Height = 13
          Caption = #1053#1086'&'#1084#1077#1088' '#1074' '#1089#1077#1088#1080#1080':'
          FocusControl = edSN
        end
        object Label7: TLabel
          Left = 7
          Top = 80
          Width = 90
          Height = 13
          Caption = '&'#1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072':'
          FocusControl = edKeyWords
        end
        object Label8: TLabel
          Left = 440
          Top = 80
          Width = 30
          Height = 13
          Caption = '&'#1071#1079#1099#1082':'
          FocusControl = cbLang
        end
        object btnShowGenres: TButton
          Left = 496
          Top = 19
          Width = 75
          Height = 25
          Caption = '&'#1042#1099#1073#1088#1072#1090#1100
          TabOrder = 0
          OnClick = btnShowGenresClick
        end
        object cbSeries: TComboBox
          Left = 103
          Top = 50
          Width = 314
          Height = 21
          TabOrder = 1
        end
        object edSN: TEdit
          Left = 522
          Top = 50
          Width = 49
          Height = 21
          Alignment = taRightJustify
          MaxLength = 3
          NumbersOnly = True
          TabOrder = 2
        end
        object edKeyWords: TEdit
          Left = 103
          Top = 77
          Width = 314
          Height = 21
          TabOrder = 3
        end
        object cbLang: TComboBox
          Left = 522
          Top = 77
          Width = 49
          Height = 21
          Style = csDropDownList
          TabOrder = 4
          Items.Strings = (
            'be'
            'bg'
            'bo'
            'br'
            'cs'
            'cz'
            'da'
            'de'
            'en'
            'eo'
            'es'
            'fr'
            'is'
            'it'
            'ja'
            'la'
            'lt'
            'lv'
            'pl'
            'pt'
            'ro'
            'ru'
            'sp'
            'sr'
            'sv'
            'th'
            'tr'
            'ua'
            'uk'
            'zh'
            #1082
            #1088#1091)
        end
      end
      object btnNext: TBitBtn
        AlignWithMargins = True
        Left = 587
        Top = 419
        Width = 144
        Height = 39
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000FF00FF000875
          0D0010A61D0013AA220016AD260017AF2A001AB12D001CB4310020B8360021B8
          390025BD3E0026BE41002AC147002CC349002FC74F0030C9520035CE590038D1
          5E003AD260003CD462003ED766003FD8680041DA6D0045DD710049E279004DE6
          7F000E7FA9000E80AA001385AF000682B600078DBB002692BF000C92C000089C
          CE00129FCB000DA2D40011A7D20020A1CA0035A7CD0030BCDD0044BADD0023D7
          FE0036D8FD004AC5DD0049C1E30049D5EE0063DAF50059EAFE006CE0F8006FE6
          FF006FF8FF0072F9FE007AFEFF0092CEE4008DE7FA0082F8FF008CFBFE0091FC
          FE0097FEFF009BFBFC00BAEEF600A0FCFE00A8FFFF00ADFFFF00B6F6FF00B3FC
          FE00B4FFFF00C6F5FF00C7FFFF00D3FFFF00E3FAFF00E4FFFF00E9F9FD00F1FB
          FD00F4FFFF00FCFFFF0000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000101010100000000001B1B1B1B1B1B0001030201000000001E2D292A31
          36281B010603010000001E382F292A31010101010A07010101011E382F292A31
          0113100F0D0B0A0605011E382F292A3101161611100D0C0A08011E4140434648
          010101011513010101011E3C27242225261F35011716010000001E2B2F292A31
          362C1D011919010000001E382F292A31362C21010101010000001E382F292A31
          362C211A0000000000001E382F292A31362C211B0000000000001E3937323439
          3D2E231B0000000000001E4B4A4541413F3F321B00000000000000204A46443F
          3D3B1C0000000000000000001E1E1E1E1E1E0000000000000000}
        TabOrder = 1
        OnClick = btnNextClick
      end
      object gbFDBCover: TGroupBox
        Left = 3
        Top = 99
        Width = 174
        Height = 245
        Caption = #1054#1073#1083#1086#1078#1082#1072
        TabOrder = 2
        DesignSize = (
          174
          245)
        object FCover: TImage
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 164
          Height = 187
          Hint = #1054#1073#1083#1086#1078#1082#1072
          Align = alTop
          Center = True
          ParentShowHint = False
          Proportional = True
          ShowHint = True
          Stretch = True
        end
        object btnPasteCover: TButton
          Left = 90
          Top = 214
          Width = 79
          Height = 26
          Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1077#1088#1072
          Anchors = [akLeft, akBottom]
          Caption = #1048#1079' '#1073#1091#1092#1077#1088#1072
          ImageIndex = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnPasteCoverClick
        end
        object btnLoad: TButton
          Left = 4
          Top = 214
          Width = 80
          Height = 26
          Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
          Anchors = [akLeft, akBottom]
          Caption = #1048#1079' '#1092#1072#1081#1083#1072
          ImageIndex = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btnLoadClick
        end
      end
      object btnCopyToFamily: TButton
        Tag = 555
        Left = 109
        Top = 41
        Width = 65
        Height = 25
        Caption = #1060#1072#1084#1080#1083#1080#1103
        TabOrder = 3
        TabStop = False
        OnClick = btnCopyToFamilyClick
      end
      object btnCopyToName: TButton
        Tag = 666
        Left = 180
        Top = 41
        Width = 65
        Height = 25
        Caption = #1048#1084#1103
        TabOrder = 4
        TabStop = False
        OnClick = btnCopyToNameClick
      end
      object btnCopyToSeries: TButton
        Left = 322
        Top = 41
        Width = 65
        Height = 25
        Caption = #1057#1077#1088#1080#1103
        TabOrder = 5
        TabStop = False
        OnClick = btnCopyToSeriesClick
      end
      object btnCopyToTitle: TButton
        Left = 251
        Top = 41
        Width = 65
        Height = 25
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        TabOrder = 6
        TabStop = False
        OnClick = btnCopyToTitleClick
      end
      object btnOpenBook: TBitBtn
        Left = 557
        Top = 12
        Width = 75
        Height = 25
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1082#1085#1080#1075#1091
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = btnFileOpenClick
      end
      object btnRenameFile: TBitBtn
        Left = 638
        Top = 12
        Width = 90
        Height = 25
        Hint = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1092#1072#1081#1083
        Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = miRenameFileClick
      end
      object edFileName: TEdit
        Left = 67
        Top = 14
        Width = 484
        Height = 21
        TabStop = False
        PopupMenu = pmEdit
        ReadOnly = True
        TabOrder = 9
      end
      object edTitle: TEdit
        Left = 66
        Top = 72
        Width = 669
        Height = 21
        TabOrder = 10
      end
      object MHLSimplePanel1: TMHLSimplePanel
        Left = 183
        Top = 99
        Width = 552
        Height = 245
        TabOrder = 11
        object PageControl1: TPageControl
          Left = 0
          Top = 0
          Width = 552
          Height = 245
          ActivePage = TabSheet1
          Align = alClient
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = #1040#1074#1090#1086#1088#1099' '#1082#1085#1080#1075#1080
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object alBookAuthors: TFBDAuthorTable
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 538
              Height = 211
              Align = alClient
              TabOrder = 0
              DesignSize = (
                538
                211)
            end
          end
          object TabSheet2: TTabSheet
            Caption = #1040#1074#1090#1086#1088#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object alFBDAuthors: TFBDAuthorTable
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 538
              Height = 211
              Align = alClient
              TabOrder = 0
              DesignSize = (
                538
                211)
            end
          end
          object TabSheet3: TTabSheet
            Caption = #1040#1085#1085#1086#1090#1072#1094#1080#1103
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object mmAnnotation: TMemo
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 538
              Height = 211
              Align = alClient
              ScrollBars = ssBoth
              TabOrder = 0
              WordWrap = False
            end
          end
          object TabSheet4: TTabSheet
            Caption = #1048#1079#1076#1072#1090#1077#1083#1100
            ImageIndex = 3
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            DesignSize = (
              544
              217)
            object RzLabel4: TLabel
              Left = 33
              Top = 46
              Width = 27
              Height = 13
              Caption = 'ISBN:'
              FocusControl = edISBN
            end
            object RzLabel6: TLabel
              Left = 308
              Top = 19
              Width = 35
              Height = 13
              Anchors = [akTop, akRight]
              Caption = #1043#1086#1088#1086#1076':'
              FocusControl = edCity
              ExplicitLeft = 122
            end
            object RzLabel7: TLabel
              Left = 392
              Top = 46
              Width = 23
              Height = 13
              Anchors = [akTop, akRight]
              Caption = #1043#1086#1076':'
              FocusControl = edYear
              ExplicitLeft = 206
            end
            object RzLabel5: TLabel
              Left = 8
              Top = 19
              Width = 52
              Height = 13
              Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
              FocusControl = edPublisher
            end
            object edISBN: TEdit
              Left = 66
              Top = 43
              Width = 320
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
            object edPublisher: TEdit
              Left = 66
              Top = 16
              Width = 236
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edYear: TEdit
              Left = 421
              Top = 43
              Width = 60
              Height = 21
              Anchors = [akTop, akRight]
              TabOrder = 2
            end
            object edCity: TEdit
              Left = 349
              Top = 16
              Width = 132
              Height = 21
              Anchors = [akTop, akRight]
              TabOrder = 3
            end
          end
        end
      end
    end
  end
  object btnClose: TBitBtn
    Left = 664
    Top = 498
    Width = 80
    Height = 26
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 1
  end
  object pmEdit: TPopupMenu
    Left = 640
    Top = 216
    object N1: TMenuItem
      Caption = #1060#1072#1084#1080#1083#1080#1103
      ShortCut = 16465
      OnClick = btnCopyToFamilyClick
    end
    object N2: TMenuItem
      Caption = #1048#1084#1103
      ShortCut = 16449
      OnClick = btnCopyToNameClick
    end
    object N3: TMenuItem
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      ShortCut = 16474
      OnClick = btnCopyToTitleClick
    end
    object N4: TMenuItem
      Caption = #1057#1077#1088#1080#1103
      ShortCut = 16472
      OnClick = btnCopyToSeriesClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object miClearAll: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077
      ShortCut = 16474
      OnClick = miClearAllClick
    end
  end
  object flFiles: TFilesList
    OnDirectory = flFilesDirectory
    OnFile = flFilesFile
    Left = 640
    Top = 168
  end
  object pmMain: TPopupMenu
    Left = 640
    Top = 120
    object miOpenFile: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100
      ShortCut = 16397
      OnClick = btnFileOpenClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object miOpenExplorer: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1072#1087#1082#1091' '#1074' '#1087#1088#1086#1074#1086#1076#1085#1080#1082#1077
      ShortCut = 16453
      OnClick = miOpenExplorerClick
    end
  end
  object FBD: TFBDDocument
    Memo = mmAnnotation
    Image = FCover
    Left = 640
    Top = 72
  end
end
