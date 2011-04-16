unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, ImgList, IdAntiFreezeBase,
  IdAntiFreeze, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, OleCtrls, SHDocVw, IdCoder, IdCoder3to4, IdCoderMIME,
  IdTCPServer, IdMappedPortTCP,IdThread, AppEvnts,common, VCLUnZip,
  IdCustomTCPServer,IdContext;

type
  Tfrm_main = class(TForm)
    img_background: TImage;
    lbl_capation: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbl_qq1: TLabel;
    lbl_Info: TLabel;
    lbl_close: TLabel;
    Label3: TLabel;
    spbtn_start: TSpeedButton;
    spbtn_close: TSpeedButton;
    cmb_gamelist: TComboBox;
    lbl_ver: TLabel;
    IdAntiFreeze1: TIdAntiFreeze;
    IdHTTP1: TIdHTTP;
    lbl_min: TLabel;
    IdDecoderMIME1: TIdDecoderMIME;
    IdEncoderMIME1: TIdEncoderMIME;
    chk_ck: TCheckBox;
    Label1: TLabel;
    spbtn_web: TSpeedButton;
    spbtn_payurl: TSpeedButton;
    apbtn_jieshao: TSpeedButton;
    apbtn_hudong: TSpeedButton;
    spbtn_payurl2: TSpeedButton;
    apbtn_xinshouka: TSpeedButton;
    web: TWebBrowser;
    VCLUnZip1: TVCLUnZip;
    IdMappedPortTCP1: TIdMappedPortTCP;
    WebBrowser1: TWebBrowser;
    btn_up: TButton;
    procedure lbl_closeClick(Sender: TObject);
    procedure spbtn_closeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure img_backgroundMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lbl_minClick(Sender: TObject);
    procedure spbtn_startClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spbtn_webClick(Sender: TObject);
    procedure spbtn_payurlClick(Sender: TObject);
    procedure spbtn_payurl2Click(Sender: TObject);
    procedure apbtn_xinshoukaClick(Sender: TObject);
    procedure apbtn_jieshaoClick(Sender: TObject);
    procedure apbtn_hudongClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdMappedPortTCP1BeforeListenerRun(AThread: TIdThread);
    procedure IdMappedPortTCP1Execute(AContext: TIdContext);
    procedure btn_upClick(Sender: TObject);


  private
    { Private declarations }
    procedure webcount;
  public
    { Public declarations }
    procedure readServerCfg;

  end;

var
  frm_main: Tfrm_main;
  Cfg: LoginCfg;
  CfgPath:string;  //��Ϸ����·��
  Servers:array of Server; //��Ϸ�б�

  LoginWeb:string;
  LoginDown:string;//���ص�ַ
  PayUrl:string;//��ֵ��ַ
  JieShao:string;//����
  XinShouKa:string;//���ֿ�
  HuDong:string;//����
  notice:string;//����
  KfQQ:string;//�ͷ�QQ

  LoginGate:Boolean;//�Ƿ�������
  AnitPlug:Boolean;//�Ƿ��������
implementation
uses IniFiles,load,fun,CnDES,CnBase64,Registry,Unit_MySuperMappedPortContext,AntiPlug,fupdate;
{$R *.dfm}
{$R res\res.res}
procedure Tfrm_main.lbl_closeClick(Sender: TObject);
begin
Close;
end;

procedure Tfrm_main.spbtn_closeClick(Sender: TObject);
begin
Close;
end;

procedure Tfrm_main.readServerCfg;
var
  ini:TIniFile;
  Mem:TMemoryStream;
  ServerVer:string;//�������汾��
  gamecount,i:Integer;
