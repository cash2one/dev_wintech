unit PingForm;

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
  WinSock2;

type
  PIPOptionInformation =  ^TIPOptionInformation;
  TIPOptionInformation = packed record
    TTL           : Byte;
    TOS           : Byte;
    Flags         : Byte;
    OptionsSize   : Byte;
    OptionsData   : PAnsiChar;
  end;

  PIcmpEchoReply  = ^TIcmpEchoReply;
  TIcmpEchoReply  = packed record
    Address       : DWORD;
    Status        : DWORD;
    RTT           : DWORD;
    DataSize      : Word;
    Reserved      : Word;
    Data          : Pointer;
    Options       : TIPOptionInformation;
  end;

var
  WSAData: TWSAData;
      
function PingHost(HostIP: AnsiString): Boolean;
type
  TIcmpCreateFile = function:THandle;stdcall;
  TIcmpCloseHandle= function(IcmpHandle:THandle):Boolean;stdcall;
  TIcmpSendEcho=function(IcmpHandle:THandle;
                  DestinationAddress: DWORD;
                  RequestData:   Pointer;
                  RequestSize:   Word;
                  RequestOptions:   PIPOptionInformation;
                  ReplyBuffer:   Pointer;
                  ReplySize:   DWord;
                  Timeout:   DWord
                  ):DWord;stdcall;
var
  hICMP:THandle;
  hICMPdll:THandle;
  IcmpCreateFile:TIcmpCreateFile;
  IcmpCloseHandle:TIcmpCloseHandle;
  IcmpSendEcho:TIcmpSendEcho;
  pIPE:PIcmpEchoReply;//   ICMP   Echo   reply   buffer
  FIPAddress:DWORD;
  FSize:DWORD;
  FTimeOut:DWORD;
  BufferSize:DWORD;
  pReqData: PAnsiChar;
  pRevData: PAnsiChar;
  MyString: AnsiString;
begin   
  Result:=False;
  hICMPdll:=LoadLibrary('icmp.dll');
  if hICMPdll=0 then   exit;

  @ICMPCreateFile:=GetProcAddress(hICMPdll,'IcmpCreateFile');
  @IcmpCloseHandle:=GetProcAddress(hICMPdll,'IcmpCloseHandle');
  @IcmpSendEcho:=GetProcAddress(hICMPdll, 'IcmpSendEcho');
  hICMP   :=   IcmpCreateFile;
  if (INVALID_HANDLE_VALUE = hICMP) then
    exit;

  //WSAStartup();
  
  FIPAddress := inet_addr(PAnsiChar(HostIP));
  MyString := 'Hello,World';                                 //send   data   buffer
  pReqData := PAnsiChar(MyString);

  FSize:=40;                                                 //receive   data   buffer
  BufferSize:=SizeOf(TICMPEchoReply)+FSize;
  GetMem(pIPE,BufferSize);   
  FillChar(pIPE^,SizeOf(pIPE^), 0);
  GetMem(pRevData,FSize);
  pIPE^.Data:=pRevData;
  FTimeOut:=500;
  try
    Result:=IcmpSendEcho(hICMP, FIPAddress, pReqData, Length(MyString),nil,pIPE,BufferSize,FTimeOut) > 0;
  finally
    IcmpCloseHandle(hICMP);
    FreeLibrary(hICMPdll);
    FreeMem(pRevData);
    FreeMem(pIPE);
  end;
end;

function GetIPFromName(Name: string): string;
var
  WSAData: TWSAData;
  HostEnt: PHostEnt;
begin
  WSAStartup(2, WSAData);
  HostEnt := gethostbyname(PChar(Name));
  if nil <> HostEnt then
  begin
    if nil <> HostEnt.h_addr then
    begin
      Result := Format('%d.%d.%d.%d', [
        Byte(HostEnt.h_addr^.S_un_b.s_b1),
        Byte(HostEnt.h_addr^.S_un_b.s_b2),
        Byte(HostEnt.h_addr^.S_un_b.s_b3),
        Byte(HostEnt.h_addr^.S_un_b.s_b4)]);
    end;
  end;
  WSACleanup;
end;
 
procedure TForm1.btn1Click(Sender: TObject);
begin
  FillChar(WSAData, SizeOf(WSAData), 0);
  //WSAStartup($0202, WSAData);
  //WSAStartup($0101, WSAData);
  mmo1.Lines.Add(GetIPFromName('litwrd.51mypc.cn'));
  if PingHost('litwrd.51mypc.cn') then
  begin
    mmo1.Lines.Add('ping ok');
  end else
  begin
    mmo1.Lines.Add('ping fail');
  end;
end;

end.
