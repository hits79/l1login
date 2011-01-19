unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPrgres, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, StdCtrls, ComCtrls, IdAntiFreezeBase, IdAntiFreeze;

type
  TForm1 = class(TForm)
    ProgressBar1: TProgressBar;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    IdAntiFreeze1: TIdAntiFreeze;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses Unit2;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  //f:TFileStream;
  down:TDownLoad;
  filelist:TStringList;

begin
  Button1.Enabled:=False;
  down:=TDownLoad.Create(True);
  filelist:=TStringList.Create;
  filelist.Add('http://dl_dir.qq.com/qqtv/QQLive8.33.5589.0.exe');
  filelist.Add('http://toolbar.soso.com/T4/download/QQToolbarInstaller.exe');
  filelist.Add('http://dl_dir.qq.com/invc/qqdict/QQDict_Setup_10_142.exe');
  down.FileList:=filelist;
  down.Resume;

end;



end.