//  http:TIdHTTP;
begin
  //���ر������ļ�
  Mem:=TMemoryStream.Create;
  try
    IdHTTP1.Get(cfg.ServerCfg,Mem);
    mem.SaveToFile(CfgPath);
    Mem.Free;
  except
    ShowMessage('��ȡ������Ϣʧ��!');
    ExitProcess(0);
  end;

  try
    //����ini
    DecodeIni(CfgPath);
    //��ȡ�����ļ�
    ini:=TIniFile.Create(CfgPath);
    ServerVer:=ini.ReadString('ServerCfg','version','');//�ж��Ƿ����
    LoginDown :=ini.ReadString('ServerCfg','logindown','');//��¼�����ص�ַ
    if ServerVer<> cfg.LoginVer then
    begin
      ShowMessage('��½���汾��һ��,�뵽�ٷ���վ�������°汾��½��!');
      WinExec(PChar('explorer.exe '+ LoginDown),SW_SHOW);
      Exit;
    end;

    //��ȡ��¼����ַ
    LoginWeb:=ini.ReadString('ServerCfg','loginweb','');//�ٷ���վ
    PayUrl:=ini.ReadString('ServerCfg','payurl','');//��ֵ��ַ
    JieShao:=ini.ReadString('ServerCfg','jieshao','');//����
    XinShouKa:=ini.ReadString('ServerCfg','xinshouka','');//���ֿ�
    HuDong:=ini.ReadString('ServerCfg','hudong','');//����
    notice:=ini.ReadString('ServerCfg','notice','');//����
    KfQQ:=ini.ReadString('ServerCfg','kfqq','');//�ͷ�QQ
    LoginGate:=ini.ReadBool('ServerCfg','LoginGate',True);
    AnitPlug:=ini.ReadBool('ServerCfg','AnitPlug',True);

    //��ȡ��Ϸ�б�
    gamecount:=ini.ReadInteger('ServerCfg','gamecount',0); //��������
    SetLength(Servers,gamecount);//���������С
    for i:=0 to gamecount-1 do
    begin
      Servers[i].serverName:=ini.ReadString('ServerCfg','servername'+inttostr(i),'');
      Servers[i].serverIp:=ini.ReadString('ServerCfg','serverip'+inttostr(i),'');
      cmb_gamelist.Items.Add(Servers[i].serverName);
    end;
    cmb_gamelist.ItemIndex:=0;

    //���ù���
    WebBrowser1.Navigate(notice);
    //����QQ
    lbl_qq1.Caption:=KfQQ;
    lbl_Info.Caption:='��ȡ�����ļ��ɹ�!';
    //�����б�
    EncodeIni(CfgPath);

  except

    lbl_Info.Caption:='��ȡ�����ļ�ʧ��,����ϵ�ͷ�!';
  end;

end;

procedure Tfrm_main.FormActivate(Sender: TObject);
begin

  Cfg.LoginName := DESDecryptStr(Cfg.LoginName,key);
  Cfg.LoginVer := DESDecryptStr(Cfg.LoginVer,key);
  Cfg.ServerCfg := DESDecryptStr(Cfg.ServerCfg,key);
  Application.Title := cfg.LoginName;
  lbl_capation.Caption:= cfg.LoginName;
  lbl_ver.Caption:='Version: '+ cfg.LoginVer;
  CfgPath:=ExtractFilePath(ParamStr(0))+'\serverCfg.dll';

  readServerCfg;//��ȡ����
  webcount; //ͳ��

  //�Զ�����
  //fupdate.frm_update:=Tfrm_update.Create(self);
  //fupdate.frm_update.ShowModal;
  //fupdate.frm_update.Free;
end;

//������ͼƬ�϶�����
procedure Tfrm_main.img_backgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND,$f012,0);
end;



procedure Tfrm_main.lbl_minClick(Sender: TObject);
begin
Application.Minimize;
end;

procedure Tfrm_main.spbtn_startClick(Sender: TObject);
var
  frm:Tfrm_LoadWG;
  res:TResourceStream;
  loginStr:string;
  LoginPar:TStringList;

  AP:TAntiPlug;//������߳�
