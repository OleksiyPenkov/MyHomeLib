inherited frmEditAuthorDataEx: TfrmEditAuthorDataEx
  Caption = #1030#1085#1092#1086#1088#1084#1072#1094#1110#1103' '#1087#1088#1086' '#1072#1074#1090#1086#1088#1072
  ClientHeight = 195
  ClientWidth = 358
  ExplicitHeight = 233
  TextHeight = 13
  inherited Label1: TLabel
    Width = 51
    Caption = '&'#1055#1088#1110#1079#1074#1080#1097#1077':'
    ExplicitWidth = 51
  end
  inherited Label2: TLabel
    Width = 22
    Caption = '&'#1030#1084#39#1103':'
    ExplicitWidth = 22
  end
  inherited Label3: TLabel
    Width = 60
    Caption = #1055#1086' '#1073#1072#1090#1100#1082#1086#1074#1110
    ExplicitWidth = 60
  end
  inherited pnButtons: TPanel
    Top = 154
    Width = 358
    TabOrder = 4
    ExplicitTop = 153
    ExplicitWidth = 354
    inherited btnOk: TButton
      Left = 186
      Caption = '&'#1047#1073#1077#1088#1077#1075#1090#1080
      ExplicitLeft = 182
    end
    inherited btnCancel: TButton
      Left = 267
      Caption = '&'#1042#1110#1076#1084#1110#1085#1072
      ExplicitLeft = 263
    end
  end
  object gbAddNew: TGroupBox [4]
    AlignWithMargins = True
    Left = 8
    Top = 91
    Width = 342
    Height = 61
    Caption = #1054#1087#1094#1110#1111
    TabOrder = 3
    object cbAddNew: TCheckBox
      Left = 17
      Top = 28
      Width = 85
      Height = 15
      Caption = '&'#1053#1086#1074#1080#1081' '#1072#1074#1090#1086#1088
      TabOrder = 0
    end
    object cbSaveLinks: TCheckBox
      Left = 158
      Top = 28
      Width = 108
      Height = 15
      Caption = #1047#1073#1077#1088#1077#1075#1090#1080' '#1079#1074#39#1103#1079#1082#1080
      TabOrder = 1
    end
  end
end
