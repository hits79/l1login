unit BaseSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls;

type
  Tfrm_baseset = class(TForm)
    GroupBox1: TGroupBox;
    btn_save: TButton;
    btn_cancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edt_gameport: TEdit;
    edt_ip: TEdit;
    edt_port: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_baseset: Tfrm_baseset;

implementation
uses IniFiles;
{$R *.dfm}

procedure Tfrm_baseset.btn_cancelClick(Sender: TObject);
begin
Close;
end;

procedure Tfrm_baseset.btn_saveClick(Sender: TObject);
var
  ini:TIniFile;
begin
  ini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'\Config.ini');
  ini.WriteString('LoginGate','GatePort',edt_gameport.Text);
  ini.ReadString('LoginGate','IP',edt_ip.Text);
  ini.ReadString('LoginGate','PORT',edt_port.Text);
  ini.Free;
  ShowMessage('±£´æ³É¹¦!');
  Close;
end;

procedure Tfrm_baseset.FormCreate(Sender: TObject);
var
  ini:TIniFile;
begin
  ini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'\Config.ini');
  edt_gameport.Text:= ini.ReadString('LoginGate','GatePort','2000');
  edt_ip.Text:= ini.ReadString('LoginGate','IP','127.0.0.1');
  edt_port.Text:= ini.ReadString('LoginGate','PORT','7956');
  ini.Free;
end;

end.
