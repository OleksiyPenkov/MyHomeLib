object frmAbout: TfrmAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
  ClientHeight = 295
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object RzPanel1: TMHLSimplePanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 249
    Height = 289
    Align = alClient
    TabOrder = 0
    object versionInfoLabel: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 38
      Width = 243
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = #1042#1077#1088#1089#1080#1103':'
      ExplicitWidth = 39
    end
    object RzLabel1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 243
      Height = 29
      Align = alTop
      Alignment = taCenter
      Caption = 'MyHomeLib'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 141
    end
    object RzLabel2: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 57
      Width = 243
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = '(c) 2008-2023 Oleksiy Penkov'
      ExplicitWidth = 143
    end
    object RzLabel3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 76
      Width = 243
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1080#1088#1086#1074#1072#1085#1080#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 115
    end
    object RzLabel4: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 178
      Width = 243
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = #1058#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 84
    end
    object RzLabel6: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 197
      Width = 243
      Height = 26
      Align = alTop
      Alignment = taCenter
      Caption = 'eg, Evgeniy_V, albert'#13' AlbanSpy, kaznelson, Olega'
      ExplicitWidth = 137
    end
    object RzLabel7: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 140
      Width = 243
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Icon Set:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 50
    end
    object RzLabel8: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 159
      Width = 243
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = #1040#1083#1077#1082#1089#1077#1081' '#1053#1077#1093#1072#1081
      ExplicitWidth = 76
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 95
      Width = 243
      Height = 39
      Align = alTop
      Alignment = taCenter
      Caption = #1040#1083#1077#1082#1089#1077#1081' '#1055#1077#1085#1100#1082#1086#1074#13#1053#1080#1082#1086#1083#1072#1081' '#1056#1099#1084#1072#1085#1086#1074#13#10'eg'
      ExplicitWidth = 90
    end
    object RzURLLabel: TMHLLinkLabel
      Left = 13
      Top = 227
      Width = 4
      Height = 4
      Alignment = taCenter
      TabOrder = 1
      OnLinkClick = RzURLLabelLinkClick
    end
    object RzBitBtn1: TButton
      Left = 91
      Top = 258
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
end
