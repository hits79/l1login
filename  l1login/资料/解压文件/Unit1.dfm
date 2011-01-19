object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 254
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 304
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 168
    Top = 136
    Width = 150
    Height = 16
    TabOrder = 1
  end
  object VCLUnZip1: TVCLUnZip
    OnTotalPercentDone = VCLUnZip1TotalPercentDone
    Left = 352
    Top = 144
  end
end
