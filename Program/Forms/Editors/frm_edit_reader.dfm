object frmEditReader: TfrmEditReader
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1076#1072#1074#1072#1085#1085#1103' '#1090#1080#1087#1091' '#1092#1072#1081#1083#1110#1074
  ClientHeight = 101
  ClientWidth = 415
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
    Top = 11
    Width = 22
    Height = 13
    Caption = '&'#1058#1080#1087':'
    FocusControl = edExt
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 32
    Height = 13
    Caption = '&'#1064#1083#1103#1093':'
    FocusControl = edPath
  end
  object pnButtons: TPanel
    Left = 0
    Top = 60
    Width = 415
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnButtons'
    ShowCaption = False
    TabOrder = 3
    ExplicitTop = 59
    ExplicitWidth = 411
    DesignSize = (
      415
      41)
    object btnOk: TButton
      Left = 247
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&'#1047#1073#1077#1088#1077#1075#1090#1080
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnSaveClick
      ExplicitLeft = 243
    end
    object btnCancel: TButton
      Left = 328
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1042#1110#1076#1084#1110#1085#1072
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 324
    end
  end
  object edExt: TEdit
    Left = 56
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    TextHint = #1056#1086#1079#1096#1080#1088#1077#1085#1085#1103' '#1092#1072#1081#1083#1091
  end
  object edPath: TMHLAutoCompleteEdit
    Left = 56
    Top = 35
    Width = 270
    Height = 21
    TabOrder = 1
    TextHint = #1064#1083#1103#1093' '#1076#1086' '#1087#1088#1086#1075#1088#1072#1084#1080' '#1087#1077#1088#1077#1075#1083#1103#1076#1091
  end
  object btnBrowse: TButton
    Left = 332
    Top = 33
    Width = 75
    Height = 25
    Caption = #1054#1075#1083#1103#1076'...'
    TabOrder = 2
    OnClick = edPathButtonClick
  end
end
