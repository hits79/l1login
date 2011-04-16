program LineageLogin;

uses
  Windows,
  Classes,
  Forms,
  Messages,
  main in 'frm\main.pas' {frm_main},
  load in 'frm\load.pas' {frm_LoadWG},
  fun in 'frm\fun.pas',
  common in '..\common\common.pas',
  Unit_MySuperMappedPortContext in '..\common\Unit_MySuperMappedPortContext.pas',
  AntiPlug in '..\common\AntiPlug.pas',
  fupdate in 'frm\fupdate.pas' {frm_update},
  DownFile in '..\common\DownFile.pas';

{$R *.res}

begin
  Mutex;//½ø³Ì»¥³â
  Application.Initialize;
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
