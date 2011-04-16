object frm_main: Tfrm_main
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #33258#21160#26356#26032#37197#32622#25991#20214#29983#25104#22120
  ClientHeight = 353
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 305
    Caption = #29983#25104#37197#32622
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 42
      Height = 12
      Caption = #29256#26412#21495':'
    end
    object Label2: TLabel
      Left = 12
      Top = 216
      Width = 48
      Height = 12
      Caption = 'Version:'
    end
    object Label3: TLabel
      Left = 12
      Top = 243
      Width = 24
      Height = 12
      Caption = 'Url:'
    end
    object edt_version: TEdit
      Left = 70
      Top = 21
      Width = 83
      Height = 20
      TabOrder = 0
    end
    object chk_coerce: TCheckBox
      Left = 176
      Top = 23
      Width = 73
      Height = 17
      Caption = #24378#21046#26356#26032
      TabOrder = 1
    end
    object lstvs: TListView
      Left = 8
      Top = 52
      Width = 250
      Height = 150
      Columns = <
        item
          Caption = 'version'
          Width = 60
        end
        item
          Caption = 'Url'
          Width = 185
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 2
      ViewStyle = vsReport
      OnClick = lstvsClick
    end
    object edt_lversion: TEdit
      Left = 61
      Top = 213
      Width = 188
      Height = 20
      TabOrder = 3
    end
    object edt_lurl: TEdit
      Left = 61
      Top = 240
      Width = 188
      Height = 20
      TabOrder = 4
    end
    object btn_add: TButton
      Left = 90
      Top = 268
      Width = 49
      Height = 25
      Caption = #28155#21152
      TabOrder = 5
      OnClick = btn_addClick
    end
    object btn_del: TButton
      Left = 200
      Top = 268
      Width = 49
      Height = 25
      Caption = #21024#38500
      TabOrder = 6
      OnClick = btn_delClick
    end
    object btn_edit: TButton
      Left = 145
      Top = 268
      Width = 49
      Height = 25
      Caption = #32534#36753
      TabOrder = 7
      OnClick = btn_editClick
    end
  end
  object btn_make: TButton
    Left = 184
    Top = 319
    Width = 82
    Height = 26
    Caption = #29983#25104#37197#32622#25991#20214
    TabOrder = 1
    OnClick = btn_makeClick
  end
end
