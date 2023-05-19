object frmEditGroup: TfrmEditGroup
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1072' '#1075#1088#1091#1087#1072
  ClientHeight = 94
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 13
  object Label1: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 10
    Width = 296
    Height = 13
    Margins.Left = 8
    Margins.Top = 10
    Margins.Right = 8
    Align = alTop
    Caption = #1053#1072#1079#1074#1072' '#1075#1088#1091#1087#1080':'
    ExplicitWidth = 66
  end
  object pnButtons: TPanel
    Left = 0
    Top = 53
    Width = 312
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnButtons'
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      312
      41)
    object btnOk: TButton
      Left = 148
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&'#1047#1073#1077#1088#1077#1075#1090#1080
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 229
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1042#1110#1076#1084#1110#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
  object edGroupName: TEdit
    AlignWithMargins = True
    Left = 8
    Top = 29
    Width = 296
    Height = 21
    Margins.Left = 8
    Margins.Right = 8
    Align = alTop
    MaxLength = 255
    TabOrder = 0
    OnChange = edGroupNameChange
  end
end
