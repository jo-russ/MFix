program MFix;

uses
  Forms,
  sysutils,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  DecimalSeparator:='.';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
