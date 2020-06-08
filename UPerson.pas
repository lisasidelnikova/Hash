unit UPerson;

interface
  
type

  TPerson = class
    PersonnelNumber: Integer;
    FIO : string[20];
    salary : Integer;

    constructor Create();  overload;
    constructor Create(PersonnelNumber: Integer; FIO: string;  salary : Integer); overload;
  end;

implementation
constructor TPerson.Create();
begin
  Self.PersonnelNumber := 0;
  Self.FIO := '';
  Self.salary := 0;
end;

constructor TPerson.Create(PersonnelNumber: Integer; FIO: string;  salary : Integer);
begin
  inherited Create;
  Self.PersonnelNumber := PersonnelNumber;
  Self.FIO := FIO;
  Self.salary := salary;
end;

end.
