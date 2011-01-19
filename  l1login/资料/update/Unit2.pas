unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, StdCtrls, ComCtrls, IdAntiFreezeBase, IdAntiFreeze;

type
  TDownLoad = class(TThread)
  public
     FileList:TStringList;
  private
    { Private declarations }
    http:TIdHTTP;
    AWorkCountMax:Integer;
    AWorkCount:Integer;

    procedure WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Integer);
    procedure Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Integer);
    procedure UpdateWorkBegin;
    procedure UpdateWork;
  protected
  procedure Execute; override;

  end;






implementation
uses Unit1;
{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TDownLoad.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TDownLoad }





procedure TDownLoad.Execute;
var
  f:TFileStream;
  i:Integer;
  
begin
  http:=TIdHTTP.Create(nil);
  for i := 0 to FileList.Count - 1 do
  begin
    Unit1.Form1.Label3.Caption:= IntToStr(i+1)+'/'+IntToStr(FileList.Count);
    http.OnWorkBegin:=WorkBegin;
    http.OnWork := Work;
    f:=TFileStream.Create(Copy(FileList[i],LastDelimiter('/',FileList[i])+1,Length(FileList[i])),fmCreate);
    http.Get(FileList[i],f);
    f.Free;

  end;

end;

procedure TDownLoad.UpdateWork;
begin
   Unit1.Form1.Label2.Caption :=  IntToStr(AWorkCount);
   Unit1.Form1.ProgressBar1.Position := AWorkCount;
end;

procedure TDownLoad.UpdateWorkBegin;
begin
  Unit1.Form1.Label1.Caption :=  IntToStr(AWorkCountMax);
  Unit1.Form1.ProgressBar1.Max:=AWorkCountMax;
  Unit1.Form1.ProgressBar1.Position:=0;
  Unit1.Form1.ProgressBar1.Min:=0;
end;

procedure TDownLoad.Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Integer);
begin
  Self.AWorkCount := AWorkCount;
  Synchronize(UpdateWork);
end;

procedure TDownLoad.WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Integer);
begin
  Self.AWorkCountMax := AWorkCountMax;
  Synchronize(UpdateWorkBegin);
end;

end.
