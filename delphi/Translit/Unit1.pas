unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var text,s:string; i:integer;
begin
     text:=memo1.Text;
     s:='';
     repeat
           i:=1;
           case text[1] of
           'a':s:=s+'�';
           'b':s:=s+'�';
           'v':s:=s+'�';
           'g':s:=s+'�';
           'd':s:=s+'�';
           'e':s:=s+'�';
           'j':case text[2] of
               'o':s:=s+'�';
               'e':s:=s+'�';
               'a':s:=s+'�';
               'u':s:=s+'�';
               else s:=s+'�';
               end;
           'z':case text[2] of
               'h':s:=s+'�'
               else s:=s+'�';
               end;
           'i':s:=s+'�';
           'k':s:=s+'�';
           'l':s:=s+'�';
           'm':s:=s+'�';
           'n':s:=s+'�';
           'o':s:=s+'�';
           'p':s:=s+'�';
           'r':s:=s+'�';
           's':case text[2] of
               'h':if text[3]='h' then s:=s+'�' else s:=s+'�';
               else s:=s+'�';
               end;
           't':s:=s+'�';
           'u':s:=s+'�';
           'f':s:=s+'�';
           'h':s:=s+'�';
           'x':s:=s+'�';
           'c':if text[2]='h' then s:=s+'�' else s:=s+'�';
           'w':s:=s+'�';
           'y':case text[2] of
               'a':s:=s+'�';
               'o':s:=s+'�';
               else s:=s+'�';
               end;
           #39:s:=s+'�';
           else s:=s+text[1];
           end;
           case s[length(s)] of
           '�':inc(i);
           '�':inc(i);
           '�':inc(i);
           '�':if not(text[1]='y') then inc(i);
           '�':inc(i);
           '�':if not(text[1]='w') then inc(i,2);
           '�':inc(i);
           '�':inc(i);
           end;
           delete(text,1,i);
     until text='';
     memo2.Text:=s;
end;

procedure TForm1.Button2Click(Sender: TObject);
var text,s:string; i:integer;
begin
     text:=memo2.Text;
     s:='';
     repeat
           i:=1;
           case text[1] of
           '�':s:=s+'a';
           '�':s:=s+'b';
           '�':s:=s+'v';
           '�':s:=s+'g';
           '�':s:=s+'d';
           '�':s:=s+'e';
           '�':s:=s+'jo';
           '�':s:=s+'zh';
           '�':s:=s+'z';
           '�':s:=s+'i';
           '�':s:=s+'j';
           '�':s:=s+'k';
           '�':s:=s+'l';
           '�':s:=s+'m';
           '�':s:=s+'n';
           '�':s:=s+'o';
           '�':s:=s+'p';
           '�':s:=s+'r';
           '�':s:=s+'s';
           '�':s:=s+'t';
           '�':s:=s+'u';
           '�':s:=s+'f';
           '�':s:=s+'h';
           '�':s:=s+'c';
           '�':s:=s+'ch';
           '�':s:=s+'sh';
           '�':s:=s+'shh';
           '�':s:=s;
           '�':s:=s+'i';
           '�':s:=s+#39;
           '�':s:=s+'je';
           '�':s:=s+'y';
           '�':s:=s+'ja';
           else s:=s+text[1];
           end;
           delete(text,1,i);
     until text='';
     memo1.Text:=s;
end;

end.
