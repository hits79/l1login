program LoginGate;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {frm_main},
  Unit_MySuperMappedPortContext in '..\common\Unit_MySuperMappedPortContext.pas',
  BaseSet in 'frm\BaseSet.pas' {frm_baseset},
  Filter in 'frm\Filter.pas' {frm_filter},
  OnlinePlayers in 'frm\OnlinePlayers.pas' {frm_online};

//var
//  hMutex:THandle;
{$R *.res}

begin
///////////////////////////////�����������/////////////////////////////
{  hMutex := CreateMutex(nil,True,'john_server');
  if hMutex <> 0 then
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
    Application.MessageBox('����������','��ʾ');
    exit;
    end;  }
  Application.Initialize;
  Application.Title := '���õ�½����';
  Application.CreateForm(Tfrm_main, frm_main);
  Application.CreateForm(Tfrm_baseset, frm_baseset);
  Application.CreateForm(Tfrm_filter, frm_filter);
  Application.CreateForm(Tfrm_online, frm_online);
  Application.Run;
end.
