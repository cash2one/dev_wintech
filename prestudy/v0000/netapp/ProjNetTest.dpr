program ProjNetTest;

uses
  Forms,
  WinSock2 in '..\..\..\common\WinSock2.pas',
  win.iobuffer in '..\..\..\v0000\win_data\win.iobuffer.pas',
  xlClientSocket in '..\..\..\v0000\win_net\xlClientSocket.pas',
  xlTcpClient in '..\..\..\v0000\win_net\xlTcpClient.pas',
  xlNetwork in '..\..\..\v0000\win_net\xlNetwork.pas',
  UtilsHttp in '..\..\..\v0000\win_utils\UtilsHttp.pas',
  UtilsHttp_Socket in '..\..\..\v0000\win_utils\UtilsHttp_Socket.pas',
  FormNetTest in 'FormNetTest.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
