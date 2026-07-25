object dlgUpdateFromFile: TdlgUpdateFromFile
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 190
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object lblFile: TLabel
    Left = 12
    Top = 12
    Width = 3
    Height = 13
  end
  object lblWarning: TLabel
    Left = 30
    Top = 92
    Width = 438
    Height = 45
    AutoSize = False
    WordWrap = True
  end
  object edFile: TEdit
    Left = 12
    Top = 31
    Width = 380
    Height = 21
    ReadOnly = True
    TabOrder = 0
    OnChange = edFileChange
  end
  object btnBrowse: TButton
    Left = 400
    Top = 29
    Width = 68
    Height = 25
    TabOrder = 1
    OnClick = btnBrowseClick
  end
  object cbFull: TCheckBox
    Left = 12
    Top = 68
    Width = 456
    Height = 17
    TabOrder = 2
  end
  object btnOk: TButton
    Left = 296
    Top = 152
    Width = 80
    Height = 25
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 388
    Top = 152
    Width = 80
    Height = 25
    Cancel = True
    ModalResult = 2
    TabOrder = 4
  end
end
