unit OnlinePlayers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,IdContext;

type
  Tfrm_online = class(TForm)
    GroupBox1: TGroupBox;
    ListView1: TListView;
    btn_ref: TButton;
    procedure btn_refClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_online: Tfrm_online;

implementation
uses Unit1;
{$R *.dfm}

procedure Tfrm_online.btn_refClick(Sender: TObject);
var
  i,count:Integer;
  idcon:TIdContext;
  item:TListItem;
begin
ListView1.Items.Clear;
count :=  frm_main.IdMappedPortTCP1.Contexts.LockList.Count;
for i := 0 to count - 1 do
begin
  idcon:=TIdContext(Unit1.frm_main.IdMappedPortTCP1.Contexts.LockList.Items[i]);
  item:=ListView1.Items.Add;
  item.Caption := IntToStr(i);
  item.SubItems.Add(idcon.Connection.Socket.Binding.PeerIP);
  item.SubItems.Add(IntToStr(idcon.Connection.Socket.Binding.PeerPort));
end;
frm_main.IdMappedPortTCP1.Contexts.UnlockList;
end;

procedure Tfrm_online.FormCreate(Sender: TObject);
begin
btn_ref.Click;
end;

end.
