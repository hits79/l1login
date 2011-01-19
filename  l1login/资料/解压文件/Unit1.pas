unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VCLUnZip, ComCtrls;

type
  TForm1 = class(TForm)
    VCLUnZip1: TVCLUnZip;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure VCLUnZip1TotalPercentDone(Sender: TObject; Percent: Integer);
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
begin
VCLUnZip1.ZipName:=ExtractFilePath(ParamStr(0))+'abc.zip';
VCLUnZip1.ReadZip;
VCLUnZip1.DestDir:=ExtractFilePath(ParamStr(0));
VCLUnZip1.RecreateDirs:=True;//是否创建子目录
VCLUnZip1.DoAll := True;
VCLUnZip1.OverwriteMode := Always;
VCLUnZip1.Password := '';
VCLUnZip1.UnZip;
end;

procedure TForm1.VCLUnZip1TotalPercentDone(Sender: TObject; Percent: Integer);
begin
ProgressBar1.Position:=Percent;
end;

end.
