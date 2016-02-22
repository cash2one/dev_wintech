unit FormChinese2PinYin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    edtText: TEdit;
    btn1: TButton;
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
  Chinese2Pinyin;
  
procedure TForm1.btn1Click(Sender: TObject);
begin
  mmo1.Lines.Add(Chinese2PinYinHeader(edtText.Text));
//
end;

end.
