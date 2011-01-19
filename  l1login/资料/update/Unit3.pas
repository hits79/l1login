unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
uses Unit1;
{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
 frn:TForm1;
begin
  frn:=TForm1.Create(Self);
 frn.Show;
 //Form1.Show;
end;

end.
