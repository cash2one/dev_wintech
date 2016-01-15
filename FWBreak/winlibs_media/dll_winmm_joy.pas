{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_winmm_joy;

interface

uses
  atmcmbaseconst, winconst, wintype, dll_winmm;

type
  PJoyCapsA         = ^TJoyCapsA;
  PJoyCaps          = PJoyCapsA;
  TJoyCapsA         = record
    wMid: Word;                  { manufacturer ID }
    wPid: Word;                  { product ID }
    szPname: array[0..MAXPNAMELEN-1] of AnsiChar;  { product name (NULL terminated AnsiString) }
    wXmin: UINT;                 { minimum x position value }
    wXmax: UINT;                 { maximum x position value }
    wYmin: UINT;                 { minimum y position value }
    wYmax: UINT;                 { maximum y position value }
    wZmin: UINT;                 { minimum z position value }
    wZmax: UINT;                 { maximum z position value }
    wNumButtons: UINT;           { number of buttons }
    wPeriodMin: UINT;            { minimum message period when captured }
    wPeriodMax: UINT;            { maximum message period when captured }
    wRmin: UINT;                 { minimum r position value }
    wRmax: UINT;                 { maximum r position value }
    wUmin: UINT;                 { minimum u (5th axis) position value }
    wUmax: UINT;                 { maximum u (5th axis) position value }
    wVmin: UINT;                 { minimum v (6th axis) position value }
    wVmax: UINT;                 { maximum v (6th axis) position value }
    wCaps: UINT;                 { joystick capabilites }
    wMaxAxes: UINT;	 	{ maximum number of axes supported }
    wNumAxes: UINT;	 	{ number of axes in use }
    wMaxButtons: UINT;	 	{ maximum number of buttons supported }
    szRegKey: array[0..MAXPNAMELEN - 1] of AnsiChar; { registry key }
    szOEMVxD: array[0..MAX_JOYSTICKOEMVXDNAME - 1] of AnsiChar; { OEM VxD in use }
  end;
  TJoyCaps = TJoyCapsA;

  PJoyInfo = ^TJoyInfo;
  TJoyInfo = record
    wXpos: UINT;                 { x position }
    wYpos: UINT;                 { y position }
    wZpos: UINT;                 { z position }
    wButtons: UINT;              { button states }
  end;

  PJoyInfoEx = ^TJoyInfoEx;
  TJoyInfoEx = record
    dwSize: DWORD;		 { size of structure }
    dwFlags: DWORD;		 { flags to indicate what to return }
    wXpos: UINT;         { x position }
    wYpos: UINT;         { y position }
    wZpos: UINT;         { z position }
    dwRpos: DWORD;		 { rudder/4th axis position }
    dwUpos: DWORD;		 { 5th axis position }
    dwVpos: DWORD;		 { 6th axis position }
    wButtons: UINT;      { button states }
    dwButtonNumber: DWORD;  { current button number pressed }
    dwPOV: DWORD;           { point of view state }
    dwReserved1: DWORD;		 { reserved for communication between winmm & driver }
    dwReserved2: DWORD;		 { reserved for future expansion }
  end;

  function joyGetDevCaps(uJoyID: UINT; lpCaps: PJoyCaps; uSize: UINT): MMRESULT; stdcall; external winmm name 'joyGetDevCapsA';
  function joyGetNumDevs: UINT; stdcall; external winmm name 'joyGetNumDevs';
  function joyGetPos(uJoyID: UINT; lpInfo: PJoyInfo): MMRESULT; stdcall; external winmm name 'joyGetPos';
  function joyGetPosEx(uJoyID: UINT; lpInfo: PJoyInfoEx): MMRESULT; stdcall; external winmm name 'joyGetPosEx';
  function joyGetThreshold(uJoyID: UINT; lpuThreshold: PUINT): MMRESULT; stdcall; external winmm name 'joyGetThreshold';
  function joyReleaseCapture(uJoyID: UINT): MMRESULT; stdcall; external winmm name 'joyReleaseCapture';
  function joySetCapture(Handle: HWND; uJoyID, uPeriod: UINT; bChanged: BOOL): MMRESULT; stdcall; external winmm name 'joySetCapture';
  function joySetThreshold(uJoyID, uThreshold: UINT): MMRESULT; stdcall; external winmm name 'joySetThreshold';
  function joyConfigChanged(dwFlags : LongWord) : MMRESULT; external winmm;

implementation

end.
