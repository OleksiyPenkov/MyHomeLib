object frmEditScript: TfrmEditScript
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080' '#1089#1082#1088#1080#1087#1090#1091
  ClientHeight = 189
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 34
    Height = 13
    Caption = '&'#1053#1072#1079#1074#1072':'
    FocusControl = edTitle
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 32
    Height = 13
    Caption = '&'#1064#1083#1103#1093':'
    FocusControl = edPath
  end
  object Label3: TLabel
    Left = 8
    Top = 100
    Width = 59
    Height = 13
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080':'
    FocusControl = edParams
  end
  object pnButtons: TPanel
    Left = 0
    Top = 148
    Width = 346
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnButtons'
    ShowCaption = False
    TabOrder = 4
    ExplicitTop = 147
    ExplicitWidth = 342
    DesignSize = (
      346
      41)
    object btnOk: TButton
      Left = 178
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&'#1047#1073#1077#1088#1077#1075#1090#1080
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnSaveClick
      ExplicitLeft = 174
    end
    object btnCancel: TButton
      Left = 259
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1042#1110#1076#1084#1110#1085#1072
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 255
    end
  end
  object edParams: TEdit
    Left = 8
    Top = 119
    Width = 330
    Height = 21
    TabOrder = 3
  end
  object edPath: TMHLAutoCompleteEdit
    Left = 8
    Top = 73
    Width = 249
    Height = 21
    TabOrder = 1
  end
  object edTitle: TEdit
    Left = 8
    Top = 27
    Width = 330
    Height = 21
    TabOrder = 0
  end
  object btnBrowse: TButton
    Left = 263
    Top = 71
    Width = 75
    Height = 25
    Caption = #1054#1075#1083#1103#1076'...'
    TabOrder = 2
    OnClick = edPathButtonClick
  end
end
