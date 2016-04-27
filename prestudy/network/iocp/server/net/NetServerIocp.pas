unit NetServerIocp;

interface

uses
  Windows, WinSock2, win.iocp,
  Win.Thread, DataChain, NetSrvClientIocp,
  NetBaseObj;

type                             
  PNetServerIocp    = ^TNetServerIocp;
  
  PNetIOCPServerWorkThread = ^TNetIOCPServerWorkThread;
  TNetIOCPServerAcceptThread = packed record
    SysThread       : TSysWinThread;
    Server          : PNetServerIocp;
  end;

  TNetIOCPServerWorkThread = packed record
    SysThread       : TSysWinThread;
    Server          : PNetServerIocp; 
  end;
                       
  TNetServerIocp    = packed record
    BaseServer      : TNetServer;    
    Iocp            : TWinIocp;
    AcceptThread    : TNetIOCPServerAcceptThread;
    IocpWorkThread  : array[0..255] of TNetIOCPServerWorkThread;
  end;
              
  procedure OpenIOCPNetServer(AServer: PNetServerIocp);
                          
implementation

uses         
  //SDLogUtils,
  Sysutils,
  BaseDataIO,
  win.cpu,
  DealServerHttpProtocol;

function ThreadProc_IocpDataBufferWorkThread(AParam: PNetIOCPServerWorkThread): HResult; stdcall;
begin
  Result := 0;
  ExitThread(Result);
end;

procedure DealAgentServerDataHandle(const AIocpBuffer: PNetIocpBuffer);  
type
  PCommandProtocol = ^TCommandProtocol;
  TCommandProtocol = packed record
    Magic: Word;
    Version: Word;
    CommandID: Word;
    CommandParam: array[0..255] of AnsiChar;
  end;

var
  tmpCommand: PCommandProtocol;
  tmpHeadChar: AnsiChar;  
begin
  // GET  POST  HEAD  PUT  DELETE  TRACE  CONNECT  OPTIONS  PATCH
  if nil = AIocpBuffer then
    exit;
  if 0 = AIocpBuffer.DataBuffer.BufferHead.DataLength then
    exit;
  tmpCommand := @AIocpBuffer.DataBuffer.Data[0];
  if 2121 = tmpCommand.Magic then
  begin

  end else
  begin
    tmpHeadChar := AIocpBuffer.DataBuffer.Data[0];
    if ('G' = tmpHeadChar) then
    begin
      //SDLog('DealServerAppStart.pas', 'DealAgentServerDataIn begin');
      try
        // 这里为什么多线程出错了 ????
        DealServerHttpProtocol.HttpServerDataInHandle(@AIocpBuffer.ClientConnect.BaseConnect, @AIocpBuffer.DataBuffer);
      except
      end;
      //SDLog('DealServerAppStart.pas', 'DealAgentServerDataIn end');
      exit;
    end;          
    if ('P' = tmpHeadChar) then
    begin
      //DealServerHttpProtocol.HttpServerDataHandle(ADataIO, AData);
      exit;
    end;
    if ('D' = tmpHeadChar) then
    begin
      //DealServerHttpProtocol.HttpServerDataHandle(ADataIO, AData);
      exit;      
    end;
  end;
end;

function ThreadProc_IOCPServerWorkThread(AParam: PNetIOCPServerWorkThread): HResult; stdcall;
var
  tmpCompleteKey: DWORD;
  tmpServer: PNetServerIocp;
  tmpBytes: Cardinal;
  tmpConnect: PNetClientConnectIOCP; 
  tmpIocpBuffer: PNetIocpBuffer;
