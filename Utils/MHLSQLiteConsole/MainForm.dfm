object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'MHL SQLite simple console'
  ClientHeight = 779
  ClientWidth = 970
  Color = clBtnFace
  Constraints.MinHeight = 654
  Constraints.MinWidth = 523
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 17
  object pnButtons: TMHLSimplePanel
    Left = 855
    Top = 0
    Width = 115
    Height = 779
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alRight
    TabOrder = 0
    DesignSize = (
      115
      779)
    object btnExecute: TButton
      Left = 8
      Top = 95
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&Execute'
      Enabled = False
      TabOrder = 2
      OnClick = btnExecuteClick
    end
    object btnOpen: TButton
      Left = 8
      Top = 10
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Open'
      TabOrder = 0
      OnClick = btnOpenClick
    end
    object btnSelect: TButton
      Left = 8
      Top = 55
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '&Select'
      Enabled = False
      TabOrder = 1
      OnClick = btnSelectClick
    end
    object btnClear: TButton
      Left = 8
      Top = 714
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akLeft, akBottom]
      Caption = '&Clear'
      TabOrder = 3
      OnClick = btnClearClick
    end
    object btnExplain: TButton
      Left = 8
      Top = 136
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'E&xplain'
      Enabled = False
      TabOrder = 4
      OnClick = btnExplainClick
    end
  end
  object pnContent: TMHLSimplePanel
    Left = 0
    Top = 0
    Width = 855
    Height = 779
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    TabOrder = 1
    object MHLSplitter1: TMHLSplitter
      Left = 0
      Top = 300
      Width = 855
      Height = 6
      Cursor = crVSplit
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      ResizeControl = edQuery
      ExplicitTop = 299
    end
    object pnDBName: TMHLSimplePanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 847
      Height = 42
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      TabOrder = 2
      object dbName: TLabel
        Left = 0
        Top = 0
        Width = 847
        Height = 42
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        AutoSize = False
        EllipsisPosition = epPathEllipsis
        Layout = tlCenter
      end
    end
    object edQuery: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 54
      Width = 847
      Height = 242
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -22
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object lv: TListView
      AlignWithMargins = True
      Left = 4
      Top = 310
      Width = 847
      Height = 373
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alClient
      Columns = <>
      HideSelection = False
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
    end
    object pnStat: TGridPanel
      AlignWithMargins = True
      Left = 4
      Top = 691
      Width = 847
      Height = 84
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alBottom
      BevelOuter = bvNone
      ColumnCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 100.000000000000000000
        end
        item
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = Label1
          Row = 0
        end
        item
          Column = 1
          Control = prepareTime
          Row = 0
        end
        item
          Column = 0
          Control = Label3
          Row = 1
        end
        item
          Column = 1
          Control = execTime
          Row = 1
        end
        item
          Column = 0
          Control = Label5
          Row = 2
        end
        item
          Column = 1
          Control = rowsFetched
          Row = 2
        end>
      RowCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 20.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 20.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 20.000000000000000000
        end>
      ShowCaption = False
      TabOrder = 3
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 100
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Caption = 'Prepare time:'
        Layout = tlCenter
        ExplicitWidth = 90
      end
      object prepareTime: TLabel
        Left = 100
        Top = 0
        Width = 747
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Layout = tlCenter
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object Label3: TLabel
        Left = 0
        Top = 20
        Width = 100
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Caption = 'Exec time:'
        Layout = tlCenter
        ExplicitTop = 26
        ExplicitWidth = 65
        ExplicitHeight = 17
      end
      object execTime: TLabel
        Left = 100
        Top = 20
        Width = 747
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Layout = tlCenter
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object Label5: TLabel
        Left = 0
        Top = 40
        Width = 100
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Caption = 'Rows fetched:'
        Layout = tlCenter
        ExplicitTop = 52
        ExplicitWidth = 88
        ExplicitHeight = 17
      end
      object rowsFetched: TLabel
        Left = 100
        Top = 40
        Width = 747
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Layout = tlCenter
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
  end
  object dlgOpenDB: TOpenDialog
    Filter = 'All files (*.*)|*.*'
    Left = 88
    Top = 40
  end
end
