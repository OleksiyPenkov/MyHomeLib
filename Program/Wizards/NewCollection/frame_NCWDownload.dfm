inherited frameNCWDownload: TframeNCWDownload
  Height = 160
  Constraints.MinHeight = 160
  Constraints.MinWidth = 320
  ExplicitHeight = 160
  object lblStatus: TLabel [0]
    AlignWithMargins = True
    Left = 14
    Top = 63
    Width = 292
    Height = 15
    Margins.Left = 14
    Margins.Top = 7
    Margins.Right = 14
    Margins.Bottom = 0
    Align = alTop
    Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' ...'
    ExplicitWidth = 90
  end
  object Bar: TProgressBar [1]
    AlignWithMargins = True
    Left = 14
    Top = 85
    Width = 292
    Height = 17
    Margins.Left = 14
    Margins.Top = 7
    Margins.Right = 14
    Margins.Bottom = 0
    Align = alTop
    TabOrder = 1
    ExplicitTop = 83
  end
  inherited pnTitle: TPanel
    inherited lblTitle: TLabel
      Width = 122
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1092#1072#1081#1083#1072' INPX'
      ExplicitWidth = 122
    end
    inherited lblSubTitle: TLabel
      Width = 269
      Caption = #1055#1086#1076#1086#1078#1076#1080#1090#1077', '#1087#1086#1082#1072' '#1092#1072#1081#1083' '#1073#1091#1076#1077#1090' '#1079#1072#1075#1088#1091#1078#1077#1085' '#1089' '#1089#1077#1088#1074#1077#1088#1072
      ExplicitWidth = 269
    end
  end
  object HTTP: TIdHTTP
    OnWork = HTTPWork
    OnWorkBegin = HTTPWorkBegin
    OnWorkEnd = HTTPWorkEnd
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 16
    Top = 112
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 192
    Top = 112
  end
  object IdSocksInfo: TIdSocksInfo
    Left = 72
    Top = 112
  end
end
