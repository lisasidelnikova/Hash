program HashProject;

uses
  Forms,
  MainForm in 'MainForm.pas' {HashForm},
  UEntries in 'UEntries.pas',
  UHashTable in 'UHashTable.pas',
  UPerson in 'UPerson.pas',
  AddPersonForm in 'AddPersonForm.pas' {AddUserForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(THashForm, HashForm);
  Application.CreateForm(TAddUserForm, AddUserForm);
  Application.Run;
end.
