{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_dc;

interface 
                         
uses
  atmcmbaseconst, winconst, wintype;

const
  { 3D border styles }
  BDR_RAISEDOUTER = 1;
  BDR_SUNKENOUTER = 2;
  BDR_RAISEDINNER = 4;
  BDR_SUNKENINNER = 8;

  BDR_OUTER = 3;
  BDR_INNER = 12;
  BDR_RAISED = 5;
  BDR_SUNKEN = 10;
                        
  { Border flags }
  BF_LEFT = 1;
  BF_TOP = 2;
  BF_RIGHT = 4;
  BF_BOTTOM = 8;

  BF_TOPLEFT = (BF_TOP or BF_LEFT);
  BF_TOPRIGHT = (BF_TOP or BF_RIGHT);
  BF_BOTTOMLEFT = (BF_BOTTOM or BF_LEFT);
  BF_BOTTOMRIGHT = (BF_BOTTOM or BF_RIGHT);
  BF_RECT = (BF_LEFT or BF_TOP or BF_RIGHT or BF_BOTTOM);

  BF_DIAGONAL = $10;

  function FrameRect(ADC: HDC; const lprc: TRect; hbr: HBRUSH): Integer; stdcall; external user32 name 'FrameRect';
  function FillRect(ADC: HDC; const lprc: TRect; hbr: HBRUSH): Integer; stdcall; external user32 name 'FillRect';
  function GetWindowDC(AWnd: HWND): HDC; stdcall; external user32 name 'GetWindowDC';
  function GetDC(AWnd: HWND): HDC; stdcall; external user32 name 'GetDC';

  (*
    DC := GetDCEx(Handle, 0, DCX_CACHE or DCX_WINDOW or DCX_CLIPSIBLINGS or DCX_CLIPCHILDREN);
  *)
  function GetDCEx(AWnd: HWND; hrgnClip: HRGN; flags: DWORD): HDC; stdcall; external user32 name 'GetDCEx';

  function WindowFromDC(ADC: HDC): HWND; stdcall; external user32 name 'WindowFromDC';
 
  function ReleaseDC(AWnd: HWND; ADC: HDC): Integer; stdcall; external user32 name 'ReleaseDC';
  function BeginPaint(AWnd: HWND; var lpPaint: TPaintStruct): HDC; stdcall; external user32 name 'BeginPaint';
  function EndPaint(AWnd: HWND; const lpPaint: TPaintStruct): BOOL; stdcall; external user32 name 'EndPaint';
  function UpdateLayeredWindow(Handle: THandle; hdcDest: HDC; pptDst: PPoint; _psize: PSize;
    hdcSrc: HDC; pptSrc: PPoint; crKey: COLORREF; pblend: PBLENDFUNCTION; dwFlags: DWORD): Boolean; stdcall; external user32 name 'UpdateLayeredWindow';
  function DrawEdge(Adc: HDC; var qrc: TRect; edge: UINT; grfFlags: UINT): BOOL; stdcall; external user32 name 'DrawEdge';
  function DrawIcon(ADC: HDC; X, Y: Integer; hIcon: HICON): BOOL; stdcall; external user32 name 'DrawIcon';
  function DrawIconEx(Adc: HDC; xLeft, yTop: Integer; hIcon: HICON; cxWidth, cyWidth: Integer; istepIfAniCur: UINT;
      hbrFlickerFreeDraw: HBRUSH; diFlags: UINT): BOOL; stdcall; external user32 name 'DrawIconEx';

  function ExcludeUpdateRgn(ADC: HDC; hWnd: HWND): Integer; stdcall; external user32 name 'ExcludeUpdateRgn';

const
  { flags for DrawFrameControl }
  DFC_CAPTION = 1;
  DFC_MENU = 2;
  DFC_SCROLL = 3;
  DFC_BUTTON = 4;
  DFC_POPUPMENU = 5;

  DFCS_CAPTIONCLOSE = 0;
  DFCS_CAPTIONMIN = 1;
  DFCS_CAPTIONMAX = 2;
  DFCS_CAPTIONRESTORE = 3;
  DFCS_CAPTIONHELP = 4;

  DFCS_MENUARROW = 0;
  DFCS_MENUCHECK = 1;
  DFCS_MENUBULLET = 2;
  DFCS_MENUARROWRIGHT = 4;

  DFCS_SCROLLUP = 0;
  DFCS_SCROLLDOWN = 1;
  DFCS_SCROLLLEFT = 2;
  DFCS_SCROLLRIGHT = 3;
  DFCS_SCROLLCOMBOBOX = 5;
  DFCS_SCROLLSIZEGRIP = 8;
  DFCS_SCROLLSIZEGRIPRIGHT = $10;

  DFCS_BUTTONCHECK = 0;
  DFCS_BUTTONRADIOIMAGE = 1;
  DFCS_BUTTONRADIOMASK = 2;
  DFCS_BUTTONRADIO = 4;
  DFCS_BUTTON3STATE = 8;
  DFCS_BUTTONPUSH = $10;

  DFCS_INACTIVE = $100;
  DFCS_PUSHED = $200;
  DFCS_CHECKED = $400;
  DFCS_TRANSPARENT = $800;
  DFCS_HOT = $1000;
  DFCS_ADJUSTRECT = $2000;
  DFCS_FLAT = $4000;
  DFCS_MONO = $8000;

  function DrawFrameControl(ADC: HDC; const Rect: TRect; uType, uState: UINT): BOOL; stdcall; external user32 name 'DrawFrameControl';

  function PaintDesktop(Adc: HDC): BOOL; stdcall; external user32 name 'PaintDesktop';

  function DrawTextA(ADC: HDC; lpStr: PAnsiChar; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer; external user32 name 'DrawTextA';
  function DrawTextW(ADC: HDC; lpStr: PWideChar; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer; external user32 name 'DrawTextW';

implementation

end.