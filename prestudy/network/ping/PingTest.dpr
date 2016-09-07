program PingTest;

uses
  Forms,
  PingForm in 'PingForm.pas' {Form1},
  WinSock2 in '..\..\..\common\WinSock2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
