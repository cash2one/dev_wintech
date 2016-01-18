unit BaseWinReg;

interface

uses
  Windows;
  
type
  PWinReg     = ^TWinReg;
  TWinReg     = record
    RootKey   : HKEY;
    Key       : HKEY;
  end;

implementation

procedure InitializeWinReg(AWinReg: PWinReg);
var
  tmpReadSize: Integer;
  tmpRet: integer;
begin
  RegOpenKeyA(AWinReg.RootKey,
    '', //lpSubKey: PAnsiChar;
    AWinReg.Key);  
  RegCreateKeyA(AWinReg.RootKey,
    '', //lpSubKey: PAnsiChar;
    AWinReg.Key);
  RegDeleteKeyA(AWinReg.Key,
    ''  //lpSubKey: PAnsiChar;
  );
  RegQueryValueA(AWinReg.Key,
    '', //lpSubKey: PAnsiChar;
    '', //lpValue: PAnsiChar;
    tmpReadSize //var lpcbValue: Longint
  );
  RegSetValueA(AWinReg.Key,
    '', //; lpSubKey: PAnsiChar;
    0, //dwType: DWORD;
    '', //lpData: PAnsiChar;
    0//cbData: DWORD
  );
   
  tmpRet := RegCloseKey(AWinReg.Key);
  if 0 = tmpRet then
  begin
    AWinReg.Key := 0;
  end;
end;

end.
