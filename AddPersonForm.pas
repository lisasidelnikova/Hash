unit AddPersonForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAddUserForm = class(TForm)
    btnAdd: TButton;
    edtFIO: TEdit;
    lblName: TLabel;
    lbNumber: TLabel;
    edtNumber: TEdit;
    lblSalary: TLabel;
    edtSalary: TEdit;
    procedure btnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure numberFilterKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddUserForm: TAddUserForm;

implementation

uses MainForm, UPerson;
{$R *.dfm}

procedure TAddUserForm.btnAddClick(Sender: TObject);
var Person: TPerson;
begin
  edtFIO.Text := Trim(edtFIO.Text);
  if edtNumber.Text = '' then
    ShowMessage('Не указан табельный номер')
  else if edtFIO.Text = ''  then
    ShowMessage('Не указаны ФИО')
  else if edtSalary.Text = ''  then
    ShowMessage('Не указана зарплата')
  else
    begin
      Person := TPerson.Create(StrToInt(edtNumber.text),edtFIO.Text,
                StrToInt(edtSalary.Text));
      Self.Hide;
      HashForm.addPerson(Person);
    end;
end;

procedure TAddUserForm.FormShow(Sender: TObject);
begin
  edtNumber.Text := '0';
  edtFIO.Text := '';
  edtSalary.Text := '0';
end;

procedure TAddUserForm.numberFilterKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key >= ' ') and ((Key < '0') or (Key > '9')) then
      Key := #0;
end;

end.
