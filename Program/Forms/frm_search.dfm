object frmBookSearch: TfrmBookSearch
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 200
  BorderStyle = bsNone
  Caption = 'frmBookSearch'
  ClientHeight = 58
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  GlassFrame.Left = 5
  GlassFrame.Top = 5
  GlassFrame.Right = 5
  GlassFrame.Bottom = 5
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object RzPanel1: TMHLSimplePanel
    Left = 0
    Top = 0
    Width = 258
    Height = 58
    Align = alClient
    BorderWidth = 5
    TabOrder = 0
    ExplicitHeight = 63
    object Label1: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 242
      Height = 13
      Align = alTop
      Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1079#1074#1072#1085#1080#1102
      ExplicitWidth = 98
    end
    object edText: TEdit
      AlignWithMargins = True
      Left = 8
      Top = 27
      Width = 242
      Height = 21
      Align = alTop
      TabOrder = 0
      OnChange = edTextChange
      OnKeyDown = edTextKeyDown
    end
  end
end
