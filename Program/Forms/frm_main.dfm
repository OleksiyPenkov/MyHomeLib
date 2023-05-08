object frmMain: TfrmMain
  Left = 0
  Top = 0
  HelpContext = 2
  Caption = 'MyHomeLib'
  ClientHeight = 772
  ClientWidth = 792
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000000000000000000000000000000000000000007F7F
    7F0100000002000000040000001436363672525252C7464545D8434242DB4342
    41DB424141D8494848CF646464BE3636366E0000001300000004151515020000
    000F000000160000001A000000213D3D3D6EA7A6A5DAC6C2BFFFBCB8B5FFBCB8
    B5FFC1BEBBFF969493DC797979A83D3D3D660000001F000000160000000F0000
    003A000000520000005B0000005E0000006C7B7B7AC1C1BEBAFFBEBBB7FFBEBB
    B7FFC3C0BCFF7B7B7BC20000006F000000610000005C000000520000003A6C6B
    6AABCECCC9FFCDCCC9FFCDCBC9FFCDCBC9FFCCCAC8FF9B9894FF928F8AFF928F
    8AFF9B9893FFCCCAC7FFCDCBC8FFCDCBC8FFCDCBC8FFCCCBC8FF666564AB5352
    50B1D1CECBFFCDCAC8FFCAC7C5FFC8C5C3FFC8C5C3FFC8C5C3FFC8C5C3FFC8C5
    C3FFC8C5C3FFC8C4C2FFC6C3C0FFC3C0BDFFBFBDB9FFBCB9B5FF4B4947B15553
    52B2B7B8BDFFA6AAB1FFA2A7ADFFA0A4ABFF9EA3AAFF9EA3AAFF9EA3AAFF9EA3
    AAFF9EA3AAFF9EA3AAFF9DA1A8FF9A9EA4FF95999FFF9A9B9EFF494745B25856
    55B2416489FF2B62DAFF666A8AFFA9947BFF6D626FFF5A5DD6FF282BAEFF3F82
    6FFF347037FF67AABDFF609FBEFF978A7AFF978470FF475E6DFF4B4947B25B58
    58B2446C93FF3475F4FF7F7591FFD7AB80FF846A70FF7676F3FF3838C7FF4893
    76FF3A7E34FF7DBECCFF75B1CCFFBF9D7DFFBC9571FF4D6673FF4C4A48B25D5B
    5AB2446C93FF3475F4FF8A7086FFEBA26BFF906462FF8786F4FF4242C8FF4893
    76FF3A7E35FF88C7D3FF7CB9D3FFD0956CFFCD8C5DFF506572FF4D4B4AB25E5C
    5BB2456D93FF3777F4FF897086FFEBA26BFF916662FF8887F5FF4848C9FF4993
    77FF3A7E35FF88C7D3FF7CB9D4FFD0956CFFCE8C5DFF516672FF4E4C4AB25F5D
    5DB2476E92FF3E7CF4FF8A7188FFEBA570FF936863FF9493F6FF5252CAFF5398
    7FFF3E8038FF84C3D0FF7BB6D0FFD29870FFCE8D5FFF526673FF4E4C4BB2605E
    5EB24A7493FF509DF4FF8F808AFFECA774FF956963FF9898F6FF5B5ACBFF599B
    85FF40813AFF81C1CEFF77B3CEFFD19A74FFCE8E60FF516673FF4E4C4BB2615E
    5EB24B7494FF4F9CF7FF798DA5FFC2BDA3FF807C83FF9696F8FF5B5ACDFF5F9D
    89FF42823BFF7DBECCFF75B1CCFFD29C78FFCE8F61FF516673FF4E4C4BB2615F
    5FB2456A89FF3668BBFF717C94FFC3BEA5FF7B7A7AFF6B79BEFF4E5CA4FF62A0
    86FF417F3DFF85C2CDFF78B3CDFFAEAE9EFFA8A38DFF4D6979FF4E4C4BB2615F
    5FAC3C5D76FF1C4A65FF37495EFF555862FF364254FF1B4662FF1C4A65FF1A42
    60FF19405FFF19405FFF19405FFF4D5562FF4C505BFF3F5A71FF4E4D4BAC6765
    659FA1A4ACFF8E94A0FF8E94A0FF8E94A0FF8E949FFF8D939FFF8D939EFF8C92
    9DFF8A919BFF888F99FF858C97FF838A94FF808791FF8F939AFF5452519F0000
    AC410000AC410000AC410000AC410000AC410000AC410000AC410000AC410000
    AC410000AC410000AC410000AC410000AC410000AC410000AC410000AC41}
  Menu = MainMenu
  Position = poDesigned
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object tlbrMain: TToolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 40
    HelpContext = 146
    ButtonHeight = 40
    ButtonWidth = 41
    Caption = 'tlbrMain'
    DisabledImages = ilToolBar_Disabled
    Images = ilToolBar
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Wrapable = False
    ExplicitWidth = 788
    object tbtnRead: TToolButton
      Left = 0
      Top = 0
      Action = acBookRead
      ImageIndex = 0
    end
    object tbtnDownloadList_Add: TToolButton
      Left = 41
      Top = 0
      Action = acBookAdd2DownloadList
      ImageIndex = 2
    end
    object tbSendToDevice: TToolButton
      Tag = 900
      Left = 82
      Top = 0
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1085#1072' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
      Caption = 'tbSendToDevice'
      DropdownMenu = pmScripts
      ImageIndex = 1
      Style = tbsDropDown
      OnClick = SendToDeviceExecute
    end
    object ToolButton13: TToolButton
      Left = 138
      Top = 0
      Width = 8
      Caption = 'ToolButton13'
      ImageIndex = 11
      Style = tbsSeparator
    end
    object tbtnRus: TToolButton
      Left = 146
      Top = 0
      Action = acShowRusAlphabet
      ImageIndex = 3
    end
    object tbtnEng: TToolButton
      Left = 187
      Top = 0
      Action = acShowEngAlphabet
      ImageIndex = 4
    end
    object ToolButton12: TToolButton
      Left = 228
      Top = 0
      Width = 8
      Caption = 'ToolButton12'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object tbtnWizard: TToolButton
      Left = 236
      Top = 0
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1082#1086#1083#1083#1077#1082#1094#1080#1102
      DropdownMenu = pmCollection
      ImageIndex = 6
      ParentShowHint = False
      ShowHint = True
      OnClick = tbtnWizardClick
    end
    object ToolButton3: TToolButton
      Left = 277
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object BtnFav_add: TToolButton
      Left = 285
      Top = 0
      Action = acBookAdd2Favorites
      DropdownMenu = pmGroups
      ImageIndex = 15
      Style = tbsDropDown
    end
    object ToolButton7: TToolButton
      Left = 341
      Top = 0
      Width = 8
      Caption = 'ToolButton7'
      ImageIndex = 18
      Style = tbsSeparator
    end
    object tbSelectAll: TToolButton
      Left = 349
      Top = 0
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      Caption = 'tbSelectAll'
      ImageIndex = 7
      OnClick = tbSelectAllClick
    end
    object tbCollapse: TToolButton
      Left = 390
      Top = 0
      Hint = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100'/'#1057#1074#1077#1088#1085#1091#1090#1100' '#1089#1087#1080#1089#1086#1082
      Caption = 'tbCollapse'
      ImageIndex = 8
      OnClick = tbCollapseClick
    end
    object ToolButton1: TToolButton
      Left = 431
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object btnSwitchTreeMode: TToolButton
      Left = 439
      Top = 0
      Hint = #1055#1077#1088#1077#1082#1083#1102#1095#1080#1090#1100' '#1074' '#1088#1077#1078#1080#1084' "'#1058#1072#1073#1083#1080#1094#1072'"'
      Caption = 'btnSwitchTreeMode'
      ImageIndex = 10
      OnClick = btnSwitchTreeModeClick
    end
    object tbtnShowDeleted: TToolButton
      Left = 480
      Top = 0
      Action = acViewHideDeletedBooks
      ImageIndex = 12
    end
    object tbtnShowLocalOnly: TToolButton
      Left = 521
      Top = 0
      Action = acViewShowLocalOnly
      ImageIndex = 13
    end
    object tbtnShowCover: TToolButton
      Left = 562
      Top = 0
      Action = acShowBookInfoPanel
      ImageIndex = 14
    end
    object ToolButton5: TToolButton
      Left = 603
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 27
      Style = tbsSeparator
    end
    object tbtnSettings: TToolButton
      Left = 611
      Top = 0
      Action = acToolsSettings
      ImageIndex = 17
    end
    object tbtnHelp: TToolButton
      Left = 652
      Top = 0
      Action = acHelpHelp
      ImageIndex = 26
    end
  end
  object pgControl: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 65
    Width = 786
    Height = 685
    HelpContext = 1
    ActivePage = tsBySerie
    Align = alClient
    OwnerDraw = True
    TabOrder = 2
    OnChange = pgControlChange
    OnDrawTab = pgControlDrawTab
    ExplicitWidth = 782
    ExplicitHeight = 684
    object tsByAuthor: TTabSheet
      HelpContext = 135
      Caption = #1040#1074#1090#1086#1088#1099
      object AuthorsViewSplitter: TMHLSplitter
        Left = 230
        Top = 70
        Height = 587
        MinSize = 230
        ResizeControl = pnAuthorsView
        ExplicitLeft = 392
        ExplicitTop = 112
        ExplicitHeight = 100
      end
      object pnAuthorsView: TMHLSimplePanel
        Left = 0
        Top = 70
        Width = 230
        Height = 587
        Align = alLeft
        TabOrder = 2
        ExplicitHeight = 586
        object pnAuthorSearch: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 224
          Height = 26
          Align = alTop
          TabOrder = 0
          DesignSize = (
            224
            26)
          object lblAuthorsSearch: TLabel
            Left = 4
            Top = 7
            Width = 30
            Height = 13
            Caption = #1055#1086#1080#1089#1082
          end
          object tbClearEdAuthor: TSpeedButton
            Left = 201
            Top = 3
            Width = 23
            Height = 25
            Hint = #1054#1095#1080#1089#1090#1080#1090#1100
            Anchors = [akTop, akRight]
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009FBFBF007F9F
              9F005F7F7F005F7F7F005F7F7F005F7F7F00808080009F9F9F00FF00FF00BFBF
              BF00BFBFBF00BFBFBF009F9F9F009F9F9F0080808000808080007F9F9F009FBF
              BF009FBFBF009FBFBF009FBFBF007F9F9F007F9F9F0080808000BFBFBF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F9F9F009FBF
              BF009FDFDF009FDFDF009FDFDF009FDFDF009FBFBF005F7F7F009F9F9F00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BFBFBF009FBF
              BF00BFDFDF00BFDFDF009FDFDF009FDFDF009FBFBF007F9F9F0080808000BFBF
              BF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F9F
              9F00BFDFDF00BFDFDF00BFDFDF009FDFDF009FDFDF009FBFBF005F7F7F009F9F
              9F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BFBF
              BF009FBFBF00BFDFDF00BFDFDF009FDFDF009FDFDF009FBFBF007F9F9F008080
              8000BFBFBF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF007F9F9F00BFDFDF00BFDFDF00BFDFDF009FDFDF009FDFDF009FBFBF005F7F
              7F009F9F9F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00BFBFBF009FBFBF009FBFBF009FBFBF009FBFBF009FBFBF009FBFBF007F9F
              9F0080808000BFBFBF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF007F9F9F00BFDFDF00FF00FF00FF00FF00FF00FF00BFDFDF009FBF
              BF007F9F9F009F9F9F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00BFBFBF009FBFBF00FF00FF00FF00FF00FF00FF00FF00FF00BFDF
              DF009FBFBF0080808000BFBFBF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF007F9F9F00BFDFDF00FF00FF00FF00FF00FF00FF00BFDF
              DF009FBFBF007F9F9F009F9F9F00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00BFBFBF009FBFBF00FF00FF00FF00FF00FF00FF00FF00
              FF00BFDFDF009FBFBF0080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF007F9F9F00BFDFDF00FF00FF00FF00FF00FF00
              FF00BFDFDF009FBFBF0080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00BFBFBF007F9F9F007F9F9F007F9F9F007F9F
              9F007F9F9F007F9F9F009FBFBF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            ParentShowHint = False
            ShowHint = True
            OnClick = tbClearEdAuthorClick
            ExplicitLeft = 199
          end
          object edLocateAuthor: TEdit
            Left = 40
            Top = 5
            Width = 155
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            OnChange = edLocateAuthorChange
            OnKeyDown = edLocateAuthorKeyDown
          end
        end
        object tvAuthors: TVirtualStringTree
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 224
          Height = 549
          Align = alClient
          ChangeDelay = 250
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          Header.AutoSizeIndex = 0
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          IncrementalSearch = isAll
          PopupMenu = pmAuthor
          TabOrder = 1
          TreeOptions.PaintOptions = [toPopupMode, toShowDropmark, toShowHorzGridLines, toShowRoot, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect, toCenterScrollIntoView]
          OnChange = tvAuthorsChange
          OnKeyDown = tvAuthorsKeyDown
          OnMeasureTextHeight = tvAuthorsMeasureTextHeight
          Touch.InteractiveGestures = [igPan, igPressAndTap]
          Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
          Columns = <>
        end
      end
      object pnAuthorBooksView: TMHLSimplePanel
        Left = 233
        Top = 70
        Width = 545
        Height = 587
        Align = alClient
        TabOrder = 3
        ExplicitWidth = 541
        ExplicitHeight = 586
        object AuthorBookInfoSplitter: TMHLSplitter
          Left = 0
          Top = 426
          Width = 549
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          ResizeControl = ipnlAuthors
          ExplicitTop = 454
          ExplicitWidth = 545
        end
        object ipnlAuthors: TInfoPanel
          AlignWithMargins = True
          Left = 3
          Top = 432
          Width = 543
          Height = 152
          Align = alBottom
          Color = clBlack
          TabOrder = 2
          OnResize = InfoPanelResize
          ShowAnnotation = False
          InfoPriority = True
          OnAuthorLinkClicked = AuthorLinkClicked
          OnSeriesLinkClicked = SeriesLinkClicked
          OnGenreLinkClicked = GenreLinkClicked
          ExplicitTop = 431
          ExplicitWidth = 535
        end
        object pnAuthorBooksTitle: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 543
          Height = 26
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 535
          object lblBooksTotalA: TLabel
            Left = 436
            Top = 0
            Width = 107
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1085#1080#1075')'
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lblAuthor: TLabel
            Left = 0
            Top = 0
            Width = 112
            Height = 26
            Align = alLeft
            Caption = #1055#1086#1083#1085#1086#1077' '#1080#1084#1103' '#1072#1074#1090#1086#1088#1072
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lblLang: TLabel
            Left = 342
            Top = 0
            Width = 31
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = #1071#1079#1099#1082
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object cbLangSelectA: TComboBox
            AlignWithMargins = True
            Left = 376
            Top = 3
            Width = 50
            Height = 21
            Margins.Right = 10
            Align = alRight
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = '-'
            OnChange = cbLangSelectAChange
            Items.Strings = (
              '-')
          end
        end
        object tvBooksA: TBookTree
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 539
          Height = 388
          Align = alClient
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          Header.AutoSizeIndex = 0
          Header.Height = 20
          Header.MainColumn = 1
          Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoHotTrack, hoOwnerDraw, hoRestrictDrag, hoShowHint, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize]
          Header.PopupMenu = pmHeaders
          Header.Style = hsFlatButtons
          HintMode = hmTooltip
          ParentColor = True
          ParentShowHint = False
          PopupMenu = pmMain
          ShowHint = False
          TabOrder = 1
          TreeOptions.SelectionOptions = [toDisableDrawSelection, toFullRowSelect, toMultiSelect, toRightClickSelect, toSiblingSelectConstraint]
          OnChange = tvBooksTreeChange
          OnDblClick = ReadBookExecute
          OnHeaderClick = tvBooksTreeHeaderClick
          OnKeyDown = tvBooksTreeKeyDown
          OnMouseUp = tvBooksTreeMouseUp
          Columns = <
            item
              BiDiMode = bdLeftToRight
              Hint = 
                'Text is initially centered and has a left-to-right directionalit' +
                'y.'
              MaxWidth = 1000
              MinWidth = 40
              Options = [coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 0
              Spacing = 10
              Text = #1053#1072#1079#1074#1072#1085#1080#1077
              Width = 267
            end
            item
              Alignment = taCenter
              BiDiMode = bdLeftToRight
              Hint = 
                'Text is initially left aligned and has a left-to-right direction' +
                'ality.'
              MaxWidth = 80
              MinWidth = 35
              Options = [coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 1
              Spacing = 10
              Text = #8470
              Width = 40
            end
            item
              Alignment = taCenter
              BiDiMode = bdRightToLeft
              Hint = 
                'Text is initially left aligned and has a right-to-left direction' +
                'ality.'
              MaxWidth = 200
              MinWidth = 65
              Options = [coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 2
              Spacing = 10
              Text = #1056#1072#1079#1084#1077#1088
              Width = 65
            end
            item
              Alignment = taCenter
              BiDiMode = bdLeftToRight
              MaxWidth = 60
              MinWidth = 60
              Options = [coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 3
              Text = #1056#1077#1081#1090#1080#1085#1075
              Width = 60
            end
            item
              BiDiMode = bdLeftToRight
              MinWidth = 40
              Options = [coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 4
              Text = #1046#1072#1085#1088
              Width = 205
            end>
        end
      end
      object tbarAuthorsRus: TToolBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 772
        Height = 29
        AutoSize = True
        Caption = 'tbarAuthorsRus'
        Color = clMenuBar
        HotImages = ilAlphabetActive
        Images = ilAlphabetNormal
        ParentColor = False
        TabOrder = 0
        Wrapable = False
        ExplicitWidth = 768
      end
      object tbarAuthorsEng: TToolBar
        AlignWithMargins = True
        Left = 3
        Top = 38
        Width = 772
        Height = 29
        AutoSize = True
        Caption = 'tbarAuthorFilter1'
        Color = clMenuBar
        HotImages = ilAlphabetActive
        Images = ilAlphabetNormal
        ParentColor = False
        TabOrder = 1
        Wrapable = False
        ExplicitWidth = 768
      end
    end
    object tsBySerie: TTabSheet
      HelpContext = 135
      Caption = #1057#1077#1088#1080#1080
      object SeriesViewSplitter: TMHLSplitter
        Left = 230
        Top = 70
        Height = 587
        MinSize = 230
        ResizeControl = pnSeriesView
        ExplicitLeft = 392
        ExplicitTop = 144
        ExplicitHeight = 100
      end
      object pnSeriesView: TMHLSimplePanel
        Left = 0
        Top = 70
        Width = 230
        Height = 587
        Align = alLeft
        TabOrder = 0
        ExplicitHeight = 586
        object tvSeries: TVirtualStringTree
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 224
          Height = 549
          Align = alClient
          ChangeDelay = 250
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.AutoSizeIndex = 0
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          IncrementalSearch = isAll
          ParentFont = False
          PopupMenu = pmAuthor
          TabOrder = 1
          TreeOptions.PaintOptions = [toPopupMode, toShowDropmark, toShowHorzGridLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
          OnChange = tvSeriesChange
          OnKeyDown = tvSeriesKeyDown
          Touch.InteractiveGestures = [igPan, igPressAndTap]
          Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
          Columns = <>
        end
        object pnSerieSearch: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 224
          Height = 26
          Align = alTop
          TabOrder = 0
          DesignSize = (
            224
            26)
          object lblSerieSearch: TLabel
            Left = 4
            Top = 7
            Width = 30
            Height = 13
            Caption = #1055#1086#1080#1089#1082
          end
          object btnClearEdSeries: TSpeedButton
            Left = 201
            Top = 3
            Width = 23
            Height = 25
            Hint = #1054#1095#1080#1089#1090#1080#1090#1100
            Anchors = [akTop, akRight]
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009FBFBF007F9F
              9F005F7F7F005F7F7F005F7F7F005F7F7F00808080009F9F9F00FF00FF00BFBF
              BF00BFBFBF00BFBFBF009F9F9F009F9F9F0080808000808080007F9F9F009FBF
              BF009FBFBF009FBFBF009FBFBF007F9F9F007F9F9F0080808000BFBFBF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F9F9F009FBF
              BF009FDFDF009FDFDF009FDFDF009FDFDF009FBFBF005F7F7F009F9F9F00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BFBFBF009FBF
              BF00BFDFDF00BFDFDF009FDFDF009FDFDF009FBFBF007F9F9F0080808000BFBF
              BF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F9F
              9F00BFDFDF00BFDFDF00BFDFDF009FDFDF009FDFDF009FBFBF005F7F7F009F9F
              9F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BFBF
              BF009FBFBF00BFDFDF00BFDFDF009FDFDF009FDFDF009FBFBF007F9F9F008080
              8000BFBFBF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF007F9F9F00BFDFDF00BFDFDF00BFDFDF009FDFDF009FDFDF009FBFBF005F7F
              7F009F9F9F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00BFBFBF009FBFBF009FBFBF009FBFBF009FBFBF009FBFBF009FBFBF007F9F
              9F0080808000BFBFBF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF007F9F9F00BFDFDF00FF00FF00FF00FF00FF00FF00BFDFDF009FBF
              BF007F9F9F009F9F9F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00BFBFBF009FBFBF00FF00FF00FF00FF00FF00FF00FF00FF00BFDF
              DF009FBFBF0080808000BFBFBF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF007F9F9F00BFDFDF00FF00FF00FF00FF00FF00FF00BFDF
              DF009FBFBF007F9F9F009F9F9F00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00BFBFBF009FBFBF00FF00FF00FF00FF00FF00FF00FF00
              FF00BFDFDF009FBFBF0080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF007F9F9F00BFDFDF00FF00FF00FF00FF00FF00
              FF00BFDFDF009FBFBF0080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00BFBFBF007F9F9F007F9F9F007F9F9F007F9F
              9F007F9F9F007F9F9F009FBFBF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnClearEdSeriesClick
          end
          object edLocateSeries: TEdit
            Left = 40
            Top = 4
            Width = 154
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            OnChange = edLocateSeriesChange
            OnKeyDown = edLocateAuthorKeyDown
          end
        end
      end
      object pnSerieBooksView: TMHLSimplePanel
        Left = 233
        Top = 70
        Width = 545
        Height = 587
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 541
        ExplicitHeight = 586
        object SerieBookInfoSplitter: TMHLSplitter
          Left = 0
          Top = 428
          Width = 545
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          ResizeControl = ipnlSeries
          ExplicitTop = 225
        end
        object ipnlSeries: TInfoPanel
          AlignWithMargins = True
          Left = 3
          Top = 434
          Width = 539
          Height = 150
          Align = alBottom
          Color = clBlack
          TabOrder = 2
          OnResize = InfoPanelResize
          OnAuthorLinkClicked = AuthorLinkClicked
          OnSeriesLinkClicked = SeriesLinkClicked
          OnGenreLinkClicked = GenreLinkClicked
          ExplicitTop = 433
          ExplicitWidth = 535
        end
        object pnSerieBooksTitle: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 539
          Height = 26
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 535
          object lblBooksTotalS: TLabel
            Left = 432
            Top = 0
            Width = 107
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1085#1080#1075')'
            Layout = tlCenter
            ExplicitLeft = 436
            ExplicitHeight = 13
          end
          object lblSeries: TLabel
            Left = 0
            Top = 0
            Width = 90
            Height = 26
            Align = alLeft
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1077#1088#1080#1080
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lbl1: TLabel
            Left = 338
            Top = 0
            Width = 31
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = #1071#1079#1099#1082
            Layout = tlCenter
            ExplicitLeft = 342
            ExplicitHeight = 13
          end
          object cbLangSelectS: TComboBox
            Tag = 1
            AlignWithMargins = True
            Left = 372
            Top = 3
            Width = 50
            Height = 21
            Margins.Right = 10
            Align = alRight
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = '-'
            OnChange = cbLangSelectAChange
            Items.Strings = (
              '-')
            ExplicitLeft = 368
          end
        end
        object tvBooksS: TBookTree
          Tag = 1
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 539
          Height = 390
          Align = alClient
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          Header.AutoSizeIndex = 0
          Header.Height = 35
          Header.Options = [hoColumnResize, hoDrag, hoHotTrack, hoOwnerDraw, hoRestrictDrag, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
          Header.PopupMenu = pmHeaders
          Header.Style = hsFlatButtons
          HintMode = hmTooltip
          ParentShowHint = False
          PopupMenu = pmMain
          ShowHint = False
          TabOrder = 1
          OnChange = tvBooksTreeChange
          OnDblClick = ReadBookExecute
          OnHeaderClick = tvBooksTreeHeaderClick
          OnKeyDown = tvBooksTreeKeyDown
          OnMouseUp = tvBooksTreeMouseUp
          Columns = <
            item
              MinWidth = 30
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 0
              Text = #1040#1074#1090#1086#1088
              Width = 131
            end
            item
              Hint = 
                'Text is initially centered and has a left-to-right directionalit' +
                'y.'
              MinWidth = 30
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 1
              Spacing = 10
              Text = #1053#1072#1079#1074#1072#1085#1080#1077
              Width = 181
            end
            item
              Alignment = taCenter
              Hint = 
                'Text is initially left aligned and has a left-to-right direction' +
                'ality.'
              MaxWidth = 90
              MinWidth = 30
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 2
              Spacing = 10
              Text = #8470
              Width = 30
            end
            item
              Alignment = taCenter
              Hint = 
                'Text is initially left aligned and has a right-to-left direction' +
                'ality.'
              MaxWidth = 100
              MinWidth = 65
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 3
              Spacing = 10
              Text = #1056#1072#1079#1084#1077#1088
              Width = 65
            end
            item
              Alignment = taCenter
              MaxWidth = 100
              MinWidth = 65
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 4
              Text = #1056#1077#1081#1090#1080#1085#1075
              Width = 65
            end
            item
              Position = 5
              Text = #1046#1072#1085#1088
              Width = 120
            end
            item
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus]
              Position = 6
              Text = #1044#1086#1073#1072#1074#1083#1077#1085#1086
              Width = 56
            end>
        end
      end
      object tbarSeriesEng: TToolBar
        AlignWithMargins = True
        Left = 3
        Top = 38
        Width = 772
        Height = 29
        AutoSize = True
        Caption = 'tbarAuthorFilter1'
        HotImages = ilAlphabetActive
        Images = ilAlphabetNormal
        TabOrder = 2
        Wrapable = False
        ExplicitWidth = 768
      end
      object tbarSeriesRus: TToolBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 772
        Height = 29
        AutoSize = True
        Caption = 'tbarAuthorFilter1'
        HotImages = ilAlphabetActive
        Images = ilAlphabetNormal
        TabOrder = 3
        Wrapable = False
        ExplicitWidth = 768
      end
    end
    object tsByGenre: TTabSheet
      HelpContext = 135
      Caption = #1046#1072#1085#1088#1099
      object GenresViewSplitter: TMHLSplitter
        Left = 230
        Top = 0
        Height = 657
        MinSize = 230
        ResizeControl = pnGenresView
        ExplicitLeft = 392
        ExplicitTop = 144
        ExplicitHeight = 100
      end
      object pnGenresView: TMHLSimplePanel
        Left = 0
        Top = 0
        Width = 230
        Height = 657
        Align = alLeft
        TabOrder = 0
        object tvGenres: TVirtualStringTree
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 224
          Height = 651
          Align = alClient
          ChangeDelay = 250
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          Header.AutoSizeIndex = 0
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          IncrementalSearch = isAll
          PopupMenu = pmAuthor
          TabOrder = 0
          TreeOptions.PaintOptions = [toPopupMode, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
          OnChange = tvGenresChange
          OnKeyDown = tvGenresKeyDown
          Touch.InteractiveGestures = [igPan, igPressAndTap]
          Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
          Columns = <>
        end
      end
      object pnGenreBooksView: TMHLSimplePanel
        Left = 233
        Top = 0
        Width = 549
        Height = 657
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 545
        object GenreBookInfoSplitter: TMHLSplitter
          Left = 0
          Top = 548
          Width = 549
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          ResizeControl = ipnlGenres
          ExplicitTop = 31
          ExplicitWidth = 250
        end
        object pnGenreBooksTitle: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 543
          Height = 26
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 539
          object lblBooksTotalG: TLabel
            Left = 436
            Top = 0
            Width = 107
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1085#1080#1075')'
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lblGenreTitle: TLabel
            Left = 0
            Top = 0
            Width = 97
            Height = 26
            Align = alLeft
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1078#1072#1085#1088#1072
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lbl2: TLabel
            Left = 342
            Top = 0
            Width = 31
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = #1071#1079#1099#1082
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object cbLangSelectG: TComboBox
            Tag = 2
            AlignWithMargins = True
            Left = 376
            Top = 3
            Width = 50
            Height = 21
            Margins.Right = 10
            Align = alRight
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = '-'
            OnChange = cbLangSelectAChange
            Items.Strings = (
              '-')
          end
        end
        object ipnlGenres: TInfoPanel
          AlignWithMargins = True
          Left = 3
          Top = 554
          Width = 539
          Height = 100
          Align = alBottom
          Color = clBlack
          TabOrder = 2
          OnResize = InfoPanelResize
          OnAuthorLinkClicked = AuthorLinkClicked
          OnSeriesLinkClicked = SeriesLinkClicked
          OnGenreLinkClicked = GenreLinkClicked
        end
        object tvBooksG: TBookTree
          Tag = 2
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 539
          Height = 510
          Align = alClient
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          Header.AutoSizeIndex = 0
          Header.Height = 20
          Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoHotTrack, hoOwnerDraw, hoRestrictDrag, hoShowHint, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize]
          Header.PopupMenu = pmHeaders
          Header.Style = hsFlatButtons
          HintMode = hmTooltip
          ParentShowHint = False
          PopupMenu = pmMain
          ShowHint = False
          TabOrder = 1
          OnChange = tvBooksTreeChange
          OnDblClick = ReadBookExecute
          OnHeaderClick = tvBooksTreeHeaderClick
          OnKeyDown = tvBooksTreeKeyDown
          OnMouseUp = tvBooksTreeMouseUp
          Columns = <
            item
              BiDiMode = bdLeftToRight
              Hint = 
                'Text is initially centered and has a left-to-right directionalit' +
                'y.'
              MinWidth = 30
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 0
              Spacing = 10
              Text = #1040#1074#1090#1086#1088'/'#1057#1077#1088#1080#1103'/'#1053#1072#1079#1074#1072#1085#1080#1077
              Width = 244
            end
            item
              Alignment = taCenter
              BiDiMode = bdLeftToRight
              Hint = 
                'Text is initially left aligned and has a left-to-right direction' +
                'ality.'
              MaxWidth = 90
              MinWidth = 30
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coShowDropMark, coVisible, coAutoSpring]
              Position = 1
              Spacing = 10
              Text = #8470
              Width = 30
            end
            item
              Alignment = taCenter
              BiDiMode = bdRightToLeft
              Hint = 
                'Text is initially left aligned and has a right-to-left direction' +
                'ality.'
              MaxWidth = 100
              MinWidth = 65
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 2
              Spacing = 10
              Text = #1056#1072#1079#1084#1077#1088
              Width = 65
            end
            item
              Alignment = taCenter
              BiDiMode = bdLeftToRight
              MaxWidth = 65
              MinWidth = 65
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 3
              Text = #1056#1077#1081#1090#1080#1085#1075
              Width = 65
            end
            item
              BiDiMode = bdLeftToRight
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 4
              Width = 139
            end>
        end
      end
    end
    object tsSearch: TTabSheet
      HelpContext = 126
      Caption = #1055#1086#1080#1089#1082
      object SearchViewSplitter: TMHLSplitter
        Left = 230
        Top = 0
        Height = 657
        MinSize = 230
        ResizeControl = pnSearchView
        ExplicitLeft = 185
        ExplicitTop = 3
        ExplicitHeight = 387
      end
      object pnSearchBooksView: TMHLSimplePanel
        Left = 233
        Top = 0
        Width = 549
        Height = 657
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 545
        object SearchBookInfoSplitter: TMHLSplitter
          Left = 0
          Top = 498
          Width = 545
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          ResizeControl = ipnlSearch
          ExplicitLeft = 2
          ExplicitTop = 46
          ExplicitWidth = 227
        end
        object ipnlSearch: TInfoPanel
          AlignWithMargins = True
          Left = 3
          Top = 504
          Width = 539
          Height = 150
          Align = alBottom
          Color = clBlack
          TabOrder = 2
          OnResize = InfoPanelResize
          OnAuthorLinkClicked = AuthorLinkClicked
          OnSeriesLinkClicked = SeriesLinkClicked
          OnGenreLinkClicked = GenreLinkClicked
        end
        object pnlFullSearch: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 539
          Height = 26
          Align = alTop
          TabOrder = 0
          object Label1: TLabel
            Left = 0
            Top = 5
            Width = 36
            Height = 13
            Caption = #1055#1088#1077#1089#1077#1090
          end
          object lblTotalBooksFL: TLabel
            Left = 432
            Top = 0
            Width = 107
            Height = 13
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1085#1080#1075')'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object cbPresetName: TComboBox
            Left = 42
            Top = 3
            Width = 126
            Height = 21
            AutoComplete = False
            TabOrder = 0
            OnSelect = cbPresetNameSelect
          end
          object btnSavePreset: TButton
            Left = 174
            Top = 1
            Width = 75
            Height = 25
            Action = acSavePreset
            TabOrder = 1
          end
          object btnDeletePreset: TButton
            Left = 255
            Top = 1
            Width = 75
            Height = 25
            Action = acDeletePreset
            TabOrder = 2
          end
        end
        object tvBooksSR: TBookTree
          Tag = 3
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 539
          Height = 460
          Align = alClient
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          Header.AutoSizeIndex = 0
          Header.Height = 20
          Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoHotTrack, hoOwnerDraw, hoRestrictDrag, hoShowHint, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize]
          Header.PopupMenu = pmHeaders
          Header.Style = hsFlatButtons
          HintMode = hmTooltip
          ParentShowHint = False
          PopupMenu = pmMain
          ShowHint = False
          TabOrder = 1
          OnChange = tvBooksTreeChange
          OnDblClick = ReadBookExecute
          OnHeaderClick = tvBooksTreeHeaderClick
          OnKeyDown = tvBooksTreeKeyDown
          OnMouseUp = tvBooksTreeMouseUp
          Columns = <
            item
              MaxWidth = 1000
              MinWidth = 30
              Position = 0
              Text = #1040#1074#1090#1086#1088
              Width = 200
            end
            item
              Hint = 
                'Text is initially centered and has a left-to-right directionalit' +
                'y.'
              MaxWidth = 1000
              MinWidth = 30
              Position = 1
              Spacing = 10
              Text = #1053#1072#1079#1074#1072#1085#1080#1077
              Width = 200
            end
            item
              MaxWidth = 1000
              MinWidth = 30
              Position = 2
              Text = #1057#1077#1088#1080#1103
              Width = 200
            end
            item
              Alignment = taCenter
              Hint = 
                'Text is initially left aligned and has a left-to-right direction' +
                'ality.'
              MaxWidth = 60
              MinWidth = 30
              Position = 3
              Spacing = 10
              Text = #8470
              Width = 45
            end
            item
              Alignment = taCenter
              Hint = 
                'Text is initially left aligned and has a right-to-left direction' +
                'ality.'
              MaxWidth = 100
              MinWidth = 65
              Position = 4
              Spacing = 10
              Text = #1056#1072#1079#1084#1077#1088
              Width = 65
            end
            item
              Alignment = taCenter
              MaxWidth = 60
              MinWidth = 60
              Position = 5
              Text = #1056#1077#1081#1090#1080#1085#1075
              Width = 60
            end
            item
              MinWidth = 30
              Position = 6
              Text = #1046#1072#1085#1088
              Width = 205
            end
            item
              Position = 7
              Text = #1044#1086#1073#1072#1074#1083#1077#1085#1086
              Width = 80
            end>
        end
      end
      object pnSearchView: TMHLSimplePanel
        Left = 0
        Top = 0
        Width = 230
        Height = 657
        Align = alLeft
        TabOrder = 0
        object SearchParams: TCategoryPanelGroup
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 224
          Height = 613
          VertScrollBar.Tracking = True
          Align = alClient
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          TabOrder = 0
          object ctpOther: TCategoryPanel
            Top = 491
            Caption = #1056#1072#1079#1085#1086#1077
            TabOrder = 0
            ExplicitWidth = 185
            object Label30: TLabel
              Left = 7
              Top = 97
              Width = 26
              Height = 13
              Alignment = taRightJustify
              Caption = #1044#1072#1090#1072
            end
            object Label2: TLabel
              Left = 7
              Top = 124
              Width = 26
              Height = 13
              Alignment = taRightJustify
              Caption = #1071#1079#1099#1082
            end
            object Label4: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 195
              Height = 13
              Align = alTop
              Caption = #1056#1072#1079#1084#1077#1097#1077#1085#1080#1077
              ExplicitWidth = 62
            end
            object Label8: TLabel
              Left = 7
              Top = 151
              Width = 38
              Height = 13
              Alignment = taRightJustify
              Caption = #1054#1094#1077#1085#1082#1072
            end
            object cbDate: TComboBox
              Left = 55
              Top = 93
              Width = 99
              Height = 21
              TabOrder = 0
              OnKeyDown = PresetFieldKeyDown
              Items.Strings = (
                #1089#1077#1075#1086#1076#1085#1103
                #1079#1072' 3 '#1076#1085#1103
                #1079#1072' '#1085#1077#1076#1077#1083#1102
                #1079#1072' 2 '#1085#1077#1076#1077#1083#1080
                #1079#1072' '#1084#1077#1089#1103#1094
                #1079#1072' 3 '#1084#1077#1089#1103#1094#1072)
            end
            object cbLang: TComboBox
              Left = 55
              Top = 120
              Width = 99
              Height = 21
              TabOrder = 1
              OnKeyDown = PresetFieldKeyDown
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
            object cbDownloaded: TComboBox
              AlignWithMargins = True
              Left = 3
              Top = 22
              Width = 195
              Height = 21
              Align = alTop
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 2
              Text = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1089#1077
              Items.Strings = (
                #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1089#1077
                #1058#1086#1083#1100#1082#1086' '#1089#1082#1072#1095#1072#1085#1085#1099#1077
                #1058#1086#1083#1100#1082#1086' '#1053#1045' '#1089#1082#1072#1095#1072#1085#1085#1099#1077)
            end
            object cbDeleted: TCheckBox
              AlignWithMargins = True
              Left = 5
              Top = 49
              Width = 193
              Height = 17
              Margins.Left = 5
              Align = alTop
              Caption = #1057#1082#1088#1099#1074#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
              TabOrder = 3
            end
            object cbLibRate: TComboBox
              Left = 55
              Top = 147
              Width = 99
              Height = 21
              TabOrder = 4
              OnKeyDown = PresetFieldKeyDown
              Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                '5')
            end
            object cbReaded: TCheckBox
              AlignWithMargins = True
              Left = 5
              Top = 72
              Width = 193
              Height = 17
              Margins.Left = 5
              Align = alTop
              Caption = #1058#1086#1083#1100#1082#1086' '#1087#1088#1086#1095#1080#1090#1072#1085#1085#1099#1077
              TabOrder = 5
            end
          end
          object ctpFile: TCategoryPanel
            Top = 314
            Height = 177
            Caption = #1060#1072#1081#1083
            TabOrder = 1
            ExplicitWidth = 220
            object Label27: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 19
              Height = 13
              Align = alTop
              Caption = #1048#1084#1103
            end
            object Label29: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 95
              Width = 18
              Height = 13
              Align = alTop
              Caption = #1058#1080#1087
            end
            object Label28: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 49
              Width = 72
              Height = 13
              Align = alTop
              Caption = #1055#1072#1087#1082#1072' ('#1072#1088#1093#1080#1074')'
            end
            object edFFile: TMHLButtonedEdit
              AlignWithMargins = True
              Left = 3
              Top = 22
              Width = 195
              Height = 21
              Align = alTop
              TabOrder = 0
              OnKeyDown = PresetFieldKeyDown
              OnRightButtonClick = ShowExpressionEditor
            end
            object edFFolder: TMHLButtonedEdit
              AlignWithMargins = True
              Left = 3
              Top = 68
              Width = 195
              Height = 21
              Align = alTop
              TabOrder = 1
              OnKeyDown = PresetFieldKeyDown
              OnRightButtonClick = ShowExpressionEditor
            end
            object edFExt: TMHLButtonedEdit
              AlignWithMargins = True
              Left = 3
              Top = 114
              Width = 195
              Height = 21
              Align = alTop
              TabOrder = 2
              OnKeyDown = PresetFieldKeyDown
              OnRightButtonClick = ShowExpressionEditor
            end
          end
          object ctpBook: TCategoryPanel
            Top = 0
            Height = 314
            Caption = #1050#1085#1080#1075#1072
            TabOrder = 2
            ExplicitWidth = 220
            object Label5: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 31
              Height = 13
              Align = alTop
              Caption = #1040#1074#1090#1086#1088
            end
            object Label24: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 49
              Width = 48
              Height = 13
              Align = alTop
              Caption = #1053#1072#1079#1074#1072#1085#1080#1077
            end
            object Label26: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 141
              Width = 28
              Height = 13
              Align = alTop
              Caption = #1046#1072#1085#1088
            end
            object Label6: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 95
              Width = 31
              Height = 13
              Align = alTop
              Caption = #1057#1077#1088#1080#1103
            end
            object Label7: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 238
              Width = 55
              Height = 13
              Align = alBottom
              Caption = #1040#1085#1085#1086#1090#1072#1094#1080#1103
            end
            object Label3: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 191
              Width = 86
              Height = 13
              Margins.Top = 0
              Align = alTop
              Caption = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
            end
            object edFFullName: TMHLButtonedEdit
              AlignWithMargins = True
              Left = 3
              Top = 22
              Width = 195
              Height = 21
              Align = alTop
              TabOrder = 0
              OnKeyDown = PresetFieldKeyDown
              OnRightButtonClick = ShowExpressionEditor
            end
            object edFTitle: TMHLButtonedEdit
              AlignWithMargins = True
              Left = 3
              Top = 68
              Width = 195
              Height = 21
              Align = alTop
              TabOrder = 1
              OnKeyDown = PresetFieldKeyDown
              OnRightButtonClick = ShowExpressionEditor
            end
            object edFSeries: TMHLButtonedEdit
              AlignWithMargins = True
              Left = 3
              Top = 114
              Width = 195
              Height = 21
              Align = alTop
              TabOrder = 2
              OnKeyDown = PresetFieldKeyDown
              OnRightButtonClick = ShowExpressionEditor
            end
            object edFGenre: TMHLButtonedEdit
              AlignWithMargins = True
              Left = 3
              Top = 160
              Width = 195
              Height = 21
              Margins.Bottom = 10
              Align = alTop
              TabOrder = 3
              OnKeyDown = PresetFieldKeyDown
              OnKeyPress = edFGenreKeyPress
              OnRightButtonClick = ShowGenreEditor
            end
            object edFAnnotation: TMHLButtonedEdit
              AlignWithMargins = True
              Left = 3
              Top = 257
              Width = 195
              Height = 21
              Margins.Bottom = 10
              Align = alBottom
              TabOrder = 4
              OnKeyDown = PresetFieldKeyDown
              OnRightButtonClick = ShowExpressionEditor
            end
            object edFKeyWords: TMHLButtonedEdit
              AlignWithMargins = True
              Left = 3
              Top = 210
              Width = 195
              Height = 21
              Hint = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
              Align = alTop
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              OnKeyDown = PresetFieldKeyDown
              OnRightButtonClick = ShowExpressionEditor
            end
          end
        end
        object pnSearchControl: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 622
          Width = 224
          Height = 32
          Align = alBottom
          TabOrder = 1
          object btnApplyFilter: TButton
            Left = 0
            Top = 2
            Width = 75
            Height = 25
            Action = acApplyPreset
            TabOrder = 0
          end
          object btnClearFilterEdits: TButton
            Left = 81
            Top = 2
            Width = 75
            Height = 25
            Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077' '#1087#1086#1083#1103
            Caption = #1054#1095#1080#1089#1090#1080#1090#1100
            TabOrder = 1
            OnClick = btnClearFilterEditsClick
          end
        end
      end
    end
    object tsByGroup: TTabSheet
      HelpContext = 125
      Caption = #1043#1088#1091#1087#1087#1099
      object GroupsViewSplitter: TMHLSplitter
        Left = 230
        Top = 0
        Height = 657
        MinSize = 230
        ResizeControl = pnGroupsView
        ExplicitLeft = 392
        ExplicitTop = 144
        ExplicitHeight = 100
      end
      object pnGroupsView: TMHLSimplePanel
        Left = 0
        Top = 0
        Width = 230
        Height = 657
        Align = alLeft
        TabOrder = 0
        object tvGroups: TVirtualStringTree
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 224
          Height = 620
          Align = alClient
          ChangeDelay = 250
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          Header.AutoSizeIndex = 0
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          PopupMenu = pmGroupActions
          TabOrder = 0
          TreeOptions.PaintOptions = [toPopupMode, toShowHorzGridLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
          OnChange = tvGroupsChange
          OnDragOver = tvGroupsDragOver
          OnDragDrop = tvGroupsDragDrop
          OnKeyDown = tvGroupsKeyDown
          Touch.InteractiveGestures = [igPan, igPressAndTap]
          Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
          Columns = <>
        end
        object RzPanel8: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 629
          Width = 224
          Height = 25
          Align = alBottom
          TabOrder = 1
          object btnAddGroup: TButton
            Left = 0
            Top = 0
            Width = 70
            Height = 25
            Action = acGroupCreate
            Caption = #1057#1086#1079#1076#1072#1090#1100
            TabOrder = 0
          end
          object btnDeleteGroup: TButton
            Left = 76
            Top = 0
            Width = 70
            Height = 25
            Action = acGroupDelete
            Caption = #1059#1076#1072#1083#1080#1090#1100
            TabOrder = 1
          end
          object btnClearGroup: TButton
            Left = 151
            Top = 0
            Width = 70
            Height = 25
            Action = acGroupClear
            Caption = #1054#1095#1080#1089#1090#1080#1090#1100
            TabOrder = 2
          end
        end
      end
      object pnGroupBooksView: TMHLSimplePanel
        Left = 233
        Top = 0
        Width = 549
        Height = 657
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 545
        object GroupBookInfoSplitter: TMHLSplitter
          Left = 0
          Top = 498
          Width = 549
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          ResizeControl = ipnlFavorites
          ExplicitTop = 31
          ExplicitWidth = 244
        end
        object ipnlFavorites: TInfoPanel
          AlignWithMargins = True
          Left = 3
          Top = 504
          Width = 543
          Height = 150
          Align = alBottom
          Color = clBlack
          TabOrder = 2
          OnResize = InfoPanelResize
          OnAuthorLinkClicked = AuthorLinkClicked
          OnSeriesLinkClicked = SeriesLinkClicked
          OnGenreLinkClicked = GenreLinkClicked
          ExplicitWidth = 539
          DesignSize = (
            539
            150)
          object lblTotalBooksF: TLabel
            AlignWithMargins = True
            Left = 1818
            Top = 9
            Width = 12
            Height = 19
            Alignment = taRightJustify
            Anchors = []
            Caption = '()'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 1601
            ExplicitTop = 3
          end
        end
        object pnGroupBooksTitle: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 539
          Height = 26
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object lblBooksTotalF: TLabel
            Left = 436
            Top = 0
            Width = 107
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1085#1080#1075')'
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lblGroups: TLabel
            Left = 0
            Top = 0
            Width = 102
            Height = 26
            Align = alLeft
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lbl3: TLabel
            Left = 342
            Top = 0
            Width = 31
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = #1071#1079#1099#1082
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object cbLangSelectF: TComboBox
            Tag = 4
            AlignWithMargins = True
            Left = 376
            Top = 3
            Width = 50
            Height = 21
            Margins.Right = 10
            Align = alRight
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = '-'
            OnChange = cbLangSelectAChange
            Items.Strings = (
              '-')
          end
        end
        object tvBooksF: TBookTree
          Tag = 4
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 539
          Height = 460
          Align = alClient
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          DragMode = dmAutomatic
          Header.AutoSizeIndex = 0
          Header.Height = 20
          Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoHotTrack, hoOwnerDraw, hoRestrictDrag, hoShowHint, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize]
          Header.PopupMenu = pmHeaders
          Header.Style = hsFlatButtons
          HintMode = hmTooltip
          ParentShowHint = False
          PopupMenu = pmMain
          ShowHint = False
          TabOrder = 1
          OnChange = tvBooksTreeChange
          OnDblClick = ReadBookExecute
          OnHeaderClick = tvBooksTreeHeaderClick
          OnKeyDown = tvBooksTreeKeyDown
          OnMouseUp = tvBooksTreeMouseUp
          Columns = <
            item
              BiDiMode = bdLeftToRight
              Hint = 
                'Text is initially centered and has a left-to-right directionalit' +
                'y.'
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 0
              Spacing = 10
              Text = #1053#1072#1079#1074#1072#1085#1080#1077
              Width = 305
            end
            item
              Alignment = taCenter
              BiDiMode = bdLeftToRight
              Hint = 
                'Text is initially left aligned and has a left-to-right direction' +
                'ality.'
              MaxWidth = 90
              MinWidth = 35
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring]
              Position = 1
              Spacing = 10
              Text = #8470
              Width = 38
            end
            item
              Alignment = taCenter
              BiDiMode = bdRightToLeft
              Hint = 
                'Text is initially left aligned and has a right-to-left direction' +
                'ality.'
              MinWidth = 65
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 2
              Spacing = 10
              Text = #1056#1072#1079#1084#1077#1088
              Width = 65
            end
            item
              Alignment = taCenter
              BiDiMode = bdLeftToRight
              MaxWidth = 60
              MinWidth = 60
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 3
              Text = #1056#1077#1081#1090#1080#1085#1075
              Width = 60
            end
            item
              BiDiMode = bdLeftToRight
              Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 4
              Text = #1050#1086#1083#1083#1077#1082#1094#1080#1103
              Width = 200
            end>
        end
      end
    end
    object tsDownload: TTabSheet
      HelpContext = 108
      Caption = #1057#1087#1080#1089#1086#1082' '#1079#1072#1082#1072#1095#1077#1082
      object tlbrDownloadList: TToolBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 772
        Height = 22
        ButtonWidth = 30
        Images = ilToolImages
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object btnStartDownload: TToolButton
          Left = 0
          Top = 0
          Hint = #1057#1090#1072#1088#1090
          Caption = 'Play'
          ImageIndex = 1
          OnClick = btnStartDownloadClick
        end
        object btnPauseDownload: TToolButton
          Left = 30
          Top = 0
          Hint = #1057#1090#1086#1087
          Caption = 'Stop'
          ImageIndex = 2
          OnClick = btnPauseDownloadClick
        end
        object RzSpacer2: TToolButton
          Left = 60
          Top = 0
          Width = 8
          Style = tbsSeparator
        end
        object BtnFirstRecord: TToolButton
          Tag = 20
          Left = 68
          Top = 0
          Hint = #1042' '#1085#1072#1095#1072#1083#1086
          Caption = 'First Record'
          ImageIndex = 3
          OnClick = MoveDwnldListNodes
        end
        object BtnDwnldUp: TToolButton
          Tag = 21
          Left = 98
          Top = 0
          Hint = #1042#1074#1077#1088#1093
          Caption = 'Up'
          ImageIndex = 4
          OnClick = MoveDwnldListNodes
        end
        object BtnDwnldDown: TToolButton
          Tag = 22
          Left = 128
          Top = 0
          Hint = #1042#1085#1080#1079
          Caption = 'Down'
          ImageIndex = 5
          OnClick = MoveDwnldListNodes
        end
        object BtnLastRecord: TToolButton
          Tag = 23
          Left = 158
          Top = 0
          Hint = #1042' '#1082#1086#1085#1077#1094
          Caption = 'Last Record'
          ImageIndex = 6
          OnClick = MoveDwnldListNodes
        end
        object ToolButton2: TToolButton
          Left = 188
          Top = 0
          Width = 8
          Caption = 'ToolButton2'
          ImageIndex = 17
          Style = tbsSeparator
        end
        object BtnDelete: TToolButton
          Left = 196
          Top = 0
          Hint = #1059#1076#1072#1083#1080#1090#1100
          Caption = 'Delete'
          ImageIndex = 7
          OnClick = btnDeleteDownloadClick
        end
        object BtnSave: TToolButton
          Left = 226
          Top = 0
          Hint = 'Save'
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          ImageIndex = 8
          OnClick = BtnSaveClick
        end
        object tbtnClear: TToolButton
          Left = 256
          Top = 0
          Caption = #1054#1095#1080#1089#1090#1080#1090#1100
          ImageIndex = 9
          OnClick = btnClearDownloadClick
        end
      end
      object Panel1: TMHLSimplePanel
        Left = 0
        Top = 28
        Width = 778
        Height = 629
        Align = alClient
        TabOrder = 1
        object RzPanel2: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 584
          Width = 772
          Height = 42
          Align = alBottom
          TabOrder = 1
          object lblDownloadState: TLabel
            Left = 288
            Top = 19
            Width = 265
            Height = 13
            AutoSize = False
            Caption = #1054#1078#1080#1076#1072#1085#1080#1077
          end
          object lblDnldAuthor: TLabel
            Left = 0
            Top = 0
            Width = 282
            Height = 13
            AutoSize = False
            Caption = 'Author'
          end
          object lblDnldTitle: TLabel
            Left = 288
            Top = 0
            Width = 265
            Height = 13
            AutoSize = False
            Caption = 'Title'
          end
          object lblDownloadCount: TLabel
            AlignWithMargins = True
            Left = 662
            Top = 3
            Width = 107
            Height = 13
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1085#1080#1075')'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
          end
          object pbDownloadProgress: TProgressBar
            Left = 0
            Top = 19
            Width = 282
            Height = 17
            TabOrder = 0
            Visible = False
          end
        end
        object tvDownloadList: TBookTree
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 772
          Height = 575
          Align = alClient
          Colors.BorderColor = 15987699
          Colors.DisabledColor = clGray
          Colors.DropMarkColor = 15385233
          Colors.DropTargetColor = 15385233
          Colors.DropTargetBorderColor = 15385233
          Colors.FocusedSelectionColor = 15385233
          Colors.FocusedSelectionBorderColor = 15385233
          Colors.GridLineColor = 15987699
          Colors.HeaderHotColor = clBlack
          Colors.HotColor = clBlack
          Colors.SelectionRectangleBlendColor = 15385233
          Colors.SelectionRectangleBorderColor = 15385233
          Colors.SelectionTextColor = clBlack
          Colors.TreeLineColor = 9471874
          Colors.UnfocusedColor = clGray
          Colors.UnfocusedSelectionColor = clWhite
          Colors.UnfocusedSelectionBorderColor = clWhite
          Header.AutoSizeIndex = 0
          Header.Height = 20
          Header.Options = [hoColumnResize, hoDrag, hoVisible]
          PopupMenu = pmDownloadList
          TabOrder = 0
          Columns = <
            item
              Position = 0
              Text = #1040#1074#1090#1086#1088
              Width = 200
            end
            item
              Position = 1
              Text = #1053#1072#1079#1074#1072#1085#1080#1077
              Width = 200
            end
            item
              Alignment = taRightJustify
              Position = 2
              Text = #1056#1072#1079#1084#1077#1088
              Width = 100
            end
            item
              Alignment = taCenter
              Position = 3
              Text = #1057#1090#1072#1090#1091#1089
              Width = 100
            end>
        end
      end
    end
  end
  object tlbrEdit: TToolBar
    Left = 0
    Top = 40
    Width = 792
    Height = 22
    ButtonHeight = 19
    ButtonWidth = 204
    Caption = 'RusBar'
    List = True
    ShowCaptions = True
    AllowTextButtons = True
    TabOrder = 1
    Wrapable = False
    ExplicitWidth = 788
    object tbtnEditAuthor: TToolButton
      Left = 0
      Top = 0
      Action = acEditAuthor
      Caption = ' '#1040#1074#1090#1086#1088
      Style = tbsTextButton
    end
    object tbtnEditSeries: TToolButton
      Left = 45
      Top = 0
      Action = acEditSerie
      Caption = ' '#1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1077#1088#1080#1080
      Style = tbsTextButton
    end
    object tbtnEditGenre: TToolButton
      Left = 139
      Top = 0
      Action = acEditGenre
      Caption = ' '#1053#1072#1079#1074#1072#1085#1080#1077' '#1078#1072#1085#1088#1072
      Style = tbsTextButton
    end
    object tbtnEditBook: TToolButton
      Left = 236
      Top = 0
      Action = acEditBook
      Caption = ' '#1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1085#1080#1075#1077
      Style = tbsTextButton
    end
    object tbtnSplitter1: TToolButton
      Left = 354
      Top = 0
      Width = 8
      Caption = 'tbtnSplitter1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object tbtnDeleteBook: TToolButton
      Left = 362
      Top = 0
      Action = acBookDelete
      Caption = ' '#1059#1076#1072#1083#1080#1090#1100
      Style = tbsTextButton
    end
    object tbtnSplitter2: TToolButton
      Left = 425
      Top = 0
      Width = 8
      Caption = 'tbtnSplitter2'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object tbtnFBD: TToolButton
      Left = 433
      Top = 0
      Action = acEditConver2FBD
      Caption = ' '#1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' FBD'
      Style = tbsTextButton
    end
    object tbtnAutoFBD: TToolButton
      Left = 556
      Top = 0
      Action = acEditAutoConver2FBD
      Caption = ' '#1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' FBD'
      Style = tbsTextButton
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 753
    Width = 792
    Height = 19
    AutoHint = True
    Panels = <
      item
        Width = 200
      end
      item
        Width = 100
      end
      item
        Alignment = taCenter
        Width = 100
      end>
    OnDrawPanel = StatusBarDrawPanel
    OnResize = StatusBarResize
    ExplicitTop = 752
    ExplicitWidth = 788
  end
  object MainMenu: TMainMenu
    Images = ilMainMenu
    OwnerDraw = True
    Left = 40
    Top = 384
    object miBook: TMenuItem
      Caption = #1050#1085#1080#1075#1072
      HelpContext = 105
      object miRead: TMenuItem
        Action = acBookRead
      end
      object miDevice: TMenuItem
        Action = acBookSend2Device
      end
      object miDownloadBooks: TMenuItem
        Action = acBookAdd2DownloadList
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object N60: TMenuItem
        Action = acBookMarkAsRead
        Caption = #1055#1088#1086#1095#1080#1090#1072#1085#1086
      end
      object N61: TMenuItem
        Caption = #1056#1077#1081#1090#1080#1085#1075
        object N62: TMenuItem
          Action = acBookSetRate1
        end
        object N63: TMenuItem
          Action = acBookSetRate2
        end
        object N64: TMenuItem
          Action = acBookSetRate3
        end
        object N65: TMenuItem
          Action = acBookSetRate4
        end
        object N66: TMenuItem
          Action = acBookSetRate5
        end
        object N67: TMenuItem
          Caption = '-'
        end
        object N68: TMenuItem
          Action = acBookSetRateClear
        end
      end
      object N69: TMenuItem
        Caption = '-'
      end
      object miAdd2Favorites: TMenuItem
        Action = acBookAdd2Favorites
      end
      object miAddToGroup: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1075#1088#1091#1087#1087#1091
        OnClick = acBookAdd2GroupExecute
        object TMenuItem
        end
      end
      object miRemoveFromGroup: TMenuItem
        Action = acBookRemoveFromGroup
      end
      object N73: TMenuItem
        Caption = '-'
      end
      object miCopyToCollection: TMenuItem
        Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1082#1086#1083#1083#1077#1082#1094#1080#1102
        ImageIndex = 23
      end
      object N74: TMenuItem
        Action = acBookDelete
      end
      object N31: TMenuItem
        Caption = '-'
      end
      object miQuitApp: TMenuItem
        Action = acApplicationExit
      end
    end
    object N2: TMenuItem
      Caption = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      HelpContext = 112
      object miNewCollection: TMenuItem
        Action = acCollectionNew
      end
      object miCollSelect: TMenuItem
        Caption = #1042#1099#1073#1088#1072#1090#1100' '#1082#1086#1083#1083#1077#1082#1094#1080#1102
        ImageIndex = 27
      end
      object miCollsettings: TMenuItem
        Action = acCollectionProperties
      end
      object miStat: TMenuItem
        Action = acCollectionStatistics
      end
      object N38: TMenuItem
        Caption = '-'
      end
      object N39: TMenuItem
        Caption = #1048#1084#1087#1086#1088#1090
        object miFb2Import: TMenuItem
          Action = acImportFb2
          Caption = #1060#1072#1081#1083#1099' fb2 '#1080' fb2.zip'
          ImageIndex = 18
        end
        object miPdfdjvu: TMenuItem
          Action = acImportNonFB2
          Caption = #1060#1072#1081#1083#1099' '#1085#1077'-fb2'
          ImageIndex = 8
        end
        object miFBDImport: TMenuItem
          Action = acImportFBD
          Caption = #1060#1072#1081#1083#1099' FBD (pdf.zip djvu.zip)'
          ImageIndex = 20
        end
        object N14: TMenuItem
          Caption = '-'
        end
        object miImportUserData: TMenuItem
          Action = acImportUserData
        end
      end
      object N40: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1088#1090
        object N46: TMenuItem
          Caption = #1069#1082#1089#1087#1086#1088#1090' '#1072#1082#1090#1080#1074#1085#1086#1075#1086' '#1089#1087#1080#1089#1082#1072
          object miExportToHTML: TMenuItem
            Tag = 351
            Action = acExport2HTML
          end
          object txt1: TMenuItem
            Tag = 352
            Action = acExport2Txt
          end
          object RTF1: TMenuItem
            Tag = 353
            Action = acExport2RTF
          end
        end
        object miINPXCollectionExport: TMenuItem
          Action = acExport2INPX
        end
        object N41: TMenuItem
          Caption = '-'
        end
        object miExportUserData: TMenuItem
          Action = acExportUserData
        end
      end
      object N6: TMenuItem
        Caption = #1054#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077
        object miRefreshGenres: TMenuItem
          Action = acCollectionUpdateGenres
        end
        object miSyncOnline: TMenuItem
          Action = acCollectionSyncFiles
        end
        object miRepairDataBase: TMenuItem
          Action = acCollectionRepair
        end
        object miCompactDataBase: TMenuItem
          Action = acCollectionCompact
        end
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object miDeleteCol: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1086#1083#1083#1077#1082#1094#1080#1102
        ImageIndex = 2
        OnClick = DeleteCollectionExecute
      end
    end
    object N24: TMenuItem
      Caption = #1043#1088#1091#1087#1087#1072
      object N43: TMenuItem
        Action = acGroupCreate
      end
      object N80: TMenuItem
        Action = acGroupEdit
      end
      object N81: TMenuItem
        Action = acGroupClear
      end
      object N82: TMenuItem
        Action = acGroupDelete
      end
    end
    object N36: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      object N51: TMenuItem
        Action = acEditBook
      end
      object FBD1: TMenuItem
        Action = acEditConver2FBD
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'/'#1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' FBD'
      end
      object FBD2: TMenuItem
        Action = acEditAutoConver2FBD
      end
      object N52: TMenuItem
        Caption = '-'
      end
      object N47: TMenuItem
        Action = acEditAuthor
      end
      object N48: TMenuItem
        Action = acEditSerie
      end
      object N50: TMenuItem
        Action = acEditGenre
      end
    end
    object miView: TMenuItem
      Caption = #1042#1080#1076
      object N75: TMenuItem
        Caption = #1055#1072#1085#1077#1083#1080
        object miShowMainToolbar: TMenuItem
          Action = acShowMainToolbar
        end
        object miShowEditToolbar: TMenuItem
          Action = acShowEditToolbar
        end
        object miShowRusAlphabet: TMenuItem
          Action = acShowRusAlphabet
        end
        object miShowEngAlphabet: TMenuItem
          Action = acShowEngAlphabet
        end
      end
      object miShowStatusbar: TMenuItem
        Action = acShowStatusbar
      end
      object miShowBookInfo: TMenuItem
        Action = acShowBookInfoPanel
      end
      object miViewExtra: TMenuItem
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
        object miShowBookCover: TMenuItem
          Action = acShowBookCover
        end
        object miShowBookAnnotation: TMenuItem
          Action = acShowBookAnnotation
          AutoCheck = True
        end
        object miBookInfoPriority: TMenuItem
          Action = acViewSetInfoPriority
          AutoCheck = True
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' BookInfo'
        end
      end
      object N76: TMenuItem
        Caption = #1056#1077#1078#1080#1084' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
        object acViewTreeView1: TMenuItem
          Action = acViewTreeView
        end
        object acViewTableView1: TMenuItem
          Action = acViewTableView
        end
      end
      object N77: TMenuItem
        Action = acViewSelectColumns
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object N78: TMenuItem
        Action = acViewHideDeletedBooks
      end
      object N79: TMenuItem
        Action = acViewShowLocalOnly
      end
    end
    object miTools: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      object miFastBookSearch: TMenuItem
        Action = acToolsQuickSearch
        ShortCut = 114
      end
      object miUpdate: TMenuItem
        Action = acToolsUpdateOnlineCollections
      end
      object N34: TMenuItem
        Action = acToolsClearReadFolder
      end
      object mmiScripts: TMenuItem
        Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1089#1082#1088#1080#1087#1090
        ImageIndex = 29
      end
      object N49: TMenuItem
        Caption = '-'
      end
      object miSettings: TMenuItem
        Action = acToolsSettings
      end
    end
    object N5: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      object miShowHelp: TMenuItem
        Action = acHelpHelp
      end
      object miCheckUpdates: TMenuItem
        Action = acHelpCheckUpdates
      end
      object N30: TMenuItem
        Caption = '-'
      end
      object miGoSite: TMenuItem
        Action = acHelpProgramSite
      end
      object miGoForum: TMenuItem
        Action = acHelpSupportForum
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miAbout: TMenuItem
        Action = acHelpAbout
      end
    end
  end
  object pmMain: TPopupMenu
    Images = ilMainMenu
    OwnerDraw = True
    Left = 128
    Top = 280
    object pmiReadBook: TMenuItem
      Caption = #1063#1080#1090#1072#1090#1100
      ImageIndex = 12
      ShortCut = 13
      OnClick = ReadBookExecute
    end
    object pmiSendToDevice: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1085#1072' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
      ImageIndex = 7
      ShortCut = 16452
      OnClick = SendToDeviceExecute
    end
    object pmiDownloadBooks: TMenuItem
      Action = acBookAdd2DownloadList
    end
    object pmiScripts: TMenuItem
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1089#1082#1088#1080#1087#1090
      ImageIndex = 29
    end
    object N44: TMenuItem
      Caption = '-'
    end
    object miReaded: TMenuItem
      Caption = #1055#1088#1086#1095#1080#1090#1072#1085#1086
      ShortCut = 16466
      OnClick = MarkAsReadedExecute
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object miGoToAuthor: TMenuItem
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1072#1074#1090#1086#1088#1091
      ImageIndex = 35
      ShortCut = 49217
      OnClick = miGoToAuthorClick
    end
    object pmiBookInfo: TMenuItem
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1085#1080#1075#1077
      ShortCut = 16457
      OnClick = ShowBookInfo
    end
    object miBookEdit: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1086#1087#1080#1089#1072#1085#1080#1077
      ImageIndex = 3
      ShortCut = 16453
      OnClick = EditBookExecute
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object miAddFavorites: TMenuItem
      Tag = 1
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1080#1079#1073#1088#1072#1085#1085#1086#1077
      ImageIndex = 13
      ShortCut = 16454
      OnClick = AddBookToGroup
    end
    object pmiGroups: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1075#1088#1091#1087#1087#1091
    end
    object miDelFavorites: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079' '#1075#1088#1091#1087#1087#1099
      ImageIndex = 21
      Visible = False
      OnClick = DeleteBookFromGroup
    end
    object miRate: TMenuItem
      Caption = #1056#1077#1081#1090#1080#1085#1075
      ImageIndex = 30
      object miSetRate1: TMenuItem
        Tag = 1
        Action = acBookSetRate1
      end
      object miSetRate2: TMenuItem
        Tag = 2
        Action = acBookSetRate2
      end
      object miSetRate3: TMenuItem
        Tag = 3
        Action = acBookSetRate3
      end
      object miSetRate4: TMenuItem
        Tag = 4
        Action = acBookSetRate4
      end
      object miSetRate5: TMenuItem
        Tag = 5
        Action = acBookSetRate5
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object miClearRate: TMenuItem
        Action = acBookSetRateClear
      end
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object pmiCheckAll: TMenuItem
      Tag = 2
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 24
      ShortCut = 16449
      OnClick = pmiCheckAllClick
    end
    object pmiSelectAll: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      ShortCut = 16467
      OnClick = pmiSelectAllClick
    end
    object pmMarkSelected: TMenuItem
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077
      ShortCut = 16461
      OnClick = pmMarkSelectedClick
    end
    object pmiDeselectAll: TMenuItem
      Tag = 1
      Caption = #1057#1085#1103#1090#1100' '#1086#1090#1084#1077#1090#1082#1080
      ImageIndex = 32
      ShortCut = 16469
      OnClick = pmiDeselectAllClick
    end
    object N23: TMenuItem
      Caption = '-'
      Hint = '-'
    end
    object miCopyClBrd: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088
      ImageIndex = 31
      ShortCut = 16451
      OnClick = miCopyClBrdClick
    end
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 368
    Top = 192
  end
  object pmAuthor: TPopupMenu
    OwnerDraw = True
    OnPopup = pmAuthorPopup
    Left = 40
    Top = 288
    object miCopyAuthor: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '
      ShortCut = 16451
      OnClick = miCopyAuthorClick
    end
    object N37: TMenuItem
      Caption = '-'
    end
    object miAddToSearch: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' "'#1055#1086#1080#1089#1082'"'
      OnClick = miAddToSearchClick
    end
  end
  object ilToolBar: TImageList
    ColorDepth = cd32Bit
    BlendColor = clWhite
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Height = 32
    Width = 32
    Left = 280
    Top = 280
    Bitmap = {
      494C01011B001D00040020002000FFFFFF002110FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000080000000E0000000010020000000000000C0
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000020300000000000000000000
      0000000000000000000000000000000000000000000001010406000000000000
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
      000000000000000000000000000C0000001F000000270000002A0000002A0000
      002A0000002A0000002A0000002A0000002A0000002A0000002A0000002A0000
      002A0000002A0000002A0000002A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000002CAE10000CAE10000CAE12323
      CCE11D1DCCE15757D1E14F4FD0E12B2BCDE10000C8E10000C8E20000C7E12626
      AEE1000001010000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000003000000080000
      0010000000170000001F00000023000000280000002A00000028000000250000
      001F00000019000000110000000A000000040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000030303036323232E11F2020EA2222
      22E7222222E7202222E71C1D1DEA171818ED151515EF141414F0141414F01414
      14F0141415F0131313F11B1B1BF02727278B0000005B0000005B0000005B0000
      005B0000005B0000005B0000002A000000000000000000000000000000000000
      00000000000000000000000000000000000030303036323232E11F2020EA2222
      22E7222222E7202222E7202222E73F61B0FB0000E7FF0000E7FF0000E7FF2D2D
      EBFF7272F1FF6C6CF0FF6666F0FF6161EFFF0000E7FF0000E7FF0000E7FF2C2C
      CBFF000001010000000000000000000000000000000000000000000000000000
      00000000000000000000000000020000000D0000001B00000026010000332111
      076B4F2C13B072401DDF7C441FEE83481FF883481FF87D461FEF73411DE14F2C
      13B52112087402010142000000360000002D0000002100000011000000040000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171B1313030FF323232FF3635
      36FF363433FF363432FF363433FFDCC29AFFDDC39BFFDDC39BFFDDC39BFFDDC3
      9BFFDDC39BFFDDC39BFFDDC39BFFDDC39BFFDDC39BFFDDC39BFFDDC39BFFDDC3
      9BFFDEC59FFFA2A09EFF0000002A000000000000000000000000000000000000
      000000000000000000000000000000000000717171B1313030FF323232FF3635
      36FF363433FF363432FF383535FF96A7D0FF8888EAFF8888EAFF8787E9FF9393
      EBFFA7A7ECFFA2A2ECFFA1A1ECFFA1A1ECFF8888EAFF8888EAFF8888EAFF8C8C
      CFFF010101010000000000000000000000000000000000000000000000000000
      0000000000000000000700000014000000210805023B492911A480471FF49969
      49F5C8AA94FEE4D4C8FFEEE5DDFFF6F0ECFFF6F1ECFFEFE5DEFFE5D6CAFFCAAD
      97FE9A6B4AF6814720F5492A11AE0704024E00000036000000290000001D0000
      000B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717172FD605B5AFF87807BFF7D76
      70FF8D8586FF867C7DFFD8BA8BFFF5EED7FFF6EED8FFF6EED8FFF6EED8FFF6EE
      D8FFF6EED8FFF6EED8FFF6EED8FFF6EED8FFF6EED8FFF6EED8FFF6EED8FFF6EE
      D8FFF2E7CCFFDEC49FFF0000002A000000000000000000000000000000000000
      000000000000000000000000000000000000717172FD605B5AFF87807BFF7D76
      70FF8D8586FF867C7DFF7E7874FFC8CAD1FFDCDCEDFF808DEFFF808CE7FFB9BD
      E5FFDBDBECFFDCDCEDFFDCDCEDFFDCDCEDFFDCDCEDFFDCDCEDFFDCDCEDFFC7C7
      D3FF010101010000000000000000000000000000000000000000000000000000
      0000000000000000000A00000018391F0D82804921F3B48E73FBECE2D9FFFCFA
      F8FFFCFAF9FFFCFAF9FFFCFAF9FFFCFAF9FFFCFAF9FFFCFAF9FFFCFAF9FFFCFA
      F9FFFCFAF9FFEEE4DCFFB79377FB814822F4391F0E8E0000002D000000200000
      0013000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000666666FD66615FFF8C8884FF7A75
      71FF989391FF888080FFD9BB8CFFF2E8CAFFEEE0BEFFCE9726FFD9B15EFFD9B2
      62FFDEBF7CFFF2E8CAFFD9B05CFFD09722FFD8B56EFFCE9215FFD7AC54FFF2E8
      CAFFF2E8CAFFDCC199FF0000002A000000000000000000000000000000000000
      000000000000000000000000000000000000666666FD66615FFF8C8884FF7A75
      71FF989391FF888080FF7E7876FFD2D2D2FFEFEFEFFFA6B0F2FF7284E9FF808F
      E7FFE3E4E9FFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFD6D6
      D6FF010101010000000000000000000000000000000000000000000000000000
      000000000000030200095C3316B09B6C4CF5EADED5FFFCFAF8FFFCFAF8FFEEE4
      DCFFD9C1AEFFC8A689FFC39B7BFFBD936EFFBE9470FFC6A080FFCDAA8FFFDDC5
      B3FFF0E6DFFFFCFAF9FFFCFAF9FFECE1D8FF9E704FF65D3417B70301001C0000
      0009000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006C6C6CFF757171FF96918EFF7E78
      74FF6E6965FF726D68FFD8BA88FFEFE2BEFFE1C893FFCE982FFFC88D1AFFD5A9
      50FFDAB66BFFEFE2BEFFC5860BFFCF9D3CFFC9922CFFD09D3AFFC38204FFEFE2
      BDFFEFE2BDFFDCC198FF0000002A000000000000000000000000000000000000
      0000000000000000000000000000000000006C6C6CFF757171FF96918EFF7E78
      74FF6E6965FF726D68FF797471FFD4D4D4FFF3F3F3FFE2E4F4FFBBC3F0FF798B
      F1FF8E9CEAFFD6D9EDFFF0F1F1FFF2F2F2FFE1E3F0FFEBEBEEFFF1F1F1FFD9D9
      D9FF010101010000000000000000000000000000000000000000000000000000
      0000030101066D3C1BCCB38F74F9F8F4F1FFFCFAF8FFEDE2DAFFC7A58AFFB586
      60FFB88B65FFBB8E69FFBE926DFFC0946FFFC19671FFC19772FFC19672FFC095
      70FFBE936EFFCFAF95FFF0E6DEFFFCFAF9FFF9F5F2FFB7957AF96E3E1CCC0301
      0106000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000727272FF7B7877FF979291FF8781
      80FF7B7876FF7D7978FFD7B885FFEBDCB1FFDEC389FFC9901FFFC89535FFD2A6
      4EFFD7B366FFEBDCB1FFC1830BFFCFA043FFC68F29FFCF9F40FFC08007FFEBDC
      B1FFEBDCB1FFDCC097FF0000002A000000000000000000000000000000000000
      000000000000000000000000000000000000727272FF7B7877FF979291FF8781
      80FF7B7876FF7D7978FF837D7BFFD5D5D5FFF5F5F5FFF6F6F6FFF1F2F6FFC4CC
      F6FF5E74F0FFADB6ECFFB3BDF0FFA8B2F2FF788BF2FFA3ADEBFFF2F2F2FFDCDC
      DCFF010101010000000000000000000000000000000000000000000000000100
      00015F3418B1B38F74F8FBF9F7FFFCFAF8FFDBC6B5FFB2835DFFB4855FFFB88A
      65FFBB8F6AFFBF936EFFC19772FFC49A75FFC59C78FFC69D79FFC69C78FFC49B
      76FFC29874FFC09570FFBF936EFFE1CDBDFFFCFAF9FFFCFAF8FFB7947AF86035
      18B1010000010000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF4B4848FF5E595BFF645F
      60FF615B5CFF686363FFD6B681FFE9D6A5FFDEC180FFD2A12CFFD09E22FFD8B0
      4EFFD4A62FFFDFC27CFFCD9715FFD5AB45FFCD9B2DFFD4A016FFD2A12CFFE9D6
      A5FFE9D6A4FFDBC097FF0000002A000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF4B4848FF5E595BFF645F
      60FF615B5CFF686363FF7D7476FFD6D6D6FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7
      F7FF8595F6FFA1ACECFF99A7F4FF6075F1FF7387F5FFA0ABF1FFF4F4F4FFDFDF
      DFFF010101010000000000000000000000000000000000000000000000003F22
      0F75A4785AF5F9F6F3FFFBF9F8FFCEB19AFFAE7C56FFB2835DFFB78863FFBB8E
      68FFBE936EFFC29773FFE5E2E0FFE6E4E1FFE6E4E1FFE6E4E2FFCAA27EFFC9A0
      7CFFC69D79FFC39975FFC09570FFBC906AFFD6BBA6FFFCFAF9FFFAF7F5FFA77E
      5FF53F220F750000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000686868FF565252FFC0BDBDFF9F9C
      9DFF9E9B9CFFA3A1A1FFD6B57DFFE7D198FFDEC17EFFCF9510FFCF9A1FFFD6A9
      3FFFCF9D29FFCF9715FFCA8E04FFD3A336FFCB9420FFD19E2CFFC98D04FFE7D1
      98FFE7D098FFDBC096FF0000002A000000000000000000000000000000000000
      000000000000000000000000000000000000686868FF565252FFC0BDBDFF9F9C
      9DFF9E9B9CFFA3A1A1FFAAA6A8FFD7D7D7FFFAFAFAFFFAFAFAFFFAFAFAFFFAFA
      FAFFC2CBF9FF8E9BEBFF8797F7FF94A2F3FFDFE3F9FFEBEDFAFFF8F8F8FFE0E0
      E0FF0601060600000000000000000000000000000000000000000A040112814A
      25ECEEE4DDFFFBF9F8FFD5BCA9FFAB7952FFB07E59FFB4855FFFB98B65FFBD91
      6CFFC19671FFC59B77FFE8E8E8FFE9E9E9FFEAEAEAFFEAEAEAFFCEA886FFCDA5
      83FFCAA27EFFC69D79FFC29874FFBE936EFFBA8D68FFDCC5B3FFFCFAF9FFF0E7
      E1FF834C27EC0A04011200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF7B7879FF868483FF1311
      10FF1B1918FF1A1818FFD5B379FFE6CB8CFFE6CB8CFFDBB666FFE0C078FFD4A3
      3AFFD2A344FFCA8B0AFFC88804FFD19D32FFC98F1DFFD29D2FFFC68501FFE6CB
      8BFFE6CB8BFFDBC096FF0000002A000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF7B7879FF868483FF1311
      10FF1B1918FF1A1818FF1A1717FFD8D8D8FFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
      FBFFEFF1FBFF576DF0FF5E73F3FFECEEF7FFFAFAFAFFF9F9F9FFF7F7F7FFDFDF
      DFFF0D010D0D0000000000000000000000000000000000000000542D149CBEA0
      88FCFBF9F8FFE8DAD0FFA9764FFFAC7A54FFB1815AFFB68761FFBA8D68FFBF93
      6EFFC39974FFC79E7BFFEAEAEAFFEBEBEBFFECECECFFECECECFFD3AD8CFFD0AA
      88FFCDA683FFC9A07DFFC59B77FFC09570FFBC8F6AFFB88A65FFECDFD6FFFCFA
      F8FFC3A690FC542E159C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF7B7878FFE9E6E6FFEEED
      EDFFFFFFFFFFFFFFFFFFD5B276FFE4C67EFFE4C67EFFE4C67EFFE4C67EFFD19E
      34FFC98802FFD09C2FFFC48403FFCE992DFFC68B1AFFCA8901FFCD9522FFE4C6
      7EFFE4C67EFFDBC095FF0000002A000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF7B7878FFE9E6E6FFEEED
      EDFFFFFFFFFFFFFFFFFFFEFFFFFFDADADAFFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
      FBFFFAFAFBFF3853F7FFADB6F0FFFAFAFAFFF6F6F6FFF1F1F1FFEDEDEDFFD9D9
      D9FF0A010A0A000000000000000000000000000000000603020C844A24F3F3EC
      E7FFFBF9F7FFB78E6DFFA8754EFFAD7B55FFB2825CFFB68862FFBB8E69FFC094
      70FFC49B76FFC9A17DFFEAE7E5FFEBE8E6FFECEAE8FFECEAE8FFD7B292FFD3AE
      8DFFCFA987FFCBA380FFC69D79FFC19772FFBD916BFFB88B65FFC39E80FFFCF9
      F8FFF5EEEAFF844B25F30603020C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF807A7AFFEDEBEBFFFFFF
      FFFFFFFFFFFFFFFFFFFFD4B173FFE3C272FFE3C272FFE3C272FFE3C272FFE2BF
      6FFFE1BE6DFFE3C172FFE1BE6DFFE1BF6FFFE1BE6EFFE0BE6DFFE3C171FFE3C2
      72FFE2C070FFDCC197FF0000002A000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF807A7AFFEDEBEBFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFDBDBDBFFFBFBFBFFFCFCFCFFFCFCFCFFFCFC
      FCFFEDEEFBFF2846F7FFE4E6F0FFF7F7F7FFECECECFFE8E8E8FFE2E2E2FFA3A0
      A3C503000303000000000000000000000000000000002E180B56A67C5EF5FBF9
      F7FFE5D7CDFFA46F48FFA9754FFFAD7B55FFB2835CFFB78963FFBC8F6AFFC095
      70FFC59B77FFCAA27EFFCEA886FFD3AE8DFFD8B493FFDCBA99FFD9B696FFD5B0
      8FFFD0AA88FFCBA482FFC79E7AFFC29773FFBD916CFFB98B65FFB4855FFFEADD
      D3FFFCFAF8FFA98163F52E180B56000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF807A7AFFFAF9F8FFFFFF
      FFFFFFFFFFFFFFFFFFFFEEE2CFFFD6B47AFFD7B579FFD7B579FFD7B579FFD7B5
      79FFD7B579FFD7B579FFD7B579FFD7B579FFD7B579FFD7B579FFD7B579FFD7B5
      79FFD7B57DFFF8F3EBFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF807A7AFFFAF9F8FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFDBDBDBFFFBFBFBFFFCFCFCFFFCFCFCFFFCFC
      FCFFCAD1FBFF0F31F6FFD8DCEEFFF3F3F3FFE4E4E4FFE9E9E9FFB7B5B7D40B00
      0B0B0100010100000000000000000000000000000000613518B5D1B8A6FFFBF9
      F7FFC8A992FFA46F48FFA9754EFFAD7B55FFB2825CFFB78963FFBB8F69FFC095
      70FFC59B77FFC9A17EFFEFEFEFFFF1F1F1FFF2F2F2FFF2F2F2FFD9B798FFD4AF
      8EFFD0AA88FFCBA381FFC79D79FFC29773FFBD916CFFB88B65FFB4855EFFD1B5
      9FFFFCFAF8FFD5BEADFF623618B5000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF827B7CFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FDFFFFFFFFFFFFFFFFFF8F8B8BFF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF827B7CFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFDCDCDCFFFBFBFBFFFCFCFCFFFCFCFCFFFCFC
      FCFFD3D8FBFF324EF6FFE2E4F2FFF2F2F2FFEEEEEEFFD2D0D2E20B000B0B0000
      000000000000000000000000000000000000000000007A421DE6E7DAD1FFFBF9
      F7FFB48B6AFFA36E47FFA8744EFFAD7B54FFB1825BFFB68862FFBB8E68FFBF94
      6FFFC49A76FFC8A07CFFECE6E1FFF2F2F2FFF3F3F3FFF4F4F4FFE3CEBCFFD2AC
      8BFFCEA785FFCAA27EFFC59C78FFC19671FFBC906BFFB88A64FFB3845EFFC09B
      7CFFFCFAF8FFEADED6FF7B431EE6000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF848181FFFBF9F8FFCDCC
      CCFFEAE9E9FFEAE9E9FFD4D1D2FFCCCACBFFCBC9C9FFCCCACBFFCCCACBFFDDDA
      DAFFFFFFFFFFFFFFFFFF888485FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF848181FFFBF9F8FFCDCC
      CCFFEAE9E9FFEAE9E9FFD4D1D2FFDBDBDBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
      FBFFFBFBFBFFEEF0FBFFFAFAFAFFF3F3F3FFD9D9D9EF0C000C0C000000000000
      0000000000000000000000000000000000000000000084481FF9F2EBE6FFFBF9
      F7FFAA7956FFA36D46FFA7734DFFAC7953FFB0805AFFB58660FFB98C67FFBE92
      6DFFC29873FFC69D79FFD9BFAAFFF4F4F4FFF5F5F5FFF6F6F6FFF4F4F4FFDBC1
      AAFFCBA482FFC89F7BFFC49A75FFBF946FFFBB8E69FFB78963FFB2835CFFB88D
      6AFFFCFAF8FFF4EEE9FF854820F9000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF83807EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF817C7DFF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF83807EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4E4FFF6F6F6FFF7F7F7FFF7F7F7FFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFF3F3F3FF0101010100000000000000000000
      0000000000000000000000000000000000000000000084471FF9FBF9F7FFFBF9
      F7FFA26D47FFA26C44FFA6724BFFAB7851FFAF7E58FFB3845EFFB88A64FFBC8F
      6AFFC09570FFC49A75FFC79E7AFFE0CCBAFFF7F7F7FFF8F8F8FFF7F7F7FFF4F4
      F4FFD8BFA9FFC59B77FFC19672FFBD916CFFB98C66FFB58660FFB1815AFFB081
      5CFFFCFAF8FFFBF9F8FF844820F9000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000676767FF7D7877FFFFFFFFFFCECC
      CDFFCDCBCCFFD5D3D4FFFFFFFFFFFFFFFFFFCBC9CAFFCDCBCBFFCDCBCCFFCDCB
      CCFFFFFFFFFFFFFFFFFF797575FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000676767FF7D7877FFFFFFFFFFCECC
      CDFFCDCBCCFFD5D3D4FFFFFFFFFFFFFFFFFFCBC9CAFFCDCBCBFFCDCBCCFFCDCB
      CCFFFFFFFFFFFFFFFFFF797575FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000084481FF9F2EBE6FFFBF9
      F7FFA87754FFA06A42FFA57049FFA9764FFFAD7B55FFB1825BFFB58761FFB98C
      67FFBD916CFFC09571FFC39975FFC69D79FFDEC8B5FFF9F9F9FFF9F9F9FFF7F7
      F7FFF3F3F2FFCEAD92FFBE936EFFBB8E69FFB78963FFB3845DFFAF7D57FFB489
      66FFFCFAF8FFF4EDE9FF84481FF9000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6BFF837E7EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFAFFFFFEFDFFFFFFFFFFFDFB
      FAFFFFFFFFFFFFFFFFFF767272FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6BFF837E7EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFAFFFFFEFDFFFFFFFFFFFDFB
      FAFFFFFFFFFFFFFFFFFF767272FF656565FF0000000000000000000000000000
      000000000000000000000000000000000000000000007A421CE6E6D9D0FFFBF9
      F7FFB18666FF9E6840FFA36D46FFA7734CFFAB7852FFAF7E58FFB3845DFFB788
      63FFBA8D67FFBD916CFFC09470FFC29773FFC39975FFE2CFC0FFFAFAFAFFF8F8
      F8FFF5F5F5FFE5DAD1FFBB8F69FFB88A64FFB4865FFFB1815AFFAD7A54FFBB95
      75FFFBF9F8FFE9DDD4FF7B431DE6000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF8C8989FFFFFFFFFFCDCC
      CCFFEAE9EAFFEAE9EAFFDDDADAFFCCCACBFFCCCACAFFD5D1D2FFEAE9EAFFCDCB
      CBFFFFFFFFFFFFFFFFFF757271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF8C8989FFFFFFFFFFCDCC
      CCFFEAE9EAFFEAE9EAFFDDDADAFFCCCACBFFCCCACAFFD5D1D2FFEAE9EAFFCDCB
      CBFFFFFFFFFFFFFFFFFF757271FF656565FF0000000000000000000000000000
      00000000000000000000000000000000000000000000603516B5CFB5A4FFFBF9
      F7FFC4A48CFF9C653DFFA16B43FFA57049FFA9754EFFAC7A54FFB08059FFB384
      5EFFBD9473FFB98C67FFBC8F6AFFBE926DFFBF936EFFC7A283FFFBFBFBFFF9F9
      F9FFF6F6F6FFF0EFEDFFB88A64FFB58660FFB1825BFFAE7C56FFAA7751FFCCAE
      98FFFBF9F8FFD3BBAAFF613518B5000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000787878FF9B9797FFFEFEFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFDFEFFFDFD
      FEFFFFFFFFFFFFFFFFFF767171FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000787878FF9B9797FFFEFEFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFDFEFFFDFD
      FEFFFFFFFFFFFFFFFFFF767171FF656565FF0000000000000000000000000000
      000000000000000000000000000000000000000000002E180B56A3795BF5FBF8
      F7FFE3D4C9FF9A623AFF9E6840FFA26D45FFA6724BFFAA7650FFAD7B55FFB080
      59FFEEEDECFFDBC8B9FFC39D7EFFB98C66FFBA8D69FFD9C1ADFFFCFCFCFFF9F9
      F9FFF6F6F6FFF0EDEBFFB4855FFFB1825BFFAE7D57FFAB7852FFA7734DFFE7D9
      CEFFFBF9F8FFA67E60F52E180B56000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000787878FF9B9898FFFFFFFFFFCBC4
      C5FFC9C2C3FFE8E6E6FFCCC5C7FFEAE7E7FFEAE7E7FFDCD8D8FFC9C3C3FFC9C3
      C3FFFFFEFEFFFFFFFFFF767271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000787878FF9B9898FFFFFFFFFFCBC4
      C5FFC9C2C3FFE8E6E6FFCCC5C7FFEAE7E7FFEAE7E7FFDCD8D8FFC9C3C3FFC9C3
      C3FFFFFEFEFFFFFFFFFF767271FF656565FF0000000000000000000000000000
      000000000000000000000000000000000000000000000603020C824A23F3F2EA
      E5FFFAF8F6FFAD8160FF9C643CFF9F6941FFA36E46FFA6724BFFAA7750FFAD7A
      54FFF0F0F0FFF3F3F3FFF5F5F5FFF5F3F1FFF7F5F3FFFCFCFCFFFBFBFBFFF8F8
      F8FFF5F5F5FFDDCEC1FFB08059FFAE7C56FFAB7852FFA8744DFFB78F6EFFFBF9
      F7FFF3ECE8FF844B24F30603020C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000747474FF979393FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF767271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000747474FF979393FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF767271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000532D139DBB9A
      82FCFBF8F7FFE4D6CBFF9A633AFF9C653DFFA06A42FFA36E47FFA6724BFFA976
      4FFFEFEFEFFFF2F2F2FFF5F5F5FFF7F7F7FFF9F9F9FFFAFAFAFFF9F9F9FFF7F7
      F7FFEDE8E3FFB68D6BFFAC7A54FFAA7750FFA7734DFFA5724AFFE7DAD0FFFBF9
      F8FFBEA089FC542E149D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6F6FFF8F8B8BFFFFFFFFFFFFFF
      FFFFFDFFFFFFFCFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFEFFFCFEFEFFFCFE
      FFFFFDFEFFFFFFFFFFFF767272FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6F6FFF8F8B8BFFFFFFFFFFFFFF
      FFFFFDFFFFFFFCFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFEFFFCFEFEFFFCFE
      FFFFFDFEFFFFFFFFFFFF767272FF656565FF0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000A060213814A
      24EDEBE1D9FFFBF8F7FFCCB19EFF996139FF9D663DFFA06A42FFA36D46FFA571
      4AFFBA9678FFD0B8A6FFE4D8CFFFEEE9E5FFF7F6F5FFF3F0EEFFE8DED7FFD1B8
      A5FFB0815DFFAA7751FFA8754EFFA6724BFFA46F47FFD2B8A5FFFBF9F8FFEDE3
      DCFF824A25ED0A06021300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF8C8989FFF3E9E2FFFDF7
      F4FFF9EEEBFFF6EAE8FFF6EAE8FFF9EDEBFFF5E8E5FFF5E9E6FFF4E8E5FFDDC3
      BDFFDFC5C0FFFEF5F3FF777271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF8C8989FFF3E9E2FFFDF7
      F4FFF9EEEBFFF6EAE8FFF6EAE8FFF9EDEBFFF5E8E5FFF5E9E6FFF4E8E5FFDDC3
      BDFFDFC5C0FFFEF5F3FF777271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003E21
      0F75A07456F5F8F4F2FFFBF9F7FFC2A28AFF996138FF9C653DFF9F6840FFA16C
      44FFA36E47FFA5714AFFA7734CFFA8744DFFA9754EFFA9764FFFA9754FFFA875
      4EFFA7734DFFA6724BFFA46F48FFA26D45FFC8A992FFFBF9F7FFF9F5F3FFA277
      59F53F220F750000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000777777FF8F8B8AFFF1E0D5FFEBDC
      CAFFEDC3B5FFE5B5A6FFE1AD9DFFE0AE9EFFDDA194FFE3AD9FFFE0A798FFE0A6
      96FFB64C30FFF2D2C5FF787270FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000777777FF8F8B8AFFF1E0D5FFEBDC
      CAFFEDC3B5FFE5B5A6FFE1AD9DFFE0AE9EFFDDA194FFE3AD9FFFE0A798FFE0A6
      96FFB64C30FFF2D2C5FF787270FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000100
      00015E3316B1AE886CF8FAF8F6FFFBF9F7FFD1B8A7FF9A643CFF9B633BFF9D66
      3EFF9F6941FFA16B44FFA26D46FFA36E47FFA46F48FFA47048FFA47048FFA46F
      48FFA36E46FFA26C44FFA26D46FFD5BDACFFFBF9F7FFFBF8F7FFB18C71F85E34
      16B1010000010000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000868686FF989696FFF8EEE6FFF8E5
      D6FFF9E6DAFFFBE7DBFFF9E3D6FFF6DED1FFF2D9CCFFECD2C4FFE6CCC0FFE3C9
      BBFFE2C5B9FFEEDDD5FF757172FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000868686FF989696FFF8EEE6FFF8E5
      D6FFF9E6DAFFFBE7DBFFF9E3D6FFF6DED1FFF2D9CCFFECD2C4FFE6CCC0FFE3C9
      BBFFE2C5B9FFEEDDD5FF757172FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000030101066E3C1AD0AF886CF9F6F2EEFFFBF8F7FFE8DBD2FFB48C6DFF9961
      39FF9B643BFF9D663EFF9E673FFF9F6941FFA06942FFA06A42FFA06A42FF9F69
      41FF9E6840FFB99274FFE9DDD4FFFBF9F7FFF7F3EFFFB18B70F96F3C1AD00301
      0106000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007C7C7CE9888585FFA0A0A2FF9596
      98FF949597FF959598FF8E8F91FF848587FF7D7D81FF77787AFF6D6E71FF6869
      6CFF5C5E60FF59595BFF3C3636FF595858E60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007C7C7CE9888585FFA0A0A2FF9596
      98FF949597FF959598FF8E8F91FF848587FF7D7D81FF77787AFF6D6E71FF6869
      6CFF5C5E60FF59595BFF3C3636FF595858E60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000040201085C3214AD986746F4E5D7CDFFFBF8F7FFFBF9F7FFE8DC
      D3FFCAAD98FFB18666FFA77753FF9F6841FF9F6942FFA87956FFB38969FFCCAF
      9BFFE9DDD5FFFBF9F7FFFBF9F7FFE6D9D0FF9A6949F45D3215AD040201080000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007A7A7AC8787878FF828282FF6C6C
      6CFF626262FF656565FF5A5A5AFF4D4D4DFF4D4D4DFF4E4E4EFF464646FF4444
      44FF424242FF404040FF383838FF6F6F6FC80000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007A7A7AC8787878FF828282FF6C6C
      6CFF626262FF656565FF5A5A5AFF4D4D4DFF4D4D4DFF4E4E4EFF464646FF4444
      44FF424242FF404040FF383838FF6F6F6FC80000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003A1E0D6E804620F1AB8367FAE7DAD1FFFBF8
      F7FFFBF9F7FFFBF9F7FFFBF9F7FFFBF9F7FFFBF9F7FFFBF9F7FFFBF9F7FFFBF9
      F7FFFBF9F7FFE8DCD3FFAD866AFA804620F13B1F0D6E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002727272A606060C0606060D45252
      52D14B4B4BD04C4C4CD04B4B4BD0484848D1484848D14B4B4BD1474747D14646
      46D0474747D1464646D34D4D4DC72C2C2C310000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002727272A606060C0606060D45252
      52D14B4B4BD04C4C4CD04B4B4BD0484848D1484848D14B4B4BD1474747D14646
      46D0474747D1464646D34D4D4DC72C2C2C310000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000080502104A27128C80451FF19361
      40F1BE9C86FEDCC9BCFFE9DDD4FFF2EBE7FFF2EBE7FFE9DDD5FFDCCABDFFBF9E
      88FE946341F180451FF14A27128C080502100000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000020101042213
      07414F2B1296703D1BD37A431CE782481EF682481EF67A431CE7703D1BD34F2B
      1396221307410201010400000000000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000595656CA595656CA5956
      56CA595656CA595656CA595656CA595656CA595656CA595656CA595656CA5956
      56CA595656CA595656CA595656CA777777CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003F3F3FCA3F3F3FCA3F3F3FCA3F3F3FCA3F3F3FCA3F3F3FCA3F3F
      3FCA3F3F3FCA3F3F3FCA777777CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000817076CAB29FA5FFBFBFBFFFBFBF
      BFFFBFBFBFFFBFBFBFFFBD9DA7FFA78590FFD1D0D1FFBFBFBFFFBFBFBFFFBFBF
      BFFFC9B9BEFFAF949DFF595656CA777777CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFEFFFEFEFCFFFDFDFCFFFDFDFAFFFCFCF8FFFBFBF8FFFAFAF5FFF8F8
      F4FFFBFBF5FF3F3F3FCA777777CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000013421E019E894403DE0401002C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000010101040101010401010104010101040101
      0104010101040101010401010103000000000000000000000000000000000000
      00000000000000000000000000000000000000000000323232CA202121CA2323
      23CA232323CA222323CA222323CA222323CAC28498FF8F2547FF8A2646FF7D2A
      44FF7E314AFF862A47FF952E4EFF973050FF852644FF7D2F48FF802D48FF8927
      46FF932A4CFFA36176FF595656CA777777CA0000000000000000000000000000
      00000000000000000000000000000000000000000000323232CA202121CA2323
      23CA232323CA222323CA222323CA222323CA222323CA222223CA222323CA2323
      23CACCCCBBFFCBCBBAFFDCDCCBFFD2D2C1FFFBFBF8FFFAFAF5FFF8F8F4FFF7F7
      F2FFFBFBF5FF3F3F3FCA777777CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000021407005993581CE3D2C8ADFFD9C79EFF743800CD0000
      000C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001010122010101220101
      0122010101220101012201010122010101220101012201010122010101220101
      0122010101220101012201010122010101220101012201010122010101220101
      0122010101220101012201010106000000000000000000000000000000000000
      000000000000000000000000000000000000777777CA313030FF323232FF3635
      36FF363433FF363432FF383535FF383531FFC18296FFA4506AFFB0677EFFAD64
      7AFFAA5F75FFA7576EFFA14862FFAA5870FFB56F85FFAC6278FFA75970FFAA5D
      75FFAF5F79FF9D5A70FF595656CA777777CA0000000000000000000000000000
      000000000000000000000000000000000000777777CA313030FF323232FF3635
      36FF363433FF363432FF383535FF383531FF363431FF363532FF353332FF3330
      2EFFEDEDDCFFEDEDDCFFECECDBFFEBEBDAFFFAFAF5FFF8F8F4FFF7F7F2FFF6F6
      F0FFFAFAF2FF3F3F3FCA777777CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000002010022602B00BEC59E67FFD6E5EBFFD3ECFFFFDFF9FFFFD6B885FF3F1A
      009B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001010103010101080101
      010B0101010B0101010B0101010B0101010B525252FF525252FF525252FF5252
      52FF525252FF525252FF525252FF525252FF535353FF555555FF565656FF5656
      56FF565656FF565656FF565656FF565656FF565656FF565656FF565656FF5656
      56FF565656FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000474748CA605B5AFF87807BFF7D76
      70FF8D8586FF867C7DFF7E7874FF7A7470FFC18296FFA6556EFFC48D9EFFD7B0
      BCFFDAB5BFFFC18798FFA34C65FFAB5C73FFD5ABB7FFDDBAC5FFCC9DACFFBD82
      95FFB0627BFF5D3240CA595656CA777777CA0000000000000000000000000000
      000000000000000000000000000000000000474748CA605B5AFF87807BFF7D76
      70FF8D8586FF867C7DFF7E7874FF7A7470FF78726EFF726C69FF67605CFF8077
      78FFCBCBBAFFDBDBCAFFC9C9B8FFC7C7B6FFD7D7C6FFD6D6C5FFCCCCBBFFD3D3
      C2FFFAFAF2FF3F3F3FCA777777CA000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000C260E
      007B9F682FEED0CAB7FFD5EBFDFFCDE4F9FFC0BFC1FFCDD3DAFFE2FAFFFFCD9A
      57FF1C0A006A0000000000000000000000000000000600000011000000000000
      0000000000000000000000000000000000000101010301010111010101270101
      013501010138010101380101013801010138434343FFAEAFB1FFAEAFB1FFAEAF
      B1FFAEAFB1FFAEAFB1FFAEAFB1FFB1B2B3FFBDBEC0FFD1D2D3FFDDDEE0FFE0E1
      E3FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1
      E3FFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000414141CA66615FFF8C8884FF7A75
      71FF989391FF888080FF7E7876FF7B7571FFC18296FFA6556FFFC48D9EFFD7B0
      BCFFDAB5BFFFC18798FFA34C65FFAB5C73FFD5ABB7FFDDBAC5FFCC9DACFFBD82
      95FFAE5F79FF592C3BCA595656CA777777CA0000000000000000000000000000
      000000000000000000000000000000000000414141CA66615FFF8C8884FF7A75
      71FF989391FF888080FF7E7876FF7B7571FF7A736FFF736D6AFF5F5A55FF8983
      80FFECECDBFFEBEBDAFFE9E9D8FFE8E8D7FFE7E7D6FFE5E5D4FFE4E4D3FFE3E3
      D2FFF9F9EFFF3F3F3FCA777777CA000000000000000000000000000000000000
      000000000000000000000000000000000000000000000D040049773F0DD4C7AF
      8EFFD5E7F2FFD2ECFFFFC5D1DEFFBC9674FFCC8124FFC38745FFCFDDEBFFE1F0
      EEFFBB782AF90C04004500000000000000001E1C2C9748499AF6110F157A0000
      0004000000000000000000000000000000000101010801010127010101540101
      01730101017B0101017B0101017B0101017B2D2D2DFF848484FF7A7A7BFF7A7A
      7BFF7A7A7BFF7A7A7BFF7A7A7BFF818182FF9C9D9EFFC6C7C8FFE2E3E5FFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000434343CA757171FF96918EFF7E78
      74FF6E6965FF726D68FF797471FF7C7673FFC18296FFA6556FFFC48D9EFFD7B0
      BCFFDAB5BFFFC18798FFA34C65FFAB5C73FFD5ABB7FFDDBAC5FFCC9DACFFBD82
      95FFAC5D77FF562937CA595656CA777777CA0000000000000000000000000000
      000000000000000000000000000000000000434343CA757171FF96918EFF7E78
      74FF6E6965FF726D68FF797471FF7C7673FF7D7774FF77716EFF68625DFF5E59
      55FFC9C9B8FFC7C7B6FFC6C6B5FFD6D6C5FFC3C3B2FFD3D3C2FFD2D2C1FFC8C8
      B7FFF7F7EAFF3F3F3FCA777777CA000000000000000000000000000000000000
      000000000000000000000000000000000012401A00A0B6834AFFCFD4CFFFD5EE
      FFFFCADFF3FFBEB5B2FFC07E3AFFD78919FFE09F32FFDA9329FFBF8D5FFFD7EF
      FFFFDFE4D7FF8F4B0ADC00000012100F18824A55CFFF5280FDFF5377E6FF1915
      229A000000000000000000000000000000000101010B2543CBFF1D4AA9FF1D4A
      A9FF1D4AA9FF1D4AA9FF1D4AA9FF1D4AA9FF1D4AA9FF1D4AA9FF1D4AA9FF1D4A
      A9FF1D4AA9FF1D4AA9FF1D4AA9FF1D4AA9FF818182FFB9BABBFFDFE0E2FFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000474747CA7B7877FF979291FF8781
      80FF7B7876FF7D7978FF837D7BFF817B7AFFC18296FFA7566FFFC48E9FFFD8B1
      BEFFDBB6C1FFC48C9CFFA7556DFFB0667BFFD8B1BCFFDFBFC9FFD0A3B2FFC189
      9BFFAD5F78FF853A52FF595656CA777777CA0000000000000000000000000000
      000000000000000000000000000000000000474747CA7B7877FF979291FF8781
      80FF7B7876FF7D7978FF837D7BFF817B7AFF847D7AFF7E7976FF716C68FF6A66
      64FFE9E9D8FFE8E8D7FFE7E7D6FFE5E5D4FFE4E4D3FFE3E3D2FFE2E2D1FFE0E0
      CFFFF4F4E5FF3F3F3FCA777777CA000000000000000000000000000000000000
      000000000000000000011C0A006A894E17E6C4B69EFFD5EBFAFFCFE7FDFFC2C9
      D2FFBD8E5FFFCD7B13FFDC931EFFDD9A2EFFDD9C35FFE0A33EFFD99432FFC4AA
      94FFDCF8FFFFDECCA2FF573C3FE1414EC7F96591FFFF68A7FFFF4C75F8FF4E51
      B1FE020202330000000000000000000000000101010B2543CBFFA4B5FCFF9DAF
      FCFF93A7FBFF889EFBFF7D95FAFF708AFAFF6381F9FF5576F9FF486BF8FF3B61
      F8FF2F57F7FF254FF7FF1C48F6FF1D4AA9FF7A7A7BFFB6B7B8FFDFE0E2FFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000464646CA4B4848FF5E595BFF645F
      60FF615B5CFF686363FF7D7476FF706567FFC18296FFA7566FFFC48EA0FFD8B2
      BEFFDCB6C2FFC48C9CFFA7566DFFB0667CFFD8B1BCFFE0BFC9FFD1A6B3FFC48E
      A0FFAF657DFF81334CFF595656CA777777CA0000000000000000000000000000
      000000000000000000000000000000000000464646CA4B4848FF5E595BFF645F
      60FF615B5CFF686363FF7D7476FF706567FF676062FF4F484AFF3A3333FF352E
      2DFFC6C6B5FFD6D6C5FFC3C3B2FFC2C2B1FFC1C1B0FFC0C0AFFFCFCFBEFFC6C6
      B5FFF3F3E2FF3F3F3FCA777777CA000000000000000000000000000000000000
      000003010025592601BEB6936BFFD2DEE4FFD3EDFFFFC8DCF0FFBBA08DFFC477
      1CFFD8880EFFDC9521FFDB9629FFDC9A2FFFDD9D36FFDFA13EFFE3A846FFD38F
      38FFCDBFB0FF8F9CD4FF4250D6FF6894FEFF6FACFFFF4F80FFFF485AE7FF4E52
      B6FF0504053E0000000000000000000000000101010B2543CBFFA6B6FCFF9FB0
      FCFF96A9FBFF8BA1FBFF8097FAFF738DFAFF6682F9FF5878F9FF4B6DF8FF3E63
      F8FF3259F7FF2751F7FF1E49F6FF1D4AA9FF818182FFB9BABBFFDFE0E2FFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000414141CA565252FFC0BDBDFF9F9C
      9DFF9E9B9CFFA3A1A1FFAAA6A8FFA6A4A4FFC08195FFA6566FFFC48E9FFFD8B1
      BDFFDBB6C1FFC38B9BFFA7546CFFB0657AFFD7B0BCFFDFBFC9FFD1A5B3FFC38E
      9FFFAF637BFF7D2D48FF595656CA777777CA0000000000000000000000000000
      000000000000000000000000000000000000414141CA565252FFC0BDBDFF9F9C
      9DFF9E9B9CFFA3A1A1FFAAA6A8FFA6A4A4FFA4A2A3FFA09D9EFF9B999AFF9C99
      9AFFE7E7D6FFE5E5D4FFE4E4D3FFE3E3D2FFF1F1E7FFECECDFFFE8E8D9FFE6E6
      D5FFF2F2E1FF3F3F3FCA777777CA0000000000000000000000000000000A2810
      00809F6530F9C3BDAFFFD6EDFFFFCEE5FAFFBFBABBFFBE8344FFCE7805FFDA8D
      12FFD9911DFFDA9323FFDB962AFFDC9B31FFDE9E38FFDFA241FFE3A948FFE7AB
      47FF84626AFF4150D1FF6C99FFFF6EACFFFF4D82FEFF485EF0FF4B50B8FD100E
      126D00000000000000000000000000000000010101082543CBFFA7B7FCFFA0B2
      FCFF98ABFBFF8EA3FBFF8299FAFF768FFAFF6985F9FF5C7BF9FF4E70F8FF4165
      F8FF355CF7FF2953F7FF204BF6FF1D4AA9FF6F6064FF8B797EFF9F898FFFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7B7879FF868483FF1311
      10FF1B1918FF1A1818FF1A1717FF1A1818FFC3879AFFA6556FFFC48D9EFFD7B1
      BDFFDBB5C1FFC38A9BFFA6536AFFAF6379FFD7B0BBFFDFBEC9FFD0A4B2FFC38D
      9EFFAD627AFF91445BFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7B7879FF868483FF1311
      10FF1B1918FF1A1818FF1A1717FF1A1818FF1A1919FF1B1916FF191818FF1B1A
      1AFFF2F2E1FFC2C2B1FFD2D2C1FFC8C8B7FFECECDFFFE8E8D9FFE6E6D5FFE5E5
      D4FFF2F2E1FF3F3F3FCA777777CA00000000000000000F05004F70380CD7B69E
      84FFD4E6F3FFD4EEFFFFC4D0DDFFBD956EFFC77208FFD68302FFD88D12FFD88E
      18FFD9911EFFDA9425FFDB982CFFDD9B33FFDE9F3BFFE2A542FFE7AB45FF8A71
      7AFF3F4FD8FF6B99FDFF72AFFFFF4D7EFDFF465AEEFF434BB9FA0B0B0E5F0000
      000000000000000000000000000000000000010101032543CBFF2543CBFF2543
      CBFF2543CBFF2543CBFF2543CBFF2543CBFF2543CBFF2543CBFF2543CBFF2543
      CBFF2543CBFF2543CBFF2543CBFF2543CBFF323232FF383838FF4B4C4CFF5758
      58FF5A5B5BFF6E6E70FFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7B7878FFE9E6E6FFEEED
      EDFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFF9F4F6FFD2AAB7FFC794A4FFD7B0
      BCFFDBB5C0FFC3899AFFAA5B70FFB56F83FFD7AFBBFFDFBEC8FFD0A4B2FFC490
      A2FFC490A2FFF4ECEEFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7B7878FFE9E6E6FFEEED
      EDFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFEFEFFFFFFFFFFFFFFFFFFF4F2
      F2FFF5F5EEFFF4F4ECFFF1F1E7FFECECDFFFE8E8D9FFE6E6D5FFB5B5A4FFB5B5
      A4FFB5B5A4FF3F3F3FCA777777CA00000000220E0075A57449FFC8CECDFFD7F0
      FFFFCBE0F4FFBDACA3FFC07623FFD27900FFD78707FFD6890FFFD78B13FFD88E
      19FFD99220FFDB9527FFDC992EFFDD9D35FFE1A23CFFE6A83FFF8E7271FF3F50
      D8FF6F9CFFFF73B0FFFF4D7EFDFF455AF0FF4A53CCFF5E4138DB0000000F0000
      0000000000000000000000000000000000000000000001010103010101080101
      010B0101010B0101010B0101010B0101010B525252FFF4F4F4FFDFE0E2FFB1A3
      A7FFB1A3A7FFB1A3A7FF393939FF6E5952FF6F5B53FF69544FFF735E56FF7963
      5BFF7B655DFF76625BFF4F383CFFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA807A7AFFEDEBEBFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC490A2FFC490
      A2FFC490A2FFC490A2FFC490A2FFC490A2FFC490A2FFC490A2FFC490A2FFC490
      A2FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA807A7AFFEDEBEBFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
      FFFFF2F2E1FFF1F1E7FFECECDFFFE8E8D9FFE6E6D5FFE5E5D4FFC7C7B6FFFFFF
      FEFFA3A378FF3F3F3FCA777777CA00000000803F0EE7C9D5DAFFD3EEFFFFC2C5
      CEFFBD864CFFCA7001FFD58000FFD58506FFD5870BFFD68910FFD78C15FFD890
      1BFFDA9322FFDB9629FFDC9A30FFDF9E36FFE5A43AFF8A6F75FF4254DBFF72A1
      FFFF70ADFFFF4E84FEFF465BF0FF4148C3FFA2B1D9FFE0C999FF401B009A0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFFAFB0B1FF555555FF9DA28FFFA0A38FFF898C7CFF858777FF8A8C
      7CFF868878FF9B9E8BFFAAAE99FF60615FFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA807A7AFFFAF9F8FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF8F8F8FF948E8FFF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA807A7AFFFAF9F8FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF2F2E1FFF6F6EAFFF2F2E1FFF2F2E1FFF2F2E1FFF2F2E1FFD3D3C2FFA7A7
      7CFFA7A77CFF000000000000000000000000532504BBB2ABA5FFBEA086FFC473
      12FFD37A00FFD58300FFD48303FFD58507FFDA8A0CFFDE8F11FFE09217FFE095
      1DFFDD9624FFDC972BFFDD9B31FFE3A137FF8D7170FF3E50DBFF6092FFFF70AD
      FFFF4D81FEFF475EF1FF434CCAFF916F6EFFCEBEAEFFE1FDFFFFD1A971FF290F
      007E000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFBAAB
      AFFF8F797FFF432C31FF77625BFF806B62FF816D65FF755F58FF69534DFF6C56
      50FF68524CFF745F57FF826F65FF7D6860FF4F383DFFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA827B7CFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FDFFFFFFFFFFFFFFFFFF8F8B8BFF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA827B7CFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FDFFFFFFFFFFFFFFFFFF8F8B8BFF3F3F3FCA0000000000000000000000000000
      00000000000000000000000000000000000010060052AE5A0AFFD17801FFD581
      00FFD38100FFD58201FFDC8802FFD58506FFBB760EFFA96D12FFA76D15FFB076
      1BFFCC8A23FFE29C2CFFE6A233FFD89A37FF604F76FF456BF1FF559AFFFF4E81
      FDFF465EF3FF424BCCFF998384FFF2C373FFD19A5EFFCACFD6FFE2F8FDFFC084
      40FA0A0300400000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFEAEB
      EDFF424243FF6F7267FFA5A894FFACAE9AFFB0B59EFF999D89FF848677FF8687
      78FF828675FF9A9D8AFFAEB19DFFABAE9AFF6B6C67FFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA848181FFFBF9F8FFCDCC
      CCFFEAE9E9FFEAE9E9FFD4D1D2FFCCCACBFFCBC9C9FFCCCACBFFCCCACBFFDDDA
      DAFFFFFFFFFFFFFFFFFF888485FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA848181FFFBF9F8FFCDCC
      CCFFEAE9E9FFEAE9E9FFD4D1D2FFCCCACBFFCBC9C9FFCCCACBFFCCCACBFFDDDA
      DAFFFFFFFFFFFFFFFFFF888485FF3F3F3FCA0000000000000000000000000000
      000000000000000000000000000000000000000000002811007BD07C00FFD483
      00FFD78400FFD58200FF9B6310FF624622FF503E2FFF4C3932FF4F3D38FF4E3D
      33FF4E3C28FF775627FFB37E2FFFB9916DFFC8AEA5FF63619EFF4669F5FF465B
      F1FF424AC7FF9A8381FFF2C26FFFEDC27CFFECC07AFFCB9969FFD0DFECFFE1EE
      E9FF8C531ADC0100001B00000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFBAAB
      AFFF86777CFF6C5751FF7D6860FF816B64FF7B655DFF6C564FFF68514BFF735E
      56FF79645CFF7F6A61FF806A62FF7F6B62FF7D6760FF51393EFFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA83807EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF817C7DFF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA83807EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF817C7DFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000592A00B4DA85
      00FFCC7B00FF6F4A16FF433732FF75594DFFB58B75FFD0A290FFD4A696FFCA9D
      8BFF9B7766FF5D4941FF4C4039FF907772FFFFFBF7FFC8B1A4FF574C90FF3E48
      C5FF957E80FFF0BE6AFFEBBE75FFEAC07CFFEDC887FFEABB78FFC49F80FFD8F2
      FFFFDDD8BDFF622E02BD00000004000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFEAEB
      EDFF515253FF999D8BFFAFB49EFFB7BCA5FF999D89FF858778FF818274FFB3B8
      A1FFACB09AFFABAF9AFFAAAC99FFACB09AFFA8AC98FF5D5D5EFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000404040CA7D7877FFFFFFFFFFCECC
      CDFFCDCBCCFFD5D3D4FFFFFFFFFFFFFFFFFFCBC9CAFFCDCBCBFFCDCBCCFFCDCB
      CCFFFFFFFFFFFFFFFFFF797575FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000404040CA7D7877FFFFFFFFFFCECC
      CDFFCDCBCCFFD5D3D4FFFFFFFFFFFFFFFFFFCBC9CAFFCDCBCBFFCDCBCCFFCDCB
      CCFFFFFFFFFFFFFFFFFF797575FF3F3F3FCA0000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000011703A
      00CC63461DFF51403AFFB68A74FFE2B4A1FFE3B9A8FFDEB4A3FFDCB1A0FFDCAF
      A0FFE2B5A5FFD7A896FF947263FF4F4239FF856D64FFD7B8B1FF9F7C6CFFA284
      6BFFECBA66FFEABC70FFEABE77FFEBC17EFFECC486FFF0CD90FFE2B171FFC2A8
      94FFDDF9FFFFD9C298FF2F130086000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFF9982
      87FF4E373CFF766159FF614A46FF624B46FF644E48FF66504AFF614A46FF816D
      64FF7F6A62FF7F6A62FF806B62FF7B655DFF7C675FFF50383DFFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000434343CA837E7EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFAFFFFFEFDFFFFFFFFFFFDFB
      FAFFFFFFFFFFFFFFFFFF767272FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000434343CA837E7EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFAFFFFFEFDFFFFFFFFFFFDFB
      FAFFFFFFFFFFFFFFFFFF767272FF3F3F3FCA0000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000150E
      0B99534036FFC1947DFFE6BCAAFFDCB1A0FFD5A594FFD3A191FFD2A191FFD2A2
      92FFD4A393FFD7A799FFDEAC9DFF947262FF3C2F28FF8A6850FFDEAB5DFFF0BA
      61FFE8B86AFFE9BB72FFEABF79FFEBC281FFEDC787FFEEC98DFFF2D297FFDCA8
      6CFFC5B8B0FFE2FFFFFFD0A86FFF110700530000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFEAEB
      EDFF6C6D6EFF7A645EFF8B8C7CFF88897AFF898B7BFF898B7BFF818273FFB0B3
      9EFFAFB39EFFAEB29CFFA6A894FF9EA08DFFA5AA96FF626263FFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000474747CA8C8989FFFFFFFFFFCDCC
      CCFFEAE9EAFFEAE9EAFFDDDADAFFCCCACBFFCCCACAFFD5D1D2FFEAE9EAFFCDCB
      CBFFFFFFFFFFFFFFFFFF757271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000474747CA8C8989FFFFFFFFFFCDCC
      CCFFEAE9EAFFEAE9EAFFDDDADAFFCCCACBFFCCCACAFFD5D1D2FFEAE9EAFFCDCB
      CBFFFFFFFFFFFFFFFFFF757271FF3F3F3FCA0000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000026382D
      28F0A27966FFE8BEABFFDAAE9CFFD3A18FFFD3A190FFD4A493FFD5A595FFD5A6
      96FFD5A697FFD4A597FFD5A698FFD9A899FF685248FF69502FFFEBB55DFFE7B6
      66FFE7B86DFFE9BC74FFEAC07BFFECC383FFEDC889FFEECA8FFFEFCE95FFF3D3
      9AFFD29E6BFFCED4DAFFE4F0DFFF824505D50000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFA58E
      94FF654D52FF654E4FFF77615AFF66504AFF69534DFF6B554FFF68524DFF705A
      53FF715D55FF6D5851FF725E56FF79635CFF553F40FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA9B9797FFFEFEFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFDFEFFFDFD
      FEFFFFFFFFFFFFFFFFFF767171FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA9B9797FFFEFEFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFDFEFFFDFD
      FEFFFFFFFFFFFFFFFFFF767171FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000100C09905C48
      40FDCBA192F8DCB19EFFD29F8DFFD4A291FFD6A796FFD8AB9BFFD9AE9EFFDAAF
      9FFFD9AE9FFFD8AC9DFFD6A89AFFDCAC9FFFAE8778FF45372CFFC49853FFEDBB
      69FFE8BA6EFFE9BD76FFEBC17DFFECC485FFEDC88BFFEECB91FFEFCE96FFF1D2
      9CFFF1CF97FFCFA57EFF94755BDF140800590000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFF666668FFA0A492FFA8AC97FF888A7BFF888A7AFF888A7AFF8687
      78FF999C89FFB5B9A3FFAEB39EFFA4A995FF5F5F60FFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA9B9898FFFFFFFFFFCBC4
      C5FFC9C2C3FFE8E6E6FFCCC5C7FFEAE7E7FFEAE7E7FFDCD8D8FFC9C3C3FFC9C3
      C3FFFFFEFEFFFFFFFFFF767271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA9B9898FFFFFFFFFFCBC4
      C5FFC9C2C3FFE8E6E6FFCCC5C7FFEAE7E7FFEAE7E7FFDCD8D8FFC9C3C3FFC9C3
      C3FFFFFEFEFFFFFFFFFF767271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000201812D07059
      56E9B79694E5D2A08EFFD3A390FFD6A997FFDAB09EFFDDB5A4FFDFB8A9FFDFBA
      AAFFDEB8AAFFDCB5A6FFDAB0A2FFD9AC9FFFCFA193FF503F37FF88693EFFEFBD
      6CFFE9BB71FFEABF78FFEBC280FFECC586FFEDC98CFFEFCC92FFF0CE97FFF0D0
      9BFFF3D6A2FFF2D39FFF4F2D11A7000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFA58E
      94FFA58E94FFA58E94FF533B40FF77625CFF776259FF6E5852FF6B554FFF888A
      7AFF6D5851FF79655CFF7B655EFF513A3FFFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000484848CA979393FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF767271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000484848CA979393FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF767271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000005281F1AD7886D
      6AEE9E8384D5B48983EED5A694FFDAB09EFFDFB8A7FFE2BFAFFFE5C4B5FFE5C7
      B6FFE4C4B4FFE1BEB0FFDEB7A9FFDAB0A3FFDCAEA0FF685048FF60492DFFEDBD
      6DFFE9BC73FFEABF7AFFECC382FFEDC788FFEECA8EFFEFCD93FFEFCF98FFF0D1
      9DFFF5DAA8FFF3D7A4FF83542DCE000000080000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFF68686AFF797B78FF9BA08EFFA9AD98FFA9AD
      98FFA0A391FF82857DFF626263FFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000454545CA8F8B8BFFFFFFFFFFFFFF
      FFFFFDFFFFFFFCFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFEFFFCFEFEFFFCFE
      FFFFFDFEFFFFFFFFFFFF767272FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000454545CA8F8B8BFFFFFFFFFFFFFF
      FFFFFDFFFFFFFCFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFEFFFCFEFEFFFCFE
      FFFFFDFEFFFFFFFFFFFF767272FF3F3F3FCA0000000000000000000000000000
      000000000000000000000000000000000000000000000000000529201AD78B70
      6DF09C7F7FD6977879D9C49B91F5DDB5A3FFE3C0AFFFE7CAB9FFEBD1C0FFEBD2
      C2FFE9CFC0FFE6C8B9FFE1BEB1FFDCB5A8FFDFB2A6FF705851FF5B472DFFEDBD
      6EFFEABD75FFEAC07CFFECC383FFEDC88AFFEECB90FFEFCD94FFF2D49EFFF5DB
      A8FFD2A36CFA321907870000000E000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FF664E53FF5C454AFF543C42FF523B
      40FF5A4248FF654D52FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000464646CA8C8989FFF3E9E2FFFDF7
      F4FFF9EEEBFFF6EAE8FFF6EAE8FFF9EDEBFFF5E8E5FFF5E9E6FFF4E8E5FFDDC3
      BDFFDFC5C0FFFEF5F3FF777271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000464646CA8C8989FFF3E9E2FFFDF7
      F4FFF9EEEBFFF6EAE8FFF6EAE8FFF9EDEBFFF5E8E5FFF5E9E6FFF4E8E5FFDDC3
      BDFFDFC5C0FFFEF5F3FF777271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000004271E19D57F63
      60EC9C7A7AD7977A7AD8A38585DDD3AEA3FAE6C5B4FFEBD1C0FFEFDACAFFF0DC
      CDFFEED7C9FFE9CEC0FFE3C3B6FFDFB9ACFFDBB0A2FF614C44FF6D5435FFEFC0
      72FFEABE77FFEBC17EFFECC585FFEDC88BFFEFCD93FFF4D7A0FFE9C18BFF7349
      24C3070300370000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA8F8B8AFFF1E0D5FFEBDC
      CAFFEDC3B5FFE5B5A6FFE1AD9DFFE0AE9EFFDDA194FFE3AD9FFFE0A798FFE0A6
      96FFB64C30FFF2D2C5FF787270FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA8F8B8AFFF1E0D5FFEBDC
      CAFFEDC3B5FFE5B5A6FFE1AD9DFFE0AE9EFFDDA194FFE3AD9FFFE0A798FFE0A6
      96FFB64C30FFF2D2C5FF787270FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000241D19BE6F59
      54EF977575D69A7B7BD99B8182D7AE9593E2E2C3B4FEECD5C3FFF2DECEFFF3E1
      D2FFEFDACCFFEAD0C2FFE5C5B8FFE3BDB1FFC9A194FF493A33FFA5834EFFF1C2
      75FFEABE79FFEBC280FFECC587FFF0CF93FFEFCD94FFA57747E2180A01600000
      0002000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      000000000000000000000000000000000000535353CA989696FFF8EEE6FFF8E5
      D6FFF9E6DAFFFBE7DBFFF9E3D6FFF6DED1FFF2D9CCFFECD2C4FFE6CCC0FFE3C9
      BBFFE2C5B9FFEEDDD5FF757172FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000535353CA989696FFF8EEE6FFF8E5
      D6FFF9E6DAFFFBE7DBFFF9E3D6FFF6DED1FFF2D9CCFFECD2C4FFE6CCC0FFE3C9
      BBFFE2C5B9FFEEDDD5FF757172FF3F3F3FCA0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000705045F6355
      4FFD856766D59F7E7EDA9D8282D99E8889D7BEA6A2E9E9CFBEFFEFDACAFFF0DC
      CDFFEDD7C9FFE9CEC0FFE3C3B6FFE9C1B5FF95766BFF4D3D2EFFDBAD65FFECBF
      75FFEABF7AFFEDC785FFF2D193FFE0AE70FF42220A9B00000012000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000005A5A5ACA888585FFA0A0A2FF9596
      98FF949597FF959598FF8E8F91FF848587FF7D7D81FF77787AFF6D6E71FF6869
      6CFF5C5E60FF59595BFF3C3636FF727171FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A5A5ACA888585FFA0A0A2FF9596
      98FF949597FF959598FF8E8F91FF848587FF7D7D81FF77787AFF6D6E71FF6869
      6CFF5C5E60FF59595BFF3C3636FF474747CA0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000D352D
      28D66F5955E9977777D59D8181D9A08787D9A39090D8CCB2AAF1EACFBFFFEBD3
      C3FFE9CFC0FFE5C8BAFFE8C4B8FFCDA798FF4C3E37FF8B6C43FFF0BF70FFEABE
      76FFEFC985FFE8BC7BFF805025CE0A0400400000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6ECA787878FF828282FF6C6C
      6CFF626262FF656565FF5A5A5AFF4D4D4DFF4D4D4DFF4E4E4EFF464646FF4444
      44FF424242FF282828CA232323CAA6A6A6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6ECA787878FF828282FF6C6C
      6CFF626262FF656565FF5A5A5AFF4D4D4DFF4D4D4DFF4E4E4EFF464646FF4444
      44FF292929CA282828CA383838FF686868CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000403
      025042362EFD6A5350E1997B7BD5A28787DA9F8787D8A38E8ED9D2B3AAF6E5C5
      B6FFE5C4B7FFEAC7B9FFD4AE9FFF604E46FF5C4935FFDEAE63FFEEC277FFEBC0
      79FFB37D42EC1D0E026A00000007000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF565656FF01010109000000000000000000000000000000000000
      00000000000000000000000000000000000000000000626262CA565656CA4F4F
      4FCA4B4B4BCA4D4D4DCA4B4B4BCA494949CA494949CA4A4A4ACA494949CA4848
      48CA494949CA474747CA535353CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000626262CA565656CA4F4F
      4FCA4B4B4BCA4D4D4DCA4B4B4BCA494949CA494949CA4A4A4ACA494949CA4848
      48CA494949CA474747CA535353CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000009060570443831FF66514CEA8A6E6DD59D8282D6A08787D5AB908FDCDEB7
      ABFBE0B8AAFEB79585FF56463EFF4F3D2CFFCC9F59FFF2C474FFDFAA61FF542D
      0EAD0200001D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FFFFFFFFFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE0E1E3FF565656FF01010106000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000402024B281F19DA4B3B34FE6E5954F6806864F6836B68F77F65
      5FFB665146FF403026FD715735FFD7AB5DFFECB764FF895422D50E06004C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000565656FF565656FF565656FF5656
      56FF565656FF565656FF565656FF565656FF565656FF565656FF565656FF5656
      56FF565656FF565656FF565656FF565656FF565656FF565656FF565656FF5656
      56FF565656FF565656FF01010103000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000C0503035716110EA51E1712C11F1712C21A14
      10BA0B0807850301003D6A3C11C3C0772EF62913037C00000007000000000000
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
      0000000000001515158615151586151515861515158615151586151515861515
      1586151515861515158615151586343434860000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007777
      77CA777777CA323232CA323232CA323232CA323232CA323232CA323232CA3232
      32CA323232CA323232CA777777CA777777CA0000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000505050FF505050FF505050FF505050FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003E779ECA70C4FCFF62869DCA66879DCA5E849DCA4A7999CA467A9CCA497B
      9DCA57819DCA56819DCA15151586343434860000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007777
      77CA9F9F9FCA757575CA494F3BFF02291FFF001C08FF001C08FF001C08FF001C
      08FF001C08FF627A6AFF323232CA777777CA0000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF688EB1FF658C
      AFFF628AAEFF6087ACFF5D85ABFF5A83AAFF5881A8FF557EA7FF537DA6FF507B
      A4FF4E79A3FF4C77A2FF4976A1FF4774A0FF45739FFF43719EFF42709DFF406F
      9CFF3E6D9BFF505050FF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000505050FF000000000000
      00000000000000000000505050FFD6C484FFD6C382FF505050FF000000000000
      00000000000000000000505050FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000323232CA202121CA2323
      23CA232323CA222323CA222323CA222323CA222323CA222223CA222323CA2323
      23CA52809ECA91D2FDFF99D5FCFFA2D7F9FF94C6E8FF86AFCCFF80B9E0FF74C6
      FDFF3F789ECA82CCFDFF15151586343434860000000000000000000000000000
      00000000000000000000000000000000000000000000323232CA202121CA2323
      23CA232323CA222323CA222323CA222323CA222323CA222223CA222323CA2323
      23CABABABAFFADABAAFF9CAF76FF30A076FF518718FF4D8512FF4C8510FF4B84
      0CFF488307FF193B05FF323232CA777777CA0000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF6C91B3FF6A8F
      B1FF678DB0FF648BAEFF6188ADFF5E86ACFF5C84AAFF5982A9FF5680A8FF547D
      A6FF517CA5FF4F7AA4FF4D78A3FF4A76A1FF4875A0FF46739FFF44729EFF4270
      9DFF416F9CFF505050FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000676767FFDCCD95FF505050FF0000
      00000000000000000000505050FFD7C587FFD6C484FF505050FF000000000000
      000000000000505050FFD2BE77FF505050FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFBFBFFF313030FF323232FF3635
      36FF363433FF363432FF383535FF383531FF363431FF363532FF353332FF3330
      2EFF5D849ECAA2D9FCFF99D6FCFF8AC5EBFF8FA6B6FF828A90FF7AA4BFFF5DBD
      FDFF3F789DCA42799DCA15151586343434860000000000000000000000000000
      000000000000000000000000000000000000777777CA313030FF323232FF3635
      36FF363433FF363432FF383535FF383531FF363431FF363532FF353332FF3330
      2EFF9A9897FFDBD8D5FF515C3BFF707566FF69774DFF5E7434FF5A722AFF5370
      1AFF4C6E08FF6A8954FF323232CA777777CA0000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF7194B5FF6E92
      B4FF6B90B2FF688EB1FF658CAFFF6289AEFF6087ACFF5D85ABFF5A83A9FF5781
      A8FF557EA7FF527DA6FF507BA4FF4E79A3FF4B77A2FF4976A1FF4774A0FF4573
      9FFF43719EFF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000676767FFDECF9AFFDDCE98FFDCCD95FF5050
      50FF00000000505050FFD9C88BFFD8C789FFD7C587FFD6C484FF505050FF0000
      0000505050FFD4C07BFFD3BF79FFD2BE77FF505050FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000737374FF605B5AFF87807BFF7D76
      70FF8D8586FF867C7DFF7E7874FF7A7470FF78726EFF726C69FF67605CFF8077
      78FF66889ECA94D1F7FF89BDDFFFA6B6C1FF999A9CFF83888CFF58ACE3FF69C1
      FBFF29A8FCFF32739DCA15151586343434860000000000000000000000000000
      000000000000000000000000000000000000474748CA605B5AFF87807BFF7D76
      70FF8D8586FF867C7DFF7E7874FF7A7470FF78726EFF726C69FF67605CFF8077
      78FFC7C5C4FF747270FFA78A65FF2E674FFF693A00FF673A00FF673900FF6539
      00FF643900FF583C12FF323232CA777777CA2341CBFF1B48A9FF1B48A9FF1B48
      A9FF1B48A9FF1B48A9FF1B48A9FF1B48A9FF1B48A9FF1B48A9FF1B48A9FF1B48
      A9FF1B48A9FF1B48A9FF1B48A9FF668DB0FF648AAEFF37ABDAFF4091B9FF408F
      B8FF5982A9FF5680A7FF547DA6FF517CA5FF3A95C5FF408EB6FF408EB6FF4875
      A0FF46739FFF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000676767FFDFD19DFFDECF9AFFDDCE98FFDCCD
      95FF505050FFDACB90FFDAC98EFFD9C88BFFD8C789FFD7C587FFD6C484FF5050
      50FFD5C280FFD4C17DFFD4C07BFFD3BF79FF505050FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000686868FF66615FFF8C8884FF7A75
      71FF989391FF888080FF7E7876FF7B7571FF7A736FFF736D6AFF5F5A55FF8983
      80FF6C8A9DCA99B7CBFFB0B4B6FFDFDFDFFFC9C9C9FF8199A9FF32A8F6FF73C6
      FBFF50B8FCFF527F9DCA15151586343434860000000000000000000000000000
      000000000000000000000000000000000000414141CA66615FFF8C8884FF7A75
      71FF989391FF888080FF7E7876FF7B7571FF7A736FFF736D6AFF5F5A55FF8983
      80FF656464FFD4D2D0FFC79D6EFFB8C9ADFFDEAC68FFDBA55BFFDA9F50FFD899
      45FFD79239FF6E4812FF323232CA777777CA2341CBFFA4B5FCFF9DAFFCFF93A7
      FBFF889EFBFF7B95FAFF6E8AFAFF6180F9FF5374F9FF4669F8FF395FF8FF2D55
      F7FF234DF7FF1A46F6FF1B48A9FF6B90B2FF688EB1FF36A9D8FF48E5FFFF41D4
      F6FF4090B8FF418FB8FF4898C4FF3BA4D3FF38CAF6FF38D5FFFF408EB6FF4B77
      A2FF4976A1FF505050FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000676767FFDFD19DFFDECF9AFFDDCE
      98FFDCCD95FFDBCC93FFDACB90FFDAC98EFFD9C88BFFD8C789FFD7C587FFD6C4
      84FFD6C382FFD5C280FFD4C17DFF505050FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006C6C6CFF757171FF96918EFF7E78
      74FF6E6965FF726D68FF797471FF7C7673FF7D7774FF77716EFF68625DFF5E59
      55FF748E9ECAB7CAD7FFC7C7C8FFD0D0D0FFE3E3E3FFA0ADB6FF71ABCFFF4AA9
      E8FF59BAF9FF56819DCA15151586343434860000000000000000000000000000
      000000000000000000000000000000000000434343CA757171FF96918EFF7E78
      74FF6E6965FF726D68FF797471FF7C7673FF7D7774FF77716EFF68625DFF5E59
      55FFD9D6D5FF9C9896FF3B3946FF001D28FF00001CFF00001DFF00001DFF0000
      1DFF00001DFF626281FF323232CA777777CA2341CBFFA6B6FCFF9FB0FCFF96A9
      FBFF8BA1FBFF7E97FAFF718DFAFF6482F9FF5676F9FF496BF8FF3C61F8FF3057
      F7FF254FF7FF1C47F6FF1B48A9FF6F93B4FF6F94B5FF459ECBFF47DEFBFF48E6
      FFFF44E2FFFF3DCBF2FF3CC9F2FF3EDBFFFF3CDAFFFF39D0FBFF3F93BFFF537D
      A6FF4C78A2FF505050FF00000000000000000000000000000000000000000000
      0000505050FF505050FF0000000000000000676767FFDFD29FFFDFD19DFFDECF
      9AFFDDCE98FFDCCD95FFDBCC93FFDACB90FFDAC98EFFCBBB85FFCABA83FFCAB9
      81FFC9B87EFFD6C382FFD5C280FF505050FF0000000000000000505050FF5050
      50FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000727272FF7B7877FF979291FF8781
      80FF7B7876FF7D7978FF837D7BFF817B7AFF847D7AFF7E7976FF716C68FF6A66
      64FF748E9ECAC5DFF1FFC2C6C9FFC7C7C7FFE2E2E2FFB4B3B4FF818284FF828C
      93FF80A9C3FF487B9DCA15151586343434860000000000000000000000000000
      000000000000000000000000000000000000474747CA7B7877FF979291FF8781
      80FF7B7876FF7D7978FF837D7BFF817B7AFF847D7AFF7E7976FF716C68FF6A66
      64FF888686FF9C9A98FF8A82ADFF387CA6FF54158FFF52128FFF51108FFF500E
      8FFF4D0C8CFF1D0565FF323232CA777777CA2341CBFFA7B7FCFFA0B2FCFF98AB
      FBFF8EA3FBFF8299FAFF748FFAFF6785F9FF5A79F9FF4C6EF8FF3F63F8FF335A
      F7FF2751F7FF1E49F6FF1B48A9FF7496B7FF7194B5FF4D9DCAFF47D8F6FF49E6
      FFFF46E2FFFF45E2FFFF43E0FFFF40DBFFFF3DDAFFFF3ACCF6FF4799C7FF527C
      A5FF507BA4FF505050FF00000000000000000000000000000000000000006767
      67FFE4D9AEFFE4D8ACFF505050FF505050FFE1D4A4FFE0D3A2FFDFD29FFFDFD1
      9DFFDECF9AFFDDCE98FFDCCD95FFDBCC93FFCDBD8AFFB0A47AFFAFA479FFAFA3
      77FFBCAF7BFFC9B87EFFD6C382FFD5C280FF505050FF505050FFD3BF79FFD2BE
      77FF505050FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF4B4848FF5E595BFF645F
      60FF615B5CFF686363FF7D7476FF706567FF676062FF4F484AFF3A3333FF352E
      2DFF708B9ECAC2E4FBFFBBC9D3FFDCDCDDFFDEDEDEFF8A8A8AFF858F95FF8BAB
      C0FF82C0EAFF467B9DCA15151586343434860000000000000000000000000000
      000000000000000000000000000000000000464646CA4B4848FF5E595BFF645F
      60FF615B5CFF686363FF7D7476FF706567FF676062FF4F484AFF3A3333FF352E
      2DFF9A9897FFDAD6D8FF65388EFFA56DC6FFA75CCEFF9F4DCDFF9B44CDFF993E
      CEFF8D33C2FF401C80FF323232CA777777CA2341CBFF2341CBFF2341CBFF2341
      CBFF2341CBFF2341CBFF2341CBFF2341CBFF2341CBFF2341CBFF2341CBFF2341
      CBFF2341CBFF2341CBFF2341CBFF789AB9FF7598B7FF63A3C9FF48CEEEFF53EB
      FFFF4CE4FFFF46E2FFFF44DFFFFF42DDFFFF40DEFFFF39C2EEFF5B9CC3FF5680
      A7FF537DA6FF505050FF00000000000000000000000000000000676767FFE6DB
      B3FFE5DAB1FFE4D9AEFFE4D8ACFFE3D7A9FFE2D5A7FFE1D4A4FFE0D3A2FFDFD2
      9FFFDFD19DFFDECF9AFFDDCE98FFDCCD95FFDBCC93FFDACB90FFDAC98EFF938B
      6CFF928A6BFFBCAF7BFFC9B87EFFD6C382FFD5C280FFD4C17DFFD4C07BFFD3BF
      79FFD2BE77FF505050FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000686868FF565252FFC0BDBDFF9F9C
      9DFF9E9B9CFFA3A1A1FFAAA6A8FFA6A4A4FFA4A2A3FFA09D9EFF9B999AFF9C99
      9AFF63869DCAB2DFFDFFB3D5EBFFB0B8BEFFA8B5BDFF9DBFD5FF9CCFF1FF8FD0
      FCFF7AC9FDFF41789ECA15151586343434860000000000000000000000000000
      000000000000000000000000000000000000414141CA565252FFC0BDBDFF9F9C
      9DFF9E9B9CFFA3A1A1FFAAA6A8FFA6A4A4FFA4A2A3FFA09D9EFF9B999AFF9C99
      9AFFC9C6CCFF4D477CFF1E5B8FFF0D94ACFF302B85FF46067EFF46067EFF4606
      7CFF3F1977FFAEA9C5FF777777CA000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF8DA9C3FF8AA7
      C2FF87A4C0FF84A2BEFF81A0BDFF7D9DBBFF7A9BBAFF4CA1CDFF61E1F7FF64EE
      FFFF5BE8FFFF52E5FFFF49E1FFFF43DFFFFF42DFFFFF3DD0F6FF408FB7FF5A83
      A9FF5781A8FF505050FF00000000000000000000000000000000000000006767
      67FFE6DBB3FFE5DAB1FFE4D9AEFFE4D8ACFFE3D7A9FFE2D5A7FFE1D4A4FFE0D3
      A2FFDFD29FFFDFD19DFF787878FF787878FF787878FF787878FFDACB90FFDAC9
      8EFFD9C88BFF7E7863FFBCAF7BFFC9B87EFFD6C382FFD5C280FFD4C17DFFD4C0
      7BFF676767FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF7B7879FF868483FF1311
      10FF1B1918FF1A1818FF1A1717FF1A1818FF1A1919FF1B1916FF191818FF1B1A
      1AFF5C839DCA68889DCA6C8A9DCA637F8FCA678599CA62869ECA5A839ECA507F
      9ECA467B9ECA3B779ECA00000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7B7879FF868483FF1311
      10FF1B1918FF1A1818FF1A1717FF1A1818FF1A1919FF1B1916FF191818FF1B1A
      1AFF3C3267FF181A64FF0E4E81FF113973FF1D1367FF1D1266FF1E1265FF1715
      61FFAAAAC2FF777777CA00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF92ACC5FF8EAA
      C4FF8BA8C2FF88A5C1FF85A3BFFF82A1BEFF49A0CCFF72E3F5FF83F6FFFF78EF
      FFFF6FEDFFFF63EAFFFF57E5FFFF4AE2FFFF43DFFFFF42E0FFFF3DCEF4FF408F
      B7FF5B84AAFF505050FF00000000000000000000000000000000000000000000
      0000676767FFE6DBB3FFE5DAB1FFE4D9AEFFE4D8ACFFE3D7A9FFE2D5A7FFE1D4
      A4FFE0D3A2FF787878FF00000000000000000000000000000000787878FFDACB
      90FFDAC98EFFD9C88BFF7E7863FFBCAF7BFFC9B87EFFD6C382FFD5C280FF6767
      67FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF7B7878FFE9E6E6FFEEED
      EDFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFEFEFFFFFFFFFFFFFFFFFFF4F2
      F2FFE9E8E8FFE1DFDFFF878384FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7B7878FFE9E6E6FFEEED
      EDFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFEFEFFFFFFFFFFFFFFFFFFF4F2
      F2FFE9E8E8FFE1DFDFFF878384FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF96B0C9FF93AD
      C7FF90ABC5FF8DA9C3FF8AA6C1FF51A4CEFF86E6F5FFA2FEFFFF99F6FFFF90F4
      FFFF85F1FFFF76EEFFFF67EAFFFF57E5FFFF4AE2FFFF44DFFFFF43E2FFFF3DCE
      F4FF408FB7FF505050FF00000000000000000000000000000000000000000000
      000000000000676767FFE6DBB3FFE5DAB1FFE4D9AEFFE4D8ACFFE3D7A9FFE2D5
      A7FF787878FF0000000000000000000000000000000000000000000000007878
      78FFDACB90FFDAC98EFFD9C88BFF7E7863FFCAB981FFD6C484FF505050FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF807A7AFFEDEBEBFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
      FFFFF4F4F4FFE7E6E7FF918C8CFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA807A7AFFEDEBEBFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
      FFFFF4F4F4FFE7E6E7FF918C8CFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF9AB3CBFF97B1
      C9FF94AEC8FF91ACC5FF69A9CFFF69CAE5FFA4F4FAFFAEF7FEFFB5FCFFFFAFFC
      FFFF9BF5FFFF8AF1FFFF77EEFFFF65EAFFFF56E9FFFF48E3FFFF43DCFCFF40D6
      F9FF38B6E3FF558BA6FF00000000000000000000000000000000000000000000
      0000505050FFE8DEB8FFE7DCB6FFE6DBB3FFE5DAB1FFE4D9AEFFE4D8ACFF5050
      50FF000000000000000000000000000000000000000000000000000000000000
      0000787878FFDACB90FFDAC98EFF7E7863FFBCAF7BFFCAB981FFD6C484FF5050
      50FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF807A7AFFFAF9F8FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF8F8F8FF948E8FFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA807A7AFFFAF9F8FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF8F8F8FF948E8FFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF9FB6CDFF9CB4
      CCFF99B2CAFF96B0C9FF9AB8D1FF73AED1FF62A8CFFF5BA8D0FF54B2DAFF74CB
      E7FFAFF8FFFF9DF6FFFF87F2FFFF71EDFFFF46BFE5FF37A9D8FF449FCDFF559F
      C9FF63A2C9FF505050FF000000000000000000000000505050FF505050FF5050
      50FFE9E0BDFFE9DFBBFFE8DEB8FFE7DCB6FFE6DBB3FFE5DAB1FF505050FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000787878FFDACB90FFDAC98EFF928A6BFFCABA83FFD7C587FFD6C4
      84FF505050FF505050FF505050FF000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF827B7CFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FDFFFFFFFFFFFFFFFFFF8F8B8BFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA827B7CFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FDFFFFFFFFFFFFFFFFFF8F8B8BFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFA3BAD0FFA0B7
      CEFF9DB5CDFF9AB3CBFF97B1C9FF94AEC8FF91ACC5FF92ADC7FF95B2CBFF5AA3
      CDFF97E1F2FFB2FCFFFF97F8FFFF68D8F1FF4692BBFF7597B7FF7699B8FF6F93
      B4FF6C90B2FF505050FF0000000000000000000000005F5F5FFFECE3C4FFEBE2
      C1FFEAE1BFFFE9E0BDFFE9DFBBFFE8DEB8FFE7DCB6FFE6DBB3FF505050FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000787878FFDBCC93FFDACB90FFAFA377FFD9C88BFFD8C789FFD7C5
      87FFD6C484FFD6C382FF505050FF000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF848181FFFBF9F8FFCDCC
      CCFFEAE9E9FFEAE9E9FFD4D1D2FFCCCACBFFCBC9C9FFCCCACBFFCCCACBFFDDDA
      DAFFFFFFFFFFFFFFFFFF888485FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA848181FFFBF9F8FFCDCC
      CCFFEAE9E9FFEAE9E9FFD4D1D2FFCCCACBFFCBC9C9FFCCCACBFFCCCACBFFDDDA
      DAFFFFFFFFFFFFFFFFFF888485FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFA7BDD2FFA5BB
      D0FFA2B8CFFF9FB6CDFF9CB4CCFF99B2CAFF96AFC9FF93ADC7FF90ABC4FF95B5
      CFFF6AB0D2FFBAFDFFFF9FF9FFFF4C9DC3FF7C9DBBFF799BB9FF7698B8FF7396
      B6FF7094B5FF505050FF000000000000000000000000626262FFECE4C7FFECE3
      C4FFEBE2C1FFEAE1BFFFE9E0BDFFE9DFBBFFF1E9CFFFE7DCB6FF505050FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000787878FFDCCD95FFDBCC93FFCDBD8AFFDAC98EFFD9C88BFFD8C7
      89FFD7C587FFD6C484FF505050FF000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF83807EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF817C7DFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA83807EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF817C7DFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFACC0D4FFA9BE
      D2FFA6BCD1FFA3B9CFFFA0B7CEFF9DB5CCFF9AB3CBFF97B0C9FF94AEC8FF91AC
      C5FF5FA6CEFF9BE9F6FF8EE6F6FF5BA4CDFF82A0BDFF7E9EBCFF7A9CBAFF7799
      B9FF7497B7FF505050FF000000000000000000000000626262FF626262FF6262
      62FFECE3C4FFEBE2C1FFEAE1BFFFF2ECCFFFF2EAD1FFE8DEB8FF505050FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000787878FFDDCE98FFDCCD95FFDBCC93FFDACB90FFDAC98EFFD9C8
      8BFF676767FF676767FF676767FF000000000000000000000000000000000000
      000000000000000000000000000000000000676767FF7D7877FFFFFFFFFFCECC
      CDFFCDCBCCFFD5D3D4FFFFFFFFFFFFFFFFFFCBC9CAFFCDCBCBFFCDCBCCFFCDCB
      CCFFFFFFFFFFFFFFFFFF797575FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000404040CA7D7877FFFFFFFFFFCECC
      CDFFCDCBCCFFD5D3D4FFFFFFFFFFFFFFFFFFCBC9CAFFCDCBCBFFCDCBCCFFCDCB
      CCFFFFFFFFFFFFFFFFFF797575FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFB0C3D6FFADC1
      D4FFAABFD3FFA7BDD2FFA4BAD0FFA2B8CFFF9FB6CDFF9CB4CCFF99B2CAFF96AF
      C8FF99B8D1FF6AB3D5FF68B2D4FF89A6C1FF86A4C0FF83A1BEFF809FBCFF7C9D
      BBFF799AB9FF505050FF00000000000000000000000000000000000000000000
      0000626262FFECE3C4FFEBE2C1FFF3EDD1FFF3EED9FFE9DFBBFFE8DEB8FF5050
      50FF000000000000000000000000000000000000000000000000000000000000
      0000787878FFDFD19DFFDECF9AFFDDCE98FFDCCD95FFDBCC93FFDACB90FF5050
      50FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6BFF837E7EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFAFFFFFEFDFFFFFFFFFFFDFB
      FAFFFFFFFFFFFFFFFFFF767272FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000434343CA837E7EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFAFFFFFEFDFFFFFFFFFFFDFB
      FAFFFFFFFFFFFFFFFFFF767272FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFB4C7D8FFB1C4
      D7FFAEC2D5FFABC0D4FFA9BED2FFA6BCD1FFA3B9CFFFA0B7CEFF9DB5CCFF9AB3
      CBFF97B0C9FF86B4D3FF84B3D2FF8EA9C4FF8BA7C2FF88A5C0FF85A2BFFF81A0
      BDFF7D9EBCFF505050FF00000000000000000000000000000000000000000000
      000000000000626262FFECE3C4FFEEE5C7FFF4F0DDFFF9F5EAFFE9DFBBFFE8DE
      B8FF505050FF0000000000000000000000000000000000000000000000005050
      50FFE0D3A2FFDFD29FFFDFD19DFFDECF9AFFDDCE98FFDCCD95FF505050FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF8C8989FFFFFFFFFFCDCC
      CCFFEAE9EAFFEAE9EAFFDDDADAFFCCCACBFFCCCACAFFD5D1D2FFEAE9EAFFCDCB
      CBFFFFFFFFFFFFFFFFFF757271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000474747CA8C8989FFFFFFFFFFCDCC
      CCFFEAE9EAFFEAE9EAFFDDDADAFFCCCACBFFCCCACAFFD5D1D2FFEAE9EAFFCDCB
      CBFFFFFFFFFFFFFFFFFF757271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFB7CADAFFB5C8
      D9FFB2C5D7FFB0C3D6FFADC1D4FFAABFD3FFA7BDD2FFA4BAD0FFA1B8CFFF9EB6
      CDFF9BB4CCFF98B1CAFF95AFC8FF92ADC7FF8FABC4FF8CA8C3FF89A6C1FF86A4
      C0FF83A1BEFF505050FF00000000000000000000000000000000000000000000
      0000626262FFEDE5C8FFECE4C7FFECE3C4FFF3EDD2FFFFFFFFFFEFE7CBFFE9DF
      BBFFE8DEB8FF505050FF00000000000000000000000000000000505050FFE2D5
      A7FFE1D4A4FFE0D3A2FFDFD29FFFDFD19DFFDECF9AFFDDCE98FFDCCD95FF5050
      50FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000787878FF9B9797FFFEFEFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFDFEFFFDFD
      FEFFFFFFFFFFFFFFFFFF767171FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA9B9797FFFEFEFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFDFEFFFDFD
      FEFFFFFFFFFFFFFFFFFF767171FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFBBCCDCFFB9CB
      DAFFA1A1A1FF787878FF787878FF787878FF787878FF787878FF787878FF7878
      78FF787878FF787878FF787878FF787878FF787878FF787878FF787878FF8BA7
      C2FF87A5C0FF505050FF00000000000000000000000000000000000000006262
      62FFEEE6CBFFEDE6CAFFEDE5C8FFECE4C7FFECE3C4FFF3EDD2FFFFFFFFFFEFE7
      CBFFE9DFBBFFE8DEB8FF505050FF505050FF505050FF505050FFE4D8ACFFE3D7
      A9FFE2D5A7FFE1D4A4FFE0D3A2FFDFD29FFFDFD19DFFDECF9AFFDDCE98FFDCCD
      95FF505050FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000787878FF9B9898FFFFFFFFFFCBC4
      C5FFC9C2C3FFE8E6E6FFCCC5C7FFEAE7E7FFEAE7E7FFDCD8D8FFC9C3C3FFC9C3
      C3FFFFFEFEFFFFFFFFFF767271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA9B9898FFFFFFFFFFCBC4
      C5FFC9C2C3FFE8E6E6FFCCC5C7FFEAE7E7FFEAE7E7FFDCD8D8FFC9C3C3FFC9C3
      C3FFFFFEFEFFFFFFFFFF767271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFBECFDDFFBCCD
      DCFFA1A1A1FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0
      D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FF787878FF8FAA
      C4FF8CA8C3FF505050FF00000000000000000000000000000000626262FFEEE7
      CDFFEEE7CCFFEEE6CBFFEDE6CAFFEDE5C8FFECE4C7FFECE3C4FFF3EDD2FFFFFF
      FFFFF3EDD9FFEEE6C9FFE8DEB8FFE7DCB6FFE6DBB3FFE5DAB1FFE4D9AEFFE4D8
      ACFFE3D7A9FFE2D5A7FFE1D4A4FFE0D3A2FFDFD29FFFDFD19DFFDECF9AFFDDCE
      98FFDCCD95FF505050FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000747474FF979393FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF767271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000484848CA979393FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF767271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFC2D1DFFFC0D0
      DEFFA1A1A1FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0
      D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FF787878FF94AE
      C8FF91ACC5FF505050FF00000000000000000000000000000000000000006262
      62FFEEE7CDFFEEE7CCFF676767FF676767FFEDE5C8FFECE4C7FFECE3C4FFEBE2
      C1FFFFFFFFFFF9F5EAFFF1EAD2FFEEE5C7FFF1E8CDFFE6DBB3FFE5DAB1FFE4D9
      AEFFE4D8ACFFE3D7A9FFE2D5A7FFE1D4A4FF676767FF676767FFDFD19DFFDECF
      9AFF676767FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6F6FFF8F8B8BFFFFFFFFFFFFFF
      FFFFFDFFFFFFFCFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFEFFFCFEFEFFFCFE
      FFFFFDFEFFFFFFFFFFFF767272FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000454545CA8F8B8BFFFFFFFFFFFFFF
      FFFFFDFFFFFFFCFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFEFFFCFEFEFFFCFE
      FFFFFDFEFFFFFFFFFFFF767272FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFC5D4E1FFC3D2
      E0FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF98B1
      CAFF95AFC8FF505050FF00000000000000000000000000000000000000000000
      0000626262FF626262FF0000000000000000676767FFEDE5C8FFECE4C7FFECE3
      C4FFEBE2C1FFEAE1BFFFF2EAD2FFF2EAD1FFE8DEB8FFE7DCB6FFE6DBB3FFE5DA
      B1FFE4D9AEFFE4D8ACFFE3D7A9FF505050FF0000000000000000676767FF6767
      67FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF8C8989FFF3E9E2FFFDF7
      F4FFF9EEEBFFF6EAE8FFF6EAE8FFF9EDEBFFF5E8E5FFF5E9E6FFF4E8E5FFDDC3
      BDFFDFC5C0FFFEF5F3FF777271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000464646CA8C8989FFF3E9E2FFFDF7
      F4FFF9EEEBFFF6EAE8FFF6EAE8FFF9EDEBFFF5E8E5FFF5E9E6FFF4E8E5FFDDC3
      BDFFDFC5C0FFFEF5F3FF777271FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFC9D6E2FFC7D5
      E1FFC4D3E0FFC2D1DFFFBFD0DEFFBDCEDDFFBBCCDCFFB8CADAFFB6C8D9FFB3C7
      D8FFB1C4D6FFAEC2D5FFABBFD4FFA8BDD2FFA5BBD1FFA2B9CFFFA0B7CEFF9DB5
      CCFF9AB2CBFF505050FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000676767FFEDE6CAFFEDE5C8FFECE4
      C7FFECE3C4FFEBE2C1FFEAE1BFFFE9E0BDFFE9DFBBFFE8DEB8FFE7DCB6FFE6DB
      B3FFE5DAB1FFE4D9AEFFE4D8ACFF505050FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000777777FF8F8B8AFFF1E0D5FFEBDC
      CAFFEDC3B5FFE5B5A6FFE1AD9DFFE0AE9EFFDDA194FFE3AD9FFFE0A798FFE0A6
      96FFB64C30FFF2D2C5FF787270FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA8F8B8AFFF1E0D5FFEBDC
      CAFFEDC3B5FFE5B5A6FFE1AD9DFFE0AE9EFFDDA194FFE3AD9FFFE0A798FFE0A6
      96FFB64C30FFF2D2C5FF787270FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFCBD8E4FFCAD7
      E3FFC8D5E2FFC5D4E1FFC3D2E0FFC0D1DFFFBECFDDFFBCCDDCFFB9CBDBFFB7C9
      DAFFB4C7D8FFB2C4D7FFAFC2D6FFACC0D4FFAABED3FFA7BCD1FFA4BAD0FFA1B8
      CEFF9EB6CDFF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000676767FFEEE7CCFFEEE6CBFFEDE6CAFFEDE5
      C8FF676767FFECE3C4FFEBE2C1FFEAE1BFFFE9E0BDFFE9DFBBFFE8DEB8FF6767
      67FFE6DBB3FFE5DAB1FFE4D9AEFFE4D8ACFF505050FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000868686FF989696FFF8EEE6FFF8E5
      D6FFF9E6DAFFFBE7DBFFF9E3D6FFF6DED1FFF2D9CCFFECD2C4FFE6CCC0FFE3C9
      BBFFE2C5B9FFEEDDD5FF757172FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000535353CA989696FFF8EEE6FFF8E5
      D6FFF9E6DAFFFBE7DBFFF9E3D6FFF6DED1FFF2D9CCFFECD2C4FFE6CCC0FFE3C9
      BBFFE2C5B9FFEEDDD5FF757172FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFCEDAE5FFCCD9
      E4FFCAD7E3FFC9D6E2FFC7D4E1FFC4D3E0FFC1D1DFFFBFD0DEFFBDCEDDFFBBCC
      DBFFB8CADAFFB6C8D9FFB3C5D8FFB0C3D6FFAEC1D5FFABBFD3FFA8BDD2FFA5BB
      D1FFA2B9CFFF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000676767FFEEE7CDFFEEE7CCFFEEE6CBFF6767
      67FF00000000676767FFECE3C4FFEBE2C1FFEAE1BFFFE9E0BDFF505050FF0000
      0000676767FFE6DBB3FFE5DAB1FFE4D9AEFF505050FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000929292FF888585FFA0A0A2FF9596
      98FF949597FF959598FF8E8F91FF848587FF7D7D81FF77787AFF6D6E71FF6869
      6CFF5C5E60FF59595BFF3C3636FF474747CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A5A5ACA888585FFA0A0A2FF9596
      98FF949597FF959598FF8E8F91FF848587FF7D7D81FF77787AFF6D6E71FF6869
      6CFF5C5E60FF59595BFF3C3636FF474747CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFD0DCE6FFCFDA
      E5FFCDD9E4FFCBD8E4FFC9D7E3FFC8D5E2FFC5D4E1FFC2D2E0FFC0D0DEFFBECF
      DDFFBCCDDCFFB9CBDBFFB7C9DAFFB4C7D8FFB2C4D7FFAFC2D6FFACC0D4FFA9BE
      D3FFA7BCD1FF505050FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000676767FFEEE7CDFF676767FF0000
      00000000000000000000676767FFECE3C4FFEBE2C1FF505050FF000000000000
      000000000000676767FFE6DBB3FF676767FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B0B0B0FF787878FF828282FF6C6C
      6CFF626262FF656565FF5A5A5AFF4D4D4DFF4D4D4DFF4E4E4EFF464646FF4444
      44FF424242FF404040FF383838FF686868CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6ECA787878FF828282FF6C6C
      6CFF626262FF656565FF5A5A5AFF4D4D4DFF4D4D4DFF4E4E4EFF464646FF4444
      44FF424242FF404040FF383838FF686868CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFD2DDE7FFD1DC
      E6FFCFDBE6FFCEDAE5FFCCD9E4FFCAD7E3FFC8D6E2FFC7D4E1FFC3D3E0FFC1D1
      DFFFBFD0DEFFBDCEDDFFBACCDBFFB8CADAFFB5C8D9FFB3C5D8FFB0C3D6FFAEC1
      D5FFABBFD3FF505050FF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000676767FF000000000000
      00000000000000000000676767FFECE4C7FFECE3C4FF505050FF000000000000
      00000000000000000000676767FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009F9F9FFF8C8C8CFF8080
      80FF797979FF7B7B7BFF797979FF757575FF757575FF777777FF757575FF7474
      74FF757575FF717171FF868686FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000626262CA565656CA4F4F
      4FCA4B4B4BCA4D4D4DCA4B4B4BCA494949CA494949CA4A4A4ACA494949CA4848
      48CA494949CA474747CA535353CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000676767FF676767FF676767FF676767FF000000000000
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
      0000000000000000000000000000505050FF505050FF505050FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004D9D59FF4D9D59FF4D9D59FF4D9D59FF4D9D59FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000030000000B00000013000000160000001600000016000000160000
      0016000000160000001600000016000000160000001600000016000000160000
      0016000000160000001600000016000000160000001600000016000000160000
      0016000000130000000B00000003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000505050FF000000000000000000000000505050FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004D9D59FF87D490FF82D28AFF7BD085FF4D9D59FF505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF00000000000000000000000000000000000000000000
      00000000000000000000A1A1A1FF656565FF656565FF656565FF656565FF6565
      65FF656565FF656565FF656565FF656565FF656565FF656565FFC3B89BFFC3B8
      9BFFC3B89BFFC3B89BFFC3B89BFFC3B89BFFC3B89BFFC3B89BFFC3B89BFFC3B8
      9BFFC3B89BFF0000000000000000000000000000000000000000000000000000
      0003000000110000002300000030000000350000003500000035000000350000
      0035000000350000003500000035000000350000003500000035000000350000
      0035000000350000003500000035000000350000003500000035000000350000
      0035000000300000002300000011000000030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000505050FF000000000000000000000000505050FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004D9D59FF8DD795FF87D490FF82D28AFF4D9D59FF688EB1FF658C
      AFFF628AAEFF6087ACFF5D85ABFF5A83AAFF5881A8FF557EA7FF537DA6FF507B
      A4FF4E79A3FF4C77A2FF4976A1FF4774A0FF45739FFF43719EFF42709DFF406F
      9CFF3E6D9BFF505050FF00000000000000000000000000000000000000000000
      00000000000000000000A1A1A1FFDBDBDBFFD9D9D9FFD7D7D7FFD5D5D5FFD3D3
      D3FFD1D1D1FFCFCFCFFFCCCCCDFFCACACBFFC8C8C9FF656565FFF6D2B7FFF6D2
      B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2
      B7FFC3B89BFF0000000000000000000000000000000000000000000000030000
      001500000051545454FF545454FF545454FF545454FF545454FF545454FF5759
      56FF575955FF575955FF575955FF565855FF575955FF575955FF575956FF5759
      56FF575956FF575955FF545454FF545454FF545454FF545454FF545454FF5454
      54FF545454FF000000710000001D000000080000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000505050FF000000000000000000000000505050FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004D9D59FF93D99AFF8DD795FF87D490FF4D9D59FF6C91B3FF6A8F
      B1FF678DB0FF648BAEFF6188ADFF5E86ACFF5C84AAFF5982A9FF5680A8FF547D
      A6FF517CA5FF4F7AA4FF4D78A3FF4A76A1FF4875A0FF46739FFF44729EFF4270
      9DFF416F9CFF505050FF00000000000000000000000000000000000000000000
      00000000000000000000A1A1A1FFDCDCDCFFDADADAFFD8D8D8FFD6D6D6FFD4D4
      D4FFD2D2D2FFD0D0D0FFCECECEFFCCCCCCFFCACACAFF656565FF505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FFF6D2B7FFF6D2
      B7FFC3B89BFF0000000000000000000000000000000000000000000000080000
      0046545454FF67697AFF67697AFF67697AFF545454FFEDEDEFFFEDEDEFFFEDED
      EFFFEDEDEFFFEDEDEFFFEDEDEFFFEDEDEFFFEDEDEFFFEDEDEFFFEDEDEFFFEDED
      EFFFEDEDEFFF545454FF67697AFF67697AFF67697AFF67697AFF67697AFF6769
      7AFF67697AFF545454FF000000260000000B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000505050FF505050FF505050FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004D9D59FF98DBA0FF93D99AFF8DD795FF4D9D59FF7194B5FF6E92
      B4FF6B90B2FF688EB1FF658CAFFF6289AEFF6087ACFF5D85ABFF5A83A9FF5781
      A8FF557EA7FF527DA6FF507BA4FF4E79A3FF4B77A2FF4976A1FF4774A0FF4573
      9FFF43719EFF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFDBDBDCFFD9D9DAFFD7D7D8FFD5D5
      D6FFD3D3D3FFD1D1D1FFCFCFCFFFCDCDCDFFCBCBCBFF656565FF608EB6FF5D8C
      B5FF5A8AB4FF5889B2FF5687B1FF5486B0FF5284B0FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FF545454FFEDEDEFFFD8DEE0FF5454
      54FF545454FF545454FF545454FFD8DEE0FFD8DEE0FFD8DEE0FFD8DEE0FFD8DE
      E0FFEDEDEFFF545454FF67697AFF67697AFF67697AFF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000505050FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000074B47DFF4D9D59FF4D9D59FF4D9D
      59FF4D9D59FF4D9D59FF9EDDA5FF98DBA0FF93D99AFF4D9D59FF4D9D59FF4D9D
      59FF4D9D59FF4D9D59FF4D9D59FF668DB0FF648AAEFF37ABDAFF4091B9FF408F
      B8FF5982A9FF5680A7FF547DA6FF517CA5FF3A95C5FF408EB6FF408EB6FF4875
      A0FF46739FFF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FF656565FFDBDBDBFFD8D8D9FFD6D6
      D7FFD4D4D5FF656565FF656565FFCECECEFFCCCCCCFF656565FF6592B8FF6290
      B7FF5F8DB6FF5C8CB4FF5A8AB3FF5788B2FF5587B1FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FF545454FFEDEDEFFFD8DEE0FF5454
      54FFA9AD98FFA9AD98FF545454FFD8DEE0FFD8DEE0FFD8DEE0FFD8DEE0FFD8DE
      E0FFEDEDEFFF545454FF67697AFF67697AFF67697AFF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B0000000000000000505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF000000000000000074B47DFFC0EAC4FFBBE8BFFFB5E6
      BAFFB0E3B5FFAAE1B0FFA4DFAAFF9EDDA5FF98DBA0FF93D99AFF8DD795FF87D4
      90FF82D28AFF7BD085FF4D9D59FF6B90B2FF688EB1FF36A9D8FF48E5FFFF41D4
      F6FF4090B8FF418FB8FF4898C4FF3BA4D3FF38CAF6FF38D5FFFF408EB6FF4B77
      A2FF4976A1FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFDEDEDEFF656565FFDADADAFFD8D8
      D8FFA1A1A1FFD3D3D4FFD1D1D2FF656565FFCDCDCEFF656565FF6B96BBFF6793
      B9FF6491B8FF618FB7FF5E8DB5FF5B8BB4FF5989B3FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FF545454FFEDEDEFFFD8DEE0FF5454
      54FFA9AD98FFA9AD98FF545454FFD8DEE0FFD8DEE0FFD8DEE0FFD8DEE0FFD8DE
      E0FFEDEDEFFF545454FF67697AFF67697AFF67697AFF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B0000000000000000A1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FF000000000000000074B47DFFC5ECCAFFC0EAC4FFBBE8
      BFFFB5E6BAFFB0E3B5FFAAE1B0FFA4DFAAFF9EDDA5FF98DBA0FF93D99AFF8DD7
      95FF87D490FF82D28AFF4D9D59FF6F93B4FF6F94B5FF459ECBFF47DEFBFF48E6
      FFFF44E2FFFF3DCBF2FF3CC9F2FF3EDBFFFF3CDAFFFF39D0FBFF3F93BFFF537D
      A6FF4C78A2FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFDFDFDFFF656565FFDBDBDBFFD9D9
      D9FFA1A1A1FFD5D5D5FFD3D3D3FF656565FFCECECFFF656565FF719ABEFF6D97
      BCFF6A95BBFF6693B9FF6390B8FF608EB6FF5D8CB5FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FF545454FFEDEDEFFFD8DEE0FF5454
      54FFA9AD98FFA9AD98FF545454FFD8DEE0FFD8DEE0FFD8DEE0FFD8DEE0FFD8DE
      E0FFEDEDEFFF545454FF67697AFF67697AFF67697AFF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFE7E7E7FFE5E5E5FFE4E4E4FFE2E2E2FFE1E1E1FFE0E0E0FFBEB3ABFFDDDD
      DDFFBEB3ABFFB2B1B1FFB2B1B1FFB2B1B1FFB2B1B1FFB2B1B1FFB2B1B1FFBEB3
      ABFFBEB3ABFFD0D0D0FFCFCFCFFFCECECEFFCDCDCDFFCCCCCCFFCBCBCBFFCACA
      CAFFD09476FF00000000000000000000000074B47DFFCBEDCFFFC5ECCAFFC0EA
      C4FFBBE8BFFFB5E6BAFFB0E3B5FFAAE1B0FFA4DFAAFF9EDDA5FF98DBA0FF93D9
      9AFF8DD795FF87D490FF4D9D59FF7496B7FF7194B5FF4D9DCAFF47D8F6FF49E6
      FFFF46E2FFFF45E2FFFF43E0FFFF40DBFFFF3DDAFFFF3ACCF6FF4799C7FF527C
      A5FF507BA4FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE0E0E0FF656565FFDCDCDCFFDADA
      DAFFA1A1A1FFD6D6D6FFD4D4D4FF656565FFD0D0D0FF656565FF779EC1FF739C
      BFFF7099BDFF6C97BCFF6994BAFF6592B9FF6290B7FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FF545454FFEDEDEFFFD8DEE0FF5454
      54FFA9AD98FFA9AD98FF545454FFD8DEE0FFD8DEE0FFD8DEE0FFD8DEE0FFD8DE
      E0FFEDEDEFFF545454FF67697AFF67697AFF67697AFF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFE8E8E8FFE7E7E7FFE5E5E5FFE4E4E4FFE2E2E2FFE1E1E1FFDFDFDFFFDEDE
      DEFFDDDDDDFFDBDBDBFFDADADAFFD8D8D8FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3
      D3FFD2D2D2FFD1D1D1FFD0D0D0FFCFCFCFFFCECECEFFCDCDCDFFCCCCCCFFCBCB
      CBFFD09476FF00000000000000000000000074B47DFF74B47DFF74B47DFF74B4
      7DFF74B47DFF74B47DFFB5E6BAFFB0E3B5FFAAE1B0FF4D9D59FF4D9D59FF4D9D
      59FF4D9D59FF4D9D59FF4D9D59FF789AB9FF7598B7FF63A3C9FF48CEEEFF53EB
      FFFF4CE4FFFF46E2FFFF44DFFFFF42DDFFFF40DEFFFF39C2EEFF5B9CC3FF5680
      A7FF537DA6FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE1E1E1FF656565FFDDDDDDFFDBDB
      DBFFA1A1A1FFD7D7D7FFD5D5D5FF656565FFD1D1D1FF656565FF7EA3C4FF7AA0
      C2FF769EC0FF729BBEFF6F98BDFF6B96BBFF6894BAFF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FF545454FFEDEDEFFFD8DEE0FF5454
      54FF545454FF545454FF545454FFD8DEE0FFD8DEE0FFD8DEE0FFD8DEE0FFD8DE
      E0FFEDEDEFFF545454FF67697AFF67697AFF67697AFF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFEAEAEAFFE8E8E8FFE7E7E7FFE5E5E5FFE4E4E4FFE2E2E2FFBEB3ABFFDFDF
      DFFFB2B1B1FFB2B1B1FFB2B1B1FFB2B1B1FFB2B1B1FFB2B1B1FFB2B1B1FFB2B1
      B1FFB2B1B1FFB2B1B1FFB2B1B1FFB2B1B1FFBEB3ABFFCECECEFFCDCDCDFFCCCC
      CCFFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000074B47DFFBBE8BFFFB5E6BAFFB0E3B5FF4D9D59FF8DA9C3FF8AA7
      C2FF87A4C0FF84A2BEFF81A0BDFF7D9DBBFF7A9BBAFF4CA1CDFF61E1F7FF64EE
      FFFF5BE8FFFF52E5FFFF49E1FFFF43DFFFFF42DFFFFF3DD0F6FF408FB7FF5A83
      A9FF5781A8FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE2E2E2FF656565FFDEDEDFFFDCDC
      DDFFA1A1A1FFD8D8D9FFD6D6D7FF656565FFD2D2D3FF656565FF86A8C8FF82A5
      C5FF7DA2C3FF79A0C1FF759DC0FF719ABEFF6E98BCFF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FF545454FFEDEDEFFFEDEDEFFFEDED
      EFFFEDEDEFFFE5E9E7FFEAEDECFFEEF0EFFFEBEEECFFE8EBE9FFE5E8E7FFEDED
      EFFFEDEDEFFF545454FF67697AFF67697AFF4D4E58FF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFEBEBEBFFEAEAEAFFE8E8E8FFE7E7E7FFE5E5E5FFE4E4E4FFE2E2E2FFE1E1
      E1FFDFDFDFFFDEDEDEFFDCDCDCFFDBDBDBFFDADADAFFD8D8D8FFD7D7D7FFD6D6
      D6FFD4D4D4FFD3D3D3FFD2D2D2FFD1D1D1FFD0D0D0FFCFCFCFFFCECECEFFCDCD
      CDFFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000074B47DFFC0EAC4FFBBE8BFFFB5E6BAFF4D9D59FF92ACC5FF8EAA
      C4FF8BA8C2FF88A5C1FF85A3BFFF82A1BEFF49A0CCFF72E3F5FF83F6FFFF78EF
      FFFF6FEDFFFF63EAFFFF57E5FFFF4AE2FFFF43DFFFFF42E0FFFF3DCEF4FF408F
      B7FF5B84AAFF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE3E3E3FF656565FFDFDFE0FFDEDE
      DEFFA1A1A1FFDADADAFFD8D8D8FF656565FFD3D3D4FF656565FF8DADCBFF88AA
      C9FF84A7C7FF80A4C4FF7BA1C3FF789FC1FF749CBFFF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FF4D4E58FF545454FF545454FF5454
      54FF545454FF525654FF525654FF525654FF525654FF525654FF525654FF5454
      54FF545454FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFECECECFFEBEBEBFFE9E9E9FFE8E8E8FFE7E7E7FFE5E5E5FFBEB3ABFFE2E2
      E2FFB5B4B4FFB4B4B4FFB4B3B3FFB3B2B2FFB2B2B2FFB2B1B1FFB1B1B1FFB1B0
      B0FFB0B0B0FFB0AFAFFFAFAFAFFFD2D2D2FFD1D1D1FFD0D0D0FFCFCFCFFFCECE
      CEFFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000074B47DFFC5ECCAFFC0EAC4FFBBE8BFFF4D9D59FF96B0C9FF93AD
      C7FF90ABC5FF8DA9C3FF8AA6C1FF51A4CEFF86E6F5FFA2FEFFFF99F6FFFF90F4
      FFFF85F1FFFF76EEFFFF67EAFFFF57E5FFFF4AE2FFFF44DFFFFF43E2FFFF3DCE
      F4FF408FB7FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE4E4E4FF656565FFE1E1E1FFDFDF
      DFFFA1A1A1FFDBDBDBFFD9D9D9FF656565FFD5D5D5FF656565FF94B2CEFF8FAF
      CCFF8BACCAFF87A9C9FF83A6C7FF7EA3C4FF7AA1C2FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E
      58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E
      58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFEEEEEEFFECECECFFEBEBEBFFE9E9E9FFE8E8E8FFE7E7E7FFE5E5E5FFE4E4
      E4FFE2E2E2FFE1E1E1FFDFDFDFFFDEDEDEFFDCDCDCFFDBDBDBFFDADADAFFD8D8
      D8FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3D3FFD2D2D2FFD1D1D1FFD0D0D0FFCFCF
      CFFFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000074B47DFFCBEDCFFFC5ECCAFFC0EAC4FF4D9D59FF9AB3CBFF97B1
      C9FF94AEC8FF91ACC5FF69A9CFFF69CAE5FFA4F4FAFFAEF7FEFFB5FCFFFFAFFC
      FFFF9BF5FFFF8AF1FFFF77EEFFFF65EAFFFF56E9FFFF48E3FFFF43DCFCFF40D6
      F9FF38B6E3FF558BA6FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE5E5E5FF656565FFE2E2E2FFE0E0
      E0FFA1A1A1FFDCDCDCFFDADADAFF656565FFD6D6D6FF656565FF9BB6D1FF96B4
      CFFF92B1CEFF8EAECCFF8AABCAFF86A8C8FF82A5C5FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FF4D4E58FFA9AD98FFA9AD98FFA9AD98FFA9AD
      98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD
      98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FF4D4E58FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFEFEFEFFFEEEEEEFFECECECFFEBEBEBFFE9E9E9FFE8E8E8FFE6E6E6FFE5E5
      E5FFE4E4E4FFE2E2E2FFE1E1E1FFDFDFDFFFDEDEDEFFDCDCDCFFDBDBDBFFD9D9
      D9FFD8D8D8FFD7D7D7FFD5D5D5FFD4D4D4FFD3D3D3FFD2D2D2FFD1D1D1FFD0D0
      D0FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000074B47DFF74B47DFF74B47DFF74B47DFF74B47DFF9FB6CDFF9CB4
      CCFF99B2CAFF96B0C9FF9AB8D1FF73AED1FF62A8CFFF5BA8D0FF54B2DAFF74CB
      E7FFAFF8FFFF9DF6FFFF87F2FFFF71EDFFFF46BFE5FF37A9D8FF449FCDFF559F
      C9FF63A2C9FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE6E6E6FF656565FFE3E3E3FFE1E1
      E1FFA1A1A1FFDDDDDDFFDBDBDBFF656565FFD7D7D7FF656565FFA1BBD4FF9DB8
      D3FF99B6D1FF95B3CFFF91B0CDFF8DADCBFF89AAC9FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFA9AD98FFC9CBBCFFC9CBBCFFC6C8
      B9FFB7B9ABFF9C9E92FF8F9086FF9A9C90FFB2B4A7FFC4C6B7FFC9CBBCFFC9CB
      BCFFC9CBBCFFC9CBBCFFC9CBBCFFC9CBBCFFA9AD98FFA9AD98FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFF0F0F0FFEFEFEFFFEEEEEEFFECECECFFEBEBEBFFE9E9E9FFA1A1A1FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF505050FFD5D5D5FFD4D4D4FFD3D3D3FFD2D2D2FFD1D1
      D1FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFA3BAD0FFA0B7
      CEFF9DB5CDFF9AB3CBFF97B1C9FF94AEC8FF91ACC5FF92ADC7FF95B2CBFF5AA3
      CDFF97E1F2FFB2FCFFFF97F8FFFF68D8F1FF4692BBFF7597B7FF7699B8FF6F93
      B4FF6C90B2FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE7E7E7FF656565FFE4E4E4FFE2E2
      E2FFA1A1A1FFDEDEDEFFDCDCDDFF656565FFD8D8D9FF656565FFA8C0D8FFA4BD
      D6FFA0BAD4FF9CB8D2FF98B5D0FF94B2CEFF90AFCCFF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFC9CBBCFFD8DACFFFD1D3
      C8FFB4B6ACFF878881FF6C6D67FF7A7B75FF9FA098FFC0C2B8FFD2D4CAFFD8DA
      CFFFD8DACFFFD8DACFFFD8DACFFFC9CBBCFFC9CBBCFFA9AD98FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFF2F2F2FFF0F0F0FFEFEFEFFFEEEEEEFFECECECFFEBEBEBFFA1A1A1FFBBE7
      F7FFC8E8F1FF8AA19FFF225668FF225066FF27516AFFB0D4E3FFC7EAF4FFA7B3
      D4FF5E6886FF91A7CBFF505050FFD7D7D7FFD5D5D5FFD4D4D4FFD3D3D3FFD2D2
      D2FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFA7BDD2FFA5BB
      D0FFA2B8CFFF9FB6CDFF9CB4CCFF99B2CAFF96AFC9FF93ADC7FF90ABC4FF95B5
      CFFF6AB0D2FFBAFDFFFF9FF9FFFF4C9DC3FF7C9DBBFF799BB9FF7698B8FF7396
      B6FF7094B5FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE8E8E8FF656565FFE5E5E5FFE3E3
      E3FFA1A1A1FFDFDFE0FFDDDDDEFF656565FFD9D9DAFF656565FF787878FF7878
      78FF787878FF787878FF787878FF787878FF97B4D0FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFD8DACFFFD8DACFFFCCCE
      C3FFA6A79FFF4D9D59FF50514CFF575753FF787973FF9FA098FFC0C2B8FFD2D4
      CAFFD8DACFFFD8DACFFFD8DACFFFD8DACFFFC9CBBCFFA9AD98FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFF3F3F3FFF2F2F2FFF0F0F0FFEFEFEFFFEDEDEDFFECECECFFA1A1A1FFBCE9
      F8FFC1E3F2FF8395A7FF3F808AFF2C6474FF8FB1C3FFD2F5FFFF96B0B9FFA5BD
      BEFF6A7D7EFFA4B8BCFF505050FFD8D8D8FFD7D7D7FFD5D5D5FFD4D4D4FFD3D3
      D3FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFACC0D4FFA9BE
      D2FFA6BCD1FFA3B9CFFFA0B7CEFF9DB5CCFF9AB3CBFF97B0C9FF94AEC8FF91AC
      C5FF5FA6CEFF9BE9F6FF8EE6F6FF5BA4CDFF82A0BDFF7E9EBCFF7A9CBAFF7799
      B9FF7497B7FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE9E9E9FF656565FFE6E6E6FFE4E4
      E4FFA1A1A1FFE1E1E1FFDFDFDFFF656565FFDBDBDBFF656565FFCCD0D6FFCCD0
      D6FFCCD0D6FFCCD0D6FFCCD0D6FF787878FF9EB9D3FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFD8DACFFFD5D7CCFFC2C4
      BAFF5FA369FF85DB8FFF4D9D59FF444541FF575753FF787973FF9FA098FFC0C2
      B8FFD2D4CAFFD8DACFFFD8DACFFFD8DACFFFC9CBBCFFA9AD98FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFF4F4F4FFF3F3F3FFF1F1F1FFF0F0F0FFEFEFEFFFEDEDEDFFA1A1A1FFC2ED
      FCFFB9DBEDFF8FB3C8FF3D7783FF3F6D82FFCBEDF9FFCEF0FDFFC3E3EFFFA7BE
      CEFF8A9AB8FF91A4ABFF505050FFD9D9D9FFD8D8D8FFD7D7D7FFD5D5D5FFD4D4
      D4FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFB0C3D6FFADC1
      D4FFAABFD3FFA7BDD2FFA4BAD0FFA2B8CFFF9FB6CDFF9CB4CCFF99B2CAFF96AF
      C8FF99B8D1FF6AB3D5FF68B2D4FF89A6C1FF86A4C0FF83A1BEFF809FBCFF7C9D
      BBFF799AB9FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFE9E9E9FF656565FFE7E7E7FFE5E5
      E5FFA1A1A1FFE2E2E2FFE0E0E0FF656565FFDCDCDCFF656565FFCCD0D6FFCCD0
      D6FFCCD0D6FFCCD0D6FFCCD0D6FF787878FFA5BED6FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFC9CBBCFFC0C2B3FFA3A4
      98FF5FA369FF8FDE97FF84DB8DFF4D9D59FF41413CFF50514BFF6F7068FF9495
      8AFFB2B4A7FFC4C6B7FFC9CBBCFFC9CBBCFFC9CBBCFFA9AD98FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFF5F5F5FFF4F4F4FFF3F3F3FFF1F1F1FFF0F0F0FFEFEFEFFFA1A1A1FFC1EB
      FAFFCEF1FEFFBBE3ECFF397383FF5C8599FFD5F6FFFFD0F2FDFFC8E7FFFFA3B5
      E5FFAAC1D4FF8186BBFF505050FFDBDBDBFFD9D9D9FFD8D8D8FFD7D7D7FFD5D5
      D5FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFB4C7D8FFB1C4
      D7FFAEC2D5FFABC0D4FFA9BED2FFA6BCD1FFA3B9CFFFA0B7CEFF9DB5CCFF9AB3
      CBFF97B0C9FF86B4D3FF84B3D2FF8EA9C4FF8BA7C2FF88A5C0FF85A2BFFF81A0
      BDFF7D9EBCFF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFEAEAEAFF656565FFE7E7E7FFE6E6
      E6FFA1A1A1FFE3E3E3FFE1E1E1FF656565FFDDDDDDFF656565FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFABC2D9FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFD5D7CCFFC2C4BAFF9799
      91FF5FA369FF98E1A0FF8EDE96FF83DB8CFF4D9D59FF4D4E4AFF595A55FF7879
      73FF9FA098FFC0C2B8FFD2D4CAFFD8DACFFFC9CBBCFFA9AD98FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFF6F6F6FFF5F5F5FFF4F4F4FFF3F3F3FFF1F1F1FFF0F0F0FFA1A1A1FFC0EB
      FAFFD1F5FFFFB6E0EBFF205167FF577C93FFDDFCFFFFD0F1F9FFCAEAFBFFB0C4
      FBFFC0E5F3FFBDDEF9FF505050FFDCDCDCFFDBDBDBFFD9D9D9FFD8D8D8FFD6D6
      D6FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFB7CADAFFB5C8
      D9FFB2C5D7FFB0C3D6FFADC1D4FFAABFD3FFA7BDD2FFA4BAD0FFA1B8CFFF9EB6
      CDFF9BB4CCFF98B1CAFF95AFC8FF92ADC7FF8FABC4FF8CA8C3FF89A6C1FF86A4
      C0FF83A1BEFF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFEBEBEBFF656565FFE8E8E8FFE7E7
      E7FFA1A1A1FFE4E4E4FFE2E2E2FF656565FFDEDEDEFF656565FFC7D6E5FFC3D4
      E4FFC0D2E2FFBCCFE1FFB9CDDFFFB5CADEFFB2C8DCFF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFD1D3C8FFB4B6ACFF5FA3
      69FFACE7B2FFA2E4A9FF97E19FFF8CDD95FF82DA8BFF4D9D59FF575753FF5C5D
      58FF787973FF9FA098FFC0C2B8FFD2D4CAFFC9CBBCFFA9AD98FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFF7F7F7FFF6F6F6FFF5F5F5FFF4F4F4FFF3F3F3FFF1F1F1FFA1A1A1FFC4EC
      FBFFD0F4FFFFA7D4DFFF3A6F7EFF486D87FFBDE1ECFF567D90FF5C8494FF4F75
      87FF2C4D62FF82A8B5FF505050FFDDDDDDFFDCDCDCFFDADADAFFD9D9D9FFD8D8
      D8FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFBBCCDCFFB9CB
      DAFFA1A1A1FF787878FF787878FF787878FF787878FF787878FF787878FF7878
      78FF787878FF787878FF787878FF787878FF787878FF787878FF787878FF8BA7
      C2FF87A5C0FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFEBEBEBFF656565FFE9E9E9FFE8E8
      E8FFA1A1A1FFE5E5E5FFE3E3E3FF656565FFDFDFE0FF656565FFCCD9E7FFC9D7
      E6FFC5D5E5FFC2D3E3FFBFD1E2FFBBCFE0FFB8CCDFFF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFCED0C6FFAFB0A8FF5FA3
      69FFB5EABBFF74B47DFF74B47DFF74B47DFF8BDD94FF81DA8AFF4D9D59FF6468
      5FFF60615CFF7A7B75FF9FA098FFC0C2B8FFC4C6B7FFA9AD98FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFF9F9F9FFF7F7F7FFF6F6F6FFF5F5F5FFF4F4F4FFF3F3F3FFA1A1A1FFC3EB
      F9FFD3F6FFFF95C7D0FF1F5064FF7296ACFF86A6B7FF113855FF3D6E80FF4070
      80FF376C78FF355C6CFF505050FFDFDFDFFFDDDDDDFFDCDCDCFFDADADAFFD9D9
      D9FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFBECFDDFFBCCD
      DCFFA1A1A1FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0
      D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FF787878FF8FAA
      C4FF8CA8C3FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFA1A1A1FFEBEBEBFFEAEAEAFFE8E8
      E9FFE7E7E7FFA1A1A1FFA1A1A1FFE2E2E2FFE0E0E1FF656565FFD0DCE9FFCDDA
      E8FFCBD9E7FFC8D7E6FFC4D5E4FFC1D2E3FFBED0E1FF505050FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFD1D3C8FF5FA369FFC8EF
      CCFF74B47DFFC0C2B8FFD3D5CAFF74B47DFF74B47DFF8ADD93FF80DA89FF4D9D
      59FF71746DFF696A65FF7D7E77FF9FA098FFB2B4A7FFA5A894FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFFAFAFAFFF8F8F8FFF7F7F7FFF6F6F6FFF5F5F5FFF4F4F4FFA1A1A1FFC2EB
      FAFFC7EDFAFF5A969EFF123B54FF93B5C5FFD6F7FFFF739FB1FF82B2BEFFABD7
      E1FF74AEB6FF417481FF505050FFE0E0E0FFDFDFDFFFDDDDDDFFDCDCDCFFDADA
      DAFFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFC2D1DFFFC0D0
      DEFFA1A1A1FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0
      D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FF787878FF94AE
      C8FF91ACC5FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A1FFECECECFFEBEBEBFFEAEAEAFFE9E9
      E9FFE8E8E8FFE6E6E7FFE5E5E5FFE3E3E3FFE2E2E2FF656565FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFF6D2B7FFC3B8
      9BFF0000000000000000000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFD5D7CCFF5FA369FF5FA3
      69FFC7C9BFFFD2D4CAFFD8DACFFFD8DACFFFD8DACFFF74B47DFF89DC92FF7ED9
      88FF4D9D59FF80827AFF6E6F6AFF7D7E77FF96988CFF9A9E8AFF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFFAFAFAFFF9F9F9FFF8F8F8FFF7F7F7FFF6F6F6FFF5F5F5FFA1A1A1FFCCF1
      FFFF88BCC7FF3A7982FF123853FF80A3B7FFD8F5FAFFCBE4E5FFC3DEE2FFD0EA
      EDFFC5E9F4FF568C97FF505050FFE1E1E1FFE0E0E0FFDFDFDFFFDDDDDDFFDCDC
      DCFFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFC5D4E1FFC3D2
      E0FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF98B1
      CAFF95AFC8FF505050FF00000000000000000000000000000000000000000000
      000000000000A1A1A1FF656565FF656565FF656565FF656565FF656565FF6565
      65FF656565FF656565FF656565FF656565FF656565FF656565FFF6D2B7FFF6D2
      B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2
      B7FFC3B89BFFC3B89BFF000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFC9CBBCFF5FA369FFC5C7
      B9FFC6C8B9FFC9CBBCFFC9CBBCFFC9CBBCFFC9CBBCFFC9CBBDFF74B47DFF74B4
      7DFF7DD987FF4D9D59FF7C8075FF6B6C64FF84857AFF8F9280FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFFBFBFBFFFAFAFAFFF9F9F9FFF8F8F8FFF7F7F7FFF6F6F6FFA1A1A1FFA4D2
      DEFF4B8D94FF336E7AFF0E304CFF6A8FA4FFD6EAE7FFCDDDD4FFCCDED8FFCADA
      D5FFCDEFF7FF4E7586FF505050FFE3E3E3FFE1E1E1FFE0E0E0FFDFDFDFFFDDDD
      DDFFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFC9D6E2FFC7D5
      E1FFC4D3E0FFC2D1DFFFBFD0DEFFBDCEDDFFBBCCDCFFB8CADAFFB6C8D9FFB3C7
      D8FFB1C4D6FFAEC2D5FFABBFD4FFA8BDD2FFA5BBD1FFA2B9CFFFA0B7CEFF9DB5
      CCFF9AB2CBFF505050FF00000000000000000000000000000000000000000000
      000000000000A1A1A1FFEBEBEBFFE9E9E9FFE7E7E8FFE6E6E6FFE4E4E4FFE2E2
      E2FFDFDFE0FFDDDDDDFFDBDBDBFFD8D8D8FFD6D6D6FF656565FFF6D2B7FFF6D2
      B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2
      B7FFF6D2B7FFC3B89BFF000000000000000000000000000000000000000B5454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFD8DACFFFD8DACFFFD8DA
      CFFFD8DACFFFD8DACFFFD8DACFFFD8DACFFFD8DACFFFD8DACFFFD8DACFFFD8DA
      CFFF74B47DFF7BD986FF4D9D59FF959890FF8F9086FF919482FF4D4E58FF4D4E
      58FF67697AFF545454FF000000260000000B000000000000000000000000D7B4
      A3FFFCFCFCFFFBFBFBFFFAFAFAFFF9F9F9FFF8F8F8FFF7F7F7FFA1A1A1FF4E8E
      97FF43878EFF316574FF0F304EFF4E6F85FF5C8091FF5D8494FF83AAB9FFA3C8
      D6FF81A4B1FF2D4A5EFF505050FFE4E4E4FFE3E3E3FFE1E1E1FFE0E0E0FFDEDE
      DEFFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFCBD8E4FFCAD7
      E3FFC8D5E2FFC5D4E1FFC3D2E0FFC0D1DFFFBECFDDFFBCCDDCFFB9CBDBFFB7C9
      DAFFB4C7D8FFB2C4D7FFAFC2D6FFACC0D4FFAABED3FFA7BCD1FFA4BAD0FFA1B8
      CEFF9EB6CDFF505050FF00000000000000000000000000000000000000000000
      000000000000A1A1A1FFA1A1A1FFE9E9E9FFE8E8E8FFE6E6E6FFE4E4E4FFE2E2
      E2FFE0E0E0FFDDDDDDFFDBDBDBFFD8D8D9FFD6D6D6FF656565FFF6D2B7FFF6D2
      B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2B7FFF6D2
      B7FFF6D2B7FFC3B89BFF00000000000000000000000000000000000000085454
      54FF67697AFF4D4E58FF4D4E58FFA9AD98FFC9CBBCFFD8DACFFFD8DACFFFD8DA
      CFFFD8DACFFFD8DACFFFD8DACFFFD8DACFFFD8DACFFFD8DACFFFD8DACFFFD8DA
      CFFFD2D9CAFF74B47DFF7AD885FF4D9D59FFACAEA1FF9DA18DFF4D4E58FF4D4E
      58FF67697AFF545454FF0000001D00000008000000000000000000000000D7B4
      A3FFFDFDFDFFFCFCFCFFFBFBFBFFFAFAFAFFF9F9F9FFF8F8F8FFA1A1A1FF4A88
      91FF40838BFF265567FF173A58FF153954FF10344CFF143850FF1B3D55FF2343
      57FF1C384EFF27485BFF505050FFE6E6E6FFE4E4E4FFE3E3E3FFE1E1E1FFE0E0
      E0FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFCEDAE5FFCCD9
      E4FFCAD7E3FFC9D6E2FFC7D4E1FFC4D3E0FFC1D1DFFFBFD0DEFFBDCEDDFFBBCC
      DBFFB8CADAFFB6C8D9FFB3C5D8FFB0C3D6FFAEC1D5FFABBFD3FFA8BDD2FFA5BB
      D1FFA2B9CFFF505050FF00000000000000000000000000000000000000000000
      00000000000000000000A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF656565FFC3B89BFFC3B8
      9BFFC3B89BFFC3B89BFFC3B89BFFC3B89BFFC3B89BFFC3B89BFFC3B89BFFC3B8
      9BFFC3B89BFF0000000000000000000000000000000000000000000000035454
      54FF67697AFF67697AFF67697AFFA9AD98FFC9CBBCFFC9CBBCFFC9CBBCFFC9CB
      BCFFC9CBBCFFC9CBBCFFC9CBBCFFC9CBBCFFC9CBBCFFC9CBBCFFC9CBBCFFC9CB
      BCFFC9CBBCFFC9CBBCFF74B47DFF74B47DFFC2C4B6FFA7AA96FF67697AFF6769
      7AFF67697AFF545454FF0000001100000003000000000000000000000000D7B4
      A3FFFEFEFEFFFDFDFDFFFCFCFCFFFBFBFBFFFAFAFAFFF9F9F9FFA1A1A1FF4081
      8AFF3D7B85FF215266FF193E5BFF193C57FF183B55FF1D4058FF22445BFF1B3C
      54FF22425BFF4F7287FF505050FFE7E7E7FFE6E6E6FFE4E4E4FFE3E3E3FFE1E1
      E1FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFD0DCE6FFCFDA
      E5FFCDD9E4FFCBD8E4FFC9D7E3FFC8D5E2FFC5D4E1FFC2D2E0FFC0D0DEFFBECF
      DDFFBCCDDCFFB9CBDBFFB7C9DAFFB4C7D8FFB2C4D7FFAFC2D6FFACC0D4FFA9BE
      D3FFA7BCD1FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A1A1A1FF00000000000000000000000000000000000000000000
      0000A1A1A1FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0026545454FF545454FF545454FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD
      98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD
      98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FFA9AD98FF545454FF5454
      54FF545454FF000000360000000400000000000000000000000000000000D7B4
      A3FFFEFEFEFFFEFEFEFFFDFDFDFFFCFCFCFFFBFBFBFFFAFAFAFFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFE8E8E8FFE7E7E7FFE6E6E6FFE4E4E4FFE3E3
      E3FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFD2DDE7FFD1DC
      E6FFCFDBE6FFCEDAE5FFCCD9E4FFCAD7E3FFC8D6E2FFC7D4E1FFC3D3E0FFC1D1
      DFFFBFD0DEFFBDCEDDFFBACCDBFFB8CADAFFB5C8D9FFB3C5D8FFB0C3D6FFAEC1
      D5FFABBFD3FF505050FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D7B4
      A3FFFFFFFFFFFEFEFEFFFEFEFEFFFDFDFDFFFCFCFCFFFBFBFBFFFAFAFAFFF9F9
      F9FFF8F8F8FFF7F7F7FFF6F6F6FFF5F5F5FFF3F3F3FFF2F2F2FFF1F1F1FFEFEF
      EFFFEEEEEEFFEDEDEDFFEBEBEBFFEAEAEAFFE8E8E8FFE7E7E7FFE5E5E5FFE4E4
      E4FFD09476FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009897970066666600666666006666
      6600666666006666660066666600666666006666660066666600666666006666
      6600666666006666660066666600666666006666660066666600666666006666
      6600666666006666660066666600666666006666660066666600666666006666
      6600666666006666660066666600666666009897970066666600666666006666
      6600666666006666660066666600666666006666660066666600666666006666
      6600666666006666660066666600666666006666660066666600666666006666
      6600666666006666660066666600666666006666660066666600666666006666
      6600666666006666660066666600666666008B8B8B0019191900191919001919
      1900191919001919190019191900191919001919190019191900191919001919
      1900191919001919190019191900191919001919190019191900191919001919
      1900191919001919190019191900191919001919190019191900191919001919
      1900191919001919190019191900191919008B8B8B0019191900191919001919
      1900191919001919190019191900191919001919190019191900191919001919
      1900191919001919190019191900191919001919190019191900191919001919
      1900191919001919190019191900191919001919190019191900191919001919
      19001919190019191900191919001919190098979700FAE4D300F9E3D200F9E3
      D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DDC800F8DD
      C700F8DCC500F8DBC400F8DAC300F8DAC100F7D9C000F7D8BF00F7D8BE00F7D7
      BD00F7D7BC00F7D6BB00F7D5BB00F7D5BA00F6D4B900F6D4B800F6D4B700F6D3
      B700F6D3B600F6D2B600F6D2B5006666660098979700FAE4D300F9E3D200F9E3
      D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DDC800F8DD
      C700F8DCC500F8DBC400F8DAC300F8DAC100F7D9C000F7D8BF00F7D8BE00F7D7
      BD00F7D7BC00F7D6BB00F7D5BB00F7D5BA00F6D4B900F6D4B800F6D4B700F6D3
      B700F6D3B600F6D2B600F6D2B500666666008B8B8B00FFF2DC00FFF1DB00FFF0
      D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEAD000FFE9CE00FFE8
      CD00FFE7CC00FFE6CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2C200FFE1
      C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDEBC00FFDDBB00FFDDBA00FFDC
      B900FFDCB800FFDBB700FFDBB700191919008B8B8B00FFF2DC00FFF1DB00FFF0
      D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEAD000FFE9CE00FFE8
      CD00FFE7CC00FFE6CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2C200FFE1
      C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDEBC00FFDDBB00FFDDBA00FFDC
      B900FFDCB800FFDBB700FFDBB7001919190098979700FAE5D400FAE4D300F9E3
      D200F9E3D100F9E2D000F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900B1B9
      BF00F8DDC700F8DCC500F8DBC400F8DAC300F8DAC100A1A1A100666666006666
      660066666600666666006666660066666600F7D5BA00F6D4B900F6D4B800F6D4
      B700F6D3B700F6D3B600F6D2B6006666660098979700FAE5D400FAE4D30000A9
      0000F9E3D100F9E2D000F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900B1B9
      BF00F8DDC700F8DCC500F8DBC400F8DAC300F8DAC100A1A1A100666666006666
      660066666600666666006666660066666600F7D5BA00F6D4B900F6D4B800F6D4
      B700F6D3B700F6D3B600F6D2B600666666008B8B8B00FFF3DE00FFF2DC00FFF1
      DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEAD000FFE9
      CE00FFE8CD00FFE7CC00FFE6CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2
      C200FFE1C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDEBC00FFDDBB00FFDD
      BA00FFDCB900FFDCB800FFDBB700191919008B8B8B00FFF3DE00FFF2DC00FFF1
      DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEAD000FFE9
      CE00FFE8CD00FFE7CC00FFE6CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2
      C200FFE1C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDEBC00FFDDBB00FFDD
      BA00FFDCB900FFDCB800FFDBB7001919190098979700FAE6D600FAE5D400FAE4
      D300F9E3D200F9E3D100F9E2D000F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DE
      C900F8DDC800F8DDC700F8DCC500F8DBC400F8DAC300A1A1A100EAEAEA00EDED
      ED00F1F1F100F5F5F500F8F8F80066666600F7D5BB00F7D5BA00F6D4B900F6D4
      B800F6D4B700F6D3B700F6D3B6006666660098979700FAE6D600FAE5D40000A9
      0000F9E3D200006C0000006C0000006C0000006C0000006C0000006C0000F8DE
      C900F8DDC800F8DDC700F8DCC500F8DBC400F8DAC300A1A1A100EAEAEA00EDED
      ED00F1F1F100F5F5F500F8F8F80066666600F7D5BB00F7D5BA00F6D4B900F6D4
      B800F6D4B700F6D3B700F6D3B600666666008B8B8B00FFF4DF00FFF3DE00FFF2
      DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEA
      D000FFE9CE00FFE8CD00FFE7CC00FFE6CA00FFE5C900FFE4C700FFE4C500FFE3
      C400FFE2C200FFE1C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDEBC00FFDD
      BB00FFDDBA00FFDCB900FFDCB800191919008B8B8B00FFF4DF00FFF3DE00FFF2
      DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEA
      D000FFE9CE00FFE8CD00FFE7CC00FFE6CA00FFE5C900FFE4C700FFE4C500FFE3
      C400FFE2C200FFE1C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDEBC00FFDD
      BB00FFDDBA00FFDCB900FFDCB8001919190098979700FAE7D700FAE6D600FAE5
      D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00B1B9
      BF00F8DEC900B1B9BF00F8DDC700B1B9BF00F8DBC400A1A1A100E6E6E600EAEA
      EA00EDEDED00F1F1F100F5F5F50066666600F7D6BB00F7D5BB00F7D5BA00F6D4
      B900F6D4B800F6D3B700F6D3B7006666660098979700FAE7D700FAE6D60000A9
      0000006C000063E170005BDF690053DC62004BDA5B0044D854003DD64D00006C
      0000F8DEC900B1B9BF00F8DDC700B1B9BF00F8DBC400A1A1A100E6E6E600EAEA
      EA00EDEDED00F1F1F100F5F5F50066666600F7D6BB00F7D5BB00F7D5BA00F6D4
      B900F6D4B800F6D3B700F6D3B700666666008B8B8B00FFF5E100FFF4DF00A1A1
      A100A1A1A100A1A1A100FFF0D900A1A1A100A1A1A100A1A1A100A1A1A100FFEB
      D100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFE1C100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFDDBA00FFDCB900191919008B8B8B00FFF5E100FFF4DF00FFF3
      DE00FFF2DC00FFF1DB00FFF0D900A1A1A100A1A1A100A1A1A100FFECD300FFEB
      D100FFEAD000A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFE0C000A1A1A100A1A1A100A1A1A100A1A1
      A100FFDDBB00FFDDBA00FFDCB9001919190098979700FAE7D800FAE7D700FAE6
      D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0
      CC00F9DFCB00F8DEC900F8DDC800F8DDC700F8DCC500A1A1A100E3E3E300E6E6
      E600EAEAEA00EDEDED00F1F1F10066666600F7D7BC00F7D6BB00F7D5BB00F7D5
      BA00F6D4B900F6D4B800F6D3B7006666660098979700FAE7D800FAE7D70000A9
      000076E781006DE47A0065E273005DDF6B00006C000000A9000000A9000000A9
      0000006C0000F8DEC900F8DDC800F8DDC700F8DCC500A1A1A100E3E3E300E6E6
      E600EAEAEA00EDEDED00F1F1F10066666600F7D7BC00F7D6BB00F7D5BB00F7D5
      BA00F6D4B900F6D4B800F6D3B700666666008B8B8B00FFF5E300FFF5E100A1A1
      A100FFF3DE00A1A1A100FFF1DB00A1A1A100A1A1A100A1A1A100A1A1A100FFEC
      D300A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFE2C200A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFDDBB00FFDDBA00191919008B8B8B00FFF5E300FFF5E100FFF4
      DF00A1A1A100CBCBCD00A1A1A100A1A1A100FFEFD800A1A1A100FFEDD500FFEC
      D300FFEBD100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFE1C100A1A1A100A1A1A100A1A1A100A1A1
      A100FFDEBC00FFDDBB00FFDDBA001919190098979700FAE8D900FAE7D800FAE7
      D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00B1B9
      BF00F9E0CC00F9DFCB00F8DEC900F8DDC800F8DDC700A1A1A100E0E0E000E3E3
      E300E6E6E600EAEAEA00EDEDED0066666600F7D7BD00F7D7BC00F7D6BB00F7D5
      BB00F7D5BA00F6D4B900F6D4B8006666660098979700FAE8D900FAE7D80000A9
      000080EA8B0078E7840070E57D0068E37500006C0000F9E2CF00F9E1CE00B1B9
      BF0000A9000000A90000F8DEC900F8DDC800F8DDC700A1A1A100E0E0E000E3E3
      E300E6E6E600EAEAEA00EDEDED0066666600F7D7BD00F7D7BC00F7D6BB00F7D5
      BB00F7D5BA00F6D4B900F6D4B800666666008B8B8B00FFF6E400FFF5E300A1A1
      A100A1A1A100A1A1A100FFF2DC00A1A1A100A1A1A100A1A1A100A1A1A100FFED
      D500A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFE3C400A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFDEBC00FFDDBB00191919008B8B8B00FFF6E400FFF5E300FFF5
      E100CBCBCD00FFF3DE00FFF2DC00A1A1A100A1A1A100A1A1A100FFEED600FFED
      D500FFECD300A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFE2C200A1A1A100A1A1A100A1A1A100A1A1
      A100FFDEBD00FFDEBC00FFDDBB001919190098979700FBE9DB00FAE8D900FAE7
      D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1
      CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DDC800A1A1A100DEDEDE00E0E0
      E000E3E3E300E6E6E600EAEAEA0066666600F7D8BE00F7D7BD00F7D7BC00F7D6
      BB00F7D5BB00F7D5BA00F6D4B9006666660098979700FBE9DB00FAE8D90000A9
      00008BED950083EB8E007BE88600006C0000F9E3D200F9E3D100F9E2CF00F9E1
      CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DDC800A1A1A100DEDEDE00E0E0
      E000E3E3E300E6E6E600EAEAEA0066666600F7D8BE00F7D7BD00F7D7BC00F7D6
      BB00F7D5BB00F7D5BA00F6D4B900666666008B8B8B00FFF7E600FFF6E400FFF5
      E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEE
      D600FFEDD500FFECD300FFEBD100FFEAD000FFE9CE00FFE8CD00FFE7CC00FFE6
      CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2C200FFE1C100FFE0C000FFE0
      BF00FFDFBE00FFDEBD00FFDEBC00191919008B8B8B00FFF7E600FFF6E400FFF5
      E300A1A1A100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEE
      D600FFEDD500FFECD300FFEBD100FFEAD000FFE9CE00FFE8CD00FFE7CC00FFE6
      CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2C200FFE1C100FFE0C000FFE0
      BF00FFDFBE00FFDEBD00FFDEBC001919190098979700FBEADC00FBE9DB00FAE8
      D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3D100B1B9
      BF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100A1A1A100F7D8BF00F7D8BE00F7D7BD00F7D7
      BC00F7D6BB00F7D5BB00F7D5BA006666660098979700FBEADC00FBE9DB0000A9
      000000A9000000A9000000A9000000A9000000A9000000A90000F9E3D100B1B9
      BF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100A1A1A100F7D8BF00F7D8BE00F7D7BD00F7D7
      BC00F7D6BB00F7D5BB00F7D5BA00666666008B8B8B00FFF8E700FFF7E600A1A1
      A100A1A1A100A1A1A100FFF4DF00A1A1A100A1A1A100A1A1A100A1A1A100FFEF
      D800A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFE4C700A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFDFBE00FFDEBD00191919008B8B8B00FFF8E700FFF7E600A1A1
      A100A1A1A100A1A1A100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEF
      D800FFEED600A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFE4C500A1A1A100A1A1A100A1A1A100A1A1
      A100FFE0BF00FFDFBE00FFDEBD001919190098979700FBEADD00FBEADC00FBE9
      DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3
      D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DDC800F8DD
      C700F8DCC500F8DBC400F8DAC300F8DAC100F7D9C000F7D8BF00F7D8BE00F7D7
      BD00F7D7BC00F7D6BB00F7D5BB006666660098979700FBEADD00FBEADC00FBE9
      DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3
      D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DDC800F8DD
      C700F8DCC500F8DBC400F8DAC300F8DAC100F7D9C000F7D8BF00F7D8BE00F7D7
      BD00F7D7BC00F7D6BB00F7D5BB00666666008B8B8B00FFF9E900FFF8E700A1A1
      A100FFF6E400A1A1A100FFF5E100A1A1A100A1A1A100A1A1A100A1A1A100FFF0
      D900A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFE5C900A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFE0BF00FFDFBE00191919008B8B8B00FFF9E900FFF8E700A1A1
      A100FFF6E400A1A1A100FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0
      D900FFEFD800A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFE4C700A1A1A100A1A1A100A1A1A100A1A1
      A100FFE0C000FFE0BF00FFDFBE001919190098979700FBEBDE00FBEADD00FBEA
      DC00FBE9DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300B1B9
      BF00F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DD
      C800F8DDC700F8DCC500F8DBC400F8DAC300F8DAC100F7D9C000F7D8BF00F7D8
      BE00F7D7BD00F7D7BC00F7D6BB006666660098979700FBEBDE00FBEADD00FBEA
      DC00FBE9DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300B1B9
      BF00F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DD
      C800F8DDC700F8DCC500F8DBC400F8DAC300F8DAC100F7D9C000F7D8BF00F7D8
      BE00F7D7BD00F7D7BC00F7D6BB00666666008B8B8B00FFFAEA00FFF9E900A1A1
      A100A1A1A100A1A1A100FFF5E300A1A1A100A1A1A100A1A1A100A1A1A100FFF1
      DB00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFE6CA00A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFE0C000FFE0BF00191919008B8B8B00FFFAEA00FFF9E900A1A1
      A100A1A1A100A1A1A100FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1
      DB00FFF0D900A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFE5C900A1A1A100A1A1A100A1A1A100A1A1
      A100FFE1C100FFE0C000FFE0BF001919190098979700FBECDF00FBEBDE00FBEA
      DD00FBEADC00FBE9DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4
      D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0CD00A1A1A100666666006666
      660066666600666666006666660066666600F8DAC300F8DAC100F7D9C000F7D8
      BF00F7D8BE00F7D7BD00F7D7BC006666660098979700FBECDF00FBEBDE00FBEA
      DD00FBEADC00FBE9DB00FAE8D900FAE7D800006C0000006C0000006C0000006C
      0000006C0000006C0000006C0000F9E1CE00F9E0CD00A1A1A100666666006666
      660066666600666666006666660066666600F8DAC300F8DAC100F7D9C000F7D8
      BF00F7D8BE00F7D7BD00F7D7BC00666666008B8B8B00FFFBEB00FFFAEA00FFF9
      E900FFF8E700FFF7E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2
      DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEA
      D000FFE9CE00FFE8CD00FFE7CC00FFE6CA00FFE5C900FFE4C700FFE4C500FFE3
      C400FFE2C200FFE1C100FFE0C000191919008B8B8B00FFFBEB00FFFAEA00FFF9
      E900FFF8E700FFF7E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2
      DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEA
      D000FFE9CE00FFE8CD00FFE7CC00FFE6CA00FFE5C900FFE4C700FFE4C500FFE3
      C400FFE2C200FFE1C100FFE0C0001919190098979700FBEDE000FBECDF00FBEB
      DE00FBEADD00FBEADC00FBE9DB00FAE8D900FAE7D800FAE7D700FAE6D600B1B9
      BF00FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00A1A1A100EAEAEA00EDED
      ED00F1F1F100F5F5F500F8F8F80066666600F8DBC400F8DAC300F8DAC100F7D9
      C000F7D8BF00F7D8BE00F7D7BD006666660098979700FBEDE000FBECDF00FBEB
      DE00FBEADD00FBEADC00FBE9DB00FAE8D900FAE7D800FAE7D700006C000088EC
      930080EA8B0078E78400006C0000F9E2CF00F9E1CE00A1A1A100EAEAEA00EDED
      ED00F1F1F100F5F5F500F8F8F80066666600F8DBC400F8DAC300F8DAC100F7D9
      C000F7D8BF00F7D8BE00F7D7BD00666666008B8B8B00FFFCED00FFFBEB00A1A1
      A100A1A1A100A1A1A100FFF7E600A1A1A100A1A1A100A1A1A100A1A1A100FFF3
      DE00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFE8CD00A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFE2C200FFE1C100191919008B8B8B00FFFCED00FFFBEB00FFFA
      EA00FFF9E900FFF8E700FFF7E600A1A1A100A1A1A100A1A1A100FFF4DF00FFF3
      DE00FFF2DC00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFE7CC00A1A1A100A1A1A100A1A1A100A1A1
      A100FFE3C400FFE2C200FFE1C1001919190098979700FBEDE200FBEDE000FBEC
      DF00FBEBDE00FBEADD00FBEADC00FBE9DB00FAE8D900FAE7D800FAE7D700FAE6
      D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00A1A1A100E6E6E600EAEA
      EA00EDEDED00F1F1F100F5F5F50066666600F8DCC500F8DBC400F8DAC300F8DA
      C100F7D9C000F7D8BF00F7D8BE006666660098979700FBEDE200FBEDE000FBEC
      DF0000A90000006C0000FBEADC00FBE9DB00FAE8D900006C00009BF2A40093EF
      9D008BED950083EB8E00006C0000F9E3D100F9E2CF00A1A1A100E6E6E600EAEA
      EA00EDEDED00F1F1F100F5F5F50066666600F8DCC500F8DBC400F8DAC300F8DA
      C100F7D9C000F7D8BF00F7D8BE00666666008B8B8B00FFFDEE00FFFCED00A1A1
      A100FFFAEA00A1A1A100FFF8E700A1A1A100A1A1A100A1A1A100A1A1A100FFF4
      DF00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFE9CE00A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFE3C400FFE2C200191919008B8B8B00FFFDEE00FFFCED00FFFB
      EB00A1A1A100CBCBCD00A1A1A100A1A1A100FFF6E400A1A1A100FFF5E100FFF4
      DF00FFF3DE00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFE8CD00A1A1A100A1A1A100A1A1A100A1A1
      A100FFE4C500FFE3C400FFE2C2001919190098979700FCEEE300FBEDE200FBED
      E000FBECDF00FBEBDE00FBEADD00FBEADC00FBE9DB00FAE8D900FAE7D800B1B9
      BF00FAE6D600B1B9BF00FAE4D300B1B9BF00F9E3D100A1A1A100E3E3E300E6E6
      E600EAEAEA00EDEDED00F1F1F10066666600F8DDC700F8DCC500F8DBC400F8DA
      C300F8DAC100F7D9C000F7D8BF006666660098979700FCEEE300FBEDE200FBED
      E000FBECDF0000A90000006C0000006C0000006C0000ACF7B400A5F5AD009DF2
      A60096F09F008EEE9800006C0000B1B9BF00F9E3D100A1A1A100E3E3E300E6E6
      E600EAEAEA00EDEDED00F1F1F10066666600F8DDC700F8DCC500F8DBC400F8DA
      C300F8DAC100F7D9C000F7D8BF00666666008B8B8B00FFFEF000FFFDEE00A1A1
      A100A1A1A100A1A1A100FFF9E900A1A1A100A1A1A100A1A1A100A1A1A100FFF5
      E100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFEAD000A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFE4C500FFE3C400191919008B8B8B00FFFEF000FFFDEE00FFFC
      ED00CBCBCD00FFFAEA00FFF9E900A1A1A100A1A1A100A1A1A100FFF5E300FFF5
      E100FFF4DF00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFE9CE00A1A1A100A1A1A100A1A1A100A1A1
      A100FFE4C700FFE4C500FFE3C4001919190098979700FCEFE400FCEEE300FBED
      E200FBEDE000FBECDF00FBEBDE00FBEADD00FBEADC00FBE9DB00FAE8D900FAE7
      D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200A1A1A100E0E0E000E3E3
      E300E6E6E600EAEAEA00EDEDED0066666600F8DDC800F8DDC700F8DCC500F8DB
      C400F8DAC300F8DAC100F7D9C0006666660098979700FCEFE400FCEEE300FBED
      E200FBEDE000FBECDF0000A90000C3FECA00BDFCC300B6FABD00AFF8B600A7F5
      AF00A0F3A80000A90000006C0000FAE4D300F9E3D200A1A1A100E0E0E000E3E3
      E300E6E6E600EAEAEA00EDEDED0066666600F8DDC800F8DDC700F8DCC500F8DB
      C400F8DAC300F8DAC100F7D9C000666666008B8B8B00FFFEF100FFFEF000FFFD
      EE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7E600FFF6E400FFF5
      E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEE
      D600FFEDD500FFECD300FFEBD100FFEAD000FFE9CE00FFE8CD00FFE7CC00FFE6
      CA00FFE5C900FFE4C700FFE4C500191919008B8B8B00FFFEF100FFFEF000FFFD
      EE00A1A1A100FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7E600FFF6E400FFF5
      E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEE
      D600FFEDD500FFECD300FFEBD100FFEAD000FFE9CE00FFE8CD00FFE7CC00FFE6
      CA00FFE5C900FFE4C700FFE4C5001919190098979700FCEFE500FCEFE400FCEE
      E300FBEDE200FBEDE000FBECDF00FBEBDE00FBEADD00FBEADC00FBE9DB00B1B9
      BF00FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300A1A1A100DEDEDE00E0E0
      E000E3E3E300E6E6E600EAEAEA0066666600F8DEC900F8DDC800F8DDC700F8DC
      C500F8DBC400F8DAC300F8DAC1006666660098979700FCEFE500FCEFE400FCEE
      E300FBEDE200FBEDE000FBECDF0000A9000000A9000000A9000000A9000000A9
      000000A90000FAE7D700006C0000FAE5D400FAE4D300A1A1A100DEDEDE00E0E0
      E000E3E3E300E6E6E600EAEAEA0066666600F8DEC900F8DDC800F8DDC700F8DC
      C500F8DBC400F8DAC300F8DAC100666666008B8B8B00FFFFF200FFFEF100A1A1
      A100A1A1A100A1A1A100FFFBEB00A1A1A100A1A1A100A1A1A100A1A1A100FFF6
      E400A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFECD300A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFE5C900FFE4C700191919008B8B8B00FFFFF200FFFEF100FFFE
      F000CBCBCD00FFFCED00FFFBEB00A1A1A100A1A1A100A1A1A100FFF7E600FFF6
      E400FFF5E300A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFEBD100A1A1A100A1A1A100A1A1A100A1A1
      A100FFE6CA00FFE5C900FFE4C7001919190098979700FCF0E600FCEFE500FCEF
      E400FCEEE300FBEDE200FBEDE000FBECDF00FBEBDE00FBEADD00FBEADC00FBE9
      DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100A1A1A100F9DFCB00F8DEC900F8DDC800F8DD
      C700F8DCC500F8DBC400F8DAC3006666660098979700FCF0E600FCEFE500FCEF
      E400FCEEE300FBEDE200FBEDE000FBECDF00FBEBDE00FBEADD00FBEADC00FBE9
      DB00FAE8D900FAE7D80000A90000FAE6D600FAE5D400A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100A1A1A100F9DFCB00F8DEC900F8DDC800F8DD
      C700F8DCC500F8DBC400F8DAC300666666008B8B8B00FFFFF300FFFFF200A1A1
      A100FFFEF000A1A1A100FFFCED00A1A1A100A1A1A100A1A1A100A1A1A100FFF7
      E600A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFEDD500A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFE6CA00FFE5C900191919008B8B8B00FFFFF300FFFFF200FFFE
      F100A1A1A100CBCBCD00A1A1A100A1A1A100FFFAEA00A1A1A100FFF8E700FFF7
      E600FFF6E400A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFECD300A1A1A100A1A1A100A1A1A100A1A1
      A100FFE7CC00FFE6CA00FFE5C9001919190098979700FCF0E700FCF0E600FCEF
      E500FCEFE400FCEEE300FBEDE200FBEDE000FBECDF00FBEBDE00FBEADD00B1B9
      BF00FBE9DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3
      D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DD
      C800F8DDC700F8DCC500F8DBC4006666660098979700FCF0E700FCF0E600FCEF
      E500FCEFE400FCEEE300FBEDE200FBEDE000FBECDF00FBEBDE00FBEADD00B1B9
      BF00FBE9DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3
      D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DEC900F8DD
      C800F8DDC700F8DCC500F8DBC400666666008B8B8B00FFFFF500FFFFF300A1A1
      A100A1A1A100A1A1A100FFFDEE00A1A1A100A1A1A100A1A1A100A1A1A100FFF8
      E700A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFEED600A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFE7CC00FFE6CA00191919008B8B8B00FFFFF500FFFFF300FFFF
      F200CBCBCD00FFFEF000FFFDEE00A1A1A100A1A1A100A1A1A100FFF9E900FFF8
      E700FFF7E600A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFEDD500A1A1A100A1A1A100A1A1A100A1A1
      A100FFE8CD00FFE7CC00FFE6CA001919190098979700FCF1E800FCF0E700FCF0
      E600FCEFE500FCEFE400FCEEE300FBEDE200A1A1A10066666600666666006666
      6600666666006666660066666600FAE7D800FAE7D700FAE6D600FAE5D400FAE4
      D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DE
      C900F8DDC800F8DDC700F8DCC5006666660098979700FCF1E800FCF0E700FCF0
      E600FCEFE500FCEFE400FCEEE300FBEDE200A1A1A10066666600666666006666
      6600666666006666660066666600FAE7D800FAE7D700FAE6D600FAE5D400FAE4
      D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DFCB00F8DE
      C900F8DDC800F8DDC700F8DCC500666666008B8B8B00FFFFF600FFFFF500FFFF
      F300FFFFF200FFFEF100FFFEF000FFFDEE00FFFCED00FFFBEB00FFFAEA00FFF9
      E900FFF8E700FFF7E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2
      DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEA
      D000FFE9CE00FFE8CD00FFE7CC00191919008B8B8B00FFFFF600FFFFF500FFFF
      F300A1A1A100FFFEF100FFFEF000FFFDEE00FFFCED00FFFBEB00FFFAEA00FFF9
      E900FFF8E700FFF7E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2
      DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEA
      D000FFE9CE00FFE8CD00FFE7CC001919190098979700FCF2E800FCF1E800FCF0
      E700FCF0E600FCEFE500FCEFE400FCEEE300A1A1A100EAEAEA00EDEDED00F1F1
      F100F5F5F500F8F8F80066666600FAE8D900FAE7D800FAE7D700FAE6D600FAE5
      D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DF
      CB00F8DEC900F8DDC800F8DDC7006666660098979700FCF2E800FCF1E800FCF0
      E700FCF0E600FCEFE500FCEFE400FCEEE300A1A1A100EAEAEA00EDEDED00F1F1
      F100F5F5F500F8F8F80066666600FAE8D900FAE7D800FAE7D700FAE6D600FAE5
      D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0CC00F9DF
      CB00F8DEC900F8DDC800F8DDC700666666008B8B8B00FFFFF700FFFFF600A1A1
      A100A1A1A100A1A1A100FFFEF100A1A1A100A1A1A100A1A1A100A1A1A100FFFA
      EA00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFF0D900A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFE9CE00FFE8CD00191919008B8B8B00FFFFF700FFFFF600A1A1
      A100A1A1A100A1A1A100FFFEF100FFFEF000FFFDEE00FFFCED00FFFBEB00FFFA
      EA00FFF9E900A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFEFD800A1A1A100A1A1A100A1A1A100A1A1
      A100FFEAD000FFE9CE00FFE8CD001919190098979700FCF2E900FCF2E800FCF1
      E800FCF0E700FCF0E600FCEFE500FCEFE400A1A1A100E6E6E600EAEAEA00EDED
      ED00F1F1F100F5F5F50066666600FBE9DB00FAE8D900FAE7D800FAE7D700FAE6
      D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0
      CC00F9DFCB00F8DEC900F8DDC8006666660098979700FCF2E900FCF2E800FCF1
      E800FCF0E700FCF0E600FCEFE500FCEFE400A1A1A100E6E6E600EAEAEA00EDED
      ED00F1F1F100F5F5F50066666600FBE9DB00FAE8D900FAE7D800FAE7D700FAE6
      D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0CD00F9E0
      CC00F9DFCB00F8DEC900F8DDC800666666008B8B8B00FFFFF800FFFFF700A1A1
      A100FFFFF500A1A1A100FFFFF200A1A1A100A1A1A100A1A1A100A1A1A100FFFB
      EB00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFF1DB00A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFEAD000FFE9CE00191919008B8B8B00FFFFF800FFFFF700A1A1
      A100FFFFF500A1A1A100FFFFF200FFFEF100FFFEF000FFFDEE00FFFCED00FFFB
      EB00FFFAEA00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFF0D900A1A1A100A1A1A100A1A1A100A1A1
      A100FFEBD100FFEAD000FFE9CE001919190098979700FDF3EA00FCF2E900FCF2
      E800B1B9BF00FCF0E700B1B9BF00FCEFE500A1A1A100E3E3E300E6E6E600EAEA
      EA00EDEDED00F1F1F10066666600FBEADC00FBE9DB00FAE8D900FAE7D800FAE7
      D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0
      CD00F9E0CC00F9DFCB00F8DEC9006666660098979700FDF3EA00FCF2E900FCF2
      E800B1B9BF00FCF0E700B1B9BF00FCEFE500A1A1A100E3E3E300E6E6E600EAEA
      EA00EDEDED00F1F1F10066666600FBEADC00FBE9DB00FAE8D900FAE7D800FAE7
      D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1CE00F9E0
      CD00F9E0CC00F9DFCB00F8DEC900666666008B8B8B00FFFFF900FFFFF800A1A1
      A100A1A1A100A1A1A100FFFFF300A1A1A100A1A1A100A1A1A100A1A1A100FFFC
      ED00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100FFF2DC00A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100FFEBD100FFEAD000191919008B8B8B00FFFFF900FFFFF800A1A1
      A100A1A1A100A1A1A100FFFFF300FFFFF200FFFEF100FFFEF000FFFDEE00FFFC
      ED00FFFBEB00A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FFF1DB00A1A1A100A1A1A100A1A1A100A1A1
      A100FFECD300FFEBD100FFEAD0001919190098979700FDF3EB00FDF3EA00FCF2
      E900FCF2E800FCF1E800FCF0E700FCF0E600A1A1A100E0E0E000E3E3E300E6E6
      E600EAEAEA00EDEDED0066666600FBEADD00FBEADC00FBE9DB00FAE8D900FAE7
      D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1
      CE00F9E0CD00F9E0CC00F9DFCB006666660098979700FDF3EB00FDF3EA00FCF2
      E900FCF2E800FCF1E800FCF0E700FCF0E600A1A1A100E0E0E000E3E3E300E6E6
      E600EAEAEA00EDEDED0066666600FBEADD00FBEADC00FBE9DB00FAE8D900FAE7
      D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2CF00F9E1
      CE00F9E0CD00F9E0CC00F9DFCB00666666008B8B8B00FFFFFA00FFFFF900FFFF
      F800FFFFF700FFFFF600FFFFF500FFFFF300FFFFF200FFFEF100FFFEF000FFFD
      EE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7E600FFF6E400FFF5
      E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEE
      D600FFEDD500FFECD300FFEBD100191919008B8B8B00FFFFFA00FFFFF900FFFF
      F800FFFFF700FFFFF600FFFFF500FFFFF300FFFFF200FFFEF100FFFEF000FFFD
      EE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7E600FFF6E400FFF5
      E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEE
      D600FFEDD500FFECD300FFEBD1001919190098979700FDF3EC00FDF3EB00FDF3
      EA00FCF2E900FCF2E800FCF1E800FCF0E700A1A1A100DEDEDE00E0E0E000E3E3
      E300E6E6E600EAEAEA0066666600FBEBDE00FBEADD00FBEADC00FBE9DB00FAE8
      D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2
      CF00F9E1CE00F9E0CD00F9E0CC006666660098979700FDF3EC00FDF3EB00FDF3
      EA00FCF2E900FCF2E800FCF1E800FCF0E700A1A1A100DEDEDE00E0E0E000E3E3
      E300E6E6E600EAEAEA0066666600FBEBDE00FBEADD00FBEADC00FBE9DB00FAE8
      D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3D100F9E2
      CF00F9E1CE00F9E0CD00F9E0CC00666666008B8B8B00FFFFFB00FFFFFA00FFFF
      F900FFFFF800FFFFF700FFFFF600FFFFF500FFFFF300FFFFF200FFFEF100FFFE
      F000FFFDEE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7E600FFF6
      E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEF
      D800FFEED600FFEDD500FFECD300191919008B8B8B00FFFFFB00FFFFFA00FFFF
      F900FFFFF800FFFFF700FFFFF600FFFFF500FFFFF300FFFFF200FFFEF100FFFE
      F000FFFDEE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7E600FFF6
      E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEF
      D800FFEED600FFEDD500FFECD3001919190098979700FDF4EC00FDF3EC00FDF3
      EB00FDF3EA00FCF2E900FCF2E800FCF1E800A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FBECDF00FBEBDE00FBEADD00FBEADC00FBE9
      DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3
      D100F9E2CF00F9E1CE00F9E0CD006666660098979700FDF4EC00FDF3EC00FDF3
      EB00FDF3EA00FCF2E900FCF2E800FCF1E800A1A1A100A1A1A100A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100FBECDF00FBEBDE00FBEADD00FBEADC00FBE9
      DB00FAE8D900FAE7D800FAE7D700FAE6D600FAE5D400FAE4D300F9E3D200F9E3
      D100F9E2CF00F9E1CE00F9E0CD00666666008B8B8B00FFFFFC00FFFFFB00FFFF
      FA00FFFFF900FFFFF800FFFFF700FFFFF600FFFFF500FFFFF300FFFFF200FFFE
      F100FFFEF000FFFDEE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7
      E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0
      D900FFEFD800FFEED600FFEDD500191919008B8B8B00FFFFFC00FFFFFB00FFFF
      FA00FFFFF900FFFFF800FFFFF700FFFFF600FFFFF500FFFFF300FFFFF200FFFE
      F100FFFEF000FFFDEE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7
      E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0
      D900FFEFD800FFEED600FFEDD5001919190098979700D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB6006666660098979700D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600666666008B8B8B00D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600191919008B8B8B00D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600191919009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700666666009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700666666008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B00191919008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B001919190098979700DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE0098979700DEDEDE00DEDEDE006666660098979700DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE0098979700DEDEDE00DEDEDE00666666008B8B8B00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE008B8B8B00DEDEDE00DEDEDE00DEDEDE00DEDEDE008B8B
      8B00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE008B8B8B00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00191919008B8B8B00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE008B8B8B00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE008B8B8B00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE001919190098979700EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00DEDE
      DE0098979700EAE9EA00EAE9EA006666660098979700EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00DEDE
      DE0098979700EAE9EA00EAE9EA00666666008B8B8B00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00DEDEDE008B8B8B00EAE9EA00EAE9EA00EAE9EA00DEDEDE008B8B
      8B00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00DEDEDE008B8B8B00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00191919008B8B8B00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00DEDE
      DE008B8B8B00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00DEDEDE008B8B8B00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA001919190098979700F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600EAE9
      EA0098979700F5F5F600F5F5F6006666660098979700F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600EAE9
      EA0098979700F5F5F600F5F5F600666666008B8B8B00F5F5F600F5F5F600F5F5
      F600F5F5F600EAE9EA008B8B8B00F5F5F600F5F5F600F5F5F600EAE9EA008B8B
      8B00F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600EAE9EA008B8B8B00F5F5F600F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600191919008B8B8B00F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600EAE9
      EA008B8B8B00F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600EAE9EA008B8B8B00F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600191919009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797009897970098979700989797009897
      9700989797009897970098979700989797008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000101
      0113000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B0019191900191919001919
      1900191919001919190019191900191919001919190019191900191919001919
      1900191919001919190019191900191919001919190019191900191919001919
      1900191919001919190019191900191919001919190019191900191919001919
      1900191919001919190019191900191919000000000000000000000000000000
      0000000000000000000000000000000000030000000100000000000000000000
      0000000000000000000200000006000000000000000000000000000000000000
      0013000000000000000000000000000000120000000000000005000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006667
      69BB20262EFF565A60FB76777ADD1C1C1C590000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B00FFF2DC00FFF1DB00FFF0
      D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEAD000FFE9CE00FFE8
      CD00FFE7CC00FFE6CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2C200FFE1
      C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDEBC00FFDDBB00FFDDBA00FFDC
      B900FFDCB800FFDBB700FFDBB700191919000000000000000000000000000000
      00000000000000000000090500487B4000FF7B4100FF4C2800C90C0600520100
      0018522C00D1763F00FB452400BF211100840000000007040040784000FD341C
      00A8784000FD00000000331B00A53C1F00B2723D00F7582F00DA000000110000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006C6F
      72F15C6268FF9A9CA0FF171E26FF2E3032A70000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B00FFF3DE00FFF2DC00FFF1
      DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEAD0008B8B
      8B0019191900191919001919190019191900191919001919190019191900FFE2
      C200FFE1C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDEBC00FFDDBB00FFDD
      BA00FFDCB900FFDCB800FFDBB700191919000000000000000000000000000000
      000000000000000000001E10007E2916009400000000291500940C0600520100
      00184E2900CB0000000000000000562D00D60100001D3C1F00B2080400440000
      00000201002205020035452500C0000000000000000A613300E2000000110000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000455663FF112B45FF112B45FF112B
      45FF112B45FF112B45FF112B45FF000000000000000000000000000000004045
      4BFEA6AAAFFFF3F6F7FF52565CFF121212550000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A1A1A1FF505050FF505050FF5050
      50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
      50FF505050FF505050FF00000000000000008B8B8B00FFF4DF00FFF3DE00FFF2
      DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD1008B8B
      8B00E4EAEA00E9EDED00EDF1F100F2F5F500F6F8F800FAFBFB0019191900FFE3
      C400FFE2C200FFE1C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDEBC00FFDD
      BB00FFDDBA00FFDCB900FFDCB800191919000000000000000000000000000000
      000000000000000000000000000E311A00A2723D00F74F2A00CE0C0600520100
      00184C2800CA00000000000000003A1E00B00603003D4F2A00CE050200350000
      00000000000008040044331B00A50000000000000000603400E3000000110000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000455663FF64A4DBFF5699D5FF488F
      CFFF3B86C9FF2F7CC3FF112B45FF000000000000000000000000010101132429
      31FFD8DBDFFFF3F6F7FF52565CFF212121620000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A1A1A1FF709ABEFF6D97BCFF6995
      BAFF6692B9FF6390B7FF608EB6FF5D8CB5FF5A8AB4FF5889B2FF5687B1FF5486
      B0FF5284B0FF505050FF00000000000000008B8B8B00FFF5E100FFF4DF00FFF3
      DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD3008B8B
      8B00E0E6E600E4EAEA00E1E5E400006C0000F2F5F500F6F8F80019191900FFE4
      C500FFE3C400FFE2C200FFE1C100FFE0C000FFE0BF00FFDFBE00FFDEBD00FFDE
      BC00FFDDBB00FFDDBA00FFDCB900191919000000000000000000000000000000
      00000000000000000000000000000000000000000000281500920A05004C0100
      00187B4100FF0000000900000000562D00D60100001B3B1F00B2090500480000
      00000E07005702010024462500C10000000001000019613400E3000000110000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000455663FF78B3E4FF6AA8DEFF5C9E
      D7FF4E94D1FF418ACCFF112B45FF000000000000000000000000424242902C32
      3AFFF9FBFCFFCDD1D5FF282E36FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A1A1A1FF779EC0FF739CBFFF6F99
      BDFF6C96BBFF6894BAFF6592B8FF6290B7FF5F8DB6FF5C8CB4FF5A8AB3FF5788
      B2FF5587B1FF505050FF00000000000000008B8B8B00FFF5E300FFF5E100FFF4
      DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD5008B8B
      8B00DCE3E300E0E6E60000A9000073DA7E00006C0000F2F5F50019191900FFE4
      C700FFE4C500FFE3C400FFE2C200FFE1C100FFE0C000FFE0BF00FFDFBE00FFDE
      BD00FFDEBC00FFDDBB00FFDDBA00191919000000000000000000000000000000
      0000000000000000000008040042773E00FA381E00AC4E2A00CC0000000D0100
      0018783F00FD723D00F74A2600C629150094000000000302002E783F00FD391E
      00AF442300BE000000002514008E482600C3763E00FB7B4100FF000000110000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000425E5EFF0E292AFF0E292AFF455663FF8EC2EDFF7EB7E6FF70AD
      E0FF62A2DAFF5498D4FF112B45FF000000000000000000000000727579E4545A
      61FFFFFFFFFF959A9FFF505359FC000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF505050FF5050
      50FF505050FF505050FF505050FF505050FFA1A1A1FF7DA3C3FF79A0C2FF769D
      C0FF729BBEFF6E98BDFF6B96BBFF6793B9FF6491B8FF618FB7FF5E8DB5FF5B8B
      B4FF5989B3FF505050FF00000000000000008B8B8B00FFF6E400FFF5E300FFF5
      E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEED6008B8B
      8B00D8E0E000DCE3E30000A9000082DE8C0073DA7E00006C000019191900FFE5
      C900FFE4C700FFE4C500FFE3C400FFE2C200FFE1C100FFE0C000FFE0BF00FFDF
      BE00FFDEBD00FFDEBC00FFDDBB00191919000000000000000000000000000000
      0000000000000000000000000000000000000000000C00000000000000000100
      0018633300E50000000000000005000000000000000000000000000000000000
      000900000000000000000000000000000000000000007B4100FF000000110000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000425E5EFF63E3E6FF56E1E4FF455663FFA2D2F5FF94C8EFFF85BC
      E9FF76B1E3FF68A7DDFF112B45FF00000000000000000000000053575DFC989D
      A2FFFFFFFFFF5B6067FF717478E4000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF6ECFECFF6BCE
      ECFF67CDECFF64CCECFF61CBECFF5ECAECFFA1A1A1FF85A8C8FF81A5C5FF7CA2
      C3FF789FC1FF749DBFFF719ABEFF6D97BCFF6A95BBFF6693B9FF6390B8FF608E
      B6FF5D8CB5FF505050FF00000000000000008B8B8B00FFF7E600FFF6E400FFF5
      E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD8008B8B
      8B00D5DEDE00D8E0E00000A9000091E29A0082DE8C0073DA7E00006C0000FFE6
      CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2C200FFE1C100FFE0C000FFE0
      BF00FFDFBE00FFDEBD00FFDEBC00191919000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000100
      0018512B00CF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000653500E9000000110000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000425E5EFF76E7E9FF69E4E7FF455663FFB5E0FEFFA8D6F8FF9ACC
      F2FF8CC1ECFF7CB6E5FF112B45FF000000000000000000000000393F46FF2A30
      37FF666A70FF252C34FF4040418E000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A1FF74D0ECFF71CF
      ECFF6DCEECFF69CDECFF66CCECFF63CBECFFA1A1A1FF8CACCBFF88AAC9FF84A7
      C7FF80A4C4FF7BA1C2FF779EC1FF739CBFFF7099BDFF6C97BCFF6994BAFF6592
      B9FF6290B7FF505050FF00000000000000008B8B8B00FFF8E700FFF7E600FFF6
      E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D9008B8B
      8B00D3DCDC0000A90000AEEAB400A0E6A70091E29A0082DE8C0073DA7E00006C
      0000FFE6CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2C200FFE1C100FFE0
      C000FFE0BF00FFDFBE00FFDEBD00191919000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000080400420000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000603003C000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000605954FF3F36
      2FFF3F362FFF425E5EFF89EAECFF7BE8EAFF455663FF94B1C0FF617889FF5E75
      88FF5B7386FF7299B6FF112B45FF000000000000000016171750151B24FF2026
      2EFF151B23FF1F252DFF00000010000000000000000000000000A1A1A1FF5050
      50FF505050FF505050FF505050FF505050FF505050FFA1A1A1FF7BD2EDFF77D1
      EDFF73D0ECFF70CFECFF6CCEECFF68CDECFFA1A1A1FF93B1CEFF8FAECCFF8BAC
      CAFF87A9C8FF83A6C5FF7EA3C4FF7AA0C2FF769EC0FF729BBEFF6F98BDFF6B96
      BBFF6894BAFF505050FF00000000000000008B8B8B00FFF9E900FFF8E700FFF7
      E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB008B8B
      8B008B8B8B0000A90000BBEDC00000A9000000A9000000A9000082DE8C0073DA
      7E00006C0000FFE6CA00FFE5C900FFE4C700FFE4C500FFE3C400FFE2C200FFE1
      C100FFE0C000FFE0BF00FFDFBE00191919000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000170804004300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000605954FFEED0
      B8FFEDCDB4FF425E5EFF9CEDEFFF8FEBEDFF455663FF9EB8C0FF657B89FF6279
      89FF5F7688FF80A2BCFF112B45FF0000000000000000727476CB0B1119FF2228
      30FF1A2028FF51555BFE00000000000000000000000000000000A1A1A1FFF4D7
      BFFFF4D6BEFFF3D5BCFFF3D4BBFFF3D3B9FFF3D2B8FFA1A1A1FF83D4EDFF7ED3
      EDFF7AD2EDFF76D1ECFF72D0ECFF6ECFECFFA1A1A1FF9AB6D1FF96B3CFFF92B0
      CDFF8EAECBFF8AABCAFF86A8C8FF82A5C5FF7DA2C3FF79A0C1FF759DC0FF719A
      BEFF6E98BCFF505050FF00000000000000008B8B8B00FFFAEA00FFF9E900FFF8
      E700FFF7E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1
      DB0000A90000D1F3D40000A90000FFEDD500FDEBD30000A9000000A9000082DE
      8C0073DA7E00006C0000F9E4C800FFE5C900FFE4C700FFE4C500FFE3C400FFE2
      C200FFE1C100FFE0C000FFE0BF00191919001F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000605954FFF0D6
      C0FFEFD3BCFF425E5EFFADF1F2FFA1EEF0FF455663FFE8FFFFFFDEFDFFFFD3F5
      FFFFC7EDFFFFB9E3FFFF112B45FF000000000000000076787EF710161FFF2228
      30FF0F141DFF7C7F82F300000000000000000000000000000000A1A1A1FFF4D9
      C2FFF4D8C1FFF4D6BFFFF4D5BDFFF3D4BCFFF3D4BAFFA1A1A1FF89D6EDFF85D5
      EDFF81D4EDFF7CD3EDFF79D2EDFF75D0ECFFA1A1A1FFA1BBD4FF9DB8D2FF99B5
      D1FF95B2CFFF91B0CDFF8DADCBFF88AAC9FF84A7C7FF80A4C4FF7BA1C3FF789F
      C1FF749CBFFF505050FF00000000000000008B8B8B00FFFBEB00FFFAEA00FFF9
      E900FFF8E700FFF7E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3DE00FFF2
      DC0000A9000000A90000FEEED800FFEED600FFEDD500FFECD300FFEBD10000A9
      000082DE8C0073DA7E00006C0000FCE6CA00FFE5C900FFE4C700FFE4C500FFE3
      C400FFE2C200FFE1C100FFE0C000191919007B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF0000000000000000000000000081
      C4FF005995FF005895FF00000000000000000000000000000000006AAEFF0056
      92FF005691FF425E5EFFA5D6D7FF668E8EFF455663FF455663FF455663FF4556
      63FF455663FF455663FF455663FF0000000000000000484D54FF1B2129FF2228
      30FF0A1119FF666768BA00000000000000000000000000000000A1A1A1FFF5DB
      C5FFF5DAC4FFF4D8C2FFF4D7C0FFF4D6BFFFF3D5BDFFA1A1A1FF90D8EEFF8CD7
      EDFF88D6EDFF84D5EDFF80D3EDFF7BD2EDFFA1A1A1FFA8C0D7FFA4BDD6FFA0BA
      D4FF9CB7D2FF98B4D0FF94B2CEFF8FAFCCFF8BACCAFF87A9C9FF83A6C7FF7EA3
      C4FF7AA1C2FF505050FF00000000000000008B8B8B00FFFCED00FFFBEB00FFFA
      EA00FFF9E900FFF8E700FFF7E600FFF6E400FFF5E300FFF5E100FFF4DF00FFF3
      DE0000A90000FEF0DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FEEB
      D20000A9000000A9000073DA7E00006C0000FAE5CA00FFE5C900FFE4C700FFE4
      C500FFE3C400FFE2C200FFE1C100191919001F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F100080000000000000000000000000007D
      C1FF04DCFFFF00C4F4FF005894FF005995FF0572AFFF0081C1FF00B6F4FF00C5
      FFFF005691FF425E5EFFB1D8D9FF6B8F8FFF678E8EFF648D8EFF8DD2D3FF0E29
      2AFF000000000000000000000000000000000505052620262EFF222830FF2329
      31FF171E26FF0F0F0F4100000000000000000000000000000000A1A1A1FFF6DD
      CAFFF5DCC8FFF5DAC5FFF5D9C3FFF4D8C2FFF4D7C0FFA1A1A1FF97DAEEFF93D9
      EEFF8FD8EDFF8BD7EDFF87D5EDFF83D4EDFFA1A1A1FFAEC4DAFFABC2D9FFA7BF
      D7FFA3BCD5FF9FB9D3FF9BB6D1FF96B4CFFF92B1CEFF8EAECCFF8AABCAFF86A8
      C8FF82A5C5FF505050FF00000000000000008B8B8B00FFFDEE00FFFCED00FFFB
      EB00FFFAEA00FFF9E900FFF8E700FFF7E600FFF6E400FFF5E300FFF5E100FFF4
      DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFEC
      D300FFEBD200FFEAD00000A9000073DA7E00006C0000FAE5CB00FFE5C900FFE4
      C700FFE4C500FFE3C400FFE2C200191919000000000000000000000000000000
      0000000000150201002300000012000000000000000000000000000000000000
      00000000000000000000000000000000000A0000000000000000000000000000
      0000000000000000000000000000000000080000000000000000000000000000
      0000000000000000000000000008000000000000000000000000000000000577
      B5FF03D3FBFF04DEFFFF00D8FFFF00B7EEFF00B4EEFF00CEFFFF00CDFFFF00BE
      FBFF0063A2FF425E5EFFDBF9F9FFD2F7F8FFC8F5F6FFBCF3F4FFB1F1F2FF0E29
      2AFF00000000000000000000000000000000545555A40B121AFF222830FF1E24
      2CFF3D434AFF0000000000000000000000000000000000000000A1A1A1FFF6DF
      CDFFF6DECBFFF6DDC9FFF5DBC7FFF5DAC5FFF5D9C3FFA1A1A1FF9EDCEEFF9ADB
      EEFF96DAEEFF92D9EEFF8ED7EDFF8AD6EDFFA1A1A1FFB5CADDFFB1C7DCFFADC4
      DAFFA9C1D8FFA5BED6FFA1BBD4FF9DB8D3FF99B6D1FF95B3CFFF91B0CDFF8DAD
      CBFF89AAC9FF505050FF00000000000000008B8B8B00FFFEF000FFFDEE00FFFC
      ED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7E600FFF6E400FFF5E300FFF5
      E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEED600FFED
      D500FFECD300FFEBD100F3E7CC0000A9000073DA7E00006C0000FFE6CA00FFE5
      C900FFE4C700FFE4C500FFE3C400191919000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000B77
      B4FF03CAF4FF05DEFFFF01D8FFFF00D8FFFF00D5FFFF00CEFFFF00CDFFFF00B9
      F4FF0472B1FF425E5EFF425E5EFF425E5EFF425E5EFF425E5EFF425E5EFF425E
      5EFF00000000000000000000000000000000808386ED0A1018FF222830FF1219
      21FF6D7176FA0000000000000000000000000000000000000000A1A1A1FFF7E1
      D1FFF7E0CFFFF6DFCDFFF6DECBFFF5DCC9FFF5DBC7FFA1A1A1FFA5DEEEFFA1DD
      EEFF9DDCEEFF99DAEEFF95D9EEFF91D8EEFFA1A1A1FFBBCEE0FFB7CCDEFFB4C9
      DDFFB0C5DBFFACC3D9FFA8C0D8FFA4BDD6FFA0BAD4FF9CB8D2FF98B5D0FF94B2
      CEFF90AFCCFF505050FF00000000000000008B8B8B00FFFEF100FFFEF000FFFD
      EE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7E600FFF6E400FFF5
      E300FFF5E100FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEE
      D600FFEDD500FFECD300FFEBD100FFEAD00000A9000000A90000FFE7CC00FFE6
      CA00FFE5C900FFE4C700FFE4C500191919000000000002010024743D00F9743D
      00F97B4100FF7B4100FF7A4100FF7B4100FF482600C3281500937B4100FF0704
      004000000000000000000000000000000000000000000000000000000010723D
      00F75E3200DF000000000000000000000000763F00FB422300BB000000000000
      0000000000000000000000000000000000000000000000000000000000002E84
      B7FF04BBE9FF12E5FFFF0ADBFFFF01D8FFFF00D4FFFF00D1FFFF00D3FFFF00AC
      E9FF267DB1FF918882FF918781FFD8CABEFF3F362FFF00000000000000000000
      000000000000000000000000000000000000555A60FE2A3038FF171D25FF0910
      17FF7C7E7FDA0000000000000000000000000000000000000000A1A1A1FFF8E4
      D4FFF7E2D2FFF7E1D0FFF6E0CEFFF6DFCCFFF6DDCAFFA1A1A1FFABE0EFFFA7DF
      EEFFA3DEEEFF9FDCEEFF9BDBEEFF97DAEEFFA1A1A1FFC0D2E3FFA1A1A1FF7878
      78FF787878FF787878FF787878FF787878FF787878FF787878FF787878FF7878
      78FF97B4D0FF505050FF00000000000000008B8B8B00FFFFF200FFFEF100FFFE
      F000FFFDEE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E700FFF7E6008B8B
      8B0019191900191919001919190019191900191919001919190019191900FFEF
      D800FFEED600FFEDD500FFECD300FFEBD100FFEAD000FFE9CE00FFE8CD00FFE7
      CC00FFE6CA00FFE5C900FFE4C7001919190000000000050200357B4100FF5E31
      00DE281500932413008B2112008521120085211100850603003C7B4100FF2D18
      009B000000000000000000000000000000000000000000000000130A00647B41
      00FF2714008F0000000000000000000000007B4100FF452400BF000000000000
      0000000000000000000000000000000000000000000000000000000000000B7C
      B8FF26D7F5FF2AE9FFFF1DE0FFFF12DCFFFF05D7FFFF00D4FFFF00D4FFFF00BE
      F4FF005793FFFAF1EAFFF9EEE6FFF8ECE2FF3F362FFF00000000000000000000
      000000000000000000000000000000000000222830FFDDE0E3FFE2E5E8FF1A20
      29FF2D2E2E740000000000000000000000000000000000000000A1A1A1FFF8E6
      D8FFF8E5D6FFF7E3D4FFF7E2D2FFF7E1D0FFF6E0CEFFA1A1A1FFB1E1EFFFAEE0
      EFFFAADFEFFFA6DEEEFFA2DDEEFF9EDCEEFFA1A1A1FFC7D6E5FFA1A1A1FFCCD0
      D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FF7878
      78FF9EB9D3FF505050FF00000000000000008B8B8B00FFFFF300FFFFF200FFFE
      F100FFFEF000FFFDEE00FFFCED00FFFBEB00FFFAEA00FFF9E900FFF8E7008B8B
      8B00E4EAEA00E9EDED00EDF1F100F2F5F500F6F8F800FAFBFB0019191900FFF0
      D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEAD000FFE9CE00FFE8
      CD00FFE7CC00FFE6CA00FFE5C9001919190000000000050200357B4100FF371D
      00AA0000000000000000000000000000000000000000000000005E3200DF6F3B
      00F3000000080000000000000000000000000000000000000000482600C37B41
      00FF040200300000000000000000000000007B4100FF452400BF000000000000
      00000000000000000000000000000000000000000000000000000A78B5FF3DDA
      F3FF54F4FFFF46EAFFFF39E7FFFF29E3FFFF18DCFFFF07D8FFFF00D4FFFF00D5
      FFFF00BBF1FF005793FF605954FF605954FF605954FF00000000000000000000
      00000000000000000000000000002828286D272D35FFF5F8FAFFD9DCE0FF272D
      34FF000000040000000000000000000000000000000000000000A1A1A1FFF9E8
      DBFFF8E7D9FFF8E6D7FFF8E4D5FFF7E3D3FFF7E2D1FFA1A1A1FFB7E3EFFFB4E2
      EFFFB0E1EFFFADE0EFFFA9DFEEFFA5DEEEFFA1A1A1FFCBD9E7FFA1A1A1FFCCD0
      D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FF7878
      78FFA5BED6FF505050FF00000000000000008B8B8B00FFFFF500FFFFF300FFFF
      F200FFFEF100FFFEF000FFFDEE00FFFCED00FFFBEB00FFFAEA00FFF9E9008B8B
      8B00E0E6E600E4EAEA00E1E5E400006C0000F2F5F500F6F8F80019191900FFF1
      DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEAD000FFE9
      CE00FFE8CD00FFE7CC00FFE6CA001919190000000000050200367B4100FF371D
      00AA000000000000000000000000000000000000000000000000201100837B41
      00FF2D18009B1F1000801F1000801F1000801F100080201100837B4100FF582F
      00D7000000000000000000000000000000007B4100FF452400BF000000000000
      000000000000000000000000000000000000000000001080B9FF58DEF3FF80FF
      FFFF72F4FFFF66F1FFFF56EDFFFF43E9FFFF2EE3FFFF18DCFFFF07D8FFFF00D4
      FFFF00D8FFFF00BBF1FF005793FF000000000000000000000000000000000000
      0000000000000000000000000000717375D84E535AFFFFFFFFFFA2A6ABFF4449
      4FFE000000000000000000000000000000000000000000000000A1A1A1FFF9EB
      DFFFF9E9DDFFF9E8DBFFF8E7D9FFF8E5D7FFF8E4D5FFA1A1A1FFBDE5EFFFA1A1
      A1FF787878FF787878FF787878FF787878FFA1A1A1FFCFDCE9FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFABC2D9FF505050FF00000000000000008B8B8B00FFFFF600FFFFF500FFFF
      F300FFFFF200FFFEF100FFFEF000FFFDEE00FFFCED00FFFBEB00FFFAEA008B8B
      8B00DCE3E300E0E6E60000A9000082DE8C00006C0000F2F5F50019191900FFF2
      DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEBD100FFEA
      D000FFE9CE00FFE8CD00FFE7CC001919190000000000050200367B4100FF371D
      00AA000000000000000000000000000000000000000000000000020100247B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF1D0F
      007C000000000000000000000000000000007B4100FF452400BF000000000000
      000000000000000000000000000000000000318ABDFF31B6DCFF82F1F9FF90F5
      FFFF9AFCFFFF92FCFFFF75F3FFFF5DEDFFFF44E9FFFF2BE3FFFF17E2FFFF04DA
      FFFF00D0FCFF00C7F8FF009BDAFF237EB4FF0000000000000000000000000000
      00000000000000000000000000005A5E63FA878C92FFFFFFFFFF676C73FF6D71
      75EE000000000000000000000000000000000000000000000000A1A1A1FFFAED
      E2FFFAEBE0FFF9EADEFFF9E9DCFFF9E8DBFFF8E6D9FFA1A1A1FFC2E6EFFFA1A1
      A1FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFA1A1A1FFD3DEEAFFD1DDEAFFCFDB
      E9FFCCDAE7FFCAD8E6FFC7D6E5FFC3D4E4FFC0D2E2FFBCCFE1FFB9CDDFFFB5CA
      DEFFB2C8DCFF505050FF00000000000000008B8B8B00FFFFF700FFFFF600FFFF
      F500FFFFF300FFFFF200FFFEF100FFFEF000FFFDEE00FFFCED00FFFBEB008B8B
      8B00D8E0E000DCE3E30000A900008DE196007FDD8900006C000019191900FFF3
      DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFECD300FFEB
      D100FFEAD000FFE9CE00FFE8CD001919190000000000050200367B4100FF361D
      00A9000000000000000000000000000000000000000000000000000000004B28
      00C7673700EB00000004000000000000000000000000482600C37B4100FF0100
      001C000000000000000000000000000000007B4100FF452400BF000000000000
      000000000000000000000000000000000000000000004193C0FF2588BCFF1A87
      BCFF038BC4FF40B7DFFF92F7FFFF78F4FFFF59EEFFFF3CE7FFFF01A8DCFF007D
      C1FF0578B7FF167CB5FF3187B8FF0607072E1A2E3A860472B1FF101316540000
      000000000000000000000000000032373EFFC8CCCFFFFDFFFFFF363C44FF5859
      5AAD000000000000000000000000000000000000000000000000A1A1A1FFFBEF
      E5FFFAEEE4FFFAECE2FFFAEBE0FFF9EADEFFF9E9DCFFA1A1A1FFC7E8F0FFA1A1
      A1FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFA1A1A1FFD4DFEBFFD4DFEBFFD2DE
      EAFFD0DCE9FFCEDBE8FFCCD9E7FFC9D7E6FFC5D5E5FFC2D3E3FFBFD1E2FFBBCF
      E0FFB8CCDFFF505050FF00000000000000008B8B8B00FFFFF800FFFFF700FFFF
      F600FFFFF500FFFFF300FFFFF200FFFEF100FFFEF000FFFDEE00FFFCED008B8B
      8B00D5DEDE00D8E0E00000A9000099E4A1008AE093007BDC8600006C0000FFF4
      DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEED600FFEDD500FFEC
      D300FFEBD100FFEAD000FFE9CE001919190000000000050200367B4100FF341B
      00A600000000000000000000000000000000000000000000000000000000160B
      006C7B4100FF0804004400000000000000000100001C7B4100FF482600C30000
      0000000000000000000000000000000000007B4100FF452400BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000197EB8FF6FD7EEFF96FCFFFF6FF7FFFF30CAEDFF005F9AFF0202
      0219008DCFFF00BCECFF006EABFD0076B9FD00A7E9FF0085D3FF161D226D0000
      0000000000000000000000000000050C14FFBDC1C5FFE5E8EBFF1F252DFF0707
      072D000000000000000000000000000000000000000000000000A1A1A1FFFBF1
      E8FFA1A1A1FF787878FF787878FF787878FF787878FFA1A1A1FFCBE9F0FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFD4DFEBFFD4DFEBFFD4DF
      EBFFD3DFEBFFD2DDEAFFD0DCE9FFCDDAE8FFCBD9E7FFC8D7E6FFC4D5E4FFC1D2
      E3FFBED0E1FF505050FF00000000000000008B8B8B00FFFFF900FFFFF800FFFF
      F700FFFFF600FFFFF500FFFFF300FFFFF200FFFEF100FFFEF000FFFDEE008B8B
      8B00D3DCDC0000A90000B1EBB700A4E7AB0095E39E0087DF900078DB8300006C
      0000FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEED600FFED
      D500FFECD300FFEBD100FFEAD0001919190000000000050200367B4100FF321A
      00A3000000000000000000000000000000000000000000000000000000000000
      0014763F00FB321A00A300000000000000001B0E00787B4100FF130A00640000
      0000000000000000000000000000000000007B4100FF452400BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003395C2FFA1FEFFFF7AF8FFFF0071A8FF000000000101
      02180086C1FD00DCFFFF00D7FFFF00CBFFFF00CEFFFF0092DBFF161D22670000
      000000000000000000000000000065696DF9343941FF1B2129FF393E45FF0000
      0000000000000000000000000000000000000000000000000000A1A1A1FFFCF2
      EBFFA1A1A1FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFA1A1A1FFCFEAF0FFCDE9
      F0FFCBE8F0FFC8E8F0FFC5E7F0FFC2E6EFFFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FF00000000000000008B8B8B00FFFFFA00FFFFF900FFFF
      F800FFFFF700FFFFF600FFFFF500FFFFF300FFFFF200FFFEF100FFFEF0008B8B
      8B008B8B8B0000A90000BBEDC00000A9000000A9000000A9000084DE8D0075DA
      8000006C0000FFF4DF00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEFD800FFEE
      D600FFEDD500FFECD300FFEBD1001919190000000000050200367B4100FF3019
      00A0000000000000000000000000000000000000000000000000000000000000
      0000391E00AF6F3B00F30000000800000000512B00CF723D00F7000000100000
      0000000000000000000000000000000000007B4100FF452400BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002185BAFF75E2F4FF63DEF4FF1C81B8FF000000000000
      000F0087BFFD00DEFEFF00D8FFFF00D0FFFF00D0FFFF008BD1FF15191C610000
      0000000000000000000000000000000000000000000008080830434444900000
      0000000000000000000000000000000000000000000000000000A1A1A1FFFCF4
      EDFFA1A1A1FFCCD0D6FFCCD0D6FFCCD0D6FFCCD0D6FFA1A1A1FFD0EAF0FFD0EA
      F0FFCEE9F0FFCCE9F0FFCAE8F0FFC8E8F0FFC4E7F0FFC1E6EFFFBEE5EFFFBBE4
      EFFFB8E3EFFFB4E2EFFF505050FF000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B00FFFFFB00FFFFFA00FFFF
      F900FFFFF800FFFFF700FFFFF600FFFFF500FFFFF300FFFFF200FFFEF100FFFE
      F00000A90000CEF2D20000A90000FFFAEA00FDF8E80000A9000000A9000080DE
      8A0072DA7D00006C0000F9F0DC00FFF3DE00FFF2DC00FFF1DB00FFF0D900FFEF
      D800FFEED600FFEDD500FFECD3001919190000000000050200367B4100FF2E19
      009D000000000000000000000000000000000000000000000000000000000000
      00000C0600507B4100FF0C0600500301002C7B4100FF391E00AF000000000000
      0000000000000000000000000000000000007B4100FF452400BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003298C5FF3097C3FF00000000000000063395
      C2FF1FD4EEFF2CECFFFF12E1FFFF00D7FFFF00D1FFFF00C3F7FF006492E2070B
      0E45005E94E3005588ED002743A700669EE9004C82EA00010228000000000000
      0000000000000000000000000000000000000000000000000000A1A1A1FFFDF5
      F0FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFD0EAF0FFD0EA
      F0FFD0EAF0FFCFEAF0FFCEE9F0FFCCE9F0FFC9E8F0FFC7E7F0FFC3E7F0FFC0E6
      EFFFBDE5EFFFBAE4EFFF505050FF000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B00FFFFFC00FFFFFB00FFFF
      FA00FFFFF900FFFFF800FFFFF700FFFFF600FFFFF500FFFFF300FFFFF200FFFE
      F10000A9000000A90000FEFBED00FFFBEB00FFFAEA00FFF9E900FFF8E70000A9
      00007DDD87006FD97A00006C0000FCF2DE00FFF3DE00FFF2DC00FFF1DB00FFF0
      D900FFEFD800FFEED600FFEDD5001919190000000000050200367B4100FF2D18
      009A000000000000000000000000000000000000000000000000000000000000
      000000000008673700EB321A00A3201100837B4100FF0C060050000000000000
      0000000000000000000000000000000000007B4100FF452400BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005F9FC4FF5E9EC4FF000000003395C2FF24C3
      E3FF74FCFFFF6CF8FFFF46EDFFFF1AE2FFFF00DDFFFF00D1FFFF00B4F3FF0062
      9DF00078BDFF00C1E8FF00B0DDFF02C1F1FF086E9AE400020327000000000000
      0000000000000000000000000000000000000000000000000000A1A1A1FFFDF7
      F1FFFDF6F0FFFDF5EFFFFCF4EEFFFCF4EDFFFCF3EBFFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FF000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B00D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8CF
      B60000A90000D8D0B800D8CFB600D8CFB600D8CFB600D8CFB600D8CFB600D8D0
      B80000A9000000A900006BD87700006C0000D7D0B800D8CFB600D8CFB600D8CF
      B600D8CFB600D8CFB600D8CFB6001919190000000000050200367B4100FF2B16
      0097000000000000000000000000000000000000000000000000000000000000
      0000000000002B1600976F3B00F35E3200DF673700EB00000008000000000000
      0000000000000000000000000000000000007B4100FF452400BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000191F23651A87
      BCFF1A87BCFF038BC4FF74F5FEFF47F4FFFF00AEDFFF0578B7FF0578B7FF2344
      56A70078BDFF1AE7FFFF06EAFFFF00D7FFFF096F9CE900020429000000000000
      0000000000000000000000000000000000000000000000000000A1A1A1FFFDF7
      F2FFFDF7F2FFFDF6F1FFFDF6F0FFFCF5EFFFFCF4EEFFFCF3EDFFFCF3EBFFFBF2
      EAFFFBF1E8FFFBEFE6FFFBEEE5FF505050FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B0000A9000068D77400006C00008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B001919190000000000050200367B4100FF2915
      0094000000000000000000000000000000000000000000000000000000000000
      0000000000000603003C7B4100FF7B4100FF2D18009B00000000000000000201
      00207B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF5A3000DB00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000151B206355CDE5FF50E9F5FF237EB4FF00000001000000003395
      C2FF40D6EFFF6FFBFFFF34E6FFFF0CE3FFFF00BAE6FF0075B4FF000000000000
      0000000000000000000000000000000000000000000000000000A1A1A1FFFDF7
      F2FFFDF7F2FFFDF7F2FFFDF7F2FFFDF6F1FFFDF6F0FFFCF5EFFFFCF4EEFFFCF3
      ECFFFCF2EBFFFBF1E9FFFBF0E8FF505050FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00D8DDD70000A9000065D67100006C0000DEDEDE00DEDE
      DE008B8B8B00DEDEDE00DEDEDE001919190000000000010000192413008B391D
      00AE000000000000000000000000000000000000000000000000000000000000
      000000000000000000001B0E00781F1000800201002000000000000000000000
      00081F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F100080130A006400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000E3395C2FF28AACEF90E11124A00000000000000003395
      C2FF3395C2FF56BAD3F573F7FFFF16B4DEFF0394CEFF0C4665BD000000000000
      0000000000000000000000000000000000000000000000000000A1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
      A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA00EAE9
      EA00EAE9EA00EAE9EA00EAE9EA00EAE9EA0000A9000000A90000EAE9EA00DEDE
      DE008B8B8B00EAE9EA00EAE9EA00191919000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000021292E765E9EC4FF0000000000000000000000000000
      00120001021B3395C2FF42C2E0FF5E9EC4FF0001021C00000012000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B00F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5
      F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600F5F5F600EAE9
      EA008B8B8B00F5F5F600F5F5F600191919000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000060D114D2185BAFF081116570000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000003000000110000002700000035000000380000
      0035000000270000001100000003000000000000000000000000000000000000
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
      00000000000000000000000000080000002700000054000000730000007B0000
      0073000000540000002700000008000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002413008B0000000000000000000000000000
      00002212008700000000000000000000000000000000000000006D91B3FF4371
      9EFF43719EFF43719EFF43719EFF43719EFF43719EFF35587AFF35587AFF3558
      7AFF35587AFF35587AFF35587AFF35587AFF35587AFF35587AFF35587AFF3558
      7AFF35587AFF35587AFF35587AFF35587AFF35587AFF35587AFF35587AFF3558
      7AFF35587AFF35587AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000A0A0A362C2C2CE11D1E1EEA1E1E
      1EE71E1E1EE71C1D1DE71C1D1DE71C1D1DE71C1D1DE71C1C1DE71C1D1DE71D1D
      1DE71D1D1EE71C1C1CE9262626E81111114A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B4D9D59FF4D9D59FF4D9D59FF4D9D59FF4D9D
      59FF00000073000000350000000B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000300000001000000000000000000000000000000000000
      0005000000000000000000000000000000000000000A0000000F000000000000
      0000000000000000000000000000452400BF0000000000000000000000000000
      0000452400BF00000000000000000000000000000000000000006D91B3FF425A
      71CC3F5770CC3D566DCC3A536DCC38526BCC364F69CC334E69CC314C68CC2F4B
      66CC2C4965CC2B4864CC294662CC274662CC264562CC264461CC264461CC2644
      61CC264461CC264461CC2B4E70DB3B6B99FF3B6B99FF3B6B99FF3B6B99FF3B6B
      99FF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000004E4E4EB1313030FF323232FF3635
      36FF363433FF363432FF383535FF383531FF363431FF363532FF353332FF3330
      2EFF2F2E2CFF2C292CFF2E2A2AFF5C5C5CC30000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B4D9D59FF87D490FF82D28AFF7BD085FF4D9D
      59FF0000007B000000380000000B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000090500487B4000FF7B4100FF4C2800C90C06005200000000261400904122
      00B9793F00FC1E10007F00000000140B0069522C00D22F19009F783F00FC0101
      0020070400401F10008000000000341C00A76B3900EF452400BF452400BF723D
      00F7341C00A700000000000000000000000000000000000000006D91B3FF6D91
      B3FFB8D7E7FF92BCD4FF92BCD4FF92BCD4FF92BCD4FF6AA1BFFF6AA1BFFF6AA1
      BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1
      BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1BFFF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000707071FD605B5AFF87807BFF7D76
      70FF8D8586FF867C7DFF7E7874FF7A7470FF78726EFF726C69FF67605CFF8077
      78FF807777FF78706BFF5F5751FF737273FC0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000030000
      00080000000B0000000B000000164D9D59FF8DD795FF87D490FF82D28AFF4D9D
      59FF00000080000000430000001A0000000F0000000F0000000C000000070000
      0004000000040000000400000004000000040000000400000004000000040000
      0004000000040000000400000003000000000000000000000000000000000000
      00001E10007E2916009400000000291500940C0600520301002A4E2A00CB0000
      000000000000452500C00100001C140B00692111008400000000381E00AD150B
      006A070400401F1000800000000000000000482600C302010020000000005E32
      00DF0000000000000000000000000000000000000000000000006D91B3FF7194
      B5FFCEE9F5FFCDE9F4FFCCE8F4FFCBE8F4FFCAE7F4FFC9E7F3FFC8E6F3FFC7E6
      F3FFC5E5F3FFC4E5F2FFBADAE9FFA8CBDDFFC2E4F2FFC2E4F2FFC2E4F2FFC2E4
      F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FD66615FFF8C8884FF7A75
      71FF989391FF888080FF7E7876FF7B7571FF7A736FFF736D6AFF5F5A55FF8983
      80FF817777FF76706EFF5E5855FF636363FC0000000000000000000000000000
      0000000000000000000000000000000000000000000000000003000000110000
      00270000003500000038000000404D9D59FF93D99AFF8DD795FF87D490FF4D9D
      59FF0000009B0000007400000059000000530000005000000044000000310000
      0025000000220000002200000022000000220000002200000022000000220000
      0022000000220000002200000006000000000000000000000000000000000000
      00000000000E311A00A2723D00F74F2A00CE0C06005209040045321A00A30000
      0000000000002F19009E0B06004D140B00697B4000FF763F00FA7B4100FE0000
      000A070400401F1000800000000000000000170C0070140A0068000000005E32
      00DF0000000000000000000000000000000000000000000000006D91B3FF7698
      B8FFD0EAF5FFCFE9F5FFCDE9F4FFCCE8F4FFCBE8F4FFCAE7F4FFC9E7F3FFC8E6
      F3FFC7E6F3FFC5E5F3FFBADBE9FF9DC3D9FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4
      F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006C6C6CFF757171FF96918EFF7E78
      74FF6E6965FF726D68FF797471FF7C7673FF7D7774FF77716EFF68625DFF5E59
      55FF67605BFF706A66FF635A54FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000008000000270000
      0054000000730000007B0000007E4D9D59FF98DBA0FF93D99AFF8DD795FF4D9D
      59FF1E1E1EFF252525FF2A2A2AFF2B2B2BFF2D2D2DFF383838FF474747FF5151
      51FF545454FF545454FF545454FF545454FF545454FF545454FF545454FF5454
      54FF545454FF545454FF00000009000000000000000000000000000000000000
      0000000000000000000000000000281500920A05004C090400477B4100FF0000
      000800000000532B00D10302002D140B00692111008400000000351C00A80201
      0028070400401F1000800000000000000000080400442B160097000000005E32
      00DF0000000000000000000000000000000000000000000000006D91B3FF7A9B
      BAFFD1EBF5FFD0EAF5FFCFE9F5FFCEE9F4FFCCE8F4FFCBE8F4FFCAE7F4FFC9E7
      F3FFC8E6F3FFC7E6F3FFBBDBE9FFA8CBDDFFC3E5F2FFC3E5F2FFC2E4F2FFC2E4
      F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FFC2E4F2FF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000727272FF7B7877FF979291FF8781
      80FF7B7876FF7D7978FF837D7BFF817B7AFF847D7AFF7E7976FF716C68FF6A66
      64FF6B6663FF6D6764FF554D4BFF656565FF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000B74B47DFF4D9D
      59FF4D9D59FF4D9D59FF4D9D59FF4D9D59FF9EDDA5FF98DBA0FF93D99AFF4D9D
      59FF4D9D59FF4D9D59FF4D9D59FF4D9D59FF4D9D59FF797A7BFFB1B2B3FFD6D7
      D9FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1E3FFE0E1
      E3FFE0E1E3FF545454FF00000009000000000000000000000000000000000000
      000008040042773E00FA381E00AC4E2A00CC0000000D0402002F3D2100B5743D
      00F97B4100FF1E10007E00000000140B00697B4100FE331B00A57B4000FF0000
      0013050300386B3900EF5E3200DF140A00680100001C603400E3452400BF6B39
      00EF0000000000000000000000000000000000000000000000006D91B3FF809F
      BDFFD3EBF6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFFC8E6F3FFBCDBE9FF9DC3D9FFC4E5F3FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFC2E4F2FFC2E4F2FFC2E4F2FF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF4B4848FF5E595BFF645F
      60FF615B5CFF686363FF7D7476FF706567FF676062FF4F484AFF3A3333FF352E
      2DFF312929FF2D2526FF241E1FFF656565FF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000B74B47DFFC0EA
      C4FFBBE8BFFFB5E6BAFFB0E3B5FFAAE1B0FFA4DFAAFF9EDDA5FF98DBA0FF93D9
      9AFF8DD795FF87D490FF82D28AFF7BD085FF4D9D59FF787879FFB6B7B8FFDFE0
      E2FFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF00000009000000000000000000000000000000000000
      000000000000000000000000000C000000000000000000000000763F00FB0100
      0017000000000000000000000000000000000000000400000003000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006D91B3FF85A2
      BFFFD5ECF6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFFBCDBEAFFA8CBDDFFC5E6F3FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFC2E4F2FFC2E4F2FF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000686868FF565252FFC0BDBDFF9F9C
      9DFF9E9B9CFFA3A1A1FFAAA6A8FFA6A4A4FFA4A2A3FFA09D9EFF9B999AFF9C99
      9AFF9A9798FFBDBABBFF615C5DFF656565FF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000B74B47DFFC5EC
      CAFFC0EAC4FFBBE8BFFFB5E6BAFFB0E3B5FFAAE1B0FFA4DFAAFF9EDDA5FF98DB
      A0FF93D99AFF8DD795FF87D490FF82D28AFF4D9D59FF644D52FF877074FF9F88
      8DFFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF545454FF00000009000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000C060050783F
      00FD7B4100FF2B17009800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006D91B3FF89A6
      C1FFD6EDF6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFFBDDCEAFF9DC3D9FFC8E6F3FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFC2E4F2FFC2E4F2FF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF7B7879FF868483FF1311
      10FF1B1918FF1A1818FF1A1717FF1A1818FF1A1919FF1B1916FF191818FF1B1A
      1AFF171616FF606060FF8C8A8AFF656565FF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000874B47DFFCBED
      CFFFC5ECCAFFC0EAC4FFBBE8BFFFB5E6BAFFB0E3B5FFAAE1B0FFA4DFAAFF9EDD
      A5FF98DBA0FF93D99AFF8DD795FF87D490FF4D9D59FF3A3A3AFF4A4B4BFF5556
      56FF585959FF6C6C6EFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000170804004300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006D91B3FF8EA9
      C4FFD8EDF7FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFFCDE9F4FFCCE8F4FFBDDCEAFFA8CBDDFFC9E7F3FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFC2E4F2FF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF7B7878FFE9E6E6FFEEED
      EDFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFEFEFFFFFFFFFFFFFFFFFFF4F2
      F2FFE9E8E8FFE1DFDFFF878384FF656565FF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000374B47DFF74B4
      7DFF74B47DFF74B47DFF74B47DFF74B47DFFB5E6BAFFB0E3B5FFAAE1B0FF4D9D
      59FF4D9D59FF4D9D59FF4D9D59FF4D9D59FF4D9D59FF69534EFF715C54FF7761
      59FF79635BFF746059FF4D363AFFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF545454FF00000009000000001F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F10008000000000000000006D91B3FF92AC
      C7FFECF3F6FFD8EDF7FFD7EDF6FFD5ECF6FFD4ECF6FFD3EBF6FFD2EBF5FFD0EA
      F5FFCFE9F5FFCEE9F4FFBDDCEAFF9DC3D9FFCAE7F4FFC9E7F3FFC8E6F3FFC7E6
      F3FFC5E6F3FFC4E5F3FFC3E5F2FFC3E5F2FFC2E4F2FFC2E4F2FFC2E4F2FF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF807A7AFFEDEBEBFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
      FFFFF4F4F4FFE7E6E7FF918C8CFF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000030000
      00080000000B0000000B0000001674B47DFFBBE8BFFFB5E6BAFFB0E3B5FF4D9D
      59FF757576FFAFB0B1FF535353FF9DA28FFFA0A38FFF898C7AFF858775FF8A8C
      7AFF868876FF9B9E8BFFAAAE99FF5E5F5DFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF00000009000000007B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF00000000000000006D91B3FF96AF
      C9FFECF3F6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFFBDDCEAFFA8CBDDFFCCE8F4FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFC2E4F2FFC2E4F2FF6AA1
      BFFF3B6B99FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF807A7AFFFAF9F8FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF8F8F8FF948E8FFF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B74B47DFFC0EAC4FFBBE8BFFFB5E6BAFF4D9D
      59FF60484DFF412A2FFF756059FF7E6960FF816B63FF735D56FF67514BFF6A54
      4EFF66504AFF725D55FF826D63FF7B665EFF4D363BFFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF545454FF00000009000000001F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F1000801F1000801F1000801F1000801F10
      00801F1000801F1000801F1000801F10008000000000000000006D91B3FF9AB2
      CBFFECF3F6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFFBDDCEAFF9DC3D9FFCDE9F4FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFC2E4F2FF6AA1
      BFFF3C6B9AFF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF827B7CFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      FDFFFFFFFFFFFFFFFFFF8F8B8BFF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B74B47DFFC5ECCAFFC0EAC4FFBBE8BFFF4D9D
      59FF404041FF6D7065FFA5A894FFACAE9AFFB0B59EFF999D89FF848675FF8687
      76FF828673FF9A9D8AFFAEB19DFFABAE9AFF696A65FFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF00000009000000000000000000000000000000000000
      0000000000150201002300000012000000000000000000000000000000000000
      00000000000000000000000000000000000A0000000000000000000000000000
      0000000000000000000000000000000000080000000000000000000000000000
      00000000000000000000000000080000000000000000000000006D91B3FF9EB5
      CDFFECF3F6FFDDEFF8FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFFD2EBF5FFBDDCEAFFA8CBDDFFCFE9F5FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFC4E5F3FFC3E5F2FF6AA1
      BFFF3E6D9BFF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF848181FFFBF9F8FFCDCC
      CCFFEAE9E9FFEAE9E9FFD4D1D2FFCCCACBFFCBC9C9FFCCCACBFFCCCACBFFDDDA
      DAFFFFFFFFFFFFFFFFFF888485FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000874B47DFFCBEDCFFFC5ECCAFFC0EAC4FF4D9D
      59FF424344FF6A554FFF7B665EFF816962FF79635BFF6A544DFF664F49FF715C
      54FF77625AFF7D685FFF7E6860FF7D6960FF7B655EFF4F373CFFA58E94FFEAEB
      EDFFE0E1E3FF545454FF000000090000000000000000000000000402002F4826
      00C37B4100FF7B4100FF7B4100FF5E3200DF2513008C01000018000000000000
      000000000000000000000C0600527B4100FF1A0E007600000000000000000000
      00000000000000000000180C00717B4100FF0E07005700000000000000000000
      000000000000180C00717B4100FF2212008600000000000000006D91B3FFA2B8
      CFFFECF3F6FF89B8CDFFDDF0F8FFDCEFF8FFDAEFF7FFD9EEF7FFD8EDF7FFD7ED
      F6FFD5ECF6FFD4ECF6FFC3DEEBFF9DC3D9FFD0EAF5FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFC5E6F3FFC4E5F3FF6AA1
      BFFF406F9CFF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF83807EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF817C7DFF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000374B47DFF74B47DFF74B47DFF74B47DFF74B4
      7DFF4F5051FF999D8BFFAFB49EFFB7BCA5FF999D89FF858776FF818272FFB3B8
      A1FFACB09AFFABAF9AFFAAAC99FFACB09AFFA8AC98FF5B5B5CFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF000000090000000000000000130A00667B4100FF7B41
      00FF412200BA211100841E10007F391D00AE7B4100FF462500C1000000000000
      000000000000000000000C0600537B4100FF1A0E007600000000000000000000
      00000000000000000000180C00717B4100FF0E07005700000000000000000000
      000000000000502900CD7B4100FF0201002600000000000000006D91B3FFA5BB
      D1FFECF3F6FFE0F1F8FFDEF0F8FFDDF0F8FFDCEFF8FFDBEFF7FFD9EEF7FFD8EE
      F7FFD7EDF6FFD6ECF6FFCDE5F1FFA8CBDDFFD2EBF5FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFFCAE7F4FFC9E7F3FFC8E6F3FFC7E6F3FFC5E6F3FF6AA1
      BFFF43719EFF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000676767FF7D7877FFFFFFFFFFCECC
      CDFFCDCBCCFFD5D3D4FFFFFFFFFFFFFFFFFFCBC9CAFFCDCBCBFFCDCBCCFFCDCB
      CCFFFFFFFFFFFFFFFFFF797575FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000064E4E4EFFE9E9E9FFD5D6D8FF9982
      87FF4C353AFF745F57FF5F4844FF604944FF624C46FF644E48FF5F4844FF816B
      62FF7D6860FF7D6860FF7E6960FF79635BFF7A655DFF4E363BFFA58E94FFEAEB
      EDFFE0E1E3FF545454FF000000090000000000000000613300E27B4100FF140A
      0068000000000000000000000000000000000301002B743E00F9000000000000
      000000000000000000000C0600537B4100FF1A0E007600000000000000000000
      00000000000000000000180C00717B4100FF0E07005700000000000000000000
      00000603003B7B4100FF3C2000B30000000000000000000000006D91B3FFA8BD
      D3FFECF3F6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFFD7EDF7FFCDE5F1FFA3C8DBFFD3EBF6FFD2EBF5FFD1EAF5FFCFEA
      F5FFCEE9F5FFCDE9F4FFCCE8F4FFCAE8F4FFC9E7F3FFC8E7F3FFC7E6F3FF6AA1
      BFFF46739FFF35587AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6BFF837E7EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFAFFFFFEFDFFFFFFFFFFFDFB
      FAFFFFFFFFFFFFFFFFFF767272FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFEAEB
      EDFF6A6B6CFF78625CFF8B8C7AFF888978FF898B79FF898B79FF808271FFB0B3
      9EFFAFB39EFFAEB29CFFA6A894FF9EA08DFFA5AA96FF606061FFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF00000009000000001B0E00787B4100FF321A00A30000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000C0600537B4100FF1A0E007600000000000000000000
      00000000000000000000180C00717B4100FF0E07005700000000000000000000
      00002B1600977B4100FF0C0600530000000000000000000000006D91B3FFABBF
      D4FFECF3F6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFFCDE5F1FFA8CBDDFFD5ECF6FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFCBE8F4FFCAE7F4FFC9E7F3FF6AA1
      BFFF4976A1FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF8C8989FFFFFFFFFFCDCC
      CCFFEAE9EAFFEAE9EAFFDDDADAFFCCCACBFFCCCACAFFD5D1D2FFEAE9EAFFCDCB
      CBFFFFFFFFFFFFFFFFFF757271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFA58E
      94FF634B50FF634C4DFF755F58FF644E48FF67514BFF69534DFF66504BFF6E58
      51FF6F5B53FF6B564FFF705C54FF77615AFF533D3EFFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF545454FF0000000900000000391E00AF7B4100FF1008005D0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000C0600537B4100FF1A0E007600000000000000000000
      00000000000000000000180C00717B4100FF0F08005A00000000000000000301
      00297B4100FF582F00D7000000000000000000000000000000006D91B3FFAEC1
      D5FFECF3F6FF89B8CDFF89B8CDFFE1F1F9FFE0F1F9FFDFF1F8FFDEF0F8FFDDF0
      F8FFDCEFF7FFDAEEF7FFCDE5F1FFA3C8DBFFD6EDF6FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFCAE7F4FF6AA1
      BFFF4D78A3FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000787878FF9B9797FFFEFEFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFDFEFFFDFD
      FEFFFFFFFFFFFFFFFFFF767171FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFF646466FFA0A492FFA8AC97FF888A79FF888A78FF888A78FF8687
      76FF999C89FFB5B9A3FFAEB39EFFA4A995FF5D5D5EFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF0000000900000000552C00D57B4100FF000000150000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001B0E00797B4100FF2B17009800000000000000000000
      00000000000000000000180C00707B4100FF11090061000000000E0700564122
      00BA7B4100FF1008005D000000000000000000000000000000006D91B3FFB1C3
      D7FFECF3F6FFE4F3F9FFE3F2F9FFE3F2F9FFE2F2F9FFE0F1F9FFDFF1F8FFDEF0
      F8FFDDF0F8FFDCEFF8FFCDE5F1FFA8CBDDFFD8EDF7FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFCCE8F4FFCBE8F4FF6AA1
      BFFF507BA5FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000787878FF9B9898FFFFFFFFFFCBC4
      C5FFC9C2C3FFE8E6E6FFCCC5C7FFEAE7E7FFEAE7E7FFDCD8D8FFC9C3C3FFC9C3
      C3FFFFFEFEFFFFFFFFFF767271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFA58E
      94FFA58E94FFA58E94FF51393EFF75605AFF756057FF6C5650FF69534DFF888A
      78FF6B564FFF77635AFF79635CFF4F383DFFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF545454FF0000000900000000773F00FA6F3B00F3000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000006693700ED7B4100FF7B4100FF02010025000000000000
      00000000000000000000180C00707B4100FF7B4100FF7B4100FF7B4100FF7B41
      00FF321A00A300000000000000000000000000000000000000006D91B3FFB3C5
      D8FFECF3F6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFFDDF0F8FFCDE5F1FFA5C9DCFFDAEEF7FFD8EEF7FFD7EDF6FFD6EC
      F6FFD4ECF6FFD3EBF6FFD2EBF5FFD0EAF5FFCFEAF5FFCEE9F4FFCDE8F4FF92BC
      D4FF547EA7FF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000747474FF979393FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF767271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFF666668FF777976FF9BA08EFFA9AD98FFA9AD
      98FFA0A391FF82857BFF606061FFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF0000000900000000643600E77B4100FF000000090000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001C0F007A7B4100FF2C1700997B4100FF2D18009A000000000000
      00000000000000000000180C00707B4100FF3A1E00B0170C006F1F1000803F20
      00B67B4100FF331A00A4000000000000000000000000000000006D91B3FFB3C5
      D8FFECF3F6FF89B8CDFF89B8CDFF89B8CDFFE4F3F9FFE3F2F9FFE2F2F9FFE1F1
      F9FFE0F1F8FFDFF0F8FFCDE5F1FFA8CBDDFFDBEFF7FF89B8CDFF89B8CDFF89B8
      CDFFD6EDF6FFD5ECF6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFFCEE9F5FF92BC
      D4FF5882A9FF35587AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6F6FFF8F8B8BFFFFFFFFFFFFFF
      FFFFFDFFFFFFFCFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFBFDFEFFFCFEFEFFFCFE
      FFFFFDFEFFFFFFFFFFFF767272FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FF644C51FF5A4348FF523A40FF5039
      3EFF584046FF634B50FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF545454FF0000000900000000492700C57B4100FF030100290000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000096B3900EE623300E4000000003F2200B87B4100FF020100270000
      00000000000000000000180C00707B4100FF130A006600000000000000000000
      00002513008C7B4100FF1B0E00790000000000000000000000006D91B3FFB3C5
      D8FFECF3F6FF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFE3F2F9FFE2F2
      F9FFE1F1F9FFE0F1F8FFCDE5F1FFA5C9DCFFDDEFF8FF89B8CDFF89B8CDFF89B8
      CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFF89B8CDFFD0EAF5FF92BC
      D4FF5D85ABFF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF8C8989FFF3E9E2FFFDF7
      F4FFF9EEEBFFF6EAE8FFF6EAE8FFF9EDEBFFF5E8E5FFF5E9E6FFF4E8E5FFDDC3
      BDFFDFC5C0FFFEF5F3FF777271FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF0000000900000000261400907B4100FF1B0E00780000
      0000000000000000000000000000000000000000000000000000000000000000
      00001D0F007C7B4100FF1A0E0077000000000C0600507B4100FF2D18009B0000
      00000000000000000000180C00707B4100FF130A006600000000000000000000
      0000050300387B4100FF3A1F00B10000000000000000000000006D91B3FFB3C5
      D8FFECF3F6FFE7F4FAFFE7F4FAFFE6F4FAFFE6F3FAFFE5F3FAFFE4F3F9FFE3F2
      F9FFE2F2F9FFE1F2F9FFCDE5F1FFA8CBDDFFDEF0F8FFD8EDF7FFDCEFF7FFDAEE
      F7FFD9EEF7FFD8EDF7FFD7EDF6FFD5ECF6FFD4ECF6FFD3EBF6FFD1EAF5FF92BC
      D4FF6188ADFF35587AFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000777777FF8F8B8AFFF1E0D5FFEBDC
      CAFFEDC3B5FFE5B5A6FFE1AD9DFFE0AE9EFFDDA194FFE3AD9FFFE0A798FFE0A6
      96FFB64C30FFF2D2C5FF787270FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF545454FF000000090000000001000019763F00FB623300E40000
      000F00000000000000000000000000000000000000001008005E000000000000
      000B6B3900EF6B3900EF000000080000000000000000492700C57B4100FF0301
      00290000000000000000180C00707B4100FF130A006600000000000000000000
      0000130A00657B4100FF331B00A50000000000000000000000006D91B3FFB3C5
      D8FFECF3F6FFE7F4FAFFE7F4FAFFE7F4FAFFE7F4FAFFE6F4FAFFE5F3FAFFE4F3
      F9FFE4F2F9FFE3F2F9FFCDE5F1FFB5D3E3FFDFF1F8FFD8EDF7FFDDF0F8FFDCEF
      F8FFDBEFF7FFD9EEF7FFD8EDF7FFD7EDF6FFD5ECF6FFD4ECF6FFD3EBF6FFD2EB
      F5FF668CAFFF43719EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000868686FF989696FFF8EEE6FFF8E5
      D6FFF9E6DAFFFBE7DBFFF9E3D6FFF6DED1FFF2D9CCFFECD2C4FFE6CCC0FFE3C9
      BBFFE2C5B9FFEEDDD5FF757172FF656565FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF000000090000000000000000201100837B4100FF562C
      00D50603003C00000005000000030603003A321A00A3462500C1000000001E10
      007E7B4100FF1E10007F0000000000000000000000000D0700547B4100FF2E18
      009C0000000000000000180C00707B4100FF140A006900000005000000040703
      003F522C00D27B4100FF110900610000000000000000000000006D91B3FFB3C5
      D8FFECF3F6FFECF3F6FFECF3F6FFECF3F6FFECF3F6FFECF3F6FFECF3F6FFECF3
      F6FFECF3F6FFECF3F6FFE9F3F7FFC9DFECFFE9F3F7FFE9F3F7FFD8EDF7FFD8ED
      F7FFD8EDF7FFD8EDF7FFC9DFECFFC7DEEBFFC4DDEBFFC2DCEAFFC0DBE9FFBEDA
      E9FF6A8FB2FF43719EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070E9888585FFA0A0A2FF9596
      98FF949597FF959598FF8E8F91FF848587FF7D7D81FF77787AFF6D6E71FF6869
      6CFF5C5E60FF59595BFF3C3636FF504F4FE60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E
      94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFA58E94FFEAEB
      EDFFE0E1E3FF545454FF000000090000000000000000000000002714008F7B41
      00FF7B4100FF7B4100FF7B4100FF7B4100FF7B4100FF170C006F0000000D6D39
      00F1743D00F900000011000000000000000000000000000000004C2800C97B41
      00FF0301002B00000000180C00707B4100FF7B4100FF7B4100FF7B4100FF7B41
      00FF7B4100FF2513008C000000000000000000000000000000006D91B3FFB3C5
      D8FFB3C5D8FFB3C5D8FFB3C5D8FFB3C5D8FFB3C5D8FFB3C5D8FFB1C4D7FFAFC2
      D6FFADC0D5FFAABED3FFA7BCD2FFA4BAD0FFA1B7CFFF9DB5CDFF9AB2CBFF96AF
      C9FF92ACC7FF8EA9C4FF8AA6C2FF85A3BFFF81A0BDFF7C9CBBFF7799B9FF7396
      B6FF6F93B4FF43719EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000005E5E5EC8787878FF828282FF6C6C
      6CFF626262FF656565FF5A5A5AFF4D4D4DFF4D4D4DFF4E4E4EFF464646FF4444
      44FF424242FF404040FF383838FF565656C80000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEBEDFFEAEB
      EDFFE0E1E3FF545454FF00000009000000000000000000000000000000000301
      002A180D00722B17009828150092150B006A0201002200000000050200342413
      008A150B006A00000000000000000000000000000000000000000C0600522413
      008B0B06004E00000000020100261C0F007B1C0F007B1C0F007B1C0F007B140B
      00690201002300000000000000000000000000000000000000006D91B3FF6D91
      B3FF6D91B3FF6D91B3FF6D91B3FF6D91B3FF6D91B3FF6D91B3FF6D91B3FF6D91
      B3FF6D91B3FF6D91B3FF8FAAC4FF8FAAC4FF8FAAC4FF6D91B3FF6D91B3FF6D91
      B3FF6D91B3FF6D91B3FF6D91B3FF6D91B3FF6D91B3FF6D91B3FF6D91B3FF6D91
      B3FF6D91B3FF6D91B3FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000606062A484848C0505050D44242
      42D13C3C3CD03E3E3ED03C3C3CD03A3A3AD13A3A3AD13C3C3CD13A3A3AD13838
      38D03A3A3AD1393939D33C3C3CC7080808310000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000545454FFFFFFFFFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE0E1E3FF545454FF00000006000000000000000000000000000000000000
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
      000000000000000000000000000000000000545454FF545454FF545454FF5454
      54FF545454FF545454FF545454FF545454FF545454FF545454FF545454FF5454
      54FF545454FF545454FF545454FF545454FF545454FF545454FF545454FF5454
      54FF545454FF545454FF00000003000000000000000000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000E00000000100010000000000000E00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object ilMainMenu: TImageList
    DrawingStyle = dsTransparent
    Left = 280
    Top = 232
    Bitmap = {
      494C010125002900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000A0000000010020000000000000A0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009CBDBD007B9C9C005A7B7B005A7B
      7B005A7B7B005A7B7B00848484009C9C9C0000000000BDBDBD00BDBDBD00BDBD
      BD009C9C9C009C9C9C0084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B9C9C009CBDBD009CBDBD009CBD
      BD009CBDBD007B9C9C007B9C9C0084848400BDBDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B9C9C009CBDBD009CDEDE009CDE
      DE009CDEDE009CDEDE009CBDBD005A7B7B009C9C9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD009CBDBD00BDDEDE00BDDE
      DE009CDEDE009CDEDE009CBDBD007B9C9C0084848400BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B9C9C00BDDEDE00BDDE
      DE00BDDEDE009CDEDE009CDEDE009CBDBD005A7B7B009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD009CBDBD00BDDE
      DE00BDDEDE009CDEDE009CDEDE009CBDBD007B9C9C0084848400BDBDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B9C9C00BDDE
      DE00BDDEDE00BDDEDE009CDEDE009CDEDE009CBDBD005A7B7B009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD009CBD
      BD009CBDBD009CBDBD009CBDBD009CBDBD009CBDBD007B9C9C0084848400BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B9C
      9C00BDDEDE00000000000000000000000000BDDEDE009CBDBD007B9C9C009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD009CBDBD0000000000000000000000000000000000BDDEDE009CBDBD008484
      8400BDBDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B9C9C00BDDEDE00000000000000000000000000BDDEDE009CBDBD007B9C
      9C009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDBDBD009CBDBD0000000000000000000000000000000000BDDEDE009CBD
      BD00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B9C9C00BDDEDE00000000000000000000000000BDDEDE009CBD
      BD00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD007B9C9C007B9C9C007B9C9C007B9C9C007B9C9C007B9C
      9C009CBDBD000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000006B00000000
      000000000000000000006B8CB500000000000000000000000000000000000000
      0000000000008C6339008C6339008C6339008C6339008C6339008C6339008C63
      39008C633900000000000000000000000000000000008C8C8C00181818001818
      1800181818001818180018181800181818001818180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010294200102942000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000AD0000006B
      0000000000006B8CB500426B9400000000000000000000000000000000000000
      0000000000008C633900CE7B2900BD8C6300A55A08008C4200008C4200008C42
      00008C633900000000000000000000000000000000008C8C8C00EFEFEF00EFEF
      EF00EFEFEF00F7F7F700F7F7F700FFFFFF001818180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000102942007B7B39001029420010294200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000AD0000006B0000006B000073DE7B0073DE
      7B00006B00004A739C0000000000000000000000000000000000000000000000
      0000000000008C633900CE843900B5947B00AD631800944A00008C4200008C42
      00008C633900000000000000000000000000000000008C8C8C00E7E7E700EFEF
      EF00EFEFEF00EFEFEF00F7F7F700F7F7F7001818180000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C6001029420010294200102942008C84420084844200847B3900102942001029
      4200B5BDC6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000AD000073DE7B0073DE7B0073DE7B0073DE
      7B0073DE7B00006B000000000000000000000000000000000000000000000000
      0000000000008C633900CE843900BD8C6300BD8C63009C520800944A00008C42
      00008C633900000000000000000000000000000000008C8C8C00E7E7E700E7E7
      E700E7E7E700EFEFEF00EFEFEF00F7F7F7001818180000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600102942007B8C94001029420094944A008C8C42008C8C4200848442001029
      4200B5BDC6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000AD000073DE7B0073DE7B0073DE7B0073DE
      7B0073DE7B0073DE7B00006B0000000000000000000000000000000000000000
      000000000000000000008C633900C67B2100B5947B00A55A1000944A00008C42
      00008C633900000000000000000000000000000000008C8C8C00DEDEDE00E7E7
      E700E7E7E700E7E7E700EFEFEF00EFEFEF001818180000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600102942007B8C9400102942009C9C4A009C944A0094944A00948C42001029
      4200B5BDC6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000AD000073DE7B0073DE7B0073DE7B0073DE
      7B0073DE7B0000AD000000000000000000000000000000000000000000000000
      000000000000000000008C633900C67B3100B5947B00BD8C63009C5208008C42
      00008C633900000000000000000000000000000000008C8C8C00DEDEDE00DEDE
      DE00E7E7E700E7E7E700E7E7E700EFEFEF001818180000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600102942007B8C940010294200A5A55200A5A552009C9C4A009C944A001029
      4200B5BDC600000000000000000000000000000000006B8CB500000000000000
      000000000000006B00000000000000AD000000AD000000AD000073DE7B0073DE
      7B0000AD0000527BA50000000000000000000000000000000000000000000000
      00000000000000000000000000008C633900B5947B00B5947300CE6300008C63
      390000000000000000000000000000000000000000008C8C8C00DEDEDE00DEDE
      DE00DEDEDE00E7E7E700E7E7E700E7E7E7001818180000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600102942007B8C940010294200ADAD5A00ADAD5200ADA55200A5A552001029
      4200B5BDC60000000000000000000000000000000000426B94006B8CB5000000
      0000006B000000AD00000000000000000000000000000000000000AD000000AD
      0000000000006B8CB500426B9400000000000000000000000000000000000000
      0000000000008C6339008C6339008CBDF70084B5E70084B5E7008C6339000000
      000000000000000000000000000000000000000000008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600102942007B8C940010294200B5B56300B5AD6300ADAD5A00ADAD5A001029
      4200B5BDC60000000000000000000000000000000000000000004A739C00006B
      000073DE7B0073DE7B00006B0000006B0000006B00000000000000AD00000000
      000000000000000000006B8CB500000000000000000000000000000000000000
      0000000000008C633900639CCE009CCEFF009CCEFF0084B5E7008C6339000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600102942007B8C940010294200B5B56B00B5B56B00ADB59400ADB56B001029
      4200B5BDC6000000000000000000000000000000000000000000006B000073DE
      7B0073DE7B0073DE7B0073DE7B0073DE7B00006B000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C6339009CCEFF009CCEFF00BDDEFF009CCEFF009CCEFF00003163008C63
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600102942007B8C940010294200BDBD7300B5BDB500C6D6C600B5C6B5001029
      4200B5BDC60000000000000000000000000000000000006B000073DE7B0073DE
      7B0073DE7B0073DE7B0073DE7B0073DE7B00006B000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C6339009CCEFF00639CCE009CCEFF009CCEFF009CCEFF00003163008C63
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600102942007B8C940010294200B5BD9400CECEB500CECEAD00BDBD73001029
      4200B5BDC600000000000000000000000000000000000000000000AD000073DE
      7B0073DE7B0073DE7B0073DE7B0073DE7B00006B000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C633900639CCE00639CCE00639CCE009CCEFF0000316300003163008C63
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600102942001029420010294200C6C68C00C6C68400C6BD8400102942001029
      4200B5BDC6000000000000000000000000000000000000000000527BA50000AD
      000073DE7B0073DE7B0000AD000000AD000000AD000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C6339009CCEFF009CCEFF009CCEFF007BADE70000316300003163008C63
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5BD
      C600B5BDC600B5BDC60010294200CEC694001029420010294200B5BDC600B5BD
      C600B5BDC60000000000000000000000000000000000426B94006B8CB5000000
      000000AD000000AD000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C63390000316300003163000031630000316300003163008C6339000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010294200102942000000000000000000000000000000
      000000000000000000000000000000000000000000006B8CB500000000000000
      00000000000000AD000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C6339008C6339008C6339008C6339008C633900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B00181818001818
      1800181818001818180018181800181818001818180018181800181818001818
      180018181800181818001818180000000000000000006B6B6B00181818001818
      1800181818001818180018181800181818001818180018181800181818001818
      18001818180018181800181818000000000031318C0031318C0031318C003131
      8C0031318C0031318C0031318C0031318C0031318C0031318C0031318C003131
      8C0031318C0031318C0031318C0031318C000000000000000000424A5200424A
      5200424A5200424A5200424A5200424A5200424A5200424A5200424A5200424A
      5200424A5200424A52000000000000000000000000006B6B6B00D6D6D600D6D6
      D600CECECE00CECECE00CECECE00C6C6C600C6C6C600BDBDC600BDBDBD00BDBD
      BD00BDBDBD00BDBDBD001818180000000000000000006B6B6B00D6D6D600D6D6
      D600CECECE00CECECE00CECECE00C6C6C600C6C6C600BDBDC600BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00181818000000000031318C006BDEFF007BD6F70073CE
      F70073CEF7006BCEF70063C6F7005AC6F70052C6F7004ABDF70042BDF70039AD
      E7003152A500315AAD0029B5F70031318C000000000000000000424A5200525A
      630073737B00ADADAD00948C8C00B5B5B500BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00424A52000000000000000000000000006B6B6B00DEDEDE00D6D6
      D600D6D6D600CECED600CECECE00CECECE00C6C6C600C6C6C600C6C6C600BDBD
      BD00BDBDBD00BDBDBD001818180000000000000000006B6B6B00DEDEDE00D6D6
      D600D6D6D600CECED600CECECE00CECECE00C6C6C600C6C6C600C6C6C600BDBD
      BD00BDBDBD00BDBDBD00181818000000000031318C006BDEFF006394CE003131
      8C00425AA50063ADE70063CEF7005AC6F70052C6F7004ABDF70042BDF70039AD
      E700399CDE00314A9C0029A5E70031318C000000000000000000424A52007373
      7B00ADADAD00D6CECE0094949400BDBDBD00CEC6CE00CEC6CE00CEC6CE00CEC6
      C600C6BDBD00424A52000000000000000000000000006B6B6B00DEDEDE00DEDE
      DE008C8C8C00A5A5A5008C8C8C008C8C8C008C8C8C00A5A5A500A5A5A500C6C6
      C600BDBDC600BDBDBD001818180000000000000000006B6B6B00DEDEDE00DEDE
      DE00D6D6D600D6D6D600006B0000CECECE00CECECE00C6C6CE00C6C6C600C6C6
      C600BDBDC600BDBDBD00181818000000000031318C006BDEFF008CD6F7005273
      B5004A6BB50021B5F7006BCEF70063C6F7005AC6F70052C6F7004ABDF70042B5
      EF00398CCE0031429C0031B5F70031318C000000000000000000424A5200BDBD
      B500D6CECE00EFE7E7009C9C9C00CEC6CE00CECECE00CECECE00CECECE00CECE
      CE00C6C6C600424A52000000000000000000000000006B6B6B00E7E7E700E7E7
      E700DEDEDE00D6D6DE00D6D6D600D6D6D600CECECE00CECECE00CECECE00C6C6
      C600C6C6C600C6C6C6001818180000000000000000006B6B6B00E7E7E700E7E7
      E700DEDEDE00D6D6DE0000AD0000006B0000CECECE00CECECE00CECECE00C6C6
      C600C6C6C600C6C6C600181818000000000031318C006BDEFF0084C6EF0073AD
      DE00295AAD006BB5E70073CEF7006BCEF70063C6F7005AC6F70052C6F7004AAD
      E7003152A5003163B50031B5F70031318C000000000000000000424A5200C6C6
      C600C6C6C600BDBDBD00BDBDBD00D6D6D600D6CED600D6CECE00D6CECE00CECE
      CE00CEC6C600424A52000000000000000000000000006B6B6B00E7E7E7008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C00C6C6C6001818180000000000000000006B6B6B00E7E7E700E7E7
      E700DEDEDE00DEDEDE0000AD000073DE7B00006B0000CECED600CECECE00CECE
      CE00C6C6CE00C6C6C600181818000000000031318C006BDEFF008CCEF7005273
      B5004A63AD007BD6F70073CEF7006BCEF70063CEF7005AC6F7005AC6F7006BDE
      FF006BDEFF006BDEFF006BDEFF0031318C000000000000000000424A5200D6D6
      D600DEDEDE00DED6DE00DED6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600CECECE00424A52000000000000000000000000006B6B6B00EFEFEF008C8C
      8C003194C6003194C600DEDEDE00317B0000317B0000D6D6D6003900A5003900
      A500CECECE00CECECE001818180000000000000000006B6B6B00EFEFEF00E7E7
      E700E7E7E700E7E7E70000AD000073DE7B0073DE7B00006B0000D6D6D600CECE
      CE00CECECE00CECECE00181818000000000031318C006BDEFF006BDEFF006BDE
      FF006BDEFF006BDEFF007BD6F70073CEF700425AA50063CEF7005AC6F7003131
      8C0031318C0031318C0031318C0031318C000000000000000000424A5200D6D6
      D600DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DED6DE00DED6D600D6D6
      D600D6D6D600424A52000000000000000000000000006B6B6B00EFEFEF008C8C
      8C003194C6003194C600C6C6CE00317B0000317B0000C6C6CE003900A5003900
      A500C6C6CE00CECECE001818180000000000000000006B6B6B00EFEFEF00EFEF
      EF00E7E7E700E7E7E70000AD000073DE7B0073DE7B0073DE7B00006B0000D6D6
      D600CECED600CECECE00181818000000000031318C0031318C0031318C003131
      8C0031318C006BDEFF0084D6F7007BCEF700425AA5006BCEF70063C6F7003131
      8C00000000000000000000000000000000000000000000000000424A5200E7DE
      DE00E7E7E700E7E7E700E7DEE700E7DEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00424A52000000000000000000000000006B6B6B00F7F7F7008C8C
      8C003194C6003194C600E7E7E700E7E7E700DEDEE700DEDEDE003900A5003900
      A500D6D6D600D6D6D6001818180000000000000000006B6B6B00F7F7F700EFEF
      EF00EFEFEF00EFEFEF0000AD000073DE7B0073DE7B0000AD0000DEDEDE00D6D6
      D600D6D6D600D6D6D60018181800000000000000000000000000000000000000
      000031318C006BDEFF008CD6F7006394CE00394A9C0073CEF7006BCEF7003131
      8C00000000000000000000000000000000000000000000000000424A5200E7E7
      E700EFE7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7DEE700E7DE
      DE00DEDEDE00424A52000000000000000000000000006B6B6B00F7F7F7008C8C
      8C003194C6003194C600C6C6CE00C6C6CE00C6C6CE00C6C6CE00C6C6CE00C6C6
      CE00C6C6CE00D6D6D6001818180000000000000000006B6B6B00F7F7F700F7F7
      F700EFEFEF00EFEFEF0000AD000073DE7B0000AD0000E7E7E700DEDEDE00DEDE
      DE00D6D6DE00D6D6D60018181800000000000000000000000000000000000000
      000031318C006BDEFF008CD6F70084CEF7004A6BB50073CEF7006BCEF7003131
      8C00000000000000000000000000000000000000000000000000424A5200EFE7
      E700EFEFEF00EFEFEF00EFEFEF00EFE7E700EFE7E700E7E7E700E7E7E700E7E7
      E700E7DEE700424A52000000000000000000000000006B6B6B00F7F7F7008C8C
      8C00F7F7F700F7F7F700EFEFEF00EFEFEF00E7E7EF00E7E7E700E7E7E700DEDE
      DE00DEDEDE00DEDEDE001818180000000000000000006B6B6B00F7F7F700F7F7
      F700F7F7F700F7F7F70000AD000000AD0000E7E7EF00E7E7E700E7E7E700DEDE
      DE00DEDEDE00DEDEDE0018181800000000000000000000000000000000000000
      000031318C006BDEFF006BDEFF006BDEFF006BDEFF006BDEFF006BDEFF003131
      8C00000000000000000000000000000000000000000000000000424A5200EFEF
      EF00F7EFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFE7
      E700E7E7E700424A52000000000000000000000000006B6B6B00FFFFFF008C8C
      8C00C6C6CE00C6C6CE00C6C6CE00C6C6CE00C6C6CE00C6C6CE00C6C6CE00C6C6
      CE00C6C6CE00DEDEDE001818180000000000000000006B6B6B00FFFFFF00FFFF
      FF00F7F7F700F7F7F70000AD0000EFEFEF00EFEFEF00EFEFEF00E7E7E700E7E7
      E700E7E7E700DEDEDE0018181800000000000000000000000000000000000000
      000031318C0031318C0031318C0031318C0031318C0031318C0031318C003131
      8C00000000000000000000000000000000000000000000000000424A5200EFEF
      EF00F7F7F700F7EFF700F7EFEF00F7EFEF00F7EFEF00EFEFEF00EFEFEF00EFEF
      EF00EFE7EF00424A52000000000000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700F7F7F700F7F7F700EFEFEF00EFEFEF00EFEFEF006B6B
      6B0018181800181818001818180000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700F7F7F700F7F7F700EFEFEF00EFEFEF00EFEFEF006B6B
      6B00181818001818180018181800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000424A5200EFEF
      EF00EFEFEF00847B7B007B7B730073736B0073736B0073736B00847B7B00F7EF
      EF00F7EFEF00424A52000000000000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700EFEFEF006B6B
      6B00EFEFEF00C6C6CE006B6B6B0000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700EFEFEF006B6B
      6B00EFEFEF00C6C6CE006B6B6B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000424A5200424A
      5200424A52008C8C8400ADA5A500BDBDBD00BDBDBD00ADADAD008C8C8400424A
      5200424A5200424A52000000000000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F7006B6B
      6B00C6C6CE006B6B6B000000000000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F7006B6B
      6B00C6C6CE006B6B6B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000424A5200424A
      5200424A5200424A5200A5A59C00B5B5B500B5B5B500ADA5A500424A5200424A
      5200424A5200424A52000000000000000000000000006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B00000000000000000000000000000000006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006B635A00736B6B00736B6B00736B6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6B0000000000000000008C8C
      8C00181818001818180018181800181818000000000000000000000000000000
      0000000000000000000000000000000000000000000042526300102942001029
      420010294200102942001029420010294200000000008C8C8C00181818001818
      1800181818001818180018181800181818001818180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5BDBD0000000000000000008C8C
      8C00DEDEDE00FFFFFF00FFFFFF00181818000000000000000000000000000000
      000000000000000000000000000000000000000000004252630063A5DE00529C
      D6004A8CCE003984CE00317BC60010294200000000008C8C8C00EFEFEF00EFEF
      EF00EFEFEF00F7F7F700F7F7F700FFFFFF001818180000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000AD00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6B00B5BDBD006B6B6B008C8C
      8C00DEDEDE00EFEFEF00FFFFFF00181818000000000000000000000000000000
      00000000000000000000000000000000000000000000425263007BB5E7006BAD
      DE005A9CD6004A94D600428CCE0010294200000000008C8C8C00E7E7E700E7E7
      DE00006B0000EFEFEF00F7F7F700F7F7F7001818180000000000000000000000
      0000000000000000000000000000000000007B7B7B00316BEF00949494000000
      000000AD000000000000006B0000006B0000006B0000006B0000006B0000006B
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5BDBD0000000000000000008C8C
      8C00DEDEDE00DEDEDE00DEDEDE00181818000000000000000000000000000000
      0000000000000000000000000000425A5A0008292900425263008CC6EF007BB5
      E70073ADE70063A5DE00529CD60010294200000000008C8C8C00E7E7E70000AD
      000073DE7B00006B0000EFEFEF00F7F7F7001818180000000000000000000000
      000000000000000000000000000000000000ADADAD00ADADAD00ADADAD000000
      000000AD0000006B000063E773005ADE6B0052DE63004ADE5A0042DE520039D6
      4A00006B00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6B0000000000000000008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C000000000000000000000000000000
      0000000000000000000000000000425A5A0063E7E70042526300A5D6F70094CE
      EF0084BDEF0073B5E7006BA5DE0010294200000000008C8C8C00DEDEDE0000AD
      000073DE7B0073DE7B00006B0000EFEFEF001818180000000000000000000000
      0000000000000000000000000000000000007B7B7B00316BEF00949494000000
      000000AD000073E784006BE77B0063E773005ADE6B00006B000000AD000000AD
      000000AD0000006B000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5BDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000425A5A0073E7EF0042526300B5E7FF00ADD6
      FF009CCEF7008CC6EF007BB5E70010294200000000008C8C8C00DEDEDE0000AD
      000073DE7B0073DE7B0073DE7B00006B00001818180000000000000000000000
      000000000000000000000000000000000000ADADAD00ADADAD00ADADAD000000
      000000AD000084EF8C007BE7840073E77B006BE77300006B0000000000000000
      00000000000000AD000000AD0000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6B0000000000000000008C8C
      8C00181818001818180018181800181818000000000000000000000000000000
      000000000000635A520042313100425A5A008CEFEF004252630094B5C600637B
      8C005A738C005A738400739CB50010294200000000008C8C8C0000AD000073DE
      7B0073DE7B0073DE7B0073DE7B0073DE7B00006B000000000000000000000000
      0000000000000000000000000000000000007B7B7B00316BEF00949494000000
      000000AD00008CEF940084EF8C007BEF8400006B000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5BDBD0000000000000000008C8C
      8C00DEDEDE00FFFFFF00FFFFFF00181818000000000000000000000000000000
      000000000000635A5200EFD6BD00425A5A009CEFEF00425263009CBDC600637B
      8C00637B8C0063738C0084A5BD0010294200000000008C8C8C0000AD000073DE
      7B0000AD000000AD000000AD000073DE7B0073DE7B00006B0000000000000000
      000000000000000000000000000000000000ADADAD00ADADAD00ADADAD000000
      000000AD000000AD000000AD000000AD000000AD000000AD000000AD0000006B
      0000006B0000006B0000006B0000006B00000000000000000000000000000000
      0000000000000000000000000000000000006B6B6B00B5BDBD006B6B6B008C8C
      8C00DEDEDE00EFEFEF00FFFFFF00181818000000000000000000000000000000
      000000000000635A5200F7D6C600425A5A00ADF7F70042526300EFFFFF00DEFF
      FF00D6F7FF00C6EFFF00BDE7FF00102942000000000000AD000073DE7B0000AD
      0000000000000000000000AD000000AD000073DE7B0073DE7B00006B00000000
      0000000000000000000000000000000000007B7B7B00316BEF00949494000000
      000000000000000000000000000000000000000000000000000000000000006B
      00008CEF940084EF8C007BE78400006B00000000000000000000000000000000
      000000000000000000000000000000000000B5BDBD0000000000000000008C8C
      8C00DEDEDE00DEDEDE00DEDEDE00181818000000000000000000000000000000
      000000000000635A5200F7DECE00425A5A00A5D6D60042526300425263004252
      6300425263004252630042526300425263000000000000AD000000AD00000000
      00000000000000000000000000000000000000AD000073DE7B0073DE7B00006B
      000000000000000000000000000000000000ADADAD00ADADAD00ADADAD000000
      00000000000000AD0000006B0000000000000000000000000000006B00009CF7
      A50094EF9C008CEF940084EF8C00006B00000000000000000000000000000000
      0000000000000000000000000000000000006B6B6B0000000000000000008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C000000000000000000000000000000
      000000000000635A5200F7E7D600425A5A00B5DEDE006B8C8C006B8C8C00638C
      8C008CD6D6000829290000000000000000000000000000AD0000000000000000
      0000000000000000000000000000000000000000000000AD000000AD000073DE
      7B00006B00000000000000000000000000007B7B7B00316BEF00949494000000
      0000000000000000000000AD0000006B0000006B0000006B0000ADF7B500A5F7
      AD009CF7A50094F79C008CEF9C00006B00000000000000000000000000000000
      000000000000000000008C8C8C00181818001818180018181800181818000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200F7E7DE00425A5A00DEFFFF00D6F7FF00CEF7F700BDF7
      F700B5F7F7000829290000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000AD
      000073DE7B00006B00000000000000000000ADADAD00ADADAD00ADADAD000000
      000000000000000000000000000000AD0000C6FFCE00BDFFC600B5FFBD00ADFF
      B500A5F7AD00A5F7AD0000AD0000006B00000000000000000000000000000000
      000000000000000000008C8C8C00DEDEDE00FFFFFF00FFFFFF00181818000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200DECEC600425A5A00425A5A00425A5A00425A5A00425A
      5A00425A5A00425A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000AD000073DE7B00006B0000000000007B7B7B00316BEF00949494000000
      00000000000000000000000000000000000000AD000000AD000000AD000000AD
      000000AD000000AD000000000000006B00006B6B6B00B5BDBD006B6B6B00B5BD
      BD006B6B6B00B5BDBD008C8C8C00DEDEDE00EFEFEF00FFFFFF00181818000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200DED6CE00948C8400948C840094848400DECEBD004231
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000AD000000AD0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000AD00000000000000000000000000000000
      000000000000000000008C8C8C00DEDEDE00DEDEDE00DEDEDE00181818000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200FFF7F700FFF7EF00FFF7EF00FFEFE700FFEFE7004231
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200635A5200635A5200635A5200635A5200635A5200635A
      5200000000000000000000000000000000000000000000000000316BA5001839
      5A0018395A0018395A0018395A0018395A0018395A0018395A0018395A001839
      5A0018395A0018395A0018395A00000000000000000000000000000000000000
      0000000000008C8C8C0018181800181818001818180018181800181818001818
      180018181800181818001818180018181800FFFFFF0010080800312929001810
      1000000000000808080000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008C8C
      8C00181818001818180018181800181818001818180018181800181818001818
      1800181818001818180000000000000000000000000000000000316BA5005A8C
      B5005A8CB5005A8CB5005A8CB5005A8CB5005A8CB5005A8CB5005A8CB5005A8C
      B5005A8CB5005A8CB50018395A00000000000000000000000000000000000000
      0000000000008C8C8C004273A5003973A500316B9C0031639C0029639C00215A
      9400185A940018528C00104A7B0018181800FFFFFF007B636300B59C9C007B6B
      6B00080808004242420029292900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008C8C
      8C004273A5003973A500316B9C0031639C0029639C00215A9400185A94001852
      8C00104A7B001818180000000000000000000000000000000000316BA5005A8C
      B5005A8CB5005A8CB5005A8CB5005A8CB5005A8CB5005A8CB5005A8CB5005A8C
      B5005A8CB5005A8CB50018395A00000000000000000000000000000000000000
      0000000000008C8C8C005A94C600528CBD004A84BD00427BB5003173B5003173
      AD00296BAD002163A500185A940018181800FFFFFF00A58C8C00CEB5B500A584
      840063525200737373005A5A5A00422121004A21210042292900422929004229
      2900422929002918210000000000000000000000000000000000000000008C8C
      8C005A94C600528CBD004A84BD00427BB5003173B5003173AD00296BAD002163
      A500185A94001818180000000000000000000000000000000000316BA5006394
      C6006394C6006394C6006394C6006394C6006394C6006394C6006394C6006394
      C6006394C6006394C60018395A00000000002142CE00184AAD00184AAD00184A
      AD00184AAD00184AAD00184AAD00184AAD00184AAD00184AAD00427BBD00397B
      B5003173AD00296BAD00215A940018181800FFFFFF0052393900393131002929
      31007B7B84007B94A5007BA5AD00AD9CAD00C68C9C00CE7B8400D6737300E77B
      7B00E77B7B00E77B8400734A4A00000000000000000000000000000000008C8C
      8C006B9CCE005A94C600528CC6004A84BD00427BBD00397BB5003173AD00296B
      AD00215A94001818180000000000000000000000000000000000316BA500739C
      D600739CD600739CD600739CD600739CD600739CD600739CD600739CD600739C
      D600739CD600739CD60018395A00000000002142CE00738CFF00738CFF00738C
      FF00738CFF00738CFF00738CFF00738CFF00738CFF00184AAD00528CBD004A84
      BD00397BB5003173B50029639C0018181800FFFFFF0021394A006373840094B5
      BD00B5E7EF00B5F7FF00ADFFFF0094F7FF0094DEE7008CB5C600848494007342
      4A0084393900D6636300DE7B7B00181010000000000000000000000000008C8C
      8C0073A5D6006B9CCE006394CE005A94C600528CBD004A84BD00397BB5003173
      B50029639C001818180000000000000000000000000000000000316BA50073A5
      D60084B5DE0084B5DE0084B5DE0084B5DE0084B5DE0084B5DE0084B5DE0084B5
      DE0084B5DE0084B5DE0018395A00000000002142CE00738CFF00738CFF00738C
      FF00738CFF00738CFF00738CFF00738CFF00738CFF00184AAD005A94C600528C
      C6004A84BD00427BBD00316B9C0018181800FFFFFF008CB5CE00FFFFFF00DEFF
      FF00ADF7FF008CE7FF008CEFFF0084F7FF0094FFFF009CFFFF0094F7FF001039
      4A0039292900B55A5A00DE7B7300181010000000000000000000000000008C8C
      8C0084ADDE007BADD60073A5D600639CCE00006B0000528CC6004A84BD00427B
      BD00316B9C001818180000000000000000000000000000000000316BA5007BAD
      DE005A84AD004A5A7B004A5A7B004A5A7B004A5A7B004A5A7B004A5A7B004A5A
      7B00527BA5007BA5D60018395A00000000002142CE002142CE002142CE002142
      CE002142CE002142CE002142CE002142CE002142CE002142CE006B9CCE006394
      CE005A8CC600528CBD004273A50018181800FFFFFF008CB5CE00DEFFFF00A5EF
      FF0084DEFF0063D6FF006BDEFF006BE7FF0073EFFF0084F7FF008CFFFF001839
      520031181800B5636300DE7B7B00181010000000000000000000000000008C8C
      8C0094BDE7008CB5DE007BADD60073A5D60000AD0000006B00005A8CC600528C
      BD004273A500181818000000000000000000000000000000000000000000316B
      A5007BADDE005A84AD004A5A7B004A5A7B004A5A7B004A5A7B004A5A7B005A84
      AD007BA5D60018395A0000000000000000000000000000000000000000000000
      0000000000008C8C8C009CC6EF0094BDE700319CD6000873AD003984B500398C
      C6000873B5002173A5004A7BAD0018181800FFFFFF006BADCE00B5F7FF007BDE
      FF0052CEFF0039C6FF005AD6FF004AD6FF0052DEFF0063E7FF006BEFFF001042
      5A0029181800B5636300DE7B7B00181010000000000000000000000000008C8C
      8C009CC6EF0000AD0000006B0000006B000073DE7B0073DE7B00006B00005A94
      C6004A7BAD001818180000000000000000000000000000000000000000000000
      0000316BA5007BADDE006B9CC6006B9CC600006B00006B9CC6006394BD007BA5
      D60018395A000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00ADCEEF00A5CEEF002994CE0000B5DE000084B5000894
      CE0000B5E7001873AD005A84B50018181800FFFFFF0052A5D6008CEFFF005AD6
      FF004ACEFF0052CEFF006BDEFF0063DEFF0052D6FF004ADEFF0052E7FF00104A
      630031181800B5636300DE7B7B00181010000000000000000000000000008C8C
      8C00ADCEEF0000AD000073DE7B0073DE7B0073DE7B0073DE7B0073DE7B00006B
      00005A84B5001818180000000000000000000000000000000000000000000000
      000000000000316BA500316BA50000AD000073DE7B00006B0000316BA5001839
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00BDDEF700B5D6F7004A94CE0008C6EF0000E7FF0000DE
      FF0000BDEF003184BD00638CB50018181800FFFFFF003994CE0084DEFF008CE7
      FF0084DEFF0073CEF70063BDEF007BD6F70084DEFF0084E7FF006BE7FF00084A
      730029181800B5636300DE7B7B00181010000000000000000000000000008C8C
      8C009CADBD0000AD000073DE7B0073DE7B0073DE7B0073DE7B0073DE7B0073DE
      7B00006B00001818180000000000000000000000000000000000000000000000
      0000000000000000000000AD000073DE7B0073DE7B0073DE7B00006B00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00A5B5BD00849CA5002994BD0039E7F70021E7FF0008DE
      FF0000CEF7001073A5006394BD0018181800FFFFFF001073BD00318CCE0052A5
      D60084A5B5007B8C9C00738494006B94AD004A8CB50031739C00104A73000010
      290008080800AD5A5A00E77B7B00181010000000000000000000000000008C8C
      8C00A5A5AD0000AD000073DE7B0073DE7B0073DE7B0073DE7B0073DE7B0000AD
      00007394BD001818180000000000000000000000000000000000000000000000
      00000000000000AD000073DE7B0073DE7B0073DE7B0073DE7B0073DE7B00006B
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00A5A5AD00429CC60029CEEF007BF7FF005AEFFF0029E7
      FF0000DEFF0000BDE700217BB50018181800FFFFFF001073BD00107BCE002152
      8400847B7300847B7B009C8C8400C6A5A50094737B007B525200633939005229
      290039292900BD6B6B00E7848400101010000000000000000000000000008C8C
      8C00ADBDC60000AD000000AD000000AD000073DE7B0073DE7B0000AD0000949C
      AD007BA5C6001818180000000000000000000000000000000000000000000000
      000000AD000000AD000073DE7B0073DE7B0073DE7B0073DE7B0073DE7B0000AD
      0000006B00000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00B5BDC6007BA5BD004A9CC600319CC60084EFF7004ADE
      F7001884BD00398CBD005A9CC60018181800FFFFFF00216BA500526373005A5A
      6300737373006B6B6B0073737300BD9C9400F7C6BD00FFC6BD00FFC6BD00F7B5
      AD00EF9C9C00EF949400734A4A00000000000000000000000000000000008C8C
      8C00DEF7FF00D6EFFF00CEE7FF00C6E7FF0000AD000000AD0000ADCEEF00A5CE
      EF008CADCE001818180000000000000000000000000000000000000000000000
      0000000000000000000000AD000073DE7B0073DE7B0073DE7B00006B00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00E7FFFF00DEF7FF00DEEFFF00ADD6F70031BDDE0039A5
      CE0094C6EF00B5D6F70094B5D60018181800FFFFFF005A5A5A005A5A52005A5A
      5A00737373007B7B7B0063636300393939008C5A5A00AD7B7B00A57B7300B58C
      8400C6948C007352520008080800000000000000000000000000000000008C8C
      8C00E7FFFF00DEF7FF00DEEFFF00D6EFFF0000AD0000C6DEFF00BDDEF700B5D6
      F70094B5D6001818180000000000000000000000000000000000000000000000
      0000000000000000000000AD000073DE7B0073DE7B0073DE7B00006B00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C00E7EFF700DEEFF700D6EFF700D6E7F70063ADCE0063AD
      CE00BDD6EF00BDD6EF00A5BDD60018181800FFFFFF0052525200525252005252
      520073737300D6D6D6009494940008080800392121009C6363006B3939007B52
      5200846363004239390008080800000000000000000000000000000000008C8C
      8C00E7EFF700DEEFF700D6EFF700D6E7F700CEE7F700C6DEEF00BDD6EF00BDD6
      EF00A5BDD6001818180000000000000000000000000000000000000000000000
      0000000000000000000000AD000000AD000000AD000000AD000000AD00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C00FFFFFF0052525200525252005252
      52005A5A5A00ADADAD006B6B6B0000000000080808009C6B6B006B424200845A
      5A00846B63004A39390010080800000000000000000000000000000000008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000425A6300102942001029
      420010294200102942001029420010294200000000006B6B6B00181818001818
      1800181818001818180018181800181818001818180018181800181818001818
      1800181818001818180018181800000000006BC6FF0039ADFF0063BDFF0094D6
      FF00A5D6FF009CD6FF009CD6FF0094D6FF0073C6FF0073C6FF006BC6FF006BC6
      FF0094D6FF00ADDEFF00A5D6FF0084CEFF0000000000A5A5A500525252009C9C
      9C00000000000000000000000000000000000000000042526300102942001029
      4200102942001029420010294200102942000000000000000000000000000000
      00000000000000000000000000000000000000000000425A6300FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF0010294200000000006B6B6B00D6D6D600D6D6
      D600CECECE00CECECE00CECECE00C6C6C6009C9CA5009C9CA500BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0018181800000000007BCEFF007BCEFF009CD6FF0094D6
      FF00BDE7FF00B5E7FF00A5DEFF0094D6FF0084C6F7007BB5DE007BCEFF0073C6
      FF006BC6FF0063BDFF006BC6FF009CD6FF000000000052525200BD7300005252
      520000000000000000000000000000000000000000004252630063A5DE00529C
      D6004A8CCE003984CE00317BC600102942000000000000000000000000000000
      00000000000000000000000000000000000000000000425A6300FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF0010294200000000006B6B6B00DEDEDE00D6D6
      D600D6D6D600CECED600CECECE008C4229007B4229009C9CA500C6C6C600BDBD
      BD00BDBDBD00BDBDBD00181818000000000084CEFF008CCEFF0094D6FF008CD6
      FF0094D6FF00A5DEFF0094D6FF008CBDDE008CADC60084B5D60084BDE7007BCE
      FF0073C6FF006BC6FF005ABDFF009CD6FF000000000052525200BD7300005252
      52000000000000000000000000000000000000000000425263007BB5E7006BAD
      DE005A9CD6004A94D600428CCE00102942000000000000000000000000000000
      00000000000000000000000000004263630008292900425A6300FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF0010294200000000006B6B6B00DEDEDE00DEDE
      DE00D6D6D600D6D6D600D6D6D600A55A39008C422900C6C6CE00C6C6C600C6C6
      C600BDBDC600BDBDBD0018181800000000008CD6FF009CD6FF009CDEFF00A5DE
      FF00A5DEFF0094D6FF0094ADBD009CBDD6008CA5B5008484840084A5BD0084CE
      FF007BCEFF0073C6FF0063C6FF007BCEFF000000000052525200BD7300005252
      5200000000000000000000000000425A5A0008292900425263008CC6EF007BB5
      E70073ADE70063A5DE00529CD600102942000000000000000000000000000000
      000000000000000000000000000042636300FFF7EF00425A6300FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF0010294200000000006B6B6B00E7E7E700E7E7
      E700DEDEDE00D6D6DE00D6D6D600D6D6D6009C9C9C009C9CA500CECECE00C6C6
      C600C6C6C600C6C6C60018181800000000009CD6FF00A5DEFF00ADDEFF00ADDE
      FF0073C6FF007BC6FF009CB5C600848C8C007B7B84007B8484007BBDE70029AD
      FF004AB5FF005ABDFF0063C6FF0063BDFF000000000052525200BD7300005252
      5200000000000000000000000000425A5A0063E7E70042526300A5D6F70094CE
      EF0084BDEF0073B5E7006BA5DE00102942000000000000000000000000000000
      000000000000000000000000000042636300FFF7EF00425A6300FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF0010294200000000006B6B6B00E7E7E700E7E7
      E700DEDEDE00DEDEDE00DEDEDE00A55A39007B422900A5A5A500CECECE00CECE
      CE00C6C6CE00C6C6C6001818180000000000A5DEFF00ADDEFF0094D6FF0073C6
      FF008CC6E700949CA500A5A5A500847B8400847B7B008C949C004AB5FF0039AD
      FF0084CEFF00009CFF00109CFF0063C6FF000000000052525200BD7300005252
      5200000000000000000000000000425A5A0073E7EF0042526300B5E7FF00ADD6
      FF009CCEF7008CC6EF007BB5E700102942000000000000000000000000000000
      000000000000635A52004239310042636300FFF7EF00425A6300B5B5B500737B
      8400737B8400737B8400B5B5B50010294200000000006B6B6B00EFEFEF00E7E7
      E700E7E7E700E7E7E700DEDEDE00B57B6B007B422900A5A5A500ADADAD00CECE
      CE00CECECE00CECECE001818180000000000ADDEFF0094D6FF0084C6F70094A5
      B500A5A5A500E7E7E700FFFFFF009C9C9C007B7B7B0094B5CE0018A5FF00A5DE
      FF0094D6FF0039ADFF0031ADFF0084CEFF000000000052525200BD7300005252
      520000000000635A520042313100425A5A008CEFEF004252630094B5C600637B
      8C005A738C005A738400739CB500102942000000000000000000000000000000
      000000000000635A5200FFF7EF0042636300FFF7EF00425A6300B5B5B500737B
      8400737B8400737B8400B5B5B50010294200000000006B6B6B00EFEFEF00EFEF
      EF00E7E7E700E7E7E700E7E7E700DEDEDE00A55A39007B422900BDBDBD00BDBD
      BD00CECED600CECECE001818180000000000B5DEFF00BDE7FF008C949C00D6D6
      D600ADADAD00EFEFEF00D6D6D600CECECE00848C8C0073C6F700009CFF0031AD
      FF008CCEFF004AB5FF006BC6FF00ADDEFF000000000063636300525252006363
      630000000000635A5200EFD6BD00425A5A009CEFEF00425263009CBDC600637B
      8C00637B8C0063738C0084A5BD00102942000000000000000000000000000000
      000000000000635A5200FFF7EF0042636300FFF7EF00425A6300FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF0010294200000000006B6B6B00F7F7F700EFEF
      EF00EFEFEF00EFEFEF00C6C6CE00C6C6CE00DEDEE700A55231009C6B5A00C6C6
      CE00D6D6D600D6D6D6001818180000000000B5E7FF00C6E7FF00A5ADB500DEDE
      DE00B5B5B500E7E7E700C6C6C600F7F7F7009CA5A5009CCEE7005ABDFF0031AD
      FF0018A5FF0031ADFF0084CEFF00A5DEFF0000000000A5A5A500525252000000
      000000000000635A5200F7D6C600425A5A00ADF7F70042526300EFFFFF00DEFF
      FF00D6F7FF00C6EFFF00BDE7FF00102942000000000000000000000000000000
      000000000000635A5200FFF7EF0042636300DEDECE00425A6300425A6300425A
      6300425A6300425A6300425A6300425A6300000000006B6B6B00F7F7F700F7F7
      F700EFEFEF00BD8473007B422900C6C6CE00E7E7E700A55231007B422900C6C6
      CE00D6D6DE00D6D6D6001818180000000000B5E7FF00C6E7FF00CEDEEF00A5A5
      A500EFEFEF00B5B5B500E7E7E700DEDEDE00C6C6C600847B8400848C940094A5
      B50084BDDE0084CEFF007BCEFF007BCEFF000000000052525200525252005252
      520000000000635A5200F7DECE00425A5A00A5D6D60042526300425263004252
      6300425263004252630042526300425263000000000000000000000000000000
      000000000000635A5200FFF7EF0042636300DEDECE0084948C0084948C008494
      8C00DEDECE00082929000000000000000000000000006B6B6B00F7F7F700F7F7
      F700F7F7F700A55A39007B422900C6C6CE00C6C6CE00A55231006B312100C6C6
      CE00DEDEDE00DEDEDE001818180000000000B5E7FF00C6E7FF00D6EFFF00A5AD
      AD00E7E7E700ADADAD00EFEFEF00DEDEDE00E7E7E70084848400847B7B007B7B
      7B00847B7B00848C94007BCEFF006BC6FF000000000000000000525252000000
      000000000000635A5200F7E7D600425A5A00B5DEDE006B8C8C006B8C8C00638C
      8C008CD6D6000829290000000000000000000000000000000000000000000000
      000000000000635A5200FFF7EF0042636300FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00082929000000000000000000000000006B6B6B00FFFFFF00FFFF
      FF00F7F7F700BD8473007B4229007B4229007B422900A55231009C736300E7E7
      E700C6C6CE00C6C6CE001818180000000000B5DEFF00BDE7FF00CEEFFF00BDD6
      E700B5B5B500EFEFEF00CECECE00EFEFEF00949494007B7B7B007B7B7B008484
      84008494A50084B5D6007BCEFF006BC6FF000000000000000000525252000000
      000000000000635A5200F7E7DE00425A5A00DEFFFF00D6F7FF00CEF7F700BDF7
      F700B5F7F7000829290000000000000000000000000000000000000000000000
      000000000000635A5200DEDECE00426363004263630042636300426363004263
      630042636300426363000000000000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700BD847300A55A3900A55A3900BD847300EFEFEF006B6B
      6B0018181800181818001818180000000000B5DEFF00B5E7FF00C6E7FF00CEE7
      FF00B5B5BD00F7F7F700BDBDBD00F7F7F7008C8C8C00848484008CA5B50094C6
      E70094D6FF0084CEFF0073CEFF006BC6FF000000000000000000525252000000
      000000000000635A5200DECEC600425A5A00425A5A00425A5A00425A5A00425A
      5A00425A5A00425A5A0000000000000000000000000000000000000000000000
      000000000000635A5200DEDECE00948C8400948C8400948C8400DEDECE004239
      310000000000000000000000000000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700EFEFEF006B6B
      6B00EFEFEF00C6C6CE006B6B6B000000000094D6FF00B5DEFF00B5E7FF00BDE7
      FF00ADC6D600ADADAD00BDBDBD008C9494009CB5C600A5D6F700A5DEFF0094D6
      FF008CCEFF007BCEFF0073C6FF0063C6FF000000000000000000525252000000
      000000000000635A5200DED6CE00948C8400948C840094848400DECEBD004231
      3100000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF004239
      310000000000000000000000000000000000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F7006B6B
      6B00C6C6CE006B6B6B00000000000000000094D6FF00A5D6FF00A5DEFF00ADDE
      FF00B5DEFF0094A5AD00A5BDD600ADDEFF00ADDEFF00A5DEFF009CD6FF008CD6
      FF0084CEFF007BCEFF006BC6FF0063BDFF000000000000000000525252000000
      000000000000635A5200FFF7F700FFF7EF00FFF7EF00FFEFE700FFEFE7004231
      3100000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200635A5200635A5200635A5200635A5200635A5200635A
      520000000000000000000000000000000000000000006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B0000000000000000000000000094D6FF0094D6FF00B5DEFF00ADDE
      FF00A5DEFF00A5DEFF00A5DEFF00A5DEFF009CD6FF0094D6FF008CD6FF0084CE
      FF007BCEFF0073C6FF0063C6FF005ABDFF000000000000000000000000000000
      000000000000635A5200635A5200635A5200635A5200635A5200635A5200635A
      5200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000AD
      0000006B0000006B0000006B0000181818001818180018181800181818001818
      18001818180018181800181818001818180000000000636352007B736300BDA5
      8C007363520042424A002931420042424A0029426B0029527300295A8C00314A
      6B003142630029426300394A5A00424A5A000000000000000000000000000000
      0000000000000000000021395A00FFFFFF00FFFFFF00425A6300102942001029
      420010294200102942001029420010294200000000004A7BAD0010528C001052
      8C0010528C0010528C0010528C0010528C0010528C0010528C0010528C001052
      8C0010528C0010528C0010528C000000000000000000000000000000000000AD
      000073DE7B0073DE7B00006B00003973A500316B9C0031639C0029639C00215A
      9400185A940018528C00104A7B00181818005A5A520052524A00847B7B00DEDE
      DE005A5A5A0031293900423939004A4A5200295284003984C600397BBD003173
      BD004A5A6B006B7BB5008C94A50094949C0084B5DE0084B5DE0084B5DE0084B5
      DE0084B5DE0084B5DE0021395A00FFFFFF00FFFFFF00425A630063A5DE005A9C
      D6004A94CE003984CE00317BC60010294200000000004A7BAD009CCEE70094C6
      DE0084BDD6007BADCE007BADCE006BA5C60073ADCE0073ADCE0073ADCE0073AD
      CE007BB5D600528CB50010528C000000000000000000000000000000000000AD
      000073DE7B0073DE7B00006B0000528CBD004A84BD00427BB5003173B5003173
      AD00296BAD002163A500185A94001818180073635A00735A4A00B5ADAD00CED6
      D600635A5A003139390073634A0063635A00214A6B004A7B9C00738C9C004A5A
      6B004A3921008C8CBD009C9CAD0094949C004A5A7B004A5A7B004A5A7B004A5A
      7B00527BAD007BADD60021395A00FFFFFF00FFFFFF00425A63007BB5E7006BAD
      DE005A9CD6005294D600428CCE0010294200000000004A7BAD00D6F7FF00D6F7
      FF00D6F7FF00D6F7FF00CEF7FF00ADD6EF00BDEFFF00C6F7FF00C6F7FF00C6F7
      FF00D6FFFF007BB5D60010528C000000000000AD0000006B0000006B0000006B
      000073DE7B0073DE7B00006B0000006B0000006B0000006B0000427BBD00397B
      B5003173AD00296BAD00215A9400181818006B635A00736B6300CECEC6007373
      6300394A39001839390029424A003139420018313900395A52009C8C6B00634A
      3900394263007384CE009C9CA5008C949C004A5A7B004A5A7B004A5A7B00527B
      AD007BADD60021395A00FFFFFF004263630008292900425A63008CC6EF0084BD
      E70073ADE70063A5DE00529CD60010294200000000004A7BAD00CEEFF700B5DE
      EF00B5DEEF00B5DEEF00BDE7F700A5D6E700B5DEF700ADDEEF00ADDEEF00ADDE
      EF00B5E7F70073ADCE0010528C000000000000AD000073DE7B0073DE7B0073DE
      7B0073DE7B0073DE7B0073DE7B0073DE7B0073DE7B00006B0000528CBD004A84
      BD00397BB5003173B50029639C00181818005252630052637B00949494003142
      42001021420029294A00393952004A4A5A004242630039396300524A7B008C73
      7300526BA5005A7BC6008C8C9C00AD9C9C004A5A7B004A5A7B00527BAD007BAD
      D60021395A00FFFFFF00FFFFFF004263630063E7E700425A6300A5D6F70094CE
      EF0084BDEF007BB5E7006BADDE0010294200000000004A7BAD00D6F7FF00D6F7
      FF00D6F7FF00CEF7FF00CEEFFF00A5D6E700BDE7F700C6EFFF00BDEFFF00BDEF
      FF00C6F7FF0073ADCE0010528C000000000000AD000073DE7B0073DE7B0073DE
      7B0073DE7B0073DE7B0073DE7B0073DE7B0073DE7B00006B00005A94C600528C
      C6004A84BD00427BBD00316B9C00181818005273B500425A840042425A001010
      5A0039396300948C8C00B5ADAD00C6BDB500BDB5B500ADA5A500847B84007B6B
      630042526300294A84007B8CB500C6A594004A5A7B005A84AD007BADD6002139
      5A00FFFFFF00FFFFFF00FFFFFF00426363007BE7EF00425A6300B5E7FF00ADD6
      FF009CCEF7008CC6EF007BB5E70010294200000000004A7BAD00DEEFF700BDDE
      EF00BDDEEF00B5DEEF00BDE7F700A5D6E700B5DEF700ADDEEF00ADDEEF00ADDE
      EF00B5E7F70073ADCE0010528C000000000000AD000000AD000000AD000000AD
      000073DE7B0073DE7B00006B000000AD000000AD000000AD00006B9CCE006394
      CE005A8CC600528CBD004273A50018181800396384006B849400313152002142
      5A007B7B7300CEC6C600D6CECE00D6CECE00DECECE00D6CECE00A5A5A5006363
      7300425A5200636B73009C949400B5AD9C006394C6007BADD60021395A00FFFF
      FF00FFFFFF00635A520042393100426363008CEFEF00425A630094B5C600637B
      8C0063738C005A738400739CB50010294200000000004A7BAD00E7F7F700D6F7
      FF00D6F7FF00D6F7FF00D6F7FF00A5D6E700BDE7F700B5DEEF00B5DEEF00BDE7
      F700C6EFFF0073ADCE0010528C000000000000000000000000000000000000AD
      000073DE7B0073DE7B00006B000094BDE700319CD6000873AD003984B500398C
      C6000873B5002173A5004A7BAD001818180042635A00738C7300425252004A73
      6B0094949400BDB5BD00CEC6C600CEC6C600A59C9C0094949C00526BB500426B
      DE00637BB5008C7B7300B5ADA500C6BDBD00316BA50021395A00FFFFFF00FFFF
      FF00FFFFFF00635A5200EFD6BD00426363009CEFEF00425A63009CBDC600637B
      8C00637B8C00637B8C0084A5BD0010294200000000004A7BAD00E7EFF700C6E7
      EF00C6E7EF00BDE7EF00C6E7F700ADD6EF00C6EFF700CEF7FF00CEEFFF00C6EF
      FF00CEF7FF007BADCE0010528C000000000000000000000000000000000000AD
      000073DE7B0073DE7B00006B0000A5CEEF002994CE0000B5DE000084B5000894
      CE0000B5E7001873AD005A84B500181818006B7B6B00526B630042524A005273
      7300A59C9C00A5A5AD008C94A500848C9C004A5A7300315AA5004A84F7005A94
      FF006384DE007373730094948C00F7F7F700FFFFFF00088C0800FFFFFF00FFFF
      FF00FFFFFF00635A5200F7D6C60042636300ADF7F700425A6300EFFFFF00DEFF
      FF00D6F7FF00C6EFFF00BDE7FF0010294200000000004A7BAD00E7F7F700D6F7
      FF00DEF7FF00D6F7FF00D6F7FF00ADDEEF00BDE7F700B5DEEF00B5DEEF00B5DE
      EF00C6EFF7007BB5D60010528C000000000000000000000000000000000000AD
      000000AD000000AD000000AD0000B5D6F7004A94CE0008C6EF0000E7FF0000DE
      FF0000BDEF003184BD00638CB500181818006B7373005A7B6B004A6B6300395A
      5A00848494006B7BA5004A5A8400315AB5003973D600529CFF0063ADFF005294
      FF0094A5C60063635A0073737300E7E7DE00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00635A5200F7DECE0042636300A5D6D600425A6300425A6300425A
      6300425A6300425A6300425A6300425A6300000000004A7BAD00F7FFFF00E7FF
      FF00E7FFFF00E7FFFF00E7FFFF00ADDEEF00CEEFF700D6F7FF00D6F7FF00CEF7
      FF00D6F7FF007BB5D60010528C00000000000000000000000000000000000000
      0000000000008C8C8C00A5B5BD00849CA5002994BD0039E7F70021E7FF0008DE
      FF0000CEF7001073A5006394BD0018181800637BA50042637B005A6B6B00425A
      73006384CE00B5BDCE00A5A5A5002952A5004273CE00638CC600849CBD00638C
      CE009CA5CE005A5252004242420094949400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00635A5200F7E7D60042636300B5DEDE006B9494006B8C8C00638C
      8C008CD6D60008292900FFFFFF00FFFFFF00000000004A7BAD00F7FFFF00D6EF
      F700CEEFF700D6EFF700E7FFFF00B5DEEF00C6E7F700C6E7F700C6EFF700BDE7
      F700C6E7F70094C6DE0010528C00000000000000000000000000000000000000
      0000000000008C8C8C00A5A5AD00429CC60029CEEF007BF7FF005AEFFF0029E7
      FF0000DEFF0000BDE700217BB500181818007394C600398CE700427BCE004A63
      9C006363B500A5B5DE008494C6003963BD00394A84005A525A00C6B59400D6C6
      BD00D6CECE00948C840073736B008C847B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00635A5200F7E7DE0042636300DEFFFF00D6F7FF00CEF7F700BDF7
      F700B5F7F70008292900FFFFFF00FFFFFF00000000004A7BAD00F7FFFF00EFFF
      FF00EFFFFF00EFFFFF00E7FFFF00B5DEEF00CEEFF700DEFFFF00DEF7FF00D6F7
      FF00DEFFFF009CC6DE0010528C00000000000000000000000000000000000000
      0000000000008C8C8C00B5BDC6007BA5BD004A9CC600319CC60084EFF7004ADE
      F7001884BD00398CBD005A9CC600181818006B9CC6004AADFF0063CEFF005AA5
      FF00846B9C003163B50029429C002952A500295AAD00396BB50084ADD6008CA5
      CE008CADD6008CA5BD009C948400948C7B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00635A5200DECEC600426363004263630042636300426363004263
      63004263630042636300FFFFFF00FFFFFF00000000004A7BAD00EFF7F700F7FF
      FF00F7FFFF00F7FFFF00F7F7FF00D6EFF700E7F7FF00DEF7FF00DEF7FF00CEEF
      F700CEEFF700ADD6E70010528C00000000000000000000000000000000000000
      0000000000008C8C8C00E7FFFF00DEF7FF00DEEFFF00ADD6F70031BDDE0039A5
      CE0094C6EF00B5D6F70094B5D600181818006384E7005284DE0052A5EF005A73
      A500635A8400527BBD00427BBD00528CBD005A8CBD006394BD005A94CE006B9C
      D6006394D6007394BD00A59C8C00A59C8C00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00635A5200DED6CE00948C8400948C8400948C8400DECEBD004239
      3100FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000004A7BAD004A7BAD004A7B
      AD004A7BAD004A7BAD004A7BAD004A7BAD004A7BAD004A7BAD004A7BAD004A7B
      AD004A7BAD004A7BAD004A7BAD00000000000000000000000000000000000000
      0000000000008C8C8C00E7EFF700DEEFF700D6EFF700D6E7F70063ADCE0063AD
      CE00BDD6EF00BDD6EF00A5BDD600181818007373FF006B6BFF004A4A9C006B7B
      8C00ADADC600B5B5CE006B94BD007B94AD00BDB5B5007B94BD00639CCE00739C
      D6006B94CE00EFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00635A5200FFF7F700FFF7EF00FFF7EF00FFEFE700FFEFE7004239
      3100FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C00ADB5FF00A5ADFF00CECEF700A5EF
      DE00FFFFFF00FFFFFF007394BD007B94B500C6BDBD007B9CC600639CCE006B9C
      D600E7F7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00635A5200635A5200635A5200635A5200635A5200635A5200635A
      5200FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000425AAD004242
      A5004242A5004242A5004242A50042429C0042429C0042429C0042429C004242
      9400424294006363940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B00181818001818
      1800181818001818180018181800181818001818180018181800181818001818
      1800181818001818180018181800000000000000000000000000000000000000
      0000000000000000000000000000A59C8400948C730000000000000000000000
      000000000000000000000000000000000000000000004A7BD6000000E7000000
      E7000000E7002929EF002121EF006363EF005A5AEF003131EF000000E7000000
      E7000000E7002929C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B00004ADE008CA5
      D600004ADE00CECECE00004ADE00849CCE00C6C6C60094A5C600004ADE00BDBD
      BD00004ADE00004ADE001818180000000000000000000000000000000000A59C
      8400948C73000000000000000000A59C8400948C73000000000000000000948C
      7300948C7300000000000000000000000000000000004A73D6000000EF000000
      EF000000EF003131EF008484F7007373F7006B6BF7006B6BF7000000EF000000
      EF000000EF002929CE0000000000000000000000000000000000000000000000
      000000AD00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B00427BDE00004A
      DE003973D600CECED600004ADE00638CD600004ADE00638CCE00004ADE00BDBD
      BD00004ADE00BDBDBD001818180000000000000000000000000000000000A59C
      8400D6C69400D6C69400948C7300D6C69400D6C69400948C7300D6C69400D6C6
      9400948C730000000000000000000000000000000000B5BDD600B5B5EF00B5B5
      EF00B5B5EF00B5B5EF00B5B5EF00B5B5EF00B5B5EF00B5B5EF00B5B5EF00B5B5
      EF00B5B5EF00ADADD60000000000000000009494940000000000000000000000
      000000AD000000000000006B0000006B0000006B0000006B0000006B0000006B
      000000000000000000000000000000000000000000006B6B6B0094ADDE00004A
      DE008CA5D600D6D6D600004ADE00004ADE00CECECE00004ADE00004ADE00C6C6
      C600004ADE00BDBDBD00181818000000000000000000A59C8400BDB58C000000
      0000BDB58C00D6C69400D6C69400D6C69400D6C69400D6C69400D6C69400BDB5
      8C0000000000948C7300948C73000000000000000000D6D6D600EFEFEF006B7B
      F7006B7BE700BDC6E700EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00D6D6D60000000000000000000000000000000000000000000000
      000000AD0000006B000063E773005ADE6B0052DE63004ADE5A0042DE520039D6
      4A00006B0000000000000000000000000000000000006B6B6B00004ADE0094AD
      DE00004ADE00D6D6DE00004ADE008CA5D600CECECE0084A5D600004ADE00C6C6
      C600004ADE00C6C6C600181818000000000000000000A59C8400D6C69400BDB5
      8C00D6C69400D6C69400D6C69400ADA58C00ADA58C00D6C69400D6C69400D6C6
      9400BDB58C00D6C69400948C73000000000000000000D6D6D600F7F7F700C6CE
      F7007B8CEF006373EF00DEE7EF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700DEDEDE0000000000000000009494940000000000000000000000
      000000AD000073E784006BE77B0063E773005ADE6B00006B000000AD000000AD
      000000AD0000006B00000000000000000000000000006B6B6B00E7E7E700E7E7
      E700DEDEDE00DEDEDE00DEDEDE00D6D6D600D6D6D600CECED600CECECE00CECE
      CE00C6C6CE00C6C6C60018181800000000000000000000000000D6C69400D6C6
      9400D6C69400D6C6940000000000000000000000000000000000D6C69400D6C6
      9400D6C69400D6C69400000000000000000000000000D6D6D600F7F7F700F7F7
      F700EFEFF7008C9CF7005A6BEF00C6CEEF00F7F7F700F7F7F700D6DEF700EFEF
      EF00F7F7F700DEDEDE0000000000000000000000000000000000000000000000
      000000AD000084EF8C007BE7840073E77B006BE77300006B0000000000000000
      00000000000000AD000000AD000000000000000000006B6B6B00EFEFEF00E7E7
      E700E7E7E700E7E7E700DEDEDE00006B0000D6D6D600D6D6D600D6D6D600CECE
      CE00CECECE00CECECE0018181800000000000000000000000000A59C8400D6C6
      9400D6C69400000000000000000000000000000000000000000000000000D6C6
      9400D6C69400948C7300000000000000000000000000D6D6D600F7F7F700F7F7
      F700F7F7F700F7F7F700637BF7009CADEF008494F700637BF7002942F7006B7B
      EF00F7F7F700DEDEDE0000000000000000009494940000000000000000000000
      000000AD00008CEF940084EF8C007BEF8400006B000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B00EFEFEF00EFEF
      EF00E7E7E700DEDEE70000AD000073DE7B00006B0000D6D6D600D6D6D600D6D6
      D600CECED600CECECE001818180000000000948C7300948C7300D6C69400D6C6
      9400948C7300000000000000000000000000000000000000000000000000ADA5
      8C00D6C69400D6C69400948C7300948C730000000000DEDEDE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00ADB5FF00ADB5EF00BDC6FF005A73F700CED6FF00E7E7
      FF00F7F7F700E7E7E70000000000000000000000000000000000000000000000
      000000AD000000AD000000AD000000AD000000AD000000AD000000AD0000006B
      0000006B0000006B0000006B0000006B0000000000006B6B6B00F7F7F700EFEF
      EF00EFEFEF0000AD000073DE7B0073DE7B0073DE7B00006B0000DEDEDE00D6D6
      D600D6D6D600D6D6D6001818180000000000A59C8400A59C8400D6C69400D6C6
      9400948C7300000000000000000000000000000000000000000000000000ADA5
      8C00D6C69400D6C69400A59C8400A59C840000000000DEDEDE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00EFEFFF006B7BEF00425AF700E7EFF700FFFFFF00FFFF
      FF00FFFFFF00E7E7E70000000000000000009494940000000000000000000000
      000000000000000000000000000000000000000000000000000000000000006B
      00008CEF940084EF8C007BE78400006B0000000000006B6B6B00F7F7F700F7F7
      F70000AD000073DE7B0073DE7B0073DE7B0073DE7B0073DE7B00006B0000DEDE
      DE00D6D6DE00D6D6D60018181800000000000000000000000000A59C8400D6C6
      9400D6C69400000000000000000000000000000000000000000000000000D6C6
      9400D6C69400948C7300000000000000000000000000DEDEDE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF003952F70094A5F700FFFFFF00FFFFFF00F7F7
      F700F7F7F700DEDEDE0000000000000000000000000000000000000000000000
      00000000000000AD0000006B0000000000000000000000000000006B00009CF7
      A50094EF9C008CEF940084EF8C00006B0000000000006B6B6B00F7F7F70000AD
      000000AD000073DE7B0073DE7B0073DE7B0073DE7B0073DE7B0000AD0000006B
      0000DEDEDE00DEDEDE0018181800000000000000000000000000D6C69400D6C6
      9400D6C69400D6C6940000000000000000000000000000000000D6C69400D6C6
      9400D6C69400D6C69400000000000000000000000000DEDEDE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00314AF700EFEFF700FFFFFF00F7F7F700EFEF
      EF00E7E7E700D6D6D60000000000000000009494940000000000000000000000
      0000000000000000000000AD0000006B0000006B0000006B0000ADF7B500A5F7
      AD009CF7A50094F79C008CEF9C00006B0000000000006B6B6B00FFFFFF00FFFF
      FF00F7F7F70000AD000073DE7B0073DE7B0073DE7B00006B0000E7E7E700E7E7
      E700E7E7E700DEDEDE00181818000000000000000000A59C8400D6C69400BDB5
      8C00D6C69400D6C69400D6C69400948C7300948C7300D6C69400D6C69400D6C6
      9400BDB58C00D6C69400948C73000000000000000000DEDEDE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CED6FF000831F700DEDEEF00F7F7F700E7E7E700EFEF
      EF00DEDEDE000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000AD0000C6FFCE00BDFFC600B5FFBD00ADFF
      B500A5F7AD00A5F7AD0000AD0000006B0000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF0000AD000073DE7B0073DE7B0073DE7B00006B0000EFEFEF006B6B
      6B001818180018181800181818000000000000000000A59C8400A59C84000000
      0000BDB58C00D6C69400D6C69400D6C69400D6C69400D6C69400D6C69400BDB5
      8C0000000000A59C8400A59C84000000000000000000DEDEDE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CED6FF001839F700E7E7F700F7F7F700EFEFEF00EFEF
      EF00000000000000000000000000000000009494940000000000000000000000
      00000000000000000000000000000000000000AD000000AD000000AD000000AD
      000000AD000000AD000000000000006B0000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF0000AD000000AD000000AD000000AD000000AD0000EFEFEF006B6B
      6B00EFEFEF00C6C6CE006B6B6B0000000000000000000000000000000000A59C
      8400D6C69400D6C69400A59C8400D6C69400D6C69400A59C8400D6C69400D6C6
      9400948C730000000000000000000000000000000000DEDEDE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EFF7FF00FFFFFF00F7F7F700E7E7E7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000AD0000000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F7006B6B
      6B00C6C6CE006B6B6B000000000000000000000000000000000000000000A59C
      8400A59C84000000000000000000A59C8400948C73000000000000000000A59C
      8400A59C840000000000000000000000000000000000E7E7E700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A59C8400948C730000000000000000000000
      00000000000000000000000000000000000000000000F7EFF700A59C9400DED6
      CE00F7F7F700424252009C9CA5009C9C9C0029426B0029527300295A8C004A63
      7B00E7E7DE00E7E7DE00F7F7F700E7E7DE00000000006B6B6B00181818001818
      1800181818001818180018181800181818001818180018181800181818001818
      18001818180018181800181818000000000000000000A5A5A500525252009C9C
      9C00000000000000000000000000000000000000000000000000525252005252
      5200525252000000000000000000000000000000000000000000000000000000
      0000000000000000000052525200000000000000000000000000000000000000
      000000000000000000000000000000000000E7EFF700DEDEEF008C848400DEDE
      DE00F7EFE70042394A00D6CEC600CECECE00295284004284C6009CB5CE0094AD
      BD00D6CEC600DED6CE00F7EFEF00E7DEDE00000000006B6B6B00004ADE008CA5
      D600004ADE00CECECE00004ADE00849CCE00C6C6C60094A5C600004ADE00BDBD
      BD00004ADE00004ADE0018181800000000000000000052525200BD7300005252
      520000000000000000000000000000000000000000000000000052525200526B
      EF00525252000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000525252000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700F7F7EF00B5ADAD00DEDE
      DE00FFF7F70039394200BDB5A500CEC6BD00214A6B00527B9C00F7EFE700D6CE
      C600BDADA500D6CEC600E7DED600D6CEC600000000006B6B6B00427BDE00004A
      DE003973D600CECED600004ADE00638CD600004ADE00638CCE00004ADE00BDBD
      BD00004ADE00BDBDBD0018181800000000000000000052525200BD7300005252
      520000000000000000000000000000000000000000000000000052525200526B
      EF00525252000000000000000000000000000000000000000000000000000000
      0000000000000000000052525200525252005252520000000000000000000000
      000000000000000000000000000000000000F7EFEF008C847B00CECEC6008C8C
      7B00424A42001839390029424A003939420018313900395A5200BDB59C00E7DE
      CE00394A63009CADD600F7F7EF00E7DEDE00000000006B6B6B0094ADDE00004A
      DE008CA5D600D6D6D600004ADE00004ADE00CECECE00004ADE00004ADE00C6C6
      C600004ADE00BDBDBD0018181800000000000000000052525200BD7300005252
      520000000000000000000000000000000000000000000000000052525200526B
      EF00525252000000000000000000000000000000000000000000000000000000
      0000525252005252520052525200525252005252520052525200525252000000
      000000000000000000000000000000000000DED6D60052637B0094949C003942
      42001021420029294A00393952004A4A5A004242630039396300524A7B00DED6
      C600526BA5005A7BC600A5A5B500E7E7DE00000000006B6B6B00004ADE0094AD
      DE00004ADE00D6D6DE00004ADE008CA5D600CECECE0084A5D600004ADE00C6C6
      C600004ADE00C6C6C60018181800000000000000000052525200BD7300005252
      5200000000000000000000000000000000000000000000000000525252005252
      520052525200000000000000000000000000000000000000000000000000A5A5
      A500BDBDBD0052525200A5A5A500BDBDBD0052525200A5A5A500BDBDBD005252
      5200000000000000000000000000000000005273B500425A8400736B7B001010
      5A0039396300948C8C00B5ADAD00C6BDB500BDB5B500ADA5A500847B84007B6B
      6B00425A6300294A84007B8CB500E7DED600000000006B6B6B00E7E7E700E7E7
      E700DEDEDE00DEDEDE00DEDEDE00D6D6D600D6D6D600CECED600CECECE00CECE
      CE00C6C6CE00C6C6C60018181800000000000000000052525200BD7300005252
      5200000000000000000000000000000000000000000000000000525252005252
      520000000000000000000000000000000000000000000000000000000000A5A5
      A500BDBDBD005252520052525200BDBDBD005252520052525200BDBDBD005252
      520000000000000000000000000000000000396384008494A50039395A002142
      5A007B7B7300CEC6C600D6CECE00D6CECE00DECECE00D6CECE00A5A5A5006363
      7300425A52006B737B009C949400B5AD9C00000000006B6B6B00EFEFEF00E7E7
      E700E7E7E70000AD0000006B0000006B0000006B0000006B0000D6D6D600CECE
      CE00CECECE00CECECE0018181800000000000000000052525200BD7300005252
      5200000000000000000000000000000000000000000000000000525252005252
      520000000000000000000000000000000000000000000000000000000000A5A5
      A50052525200A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A5005252
      52000000000000000000000000000000000042635A007B8C7B00425252004A73
      6B0094949400BDB5BD00CEC6C600CEC6C600A59C9C0094949C00526BB500426B
      DE00637BB500DED6C600B5ADA500C6BDBD00000000006B6B6B00EFEFEF00EFEF
      EF00E7E7E70000AD000073DE7B0073DE7B0073DE7B00006B0000D6D6D600D6D6
      D600CECED600CECECE0018181800000000000000000052525200525252005252
      5200000000000000000000000000000000000000000000000000525252005252
      520000000000000000000000000000000000000000000000000000000000A5A5
      A50052525200E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700A5A5A5005252
      52000000000000000000000000000000000073847300637B6B00425A4A005273
      7300A59C9C00A5A5AD008C94A500848C9C004A5A7300315AA5004A84F7005A94
      FF006384DE00DED6CE0094948C00F7F7F700000000006B6B6B00F7F7F700EFEF
      EF00EFEFEF0000AD000073DE7B0073DE7B0073DE7B00006B0000DEDEDE00D6D6
      D600D6D6D600D6D6D600181818000000000000000000A5A5A500525252000000
      0000000000000000000000000000000000000000000000000000525252005252
      520000000000000000000000000000000000000000000000000000000000A5A5
      A50052525200E7E7E700C6C6C600C6C6C600C6C6C600C6C6C6009C9C9C005252
      520000000000000000000000000000000000EFEFEF005A7B73004A6B6300395A
      5A00848494006B7BA5004A5A8400315AB5003973D600529CFF0063ADFF005294
      FF00BDBDCE00E7DEDE007B7B7300E7E7DE00000000006B6B6B00F7F7F70000AD
      000000AD000073DE7B0073DE7B0073DE7B0073DE7B0073DE7B00006B0000006B
      0000D6D6DE00D6D6D60018181800000000000000000052525200525252005252
      5200000000000000000000000000000000000000000000000000525252005252
      520000000000000000000000000000000000000000000000000000000000A5A5
      A50052525200E7E7E700C6C6C600BDBDBD00BDBDBD00BDBDBD009C9C9C005252
      52000000000000000000000000000000000094A5BD00738C9C005A6B6B00425A
      73006384CE00B5BDCE00A5A5A5002952A5004273CE00638CC600849CBD00D6D6
      D600E7E7DE00E7E7DE00BDBDBD0094949400000000006B6B6B00F7F7F700F7F7
      F70000AD000073DE7B0073DE7B0073DE7B0073DE7B0073DE7B0000AD0000DEDE
      DE00DEDEDE00DEDEDE0018181800000000000000000000000000525252000000
      0000000000007B7B7B0052525200000000005252520052525200525252005252
      520052525200525252000000000052525200000000000000000000000000A5A5
      A50052525200E7E7E700B5B5B500C6C6C600D6D6D600D6D6D600A5A5A5005252
      5200000000000000000000000000000000007B9CC600398CE700427BCE004A63
      9C006363B500A5B5DE008494C6003963BD00394A84005A525A00D6C6AD00DED6
      CE00DED6CE00DEDED600F7EFEF00B5ADA500000000006B6B6B00FFFFFF00FFFF
      FF00F7F7F70000AD000073DE7B0073DE7B0073DE7B0000AD0000E7E7E700E7E7
      E700E7E7E700DEDEDE0018181800000000000000000000000000525252000000
      0000000000007B7B7B00BDBDC6005252520052525200BDBDC600BDBDC600BDBD
      C600BDBDC600525252005252520052525200000000000000000000000000A5A5
      A50052525200E7E7E700B5B5B500BDBDBD00BDBDBD00C6C6C600A59C9C005252
      520000000000000000000000000000000000849CA5004AADFF0063CEFF005AA5
      FF00846B9C003163B50029429C002952A500295AAD00396BB50084ADD600C6C6
      C600DECEC600DECEC600EFE7DE00DED6C600000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00EFF7F70000AD000073DE7B0000AD0000EFEFEF00EFEFEF006B6B
      6B00181818001818180018181800000000000000000000000000525252000000
      0000000000007B7B7B00BDBDC600BDBDC600BDBDC600BDBDC600BDBDC600BDBD
      C600BDBDC600BDBDC6007B7B7B0000000000000000000000000000000000A5A5
      A50052525200E7E7E700D6D6D600D6D6D600CECECE00DEDEDE00A5A5A5005252
      520000000000000000000000000000000000E7DED6006B94D6005AA5EF005A73
      A500635A84006B8CC600427BBD00528CBD005A94BD0084A5C600DEDEE700D6D6
      CE00E7DED600DEDED600F7F7EF00E7DEDE00000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F7F70000AD0000F7F7F700F7F7F700EFEFEF006B6B
      6B00EFEFEF00C6C6CE006B6B6B00000000000000000000000000525252000000
      0000000000007B7B7B00BDBDC6007B7B7B007B7B7B00BDBDC600BDBDC600BDBD
      C6007B7B7B007B7B7B000000000000000000000000000000000000000000A5A5
      A50052525200E7E7E700E7E7E700E7E7E700E7E7E700DEE7E7009CCEAD005252
      5200000000000000000000000000000000009C8473006B6BF70052529C006B7B
      8C00ADADBD00C6A58C009C9CA500C6A58400C6AD8C00C6A58400D6AD8C00C69C
      7B00C69C7B00C69C7300D6A58400C69C7B00000000006B6B6B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F7006B6B
      6B00C6C6CE006B6B6B0000000000000000000000000000000000525252000000
      0000000000007B7B7B007B7B7B00000000007B7B7B007B7B7B007B7B7B007B7B
      7B0000000000000000000000000000000000000000000000000000000000A5A5
      A500525252005252520052525200525252005252520052525200525252005252
      520000000000000000000000000000000000636363007B84B500CEC6DE00ADEF
      DE00DEC6A500D6A57B00D6AD8400D6A58400D6A58400D6A58400E7B58C00D6AD
      8400D6AD8400D6AD8400E7B58C00D6AD8C00000000006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADADAD000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000AD
      0000006B0000006B0000006B0000000000000000000042526300102942001029
      4200102942001029420010294200102942000000000000000000000000000000
      0000000000000000000000000000000000000000000042526300102942001029
      4200102942001029420010294200102942000000000073848C006B6B6B001818
      1800181818001818180018181800181818001818180018181800181818001818
      1800181818000000000000000000000000000000000000000000000000000000
      00009C949400E7DEDE00F7F7F700FFFFFF00FFFFFF00F7F7F700E7DEDE00A59C
      9C000000000000000000000000000000000000000000000000000000000000AD
      000073DE7B0073DE7B00006B000000000000000000004252630063A5DE00529C
      D6004A8CCE003984CE00317BC600102942000000000000000000000000000000
      000000000000000000000000000000000000000000004252630063A5DE00529C
      D6004A8CCE003984CE00317BC6001029420073848C00000000007BA5B500425A
      5A003973A500316B9C0031639C0029639C00215A9400185A940018528C00104A
      7B00181818000000000000000000000000000000000000000000000000000000
      0000D6D6D600F7F7F700F7F7F700F7EFEF00EFE7E700DEDEDE00CEC6C600AD9C
      9C000000000000000000000000000000000000000000000000000000000000AD
      000073DE7B0073DE7B00006B00000000000000000000425263007BB5E7006BAD
      DE005A9CD6004A94D600428CCE00102942000000000000000000000000000000
      00000000000000000000000000000000000000000000425263007BB5E7006BAD
      DE005A9CD6004A94D600428CCE001029420000000000429CBD009CDEF7008CC6
      D60029424A0029424A00427BB5003173B5003173AD00296BAD002163A500185A
      9400181818000000000000000000000000000000000000000000000000000000
      0000CEC6C600D6D6D600C6D6C600D6DECE00B5D6B500CED6C600CEC6C600BDAD
      AD000000000000000000000000000000000000AD0000006B0000006B0000006B
      000073DE7B0073DE7B00006B0000006B0000006B0000006B00008CC6EF007BB5
      E70073ADE70063A5DE00529CD600102942002142CE00184AAD00184AAD00184A
      AD00184AAD00184AAD00184AAD00184AAD00184AAD00184AAD008CC6EF007BB5
      E70073ADE70063A5DE00529CD6001029420000000000429CBD009CDEF700186B
      AD003194C6003194C60029424A00427BBD00397BB5003173AD00296BAD00215A
      9400181818000000000000000000000000000000000000000000000000000000
      0000DED6D600C6D6C600399C390084D6840073CE73004AA54A00CED6CE00C6BD
      BD000000000000000000000000000000000000AD000073DE7B0073DE7B0073DE
      7B0073DE7B0073DE7B0073DE7B0073DE7B0073DE7B00006B0000A5D6F70094CE
      EF0084BDEF0073B5E7006BA5DE00102942002142CE00738CFF00738CFF00738C
      FF00738CFF00738CFF00738CFF00738CFF00738CFF00184AAD00A5D6F70094CE
      EF0084BDEF0073B5E7006BA5DE001029420000000000000000003194C6003194
      C60039B5EF0039B5EF003194C60029424A004A84BD00397BB5003173B5002963
      9C00181818000000000000000000000000000000000000000000000000000000
      0000E7E7E7007BAD7B0073B57300F7F7F700E7F7E70073B5730073A57300CEC6
      C6000000000000000000000000000000000000AD000073DE7B0073DE7B0073DE
      7B0073DE7B0073DE7B0073DE7B0073DE7B0073DE7B00006B0000B5E7FF00ADD6
      FF009CCEF7008CC6EF007BB5E700102942002142CE00738CFF00738CFF00738C
      FF00738CFF00738CFF00738CFF00738CFF00738CFF00184AAD00B5E7FF00ADD6
      FF009CCEF7008CC6EF007BB5E700102942000000000000000000186BAD0063D6
      EF0063D6EF0039B5EF0039B5EF003194C60029424A004A84BD00427BBD00316B
      9C00181818000000000000000000000000000000000000000000000000000000
      0000EFEFEF00A5C6A50084BD8400EFF7EF00F7F7F7007BBD7B00B5C6AD00D6CE
      CE000000000000000000000000000000000000AD000000AD000000AD000000AD
      000073DE7B0073DE7B00006B000000AD000000AD000000AD000094B5C600637B
      8C005A738C005A738400739CB500102942002142CE002142CE002142CE002142
      CE002142CE002142CE002142CE002142CE002142CE002142CE0094B5C600637B
      8C005A738C005A738400739CB5001029420000000000000000006B6B6B00186B
      AD0063D6EF0063D6EF0039B5EF0039B5EF003194C60029424A00528CBD004273
      A500181818000000000000000000000000000000000000000000000000000000
      0000F7F7F700F7F7F70084C684006BCE6B006BCE6B0073B57300EFE7E700D6D6
      D6000000000000000000000000000000000000000000000000000000000000AD
      000073DE7B0073DE7B00006B0000425A5A009CEFEF00425263009CBDC600637B
      8C00637B8C0063738C0084A5BD00102942000000000000000000000000000000
      000000000000635A5200EFD6BD00425A5A009CEFEF00425263009CBDC600637B
      8C00637B8C0063738C0084A5BD001029420000000000000000006B6B6B009CC6
      EF00186BAD0063D6EF0063D6EF0039B5EF0039B5EF003194C60029424A004A7B
      AD00181818000000000000000000000000000000000000000000000000000000
      0000F7F7F700F7F7F700E7EFDE0094DE940094DE9400D6EFD600EFE7E700DEDE
      DE000000000000000000000000000000000000000000000000000000000000AD
      000073DE7B0073DE7B00006B0000425A5A00ADF7F70042526300EFFFFF00DEFF
      FF00D6F7FF00C6EFFF00BDE7FF00102942000000000000000000000000000000
      000000000000635A5200F7D6C600425A5A00ADF7F70042526300EFFFFF00DEFF
      FF00D6F7FF00C6EFFF00BDE7FF001029420000000000000000006B6B6B00ADCE
      EF00A5CEEF00186BAD0063D6EF0063D6EF0039B5EF0039B5EF003194C6002942
      4A00181818000000000000000000000000000000000000000000000000000000
      0000F7F7F700F7F7F700F7F7F700FFFFFF00FFFFFF00FFFFFF00EFEFEF00DEDE
      DE000000000000000000000000000000000000000000000000000000000000AD
      000000AD000000AD000000AD0000425A5A00A5D6D60042526300425263004252
      6300425263004252630042526300425263000000000000000000000000000000
      000000000000635A5200F7DECE00425A5A00A5D6D60042526300425263004252
      63004252630042526300425263004252630000000000000000006B6B6B00BDDE
      F700B5D6F700ADCEEF00186BAD0063D6EF0063D6EF0021A5DE00949494005A5A
      5A0029424A000000000000000000000000000000000000000000000000000000
      0000F7EFEF00F7F7F700F7F7F700FFFFFF00FFFFFF00FFFFFF00EFEFEF00E7DE
      DE00000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200F7E7D600425A5A00B5DEDE006B8C8C006B8C8C00638C
      8C008CD6D6000829290000000000000000000000000000000000000000000000
      000000000000635A5200F7E7D600425A5A00B5DEDE006B8C8C006B8C8C00638C
      8C008CD6D60008292900000000000000000000000000000000006B6B6B00A5B5
      BD00949CA500949CA5008C94A500186BAD0063D6EF009C9C9C009C9C9C007B7B
      7B0039294A0039294A0000000000000000000000000000000000000000000000
      0000B5ADAD00E7DEDE00F7F7F700FFFFFF00FFFFFF00FFFFFF00F7EFEF00D6D6
      D600000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200F7E7DE00425A5A00DEFFFF00D6F7FF00CEF7F700BDF7
      F700B5F7F7000829290000000000000000000000000000000000000000000000
      000000000000635A5200F7E7DE00425A5A00DEFFFF00D6F7FF00CEF7F700BDF7
      F700B5F7F70008292900000000000000000000000000000000006B6B6B00A5A5
      AD00C6CECE00CECED600CECED600CECED600186BAD007B7B7B009C9C9C007B7B
      7B008C00EF008C00EF0039294A00000000000000000000000000000000000000
      000000000000DED6D600EFEFEF00FFFFFF00FFFFFF00F7F7F700EFE7E7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200DECEC600425A5A00425A5A00425A5A00425A5A00425A
      5A00425A5A00425A5A0000000000000000000000000000000000000000000000
      000000000000635A5200DECEC600425A5A00425A5A00425A5A00425A5A00425A
      5A00425A5A00425A5A00000000000000000000000000000000006B6B6B00B5BD
      C600ADB5BD00ADB5BD00ADB5BD00ADB5BD00A5B5BD00186BAD0039294A00AD6B
      EF00AD6BEF008C00EF005A526B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200DED6CE00948C8400948C840094848400DECEBD004231
      3100000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200DED6CE00948C8400948C840094848400DECEBD004231
      31000000000000000000000000000000000000000000000000006B6B6B00E7FF
      FF00DEF7FF00DEEFFF00D6EFFF00CEE7FF00C6DEFF00BDDEF700A59CB500C69C
      F700AD6BEF008C00EF008C8CA500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200FFF7F700FFF7EF00FFF7EF00FFEFE700FFEFE7004231
      3100000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200FFF7F700FFF7EF00FFF7EF00FFEFE700FFEFE7004231
      31000000000000000000000000000000000000000000000000006B6B6B00E7EF
      F700DEEFF700D6EFF700D6E7F700CEE7F700C6DEEF00BDD6EF00BDD6EF00A59C
      B500A59CB500ADA5C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200635A5200635A5200635A5200635A5200635A5200635A
      5200000000000000000000000000000000000000000000000000000000000000
      000000000000635A5200635A5200635A5200635A5200635A5200635A5200635A
      52000000000000000000000000000000000000000000000000006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B00000000000000000000000000424D3E000000000000003E000000
      2800000040000000A00000000100010000000000000500000000000000000000
      000000000000000000000000FFFFFF00FFFF0000000000000080000000000000
      007F000000000000007F000000000000003F000000000000803F000000000000
      801F000000000000C01F000000000000C00F000000000000E70F000000000000
      E787000000000000F387000000000000F3C7000000000000F9C7000000000000
      F807000000000000FFFF000000000000FFFFFFFFFFDDF807807FFCFFFFC9F807
      807FFC3FFE03F807807FE007FE03F807807FE007FE01FC07807FE007FE03FC07
      807FE007BA03FE0F807FE00793C9F81F807FE007C05DF81FFFFFE007C07FF00F
      FFFFE007807FF00FFFFFE007C07FF00FFFFFE007C07FF00FFFFFE00793FFF01F
      FFFFFCFFBBFFF83FFFFFFFFFFFFFFFFF800180010000C003800180010000C003
      800180010000C003800180010000C003800180010000C003800180010000C003
      800180010000C00380018001000FC00380018001F00FC00380018001F00FC003
      80018001F00FC00380018001F00FC00380018001FFFFC00380018001FFFFC003
      80038003FFFFC00380078007FFFFFC3FFFFFFFFFFF60FF80807FFFFFFF60FF80
      807FF7FFFF00FF80807F140FFF60FE00807F1007FF60FE00807F1003FF7FFE00
      807F1039FF60F800807F107FFF60F800803F1000FF00F8008C1F1FE0FF60F800
      9F0F19C0FF60F803BF871C00FC1FF803FFE31E00FC1FF803FFF11F02001FF80F
      FFF9FFFEFC1FF80FFFFFFFFFFC1FF80FC001F80003FFE003C001F80001FFE003
      C001F8000001E003C00100000000E003C00100000000E003C00100000000E003
      C00100000000E003E003F8000000E003F007F8000000E003F80FF8000000E003
      FC1FF8000000E003F80FF8000000E003F007F8000000E003FC1FF8000000E003
      FC1FF8000000E003FC1FF8000100E003FF80800100008F80FF80800100008F80
      FF80800100008F80FE00800100008E00FE00800100008E00FE00800100008E00
      F800800100008800F800800100008800F800800100009800F800800100008800
      F80380010000D803F80380010000D803F80380010000D803F80F80010000D80F
      F80F80030000D80FF80F80070000F80FFFFFE0008000FC008001E00000000000
      8001E00000000000800100000000000080010000000000008001000000000000
      80010000000000008001E000000000008001E000000000008001E00000000000
      8001F800000000008001F800000000008001F800000000008001F80000000000
      8001F80000000000FFFFF80000000000C003FFFF8001FE7F8003FFFF8001E667
      8003F7FF8001E0078003740F800190098003F00780018001800370038001C3C3
      8003F0398001C7E38003707F800107E08003F000800107E080037FE08001C7E3
      8003F9C08001C3C380037C00800180018007FE0080019009800F7F028001E007
      801FFFFE8003E667803FFFFF8007FE7F800080018FC7FDFF000080018FC7FEFF
      000080018FC7FC7F000080018FC7F01F000080018FC7E00F000080018FCFE00F
      000080018FCFE00F000080018FCFE00F000080019FCFE00F000080018FCFE00F
      00008001D902E00F00008001D800E00F00008001D801E00F00008001D803E00F
      00008003D90FE00F00008007FFFFF01FFEFFE180FF800007F00FE180FF800007
      F00FE180FF808007F00F000000008007F00F00000000C007F00F00000000C007
      F00F00000000C007F00FE000F800C007F00FE000F800C007F00FE000F800C007
      F00FF803F803C003F00FF803F803C001F81FF803F803C001FFFFF80FF80FC001
      FFFFF80FF80FC003FFFFF80FF80FC00700000000000000000000000000000000
      000000000000}
  end
  object pmCollection: TPopupMenu
    Images = ilMainMenu
    OwnerDraw = True
    Left = 40
    Top = 336
  end
  object pmScripts: TPopupMenu
    Images = ilFileTypes
    OwnerDraw = True
    Left = 40
    Top = 240
    object MenuItem1: TMenuItem
      Caption = '324'
    end
    object MenuItem2: TMenuItem
      Caption = '34'
    end
    object MenuItem3: TMenuItem
      Caption = '35'
    end
  end
  object ilFileTypes: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 280
    Top = 360
    Bitmap = {
      494C01010C001100040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
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
      000000000000000000000000000000000000275970EF2B6581FF2B6581FF2B65
      81FF2B6581FF2B6581FF2B6581FF2B6581FF122B3AFF1C4661FF1C4661FF1D3F
      55FF1F2D36FF162D3CEF00000000000000000000000000000000000000000000
      00000000000000000000B88B59FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000010101030101
      0106010101030000000000000000000000000101010301010106010101030000
      0000000000000000000000000000000000003B7C99FF4FA2C5FF4FA2C5FF4FA2
      C5FF4FA2C5FF4FA2C5FF4FA2C5FF4FA2C5FF1C4860FF3186B4FF3186B4FF3466
      81FFE99464FF284050FF00000000000000000000000000000000000000000000
      000000000000AE6611FFE0CFBCFFF3EBE1FFAA9E8AFF687064FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000101
      0103000000000000000000000000000000003F819EFF52A6CAFF52A6CAFF52A6
      CAFF52A6CAFF52A6CAFF52A6CAFF52A6CAFF1F4B63FF368DBBFF368DBBFF3874
      95FFE99464FF2C4D63FF00000000000000000000000000000000000000000000
      000000000000A85C01FFD8C3ACFFEDF4FAFF27A3F6FF30A4F0FF4184A6FF9187
      70FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000303F0173379601FF3C9501FF4F6801BF000000000000
      000000000000000000000000000000000000010101030101010E010101160101
      010E01010103000000000101010601010111010101140101010B000000000101
      0106000000000000000000000000000000004486A2FF55ABCEFF55ABCEFF55AB
      CEFF55ABCEFF55ABCEFF55ABCEFF55ABCEFF224F66FF3C94C1FF3C94C1FF3D7D
      9EFFDCDCDCFF32566DFF00000000000000000000000000000000000000000000
      0000AF6810FFA95D00FFB48857FFB1C2CDFF3CA5EBFF0094F8FF8AC8F3FFE2E2
      E3FFCAB69DFFAD8250FF00000000000000000000000000000000000000000000
      0000000000002B3801665C8D01FF2AAD01FF0BAB01FF5C7901E11D2601440000
      000000000000000000000000000000000000010101080101011F0101012D0101
      011F010101080101010601010116010101240101012201010114000000000101
      010300000000000000000000000000000000498AA5FF58B0D1FF58B0D1FF58B0
      D1FF58B0D1FF58B0D1FF58B0D1FF58B0D1FF265369FF419BC9FF419BC9FF4182
      A3FFDCDCDCFF365D73FF0000000000000000000000000000000000000000BA79
      20FFB06500FFB06400FFAD6300FFAC6B16FFB58952FFB3A99DFFE7E6E6FFE3E3
      E3FFD8D8D8FFCACACBFFBDAE9BFF000000000000000000000000000000000000
      000004050108516901C31EAB01FF33D901FF31D601FF2E9C01FF5A7D01E5161C
      0133000000000000000000000000000000000101010B0134FFFF010101400101
      0132010101190101011C0101012D0134FFFF0101012401010111000000000000
      0000000000000000000000000000000000004E90A9FF5BB5D5FF5BB5D5FF5BB5
      D5FF5BB5D5FF5BB5D5FF5BB5D5FF5BB5D5FF2B576CFF48A2CFFF47A2CEFF4588
      A6FFDCDCDCFF3C6478FF0000000000000000000000000000000000000000B870
      04FFB76E01FFB46D03FFB97106FFBE7B16FFC0811FFFBD7E20FFAE752BFFB797
      71FFCAC3BDFFCACACBFFC2C2C2FF000000000000000000000000000000000000
      00003545017F509001FF1EC101FF30D501FF34DA01FF2BD001FF379601FF3545
      017F000000000000000000000000000000000101010B0134FFFF010101510101
      014C0101013B0101013E0134FFFF010101380101011C01010106000000000000
      0000000000000000000000000000000000005395AEFF5EBAD9FF5EBAD9FF5EBA
      D9FF5EBAD9FF5EBAD9FF5EBAD9FF5BB5D5FF2E5A70FF4EA8D4FF4DA8D4FF4A8D
      ABFFDCDCDCFF426A7EFF00000000000000000000000000000000C17B09FFBE76
      00FFBF7C11FFBF7B0DFFBE7600FFBE7603FFBF790BFFC38112FFC5861BFFC78A
      23FFB77A1CFFAD8144FFA79481FF000000000000000000000000000000001015
      0126377701CC26BB01FF19BB01FF0E7F01B2149D01D933D901FF28B001FF5A8D
      01FF000000000000000000000000000000000101010B0134FFFF0101015A0101
      015A0101014C0134FFFF0101014E0101013E0101011901010103000000000000
      000000000000000000000000000000000000589BB1FF62C0DDFF62C0DDFF62C0
      DDFF62C0DDFF62C0DDFF62C0DDFF62C0DDFF3C7089FF3F7C99FF54AED9FF52A6
      CEFF4D829BFF405E6EEF00000000000000000000000000000000C57E00FFC98A
      18FFC4871CFFC68103FFB86D0AFFA4511DFF9F4E1DFFA75B14FFC58006FFC887
      0EFFCA8B17FFCC9020FFC98D21FFB2771DFF0000000000000000000000005A7D
      01E5309801FF0A9901E501170122010C01110111011916A601E51EC101FF4894
      01FF485D01AE080A011100000000000000000101010B0134FFFF0134FFFF0134
      FFFF0134FFFF0134FFFF010101430101013E0101012201010108000000000000
      0000000000000000000000000000000000005D9FB5FF65C5E1FF65C5E1FF65C5
      E1FF65C5E1FF65C5E1FF65C5E1FF65C5E1FF61B1CBFF3C7089FF3C7089FF59A2
      C4FF547E91FF01010220000000000000000000000000CE8B07FFCE8E0DFFCB94
      2DFFD09216FFC88500FF9C4D1AFF8E4617FF8A5801FF854C0AFF9F580DFF9B56
      0CFFC17D05FFCE8C09FFD09317FF000000000000000000000000000000003088
      01E6036201990119012600000000000000000000000001190126139401CC1CBE
      01FF4B9101FF3545017F00000000000000000101010B0134FFFF010101490101
      013E01010122010101220134FFFF0101013E010101270101010B000000000000
      00000000000000000000000000000000000063A4B9FF68CBE5FF68CBE5FF68CB
      E5FF68CBE5FF68CBE5FF68CBE5FF68CBE5FF68CBE5FF63A4B9FF3B6578FF629F
      BAFF547E91FF000000000000000000000000D89C1BFFD39000FFD5A23AFFD6A0
      2FFFD39000FFD18E00FF7B410EFF934E10FFD18E00FFAD6A06FF813F0FFF6D38
      0BFFA46C06FFD49307FF0000000000000000000000000000000000000000022A
      0140000000000000000000000000000000000000000000000000021C012B1196
      01D41E9C01FF567201D41218012A000000000101010B0134FFFF0101014C0101
      014901010135010101320134FFFF0101013B0101012201010108000000000000
      00000000000000000000000000000000000068AABEFF6BD0E9FF6BD0E9FF6BD0
      E9FF6BD0E9FF6BD0E9FF6BD0E9FF6BD0E9FF6BD0E9FF6BD0E9FF3F687CFF6CA6
      C1FF547E91FF000000000000000000000000DB9C0BFFDFAD39FFD7A743FFDB9B
      06FFC78502FFAD6A08FFB47A01FF774908FF7C4309FF7D3F0AFF6C3809FFBE8B
      17FFDEA520FFDFA82AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000109
      010D088901D9309801FF5E8401F200000000010101080134FFFF010101430101
      014C01010146010101400134FFFF0101012D0101011401010103000000000000
      0000000000000000000000000000000000006CAFC1FF6ED5EDFF6ED5EDFF6ED5
      EDFF6ED5EDFF6ED5EDFF6ED5EDFF6ED5EDFF6ED5EDFF6ED5EDFF446C7EFF76AE
      C7FF547E91FF000000000000000000000000E7B539FFDAB058FFE5AF28FFE1A3
      05FFAD760AFF7A3C0CFFAA6F0FFFD89F1AFF7D4609FF683305FFA77C22FFE7B5
      38FFE7B73CFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000001170122037C01C3509001FF00000000010101030134FFFF0134FFFF0134
      FFFF0134FFFF0134FFFF01010122010101140101010600000000000000000000
      00000000000000000000000000000000000072B4C5FF72DAF0FF72DAF0FF72DA
      F0FF72DAF0FF72DAF0FF72DAF0FF72DAF0FF72DAF0FF72DAF0FF497081FF80B5
      CEFF547E91FF00000000000000000000000000000000E6B845FFEAB21AFFEAB4
      22FFE7B328FF845E18FF582C05FF643103FF562A01FF8D6925FFEEC450FFEFC4
      52FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000001170122198001D0000000000000000001010103010101080101
      010B0101010B0101010B01010108010101030000000000000000000000000000
      00000000000000000000000000000000000077B9CBFF75E0F6FF75E0F6FF75E0
      F6FF75E0F6FF75E0F6FF75E0F6FF75E0F6FF75E0F6FF75E0F6FF4E7383FF89BB
      D3FF547E91FF000000000000000000000000000000000000000000000000F0C0
      33FFF2C43CFFF3C94DFFE3BE4FFFBC9F48FFD5B456FFF5D167FFF5D066FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007DBFCFFF78E5FAFF78E5FAFF78E5
      FAFF78E5FAFF78E5FAFF78E5FAFF78E5FAFF78E5FAFF78E5FAFF527586FF91C0
      D7FF547E91FF0000000000000000000000000000000000000000000000000000
      00000000000000000000F8D156FFF9D76BFFF9DC80FFFADE86FFF9D463FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A6F78C083C4D3FF83C4D3FF83C4
      D3FF83C4D3FF83C4D3FF83C4D3FF83C4D3FF83C4D3FF83C4D3FF6C8894FF4A6F
      78C0152024800000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCD964FFFCDB6AFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003F57A8FF3F3F
      A6FF3F3FA5FF3F3FA2FF3F3FA0FF3F3F9EFF3F3F9CFF3F3F9AFF3F3F98FF3F3F
      96FF3F3F95FF5F5F95FF0000000000000000000000006B6B6BFF1B1B1BFF1B1B
      1BFF1B1B1BFF1B1B1BFF1B1B1BFF1B1B1BFF1B1B1BFF1B1B1BFF1B1B1BFF1B1B
      1BFF1B1B1BFF1B1B1BFF1B1B1BFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004777D0FF0001E6FF0000
      E5FF0000E5FF2828E9FF2121E8FF6464EEFF5858ECFF3131E9FF0000E3FF0000
      E3FF0000E3FF2C2CC6FF0000000000000000000000006B6B6BFFD3D3D4FFD0D0
      D1FFCDCDCEFFCBCBCCFFC8C8C9FFC4C4C5FFC2C2C3FFBFBFC1FFBDBDBEFFBBBB
      BCFFB9B9BBFFB8B8B9FF1B1B1BFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000476FD1FF0000E8FF0000
      E8FF0000E8FF2F2FECFF8686F3FF6E6EF1FF6A6AF1FF6C6CF1FF0000E8FF0000
      E8FF0000E8FF2D2DCCFF0000000000000000000000006B6B6BFFD8D8D8FFD5D5
      D5FFD2D2D2FFCFCFD0FFCCCCCDFFC9C9CAFFC5C5C7FFC3C3C4FFC0C0C1FFBEBE
      BFFFBCBCBDFFBABABBFF1B1B1BFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F5EEE3FFDCC29AFFDDC39BFFDDC3
      9BFFDDC39BFFDDC39BFFDDC39BFFDDC39BFFDDC39BFFDDC39BFFDDC39BFFDDC3
      9BFFDDC39BFFDDC39BFFDEC59FFFFCFAF6FF00000000B1BBD2FFB3B3EBFFB3B3
      EBFFB2B2EAFFB3B3EBFFB3B3EBFFB3B3EBFFB3B3EBFFB3B3EBFFB3B3EBFFB3B3
      EBFFB3B3EBFFAAAAD1FF0000000000000000000000006B6B6BFFDCDCDDFFD9D9
      DAFFD6D6D7FFD3D3D4FF026E02FFCDCDCEFFCACACBFFC7C7C8FFC4C4C5FFC1C1
      C2FFBFBFC0FFBDBDBEFF1B1B1BFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D8BA8BFFF5EED7FFF6EED8FFF6EE
      D8FFF6EED8FFF6EED8FFF6EED8FFF6EED8FFF6EED8FFF6EED8FFF6EED8FFF6EE
      D8FFF6EED8FFF6EED8FFF2E7CCFFDEC49FFF00000000D3D3D3FFEEEEEEFF6A7D
      F1FF6B7CE7FFBEC4E3FFEDEDEDFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEE
      EEFFEEEEEEFFD4D4D4FF0000000000000000000000006B6B6BFFE0E0E1FFE0E0
      E1FFDADADBFFD7D7D8FF02A902FF026E02FFCECECFFFCBCBCCFFC8C8C9FFC5C5
      C7FFC2C2C3FFC0C0C1FF1B1B1BFF000000000000000000000000000000000C0C
      0C0B363636B54242428A4242428A4242428A4242428A1B1B1BE31B1B1BE33A3A
      3AA900000000000000000000000000000000D9BB8CFFF2E8CAFFEEE0BEFFCE97
      26FFD9B15EFFD9B262FFDEBF7CFFF2E8CAFFD9B05CFFD09722FFD8B56EFFCE92
      15FFD7AC54FFF2E8CAFFF2E8CAFFDCC199FF00000000D4D4D4FFF1F1F1FFC7CD
      F3FF7789EBFF5F73EAFFDFE0E8FFF1F1F1FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0
      F0FFF0F0F0FFD8D8D8FF0000000000000000000000006B6B6BFFE4E4E5FFE1E1
      E2FFDEDEDFFFDBDBDCFF02A902FF75DA80FF026E02FFCFCFD0FFCCCCCDFFCACA
      CBFFC7C7C8FFC3C3C4FF1B1B1BFF000000000000000000000000000000003C3C
      3CA5292929CFBBADADFF353535FFB6A9A9FFBBADADFF444444FF5F5F5FFF2929
      29CF00000000000000000000000000000000D8BA88FFEFE2BEFFE1C893FFCE98
      2FFFC88D1AFFD5A950FFDAB66BFFEFE2BEFFC5860BFFCF9D3CFFC9922CFFD09D
      3AFFC38204FFEFE2BDFFEFE2BDFFDCC198FF00000000D6D6D6FFF5F5F5FFF5F5
      F5FFECEDF5FF8D9CF6FF576DEDFFC5CAEBFFF1F2F2FFF4F4F4FFD7DBF1FFE8E9
      EDFFF3F3F3FFDBDBDBFF0000000000000000000000006B6B6BFFE8E8E9FFE5E6
      E6FFE3E3E3FFE0E0E0FF02A902FF75DA80FF75DA80FF026E02FFD0D0D1FFCDCD
      CEFFCBCBCCFFC8C8C9FF1B1B1BFF000000000000000000000000000000002E2E
      2EC7535353FFBDB7B7FF242424FFB4AEAEFFBDB7B7FF3F3F3FFF5C5C5CFF2E2E
      2EC700000000000000000000000000000000D7B885FFEBDCB1FFDEC389FFC990
      1FFFC89535FFD2A64EFFD7B366FFEBDCB1FFC1830BFFCFA043FFC68F29FFCF9F
      40FFC08007FFEBDCB1FFEBDCB1FFDCC097FF00000000D7D7D7FFF7F7F7FFF7F7
      F7FFF7F7F7FFF7F7F7FF657AF4FF9CA8EEFF8091F0FF6579F1FF2745F4FF677A
      EAFFF3F3F3FFDEDEDEFF0000000000000000000000006B6B6BFFECECEDFFEAEA
      EAFFE7E7E7FFE4E4E4FF02A902FF75DA80FF75DA80FF75DA80FF026E02FFD2D2
      D2FFCFCFD0FFCCCCCDFF1B1B1BFF000000000000000000000000000000003131
      31C1555555FFC7C6C6FFC3C2C2FFC3C2C2FFC7C6C6FF3A3A3AFF5A5A5AFF3131
      31C100000000000000000000000000000000D6B681FFE9D6A5FFDEC180FFD2A1
      2CFFD09E22FFD8B04EFFD4A62FFFDFC27CFFCD9715FFD5AB45FFCD9B2DFFD4A0
      16FFD2A12CFFE9D6A5FFE9D6A4FFDBC097FF00000000D8D8D8FFF9F9F9FFF9F9
      F9FFF9F9F9FFF9F9F9FFA8B4F9FFABB4EBFFB9C3F9FF5B71F2FFCBD2F8FFE0E3
      F9FFF7F7F7FFE0E0E0FF0000000000000000000000006B6B6BFFF0F0F0FFEDED
      EEFFEBEBEBFFE8E8E8FF02A902FF75DA80FF75DA80FF02A902FFD9D9DAFFD6D6
      D7FFD3D3D4FFD0D0D1FF1B1B1BFF000000000000000000000000000000003434
      34BC585858FF353535FF353535FF353535FF353535FF363636FF595959FF3434
      34BC00000000000000000000000000000000D6B57DFFE7D198FFDEC17EFFCF95
      10FFCF9A1FFFD6A93FFFCF9D29FFCF9715FFCA8E04FFD3A336FFCB9420FFD19E
      2CFFC98D04FFE7D198FFE7D098FFDBC096FF00000000D9D9D9FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFE9ECFBFF677AEDFF415BF5FFE6E8F5FFFCFCFCFFFCFC
      FCFFFAFAFAFFE2E2E2FF0000000000000000000000006B6B6BFFF4F4F4FFF1F1
      F1FFEFEFEFFFECECECFF02A902FF75DA80FF02A902FFE0E0E1FFDDDDDEFFDADA
      DBFFD7D7D8FFD4D4D5FF1B1B1BFF000000000000000000000000000000003636
      36B7797979FFD6D6CCFFF6F6E9FFF6F6E9FFF6F6E9FFD6D6CCFF797979FF3636
      36B700000000000000000000000000000000D5B379FFE6CB8CFFE6CB8CFFDBB6
      66FFE0C078FFD4A33AFFD2A344FFCA8B0AFFC88804FFD19D32FFC98F1DFFD29D
      2FFFC68501FFE6CB8BFFE6CB8BFFDBC096FF00000000DADADAFFFCFCFCFFFBFB
      FBFFFCFCFCFFFBFBFBFFFBFBFBFF3A55F7FF96A3F0FFFBFBFBFFF9F9F9FFF5F5
      F5FFF2F2F2FFDCDCDCFF0000000000000000000000006B6B6BFFF7F7F7FFF5F5
      F5FFF2F2F2FFF0F0F0FF02A902FF02A902FFE7E7E8FFE4E4E5FFE1E1E2FFDEDE
      DFFFDBDBDCFFD8D8D9FF1B1B1BFF000000000000000000000000000000003838
      38B27E7E7EFFFAFAF3FFF5F5EEFFF5F5EEFFF5F5EEFFFAFAF3FF7E7E7EFF3838
      38B200000000000000000000000000000000D5B276FFE4C67EFFE4C67EFFE4C6
      7EFFE4C67EFFD19E34FFC98802FFD09C2FFFC48403FFCE992DFFC68B1AFFCA89
      01FFCD9522FFE4C67EFFE4C67EFFDBC095FF00000000DBDBDBFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFF8F8FCFF314DF7FFE9EAF1FFF9F9F9FFF0F0F0FFE8E8
      E8FFE4E4E4FFD3D3D3FF0000000000000000000000006B6B6BFFFAFAFAFFF8F8
      F8FFF5F5F6FFF3F3F3FF02A902FFEEEEEEFFEBEBECFFE8E8E9FFE5E6E6FFE3E3
      E3FFE0E0E0FFDCDCDDFF1B1B1BFF000000000000000000000000000000003939
      39AF848484FFFFFFFEFFFEFEFDFFFEFEFDFFFEFEFDFFFFFFFEFF848484FF3939
      39AF00000000000000000000000000000000D4B173FFE3C272FFE3C272FFE3C2
      72FFE3C272FFE2BF6FFFE1BE6DFFE3C172FFE1BE6DFFE1BF6FFFE1BE6EFFE0BE
      6DFFE3C171FFE3C272FFE2C070FFDCC197FF00000000DBDBDBFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFCAD1FBFF0C2FF7FFD8DCEEFFF4F4F4FFE2E2E2FFE9E9
      E9FFDDDDDDFF000000000000000000000000000000006B6B6BFFFCFCFCFFFAFA
      FBFFF8F8F9FFF6F6F7FFF4F4F4FFF2F2F2FFEFEFEFFFECECEDFFEAEAEAFF6B6B
      6BFF1B1B1BFF1B1B1BFF1B1B1BFF000000000000000000000000000000004242
      42813A3A3AAC59595366595953665959536659595366595953663A3A3AAC4242
      428100000000000000000000000000000000EEE2CFFFD6B47AFFD7B579FFD7B5
      79FFD7B579FFD7B579FFD7B579FFD7B579FFD7B579FFD7B579FFD7B579FFD7B5
      79FFD7B579FFD7B579FFD7B57DFFF8F3EBFF00000000DCDCDCFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFCED4FBFF1838F6FFE0E2F1FFF2F2F2FFEFEFEFFFEDED
      EDFF00000000000000000000000000000000000000006B6B6BFFFEFEFEFFFDFD
      FDFFFBFBFBFFF9F9F9FFF7F7F7FFF5F5F5FFF3F3F3FFF0F0F0FFEDEDEEFF6B6B
      6BFFE8E8E8FFC7C7C9FF6B6B6BFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DCDCDCFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFEEF0FCFFFBFBFBFFF3F3F3FFE7E7E7FF0000
      000000000000000000000000000000000000000000006B6B6BFFFFFFFFFFFFFF
      FFFFFDFDFDFFFCFCFCFFFAFAFAFFF8F8F8FFF6F6F6FFF4F4F4FFF1F1F1FF6B6B
      6BFFC7C7C9FF6B6B6BFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E4E4E4FFF7F7F7FFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF3F3F3FF000000000000
      000000000000000000000000000000000000000000006B6B6BFF6B6B6BFF6B6B
      6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B
      6BFF6B6B6BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006BC2FDFF3FAFFDFF62BDFDFF97D4
      FCFFA0D6FDFF9CD5FDFF9CD5FDFF94D2FCFF76C5FDFF74C6FDFF6EC3FCFF6BC1
      FCFF91D1FCFFACDCFDFFA0D7FDFF83CBFDFF0000000000000000000000004040
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007BC8FEFF7CC9FDFF99D5FCFF96D3
      FDFFB8E1FCFFB7E0FDFFA6D9FDFF95D3FCFF82C4F0FF80B6DCFF7BC8FCFF73C5
      FDFF6AC1FDFF66BFFDFF6EC2FDFF99D5FDFF00000000000000002B2B2B00E0DB
      D9004267000000808000004E1900004E1900004E1900004E1900004E1900004E
      1900004E1900004E1900004E1900003611000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FEFEFC00FEFEFC00FDFDFA00FDFDFA00FCFC
      F800FEFEF90000000000000000000000000083CDFEFF8BCFFEFF91D2FDFF8DD0
      FDFF96D5FDFFA3D9FCFF97D3F8FF8EBCDBFF89ADC5FF87B2D1FF82BCE2FF7DC9
      FEFF74C6FEFF6AC1FEFF5EBDFEFF9CD6FDFF000000002B2B2B00E0DBD9000000
      00004870000000B9B9005A8A0000588800005888000058880000588800005888
      0000588800005787000053830100000000000000000000000000000000000000
      0000000000000000000000000000A49197009079810000000000000000000000
      0000000000000000000099898E00000000000000000000000000000000000000
      000000000000FEFEFC00FDFDFC00FDFDFA00FCFCF800FBFBF800FAFAF500F8F8
      F400FBFBF5000000000000000000000000008FD1FDFF98D5FDFF9DD8FDFFA3DA
      FDFFA6DCFCFF93D1FAFF91AABCFF98BCD4FF8AA3B2FF818182FF84A3B8FF85CE
      FDFF7ECAFEFF73C5FDFF68C1FDFF7CC9FDFF26262600D2CFCE00FFFDFC00CCC7
      C5005383010000000000E1F5BB00CDEF8C00C2EB7200BAE95E00B8E85900AEE5
      4200A5E22C009BDF160092DC00000036110000000000C6899D008F2648008A28
      47007A2B440078314800842B4700952F4F009731510084274500773047007B2E
      480089294800952F4F008F5A6B00000000000000000000000000000000000000
      0000CCCCBB00CBCBBA00DCDCCB00D2D2C100FBFBF800FAFAF500F8F8F400F7F7
      F200FBFBF50000000000000000000000000099D6FEFFA3D9FEFFA9DDFCFFAADC
      FDFF75C6FCFF7AC7F9FF98B3C5FF82888CFF818181FF818181FF7EB9E0FF31AA
      FCFF4CB5FDFF61BEFDFF69C1FCFF64BDFDFFB1AEAD00FFFBF800D5CFCB002B2B
      2B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C5879B00A4516B00B068
      7F00AE647A00AA607600A7586F00A1496300AA5A7100B5718500AE647A00A75A
      7100AA5A7100AE647A008B546500000000000000000000000000000000000000
      0000EDEDDC00EDEDDC00ECECDB00EBEBDA00FAFAF500F8F8F400F7F7F200F6F6
      F000FAFAF200000000000000000000000000A3DAFEFFADDDFEFF90D2FBFF77C6
      FBFF8FC2E3FF959EA5FFA5A5A5FF818181FF818181FF889199FF4FB6FBFF3EAF
      FCFF84CCFBFF0398FDFF159FFCFF65C0FDFF00000000CCC7C50000000000E0DB
      D900884D000000808000673C0000673C0000673C0000673C0000673C0000673C
      0000673C0000673C0000673C00005032000000000000C5879B00A4516B00C48E
      A000D7B0BC00DAB5C000C5879B00A1496300AA5A7100D7AFBB00DDBAC500CD9D
      AC00BD829500B0637C00844C5F0000000000000000000000000000000000FEFE
      FC00CBCBBA00DBDBCA00C9C9B800C7C7B600D7D7C600D6D6C500CCCCBB00D3D3
      C200FAFAF200000000000000000000000000ACDDFDFF95D4FCFF85C7F0FF93A6
      B3FFA3A3A3FFE2E2E2FFF8F8F8FF999999FF818181FF97B6CBFF21A4FDFFA2D9
      FCFF95D3FCFF3BAFFCFF37ADFDFF85CCFDFFA6A3A20000000000E0DBD9000000
      0000A75800001EC5C500A7580000A7580000A25700009F5600009F5600009C56
      00009654000096540000945400000000000000000000C6899D00A75A7100C689
      9D00D7B0BC00DAB5C000C1879800A34D6600AA607600D7AFBB00DDBAC500CD9D
      AC00BD829500AD6179007F45570000000000000000000000000000000000FEFE
      FC00ECECDB00EBEBDA00E9E9D800E8E8D700E7E7D600E5E5D400E4E4D300E3E3
      D200F9F9EF00000000000000000000000000B1DFFDFFBBE1F8FF8E9399FFD1D2
      D1FFAAAAA9FFEFEFEFFFD4D4D4FFCFCFCFFF858889FF75C0F4FF0499FDFF33AB
      FBFF8ACFFCFF4AB4FCFF71C4FCFFAFDEFDFF26262600D2CFCE00FFFDFC00CCC7
      C500B563060000000000FFE4B000FFDDA400FFD79800FFD18D00FFCB8100FFC5
      7600FFBF6A00FFB95F00FFB353005032000000000000C5879B00A6567000C48E
      A000D7B0BC00DAB5C000C5879B00A1496300AA5A7100D7AFBB00DAB5C000CD9D
      AC00BD829500AA5A71007B3F520000000000000000000000000000000000FDFD
      FA00C9C9B800C7C7B600C6C6B500D6D6C500C3C3B200D3D3C200D2D2C100C8C8
      B700F7F7EA00000000000000000000000000B5E1FDFFC4E6FDFFA2AFB7FFDBDB
      DBFFB5B5B5FFE5E5E5FFC7C7C7FFF7F7F7FF9CA2A7FF9BC9E7FF5EBCF9FF33AB
      FCFF1BA2FDFF35ADFCFF83CBFCFFA1D8FDFFB1AEAD00FFFBF800D5CFCB002B2B
      2B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C5879B00A6567000C689
      9D00D7B0BC00DAB5C000C6899D00A75A7100AE647A00D7B0BC00E0BFC900D0A3
      B200C6899D00AE647A0076394D0000000000000000000000000000000000FDFD
      FA00E9E9D800E8E8D700E7E7D600E5E5D400E4E4D300E3E3D200E2E2D100E0E0
      CF00F4F4E500000000000000000000000000B6E2FEFFC4E7FEFFC8DDECFFA4A6
      A7FFE9E9EAFFB1B1B1FFE6E6E6FFDCDCDCFFC1C1C1FF818181FF878E92FF91A7
      B6FF84B8D9FF81C8F8FF7FCBFCFF81CAFDFF00000000CCC7C50000000000E0DB
      D9001B145D000080800000005000000050000000500000005000000050000000
      50000000500000005000000050000000500000000000C5879B00A75A7100C490
      A200DAB5C000DAB5C000C6899D00A7586F00B0687F00DAB5C000DDBAC500D0A3
      B200C48EA000AE647A007333490000000000000000000000000000000000FCFC
      F800C6C6B500D6D6C500C3C3B200C2C2B100C1C1B000C0C0AF00CFCFBE00C6C6
      B500F3F3E200000000000000000000000000B5E0FDFFC4E6FEFFD1EBFDFFA0A8
      ADFFE6E5E5FFACACACFFEFEFEFFFDEDEDEFFE7E7E7FF818181FF818181FF8181
      81FF818181FF818E96FF81C8FAFF6DC2FDFFA6A3A20000000000E0DBD9000000
      0000201A6F001EC5C5005A0292005A0292005A0292005A0292005A0292005A02
      92005A0292005A02920053028D000000500000000000C5879B00A6567000C689
      9D00D7B0BC00DDBAC500C6899D00A7586F00AE647A00D7B0BC00E0BFC900D0A3
      B200C490A200AE647A00712E440000000000000000000000000000000000FCFC
      F600E7E7D600E5E5D400E4E4D300E3E3D200F1F1E700ECECDF00E8E8D900E6E6
      D500F2F2E100000000000000000000000000B2DFFDFFBDE3FDFFC9E9FDFFBFD4
      E1FFB4B4B5FFE9E9E9FFCBCBCBFFEAEAEAFF949494FF818181FF818181FF8181
      81FF8494A0FF84B5D5FF7FC8FCFF70C4FCFF26262600D2CFCE00FFFDFC00CCC7
      C5005302860000000000F0BEFF00E5A3FF00DE95FF00D787FF00D27DFF00D079
      FF00CA6CFF00C063F400B55AE8001B145D0000000000C88EA100A75A7100C48E
      A000D7B0BC00DDBAC500C1879800A4516B00AE647A00D7B0BC00E0BFC900D0A3
      B200C6899D00AE647A008545590000000000000000000000000000000000FBFB
      F500C3C3B200C2C2B100D2D2C100C8C8B700ECECDF00E8E8D900E6E6D500E5E5
      D400F2F2E100000000000000000000000000B0DEFDFFB6E1FDFFC1E5FDFFC9E7
      FCFFB0B7BBFFF4F4F5FFBCBCBDFFF3F3F3FF8C8C8CFF818384FF8FA2B1FF97C6
      E5FF91D3FCFF85CCFDFF79C8FDFF6DC2FDFFB1AEAD00FFFBF800D5CFCB001812
      5400620A9A006810A000620A9A006810A000620A9A006810A000620A9A006810
      A000620A9A005F08950053028600191463000000000000000000D7AFBB00C490
      A200D7B0BC00DAB5C000C6899D00A75A7100B46E8200D7B0BC00DDBAC500D1A6
      B400C490A200D7AFBB000000000000000000000000000000000000000000FAFA
      F500F5F5EE00F4F4EC00F1F1E700ECECDF00E8E8D900E6E6D500B5B5A400B5B5
      A400B5B5A40000000000000000000000000096D2FCFFB1DEFCFFB6E1FEFFBCE3
      FDFFAAC5D5FFAFAEAFFFBBBDBBFF8D9397FF9AB2C3FFA7D5F3FFA1D8FDFF97D4
      FEFF8BCFFEFF80CAFDFF74C6FEFF68C0FEFF00000000CCC7C500181254004B02
      7A000091910000D1D1000096960046057F004F0384004B027A004F0384004B02
      7A0050028100390A770018125400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FAFA
      F200F4F4EC00F1F1E700ECECDF00E8E8D900E6E6D500E5E5D400C7C7B6000000
      0000A3A3790000000000000000000000000095D2FDFFA0D7FCFFA7DCFDFFAFDE
      FDFFB1DEFAFF91A1ACFFA1BED3FFADDBF8FFA9DCFDFFA2D9FDFF98D5FDFF8ED1
      FDFF83CCFEFF7AC8FEFF6EC3FEFF63BEFEFFA6A3A20018125400201A6F000096
      960000D1D10000919100201A6F002C14740027106B002C14740027106B002C14
      740027106B001812540000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      F600F9F9EF00F6F6EA00F4F4E500F3F3E200F2F2E100F2F2E100D3D3C200A7A7
      7D00A7A77D000000000000000000000000000000000091D1FCFFB1DEFDFFAFDE
      FDFFA5DAFDFFA5DBFCFFA6DAFDFFA2D9FDFF9DD7FEFF96D4FEFF8ED0FDFF85CD
      FEFF7CC9FEFF73C5FDFF66C0FEFF5CBCFCFF210F54001B145D00191463001914
      6300191463001914630019146300191463001914630019146300191463001B14
      5D00001D58000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0038001FFFF000080038001FFFF
      000080038001FFFF000080038001FFFF000080038001E00F000080038001E00F
      000080038001E00F000080038001E00F000080038001E00F000080038001E00F
      000080038001E00F000080038001E00F000080078001E00F0000800F8001FFFF
      0000801F8003FFFF0000803F8007FFFF0000E001FFFFFFFF0000C000FFFFFE07
      00009000FE7DF807000004008001F007000000018001F007000080008001E007
      000010008001E007000004008001E007000000018001E007000080008001E007
      000010008001E007000004008001E00700000000C003E00700008001FFFFE017
      00000003FFFFE00700000007FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object pmHeaders: TPopupMenu
    Images = ilFileTypes
    OwnerDraw = True
    Left = 128
    Top = 232
    object N3: TMenuItem
      Tag = 20
      Caption = #1040#1074#1090#1086#1088
      Checked = True
      OnClick = HeaderPopupItemClick
    end
    object N4: TMenuItem
      Tag = 11
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      OnClick = HeaderPopupItemClick
    end
    object N8: TMenuItem
      Tag = 12
      Caption = #1057#1077#1088#1080#1103
      OnClick = HeaderPopupItemClick
    end
    object N10: TMenuItem
      Tag = 13
      Caption = #8470
      OnClick = HeaderPopupItemClick
    end
    object N12: TMenuItem
      Tag = 14
      Caption = #1046#1072#1085#1088
      OnClick = HeaderPopupItemClick
    end
    object N21: TMenuItem
      Tag = 15
      Caption = #1056#1072#1079#1084#1077#1088
      OnClick = HeaderPopupItemClick
    end
    object N13: TMenuItem
      Tag = 16
      Caption = #1052#1086#1103' '#1086#1094#1077#1085#1082#1072
      OnClick = HeaderPopupItemClick
    end
    object N15: TMenuItem
      Tag = 17
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1086
      OnClick = HeaderPopupItemClick
    end
    object N28: TMenuItem
      Tag = 18
      Caption = #1058#1080#1087
      OnClick = HeaderPopupItemClick
    end
    object N22: TMenuItem
      Tag = 19
      Caption = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      OnClick = HeaderPopupItemClick
    end
    object N42: TMenuItem
      Tag = 21
      Caption = #1071#1079#1099#1082
      OnClick = HeaderPopupItemClick
    end
    object N45: TMenuItem
      Tag = 22
      Caption = #1056#1077#1081#1090#1080#1085#1075
      OnClick = HeaderPopupItemClick
    end
    object BookID1: TMenuItem
      Tag = 23
      Caption = 'BookID'
      OnClick = HeaderPopupItemClick
    end
    object N25: TMenuItem
      Caption = '-'
    end
    object N27: TMenuItem
      Caption = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1099#1077
      OnClick = N27Click
    end
  end
  object TrayIcon: TTrayIcon
    Hint = 'MyHomeLib'
    BalloonHint = 'MyHomeLib'
    PopupMenu = pmTray
    OnDblClick = TrayIconDblClick
    Left = 456
    Top = 192
  end
  object pmTray: TPopupMenu
    OwnerDraw = True
    Left = 128
    Top = 424
    object N29: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100'/'#1057#1074#1077#1088#1085#1091#1090#1100
      OnClick = TrayIconDblClick
    end
    object N32: TMenuItem
      Caption = '-'
    end
    object N33: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N33Click
    end
  end
  object pmDownloadList: TPopupMenu
    Images = ilMainMenu
    OwnerDraw = True
    Left = 128
    Top = 376
    object mi_dwnl_LocateAuthor: TMenuItem
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1072#1074#1090#1086#1088#1091
      ImageIndex = 35
      OnClick = mi_dwnl_LocateAuthorClick
    end
    object N35: TMenuItem
      Caption = '-'
    end
    object mi_dwnl_Delete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnClick = btnDeleteDownloadClick
    end
  end
  object ilToolBar_Disabled: TImageList
    ColorDepth = cd32Bit
    BlendColor = clWhite
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Height = 32
    Width = 32
    Left = 280
    Top = 320
    Bitmap = {
      494C010118001D00040020002000FFFFFF002110FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000080000000E0000000010020000000000000C0
      0100000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000535353CA535353CA5353
      53CA535353CA535353CA535353CA535353CA535353CA535353CA535353CA5353
      53CA535353CA535353CA535353CA737373CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003F3F3FCA3F3F3FCA3F3F3FCA3F3F3FCA3F3F3FCA3F3F3FCA3F3F
      3FCA3F3F3FCA3F3F3FCA737373CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000003000000110000002700000035000000380000
      0035000000270000001100000003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6F6FCA9C9C9CFFB8B8B8FFB8B8
      B8FFB8B8B8FFB8B8B8FF9C9C9CFF868686FFC8C8C8FFB8B8B8FFB8B8B8FFB8B8
      B8FFB5B5B5FF939393FF535353CA737373CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F4F4F4FFF3F3F3FFF2F2F2FFF2F2F2FFF1F1F1FFF0F0F0FFEFEFEFFFEEEE
      EEFFF0F0F0FF3F3F3FCA737373CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000131C1C1C9E3E3E3EDE0101012C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000080000002700000054000000730000007B0000
      0073000000540000002700000008000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000323232CA222222CA2525
      25CA252525CA242424CA242424CA242424CA898989FF363636FF363636FF3838
      38FF3E3E3EFF393939FF3E3E3EFF404040FF363636FF3C3C3CFF3B3B3BFF3737
      37FF3B3B3BFF696969FF535353CA737373CA0000000000000000000000000000
      00000000000000000000000000000000000000000000323232CA222222CA2525
      25CA252525CA242424CA242424CA242424CA242424CA242424CA242424CA2525
      25CAC1C1C1FFC0C0C0FFD0D0D0FFC7C7C7FFF0F0F0FFEFEFEFFFEEEEEEFFECEC
      ECFFF0F0F0FF3F3F3FCA737373CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000207070759525252E3BEBEBEFFBBBBBBFF333333CD0000
      000C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B858585FF858585FF858585FF858585FF8585
      85FF00000073000000350000000B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000737373CA333333FF353535FF3737
      37FF363636FF363636FF373737FF363636FF878787FF5C5C5CFF6F6F6FFF6C6C
      6CFF686868FF606060FF545454FF616161FF767676FF6A6A6AFF626262FF6666
      66FF696969FF626262FF535353CA737373CA0000000000000000000000000000
      000000000000000000000000000000000000737373CA333333FF353535FF3838
      38FF363636FF363636FF383838FF373737FF363636FF373737FF353535FF3232
      32FFE0E0E0FFE0E0E0FFDFDFDFFFDEDEDEFFEFEFEFFFEEEEEEFFECECECFFEBEB
      EBFFEFEFEFFF3F3F3FCA737373CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000001010122282828BE949494FFDDDDDDFFE6E6E6FFF0F0F0FFACACACFF1818
      189B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B858585FFB9B9B9FFB6B6B6FFB3B3B3FF8585
      85FF0000007B000000380000000B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000474747CA5A5A5AFF7B7B7BFF7373
      73FF828282FF797979FF747474FF717171FF878787FF5F5F5FFF909090FFAFAF
      AFFFB3B3B3FF8B8B8BFF585858FF656565FFABABABFFB8B8B8FF9E9E9EFF8787
      87FF6B6B6BFF383838CA535353CA737373CA0000000000000000000000000000
      000000000000000000000000000000000000474747CA5C5C5CFF7C7C7CFF7373
      73FF828282FF7A7A7AFF757575FF717171FF6F6F6FFF6A6A6AFF5E5E5EFF7575
      75FFC0C0C0FFCFCFCFFFBEBEBEFFBCBCBCFFCCCCCCFFCBCBCBFFC1C1C1FFC8C8
      C8FFEFEFEFFF3F3F3FCA737373CA000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000C0E0E
      0E7B616161EEC1C1C1FFE5E5E5FFDFDFDFFFBBBBBBFFCDCDCDFFF1F1F1FF8F8F
      8FFF0A0A0A6A0000000000000000000000000000000600000011000000000000
      0000000000000000000000000000000000000000000000000000000000030000
      00080000000B0000000B00000016858585FFBDBDBDFFB9B9B9FFB6B6B6FF8585
      85FF01010180000000430000001A0000000F0000000F0000000C000000070000
      0004000000040000000400000004000000040000000400000004000000040000
      0004000000040000000400000003000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA5F5F5FFF848484FF7272
      72FF8E8E8EFF7C7C7CFF757575FF727272FF878787FF606060FF909090FFAFAF
      AFFFB3B3B3FF8B8B8BFF585858FF656565FFABABABFFB8B8B8FF9E9E9EFF8787
      87FF696969FF333333CA535353CA737373CA0000000000000000000000000000
      000000000000000000000000000000000000404040CA5F5F5FFF848484FF7272
      72FF8E8E8EFF7D7D7DFF767676FF727272FF707070FF6B6B6BFF5A5A5AFF7E7E
      7EFFDFDFDFFFDEDEDEFFDDDDDDFFDCDCDCFFDBDBDBFFD9D9D9FFD8D8D8FFD7D7
      D7FFEDEDEDFF3F3F3FCA737373CA000000000000000000000000000000000000
      00000000000000000000000000000000000000000000040404493B3B3BD4A7A7
      A7FFE0E0E0FFE6E6E6FFCCCCCCFF919191FF737373FF7D7D7DFFD8D8D8FFE7E7
      E7FF6E6E6EF9040404450000000000000000212121975C5C5CF61212127A0000
      0004000000000000000000000000000000000000000000000003000000110000
      0027000000350000003800000040858585FFC0C0C0FFBDBDBDFFB9B9B9FF8585
      85FF0101019B0000007400000059000000530000005000000044000000310000
      0025000000220000002200000022000000220000002200000022000000220000
      0022000000220000002200000006000000000000000000000000000000000000
      000000000000000000000000000000000000424242CA6F6F6FFF8C8C8CFF7474
      74FF666666FF6A6A6AFF717171FF737373FF878787FF606060FF909090FFAFAF
      AFFFB3B3B3FF8B8B8BFF585858FF656565FFABABABFFB8B8B8FF9E9E9EFF8787
      87FF676767FF2F2F2FCA535353CA737373CA0000000000000000000000000000
      000000000000000000000000000000000000434343CA6F6F6FFF8D8D8DFF7575
      75FF676767FF6B6B6BFF717171FF737373FF747474FF6E6E6EFF606060FF5959
      59FFBEBEBEFFBCBCBCFFBCBCBCFFCBCBCBFFB9B9B9FFC8C8C8FFC7C7C7FFBDBD
      BDFFEBEBEBFF3F3F3FCA737373CA000000000000000000000000000000000000
      0000000000000000000000000000000000121A1A1AA07A7A7AFFCCCCCCFFE8E8
      E8FFDBDBDBFFB1B1B1FF757575FF777777FF8C8C8CFF828282FF868686FFE9E9
      E9FFD9D9D9FF454545DC00000012121212826F6F6FFF959595FF8C8C8CFF1A1A
      1A9A000000000000000000000000000000000000000000000008000000270000
      0054000000730000007B0000007E858585FFC2C2C2FFC0C0C0FFBDBDBDFF8585
      85FF222222FF292929FF2D2D2DFF2E2E2EFF303030FF3A3A3AFF494949FF5252
      52FF555555FF555555FF555555FF555555FF555555FF555555FF555555FF5555
      55FF555555FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000464646CA757575FF8E8E8EFF7D7D
      7DFF757575FF767676FF7A7A7AFF787878FF878787FF606060FF919191FFB0B0
      B0FFB4B4B4FF8F8F8FFF5F5F5FFF6E6E6EFFB0B0B0FFBCBCBCFFA4A4A4FF8D8D
      8DFF686868FF464646FF535353CA737373CA0000000000000000000000000000
      000000000000000000000000000000000000464646CA767676FF8E8E8EFF7D7D
      7DFF757575FF777777FF7A7A7AFF797979FF7A7A7AFF767676FF6A6A6AFF6464
      64FFDDDDDDFFDCDCDCFFDBDBDBFFD9D9D9FFD8D8D8FFD7D7D7FFD6D6D6FFD4D4
      D4FFE8E8E8FF3F3F3FCA737373CA000000000000000000000000000000000000
      000000000000000000010A0A0A6A494949E6AFAFAFFFE5E5E5FFE2E2E2FFC5C5
      C5FF878787FF6C6C6CFF808080FF888888FF8A8A8AFF919191FF858585FFA5A5
      A5FFEFEFEFFFBFBFBFFF414141E1686868F9A2A2A2FFB1B1B1FF8D8D8DFF6767
      67FE02020233000000000000000000000000000000000000000B9F9F9FFF8585
      85FF858585FF858585FF858585FF858585FFC5C5C5FFC2C2C2FFC0C0C0FF8585
      85FF858585FF858585FF858585FF858585FF858585FF787878FFACACACFFD0D0
      D0FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9
      D9FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000444444CA494949FF585858FF5E5E
      5EFF5A5A5AFF626262FF737373FF656565FF878787FF606060FF919191FFB1B1
      B1FFB5B5B5FF8F8F8FFF5F5F5FFF6E6E6EFFB0B0B0FFBCBCBCFFA6A6A6FF9191
      91FF6E6E6EFF3F3F3FFF535353CA737373CA0000000000000000000000000000
      000000000000000000000000000000000000444444CA4A4A4AFF5A5A5AFF5E5E
      5EFF5C5C5CFF626262FF737373FF656565FF5F5F5FFF4A4A4AFF363636FF3131
      31FFBCBCBCFFCBCBCBFFB9B9B9FFB8B8B8FFB7B7B7FFB6B6B6FFC4C4C4FFBCBC
      BCFFE6E6E6FF3F3F3FCA737373CA000000000000000000000000000000000000
      000001010125252525BE8C8C8CFFD7D7D7FFE7E7E7FFD8D8D8FF9C9C9CFF6C6C
      6CFF747474FF828282FF848484FF888888FF8B8B8BFF909090FF979797FF8282
      82FFB8B8B8FFA3A3A3FF6C6C6CFFA4A4A4FFB5B5B5FF959595FF767676FF6868
      68FF0404043E000000000000000000000000000000000000000B9F9F9FFFD7D7
      D7FFD4D4D4FFD1D1D1FFCDCDCDFFCBCBCBFFC8C8C8FFC5C5C5FFC2C2C2FFC0C0
      C0FFBDBDBDFFB9B9B9FFB6B6B6FFB3B3B3FF858585FF767676FFB1B1B1FFD8D8
      D8FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA535353FFB7B7B7FF9797
      97FF979797FF9C9C9CFFA1A1A1FF9F9F9FFF868686FF606060FF919191FFB0B0
      B0FFB4B4B4FF8E8E8EFF5F5F5FFF6D6D6DFFAFAFAFFFBCBCBCFFA6A6A6FF9191
      91FF6C6C6CFF3B3B3BFF535353CA737373CA0000000000000000000000000000
      000000000000000000000000000000000000404040CA535353FFB7B7B7FF9898
      98FF979797FF9D9D9DFFA1A1A1FF9F9F9FFF9E9E9EFF999999FF959595FF9595
      95FFDBDBDBFFD9D9D9FFD8D8D8FFD7D7D7FFE5E5E5FFE0E0E0FFDCDCDCFFDADA
      DAFFE5E5E5FF3F3F3FCA737373CA0000000000000000000000000000000A0F0F
      0F80606060F9B7B7B7FFE7E7E7FFE0E0E0FFB7B7B7FF7A7A7AFF686868FF7878
      78FF7D7D7DFF818181FF848484FF898989FF8C8C8CFF919191FF989898FF9999
      99FF686868FF6B6B6BFFA8A8A8FFB5B5B5FF969696FF7B7B7BFF676767FD1010
      106D00000000000000000000000000000000000000000000000B9F9F9FFFD9D9
      D9FFD7D7D7FFD4D4D4FFD1D1D1FFCDCDCDFFCBCBCBFFC8C8C8FFC5C5C5FFC2C2
      C2FFC0C0C0FFBDBDBDFFB9B9B9FFB6B6B6FF858585FF515151FF717171FF8787
      87FF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA757575FF808080FF1515
      15FF1C1C1CFF1C1C1CFF1B1B1BFF1C1C1CFF8C8C8CFF606060FF909090FFB0B0
      B0FFB4B4B4FF8D8D8DFF5E5E5EFF6C6C6CFFAFAFAFFFBBBBBBFFA5A5A5FF9090
      90FF6B6B6BFF4F4F4FFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA767676FF808080FF1515
      15FF1C1C1CFF1C1C1CFF1B1B1BFF1C1C1CFF1D1D1DFF1C1C1CFF1C1C1CFF1E1E
      1EFFE5E5E5FFB8B8B8FFC7C7C7FFBDBDBDFFE0E0E0FFDCDCDCFFDADADAFFD9D9
      D9FFE5E5E5FF3F3F3FCA737373CA00000000000000000505054F353535D79898
      98FFDFDFDFFFE8E8E8FFCCCCCCFF8F8F8FFF646464FF6E6E6EFF787878FF7A7A
      7AFF7D7D7DFF828282FF868686FF8A8A8AFF8E8E8EFF949494FF999999FF7676
      76FF6C6C6CFFA7A7A7FFB7B7B7FF949494FF787878FF626262FA0C0C0C5F0000
      00000000000000000000000000000000000000000000000000089F9F9FFFDBDB
      DBFFD9D9D9FFD7D7D7FFD4D4D4FFD1D1D1FFCDCDCDFFCBCBCBFFC8C8C8FFC5C5
      C5FFC2C2C2FFC0C0C0FFBDBDBDFFB9B9B9FF858585FF3C3C3CFF4C4C4CFF5656
      56FF595959FF6B6B6BFFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA757575FFDDDDDDFFE4E4
      E4FFF5F5F5FFF5F5F5FFF4F4F4FFF5F5F5FFEAEAEAFFAAAAAAFF979797FFAFAF
      AFFFB4B4B4FF8D8D8DFF646464FF767676FFAEAEAEFFBBBBBBFFA5A5A5FF9393
      93FF939393FFE4E4E4FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA767676FFDEDEDEFFE4E4
      E4FFF5F5F5FFF5F5F5FFF4F4F4FFF5F5F5FFF4F4F4FFF5F5F5FFF5F5F5FFE9E9
      E9FFEAEAEAFFE9E9E9FFE5E5E5FFE0E0E0FFDCDCDCFFDADADAFFACACACFFACAC
      ACFFACACACFF3F3F3FCA737373CA000000000D0D0D75707070FFC8C8C8FFE9E9
      E9FFDBDBDBFFA9A9A9FF6C6C6CFF676767FF727272FF757575FF777777FF7A7A
      7AFF808080FF838383FF878787FF8B8B8BFF909090FF969696FF757575FF6C6C
      6CFFAAAAAAFFB7B7B7FF949494FF787878FF6D6D6DFF434343DB0000000F0000
      00000000000000000000000000000000000000000000000000039F9F9FFF9F9F
      9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFFD1D1D1FFCDCDCDFFCBCBCBFF8585
      85FF858585FF858585FF858585FF858585FF858585FF545454FF5C5C5CFF6060
      60FF626262FF5F5F5FFF3B3B3BFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA777777FFE2E2E2FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FF939393FF9393
      93FF939393FF939393FF939393FF939393FF939393FF939393FF939393FF9393
      93FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA787878FFE2E2E2FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF4F4F4FFF5F5
      F5FFE5E5E5FFE5E5E5FFE0E0E0FFDCDCDCFFDADADAFFD9D9D9FFBCBCBCFFF4F4
      F4FF969696FF3F3F3FCA737373CA000000003C3C3CE7CECECEFFE8E8E8FFC2C2
      C2FF7D7D7DFF626262FF6B6B6BFF707070FF737373FF757575FF787878FF7C7C
      7CFF818181FF848484FF898989FF8C8C8CFF929292FF737373FF707070FFADAD
      ADFFB5B5B5FF979797FF797979FF636363FFB4B4B4FFBCBCBCFF1919199A0000
      0000000000000000000000000000000000000000000000000000000000030000
      00080000000B0000000B000000169F9F9FFFD4D4D4FFD1D1D1FFCDCDCDFF8585
      85FF737373FFAAAAAAFF545454FF999999FF9A9A9AFF858585FF808080FF8585
      85FF818181FF959595FFA4A4A4FF5E5E5EFFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA777777FFEEEEEEFFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFF5F5F5FFEEEEEEFF8A8A8AFF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA787878FFEFEFEFFFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFE5E5E5FFEAEAEAFFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFC8C8C8FF9999
      99FF999999FF000000000000000000000000242424BBA8A8A8FF9B9B9BFF6767
      67FF686868FF6E6E6EFF6E6E6EFF707070FF757575FF797979FF7D7D7DFF8282
      82FF838383FF858585FF8A8A8AFF8F8F8FFF747474FF6D6D6DFFA2A2A2FFB5B5
      B5FF959595FF7B7B7BFF676767FF727272FFB8B8B8FFF3F3F3FF9E9E9EFF0F0F
      0F7E000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B9F9F9FFFD7D7D7FFD4D4D4FFD1D1D1FF8585
      85FF4C4C4CFF303030FF606060FF676767FF696969FF5E5E5EFF525252FF5555
      55FF515151FF5D5D5DFF6B6B6BFF646464FF3B3B3BFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA787878FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF4F4F4FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3
      F3FFF5F5F5FFF5F5F5FF878787FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA797979FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF4F4F4FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3
      F3FFF5F5F5FFF5F5F5FF888888FF3F3F3FCA0000000000000000000000000000
      00000000000000000000000000000000000006060652535353FF676767FF6C6C
      6CFF6C6C6CFF6D6D6DFF727272FF707070FF676767FF606060FF616161FF6969
      69FF797979FF898989FF8F8F8FFF8A8A8AFF5B5B5BFF848484FFA7A7A7FF9595
      95FF7B7B7BFF676767FF848484FFB2B2B2FF919191FFCACACAFFEFEFEFFF7A7A
      7AFA030303400000000000000000000000000000000000000000000000000000
      000000000000000000000000000B9F9F9FFFD9D9D9FFD7D7D7FFD4D4D4FF8585
      85FF424242FF6C6C6CFF9E9E9EFFA4A4A4FFAAAAAAFF949494FF7E7E7EFF8080
      80FF7E7E7EFF949494FFA7A7A7FFA4A4A4FF676767FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7D7D7DFFEFEFEFFFC5C5
      C5FFE0E0E0FFE0E0E0FFC9C9C9FFC3C3C3FFC2C2C2FFC3C3C3FFC3C3C3FFD2D2
      D2FFF5F5F5FFF5F5F5FF818181FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7D7D7DFFEFEFEFFFC5C5
      C5FFE0E0E0FFE0E0E0FFCACACAFFC3C3C3FFC2C2C2FFC3C3C3FFC3C3C3FFD2D2
      D2FFF5F5F5FFF5F5F5FF818181FF3F3F3FCA0000000000000000000000000000
      000000000000000000000000000000000000000000001010107B696969FF6D6D
      6DFF6E6E6EFF6D6D6DFF595959FF444444FF414141FF3E3E3EFF424242FF4141
      41FF3E3E3EFF525252FF727272FF8B8B8BFFABABABFF6F6F6FFF848484FF7979
      79FF656565FF848484FFB1B1B1FFB3B3B3FFB1B1B1FF919191FFDADADAFFE4E4
      E4FF4D4D4DDC0000001B00000000000000000000000000000000000000000000
      00000000000000000000000000089F9F9FFFDBDBDBFFD9D9D9FFD7D7D7FF8585
      85FF454545FF565656FF646464FF686868FF626262FF555555FF505050FF5C5C
      5CFF606060FF666666FF666666FF676767FF646464FF3C3C3CFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7C7C7CFFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FF797979FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA7C7C7CFFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FF7A7A7AFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000262626B46F6F
      6FFF686868FF464646FF3B3B3BFF5B5B5BFF898989FF9F9F9FFFA4A4A4FF9A9A
      9AFF777777FF4C4C4CFF444444FF797979FFF2F2F2FFACACACFF5D5D5DFF6363
      63FF808080FFADADADFFAFAFAFFFB1B1B1FFB9B9B9FFAEAEAEFF999999FFEBEB
      EBFFCDCDCDFF2B2B2BBD00000004000000000000000000000000000000000000
      00000000000000000000000000039F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F
      9FFF515151FF959595FFAAAAAAFFB0B0B0FF949494FF808080FF7B7B7BFFACAC
      ACFFA6A6A6FFA5A5A5FFA3A3A3FFA6A6A6FFA2A2A2FF5B5B5BFFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA757575FFF5F5F5FFC5C5
      C5FFC4C4C4FFCBCBCBFFF5F5F5FFF5F5F5FFC2C2C2FFC4C4C4FFC4C4C4FFC4C4
      C4FFF5F5F5FFF5F5F5FF737373FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA767676FFF5F5F5FFC5C5
      C5FFC4C4C4FFCCCCCCFFF5F5F5FFF5F5F5FFC2C2C2FFC4C4C4FFC4C4C4FFC4C4
      C4FFF5F5F5FFF5F5F5FF737373FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000113434
      34CC444444FF444444FF888888FFB0B0B0FFB5B5B5FFB0B0B0FFADADADFFACAC
      ACFFB1B1B1FFA5A5A5FF737373FF454545FF6E6E6EFFB5B5B5FF7B7B7BFF8181
      81FFAAAAAAFFADADADFFB0B0B0FFB2B2B2FFB6B6B6FFBEBEBEFFA5A5A5FFA3A3
      A3FFEFEFEFFFB7B7B7FF12121286000000000000000000000000000000000000
      0000000000000000000000000000000000064F4F4FFFE0E0E0FFCFCFCFFF8282
      82FF3A3A3AFF5F5F5FFF4A4A4AFF4B4B4BFF4E4E4EFF505050FF4A4A4AFF6969
      69FF666666FF666666FF676767FF626262FF636363FF3B3B3BFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000414141CA7B7B7BFFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF0F0F0FFF3F3F3FFF5F5F5FFF0F0
      F0FFF5F5F5FFF5F5F5FF707070FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424242CA7C7C7CFFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF0F0F0FFF3F3F3FFF5F5F5FFF0F0
      F0FFF5F5F5FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001010
      1099444444FF919191FFB8B8B8FFADADADFFA2A2A2FF9F9F9FFF9F9F9FFFA0A0
      A0FFA1A1A1FFA5A5A5FFAAAAAAFF727272FF343434FF676767FF9D9D9DFFA9A9
      A9FFA9A9A9FFACACACFFB0B0B0FFB4B4B4FFB8B8B8FFBABABAFFC2C2C2FF9D9D
      9DFFB4B4B4FFF4F4F4FF9D9D9DFF060606530000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FF696969FF616161FF858585FF828282FF848484FF848484FF7B7B7BFFA9A9
      A9FFA9A9A9FFA8A8A8FF9E9E9EFF989898FFA0A0A0FF5F5F5FFFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000454545CA868686FFF5F5F5FFC5C5
      C5FFE0E0E0FFE0E0E0FFD2D2D2FFC3C3C3FFC3C3C3FFC9C9C9FFE0E0E0FFC4C4
      C4FFF5F5F5FFF5F5F5FF707070FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000454545CA868686FFF5F5F5FFC5C5
      C5FFE1E1E1FFE1E1E1FFD2D2D2FFC3C3C3FFC3C3C3FFCACACAFFE1E1E1FFC4C4
      C4FFF5F5F5FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000263131
      31F0787878FFBABABAFFAAAAAAFF9E9E9EFF9F9F9FFFA1A1A1FFA3A3A3FFA4A4
      A4FFA4A4A4FFA3A3A3FFA4A4A4FFA6A6A6FF555555FF4F4F4FFFA4A4A4FFA6A6
      A6FFA9A9A9FFAEAEAEFFB1B1B1FFB5B5B5FFB9B9B9FFBBBBBBFFC0C0C0FFC4C4
      C4FF959595FFCECECEFFE4E4E4FF3F3F3FD50000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF4F4F4FFF4F4F4FFF606060FF505050FF525252FF545454FF515151FF5959
      59FF5B5B5BFF575757FF5C5C5CFF606060FF414141FF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000494949CA939393FFF3F3F3FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3F3FFF3F3F3FFF3F3
      F3FFF5F5F5FFF5F5F5FF6F6F6FFF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA939393FFF3F3F3FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3F3FFF3F3F3FFF3F3
      F3FFF5F5F5FFF5F5F5FF6F6F6FFF3F3F3FCA0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000D0D0D904B4B
      4BFD9E9E9EF8ADADADFF9D9D9DFFA0A0A0FFA4A4A4FFA8A8A8FFAAAAAAFFABAB
      ABFFABABABFFA9A9A9FFA6A6A6FFAAAAAAFF868686FF3A3A3AFF8C8C8CFFABAB
      ABFFABABABFFAFAFAFFFB2B2B2FFB6B6B6FFB9B9B9FFBDBDBDFFC0C0C0FFC3C3
      C3FFC1C1C1FF9E9E9EFF727272DF070707590000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FF636363FF9B9B9BFFA2A2A2FF838383FF838383FF838383FF8080
      80FF939393FFAEAEAEFFA9A9A9FF9F9F9FFF5D5D5DFFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000494949CA949494FFF5F5F5FFBDBD
      BDFFBBBBBBFFDDDDDDFFBEBEBEFFDEDEDEFFDEDEDEFFD0D0D0FFBCBCBCFFBCBC
      BCFFF4F4F4FFF5F5F5FF707070FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4A4ACA949494FFF5F5F5FFBEBE
      BEFFBCBCBCFFDEDEDEFFBFBFBFFFDFDFDFFFDFDFDFFFD1D1D1FFBDBDBDFFBDBD
      BDFFF4F4F4FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      00000000000000000000000000000000000000000000000000001B1B1BD05B5B
      5BE9969696E59D9D9DFFA0A0A0FFA6A6A6FFACACACFFB1B1B1FFB4B4B4FFB6B6
      B6FFB4B4B4FFB1B1B1FFADADADFFAAAAAAFF9F9F9FFF434343FF646464FFADAD
      ADFFACACACFFB0B0B0FFB3B3B3FFB7B7B7FFBABABAFFBEBEBEFFC0C0C0FFC2C2
      C2FFC7C7C7FFC5C5C5FF2B2B2BA7000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF8D8D8DFF8D8D8DFF3E3E3EFF606060FF5F5F5FFF575757FF545454FF8383
      83FF575757FF616161FF626262FF3D3D3DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000474747CA8F8F8FFFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FF707070FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000474747CA8F8F8FFFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000005232323D76E6E
      6EEE828282D5888888EEA3A3A3FFACACACFFB4B4B4FFBABABAFFBFBFBFFFC0C0
      C0FFBEBEBEFFBABABAFFB3B3B3FFADADADFFABABABFF535353FF494949FFADAD
      ADFFADADADFFB0B0B0FFB5B5B5FFB8B8B8FFBBBBBBFFBEBEBEFFC1C1C1FFC3C3
      C3FFCCCCCCFFC9C9C9FF505050CE000000080000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FF656565FF767676FF979797FFA3A3A3FFA3A3
      A3FF9A9A9AFF808080FF5F5F5FFFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000444444CA878787FFF5F5F5FFF5F5
      F5FFF4F4F4FFF3F3F3FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3F3FFF3F3F3FFF4F4
      F4FFF4F4F4FFF5F5F5FF707070FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000444444CA888888FFF5F5F5FFF5F5
      F5FFF4F4F4FFF3F3F3FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3F3FFF3F3F3FFF4F4
      F4FFF4F4F4FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000005242424D77171
      71F07E7E7ED6797979D99A9A9AF5B1B1B1FFBBBBBBFFC3C3C3FFC9C9C9FFCACA
      CAFFC8C8C8FFC2C2C2FFBABABAFFB2B2B2FFAFAFAFFF5B5B5BFF474747FFADAD
      ADFFAFAFAFFFB1B1B1FFB5B5B5FFB9B9B9FFBCBCBCFFBFBFBFFFC5C5C5FFCCCC
      CCFF999999FA181818870000000E000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF505050FF474747FF3F3F3FFF3E3E
      3EFF454545FF4F4F4FFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000444444CA868686FFDFDFDFFFEDED
      EDFFE5E5E5FFE1E1E1FFE1E1E1FFE4E4E4FFDFDFDFFFE0E0E0FFDFDFDFFFBCBC
      BCFFBFBFBFFFEBEBEBFF707070FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000444444CA868686FFE0E0E0FFEDED
      EDFFE5E5E5FFE1E1E1FFE1E1E1FFE4E4E4FFE0E0E0FFE1E1E1FFE0E0E0FFBDBD
      BDFFBFBFBFFFECECECFF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000004222222D56666
      66EC7A7A7AD77A7A7AD8848484DDABABABFABFBFBFFFC9C9C9FFD2D2D2FFD4D4
      D4FFCFCFCFFFC8C8C8FFBEBEBEFFB6B6B6FFADADADFF4F4F4FFF535353FFB0B0
      B0FFB0B0B0FFB2B2B2FFB7B7B7FFB9B9B9FFBEBEBEFFC8C8C8FFB5B5B5FF4545
      45C3030303370000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000494949CA878787FFD6D6D6FFD1D1
      D1FFBCBCBCFFAFAFAFFFA8A8A8FFA8A8A8FF9E9E9EFFA8A8A8FFA3A3A3FFA2A2
      A2FF4F4F4FFFC9C9C9FF707070FF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000494949CA888888FFD7D7D7FFD1D1
      D1FFBDBDBDFFB0B0B0FFA8A8A8FFA9A9A9FF9E9E9EFFA9A9A9FFA3A3A3FFA2A2
      A2FF505050FFCACACAFF707070FF3F3F3FCA0000000000000000000000000000
      00000000000000000000000000000000000000000000000000001F1F1FBE5C5C
      5CEF767676D67B7B7BD9808080D7939393E2BEBEBEFECDCDCDFFD6D6D6FFD8D8
      D8FFD2D2D2FFCACACAFFC0C0C0FFBABABAFF9F9F9FFF3E3E3EFF7A7A7AFFB2B2
      B2FFB0B0B0FFB3B3B3FFB7B7B7FFC0C0C0FFBFBFBFFF6F6F6FE20A0A0A600000
      0002000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000515151CA929292FFE4E4E4FFDADA
      DAFFDCDCDCFFDDDDDDFFD9D9D9FFD5D5D5FFD0D0D0FFC9C9C9FFC4C4C4FFC1C1
      C1FFBDBDBDFFD4D4D4FF6F6F6FFF646464FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000515151CA929292FFE4E4E4FFDBDB
      DBFFDCDCDCFFDEDEDEFFD9D9D9FFD5D5D5FFD0D0D0FFC9C9C9FFC4C4C4FFC1C1
      C1FFBEBEBEFFD4D4D4FF6F6F6FFF3F3F3FCA0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000606065F5757
      57FD686868D57E7E7EDA818181D9888888D7A2A2A2E9C8C8C8FFD2D2D2FFD4D4
      D4FFCFCFCFFFC8C8C8FFBEBEBEFFBDBDBDFF777777FF404040FF9F9F9FFFAFAF
      AFFFB0B0B0FFB7B7B7FFC1C1C1FFA2A2A2FF2020209B00000012000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000585858CA828282FF9B9B9BFF9292
      92FF919191FF919191FF8B8B8BFF828282FF7A7A7AFF757575FF6C6C6CFF6767
      67FF5D5D5DFF585858FF383838FF6F6F6FFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000585858CA828282FF9C9C9CFF9292
      92FF919191FF919191FF8C8C8CFF828282FF7B7B7BFF767676FF6D6D6DFF6868
      68FF5E5E5EFF5A5A5AFF393939FF454545CA0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000D3030
      30D65B5B5BE9787878D5808080D9878787D98C8C8CD8AEAEAEF1C8C8C8FFCBCB
      CBFFC8C8C8FFC2C2C2FFC0C0C0FFA4A4A4FF424242FF686868FFAFAFAFFFAFAF
      AFFFB9B9B9FFAFAFAFFF4B4B4BCE040404400000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000006A6A6ACA757575FF7E7E7EFF6A6A
      6AFF616161FF646464FF595959FF4E4E4EFF4E4E4EFF4F4F4FFF474747FF4545
      45FF444444FF292929CA242424CAA1A1A1FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6BCA767676FF7E7E7EFF6B6B
      6BFF616161FF646464FF5B5B5BFF4E4E4EFF4E4E4EFF4F4F4FFF484848FF4646
      46FF2A2A2ACA292929CA3B3B3BFF646464CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000303
      03503A3A3AFD555555E17B7B7BD5868686DA878787D88C8C8CD9AFAFAFF6C0C0
      C0FFBFBFBFFFC1C1C1FFAAAAAAFF515151FF4A4A4AFF9F9F9FFFB2B2B2FFB1B1
      B1FF737373EC0D0D0D6A00000007000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      000000000000000000000000000000000000000000005F5F5FCA545454CA4E4E
      4ECA4A4A4ACA4A4A4ACA4A4A4ACA474747CA474747CA494949CA474747CA4747
      47CA474747CA454545CA515151CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000606060CA555555CA4E4E
      4ECA4A4A4ACA4B4B4BCA4A4A4ACA474747CA474747CA494949CA474747CA4747
      47CA474747CA454545CA515151CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000070707703C3C3CFF535353EA6E6E6ED5818181D6858585D58E8E8EDCB4B4
      B4FBB4B4B4FE939393FF494949FF3F3F3FFF929292FFB3B3B3FF9D9D9DFF2B2B
      2BAD0000001D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF5F5F5FFF5F5F5FFF5F5
      F5FFF4F4F4FFF4F4F4FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFD9D9D9FF555555FF00000006000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000303034B222222DA3F3F3FFE5C5C5CF6696969F66D6D6DF76767
      67FB545454FF343434FD555555FF9C9C9CFFA7A7A7FF4F4F4FD50505054C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FF555555FF555555FF5555
      55FF555555FF555555FF555555FF555555FF555555FF555555FF555555FF5555
      55FF555555FF555555FF555555FF555555FF555555FF555555FF555555FF5555
      55FF555555FF555555FF00000003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000C04040457131313A5191919C1191919C21717
      17BA0A0A0A850202023D383838C36D6D6DF61212127C00000007000000000000
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
      0000000000001616168616161686161616861616168616161686161616861616
      1686161616861616168616161686323232860000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      73CA737373CA313131CA313131CA313131CA313131CA313131CA313131CA3131
      31CA313131CA313131CA737373CA737373CA0000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FF585858FF5858
      58FF585858FF585858FF585858FF585858FF585858FF585858FF585858FF5858
      58FF585858FF585858FF585858FF585858FF585858FF585858FF585858FF5858
      58FF585858FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000585858FF585858FF585858FF585858FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000777777CAC1C1C1FF828282CA848484CA818181CA777777CA787878CA7A7A
      7ACA7F7F7FCA7F7F7FCA16161686323232860000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      73CA989898CA717171CA4A4A4AFF262626FF191919FF191919FF191919FF1919
      19FF191919FF727272FF313131CA737373CA0000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FF969696FF9595
      95FF939393FF909090FF8E8E8EFF8C8C8CFF8A8A8AFF888888FF878787FF8585
      85FF848484FF838383FF828282FF808080FF7E7E7EFF7C7C7CFF7B7B7BFF7A7A
      7AFF787878FF585858FF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000585858FF000000000000
      00000000000000000000585858FFBBBBBBFFBABABAFF585858FF000000000000
      00000000000000000000585858FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000323232CA222222CA2525
      25CA252525CA232323CA232323CA232323CA232323CA232323CA232323CA2424
      24CA7E7E7ECACECECEFFD0D0D0FFD1D1D1FFC1C1C1FFACACACFFB6B6B6FFC3C3
      C3FF777777CAC9C9C9FF16161686323232860000000000000000000000000000
      00000000000000000000000000000000000000000000313131CA212121CA2525
      25CA252525CA232323CA232323CA232323CA232323CA232323CA232323CA2424
      24CAB3B3B3FFA4A4A4FF9C9C9CFF8A8A8AFF686868FF656565FF656565FF6363
      63FF626262FF2F2F2FFF313131CA737373CA0000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FF999999FF9797
      97FF969696FF949494FF919191FF8F8F8FFF8D8D8DFF8B8B8BFF898989FF8787
      87FF868686FF858585FF848484FF828282FF818181FF7E7E7EFF7D7D7DFF7B7B
      7BFF7A7A7AFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6EFFC3C3C3FF585858FF0000
      00000000000000000000585858FFBBBBBBFFBBBBBBFF585858FF000000000000
      000000000000585858FFB4B4B4FF585858FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B8FF333333FF343434FF3838
      38FF363636FF363636FF383838FF373737FF363636FF373737FF353535FF3232
      32FF818181CAD3D3D3FFD1D1D1FFC1C1C1FFA2A2A2FF878787FFA1A1A1FFBCBC
      BCFF777777CA777777CA16161686323232860000000000000000000000000000
      000000000000000000000000000000000000737373CA323232FF343434FF3737
      37FF353535FF353535FF373737FF363636FF353535FF363636FF343434FF3131
      31FF929292FFCFCFCFFF535353FF6E6E6EFF6A6A6AFF636363FF5F5F5FFF5A5A
      5AFF555555FF777777FF313131CA737373CA0000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FF9C9C9CFF9A9A
      9AFF989898FF969696FF959595FF929292FF909090FF8E8E8EFF8C8C8CFF8A8A
      8AFF888888FF878787FF858585FF848484FF828282FF828282FF808080FF7E7E
      7EFF7C7C7CFF585858FF00000000000000000000000000000000000000000000
      00000000000000000000000000006E6E6EFFC6C6C6FFC5C5C5FFC3C3C3FF5858
      58FF00000000585858FFBEBEBEFFBDBDBDFFBBBBBBFFBBBBBBFF585858FF0000
      0000585858FFB6B6B6FFB5B5B5FFB4B4B4FF585858FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF5A5A5AFF7B7B7BFF7373
      73FF828282FF797979FF757575FF717171FF6F6F6FFF6A6A6AFF5E5E5EFF7575
      75FF848484CACCCCCCFFB9B9B9FFB1B1B1FF969696FF858585FFABABABFFBEBE
      BEFFAAAAAAFF727272CA16161686323232860000000000000000000000000000
      000000000000000000000000000000000000464646CA5A5A5AFF7B7B7BFF7272
      72FF818181FF797979FF747474FF707070FF6E6E6EFF696969FF5E5E5EFF7474
      74FFBDBDBDFF6E6E6EFF818181FF5C5C5CFF333333FF333333FF323232FF3232
      32FF323232FF373737FF313131CA737373CA626262FF5F5F5FFF5F5F5FFF5F5F
      5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F
      5FFF5F5F5FFF5F5F5FFF5F5F5FFF969696FF939393FFAEAEAEFF979797FF9595
      95FF8B8B8BFF898989FF878787FF868686FF9B9B9BFF949494FF949494FF8181
      81FF7E7E7EFF585858FF00000000000000000000000000000000000000000000
      00000000000000000000000000006E6E6EFFC8C8C8FFC6C6C6FFC5C5C5FFC3C3
      C3FF585858FFC1C1C1FFBFBFBFFFBEBEBEFFBDBDBDFFBBBBBBFFBBBBBBFF5858
      58FFB8B8B8FFB7B7B7FFB6B6B6FFB5B5B5FF585858FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000666666FF5F5F5FFF848484FF7272
      72FF8E8E8EFF7C7C7CFF757575FF727272FF707070FF6B6B6BFF585858FF7E7E
      7EFF868686CAB2B2B2FFAEAEAEFFD7D7D7FFC2C2C2FF969696FFA9A9A9FFC3C3
      C3FFB7B7B7FF7E7E7ECA16161686323232860000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA5F5F5FFF838383FF7171
      71FF8E8E8EFF7C7C7CFF757575FF717171FF6F6F6FFF6A6A6AFF585858FF7E7E
      7EFF626262FFC9C9C9FF929292FFBBBBBBFF9C9C9CFF959595FF8E8E8EFF8888
      88FF818181FF414141FF313131CA737373CA626262FFC3C3C3FFBFBFBFFFB8B8
      B8FFB2B2B2FFAAAAAAFFA2A2A2FF9A9A9AFF929292FF8A8A8AFF828282FF7979
      79FF737373FF6E6E6EFF5F5F5FFF989898FF969696FFACACACFFDBDBDBFFCECE
      CEFF969696FF959595FF9E9E9EFFA8A8A8FFC7C7C7FFCFCFCFFF949494FF8282
      82FF828282FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6EFFC8C8C8FFC6C6C6FFC5C5
      C5FFC3C3C3FFC2C2C2FFC1C1C1FFBFBFBFFFBEBEBEFFBDBDBDFFBBBBBBFFBBBB
      BBFFBABABAFFB8B8B8FFB7B7B7FF585858FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006A6A6AFF6F6F6FFF8C8C8CFF7575
      75FF676767FF6A6A6AFF717171FF737373FF747474FF6E6E6EFF606060FF5757
      57FF8A8A8ACAC4C4C4FFC0C0C0FFC8C8C8FFDADADAFFA8A8A8FFA8A8A8FFA9A9
      A9FFB9B9B9FF7F7F7FCA16161686323232860000000000000000000000000000
      000000000000000000000000000000000000424242CA6F6F6FFF8C8C8CFF7474
      74FF666666FF6A6A6AFF707070FF727272FF737373FF6E6E6EFF5F5F5FFF5757
      57FFCECECEFF929292FF3D3D3DFF202020FF090909FF090909FF090909FF0909
      09FF090909FF666666FF313131CA737373CA626262FFC4C4C4FFBFBFBFFFBABA
      BAFFB3B3B3FFACACACFFA5A5A5FF9B9B9BFF939393FF8B8B8BFF838383FF7B7B
      7BFF747474FF6E6E6EFF5F5F5FFF9B9B9BFF9B9B9BFFA4A4A4FFD6D6D6FFDCDC
      DCFFDADADAFFC7C7C7FFC5C5C5FFD4D4D4FFD3D3D3FFCCCCCCFF999999FF8787
      87FF838383FF585858FF00000000000000000000000000000000000000000000
      0000585858FF585858FF00000000000000006E6E6EFFC9C9C9FFC8C8C8FFC6C6
      C6FFC5C5C5FFC3C3C3FFC2C2C2FFC1C1C1FFBFBFBFFFB4B4B4FFB2B2B2FFB1B1
      B1FFB0B0B0FFBABABAFFB8B8B8FF585858FF0000000000000000585858FF5858
      58FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF757575FF8E8E8EFF7D7D
      7DFF757575FF777777FF7A7A7AFF787878FF7A7A7AFF767676FF696969FF6464
      64FF8A8A8ACAD8D8D8FFBFBFBFFFC0C0C0FFD9D9D9FFADADADFF7E7E7EFF8989
      89FFA5A5A5FF797979CA16161686323232860000000000000000000000000000
      000000000000000000000000000000000000454545CA757575FF8E8E8EFF7D7D
      7DFF747474FF767676FF797979FF787878FF797979FF757575FF696969FF6363
      63FF828282FF949494FF878787FF7C7C7CFF353535FF333333FF313131FF3030
      30FF2D2D2DFF1E1E1EFF313131CA737373CA626262FFC5C5C5FFC1C1C1FFBBBB
      BBFFB5B5B5FFAEAEAEFFA5A5A5FF9E9E9EFF969696FF8D8D8DFF858585FF7C7C
      7CFF767676FF6F6F6FFF5F5F5FFF9E9E9EFF9C9C9CFFA3A3A3FFD1D1D1FFDCDC
      DCFFDADADAFFDADADAFFD8D8D8FFD4D4D4FFD3D3D3FFC8C8C8FF9F9F9FFF8686
      86FF858585FF585858FF00000000000000000000000000000000000000006E6E
      6EFFD0D0D0FFCFCFCFFF585858FF585858FFCCCCCCFFCBCBCBFFC9C9C9FFC8C8
      C8FFC6C6C6FFC5C5C5FFC3C3C3FFC2C2C2FFB6B6B6FFA0A0A0FFA0A0A0FF9F9F
      9FFFA9A9A9FFB0B0B0FFBABABAFFB8B8B8FF585858FF585858FFB5B5B5FFB4B4
      B4FF585858FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6EFF494949FF585858FF5E5E
      5EFF5A5A5AFF626262FF737373FF656565FF5F5F5FFF494949FF363636FF3131
      31FF878787CADDDDDDFFC3C3C3FFD4D4D4FFD6D6D6FF868686FF8B8B8BFFA7A7
      A7FFBDBDBDFF787878CA16161686323232860000000000000000000000000000
      000000000000000000000000000000000000444444CA494949FF585858FF5E5E
      5EFF5A5A5AFF616161FF727272FF646464FF5F5F5FFF494949FF353535FF3030
      30FF929292FFCECECEFF4D4D4DFF818181FF767676FF6C6C6CFF666666FF6161
      61FF575757FF353535FF313131CA737373CA626262FF626262FF626262FF6262
      62FF626262FF626262FF626262FF626262FF626262FF626262FF626262FF6262
      62FF626262FF626262FF626262FFA1A1A1FF9F9F9FFFA8A8A8FFC9C9C9FFE0E0
      E0FFDCDCDCFFDADADAFFD7D7D7FFD6D6D6FFD6D6D6FFC0C0C0FFA3A3A3FF8989
      89FF878787FF585858FF000000000000000000000000000000006E6E6EFFD3D3
      D3FFD2D2D2FFD0D0D0FFCFCFCFFFCECECEFFCDCDCDFFCCCCCCFFCBCBCBFFC9C9
      C9FFC8C8C8FFC6C6C6FFC5C5C5FFC3C3C3FFC2C2C2FFC1C1C1FFBFBFBFFF8B8B
      8BFF8A8A8AFFA9A9A9FFB0B0B0FFBABABAFFB8B8B8FFB7B7B7FFB6B6B6FFB5B5
      B5FFB4B4B4FF585858FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000666666FF535353FFB7B7B7FF9898
      98FF979797FF9C9C9CFFA1A1A1FF9F9F9FFF9D9D9DFF999999FF959595FF9595
      95FF828282CAD9D9D9FFCECECEFFB2B2B2FFAFAFAFFFBABABAFFCACACAFFCCCC
      CCFFC6C6C6FF777777CA16161686323232860000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA515151FFB6B6B6FF9797
      97FF969696FF9C9C9CFFA1A1A1FF9F9F9FFF9D9D9DFF989898FF949494FF9494
      94FFC0C0C0FF525252FF5F5F5FFF8A8A8AFF3F3F3FFF272727FF272727FF2626
      26FF323232FFA9A9A9FF737373CA000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFAFAFAFFFADAD
      ADFFAAAAAAFFA8A8A8FFA6A6A6FFA4A4A4FFA2A2A2FFA6A6A6FFDADADAFFE4E4
      E4FFDFDFDFFFDCDCDCFFD9D9D9FFD7D7D7FFD7D7D7FFCBCBCBFF959595FF8C8C
      8CFF8A8A8AFF585858FF00000000000000000000000000000000000000006E6E
      6EFFD3D3D3FFD2D2D2FFD0D0D0FFCFCFCFFFCECECEFFCDCDCDFFCCCCCCFFCBCB
      CBFFC9C9C9FFC8C8C8FF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFFC1C1C1FFBFBF
      BFFFBEBEBEFF7B7B7BFFA9A9A9FFB0B0B0FFBABABAFFB8B8B8FFB7B7B7FFB6B6
      B6FF6E6E6EFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF767676FF808080FF1515
      15FF1C1C1CFF1C1C1CFF1B1B1BFF1C1C1CFF1D1D1DFF1C1C1CFF1C1C1CFF1E1E
      1EFF818181CA848484CA868686CA7B7B7BCA818181CA838383CA818181CA7E7E
      7ECA797979CA767676CA00000000000000000000000000000000000000000000
      0000000000000000000000000000000000003E3E3ECA757575FF808080FF1414
      14FF1C1C1CFF1C1C1CFF1B1B1BFF1C1C1CFF1D1D1DFF1C1C1CFF1C1C1CFF1E1E
      1EFF3F3F3FFF2C2C2CFF535353FF434343FF282828FF272727FF272727FF2727
      27FFA8A8A8FF737373CA00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFB1B1B1FFB0B0
      B0FFAEAEAEFFABABABFFA9A9A9FFA7A7A7FFA5A5A5FFDCDCDCFFEBEBEBFFE6E6
      E6FFE4E4E4FFE1E1E1FFDCDCDCFFDADADAFFD7D7D7FFD8D8D8FFC9C9C9FF9595
      95FF8D8D8DFF585858FF00000000000000000000000000000000000000000000
      00006E6E6EFFD3D3D3FFD2D2D2FFD0D0D0FFCFCFCFFFCECECEFFCDCDCDFFCCCC
      CCFFCBCBCBFF7E7E7EFF000000000000000000000000000000007E7E7EFFC1C1
      C1FFBFBFBFFFBEBEBEFF7B7B7BFFA9A9A9FFB0B0B0FFBABABAFFB8B8B8FF6E6E
      6EFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF767676FFDDDDDDFFE4E4
      E4FFF5F5F5FFF5F5F5FFF4F4F4FFF5F5F5FFF4F4F4FFF5F5F5FFF5F5F5FFE9E9
      E9FFDFDFDFFFD7D7D7FF808080FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003E3E3ECA757575FFDDDDDDFFE3E3
      E3FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF3F3F3FFF4F4F4FFF4F4F4FFE8E8
      E8FFDFDFDFFFD6D6D6FF808080FF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFB5B5B5FFB2B2
      B2FFB1B1B1FFAFAFAFFFACACACFFA9A9A9FFDFDFDFFFF3F3F3FFEDEDEDFFEBEB
      EBFFE8E8E8FFE5E5E5FFE1E1E1FFDCDCDCFFDADADAFFD7D7D7FFD9D9D9FFC9C9
      C9FF959595FF585858FF00000000000000000000000000000000000000000000
      0000000000006E6E6EFFD3D3D3FFD2D2D2FFD0D0D0FFCFCFCFFFCECECEFFCDCD
      CDFF7E7E7EFF0000000000000000000000000000000000000000000000007E7E
      7EFFC1C1C1FFBFBFBFFFBEBEBEFF7B7B7BFFB1B1B1FFBBBBBBFF585858FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF787878FFE2E2E2FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF4F4F4FFF5F5
      F5FFEAEAEAFFDDDDDDFF898989FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003E3E3ECA777777FFE2E2E2FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF3F3F3FFF4F4
      F4FFEAEAEAFFDDDDDDFF888888FF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFB7B7B7FFB5B5
      B5FFB3B3B3FFB1B1B1FFAEAEAEFFC7C7C7FFECECECFFEFEFEFFFF3F3F3FFF3F3
      F3FFEDEDEDFFE9E9E9FFE5E5E5FFE1E1E1FFDFDFDFFFDBDBDBFFD5D5D5FFCFCF
      CFFFB7B7B7FF919191FF00000000000000000000000000000000000000000000
      0000585858FFD6D6D6FFD4D4D4FFD3D3D3FFD2D2D2FFD0D0D0FFCFCFCFFF5858
      58FF000000000000000000000000000000000000000000000000000000000000
      00007E7E7EFFC1C1C1FFBFBFBFFF7B7B7BFFA9A9A9FFB1B1B1FFBBBBBBFF5858
      58FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF787878FFEEEEEEFFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFF5F5F5FFEEEEEEFF8A8A8AFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003E3E3ECA777777FFEEEEEEFFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4
      F4FFF4F4F4FFEEEEEEFF8A8A8AFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFBABABAFFB8B8
      B8FFB6B6B6FFB5B5B5FFBCBCBCFFB3B3B3FFADADADFFADADADFFB4B4B4FFC9C9
      C9FFF0F0F0FFEDEDEDFFE9E9E9FFE4E4E4FFBFBFBFFFACACACFFA4A4A4FFA4A4
      A4FFA7A7A7FF585858FF000000000000000000000000585858FF585858FF5858
      58FFD9D9D9FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3D3FFD2D2D2FF585858FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007E7E7EFFC1C1C1FFBFBFBFFF8A8A8AFFB2B2B2FFBBBBBBFFBBBB
      BBFF585858FF585858FF585858FF000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF787878FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF4F4F4FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3
      F3FFF5F5F5FFF5F5F5FF888888FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003E3E3ECA787878FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF3F3F3FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF3F3
      F3FFF4F4F4FFF4F4F4FF878787FF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFBEBEBEFFBBBB
      BBFFB9B9B9FFB7B7B7FFB5B5B5FFB3B3B3FFB1B1B1FFB2B2B2FFB6B6B6FFA8A8
      A8FFDCDCDCFFF3F3F3FFEEEEEEFFD2D2D2FF989898FF9E9E9EFFA0A0A0FF9B9B
      9BFF989898FF585858FF000000000000000000000000666666FFDCDCDCFFDBDB
      DBFFDADADAFFD9D9D9FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3D3FF585858FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007E7E7EFFC2C2C2FFC1C1C1FF9F9F9FFFBEBEBEFFBDBDBDFFBBBB
      BBFFBBBBBBFFBABABAFF585858FF000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF7D7D7DFFEEEEEEFFC5C5
      C5FFE0E0E0FFE0E0E0FFCACACAFFC3C3C3FFC2C2C2FFC3C3C3FFC3C3C3FFD2D2
      D2FFF5F5F5FFF5F5F5FF818181FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003E3E3ECA7D7D7DFFEEEEEEFFC4C4
      C4FFE0E0E0FFE0E0E0FFC9C9C9FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFD2D2
      D2FFF4F4F4FFF4F4F4FF808080FF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFC1C1C1FFBFBF
      BFFFBCBCBCFFBABABAFFB8B8B8FFB6B6B6FFB5B5B5FFB2B2B2FFB0B0B0FFB9B9
      B9FFB3B3B3FFF4F4F4FFEFEFEFFFA2A2A2FFA4A4A4FFA2A2A2FF9F9F9FFF9D9D
      9DFF9C9C9CFF585858FF000000000000000000000000696969FFDDDDDDFFDCDC
      DCFFDBDBDBFFDADADAFFD9D9D9FFD7D7D7FFE2E2E2FFD4D4D4FF585858FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007E7E7EFFC3C3C3FFC2C2C2FFB6B6B6FFBFBFBFFFBEBEBEFFBDBD
      BDFFBBBBBBFFBBBBBBFF585858FF000000000000000000000000000000000000
      000000000000000000000000000000000000646464FF7C7C7CFFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FF797979FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003E3E3ECA7C7C7CFFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FF797979FF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFC4C4C4FFC2C2
      C2FFC0C0C0FFBDBDBDFFBBBBBBFFB9B9B9FFB7B7B7FFB5B5B5FFB3B3B3FFB1B1
      B1FFABABABFFE3E3E3FFE0E0E0FFA9A9A9FFA6A6A6FFA5A5A5FFA3A3A3FFA0A0
      A0FF9E9E9EFF585858FF000000000000000000000000696969FF696969FF6969
      69FFDCDCDCFFDBDBDBFFDADADAFFE4E4E4FFE3E3E3FFD6D6D6FF585858FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007E7E7EFFC5C5C5FFC3C3C3FFC2C2C2FFC1C1C1FFBFBFBFFFBEBE
      BEFF6E6E6EFF6E6E6EFF6E6E6EFF000000000000000000000000000000000000
      000000000000000000000000000000000000656565FF767676FFF5F5F5FFC5C5
      C5FFC4C4C4FFCBCBCBFFF5F5F5FFF5F5F5FFC2C2C2FFC4C4C4FFC4C4C4FFC4C4
      C4FFF5F5F5FFF5F5F5FF737373FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F3F3FCA757575FFF4F4F4FFC4C4
      C4FFC3C3C3FFCBCBCBFFF4F4F4FFF4F4F4FFC2C2C2FFC3C3C3FFC3C3C3FFC3C3
      C3FFF4F4F4FFF4F4F4FF727272FF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFC5C5C5FFC4C4
      C4FFC3C3C3FFC1C1C1FFBEBEBEFFBCBCBCFFBABABAFFB8B8B8FFB6B6B6FFB4B4
      B4FFBCBCBCFFB6B6B6FFB5B5B5FFACACACFFAAAAAAFFA7A7A7FFA5A5A5FFA4A4
      A4FFA1A1A1FF585858FF00000000000000000000000000000000000000000000
      0000696969FFDCDCDCFFDBDBDBFFE5E5E5FFE7E7E7FFD7D7D7FFD6D6D6FF5858
      58FF000000000000000000000000000000000000000000000000000000000000
      00007E7E7EFFC8C8C8FFC6C6C6FFC5C5C5FFC3C3C3FFC2C2C2FFC1C1C1FF5858
      58FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000696969FF7B7B7BFFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF0F0F0FFF3F3F3FFF5F5F5FFF0F0
      F0FFF5F5F5FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000414141CA7B7B7BFFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF0F0F0FFF3F3F3FFF4F4F4FFF0F0
      F0FFF4F4F4FFF4F4F4FF6F6F6FFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFC8C8C8FFC6C6
      C6FFC4C4C4FFC4C4C4FFC2C2C2FFC0C0C0FFBDBDBDFFBBBBBBFFB9B9B9FFB7B7
      B7FFB5B5B5FFB8B8B8FFB7B7B7FFAFAFAFFFADADADFFABABABFFA8A8A8FFA6A6
      A6FFA5A5A5FF585858FF00000000000000000000000000000000000000000000
      000000000000696969FFDCDCDCFFDEDEDEFFEAEAEAFFF0F0F0FFD7D7D7FFD6D6
      D6FF585858FF0000000000000000000000000000000000000000000000005858
      58FFCBCBCBFFC9C9C9FFC8C8C8FFC6C6C6FFC5C5C5FFC3C3C3FF585858FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6F6FFF868686FFF5F5F5FFC5C5
      C5FFE0E0E0FFE0E0E0FFD2D2D2FFC3C3C3FFC3C3C3FFCACACAFFE0E0E0FFC4C4
      C4FFF5F5F5FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000454545CA858585FFF4F4F4FFC4C4
      C4FFE0E0E0FFE0E0E0FFD2D2D2FFC2C2C2FFC2C2C2FFC9C9C9FFE0E0E0FFC3C3
      C3FFF4F4F4FFF4F4F4FF6F6F6FFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFCACACAFFC9C9
      C9FFC7C7C7FFC5C5C5FFC4C4C4FFC3C3C3FFC1C1C1FFBEBEBEFFBCBCBCFFBABA
      BAFFB8B8B8FFB6B6B6FFB4B4B4FFB2B2B2FFB0B0B0FFAEAEAEFFACACACFFAAAA
      AAFFA7A7A7FF585858FF00000000000000000000000000000000000000000000
      0000696969FFDEDEDEFFDDDDDDFFDCDCDCFFE6E6E6FFFBFBFBFFE0E0E0FFD7D7
      D7FFD6D6D6FF585858FF00000000000000000000000000000000585858FFCDCD
      CDFFCCCCCCFFCBCBCBFFC9C9C9FFC8C8C8FFC6C6C6FFC5C5C5FFC3C3C3FF5858
      58FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000757575FF939393FFF3F3F3FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3F3FFF3F3F3FFF3F3
      F3FFF5F5F5FFF5F5F5FF6F6F6FFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000494949CA929292FFF3F3F3FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF3F3F3FFF3F3F3FFF3F3
      F3FFF4F4F4FFF4F4F4FF6F6F6FFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFCDCDCDFFCBCB
      CBFFA4A4A4FF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E
      7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFFADAD
      ADFFABABABFF585858FF00000000000000000000000000000000000000006969
      69FFDFDFDFFFDFDFDFFFDEDEDEFFDDDDDDFFDCDCDCFFE6E6E6FFFBFBFBFFE0E0
      E0FFD7D7D7FFD6D6D6FF585858FF585858FF585858FF585858FFCFCFCFFFCECE
      CEFFCDCDCDFFCCCCCCFFCBCBCBFFC9C9C9FFC8C8C8FFC6C6C6FFC5C5C5FFC3C3
      C3FF585858FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000757575FF949494FFF5F5F5FFBDBD
      BDFFBBBBBBFFDDDDDDFFBEBEBEFFDEDEDEFFDEDEDEFFD0D0D0FFBCBCBCFFBCBC
      BCFFF4F4F4FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000494949CA939393FFF4F4F4FFBDBD
      BDFFBBBBBBFFDDDDDDFFBEBEBEFFDEDEDEFFDEDEDEFFD0D0D0FFBCBCBCFFBCBC
      BCFFF3F3F3FFF4F4F4FF6F6F6FFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFCFCFCFFFCDCD
      CDFFA4A4A4FFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCF
      CFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFF7E7E7EFFB0B0
      B0FFAEAEAEFF585858FF00000000000000000000000000000000696969FFE1E1
      E1FFE0E0E0FFDFDFDFFFDFDFDFFFDEDEDEFFDDDDDDFFDCDCDCFFE6E6E6FFFBFB
      FBFFE7E7E7FFDFDFDFFFD6D6D6FFD4D4D4FFD3D3D3FFD2D2D2FFD0D0D0FFCFCF
      CFFFCECECEFFCDCDCDFFCCCCCCFFCBCBCBFFC9C9C9FFC8C8C8FFC6C6C6FFC5C5
      C5FFC3C3C3FF585858FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000727272FF8F8F8FFFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFF5F5F5FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000474747CA8F8F8FFFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FF6F6F6FFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD1D1D1FFD0D0
      D0FFA4A4A4FFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCF
      CFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFF7E7E7EFFB3B3
      B3FFB1B1B1FF585858FF00000000000000000000000000000000000000006969
      69FFE1E1E1FFE0E0E0FF6E6E6EFF6E6E6EFFDEDEDEFFDDDDDDFFDCDCDCFFDBDB
      DBFFFBFBFBFFF0F0F0FFE3E3E3FFDEDEDEFFE1E1E1FFD3D3D3FFD2D2D2FFD0D0
      D0FFCFCFCFFFCECECEFFCDCDCDFFCCCCCCFF6E6E6EFF6E6E6EFFC8C8C8FFC6C6
      C6FF6E6E6EFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6DFF888888FFF5F5F5FFF5F5
      F5FFF4F4F4FFF3F3F3FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3F3FFF3F3F3FFF4F4
      F4FFF4F4F4FFF5F5F5FF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000444444CA878787FFF4F4F4FFF4F4
      F4FFF3F3F3FFF2F2F2FFF4F4F4FFF4F4F4FFF4F4F4FFF2F2F2FFF2F2F2FFF3F3
      F3FFF3F3F3FFF4F4F4FF6F6F6FFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD3D3D3FFD2D2
      D2FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFB6B6
      B6FFB4B4B4FF585858FF00000000000000000000000000000000000000000000
      0000696969FF696969FF00000000000000006E6E6EFFDEDEDEFFDDDDDDFFDCDC
      DCFFDBDBDBFFDADADAFFE3E3E3FFE3E3E3FFD6D6D6FFD4D4D4FFD3D3D3FFD2D2
      D2FFD0D0D0FFCFCFCFFFCECECEFF585858FF00000000000000006E6E6EFF6E6E
      6EFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6EFF868686FFDFDFDFFFEDED
      EDFFE5E5E5FFE1E1E1FFE1E1E1FFE4E4E4FFDFDFDFFFE0E0E0FFDFDFDFFFBCBC
      BCFFBFBFBFFFEBEBEBFF707070FF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000444444CA858585FFDFDFDFFFECEC
      ECFFE4E4E4FFE1E1E1FFE1E1E1FFE3E3E3FFDFDFDFFFE0E0E0FFDFDFDFFFBCBC
      BCFFBEBEBEFFEBEBEBFF6F6F6FFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD5D5D5FFD4D4
      D4FFD3D3D3FFD1D1D1FFD0D0D0FFCECECEFFCDCDCDFFCBCBCBFFC9C9C9FFC8C8
      C8FFC6C6C6FFC4C4C4FFC3C3C3FFC1C1C1FFBFBFBFFFBDBDBDFFBBBBBBFFB9B9
      B9FFB7B7B7FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6EFFDFDFDFFFDEDEDEFFDDDD
      DDFFDCDCDCFFDBDBDBFFDADADAFFD9D9D9FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3
      D3FFD2D2D2FFD0D0D0FFCFCFCFFF585858FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000747474FF888888FFD6D6D6FFD1D1
      D1FFBCBCBCFFAFAFAFFFA8A8A8FFA9A9A9FF9E9E9EFFA9A9A9FFA3A3A3FFA2A2
      A2FF4F4F4FFFCACACAFF6F6F6FFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000484848CA878787FFD6D6D6FFD0D0
      D0FFBCBCBCFFAFAFAFFFA7A7A7FFA8A8A8FF9D9D9DFFA8A8A8FFA2A2A2FFA1A1
      A1FF4F4F4FFFC9C9C9FF6F6F6FFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD7D7D7FFD6D6
      D6FFD4D4D4FFD3D3D3FFD2D2D2FFD1D1D1FFCFCFCFFFCDCDCDFFCCCCCCFFCACA
      CAFFC8C8C8FFC6C6C6FFC4C4C4FFC4C4C4FFC2C2C2FFC0C0C0FFBEBEBEFFBCBC
      BCFFBABABAFF585858FF00000000000000000000000000000000000000000000
      00000000000000000000000000006E6E6EFFE0E0E0FFDFDFDFFFDFDFDFFFDEDE
      DEFF6E6E6EFFDCDCDCFFDBDBDBFFDADADAFFD9D9D9FFD7D7D7FFD6D6D6FF6E6E
      6EFFD3D3D3FFD2D2D2FFD0D0D0FFCFCFCFFF585858FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000838383FF929292FFE4E4E4FFDADA
      DAFFDCDCDCFFDDDDDDFFD9D9D9FFD5D5D5FFD0D0D0FFC9C9C9FFC4C4C4FFC1C1
      C1FFBDBDBDFFD4D4D4FF6F6F6FFF3F3F3FCA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000505050CA919191FFE3E3E3FFDADA
      DAFFDCDCDCFFDDDDDDFFD9D9D9FFD4D4D4FFD0D0D0FFC9C9C9FFC3C3C3FFC0C0
      C0FFBDBDBDFFD3D3D3FF6F6F6FFF3E3E3ECA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD9D9D9FFD8D8
      D8FFD6D6D6FFD5D5D5FFD3D3D3FFD3D3D3FFD1D1D1FFD0D0D0FFCECECEFFCCCC
      CCFFCBCBCBFFC9C9C9FFC7C7C7FFC5C5C5FFC4C4C4FFC3C3C3FFC1C1C1FFBFBF
      BFFFBDBDBDFF585858FF00000000000000000000000000000000000000000000
      00000000000000000000000000006E6E6EFFE1E1E1FFE0E0E0FFDFDFDFFF6E6E
      6EFF000000006E6E6EFFDCDCDCFFDBDBDBFFDADADAFFD9D9D9FF585858FF0000
      00006E6E6EFFD3D3D3FFD2D2D2FFD0D0D0FF585858FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008E8E8EFF828282FF9B9B9BFF9292
      92FF919191FF919191FF8B8B8BFF828282FF7A7A7AFF767676FF6C6C6CFF6868
      68FF5D5D5DFF585858FF383838FF454545CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000585858CA818181FF9B9B9BFF9191
      91FF919191FF919191FF8B8B8BFF818181FF7A7A7AFF757575FF6C6C6CFF6767
      67FF5D5D5DFF585858FF383838FF454545CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFDBDBDBFFD9D9
      D9FFD8D8D8FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3D3FFD2D2D2FFD0D0D0FFCFCF
      CFFFCDCDCDFFCCCCCCFFCACACAFFC8C8C8FFC6C6C6FFC4C4C4FFC4C4C4FFC2C2
      C2FFC0C0C0FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6EFFE1E1E1FF6E6E6EFF0000
      000000000000000000006E6E6EFFDCDCDCFFDBDBDBFF585858FF000000000000
      0000000000006E6E6EFFD3D3D3FF6E6E6EFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AAAAAAFF757575FF7E7E7EFF6A6A
      6AFF616161FF646464FF595959FF4E4E4EFF4E4E4EFF4F4F4FFF474747FF4545
      45FF444444FF424242FF3A3A3AFF646464CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006A6A6ACA757575FF7E7E7EFF6A6A
      6AFF606060FF636363FF595959FF4E4E4EFF4E4E4EFF4F4F4FFF474747FF4545
      45FF434343FF414141FF3A3A3AFF646464CA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFDCDCDCFFDBDB
      DBFFDADADAFFD9D9D9FFD8D8D8FFD6D6D6FFD5D5D5FFD3D3D3FFD3D3D3FFD1D1
      D1FFD0D0D0FFCECECEFFCCCCCCFFCBCBCBFFC9C9C9FFC7C7C7FFC5C5C5FFC4C4
      C4FFC3C3C3FF585858FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006E6E6EFF000000000000
      000000000000000000006E6E6EFFDDDDDDFFDCDCDCFF585858FF000000000000
      000000000000000000006E6E6EFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009A9A9AFF888888FF7C7C
      7CFF767676FF787878FF767676FF737373FF737373FF747474FF737373FF7272
      72FF737373FF6F6F6FFF838383FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005F5F5FCA545454CA4E4E
      4ECA4A4A4ACA4A4A4ACA4A4A4ACA474747CA474747CA484848CA474747CA4747
      47CA474747CA454545CA505050CA000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF000000000000
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
      0000000000000000000000000000595959FF595959FF595959FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000030000000B00000013000000160000001600000016000000160000
      0016000000160000001600000016000000160000001600000016000000160000
      0016000000160000001600000016000000160000001600000016000000160000
      0016000000130000000B00000003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000595959FF000000000000000000000000595959FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008D8D8DFFC0C0C0FFBDBDBDFFBABABAFF8D8D8DFF585858FF5858
      58FF585858FF585858FF585858FF585858FF585858FF585858FF585858FF5858
      58FF585858FF585858FF585858FF585858FF585858FF585858FF585858FF5858
      58FF585858FF585858FF00000000000000000000000000000000000000000000
      00000000000000000000A5A5A5FF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFFB6B6B6FFB6B6
      B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6
      B6FFB6B6B6FF0000000000000000000000000000000000000000000000000000
      0003000000110000002300000030000000350000003500000035000000350000
      0035000000350000003500000035000000350000003500000035000000350000
      0035000000350000003500000035000000350000003500000035000000350000
      0035000000300000002300000011000000030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000595959FF000000000000000000000000595959FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008D8D8DFFC3C3C3FFC0C0C0FFBDBDBDFF8D8D8DFF969696FF9494
      94FF939393FF909090FF8E8E8EFF8C8C8CFF8A8A8AFF898989FF888888FF8686
      86FF848484FF838383FF818181FF808080FF7E7E7EFF7C7C7CFF7B7B7BFF7A7A
      7AFF797979FF585858FF00000000000000000000000000000000000000000000
      00000000000000000000A5A5A5FFDADADAFFD8D8D8FFD6D6D6FFD4D4D4FFD2D2
      D2FFD0D0D0FFCFCFCFFFCDCDCDFFCBCBCBFFC9C9C9FF6D6D6DFFCECECEFFCECE
      CEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECE
      CEFFB6B6B6FF0000000000000000000000000000000000000000000000030000
      001500000051555555FF555555FF555555FF555555FF555555FF555555FF5959
      59FF595959FF595959FF595959FF585858FF595959FF595959FF595959FF5959
      59FF595959FF595959FF555555FF555555FF555555FF555555FF555555FF5555
      55FF555555FF000000710000001D000000080000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000595959FF000000000000000000000000595959FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008D8D8DFFC5C5C5FFC3C3C3FFC0C0C0FF8D8D8DFF999999FF9797
      97FF959595FF939393FF919191FF8F8F8FFF8D8D8DFF8B8B8BFF8A8A8AFF8888
      88FF878787FF858585FF848484FF818181FF808080FF7E7E7EFF7D7D7DFF7B7B
      7BFF7A7A7AFF585858FF00000000000000000000000000000000000000000000
      00000000000000000000A5A5A5FFDBDBDBFFD9D9D9FFD7D7D7FFD5D5D5FFD3D3
      D3FFD1D1D1FFCFCFCFFFCFCFCFFFCDCDCDFFCBCBCBFF6D6D6DFF595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FFCECECEFFCECE
      CEFFB6B6B6FF0000000000000000000000000000000000000000000000080000
      0046555555FF6B6B6BFF6B6B6BFF6B6B6BFF555555FFE5E5E5FFE5E5E5FFE5E5
      E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5
      E5FFE5E5E5FF555555FF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B
      6BFF6B6B6BFF555555FF000000260000000B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000595959FF595959FF595959FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008D8D8DFFC8C8C8FFC5C5C5FFC3C3C3FF8D8D8DFF9C9C9CFF9A9A
      9AFF989898FF969696FF949494FF929292FF909090FF8E8E8EFF8C8C8CFF8A8A
      8AFF898989FF888888FF868686FF848484FF828282FF818181FF808080FF7E7E
      7EFF7C7C7CFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFDADADAFFD8D8D8FFD6D6D6FFD4D4
      D4FFD2D2D2FFD0D0D0FFCFCFCFFFCECECEFFCCCCCCFF6D6D6DFF979797FF9595
      95FF939393FF939393FF919191FF909090FF8E8E8EFF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FF555555FFE5E5E5FFD6D6D6FF5555
      55FF555555FF555555FF555555FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6
      D6FFE5E5E5FF555555FF6B6B6BFF6B6B6BFF6B6B6BFF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000595959FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7A7A7FF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8D8D8DFFCBCBCBFFC8C8C8FFC5C5C5FF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF959595FF939393FFAEAEAEFF979797FF9696
      96FF8B8B8BFF8A8A8AFF888888FF878787FF9B9B9BFF949494FF949494FF8080
      80FF7E7E7EFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FF6D6D6DFFDADADAFFD7D7D7FFD5D5
      D5FFD3D3D3FF6D6D6DFF6D6D6DFFCFCFCFFFCDCDCDFF6D6D6DFF9B9B9BFF9999
      99FF969696FF959595FF939393FF929292FF919191FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FF555555FFE5E5E5FFD6D6D6FF5555
      55FFA3A3A3FFA3A3A3FF555555FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6
      D6FFE5E5E5FF555555FF6B6B6BFF6B6B6BFF6B6B6BFF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B0000000000000000595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF0000000000000000A7A7A7FFDCDCDCFFDADADAFFD7D7
      D7FFD4D4D4FFD1D1D1FFCECECEFFCBCBCBFFC8C8C8FFC5C5C5FFC3C3C3FFC0C0
      C0FFBDBDBDFFBABABAFF8D8D8DFF989898FF969696FFACACACFFDCDCDCFFCECE
      CEFF969696FF969696FF9E9E9EFFA8A8A8FFC6C6C6FFD0D0D0FF949494FF8282
      82FF818181FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFDDDDDDFF6D6D6DFFD9D9D9FFD7D7
      D7FFA5A5A5FFD2D2D2FFD0D0D0FF6D6D6DFFCECECEFF6D6D6DFF9F9F9FFF9C9C
      9CFF9A9A9AFF989898FF969696FF949494FF939393FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FF555555FFE5E5E5FFD6D6D6FF5555
      55FFA3A3A3FFA3A3A3FF555555FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6
      D6FFE5E5E5FF555555FF6B6B6BFF6B6B6BFF6B6B6BFF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B0000000000000000A5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FF0000000000000000A7A7A7FFDFDFDFFFDCDCDCFFDADA
      DAFFD7D7D7FFD4D4D4FFD1D1D1FFCECECEFFCBCBCBFFC8C8C8FFC5C5C5FFC3C3
      C3FFC0C0C0FFBDBDBDFF8D8D8DFF9B9B9BFF9B9B9BFFA4A4A4FFD6D6D6FFDDDD
      DDFFDADADAFFC7C7C7FFC5C5C5FFD4D4D4FFD3D3D3FFCCCCCCFF999999FF8888
      88FF838383FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFDEDEDEFF6D6D6DFFDADADAFFD8D8
      D8FFA5A5A5FFD4D4D4FFD2D2D2FF6D6D6DFFCFCFCFFF6D6D6DFFA2A2A2FFA0A0
      A0FF9E9E9EFF9C9C9CFF999999FF979797FF959595FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FF555555FFE5E5E5FFD6D6D6FF5555
      55FFA3A3A3FFA3A3A3FF555555FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6
      D6FFE5E5E5FF555555FF6B6B6BFF6B6B6BFF6B6B6BFF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFE5E5E5FFE3E3E3FFE2E2E2FFE0E0E0FFDFDFDFFFDEDEDEFFB5B5B5FFDCDC
      DCFFB5B5B5FFB4B4B4FFB4B4B4FFB4B4B4FFB4B4B4FFB4B4B4FFB4B4B4FFB5B5
      B5FFB5B5B5FFCFCFCFFFCFCFCFFFCECECEFFCDCDCDFFCCCCCCFFCCCCCCFFCBCB
      CBFF979797FF000000000000000000000000A7A7A7FFE1E1E1FFDFDFDFFFDCDC
      DCFFDADADAFFD7D7D7FFD4D4D4FFD1D1D1FFCECECEFFCBCBCBFFC8C8C8FFC5C5
      C5FFC3C3C3FFC0C0C0FF8D8D8DFF9E9E9EFF9C9C9CFFA3A3A3FFD2D2D2FFDDDD
      DDFFDADADAFFDADADAFFD8D8D8FFD4D4D4FFD3D3D3FFC8C8C8FF9F9F9FFF8787
      87FF868686FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFDFDFDFFF6D6D6DFFDBDBDBFFD9D9
      D9FFA5A5A5FFD5D5D5FFD3D3D3FF6D6D6DFFCFCFCFFF6D6D6DFFA6A6A6FFA3A3
      A3FFA2A2A2FFA0A0A0FF9D9D9DFF9B9B9BFF999999FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FF555555FFE5E5E5FFD6D6D6FF5555
      55FFA3A3A3FFA3A3A3FF555555FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6
      D6FFE5E5E5FF555555FF6B6B6BFF6B6B6BFF6B6B6BFF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFE6E6E6FFE5E5E5FFE3E3E3FFE2E2E2FFE0E0E0FFDFDFDFFFDDDDDDFFDCDC
      DCFFDCDCDCFFDADADAFFD9D9D9FFD7D7D7FFD6D6D6FFD5D5D5FFD3D3D3FFD2D2
      D2FFD1D1D1FFD0D0D0FFCFCFCFFFCFCFCFFFCECECEFFCDCDCDFFCCCCCCFFCCCC
      CCFF979797FF000000000000000000000000A7A7A7FFA7A7A7FFA7A7A7FFA7A7
      A7FFA7A7A7FFA7A7A7FFD7D7D7FFD4D4D4FFD1D1D1FF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFFA1A1A1FF9F9F9FFFA9A9A9FFC9C9C9FFE0E0
      E0FFDCDCDCFFDADADAFFD7D7D7FFD6D6D6FFD6D6D6FFC2C2C2FFA2A2A2FF8A8A
      8AFF888888FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFDFDFDFFF6D6D6DFFDCDCDCFFDADA
      DAFFA5A5A5FFD6D6D6FFD4D4D4FF6D6D6DFFD0D0D0FF6D6D6DFFAAAAAAFFA7A7
      A7FFA5A5A5FFA3A3A3FFA1A1A1FF9F9F9FFF9D9D9DFF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FF555555FFE5E5E5FFD6D6D6FF5555
      55FF555555FF555555FF555555FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6
      D6FFE5E5E5FF555555FF6B6B6BFF6B6B6BFF6B6B6BFF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFE8E8E8FFE6E6E6FFE5E5E5FFE3E3E3FFE2E2E2FFE0E0E0FFB5B5B5FFDDDD
      DDFFB4B4B4FFB4B4B4FFB4B4B4FFB4B4B4FFB4B4B4FFB4B4B4FFB4B4B4FFB4B4
      B4FFB4B4B4FFB4B4B4FFB4B4B4FFB4B4B4FFB5B5B5FFCECECEFFCDCDCDFFCCCC
      CCFF979797FF0000000000000000000000000000000000000000000000000000
      000000000000A7A7A7FFDADADAFFD7D7D7FFD4D4D4FF8D8D8DFFAFAFAFFFADAD
      ADFFAAAAAAFFA9A9A9FFA7A7A7FFA4A4A4FFA2A2A2FFA6A6A6FFD9D9D9FFE4E4
      E4FFE0E0E0FFDDDDDDFFD9D9D9FFD7D7D7FFD7D7D7FFCBCBCBFF959595FF8C8C
      8CFF8A8A8AFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE0E0E0FF6D6D6DFFDDDDDDFFDBDB
      DBFFA5A5A5FFD7D7D7FFD5D5D5FF6D6D6DFFD1D1D1FF6D6D6DFFAFAFAFFFACAC
      ACFFA9A9A9FFA7A7A7FFA5A5A5FFA2A2A2FFA1A1A1FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FF555555FFE5E5E5FFE5E5E5FFE5E5
      E5FFE5E5E5FFE0E0E0FFE4E4E4FFE6E6E6FFE5E5E5FFE2E2E2FFDFDFDFFFE5E5
      E5FFE5E5E5FF555555FF6B6B6BFF6B6B6BFF515151FF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFE9E9E9FFE8E8E8FFE6E6E6FFE5E5E5FFE3E3E3FFE2E2E2FFE0E0E0FFDFDF
      DFFFDDDDDDFFDCDCDCFFDBDBDBFFDADADAFFD9D9D9FFD7D7D7FFD6D6D6FFD5D5
      D5FFD3D3D3FFD2D2D2FFD1D1D1FFD0D0D0FFCFCFCFFFCFCFCFFFCECECEFFCDCD
      CDFF979797FF0000000000000000000000000000000000000000000000000000
      000000000000A7A7A7FFDCDCDCFFDADADAFFD7D7D7FF8D8D8DFFB1B1B1FFB0B0
      B0FFADADADFFABABABFFA9A9A9FFA8A8A8FFA5A5A5FFDCDCDCFFECECECFFE6E6
      E6FFE4E4E4FFE1E1E1FFDDDDDDFFDADADAFFD7D7D7FFD8D8D8FFC9C9C9FF9595
      95FF8D8D8DFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE1E1E1FF6D6D6DFFDEDEDEFFDDDD
      DDFFA5A5A5FFD9D9D9FFD7D7D7FF6D6D6DFFD2D2D2FF6D6D6DFFB3B3B3FFB1B1
      B1FFAEAEAEFFABABABFFA8A8A8FFA6A6A6FFA4A4A4FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FF515151FF555555FF555555FF5555
      55FF555555FF565656FF565656FF565656FF565656FF565656FF565656FF5555
      55FF555555FF515151FF515151FF515151FF515151FF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFEAEAEAFFE9E9E9FFE7E7E7FFE6E6E6FFE5E5E5FFE3E3E3FFB5B5B5FFE0E0
      E0FFB7B7B7FFB7B7B7FFB6B6B6FFB5B5B5FFB5B5B5FFB4B4B4FFB4B4B4FFB3B3
      B3FFB3B3B3FFB2B2B2FFB2B2B2FFD1D1D1FFD0D0D0FFCFCFCFFFCFCFCFFFCECE
      CEFF979797FF0000000000000000000000000000000000000000000000000000
      000000000000A7A7A7FFDFDFDFFFDCDCDCFFDADADAFF8D8D8DFFB5B5B5FFB2B2
      B2FFB1B1B1FFAFAFAFFFACACACFFA8A8A8FFDFDFDFFFF3F3F3FFEDEDEDFFEBEB
      EBFFE8E8E8FFE5E5E5FFE1E1E1FFDDDDDDFFDADADAFFD7D7D7FFD9D9D9FFC9C9
      C9FF959595FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE2E2E2FF6D6D6DFFDFDFDFFFDEDE
      DEFFA5A5A5FFDADADAFFD8D8D8FF6D6D6DFFD4D4D4FF6D6D6DFFB8B8B8FFB5B5
      B5FFB3B3B3FFB0B0B0FFADADADFFAAAAAAFFA8A8A8FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FF515151FF515151FF515151FF5151
      51FF515151FF515151FF515151FF515151FF515151FF515151FF515151FF5151
      51FF515151FF515151FF515151FF515151FF515151FF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFECECECFFEAEAEAFFE9E9E9FFE7E7E7FFE6E6E6FFE5E5E5FFE3E3E3FFE2E2
      E2FFE0E0E0FFDFDFDFFFDDDDDDFFDCDCDCFFDBDBDBFFDADADAFFD9D9D9FFD7D7
      D7FFD6D6D6FFD5D5D5FFD3D3D3FFD2D2D2FFD1D1D1FFD0D0D0FFCFCFCFFFCFCF
      CFFF979797FF0000000000000000000000000000000000000000000000000000
      000000000000A7A7A7FFE1E1E1FFDFDFDFFFDCDCDCFF8D8D8DFFB8B8B8FFB6B6
      B6FFB3B3B3FFB1B1B1FFAEAEAEFFC7C7C7FFECECECFFEFEFEFFFF3F3F3FFF3F3
      F3FFEDEDEDFFE9E9E9FFE5E5E5FFE1E1E1FFE0E0E0FFDBDBDBFFD5D5D5FFD0D0
      D0FFB7B7B7FF919191FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE3E3E3FF6D6D6DFFE0E0E0FFDFDF
      DFFFA5A5A5FFDBDBDBFFD9D9D9FF6D6D6DFFD5D5D5FF6D6D6DFFBBBBBBFFBABA
      BAFFB7B7B7FFB4B4B4FFB2B2B2FFAFAFAFFFACACACFF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FF515151FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3
      A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3
      A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FF515151FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFECECECFFECECECFFEAEAEAFFE9E9E9FFE7E7E7FFE6E6E6FFE4E4E4FFE3E3
      E3FFE2E2E2FFE0E0E0FFDFDFDFFFDDDDDDFFDCDCDCFFDBDBDBFFDADADAFFD8D8
      D8FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3D3FFD2D2D2FFD1D1D1FFD0D0D0FFCFCF
      CFFF979797FF0000000000000000000000000000000000000000000000000000
      000000000000A7A7A7FFA7A7A7FFA7A7A7FFA7A7A7FFA7A7A7FFBABABAFFB9B9
      B9FFB7B7B7FFB5B5B5FFBCBCBCFFB2B2B2FFACACACFFACACACFFB5B5B5FFC9C9
      C9FFF0F0F0FFEEEEEEFFE9E9E9FFE4E4E4FFBEBEBEFFACACACFFA4A4A4FFA5A5
      A5FFA8A8A8FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE4E4E4FF6D6D6DFFE1E1E1FFDFDF
      DFFFA5A5A5FFDCDCDCFFDADADAFF6D6D6DFFD6D6D6FF6D6D6DFFC0C0C0FFBDBD
      BDFFBBBBBBFFB9B9B9FFB6B6B6FFB3B3B3FFB1B1B1FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFA3A3A3FFC1C1C1FFC1C1C1FFBEBE
      BEFFB0B0B0FF979797FF8A8A8AFF959595FFACACACFFBCBCBCFFC1C1C1FFC1C1
      C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFA3A3A3FFA3A3A3FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFEDEDEDFFECECECFFECECECFFEAEAEAFFE9E9E9FFE7E7E7FFA5A5A5FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF595959FF595959FF595959FFD4D4D4FFD3D3D3FFD2D2D2FFD1D1D1FFD0D0
      D0FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFBEBEBEFFBBBB
      BBFFB9B9B9FFB8B8B8FFB6B6B6FFB3B3B3FFB1B1B1FFB2B2B2FFB7B7B7FFA9A9
      A9FFDCDCDCFFF3F3F3FFEFEFEFFFD3D3D3FF999999FF9E9E9EFFA0A0A0FF9B9B
      9BFF989898FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE5E5E5FF6D6D6DFFE2E2E2FFE0E0
      E0FFA5A5A5FFDDDDDDFFDBDBDBFF6D6D6DFFD7D7D7FF6D6D6DFFC4C4C4FFC2C2
      C2FFBFBFBFFFBDBDBDFFBABABAFFB8B8B8FFB5B5B5FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFC1C1C1FFD0D0D0FFC9C9
      C9FFAEAEAEFF838383FF6A6A6AFF777777FF9A9A9AFFB9B9B9FFCACACAFFD0D0
      D0FFD0D0D0FFD0D0D0FFD0D0D0FFC1C1C1FFC1C1C1FFA3A3A3FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFEFEFEFFFEDEDEDFFECECECFFECECECFFEAEAEAFFE9E9E9FFA5A5A5FFE4E4
      E4FFE5E5E5FFA2A2A2FF5D5D5DFF595959FF5B5B5BFFD3D3D3FFE7E7E7FFBBBB
      BBFF747474FFB0B0B0FF595959FFD6D6D6FFD4D4D4FFD3D3D3FFD2D2D2FFD1D1
      D1FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFC0C0C0FFBFBF
      BFFFBCBCBCFFBABABAFFB9B9B9FFB7B7B7FFB4B4B4FFB2B2B2FFB0B0B0FFB9B9
      B9FFB3B3B3FFF4F4F4FFF0F0F0FFA2A2A2FFA4A4A4FFA2A2A2FF9F9F9FFF9D9D
      9DFF9C9C9CFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE6E6E6FF6D6D6DFFE3E3E3FFE1E1
      E1FFA5A5A5FFDEDEDEFFDCDCDCFF6D6D6DFFD8D8D8FF6D6D6DFF7E7E7EFF7E7E
      7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFFBABABAFF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFD0D0D0FFD0D0D0FFC4C4
      C4FFA1A1A1FF868686FF515151FF575757FF757575FF9A9A9AFFB9B9B9FFCACA
      CAFFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFC1C1C1FFA3A3A3FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF0F0F0FFEFEFEFFFEDEDEDFFECECECFFEBEBEBFFEAEAEAFFA5A5A5FFE6E6
      E6FFE1E1E1FF9C9C9CFF838383FF6A6A6AFFB5B5B5FFF1F1F1FFB2B2B2FFBDBD
      BDFF828282FFBABABAFF595959FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3D3FFD2D2
      D2FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFC3C3C3FFC1C1
      C1FFC0C0C0FFBDBDBDFFBBBBBBFFB9B9B9FFB8B8B8FFB5B5B5FFB3B3B3FFB1B1
      B1FFABABABFFE3E3E3FFE0E0E0FFA9A9A9FFA7A7A7FFA5A5A5FFA3A3A3FFA0A0
      A0FF9E9E9EFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE7E7E7FF6D6D6DFFE4E4E4FFE2E2
      E2FFA5A5A5FFDFDFDFFFDEDEDEFF6D6D6DFFDADADAFF6D6D6DFFD0D0D0FFD0D0
      D0FFD0D0D0FFD0D0D0FFD0D0D0FF7E7E7EFFBEBEBEFF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFD0D0D0FFCDCDCDFFBBBB
      BBFF8E8E8EFFBEBEBEFF868686FF464646FF575757FF757575FF9A9A9AFFB9B9
      B9FFCACACAFFD0D0D0FFD0D0D0FFD0D0D0FFC1C1C1FFA3A3A3FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF1F1F1FFF0F0F0FFEEEEEEFFEDEDEDFFECECECFFEBEBEBFFA5A5A5FFEAEA
      EAFFDBDBDBFFB7B7B7FF7A7A7AFF747474FFEAEAEAFFEDEDEDFFE1E1E1FFC1C1
      C1FFA3A3A3FFA8A8A8FF595959FFD8D8D8FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3
      D3FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFC6C6C6FFC4C4
      C4FFC2C2C2FFC0C0C0FFBEBEBEFFBCBCBCFFBABABAFFB9B9B9FFB7B7B7FFB4B4
      B4FFBCBCBCFFB6B6B6FFB5B5B5FFACACACFFAAAAAAFFA8A8A8FFA6A6A6FFA4A4
      A4FFA1A1A1FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE7E7E7FF6D6D6DFFE5E5E5FFE3E3
      E3FFA5A5A5FFE0E0E0FFDFDFDFFF6D6D6DFFDBDBDBFF6D6D6DFFD0D0D0FFD0D0
      D0FFD0D0D0FFD0D0D0FFD0D0D0FF7E7E7EFFC2C2C2FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFC1C1C1FFB8B8B8FF9D9D
      9DFF8E8E8EFFC2C2C2FFBDBDBDFF868686FF424242FF515151FF6D6D6DFF8F8F
      8FFFACACACFFBCBCBCFFC1C1C1FFC1C1C1FFC1C1C1FFA3A3A3FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF2F2F2FFF1F1F1FFF0F0F0FFEEEEEEFFEDEDEDFFECECECFFA5A5A5FFE8E8
      E8FFEEEEEEFFE0E0E0FF787878FF8B8B8BFFF2F2F2FFEEEEEEFFE7E7E7FFBFBF
      BFFFC4C4C4FF969696FF595959FFDADADAFFD8D8D8FFD7D7D7FFD6D6D6FFD4D4
      D4FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFC8C8C8FFC7C7
      C7FFC5C5C5FFC3C3C3FFC1C1C1FFC0C0C0FFBDBDBDFFBBBBBBFFB9B9B9FFB8B8
      B8FFB5B5B5FFB8B8B8FFB7B7B7FFAFAFAFFFADADADFFABABABFFA9A9A9FFA7A7
      A7FFA5A5A5FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE8E8E8FF6D6D6DFFE5E5E5FFE4E4
      E4FFA5A5A5FFE1E1E1FFDFDFDFFF6D6D6DFFDCDCDCFF6D6D6DFFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFC6C6C6FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFCDCDCDFFBBBBBBFF9393
      93FF8E8E8EFFC6C6C6FFC1C1C1FFBDBDBDFF868686FF4F4F4FFF595959FF7575
      75FF9A9A9AFFB9B9B9FFCACACAFFD0D0D0FFC1C1C1FFA3A3A3FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF3F3F3FFF2F2F2FFF1F1F1FFF0F0F0FFEEEEEEFFEDEDEDFFA5A5A5FFE8E8
      E8FFF1F1F1FFDEDEDEFF5A5A5AFF848484FFF7F7F7FFEDEDEDFFE9E9E9FFCECE
      CEFFE3E3E3FFDFDFDFFF595959FFDBDBDBFFDADADAFFD8D8D8FFD7D7D7FFD5D5
      D5FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFCACACAFFC9C9
      C9FFC8C8C8FFC6C6C6FFC4C4C4FFC2C2C2FFC0C0C0FFBEBEBEFFBCBCBCFFBABA
      BAFFB9B9B9FFB6B6B6FFB4B4B4FFB2B2B2FFB0B0B0FFAEAEAEFFACACACFFAAAA
      AAFFA8A8A8FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE9E9E9FF6D6D6DFFE6E6E6FFE5E5
      E5FFA5A5A5FFE2E2E2FFE0E0E0FF6D6D6DFFDDDDDDFF6D6D6DFFD6D6D6FFD5D5
      D5FFD2D2D2FFD2D2D2FFCFCFCFFFCDCDCDFFCBCBCBFF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFC9C9C9FFAEAEAEFF8E8E
      8EFFD0D0D0FFCBCBCBFFC6C6C6FFC1C1C1FFBCBCBCFF868686FF575757FF5C5C
      5CFF757575FF9A9A9AFFB9B9B9FFCACACAFFC1C1C1FFA3A3A3FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF4F4F4FFF3F3F3FFF2F2F2FFF1F1F1FFF0F0F0FFEEEEEEFFA5A5A5FFEAEA
      EAFFF0F0F0FFD2D2D2FF747474FF767676FFDEDEDEFF848484FF8A8A8AFF7C7C
      7CFF575757FFABABABFF595959FFDCDCDCFFDBDBDBFFD9D9D9FFD8D8D8FFD7D7
      D7FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFCDCDCDFFCBCB
      CBFFA4A4A4FF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D
      7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFF7D7D7DFFADAD
      ADFFABABABFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFE9E9E9FF6D6D6DFFE7E7E7FFE6E6
      E6FFA5A5A5FFE3E3E3FFE1E1E1FF6D6D6DFFDEDEDEFF6D6D6DFFD9D9D9FFD7D7
      D7FFD6D6D6FFD4D4D4FFD2D2D2FFD1D1D1FFCFCFCFFF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFC6C6C6FFA9A9A9FF8E8E
      8EFFD4D4D4FF9F9F9FFF9F9F9FFF9F9F9FFFC1C1C1FFBCBCBCFF868686FF6565
      65FF606060FF777777FF9A9A9AFFB9B9B9FFBCBCBCFFA3A3A3FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF6F6F6FFF4F4F4FFF3F3F3FFF2F2F2FFF1F1F1FFF0F0F0FFA5A5A5FFE8E8
      E8FFF2F2F2FFC6C6C6FF595959FF9C9C9CFFAAAAAAFF444444FF747474FF7676
      76FF717171FF646464FF595959FFDDDDDDFFDCDCDCFFDBDBDBFFD9D9D9FFD8D8
      D8FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFCFCFCFFFCDCD
      CDFFA4A4A4FFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCF
      CFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFF7D7D7DFFB0B0
      B0FFAEAEAEFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFA5A5A5FFE9E9E9FFE8E8E8FFE6E6
      E6FFE5E5E5FFA5A5A5FFA5A5A5FFE0E0E0FFDFDFDFFF6D6D6DFFDCDCDCFFDADA
      DAFFD9D9D9FFD7D7D7FFD5D5D5FFD3D3D3FFD2D2D2FF595959FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFC9C9C9FF8E8E8EFFDCDC
      DCFF9F9F9FFFB9B9B9FFCBCBCBFF9F9F9FFF9F9F9FFFC0C0C0FFBCBCBCFF8686
      86FF717171FF676767FF7A7A7AFF9A9A9AFFACACACFF9F9F9FFF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF7F7F7FFF5F5F5FFF4F4F4FFF3F3F3FFF2F2F2FFF1F1F1FFA5A5A5FFE8E8
      E8FFEAEAEAFF979797FF464646FFB8B8B8FFF3F3F3FFA3A3A3FFB3B3B3FFD4D4
      D4FFAEAEAEFF797979FF595959FFDEDEDEFFDDDDDDFFDCDCDCFFDBDBDBFFD9D9
      D9FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD1D1D1FFD0D0
      D0FFA4A4A4FFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCF
      CFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFF7D7D7DFFB3B3
      B3FFB1B1B1FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFEAEAEAFFE9E9E9FFE8E8E8FFE7E7
      E7FFE6E6E6FFE4E4E4FFE3E3E3FFE1E1E1FFE0E0E0FF6D6D6DFFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFCECECEFFB6B6
      B6FF0000000000000000000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFCDCDCDFF8E8E8EFF8E8E
      8EFFC0C0C0FFCACACAFFD0D0D0FFD0D0D0FFD0D0D0FF9F9F9FFFBFBFBFFFBBBB
      BBFF868686FF7D7D7DFF6C6C6CFF7A7A7AFF919191FF959595FF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF7F7F7FFF6F6F6FFF5F5F5FFF4F4F4FFF3F3F3FFF2F2F2FFA5A5A5FFEEEE
      EEFFBCBCBCFF7B7B7BFF444444FFA8A8A8FFF0F0F0FFE0E0E0FFDBDBDBFFE6E6
      E6FFE6E6E6FF8F8F8FFF595959FFDFDFDFFFDEDEDEFFDDDDDDFFDCDCDCFFDBDB
      DBFF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD4D4D4FFD2D2
      D2FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFB6B6
      B6FFB4B4B4FF585858FF00000000000000000000000000000000000000000000
      000000000000A5A5A5FF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFFCECECEFFCECE
      CEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECE
      CEFFB6B6B6FFB6B6B6FF000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFC1C1C1FF8E8E8EFFBDBD
      BDFFBEBEBEFFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FF9F9F9FFF9F9F
      9FFFBABABAFF868686FF7A7A7AFF696969FF808080FF8B8B8BFF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF8F8F8FFF7F7F7FFF6F6F6FFF5F5F5FFF4F4F4FFF3F3F3FFA5A5A5FFD0D0
      D0FF8E8E8EFF727272FF3D3D3DFF959595FFE5E5E5FFD8D8D8FFDADADAFFD6D6
      D6FFEBEBEBFF7C7C7CFF595959FFE1E1E1FFDFDFDFFFDEDEDEFFDDDDDDFFDCDC
      DCFF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD6D6D6FFD5D5
      D5FFD3D3D3FFD1D1D1FFD0D0D0FFCECECEFFCDCDCDFFCBCBCBFFC9C9C9FFC8C8
      C8FFC7C7C7FFC5C5C5FFC3C3C3FFC0C0C0FFBFBFBFFFBDBDBDFFBBBBBBFFB9B9
      B9FFB7B7B7FF585858FF00000000000000000000000000000000000000000000
      000000000000A5A5A5FFE9E9E9FFE7E7E7FFE5E5E5FFE4E4E4FFE2E2E2FFE0E0
      E0FFDEDEDEFFDCDCDCFFDADADAFFD7D7D7FFD5D5D5FF6D6D6DFFCECECEFFCECE
      CEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECE
      CEFFCECECEFFB6B6B6FF000000000000000000000000000000000000000B5555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFD0D0D0FFD0D0D0FFD0D0
      D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0
      D0FF9F9F9FFFBABABAFF868686FF929292FF8A8A8AFF8D8D8DFF515151FF5151
      51FF6B6B6BFF555555FF000000260000000B000000000000000000000000B6B6
      B6FFF9F9F9FFF8F8F8FFF7F7F7FFF6F6F6FFF5F5F5FFF4F4F4FFA5A5A5FF9090
      90FF898989FF6B6B6BFF3E3E3EFF777777FF868686FF8A8A8AFFADADADFFC8C8
      C8FFA7A7A7FF545454FF595959FFE2E2E2FFE1E1E1FFDFDFDFFFDEDEDEFFDCDC
      DCFF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD8D8D8FFD7D7
      D7FFD5D5D5FFD4D4D4FFD2D2D2FFD1D1D1FFCFCFCFFFCDCDCDFFCBCBCBFFCACA
      CAFFC8C8C8FFC7C7C7FFC5C5C5FFC3C3C3FFC2C2C2FFC0C0C0FFBEBEBEFFBCBC
      BCFFBABABAFF585858FF00000000000000000000000000000000000000000000
      000000000000A5A5A5FFA5A5A5FFE7E7E7FFE6E6E6FFE4E4E4FFE2E2E2FFE0E0
      E0FFDFDFDFFFDCDCDCFFDADADAFFD7D7D7FFD5D5D5FF6D6D6DFFCECECEFFCECE
      CEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECE
      CEFFCECECEFFB6B6B6FF00000000000000000000000000000000000000085555
      55FF6B6B6BFF515151FF515151FFA3A3A3FFC1C1C1FFD0D0D0FFD0D0D0FFD0D0
      D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0
      D0FFCECECEFF9F9F9FFFB9B9B9FF868686FFA6A6A6FF989898FF515151FF5151
      51FF6B6B6BFF555555FF0000001D00000008000000000000000000000000B6B6
      B6FFFAFAFAFFF9F9F9FFF8F8F8FFF7F7F7FFF6F6F6FFF5F5F5FFA5A5A5FF8B8B
      8BFF858585FF5D5D5DFF474747FF454545FF404040FF444444FF494949FF4D4D
      4DFF444444FF525252FF595959FFE4E4E4FFE2E2E2FFE1E1E1FFDFDFDFFFDEDE
      DEFF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFD9D9D9FFD8D8
      D8FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3D3FFD1D1D1FFD0D0D0FFCECECEFFCCCC
      CCFFCBCBCBFFC9C9C9FFC8C8C8FFC6C6C6FFC4C4C4FFC2C2C2FFC0C0C0FFBFBF
      BFFFBDBDBDFF585858FF00000000000000000000000000000000000000000000
      00000000000000000000A5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FF6D6D6DFFB6B6B6FFB6B6
      B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6
      B6FFB6B6B6FF0000000000000000000000000000000000000000000000035555
      55FF6B6B6BFF6B6B6BFF6B6B6BFFA3A3A3FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1
      C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1C1FFC1C1
      C1FFC1C1C1FFC1C1C1FF9F9F9FFF9F9F9FFFBBBBBBFFA0A0A0FF6B6B6BFF6B6B
      6BFF6B6B6BFF555555FF0000001100000003000000000000000000000000B6B6
      B6FFFBFBFBFFFAFAFAFFF9F9F9FFF8F8F8FFF7F7F7FFF6F6F6FFA5A5A5FF8383
      83FF7E7E7EFF5B5B5BFF4A4A4AFF484848FF474747FF4B4B4BFF4F4F4FFF4848
      48FF4E4E4EFF7A7A7AFF595959FFE5E5E5FFE4E4E4FFE2E2E2FFE1E1E1FFDFDF
      DFFF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFDBDBDBFFD9D9
      D9FFD8D8D8FFD8D8D8FFD7D7D7FFD5D5D5FFD4D4D4FFD2D2D2FFD0D0D0FFCFCF
      CFFFCDCDCDFFCBCBCBFFCACACAFFC8C8C8FFC7C7C7FFC5C5C5FFC3C3C3FFC1C1
      C1FFC0C0C0FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A5FF00000000000000000000000000000000000000000000
      0000A5A5A5FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0026555555FF555555FF555555FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3
      A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3
      A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FFA3A3A3FF555555FF5555
      55FF555555FF000000360000000400000000000000000000000000000000B6B6
      B6FFFBFBFBFFFBFBFBFFFAFAFAFFF9F9F9FFF8F8F8FFF7F7F7FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFE6E6E6FFE5E5E5FFE4E4E4FFE2E2E2FFE1E1
      E1FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFDCDCDCFFDBDB
      DBFFDADADAFFD9D9D9FFD8D8D8FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3D3FFD1D1
      D1FFD0D0D0FFCECECEFFCCCCCCFFCBCBCBFFC9C9C9FFC8C8C8FFC6C6C6FFC4C4
      C4FFC2C2C2FF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B6B6
      B6FFFCFCFCFFFBFBFBFFFBFBFBFFFAFAFAFFF9F9F9FFF8F8F8FFF7F7F7FFF6F6
      F6FFF5F5F5FFF4F4F4FFF3F3F3FFF2F2F2FFF0F0F0FFEFEFEFFFEEEEEEFFECEC
      ECFFECECECFFEBEBEBFFE9E9E9FFE8E8E8FFE6E6E6FFE5E5E5FFE3E3E3FFE2E2
      E2FF979797FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A006C6C6C006C6C6C006C6C
      6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C
      6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C
      6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C6C006C6C
      6C006C6C6C006C6C6C006C6C6C006C6C6C008F8F8F0024242400242424002424
      2400242424002424240024242400242424002424240024242400242424002424
      2400242424002424240024242400242424002424240024242400242424002424
      2400242424002424240024242400242424002424240024242400242424002424
      2400242424002424240024242400242424008F8F8F0023232300232323002323
      2300232323002323230023232300232323002323230023232300232323002323
      2300232323002323230023232300232323002323230023232300232323002323
      2300232323002323230023232300232323002323230023232300232323002323
      2300232323002323230023232300232323008F8F8F0024242400242424002424
      2400242424002424240024242400242424002424240024242400242424002424
      2400242424002424240024242400242424002424240024242400242424002424
      2400242424002424240024242400242424002424240024242400242424002424
      2400242424002424240024242400242424009A9A9A00E0E0E000DFDFDF00DEDE
      DE00DDDDDD00DCDCDC00DBDBDB00DBDBDB00DADADA00D9D9D900D8D8D800D8D8
      D800D7D7D700D6D6D600D5D5D500D5D5D500D5D5D500D4D4D400D4D4D400D3D3
      D300D2D2D200D2D2D200D1D1D100D1D1D100D0D0D000CFCFCF00CFCFCF00CECE
      CE00CECECE00CECECE00CDCDCD006C6C6C008F8F8F00EBEBEB00EAEAEA00E9E9
      E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E4E4E400E2E2E200E2E2
      E200E1E1E100DFDFDF00DFDFDF00DDDDDD00DDDDDD00DCDCDC00DBDBDB00DADA
      DA00DADADA00D9D9D900D8D8D800D7D7D700D7D7D700D6D6D600D6D6D600D5D5
      D500D5D5D500D5D5D500D5D5D500242424008F8F8F00EAEAEA00E9E9E900E9E9
      E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3E300E2E2E200E1E1
      E100E0E0E000DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADA
      DA00D9D9D900D9D9D900D8D8D800D7D7D700D7D7D700D6D6D600D6D6D600D5D5
      D500D5D5D500D4D4D400D4D4D400232323008F8F8F00EBEBEB00EAEAEA00E9E9
      E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3E300E2E2E200E1E1
      E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DBDBDB00DADA
      DA00DADADA00D9D9D900D8D8D800D7D7D700D7D7D700D6D6D600D6D6D600D5D5
      D500D5D5D500D4D4D400D4D4D400242424009A9A9A00E1E1E100E0E0E0007D7D
      7D00DEDEDE00DDDDDD00DCDCDC00DBDBDB00DBDBDB00DADADA00D9D9D900BBBB
      BB00D8D8D800D7D7D700D6D6D600D5D5D500D5D5D500A4A4A4006C6C6C006C6C
      6C006C6C6C006C6C6C006C6C6C006C6C6C00D1D1D100D0D0D000CFCFCF00CFCF
      CF00CECECE00CECECE00CECECE006C6C6C008F8F8F00ECECEC00EBEBEB00EAEA
      EA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E4E4E4008F8F
      8F0024242400242424002424240024242400242424002424240024242400DBDB
      DB00DADADA00DADADA00D9D9D900D8D8D800D7D7D700D7D7D700D6D6D600D6D6
      D600D5D5D500D5D5D500D5D5D500242424008F8F8F00EBEBEB00EAEAEA00E9E9
      E900E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3E300E2E2
      E200E1E1E100E0E0E000DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDB
      DB00DADADA00D9D9D900D9D9D900D8D8D800D7D7D700D7D7D700D6D6D600D6D6
      D600D5D5D500D5D5D500D4D4D400232323008F8F8F00ECECEC00EBEBEB00EAEA
      EA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3E300E2E2
      E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DBDB
      DB00DADADA00DADADA00D9D9D900D8D8D800D7D7D700D7D7D700D6D6D600D6D6
      D600D5D5D500D5D5D500D4D4D400242424009A9A9A00E1E1E100E1E1E1007D7D
      7D00DFDFDF00545454005454540054545400545454005454540054545400D9D9
      D900D8D8D800D8D8D800D7D7D700D6D6D600D5D5D500A4A4A400E7E7E700E9E9
      E900EDEDED00F1F1F100F4F4F4006C6C6C00D1D1D100D1D1D100D0D0D000CFCF
      CF00CFCFCF00CECECE00CECECE006C6C6C008F8F8F00EDEDED00ECECEC00EBEB
      EB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E4008F8F
      8F00E7E7E700E9E9E900EDEDED00F1F1F100F4F4F400F7F7F70024242400DCDC
      DC00DBDBDB00DADADA00DADADA00D9D9D900D8D8D800D7D7D700D7D7D700D6D6
      D600D6D6D600D5D5D500D5D5D500242424008F8F8F00ECECEC00EBEBEB00EAEA
      EA00E9E9E900E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3
      E300E2E2E200E1E1E100E0E0E000DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDC
      DC00DBDBDB00DADADA00D9D9D900D9D9D900D8D8D800D7D7D700D7D7D700D6D6
      D600D6D6D600D5D5D500D5D5D500232323008F8F8F00EDEDED00ECECEC00EBEB
      EB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3
      E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDC
      DC00DBDBDB00DADADA00DADADA00D9D9D900D8D8D800D7D7D700D7D7D700D6D6
      D600D6D6D600D5D5D500D5D5D500242424009A9A9A00E2E2E200E1E1E1007D7D
      7D0054545400BFBFBF00BCBCBC00B7B7B700B4B4B400B1B1B100AEAEAE005454
      5400D9D9D900BBBBBB00D8D8D800BBBBBB00D6D6D600A4A4A400E3E3E300E7E7
      E700E9E9E900EDEDED00F1F1F1006C6C6C00D2D2D200D1D1D100D1D1D100D0D0
      D000CFCFCF00CECECE00CECECE006C6C6C008F8F8F00EEEEEE00EDEDED00ECEC
      EC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E5008F8F
      8F00E3E3E300E7E7E700E2E2E20054545400F1F1F100F4F4F40024242400DDDD
      DD00DCDCDC00DBDBDB00DADADA00DADADA00D9D9D900D8D8D800D7D7D700D7D7
      D700D6D6D600D6D6D600D5D5D500242424008F8F8F00EDEDED00ECECEC00A3A3
      A300A3A3A300A3A3A300E9E9E900A3A3A300A3A3A300A3A3A300A3A3A300E4E4
      E400A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300DADADA00A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300D6D6D600D5D5D500232323008F8F8F00EEEEEE00EDEDED00ECEC
      EC00EBEBEB00EAEAEA00E9E9E900A4A4A400A4A4A400A4A4A400E5E5E500E4E4
      E400E3E3E300A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400DADADA00A4A4A400A4A4A400A4A4A400A4A4
      A400D6D6D600D6D6D600D5D5D500242424009A9A9A00E3E3E300E2E2E2007D7D
      7D00C8C8C800C4C4C400C0C0C000BCBCBC00545454007D7D7D007D7D7D007D7D
      7D0054545400D9D9D900D8D8D800D8D8D800D7D7D700A4A4A400E0E0E000E3E3
      E300E7E7E700E9E9E900EDEDED006C6C6C00D2D2D200D2D2D200D1D1D100D1D1
      D100D0D0D000CFCFCF00CECECE006C6C6C008F8F8F00EEEEEE00EEEEEE00EDED
      ED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E6008F8F
      8F00E0E0E000E3E3E3007D7D7D00BFBFBF0054545400F1F1F10024242400DDDD
      DD00DDDDDD00DCDCDC00DBDBDB00DADADA00DADADA00D9D9D900D8D8D800D7D7
      D700D7D7D700D6D6D600D6D6D600242424008F8F8F00EEEEEE00EDEDED00A3A3
      A300EBEBEB00A3A3A300E9E9E900A3A3A300A3A3A300A3A3A300A3A3A300E5E5
      E500A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300DBDBDB00A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300D6D6D600D6D6D600232323008F8F8F00EEEEEE00EEEEEE00EDED
      ED00A4A4A400CACACA00A4A4A400A4A4A400E8E8E800A4A4A400E6E6E600E5E5
      E500E4E4E400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400DADADA00A4A4A400A4A4A400A4A4A400A4A4
      A400D7D7D700D6D6D600D6D6D600242424009A9A9A00E4E4E400E3E3E3007D7D
      7D00CDCDCD00C9C9C900C5C5C500C2C2C20054545400DDDDDD00DCDCDC00BBBB
      BB007D7D7D007D7D7D00D9D9D900D8D8D800D8D8D800A4A4A400DDDDDD00E0E0
      E000E3E3E300E7E7E700E9E9E9006C6C6C00D3D3D300D2D2D200D2D2D200D1D1
      D100D1D1D100D0D0D000CFCFCF006C6C6C008F8F8F00EFEFEF00EEEEEE00EEEE
      EE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7E7008F8F
      8F00DDDDDD00E0E0E0007D7D7D00C5C5C500BFBFBF005454540024242400DFDF
      DF00DDDDDD00DDDDDD00DCDCDC00DBDBDB00DADADA00DADADA00D9D9D900D8D8
      D800D7D7D700D7D7D700D6D6D600242424008F8F8F00EFEFEF00EEEEEE00A3A3
      A300A3A3A300A3A3A300EAEAEA00A3A3A300A3A3A300A3A3A300A3A3A300E6E6
      E600A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300DCDCDC00A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300D7D7D700D6D6D600232323008F8F8F00EFEFEF00EEEEEE00EEEE
      EE00CACACA00ECECEC00EBEBEB00A4A4A400A4A4A400A4A4A400E7E7E700E6E6
      E600E5E5E500A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400DBDBDB00A4A4A400A4A4A400A4A4A400A4A4
      A400D7D7D700D7D7D700D6D6D600242424009A9A9A00E5E5E500E4E4E4007D7D
      7D00D1D1D100CECECE00CACACA0054545400DFDFDF00DEDEDE00DDDDDD00DCDC
      DC00DBDBDB00DBDBDB00DADADA00D9D9D900D8D8D800A4A4A400DBDBDB00DDDD
      DD00E0E0E000E3E3E300E7E7E7006C6C6C00D4D4D400D3D3D300D2D2D200D2D2
      D200D1D1D100D1D1D100D0D0D0006C6C6C008F8F8F00F0F0F000EFEFEF00EEEE
      EE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E8008F8F
      8F00DBDBDB00DDDDDD007D7D7D00CCCCCC00C5C5C500BFBFBF0054545400DFDF
      DF00DFDFDF00DDDDDD00DDDDDD00DCDCDC00DBDBDB00DADADA00DADADA00D9D9
      D900D8D8D800D7D7D700D7D7D700242424008F8F8F00F0F0F000EFEFEF00EEEE
      EE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E9E9E900E8E8E800E7E7
      E700E6E6E600E5E5E500E4E4E400E3E3E300E2E2E200E1E1E100E0E0E000DFDF
      DF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADADA00D9D9D900D9D9
      D900D8D8D800D7D7D700D7D7D700232323008F8F8F00F0F0F000EFEFEF00EEEE
      EE00A4A4A400EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7
      E700E6E6E600E5E5E500E4E4E400E3E3E300E2E2E200E1E1E100E0E0E000DFDF
      DF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DBDBDB00DADADA00DADADA00D9D9
      D900D8D8D800D7D7D700D7D7D700242424009A9A9A00E6E6E600E5E5E5007D7D
      7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D00DEDEDE00BBBB
      BB00DCDCDC00DBDBDB00DBDBDB00DADADA00D9D9D900A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400A4A4A400D4D4D400D4D4D400D3D3D300D2D2
      D200D2D2D200D1D1D100D1D1D1006C6C6C008F8F8F00F1F1F100F0F0F000EFEF
      EF00EEEEEE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E9008F8F
      8F00D9D9D9007D7D7D00D8D8D800D2D2D200CCCCCC00C5C5C500BFBFBF005454
      5400DFDFDF00DFDFDF00DDDDDD00DDDDDD00DCDCDC00DBDBDB00DADADA00DADA
      DA00D9D9D900D8D8D800D7D7D700242424008F8F8F00F0F0F000F0F0F000A3A3
      A300A3A3A300A3A3A300ECECEC00A3A3A300A3A3A300A3A3A300A3A3A300E8E8
      E800A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300DDDDDD00A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300D8D8D800D7D7D700232323008F8F8F00F1F1F100F0F0F000A4A4
      A400A4A4A400A4A4A400EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8
      E800E7E7E700A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400DDDDDD00A4A4A400A4A4A400A4A4A400A4A4
      A400D9D9D900D8D8D800D7D7D700242424009A9A9A00E6E6E600E6E6E600E5E5
      E500E4E4E400E3E3E300E2E2E200E1E1E100E1E1E100E0E0E000DFDFDF00DEDE
      DE00DDDDDD00DCDCDC00DBDBDB00DBDBDB00DADADA00D9D9D900D8D8D800D8D8
      D800D7D7D700D6D6D600D5D5D500D5D5D500D5D5D500D4D4D400D4D4D400D3D3
      D300D2D2D200D2D2D200D1D1D1006C6C6C008F8F8F00F2F2F200F1F1F100F0F0
      F000EFEFEF00EEEEEE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA008F8F
      8F008F8F8F007D7D7D00DDDDDD007D7D7D007D7D7D007D7D7D00C5C5C500BFBF
      BF0054545400DFDFDF00DFDFDF00DDDDDD00DDDDDD00DCDCDC00DBDBDB00DADA
      DA00DADADA00D9D9D900D8D8D800242424008F8F8F00F2F2F200F0F0F000A3A3
      A300EFEFEF00A3A3A300EDEDED00A3A3A300A3A3A300A3A3A300A3A3A300E9E9
      E900A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300DEDEDE00A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300D9D9D900D8D8D800232323008F8F8F00F2F2F200F1F1F100A4A4
      A400EFEFEF00A4A4A400EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9
      E900E8E8E800A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400DEDEDE00A4A4A400A4A4A400A4A4A400A4A4
      A400DADADA00D9D9D900D8D8D800242424009A9A9A00E6E6E600E6E6E600E6E6
      E600E5E5E500E4E4E400E3E3E300E2E2E200E1E1E100E1E1E100E0E0E000BBBB
      BB00DEDEDE00DDDDDD00DCDCDC00DBDBDB00DBDBDB00DADADA00D9D9D900D8D8
      D800D8D8D800D7D7D700D6D6D600D5D5D500D5D5D500D5D5D500D4D4D400D4D4
      D400D3D3D300D2D2D200D2D2D2006C6C6C008F8F8F00F3F3F300F2F2F200F1F1
      F100F0F0F000EFEFEF00EEEEEE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEA
      EA007D7D7D00E6E6E6007D7D7D00E6E6E600E5E5E5007D7D7D007D7D7D00C5C5
      C500BFBFBF0054545400DDDDDD00DFDFDF00DDDDDD00DDDDDD00DCDCDC00DBDB
      DB00DADADA00DADADA00D9D9D900242424008F8F8F00F3F3F300F2F2F200A3A3
      A300A3A3A300A3A3A300EEEEEE00A3A3A300A3A3A300A3A3A300A3A3A300E9E9
      E900A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300DFDFDF00A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300D9D9D900D9D9D900232323008F8F8F00F3F3F300F2F2F200A4A4
      A400A4A4A400A4A4A400EEEEEE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEA
      EA00E9E9E900A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400DFDFDF00A4A4A400A4A4A400A4A4A400A4A4
      A400DADADA00DADADA00D9D9D900242424009A9A9A00E7E7E700E6E6E600E6E6
      E600E6E6E600E5E5E500E4E4E400E3E3E3005454540054545400545454005454
      5400545454005454540054545400DCDCDC00DBDBDB00A4A4A4006C6C6C006C6C
      6C006C6C6C006C6C6C006C6C6C006C6C6C00D5D5D500D5D5D500D5D5D500D4D4
      D400D4D4D400D3D3D300D2D2D2006C6C6C008F8F8F00F4F4F400F3F3F300F2F2
      F200F1F1F100F0F0F000EFEFEF00EEEEEE00EEEEEE00EDEDED00ECECEC00EBEB
      EB007D7D7D007D7D7D00E7E7E700E7E7E700E6E6E600E5E5E500E4E4E4007D7D
      7D00C5C5C500BFBFBF0054545400DFDFDF00DFDFDF00DDDDDD00DDDDDD00DCDC
      DC00DBDBDB00DADADA00DADADA00242424008F8F8F00F3F3F300F3F3F300F2F2
      F200F0F0F000F0F0F000EFEFEF00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEA
      EA00E9E9E900E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3
      E300E2E2E200E1E1E100E0E0E000DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDC
      DC00DBDBDB00DADADA00D9D9D900232323008F8F8F00F4F4F400F3F3F300F2F2
      F200F1F1F100F0F0F000EFEFEF00EEEEEE00EEEEEE00EDEDED00ECECEC00EBEB
      EB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3
      E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDC
      DC00DBDBDB00DADADA00DADADA00242424009A9A9A00E8E8E800E7E7E700E6E6
      E600E6E6E600E6E6E600E5E5E500E4E4E400E3E3E300E2E2E20054545400D0D0
      D000CDCDCD00C9C9C90054545400DDDDDD00DCDCDC00A4A4A400E7E7E700E9E9
      E900EDEDED00F1F1F100F4F4F4006C6C6C00D6D6D600D5D5D500D5D5D500D5D5
      D500D4D4D400D4D4D400D3D3D3006C6C6C008F8F8F00F5F5F500F4F4F400F3F3
      F300F2F2F200F1F1F100F0F0F000EFEFEF00EEEEEE00EEEEEE00EDEDED00ECEC
      EC007D7D7D00E9E9E900E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E5E5
      E5007D7D7D007D7D7D00BFBFBF0054545400DEDEDE00DFDFDF00DDDDDD00DDDD
      DD00DCDCDC00DBDBDB00DADADA00242424008F8F8F00F5F5F500F3F3F300A3A3
      A300A3A3A300A3A3A300F0F0F000A3A3A300A3A3A300A3A3A300A3A3A300EBEB
      EB00A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300E1E1E100A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300DBDBDB00DADADA00232323008F8F8F00F5F5F500F4F4F400F3F3
      F300F2F2F200F1F1F100F0F0F000A4A4A400A4A4A400A4A4A400EDEDED00ECEC
      EC00EBEBEB00A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E0E0E000A4A4A400A4A4A400A4A4A400A4A4
      A400DCDCDC00DBDBDB00DADADA00242424009A9A9A00E8E8E800E8E8E800E7E7
      E7007D7D7D0054545400E6E6E600E5E5E500E4E4E40054545400D9D9D900D5D5
      D500D1D1D100CECECE0054545400DEDEDE00DDDDDD00A4A4A400E3E3E300E7E7
      E700E9E9E900EDEDED00F1F1F1006C6C6C00D7D7D700D6D6D600D5D5D500D5D5
      D500D5D5D500D4D4D400D4D4D4006C6C6C008F8F8F00F6F6F600F5F5F500F4F4
      F400F3F3F300F2F2F200F1F1F100F0F0F000EFEFEF00EEEEEE00EEEEEE00EDED
      ED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5
      E500E5E5E500E4E4E4007D7D7D00BFBFBF0054545400DFDFDF00DFDFDF00DDDD
      DD00DDDDDD00DCDCDC00DBDBDB00242424008F8F8F00F6F6F600F5F5F500A3A3
      A300F3F3F300A3A3A300F0F0F000A3A3A300A3A3A300A3A3A300A3A3A300ECEC
      EC00A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300E2E2E200A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300DCDCDC00DBDBDB00232323008F8F8F00F6F6F600F5F5F500F4F4
      F400A4A4A400CACACA00A4A4A400A4A4A400EFEFEF00A4A4A400EEEEEE00EDED
      ED00ECECEC00A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E1E1E100A4A4A400A4A4A400A4A4A400A4A4
      A400DDDDDD00DCDCDC00DBDBDB00242424009A9A9A00E9E9E900E8E8E800E8E8
      E800E7E7E7007D7D7D00545454005454540054545400E1E1E100DEDEDE00D9D9
      D900D6D6D600D3D3D30054545400BBBBBB00DEDEDE00A4A4A400E0E0E000E3E3
      E300E7E7E700E9E9E900EDEDED006C6C6C00D8D8D800D7D7D700D6D6D600D5D5
      D500D5D5D500D5D5D500D4D4D4006C6C6C008F8F8F00F7F7F700F6F6F600F5F5
      F500F4F4F400F3F3F300F2F2F200F1F1F100F0F0F000EFEFEF00EEEEEE00EEEE
      EE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6
      E600E5E5E500E4E4E400E0E0E0007D7D7D00BFBFBF0054545400DFDFDF00DFDF
      DF00DDDDDD00DDDDDD00DCDCDC00242424008F8F8F00F7F7F700F6F6F600A3A3
      A300A3A3A300A3A3A300F2F2F200A3A3A300A3A3A300A3A3A300A3A3A300EDED
      ED00A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300E3E3E300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300DCDCDC00DCDCDC00232323008F8F8F00F7F7F700F6F6F600F5F5
      F500CACACA00F3F3F300F2F2F200A4A4A400A4A4A400A4A4A400EEEEEE00EEEE
      EE00EDEDED00A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E2E2E200A4A4A400A4A4A400A4A4A400A4A4
      A400DEDEDE00DDDDDD00DCDCDC00242424009A9A9A00EAEAEA00E9E9E900E8E8
      E800E8E8E800E7E7E7007D7D7D00EBEBEB00E8E8E800E5E5E500E2E2E200DEDE
      DE00DBDBDB007D7D7D0054545400E0E0E000DFDFDF00A4A4A400DDDDDD00E0E0
      E000E3E3E300E7E7E700E9E9E9006C6C6C00D8D8D800D8D8D800D7D7D700D6D6
      D600D5D5D500D5D5D500D5D5D5006C6C6C008F8F8F00F7F7F700F7F7F700F6F6
      F600F5F5F500F4F4F400F3F3F300F2F2F200F1F1F100F0F0F000EFEFEF00EEEE
      EE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7
      E700E6E6E600E5E5E500E4E4E400E4E4E4007D7D7D007D7D7D00E1E1E100DFDF
      DF00DFDFDF00DDDDDD00DDDDDD00242424008F8F8F00F7F7F700F7F7F700F6F6
      F600F5F5F500F3F3F300F3F3F300F2F2F200F0F0F000F0F0F000EFEFEF00EEEE
      EE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E9E9E900E8E8E800E7E7
      E700E6E6E600E5E5E500E4E4E400E3E3E300E2E2E200E1E1E100E0E0E000DFDF
      DF00DEDEDE00DDDDDD00DCDCDC00232323008F8F8F00F7F7F700F7F7F700F6F6
      F600A4A4A400F4F4F400F3F3F300F2F2F200F1F1F100F0F0F000EFEFEF00EEEE
      EE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7
      E700E6E6E600E5E5E500E4E4E400E3E3E300E2E2E200E1E1E100E0E0E000DFDF
      DF00DFDFDF00DEDEDE00DDDDDD00242424009A9A9A00EAEAEA00EAEAEA00E9E9
      E900E8E8E800E8E8E800E7E7E7007D7D7D007D7D7D007D7D7D007D7D7D007D7D
      7D007D7D7D00E2E2E20054545400E1E1E100E0E0E000A4A4A400DBDBDB00DDDD
      DD00E0E0E000E3E3E300E7E7E7006C6C6C00D9D9D900D8D8D800D8D8D800D7D7
      D700D6D6D600D5D5D500D5D5D5006C6C6C008F8F8F00F8F8F800F7F7F700F7F7
      F700F6F6F600F5F5F500F4F4F400F3F3F300F2F2F200F1F1F100F0F0F0008F8F
      8F0024242400242424002424240024242400242424002424240024242400E8E8
      E800E7E7E700E6E6E600E5E5E500E4E4E400E4E4E400E2E2E200E2E2E200E1E1
      E100DFDFDF00DFDFDF00DDDDDD00242424008F8F8F00F8F8F800F7F7F700A3A3
      A300A3A3A300A3A3A300F3F3F300A3A3A300A3A3A300A3A3A300A3A3A300EFEF
      EF00A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300E5E5E500A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300DEDEDE00DDDDDD00232323008F8F8F00F8F8F800F7F7F700F7F7
      F700CACACA00F5F5F500F4F4F400A4A4A400A4A4A400A4A4A400F0F0F000EFEF
      EF00EEEEEE00A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E4E4E400A4A4A400A4A4A400A4A4A400A4A4
      A400DFDFDF00DFDFDF00DEDEDE00242424009A9A9A00EBEBEB00EAEAEA00EAEA
      EA00E9E9E900E8E8E800E8E8E800E7E7E700E6E6E600E6E6E600E6E6E600E5E5
      E500E4E4E400E3E3E3007D7D7D00E1E1E100E1E1E100A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400A4A4A400DADADA00D9D9D900D8D8D800D8D8
      D800D7D7D700D6D6D600D5D5D5006C6C6C008F8F8F00F8F8F800F8F8F800F7F7
      F700F7F7F700F6F6F600F5F5F500F4F4F400F3F3F300F2F2F200F1F1F1008F8F
      8F00E7E7E700E9E9E900EDEDED00F1F1F100F4F4F400F7F7F70024242400E9E9
      E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E4E4E400E2E2E200E2E2
      E200E1E1E100DFDFDF00DFDFDF00242424008F8F8F00F8F8F800F8F8F800A3A3
      A300F7F7F700A3A3A300F5F5F500A3A3A300A3A3A300A3A3A300A3A3A300F0F0
      F000A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300E6E6E600A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300DFDFDF00DEDEDE00232323008F8F8F00F8F8F800F8F8F800F7F7
      F700A4A4A400CACACA00A4A4A400A4A4A400F3F3F300A4A4A400F1F1F100F0F0
      F000EFEFEF00A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E5E5E500A4A4A400A4A4A400A4A4A400A4A4
      A400E0E0E000DFDFDF00DFDFDF00242424009A9A9A00EBEBEB00EBEBEB00EAEA
      EA00EAEAEA00E9E9E900E8E8E800E8E8E800E7E7E700E6E6E600E6E6E600BBBB
      BB00E5E5E500E4E4E400E3E3E300E2E2E200E1E1E100E1E1E100E0E0E000DFDF
      DF00DEDEDE00DDDDDD00DCDCDC00DBDBDB00DBDBDB00DADADA00D9D9D900D8D8
      D800D8D8D800D7D7D700D6D6D6006C6C6C008F8F8F00F8F8F800F8F8F800F8F8
      F800F7F7F700F7F7F700F6F6F600F5F5F500F4F4F400F3F3F300F2F2F2008F8F
      8F00E3E3E300E7E7E700E2E2E20054545400F1F1F100F4F4F40024242400EAEA
      EA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E4E4E400E2E2
      E200E2E2E200E1E1E100DFDFDF00242424008F8F8F00F8F8F800F8F8F800A3A3
      A300A3A3A300A3A3A300F6F6F600A3A3A300A3A3A300A3A3A300A3A3A300F0F0
      F000A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300E7E7E700A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300E0E0E000DFDFDF00232323008F8F8F00F8F8F800F8F8F800F8F8
      F800CACACA00F7F7F700F6F6F600A4A4A400A4A4A400A4A4A400F2F2F200F1F1
      F100F0F0F000A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E6E6E600A4A4A400A4A4A400A4A4A400A4A4
      A400E1E1E100E0E0E000DFDFDF00242424009A9A9A00ECECEC00EBEBEB00EBEB
      EB00EAEAEA00EAEAEA00E9E9E900E8E8E800A4A4A4006C6C6C006C6C6C006C6C
      6C006C6C6C006C6C6C006C6C6C00E3E3E300E2E2E200E1E1E100E1E1E100E0E0
      E000DFDFDF00DEDEDE00DDDDDD00DCDCDC00DBDBDB00DBDBDB00DADADA00D9D9
      D900D8D8D800D8D8D800D7D7D7006C6C6C008F8F8F00F8F8F800F8F8F800F8F8
      F800F8F8F800F7F7F700F7F7F700F6F6F600F5F5F500F4F4F400F3F3F3008F8F
      8F00E0E0E000E3E3E3007D7D7D00C5C5C50054545400F1F1F10024242400EBEB
      EB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E4E4
      E400E2E2E200E2E2E200E1E1E100242424008F8F8F00F9F9F900F8F8F800F8F8
      F800F8F8F800F7F7F700F7F7F700F6F6F600F5F5F500F3F3F300F3F3F300F2F2
      F200F0F0F000F0F0F000EFEFEF00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEA
      EA00E9E9E900E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3
      E300E2E2E200E1E1E100E0E0E000232323008F8F8F00F9F9F900F8F8F800F8F8
      F800A4A4A400F7F7F700F7F7F700F6F6F600F5F5F500F4F4F400F3F3F300F2F2
      F200F1F1F100F0F0F000EFEFEF00EEEEEE00EEEEEE00EDEDED00ECECEC00EBEB
      EB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4E400E3E3
      E300E2E2E200E1E1E100E0E0E000242424009A9A9A00EDEDED00ECECEC00EBEB
      EB00EBEBEB00EAEAEA00EAEAEA00E9E9E900A4A4A400E7E7E700E9E9E900EDED
      ED00F1F1F100F4F4F4006C6C6C00E4E4E400E3E3E300E2E2E200E1E1E100E1E1
      E100E0E0E000DFDFDF00DEDEDE00DDDDDD00DCDCDC00DBDBDB00DBDBDB00DADA
      DA00D9D9D900D8D8D800D8D8D8006C6C6C008F8F8F00F9F9F900F8F8F800F8F8
      F800F8F8F800F8F8F800F7F7F700F7F7F700F6F6F600F5F5F500F4F4F4008F8F
      8F00DDDDDD00E0E0E0007D7D7D00CACACA00C3C3C3005454540024242400ECEC
      EC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5E500E4E4
      E400E4E4E400E2E2E200E2E2E200242424008F8F8F00F9F9F900F9F9F900A3A3
      A300A3A3A300A3A3A300F7F7F700A3A3A300A3A3A300A3A3A300A3A3A300F3F3
      F300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300E9E9E900A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300E2E2E200E1E1E100232323008F8F8F00F9F9F900F9F9F900A4A4
      A400A4A4A400A4A4A400F7F7F700F7F7F700F6F6F600F5F5F500F4F4F400F3F3
      F300F2F2F200A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E8E8E800A4A4A400A4A4A400A4A4A400A4A4
      A400E3E3E300E2E2E200E1E1E100242424009A9A9A00EDEDED00EDEDED00ECEC
      EC00EBEBEB00EBEBEB00EAEAEA00EAEAEA00A4A4A400E3E3E300E7E7E700E9E9
      E900EDEDED00F1F1F1006C6C6C00E5E5E500E4E4E400E3E3E300E2E2E200E1E1
      E100E1E1E100E0E0E000DFDFDF00DEDEDE00DDDDDD00DCDCDC00DBDBDB00DBDB
      DB00DADADA00D9D9D900D8D8D8006C6C6C008F8F8F00F9F9F900F9F9F900F8F8
      F800F8F8F800F8F8F800F8F8F800F7F7F700F7F7F700F6F6F600F5F5F5008F8F
      8F00DBDBDB00DDDDDD007D7D7D00CFCFCF00C8C8C800C2C2C20054545400EDED
      ED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6E600E5E5
      E500E4E4E400E4E4E400E2E2E200242424008F8F8F00F9F9F900F9F9F900A3A3
      A300F8F8F800A3A3A300F8F8F800A3A3A300A3A3A300A3A3A300A3A3A300F3F3
      F300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300E9E9E900A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300E3E3E300E2E2E200232323008F8F8F00F9F9F900F9F9F900A4A4
      A400F8F8F800A4A4A400F8F8F800F7F7F700F7F7F700F6F6F600F5F5F500F4F4
      F400F3F3F300A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E9E9E900A4A4A400A4A4A400A4A4A400A4A4
      A400E4E4E400E3E3E300E2E2E200242424009A9A9A00EEEEEE00EDEDED00EDED
      ED00BBBBBB00EBEBEB00BBBBBB00EAEAEA00A4A4A400E0E0E000E3E3E300E7E7
      E700E9E9E900EDEDED006C6C6C00E6E6E600E5E5E500E4E4E400E3E3E300E2E2
      E200E1E1E100E1E1E100E0E0E000DFDFDF00DEDEDE00DDDDDD00DCDCDC00DBDB
      DB00DBDBDB00DADADA00D9D9D9006C6C6C008F8F8F00F9F9F900F9F9F900F9F9
      F900F8F8F800F8F8F800F8F8F800F8F8F800F7F7F700F7F7F700F6F6F6008F8F
      8F00D9D9D9007D7D7D00DADADA00D4D4D400CDCDCD00C6C6C600C1C1C1005454
      5400EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7E700E6E6
      E600E5E5E500E4E4E400E4E4E400242424008F8F8F00F9F9F900F9F9F900A3A3
      A300A3A3A300A3A3A300F8F8F800A3A3A300A3A3A300A3A3A300A3A3A300F5F5
      F500A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300EAEAEA00A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300E4E4E400E3E3E300232323008F8F8F00F9F9F900F9F9F900A4A4
      A400A4A4A400A4A4A400F8F8F800F8F8F800F7F7F700F7F7F700F6F6F600F5F5
      F500F4F4F400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400EAEAEA00A4A4A400A4A4A400A4A4A400A4A4
      A400E5E5E500E4E4E400E3E3E300242424009A9A9A00EEEEEE00EEEEEE00EDED
      ED00EDEDED00ECECEC00EBEBEB00EBEBEB00A4A4A400DDDDDD00E0E0E000E3E3
      E300E7E7E700E9E9E9006C6C6C00E6E6E600E6E6E600E5E5E500E4E4E400E3E3
      E300E2E2E200E1E1E100E1E1E100E0E0E000DFDFDF00DEDEDE00DDDDDD00DCDC
      DC00DBDBDB00DBDBDB00DADADA006C6C6C008F8F8F00F9F9F900F9F9F900F9F9
      F900F9F9F900F8F8F800F8F8F800F8F8F800F8F8F800F7F7F700F7F7F7008F8F
      8F008F8F8F007D7D7D00DDDDDD007D7D7D007D7D7D007D7D7D00C5C5C500BFBF
      BF0054545400EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7
      E700E6E6E600E5E5E500E4E4E400242424008F8F8F00F9F9F900F9F9F900F9F9
      F900F9F9F900F9F9F900F8F8F800F8F8F800F8F8F800F7F7F700F7F7F700F6F6
      F600F5F5F500F3F3F300F3F3F300F2F2F200F0F0F000F0F0F000EFEFEF00EEEE
      EE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E9E9E900E8E8E800E7E7
      E700E6E6E600E5E5E500E4E4E400232323008F8F8F00F9F9F900F9F9F900F9F9
      F900F9F9F900F9F9F900F8F8F800F8F8F800F8F8F800F7F7F700F7F7F700F6F6
      F600F5F5F500F4F4F400F3F3F300F2F2F200F1F1F100F0F0F000EFEFEF00EEEE
      EE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8E800E7E7
      E700E6E6E600E5E5E500E4E4E400242424009A9A9A00EFEFEF00EEEEEE00EEEE
      EE00EDEDED00EDEDED00ECECEC00EBEBEB00A4A4A400DBDBDB00DDDDDD00E0E0
      E000E3E3E300E7E7E7006C6C6C00E6E6E600E6E6E600E6E6E600E5E5E500E4E4
      E400E3E3E300E2E2E200E1E1E100E1E1E100E0E0E000DFDFDF00DEDEDE00DDDD
      DD00DCDCDC00DBDBDB00DBDBDB006C6C6C008F8F8F00F9F9F900F9F9F900F9F9
      F900F9F9F900F9F9F900F8F8F800F8F8F800F8F8F800F8F8F800F7F7F700F7F7
      F7007D7D7D00E5E5E5007D7D7D00F3F3F300F1F1F1007D7D7D007D7D7D00C4C4
      C400BEBEBE0054545400E9E9E900ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8
      E800E7E7E700E6E6E600E5E5E500242424008F8F8F00F9F9F900F9F9F900F9F9
      F900F9F9F900F9F9F900F9F9F900F8F8F800F8F8F800F8F8F800F7F7F700F7F7
      F700F6F6F600F5F5F500F3F3F300F3F3F300F2F2F200F0F0F000F0F0F000EFEF
      EF00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E9E9E900E8E8
      E800E7E7E700E6E6E600E5E5E500232323008F8F8F00FAFAFA00F9F9F900F9F9
      F900F9F9F900F9F9F900F9F9F900F8F8F800F8F8F800F8F8F800F7F7F700F7F7
      F700F6F6F600F5F5F500F4F4F400F3F3F300F2F2F200F1F1F100F0F0F000EFEF
      EF00EEEEEE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E8E8
      E800E7E7E700E6E6E600E5E5E500242424009A9A9A00EFEFEF00EFEFEF00EEEE
      EE00EEEEEE00EDEDED00EDEDED00ECECEC00A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E7E7E700E6E6E600E6E6E600E6E6E600E5E5
      E500E4E4E400E3E3E300E2E2E200E1E1E100E1E1E100E0E0E000DFDFDF00DEDE
      DE00DDDDDD00DCDCDC00DBDBDB006C6C6C008F8F8F00FAFAFA00F9F9F900F9F9
      F900F9F9F900F9F9F900F9F9F900F8F8F800F8F8F800F8F8F800F8F8F800F7F7
      F7007D7D7D007D7D7D00F5F5F500F4F4F400F3F3F300F2F2F200F1F1F1007D7D
      7D00C3C3C300BDBDBD0054545400EBEBEB00ECECEC00EBEBEB00EAEAEA00E9E9
      E900E8E8E800E7E7E700E6E6E600242424008F8F8F00FAFAFA00F9F9F900F9F9
      F900F9F9F900F9F9F900F9F9F900F9F9F900F8F8F800F8F8F800F8F8F800F7F7
      F700F7F7F700F6F6F600F5F5F500F3F3F300F3F3F300F2F2F200F0F0F000F0F0
      F000EFEFEF00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9E900E9E9
      E900E8E8E800E7E7E700E6E6E600232323008F8F8F00FAFAFA00FAFAFA00F9F9
      F900F9F9F900F9F9F900F9F9F900F9F9F900F8F8F800F8F8F800F8F8F800F7F7
      F700F7F7F700F6F6F600F5F5F500F4F4F400F3F3F300F2F2F200F1F1F100F0F0
      F000EFEFEF00EEEEEE00EEEEEE00EDEDED00ECECEC00EBEBEB00EAEAEA00E9E9
      E900E8E8E800E7E7E700E6E6E600242424009A9A9A00C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C9006C6C6C008F8F8F00C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C9007D7D7D00CACACA00C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900CACA
      CA007D7D7D007D7D7D00BBBBBB0054545400CACACA00C9C9C900C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900242424008F8F8F00C8C8C800C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8
      C800C8C8C800C8C8C800C8C8C800232323008F8F8F00CACACA00CACACA00CACA
      CA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACA
      CA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACA
      CA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACA
      CA00CACACA00CACACA00CACACA00242424009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A006C6C6C008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F007D7D7D00BABABA00545454008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F00242424008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F00232323008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F00242424009A9A9A00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB009A9A9A00DBDBDB00DBDBDB006C6C6C008F8F8F00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00D9D9D9007D7D7D00B8B8B80054545400DBDBDB00DBDB
      DB008F8F8F00DBDBDB00DBDBDB00242424008F8F8F00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB008F8F8F00DBDBDB00DBDBDB00DBDBDB00DBDBDB008F8F
      8F00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB008F8F8F00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB00232323008F8F8F00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB008F8F8F00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB008F8F8F00DBDBDB00DBDBDB00DBDBDB00DBDB
      DB00DBDBDB00DBDBDB00DBDBDB00242424009A9A9A00E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600DBDB
      DB009A9A9A00E6E6E600E6E6E6006C6C6C008F8F8F00E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E6007D7D7D007D7D7D00E6E6E600DBDB
      DB008F8F8F00E6E6E600E6E6E600242424008F8F8F00E6E6E600E6E6E600E6E6
      E600E6E6E600DBDBDB008F8F8F00E6E6E600E6E6E600E6E6E600DBDBDB008F8F
      8F00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600DBDBDB008F8F8F00E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600232323008F8F8F00E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600DBDB
      DB008F8F8F00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600DBDBDB008F8F8F00E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600242424009A9A9A00F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6
      E6009A9A9A00F2F2F200F2F2F2006C6C6C008F8F8F00F1F1F100F1F1F100F1F1
      F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1
      F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1
      F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100E6E6
      E6008F8F8F00F1F1F100F1F1F100242424008F8F8F00F1F1F100F1F1F100F1F1
      F100F1F1F100E6E6E6008F8F8F00F1F1F100F1F1F100F1F1F100E6E6E6008F8F
      8F00F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F1F1
      F100F1F1F100E6E6E6008F8F8F00F1F1F100F1F1F100F1F1F100F1F1F100F1F1
      F100F1F1F100F1F1F100F1F1F100232323008F8F8F00F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E6E6
      E6008F8F8F00F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200E6E6E6008F8F8F00F2F2F200F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200242424009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A009A9A9A008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000101
      0113000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006969
      69BB323232FF626262FB7B7B7BDD1B1B1B590000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B00E0E0E000DFDFDF00DFDF
      DF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADADA00D9D9D900D9D9
      D900D8D8D800D7D7D700D6D6D600D6D6D600D5D5D500D4D4D400D4D4D400D3D3
      D300D3D3D300D2D2D200D1D1D100D1D1D100D0D0D000D0D0D000D0D0D000CFCF
      CF00CFCFCF00CECECE00CECECE006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      73F16A6A6AFFA0A0A0FF2A2A2AFF323232A70000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B00E1E1E100E0E0E000DFDF
      DF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADADA00BCBC
      BC00D9D9D900D8D8D800D7D7D700D6D6D600D6D6D600A4A4A4006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D00D1D1D100D0D0D000D0D0D000D0D0
      D000CFCFCF00CFCFCF00CECECE006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005F5F5FFF393939FF393939FF3939
      39FF393939FF393939FF393939FF000000000000000000000000000000004E4E
      4EFEADADADFFF3F3F3FF5E5E5EFF121212550000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A5FF585858FF585858FF5858
      58FF585858FF585858FF585858FF585858FF585858FF585858FF585858FF5858
      58FF585858FF585858FF00000000000000009B9B9B00E2E2E200E1E1E100E0E0
      E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADA
      DA00D9D9D900D9D9D900D8D8D800D7D7D700D6D6D600A4A4A400E7E7E700EAEA
      EA00EEEEEE00F2F2F200F4F4F4006D6D6D00D1D1D100D1D1D100D0D0D000D0D0
      D000D0D0D000CFCFCF00CFCFCF006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005F5F5FFFADADADFFA3A3A3FF9B9B
      9BFF939393FF8B8B8BFF393939FF000000000000000000000000010101133535
      35FFDADADAFFF3F3F3FF5E5E5EFF212121620000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A5FFA2A2A2FFA0A0A0FF9E9E
      9EFF9B9B9BFF999999FF979797FF959595FF949494FF939393FF919191FF9090
      90FF8F8F8FFF585858FF00000000000000009B9B9B00E3E3E300E2E2E200E1E1
      E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00BCBC
      BC00DADADA00BCBCBC00D9D9D900BCBCBC00D7D7D700A4A4A400E3E3E300E7E7
      E700EAEAEA00EEEEEE00F2F2F2006D6D6D00D2D2D200D1D1D100D1D1D100D0D0
      D000D0D0D000CFCFCF00CFCFCF006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005F5F5FFFBABABAFFB1B1B1FFA8A8
      A8FF9F9F9FFF969696FF393939FF000000000000000000000000424242903D3D
      3DFFF7F7F7FFD0D0D0FF3A3A3AFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A5FFA6A6A6FFA4A4A4FFA1A1
      A1FF9F9F9FFF9D9D9DFF9B9B9BFF999999FF969696FF959595FF949494FF9292
      92FF919191FF585858FF00000000000000009B9B9B00E3E3E300E3E3E300E2E2
      E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDC
      DC00DBDBDB00DADADA00D9D9D900D9D9D900D8D8D800A4A4A400E1E1E100E3E3
      E300E7E7E700EAEAEA00EEEEEE006D6D6D00D3D3D300D2D2D200D1D1D100D1D1
      D100D0D0D000D0D0D000CFCFCF006D6D6D000000000038383896585858FF5858
      58FF585858FF585858FF38383896000000000000000038383896585858FF5858
      58FF585858FF585858FF585858FF383838960000000000000000000000000000
      000038383896585858FF585858FF585858FF585858FF585858FF383838960000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000636363FF313131FF313131FF5F5F5FFFC8C8C8FFBEBEBEFFB5B5
      B5FFABABABFFA3A3A3FF393939FF000000000000000000000000797979E46262
      62FFFBFBFBFF9E9E9EFF5B5B5BFC000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A5FF585858FF5858
      58FF585858FF585858FF585858FF585858FFA5A5A5FFAAAAAAFFA8A8A8FFA5A5
      A5FFA3A3A3FFA1A1A1FF9F9F9FFF9C9C9CFF9A9A9AFF989898FF969696FF9595
      95FF939393FF585858FF00000000000000009B9B9B00E4E4E400E3E3E300E3E3
      E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00BCBC
      BC00DCDCDC00DBDBDB00DADADA00D9D9D900D9D9D900A4A4A400DEDEDE00E1E1
      E100E3E3E300E7E7E700EAEAEA006D6D6D00D3D3D300D3D3D300D2D2D200D1D1
      D100D1D1D100D0D0D000D0D0D0006D6D6D0000000000585858FFC9C9C9FFC9C9
      C9FFC8C8C8FFC7C7C7FF585858FF0000000000000000585858FFBFBFBFFFBEBE
      BEFFBDBDBDFFBCBCBCFFBBBBBBFF585858FF0000000000000000383838965858
      58FF585858FFC5C5C5FFC3C3C3FFC2C2C2FFC1C1C1FFC0C0C0FF585858FF5858
      58FF383838960000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000636363FFD8D8D8FFD5D5D5FF5F5F5FFFD4D4D4FFCCCCCCFFC2C2
      C2FFB9B9B9FFB0B0B0FF393939FF0000000000000000000000005F5F5FFCA1A1
      A1FFFBFBFBFF686868FF797979E4000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A5FFCECECEFFCDCD
      CDFFCCCCCCFFCBCBCBFFCACACAFFC9C9C9FFA5A5A5FFAFAFAFFFACACACFFA9A9
      A9FFA7A7A7FFA5A5A5FFA3A3A3FFA0A0A0FF9E9E9EFF9C9C9CFF999999FF9797
      97FF959595FF585858FF00000000000000009B9B9B00E5E5E500E4E4E400E3E3
      E300E3E3E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDD
      DD00DCDCDC00DCDCDC00DBDBDB00DADADA00D9D9D900A4A4A400DCDCDC00DEDE
      DE00E1E1E100E3E3E300E7E7E7006D6D6D00D4D4D400D3D3D300D3D3D300D2D2
      D200D1D1D100D1D1D100D0D0D0006D6D6D0000000000585858FFCBCBCBFFCACA
      CAFFC9C9C9FFC9C9C9FF585858FF0000000038383896585858FFC1C1C1FFC0C0
      C0FFBFBFBFFFBEBEBEFF585858FF383838960000000038383896585858FFC9C9
      C9FFC9C9C9FFC8C8C8FFC6C6C6FFC4C4C4FFC3C3C3FFC1C1C1FFC0C0C0FFBFBF
      BFFF585858FF3838389600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000636363FFDDDDDDFFD9D9D9FF5F5F5FFFE0E0E0FFD8D8D8FFD0D0
      D0FFC7C7C7FFBDBDBDFF393939FF000000000000000000000000494949FF3B3B
      3BFF717171FF373737FF4040408E000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A5FFCFCFCFFFCECE
      CEFFCDCDCDFFCCCCCCFFCBCBCBFFCACACAFFA5A5A5FFB3B3B3FFB1B1B1FFAEAE
      AEFFABABABFFA8A8A8FFA6A6A6FFA4A4A4FFA2A2A2FFA0A0A0FF9D9D9DFF9B9B
      9BFF999999FF585858FF00000000000000009B9B9B00E6E6E600E5E5E500E4E4
      E400E3E3E300E3E3E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDFDF00BCBC
      BC00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADADA00A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400A4A4A400D4D4D400D4D4D400D3D3D300D3D3
      D300D2D2D200D1D1D100D1D1D1006D6D6D0000000000585858FFCECECEFFCCCC
      CCFFCACACAFFC9C9C9FF585858FF38383896585858FFC5C5C5FFC3C3C3FFC2C2
      C2FFC0C0C0FF585858FF383838960000000000000000585858FFCCCCCCFFCACA
      CAFFC9C9C9FFC9C9C9FFC8C8C8FFC6C6C6FFC4C4C4FFC3C3C3FFC1C1C1FFC0C0
      C0FFBFBFBFFF585858FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000606060FF3F3F
      3FFF3F3F3FFF636363FFE1E1E1FFDEDEDEFF5F5F5FFFB4B4B4FF808080FF7C7C
      7CFF7B7B7BFF9F9F9FFF393939FF000000000000000016161650282828FF3232
      32FF282828FF313131FF00000010000000000000000000000000A5A5A5FF5858
      58FF585858FF585858FF585858FF585858FF585858FFA5A5A5FFD0D0D0FFD0D0
      D0FFCFCFCFFFCECECEFFCDCDCDFFCCCCCCFFA5A5A5FFB7B7B7FFB5B5B5FFB3B3
      B3FFB0B0B0FFADADADFFABABABFFA8A8A8FFA5A5A5FFA3A3A3FFA1A1A1FF9F9F
      9FFF9D9D9DFF585858FF00000000000000009B9B9B00E6E6E600E6E6E600E5E5
      E500E4E4E400E3E3E300E3E3E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDF
      DF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADADA00D9D9D900D9D9
      D900D8D8D800D7D7D700D6D6D600D6D6D600D5D5D500D4D4D400D4D4D400D3D3
      D300D3D3D300D2D2D200D1D1D1006D6D6D0000000000585858FFD0D0D0FFCFCF
      CFFFCDCDCDFFCBCBCBFF585858FF585858FFC9C9C9FFC7C7C7FFC5C5C5FFC3C3
      C3FFC2C2C2FF585858FF000000000000000038383896585858FFCFCFCFFFCDCD
      CDFFCBCBCBFFC9C9C9FFC9C9C9FFC8C8C8FFC7C7C7FFC5C5C5FFC3C3C3FFC2C2
      C2FFC1C1C1FF585858FF38383896000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000606060FFCCCC
      CCFFCACACAFF636363FFE5E5E5FFE2E2E2FF5F5F5FFFBABABAFF828282FF8181
      81FF7D7D7DFFA8A8A8FF393939FF0000000000000000767676CB1D1D1DFF3434
      34FF2C2C2CFF5D5D5DFE00000000000000000000000000000000A5A5A5FFD3D3
      D3FFD3D3D3FFD1D1D1FFD0D0D0FFCFCFCFFFCFCFCFFFA5A5A5FFD2D2D2FFD1D1
      D1FFD0D0D0FFD0D0D0FFCFCFCFFFCECECEFFA5A5A5FFBCBCBCFFB9B9B9FFB6B6
      B6FFB4B4B4FFB2B2B2FFAFAFAFFFACACACFFAAAAAAFFA7A7A7FFA5A5A5FFA3A3
      A3FFA1A1A1FF585858FF00000000000000009B9B9B00E7E7E700E6E6E600E6E6
      E600E5E5E500E4E4E400E3E3E300E3E3E300E2E2E200E1E1E100E0E0E000BCBC
      BC00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADADA00D9D9
      D900D9D9D900D8D8D800D7D7D700D6D6D600D6D6D600D5D5D500D4D4D400D4D4
      D400D3D3D300D3D3D300D2D2D2006D6D6D0000000000585858FFD3D3D3FFD1D1
      D1FFCFCFCFFFCECECEFF585858FFCACACAFFC9C9C9FFC9C9C9FFC8C8C8FFC6C6
      C6FF585858FF383838960000000000000000585858FFD3D3D3FFD1D1D1FFCFCF
      CFFFCDCDCDFFCBCBCBFF585858FF585858FF585858FFC7C7C7FFC6C6C6FFC4C4
      C4FFC3C3C3FFC1C1C1FF585858FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000606060FFD2D2
      D2FFCFCFCFFF636363FFE9E9E9FFE6E6E6FF5F5F5FFFFAFAFAFFF7F7F7FFF1F1
      F1FFEBEBEBFFE3E3E3FF393939FF00000000000000007F7F7FF7232323FF3434
      34FF212121FF838383F300000000000000000000000000000000A5A5A5FFD6D6
      D6FFD5D5D5FFD3D3D3FFD2D2D2FFD1D1D1FFD0D0D0FFA5A5A5FFD3D3D3FFD2D2
      D2FFD1D1D1FFD0D0D0FFD0D0D0FFCFCFCFFFA5A5A5FFC0C0C0FFBDBDBDFFBBBB
      BBFFB8B8B8FFB6B6B6FFB4B4B4FFB1B1B1FFAEAEAEFFABABABFFA9A9A9FFA7A7
      A7FFA4A4A4FF585858FF00000000000000009B9B9B00E8E8E800E7E7E700E6E6
      E600E6E6E600E5E5E500E4E4E400E3E3E300E3E3E300E2E2E200E1E1E100E0E0
      E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00A4A4A4006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D00D6D6D600D6D6D600D5D5D500D4D4
      D400D4D4D400D3D3D300D3D3D3006D6D6D0000000000585858FFD5D5D5FFD3D3
      D3FFD2D2D2FFD0D0D0FF585858FFCCCCCCFFCBCBCBFFC9C9C9FFC9C9C9FF5858
      58FF38383896000000000000000000000000585858FFD5D5D5FFD3D3D3FFD2D2
      D2FFCFCFCFFF585858FF383838960000000038383896585858FFC8C8C8FFC6C6
      C6FFC4C4C4FFC3C3C3FF585858FF000000000000000000000000000000008A8A
      8AFF656565FF656565FF00000000000000000000000000000000767676FF6363
      63FF626262FF636363FFD1D1D1FF909090FF5F5F5FFF5F5F5FFF5F5F5FFF5F5F
      5FFF5F5F5FFF5F5F5FFF5F5F5FFF0000000000000000565656FF2D2D2DFF3434
      34FF1D1D1DFF686868BA00000000000000000000000000000000A5A5A5FFD7D7
      D7FFD7D7D7FFD5D5D5FFD4D4D4FFD3D3D3FFD2D2D2FFA5A5A5FFD6D6D6FFD4D4
      D4FFD3D3D3FFD2D2D2FFD1D1D1FFD0D0D0FFA5A5A5FFC4C4C4FFC2C2C2FFC0C0
      C0FFBDBDBDFFBABABAFFB8B8B8FFB5B5B5FFB3B3B3FFB0B0B0FFADADADFFABAB
      ABFFA8A8A8FF585858FF00000000000000009B9B9B00E9E9E900E8E8E800E7E7
      E700E6E6E600E6E6E600E5E5E500E4E4E400E3E3E300E3E3E300E2E2E200BCBC
      BC00E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00A4A4A400E7E7E700EAEA
      EA00EEEEEE00F2F2F200F4F4F4006D6D6D00D7D7D700D6D6D600D6D6D600D5D5
      D500D4D4D400D4D4D400D3D3D3006D6D6D0000000000585858FFD7D7D7FFD5D5
      D5FFD4D4D4FFD2D2D2FFD1D1D1FFCFCFCFFFCDCDCDFFCBCBCBFFCACACAFF5858
      58FF585858FF383838960000000000000000585858FFD6D6D6FFD5D5D5FFD4D4
      D4FFD2D2D2FF585858FF000000000000000000000000585858FFC9C9C9FFC8C8
      C8FFC7C7C7FFC5C5C5FF585858FF000000000000000000000000000000008787
      87FFD1D1D1FFC0C0C0FF646464FF656565FF7C7C7CFF898989FFB6B6B6FFC3C3
      C3FF626262FF636363FFD4D4D4FF919191FF909090FF8F8F8FFFCCCCCCFF3131
      31FF0000000000000000000000000000000005050526323232FF343434FF3535
      35FF2A2A2AFF0F0F0F4100000000000000000000000000000000A5A5A5FFDADA
      DAFFD9D9D9FFD7D7D7FFD6D6D6FFD5D5D5FFD4D4D4FFA5A5A5FFD8D8D8FFD7D7
      D7FFD5D5D5FFD4D4D4FFD3D3D3FFD2D2D2FFA5A5A5FFC8C8C8FFC6C6C6FFC4C4
      C4FFC1C1C1FFBFBFBFFFBCBCBCFFB9B9B9FFB7B7B7FFB5B5B5FFB2B2B2FFAFAF
      AFFFACACACFF585858FF00000000000000009B9B9B00E9E9E900E9E9E900E8E8
      E800E7E7E700E6E6E600E6E6E600E5E5E500E4E4E400E3E3E300E3E3E300E2E2
      E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00A4A4A400E3E3E300E7E7
      E700EAEAEA00EEEEEE00F2F2F2006D6D6D00D8D8D800D7D7D700D6D6D600D6D6
      D600D5D5D500D4D4D400D4D4D4006D6D6D0000000000585858FFD9D9D9FFD7D7
      D7FFD6D6D6FFD5D5D5FFD3D3D3FFD2D2D2FFCFCFCFFFCECECEFFCCCCCCFFCACA
      CAFFC9C9C9FF585858FF3838389600000000585858FFD9D9D9FFD7D7D7FFD5D5
      D5FFD4D4D4FF585858FF000000000000000000000000585858FFCACACAFFC9C9
      C9FFC9C9C9FFC7C7C7FF585858FF000000000000000000000000000000008181
      81FFCACACAFFD3D3D3FFCECECEFFB6B6B6FFB4B4B4FFC7C7C7FFC7C7C7FFBDBD
      BDFF6F6F6FFF636363FFF3F3F3FFF1F1F1FFEEEEEEFFECECECFFE9E9E9FF3131
      31FF00000000000000000000000000000000555555A41E1E1EFF343434FF3030
      30FF4D4D4DFF0000000000000000000000000000000000000000A5A5A5FFDCDC
      DCFFDBDBDBFFDADADAFFD8D8D8FFD7D7D7FFD6D6D6FFA5A5A5FFDADADAFFD8D8
      D8FFD7D7D7FFD7D7D7FFD5D5D5FFD4D4D4FFA5A5A5FFCCCCCCFFCACACAFFC8C8
      C8FFC5C5C5FFC3C3C3FFC0C0C0FFBEBEBEFFBCBCBCFFB9B9B9FFB6B6B6FFB4B4
      B4FFB1B1B1FF585858FF00000000000000009B9B9B00EAEAEA00E9E9E900E9E9
      E900E8E8E800E7E7E700E6E6E600E6E6E600E5E5E500E4E4E400E3E3E300BCBC
      BC00E2E2E200BCBCBC00E0E0E000BCBCBC00DFDFDF00A4A4A400E1E1E100E3E3
      E300E7E7E700EAEAEA00EEEEEE006D6D6D00D9D9D900D8D8D800D7D7D700D6D6
      D600D6D6D600D5D5D500D4D4D4006D6D6D0000000000585858FFDADADAFFDADA
      DAFFD8D8D8FFD6D6D6FFD5D5D5FFD4D4D4FFD2D2D2FFD0D0D0FFCFCFCFFFCDCD
      CDFFCBCBCBFFC9C9C9FF585858FF38383896585858FFDADADAFFD9D9D9FFD7D7
      D7FFD6D6D6FF585858FF000000000000000000000000585858FFCCCCCCFFCACA
      CAFFC9C9C9FFC9C9C9FF585858FF000000000000000000000000000000008181
      81FFC4C4C4FFD3D3D3FFCECECEFFCECECEFFCCCCCCFFC7C7C7FFC7C7C7FFB9B9
      B9FF7C7C7CFF636363FF636363FF636363FF636363FF636363FF636363FF6363
      63FF00000000000000000000000000000000878787ED1C1C1CFF343434FF2525
      25FF777777FA0000000000000000000000000000000000000000A5A5A5FFDEDE
      DEFFDDDDDDFFDCDCDCFFDBDBDBFFD9D9D9FFD8D8D8FFA5A5A5FFDBDBDBFFDADA
      DAFFD9D9D9FFD8D8D8FFD7D7D7FFD6D6D6FFA5A5A5FFD0D0D0FFCECECEFFCCCC
      CCFFC9C9C9FFC7C7C7FFC4C4C4FFC2C2C2FFC0C0C0FFBDBDBDFFBBBBBBFFB8B8
      B8FFB5B5B5FF585858FF00000000000000009B9B9B00EBEBEB00EAEAEA00E9E9
      E900E9E9E900E8E8E800E7E7E700E6E6E600E6E6E600E5E5E500E4E4E400E3E3
      E300E3E3E300E2E2E200E1E1E100E0E0E000DFDFDF00A4A4A400DEDEDE00E1E1
      E100E3E3E300E7E7E700EAEAEA006D6D6D00D9D9D900D9D9D900D8D8D800D7D7
      D700D6D6D600D6D6D600D5D5D5006D6D6D0000000000585858FFDCDCDCFFDBDB
      DBFFDADADAFFD9D9D9FF585858FF585858FF585858FF585858FFD1D1D1FFCFCF
      CFFFCDCDCDFFCCCCCCFFCACACAFF585858FF585858FFDCDCDCFFDADADAFFDADA
      DAFFD8D8D8FF585858FF000000000000000000000000585858FFCECECEFFCCCC
      CCFFCACACAFFC9C9C9FF585858FF000000000000000000000000000000008D8D
      8DFFB8B8B8FFD8D8D8FFD1D1D1FFCECECEFFCBCBCBFFC9C9C9FFCACACAFFADAD
      ADFF878787FF8C8C8CFF8B8B8BFFC9C9C9FF3F3F3FFF00000000000000000000
      000000000000000000000000000000000000626262FE3B3B3BFF2A2A2AFF1C1C
      1CFF7F7F7FDA0000000000000000000000000000000000000000A5A5A5FFE0E0
      E0FFDFDFDFFFDEDEDEFFDDDDDDFFDCDCDCFFDADADAFFA5A5A5FFDEDEDEFFDCDC
      DCFFDBDBDBFFDADADAFFD9D9D9FFD8D8D8FFA5A5A5FFD4D4D4FFA5A5A5FF7E7E
      7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFF7E7E
      7EFFBABABAFF585858FF00000000000000009B9B9B00EBEBEB00EBEBEB00EAEA
      EA00E9E9E900E9E9E900E8E8E800E7E7E700E6E6E600E6E6E600E5E5E500BCBC
      BC00E3E3E300E3E3E300E2E2E200E1E1E100E0E0E000A4A4A400DCDCDC00DEDE
      DE00E1E1E100E3E3E300E7E7E7006D6D6D00DADADA00D9D9D900D9D9D900D8D8
      D800D7D7D700D6D6D600D6D6D6006D6D6D0000000000585858FFDEDEDEFFDDDD
      DDFFDBDBDBFFDADADAFF585858FF000000000000000038383896585858FFD2D2
      D2FFD0D0D0FFCECECEFFCCCCCCFF585858FF585858FFDDDDDDFFDCDCDCFFDBDB
      DBFFDADADAFF585858FF000000000000000000000000585858FFD0D0D0FFCFCF
      CFFFCDCDCDFFCBCBCBFF585858FF000000000000000000000000000000008585
      85FFCECECEFFDDDDDDFFD5D5D5FFD2D2D2FFCECECEFFCBCBCBFFCBCBCBFFBBBB
      BBFF636363FFEDEDEDFFEBEBEBFFE8E8E8FF3F3F3FFF00000000000000000000
      000000000000000000000000000000000000343434FFDEDEDEFFE3E3E3FF2C2C
      2CFF2D2D2D740000000000000000000000000000000000000000A5A5A5FFE2E2
      E2FFE1E1E1FFE0E0E0FFDFDFDFFFDEDEDEFFDDDDDDFFA5A5A5FFDFDFDFFFDEDE
      DEFFDDDDDDFFDBDBDBFFDBDBDBFFDADADAFFA5A5A5FFD7D7D7FFA5A5A5FFD1D1
      D1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FF7E7E
      7EFFBEBEBEFF585858FF00000000000000009B9B9B00EBEBEB00EBEBEB00EBEB
      EB00EAEAEA00E9E9E900E9E9E900E8E8E800E7E7E700E6E6E600E6E6E600E5E5
      E500E4E4E400E3E3E300E3E3E300E2E2E200E1E1E100A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400A4A4A400DBDBDB00DADADA00D9D9D900D9D9
      D900D8D8D800D7D7D700D6D6D6006D6D6D0000000000585858FFE0E0E0FFDFDF
      DFFFDDDDDDFFDCDCDCFF585858FF000000000000000000000000585858FFD4D4
      D4FFD2D2D2FFD1D1D1FFCFCFCFFF585858FF585858FFDFDFDFFFDEDEDEFFDCDC
      DCFFDBDBDBFF585858FF000000000000000000000000585858FFD3D3D3FFD1D1
      D1FFCFCFCFFFCDCDCDFF585858FF000000000000000000000000828282FFD2D2
      D2FFE7E7E7FFDFDFDFFFDCDCDCFFD8D8D8FFD3D3D3FFCFCFCFFFCBCBCBFFCCCC
      CCFFB9B9B9FF636363FF606060FF606060FF606060FF00000000000000000000
      00000000000000000000000000002828286D393939FFF5F5F5FFDBDBDBFF3838
      38FF000000040000000000000000000000000000000000000000A5A5A5FFE4E4
      E4FFE3E3E3FFE2E2E2FFE1E1E1FFE0E0E0FFDFDFDFFFA5A5A5FFE1E1E1FFE0E0
      E0FFDFDFDFFFDEDEDEFFDCDCDCFFDBDBDBFFA5A5A5FFD9D9D9FFA5A5A5FFD1D1
      D1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FF7E7E
      7EFFC3C3C3FF585858FF00000000000000009B9B9B00ECECEC00EBEBEB00EBEB
      EB00EBEBEB00EAEAEA00E9E9E900E9E9E900E8E8E800E7E7E700E6E6E600BCBC
      BC00E5E5E500E4E4E400E3E3E300E3E3E300E2E2E200E1E1E100E0E0E000DFDF
      DF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADADA00D9D9
      D900D9D9D900D8D8D800D7D7D7006D6D6D0000000000585858FFE2E2E2FFE0E0
      E0FFDFDFDFFFDEDEDEFF585858FF000000000000000038383896585858FFD5D5
      D5FFD5D5D5FFD3D3D3FFD1D1D1FF585858FF585858FFE1E1E1FFE0E0E0FFDEDE
      DEFFDDDDDDFF585858FF000000000000000000000000585858FFD5D5D5FFD3D3
      D3FFD2D2D2FFCFCFCFFF585858FF0000000000000000888888FFD7D7D7FFF2F2
      F2FFE9E9E9FFE6E6E6FFE3E3E3FFDEDEDEFFD9D9D9FFD3D3D3FFCFCFCFFFCBCB
      CBFFCECECEFFB9B9B9FF636363FF000000000000000000000000000000000000
      0000000000000000000000000000767676D85C5C5CFFFBFBFBFFAAAAAAFF5252
      52FE000000000000000000000000000000000000000000000000A5A5A5FFE7E7
      E7FFE5E5E5FFE4E4E4FFE3E3E3FFE1E1E1FFE1E1E1FFA5A5A5FFE2E2E2FFA5A5
      A5FF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFFA5A5A5FFDCDCDCFFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFC6C6C6FF585858FF00000000000000009B9B9B00EDEDED00ECECEC00EBEB
      EB00EBEBEB00EBEBEB00EAEAEA00E9E9E900A4A4A4006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D00E3E3E300E3E3E300E2E2E200E1E1E100E0E0
      E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDBDB00DADA
      DA00D9D9D900D9D9D900D8D8D8006D6D6D0000000000585858FFE3E3E3FFE2E2
      E2FFE1E1E1FFE0E0E0FF585858FF585858FF585858FF585858FFDADADAFFD8D8
      D8FFD6D6D6FFD5D5D5FFD4D4D4FF585858FF585858FFE2E2E2FFE1E1E1FFE0E0
      E0FFDFDFDFFF585858FF000000000000000000000000585858FFD6D6D6FFD5D5
      D5FFD4D4D4FFD2D2D2FF585858FF00000000929292FFB5B5B5FFE7E7E7FFECEC
      ECFFF2F2F2FFF1F1F1FFE9E9E9FFE3E3E3FFDFDFDFFFD8D8D8FFD6D6D6FFD0D0
      D0FFC8C8C8FFC2C2C2FF9F9F9FFF888888FF0000000000000000000000000000
      0000000000000000000000000000656565FA919191FFFBFBFBFF737373FF7676
      76EE000000000000000000000000000000000000000000000000A5A5A5FFE9E9
      E9FFE8E8E8FFE6E6E6FFE5E5E5FFE4E4E4FFE2E2E2FFA5A5A5FFE3E3E3FFA5A5
      A5FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFA5A5A5FFDEDEDEFFDDDDDDFFDBDB
      DBFFDADADAFFD8D8D8FFD7D7D7FFD5D5D5FFD3D3D3FFD1D1D1FFCFCFCFFFCDCD
      CDFFCBCBCBFF585858FF00000000000000009B9B9B00EDEDED00EDEDED00ECEC
      EC00EBEBEB00EBEBEB00EBEBEB00EAEAEA00A4A4A400E7E7E700EAEAEA00EEEE
      EE00F2F2F200F4F4F4006D6D6D00E4E4E400E3E3E300E3E3E300E2E2E200E1E1
      E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDCDC00DBDB
      DB00DADADA00D9D9D900D9D9D9006D6D6D0000000000585858FFE5E5E5FFE4E4
      E4FFE2E2E2FFE1E1E1FFE0E0E0FFDFDFDFFFDDDDDDFFDCDCDCFFDBDBDBFFDADA
      DAFFD9D9D9FFD7D7D7FFD5D5D5FF585858FF585858FFE4E4E4FFE3E3E3FFE2E2
      E2FFE0E0E0FF585858FF000000000000000000000000585858FFD9D9D9FFD7D7
      D7FFD5D5D5FFD4D4D4FF585858FF00000000000000009A9A9AFF8F8F8FFF8E8E
      8EFF919191FFB8B8B8FFEEEEEEFFEAEAEAFFE4E4E4FFDDDDDDFFA9A9A9FF8787
      87FF828282FF868686FF8F8F8FFF0707072E303030867C7C7CFF141414540000
      0000000000000000000000000000414141FFCDCDCDFFFBFBFBFF474747FF5959
      59AD000000000000000000000000000000000000000000000000A5A5A5FFEBEB
      EBFFEAEAEAFFE9E9E9FFE8E8E8FFE6E6E6FFE5E5E5FFA5A5A5FFE5E5E5FFA5A5
      A5FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFA5A5A5FFDFDFDFFFDFDFDFFFDEDE
      DEFFDCDCDCFFDBDBDBFFD9D9D9FFD8D8D8FFD6D6D6FFD4D4D4FFD3D3D3FFD1D1
      D1FFCFCFCFFF585858FF00000000000000009B9B9B00EDEDED00EDEDED00EDED
      ED00ECECEC00EBEBEB00EBEBEB00EBEBEB00A4A4A400E3E3E300E7E7E700EAEA
      EA00EEEEEE00F2F2F2006D6D6D00E5E5E500E4E4E400E3E3E300E3E3E300E2E2
      E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDCDC00DCDC
      DC00DBDBDB00DADADA00D9D9D9006D6D6D0000000000585858FFE6E6E6FFE5E5
      E5FFE4E4E4FFE3E3E3FFE2E2E2FFE1E1E1FFDFDFDFFFDEDEDEFFDDDDDDFFDBDB
      DBFFDADADAFFD9D9D9FF585858FF38383896585858FFE5E5E5FFE4E4E4FFE3E3
      E3FFE2E2E2FF585858FF000000000000000000000000585858FFDADADAFFD9D9
      D9FFD7D7D7FFD6D6D6FF585858FF000000000000000000000000000000000000
      000000000000888888FFD2D2D2FFF1F1F1FFEBEBEBFFC6C6C6FF6B6B6BFF0202
      0219949494FFB8B8B8FF787878FD808080FDAAAAAAFF909090FF1E1E1E6D0000
      0000000000000000000000000000191919FFC3C3C3FFE6E6E6FF313131FF0707
      072D000000000000000000000000000000000000000000000000A5A5A5FFEDED
      EDFFA5A5A5FF7E7E7EFF7E7E7EFF7E7E7EFF7E7E7EFFA5A5A5FFE6E6E6FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFDFDFDFFFDFDFDFFFDFDF
      DFFFDFDFDFFFDDDDDDFFDCDCDCFFDADADAFFD9D9D9FFD7D7D7FFD6D6D6FFD4D4
      D4FFD2D2D2FF585858FF00000000000000009B9B9B00EEEEEE00EDEDED00EDED
      ED00BCBCBC00ECECEC00BCBCBC00EBEBEB00A4A4A400E1E1E100E3E3E300E7E7
      E700EAEAEA00EEEEEE006D6D6D00E6E6E600E5E5E500E4E4E400E3E3E300E3E3
      E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDDDD00DCDC
      DC00DCDCDC00DBDBDB00DADADA006D6D6D0000000000585858FFE8E8E8FFE6E6
      E6FFE5E5E5FFE5E5E5FFE3E3E3FFE2E2E2FFE1E1E1FFE0E0E0FFDFDFDFFFDDDD
      DDFFDCDCDCFF585858FF3838389600000000585858FFE6E6E6FFE5E5E5FFE5E5
      E5FFE3E3E3FF585858FF000000000000000000000000585858FFDCDCDCFFDADA
      DAFFDADADAFFD8D8D8FF585858FF000000000000000000000000000000000000
      000000000000000000009B9B9BFFF4F4F4FFEDEDEDFF797979FF000000000101
      01188C8C8CFDD1D1D1FFCDCDCDFFC6C6C6FFC7C7C7FF999999FF1E1E1E670000
      00000000000000000000000000006F6F6FF9444444FF2D2D2DFF484848FF0000
      0000000000000000000000000000000000000000000000000000A5A5A5FFEFEF
      EFFFA5A5A5FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFA5A5A5FFE7E7E7FFE6E6
      E6FFE5E5E5FFE5E5E5FFE4E4E4FFE3E3E3FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FF00000000000000009B9B9B00EFEFEF00EEEEEE00EDED
      ED00EDEDED00EDEDED00ECECEC00EBEBEB00A4A4A400DEDEDE00E1E1E100E3E3
      E300E7E7E700EAEAEA006D6D6D00E6E6E600E6E6E600E5E5E500E4E4E400E3E3
      E300E3E3E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDEDE00DDDD
      DD00DCDCDC00DCDCDC00DBDBDB006D6D6D0000000000585858FFE8E8E8FFE8E8
      E8FFE7E7E7FFE6E6E6FFE5E5E5FFE4E4E4FFE3E3E3FFE2E2E2FFE0E0E0FF5858
      58FF585858FF383838960000000000000000585858FFE8E8E8FFE7E7E7FFE6E6
      E6FFE5E5E5FF585858FF000000000000000000000000585858FFDDDDDDFFDCDC
      DCFFDBDBDBFFDADADAFF585858FF000000000000000000000000000000000000
      000000000000000000008D8D8DFFDBDBDBFFD8D8D8FF8A8A8AFF000000000000
      000F8C8C8CFDD2D2D2FFCECECEFFC8C8C8FFC8C8C8FF939393FF191919610000
      0000000000000000000000000000000000000000000008080830434343900000
      0000000000000000000000000000000000000000000000000000A5A5A5FFF1F1
      F1FFA5A5A5FFD1D1D1FFD1D1D1FFD1D1D1FFD1D1D1FFA5A5A5FFE7E7E7FFE7E7
      E7FFE6E6E6FFE6E6E6FFE5E5E5FFE5E5E5FFE4E4E4FFE3E3E3FFE2E2E2FFE1E1
      E1FFE1E1E1FFE0E0E0FF585858FF000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B00EFEFEF00EFEFEF00EEEE
      EE00EDEDED00EDEDED00EDEDED00ECECEC00A4A4A400DCDCDC00DEDEDE00E1E1
      E100E3E3E300E7E7E7006D6D6D00E7E7E700E6E6E600E6E6E600E5E5E500E4E4
      E400E3E3E300E3E3E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDFDF00DEDE
      DE00DDDDDD00DCDCDC00DCDCDC006D6D6D000000000038383896585858FF5858
      58FF585858FF585858FF585858FF585858FF585858FF585858FF585858FF3838
      38960000000000000000000000000000000038383896585858FF585858FF5858
      58FF585858FF3838389600000000000000000000000038383896585858FF5858
      58FF585858FF585858FF38383896000000000000000000000000000000000000
      00000000000000000000000000009E9E9EFF9C9C9CFF00000000000000069B9B
      9BFFCACACAFFDFDFDFFFD5D5D5FFCDCDCDFFC9C9C9FFC0C0C0FF696969E20C0C
      0C45666666E35F5F5FED2D2D2DA76E6E6EE9575757EA01010128000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5FFF1F1
      F1FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFE7E7E7FFE7E7
      E7FFE7E7E7FFE7E7E7FFE6E6E6FFE6E6E6FFE5E5E5FFE4E4E4FFE4E4E4FFE3E3
      E3FFE2E2E2FFE1E1E1FF585858FF000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B00F0F0F000EFEFEF00EFEF
      EF00EEEEEE00EDEDED00EDEDED00EDEDED00A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400E8E8E800E7E7E700E6E6E600E6E6E600E5E5
      E500E4E4E400E3E3E300E3E3E300E2E2E200E1E1E100E0E0E000DFDFDF00DFDF
      DF00DEDEDE00DDDDDD00DCDCDC006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5FFA4A4A4FF000000009B9B9BFFBFBF
      BFFFEFEFEFFFEBEBEBFFE2E2E2FFD6D6D6FFD1D1D1FFC9C9C9FFB5B5B5FF6B6B
      6BF0838383FFBBBBBBFFAEAEAEFFBDBDBDFF737373E402020227000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5FFF3F3
      F3FFF2F2F2FFF1F1F1FFF1F1F1FFF1F1F1FFEFEFEFFFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FF000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B00CACACA00CACACA00CACA
      CA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACA
      CA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACA
      CA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACA
      CA00CACACA00CACACA00CACACA006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001F1F1F658E8E
      8EFF8E8E8EFF919191FFEAEAEAFFE6E6E6FFADADADFF828282FF828282FF4747
      47A7838383FFDADADAFFDBDBDBFFCDCDCDFF757575E902020229000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5FFF3F3
      F3FFF3F3F3FFF2F2F2FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0F0FFEFEFEFFFEEEE
      EEFFEDEDEDFFECECECFFEBEBEBFF585858FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001C1C1C63C8C8C8FFDEDEDEFF888888FF00000001000000009B9B
      9BFFCECECEFFEEEEEEFFDBDBDBFFD6D6D6FFB7B7B7FF7E7E7EFF000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5FFF3F3
      F3FFF3F3F3FFF3F3F3FFF3F3F3FFF2F2F2FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0
      F0FFEFEFEFFFEDEDEDFFEDEDEDFF585858FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDCDC00DCDC
      DC009B9B9B00DCDCDC00DCDCDC006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000E9B9B9BFFAAAAAAF91111114A00000000000000009B9B
      9BFF9B9B9BFFB8B8B8F5EBEBEBFFB2B2B2FF999999FF4B4B4BBD000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5
      A5FFA5A5A5FFA5A5A5FFA5A5A5FFA5A5A5FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B00E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700DCDC
      DC009B9B9B00E7E7E700E7E7E7006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002A2A2A76A4A4A4FF0000000000000000000000000000
      00120101011B9B9B9BFFBFBFBFFFA4A4A4FF0101011C00000012000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B00F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200E7E7
      E7009B9B9B00F2F2F200F2F2F2006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000E0E0E4D8D8D8DFF121212570000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000003000000110000002700000035000000380000
      0035000000270000001100000003000000000000000000000000000000000000
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
      00000000000000000000000000080000002700000054000000730000007B0000
      0073000000540000002700000008000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000979797FF7979
      79FF797979FF797979FF797979FF797979FF797979FF5E5E5EFF5E5E5EFF5E5E
      5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E
      5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E5EFF5E5E
      5EFF5E5E5EFF5E5E5EFF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000009090936343434E1272727EA2828
      28E7282828E7262626E7262626E7262626E7262626E7262626E7262626E72727
      27E7272727E7262626E9303030E81111114A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B858585FF858585FF858585FF858585FF8585
      85FF00000073000000350000000B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000979797FF5E5E
      5ECC5C5C5CCC595959CC585858CC565656CC545454CC525252CC515151CC4F4F
      4FCC4E4E4ECC4D4D4DCC4C4C4CCC4A4A4ACC4A4A4ACC494949CC494949CC4949
      49CC494949CC494949CC545454DB737373FF737373FF737373FF737373FF7373
      73FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000004F4F4FB13B3B3BFF3D3D3DFF4040
      40FF3E3E3EFF3E3E3EFF404040FF3F3F3FFF3E3E3EFF3F3F3FFF3D3D3DFF3A3A
      3AFF383838FF343434FF353535FF5F5F5FC30000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B858585FFB9B9B9FFB6B6B6FFB3B3B3FF8585
      85FF0000007B000000380000000B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000979797FF9797
      97FFD8D8D8FFBEBEBEFFBEBEBEFFBEBEBEFFBEBEBEFFA4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4
      A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4A4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000777777FD636363FF858585FF7C7C
      7CFF8B8B8BFF848484FF7E7E7EFF7A7A7AFF787878FF737373FF676767FF7E7E
      7EFF7E7E7EFF767676FF5F5F5FFF797979FC0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000030000
      00080000000B0000000B00000016858585FFBDBDBDFFB9B9B9FFB6B6B6FF8585
      85FF01010180000000430000001A0000000F0000000F0000000C000000070000
      0004000000040000000400000004000000040000000400000004000000040000
      0004000000040000000400000003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000979797FF9A9A
      9AFFE9E9E9FFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFE7E7E7FFE6E6E6FFE6E6
      E6FFE5E5E5FFE5E5E5FFDADADAFFCCCCCCFFE4E4E4FFE4E4E4FFE4E4E4FFE4E4
      E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6DFD686868FF8D8D8DFF7B7B
      7BFF979797FF868686FF808080FF7B7B7BFF797979FF747474FF616161FF8888
      88FF7E7E7EFF777777FF606060FF6B6B6BFC0000000000000000000000000000
      0000000000000000000000000000000000000000000000000003000000110000
      0027000000350000003800000040858585FFC0C0C0FFBDBDBDFFB9B9B9FF8585
      85FF0101019B0000007400000059000000530000005000000044000000310000
      0025000000220000002200000022000000220000002200000022000000220000
      0022000000220000002200000006000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000979797FF9D9D
      9DFFEAEAEAFFE9E9E9FFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFE7E7E7FFE6E6
      E6FFE6E6E6FFE5E5E5FFDBDBDBFFC5C5C5FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4
      E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000737373FF787878FF959595FF7E7E
      7EFF707070FF737373FF7A7A7AFF7C7C7CFF7D7D7DFF777777FF696969FF6161
      61FF676767FF717171FF616161FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000008000000270000
      0054000000730000007B0000007E858585FFC2C2C2FFC0C0C0FFBDBDBDFF8585
      85FF222222FF292929FF2D2D2DFF2E2E2EFF303030FF3A3A3AFF494949FF5252
      52FF555555FF555555FF555555FF555555FF555555FF555555FF555555FF5555
      55FF555555FF555555FF00000009000000000000000038383896595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF383838960000000038383896595959FF595959FF595959FF595959FF3838
      3896000000000000000000000000000000000000000038383896595959FF5959
      59FF595959FF595959FF38383896000000000000000000000000979797FFA0A0
      A0FFEBEBEBFFEAEAEAFFE9E9E9FFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFE7E7
      E7FFE6E6E6FFE6E6E6FFDBDBDBFFCCCCCCFFE5E5E5FFE5E5E5FFE4E4E4FFE4E4
      E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000797979FF808080FF979797FF8787
      87FF7E7E7EFF818181FF848484FF838383FF848484FF808080FF727272FF6D6D
      6DFF6D6D6DFF6E6E6EFF565656FF6D6D6DFF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000B9F9F9FFF8585
      85FF858585FF858585FF858585FF858585FFC5C5C5FFC2C2C2FFC0C0C0FF8585
      85FF858585FF858585FF858585FF858585FF858585FF787878FFACACACFFD0D0
      D0FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9
      D9FFD9D9D9FF555555FF000000090000000000000000595959FFC5C5C5FFC5C5
      C5FFC3C3C3FFC2C2C2FFC1C1C1FFC0C0C0FFBFBFBFFFBEBEBEFFBDBDBDFFBDBD
      BDFF595959FF00000000595959FFD0D0D0FFCFCFCFFFCECECEFFCCCCCCFF5959
      59FF0000000000000000000000000000000038383896595959FFC1C1C1FFC0C0
      C0FFBFBFBFFFBEBEBEFF595959FF000000000000000000000000979797FFA4A4
      A4FFEBEBEBFFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFE6E6E6FFDBDBDBFFC5C5C5FFE5E5E5FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE4E4E4FFE4E4E4FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000777777FF525252FF626262FF6767
      67FF636363FF6B6B6BFF7C7C7CFF6E6E6EFF686868FF525252FF3E3E3EFF3939
      39FF343434FF313131FF2A2A2AFF6D6D6DFF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000B9F9F9FFFD7D7
      D7FFD4D4D4FFD1D1D1FFCDCDCDFFCBCBCBFFC8C8C8FFC5C5C5FFC2C2C2FFC0C0
      C0FFBDBDBDFFB9B9B9FFB6B6B6FFB3B3B3FF858585FF767676FFB1B1B1FFD8D8
      D8FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFC8C8C8FFC7C7
      C7FFC5C5C5FFC4C4C4FFC3C3C3FFC2C2C2FFC1C1C1FFC0C0C0FFBFBFBFFFBEBE
      BEFF595959FF00000000595959FFD2D2D2FFD0D0D0FFD0D0D0FFCECECEFF5959
      59FF00000000000000000000000000000000595959FFC4C4C4FFC3C3C3FFC2C2
      C2FFC1C1C1FFBFBFBFFF595959FF000000000000000000000000979797FFA7A7
      A7FFECECECFFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFDCDCDCFFCCCCCCFFE6E6E6FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE4E4E4FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000707070FF5B5B5BFFC0C0C0FFA1A1
      A1FFA0A0A0FFA5A5A5FFAAAAAAFFA8A8A8FFA6A6A6FFA2A2A2FF9E9E9EFF9E9E
      9EFF9C9C9CFFBDBDBDFF646464FF6D6D6DFF0000000000000000000000000000
      000000000000000000000000000000000000000000000000000B9F9F9FFFD9D9
      D9FFD7D7D7FFD4D4D4FFD1D1D1FFCDCDCDFFCBCBCBFFC8C8C8FFC5C5C5FFC2C2
      C2FFC0C0C0FFBDBDBDFFB9B9B9FFB6B6B6FF858585FF515151FF717171FF8787
      87FF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFCACACAFFC9C9
      C9FFC8C8C8FFC7C7C7FFC5C5C5FFC4C4C4FFC3C3C3FFC2C2C2FFC1C1C1FFBFBF
      BFFF595959FF00000000595959FFD4D4D4FFD2D2D2FFD0D0D0FFD0D0D0FF5959
      59FF00000000000000000000000038383896595959FFC5C5C5FFC4C4C4FFC3C3
      C3FFC2C2C2FFC1C1C1FF595959FF000000000000000000000000979797FFAAAA
      AAFFEDEDEDFFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFDCDCDCFFC5C5C5FFE6E6E6FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE4E4E4FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6DFF808080FF898989FF1D1D
      1DFF242424FF242424FF232323FF242424FF252525FF242424FF242424FF2626
      26FF222222FF686868FF909090FF6D6D6DFF0000000000000000000000000000
      00000000000000000000000000000000000000000000000000089F9F9FFFDBDB
      DBFFD9D9D9FFD7D7D7FFD4D4D4FFD1D1D1FFCDCDCDFFCBCBCBFFC8C8C8FFC5C5
      C5FFC2C2C2FFC0C0C0FFBDBDBDFFB9B9B9FF858585FF3C3C3CFF4C4C4CFF5656
      56FF595959FF6B6B6BFFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFCDCDCDFFCBCB
      CBFFCACACAFFC9C9C9FFC8C8C8FFC6C6C6FFC5C5C5FFC4C4C4FFC3C3C3FFC1C1
      C1FF595959FF00000000595959FFD5D5D5FFD4D4D4FFD2D2D2FFD1D1D1FF5959
      59FF000000000000000000000000595959FFC9C9C9FFC7C7C7FFC6C6C6FFC5C5
      C5FFC3C3C3FFC2C2C2FF595959FF000000000000000000000000979797FFAEAE
      AEFFEDEDEDFFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFE9E9E9FFE8E8E8FFDCDCDCFFCCCCCCFFE7E7E7FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6DFF808080FFE5E5E5FFEBEB
      EBFFFCFCFCFFFCFCFCFFFBFBFBFFFCFCFCFFFBFBFBFFFCFCFCFFFCFCFCFFF0F0
      F0FFE6E6E6FFDEDEDEFF898989FF6D6D6DFF0000000000000000000000000000
      00000000000000000000000000000000000000000000000000039F9F9FFF9F9F
      9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFFD1D1D1FFCDCDCDFFCBCBCBFF8585
      85FF858585FF858585FF858585FF858585FF858585FF545454FF5C5C5CFF6060
      60FF626262FF5F5F5FFF3B3B3BFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFCFCFCFFFCECE
      CEFFCDCDCDFFCBCBCBFF595959FF595959FF595959FF595959FF595959FF5959
      59FF3838389600000000595959FFD7D7D7FFD6D6D6FFD4D4D4FFD3D3D3FF5959
      59FF000000000000000038383896595959FFCBCBCBFFC9C9C9FFC8C8C8FFC6C6
      C6FFC5C5C5FFC4C4C4FF595959FF000000000000000000000000979797FFB1B1
      B1FFF3F3F3FFEDEDEDFFEDEDEDFFECECECFFECECECFFEBEBEBFFEBEBEBFFEAEA
      EAFFE9E9E9FFE9E9E9FFDCDCDCFFC5C5C5FFE7E7E7FFE7E7E7FFE6E6E6FFE6E6
      E6FFE6E6E6FFE5E5E5FFE5E5E5FFE5E5E5FFE4E4E4FFE4E4E4FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6DFF828282FFE9E9E9FFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFBFBFBFFFCFC
      FCFFF2F2F2FFE5E5E5FF929292FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000030000
      00080000000B0000000B000000169F9F9FFFD4D4D4FFD1D1D1FFCDCDCDFF8585
      85FF737373FFAAAAAAFF545454FF999999FF9A9A9AFF858585FF808080FF8585
      85FF818181FF959595FFA4A4A4FF5E5E5EFFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFD1D1D1FFD0D0
      D0FFCFCFCFFFCECECEFF595959FF000000000000000000000000000000000000
      00000000000000000000595959FFD9D9D9FFD7D7D7FFD6D6D6FFD4D4D4FF5959
      59FF0000000038383896595959FFCECECEFFCCCCCCFFCBCBCBFFC9C9C9FFC8C8
      C8FFC7C7C7FFC5C5C5FF595959FF000000000000000000000000979797FFB4B4
      B4FFF3F3F3FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFDCDCDCFFCCCCCCFFE8E8E8FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE4E4E4FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6DFF828282FFF5F5F5FFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFC
      FCFFFCFCFCFFF5F5F5FF949494FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B9F9F9FFFD7D7D7FFD4D4D4FFD1D1D1FF8585
      85FF4C4C4CFF303030FF606060FF676767FF696969FF5E5E5EFF525252FF5555
      55FF515151FF5D5D5DFF6B6B6BFF646464FF3B3B3BFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFD3D3D3FFD2D2
      D2FFD0D0D0FFD0D0D0FF595959FF595959FF595959FF595959FF595959FF5959
      59FF3838389600000000595959FFDBDBDBFFD9D9D9FFD8D8D8FFD6D6D6FF5959
      59FF00000000595959FFD0D0D0FFD0D0D0FFCECECEFFCDCDCDFFCBCBCBFFCACA
      CAFFC8C8C8FFC7C7C7FF595959FF000000000000000000000000979797FFB6B6
      B6FFF3F3F3FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFDCDCDCFFC5C5C5FFE9E9E9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE4E4E4FFA4A4
      A4FF737373FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6DFF838383FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFBFBFBFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFAFA
      FAFFFCFCFCFFFCFCFCFF919191FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000B9F9F9FFFD9D9D9FFD7D7D7FFD4D4D4FF8585
      85FF424242FF6C6C6CFF9E9E9EFFA4A4A4FFAAAAAAFF949494FF7E7E7EFF8080
      80FF7E7E7EFF949494FFA7A7A7FFA4A4A4FF676767FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFD6D6D6FFD4D4
      D4FFD3D3D3FFD2D2D2FFD0D0D0FFD0D0D0FFCECECEFFCDCDCDFFCCCCCCFFCACA
      CAFF595959FF00000000595959FFDCDCDCFFDBDBDBFFDADADAFFD8D8D8FF5959
      59FF38383896595959FFD2D2D2FFD0D0D0FFD0D0D0FF595959FFCDCDCDFFCBCB
      CBFFCACACAFFC8C8C8FF595959FF000000000000000000000000979797FFB9B9
      B9FFF3F3F3FFEFEFEFFFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFEBEBEBFFDCDCDCFFCCCCCCFFE9E9E9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE5E5E5FFE5E5E5FFA4A4
      A4FF757575FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6DFF878787FFF5F5F5FFCDCD
      CDFFE7E7E7FFE7E7E7FFD2D2D2FFCBCBCBFFCACACAFFCBCBCBFFCBCBCBFFD9D9
      D9FFFCFCFCFFFCFCFCFF8A8A8AFF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000089F9F9FFFDBDBDBFFD9D9D9FFD7D7D7FF8585
      85FF454545FF565656FF646464FF686868FF626262FF555555FF505050FF5C5C
      5CFF606060FF666666FF666666FF676767FF646464FF3C3C3CFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFD8D8D8FFD7D7
      D7FFD6D6D6FFD4D4D4FFD3D3D3FFD1D1D1FFD0D0D0FFD0D0D0FFCECECEFFCDCD
      CDFF595959FF00000000595959FFDEDEDEFFDDDDDDFFDBDBDBFFDADADAFF5959
      59FF595959FFD5D5D5FFD4D4D4FFD2D2D2FFD0D0D0FF595959FFCFCFCFFFCDCD
      CDFFCCCCCCFFCACACAFF595959FF000000000000000000000000979797FFBCBC
      BCFFF3F3F3FFB9B9B9FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFEDEDEDFFEDED
      EDFFECECECFFECECECFFDEDEDEFFC5C5C5FFEAEAEAFFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE6E6E6FFE5E5E5FFA4A4
      A4FF777777FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6DFF868686FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFF848484FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000039F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F
      9FFF515151FF959595FFAAAAAAFFB0B0B0FF949494FF808080FF7B7B7BFFACAC
      ACFFA6A6A6FFA5A5A5FFA3A3A3FFA6A6A6FFA2A2A2FF5B5B5BFFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFDBDBDBFFD9D9
      D9FFD8D8D8FFD7D7D7FFD5D5D5FFD4D4D4FFD2D2D2FFD1D1D1FFD0D0D0FFCFCF
      CFFF595959FF00000000595959FFE0E0E0FFDEDEDEFFDDDDDDFFDBDBDBFF5959
      59FFD9D9D9FFD7D7D7FFD6D6D6FFD4D4D4FF595959FF595959FFD0D0D0FFCFCF
      CFFFCDCDCDFFCCCCCCFF595959FF000000000000000000000000979797FFBFBF
      BFFFF3F3F3FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFEEEE
      EEFFEDEDEDFFECECECFFE5E5E5FFCCCCCCFFEBEBEBFFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFE7E7E7FFE7E7E7FFE6E6E6FFE6E6E6FFE6E6E6FFA4A4
      A4FF797979FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F6F6FFF808080FFFCFCFCFFCDCD
      CDFFCCCCCCFFD4D4D4FFFCFCFCFFFCFCFCFFCACACAFFCCCCCCFFCCCCCCFFCCCC
      CCFFFCFCFCFFFCFCFCFF7C7C7CFF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000064F4F4FFFE0E0E0FFCFCFCFFF8282
      82FF3A3A3AFF5F5F5FFF4A4A4AFF4B4B4BFF4E4E4EFF505050FF4A4A4AFF6969
      69FF666666FF666666FF676767FF626262FF636363FF3B3B3BFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFDDDDDDFFDCDC
      DCFFDADADAFFD9D9D9FFD8D8D8FFD6D6D6FFD5D5D5FFD4D4D4FFD2D2D2FFD1D1
      D1FF595959FF00000000595959FFE1E1E1FFE0E0E0FFDFDFDFFFDDDDDDFF5959
      59FFDADADAFFD9D9D9FFD7D7D7FF595959FF38383896595959FFD1D1D1FFD0D0
      D0FFCFCFCFFFCECECEFF595959FF000000000000000000000000979797FFC1C1
      C1FFF3F3F3FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFEDEDEDFFE5E5E5FFC9C9C9FFEBEBEBFFEBEBEBFFEAEAEAFFEAEA
      EAFFE9E9E9FFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFE7E7E7FFE6E6E6FFA4A4
      A4FF7A7A7AFF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000737373FF858585FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFF7F7F7FFFAFAFAFFFCFCFCFFF7F7
      F7FFFCFCFCFFFCFCFCFF797979FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FF696969FF616161FF858585FF828282FF848484FF848484FF7B7B7BFFA9A9
      A9FFA9A9A9FFA8A8A8FF9E9E9EFF989898FFA0A0A0FF5F5F5FFFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFDFDFDFFFDEDE
      DEFFDDDDDDFFDBDBDBFF595959FF595959FF595959FF595959FF595959FF5959
      59FF3838389600000000595959FFE2E2E2FFE1E1E1FFE0E0E0FFDFDFDFFFDDDD
      DDFFDCDCDCFFDBDBDBFFD9D9D9FF595959FF00000000595959FFD3D3D3FFD2D2
      D2FFD0D0D0FFD0D0D0FF595959FF000000000000000000000000979797FFC3C3
      C3FFF3F3F3FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFE5E5E5FFCCCCCCFFECECECFFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE8E8E8FFE7E7E7FFE7E7E7FFA4A4
      A4FF7D7D7DFF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000787878FF8F8F8FFFFCFCFCFFCDCD
      CDFFE7E7E7FFE7E7E7FFD9D9D9FFCBCBCBFFCBCBCBFFD2D2D2FFE7E7E7FFCCCC
      CCFFFCFCFCFFFCFCFCFF797979FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF4F4F4FFF4F4F4FFF606060FF505050FF525252FF545454FF515151FF5959
      59FF5B5B5BFF575757FF5C5C5CFF606060FF414141FF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFE1E1E1FFE0E0
      E0FFDFDFDFFFDEDEDEFF595959FF000000000000000000000000000000000000
      00000000000000000000595959FFE3E3E3FFE2E2E2FFE1E1E1FFE0E0E0FFDFDF
      DFFFDEDEDEFFDCDCDCFF595959FF3838389600000000595959FFD5D5D5FFD3D3
      D3FFD2D2D2FFD0D0D0FF595959FF000000000000000000000000979797FFC4C4
      C4FFF3F3F3FFB9B9B9FFB9B9B9FFF1F1F1FFF1F1F1FFF1F1F1FFF0F0F0FFF0F0
      F0FFEFEFEFFFEEEEEEFFE5E5E5FFC9C9C9FFEDEDEDFFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE7E7E7FFA4A4
      A4FF808080FF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000808080FF9C9C9CFFFAFAFAFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFAFAFAFFFAFAFAFFFAFA
      FAFFFCFCFCFFFCFCFCFF787878FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FF636363FF9B9B9BFFA2A2A2FF838383FF838383FF838383FF8080
      80FF939393FFAEAEAEFFA9A9A9FF9F9F9FFF5D5D5DFFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFE2E2E2FFE2E2
      E2FFE1E1E1FFE0E0E0FF595959FF595959FF595959FF595959FF595959FF5959
      59FF3838389600000000595959FFE5E5E5FFE4E4E4FFE2E2E2FFE1E1E1FFE1E1
      E1FFDFDFDFFF595959FF383838960000000000000000595959FFD7D7D7FFD5D5
      D5FFD4D4D4FFD2D2D2FF595959FF000000000000000000000000979797FFC7C7
      C7FFF3F3F3FFF3F3F3FFF2F2F2FFF2F2F2FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0
      F0FFF0F0F0FFEFEFEFFFE5E5E5FFCCCCCCFFEDEDEDFFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE8E8E8FFE8E8E8FFA4A4
      A4FF838383FF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000808080FF9D9D9DFFFCFCFCFFC6C6
      C6FFC5C5C5FFE5E5E5FFC7C7C7FFE5E5E5FFE5E5E5FFD7D7D7FFC5C5C5FFC5C5
      C5FFFBFBFBFFFCFCFCFF797979FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF8D8D8DFF8D8D8DFF3E3E3EFF606060FF5F5F5FFF575757FF545454FF8383
      83FF575757FF616161FF626262FF3D3D3DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFE5E5E5FFE3E3
      E3FFE2E2E2FFE1E1E1FFE1E1E1FFE0E0E0FFDEDEDEFFDDDDDDFFDCDCDCFFDBDB
      DBFF595959FF00000000595959FFE6E6E6FFE5E5E5FFE4E4E4FFE2E2E2FFE1E1
      E1FFE1E1E1FF595959FF000000000000000000000000595959FFD8D8D8FFD7D7
      D7FFD6D6D6FFD4D4D4FF595959FF000000000000000000000000979797FFC8C8
      C8FFF3F3F3FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFF0F0F0FFE5E5E5FFCACACAFFEEEEEEFFEEEEEEFFEDEDEDFFECEC
      ECFFECECECFFEBEBEBFFEBEBEBFFEAEAEAFFEAEAEAFFE9E9E9FFE8E8E8FFBEBE
      BEFF868686FF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7BFF989898FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFF797979FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FF656565FF767676FF979797FFA3A3A3FFA3A3
      A3FF9A9A9AFF808080FF5F5F5FFFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFE6E6E6FFE5E5
      E5FFE5E5E5FFE3E3E3FFE2E2E2FFE1E1E1FFE1E1E1FFDFDFDFFFDEDEDEFFDDDD
      DDFF595959FF00000000595959FFE6E6E6FFE6E6E6FFE5E5E5FFE4E4E4FFE3E3
      E3FF595959FF38383896000000000000000000000000595959FFDADADAFFD9D9
      D9FFD7D7D7FFD6D6D6FF595959FF000000000000000000000000979797FFC8C8
      C8FFF3F3F3FFB9B9B9FFB9B9B9FFB9B9B9FFF3F3F3FFF2F2F2FFF2F2F2FFF1F1
      F1FFF1F1F1FFF0F0F0FFE5E5E5FFCCCCCCFFEFEFEFFFB9B9B9FFB9B9B9FFB9B9
      B9FFEDEDEDFFECECECFFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFE9E9E9FFBEBE
      BEFF898989FF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000767676FF919191FFFCFCFCFFFCFC
      FCFFFBFBFBFFFAFAFAFFFCFCFCFFFCFCFCFFFCFCFCFFFAFAFAFFFAFAFAFFFBFB
      FBFFFBFBFBFFFCFCFCFF797979FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF505050FF474747FF3F3F3FFF3E3E
      3EFF454545FF4F4F4FFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFE7E7E7FFE6E6
      E6FFE6E6E6FFE5E5E5FFE4E4E4FFE3E3E3FFE2E2E2FFE1E1E1FFE0E0E0FFDFDF
      DFFF595959FF00000000595959FFE8E8E8FFE7E7E7FFE6E6E6FFE5E5E5FFE4E4
      E4FF595959FF00000000000000000000000000000000595959FFDCDCDCFFDBDB
      DBFFD9D9D9FFD8D8D8FF595959FF000000000000000000000000979797FFC8C8
      C8FFF3F3F3FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFF2F2F2FFF2F2
      F2FFF1F1F1FFF1F1F1FFE5E5E5FFCACACAFFEFEFEFFFB9B9B9FFB9B9B9FFB9B9
      B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFB9B9B9FFEAEAEAFFBEBE
      BEFF8C8C8CFF5E5E5EFF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000777777FF8F8F8FFFE6E6E6FFF4F4
      F4FFECECECFFE8E8E8FFE8E8E8FFEBEBEBFFE6E6E6FFE7E7E7FFE6E6E6FFC5C5
      C5FFC8C8C8FFF3F3F3FF797979FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF000000090000000000000000595959FFE9E9E9FFE8E8
      E8FFE7E7E7FFE6E6E6FFE6E6E6FFE5E5E5FFE4E4E4FFE3E3E3FFE2E2E2FFE1E1
      E1FF595959FF00000000595959FFE9E9E9FFE8E8E8FFE7E7E7FFE6E6E6FF5959
      59FF3838389600000000000000000000000000000000595959FFDEDEDEFFDCDC
      DCFFDBDBDBFFD9D9D9FF595959FF000000000000000000000000979797FFC8C8
      C8FFF3F3F3FFF4F4F4FFF4F4F4FFF4F4F4FFF3F3F3FFF3F3F3FFF3F3F3FFF2F2
      F2FFF2F2F2FFF2F2F2FFE5E5E5FFCCCCCCFFF0F0F0FFEDEDEDFFEFEFEFFFEEEE
      EEFFEEEEEEFFEDEDEDFFEDEDEDFFECECECFFECECECFFEBEBEBFFEAEAEAFFBEBE
      BEFF8E8E8EFF5E5E5EFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000007E7E7EFF919191FFDEDEDEFFD8D8
      D8FFC5C5C5FFB8B8B8FFB1B1B1FFB2B2B2FFA6A6A6FFB2B2B2FFACACACFFABAB
      ABFF575757FFD2D2D2FF797979FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000038383896595959FF5959
      59FF595959FF595959FF595959FF595959FF595959FF595959FF595959FF5959
      59FF383838960000000038383896595959FF595959FF595959FF595959FF3838
      3896000000000000000000000000000000000000000038383896595959FF5959
      59FF595959FF595959FF38383896000000000000000000000000979797FFC8C8
      C8FFF3F3F3FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF3F3F3FFF3F3
      F3FFF2F2F2FFF2F2F2FFE5E5E5FFD4D4D4FFF1F1F1FFEDEDEDFFF0F0F0FFEFEF
      EFFFEFEFEFFFEEEEEEFFEDEDEDFFEDEDEDFFECECECFFECECECFFEBEBEBFFEBEB
      EBFF929292FF797979FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C8C8CFF9B9B9BFFEBEBEBFFE2E2
      E2FFE3E3E3FFE4E4E4FFE0E0E0FFDCDCDCFFD7D7D7FFD2D2D2FFCCCCCCFFC9C9
      C9FFC6C6C6FFDBDBDBFF787878FF6D6D6DFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000979797FFC8C8
      C8FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3
      F3FFF3F3F3FFF3F3F3FFF3F3F3FFE0E0E0FFF3F3F3FFF3F3F3FFEDEDEDFFEDED
      EDFFEDEDEDFFEDEDEDFFE0E0E0FFDFDFDFFFDEDEDEFFDDDDDDFFDCDCDCFFDBDB
      DBFF959595FF797979FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000767676E98B8B8BFFA5A5A5FF9B9B
      9BFF9A9A9AFF9A9A9AFF949494FF8B8B8BFF848484FF808080FF757575FF7171
      71FF666666FF626262FF414141FF565656E60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D
      8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFF8D8D8DFFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000979797FFC8C8
      C8FFC8C8C8FFC8C8C8FFC8C8C8FFC8C8C8FFC8C8C8FFC8C8C8FFC7C7C7FFC5C5
      C5FFC4C4C4FFC2C2C2FFC0C0C0FFBEBEBEFFBBBBBBFFB9B9B9FFB6B6B6FFB4B4
      B4FFB1B1B1FFAEAEAEFFABABABFFA8A8A8FFA5A5A5FFA1A1A1FF9E9E9EFF9B9B
      9BFF999999FF797979FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000616161C8808080FF888888FF7373
      73FF6A6A6AFF6D6D6DFF626262FF565656FF565656FF575757FF505050FF4E4E
      4EFF4C4C4CFF4A4A4AFF424242FF5A5A5AC80000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3
      E3FFD9D9D9FF555555FF00000009000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000979797FF9797
      97FF979797FF979797FF979797FF979797FF979797FF979797FF979797FF9797
      97FF979797FF979797FFAEAEAEFFAEAEAEFFAEAEAEFF979797FF979797FF9797
      97FF979797FF979797FF979797FF979797FF979797FF979797FF979797FF9797
      97FF979797FF979797FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000606062A4B4B4BC0555555D44848
      48D1424242D0444444D0424242D0414141D1414141D1424242D1404040D13F3F
      3FD0404040D13F3F3FD3414141C7080808310000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000555555FFF5F5F5FFF4F4F4FFF4F4
      F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF4F4F4FFF5F5F5FFF5F5F5FFF5F5
      F5FFF4F4F4FFF4F4F4FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
      F5FFD9D9D9FF555555FF00000006000000000000000000000000000000000000
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
      000000000000000000000000000000000000555555FF555555FF555555FF5555
      55FF555555FF555555FF555555FF555555FF555555FF555555FF555555FF5555
      55FF555555FF555555FF555555FF555555FF555555FF555555FF555555FF5555
      55FF555555FF555555FF00000003000000000000000000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000E00000000100010000000000000E00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object pmGroups: TPopupMenu
    Images = ilMainMenu
    OwnerDraw = True
    Left = 128
    Top = 328
    object GroupMenuItem: TMenuItem
      OnClick = GroupMenuItemClick
    end
  end
  object BalloonHint1: TBalloonHint
    Left = 456
    Top = 240
  end
  object ilAlphabetNormal: TImageList
    DrawingStyle = dsTransparent
    Left = 576
    Top = 320
  end
  object ilAlphabetActive: TImageList
    DrawingStyle = dsTransparent
    Left = 672
    Top = 320
  end
  object Actions: TActionList
    Images = ilMainMenu
    Left = 576
    Top = 208
    object acShowMainToolbar: TAction
      Category = #1042#1080#1076
      Caption = #1054#1089#1085#1086#1074#1085#1072#1103' '#1087#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
      OnExecute = ShowMainToolbarExecute
      OnUpdate = ShowMainToolbarUpdate
    end
    object acShowEditToolbar: TAction
      Category = #1042#1080#1076
      Caption = #1055#1072#1085#1077#1083#1100' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      Hint = #1055#1072#1085#1077#1083#1100' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      OnExecute = ShowEditToolbarExecute
      OnUpdate = ShowEditToolbarUpdate
    end
    object acShowRusAlphabet: TAction
      Category = #1042#1080#1076
      Caption = #1056#1091#1089#1089#1082#1080#1081' '#1072#1083#1092#1072#1074#1080#1090
      Hint = #1056#1091#1089#1089#1082#1080#1081' '#1072#1083#1092#1072#1074#1080#1090
      OnExecute = ShowRusAlphabetExecute
      OnUpdate = ShowRusAlphabetUpdate
    end
    object acShowEngAlphabet: TAction
      Category = #1042#1080#1076
      Caption = #1040#1085#1075#1083#1080#1081#1089#1082#1080#1081' '#1072#1083#1092#1072#1074#1080#1090
      Hint = #1040#1085#1075#1083#1080#1081#1089#1082#1080#1081' '#1072#1083#1092#1072#1074#1080#1090
      OnExecute = ShowEngAlphabetExecute
      OnUpdate = ShowEngAlphabetUpdate
    end
    object acShowStatusbar: TAction
      Category = #1042#1080#1076
      Caption = #1057#1090#1088#1086#1082#1072' '#1089#1086#1089#1090#1086#1103#1085#1080#1103
      Hint = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1080#1083#1080' '#1089#1082#1088#1099#1090#1080#1077' '#1089#1090#1088#1086#1082#1080' '#1089#1086#1089#1090#1086#1103#1085#1080#1103'.'
      OnExecute = ShowStatusbarExecute
      OnUpdate = ShowStatusbarUpdate
    end
    object acShowBookInfoPanel: TAction
      Category = #1042#1080#1076
      Caption = #1055#1072#1085#1077#1083#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086' '#1082#1085#1080#1075#1077
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100'/'#1057#1087#1088#1103#1090#1072#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086' '#1082#1085#1080#1075#1077
      OnExecute = ShowBookInfoPanelExecute
      OnUpdate = ShowBookInfoPanelUpdate
    end
    object acShowBookCover: TAction
      Category = #1042#1080#1076
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1086#1073#1083#1086#1078#1082#1091
      OnExecute = ShowBookCoverExecute
      OnUpdate = ShowBookCoverUpdate
    end
    object acShowBookAnnotation: TAction
      Category = #1042#1080#1076
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1072#1085#1085#1086#1090#1072#1094#1080#1102
      OnExecute = ShowBookAnnotationExecute
      OnUpdate = ShowBookAnnotationUpdate
    end
    object acBookRead: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1063#1080#1090#1072#1090#1100
      Hint = #1063#1080#1090#1072#1090#1100
      ImageIndex = 12
      OnExecute = ReadBookExecute
    end
    object acBookSend2Device: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1085#1072' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
      ImageIndex = 7
      OnExecute = SendToDeviceExecute
    end
    object acBookAdd2DownloadList: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1089#1087#1080#1089#1086#1082' '#1079#1072#1082#1072#1095#1077#1082
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1086#1095#1077#1088#1077#1076#1100' '#1079#1072#1075#1088#1091#1079#1082#1080
      ImageIndex = 20
      ShortCut = 16460
      OnExecute = Add2DownloadListExecute
    end
    object acBookMarkAsRead: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1055#1088#1086#1095#1080#1090#1072#1085#1085#1086
      OnExecute = MarkAsReadedExecute
    end
    object acBookAdd2Favorites: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1080#1079#1073#1088#1072#1085#1085#1086#1077
      ImageIndex = 13
      OnExecute = acBookAdd2FavoritesExecute
    end
    object acBookAdd2Group: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1075#1088#1091#1087#1087#1091
      OnExecute = acBookAdd2GroupExecute
    end
    object acBookRemoveFromGroup: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079' '#1075#1088#1091#1087#1087#1099
      OnExecute = acBookRemoveFromGroupExecute
    end
    object acBookSetRate1: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = '*'
      OnExecute = BookSetRateExecute
      OnUpdate = UpdateBookAction
    end
    object acBookSetRate2: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = '* *'
      OnExecute = BookSetRateExecute
      OnUpdate = UpdateBookAction
    end
    object acBookSetRate3: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = '* * *'
      OnExecute = BookSetRateExecute
      OnUpdate = UpdateBookAction
    end
    object acBookSetRate4: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = '* * * *'
      OnExecute = BookSetRateExecute
      OnUpdate = UpdateBookAction
    end
    object acBookSetRate5: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = '* * * * *'
      OnExecute = BookSetRateExecute
      OnUpdate = UpdateBookAction
    end
    object acBookSetRateClear: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = BookSetRateExecute
      OnUpdate = UpdateBookAction
    end
    object acGroupCreate: TAction
      Category = #1043#1088#1091#1087#1087#1099
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
      OnExecute = AddGroupExecute
      OnUpdate = AddGroupUpdate
    end
    object acGroupEdit: TAction
      Category = #1043#1088#1091#1087#1087#1099
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1075#1088#1091#1087#1087#1091
      OnExecute = RenameGroupExecute
      OnUpdate = EditGroupUpdate
    end
    object acGroupClear: TAction
      Category = #1043#1088#1091#1087#1087#1099
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1075#1088#1091#1087#1087#1091
      OnExecute = ClearGroupExecute
      OnUpdate = ClearGroupUpdate
    end
    object acGroupDelete: TAction
      Category = #1043#1088#1091#1087#1087#1099
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1075#1088#1091#1087#1087#1091
      OnExecute = DeleteGroupExecute
      OnUpdate = EditGroupUpdate
    end
    object acSavePreset: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1088#1077#1089#1077#1090
      OnExecute = SaveSearchPreset
      OnUpdate = SavePresetUpdate
    end
    object acDeletePreset: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1077#1089#1077#1090
      OnExecute = DeleteSearchPreset
      OnUpdate = DeletePresetUpdate
    end
    object acApplyPreset: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = #1053#1072#1095#1072#1090#1100' '#1087#1086#1080#1089#1082
      OnExecute = DoApplyFilter
    end
    object acClearPreset: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077' '#1087#1086#1083#1103
    end
    object acEditBook: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1085#1080#1075#1077
      OnExecute = EditBookExecute
    end
    object acEditConver2FBD: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' FBD'
      OnExecute = Conver2FBDExecute
    end
    object acEditAutoConver2FBD: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' FBD'
    end
    object acEditAuthor: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1040#1074#1090#1086#1088
      OnExecute = EditAuthorExecute
      OnUpdate = EditAuthorUpdate
    end
    object acEditSerie: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1077#1088#1080#1080
      OnExecute = EditSeriesExecute
      OnUpdate = EditSerieUpdate
    end
    object acEditGenre: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1078#1072#1085#1088#1072
      OnExecute = EditGenresExecute
      OnUpdate = EditGenreUpdate
    end
    object acBookShowInfo: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1085#1080#1075#1077
      OnExecute = ShowBookInfoPanelExecute
    end
    object acBookCopy2Collection: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1082#1086#1083#1083#1077#1082#1094#1080#1102
    end
    object acBookDelete: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 0
      OnExecute = DeleteBookExecute
    end
    object acApplicationExit: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1042#1099#1093#1086#1076
      ImageIndex = 33
      OnExecute = QuitAppExecute
    end
    object acCollectionNew: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1082#1086#1083#1083#1077#1082#1094#1080#1102
      Hint = #1052#1072#1089#1090#1077#1088' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1082#1086#1083#1083#1077#1082#1094#1080#1081
      ImageIndex = 1
      ShortCut = 16462
      OnExecute = ShowNewCollectionWizard
    end
    object acCollectionSelect: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1082#1086#1083#1083#1077#1082#1094#1080#1102
    end
    object acCollectionProperties: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
      ImageIndex = 3
      OnExecute = ShowCollectionSettingsExecute
    end
    object acCollectionStatistics: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
      OnExecute = ShowCollectionStatisticsExecute
    end
    object acCollectionDelete: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = DeleteCollectionExecute
    end
    object acViewTreeView: TAction
      Category = #1042#1080#1076
      Caption = #1042' '#1074#1080#1076#1077' '#1076#1077#1088#1077#1074#1072
      Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1082#1085#1080#1075' '#1074' '#1074#1080#1076#1077' '#1076#1077#1088#1077#1074#1072
    end
    object acViewTableView: TAction
      Category = #1042#1080#1076
      Caption = #1042' '#1074#1080#1076#1077' '#1090#1072#1073#1083#1080#1094#1099
      Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1082#1085#1080#1075' '#1074' '#1074#1080#1076#1077' '#1090#1072#1073#1083#1080#1094#1099
    end
    object acViewSelectColumns: TAction
      Category = #1042#1080#1076
      Caption = #1042#1099#1073#1086#1088' '#1089#1090#1086#1083#1073#1094#1086#1074' '#1074' '#1090#1072#1073#1083#1080#1094#1077'...'
    end
    object acViewHideDeletedBooks: TAction
      Category = #1042#1080#1076
      Caption = #1057#1082#1088#1099#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1082#1085#1080#1075#1080
      Hint = #1057#1082#1088#1099#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      OnExecute = HideDeletedBooksExecute
      OnUpdate = HideDeletedBooksUpdate
    end
    object acViewShowLocalOnly: TAction
      Category = #1042#1080#1076
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1089#1082#1072#1095#1072#1085#1085#1099#1077' '#1082#1085#1080#1075#1080
      Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1089#1082#1072#1095#1072#1085#1085#1099#1077' '#1082#1085#1080#1075#1080
      OnExecute = ShowLocalOnlyExecute
      OnUpdate = ShowLocalOnlyUpdate
    end
    object acToolsQuickSearch: TAction
      Category = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Caption = #1041#1099#1089#1090#1088#1099#1081' '#1087#1086#1080#1089#1082
      OnExecute = QuickSearchExecute
    end
    object acToolsUpdateOnlineCollections: TAction
      Category = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
      OnExecute = UpdateOnlineCollectionExecute
    end
    object acToolsClearReadFolder: TAction
      Category = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1072#1087#1082#1091' '#8220#1044#1083#1103' '#1095#1090#1077#1085#1080#1103#8221
      OnExecute = ClearReadFolderExecute
    end
    object acToolsRunScript: TAction
      Category = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1089#1082#1088#1080#1087#1090
    end
    object acToolsSettings: TAction
      Category = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 11
      OnExecute = ChangeSettingsExecute
    end
    object acHelpHelp: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1057#1087#1088#1072#1074#1082#1072
      Hint = #1057#1087#1088#1072#1074#1082#1072
      ImageIndex = 17
      OnExecute = ShowHelpExecute
    end
    object acHelpCheckUpdates: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1085#1072#1083#1080#1095#1080#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081
      OnExecute = CheckUpdatesExecute
    end
    object acHelpProgramSite: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1057#1072#1081#1090' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      OnExecute = GoSiteExecute
    end
    object acHelpSupportForum: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1060#1086#1088#1091#1084' '#1087#1086#1076#1076#1077#1088#1078#1082#1080
      OnExecute = GoForumExecute
    end
    object acHelpAbout: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnExecute = ShowAboutExecute
    end
    object acImportFb2Zip: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = 'fb2  ('#1080#1079' .zip)'
      Hint = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1085#1080#1075#1080' '#1074' '#1092#1086#1088#1084#1072#1090#1077' FB2 ('#1080#1079' .zip)'
      OnUpdate = ImportFb2Update
    end
    object acImportFb2: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = 'fb2'
      Hint = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1085#1080#1075#1080' '#1074' '#1092#1086#1088#1084#1072#1090#1077' FB2 ('#1080#1079' .zip)'
      OnExecute = ImportFb2Execute
      OnUpdate = ImportFb2Update
    end
    object acImportNonFB2: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = #1085#1077'-fb2'
      Hint = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1085#1080#1075#1080
      OnExecute = ImportNonFB2Execute
      OnUpdate = ImportNonFB2Update
    end
    object acImportFBD: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = 'FBD (pdf.zip djvu.zip)'
      Hint = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1085#1080#1075#1080' '#1074' '#1092#1086#1088#1084#1072#1090#1077' FBD'
      OnExecute = ImportFBDExecute
      OnUpdate = ImportNonFB2Update
    end
    object acImportUserData: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1077' '#1076#1072#1085#1085#1099#1077
      Hint = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1077' '#1076#1072#1085#1085#1099#1077
      OnExecute = ImportUserDataExecute
    end
    object acExport2HTML: TAction
      Tag = 351
      Category = #1069#1082#1089#1087#1086#1088#1090
      Caption = 'html'
      OnExecute = Export2HTMLExecute
    end
    object acExport2Txt: TAction
      Tag = 352
      Category = #1069#1082#1089#1087#1086#1088#1090
      Caption = 'txt'
      OnExecute = Export2HTMLExecute
    end
    object acExport2RTF: TAction
      Tag = 353
      Category = #1069#1082#1089#1087#1086#1088#1090
      Caption = 'RTF'
      OnExecute = Export2HTMLExecute
    end
    object acExport2INPX: TAction
      Category = #1069#1082#1089#1087#1086#1088#1090
      Caption = #1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074' inpx'
      OnExecute = Export2INPXExecute
    end
    object acExportUserData: TAction
      Category = #1069#1082#1089#1087#1086#1088#1090
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1077' '#1076#1072#1085#1085#1099#1077
      OnExecute = ExportUserDataExecute
    end
    object acCollectionUpdateGenres: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082'  '#1078#1072#1085#1088#1086#1074
      OnExecute = UpdateGenresExecute
    end
    object acCollectionSyncFiles: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1092#1072#1081#1083#1099
      ImageIndex = 9
      OnExecute = SyncFilesExecute
    end
    object acCollectionRepair: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100' '#1086#1096#1080#1073#1082#1080
      OnExecute = RepairDataBaseExecute
    end
    object acCollectionCompact: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1057#1078#1072#1090#1100
      OnExecute = CompactDataBaseExecute
    end
    object acViewSetInfoPriority: TAction
      Category = #1042#1080#1076
      Caption = 'acViewSetInfoPriority'
      OnExecute = acViewSetInfoPriorityExecute
    end
  end
  object ilToolImages: TImageList
    ColorDepth = cd32Bit
    Left = 576
    Top = 264
    Bitmap = {
      494C01010A000D00040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000101010F010101170101011A0101
      011A0101011A0101011A0101011A0101011A0101011A0101011A0101011A0101
      011A0101011A0101011A010101170101010F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000101011E0101012E0101016E0101
      01E70303038A0303038A0303038A0303038A0303038A0303038A010101E70101
      01E7010101E7010101E7010101B70101011E01010101010101070101010E0101
      0114010101190101011A010101190101011701010115010101120101010E0101
      010B010101080101010501010102010101010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000101014C010101DB2D2D
      2DF7B9ABABFF444444FF444444FFB5A7A7FFB5A7A7FFB9ABABFF444444FF5656
      56FF535353FF696969FF010101DB00000000010101020101010D0101011B0101
      01280101013101010133010B1464012547CC012446CC010A135D0101011C0101
      01160101010F0101010A01010104010101010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202CE676767FF4040
      40FFBAB1B1FF404040FF404040FFB1A8A8FFB1A8A8FFBAB1B1FF404040FF5656
      56FF4B4B4BFF6B6B6BFF020202CE000000000000000000000000000000000000
      000000000000010A1348012345CC5594B7FF35689AFF012748CA010B14480000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202C9656565FF3C3C
      3CFFC0BBBBFF282828FF282828FFB7B2B2FFB7B2B2FFC0BBBBFF3C3C3CFF5656
      56FF434343FF6D6D6DFF020202C9000000000000000000000000000000000000
      000001152141023859BB3B729FFF39709DFF609FC0FF4679ABFF012C4EC60110
      1B46000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202C5686868FF3838
      38FFC8C7C7FFC3C2C2FFC3C2C2FFC3C2C2FFC3C2C2FFC8C7C7FF383838FF5656
      56FF3B3B3BFF707070FF020202C500000000000000000000000000000000010D
      1948012345CC508DB3FF69ACC8FF4981ACFF5187B3FF6BAAC8FF5688BBFF0132
      54C101121D440000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202C16C6C6CFF3535
      35FF343434FF343434FF343434FF343434FF343434FF343434FF353535FF3535
      35FF353535FF747474FF020202C10000000000000000000000000116223F023D
      60B660A1C0FF407AA3FF4379A7FF67A6C5FF629DC2FF5F95C1FF75B4D1FF6698
      CBFF020202AB0101013C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202BE6F6F6FFF6666
      66FF666666FF666666FF666666FF666666FF666666FF666666FF666666FF6666
      66FF666666FF6F6F6FFF020202BE0000000000000000010D1948012345CC3469
      98FF518CB3FF6AABC8FF68A7C6FF4E81B3FF72B1CEFF6FA9CDFF6DA3CEFF6E6E
      6EFFAA9999FF020202A501152142000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202BB737373FFD4D4
      C9FFF4F4E4FFF4F4E4FFF4F4E4FFF4F4E4FFF4F4E4FFF4F4E4FFF4F4E4FFF4F4
      E4FFD4D4C9FF737373FF020202BB000000000118243E024264B16BAEC9FF67A8
      C5FF5792B8FF4C81AFFF5E97BFFF78B9D2FF679DC8FF7CBAD5FF7F7F7FFFCEC0
      C0FF7A7A7AFF5688BBFF023453A6000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202B8767676FFF6F6
      E9FFECECDFFFECECDFFFECECDFFFECECDFFFECECDFFFECECDFFFECECDFFFECEC
      DFFFF6F6E9FF767676FF020202B80000000002334D830E4F70B8195C7CC32A6C
      8BD05093AEE773B6CEFB6FACCCFF679DC8FF83C7DAFF888888FFD3CACAFF8383
      83FF61A4C6FF64A7C9FF023655A5000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202B57A7A7AFFF8F8
      EFFFF1F1E7FFF1F1E7FFF1F1E7FFF1F1E7FFF1F1E7FFF1F1E7FFF1F1E7FFF1F1
      E7FFF8F8EFFF7A7A7AFF020202B5000000000103040501090D1401101828011A
      2641012E45770C4868AB4186A0DB78B7D3FC919191FFD9D4D4FF8D8D8DFF69AC
      CEFF75B8D4FF023F60B401172340000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202B27D7D7DFFFBFB
      F5FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6F0FFF6F6
      F0FFFBFBF5FF7D7D7DFF020202B2000000000000000000000000000000000000
      00000000000001070A10012B406D01010169DDDCDCFF949494FF71B4D6FF81C4
      DBFF024162B2011650CC01061A48000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202B07F7F7FFFFEFE
      FBFFFBFBF8FFFBFBF8FFFBFBF8FFFBFBF8FFFBFBF8FFFBFBF8FFFBFBF8FFFBFB
      F8FFFEFEFBFF7F7F7FFF020202B0000000000000000000000000000000000000
      0000000000000000000000000000010101240101016788CCDDFF87CBDDFF0243
      65AF012767CC4073B6FF01205DCC010B21480000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000020202AE848484FFFFFF
      FFFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFF
      FEFFFFFFFFFF848484FF020202AE000000000000000000000000000000000000
      000000000000000000000000000000000000010C1239023F5C9C023E5C9C0119
      253E01112848012C6DCC5385C9FF012665CC0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000002020281020202AC3434
      2366343423663434236634342366343423663434236634342366343423663434
      236634342366020202AC02020281000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000001132A48013173CC011128480000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001010103010101110101
      011A0101011A0101011A0101011A0101011A0101011A0101011A0101011A0101
      011A010101130101010400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001010106492502A07B3F
      03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F
      03CC4A2602A10101010700000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F4306CCFFBC
      1FFFFFB914FFFFB812FFFFB711FFFFB70FFFFFB60EFFFFB60DFFFFB60BFFFFB7
      0EFF7F4306CC0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000010101030101010F010101190101
      011A0101011A0101011A0101011A0101011A0101011A0101011A0101011A0101
      011A010101190101010F01010103000000000000000000000000000000000101
      0108010101150101011A0101011A0101011A0101011A0101011A0101011A0101
      01170101010A0101010100000000000000000000000000000000623507998347
      0ACC83470ACC83470ACC83470ACC83470ACC83470ACC83470ACC83470ACC8347
      0ACC623507990000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000010101034A27039F7D4105CC7D41
      05CC7D4105CC7D4105CC7D4105CC7D4105CC7D4105CC7D4105CC7D4105CC7D41
      05CC7D4105CC4A27039F01010103000000000000000000000000000000000101
      01100101012A0101013309050240683605B3683605B309050240010101330101
      012E010101140101010100000000000000000000000000000000000000000000
      0000000000003E23065C884D0ECCF1B944FF884D0ECC3E23065C000000000000
      0000000000000000000000000000000000000101010E01010112010101170101
      011A0101011A0101011A0101011A0101011A0101011A0101011A0101011A0101
      011A0101011A01010117010101120101010E000000003D21055C874B0BCCF9C9
      67FFFAB828FFFBB71DFFFBB519FFFBB415FFFBB312FFFBB210FFFBB20FFFFBB5
      17FF874B0BCC3D21055C00000000000000000000000000000000000000000000
      0000000000000805021573400AAEBF8018E6BF7F17E673400AAE080502150000
      0000000000000000000000000000000000000000000000000000000000000000
      00004126095C8F5313CCE9B960FFD99935FFE7B55AFF8F5313CC4126095C0000
      0000000000000000000000000000000000000101011C01013CA2010161CC0101
      61CC010161CC010161CC010161CC010161CC010161CC010161CC010161CC0101
      61CC010161CC010161CC01013CA20101011C00000000000000004227095C9155
      14CCF8CF81FFE6A53FFFDE9D30FFDD9C2FFFDD9C2FFFDD9C2FFFE6AE48FF9155
      14CC4227095C0000000000000000000000000000000000000000000000000000
      0000100A03157D4911AEC18932E6F1B437FFF0B131FFBF8429E67D4911AE100A
      0315000000000000000000000000000000000000000000000000000000004429
      0B5C945917CCE9BF73FFCD9144FFCD9144FFCD9144FFE3B569FF945917CC4429
      0B5C0000000000000000000000000000000000000000010173CC6060E7FF5353
      DAFF4D4DD4FF4747CEFF4242C9FF3F3FC6FF3E3EC5FF3D3DC4FF3C3CC3FF3B3B
      C2FF3A3AC1FF3B3BC2FF010173CC00000000000000000000000000000000472C
      0D5C9C611DCCFBD98DFFECB368FFE1A75CFFD79C51FFE7BC71FF9C611DCC472C
      0D5C00000000000000000000000000000000000000000000000000000000120C
      0415865419AEC7954CE6E3B25EFFD3953CFFD3953CFFDFA953FFC18B3FE68654
      19AE120C04150000000000000000000000000000000000000000472C0E5C9C60
      1CCCF8D286FFE2B166FFDDAB60FFDCAA5FFFDBA95EFFDAA75CFFE5BA6FFF9C60
      1CCC472C0E5C0000000000000000000000000000000001017FCC6767EEFF5C5C
      E3FF5656DDFF5050D7FF4B4BD2FF4646CDFF4444CBFF4242C9FF4141C8FF4040
      C7FF3F3FC6FF4141C8FF01017FCC000000000000000000000000000000000000
      00004C31115CA86D26CCFEE195FFF8C77CFFFDDE92FFA86D26CC4C31115C0000
      0000000000000000000000000000000000000000000000000000130D0515905D
      20AED1A45AE6F7CB80FFEAAF64FFE0A55AFFD69B50FFD1954AFFDDAC61FFC995
      4CE6905D20AE130D0515000000000000000000000000000000007A4D1899A367
      21CCA36721CCA36721CCA36721CCA36721CCA36721CCA36721CCA36721CCA367
      21CC7A4D18990000000000000000000000000000000001016599010187CC0101
      87CC010187CC010187CC010187CC010187CC010187CC010187CC010187CC0101
      87CC010187CC010187CC01016599000000000000000000000000000000000000
      0000000000005136155CB3772ECCFFE599FFB3772ECC5136155C000000000000
      00000000000000000000000000000000000000000000140D0615996627AED8AA
      5FE6FEDE92FFFCD68AFFFCD68AFFFCD68AFFFCD68AFFFCD589FFFCD589FFFDDA
      8EFFD8A85DE6996627AE140D0615000000000000000000000000000000000000
      0000000000004C31115CA86D26CCFCDA8EFFA86D26CC4C31115C000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005439175CBB7F33CC5439175C00000000000000000000
      000000000000000000000000000000000000000000002F200D33BB7F33CCBB7F
      33CCBB7F33CCBB7F33CCBB7F33CCBB7F33CCBB7F33CCBB7F33CCBB7F33CCBB7F
      33CCBB7F33CCBB7F33CC2F200D33000000000000000000000000000000000000
      00005035145CAF732ACCFEE094FFF4BE73FFFDDE92FFAF732ACC5035145C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005237
      165CB4782ECCFFE498FFFAC97EFFFAC97EFFFAC97EFFFFE195FFB4782ECC5237
      165C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005439175CB77C
      31CCFFE599FFFEDB8FFFFEDB8FFFFEDB8FFFFEDB8FFFFEDB8FFFFFE498FFB77C
      31CC5439175C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C5F2799BB7F
      34CCBB7F34CCBB7F34CCBB7F34CCBB7F34CCBB7F34CCBB7F34CCBB7F34CCBB7F
      34CC8C5F27990000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000010101120101012C101005721717
      0787171707871717078717170787171707871717078717170787171707871717
      078717170787101005720101012C010101120000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000001010109010101161E1E0D82FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFEFDFFFEFEFCFFFDFDFBFFFDFDFAFFFCFC
      F8FFFEFEF9FF1E1E0D8201010116010101090000000000000000000000000101
      0104010101160101011A0101011801010114010101100101010C010101040000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001010103010101110101
      011A0101011A0101011A0101011A0101011A0101011A0101011A0101011A0101
      011A0101011301010104000000000000000000000000000000002424137BFFFF
      FFFFFFFFFFFFFEFEFEFFFDFDFCFFFDFDFBFFFCFCF9FFFBFBF8FFFAFAF6FFF8F8
      F4FFFBFBF6FF2424137B00000000000000000000000000000000000000000101
      01084A2602A22E18027401010130010101280101012001010118010101070000
      0000000000000000000000000000000000000000000001010103010101110101
      011A0101011A0101011A0101011A0101011A0101011A0101011A0101011A0101
      011A010101130101010400000000000000000000000001010106492502A07B3F
      03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F
      03CC4A2602A1010101070000000000000000000000000000000028281777FFFF
      FFFFFEFEFEFFFDFDFCFFFDFDFBFFFCFCF9FFFBFBF8FFFAFAF6FFF8F8F4FFF7F7
      F2FFFBFBF5FF2828177700000000000000000000000000000000000000000000
      00007F4306CC7F4306CC2C17035C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001010103492603A07B3F
      03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F03CC7B3F
      03CC4A2603A10101010400000000000000000000000000000000391E035C7F43
      06CCFFBE24FFFFB710FFFFB70EFFFFB60DFFFFB60CFFFFB50AFFFFB914FF7F43
      06CC391E035C00000000000000000000000000000000000000002A2A1976FFFF
      FEFFFDFDFCFFD4D4D2FF5B5B5BFFE6E6E4FFE5E5E2FF5B5B5BFFD0D0CBFFF6F6
      F0FFFAFAF3FF2A2A197600000000000000000000000000000000000000000000
      000083470ACCFFBF26FF83470ACC3C21055C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000804407CCFFBE
      24FFFFB914FFFFB812FFFFB710FFFFB70EFFFFB60CFFFFB60BFFFFB50AFFFFB6
      0EFF804407CC0000000000000000000000000000000000000000000000003B20
      055C83470ACCFDC02FFFFCB105FFFCB105FFFCB105FFFDBB22FF83470ACC3B20
      055C0000000000000000000000000000000000000000000000002B2B1A74FEFE
      FDFFEAEAE8FF646464FFC1C1BFFFFAFAF6FFF8F8F4FFBFBFBCFF646464FFE3E3
      DDFFFAFAF2FF2B2B1A7400000000000000000000000000000000000000000000
      0000884D0ECCFBB822FFFBBF35FF884D0ECC3F24075C00000000000000000000
      0000000000000000000000000000000000000000000000000000854A0BCCFCBB
      25FFFBAF07FFFBAF07FFFBAF07FFFBAF07FFFBAF07FFFBAF07FFFBAF07FFFBB4
      13FF854A0BCC0000000000000000000000000000000000000000000000000000
      00003E23065C884D0ECCF5BD41FFF1A915FFF5BA3AFF884D0ECC3E23065C0000
      00000000000000000000000000000000000000000000000000002C2C1B72FEFE
      FCFFB5B5B4FFA3A3A2FFFAFAF6FFF8F8F4FFF7F7F2FFF6F6F0FFA1A19FFFB1B1
      ADFFF9F9EFFF2C2C1B7200000000000000000000000000000000000000000000
      00008F5313CCEFB33AFFEAA41EFFF2BD4BFF8F5313CC4126095C000000000000
      00000000000000000000000000000000000000000000000000008C5111CCF2B7
      3BFFEDA719FFEDA719FFEDA719FFEDA719FFEDA719FFEDA719FFEDA719FFF0AF
      28FF8C5111CC0000000000000000000000000000000000000000000000000000
      0000000000004025095C8F5313CCEEBB55FF8F5313CC4025095C000000000000
      00000000000000000000000000000000000000000000000000002E2E1C71FDFD
      FBFFEAEAE8FF7B7B7BFFC9C9C6FFF7F7F2FFF6F6F0FFC7C7C3FF7B7B7BFFE2E2
      D9FFF7F7EAFF2E2E1C7100000000000000000000000000000000000000000000
      0000945917CCE4AE51FFD99935FFD99935FFEABB61FF945917CC44290B5C0000
      0000000000000000000000000000000000000000000000000000945917CCE8B4
      52FFDD9C2EFFDD9C2EFFDD9C2EFFDD9C2EFFDD9C2EFFDD9C2EFFDD9C2EFFE3A8
      40FF945917CC0000000000000000000000000000000000000000714412999459
      17CC945917CC945917CC945917CC945917CC945917CC945917CC945917CC9459
      17CC7144129900000000000000000000000000000000000000002F2F1E6FFDFD
      FAFFFAFAF6FFDCDCD8FF868686FFE8E8E3FFE7E7E1FF868686FFD6D6CFFFECEC
      DFFFF4F4E5FF2F2F1E6F00000000000000000000000000000000000000000000
      00009C601CCCE5B467FFCE9245FFCD9144FFCD9144FFE7BC70FF9C601CCC0000
      00000000000000000000000000000000000000000000000000009C601CCCEEBF
      71FFD59846FFD09340FFD09340FFD09340FFD09340FFD09340FFD09340FFDAA5
      53FF9C601CCC0000000000000000000000000000000000000000472C0D5C9C60
      1CCCF8D286FFE7B56AFFDCAA5FFFDAA85DFFDAA75BFFD9A55AFFE5BA6FFF9C60
      1CCC472C0D5C000000000000000000000000000000000000000030301E6DFCFC
      F8FFF8F8F4FFF7F7F2FFF6F6F0FFF5F5EEFFF4F4ECFFF1F1E7FFECECDFFFE8E8
      D9FFF3F3E2FF30301E6D00000000000000000000000000000000000000000000
      0000A36721CCF5C67BFFE9AD62FFDFA358FFF1CC81FFA36721CC4A2E0F5C0000
      0000000000000000000000000000000000000000000000000000A46822CCF6C8
      7DFFEDB166FFE1A55AFFD4984DFFCD9146FFCC9045FFCC9045FFCC9045FFDAA7
      5CFFA46822CC0000000000000000000000000000000000000000000000004A2E
      0F5CA36721CCFBD78BFFE9AD62FFDFA358FFD5994EFFEDC67BFFA36721CC4A2E
      0F5C00000000000000000000000000000000000000000000000031311F6CFCFC
      F7FFF7F7F2FFF6F6F0FFF5F5EEFFF4F4ECFFF1F1E7FFECECDFFFE8E8D9FFE6E6
      D5FFF2F2E1FF31311F6C00000000000000000000000000000000000000000000
      0000A86D26CCF7CB80FFF1B66BFFFDDC90FFA86D26CC4C31115C000000000000
      0000000000000000000000000000000000000000000000000000AB6F27CCF8CE
      82FFF2B96EFFF2B96EFFF2B96EFFEDB469FFE7AD62FFE2A95EFFE0A75CFFEBBC
      71FFAB6F27CC0000000000000000000000000000000000000000000000000000
      00004C31115CA86D26CCFCDB8FFFEFB469FFFBD88CFFA86D26CC4C31115C0000
      00000000000000000000000000000000000000000000000000003232216BFBFB
      F6FFF6F6F0FFF5F5EEFFF4F4ECFFF1F1E7FFECECDFFFE8E8D9FFE6E6D5FFE5E5
      D4FFF2F2E1FF3232216B00000000000000000000000000000000000000000000
      0000AF732ACCFBD488FFFFE397FFAF732ACC4F34135C00000000000000000000
      0000000000000000000000000000000000000000000000000000B1752CCCFCD6
      8AFFF8C77CFFF8C77CFFF8C77CFFF8C77CFFF8C77CFFF8C77CFFF8C77CFFFBD3
      87FFB1752CCC0000000000000000000000000000000000000000000000000000
      0000000000004F34135CAF732ACCFEDF93FFAF732ACC4F34135C000000000000
      000000000000000000000000000000000000000000000000000032322169FAFA
      F4FFF5F5EEFFF4F4ECFFF1F1E7FFECECDFFFE8E8D9FFE6E6D5FFA4A493FFA4A4
      93FFA4A493FF2424137C00000000000000000000000000000000000000000000
      0000B4782ECCFFE599FFB4782ECC5136155C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B77B30CCFFE0
      94FFFEDB8FFFFEDB8FFFFEDB8FFFFEDB8FFFFEDA8EFFFEDA8EFFFEDA8EFFFFDE
      92FFB77B30CC0000000000000000000000000000000000000000875B2399B478
      2ECCB4782ECCB4782ECCB4782ECCB4782ECCB4782ECCB4782ECCB4782ECCB478
      2ECC875B2399000000000000000000000000000000000000000033332268FAFA
      F3FFF4F4ECFFF1F1E7FFECECDFFFE8E8D9FFE6E6D5FFE5E5D4FFB6B6A5FFFFFF
      FFFF3333226813130D2500000000000000000000000000000000000000000000
      0000B77C31CCB77C31CC5439175C000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C5F2799BB7F
      33CCBB7F33CCBB7F33CCBB7F33CCBB7F33CCBB7F33CCBB7F33CCBB7F33CCBB7F
      33CC8C5F27990000000000000000000000000000000000000000B77C31CCFFE0
      94FFFEDB8FFFFEDB8FFFFEDB8FFFFEDB8FFFFEDB8FFFFEDB8FFFFEDB8FFFFFDF
      93FFB77C31CC000000000000000000000000000000000000000033332367FCFC
      F5FFF9F9EFFFF6F6EAFFF4F4E5FFF3F3E2FFF2F2E1FFF2F2E1FFC2C2B1FF3333
      236713130D250000000000000000000000000000000000000000000000000000
      00008C5F2799553A185C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C5F2799BB7F
      34CCBB7F34CCBB7F34CCBB7F34CCBB7F34CCBB7F34CCBB7F34CCBB7F34CCBB7F
      34CC8C5F2799000000000000000000000000000000000000000027271B4D3434
      2366343423663434236634342366343423663434236634342366343423661313
      0D24000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      000000000000}
  end
  object pmGroupActions: TPopupMenu
    Left = 40
    Top = 440
    object N9: TMenuItem
      Action = acGroupCreate
    end
    object N26: TMenuItem
      Action = acGroupEdit
    end
    object N58: TMenuItem
      Action = acGroupClear
    end
    object N59: TMenuItem
      Action = acGroupDelete
    end
  end
  object tmrCheckUpdates: TTimer
    Enabled = False
    Interval = 25000
    OnTimer = tmrCheckUpdatesTimer
    Left = 424
    Top = 360
  end
  object tmrSearchA: TTimer
    Enabled = False
    OnTimer = tmrSearchATimer
    Left = 512
    Top = 360
  end
  object tmrSearchS: TTimer
    Enabled = False
    OnTimer = tmrSearchSTimer
    Left = 584
    Top = 384
  end
end
