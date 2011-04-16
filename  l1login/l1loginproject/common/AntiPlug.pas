unit AntiPlug;

interface

uses
  Classes, Windows,IniFiles,Dialogs,common,SysUtils;

type
  TAntiPlug = class(TThread)
  private
    procedure SetName;
    procedure GetConfig;
  protected
    procedure Execute; override;
    procedure GetAllWindows;
  end;

var
  whwnd:HWND=0;
  EXES:TStringList;
  DLLS:TStringList;
  TITLES:TStringList;
  boolBianDang:Boolean=True;
implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TAntiPlug.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{$IFDEF MSWINDOWS}
type
  TThreadNameInfo = record
    FType: LongWord;     // must be 0x1000
    FName: PChar;        // pointer to name (in user address space)
    FThreadID: LongWord; // thread ID (-1 indicates caller thread)
    FFlags: LongWord;    // reserved for future use, must be zero
  end;
{$ENDIF}

{ TAntiPlug }

procedure TAntiPlug.GetAllWindows;
var
  Hwnd:THandle;
  Buf: array[0..MAX_PATH] of char;
  i:Integer;

  ph:THandle;
  pid:Cardinal;
  p:Pointer;
  mem:TMemoryStream;
  res:TResourceStream;
  ipbuf:array[1..200] of Byte;
  lpNumberOfBytesRead:DWORD;
  s:string;
  
begin
  //获取游戏窗口句柄
  if whwnd =0 then
  begin
   whwnd:= FindWindow(nil,'Lineage Windows Client');
   Exit;
  end;

  //变档
  if boolBianDang then
  begin
    if whwnd<=0 then
    begin
    ShowMessage('失败');
    exit;
    end;
    GetWindowThreadProcessId(whwnd,@pid);
    ph:=OpenProcess(PROCESS_ALL_ACCESS ,false,pid);
    if pid <=0 then
    begin
    ShowMessage('失败');
    exit;
    end;

{ p:=pointer($00416999);
  s:='746E';
  for I := 1 to length(s) div 2 do
  begin
    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
  end;

  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);

  p:=pointer($00466A33);
  s:='0084C00F84F500';
  for I := 1 to length(s) div 2 do
  begin
    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
  end;

  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);

  p:=pointer($004B6CE0);
  s:='EB';
  for I := 1 to length(s) div 2 do
  begin
    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
  end;

  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);

  p:=pointer($0070132C);
  s:='BA1C';
  for I := 1 to length(s) div 2 do
  begin
    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
  end;

  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);

  p:=pointer($006DA508);
  s:='BA1C';
  for I := 1 to length(s) div 2 do
  begin
    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
  end;

  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);

}
    p:=pointer($00504538);
    mem:=TMemoryStream.Create;
    res:=TResourceStream.Create(HInstance,'List','bin');
    mem.LoadFromStream(res);
    res.Free;
//    WriteProcessMemory(ph,p,mem.Memory,mem.Size,lpNumberOfBytesRead);
    for I := 0 to (mem.Size div 200)-1 do
    begin
      mem.ReadBuffer(ipbuf,SizeOf(ipbuf));
      WriteProcessMemory(ph,Pointer(integer(p)+i*200),Pointer(@ipbuf),SizeOf(ipbuf),lpNumberOfBytesRead);
    end; 

    mem.Free;
    CloseHandle(ph);
    boolBianDang := False;
  end;


  //如果设置窗体标题失败 则自动退出进程
  if (not SetWindowText(whwnd,PChar(GetRandomPassword(5)))) and (whwnd <>0) then
  begin
    ExitProcess(0);
  end;

  //更具DLL判断外挂
  for I := 0 to DLLS.Count - 1 do
  begin
    if (LoadLibrary(PChar(DLLS.Strings[i]))>0) then
    begin
      WinExec('cmd.exe /c echo 发现非法外挂.错误代码:101! & pause',SW_SHOW);
      ExitProcess(0);
    end;
  end;


  //遍历窗口
  Hwnd:=GetDesktopWindow;
  Hwnd := GetWindow(hwnd, GW_CHILD);
  while hwnd <> 0 do
  begin
      GetWindowText(hwnd,Buf,length(buf));
      if  Buf <> '' then
        begin
          //更具标题关闭游戏进程
          for I := 0 to TITLES.Count - 1 do
          begin
            if (pos(TITLES.Strings[i],Buf) >0) then
            begin
              WinExec('cmd.exe /c echo 发现非法外挂.错误代码:102! & pause',SW_SHOW);
              ExitProcess(0);
            end;
          end;
        end;
        Hwnd := GetWindow(hwnd, GW_HWNDNEXT);
  end;

  //更具进程名杀进程
    for I := 0 to EXES.Count - 1 do
  begin
    if FindProcess(EXES.Strings[i]) then
    begin
      WinExec('cmd.exe /c echo 发现非法外挂.错误代码:103! & pause',SW_SHOW);
      ExitProcess(0);
    end;
  end;

end;

procedure TAntiPlug.GetConfig;
var
  ini:TIniFile;
  tempstr,inipath:string;
  i:Integer;
begin
  inipath:=ExtractFilePath(ParamStr(0))+'\serverCfg.dll';
  DecodeIni(inipath);
  //读取EXE
  ini:=TIniFile.Create(inipath);
  tempstr:=ini.ReadString('ServerCfg','EXES','');
  if(tempstr<>'') then
  begin
     EXES:=TStringList.Create;
     EXES.Delimiter:=',';
     EXES.DelimitedText:=tempstr;
  end else
  begin
    MessageBox(0,'读取反外挂信息失败1!','',0);
    ExitProcess(0);
  end;

  //读取DLL

  tempstr:=ini.ReadString('ServerCfg','DLLS','');
  if(tempstr<>'') then
  begin
     DLLS:=TStringList.Create;
     DLLS.Delimiter:=',';
     DLLS.DelimitedText:=tempstr;
     for I := 0 to DLLS.Count - 1 do
     begin
       //删除所有DLL
       DeleteFile(DLLS.Strings[i]);
     end;
  end else
  begin
    MessageBox(0,'读取反外挂信息失败2!','',0);
    ExitProcess(0);
  end;

  //读取标题

  tempstr:=ini.ReadString('ServerCfg','TITLES','');
  if(tempstr<>'') then
  begin
     TITLES:=TStringList.Create;
     TITLES.Delimiter:=',';
     TITLES.DelimitedText:=tempstr;
  end else
  begin
    MessageBox(0,'读取反外挂信息失败1!','',0);
    ExitProcess(0);
  end;
  ini.Free;
  EncodeIni(inipath);
end;

procedure TAntiPlug.SetName;
{$IFDEF MSWINDOWS}
var
  ThreadNameInfo: TThreadNameInfo;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  ThreadNameInfo.FType := $1000;
  ThreadNameInfo.FName := 'AntiPlug';
  ThreadNameInfo.FThreadID := $FFFFFFFF;
  ThreadNameInfo.FFlags := 0;

  try
    RaiseException( $406D1388, 0, sizeof(ThreadNameInfo) div sizeof(LongWord), @ThreadNameInfo );
  except
  end;
{$ENDIF}
end;


procedure TAntiPlug.Execute;
var
  msg:TMsg;
begin
  SetName;
  GetConfig;
  { Place thread code here }
  SetTimer(0, 10{标识}, 2000{时间：毫秒}, @TAntiPlug.GetAllWindows);
  while GetMessage(msg, 0, 0, 0) do DispatchMessage(msg);
  killtimer(0,10{也可以是标识});//关闭定时器
end;

end.
