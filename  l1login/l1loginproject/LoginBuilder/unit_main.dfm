object frm_main: Tfrm_main
  Left = 299
  Top = 211
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #30331#24405#22120#29983#25104#22120' v1.1 by:JohnTao'
  ClientHeight = 267
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 433
    Height = 225
    Caption = #29983#25104#30331#24405#22120
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 23
      Width = 66
      Height = 12
      Caption = #30331#24405#22120#21517#31216':'
    end
    object Label2: TLabel
      Left = 218
      Top = 25
      Width = 42
      Height = 12
      Caption = #29256#26412#21495':'
    end
    object Label3: TLabel
      Left = 17
      Top = 47
      Width = 54
      Height = 12
      Caption = #37197#32622#22320#22336':'
    end
    object edt_loginname: TEdit
      Left = 89
      Top = 18
      Width = 121
      Height = 20
      TabOrder = 0
    end
    object edt_version: TEdit
      Left = 266
      Top = 18
      Width = 145
      Height = 20
      TabOrder = 1
    end
    object edt_cfg: TEdit
      Left = 89
      Top = 44
      Width = 288
      Height = 20
      TabOrder = 2
    end
    object btn_checkcfg: TButton
      Left = 383
      Top = 44
      Width = 28
      Height = 20
      Caption = #26816#27979
      TabOrder = 3
      OnClick = btn_checkcfgClick
    end
    object ListBox1: TListBox
      Left = 17
      Top = 70
      Width = 394
      Height = 138
      ItemHeight = 12
      TabOrder = 4
    end
  end
  object web: TWebBrowser
    Left = 80
    Top = 408
    Width = 300
    Height = 150
    TabOrder = 1
    ControlData = {
      4C000000021F0000810F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object btn_builder: TButton
    Left = 366
    Top = 239
    Width = 75
    Height = 25
    Caption = #29983#25104#30331#24405#22120
    TabOrder = 2
    OnClick = btn_builderClick
  end
  object OpenDialog1: TOpenDialog
    Left = 8
    Top = 240
  end
  object SaveDialog1: TSaveDialog
    Left = 40
    Top = 240
  end
end
