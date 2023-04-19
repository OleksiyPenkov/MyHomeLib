inherited ImportProgressForm: TImportProgressForm
  BorderStyle = bsDialog
  Caption = #1048#1084#1087#1086#1088#1090
  ClientHeight = 87
  ClientWidth = 370
  Padding.Left = 10
  Padding.Top = 10
  Padding.Right = 10
  Padding.Bottom = 10
  Position = poMainFormCenter
  ExplicitWidth = 382
  ExplicitHeight = 125
  DesignSize = (
    370
    87)
  TextHeight = 13
  object txtComment: TLabel
    AlignWithMargins = True
    Left = 13
    Top = 13
    Width = 344
    Height = 13
    Align = alTop
    AutoSize = False
    Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1091#1077#1084'...'
    EllipsisPosition = epEndEllipsis
    ExplicitLeft = 10
    ExplicitTop = 10
    ExplicitWidth = 79
  end
  object ProgressBar: TProgressBar
    Left = 10
    Top = 29
    Width = 350
    Height = 17
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 346
  end
  object btnCancel: TButton
    Left = 277
    Top = 52
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    Default = True
    TabOrder = 1
    OnClick = btnCancelClick
    ExplicitLeft = 273
    ExplicitTop = 51
  end
end
