object frm_main: Tfrm_main
  Left = 486
  Top = 231
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #30331#24405#22120#37197#32622#22120' v1.1 by:John'
  ClientHeight = 381
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 40
    Top = 144
    Width = 36
    Height = 12
    Caption = 'Label1'
  end
  object Label11: TLabel
    Left = 208
    Top = 192
    Width = 42
    Height = 12
    Caption = 'Label11'
  end
  object btn_cfg: TButton
    Left = 354
    Top = 348
    Width = 96
    Height = 25
    Caption = #29983#25104#37197#32622#25991#20214
    TabOrder = 0
    OnClick = btn_cfgClick
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 449
    Height = 329
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #22522#26412#37197#32622
      object GroupBox2: TGroupBox
        Left = 0
        Top = 2
        Width = 438
        Height = 297
        Caption = #22522#26412#37197#32622
        TabOrder = 0
        object GroupBox4: TGroupBox
          Left = 8
          Top = 16
          Width = 417
          Height = 49
          Caption = #29256#26412#21495#21450#20854#20182
          TabOrder = 0
          object Label5: TLabel
            Left = 16
            Top = 24
            Width = 42
            Height = 12
            Caption = #29256#26412#21495':'
          end
          object edt_serverversion: TEdit
            Left = 64
            Top = 19
            Width = 177
            Height = 20
            TabOrder = 0
          end
          object chk_logingate: TCheckBox
            Left = 247
            Top = 21
            Width = 74
            Height = 17
            Caption = #30331#38470#32593#20851
            TabOrder = 1
          end
          object chk_AnitPlug: TCheckBox
            Left = 334
            Top = 21
            Width = 65
            Height = 17
            Caption = #21453#22806#25346
            TabOrder = 2
          end
        end
        object GroupBox1: TGroupBox
          Left = 8
          Top = 71
          Width = 417
          Height = 170
          Caption = #38142#25509#22320#22336
          TabOrder = 1
          object lable1: TLabel
            Left = 16
            Top = 16
            Width = 54
            Height = 12
            Caption = #23448#26041#22320#22336':'
          end
          object Label2: TLabel
            Left = 16
            Top = 37
            Width = 54
            Height = 12
            Caption = #19979#36733#39029#38754':'
          end
          object Label3: TLabel
            Left = 16
            Top = 58
            Width = 54
            Height = 12
            Caption = #20805#20540#22320#22336':'
          end
          object Label4: TLabel
            Left = 16
            Top = 79
            Width = 54
            Height = 12
            Caption = #20171#32461#22320#22336':'
          end
          object Label6: TLabel
            Left = 16
            Top = 100
            Width = 42
            Height = 12
            Caption = #26032#25163#21345':'
          end
          object Label9: TLabel
            Left = 16
            Top = 121
            Width = 54
            Height = 12
            Caption = #20114#21160#22320#22336':'
          end
          object Label10: TLabel
            Left = 16
            Top = 143
            Width = 54
            Height = 12
            Caption = #20844#21578#22320#22336':'
          end
          object edt_loginweb: TEdit
            Left = 76
            Top = 13
            Width = 325
            Height = 20
            TabOrder = 0
          end
          object edt_logindown: TEdit
            Left = 76
            Top = 34
            Width = 325
            Height = 20
            TabOrder = 1
          end
          object edt_payurl: TEdit
            Left = 76
            Top = 55
            Width = 325
            Height = 20
            TabOrder = 2
          end
          object edt_jieshao: TEdit
            Left = 76
            Top = 76
            Width = 325
            Height = 20
            TabOrder = 3
          end
          object edt_xinshouka: TEdit
            Left = 76
            Top = 97
            Width = 325
            Height = 20
            TabOrder = 4
          end
          object edt_hudong: TEdit
            Left = 76
            Top = 118
            Width = 325
            Height = 20
            TabOrder = 5
          end
          object edt_notice: TEdit
            Left = 76
            Top = 140
            Width = 325
            Height = 20
            TabOrder = 6
          end
        end
        object GroupBox6: TGroupBox
          Left = 8
          Top = 247
          Width = 417
          Height = 41
          Caption = #23458#26381'QQ'
          TabOrder = 2
          object Label12: TLabel
            Left = 16
            Top = 18
            Width = 42
            Height = 12
            Caption = #23458#26381'QQ:'
          end
          object edt_kfqq: TEdit
            Left = 76
            Top = 14
            Width = 325
            Height = 20
            TabOrder = 0
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #26381#21153#22120#21015#34920
      ImageIndex = 1
      object GroupBox5: TGroupBox
        Left = 8
        Top = 3
        Width = 193
        Height = 286
        Caption = #26381#21153#22120#21015#34920
        TabOrder = 0
        object lst_game: TListBox
          Left = 11
          Top = 16
          Width = 150
          Height = 257
          ItemHeight = 12
          TabOrder = 0
          OnClick = lst_gameClick
        end
        object btn_up: TButton
          Left = 163
          Top = 37
          Width = 25
          Height = 25
          Caption = #8743
          TabOrder = 1
          OnClick = btn_upClick
        end
        object btn_down: TButton
          Left = 163
          Top = 80
          Width = 25
          Height = 25
          Caption = #8744
          TabOrder = 2
          OnClick = btn_downClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 207
        Top = 3
        Width = 225
        Height = 86
        Caption = #26381#21153#22120#20449#24687
        TabOrder = 1
        object Label7: TLabel
          Left = 16
          Top = 24
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#21517#23383':'
        end
        object Label8: TLabel
          Left = 24
          Top = 48
          Width = 54
          Height = 12
          Caption = 'IP'#21644#31471#21475':'
        end
        object edt_serverip: TEdit
          Left = 96
          Top = 48
          Width = 121
          Height = 20
          TabOrder = 0
        end
        object edt_servername: TEdit
          Left = 96
          Top = 24
          Width = 121
          Height = 20
          TabOrder = 1
        end
      end
      object btn_add: TButton
        Left = 220
        Top = 109
        Width = 59
        Height = 25
        Caption = #28155#21152
        TabOrder = 2
        OnClick = btn_addClick
      end
      object btn_edit: TButton
        Left = 285
        Top = 109
        Width = 57
        Height = 25
        Caption = #32534#36753
        TabOrder = 3
        OnClick = btn_editClick
      end
      object btn_del: TButton
        Left = 349
        Top = 109
        Width = 75
        Height = 25
        Caption = #21024#38500
        TabOrder = 4
        OnClick = btn_delClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = #21453#22806#25346#35774#32622
      ImageIndex = 2
      object GroupBox7: TGroupBox
        Left = 3
        Top = 3
        Width = 435
        Height = 297
        Caption = #31574#30053#35774#32622
        TabOrder = 0
        object Label13: TLabel
          Left = 201
          Top = 66
          Width = 30
          Height = 12
          Caption = #21517#23383':'
        end
        object rbtn_exe: TRadioButton
          Left = 16
          Top = 24
          Width = 113
          Height = 17
          Caption = #36827#31243#31574#30053
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbtn_exeClick
        end
        object rbtn_dll: TRadioButton
          Left = 160
          Top = 24
          Width = 113
          Height = 17
          Caption = 'DLL'#31574#30053
          TabOrder = 1
          OnClick = rbtn_exeClick
        end
        object rbtn_title: TRadioButton
          Left = 296
          Top = 24
          Width = 113
          Height = 17
          Caption = #26631#39064#31574#30053
          TabOrder = 2
          OnClick = rbtn_exeClick
        end
        object Panel1: TPanel
          Left = 16
          Top = 47
          Width = 393
          Height = 2
          TabOrder = 3
        end
        object lst_celue: TListBox
          Left = 16
          Top = 55
          Width = 171
          Height = 226
          ItemHeight = 12
          TabOrder = 4
          OnClick = lst_celueClick
        end
        object edt_celuename: TEdit
          Left = 240
          Top = 61
          Width = 161
          Height = 20
          TabOrder = 5
        end
        object btn_celue_add: TButton
          Left = 215
          Top = 87
          Width = 56
          Height = 25
          Caption = #28155#21152
          TabOrder = 6
          OnClick = btn_celue_addClick
        end
        object btn_celue_edit: TButton
          Left = 277
          Top = 87
          Width = 56
          Height = 25
          Caption = #20462#25913
          TabOrder = 7
          OnClick = btn_celue_editClick
        end
        object btn_celue_del: TButton
          Left = 339
          Top = 87
          Width = 56
          Height = 25
          Caption = #21024#38500
          TabOrder = 8
          OnClick = btn_celue_delClick
        end
      end
    end
  end
  object IdEncoderMIME1: TIdEncoderMIME
    FillChar = '='
    Left = 40
    Top = 344
  end
  object IdDecoderMIME1: TIdDecoderMIME
    FillChar = '='
    Left = 8
    Top = 344
  end
  object SaveDialog1: TSaveDialog
    Filter = #21015#34920#25991#20214'(*.txt)|*.txt'
    Left = 72
    Top = 344
  end
end
