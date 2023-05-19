object frmEditAuthorFull: TfrmEditAuthorFull
  Left = 0
  Top = 0
  HelpContext = 117
  BorderStyle = bsDialog
  Caption = #1044#1072#1085#1085#1099#1077' '#1086#1073' '#1072#1074#1090#1086#1088#1077
  ClientHeight = 233
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 13
  object gbButtons: TPanel
    Left = 0
    Top = 199
    Width = 292
    Height = 34
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 288
    object btnSave: TButton
      Left = 126
      Top = 3
      Width = 75
      Height = 25
      Caption = #1047#1073#1077#1088#1077#1075#1090#1080
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 207
      Top = 3
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1042#1110#1076#1084#1110#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
  object gbEdits: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 286
    Height = 193
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 0
    ExplicitWidth = 282
    object Label1: TLabel
      Left = 9
      Top = 1
      Width = 47
      Height = 13
      Caption = '&'#1055#1088#1110#1079#1074#1080#1097#1077
      FocusControl = edFamily
    end
    object Label2: TLabel
      Left = 9
      Top = 43
      Width = 18
      Height = 13
      Caption = '&'#1030#1084#39#1103
      FocusControl = edName
    end
    object Label3: TLabel
      Left = 151
      Top = 43
      Width = 60
      Height = 13
      Caption = #1055#1086' '#1073#1072#1090#1100#1082#1086#1074#1110
      FocusControl = edMiddle
    end
    object Label4: TLabel
      Left = 50
      Top = 143
      Width = 24
      Height = 13
      Alignment = taRightJustify
      Caption = 'E&mail'
      FocusControl = edEmail
    end
    object Label5: TLabel
      Left = 23
      Top = 170
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Home&page'
      FocusControl = edHomepage
    end
    object Separator: TBevel
      Left = 9
      Top = 132
      Width = 270
      Height = 4
      Shape = bsTopLine
    end
    object Label6: TLabel
      Left = 12
      Top = 89
      Width = 51
      Height = 13
      Caption = #1055#1089#1077#1074#1076#1086#1085#1110#1084
      FocusControl = edNick
    end
    object edFamily: TEdit
      Left = 9
      Top = 17
      Width = 270
      Height = 21
      TabOrder = 0
    end
    object edName: TEdit
      Left = 9
      Top = 62
      Width = 136
      Height = 21
      TabOrder = 1
    end
    object edMiddle: TEdit
      Left = 151
      Top = 62
      Width = 128
      Height = 21
      TabOrder = 2
    end
    object edEmail: TEdit
      Left = 80
      Top = 140
      Width = 199
      Height = 21
      TabOrder = 4
    end
    object edHomepage: TEdit
      Left = 80
      Top = 167
      Width = 199
      Height = 21
      TabOrder = 5
    end
    object edNick: TEdit
      Left = 9
      Top = 105
      Width = 270
      Height = 21
      TabOrder = 3
    end
  end
end
