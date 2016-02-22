program PjChinese2Pinyin;

uses
  Forms,
  FormChinese2PinYin in 'FormChinese2PinYin.pas' {Form1},
  Chinese2Pinyin in 'Chinese2Pinyin.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
