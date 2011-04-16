unit Unit_MySuperMappedPortContext;

interface
uses IdMappedPortTCP,IdCoderXXE,CnBase64;

type
  TMySuperMappedPortContext = Class(TIdMappedPortContext)
    public
      procedure DoEncode;
      procedure DoDecode;
  End;

var
  Xorkey:Integer=7;

implementation

function   Encode(Str:String):String;
var//加密
TmpChr:String;
i,Len:integer;
begin
  TmpChr:= Str;
  Len:=Length(TmpChr);
  for   i:=1   to   Len   do
  begin
    TmpChr[i]:= Char(Ord(TmpChr[i]) xor Xorkey);
  end;
    Result := TmpChr;
end;

function   Decode(Str:String):String;
var//解密
TmpChr:String;
i,Len:integer;
begin
  TmpChr:= Str;
  Len:=Length(TmpChr);
  for   i:=1   to   Len   do
  begin
    TmpChr[i]:= Char(Ord(TmpChr[i]) xor Xorkey);
  end;
    Result := TmpChr;
end;




{自定义加密函数}
function EncodeData(Src: String): String;
begin
  Result := Encode(Src);
end;

{自定义解密函数}
function DecodeData(Src: String): String;
begin
  Result := Decode(Src);
end;


{自定义加密接口}
procedure TMySuperMappedPortContext.DoEncode;
begin
  FNetData := EncodeData(FNetData);
end;

{自定义解密接口}
procedure TMySuperMappedPortContext.DoDecode;
begin
  FNetData := DecodeData(FNetData);
end;


end.
 