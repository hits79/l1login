program Loginbuilder;

uses
  Forms,
  unit_main in 'unit_main.pas' {frm_main},
  common in '..\common\common.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
