object frmAuthorList: TfrmAuthorList
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1087#1080#1089#1086#1082' '#1072#1074#1090#1086#1088#1110#1074
  ClientHeight = 424
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 13
  object tvAuthorList: TVirtualStringTree
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 321
    Height = 377
    Align = alClient
    Colors.BorderColor = 15987699
    Colors.DisabledColor = clGray
    Colors.DropMarkColor = 15385233
    Colors.DropTargetColor = 15385233
    Colors.DropTargetBorderColor = 15385233
    Colors.FocusedSelectionColor = 15385233
    Colors.FocusedSelectionBorderColor = 15385233
    Colors.GridLineColor = 15987699
    Colors.HeaderHotColor = clBlack
    Colors.HotColor = clBlack
    Colors.SelectionRectangleBlendColor = 15385233
    Colors.SelectionRectangleBorderColor = 15385233
    Colors.SelectionTextColor = clBlack
    Colors.TreeLineColor = 9471874
    Colors.UnfocusedColor = clGray
    Colors.UnfocusedSelectionColor = clWhite
    Colors.UnfocusedSelectionBorderColor = clWhite
    Header.AutoSizeIndex = 0
    Header.DefaultHeight = 17
    Header.Height = 17
    Header.MainColumn = -1
    Header.Options = [hoColumnResize, hoDrag]
    TabOrder = 0
    TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
    OnFreeNode = tvAuthorListFreeNode
    OnGetText = tvAuthorListGetText
    OnGetNodeDataSize = tvAuthorListGetNodeDataSize
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Columns = <>
  end
  object pnButtons: TPanel
    Left = 0
    Top = 383
    Width = 327
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnButtons'
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 382
    ExplicitWidth = 323
    DesignSize = (
      327
      41)
    object btnOk: TButton
      Left = 159
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&'#1047#1073#1077#1088#1077#1075#1090#1080
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 155
    end
    object btnCancel: TButton
      Left = 240
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1042#1110#1076#1084#1110#1085#1072
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 236
    end
  end
end
