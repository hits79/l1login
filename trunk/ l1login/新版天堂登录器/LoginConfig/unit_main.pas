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
readSini;//��ȡ����
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
  //��ȡ��Ϸ�б�
  ini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'\config.ini');
  //���汾��
  edt_serverversion.Text:=ini.ReadString('ServerCfg','version','');
  //���б���
  gamecount:=ini.ReadInteger('ServerCfg','gamecount',0);
  //�����б�����
  SetLength(Servers,gamecount);
  //���б�
  for i:=0 to gamecount-1 do
  begin
     Servers[i].serverName:=ini.ReadString('ServerCfg','servername'+inttostr(i),'');
     Servers[i].serverIp:=ini.ReadString('ServerCfg','serverip'+inttostr(i),'');
  end;

  reflst;//ˢ����Ϸ�б�

  //����½����
  chk_logingate.Checked:= ini.ReadBool('ServerCfg','LoginGate',True);
  //�������
  chk_AnitPlug.Checked := ini.ReadBool('ServerCfg','AnitPlug',True);
  //�ٷ���վ
  edt_loginweb.Text := ini.ReadString('ServerCfg','loginweb','');
  //���ص�ַ
  edt_logindown.Text := ini.ReadString('ServerCfg','logindown','');
  //��ֵ��ַ
  edt_payurl.Text := ini.ReadString('ServerCfg','payurl','');
  //���ܵ�ַ
  edt_jieshao.Text := ini.ReadString('ServerCfg','jieshao','');
  //���ֿ���ַ
  edt_xinshouka.Text := ini.ReadString('ServerCfg','xinshouka','');
  //������ַ
  edt_hudong.Text := ini.ReadString('ServerCfg','hudong','');
  //�����ַ
  edt_notice.Text := ini.ReadString('ServerCfg','notice','');
  //�ͷ�QQ
  edt_kfqq.Text := ini.ReadString('ServerCfg','kfqq','');
  //��ȡEXES
  tmp:= ini.ReadString('ServerCfg','EXES','');
  EXES := TStringList.Create;
  EXES.Delimiter:=',';
  EXES.DelimitedText:=tmp;
  //��ȡDLLS
  tmp:= ini.ReadString('ServerCfg','DLLS','');
  DLLS := TStringList.Create;
  DLLS.Delimiter:=',';
  DLLS.DelimitedText:=tmp;
  //��ȡTITLES
  tmp:= ini.ReadString('ServerCfg','TITLES','');
  TITLES := TStringList.Create;
  TITLES.Delimiter:=',';
  TITLES.DelimitedText:=tmp;
  rbtn_exe.Checked:=True;
  //ˢ���б�
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
  ShowMessage('��ӳɹ�!');
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
  //д�汾��
  ini.WriteString('ServerCfg','version',edt_serverversion.Text);
  //д��Ϸ�б���
  ini.WriteInteger('ServerCfg','gamecount',Length(Servers));
  //д�б�
  for i:=0 to Length(Servers)-1 do
  begin
     ini.WriteString('ServerCfg','servername'+inttostr(i),Servers[i].serverName);
     ini.WriteString('ServerCfg','serverip'+inttostr(i),Servers[i].serverIp);
  end;

  //д��½����
  ini.WriteBool('ServerCfg','LoginGate',chk_logingate.Checked);
  //д�����
  ini.WriteBool('ServerCfg','AnitPlug',chk_AnitPlug.Checked);
  //�ٷ���վ
  ini.WriteString('ServerCfg','loginweb',edt_loginweb.Text);
  //���ص�ַ
  ini.WriteString('ServerCfg','logindown',edt_logindown.Text);
  //��ֵ��ַ
  ini.WriteString('ServerCfg','payurl',edt_payurl.Text);
  //���ܵ�ַ
  ini.WriteString('ServerCfg','jieshao',edt_jieshao.Text);
  //���ֿ���ַ
  ini.WriteString('ServerCfg','xinshouka',edt_xinshouka.Text);
  //������ַ
  ini.WriteString('ServerCfg','hudong',edt_hudong.Text);
  //�����ַ
  ini.WriteString('ServerCfg','notice',edt_notice.Text);
  //�ͷ�QQ
  ini.WriteString('ServerCfg','kfqq',edt_kfqq.Text);
  //дȡEXES
  tmp:='';
  for I := 0 to EXES.Count - 1 do
  begin
    tmp:= tmp + ',' + EXES.Strings[i];
  end;  
  tmp := Copy(tmp,2,Length(tmp));
  ini.WriteString('ServerCfg','EXES',tmp);
  //��ȡDLLS
  tmp:='';
  for I := 0 to DLLS.Count - 1 do
  begin
    tmp:= tmp + ',' + DLLS.Strings[i];
  end;
  tmp := Copy(tmp,2,Length(tmp));
  ini.WriteString('ServerCfg','DLLS',tmp);
  //��ȡTITLES
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
    ShowMessage('��ѡ���б���Ŀ!');
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
  ShowMessage('��ӳɹ�!');
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
end;

procedure Tfrm_main.btn_celue_delClick(Sender: TObject);
var
  tmpindex:Integer;
begin
  if not CheckLstCelue then
  begin
    ShowMessage('��ѡ���б���Ŀ!');
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
  ShowMessage('ɾ���ɹ�!');
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
end;

procedure Tfrm_main.btn_celue_editClick(Sender: TObject);
var
  tmpindex:Integer;
begin
  if not CheckLstCelue then
  begin
    ShowMessage('��ѡ���б���Ŀ!');
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
  ShowMessage('�޸ĳɹ�!');
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
  ShowMessage('��ѡ����Ŀ!');
  Exit;
end;
  temp.serverName:=edt_servername.Text;
  temp.serverIp:=edt_serverip.Text;

  Servers[lst_game.ItemIndex]:=temp;
  index:=lst_game.ItemIndex;
  reflst;
  saveSini(ExtractFilePath(ParamStr(0))+'\config.ini');
  lst_game.ItemIndex:=index;
  ShowMessage('�༭�ɹ�!');
end;

procedure Tfrm_main.btn_delClick(Sender: TObject);
var
  i:Integer;
begin
if (lst_game.ItemIndex <0)then
begin
  ShowMessage('��ѡ����Ŀ!');
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
  ShowMessage('ɾ���ɹ�!');
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
    //����
    EncodeIni(SaveDialog1.FileName);
    //DecodeIni(SaveDialog1.FileName);
    ShowMessage('����ɹ�!���뽫���ɵ��ļ���ֵ������վ�ռ�!');
  end;
end;





procedure Tfrm_main.btn_upClick(Sender: TObject);
var
  temp:Server;
  tempi:integer;
begin
if (lst_game.ItemIndex <0) or (lst_game.ItemIndex-1<0) then
begin
  ShowMessage('��ѡ����Ŀ!');
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
  ShowMessage('��ѡ����Ŀ!');
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
