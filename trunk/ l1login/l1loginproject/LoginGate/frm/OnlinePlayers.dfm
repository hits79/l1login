object frm_online: Tfrm_online
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #22312#32447#29609#23478
  ClientHeight = 295
  ClientWidth = 428
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
    Width = 410
    Height = 233
    Caption = #22312#32447#29609#23478'IP'
    TabOrder = 0
    object ListView1: TListView
      Left = 16
      Top = 24
      Width = 377
      Height = 193
      Columns = <
        item
          Caption = 'ID'
        end
        item
          Caption = 'IP'
          Width = 150
        end
        item
          Caption = 'PORT'
          Width = 80
        end>
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object btn_ref: TButton
    Left = 16
    Top = 256
    Width = 75
    Height = 25
    Caption = #21047#26032
    TabOrder = 1
    OnClick = btn_refClick
  end
end
