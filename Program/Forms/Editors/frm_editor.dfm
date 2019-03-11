object frmEditor: TfrmEditor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090' '#1074#1099#1088#1072#1078#1077#1085#1080#1103
  ClientHeight = 203
  ClientWidth = 392
  Color = clBtnFace
  Constraints.MinHeight = 236
  Constraints.MinWidth = 366
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mmMemo: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 386
    Height = 109
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object RzGroupBox4: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 115
    Width = 386
    Height = 45
    Margins.Top = 0
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnNotEq: TButton
      Tag = 52
      Left = 306
      Top = 11
      Width = 31
      Height = 25
      Caption = '<>'
      TabOrder = 8
      OnClick = btnLikeClick
    end
    object btnBraket: TButton
      Tag = 55
      Left = 158
      Top = 11
      Width = 31
      Height = 25
      Caption = '()'
      TabOrder = 4
      OnClick = btnLikeClick
    end
    object btnGreat: TButton
      Tag = 54
      Left = 232
      Top = 11
      Width = 31
      Height = 25
      Caption = '>'
      TabOrder = 6
      OnClick = btnLikeClick
    end
    object btnLess: TButton
      Tag = 53
      Left = 195
      Top = 11
      Width = 31
      Height = 25
      Caption = '<'
      TabOrder = 5
      OnClick = btnLikeClick
    end
    object btnAnd: TButton
      Tag = 56
      Left = 47
      Top = 11
      Width = 31
      Height = 25
      Caption = 'AND'
      TabOrder = 1
      OnClick = btnLikeClick
    end
    object btnOr: TButton
      Tag = 57
      Left = 84
      Top = 11
      Width = 31
      Height = 25
      Caption = 'OR'
      TabOrder = 2
      OnClick = btnLikeClick
    end
    object btnNot: TButton
      Tag = 58
      Left = 121
      Top = 11
      Width = 31
      Height = 25
      Caption = 'NOT'
      TabOrder = 3
      OnClick = btnLikeClick
    end
    object btnCommas: TButton
      Tag = 59
      Left = 269
      Top = 11
      Width = 31
      Height = 25
      Caption = '" "'
      TabOrder = 7
      OnClick = btnLikeClick
    end
    object btnLike: TButton
      Tag = 50
      Left = 10
      Top = 11
      Width = 31
      Height = 25
      Caption = 'LIKE'
      TabOrder = 0
      OnClick = btnLikeClick
    end
    object btnEq: TButton
      Tag = 51
      Left = 343
      Top = 11
      Width = 32
      Height = 25
      Caption = '='
      TabOrder = 9
      OnClick = btnLikeClick
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 163
    Width = 392
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnButtons'
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      392
      40)
    object btnOk: TButton
      Left = 229
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 310
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
end
