unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  Tfrm_main = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edt_version: TEdit;
    chk_coerce: TCheckBox;
    lstvs: TListView;
    btn_make: TButton;
    edt_lversion: TEdit;
    edt_lurl: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    btn_add: TButton;
    btn_del: TButton;
    btn_edit: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lstvsClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure btn_makeClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadIni;
    procedure SaveIni;
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;

implementation
uses IniFiles;
{$R *.dfm}

procedure Tfrm_main.btn_addClick(Sender: TObject);
begin
  if (edt_lversion.Text <>'') and (edt_lurl.Text <> '') then
  begin
    with lstvs.Items.Add do
    begin
      Caption:=edt_lversion.Text;
      SubItems.Add(edt_lurl.Text);
    end;
  end;
  ShowMessage('添加成功');
end;

procedure Tfrm_main.btn_delClick(Sender: TObject);
begin
  if lstvs.ItemIndex >=0 then
  begin
    lstvs.Items.Delete(lstvs.ItemIndex);
  end;
  ShowMessage('删除成功');
end;

procedure Tfrm_main.btn_editClick(Sender: TObject);
var
  listitem:TListItem;
begin
  if lstvs.ItemIndex >=0 then
  begin
    listitem:=lstvs.Items[lstvs.ItemIndex];
    listitem.Caption:=edt_lversion.Text;
    listitem.SubItems[0]:=edt_lurl.Text;
  end;
  ShowMessage('修改完毕');
end;

procedure Tfrm_main.btn_makeClick(Sender: TObject);
begin
SaveIni;
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
begin
ReadIni;
end;

procedure Tfrm_main.lstvsClick(Sender: TObject);
begin
  if lstvs.ItemIndex >=0 then
  begin
    edt_lversion.Text:= lstvs.Items[lstvs.ItemIndex].Caption;
    edt_lurl.Text:=lstvs.Items[lstvs.ItemIndex].SubItems[0];
  end;

end;

procedure Tfrm_main.ReadIni;
var
  IniFIle:TIniFile;
  ps:TStringList;
  i:integer;
  listitem:TListItem;
begin
   lstvs.Items.Clear;
  IniFIle:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'LoginUpdate.ini');
  edt_version.Text:= IniFIle.ReadString('LoginUpdate','version','0000');
  chk_coerce.Checked:= IniFIle.ReadBool('LoginUpdate','coerce',False);
  ps:=TStringList.Create;
  ps.Delimiter:=',';
  ps.DelimitedText:= IniFIle.ReadString('LoginUpdate','pathver','');
  for I := 0 to ps.Count - 1 do
  begin
    listitem:=lstvs.Items.Add;
    listitem.Caption:=ps[i];
    listitem.SubItems.Add(IniFIle.ReadString('LoginUpdate',ps[i],''));
  end;

end;

procedure Tfrm_main.SaveIni;
var
  IniFIle:TIniFile;

  i:integer;
  listitem:TListItem;
  s:string;
begin
  DeleteFile(ExtractFilePath(ParamStr(0))+'LoginUpdate.ini');
  IniFIle:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'LoginUpdate.ini');
  IniFIle.WriteString('LoginUpdate','version',edt_version.Text);
  IniFIle.WriteBool('LoginUpdate','coerce',chk_coerce.Checked);


  for I := 0 to lstvs.Items.Count - 1 do
  begin
    listitem:=lstvs.Items[i];
    IniFIle.WriteString('LoginUpdate',listitem.Caption,listitem.SubItems[0]);
    //IniFIle.WriteString('LoginUpdate',listitem.Caption,s);
    s:=s+listitem.Caption+',';
  end;
  IniFIle.WriteString('LoginUpdate','pathver',Copy(s,0,Length(s)-1));

  ///ini2
  DeleteFile(ExtractFilePath(ParamStr(0))+'update.txt');
  IniFIle:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'update.txt');
  IniFIle.WriteString('LoginUpdate','version',edt_version.Text);
  IniFIle.WriteBool('LoginUpdate','coerce',chk_coerce.Checked);


  for I := 0 to lstvs.Items.Count - 1 do
  begin
    listitem:=lstvs.Items[i];
    IniFIle.WriteString('LoginUpdate',listitem.Caption,listitem.SubItems[0]);
    //IniFIle.WriteString('LoginUpdate',listitem.Caption,s);
    s:=s+listitem.Caption+',';
  end;
  IniFIle.WriteString('LoginUpdate','pathver',Copy(s,0,Length(s)-1));
  ShowMessage('保存完毕');
end;

end.
