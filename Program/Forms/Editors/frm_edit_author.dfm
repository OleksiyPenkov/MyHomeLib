object frmEditAuthorData: TfrmEditAuthorData
  Left = 0
  Top = 0
  HelpContext = 117
  BorderStyle = bsDialog
  Caption = #1030#1085#1092#1086#1088#1084#1072#1094#1110#1103' '#1087#1088#1086' '#1072#1074#1090#1086#1088#1072
  ClientHeight = 133
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 51
    Height = 13
    Caption = '&'#1055#1088#1110#1079#1074#1080#1097#1077':'
    FocusControl = edLastName
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 22
    Height = 13
    Caption = '&'#1030#1084#39#1103':'
    FocusControl = edFirstName
  end
  object Label3: TLabel
    Left = 8
    Top = 67
    Width = 60
    Height = 13
    Caption = #1055#1086' '#1073#1072#1090#1100#1082#1086#1074#1110
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
    ExplicitTop = 91
    ExplicitWidth = 354
    DesignSize = (
      358
      41)
    object btnOk: TButton
      Left = 190
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&'#1047#1073#1077#1088#1077#1075#1090#1080
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 186
    end
    object btnCancel: TButton
      Left = 271
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1042#1110#1076#1084#1110#1085#1072
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 267
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
