object frm_filter: Tfrm_filter
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #23433#20840#36807#28388
  ClientHeight = 344
  ClientWidth = 190
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 169
    Height = 329
    Caption = 'IP'#36807#28388#35774#32622
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 272
      Width = 14
      Height = 13
      Caption = 'IP:'
    end
    object ListBox1: TListBox
      Left = 16
      Top = 16
      Width = 145
      Height = 247
      ItemHeight = 13
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 36
      Top = 269
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object btn_add: TButton
      Left = 16
      Top = 297
      Width = 57
      Height = 25
      Caption = #28155#21152
      TabOrder = 2
      OnClick = btn_addClick
    end
    object btn_remove: TButton
      Left = 79
      Top = 296
      Width = 57
      Height = 25
      Caption = #31227#38500
      TabOrder = 3
      OnClick = btn_removeClick
    end
  end
end
