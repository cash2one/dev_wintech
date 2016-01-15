unit dll_imm32_w;

interface

uses
  atmcmbaseconst, winconst, wintype, dll_imm32;

function ImmInstallIMEW(lpszIMEFileName, lpszLayoutText: PWideChar): HKL; stdcall; external imm32 name 'ImmInstallIMEW';
function ImmGetDescriptionW(hKl: HKL; AChar: PWideChar; uBufLen: UINT): UINT; stdcall; external imm32 name 'ImmGetDescriptionW';
function ImmGetIMEFileNameW(hKl: HKL; AChar: PWideChar; uBufLen: UINT): UINT; stdcall; external imm32 name 'ImmGetIMEFileNameW';

function ImmGetCompositionStrW(hImc: HIMC; dWord1: DWORD; lpBuf: pointer; dwBufLen: DWORD): Longint; stdcall;
    external imm32 name 'ImmGetCompositionStringW';

function ImmSetCompositionStrW(hImc: HIMC; dwIndex: DWORD; lpComp: pointer; dwCompLen: DWORD;
    lpRead: pointer; dwReadLen: DWORD):Boolean; stdcall; external imm32 name 'ImmSetCompositionStringW';
function ImmGetCandidateListCountW(hImc: HIMC; var ListCount: DWORD): DWORD; stdcall; external imm32 name 'ImmGetCandidateListCountW';
function ImmGetCandidateListW(hImc: HIMC; deIndex: DWORD; lpCandidateList: PCANDIDATELIST;
    dwBufLen: DWORD): DWORD; stdcall; external imm32 name 'ImmGetCandidateListW';
function ImmGetGuideLineW(hImc: HIMC; dwIndex: DWORD; lpBuf: PWideChar; dwBufLen: DWORD): DWORD; stdcall; external imm32 name 'ImmGetGuideLineW';

function ImmGetCompositionFontW(hImc: HIMC; lpLogfont: PLOGFONTW): Boolean; stdcall; external imm32 name 'ImmGetCompositionFontW';
function ImmSetCompositionFontW(hImc: HIMC; lpLogfont: PLOGFONTW): Boolean; stdcall; external imm32 name 'ImmSetCompositionFontW';
function ImmConfigureIMEW(hKl: HKL; hWnd: HWND; dwMode: DWORD; lpData: pointer): Boolean; stdcall; external imm32 name 'ImmConfigureIMEW';
function ImmEscapeW(hKl: HKL; hImc: HIMC; uEscape: UINT; lpData: pointer): LRESULT; stdcall; external imm32 name 'ImmEscapeW';
function ImmGetConversionListW(hKl: HKL; hImc: HIMC; lpSrc: PWideChar; lpDst: PCANDIDATELIST;
    dwBufLen: DWORD; uFlag: UINT ): DWORD; stdcall; external imm32 name 'ImmGetConversionListW';

function ImmIsUIMessageW(hWnd: HWND; msg: UINT; wParam: WPARAM; lParam: LPARAM): Boolean; stdcall; external imm32 name 'ImmIsUIMessageW';
function ImmRegisterWordW(hKl: HKL; lpszReading: PWideChar; dwStyle: DWORD; lpszRegister: PWideChar): Boolean; stdcall; external imm32 name 'ImmRegisterWordW';
function ImmUnregisterWordW(hKl: HKL; lpszReading: PWideChar; dwStyle: DWORD; lpszUnregister: PWideChar): Boolean; stdcall; external imm32 name 'ImmUnregisterWordW';
function ImmGetRegisterWordStyleW(hKl: HKL; nItem: UINT; lpStyleBuf: PSTYLEBUF): UINT; stdcall; external imm32 name 'ImmGetRegisterWordStyleW';

type
  RegisterWordEnumProcA = Function(lpReading: PWideChar; dwStyle: DWORD; lpszStr: PWideChar; lpData: pointer): integer;
  RegisterWordEnumProc = RegisterWordEnumProcA;

function ImmEnumRegisterWordW(hKl: HKL; lpfnEnumProc: REGISTERWORDENUMPROC; lpszReading: PWideChar;
    dwStyle: DWORD; lpszRegister: PWideChar; lpData : pointer): UINT; stdcall; external imm32 name 'ImmEnumRegisterWordW';

implementation

end.
