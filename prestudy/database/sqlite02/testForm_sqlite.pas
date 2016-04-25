unit testForm_sqlite;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls;

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
  SQLite3,
  SQLite3WrapApi;
  
procedure TForm1.btn1Click(Sender: TObject);
var
  tmpDB: PSQL3Db;
  tmpState: PSQL3Statement;
  tmpValue1: integer;
  tmpValue2: integer;
  tmpRet: integer;
begin
  tmpDB := CheckOutSQL3Db;
  try
    if SQL3DbOpen(tmpDB, 'test20160425_1641.db', SQLITE_OPEN_CREATE or SQLITE_OPEN_READWRITE or SQLITE_OPEN_NOMUTEX) then
    begin
      if SQL3DbExecute(tmpDB, 'CREATE TABLE IF NOT EXISTS testtable (col1 INTEGER, col2 INTEGER);') then
      begin
        //if SQL3DbExecute(tmpDB, 'INSERT INTO testtable (col1, col2) VALUES (1243, 3218);') then
        begin
        end;
      end;
      tmpState := CheckOutSql3Statement(tmpDB, 'SELECT count(*) FROM testtable');
      if nil <> tmpState then
      begin
        try
          tmpRet := SQL3StatementStep(tmpState);
          while SQLITE_ROW = tmpRet do
          begin
            tmpValue1 := SQLStatement_IntValue(tmpState, 0);
            //tmpValue2 := SQLStatement_IntValue(tmpState, 1);
            if (0 = tmpValue1) or (0 = tmpValue2) then
            begin
            end;                                
            tmpRet := SQL3StatementStep(tmpState);
          end;
        finally
          CheckInSql3Statement(tmpState);
        end;
      end;
    end;
  finally
    CheckInSQL3Db(tmpDB);
  end;
end;

end.

