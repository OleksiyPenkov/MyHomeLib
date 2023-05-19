inherited ImportProgressFormEx: TImportProgressFormEx
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  ClientHeight = 371
  ClientWidth = 442
  Constraints.MinHeight = 200
  Constraints.MinWidth = 300
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 454
  ExplicitHeight = 409
  TextHeight = 13
  inherited txtComment: TLabel
    Width = 416
    ExplicitWidth = 416
  end
  inherited ProgressBar: TProgressBar
    Width = 422
    TabOrder = 1
    ExplicitWidth = 418
  end
  inherited btnCancel: TButton
    Left = 346
    Top = 333
    TabOrder = 0
    ExplicitLeft = 342
    ExplicitTop = 332
  end
  object errorLog: TListView
    Left = 10
    Top = 52
    Width = 414
    Height = 275
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Width = 20
      end
      item
        AutoSize = True
      end>
    ColumnClick = False
    HoverTime = 65535
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    ExplicitWidth = 410
    ExplicitHeight = 274
  end
  object btnSaveLog: TButton
    Left = 10
    Top = 333
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1047#1073#1077#1088#1077#1075#1090#1080
    TabOrder = 3
    Visible = False
    OnClick = btnSaveLogClick
    ExplicitTop = 332
  end
  object Timer: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = TimerTimer
    Left = 216
    Top = 336
  end
end
