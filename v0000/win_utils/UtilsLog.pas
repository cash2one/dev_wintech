{------------------------------------------------------------------------------}
{ SDLogUtils.pas for SDShell                                                   }
{------------------------------------------------------------------------------}
{ 单元描述: 日志工具函数单元                                                   }
{ 单元作者: 盛大网络 张洋 (zhangyang@snda.com)                                 }
{ 参考文档:                                                                    }
{ 创建日期: 2005-12-05                                                         }
{------------------------------------------------------------------------------}
{ 日志模块功能介绍:                                                            }
{                                                                              }
{   * 独立单元，避免循环引用，可在多个项目中直接引用                           }
{   * 自动将子线程日志缩进显示                                                 }
{   * 将日志分为普通日志和异常日志二类，方便定位错误                           }
{   * 日志文件名分别为(假设为SDShell.exe): SDShell.log 和 SDShellErr.log       }
{   * 提供异常信息日志函数 LogException                                        }
{   * 日志文件超过指定大小之后自动在下次进程启动运行时删除                     }
{   * 可通过 SDDebugViewer.exe 即时查看调试细节                                }
{                                                                              }
{ Log日志函数:                                                                 }
{                                                                              }
{ procedure Log(const AMsg: ansistring);                            // Log一般信息 }
{ procedure LogException(E: Exception; const AMsg: ansistring = '');// Log异常对象 }
{ procedure LogWarning(const AMsg: ansistring);                     // Log警告信息 }
{ procedure LogError(const AMsg: ansistring);                       // Log错误信息 }
{ procedure LogWithTag(const AMsg: ansistring; const ATag: ansistring); // Log加标记   }
{ procedure LogSeparator;                                       // Log分隔符   }
{ procedure LogEnterProc(const AProcName: ansistring);              // Log进入过程 }
{ procedure LogLeaveProc(const AProcName: ansistring);              // Log退出过程 }
{                                                                              }
{------------------------------------------------------------------------------}
{ 修改历史：                                                                   }
(* 2007.01.31 liaofeng                                                          }
{   在写入日志时增加判断，如果写入的次数超出一定数量，则自动截断或重写日志     }
{   增加条件编译选项：$DEFINE LOGTRUNCFILE，在日志超出限制时是否自动截断(重写  }
{   日志并保留最后写入的一段日志，默认保留100K)，未定义时重写文件              }
 * 2007.05.29
    修改为不立即初始化日志文件，并且可以不仅仅透过编译开关彻底关闭日志文件，也可以
    在程序软关闭日志文件。


{-----------------------------------------------------------------------------*)
unit UtilsLog;

{$WARN SYMBOL_PLATFORM OFF}


{$DEFINE LOGTOFILE}           // 是否LOG至文件
{.$DEFINE LOGTODEBUGGER}      // 是否LOG至DebugView
{$DEFINE LOGSOURCEFILENAME}   // 是否在LOG文件中显示源代码名称

{$DEFINE REROUTEASSERT}       // 是否替换Assert
{$DEFINE ASSERTMSGLOG}        // 将Assert信息Log至文件
{.$DEFINE ASSERTMSGSHOW}      // 将Assert信息通过MessageBox显示出来
{$DEFINE ASSERTMSGRAISE}      // 将Assert信息Raise出来

{.$DEFINE LOGERRORRAISE}       // 将LogError或LogException的信息raise出来

{$DEFINE LOGTRUNCFILE}        // 超出日志大小限制时截断文件而不是重写文件

interface

uses
  Windows, Classes, SysUtils;

type
  PLogFile        = ^TLogFile;
  TLogFile        = record
    Initialized   : Boolean; { 是否已初始化参数 }
    AllowLogToFile: Boolean;// = True;
    LogFileNameMode: integer;
    LastLogTick   : DWORD;
    LogLock       : TRTLCriticalSection;                 { 日志写入锁 }
    FileHandle    : THandle;
    ErrFileHandle : THandle;   { 日志文件句柄 }
    LogWriteCount : Integer;    { 日志已写入次数 }
    FileName      : AnsiString;
    ErrorFileName : AnsiString; { 异常日志文件名全路径 }
  end;

{ Log系列输出函数}
procedure Log(const ASourceFileName, AMsg: string; ALogFile: PLogFile = nil);                             // Log一般信息   
procedure SDLog(const ASourceFileName, AMsg: string; ALogFile: PLogFile = nil);                             // Log一般信息
procedure LogException(const ASourceFileName: string; E: Exception;
    ALogFile: PLogFile = nil;
    const AMsg: string = ''; ARaise: Boolean = False); // Log异常对象
procedure LogWarning(const ASourceFileName, AMsg: string;
    ALogFile: PLogFile = nil);                      // Log警告信息
procedure LogError(const ASourceFileName, AMsg: string;
    ALogFile: PLogFile = nil; ErrorCode: Integer = 0); overload;    // Log错误信息
procedure LogError(const ASourceFileName, AMsg: string; E: Exception;
    ALogFile: PLogFile = nil; ARaise: Boolean=False); overload;              // Log错误信息
procedure LogWithTag(const ASourceFileName, AMsg, ATag: string;
    ALogFile: PLogFile = nil);  // Log加标记
procedure LogSeparator(const ASourceFileName: string; ALogFile: PLogFile = nil); // Log分隔符
procedure LogEnterProc(const ASourceFileName, AProcName: string;
    ALogFile: PLogFile = nil);               // Log进入过程
procedure LogLeaveProc(const ASourceFileName, AProcName: string;
    ALogFile: PLogFile = nil);               // Log退出过程

procedure InitLogFileHandle(ALogFile: PLogFile = nil);
procedure SurfaceLogError(const ASource, AMsg: string; E: Exception;
    ALogFile: PLogFile = nil);

procedure InitLogFiles(ALogFile: PLogFile);
procedure CloseLogFiles(ALogFile: PLogFile = nil);

var
  G_LogFile          : TLogFile;
  G_CurrentProcessId : Cardinal = 0;                   { 当前进程Id }
//  G_MainThreadId     : Cardinal = 0;                       { 主线程Id }

implementation
               
procedure SDLog(const ASourceFileName, AMsg: string; ALogFile: PLogFile = nil);                             // Log一般信息
begin
  Log(ASourceFileName, AMsg, ALogFile);
end;
//uses
//  IniFiles;

const
  { 最大日志文件大小,超过后下次运行时自动删除重新开始 }
  cMaxLogFileSize    = 1024 * 1024 * 256;
  { 最大写入的次数，超过自动截断重写 }
  cMaxLogWriteCount  = 6 * 1000 * 1000;
  { 自动截断时保留最后写入日志的大小 }
  cMaxLogSaveSize    = 1024 * 100;

procedure InitLogFileHandle(ALogFile: PLogFile);
begin
  if ALogFile.Initialized then
  begin
    try
      DeleteCriticalSection(ALogFile.LogLock);
    except
    end;
    ALogFile.Initialized := False;
  end;     
  if ALogFile.FileHandle <> INVALID_HANDLE_VALUE then
  begin
    CloseHandle(ALogFile.FileHandle);
    ALogFile.FileHandle := INVALID_HANDLE_VALUE;
  end;
  
  if ALogFile.ErrFileHandle <> INVALID_HANDLE_VALUE then
  begin
    CloseHandle(ALogFile.ErrFileHandle);
    ALogFile.ErrFileHandle := INVALID_HANDLE_VALUE;
  end;
end;
  
function GetFileSize(const AFileName: string): Int64;
var
  HFileRes: THandle;
begin
  Result := 0;
  HFileRes := CreateFile(PChar(@AFileName[1]), GENERIC_READ, FILE_SHARE_READ,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if HFileRes <> INVALID_HANDLE_VALUE then
  begin
    Result := Windows.GetFileSize(HFileRes, nil);
    CloseHandle(HFileRes);
  end;
end;

procedure InitLogFiles(ALogFile: PLogFile);
var
  s: ansistring;
//  ini: TIniFile;
begin
{$IFDEF LOGTOFILE}
  if not ALogFile.Initialized then
  begin
    if not ALogFile.AllowLogToFile then
      Exit;
//    ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
//    try
//      logmode := strtointdef(ini.ReadString('Log', 'LogMode', '0'), 0);
//    finally
//      ini.Free;
//    end;
    if ALogFile.FileName = '' then
    begin
      case ALogFile.LogFileNameMode of
        0: begin
          ALogFile.FileName := ansistring(ChangeFileExt(ParamStr(0), '.log'));
          ALogFile.ErrorFileName := ansistring(ChangeFileExt(ParamStr(0), '.Err.log'));
        end;
        1: begin
          s := ansistring(trim(ParamStr(0)));
          s := copy(s, 1, length(s) - 4) + '_' + AnsiString(formatdatetime('mmdd_hhmmss', now()));
          ALogFile.FileName := s + '.log';
          ALogFile.ErrorFileName := s + 'Err.log';
        end;
        2: begin
          ALogFile.Initialized := True;
          ALogFile.AllowLogToFile := False;
          exit;
        end;
      end;
    end;
    ALogFile.Initialized := true;
    try
      InitializeCriticalSection(ALogFile.LogLock);
    except
    end;
//      (ALogFile.FileHandle <> INVALID_HANDLE_VALUE) and
//                     (ALogFile.FileHandle <> 0) and
//                     (ALogFile.ErrFileHandle <> INVALID_HANDLE_VALUE) and
//                     (ALogFile.ErrFileHandle <> 0);
  end;
{$ENDIF}
end;

procedure CloseLogFiles(ALogFile: PLogFile);
begin
  // 暂时不解锁
//  Exit;
  if ALogFile <> nil then
  begin
    if ALogFile.Initialized then
    begin
      if (ALogFile.FileHandle <> INVALID_HANDLE_VALUE) then
      begin
        try
        if CloseHandle(ALogFile.FileHandle) then
        begin
          ALogFile.FileHandle := 0;
        end;
        except
        end;
      end;
      if (ALogFile.ErrFileHandle <> INVALID_HANDLE_VALUE) then
      begin
        try
          if CloseHandle(ALogFile.ErrFileHandle) then
          begin
            ALogFile.ErrFileHandle := 0;
          end;
        except
        end;
      end;
      ALogFile.Initialized := False;

  // 好像不能解锁
      try
        DeleteCriticalSection(ALogFile.LogLock);
      except
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
// _Log - 写入信息至日志文件(可指定是否同时写入异常日志中)
//------------------------------------------------------------------------------
// 函数参数: Msg      = 日志信息
//           IsError  = 是否同时记录至异常日志中
// 返 回 值: 无
// 创建时间: 2005-12-5 22:29:51
//------------------------------------------------------------------------------
procedure _Log(const SourceFileName, AMsg: String;
  ALogFile: PLogFile;
  IsError: Boolean = False);
var
//  hFile: THandle;
  BytesWrite: Cardinal;
  LocalTime: TSystemTime;
//  LogFileName: ansistring;
  LogFileHandle: THandle;
  CurrentThreadId: Cardinal;
  IsThreadMsg: Boolean;
  ErrMsg:string;
  T: Int64;
  L: Integer;
{$IFDEF LOGTRUNCFILE}
  SaveBuffer: PChar;
{$ENDIF}
  LogInfo: ansistring;
  tmpMsg: ansistring;
  FileSize: DWORD;
begin
{$IFDEF LOGTOFILE}
  if ALogFile = nil then
  begin
    ALogFile := @G_LogFile;
  end;
  InitLogFiles(ALogFile);
  if not ALogFile.Initialized then
  begin
    Exit; //InitLogFiles;
  end;
  if not ALogFile.AllowLogToFile then
  begin
    Exit;
  end;
  tmpMsg := ansistring(AMsg);
  L:= Length(tmpMsg);
  if L<65536 then //单行太大了。
  begin                   
    {$IFDEF LOGTRUNCFILE}
    SaveBuffer:= @tmpMsg[1];
    {$ENDIF}
//    if SaveBuffer[L] <> #0 then
//      Exit;
  end else
  begin
    Exit;
  end;

  CurrentThreadId := GetCurrentThreadId;
  IsThreadMsg := MainThreadId <> CurrentThreadId;

  if IsError then
  begin
    if (ALogFile.ErrFileHandle = 0) or
       (ALogFile.ErrFileHandle = INVALID_HANDLE_VALUE) then
    begin
      ALogFile.ErrFileHandle := CreateFileA(PAnsiChar(ALogFile.ErrorFileName),
          GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
        OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
      if ALogFile.ErrFileHandle <> INVALID_HANDLE_VALUE then
      begin
        if Windows.GetFileSize(ALogFile.ErrFileHandle, @FileSize) > cMaxLogFileSize then
          SetEndOfFile(ALogFile.ErrFileHandle);
        SetFilePointer(ALogFile.ErrFileHandle, 0, nil, FILE_END);
      end;
    end;
    LogFileHandle := ALogFile.ErrFileHandle
  end else
  begin
    if (ALogFile.FileHandle = 0) or
       (ALogFile.FileHandle = INVALID_HANDLE_VALUE) then
    begin
      ALogFile.FileHandle := CreateFileA(PAnsiChar(ALogFile.FileName), GENERIC_WRITE
        {$IFDEF LOGTRUNCFILE}or GENERIC_READ{$ENDIF},
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
        OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
      if ALogFile.FileHandle <> INVALID_HANDLE_VALUE then
      begin
        if Windows.GetFileSize(ALogFile.FileHandle, @FileSize) > cMaxLogFileSize then
        begin
          {$IFDEF LOGTRUNCFILE}
          InterlockedExchange(ALogFile.LogWriteCount, cMaxLogWriteCount);  // 设为最大日志写入次数，下次写就会自动截断了
          {$ELSE}
          SetEndOfFile(G_LogFileHandle)
          {$ENDIF}
        end else
        begin
          InterlockedExchange(ALogFile.LogWriteCount, FileSize div 100);   // 大致估算已写入日志次数
        end;
        SetFilePointer(ALogFile.FileHandle, 0, nil, FILE_END);
      end;
    end;
    LogFileHandle := ALogFile.FileHandle;
    // 检查写入次数是否已超出限制，超出则自动截断或重写
    if InterlockedIncrement(ALogFile.LogWriteCount) > cMaxLogWriteCount then
    begin
      if InterlockedExchange(ALogFile.LogWriteCount, 0) > cMaxLogWriteCount then
      begin
        {$IFDEF LOGTRUNCFILE}
        GetMem(SaveBuffer, cMaxLogSaveSize);
        try
          SetFilePointer(LogFileHandle, -cMaxLogSaveSize, nil, FILE_END);
          ReadFile(LogFileHandle, SaveBuffer^, cMaxLogSaveSize, BytesWrite, nil);
        {$ENDIF}
          SetFilePointer(LogFileHandle, 0, nil, FILE_BEGIN);
          SetEndOfFile(LogFileHandle);
        {$IFDEF LOGTRUNCFILE}
          WriteFile(LogFileHandle, SaveBuffer^, BytesWrite, BytesWrite, nil);
        except
        end;
        FreeMem(SaveBuffer);
        {$ENDIF}
      end;
    end;
  end;
//    LogFileName := G_LogErrorFileName else
//    LogFileName := G_LogFileName;

//  hFile := CreateFileA(PAnsiChar(LogFileName), GENERIC_WRITE, FILE_SHARE_READ, nil,
//    OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
//  if hFile = INVALID_HANDLE_VALUE then Exit;
  try
{$IFDEF LOGSOURCEFILENAME}
    LogInfo := '[' + ansistring(SourceFileName) + ']' + tmpMsg;
{$ELSE}
    LogInfo := Msg;
{$ENDIF LOGSOURCEFILENAME}
    if IsThreadMsg then
    begin
      LogInfo := AnsiString(Format(#9'[%.8x] %s', [CurrentThreadId, LogInfo]));
    end;
//    SetFilePointer(LogFileHandle, 0, nil, FILE_END);
    GetLocalTime(LocalTime);

    QueryPerformanceCounter(T);
    T:= T mod 1000000;
    LogInfo := ansistring(LogInfo + #13#10);
    //(*//
    try
      LogInfo := ansistring(Format('(%.8x) %.4d-%.2d-%.2d %.2d:%.2d:%.2d.%.3d.%.6d=%s'#13#10, [
        G_CurrentProcessId,
        LocalTime.wYear, LocalTime.wMonth, LocalTime.wDay,
        LocalTime.wHour, LocalTime.wMinute, LocalTime.wSecond,
        LocalTime.wMilliseconds, T,
        LogInfo]));
    except
      LogInfo := '';
    end;
    //*)

//    EnterCriticalSection(G_LogLock);
    try
      try
      SetFilePointer(LogFileHandle, 0, nil, FILE_END);

      WriteFile(LogFileHandle, LogInfo[1], Length(LogInfo), BytesWrite, nil);
      except
        on E: Exception do
        begin
          // 加一段日志情况的保护
          ErrMsg := '日志错误:' + E.Message + #13#10;
          WriteFile(LogFileHandle, ErrMsg[1], Length(ErrMsg), BytesWrite, nil);
        end;
      end;
//      FlushFileBuffers(LogFileHandle);
    finally
//      LeaveCriticalSection(G_LogLock);
    end;
  finally
//    CloseHandle(hFile);
  end;

  if IsError then
  begin
    _Log(SourceFileName, string(tmpMsg), ALogFile, False);
  end;
{$ENDIF}
end;

//------------------------------------------------------------------------------
// _LogE - 记录错误信息至日志文件(同时写入至二个日志文件中)
//------------------------------------------------------------------------------
// 函数参数: Msg   = 发生异常的过程名(或其他日志内容)
//           E     = 异常对象
// 返 回 值: 无
// 创建时间: 2005-12-5 22:30:54
//------------------------------------------------------------------------------
procedure _LogE(const SourceFileName, Msg: ansistring; E: Exception; ALogFile: PLogFile);
var
  LogInfo: ansistring;
begin
  LogInfo := ansistring(Format('!!! Runtime Exception: %s (ClassName: %s; Msg: %s)', [Msg, E.ClassName, E.Message]));
  _Log(string(SourceFileName), string(LogInfo), ALogFile, True);
end;

//------------------------------------------------------------------------------
// DebugOut - 输出调试信息串
//------------------------------------------------------------------------------
// 函数参数: const S: ansistring
// 返 回 值: 无
// 尚存问题:
// 创建时间: 2006-5-9 12:05:15
//------------------------------------------------------------------------------
procedure DebugOut(const SourceFileName, S: ansistring);
begin
{$IFDEF LOGTODEBUGGER}
  OutputDebugStringA(PAnsiChar(Format('[%s] %s', [SourceFileName, S])));
{$ENDIF}
end;


// Log 系列输出函数 == Start ==
procedure Log(const ASourceFileName, AMsg: String; ALogFile: PLogFile);                             // Log一般信息
begin
  DebugOut(ansistring(ASourceFileName), ansistring(AMsg));
  _Log(ASourceFileName, AMsg, ALogFile);
end;

procedure LogException(const ASourceFileName: String; E: Exception;
    ALogFile: PLogFile = nil;
    const AMsg: String='';
    ARaise: Boolean = False);
begin
  LogError(ASourceFileName, AMsg, E, ALogFile, ARaise);
//  DebugOut(ASourceFileName, Format('!! EXCEPTION [%s]: %s; %s', [E.ClassName, E.Message, AMsg]));
//  _LogE(ASourceFileName, AMsg, E);
  {$IFDEF LOGERRORRAISE}
    // 为方便查看错误
//    raise E;
  {$ENDIF}
end;

procedure LogWithTag(const ASourceFileName, AMsg: String; const ATag: String;
   ALogFile: PLogFile);
var
  S: String;
begin
  S := Format('[tag=%s] %s', [ATag, AMsg]);
  DebugOut(ansistring(ASourceFileName), ansistring(S));
  _Log(ASourceFileName, S, ALogFile);
end;

procedure LogWarning(const ASourceFileName, AMsg: string; ALogFile: PLogFile);
var
  S: ansistring;
begin
  S := '[WARNING] ' + AnsiString(AMsg);
  DebugOut(ansistring(ASourceFileName), S);
  _Log(ASourceFileName, string(S), ALogFile, True);
end;

procedure LogError(const ASourceFileName, AMsg: string;
    ALogFile: PLogFile = nil; ErrorCode: Integer = 0);
var
  S: ansistring;
begin
  if ErrorCode <> 0 then
    S := '[ERROR ErrorCode=' + ansistring(IntToStr(ErrorCode)) + '] ' + ansistring(AMsg)
  else
    S := '[ERROR] ' + ansistring(AMsg);
  DebugOut(ansistring(ASourceFileName), S);
  _Log(ASourceFileName, string(S), ALogFile, True);
  {$IFDEF LOGERRORRAISE}
    // 为方便查看错误
    // 为了区分错误类型使用HelpContext标识
    raise Exception.Create('[' + ASourceFileName + ']' + AMsg).HelpContext = ErrorCode;
  {$ENDIF}
end;

procedure LogError(const ASourceFileName, AMsg: string; E: Exception;
    ALogFile: PLogFile = nil;
    ARaise: Boolean = False); overload;              // Log错误信息
var
  S: ansistring;
begin
  S:= ansistring(Format('!!! EXCEPTION [%s][%d]: %s; %s', [E.ClassName, E.HelpContext, E.Message, AMsg]));
  DebugOut(ansistring(ASourceFileName), S);
  _Log(ASourceFileName, string(S), ALogFile, True);
  {$IFDEF LOGERRORRAISE}
    // 为方便查看错误
    // 为了区分错误类型使用HelpContext标识
    if ARaise then
      raise E;
  {$ENDIF}
end;

procedure LogSeparator(const ASourceFileName: string; ALogFile: PLogFile);
begin
  DebugOut(ansistring(ASourceFileName), '-----------------------');
  _Log(ASourceFileName, '-----------------------', ALogFile);
end;

procedure LogEnterProc(const ASourceFileName, AProcName: string; ALogFile: PLogFile);
var
  S: ansistring;
begin
  S := '[ENTERPROC] ' + ansistring(AProcName);
  DebugOut(ansistring(ASourceFileName), S);
  _Log(ASourceFileName, string(S), ALogFile);
end;

procedure LogLeaveProc(const ASourceFileName, AProcName: string; ALogFile: PLogFile);
var
  S: ansistring;
begin
  S := '[LEAVEPROC] ' + ansistring(AProcName);
  DebugOut(ansistring(ASourceFileName), S);
  _Log(ASourceFileName, string(S), ALogFile);
end;

procedure AssertErrorHandler(const Msg, Filename: string;
  LineNumber: Integer; ErrorAddr: Pointer);
begin
{$IFDEF ASSERTMSGSHOW} // 将Assert信息通过MessageBox显示出来
  MessageBox(0, PAnsiChar(Format('%s (%s, line %d, address $%x)',
    [Msg, Filename, LineNumber, Pred(Integer(ErrorAddr))]))
    , '日志提示', MB_OK + MB_ICONSTOP);
{$ENDIF}

{$IFDEF ASSERTMSGLOG} // 将Assert信息Log至文件
  Log(Format('%s, line %d, address $%x',
    [ExtractFileName(Filename), LineNumber, Pred(Integer(ErrorAddr))])
    , Msg, @G_LogFile);
{$ENDIF}

{$IFDEF ASSERTMSGRAISE}
  raise Exception.Create(Format('%s (%s, line %d, address $%x)',
    [Msg, Filename, LineNumber, Pred(Integer(ErrorAddr))]));
{$ENDIF}
end;

procedure RerouteAssertions;
begin
  System.AssertErrorProc := AssertErrorHandler;
end;

procedure SurfaceLogError(const ASource, AMsg: String; E: Exception; ALogFile: PLogFile = nil);
begin
  if E<>nil then
    LogError(ASource, AMsg, E, ALogFile, False)
  else
    LogError(ASource, AMsg, ALogFile);
end;

initialization
  // 替换原有的Assert
//  G_MainThreadId := GetCurrentThreadId;
  FillChar(G_LogFile, SizeOf(G_LogFile), 0);
  G_LogFile.AllowLogToFile := true;
  G_LogFile.FileHandle := INVALID_HANDLE_VALUE;
  G_LogFile.ErrFileHandle := INVALID_HANDLE_VALUE;
  {$IFDEF REROUTEASSERT}
  RerouteAssertions;
  {$ENDIF}

//finalization
//  CloseLogFiles(@G_LogFile);

end.