begin
  Result := 0;
  if nil <> AParam then
  begin
    tmpServer := AParam.Server;
    if nil <> tmpServer then
    begin
      while (1 = tmpServer.BaseServer.IsActiveStatus) and
            (1 = AParam.SysThread.Core.IsActiveStatus) do
      begin
        Sleep(1);
        tmpIocpBuffer := nil; 
        //此处有可能多个线程处理同一个SocketHandle对象，因此需要加锁
        if not GetQueuedCompletionStatus(tmpServer.Iocp.Handle, tmpBytes, tmpCompleteKey, POverlapped(tmpIocpBuffer), INFINITE) then
        begin  //客户端异常断开
          if nil <> tmpIocpBuffer then
          begin
      
          end;
        end else
        begin
          if nil <> tmpIocpBuffer then
          begin
            tmpConnect := tmpIocpBuffer.ClientConnect;
            if ioHandle = tmpIocpBuffer.IocpOperate then
            begin
              DealAgentServerDataHandle(tmpIocpBuffer);
              CheckInIocpBuffer(tmpIocpBuffer);
              Continue;
            end;
            if ioSockRead = tmpIocpBuffer.IocpOperate then
            begin      
              if 0 < tmpBytes then
              begin
                // 处理进来的数据
                tmpIocpBuffer.IocpOperate := ioHandle;
                tmpIocpBuffer.DataBuffer.BufferHead.DataLength := tmpBytes;
                Windows.PostQueuedCompletionStatus(tmpServer.Iocp.Handle, 0, 0, @tmpIocpBuffer.Overlapped);
                ReadIocpDataIn(tmpConnect, CheckOutIocpBuffer);
              end else
              begin
                WinSock2.closesocket(tmpConnect.BaseConnect.ClientSocketHandle);
                tmpConnect.BaseConnect.ClientSocketHandle := 0;
                CheckInClientConnectionIocp(tmpConnect);
                CheckInIocpBuffer(tmpIocpBuffer);
              end;
              Continue;
            end;
            if ioSockWrite = tmpIocpBuffer.IocpOperate then
            begin
              HttpServerDataOutEndHandle(@tmpIocpBuffer.ClientConnect.BaseConnect, @tmpIocpBuffer.DataBuffer);
              CheckInIocpBuffer(tmpIocpBuffer);
              Continue;
            end;
          end else
          begin            
            // tmpBuffer.ClientConnect.ConnectSocketHandle 失效了 可以不用管了 ??    
            Continue;
          end;
        end;
      end;
    end;
  end;
  ExitThread(Result);
end;

function ThreadProc_IOCPServerAcceptThread(AParam: PNetIOCPServerWorkThread): HResult; stdcall;
var
  tmpClientConnectionSocket: Winsock2.TSocket;
  tmpClient: PNetClientConnectIOCP;
  tmpAddr: TSockAddr;
  tmpAddrlen: Integer;
begin
  Result := 0;   
  while 1 = AParam.SysThread.Core.IsActiveStatus do
  begin
    Sleep(1);
    FillChar(tmpAddr, SizeOf(tmpAddr), 0);
    tmpAddrlen := SizeOf(tmpAddr);
    tmpClientConnectionSocket := WinSock2.WSAAccept(AParam.Server.BaseServer.ListenSocketHandle, @tmpAddr, @tmpAddrlen, nil, 0);
    if INVALID_SOCKET  <> tmpClientConnectionSocket then
    begin
      if 1 <> AParam.SysThread.Core.IsActiveStatus then
      begin
        WinSock2.CloseSocket(tmpClientConnectionSocket);
        Exit;
      end;
      if 0 = Windows.CreateIoCompletionPort(tmpClientConnectionSocket,
          AParam.Server.Iocp.Handle,
          1, 0) then
      begin
        // error
      end else
      begin
        tmpClient := CheckOutClientConnectionIocp(@AParam.Server.BaseServer);
        if nil <> tmpClient then
        begin
          tmpClient.BaseConnect.ClientSocketHandle := tmpClientConnectionSocket;
          ReadIocpDataIn(tmpClient, CheckOutIocpBuffer);
        end;
      end;
    end;
  end;
  ExitThread(Result);
end;
                           
procedure OpenIOCPNetServer(AServer: PNetServerIocp);
var   
  tmpAddr: Winsock2.TSockAddr;
  tmpWorkThreadCount: integer;
  i: integer;
