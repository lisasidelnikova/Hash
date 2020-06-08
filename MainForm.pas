{Задан набор записей следующей структуры: табельный номер, ФИО,
заработная плата. По табельному номеру найти остальные сведения.

метод отрытой адресации (двойное хеширование)}

unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UHashTable, Menus, Grids, UPerson, AddPersonForm;

type
  THashForm = class(TForm)
    mmMain: TMainMenu;
    mniFile: TMenuItem;
    mniOpen: TMenuItem;
    mniSave: TMenuItem;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    matPersons: TStringGrid;
    mniFind: TMenuItem;
    mniRemove: TMenuItem;
    mniAdd: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mniOpenClick(Sender: TObject);
    procedure mniSaveClick(Sender: TObject);
    procedure mniFindClick(Sender: TObject);
    procedure mniRemoveClick(Sender: TObject);
    procedure mniAddClick(Sender: TObject);
  private
    function InputPersonId(var value: integer): boolean;
    procedure showPerson(person: TPerson);
  public
    procedure addPerson(person: TPerson);
  end;

var
  HashForm: THashForm;
  table: THashTable;
implementation

{$R *.dfm}

procedure THashForm.FormCreate(Sender: TObject);
begin
  table := THashTable.Create;
  with(matPersons) do
    begin
      Cols[0].Text := 'Табельный номер';
      Cols[1].Text := 'ФИО';
      Cols[2].Text := 'Зарплата';
      RowCount := 1;
    end;
end;

procedure THashForm.mniOpenClick(Sender: TObject);
var
  loadedCount: integer;
begin
  if dlgOpen.Execute then
    begin
      loadedCount := table.loadFromFile(dlgOpen.FileName);
      table.showInTable(matPersons);
      if loadedCount > 0 then
        ShowMessage('Загружено '+IntToStr(loadedCount)+' записей')
      else
        ShowMessage('Файл пуст');
    end;
end;

procedure THashForm.mniSaveClick(Sender: TObject);
begin
  if dlgSave.Execute then
    begin
      table.saveToFile(dlgSave.FileName);
      ShowMessage('Запись сохранена');
    end;
end;

procedure THashForm.mniFindClick(Sender: TObject);
var
  id: integer;
begin
  if InputPersonId(id) then
    showPerson(table.get(id));
end;

procedure THashForm.mniRemoveClick(Sender: TObject);
var
  id: Integer;
begin
  if InputPersonId(id) then
    if table.remove(id) then
      begin
        table.showInTable(matPersons);
        ShowMessage('Запись удалена');
      end
    else
      ShowMessage('Запись не найдена');
end;

function THashForm.InputPersonId(var value: integer): boolean;
var
  input: string;
begin
  result := InputQuery('','Введите табельный номер:', input)
  and TryStrToInt(input, value);
end;

procedure THashForm.addPerson(person: TPerson);
begin
  table.add(person.PersonnelNumber,person);
  table.showInTable(matPersons);
end;

procedure THashForm.showPerson(person: TPerson);
begin
  if person <> nil then
    with(person) do
      ShowMessage(person.FIO + #10#13 +  'Зарплата: ' + IntToStr(person.salary))
  else
    ShowMessage('Запись не найдена!');
end;

procedure THashForm.mniAddClick(Sender: TObject);
begin
  AddUserForm.Show;
end;

end.
