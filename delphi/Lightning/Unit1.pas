unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    procedure flash(x,y:integer);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.flash(x,y:integer);
begin
     form1.Canvas.FillRect(ClientRect);;
     randomize;
     form1.Canvas.Pixels[x,y]:=clwhite;
     repeat
     inc(y);
     case random(3) of
     0:
     begin
     x:=x-1;
     form1.Canvas.Pixels[x,y]:=clwhite;
     end;
     1:                                
     begin
     x:=x+1;
     form1.Canvas.Pixels[x,y]:=clwhite;
     end;
     2:
     begin
     form1.Canvas.Pixels[x,y]:=clwhite;
     end;
     end;
     until (y=form1.Height);
     timer2.Enabled:=true;
     repeat
     application.ProcessMessages;
     until timer2.Enabled=false;  
     form1.Canvas.FillRect(ClientRect);;
     //timer1.Interval:=random(5000)+1000;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
     timer2.Enabled:=false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     timer1.interval:=0;
     flash(random(form1.Width),0);
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     flash(x,y);
end;

end.
