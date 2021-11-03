program Matrix;

uses
  Forms,
  UMain in 'UMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  form1.FormStyle:=fsstayontop;
  Application.Run;
end.
