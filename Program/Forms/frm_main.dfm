object frmMain: TfrmMain
  Left = 0
  Top = 0
  HelpContext = 2
  ActiveControl = edLocateAuthor
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object tlbrMain: TRzToolbar
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 786
    Height = 36
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 0
    Align = alTop
    AutoStyle = False
    Images = dmImages.vilToolbar
    RowHeight = 32
    AutoSize = True
    BorderInner = fsNone
    BorderOuter = fsFlatRounded
    BorderWidth = 0
    FullRepaint = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    ToolbarControls = (
      tbtnRead
      tbtnDownloadList_Add
      tbSendToDevice
      RzSep1
      tbtnRus
      tbtnEng
      RzSep2
      tbtnWizard
      RzSep3
      BtnFav_add
      RzSep4
      tbSelectAll
      tbCollapse
      RzSep5
      btnSwitchTreeMode
      tbtnShowDeleted
      tbtnShowLocalOnly
      tbtnShowCover
      RzSep6
      tbtnSettings
      tbtnHelp)
    object tbtnRead: TRzToolButton
      Left = 6
      Top = 2
      Action = acBookRead
      ImageIndex = 0
    end
    object tbtnDownloadList_Add: TRzToolButton
      Left = 33
      Top = 2
      Action = acBookAdd2DownloadList
      ImageIndex = 2
    end
    object tbSendToDevice: TRzToolButton
      Tag = 900
      Left = 60
      Top = 2
      Hint = #1053#1072#1076#1110#1089#1083#1072#1090#1080' '#1085#1072' '#1087#1088#1080#1089#1090#1088#1110#1081
      DropDownMenu = pmScripts
      ImageIndex = 1
      ToolStyle = tsDropDown
      ParentShowHint = False
      ShowHint = True
      OnClick = SendToDeviceExecute
    end
    object RzSep1: TRzSpacer
      Left = 100
      Top = 2
    end
    object tbtnRus: TRzToolButton
      Left = 108
      Top = 2
      Action = acShowRusAlphabet
      ImageIndex = 3
    end
    object tbtnEng: TRzToolButton
      Left = 135
      Top = 2
      Action = acShowEngAlphabet
      ImageIndex = 4
    end
    object RzSep2: TRzSpacer
      Left = 162
      Top = 2
    end
    object tbtnWizard: TRzToolButton
      Left = 170
      Top = 2
      Hint = #1042#1080#1073#1088#1072#1090#1080' '#1082#1086#1083#1077#1082#1094#1110#1102
      DropDownMenu = pmCollection
      ImageIndex = 6
      ParentShowHint = False
      ShowHint = True
      OnClick = tbtnWizardClick
    end
    object RzSep3: TRzSpacer
      Left = 197
      Top = 2
    end
    object BtnFav_add: TRzToolButton
      Left = 205
      Top = 2
      Action = acBookAdd2Favorites
      DropDownMenu = pmGroups
      ImageIndex = 15
      ToolStyle = tsDropDown
    end
    object RzSep4: TRzSpacer
      Left = 245
      Top = 2
    end
    object tbSelectAll: TRzToolButton
      Left = 253
      Top = 2
      Hint = #1042#1110#1076#1079#1085#1072#1095#1080#1090#1080' '#1074#1089#1077
      ImageIndex = 7
      ParentShowHint = False
      ShowHint = True
      OnClick = tbSelectAllClick
    end
    object tbCollapse: TRzToolButton
      Left = 280
      Top = 2
      Hint = #1056#1086#1079#1075#1086#1088#1085#1091#1090#1080'/'#1047#1075#1086#1088#1085#1091#1090#1080' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 8
      ParentShowHint = False
      ShowHint = True
      OnClick = tbCollapseClick
    end
    object RzSep5: TRzSpacer
      Left = 307
      Top = 2
    end
    object btnSwitchTreeMode: TRzToolButton
      Left = 315
      Top = 2
      Hint = #1055#1077#1088#1077#1082#1083#1102#1095#1080#1090#1080' '#1074' '#1088#1077#1078#1080#1084' "'#1058#1072#1073#1083#1080#1094#1103'"'
      ImageIndex = 10
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSwitchTreeModeClick
    end
    object tbtnShowDeleted: TRzToolButton
      Left = 342
      Top = 2
      Action = acViewHideDeletedBooks
      ImageIndex = 12
    end
    object tbtnShowLocalOnly: TRzToolButton
      Left = 369
      Top = 2
      Action = acViewShowLocalOnly
      ImageIndex = 13
    end
    object tbtnShowCover: TRzToolButton
      Left = 396
      Top = 2
      Action = acShowBookInfoPanel
      ImageIndex = 14
    end
    object RzSep6: TRzSpacer
      Left = 423
      Top = 2
    end
    object tbtnSettings: TRzToolButton
      Left = 431
      Top = 2
      Action = acToolsSettings
      ImageIndex = 17
    end
    object tbtnHelp: TRzToolButton
      Left = 458
      Top = 2
      Hint = #1044#1086#1074#1110#1076#1082#1072
      Action = acHelpHelp
      ImageIndex = 26
    end
  end
  object pgControl: TRzPageControl
    AlignWithMargins = True
    Left = 3
    Top = 65
    Width = 786
    Height = 685
    HelpContext = 1
    ActivePage = tsByAuthor
    Align = alClient
    TabOrder = 2
    OnChange = pgControlChange
    ExplicitWidth = 772
    ExplicitHeight = 652
    object tsByAuthor: TRzTabSheet
      HelpContext = 135
      Caption = #1040#1074#1090#1086#1088#1080
      object AuthorsViewSplitter: TMHLSplitter
        Left = 230
        Top = 70
        Height = 574
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
        Height = 574
        Align = alLeft
        TabOrder = 2
        ExplicitHeight = 541
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
            Width = 33
            Height = 13
            Caption = #1055#1086#1096#1091#1082
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
          Height = 536
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
        Width = 537
        Height = 574
        Align = alClient
        TabOrder = 3
        ExplicitWidth = 523
        ExplicitHeight = 541
        object AuthorBookInfoSplitter: TMHLSplitter
          Left = 0
          Top = 413
          Width = 537
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
          Top = 419
          Width = 531
          Height = 152
          Align = alBottom
          BorderOuter = fsFlatRounded
          TabOrder = 2
          OnResize = InfoPanelResize
          ShowAnnotation = False
          InfoPriority = True
          OnAuthorLinkClicked = AuthorLinkClicked
          OnSeriesLinkClicked = SeriesLinkClicked
          OnGenreLinkClicked = GenreLinkClicked
          ExplicitTop = 386
          ExplicitWidth = 517
        end
        object pnAuthorBooksTitle: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 531
          Height = 26
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 517
          object lblBooksTotalA: TLabel
            Left = 438
            Top = 0
            Width = 93
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1110#1083#1100#1082#1110#1089#1090#1100' '#1082#1085#1080#1075')'
            Layout = tlCenter
            ExplicitLeft = 452
            ExplicitHeight = 13
          end
          object lblAuthor: TLabel
            Left = 0
            Top = 0
            Width = 105
            Height = 26
            Align = alLeft
            Caption = #1055#1086#1074#1085#1077' '#1110#1084#39#1103' '#1072#1074#1090#1086#1088#1072
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lblLang: TLabel
            Left = 344
            Top = 0
            Width = 31
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = #1052#1086#1074#1072
            Layout = tlCenter
            ExplicitLeft = 358
            ExplicitHeight = 13
          end
          object cbLangSelectA: TComboBox
            AlignWithMargins = True
            Left = 378
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
            ExplicitLeft = 364
          end
        end
        object tvBooksA: TBookTree
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 531
          Height = 375
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
        Width = 764
        Height = 29
        AutoSize = True
        Caption = 'tbarAuthorsRus'
        DrawingStyle = dsGradient
        HotImages = ilAlphabetActive
        Images = ilAlphabetNormal
        ParentColor = True
        TabOrder = 0
        Transparent = True
        Wrapable = False
        ExplicitWidth = 750
      end
      object tbarAuthorsEng: TToolBar
        AlignWithMargins = True
        Left = 3
        Top = 38
        Width = 764
        Height = 29
        AutoSize = True
        Caption = 'tbarAuthorFilter1'
        DrawingStyle = dsGradient
        HotImages = ilAlphabetActive
        Images = ilAlphabetNormal
        ParentColor = True
        TabOrder = 1
        Transparent = True
        Wrapable = False
        ExplicitWidth = 750
      end
    end
    object tsBySerie: TRzTabSheet
      HelpContext = 135
      Caption = #1057#1077#1088#1110#1111
      object SeriesViewSplitter: TMHLSplitter
        Left = 230
        Top = 70
        Height = 574
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
        Height = 574
        Align = alLeft
        TabOrder = 0
        ExplicitHeight = 587
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
            Width = 33
            Height = 13
            Caption = #1055#1086#1096#1091#1082
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
        Width = 537
        Height = 574
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 545
        ExplicitHeight = 587
        object SerieBookInfoSplitter: TMHLSplitter
          Left = 0
          Top = 415
          Width = 551
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          ResizeControl = ipnlSeries
          ExplicitTop = 225
          ExplicitWidth = 545
        end
        object ipnlSeries: TInfoPanel
          AlignWithMargins = True
          Left = 3
          Top = 421
          Width = 545
          Height = 150
          Align = alBottom
          BorderOuter = fsFlatRounded
          TabOrder = 2
          OnResize = InfoPanelResize
          OnAuthorLinkClicked = AuthorLinkClicked
          OnSeriesLinkClicked = SeriesLinkClicked
          OnGenreLinkClicked = GenreLinkClicked
          ExplicitTop = 434
          ExplicitWidth = 539
        end
        object pnSerieBooksTitle: TMHLSimplePanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 545
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
          object lblBooksTotalS: TLabel
            Left = 452
            Top = 0
            Width = 93
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1110#1083#1100#1082#1110#1089#1090#1100' '#1082#1085#1080#1075')'
            Layout = tlCenter
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
            Left = 358
            Top = 0
            Width = 31
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = #1052#1086#1074#1072
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object cbLangSelectS: TComboBox
            Tag = 1
            AlignWithMargins = True
            Left = 392
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
        object tvBooksS: TBookTree
          Tag = 1
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 531
          Height = 377
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
          ExplicitWidth = 539
          ExplicitHeight = 390
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
        Width = 764
        Height = 29
        AutoSize = True
        Caption = 'tbarAuthorFilter1'
        DrawingStyle = dsGradient
        HotImages = ilAlphabetActive
        Images = ilAlphabetNormal
        ParentColor = True
        TabOrder = 2
        Transparent = True
        Wrapable = False
        ExplicitWidth = 772
      end
      object tbarSeriesRus: TToolBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 764
        Height = 29
        AutoSize = True
        Caption = 'tbarAuthorFilter1'
        DrawingStyle = dsGradient
        HotImages = ilAlphabetActive
        Images = ilAlphabetNormal
        ParentColor = True
        TabOrder = 3
        Transparent = True
        Wrapable = False
        ExplicitWidth = 772
      end
    end
    object tsByGenre: TRzTabSheet
      HelpContext = 135
      Caption = #1046#1072#1085#1088#1080
      object GenresViewSplitter: TMHLSplitter
        Left = 230
        Top = 0
        Height = 644
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
        Height = 644
        Align = alLeft
        TabOrder = 0
        ExplicitHeight = 657
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
        Width = 551
        Height = 644
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 545
        ExplicitHeight = 657
        object GenreBookInfoSplitter: TMHLSplitter
          Left = 0
          Top = 535
          Width = 551
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
          Width = 545
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
            Left = 452
            Top = 0
            Width = 93
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1110#1083#1100#1082#1110#1089#1090#1100' '#1082#1085#1080#1075')'
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
            Left = 358
            Top = 0
            Width = 31
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = #1052#1086#1074#1072
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object cbLangSelectG: TComboBox
            Tag = 2
            AlignWithMargins = True
            Left = 392
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
          Top = 541
          Width = 531
          Height = 100
          Align = alBottom
          BorderOuter = fsFlatRounded
          TabOrder = 2
          OnResize = InfoPanelResize
          OnAuthorLinkClicked = AuthorLinkClicked
          OnSeriesLinkClicked = SeriesLinkClicked
          OnGenreLinkClicked = GenreLinkClicked
          ExplicitTop = 554
          ExplicitWidth = 539
        end
        object tvBooksG: TBookTree
          Tag = 2
          AlignWithMargins = True
          Left = 3
          Top = 35
          Width = 531
          Height = 497
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
          ExplicitWidth = 539
          ExplicitHeight = 510
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
    object tsSearch: TRzTabSheet
      HelpContext = 126
      Caption = #1055#1086#1096#1091#1082
      object SearchViewSplitter: TMHLSplitter
        Left = 230
        Top = 0
        Height = 644
        MinSize = 230
        ResizeControl = pnSearchView
        ExplicitLeft = 185
        ExplicitTop = 3
        ExplicitHeight = 387
      end
      object pnSearchBooksView: TMHLSimplePanel
        Left = 233
        Top = 0
        Width = 551
        Height = 644
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 545
        ExplicitHeight = 657
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
          BorderOuter = fsFlatRounded
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
            Left = 446
            Top = 0
            Width = 93
            Height = 13
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1110#1083#1100#1082#1110#1089#1090#1100' '#1082#1085#1080#1075')'
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
          Width = 531
          Height = 447
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
          ExplicitWidth = 539
          ExplicitHeight = 460
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
        Height = 644
        Align = alLeft
        TabOrder = 0
        ExplicitHeight = 657
        object SearchParams: TCategoryPanelGroup
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 224
          Height = 600
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
              Caption = #1052#1086#1074#1072
            end
            object Label4: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 178
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
              Width = 178
              Height = 21
              Align = alTop
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 2
              Text = #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' '#1074#1089#1077
              Items.Strings = (
                #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' '#1074#1089#1077
                #1058#1110#1083#1100#1082#1080' '#1079#1072#1074#1072#1085#1090#1072#1078#1077#1085#1110
                #1058#1110#1083#1100#1082#1080' '#1053#1045' '#1079#1072#1074#1072#1085#1090#1072#1078#1077#1085#1110)
            end
            object cbDeleted: TCheckBox
              AlignWithMargins = True
              Left = 5
              Top = 49
              Width = 176
              Height = 17
              Margins.Left = 5
              Align = alTop
              Caption = #1055#1088#1080#1093#1086#1074#1091#1074#1072#1090#1080' '#1074#1080#1076#1072#1083#1077#1085#1110
              TabOrder = 3
              ExplicitWidth = 193
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
              Width = 176
              Height = 17
              Margins.Left = 5
              Align = alTop
              Caption = #1058#1110#1083#1100#1082#1080' '#1087#1088#1086#1095#1080#1090#1072#1085#1110
              TabOrder = 5
              ExplicitWidth = 193
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
              Caption = #1050#1083#1102#1095#1086#1074#1110' '#1089#1083#1086#1074#1072
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
              Hint = #1050#1083#1102#1095#1086#1074#1110' '#1089#1083#1086#1074#1072
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
          Top = 609
          Width = 224
          Height = 32
          Align = alBottom
          TabOrder = 1
          ExplicitTop = 622
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
    object tsByGroup: TRzTabSheet
      HelpContext = 125
      Caption = #1043#1088#1091#1087#1080
      object GroupsViewSplitter: TMHLSplitter
        Left = 230
        Top = 0
        Height = 644
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
        Height = 644
        Align = alLeft
        TabOrder = 0
        ExplicitHeight = 657
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
            Caption = #1057#1090#1074#1086#1088#1080#1090#1080
            TabOrder = 0
          end
          object btnDeleteGroup: TButton
            Left = 76
            Top = 0
            Width = 70
            Height = 25
            Action = acGroupDelete
            Caption = #1042#1080#1076#1072#1083#1080#1090#1080
            TabOrder = 1
          end
          object btnClearGroup: TButton
            Left = 151
            Top = 0
            Width = 70
            Height = 25
            Action = acGroupClear
            Caption = #1054#1095#1080#1089#1090#1080#1090#1080
            TabOrder = 2
          end
        end
      end
      object pnGroupBooksView: TMHLSimplePanel
        Left = 233
        Top = 0
        Width = 551
        Height = 644
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 545
        ExplicitHeight = 657
        object GroupBookInfoSplitter: TMHLSplitter
          Left = 0
          Top = 485
          Width = 551
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
          Top = 491
          Width = 545
          Height = 150
          Align = alBottom
          BorderOuter = fsFlatRounded
          TabOrder = 2
          OnResize = InfoPanelResize
          OnAuthorLinkClicked = AuthorLinkClicked
          OnSeriesLinkClicked = SeriesLinkClicked
          OnGenreLinkClicked = GenreLinkClicked
          ExplicitTop = 504
          ExplicitWidth = 539
          DesignSize = (
            531
            150)
          object lblTotalBooksF: TLabel
            AlignWithMargins = True
            Left = 1695
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
          Width = 531
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
          object lblBooksTotalF: TLabel
            Left = 452
            Top = 0
            Width = 93
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1110#1083#1100#1082#1110#1089#1090#1100' '#1082#1085#1080#1075')'
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lblGroups: TLabel
            Left = 0
            Top = 0
            Width = 102
            Height = 26
            Align = alLeft
            Caption = #1053#1072#1079#1074#1072' '#1075#1088#1091#1087#1080
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object lbl3: TLabel
            Left = 358
            Top = 0
            Width = 31
            Height = 26
            Align = alRight
            Alignment = taRightJustify
            Caption = #1052#1086#1074#1072
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object cbLangSelectF: TComboBox
            Tag = 4
            AlignWithMargins = True
            Left = 392
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
          Width = 531
          Height = 447
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
          ExplicitWidth = 539
          ExplicitHeight = 460
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
    object tsDownload: TRzTabSheet
      HelpContext = 108
      Caption = #1057#1087#1080#1089#1086#1082' '#1079#1072#1074#1072#1085#1090#1072#1078#1077#1085#1100
      object tlbrDownloadList: TRzToolbar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 772
        Height = 24
        Align = alTop
        AutoStyle = False
        Images = dmImages.vilDownload
        RowHeight = 20
        AutoSize = True
        BorderInner = fsNone
        BorderOuter = fsFlatRounded
        FullRepaint = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ToolbarControls = (
          btnStartDownload
          btnPauseDownload
          DlSep1
          BtnFirstRecord
          BtnDwnldUp
          BtnDwnldDown
          BtnLastRecord
          DlSep2
          BtnDelete
          BtnSave
          tbtnClear)
        object btnStartDownload: TRzToolButton
          Left = 0
          Top = 0
          Hint = #1057#1090#1072#1088#1090
          Caption = 'Play'
          ImageIndex = 1
          OnClick = btnStartDownloadClick
        end
        object btnPauseDownload: TRzToolButton
          Left = 30
          Top = 0
          Hint = #1057#1090#1086#1087
          Caption = 'Stop'
          ImageIndex = 2
          OnClick = btnPauseDownloadClick
        end
        object DlSep1: TRzSpacer
          Left = 60
          Top = 2
        end
        object BtnFirstRecord: TRzToolButton
          Tag = 20
          Left = 68
          Top = 0
          Hint = #1042' '#1085#1072#1095#1072#1083#1086
          Caption = 'First Record'
          ImageIndex = 3
          OnClick = MoveDwnldListNodes
        end
        object BtnDwnldUp: TRzToolButton
          Tag = 21
          Left = 98
          Top = 0
          Hint = #1042#1074#1077#1088#1093
          Caption = 'Up'
          ImageIndex = 4
          OnClick = MoveDwnldListNodes
        end
        object BtnDwnldDown: TRzToolButton
          Tag = 22
          Left = 128
          Top = 0
          Hint = #1042#1085#1080#1079
          Caption = 'Down'
          ImageIndex = 5
          OnClick = MoveDwnldListNodes
        end
        object BtnLastRecord: TRzToolButton
          Tag = 23
          Left = 158
          Top = 0
          Hint = #1042' '#1082#1086#1085#1077#1094
          Caption = 'Last Record'
          ImageIndex = 6
          OnClick = MoveDwnldListNodes
        end
        object DlSep2: TRzSpacer
          Left = 188
          Top = 2
        end
        object BtnDelete: TRzToolButton
          Left = 196
          Top = 0
          Hint = #1059#1076#1072#1083#1080#1090#1100
          Caption = 'Delete'
          ImageIndex = 7
          OnClick = btnDeleteDownloadClick
        end
        object BtnSave: TRzToolButton
          Left = 226
          Top = 0
          Hint = 'Save'
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          ImageIndex = 8
          OnClick = BtnSaveClick
        end
        object tbtnClear: TRzToolButton
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
            Caption = #1054#1095#1110#1082#1091#1074#1072#1085#1085#1103
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
            Left = 676
            Top = 3
            Width = 93
            Height = 13
            Align = alRight
            Alignment = taRightJustify
            Caption = '('#1082#1110#1083#1100#1082#1110#1089#1090#1100' '#1082#1085#1080#1075')'
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
              Text = #1053#1072#1079#1074#1072
              Width = 200
            end
            item
              Alignment = taRightJustify
              Position = 2
              Text = #1056#1086#1079#1084#1110#1088
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
    ButtonWidth = 185
    Caption = 'RusBar'
    List = True
    ShowCaptions = True
    AllowTextButtons = True
    TabOrder = 1
    Wrapable = False
    ExplicitWidth = 778
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
      Style = tbsTextButton
    end
    object tbtnEditGenre: TToolButton
      Left = 110
      Top = 0
      Action = acEditGenre
      Style = tbsTextButton
    end
    object tbtnEditBook: TToolButton
      Left = 186
      Top = 0
      Action = acEditBook
      Style = tbsTextButton
    end
    object tbtnSplitter1: TToolButton
      Left = 306
      Top = 0
      Width = 8
      Caption = 'tbtnSplitter1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object tbtnDeleteBook: TToolButton
      Left = 314
      Top = 0
      Action = acBookDelete
      Style = tbsTextButton
    end
    object tbtnSplitter2: TToolButton
      Left = 379
      Top = 0
      Width = 8
      Caption = 'tbtnSplitter2'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object tbtnFBD: TToolButton
      Left = 387
      Top = 0
      Action = acEditConvert2FBD
      Style = tbsTextButton
    end
    object tbtnAutoFBD: TToolButton
      Left = 502
      Top = 0
      Action = acEditAutoConvert2FBD
      Style = tbsTextButton
    end
  end
  object StatusBar: TRzStatusBar
    Left = 0
    Top = 753
    Width = 792
    Height = 22
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderWidth = 0
    TabOrder = 3
    ExplicitTop = 720
    ExplicitWidth = 778
    object spStatus: TRzStatusPane
      Left = 0
      Top = 0
      Width = 200
      Height = 22
      Align = alLeft
    end
    object spHint: TRzStatusPane
      Left = 200
      Top = 0
      Width = 100
      Height = 22
      Align = alLeft
    end
    object spInfo: TRzStatusPane
      Left = 300
      Top = 0
      Width = 100
      Height = 22
      Align = alLeft
      Alignment = taCenter
    end
  end
  object MainMenu: TMainMenu
    Images = dmImages.vilMenu
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
        Caption = #1044#1086#1076#1072#1090#1080' '#1076#1086' '#1075#1088#1091#1087#1080
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
        Caption = #1050#1086#1087#1110#1102#1074#1072#1090#1080' '#1076#1086' '#1082#1086#1083#1077#1082#1094#1110#1111
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
      Caption = #1050#1086#1083#1077#1082#1094#1110#1103
      HelpContext = 112
      object miNewCollection: TMenuItem
        Action = acCollectionNew
      end
      object miCollSelect: TMenuItem
        Caption = #1042#1080#1073#1088#1072#1090#1080' '#1082#1086#1083#1077#1082#1094#1110#1102
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
        Caption = #1030#1084#1087#1086#1088#1090
        object miFb2Import: TMenuItem
          Action = acImportFb2
          Caption = #1060#1072#1081#1083#1080' fb2 '#1090#1072' fb2.zip'
          ImageIndex = 18
        end
        object miPdfdjvu: TMenuItem
          Action = acImportNonFB2
          Caption = #1060#1072#1081#1083#1080' '#1085#1077'-fb2'
          ImageIndex = 8
        end
        object miFBDImport: TMenuItem
          Action = acImportFBD
          Caption = #1060#1072#1081#1083#1080' FBD (pdf.zip djvu.zip)'
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
        Caption = #1045#1082#1089#1087#1086#1088#1090
        object N46: TMenuItem
          Caption = #1045#1082#1089#1087#1086#1088#1090' '#1072#1082#1090#1080#1074#1085#1086#1075#1086' '#1089#1087#1080#1089#1082#1091
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
        Caption = #1054#1073#1089#1083#1091#1075#1086#1074#1091#1074#1072#1085#1085#1103
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
        Action = acCollectionDelete
      end
    end
    object N24: TMenuItem
      Caption = #1043#1088#1091#1087#1072
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
      Caption = #1056#1077#1076#1072#1075#1091#1074#1072#1085#1085#1103
      object N51: TMenuItem
        Action = acEditBook
      end
      object FBD1: TMenuItem
        Action = acEditConvert2FBD
      end
      object FBD2: TMenuItem
        Action = acEditAutoConvert2FBD
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
      Caption = #1042#1080#1075#1083#1103#1076
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
        Caption = #1044#1086#1076#1072#1090#1082#1086#1074#1086
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
          Caption = #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' BookInfo'
        end
      end
      object N76: TMenuItem
        Caption = #1056#1077#1078#1080#1084' '#1087#1077#1088#1077#1075#1083#1103#1076#1091
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
      Caption = #1030#1085#1089#1090#1088#1091#1084#1077#1085#1090#1080
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
      Caption = #1044#1086#1087#1086#1084#1086#1075#1072
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
      object N1: TMenuItem
        Caption = '-'
      end
      object miAbout: TMenuItem
        Action = acHelpAbout
      end
    end
  end
  object pmMain: TPopupMenu
    Images = dmImages.vilMenu
    OwnerDraw = True
    Left = 128
    Top = 280
    object pmiReadBook: TMenuItem
      Caption = #1063#1080#1090#1072#1090#1080
      ImageIndex = 12
      ShortCut = 13
      OnClick = ReadBookExecute
    end
    object pmiSendToDevice: TMenuItem
      Caption = #1053#1072#1076#1110#1089#1083#1072#1090#1080' '#1085#1072' '#1087#1088#1080#1089#1090#1088#1110#1081
      ImageIndex = 7
      ShortCut = 16452
      OnClick = SendToDeviceExecute
    end
    object pmiDownloadBooks: TMenuItem
      Action = acBookAdd2DownloadList
    end
    object pmiScripts: TMenuItem
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1080' '#1089#1082#1088#1080#1087#1090
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
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1076#1086' '#1072#1074#1090#1086#1088#1072
      ImageIndex = 35
      ShortCut = 49217
      OnClick = miGoToAuthorClick
    end
    object pmiBookInfo: TMenuItem
      Caption = #1030#1085#1092#1086#1088#1084#1072#1094#1110#1103' '#1087#1088#1086' '#1082#1085#1080#1075#1091
      ShortCut = 16457
      OnClick = ShowBookInfo
    end
    object miBookEdit: TMenuItem
      Caption = #1047#1084#1110#1085#1080#1090#1080' '#1086#1087#1080#1089
      ImageIndex = 3
      ShortCut = 16453
      OnClick = EditBookExecute
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object miAddFavorites: TMenuItem
      Tag = 1
      Caption = #1044#1086#1076#1072#1090#1080' '#1076#1086' '#1086#1073#1088#1072#1085#1086#1075#1086
      ImageIndex = 13
      ShortCut = 16454
      OnClick = AddBookToGroup
    end
    object pmiGroups: TMenuItem
      Caption = #1044#1086#1076#1072#1090#1080' '#1076#1086' '#1075#1088#1091#1087#1080
    end
    object miDelFavorites: TMenuItem
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080' '#1110#1079' '#1075#1088#1091#1087#1080
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
      Caption = #1042#1110#1076#1079#1085#1072#1095#1080#1090#1080' '#1074#1089#1077
      ImageIndex = 24
      ShortCut = 16449
      OnClick = pmiCheckAllClick
    end
    object pmiSelectAll: TMenuItem
      Caption = #1042#1080#1076#1110#1083#1080#1090#1080' '#1074#1089#1077
      ShortCut = 16467
      OnClick = pmiSelectAllClick
    end
    object pmMarkSelected: TMenuItem
      Caption = #1042#1110#1076#1079#1085#1072#1095#1080#1090#1080' '#1074#1080#1076#1110#1083#1077#1085#1110
      ShortCut = 16461
      OnClick = pmMarkSelectedClick
    end
    object pmiDeselectAll: TMenuItem
      Tag = 1
      Caption = #1047#1085#1103#1090#1080' '#1087#1086#1079#1085#1072#1095#1082#1080
      ImageIndex = 32
      ShortCut = 16469
      OnClick = pmiDeselectAllClick
    end
    object N23: TMenuItem
      Caption = '-'
      Hint = '-'
    end
    object miCopyClBrd: TMenuItem
      Caption = #1050#1086#1087#1110#1102#1074#1072#1090#1080' '#1074' '#1073#1091#1092#1077#1088
      ImageIndex = 31
      ShortCut = 16451
      OnClick = miCopyClBrdClick
    end
  end
  object pmAuthor: TPopupMenu
    OwnerDraw = True
    OnPopup = pmAuthorPopup
    Left = 40
    Top = 288
    object miCopyAuthor: TMenuItem
      Caption = #1050#1086#1087#1110#1102#1074#1072#1090#1080' '#1074' '#1073#1091#1092#1077#1088
      ShortCut = 16451
      OnClick = miCopyAuthorClick
    end
    object N37: TMenuItem
      Caption = '-'
    end
    object miAddToSearch: TMenuItem
      Caption = #1044#1086#1076#1072#1090#1080' '#1076#1086' "'#1055#1086#1096#1091#1082#1091'"'
      OnClick = miAddToSearchClick
    end
  end
  object pmCollection: TPopupMenu
    Images = dmImages.vilMenu
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
      Caption = #1053#1072#1079#1074#1072
      OnClick = HeaderPopupItemClick
    end
    object N8: TMenuItem
      Tag = 12
      Caption = #1057#1077#1088#1110#1103
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
      Caption = #1056#1086#1079#1084#1110#1088
      OnClick = HeaderPopupItemClick
    end
    object N13: TMenuItem
      Tag = 16
      Caption = #1052#1086#1103' '#1086#1094#1110#1085#1082#1072
      OnClick = HeaderPopupItemClick
    end
    object N15: TMenuItem
      Tag = 17
      Caption = #1044#1086#1076#1072#1085#1086
      OnClick = HeaderPopupItemClick
    end
    object N28: TMenuItem
      Tag = 18
      Caption = #1058#1080#1087
      OnClick = HeaderPopupItemClick
    end
    object N22: TMenuItem
      Tag = 19
      Caption = #1050#1086#1083#1077#1082#1094#1110#1103
      OnClick = HeaderPopupItemClick
    end
    object N42: TMenuItem
      Tag = 21
      Caption = #1052#1086#1074#1072
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
      Caption = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1110
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
      Caption = #1042#1110#1076#1082#1088#1080#1090#1080'/'#1047#1075#1086#1088#1085#1091#1090#1080
      OnClick = TrayIconDblClick
    end
    object N32: TMenuItem
      Caption = '-'
    end
    object N33: TMenuItem
      Caption = #1042#1080#1093#1110#1076
      OnClick = N33Click
    end
  end
  object pmDownloadList: TPopupMenu
    Images = dmImages.vilMenu
    OwnerDraw = True
    Left = 128
    Top = 376
    object mi_dwnl_LocateAuthor: TMenuItem
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1076#1086' '#1072#1074#1090#1086#1088#1072
      ImageIndex = 35
      OnClick = mi_dwnl_LocateAuthorClick
    end
    object N35: TMenuItem
      Caption = '-'
    end
    object mi_dwnl_Delete: TMenuItem
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080
      ImageIndex = 2
      OnClick = btnDeleteDownloadClick
    end
  end
  object pmGroups: TPopupMenu
    Images = dmImages.vilMenu
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
    Images = dmImages.vilMenu
    Left = 576
    Top = 208
    object acShowMainToolbar: TAction
      Category = #1042#1080#1076
      Caption = #1054#1089#1085#1086#1074#1085#1072' '#1087#1072#1085#1077#1083#1100' '#1110#1085#1089#1090#1088#1091#1084#1077#1085#1090#1110#1074
      OnExecute = ShowMainToolbarExecute
      OnUpdate = ShowMainToolbarUpdate
    end
    object acImportNonFB2: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = #1085#1077'-fb2'
      Hint = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1085#1080#1075#1080
      OnExecute = ImportNonFB2Execute
      OnUpdate = ImportNonFB2Update
    end
    object acShowEditToolbar: TAction
      Category = #1042#1080#1076
      Caption = #1055#1072#1085#1077#1083#1100' '#1088#1077#1076#1072#1075#1091#1074#1072#1085#1085#1103
      Hint = #1055#1072#1085#1077#1083#1100' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
      OnExecute = ShowEditToolbarExecute
      OnUpdate = ShowEditToolbarUpdate
    end
    object acShowRusAlphabet: TAction
      Category = #1042#1080#1076
      Caption = #1050#1080#1088#1080#1083#1080#1095#1085#1072' '#1072#1073#1077#1090#1082#1072
      Hint = #1050#1080#1088#1080#1083#1080#1095#1085#1072' '#1072#1073#1077#1090#1082#1072
      OnExecute = ShowRusAlphabetExecute
      OnUpdate = ShowRusAlphabetUpdate
    end
    object acShowEngAlphabet: TAction
      Category = #1042#1080#1076
      Caption = #1051#1072#1090#1080#1085#1089#1100#1082#1072' '#1072#1073#1077#1090#1082#1072
      Hint = #1051#1072#1090#1080#1085#1089#1100#1082#1072' '#1072#1073#1077#1090#1082#1072
      OnExecute = ShowEngAlphabetExecute
      OnUpdate = ShowEngAlphabetUpdate
    end
    object acShowStatusbar: TAction
      Category = #1042#1080#1076
      Caption = #1056#1103#1076#1086#1082' '#1089#1090#1072#1085#1091
      Hint = #1042#1110#1076#1086#1073#1088#1072#1078#1077#1085#1085#1103' '#1072#1073#1086' '#1087#1088#1080#1093#1086#1074#1091#1074#1072#1085#1085#1103' '#1088#1103#1076#1082#1072' '#1089#1090#1072#1085#1091'.'
      OnExecute = ShowStatusbarExecute
      OnUpdate = ShowStatusbarUpdate
    end
    object acShowBookInfoPanel: TAction
      Category = #1042#1080#1076
      Caption = #1055#1072#1085#1077#1083#1100' '#1110#1085#1092#1086#1088#1084#1072#1094#1110#1111' '#1087#1088#1086' '#1082#1085#1080#1075#1091
      Hint = #1055#1086#1082#1072#1079#1072#1090#1080'/'#1057#1093#1086#1074#1072#1090#1080' '#1087#1072#1085#1077#1083#1100' '#1110#1085#1092#1086#1088#1084#1072#1094#1110#1111' '#1087#1088#1086' '#1082#1085#1080#1075#1091
      OnExecute = ShowBookInfoPanelExecute
      OnUpdate = ShowBookInfoPanelUpdate
    end
    object acShowBookCover: TAction
      Category = #1042#1080#1076
      Caption = #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' '#1086#1073#1082#1083#1072#1076#1080#1085#1082#1091
      OnExecute = ShowBookCoverExecute
      OnUpdate = ShowBookCoverUpdate
    end
    object acShowBookAnnotation: TAction
      Category = #1042#1080#1076
      Caption = #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' '#1072#1085#1086#1090#1072#1094'i'#1102
      OnExecute = ShowBookAnnotationExecute
      OnUpdate = ShowBookAnnotationUpdate
    end
    object acBookRead: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1063#1080#1090#1072#1090#1080
      Hint = #1063#1080#1090#1072#1090#1080
      ImageIndex = 12
      OnExecute = ReadBookExecute
    end
    object acBookSend2Device: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1053#1072#1076#1110#1089#1083#1072#1090#1080' '#1085#1072' '#1087#1088#1080#1089#1090#1088#1110#1081
      Hint = #1053#1072#1076#1110#1089#1083#1072#1090#1080' '#1085#1072' '#1087#1088#1080#1089#1090#1088#1110#1081
      ImageIndex = 7
      OnExecute = SendToDeviceExecute
    end
    object acBookAdd2DownloadList: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1044#1086#1076#1072#1090#1080' '#1076#1086' '#1089#1087#1080#1089#1082#1091' '#1079#1072#1074#1072#1085#1090#1072#1078#1077#1085#1100
      Hint = #1044#1086#1076#1072#1090#1080' '#1076#1086' '#1089#1087#1080#1089#1082#1091' '#1079#1072#1074#1072#1085#1090#1072#1078#1077#1085#1100
      ImageIndex = 20
      ShortCut = 16460
      OnExecute = Add2DownloadListExecute
    end
    object acBookMarkAsRead: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1055#1088#1086#1095#1080#1090#1072#1085#1086
      OnExecute = MarkAsReadedExecute
    end
    object acBookAdd2Favorites: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1044#1086#1076#1072#1090#1080' '#1074' '#1086#1073#1088#1072#1085#1077
      Hint = #1044#1086#1076#1072#1090#1080' '#1074' '#1086#1073#1088#1072#1085#1077
      ImageIndex = 13
      OnExecute = acBookAdd2FavoritesExecute
    end
    object acBookAdd2Group: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1044#1086#1076#1072#1090#1080' '#1076#1086' '#1075#1088#1091#1087#1080
      OnExecute = acBookAdd2GroupExecute
    end
    object acBookRemoveFromGroup: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080' '#1110#1079' '#1075#1088#1091#1087#1080
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
      Caption = #1054#1095#1080#1089#1090#1080#1090#1080
      OnExecute = BookSetRateExecute
      OnUpdate = UpdateBookAction
    end
    object acGroupCreate: TAction
      Category = #1043#1088#1091#1087#1080
      Caption = #1057#1090#1074#1086#1088#1080#1090#1080' '#1075#1088#1091#1087#1091
      Hint = #1057#1090#1074#1086#1088#1080#1090#1080' '#1085#1086#1074#1091' '#1075#1088#1091#1087#1091
      OnExecute = AddGroupExecute
      OnUpdate = AddGroupUpdate
    end
    object acGroupEdit: TAction
      Category = #1043#1088#1091#1087#1080
      Caption = #1055#1077#1088#1077#1081#1084#1077#1085#1091#1074#1072#1090#1080' '#1075#1088#1091#1087#1091
      Hint = #1055#1077#1088#1077#1081#1084#1077#1085#1091#1074#1072#1090#1080' '#1074#1080#1073#1088#1072#1085#1091' '#1075#1088#1091#1087#1091
      OnExecute = RenameGroupExecute
      OnUpdate = EditGroupUpdate
    end
    object acGroupClear: TAction
      Category = #1043#1088#1091#1087#1080
      Caption = #1054#1095#1080#1089#1090#1080#1090#1080' '#1075#1088#1091#1087#1091
      Hint = #1054#1095#1080#1089#1090#1080#1090#1080' '#1074#1080#1073#1088#1072#1085#1091' '#1075#1088#1091#1087#1091
      OnExecute = ClearGroupExecute
      OnUpdate = ClearGroupUpdate
    end
    object acGroupDelete: TAction
      Category = #1043#1088#1091#1087#1080
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080' '#1075#1088#1091#1087#1091
      Hint = #1042#1080#1076#1072#1083#1080#1090#1080' '#1074#1080#1073#1088#1072#1085#1091' '#1075#1088#1091#1087#1091
      OnExecute = DeleteGroupExecute
      OnUpdate = EditGroupUpdate
    end
    object acSavePreset: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1047#1073#1077#1088#1077#1075#1090#1080
      Hint = #1047#1073#1077#1088#1077#1075#1090#1080' '#1087#1088#1077#1089#1077#1090
      OnExecute = SaveSearchPreset
      OnUpdate = SavePresetUpdate
    end
    object acDeletePreset: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1077#1089#1077#1090
      OnExecute = DeleteSearchPreset
      OnUpdate = DeletePresetUpdate
    end
    object acApplyPreset: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1047#1072#1089#1090#1086#1089#1091#1074#1072#1090#1080
      Hint = #1056#1086#1079#1087#1086#1095#1072#1090#1080' '#1087#1086#1096#1091#1082
      OnExecute = DoApplyFilter
    end
    object acClearPreset: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1054#1095#1080#1089#1090#1080#1090#1080
      Hint = #1054#1095#1080#1089#1090#1080#1090#1080' '#1074#1089#1110' '#1087#1086#1083#1103
    end
    object acEditBook: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1030#1085#1092#1086#1088#1084#1072#1094#1110#1103' '#1087#1088#1086' '#1082#1085#1080#1075#1091
      OnExecute = EditBookExecute
    end
    object acEditConvert2FBD: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1055#1077#1088#1077#1090#1074#1086#1088#1080#1090#1080' '#1085#1072' FBD'
      OnExecute = Conver2FBDExecute
    end
    object acEditAutoConvert2FBD: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1085#1086' '#1087#1077#1088#1077#1090#1074#1086#1088#1080#1090#1080' '#1085#1072' FBD'
    end
    object acEditAuthor: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1040#1074#1090#1086#1088
      OnExecute = EditAuthorExecute
      OnUpdate = EditAuthorUpdate
    end
    object acEditSerie: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1053#1072#1079#1074#1072' '#1089#1077#1088#1110#1111
      OnExecute = EditSeriesExecute
      OnUpdate = EditSerieUpdate
    end
    object acEditGenre: TAction
      Category = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Caption = #1053#1072#1079#1074#1072' '#1078#1072#1085#1088#1091
      OnExecute = EditGenresExecute
      OnUpdate = EditGenreUpdate
    end
    object acBookShowInfo: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1030#1085#1092#1086#1088#1084#1072#1094#1110#1103' '#1087#1088#1086' '#1082#1085#1080#1075#1091
      OnExecute = ShowBookInfoPanelExecute
    end
    object acBookCopy2Collection: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1050#1086#1087#1110#1102#1074#1072#1090#1080' '#1076#1086' '#1082#1086#1083#1077#1082#1094#1110#1111
    end
    object acBookDelete: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080
      ImageIndex = 0
      OnExecute = DeleteBookExecute
    end
    object acApplicationExit: TAction
      Category = #1050#1085#1080#1075#1072
      Caption = #1042#1080#1093#1110#1076
      ImageIndex = 33
      OnExecute = QuitAppExecute
    end
    object acCollectionNew: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1057#1090#1074#1086#1088#1080#1090#1080' '#1085#1086#1074#1091' '#1082#1086#1083#1077#1082#1094#1110#1102
      Hint = #1052#1072#1081#1089#1090#1077#1088' '#1076#1086#1076#1072#1074#1072#1085#1085#1103' '#1082#1086#1083#1077#1082#1094#1110#1081
      ImageIndex = 1
      ShortCut = 16462
      OnExecute = ShowNewCollectionWizard
    end
    object acCollectionSelect: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1042#1080#1073#1088#1072#1090#1080' '#1082#1086#1083#1077#1082#1094#1110#1102
    end
    object acCollectionProperties: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1042#1083#1072#1089#1090#1080#1074#1086#1089#1090#1110' '#1082#1086#1083#1077#1082#1094#1110#1111
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
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080
      ImageIndex = 2
      OnExecute = DeleteCollectionExecute
    end
    object acViewTreeView: TAction
      Category = #1042#1080#1076
      Caption = #1059' '#1074#1080#1075#1083#1103#1076#1110' '#1076#1077#1088#1077#1074#1072
      Hint = #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' '#1089#1087#1080#1089#1086#1082' '#1082#1085#1080#1075' '#1091' '#1074#1080#1075#1083#1103#1076#1110' '#1076#1077#1088#1077#1074#1072
    end
    object acViewTableView: TAction
      Category = #1042#1080#1076
      Caption = #1059' '#1074#1080#1075#1083#1103#1076#1110' '#1090#1072#1073#1083#1080#1094#1110
      Hint = #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' '#1089#1087#1080#1089#1086#1082' '#1082#1085#1080#1075' '#1091' '#1074#1080#1075#1083#1103#1076#1110' '#1090#1072#1073#1083#1080#1094#1110
    end
    object acViewSelectColumns: TAction
      Category = #1042#1080#1076
      Caption = #1042#1080#1073#1110#1088' '#1089#1090#1086#1074#1087#1094#1110#1074' '#1091' '#1090#1072#1073#1083#1080#1094#1110'...'
    end
    object acViewHideDeletedBooks: TAction
      Category = #1042#1080#1076
      Caption = #1057#1093#1086#1074#1072#1090#1080' '#1074#1080#1076#1072#1083#1077#1085#1110' '#1082#1085#1080#1075#1080
      Hint = #1057#1093#1086#1074#1072#1090#1080' '#1074#1080#1076#1072#1083#1077#1085#1110' '#1082#1085#1080#1075#1080
      OnExecute = HideDeletedBooksExecute
      OnUpdate = HideDeletedBooksUpdate
    end
    object acViewShowLocalOnly: TAction
      Category = #1042#1080#1076
      Caption = #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' '#1090#1110#1083#1100#1082#1080' '#1079#1072#1074#1072#1085#1090#1072#1078#1077#1085#1110' '#1082#1085#1080#1075#1080
      Hint = #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' '#1090#1110#1083#1100#1082#1080' '#1079#1072#1074#1072#1085#1090#1072#1078#1077#1085#1110' '#1082#1085#1080#1075#1080
      OnExecute = ShowLocalOnlyExecute
      OnUpdate = ShowLocalOnlyUpdate
    end
    object acToolsQuickSearch: TAction
      Category = #1030#1085#1089#1090#1088#1091#1084#1077#1085#1090#1080
      Caption = #1064#1074#1080#1076#1082#1080#1081' '#1087#1086#1096#1091#1082
      OnExecute = QuickSearchExecute
    end
    object acToolsUpdateOnlineCollections: TAction
      Category = #1030#1085#1089#1090#1088#1091#1084#1077#1085#1090#1080
      Caption = #1054#1085#1086#1074#1080#1090#1080' '#1082#1086#1083#1077#1082#1094#1110#1111
      OnExecute = UpdateOnlineCollectionExecute
    end
    object acToolsClearReadFolder: TAction
      Category = #1030#1085#1089#1090#1088#1091#1084#1077#1085#1090#1080
      Caption = #1054#1095#1080#1089#1090#1080#1090#1080' '#1087#1072#1087#1082#1091' '#8220#1044#1083#1103' '#1095#1080#1090#1072#1085#1085#1103#8221
      OnExecute = ClearReadFolderExecute
    end
    object acToolsRunScript: TAction
      Category = #1030#1085#1089#1090#1088#1091#1084#1077#1085#1090#1080
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1080' '#1089#1082#1088#1080#1087#1090
    end
    object acToolsSettings: TAction
      Category = #1030#1085#1089#1090#1088#1091#1084#1077#1085#1090#1080
      Caption = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103
      Hint = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103' '#1087#1088#1086#1075#1088#1072#1084#1080
      ImageIndex = 11
      OnExecute = ChangeSettingsExecute
    end
    object acHelpHelp: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1044#1086#1074#1110#1076#1082#1072
      Hint = #1057#1087#1088#1072#1074#1082#1072
      ImageIndex = 17
      OnExecute = ShowHelpExecute
    end
    object acHelpCheckUpdates: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1055#1077#1088#1077#1074#1110#1088#1080#1090#1080' '#1085#1072#1103#1074#1085#1110#1089#1090#1100' '#1086#1085#1086#1074#1083#1077#1085#1100
      OnExecute = CheckUpdatesExecute
    end
    object acHelpProgramSite: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1057#1072#1081#1090' '#1087#1088#1086#1075#1088#1072#1084#1080
      OnExecute = GoSiteExecute
    end
    object acHelpSupportForum: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1060#1086#1088#1091#1084' '#1087#1110#1076#1090#1088#1080#1084#1082#1080
      OnExecute = GoForumExecute
    end
    object acHelpAbout: TAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1055#1088#1086' '#1087#1088#1086#1075#1088#1072#1084#1091
      OnExecute = ShowAboutExecute
    end
    object acImportFb2Zip: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = 'fb2  ('#1080#1079' .zip)'
      Hint = #1030#1084#1087#1086#1088#1090#1091#1074#1072#1090#1080' '#1082#1085#1080#1075#1080' '#1091' '#1092#1086#1088#1084#1072#1090#1110' FB2 ('#1079' .zip)'
      OnUpdate = ImportFb2Update
    end
    object acImportFb2: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = 'fb2'
      Hint = #1030#1084#1087#1086#1088#1090#1091#1074#1072#1090#1080' '#1082#1085#1080#1075#1080' '#1091' '#1092#1086#1088#1084#1072#1090#1110' FB2 ('#1079' .zip)'
      OnExecute = ImportFb2Execute
      OnUpdate = ImportFb2Update
    end
    object acImportFBD: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = 'FBD (pdf.zip djvu.zip)'
      Hint = #1030#1084#1087#1086#1088#1090#1091#1074#1072#1090#1080' '#1082#1085#1080#1075#1080' '#1091' '#1092#1086#1088#1084#1072#1090#1110' FBD'
      OnExecute = ImportFBDExecute
      OnUpdate = ImportNonFB2Update
    end
    object acImportUserData: TAction
      Category = #1048#1084#1087#1086#1088#1090
      Caption = #1044#1072#1085#1110' '#1082#1086#1088#1080#1089#1090#1091#1074#1072#1095#1072
      Hint = #1030#1084#1087#1086#1088#1090#1091#1074#1072#1090#1080' '#1076#1072#1085#1110' '#1082#1086#1088#1080#1089#1090#1091#1074#1072#1095#1072
      OnExecute = ImportUserDataExecute
    end
    object acExport2HTML: TAction
      Tag = 351
      Category = #1045#1082#1089#1087#1086#1088#1090
      Caption = 'html'
      OnExecute = Export2HTMLExecute
    end
    object acExport2Txt: TAction
      Tag = 352
      Category = #1045#1082#1089#1087#1086#1088#1090
      Caption = 'txt'
      OnExecute = Export2HTMLExecute
    end
    object acExport2RTF: TAction
      Tag = 353
      Category = #1045#1082#1089#1087#1086#1088#1090
      Caption = 'RTF'
      OnExecute = Export2HTMLExecute
    end
    object acExport2INPX: TAction
      Category = #1045#1082#1089#1087#1086#1088#1090
      Caption = #1045#1082#1089#1087#1086#1088#1090#1091#1074#1072#1090#1080' '#1074' inpx'
      OnExecute = Export2INPXExecute
    end
    object acExportUserData: TAction
      Category = #1045#1082#1089#1087#1086#1088#1090
      Caption = #1044#1072#1085#1110' '#1082#1086#1088#1080#1089#1090#1091#1074#1072#1095#1072
      OnExecute = ExportUserDataExecute
    end
    object acCollectionUpdateGenres: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1054#1085#1086#1074#1080#1090#1080' '#1089#1087#1080#1089#1086#1082' '#1078#1072#1085#1088#1110#1074
      OnExecute = UpdateGenresExecute
    end
    object acCollectionSyncFiles: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1057#1080#1085#1093#1088#1086#1085#1110#1079#1091#1074#1072#1090#1080' '#1092#1072#1081#1083#1080
      ImageIndex = 9
      OnExecute = SyncFilesExecute
    end
    object acCollectionRepair: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1042#1080#1087#1088#1072#1074#1080#1090#1080' '#1087#1086#1084#1080#1083#1082#1080
      OnExecute = RepairDataBaseExecute
    end
    object acCollectionCompact: TAction
      Category = #1050#1086#1083#1083#1077#1082#1094#1080#1103
      Caption = #1057#1090#1080#1089#1085#1091#1090#1080
      OnExecute = CompactDataBaseExecute
    end
    object acViewSetInfoPriority: TAction
      Category = #1042#1080#1076
      Caption = 'acViewSetInfoPriority'
      OnExecute = acViewSetInfoPriorityExecute
    end
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
