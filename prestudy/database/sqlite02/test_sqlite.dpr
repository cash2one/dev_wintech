program test_sqlite;

uses
  Forms,
  testForm_sqlite in 'testForm_sqlite.pas' {Form1},
  SQLite3Wrap in '..\..\..\comps\sqlite\sqliteApi\SQLite3Wrap.pas',
  SQLite3Utils in '..\..\..\comps\sqlite\sqliteApi\SQLite3Utils.pas',
  SQLite3 in '..\..\..\comps\sqlite\sqliteApi\SQLite3.pas',
  SQLite3WrapBlob in '..\..\..\comps\sqlite\sqliteApi\SQLite3WrapBlob.pas',
  SQLite3WrapApi in '..\..\..\comps\sqlite\sqliteApi\SQLite3WrapApi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
