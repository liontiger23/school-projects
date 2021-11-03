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
           'a':s:=s+'à';
           'b':s:=s+'á';
           'v':s:=s+'â';
           'g':s:=s+'ã';
           'd':s:=s+'ä';
           'e':s:=s+'å';
           'j':case text[2] of
               'o':s:=s+'¸';
               'e':s:=s+'ý';
               'a':s:=s+'ÿ';
               'u':s:=s+'þ';
               else s:=s+'é';
               end;
           'z':case text[2] of
               'h':s:=s+'æ'
               else s:=s+'ç';
               end;
           'i':s:=s+'è';
           'k':s:=s+'ê';
           'l':s:=s+'ë';
           'm':s:=s+'ì';
           'n':s:=s+'í';
           'o':s:=s+'î';
           'p':s:=s+'ï';
           'r':s:=s+'ð';
           's':case text[2] of
               'h':if text[3]='h' then s:=s+'ù' else s:=s+'ø';
               else s:=s+'ñ';
               end;
           't':s:=s+'ò';
           'u':s:=s+'ó';
           'f':s:=s+'ô';
           'h':s:=s+'õ';
           'x':s:=s+'õ';
           'c':if text[2]='h' then s:=s+'÷' else s:=s+'ö';
           'w':s:=s+'ù';
           'y':case text[2] of
               'a':s:=s+'ÿ';
               'o':s:=s+'¸';
               else s:=s+'þ';
               end;
           #39:s:=s+'ü';
           else s:=s+text[1];
           end;
           case s[length(s)] of
           '¸':inc(i);
           'ý':inc(i);
           'ÿ':inc(i);
           'þ':if not(text[1]='y') then inc(i);
           'ø':inc(i);
           'ù':if not(text[1]='w') then inc(i,2);
           'æ':inc(i);
           '÷':inc(i);
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
           'à':s:=s+'a';
           'á':s:=s+'b';
           'â':s:=s+'v';
           'ã':s:=s+'g';
           'ä':s:=s+'d';
           'å':s:=s+'e';
           '¸':s:=s+'jo';
           'æ':s:=s+'zh';
           'ç':s:=s+'z';
           'è':s:=s+'i';
           'é':s:=s+'j';
           'ê':s:=s+'k';
           'ë':s:=s+'l';
           'ì':s:=s+'m';
           'í':s:=s+'n';
           'î':s:=s+'o';
           'ï':s:=s+'p';
           'ð':s:=s+'r';
           'ñ':s:=s+'s';
           'ò':s:=s+'t';
           'ó':s:=s+'u';
           'ô':s:=s+'f';
           'õ':s:=s+'h';
           'ö':s:=s+'c';
           '÷':s:=s+'ch';
           'ø':s:=s+'sh';
           'ù':s:=s+'shh';
           'ú':s:=s;
           'û':s:=s+'i';
           'ü':s:=s+#39;
           'ý':s:=s+'je';
           'þ':s:=s+'y';
           'ÿ':s:=s+'ja';
           else s:=s+text[1];
           end;
           delete(text,1,i);
     until text='';
     memo1.Text:=s;
end;

end.