begin
  InitWinIocp(@AServer.Iocp);
  if (0 = AServer.Iocp.Handle) or
     (INVALID_HANDLE_VALUE = AServer.Iocp.Handle) then
  begin
    exit;
  end;
  
  if 0 = AServer.BaseServer.ListenSocketHandle then
  begin
    AServer.BaseServer.ListenSocketHandle := WSASocket(PF_INET, SOCK_STREAM, 0, nil, 0, WSA_FLAG_OVERLAPPED);
  end;          
  if INVALID_SOCKET <> AServer.BaseServer.ListenSocketHandle then
  begin
    if 0 = AServer.BaseServer.ListenPort then
      AServer.BaseServer.ListenPort := 80;
    AServer.BaseServer.IsActiveStatus := 1;
    FillChar(tmpAddr, SizeOf(tmpAddr), 0);
    tmpAddr.sin_family := AF_INET;
    tmpAddr.sin_port := htons(AServer.BaseServer.ListenPort);
    tmpAddr.sin_addr.S_addr := htonl(INADDR_ANY); //在任何地址上监听，如果有多块网卡，会每块都监听

    if 0 <> bind(AServer.BaseServer.ListenSocketHandle, @tmpAddr, SizeOf(tmpAddr)) then
    begin
      //raise ESocketError.Create(GetLastWsaErrorStr);
      WinSock2.closesocket(AServer.BaseServer.ListenSocketHandle);
      AServer.BaseServer.ListenSocketHandle := 0;
      AServer.BaseServer.IsActiveStatus := 0;
    end;
    if 1 = AServer.BaseServer.IsActiveStatus then
    begin
      if 0 <> listen(AServer.BaseServer.ListenSocketHandle, MaxInt) then
      begin
       //raise ESocketError.Create(GetLastWsaErrorStr);
        WinSock2.closesocket(AServer.BaseServer.ListenSocketHandle);
        AServer.BaseServer.ListenSocketHandle := 0;
        AServer.BaseServer.IsActiveStatus := 0;
      end;
    end;
    //tmpWorkThreadCount := GetCPUCount * 2 + 4;     
    if 1 = AServer.BaseServer.IsActiveStatus then
    begin
      tmpWorkThreadCount := GetProcessorCount * 2;
      for i := 0 to tmpWorkThreadCount - 1 do
      begin
        AServer.IocpWorkThread[i].SysThread.Core.IsActiveStatus := 1;
        AServer.IocpWorkThread[i].Server := AServer;
        AServer.IocpWorkThread[i].SysThread.Core.ThreadHandle :=
          Windows.CreateThread(nil, 0, @ThreadProc_IOCPServerWorkThread, @AServer.IocpWorkThread[i],
          CREATE_SUSPENDED, AServer.IocpWorkThread[i].SysThread.Core.ThreadID);
        Windows.ResumeThread(AServer.IocpWorkThread[i].SysThread.Core.ThreadHandle);
      end;
      AServer.BaseServer.CheckOutDataOutBuffer := CheckOutIocpDataOutBuffer;
      AServer.BaseServer.SendDataOut := SendIocpDataOut;
      
      AServer.BaseServer.CheckOutClientSession := CheckOutHttpClientSession;
      AServer.BaseServer.CheckInClientSession := CheckInHttpClientSession;

      AServer.AcceptThread.Server := AServer;
      AServer.AcceptThread.SysThread.Core.IsActiveStatus := 1;
      AServer.AcceptThread.SysThread.Core.ThreadHandle :=
          Windows.CreateThread(nil, 0, @ThreadProc_IOCPServerAcceptThread, @AServer.AcceptThread,
          CREATE_SUSPENDED, AServer.AcceptThread.SysThread.Core.ThreadID);
      Windows.ResumeThread(AServer.AcceptThread.SysThread.Core.ThreadHandle);
      // FMaxWorkThrCount := 160;
      // FMinWorkThrCount := 120;
      // FMaxCheckThrCount := 60;
      // FMinCheckThrCount := 40;
    end;
  end;
end;

procedure CloseIOCPNetServer(AServer: PNetServerIocp);
const
  CompleteKey_CloseIocp = 255;
var
  tmpBytes: DWord;
begin
  if (0 <> AServer.BaseServer.ListenSocketHandle) and
     (INVALID_SOCKET <> AServer.BaseServer.ListenSocketHandle) then
  begin
    WinSock2.CloseSocket(AServer.BaseServer.ListenSocketHandle);
    AServer.BaseServer.ListenSocketHandle := 0;
  end;
  if (0 <> AServer.Iocp.Handle) and
     (INVALID_HANDLE_VALUE <> AServer.Iocp.Handle) then
  begin
    PostQueuedCompletionStatus(AServer.Iocp.Handle, tmpBytes, CompleteKey_CloseIocp, nil);

    Windows.CloseHandle(AServer.Iocp.Handle);
    AServer.Iocp.Handle := 0;
  end;
end;

end.
