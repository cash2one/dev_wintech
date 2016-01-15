{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_w;

interface 
                 
uses
  atmcmbaseconst, winconst, wintype, dll_user32;

type
  PDeviceModeW      = ^TDeviceModeW;
  TDeviceModeW      = packed record
    dmDeviceName    : array[0..CCHDEVICENAME - 1] of WideChar;
    dmSpecVersion   : Word;
    dmDriverVersion : Word;
    dmSize: Word;
    dmDriverExtra: Word;
    dmFields: DWORD;
    dmOrientation   : SHORT;
    dmPaperSize: SHORT;
    dmPaperLength   : SHORT;
    dmPaperWidth    : SHORT;
    dmScale: SHORT;
    dmCopies        : SHORT;
    dmDefaultSource : SHORT;
    dmPrintQuality  : SHORT;
    dmColor: SHORT;
    dmDuplex        : SHORT;
    dmYResolution   : SHORT;
    dmTTOption      : SHORT;
    dmCollate       : SHORT;
    dmFormName      : array[0..CCHFORMNAME - 1] of WideChar;
    dmLogPixels     : Word;
    dmBitsPerPel    : DWORD;
    dmPelsWidth     : DWORD;
    dmPelsHeight    : DWORD;
    dmDisplayFlags  : DWORD;
    dmDisplayFrequency: DWORD;
    dmICMMethod     : DWORD;
    dmICMIntent     : DWORD;
    dmMediaType     : DWORD;
    dmDitherType    : DWORD;
    dmICCManufacturer: DWORD;
    dmICCModel      : DWORD;
    dmPanningWidth  : DWORD;
    dmPanningHeight : DWORD;
  end;

  TDevModeW         = TDeviceModeW;  {compatibility with Delphi 1.0}

  function CreateDesktopW(lpszDesktop, lpszDevice: PWideChar; pDevmode: PDeviceModeW;
      dwFlags: DWORD; dwDesiredAccess: DWORD; lpsa: PSecurityAttributes): HDESK; stdcall; external user32 name 'CreateDesktopW';
  function OpenDesktopW(lpszDesktop: PWideChar; dwFlags: DWORD; fInherit: BOOL; dwDesiredAccess: DWORD): HDESK; stdcall; external user32 name 'OpenDesktopW';
  function EnumDesktopsW(hwinsta: HWINSTA; lpEnumFunc: TFNDeskTopEnumProc; lParam: LPARAM): BOOL; stdcall; external user32 name 'EnumDesktopsW';

  function SystemParametersInfoW(uiAction, uiParam: UINT; pvParam: Pointer; fWinIni: UINT): BOOL; stdcall; external user32 name 'SystemParametersInfoW';
  
type
  TwDLLUser32       = record    
    Handle          : HModule;
  end;

  function ChangeDisplaySettingsW(var lpDevMode: TDeviceModeW; dwFlags: DWORD): Longint; stdcall; external user32 name 'ChangeDisplaySettingsW';
  function ChangeDisplaySettingsExW(lpszDeviceName: PWideChar; var lpDevMode: TDeviceModeW;
        wnd: HWND; dwFlags: DWORD; lParam: Pointer): Longint; stdcall; external user32 name 'ChangeDisplaySettingsExW';
  function EnumDisplaySettingsW(lpszDeviceName: PWideChar; iModeNum: DWORD;
    var lpDevMode: TDeviceModeW): BOOL; stdcall; external user32 name 'EnumDisplaySettingsW';

type
  PDisplayDeviceW = ^TDisplayDeviceW;
  TDisplayDeviceW = packed record
    cb: DWORD;
    DeviceName: array[0..31] of WideChar;
    DeviceString: array[0..127] of WideChar;
    StateFlags: DWORD;
  end;

  function EnumDisplayDevicesW(Unused: Pointer; iDevNum: DWORD;
    var lpDisplayDevice: TDisplayDeviceW; dwFlags: DWORD): BOOL; stdcall; external user32 name 'EnumDisplayDevicesW';

  function LoadCursorW(hInstance: HINST; lpCursorName: PWideChar): HCURSOR; stdcall; external user32 name 'LoadCursorW';
  function LoadCursorFromFileW(lpFileName: PWideChar): HCURSOR; stdcall; external user32 name 'LoadCursorFromFileW';

  function LoadIconW(hInstance: HINST; lpIconName: PWideChar): HICON; stdcall; external user32 name 'LoadIconW';

  function GetAltTabInfoW(hwnd: HWND; iItem: Integer; var pati: TAltTabInfo;
    pszItemText: PWideChar; cchItemText: UINT): BOOL; stdcall; external user32 name 'GetAltTabInfoW';
  

implementation

end.
