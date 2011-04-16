unit Filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Tfrm_filter = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Label1: TLabel;
    Edit1: TEdit;
    btn_add: TButton;
    btn_remove: TButton;
    procedure btn_addClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_removeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_filter: Tfrm_filter;

implementation

{$R *.dfm}

procedure Tfrm_filter.btn_addClick(Sender: TObject);
begin
if Edit1.Text ='' then Exit;

ListBox1.Items.Add(Edit1.Text);
ListBox1.Items.SaveToFile('filter.txt');
end;

procedure Tfrm_filter.btn_removeClick(Sender: TObject);
begin
if ListBox1.ItemIndex >= 0 then
begin
  ListBox1.Items.Delete(ListBox1.ItemIndex);
  ListBox1.Items.SaveToFile('filter.txt');
end;

end;

procedure Tfrm_filter.FormCreate(Sender: TObject);
begin
ListBox1.Items.LoadFromFile('filter.txt');
end;

end.
