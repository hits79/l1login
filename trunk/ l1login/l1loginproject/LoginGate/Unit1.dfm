object frm_main: Tfrm_main
  Left = 394
  Top = 200
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22825#22530#30331#38470#32593#20851
  ClientHeight = 222
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object mem_log: TMemo
    Left = 0
    Top = 0
    Width = 334
    Height = 203
    Align = alClient
    ReadOnly = True
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 203
    Width = 334
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = '????'
        Width = 50
      end
      item
        Alignment = taCenter
        Width = 50
      end
      item
        Alignment = taCenter
        Text = '????'
        Width = 50
      end
      item
        Alignment = taCenter
        Width = 50
      end>
  end
  object IdMappedPortTCP1: TIdMappedPortTCP
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 7956
      end>
    DefaultPort = 0
    ListenQueue = 1000
    OnBeforeListenerRun = IdMappedPortTCP1BeforeListenerRun
    OnConnect = IdMappedPortTCP1Connect
    OnDisconnect = IdMappedPortTCP1Disconnect
    OnException = IdMappedPortTCP1Exception
    MappedHost = '127.0.0.1'
    MappedPort = 25510
    OnExecute = IdMappedPortTCP1Execute
    Left = 80
    Top = 24
  end
  object MainMenu1: TMainMenu
    Left = 48
    Top = 24
    object N_CTRL: TMenuItem
      Caption = #25511#21046'(&C)'
      object N_START: TMenuItem
        Caption = #21551#21160#26381#21153'(&S)'
        OnClick = N_STARTClick
      end
      object N_STOP: TMenuItem
        Caption = #20572#27490#26381#21153'(&T)'
        OnClick = N_STOPClick
      end
      object N_CLEAR: TMenuItem
        Caption = #28165#31354#26085#24535'(&C)'
        OnClick = N_CLEARClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object N_EXIT: TMenuItem
        Caption = #36864#20986'(&E)'
      end
    end
    object N1: TMenuItem
      Caption = #26597#30475'(&V)'
      object N_ONLINE: TMenuItem
        Caption = #22312#32447#29609#23478'(&O)'
        OnClick = N_ONLINEClick
      end
    end
    object N_SELECT: TMenuItem
      Caption = #36873#39033'(&S)'
      object N_BASIC: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = N_BASICClick
      end
      object N_BLOCK: TMenuItem
        Caption = #23433#20840#36807#28388'(&S)'
        OnClick = N_BLOCKClick
      end
    end
    object H1: TMenuItem
      Caption = #24110#21161'(&H)'
      object A1: TMenuItem
        Caption = #20851#20110'(&A)'
        OnClick = A1Click
      end
    end
  end
end
