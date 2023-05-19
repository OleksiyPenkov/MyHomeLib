object frmStat: TfrmStat
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1082#1086#1083#1077#1082#1094#1110#1111
  ClientHeight = 244
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    473
    244)
  TextHeight = 13
  object btnClose: TButton
    Left = 386
    Top = 211
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1080#1090#1080
    Default = True
    ModalResult = 1
    TabOrder = 0
    ExplicitLeft = 382
    ExplicitTop = 210
  end
  object lvInfo: TListView
    Left = 8
    Top = 8
    Width = 453
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
        Header = #1047#1072#1075#1072#1083#1100#1085#1072' '#1110#1085#1092#1086#1088#1084#1072#1094#1110#1103
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
        GroupID = 2
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end>
    Items.ItemData = {
      05B10100000700000000000000FFFFFFFFFFFFFFFF0100000000000000000000
      00051D0430043704320430040873007500620020006900740065006D00C0B3E2
      3900000000FFFFFFFFFFFFFFFF0100000000000000000000000E140430044204
      300420004104420432043E04400435043D043D044F0408730075006200200069
      00740065006D001874E23900000000FFFFFFFFFFFFFFFF010000000000000000
      00000006120435044004410456044F040873007500620020006900740065006D
      0078E1E23900000000FFFFFFFFFFFFFFFF010000000000000000000000041E04
      3F04380441040873007500620020006900740065006D00B0BEE23900000000FF
      FFFFFFFFFFFFFF010000000200000000000000071004320442043E0440045604
      32040873007500620020006900740065006D00E8E1E23900000000FFFFFFFFFF
      FFFFFF010000000200000000000000041A043D04380433040873007500620020
      006900740065006D0068C2E23900000000FFFFFFFFFFFFFFFF01000000020000
      000000000005210435044004560439040873007500620020006900740065006D
      0058E2E239FFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    GroupView = True
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    TabOrder = 1
    ViewStyle = vsReport
  end
end
