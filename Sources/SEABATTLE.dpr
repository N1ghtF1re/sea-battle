    {$APPTYPE CONSOLE}

uses
  Sasha in 'units/Sasha.pas',
  typeandconst in 'units/typeandconst.pas',
  Kiryl in 'units/Kiryl.pas',
  Nikita in 'units/Nikita.pas',   SysUtils;

begin
  Readfile(Field1,Field2);
  game(Field1,Field2);
end.
