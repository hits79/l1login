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
var//����
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
var//����
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




{�Զ�����ܺ���}
function EncodeData(Src: String): String;
begin
  Result := Encode(Src);
end;

{�Զ�����ܺ���}
function DecodeData(Src: String): String;
begin
  Result := Decode(Src);
end;


{�Զ�����ܽӿ�}
procedure TMySuperMappedPortContext.DoEncode;
begin
  FNetData := EncodeData(FNetData);
end;

{�Զ�����ܽӿ�}
procedure TMySuperMappedPortContext.DoDecode;
begin
  FNetData := DecodeData(FNetData);
end;


end.
 