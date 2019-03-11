object frmStat: TfrmStat
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086' '#1082#1086#1083#1083#1077#1082#1094#1080#1080
  ClientHeight = 244
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    473
    244)
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton
    Left = 390
    Top = 211
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 0
    ExplicitTop = 341
  end
  object lvInfo: TListView
    Left = 8
    Top = 8
    Width = 457
    Height = 197
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = 'Prop'
        Width = 100
      end
      item
        Caption = 'Value'
        Width = 350
      end>
    ColumnClick = False
    Groups = <
      item
        Header = #1054#1073#1097#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
        ExtendedImage = -1
      end
      item
        Header = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
        GroupID = 2
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
        ExtendedImage = -1
      end>
    Items.ItemData = {
      03A10100000700000000000000FFFFFFFFFFFFFFFF0100000000000000000000
      00081D0430043704320430043D04380435040873007500620020006900740065
      006D0000000000FFFFFFFFFFFFFFFF0100000000000000000000000D14043004
      42043004200041043E043704340430043D0438044F0408730075006200200069
      00740065006D0000000000FFFFFFFFFFFFFFFF01000000000000000000000006
      120435044004410438044F040873007500620020006900740065006D00000000
      00FFFFFFFFFFFFFFFF010000000000000000000000081E043F04380441043004
      3D04380435040873007500620020006900740065006D0000000000FFFFFFFFFF
      FFFFFF010000000200000000000000071004320442043E0440043E0432040873
      007500620020006900740065006D0000000000FFFFFFFFFFFFFFFF0100000002
      00000000000000041A043D04380433040873007500620020006900740065006D
      0000000000FFFFFFFFFFFFFFFF01000000020000000000000005210435044004
      380439040873007500620020006900740065006D00FFFFFFFFFFFFFFFFFFFFFF
      FFFFFF}
    GroupView = True
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    TabOrder = 1
    ViewStyle = vsReport
  end
end
