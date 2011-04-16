unit unit_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME,common,
  CnClasses, CnTimer, ComCtrls, ExtCtrls;

type
  Tfrm_main = class(TForm)
    IdEncoderMIME1: TIdEncoderMIME;
    IdDecoderMIME1: TIdDecoderMIME;
    SaveDialog1: TSaveDialog;
    btn_cfg: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    edt_serverversion: TEdit;
    chk_logingate: TCheckBox;
    chk_AnitPlug: TCheckBox;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    lst_game: TListBox;
    btn_up: TButton;
    btn_down: TButton;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    edt_serverip: TEdit;
    edt_servername: TEdit;
    btn_add: TButton;
    btn_edit: TButton;
    btn_del: TButton;
    GroupBox1: TGroupBox;
    lable1: TLabel;
    edt_loginweb: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edt_logindown: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edt_payurl: TEdit;
    edt_jieshao: TEdit;
    edt_xinshouka: TEdit;
    edt_hudong: TEdit;
    edt_notice: TEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    edt_kfqq: TEdit;
    GroupBox7: TGroupBox;
    rbtn_exe: TRadioButton;
    rbtn_dll: TRadioButton;
    rbtn_title: TRadioButton;
    Panel1: TPanel;
    lst_celue: TListBox;
    Label13: TLabel;
    edt_celuename: TEdit;
    btn_celue_add: TButton;
    btn_celue_edit: TButton;
    btn_celue_del: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lst_gameClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_cfgClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure btn_upClick(Sender: TObject);
    procedure btn_downClick(Sender: TObject);
    procedure rbtn_exeClick(Sender: TObject);
    procedure lst_celueClick(Sender: TObject);
    procedure btn_celue_addClick(Sender: TObject);
    procedure btn_celue_editClick(Sender: TObject);
    procedure btn_celue_delClick(Sender: TObject);
  private
    { Private declarations }
    procedure reflst();
    procedure readSini();
    procedure saveSini(FilePath:string);
    procedure savecfg();
    procedure reflstCelue();

    function CheckLstCelue():Boolean;
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;
  cfg:LoginCfg;
  Servers:array of Server;
  EXES:TStringList;
  DLLS:TStringList;
  TITLES:TStringList;


implementation
uses IniFiles;
{$R *.dfm}





procedure Tfrm_main.FormCreate(Sender: TObject);
begin
readSini;//读取配置
end;

procedure Tfrm_main.rbtn_exeClick(Sender: TObject);
begin
  reflstCelue;
end;

procedure Tfrm_main.readSini;
var
  ini:TIniFile;
  gamecount,i:Integer;
  tmp:string;
begin
  //获取游戏列表
  ini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'\config.ini');
  //读版本号
  edt_serverversion.Text:=ini.ReadString('ServerCfg','version','');
  //读列表数
  gamecount:=ini.ReadInteger('ServerCfg','gamecount',0);
  //设置列表数组
  SetLength(Servers,gamecount);
  //读列表
  for i:=0 to gamecount-1 do
  begin
     Servers[i].serverName:=ini.ReadString('ServerCfg','servername'+inttostr(i),'');
     Servers[i].serverIp:=ini.ReadString('ServerCfg','serverip'+inttostr(i),'');
  end;

  reflst;//刷新游戏列表

  //读登陆网关
  chk_logingate.Checked:= ini.ReadBool('ServerCfg','LoginGate',True);
  //读反外挂
  chk_AnitPlug.Checked := ini.ReadBool('ServerCfg','AnitPlug',True);
  //官方网站
  edt_loginweb.Text := ini.ReadString('ServerCfg','loginweb','');
  //下载地址
  edt_logindown.Text := ini.ReadString('ServerCfg','logindown','');
  //充值地址
  edt_payurl.Text := ini.ReadString('ServerCfg','payurl','');
  //介绍地址
  edt_jieshao.Text := ini.ReadString('ServerCfg','jieshao','');
  //新手卡地址
  edt_xinshouka.Text := ini.ReadString('ServerCfg','xinshouka','');
  //互动地址
  edt_hudong.Text := ini.ReadString('ServerCfg','hudong','');
  //公告地址
  edt_notice.Text := ini.ReadString('ServerCfg','notice','');
  //客服QQ
  edt_kfqq.Text := ini.ReadString('ServerCfg','kfqq','');
  //读取EXES
  tmp:= ini.ReadString('ServerCfg','EXES','');
  EXES := TStringList.Create;
  EXES.Delimiter:=',';
  EXES.DelimitedText:=tmp;
  //读取DLLS
  tmp:= ini.ReadString('ServerCfg','DLLS','');
  DLLS := TStringList.Create;
  DLLS.Delimiter:=',';
  DLLS.DelimitedText:=tmp;
  //读取TITLES
  tmp:= ini.ReadString('ServerCfg','TITLES','');
  TITLES := TStringList.Create;
  TITLES.Delimiter:=',';
  TITLES.DelimitedText:=tmp;
  rbtn_exe.Checked:=True;
  //刷新列表
  reflstCelue;
  ini.Free;
