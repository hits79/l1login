object frm_baseset: Tfrm_baseset
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 170
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 113
    Caption = #22522#26412#35774#32622
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 52
      Height = 13
      Caption = #26412#22320#31471#21475':'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 38
      Height = 13
      Caption = #36716#21457'IP:'
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 52
      Height = 13
      Caption = #36716#21457#31471#21475':'
    end
    object edt_gameport: TEdit
      Left = 98
      Top = 21
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '2000'
    end
    object edt_ip: TEdit
      Left = 98
      Top = 45
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edt_port: TEdit
      Left = 98
      Top = 69
      Width = 121
      Height = 21
      TabOrder = 2
    end
  end
  object btn_save: TButton
    Left = 102
    Top = 136
    Width = 75
    Height = 25
    Caption = #20445#23384
    TabOrder = 1
    OnClick = btn_saveClick
  end
  object btn_cancel: TButton
    Left = 182
    Top = 137
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 2
    OnClick = btn_cancelClick
  end
end
