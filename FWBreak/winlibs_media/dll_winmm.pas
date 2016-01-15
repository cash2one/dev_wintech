{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_winmm;

interface

uses
  atmcmbaseconst, winconst, wintype;

const
  winmm             = 'winmm.dll';   // mmsystem
  MAXPNAMELEN       =  32;    { max product name length (including nil) }
  MAXERRORLENGTH    = 128;    { max error text length (including nil) }
  MAX_JOYSTICKOEMVXDNAME = 260; { max oem vxd name length (including nil) }

type
  HDRVR             = Integer;
  MMVERSION         = UINT;             { major (high byte), minor (low byte) }
  MMRESULT          = UINT;              { error return code, 0 means no error }

  TFNDrvCallBack    = procedure(hdrvr: HDRVR; uMsg: UINT; dwUser: DWORD;
    dw1, dw2: DWORD) stdcall;
  
  PAuxCapsA         = ^TAuxCapsA;
  PAuxCaps          = PAuxCapsA;
  TAuxCapsA         = record
    wMid            : Word;                  { manufacturer ID }
    wPid            : Word;                  { product ID }
    vDriverVersion  : MMVERSION;        { version of the driver }
    szPname         : array[0..MAXPNAMELEN-1] of AnsiChar;  { product name (NULL terminated AnsiString) }
    wTechnology     : Word;           { type of device }
    dwSupport       : DWORD;            { functionality supported by driver }
  end;
  TAuxCaps          = TAuxCapsA;


  function auxGetDevCaps(uDeviceID: UINT; lpCaps: PAuxCaps; uSize: UINT): MMRESULT; stdcall; external winmm name 'auxGetDevCapsA';
  function auxGetNumDevs: UINT; stdcall; external winmm name 'auxGetNumDevs';
  function auxGetVolume(uDeviceID: UINT; lpdwVolume: PDWORD): MMRESULT; stdcall; external winmm name 'auxGetVolume';
  function auxSetVolume(uDeviceID: UINT; dwVolume: DWORD): MMRESULT; stdcall; external winmm name 'auxSetVolume';
  function auxOutMessage(uDeviceID, uMessage: UINT; dw1, dw2: DWORD): MMRESULT; stdcall; external winmm name 'auxOutMessage';

  function OpenDriver(szDriverName: PWideChar; szSectionName: PWideChar; lParam2: Longint): HDRVR; stdcall; external winmm name 'OpenDriver';
  function CloseDriver(hDriver: HDRVR; lParam1, lParam2: Longint): Longint; stdcall; external winmm name 'CloseDriver';
  function DefDriverProc(dwDriverIdentifier: DWORD; hdrvr: HDRVR; uMsg: UINT;
    lParam1, lParam2: LPARAM): Longint; stdcall; external winmm name 'DefDriverProc';
  function DrvGetModuleHandle(hDriver: HDRVR): HMODULE; stdcall; external winmm name 'DrvGetModuleHandle';
  function GetDriverModuleHandle(hDriver: HDRVR): HMODULE; stdcall; external winmm name 'GetDriverModuleHandle';
  function SendDriverMessage(hDriver: HDRVR; message: UINT; lParam1, lParam2: Longint): Longint; stdcall; external winmm name 'SendDriverMessage';

type
  MCIERROR = DWORD;     { error return code, 0 means no error }
  MCIDEVICEID = UINT;   { MCI device ID type }

  TFNYieldProc = function(mciId: MCIDEVICEID; dwYieldData: DWORD): UINT stdcall;

  function mciExecute(pszCommand: LPCSTR): BOOL; stdcall; external winmm name 'mciExecute';
  function mciGetCreatorTask(mciId: MCIDEVICEID): HTASK; stdcall; external winmm name 'mciGetCreatorTask';
  function mciGetDeviceID(pszDevice: PAnsiChar): MCIDEVICEID; stdcall; external winmm name 'mciGetDeviceIDA';
  function mciGetDeviceIDFromElementID(dwElementID: DWORD; lpstrType: PAnsiChar): MCIDEVICEID; stdcall; external winmm name 'mciGetDeviceIDFromElementIDA';
  function mciGetErrorString(mcierr: MCIERROR; pszText: PAnsiChar; uLength: UINT): BOOL; stdcall; external winmm name 'mciGetErrorStringA';
  function mciGetYieldProc(mciId: MCIDEVICEID; lpdwYieldData: PDWORD): TFNYieldProc; stdcall; external winmm name 'mciGetYieldProc';
  function mciSendCommand(mciId: MCIDEVICEID; uMessage: UINT;
      dwParam1, dwParam2: DWORD): MCIERROR; stdcall; external winmm name 'mciSendCommandA';
  function mciSendString(lpstrCommand, lpstrReturnString: PAnsiChar;
      uReturnLength: UINT; hWndCallback: HWND): MCIERROR; stdcall; external winmm name 'mciSendStringA';
  function mciSetYieldProc(mciId: MCIDEVICEID; fpYieldProc: TFNYieldProc;
      dwYieldData: DWORD): BOOL; stdcall; external winmm name 'mciSetYieldProc';

  function mmsystemGetVersion: UINT; stdcall; external winmm name 'mmsystemGetVersion';
  function PlaySound(pszSound: PAnsiChar; hmod: HMODULE; fdwSound: DWORD): BOOL; stdcall; external winmm name 'PlaySoundA';
  function sndPlaySound(lpszSoundName: PAnsiChar; uFlags: UINT): BOOL; stdcall; external winmm name 'sndPlaySoundA';

type
  PTimeCaps = ^TTimeCaps;
  TTimeCaps = record
    wPeriodMin: UINT;     { minimum period supported  }
    wPeriodMax: UINT;     { maximum period supported  }
  end;

const  
  TIME_MS         = $0001;  { time in milliseconds }
  TIME_SAMPLES    = $0002;  { number of wave samples }
  TIME_BYTES      = $0004;  { current byte offset }
  TIME_SMPTE      = $0008;  { SMPTE time }
  TIME_MIDI       = $0010;  { MIDI time }
  TIME_TICKS      = $0020;  { Ticks within MIDI stream }


type
  PMMTime = ^TMMTime;
  TMMTime = record
    case wType: UINT of        { indicates the contents of the variant record }
     TIME_MS:      (ms: DWORD);
     TIME_SAMPLES: (sample: DWORD);
     TIME_BYTES:   (cb: DWORD);
     TIME_TICKS:   (ticks: DWORD);
     TIME_SMPTE: (
        hour: Byte;
        min: Byte;
        sec: Byte;
        frame: Byte;
        fps: Byte;
        dummy: Byte;
        pad: array[0..1] of Byte);
      TIME_MIDI : (songptrpos: DWORD);
  end;

  TFNTimeCallBack = procedure(uTimerID, uMessage: UINT; dwUser, dw1, dw2: DWORD) stdcall;

  function timeBeginPeriod(uPeriod: UINT): MMRESULT; stdcall; external winmm name 'timeBeginPeriod';
  function timeEndPeriod(uPeriod: UINT): MMRESULT; stdcall; external winmm name 'timeEndPeriod';
  
  function timeGetDevCaps(lpTimeCaps: PTimeCaps; uSize: UINT): MMRESULT; stdcall; external winmm name 'timeGetDevCaps';
  function timeGetSystemTime(lpTime: PMMTime; uSize: Word): MMRESULT; stdcall; external winmm name 'timeGetSystemTime';
  function timeGetTime: DWORD; stdcall; external winmm name 'timeGetTime';
  function timeKillEvent(uTimerID: UINT): MMRESULT; stdcall; external winmm name 'timeKillEvent';
  function timeSetEvent(uDelay, uResolution: UINT; lpFunction: TFNTimeCallBack;
      dwUser: DWORD; uFlags: UINT): MMRESULT; stdcall; external winmm name 'timeSetEvent';

implementation

end.