end;

procedure Tfrm_main.lst_celueClick(Sender: TObject);
begin
  edt_celuename.Text := lst_celue.Items[lst_celue.ItemIndex];
end;

procedure Tfrm_main.lst_gameClick(Sender: TObject);
begin
  edt_servername.Text:=servers[lst_game.ItemIndex].serverName;
  edt_serverip.Text:=servers[lst_game.ItemIndex].serverIp;
end;

procedure Tfrm_main.btn_addClick(Sender: TObject);
var
  temp:Server;
begin
  temp.serverName:=edt_servername.Text;
  temp.serverIp:=edt_serverip.Text;

  SetLength(Servers,Length(Servers)+1);
  Servers[Length(Servers)-1]:=temp;
  reflst;
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
  ShowMessage('添加成功!');
  lst_game.ItemIndex := lst_game.Count -1;
end;

procedure Tfrm_main.reflst;
var
  i:Integer;
begin
  lst_game.Clear;
  for i:=0 to Length(servers)-1 do
  begin
    lst_game.Items.Add(servers[i].serverName);
  end;
end;

procedure Tfrm_main.reflstCelue;
var
  tmpstrlst:TStringList;
  i:Integer;
begin
  tmpstrlst:=TStringList.Create;
  if rbtn_exe.Checked then
    tmpstrlst.Assign(EXES)
  else if rbtn_dll.Checked then
    tmpstrlst.Assign(DLLS)
  else
    tmpstrlst.Assign(TITLES);
  lst_celue.Clear;
  for I := 0 to tmpstrlst.Count - 1 do
  begin
    lst_celue.Items.Add(tmpstrlst.Strings[i]);
  end;  
  tmpstrlst.Free;
end;

procedure Tfrm_main.saveSini(FilePath:string);
var
  ini:TIniFile;
  i:Integer;
  tmp:string;
begin
  ini:=TIniFile.Create(FilePath);
  //写版本号
  ini.WriteString('ServerCfg','version',edt_serverversion.Text);
  //写游戏列表数
  ini.WriteInteger('ServerCfg','gamecount',Length(Servers));
  //写列表
  for i:=0 to Length(Servers)-1 do
  begin
     ini.WriteString('ServerCfg','servername'+inttostr(i),Servers[i].serverName);
     ini.WriteString('ServerCfg','serverip'+inttostr(i),Servers[i].serverIp);
  end;

  //写登陆网关
  ini.WriteBool('ServerCfg','LoginGate',chk_logingate.Checked);
  //写反外挂
  ini.WriteBool('ServerCfg','AnitPlug',chk_AnitPlug.Checked);
  //官方网站
  ini.WriteString('ServerCfg','loginweb',edt_loginweb.Text);
  //下载地址
  ini.WriteString('ServerCfg','logindown',edt_logindown.Text);
  //充值地址
  ini.WriteString('ServerCfg','payurl',edt_payurl.Text);
  //介绍地址
  ini.WriteString('ServerCfg','jieshao',edt_jieshao.Text);
  //新手卡地址
  ini.WriteString('ServerCfg','xinshouka',edt_xinshouka.Text);
  //互动地址
  ini.WriteString('ServerCfg','hudong',edt_hudong.Text);
  //公告地址
  ini.WriteString('ServerCfg','notice',edt_notice.Text);
  //客服QQ
  ini.WriteString('ServerCfg','kfqq',edt_kfqq.Text);
  //写取EXES
  tmp:='';
  for I := 0 to EXES.Count - 1 do
  begin
    tmp:= tmp + ',' + EXES.Strings[i];
  end;  
  tmp := Copy(tmp,2,Length(tmp));
  ini.WriteString('ServerCfg','EXES',tmp);
  //读取DLLS
  tmp:='';
  for I := 0 to DLLS.Count - 1 do
  begin
    tmp:= tmp + ',' + DLLS.Strings[i];
  end;
  tmp := Copy(tmp,2,Length(tmp));
  ini.WriteString('ServerCfg','DLLS',tmp);
  //读取TITLES
  tmp:='';
  for I := 0 to TITLES.Count - 1 do
  begin
    tmp:= tmp + ',' + TITLES.Strings[i];
  end;
  tmp := Copy(tmp,2,Length(tmp));
  ini.WriteString('ServerCfg','TITLES',tmp);

  ini.Free;

end;

procedure Tfrm_main.btn_celue_addClick(Sender: TObject);
begin
  if not CheckLstCelue then
  begin
    ShowMessage('请选择列表项目!');
    Exit;
  end;
  if rbtn_exe.Checked then
  begin
    EXES.Add(edt_celuename.Text);
  end;
  if rbtn_dll.Checked then
  begin
    DLLS.Add(edt_celuename.Text);
  end;
  if rbtn_title.Checked then
  begin
    TITLES.Add(edt_celuename.Text);
  end;
  reflstCelue;
  lst_celue.ItemIndex := lst_celue.Count -1;
  ShowMessage('添加成功!');
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
end;

