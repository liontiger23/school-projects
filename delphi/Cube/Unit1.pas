unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure draw_cube;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure incx;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
const
size=200;

var y1,y2,
    x1,
    rv,rh1,rh2,c,vc,
    size_check,
    s_check,moving:integer;
    CAN_V:BOOLEAN;

procedure tform1.draw_cube;
begin
     with image1.Canvas do
     begin
     fillrect(cliprect);
     moveto(x1,y1);
     lineto(x1+rh2,y1+rv);
     lineto(x1+rh2,y2-rv);
     lineto(x1,y2);
     lineto(x1,y1);
     lineto(x1-rh1,y1+rv);
     lineto(x1-rh1,y2-rv);
     lineto(x1,y2);
     end;
     label1.Caption:=inttostr(size_check); 
     label2.Caption:=inttostr(vc);
end;
procedure TForm1.FormCreate(Sender: TObject);
var i,j:integer;
begin
     x1:=(image1.Width div 2)-(size div 2);
     y1:=(image1.Height div 2)-(size div 2);
     rh1:=0;
     rh2:=size;
     rv:=0;
     y2:=y1+size;
     c:=0;
     size_check:=0;
     vc:=1;
     moving:=1;
     s_check:=moving;
     can_v:=true;
     draw_cube;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     incx;
     draw_cube;
end;

procedure TForm1.incx;
var i:integer;
begin
     if (((s_check<0) and (size_check<size div 2)) or
     ((s_check>0) and (size_check>size div 2))) and (can_v) then
     begin
     vc:=0-vc;
     can_v:=false;
     c:=0;
     end;
     if {(size_check<0) or }(size_check>=size) then
     begin
     vc:=0-vc;
     can_v:=true;
     c:=0;
     x1:=x1-rh1;
     rh1:=0;
     rh2:=size;
     size_check:=0;
     //s_check:=0-s_check;
     //moving:=0-moving;
     end;
     inc(size_check,s_check);
     inc(x1,moving);
     if c=0 then
     begin
     inc(rv,vc);
     c:=1;
     end else
     inc(c,-1);
     inc(rh1,moving);
     inc(rh2,-moving);

end;

end.
