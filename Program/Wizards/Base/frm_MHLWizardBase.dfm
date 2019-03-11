object MHLWizardBase: TMHLWizardBase
  Left = 0
  Top = 0
  HelpContext = 136
  BorderStyle = bsDialog
  Caption = 'MyHomeLib - '#1052#1072#1089#1090#1077#1088
  ClientHeight = 394
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnButtons: TPanel
    Left = 0
    Top = 353
    Width = 520
    Height = 41
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      520
      39)
    object btnCancel: TButton
      Left = 436
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 0
      OnClick = OnCancel
    end
    object btnForward: TButton
      Left = 342
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1087#1077#1088#1077#1076' >'
      TabOrder = 1
      OnClick = DoChangePage
    end
    object btnBackward: TButton
      Left = 261
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '< '#1053#1072#1079#1072#1076
      TabOrder = 2
      OnClick = DoChangePage
    end
  end
end
