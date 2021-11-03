program Eruditor;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FMain},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
