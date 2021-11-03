unit ULongMath;

interface  
function readlong(var x:array of byte):integer;   
procedure writelong(var x:array of byte; l:integer);    
procedure sumlong(var x,y:array of byte; var l:integer); 
function max(x,y:integer):integer;
procedure longmult(var a,b,c:array of byte; var la,lb,lc:integer);     
procedure clearlong(var x:array of byte);

implementation   
function readlong(var x:array of byte):integer;
var i,j:integer; c:char; s:string;
begin
     read(c);
     result:=0;
     s:='';
     while (ord(c)<58) and (ord(c)>47) do
     begin
     inc(result);
     s:=s+c;
     read(c);
     end;
     for i:=result downto 1 do
     x[i]:=ord(s[result-i+1])-48;
     begin
     result:=result;
     end;
end;
procedure writelong(var x:array of byte; l:integer);
var i,j:integer;
begin
     for i:=l downto 1 do
     write(x[i]);
end;
procedure sumlong(var x,y:array of byte; var l:integer);
var i,j,p,s:integer;
begin
     p:=0;
     for i:=1 to l do
     begin
         s:=x[i]+y[i]+p;
         x[i]:=(s mod 10);
         p:=s div 10;
     end;
     if p<>0 then
     begin
         inc(l);
         x[l]:=p;
     end;
end;
function max(x,y:integer):integer;
begin
     if x>y then
     result:=x
     else
     result:=y;
end;

procedure longmult(var a,b,c:array of byte; var la,lb,lc:integer);
var i,j,cr,k:integer;
begin
     lc:=0;
     for i:=1 to la do
     begin
        for j:=1 to lb do
        begin
            cr:=a[i]*b[j];
            k:=i+j-1;
            while (cr>0) do
            begin
                cr:=cr+c[k];
                c[k]:=cr mod 10;
                cr:=cr div 10;
                if(k>lc) then
                  lc:=k;
                k:=k+1;
            end;
        end;
     end;
end;

procedure clearlong(var x:array of byte; var lx:integer);
var i:integer;
begin
     for i:=1 to lx do
        x[i]:=0;
     lx:=0;
end;

end.
