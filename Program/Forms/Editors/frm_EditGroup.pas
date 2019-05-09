unit frm_EditGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmEditGroup = class(TForm)
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edGroupName: TEdit;
    procedure edGroupNameChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetGroupName: string;
    procedure SetGroupName(const Value: string);

    property GroupName: string read GetGroupName write SetGroupName;
  public
    { Public declarations }
  end;

var
  frmEditGroup: TfrmEditGroup;

function NewGroup(var groupName: string): Boolean;

function EditGroup(var groupName: string): Boolean;


implementation

resourcestring
  rstrNewGroup = 'Новая группа';
  rstrEditGroup = 'Редактирование группы';

{$R *.dfm}

procedure TfrmEditGroup.FormShow(Sender: TObject);
begin
  edGroupNameChange(nil);
end;

function TfrmEditGroup.GetGroupName: string;
begin
  Result := Trim(edGroupName.Text);
end;

procedure TfrmEditGroup.SetGroupName(const Value: string);
begin
  edGroupName.Text := Value;
end;

procedure TfrmEditGroup.edGroupNameChange(Sender: TObject);
begin
  btnOk.Enabled := GroupName <> '';
end;

function InternalEditGroup(createNew: Boolean; var groupName: string): Boolean;
var
  frmEditGroup: TfrmEditGroup;
begin
  frmEditGroup := TfrmEditGroup.Create(Application);
  try
    if createNew then
    begin
      frmEditGroup.Caption := rstrNewGroup;
    end
    else
    begin
      frmEditGroup.Caption := rstrEditGroup;
      frmEditGroup.GroupName := groupName;
    end;

    Result := (frmEditGroup.ShowModal = mrOk);

    if Result then
      groupName := frmEditGroup.GroupName;
  finally
    frmEditGroup.Free;
  end;
end;

function NewGroup(var groupName: string): Boolean;
begin
  Result := InternalEditGroup(True, groupName);
end;

function EditGroup(var groupName: string): Boolean;
begin
  Result := InternalEditGroup(False, groupName);
end;

end.
