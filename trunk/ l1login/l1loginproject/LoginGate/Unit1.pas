unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, IdMappedPortTCP,
  StdCtrls,IdContext,IdThread, ComCtrls, Menus, IdCoder, IdCoder3to4,
  IdCoder00E, IdCoderXXE,IniFiles, IdCustomTCPServer;

type
  Tfrm_main = class(TForm)
    IdMappedPortTCP1: TIdMappedPortTCP;
    MainMenu1: TMainMenu;
    N_CTRL: TMenuItem;
    N1: TMenuItem;
    N_SELECT: TMenuItem;
    H1: TMenuItem;
    mem_log: TMemo;
    StatusBar1: TStatusBar;
    N_START: TMenuItem;
    N_STOP: TMenuItem;
    N_CLEAR: TMenuItem;
    N4: TMenuItem;
    N_EXIT: TMenuItem;
    A1: TMenuItem;
    N_BASIC: TMenuItem;
    N_BLOCK: TMenuItem;
    N_ONLINE: TMenuItem;
    procedure IdMappedPortTCP1Connect(AContext: TIdContext);
    procedure IdMappedPortTCP1BeforeListenerRun(AThread: TIdThread);
    procedure IdMappedPortTCP1Execute(AContext: TIdContext);
    procedure N_STARTClick(Sender: TObject);
    procedure N_STOPClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure N_CLEARClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdMappedPortTCP1Disconnect(AContext: TIdContext);
    procedure IdMappedPortTCP1Exception(AContext: TIdContext;
      AException: Exception);
    procedure N_BASICClick(Sender: TObject);
    procedure N_BLOCKClick(Sender: TObject);
    procedure N_ONLINEClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure About;
    procedure AddLog(s:string);
  end;

var
  frm_main: Tfrm_main;
  ip:string;
  port:Integer;
  GatePort:integer;
implementation
uses Unit_MySuperMappedPortContext,BaseSet,Filter,OnlinePlayers;
{$R *.dfm}

procedure Tfrm_main.IdMappedPortTCP1Connect(AContext: TIdContext);
begin
if Filter.frm_filter.ListBox1.Items.IndexOf(AContext.Connection.Socket.Binding.PeerIP) >= 0  then
begin
  AContext.Connection.IOHandler.Close;
end;

statusbar1.Panels.Items[2].Text := IntToStr( IdMappedPortTCP1.Contexts.LockList.Count)+'/0';
IdMappedPortTCP1.Contexts.UnlockList;
end;

procedure Tfrm_main.IdMappedPortTCP1Disconnect(AContext: TIdContext);
begin
statusbar1.Panels.Items[2].Text := IntToStr( IdMappedPortTCP1.Contexts.LockList.Count)+'/0';
IdMappedPortTCP1.Contexts.UnlockList;
end;

procedure Tfrm_main.IdMappedPortTCP1BeforeListenerRun(AThread: TIdThread);
begin
  IdMappedPortTCP1.ContextClass := TMySuperMappedPortContext;

end;

procedure Tfrm_main.IdMappedPortTCP1Exception(AContext: TIdContext;
  AException: Exception);
begin
statusbar1.Panels.Items[2].Text := IntToStr( IdMappedPortTCP1.Contexts.LockList.Count)+'/0';
IdMappedPortTCP1.Contexts.UnlockList;
end;

procedure Tfrm_main.IdMappedPortTCP1Execute(AContext: TIdContext);
begin
if Filter.frm_filter.ListBox1.Items.IndexOf(AContext.Connection.Socket.Binding.PeerIP) >= 0  then
begin
  AContext.Connection.IOHandler.Close;
end;


  if AContext is TMySuperMappedPortContext then begin
    TMySuperMappedPortContext(AContext).DoDecode;
  end;
end;

procedure Tfrm_main.N_STARTClick(Sender: TObject);
begin
AddLog('正在启动服务...');
IdMappedPortTCP1.MappedHost:=ip;
StatusBar1.Panels.Items[3].Text:=ip;
IdMappedPortTCP1.MappedPort:=port;
IdMappedPortTCP1.Bindings.Clear;
with IdMappedPortTCP1.Bindings.Add  do
begin
  IP :='0.0.0.0';
  Port:=GatePort;
  StatusBar1.Panels[0].Text:=IntToStr(GatePort);
  StatusBar1.Panels[2].Text:='0/0';
end;
IdMappedPortTCP1.Active:=True;
N_START.Enabled:=False;
N_STOP.Enabled:=true;
AddLog('启动服务完成...');
end;

procedure Tfrm_main.N_STOPClick(Sender: TObject);
begin
AddLog('正在停止服务...');
IdMappedPortTCP1.Active:=False;
N_START.Enabled:=True;
N_STOP.Enabled:=False;
StatusBar1.Panels[0].Text:='????';
StatusBar1.Panels[2].Text:='????';
AddLog('停止服务完成...');
end;

procedure Tfrm_main.About;
begin
AddLog('天堂反外挂登陆网关 V 1.0');
AddLog('更新日期: 2009/09/30');
AddLog('程序制作: John QQ:7956214');
AddLog('程序网站: http://Www.PCsql.Com');
end;

procedure Tfrm_main.AddLog(s: string);
begin
mem_log.Lines.Add('['+ TimeToStr(Now) +'] '+s);
end;

procedure Tfrm_main.FormActivate(Sender: TObject);
begin
//About;
N_START.Click;
end;

procedure Tfrm_main.A1Click(Sender: TObject);
begin
ShowMessage('欢迎使用!');
//About;
end;

procedure Tfrm_main.N_BASICClick(Sender: TObject);
begin
BaseSet.frm_baseset.ShowModal;
end;

procedure Tfrm_main.N_BLOCKClick(Sender: TObject);
begin
Filter.frm_filter.ShowModal;
end;

procedure Tfrm_main.N_CLEARClick(Sender: TObject);
begin
if Application.MessageBox('是否清除日志?','信息',MB_YESNO + MB_ICONINFORMATION)=idyes then
begin
  mem_log.Clear;
end;

end;

procedure Tfrm_main.N_ONLINEClick(Sender: TObject);
begin
OnlinePlayers.frm_online.ShowModal;
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
var
  INI:TIniFile;
begin
  INI:=TIniFile.Create(ExtractFilePath(ParamStr(0))+ 'Config.ini');
  ip:=INI.ReadString('LoginGate','IP','127.0.0.1');
  port:=INI.ReadInteger('LoginGate','PORT',2000);
  GatePort:=INI.ReadInteger('LoginGate','GatePort',7956);
  INI.Free;
end;

end.
