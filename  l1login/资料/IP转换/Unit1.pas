unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
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
procedure TForm1.Button1Click(Sender: TObject);
var
  strlist:TStringList;
  i:Integer;
begin
  strlist:=TStringList.Create;
  strlist.Delimiter:='.';
  strlist.DelimitedText:=Edit1.Text;
  for i := 0 to strlist.Count - 1 do
  begin
    Edit2.Text:=Edit2.Text+IntToHex(StrToInt(strlist.Strings[i]),2);
  end;
  Edit2.Text:=Edit2.Text;
  Edit2.Text:=IntToStr(HexToInt(Edit2.Text));

end;

end.
