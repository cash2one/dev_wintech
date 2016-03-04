unit FormNetTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    mmo1: TMemo;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  win.iobuffer,
  UtilsHttp;
  
procedure TForm1.btn1Click(Sender: TObject);
var
  tmpIOBuffer: PIOBuffer;
  tmpUrl: AnsiString;
  tmpPost: AnsiString;
  tmpRetData: AnsiString;
  tmpHttpSession: THttpClientSession;
  tmpHttpHeadParseSession: THttpHeadParseSession;
begin
  tmpUrl := 'http://www.hepaidai.com/login';
  tmpPost := '';
  FillChar(tmpHttpSession, SizeOf(tmpHttpSession), 0);
  tmpIOBuffer := PostHttpUrlData(tmpUrl, tmpPost, @tmpHttpSession);
  if nil <> tmpIOBuffer then
  begin
    FillChar(tmpHttpHeadParseSession, SizeOf(tmpHttpHeadParseSession), 0);
    HttpBufferHeader_Parser(tmpIOBuffer, @tmpHttpHeadParseSession);
    if 200 = tmpHttpHeadParseSession.RetCode then
    begin
      tmpRetData := PAnsiChar(@tmpIOBuffer.Data[tmpHttpHeadParseSession.HeadEndPos + 1]);
      if '' <> tmpRetData then
      begin
      
      end;
    end;
  end;
//
end;

end.
