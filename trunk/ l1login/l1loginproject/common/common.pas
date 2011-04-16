unit common;

interface
uses
  SysUtils,Classes,TlHelp32,DCPdes;

type
    LoginCfg= record
      Flag:string[10];//标志QQ
      LoginName:string[20];//='万佳天堂';
      LoginVer:string[10];//='2.0';
      ServerCfg:string[100];//='http://www.99tt1.com/ServerCFG.txt';//配置地址
    end;
  Server=record
    serverName:string[20];
    serverIp:string[20];
  end;

const key :string= '7956214';

function HexToInt(str:string) : Int64;
function GetHexIP(ip:string):string;
function GetRandomPassword(ALen: Integer): string;//获取随机字符串
function FindProcess(AFileName:string):boolean;   
procedure EncodeIni(FileName:string);
procedure DecodeIni(FileName:string);

implementation

function GetHexIP(ip:string):string;
var
  strlist:TStringList;
  i:Integer;
  hexip:string;
begin
  hexip:=ip;
  strlist:=TStringList.Create;
  strlist.Delimiter:='.';
  strlist.DelimitedText:=ip;
  for i := 0 to strlist.Count - 1 do
  begin
    hexip:=hexip+IntToHex(StrToInt(strlist.Strings[i]),2);
  end;
  hexip:=IntToStr(HexToInt(hexip));
  Result :=hexip;
end;
function HexToInt(str:string) : Int64;
var
i :Word;
value : Int64;
pos : Word;
begin
value:=0;
pos:=length(str);
for i:=1 to pos do
 begin
case str[i] of
'f','F':
value := value*16+15;
'e','E':
value := value*16+14;
'd','D':
value := value*16+13;
'c','C':
 value := value*16+12;
'b','B':
value := value*16+11;
'a','A':
value := value*16+10;
'0'..'9':
value := value*16+ord(str[i])-ord('0');
else
 result:=value;
exit;
end;
result:=value;
end;
end;
function GetRandomPassword(ALen: Integer): string;
var
str: string;
begin
Randomize;
str := 'ABCDEF0123456789';
Result := '';
repeat
    Result := Result + str[Random(Length(str)) + 1];
until (Length(Result) = ALen);
end;
function FindProcess(AFileName:string):boolean;
var  
hSnapshot:THandle;   
lppe:TProcessEntry32;   
Found:Boolean;   
begin  
Result:=False;   
hSnapshot:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);   
lppe.dwSize:=SizeOf(TProcessEntry32);   
Found:=Process32First(hSnapshot,lppe);   
while Found do  
    begin  
      if((UpperCase(ExtractFileName(lppe.szExeFile))=UpperCase(AFileName))   or   (UpperCase(lppe.szExeFile   )=UpperCase(AFileName))) then  
        begin  
        Result:=True;   
        end;   
      Found:=Process32Next(hSnapshot,lppe);   
    end;
end;
procedure EncodeIni(FileName:string);
var
  mem,mem2:TMemoryStream;
  dcp:TDCP_des;
begin
  dcp:=TDCP_des.Create(nil);
  dcp.Init('123456',48,nil);
  mem:=TMemoryStream.Create;
  mem2:=TMemoryStream.Create;
  mem.LoadFromFile(FileName);
  dcp.EncryptStream(mem,mem2,mem.Size);
  mem.Free;
  mem2.SaveToFile(FileName);
  mem2.Free;
end;

procedure DecodeIni(FileName:string);
var
  mem,mem2:TMemoryStream;
  dcp:TDCP_des;
begin
  dcp:=TDCP_des.Create(nil);
  dcp.Init('123456',48,nil);
  mem:=TMemoryStream.Create;
  mem2:=TMemoryStream.Create;
  mem.LoadFromFile(FileName);
  dcp.DecryptStream(mem,mem2,mem.Size);
  mem.Free;
  mem2.SaveToFile(FileName);
  mem2.Free;
end;


end.
