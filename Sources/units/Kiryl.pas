unit Kiryl;

interface
  uses
    typeandconst,SysUtils;
  function  checkHitting(Matrix:TPlayingField;var i,j:byte):boolean;
  procedure  turn_declaration(var j,i:byte);

implementation
  function  checkHitting(Matrix:TPlayingField;var i,j:byte):boolean;
  var wound:Boolean;
  begin
    if Matrix[i,j]='K' then
      wound:=True
    else
      wound:=False;
    if wound=false then
    begin
      Writeln('NE POPAL XDDDD');
      Sleep(2000);
    end;
    checkHitting:=wound;
  end;

  procedure  turn_declaration(var j,i:byte);
  const acceptnum = [1..10];
        acceptchar = ['A'..'L', 'a'..'l'];
  var inpStr, S:string;
      temp:Char;
      exiter:Boolean;
  begin
    writeln('Please, input following tepmplate (A-1)');
    exiter:=False;
    repeat
      readln(inpStr);
      if ((Length(inpStr) > 0) and (inpSTr[1] in acceptchar)) then
      begin
          if Length(inpStr)>=1 then
            temp:=inpStr[1];
          if ord(temp)<91 then
            i:=ord(temp)-64
          else
            i:=Ord(temp)-96;
        if Length(inpStr)=3 then
        begin
          j:=StrToInt(inpStr[3]);
          if (i in acceptnum) and (inpStr[2]='-') and(j in acceptnum) then
            exiter:=True
          else Writeln('try again');
        end;
        if Length(inpStr)=4 then
        begin
          S:=Copy(inpStr,3,2);
          j:=StrToInt(S);
          if (i in acceptnum) and (inpStr[2]='-') and(j in acceptnum) then
            exiter:=True
          else Writeln('try again');
        end;
      end
      else writeln('try again');
      //if (Length(inpStr)<>3) and (Length(inpStr)<>4) and (exiter=False) then writeln('try again');
    until exiter;
  end;
end.
 