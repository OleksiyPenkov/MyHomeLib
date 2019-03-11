object frmEditAuthorData: TfrmEditAuthorData
  Left = 0
  Top = 0
  HelpContext = 117
  BorderStyle = bsDialog
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1072#1074#1090#1086#1088#1077
  ClientHeight = 133
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 48
    Height = 13
    Caption = '&'#1060#1072#1084#1080#1083#1080#1103':'
    FocusControl = edLastName
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 23
    Height = 13
    Caption = '&'#1048#1084#1103':'
    FocusControl = edFirstName
  end
  object Label3: TLabel
    Left = 8
    Top = 67
    Width = 53
    Height = 13
    Caption = #1054'&'#1090#1095#1077#1089#1090#1074#1086':'
    FocusControl = edMiddleName
  end
  object pnButtons: TPanel
    Left = 0
    Top = 92
    Width = 358
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnButtons'
    ShowCaption = False
    TabOrder = 3
    DesignSize = (
      358
      41)
    object btnOk: TButton
      Left = 194
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
      Left = 275
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
  object edFirstName: TEdit
    Left = 72
    Top = 37
    Width = 278
    Height = 21
    TabOrder = 1
  end
  object edLastName: TEdit
    Left = 72
    Top = 10
    Width = 278
    Height = 21
    TabOrder = 0
  end
  object edMiddleName: TEdit
    Left = 72
    Top = 64
    Width = 278
    Height = 21
    TabOrder = 2
  end
end
