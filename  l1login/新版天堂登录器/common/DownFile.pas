unit DownFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, StdCtrls, ComCtrls, IdAntiFreezeBase, IdAntiFreeze;

type
  TDownLoad = class(TThread)
  public
     FileList:TStringList;
  private
    { Private declarations }
    http:TIdHTTP;
    AWorkCountMax:Integer;
    AWorkCount:Integer;

    procedure WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Integer);
    procedure Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Integer);
    procedure WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure UpdateWorkBegin;
    procedure UpdateWork;
    procedure Unzip();
    procedure ZipPercent(Sender: TObject;Percent: Integer);
  protected
  procedure Execute; override;

  end;






implementation
uses fupdate,IniFiles,VCLUnZip;





procedure TDownLoad.Execute;
var
  f:TFileStream;
  i:Integer;

  inifile:TIniFile;
   ver:Integer;
   str:TStringList;

   res:TResourceStream;
begin
  http:=TIdHTTP.Create(nil);
  for i := 0 to FileList.Count - 1 do
  begin
    fupdate.frm_update.Label3.Caption:= IntToStr(i+1)+'/'+IntToStr(FileList.Count);
    http.OnWorkBegin:=WorkBegin;
    http.OnWork := Work;
    http.OnWorkEnd :=WorkEnd;
    f:=TFileStream.Create(Copy(FileList[i],LastDelimiter('/',FileList[i])+1,Length(FileList[i])),fmCreate);
    http.Get(FileList[i],f);
    f.Free;

  end;


  Synchronize(Unzip);

  //吃当
  res:=TResourceStream.Create(HInstance,'cd','exe');
  res.SaveToFile(ExtractFilePath(ParamStr(0))+'cd.exe');
  res.Free;
  MessageBox(fupdate.frm_update.Handle,'开始吃当，吃完当请重新打开登录器~','提示信息~',0);
  WinExec(PChar(ExtractFilePath(ParamStr(0))+'cd.exe'),SW_SHOW);


  //写入版本号
  inifile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'update.txt');
  ver:=inifile.ReadInteger('LoginUpdate','version',0);
  IniFile.free;

  DeleteFile(ExtractFilePath(ParamStr(0))+'johnver.txt');
  str:=TStringList.Create;
  str.Text:=IntToStr(ver);
  str.SaveToFile(ExtractFilePath(ParamStr(0))+'johnver.txt');
  str.Free;


  http.Free;

  ExitProcess(0);

end;

procedure TDownLoad.Unzip;
var
  inifile:TIniFile;
  str:TStringList;
  i,ver2:Integer;

  VCLUnZip1:TVCLUnZip;
begin
//解压文件
  VCLUnZip1:=TVCLUnZip.Create(nil);
  VCLUnZip1.OnTotalPercentDone :=ZipPercent;
  str:=TStringList.Create;
  str.LoadFromFile(ExtractFilePath(ParamStr(0))+'johnver.txt');
  ver2:=StrToInt(Trim(str.Text));

  str:=TStringList.Create;
  str.Delimiter:=',';
  inifile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'update.txt');
  str.DelimitedText:= inifile.ReadString('LoginUpdate','pathver','');
  fupdate.frm_update.Label2.Caption:='正在解压文件...';
  fupdate.frm_update.ProgressBar1.Max:=100;
  fupdate.frm_update.ProgressBar1.Min:=0;
  fupdate.frm_update.ProgressBar1.Position:=0;


  for I := str.IndexOf(IntToStr(ver2)) to str.Count - 1 do
  begin
    fupdate.frm_update.Label3.Caption:=  '任务进度:'+ IntToStr(i+1)+'/'+IntToStr(str.Count-str.IndexOf(IntToStr(ver2)));
    //ShowMessage(fupdate.frm_update.Label3.Caption);
    VCLUnZip1.ZipName:=ExtractFilePath(ParamStr(0))+str[i]+'.zip';
    VCLUnZip1.ReadZip;
    VCLUnZip1.DestDir:=ExtractFilePath(ParamStr(0));
    VCLUnZip1.RecreateDirs:=True;//是否创建子目录
    VCLUnZip1.DoAll := True;
    VCLUnZip1.OverwriteMode := Always;
    VCLUnZip1.Password := '';
    VCLUnZip1.UnZip;

  end;
  str.Free;
  IniFile.Free;
  VCLUnZip1.Free;
  fupdate.frm_update.Label2.Caption:='解压完毕...';
end;

procedure TDownLoad.UpdateWork;
begin
   fupdate.frm_update.Label2.Caption :=  '下载进度:'+IntToStr(AWorkCount div 1024)+'K/'+IntToStr(AWorkCountMax div 1024)+'K';
   fupdate.frm_update.ProgressBar1.Position := AWorkCount;
end;

procedure TDownLoad.UpdateWorkBegin;
begin
  fupdate.frm_update.Label2.Caption :=  '下载进度:0/'+IntToStr(AWorkCountMax div 1024);
  fupdate.frm_update.ProgressBar1.Max:=AWorkCountMax;
  fupdate.frm_update.ProgressBar1.Position:=0;
  fupdate.frm_update.ProgressBar1.Min:=0;
end;

procedure TDownLoad.Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Integer);
begin
  Self.AWorkCount := AWorkCount;
  Synchronize(UpdateWork);
end;

procedure TDownLoad.WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Integer);
begin
  Self.AWorkCountMax := AWorkCountMax;
  Synchronize(UpdateWorkBegin);
end;

procedure TDownLoad.WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  
end;

procedure TDownLoad.ZipPercent(Sender: TObject; Percent: Integer);
begin
  fupdate.frm_update.ProgressBar1.Position:=Percent;
end;

end.
