unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R 2.RES}

procedure TForm1.Button1Click(Sender: TObject);
var
  h:HWND;
  ph:THandle;
  pid:Cardinal;
  ok:Boolean;
  p:Pointer;
  buffer:Byte;
  lpNumberOfBytesRead:DWORD;
  ip:string;
  ipbuf:array[1..200] of Byte;
  i:Integer;
  mem:TMemoryStream;
  res:TResourceStream;

  s:string;

  pc:PChar;
begin

  h:=FindWindow(nil,'Lineage Windows Client');
  while h=0 do
  begin
    h:=FindWindow(nil,'Lineage Windows Client');
    Sleep(200);
  end;
  
  if h<=0 then
  begin
  ShowMessage('Ê§°Ü');
  exit;
  end;
  GetWindowThreadProcessId(h,@pid);
  ph:=OpenProcess(PROCESS_ALL_ACCESS ,false,pid);
  if pid <=0 then
  begin
  ShowMessage('Ê§°Ü');
  exit;
  end;

{  p:=pointer($004C94C0);
  s:='EB';
  for I := 1 to length(s) div 2 do
  begin
   ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
  end;
  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);

  p:=pointer($00472A52);
  s:='90E9';
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

  //WriteProcessMemory(ph,p,mem.Memory,mem.Size,lpNumberOfBytesRead);
 


  for I := 0 to (mem.Size div 200)-1 do
  begin
    mem.ReadBuffer(ipbuf,SizeOf(ipbuf));
    WriteProcessMemory(ph,Pointer(integer(p)+i*200),Pointer(@ipbuf),SizeOf(ipbuf),lpNumberOfBytesRead);
  end;



//    p:=pointer($0046690B);
//  s:='0F8D';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//  p:=pointer($004675DA);
//  s:='74';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);;
//  end;
//
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//  p:=pointer($0046786E);
//  s:='0F8519010000';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//  p:=pointer($00416999);
//  s:='746E';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//  p:=pointer($00466A33);
//  s:='0084C00F84F500';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//  p:=pointer($004B6CE0);
//  s:='EB';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//  p:=pointer($0070132C);
//  s:='BA1C';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//  p:=pointer($006DA508);
//  s:='BA1C';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//      //asdsad
//
//  p:=pointer($0046786E);
//  s:='909090909090';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//  p:=pointer($0046690B);
//  s:='90E9';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);
//
//  p:=pointer($004675DA);
//  s:='EB';
//  for I := 1 to length(s) div 2 do
//  begin
//    ipbuf[i]:=StrToInt('$'+s[i+1*i-1]+s[i+1+1*i-1]);
//  end;
//  WriteProcessMemory(ph,p,Pointer(@ipbuf),length(s) div 2,lpNumberOfBytesRead);




  mem.Free;
  CloseHandle(ph);
  ShowMessage('³Â¹¦');
end;

end.
