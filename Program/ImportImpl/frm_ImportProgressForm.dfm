inherited ImportProgressForm: TImportProgressForm
  BorderStyle = bsDialog
  Caption = #1030#1084#1087#1086#1088#1090
  ClientHeight = 85
  ClientWidth = 362
  Padding.Left = 10
  Padding.Top = 10
  Padding.Right = 10
  Padding.Bottom = 10
  Position = poMainFormCenter
  ExplicitWidth = 378
  ExplicitHeight = 124
  DesignSize = (
    362
    85)
  TextHeight = 13
  object txtComment: TLabel
    AlignWithMargins = True
    Left = 13
    Top = 13
    Width = 336
    Height = 13
    Align = alTop
    AutoSize = False
    Caption = #1030#1084#1087#1086#1088#1090#1091#1108#1084#1086'...'
    EllipsisPosition = epEndEllipsis
    ExplicitLeft = 10
    ExplicitTop = 10
    ExplicitWidth = 79
  end
  object ProgressBar: TProgressBar
    Left = 10
    Top = 29
    Width = 342
    Height = 17
    Align = alTop
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 257
    Top = 50
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1042#1110#1076#1084#1110#1085#1072
    Default = True
    TabOrder = 1
    OnClick = btnCancelClick
    ExplicitLeft = 261
  end
end
