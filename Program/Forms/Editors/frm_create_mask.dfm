object frmCreateMask: TfrmCreateMask
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1082#1083#1072#1076#1072#1085#1085#1103' '#1096#1072#1073#1083#1086#1085#1091
  ClientHeight = 448
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 40
    Width = 48
    Height = 13
    Caption = #1055#1088#1080#1082#1083#1072#1076':'
  end
  object Label2: TLabel
    Left = 58
    Top = 40
    Width = 85
    Height = 13
    Caption = '[%s [(%n) ]- ]%t'
  end
  object Label3: TLabel
    Left = 8
    Top = 16
    Width = 44
    Height = 13
    Caption = '&'#1064#1072#1073#1083#1086#1085':'
    FocusControl = edTemplate
  end
  object edTemplate: TEdit
    Left = 58
    Top = 13
    Width = 367
    Height = 21
    Margins.Top = 10
    TabOrder = 0
    OnChange = edTemplateChange
  end
  object pnButtons: TPanel
    Left = 0
    Top = 407
    Width = 434
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnButtons'
    ShowCaption = False
    TabOrder = 2
    ExplicitTop = 406
    ExplicitWidth = 430
    DesignSize = (
      434
      41)
    object btnOk: TButton
      Left = 266
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&'#1047#1073#1077#1088#1077#1075#1090#1080
      Default = True
      TabOrder = 0
      OnClick = SaveMask
      ExplicitLeft = 262
    end
    object btnCancel: TButton
      Left = 347
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1042#1110#1076#1084#1110#1085#1072
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 343
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 59
    Width = 434
    Height = 348
    ActivePage = TabSheet1
    Align = alBottom
    MultiLine = True
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #1055#1088#1072#1074#1080#1083#1072' '#1087#1086#1073#1091#1076#1086#1074#1080' '#1096#1072#1073#1083#1086#1085#1091
      object stDescription: TMHLStaticTip
        Left = 0
        Top = 0
        Width = 426
        Height = 320
        Align = alClient
        Caption = 
          #1055#1088#1072#1074#1080#1083#1072' '#1087#1086#1073#1091#1076#1086#1074#1080' '#1096#1072#1073#1083#1086#1085#1091':'#13'%t - '#1085#1072#1079#1074#1072' '#1082#1085#1080#1075#1080#13'%s - '#1085#1072#1079#1074#1072' '#1089#1077#1088#1110#1111' '#1082#1085#1080#1075 +
          #13'%n - '#1085#1086#1084#1077#1088' '#1082#1085#1080#1075#1080' '#1091' '#1089#1077#1088#1110#1111#13'%id - ID '#1082#1085#1080#1075#1080#13'%g - '#1087#1077#1088#1096#1080#1081' '#1078#1072#1085#1088' '#1079#1110' '#1089#1087#1080 +
          #1089#1082#1091#13'%ga - '#1074#1077#1089#1100' '#1087#1077#1088#1077#1083#1110#1082' '#1078#1072#1085#1088#1110#1074#13'%f - '#1087#1088#1110#1079#1074#1080#1097#1077', '#1110#1084#39#1103' '#1090#1072' '#1087#1086' '#1073#1072#1090#1100#1082#1086#1074#1110 +
          ' '#1087#1077#1088#1096#1086#1075#1086' '#1072#1074#1090#1086#1088#1072#13'%fa - '#1087#1088#1110#1079#1074#1080#1097#1077' '#1090#1072' '#1110#1085#1110#1094#1110#1072#1083#1080' '#1074#1089#1110#1093' '#1072#1074#1090#1086#1088#1110#1074#13'%ff - '#1087#1077 +
          #1088#1096#1072' '#1083#1110#1090#1077#1088#1072' '#1087#1088#1110#1079#1074#1080#1097#1072' '#1072#1074#1090#1086#1088#1072#13'%fl - '#1087#1088#1110#1079#1074#1080#1097#1077' '#1087#1077#1088#1096#1086#1075#1086' '#1072#1074#1090#1086#1088#1072#13'%fn - '#1087 +
          #1088#1110#1079#1074#1080#1097#1077' '#1090#1072' '#1110#1084#39#1103' '#1087#1077#1088#1096#1086#1075#1086' '#1072#1074#1090#1086#1088#1072#13'%fc - '#1087#1088#1110#1079#1074#1080#1097#1077', '#1110#1084#39#1103' '#1090#1072' '#1087#1086'-'#1073#1072#1090#1100#1082#1086 +
          #1074#1110' '#1086#1073#1088#1072#1085#1086#1075#1086' '#1072#1074#1090#1086#1088#1072' '#1085#1072' '#1079#1072#1082#1083#1072#1076#1094#1110' "'#1040#1074#1090#1086#1088#1080'" '#13'('#1096#1072#1073#1083#1086#1085' '#1087#1088#1072#1094#1102#1108' '#1090#1110#1083#1100#1082#1080' '#1087 +
          #1088#1080' '#1077#1082#1089#1087#1086#1088#1090#1110' '#1079' '#1079#1072#1082#1083#1072#1076#1082#1080' "'#1040#1074#1090#1086#1088#1080'", '#1087#1088#1080' '#1077#1082#1089#1087#1086#1088#1090#1110' '#1079' '#1110#1085#1096#1080#1093' '#1079#1072#1082#1083#1072#1076#1086#1082' '#1079 +
          #1072#1084#1110#1085#1102#1108#1090#1100#1089#1103' '#1096#1072#1073#1083#1086#1085#1086#1084' %f)'#13'%rg - '#1082#1086#1088#1077#1085#1077#1074#1080#1081' '#1078#1072#1085#1088#13'\ - '#1087#1110#1076' '#1095#1072#1089' '#1092#1086#1088#1084#1091#1074#1072 +
          #1085#1085#1103' '#1096#1083#1103#1093#1091' '#1076#1086' '#1092#1072#1081#1083#1091' '#1087#1086#1076#1110#1083#1103#1108' '#1095#1072#1089#1090#1080#1085#1080' '#1096#1083#1103#1093#1091' ('#1076#1083#1103' '#1110#1084#1077#1085#1110' '#1092#1072#1081#1083#1091' '#1094#1077#1081' '#1089#1080 +
          #1084#1074#1086#1083' '#1085#1077#1087#1088#1080#1087#1091#1089#1090#1080#1084#1080#1081')'#13'[ ] '#8211' '#1073#1083#1086#1082' '#1077#1083#1077#1084#1077#1085#1090#1072' '#1096#1072#1073#1083#1086#1085#1091'. '#1059' '#1073#1083#1086#1094#1110' '#1084#1086#1078#1077' '#1073#1091 +
          #1090#1080' '#1083#1080#1096#1077' '#1086#1076#1080#1085' '#1077#1083#1077#1084#1077#1085#1090' '#1096#1072#1073#1083#1086#1085#1091'. '#13#1058#1072#1082#1086#1078' '#1076#1086#1079#1074#1086#1083#1103#1102#1090#1100#1089#1103' '#1074#1082#1083#1072#1076#1077#1085#1110' '#1073#1083#1086#1082#1080 +
          '. '#1071#1082#1097#1086' '#1077#1083#1077#1084#1077#1085#1090' '#1096#1072#1073#1083#1086#1085#1091' '#1085#1077' '#1084#1072#1108' '#1079#1085#1072#1095#1077#1085#1085#1103', '#1074#1077#1089#1100' '#1073#1083#1086#1082' '#1085#1077' '#1074#1080#1074#1086#1076#1080#1090#1100#1089#1103'.' +
          #13#1044#1083#1103' '#1074#1080#1074#1077#1076#1077#1085#1085#1103' '#1077#1083#1077#1084#1077#1085#1090#1072' '#1091' '#1090#1088#1072#1085#1089#1083#1110#1090#1110' '#1085#1077#1086#1073#1093#1110#1076#1085#1086' '#1074#1074#1077#1089#1090#1080' '#1081#1086#1075#1086' '#1091' '#1074#1077#1088#1093 +
          #1085#1100#1086#1084#1091' '#13#1088#1077#1075#1110#1089#1090#1088#1110'.'
        ExplicitTop = -2
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1053#1072#1083#1072#1075#1086#1076#1078#1077#1085#1085#1103' '#1096#1072#1073#1083#1086#1085#1091
      ImageIndex = 1
      object Label5: TLabel
        Left = 104
        Top = 9
        Width = 47
        Height = 13
        Caption = #1055#1088#1110#1079#1074#1080#1097#1077
      end
      object Label6: TLabel
        Left = 240
        Top = 9
        Width = 18
        Height = 13
        Caption = #1030#1084#39#1103
      end
      object Label7: TLabel
        Left = 328
        Top = 9
        Width = 61
        Height = 13
        Caption = #1055#1086'-'#1073#1072#1090#1100#1082#1086#1074#1110
      end
      object Label8: TLabel
        Left = 64
        Top = 28
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label9: TLabel
        Left = 64
        Top = 54
        Width = 6
        Height = 13
        Caption = '2'
      end
      object Label4: TLabel
        Left = 156
        Top = 174
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label10: TLabel
        Left = 292
        Top = 174
        Width = 6
        Height = 13
        Caption = '2'
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 8
        Width = 62
        Height = 17
        Caption = #1040#1074#1090#1086#1088#1080
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = ParseTestTemplate
      end
      object Edit1: TEdit
        Left = 76
        Top = 24
        Width = 110
        Height = 21
        TabOrder = 1
        Text = #1055#1077#1085#1100#1082#1086#1074
        OnChange = ParseTestTemplate
      end
      object Edit2: TEdit
        Left = 192
        Top = 24
        Width = 106
        Height = 21
        TabOrder = 2
        Text = #1054#1083#1077#1082#1089#1110#1081
        OnChange = ParseTestTemplate
      end
      object Edit3: TEdit
        Left = 304
        Top = 24
        Width = 103
        Height = 21
        TabOrder = 3
        Text = #1042#1086#1083#1086#1076#1080#1084#1080#1088#1086#1074#1080#1095
        OnChange = ParseTestTemplate
      end
      object Edit5: TEdit
        Left = 304
        Top = 51
        Width = 103
        Height = 21
        TabOrder = 6
        Text = #1070#1085
        OnChange = ParseTestTemplate
      end
      object Edit4: TEdit
        Left = 192
        Top = 51
        Width = 106
        Height = 21
        TabOrder = 5
        Text = #1044#1077
        OnChange = ParseTestTemplate
      end
      object Edit6: TEdit
        Left = 76
        Top = 51
        Width = 110
        Height = 21
        TabOrder = 4
        Text = #1050#1110#1084
        OnChange = ParseTestTemplate
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 80
        Width = 140
        Height = 17
        Caption = #1053#1072#1079#1074#1072' '#1082#1085#1080#1075#1080
        Checked = True
        State = cbChecked
        TabOrder = 7
        OnClick = ParseTestTemplate
      end
      object Edit7: TEdit
        Left = 168
        Top = 78
        Width = 239
        Height = 21
        TabOrder = 8
        Text = #1058#1088#1080#1073#1086#1083#1086#1075#1110#1103' '#1076#1083#1103' '#1095#1072#1081#1085#1080#1082#1110#1074
        OnChange = ParseTestTemplate
      end
      object CheckBox3: TCheckBox
        Left = 8
        Top = 103
        Width = 140
        Height = 17
        Caption = #1057#1077#1088#1110#1103' '#1082#1085#1080#1075
        Checked = True
        State = cbChecked
        TabOrder = 9
        OnClick = ParseTestTemplate
      end
      object Edit8: TEdit
        Left = 168
        Top = 101
        Width = 239
        Height = 21
        TabOrder = 10
        Text = #1044#1083#1103' '#1095#1072#1081#1085#1080#1082#1110#1074
        OnChange = ParseTestTemplate
      end
      object CheckBox4: TCheckBox
        Left = 8
        Top = 126
        Width = 140
        Height = 17
        Caption = #1053#1086#1084#1077#1088' '#1082#1085#1080#1075#1080' '#1091' '#1089#1077#1088#1110#1111
        Checked = True
        State = cbChecked
        TabOrder = 11
        OnClick = ParseTestTemplate
      end
      object Edit9: TEdit
        Left = 168
        Top = 124
        Width = 239
        Height = 21
        TabOrder = 12
        Text = '2'
        OnChange = ParseTestTemplate
      end
      object CheckBox5: TCheckBox
        Left = 8
        Top = 149
        Width = 140
        Height = 17
        Caption = 'ID '#1082#1085#1080#1075#1080
        Checked = True
        State = cbChecked
        TabOrder = 13
        OnClick = ParseTestTemplate
      end
      object Edit10: TEdit
        Left = 168
        Top = 147
        Width = 239
        Height = 21
        TabOrder = 14
        Text = '12345'
        OnChange = ParseTestTemplate
      end
      object CheckBox6: TCheckBox
        Left = 8
        Top = 172
        Width = 140
        Height = 17
        Caption = #1046#1072#1085#1088#1080
        Checked = True
        State = cbChecked
        TabOrder = 15
        OnClick = ParseTestTemplate
      end
      object Edit11: TEdit
        Left = 168
        Top = 170
        Width = 105
        Height = 21
        TabOrder = 16
        Text = #1060#1110#1079#1080#1082#1072
        OnChange = ParseTestTemplate
      end
      object Edit12: TEdit
        Left = 304
        Top = 169
        Width = 103
        Height = 21
        TabOrder = 17
        Text = #1058#1077#1093#1085#1110#1082#1072
        OnChange = ParseTestTemplate
      end
      object CheckBox7: TCheckBox
        Left = 8
        Top = 195
        Width = 140
        Height = 17
        Caption = #1050#1086#1088#1077#1085#1077#1074#1080#1081' '#1078#1072#1085#1088
        Checked = True
        State = cbChecked
        TabOrder = 18
        OnClick = ParseTestTemplate
      end
      object Edit13: TEdit
        Left = 168
        Top = 193
        Width = 239
        Height = 21
        TabOrder = 19
        Text = #1053#1072#1091#1095#1087#1086#1087
        OnChange = ParseTestTemplate
      end
    end
  end
end
