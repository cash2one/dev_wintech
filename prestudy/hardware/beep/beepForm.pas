unit beepForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
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
              
procedure PlaySong1;
const
  t = 800;
begin
  Windows.Beep(330, t);
  Windows.Beep(392, t);
  Windows.Beep(262, t*2);

  Windows.Beep(294, t);
  Windows.Beep(330, t);
  Windows.Beep(196, t*2);

  Windows.Beep(262, t);
  Windows.Beep(294, t);
  Windows.Beep(330, t);
  Windows.Beep(392, t);
  Windows.Beep(294, t*4);
end;

procedure PlaySong2;
{* 
  送别 
  歌手:青燕子演唱组 
  专辑:森林和原野 
  作词:李叔同(弘一大师) 
  *}  
const  
  ONE_BEEP = 600;  
  HALF_BEEP = 300;  
  { 
  NOTE_1 = 440; 
  NOTE_2 = 495; 
  NOTE_3 = 550; 
  NOTE_4 = 587; 
  NOTE_5 = 660; 
  NOTE_6 = 733; 
  NOTE_7 = 825; 
  }  
  NOTE_1 = 440*1;  
  NOTE_2 = 495*1;  
  NOTE_3 = 550*1;  
  NOTE_4 = 587*1;  
  NOTE_5 = 660*1;  
  NOTE_6 = 733*1;  
  NOTE_7 = 825*1;  
begin  
  try  
    //长亭外  
    Windows.Beep(NOTE_5, ONE_BEEP);  
    Windows.Beep(NOTE_3, HALF_BEEP);  
    Windows.Beep(NOTE_5, HALF_BEEP);  
    Windows.Beep(NOTE_1 * 2, ONE_BEEP * 2);  
  
    //古道边  
    Windows.Beep(NOTE_6, ONE_BEEP);
    Windows.Beep(NOTE_1 * 2, ONE_BEEP);
    Windows.Beep(NOTE_5, ONE_BEEP * 2);

    //芳草碧连天
    Windows.Beep(NOTE_5, ONE_BEEP);
    Windows.Beep(NOTE_1, HALF_BEEP);
    Windows.Beep(NOTE_2, HALF_BEEP);  
    Windows.Beep(NOTE_3, ONE_BEEP);  
    Windows.Beep(NOTE_2, HALF_BEEP);  
    Windows.Beep(NOTE_1, HALF_BEEP);  
    Windows.Beep(NOTE_2, ONE_BEEP * 4);  
  
    //晚风扶柳笛声残  
    Windows.Beep(NOTE_5, ONE_BEEP);  
    Windows.Beep(NOTE_3, HALF_BEEP);  
    Windows.Beep(NOTE_5, HALF_BEEP);  
    Windows.Beep(NOTE_1 * 2, HALF_BEEP * 3);  
    Windows.Beep(NOTE_7, HALF_BEEP);  
    Windows.Beep(NOTE_6, ONE_BEEP);  
    Windows.Beep(NOTE_1 * 2, ONE_BEEP);
    Windows.Beep(NOTE_5, ONE_BEEP * 2);  
  
    //夕阳山外山  
    Windows.Beep(NOTE_5, ONE_BEEP);  
    Windows.Beep(NOTE_2, HALF_BEEP);  
    Windows.Beep(NOTE_3, HALF_BEEP);  
    Windows.Beep(NOTE_4, HALF_BEEP * 3);  
    Windows.Beep(round(NOTE_7 / 2), HALF_BEEP);  
    Windows.Beep(NOTE_1, ONE_BEEP * 4);  
  
    //天之涯  
    Windows.Beep(NOTE_6, ONE_BEEP);  
    Windows.Beep(NOTE_1 * 2, ONE_BEEP);  
    Windows.Beep(NOTE_1 * 2, ONE_BEEP * 2);  
  
    //地之角  
    Windows.Beep(NOTE_7, ONE_BEEP);  
    Windows.Beep(NOTE_6, HALF_BEEP);  
    Windows.Beep(NOTE_7, HALF_BEEP);  
    Windows.Beep(NOTE_1 * 2, ONE_BEEP * 2);  
  
    //知交半零落  
    Windows.Beep(NOTE_6, HALF_BEEP);  
    Windows.Beep(NOTE_7, HALF_BEEP);  
    Windows.Beep(NOTE_1 * 2, HALF_BEEP);  
    Windows.Beep(NOTE_6, HALF_BEEP);  
    Windows.Beep(NOTE_6, HALF_BEEP);  
    Windows.Beep(NOTE_5, HALF_BEEP);  
    Windows.Beep(NOTE_3, HALF_BEEP);  
    Windows.Beep(NOTE_1, HALF_BEEP);  
    Windows.Beep(NOTE_2, ONE_BEEP * 4);  
  
    //一壶浊酒尽余欢  
    Windows.Beep(NOTE_5, ONE_BEEP);  
    Windows.Beep(NOTE_3, HALF_BEEP);  
    Windows.Beep(NOTE_5, HALF_BEEP);  
    Windows.Beep(NOTE_1 * 2, HALF_BEEP * 3);  
    Windows.Beep(NOTE_7, HALF_BEEP);  
    Windows.Beep(NOTE_6, ONE_BEEP);  
    Windows.Beep(NOTE_1 * 2, ONE_BEEP);  
    Windows.Beep(NOTE_5, ONE_BEEP * 2);
  
    //今宵别梦寒  
    Windows.Beep(NOTE_5, ONE_BEEP);  
    Windows.Beep(NOTE_2, HALF_BEEP);  
    Windows.Beep(NOTE_3, HALF_BEEP);  
    Windows.Beep(NOTE_4, HALF_BEEP * 3);  
    Windows.Beep(round(NOTE_7 / 2), HALF_BEEP);  
    Windows.Beep(NOTE_1, ONE_BEEP * 3);  
  except  
    on E: Exception do  
      Writeln(E.Classname, ': ', E.Message);  
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  //Windows.Beep();
  //Windows.Beep(1200, 10);
  //Windows.MessageBeep(MB_OK);
  //Windows.MessageBeep(MB_ICONEXCLAMATION); 
  //Windows.Beep(440, 1000);
  //PlaySong2;
  SysUtils.beep;
  //Windows.Beep(音高, 长度);
end;

end.
