unit unit_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME,common,
  CnClasses, CnTimer, OleCtrls, SHDocVw,idhttp;

type
  Tfrm_main = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edt_loginname: TEdit;
    Label2: TLabel;
    edt_version: TEdit;
    edt_cfg: TEdit;
    Label3: TLabel;
    web: TWebBrowser;
    btn_builder: TButton;
    btn_checkcfg: TButton;
    ListBox1: TListBox;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure btn_builderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_checkcfgClick(Sender: TObject);
  private
    { Private declarations }
    procedure NetLocal(bool:Boolean);
    procedure readini();
    procedure saveini();
    procedure webcount;
    procedure FindModule();
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;
  cfg:LoginCfg;
  Servers:array of Server;
  path:string;//模板路径
  CfgOk:Boolean=False;
implementation
uses IniFiles,CnDES,CnBase64;
{$R *.dfm}



procedure Tfrm_main.btn_builderClick(Sender: TObject);
var
  fs1,fs2:TFileStream;
begin

  //判断模板文件是否存在
  if(ListBox1.ItemIndex<0) then
  begin
    ShowMessage('请选择模板文件!');
    Exit;
  end;
  if not cfgok then
  begin
    ShowMessage('请先检测配置文件是否正确!');
    Exit;
  end;
  saveini;
  cfgok:=False;
  SaveDialog1.FileName:= Copy(ListBox1.Items[ListBox1.ItemIndex],0,pos('.',ListBox1.Items[ListBox1.ItemIndex]))+'exe';
  SaveDialog1.Filter:='登录器(*.exe)|*.exe';
  SaveDialog1.DefaultExt:='exe';
  SaveDialog1.InitialDir:=ExtractFilePath(ParamStr(0));
  if SaveDialog1.Execute() then
  begin
      fs2:=TFileStream.Create((ExtractFilePath(path)+ListBox1.Items[ListBox1.ItemIndex]), fmOpenReadWrite);
      fs2.Seek(-SizeOf(cfg),soEnd);
      fs2.ReadBuffer(cfg,SizeOf(cfg));
      fs2.Seek(0,soBeginning);
    if(cfg.flag='7956214') then
    begin
      ShowMessage('这不是模板文件!');
      exit;
    end;
    cfg.flag:='7956214';//标示
    cfg.LoginName:=DESEncryptStr(edt_loginname.Text,key);
    cfg.LoginVer:=DESEncryptStr(edt_version.Text,key);
    cfg.ServerCfg:=DESEncryptStr(edt_cfg.Text,key);
    fs1:=TFileStream.Create(SaveDialog1.FileName,fmCreate);
    fs1.CopyFrom(fs2,fs2.Size);
    fs1.Seek(0,soEnd);
    fs1.WriteBuffer(cfg,SizeOf(cfg));
    fs1.Free;
    fs2.Free;
    ShowMessage('配置成功!');

  end;
end;

procedure Tfrm_main.readini;
var
  ini:TIniFile;
begin
  ini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+ '\config.ini');
  edt_loginname.Text:=ini.ReadString('config','loginname','');
  edt_version.Text:=ini.ReadString('config','loginver','');
  edt_cfg.Text:=ini.ReadString('config','servercfg','');
  ini.Destroy;
end;



procedure Tfrm_main.saveini;
var
  ini:TIniFile;
begin
  ini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+ '\config.ini');
  ini.WriteString('config','loginname',edt_loginname.Text);
  ini.WriteString('config','loginver',edt_version.Text);
  ini.WriteString('config','servercfg',edt_cfg.Text);
  ini.Destroy;
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
begin
readini;
NetLocal(True);
FindModule;
end;

procedure Tfrm_main.NetLocal(bool: Boolean);
begin
   if bool then
   begin
     edt_cfg.Enabled:=True;
     edt_cfg.Color:= clWhite;

   end else begin
     edt_cfg.Enabled:=False;
     edt_cfg.Color:= clBtnFace;
   end;
end;

procedure Tfrm_main.webcount;
var
  s:array[0..100] of Char;
  winpath:array[0..MAX_PATH] of Char;
  mem:TMemoryStream;
begin
  GetWindowsDirectory(winpath,SizeOf(winpath));
  s:='<script language="javascript" type="text/javascript" src="http://js.users.51.la/4342355.js"></script>';
  mem:=TMemoryStream.Create;
  mem.Write(s,SizeOf(s));
  mem.SaveToFile(winpath+'\temp.html');
  mem.Free;
  web.Navigate(winpath+'\temp.html');
  DeleteFile(winpath+'\temp.html');
end;

procedure Tfrm_main.btn_checkcfgClick(Sender: TObject);
var
  http:TIdHTTP;
begin
  try
    http:=TIdHTTP.Create(nil);
    http.Get(edt_cfg.Text);
    http.Free;
  except
    ShowMessage('请检查配置文件是否正确!');
    Exit;
  end;
  CfgOk:=True;
  ShowMessage('配置文件已通过!');
end;

procedure Tfrm_main.FindModule;
var
  fh:Integer;
  sr:TSearchRec;
begin
  path:=ExtractFilePath(ParamStr(0))+'\模板\*.*';
  fh:=FindFirst(path,faAnyFile,sr);
  while fh = 0 do
  begin
    if (sr.Name <> '.') and (sr.Name <> '..') then
    begin
      ListBox1.Items.Add(sr.Name);
    end;
    fh := FindNext(sr);
  end;
  FindClose(sr);
end;

procedure Tfrm_main.FormActivate(Sender: TObject);
begin
webcount;
end;

end.