procedure Tfrm_main.btn_celue_delClick(Sender: TObject);
var
  tmpindex:Integer;
begin
  if not CheckLstCelue then
  begin
    ShowMessage('请选择列表项目!');
    Exit;
  end;
  
  if rbtn_exe.Checked then
  begin
    EXES.Delete(lst_celue.ItemIndex); 
  end;
  if rbtn_dll.Checked then
  begin
    DLLS.Delete(lst_celue.ItemIndex); 
  end;
  if rbtn_title.Checked then
  begin
    TITLES.Delete(lst_celue.ItemIndex); 
  end;
  tmpindex:=lst_celue.ItemIndex-1;
  reflstCelue;
  if lst_celue.Count <> 0 then  
    lst_celue.ItemIndex := tmpindex;
  ShowMessage('删除成功!');
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
end;

procedure Tfrm_main.btn_celue_editClick(Sender: TObject);
var
  tmpindex:Integer;
begin
  if not CheckLstCelue then
  begin
    ShowMessage('请选择列表项目!');
    Exit;
  end;
  if rbtn_exe.Checked then
  begin
    EXES.Strings[lst_celue.ItemIndex]:=edt_celuename.Text; 
  end;
  if rbtn_dll.Checked then
  begin
    DLLS.Strings[lst_celue.ItemIndex]:=edt_celuename.Text; 
  end;
  if rbtn_title.Checked then
  begin
    TITLES.Strings[lst_celue.ItemIndex]:=edt_celuename.Text; 
  end;
  tmpindex:=lst_celue.ItemIndex;
  reflstCelue;
  lst_celue.ItemIndex := tmpindex;
  ShowMessage('修改成功!');
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
end;

procedure Tfrm_main.btn_cfgClick(Sender: TObject);
begin
saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
savecfg;

end;

procedure Tfrm_main.btn_editClick(Sender: TObject);
var
  temp:Server;
  index:integer;
begin
if (lst_game.ItemIndex <0)  then
begin
  ShowMessage('请选择项目!');
  Exit;
end;
  temp.serverName:=edt_servername.Text;
  temp.serverIp:=edt_serverip.Text;

  Servers[lst_game.ItemIndex]:=temp;
  index:=lst_game.ItemIndex;
  reflst;
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
  lst_game.ItemIndex:=index;
  ShowMessage('编辑成功!');
end;

procedure Tfrm_main.btn_delClick(Sender: TObject);
var
  i:Integer;
begin
if (lst_game.ItemIndex <0)then
begin
  ShowMessage('请选择项目!');
  Exit;
end;
  for i:=lst_game.ItemIndex to Length(servers)-2 do
  begin
    //temp:=servers[i];
    servers[i]:=servers[i+1];
  end;
  SetLength(Servers,Length(servers)-1);
  reflst;
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
  ShowMessage('删除成功!');
end;

procedure Tfrm_main.savecfg;
var
  mem:TStringList;
  s:string;
begin
  SaveDialog1.InitialDir:= ExtractFilePath(ParamStr(0));
  SaveDialog1.FileName:='servercfg.txt';
  SaveDialog1.DefaultExt:='txt';
  if SaveDialog1.Execute() then
  begin
    DeleteFile(SaveDialog1.FileName);
    saveSini(SaveDialog1.FileName);
    //加密
    EncodeIni(SaveDialog1.FileName);
    //DecodeIni(SaveDialog1.FileName);
    ShowMessage('保存成功!，请将生成的文件传值您的网站空间!');
  end;
end;





procedure Tfrm_main.btn_upClick(Sender: TObject);
var
  temp:Server;
  tempi:integer;
begin
if (lst_game.ItemIndex <0) or (lst_game.ItemIndex-1<0) then
begin
  ShowMessage('请选择项目!');
  Exit;
end;
  temp := servers[lst_game.ItemIndex];
  servers[lst_game.ItemIndex]:=servers[lst_game.ItemIndex-1];
  servers[lst_game.ItemIndex-1]:=temp;
  tempi:= lst_game.ItemIndex-1;
  reflst;
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
  lst_game.ItemIndex:=tempi;
end;


function Tfrm_main.CheckLstCelue: Boolean;
begin
  if lst_celue.ItemIndex<0 then
  Result := False
  else
  Result:=True;
end;

procedure Tfrm_main.btn_downClick(Sender: TObject);
var
  temp:Server;
  tempi:integer;
begin
if (lst_game.ItemIndex <0) or (lst_game.ItemIndex+1 = lst_game.Count) then
begin
  ShowMessage('请选择项目!');
  Exit;
end;
  temp := servers[lst_game.ItemIndex];
  servers[lst_game.ItemIndex]:=servers[lst_game.ItemIndex+1];
  servers[lst_game.ItemIndex+1]:=temp;
  tempi:= lst_game.ItemIndex+1;
  reflst;
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
  lst_game.ItemIndex:=tempi;
end;

end.
