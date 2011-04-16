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
///////////////////////////////创建互斥进程/////////////////////////////
{  hMutex := CreateMutex(nil,True,'john_server');
  if hMutex <> 0 then
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
    Application.MessageBox('程序已运行','提示');
    exit;
    end;  }
  Application.Initialize;
  Application.Title := '天堂登陆网关';
  Application.CreateForm(Tfrm_main, frm_main);
  Application.CreateForm(Tfrm_baseset, frm_baseset);
  Application.CreateForm(Tfrm_filter, frm_filter);
  Application.CreateForm(Tfrm_online, frm_online);
  Application.Run;
end.
