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
  ipbuf:array [1..20] of Byte;
  i:Integer;
begin

  h:=FindWindow(nil,'Lineage Windows Client');
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
  p:=pointer($007aa34c);
  while true do
  begin
  Sleep(100);
  ok:=ReadProcessMemory(ph,p,Pointer(@buffer),SizeOf(Byte),lpNumberOfBytesRead);
    if buffer=9 then
    begin
    p:=pointer($007a9f5c);
    ip:='125.46.41.18';
    for I := 1 to Length(ip) do
    begin
      ipbuf[i]:=ord(ip[i]);
    end;
    for I := Length(ip)+1 to 20 do
    begin
      ipbuf[i]:=0;
    end;
    WriteProcessMemory(ph,p,Pointer(@ipbuf),SizeOf(ipbuf),lpNumberOfBytesRead);
    Break;
    end;
  end;
  CloseHandle(ph);
  ShowMessage('³Â¹¦');
end;

end.
