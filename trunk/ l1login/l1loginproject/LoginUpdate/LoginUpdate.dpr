program LoginUpdate;

uses
  Forms,
  Main in 'frm\Main.pas' {frm_main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
