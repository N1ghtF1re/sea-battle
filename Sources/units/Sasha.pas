unit Sasha;

interface
uses
    Kiryl,
    typeandconst,SysUtils;
    type players = 1..2;
     letters = 'A'..'Z';
    var i,j:integer;
    var Field1,Field2:TPlayingField;
    procedure writeField(var Matrix: TPlayingField);
    procedure editField(var EnemyMatrix,fullmatrix: TPlayingField; x,y: Byte; isHitting:Boolean);
    procedure rewrite(var firstEnemy, secondEnemy:TPlayingField);
    procedure clearconsole;
    procedure game(firstPlayerMatrix, secondPlayerMatrix: TPlayingField);
implementation

  procedure writeField(var Matrix: TPlayingField);
  var i,j:byte;
  ch: char;
  ltr:letters;
  begin
    ltr:='A';
    write('  ');
    for i:=1 to 10 do
    begin
      write(ltr:2);
      inc(ltr);
    end;
    writeln;
    for i:=1 to 10 do
    begin
      Write(i:2);
      for j:=1 to 10 do
      begin
        write(Matrix[i,j]:2);
      end;
      writeln;

    end;
  end;

  procedure editField(var EnemyMatrix,fullmatrix: TPlayingField; x,y: Byte; isHitting:Boolean);
  var flag, iskilled:Boolean;
  i,j,lasttop, lastdown,lastleft,lastright:byte;
  begin
    if (not isHitting) then
      EnemyMatrix[x,y]:='M'
    else
    begin
      EnemyMatrix[x,y]:='R';
      // Killed check
      if ((fullmatrix[x+1, y] = 'K') or (fullmatrix[x-1, y] = 'K')) then
      begin
        flag:=True;
        isKilled:=true;
        i:=1;
        while(flag) do
        begin
          if ((fullmatrix[x-i, y] = 'K') and (EnemyMatrix[x-i, y] <> 'R')) then
          begin
            isKilled:=false;
            flag:=false;
          end
          else
          begin
            if (fullmatrix[x-i, y] <> 'K') then
            begin
              flag:=false;
              lastdown:=x-i+1;
            end;
          end;
          Inc(i);
        end;
        flag:=True;
        i:=1;
        while(flag and isKilled) do
        begin
          if ((fullmatrix[x+i, y] = 'K') and (EnemyMatrix[x+i, y] <> 'R')) then
          begin
            isKilled:=false;
            flag:=false;
          end
          else
          begin
            if (fullmatrix[x+i, y] <> 'K') then
            begin
              flag:=false;
              lasttop:=x+i-1;
            end;
          end;
          Inc(i);
        end;
        if(iskilled) then
        begin
          for j:=lastdown to lasttop do
          begin
            EnemyMatrix[j, y] := 'K';
          end;
        end;
      end
      else
      begin
        if ((fullmatrix[x, y+1] = 'K') or (fullmatrix[x, y-1] = 'K')) then
        begin
          flag:=True;
          isKilled:=true;
          i:=1;
          while(flag) do
          begin
            if ((fullmatrix[x, y-i] = 'K') and (EnemyMatrix[x, y-i] <> 'R')) then
            begin
              isKilled:=false;
              flag:=false;
            end
            else
            begin
              if (fullmatrix[x, y-i] <> 'K') then
              begin
                flag:=false;
                lastleft:=y-i+1;
              end;
            end;
            Inc(i);
          end;
          flag:=True;
          i:=1;
          while(flag and isKilled) do
          begin
            if ((fullmatrix[x, y+i] = 'K') and (EnemyMatrix[x, y+i] <> 'R')) then
            begin
              isKilled:=false;
              flag:=false;
            end
            else
            begin
              if (fullmatrix[x, y+i] <> 'K') then
              begin
                flag:=false;
                lastright:=y+i-1;
              end;
            end;
            Inc(i);
          end;
          if(iskilled) then
          begin
            for j:=lastleft to lastright do
            begin
              EnemyMatrix[x, j] := 'K';
            end;
          end;
        end
        else
        begin
          EnemyMatrix[x, y] := 'K';
        end;
      end;
    end;
  end;

  procedure rewrite(var firstEnemy, secondEnemy:TPlayingField);
  var i,j:integer;
  begin
    for i:=1 to 10 do
    begin
      for j:=1 to 10 do
      begin
        firstEnemy[i,j]:= '*';
        secondEnemy[i,j]:= '*';
      end;
    end;
  end;

  procedure clearconsole;
  var i:byte;
  begin
    for i:=1 to 100 do
      writeln;
  end;

  procedure game({var CurrPlayer: Byte; }firstPlayerMatrix, secondPlayerMatrix: TPlayingField);
  var P1N, P2N: byte;
  firstEnemy, secondEnemy:TPlayingField;
  str:string;
  x,y:Byte;
  i,j:Byte;
  hitting:boolean;
  isHitting: boolean;
  currplayer:byte;
  begin
    rewrite(firstEnemy, secondEnemy);
    P1N:= 20;
    P2N:= 20;
    currplayer := 1;
    repeat
      clearconsole;
      writeln('Player', currplayer, ' turn:');
      case currplayer of
        1:
        begin
          writeField(firstEnemy);
          repeat
            turn_declaration(x,y);
            if firstenemy[x,y] <> '*' then
              writeln('You already hit this place');
          until firstenemy[x,y] ='*';
          isHitting:=checkHitting(secondPlayerMatrix,x,y);
          if(isHitting) then
            DEC(P2N);
          editField(firstEnemy,secondPlayerMatrix,x,y,isHitting);
        end;
        2:
        begin
          writeField(secondEnemy);
          repeat
            turn_declaration(x,y);
            if secondenemy[x,y] <> '*' then
              writeln('You already hit this place');
          until secondenemy[x,y] ='*';
          isHitting:=checkHitting(firstPlayerMatrix,x,y);
          if(isHitting) then
            DEC(P1N);
          editField(secondEnemy,firstPlayerMatrix,x,y,isHitting);
        end;
      end;

      if(not isHitting) then
        case currplayer of
          1: currplayer:=2;
          2: currplayer:=1;
        end;
    until ( (P1N <= 0) or (P2N <= 0) );
    clearconsole;
    if (P1N = 0) then
    begin
      writeln('Player 2 win!', #10#13);
      writeField(secondEnemy);
    end;
    if (P2N = 0) then
    begin
      writeln('Player 1 win!', #10#13);
      writeField(firstEnemy);
    end;
    Writeln(#10#13, 'Game over');
    readln;
  end;
end.
 