begin

  if chk_ck.Checked then
  begin
     res:=TResourceStream.Create(HInstance,'ck','cfg');
     res.SaveToFile('lineage.cfg');
     res.Free;
  end else begin
     res:=TResourceStream.Create(HInstance,'qp','cfg');
     res.SaveToFile('lineage.cfg');
     res.Free;
  end;

  res:=TResourceStream.Create(HInstance,'closenp','dll');
  res.SaveToFile('closenp.dll');
  res.Free;
  res:=TResourceStream.Create(HInstance,'LinS3EP1','dll');
  res.SaveToFile('LinS3EP1.dll');
  res.Free;

  res:=TResourceStream.Create(HInstance,'Lin','exe');
  res.SaveToFile('john.exe');
  res.Free;

  frm:=Tfrm_LoadWG.Create(nil);
  frm.ShowModal;
  frm.free;

  if AnitPlug then
  begin
    AP:=TAntiPlug.Create(false);
    ap.Resume;
  end;


  if LoginGate then
  begin
    //ӳ��˿�
    IdMappedPortTCP1.Active:=false;
    LoginPar:=TStringList.Create;
    LoginPar.DelimitedText:=Servers[cmb_gamelist.ItemIndex].serverip;
    LoginPar.Delimiter:=' ';
    IdMappedPortTCP1.MappedHost:= LoginPar.Strings[0];
    IdMappedPortTCP1.MappedPort:=StrToInt(LoginPar.Strings[1]);
    IdMappedPortTCP1.Active:=True;
    WinExec(PChar('john.exe 127.0.0.1 214'),SW_SHOW);
  end else
  begin
    loginStr:=string(servers[cmb_gamelist.ItemIndex].serverIp);
    WinExec(pchar('john.exe '+loginStr),SW_SHOW);
  end;
end;

procedure Tfrm_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ExitProcess(0);
end;


procedure Tfrm_main.spbtn_webClick(Sender: TObject);
begin
WinExec(PChar('explorer.exe ' + LoginWeb),SW_SHOW);
end;

procedure Tfrm_main.spbtn_payurlClick(Sender: TObject);
begin
WinExec(PChar('explorer.exe '+payurl),SW_SHOW);
end;

procedure Tfrm_main.spbtn_payurl2Click(Sender: TObject);
begin
WinExec(PChar('explorer.exe '+payurl),SW_SHOW);
end;

procedure Tfrm_main.apbtn_xinshoukaClick(Sender: TObject);
begin
WinExec(PChar('explorer.exe '+xinshouka),SW_SHOW);
end;

procedure Tfrm_main.btn_upClick(Sender: TObject);
begin
  fupdate.frm_update:=Tfrm_update.Create(self);
  fupdate.frm_update.ShowModal;
  fupdate.frm_update.Free;
end;

procedure Tfrm_main.apbtn_jieshaoClick(Sender: TObject);
begin
WinExec(PChar('explorer.exe '+jieshao),SW_SHOW);
end;

procedure Tfrm_main.apbtn_hudongClick(Sender: TObject);
begin
WinExec(PChar('explorer.exe '+hudong),SW_SHOW);
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
var
  fs:TMemoryStream;
begin
  try
    fs:=TMemoryStream.Create();
    fs.LoadFromFile(ParamStr(0));
    fs.Seek(-SizeOf(cfg),soEnd);
    fs.ReadBuffer(cfg,SizeOf(cfg));
  except
    ShowMessage('��¼���ڲ�����!');
    ExitProcess(0);
  end;

  if(Cfg.flag<>'7956214')then
  begin
    ShowMessage('����ģ��!');
    ExitProcess(0);
  end;
end;

procedure Tfrm_main.IdMappedPortTCP1BeforeListenerRun(AThread: TIdThread);
begin
 IdMappedPortTCP1.ContextClass := TMySuperMappedPortContext;
end;

procedure Tfrm_main.IdMappedPortTCP1Execute(AContext: TIdContext);
begin
  if AContext is TMySuperMappedPortContext then begin
    TMySuperMappedPortContext(AContext).DoEncode;
  end;
end;

procedure Tfrm_main.webcount;
var
  s:array[0..100] of Char;
  winpath:array[0..MAX_PATH] of Char;
  mem:TMemoryStream;
begin
  GetWindowsDirectory(winpath,SizeOf(winpath));
  s:='<script language="javascript" type="text/javascript" src="http://js.users.51.la/4342305.js"></script>';
  mem:=TMemoryStream.Create;
  mem.Write(s,SizeOf(s));
  mem.SaveToFile(winpath+'\temp.html');
  mem.Free;
  web.Navigate(winpath+'\temp.html');
  DeleteFile(winpath+'\temp.html');

end;

end.
