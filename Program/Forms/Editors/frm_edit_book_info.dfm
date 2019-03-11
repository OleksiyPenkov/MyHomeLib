object frmEditBookInfo: TfrmEditBookInfo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = '  '#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077'  '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086' '#1082#1085#1080#1075#1077
  ClientHeight = 502
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object Label1: TLabel
    Left = 10
    Top = 25
    Width = 64
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&'#1053#1072#1079#1074#1072#1085#1080#1077':'
    FocusControl = edT
  end
  object pnButtons: TPanel
    Left = 0
    Top = 449
    Width = 795
    Height = 53
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnButtons'
    ShowCaption = False
    TabOrder = 3
    DesignSize = (
      795
      53)
    object btnOk: TButton
      Left = 581
      Top = 13
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 687
      Top = 13
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
    object btnNextBook: TButton
      Left = 116
      Top = 13
      Width = 98
      Height = 33
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1087#1077#1088#1077#1081#1090#1080' '#1082' '#1089#1083#1077#1076#1091#1102#1097#1077#1081' '#1082#1085#1080#1075#1077
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&>>>'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnNextBookClick
    end
    object btnPrevBook: TButton
      Left = 10
      Top = 13
      Width = 99
      Height = 33
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1087#1077#1088#1077#1081#1090#1080' '#1082' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1081' '#1082#1085#1080#1075#1077
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&<<<'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnPrevBookClick
    end
  end
  object edT: TEdit
    AlignWithMargins = True
    Left = 86
    Top = 21
    Width = 578
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 0
    OnChange = edTChange
  end
  object gbAuthors: TGroupBox
    Left = 10
    Top = 56
    Width = 776
    Height = 200
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&'#1040#1074#1090#1086#1088#1099
    TabOrder = 1
    object lvAuthors: TListView
      Left = 21
      Top = 29
      Width = 633
      Height = 145
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      BevelKind = bkFlat
      BorderStyle = bsNone
      Columns = <
        item
          Caption = #1060#1072#1084#1080#1083#1080#1103
          Width = 222
        end
        item
          Caption = #1048#1084#1103
          Width = 196
        end
        item
          AutoSize = True
          Caption = #1054#1090#1095#1077#1089#1090#1074#1086
        end>
      ColumnClick = False
      GridLines = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = btnAChangeClick
    end
    object btnAddAuthor: TButton
      Left = 662
      Top = 29
      Width = 98
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = btnAddAuthorClick
    end
    object btnAChange: TButton
      Left = 662
      Top = 69
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1048'&'#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = btnAChangeClick
    end
    object btnADelete: TButton
      Left = 662
      Top = 110
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
      OnClick = btnADeleteClick
    end
  end
  object gbExtraInfo: TGroupBox
    Left = 10
    Top = 264
    Width = 776
    Height = 177
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' &'#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
    TabOrder = 2
    object Label6: TLabel
      Left = 21
      Top = 31
      Width = 52
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&'#1046#1072#1085#1088#1099':'
      FocusControl = lblGenre
    end
    object Label3: TLabel
      Left = 21
      Top = 65
      Width = 44
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1057'&'#1077#1088#1080#1103':'
      FocusControl = cbSeries
    end
    object Label4: TLabel
      Left = 554
      Top = 65
      Width = 99
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1053#1086'&'#1084#1077#1088' '#1074' '#1089#1077#1088#1080#1080':'
      FocusControl = edSN
    end
    object Label5: TLabel
      Left = 21
      Top = 101
      Width = 112
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&'#1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072':'
      FocusControl = edKeyWords
    end
    object Label7: TLabel
      Left = 21
      Top = 136
      Width = 37
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&'#1071#1079#1099#1082':'
      FocusControl = cbLang
    end
    object lblGenre: TEdit
      Left = 146
      Top = 27
      Width = 508
      Height = 27
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabStop = False
      AutoSize = False
      BorderStyle = bsNone
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
    end
    object btnGenres: TButton
      Left = 662
      Top = 25
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&'#1042#1099#1073#1088#1072#1090#1100
      TabOrder = 1
      OnClick = btnGenresClick
    end
    object cbLang: TComboBox
      Left = 146
      Top = 132
      Width = 87
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 5
      OnChange = edTChange
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
    object cbSeries: TComboBox
      Left = 146
      Top = 61
      Width = 401
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 2
      OnChange = edTChange
    end
    object edKeyWords: TEdit
      AlignWithMargins = True
      Left = 146
      Top = 97
      Width = 614
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 4
      OnChange = edTChange
    end
    object edSN: TEdit
      Left = 662
      Top = 61
      Width = 98
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taRightJustify
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 3
      OnChange = edTChange
    end
  end
  object btnOpenBook: TButton
    Left = 672
    Top = 18
    Width = 98
    Height = 33
    Hint = #1054#1090#1082#1088#1099#1090#1100' '#1082#1085#1080#1075#1091
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #1054#1090#1082#1088#1099#1090#1100
    ImageIndex = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnOpenBookClick
  end
end
