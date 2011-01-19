unit fupdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls,IdHTTP, VCLUnZip;

type
  Tfrm_update = class(TForm)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    VCLUnZip1: TVCLUnZip;
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure VCLUnZip1TotalPercentDone(Sender: TObject; Percent: Integer);
  private
    { Private declarations }
    procedure CMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    { Public declarations }
  end;

var
  frm_update: Tfrm_update;

implementation
uses DownFile,IniFiles;
{$R *.dfm}


procedure Tfrm_update.CMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  brush.style := bsClear;
  inherited;
end;

procedure Tfrm_update.FormActivate(Sender: TObject);
var
  down:TDownLoad;
  fs:TStringList;

  http:TIdHTTP;
  mem:TMemoryStream;
  str:TStringList;
  inifile:TIniFile;
  ver:Integer;
  ver2:Integer;
  i:Integer;
begin
try
  //下载配置文件
  http:=TIdHTTP.Create(nil);
  mem:=TMemoryStream.Create;
  http.Get('http://127.0.0.1/update.txt',mem);
  mem.SaveToFile('update.txt');
  mem.Free;
  http.Free;
  //版本号对比
  inifile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'update.txt');
  ver:=inifile.ReadInteger('LoginUpdate','version',0);
  str:=TStringList.Create;
  str.LoadFromFile(ExtractFilePath(ParamStr(0))+'johnver.txt');
  ver2:=StrToInt(Trim(str.Text));
  str.Free;
  //如果版本号相同则退出
  if ver = ver2 then
  begin
    //ShowMessage('不需要更新');
    postmessage(handle,WM_CLOSE,0,0);
    Exit;
  end;

  if inifile.ReadBool('LoginUpdate','coerce',False) =False then
  begin
    if MessageBox(Handle,'发现更新,是否更新?','更新提示',MB_YESNO) = IDNO then
    begin
      postmessage(handle,WM_CLOSE,0,0);
      Exit;    
    end;
  end;
  


  str:=TStringList.Create;
  str.Delimiter:=',';
  str.DelimitedText:= inifile.ReadString('LoginUpdate','pathver','');

  down:=TDownLoad.Create(true);
  fs:=TStringList.Create;
  //添加任务
  for I := str.IndexOf(IntToStr(ver2)) to str.Count - 1 do
  begin
    fs.Add(inifile.ReadString('LoginUpdate',str[i],''));
  end;
  down.FileList:=fs;
  down.Resume;
  IniFile.Free;
  str.Free;
except
  on E: Exception do
  begin
  ShowMessage(e.Message);
  postmessage(handle,WM_CLOSE,0,0);
  end;
end;


end;

procedure Tfrm_update.Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  SC_DragMove = $F012;
begin
  ReleaseCapture;
  Perform(WM_SysCommand, SC_DragMove, 0);
end;

procedure Tfrm_update.VCLUnZip1TotalPercentDone(Sender: TObject;
  Percent: Integer);
begin
  ProgressBar1.Position:=Percent;
end;

end.
