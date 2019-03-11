object frmEditScript: TfrmEditScript
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1082#1088#1080#1087#1090#1072
  ClientHeight = 189
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 52
    Height = 13
    Caption = '&'#1053#1072#1079#1074#1072#1085#1080#1077':'
    FocusControl = edTitle
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 29
    Height = 13
    Caption = '&'#1055#1091#1090#1100':'
    FocusControl = edPath
  end
  object Label3: TLabel
    Left = 8
    Top = 100
    Width = 61
    Height = 13
    Caption = #1055#1072'&'#1088#1072#1084#1077#1090#1088#1099':'
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
    DesignSize = (
      346
      41)
    object btnOk: TButton
      Left = 182
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 263
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
    Caption = #1054#1073'&'#1079#1086#1088'...'
    TabOrder = 2
    OnClick = edPathButtonClick
  end
end
