unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    StringGrid2: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure DeactivateScrSaver(var Msg : TMsg; var Handled : boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  col,row:integer;
  capacity:boolean;
  crs : TPoint; {первоначально расположение курсора мышки}
implementation

{$R *.dfm}
{$D "Programname Screensaver"}

procedure TForm1.Timer1Timer(Sender: TObject);
var i,j,x,n:integer;
begin
     //stringgrid1.DefaultColWidth:=stringgrid1.Font.Size*2;
     //stringgrid1.DefaultRowHeight:=stringgrid1.Font.Height*2;
     randomize;
     n:=0;
     for i:=0 to stringgrid1.ColCount-1 do
     if random(5)>3 then
     begin
     x:=random(90)+33;
     if (stringgrid2.Cells[i,0]='') then
     stringgrid2.cells[i,0]:='0';
     if (stringgrid2.Cells[i,0]='0') then
     if random(5)=0 then stringgrid2.Cells[i,0]:=inttostr(random(6)+5);
     n:=strtoint(stringgrid2.Cells[i,0]);
     for j:=stringgrid1.RowCount-2 downto 0 do
     if (col<>i) or ((col=i) and (row<>j)) then
     stringgrid1.Cells[i,j+1]:=stringgrid1.Cells[i,j];
     if n>0 then
     begin
     stringgrid1.Cells[i,0]:='';
     stringgrid2.Cells[i,0]:=inttostr(n-1);
     end else
     stringgrid1.Cells[i,0]:=char(x);
     end;
     //if (capacity) and (form1.AlphaBlendValue>20) then form1.AlphaBlendValue:=form1.AlphaBlendValue-1 else
     //if form1.AlphaBlendValue<255 then
     //form1.AlphaBlendValue:=form1.AlphaBlendValue+1;
     {for j:=stringgrid1.RowCount-2 downto 0 do
     for i:=0 to stringgrid1.ColCount-1 do
     stringgrid1.Cells[i,j+1]:=stringgrid1.Cells[i,j];}
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
     capacity:=true;
     col:=-1;
     row:=-1;
     stringgrid1.Canvas.CopyRect(rect(100,200,300,400),stringgrid1.Canvas,rect(0,0,100,200));
end;

procedure TForm1.FormResize(Sender: TObject);
var i:integer;
begin
     //capacity:=false;
     stringgrid1.ColCount:=form1.Width div stringgrid1.DefaultColWidth-1;
     stringgrid1.RowCount:=(form1.Height div stringgrid1.DefaultRowHeight)-2;
     stringgrid2.ColCount:=stringgrid1.ColCount;
     for i:=0 to stringgrid2.ColCount-1 do
     if stringgrid2.Cells[i,0]<>'' then stringgrid2.Cells[i,0]:='0';
     //capacity:=true;
end;

procedure TForm1.StringGrid1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var i:integer;
begin
     {col:=x div stringgrid1.DefaultColWidth;
     row:=y div stringgrid1.DefaultRowHeight;
     //if not(capacity) then
     if (col>-1) and (row>-1) then
     for i:=row+1 to stringgrid1.RowCount-1 do
     stringgrid1.cells[col,i]:='';   }
end;

procedure TForm1.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     //if button=mbleft then
     //capacity:=false;
end;

procedure TForm1.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     //capacity:=true;
end;

procedure TForm1.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin 
     //if key=32 then
     //capacity:=false;
end;

procedure TForm1.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin 
     //capacity:=true;
end;

procedure TForm1.DeactivateScrSaver(var Msg: TMsg; var Handled: boolean);
{определение движения мышки или нажатия на клавиатуре}
var
  done: boolean;
begin
  if Msg.message = WM_MOUSEMOVE then {сдвинулась мышка}
    done := (Abs(LOWORD(Msg.lParam) - crs.x) > 5) or
    (Abs(HIWORD(Msg.lParam) - crs.y) > 5)
  else {key / mouse нажаты?}
    done := (Msg.message = WM_KEYDOWN) or (Msg.message = WM_KEYUP) or
    (Msg.message = WM_SYSKEYDOWN) or (Msg.message = WM_SYSKEYUP) or
    (Msg.message = WM_ACTIVATE) or (Msg.message = WM_NCACTIVATE) or
    (Msg.message = WM_ACTIVATEAPP) or (Msg.message = WM_LBUTTONDOWN) or
    (Msg.message = WM_RBUTTONDOWN) or (Msg.message = WM_MBUTTONDOWN);
  if done then
    Close;
end; {procedure TScrForm.DeactivateScrSaver}


procedure TForm1.FormHide(Sender: TObject);
{возвращаем управление пользователю}
begin
  Application.OnMessage := nil; {запрещаем сообщения}
  {останавливаем скринсейвер...}
  //
  timer1.Enabled:=false;
  ShowCursor(true); {возвращаем курсор назад}
end; {procedure TScrForm.FormHide}


procedure TForm1.FormShow(Sender: TObject);
{starts the screensaver}
begin
  WindowState := wsMaximized; {окошко будет на полный экран}
  GetCursorPos(crs); {получаем позицию курсора}
  Application.OnMessage := DeactivateScrSaver; {проверяем мышку/клавиатуру}
  ShowCursor(false); {скрываем курсор}
  {начинаем отображение скринсейвера...}
  //
  timer1.Enabled:=true;
end; {процедура TScrForm.FormShow}


end.
