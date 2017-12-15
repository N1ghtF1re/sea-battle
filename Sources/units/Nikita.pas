unit Nikita;

interface
  uses typeandconst;
  const link1 =  ('player1.txt');
  const link2 =  ('player2.txt');
  procedure Readfile(var Field1,field2:TPlayingField);
Implementation

  procedure Readfile(var Field1,field2:TPlayingField);
  var f,g: file of char;
  var i,j: integer;
  var c: char;
  begin
    assign(f,link1);
    reset(f); 
    assign(g,link2);
    reset(g);
    for i:=1 to 10 do
    begin 
      for j:=1 to 10 do
      read(g,Field2[i,j]);
      read(f,Field1[i,j]);
    end;
    if i<>10 THEN
    begin
      read(f,c);
      read(f,c); 
      read(g,c);
      read(g,c);
    end;
  end;

end.
