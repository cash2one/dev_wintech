(*
          1    0 0000BCAC AppCleanup
          2    1 00001E3B capCreateCaptureWindowA
          3    2 00001DEB capCreateCaptureWindowW
          4    3 00001B0F capGetDriverDescriptionA
          5    4 00001B06 capGetDriverDescriptionW
          6    5 0000C3A5 videoThunk32
*)

unit dllavicap32;

interface

const
  WM_CAP_START            = WM_USER;
  WM_CAP_SET_CALLBACK_ERROR   = WM_CAP_START + 2;
  WM_CAP_SET_CALLBACK_STATUSA = WM_CAP_START + 3;
  WM_CAP_SET_CALLBACK_FRAME   = WM_CAP_START + 5;
  WM_CAP_SET_CALLBACK_VIDEOSTREAM = WM_CAP_START + 6;

  WM_CAP_DRIVER_CONNECT   = WM_CAP_START + 10;
  WM_CAP_DRIVER_DISCONNECT= WM_CAP_START + 11;

  WM_CAP_FILE_SET_CAPTURE_FILEA = WM_CAP_START + 20;
  WM_CAP_SAVEDIB          = WM_CAP_START + 25;

  WM_CAP_SET_PREVIEW      = WM_CAP_START + 50;
  WM_CAP_SET_OVERLAY      = WM_CAP_START + 51;
  WM_CAP_SET_PREVIEWRATE  = WM_CAP_START + 52;
  WM_CAP_SET_SCALE        = WM_CAP_START + 53;
  WM_CAP_GRAB_FRAME       = WM_CAP_START + 60;
  WM_CAP_SEQUENCE         = WM_CAP_START + 62;
  WM_CAP_SEQUENCE_NOFILE  = WM_CAP_START + 63 ;
  WM_CAP_STOP             = WM_CAP_START + 68;
  avicap32 = 'avicap32.dll';
  
  function capCreateCaptureWindowA(
      lpszWindowName: PAnsiCHAR;
      dwStyle: DWORD; // WS_CHILD or WS_VISIBLE
      x: integer; y: integer; nWidth: integer; nHeight: integer;
      ParentWin : HWND;
      nId : integer): HWND; stdcall external avicap32;
        
implementation

(*
开启
SendMessage(hWndC, WM_CAP_SET_CALLBACK_VIDEOSTREAM, 0, 0);
SendMessage(hWndC, WM_CAP_SET_CALLBACK_ERROR, 0, 0);
SendMessage(hWndC, WM_CAP_SET_CALLBACK_STATUSA, 0, 0);
SendMessage(hWndC, WM_CAP_DRIVER_CONNECT, 0, 0);
SendMessage(hWndC, WM_CAP_SET_SCALE, 1, 0);
SendMessage(hWndC, WM_CAP_SET_PREVIEWRATE, 66, 0);
//SendMessage(hWndC, WM_CAP_SEQUENCE_NOFILE, 1, 0);
SendMessage(hWndC, WM_CAP_SET_OVERLAY, 1, 0);
SendMessage(hWndC, WM_CAP_SET_PREVIEW, 1, 0);

关闭
SendMessage(hWndC, WM_CAP_DRIVER_DISCONNECT, 0, 0);

保存为BMP图像
SendMessage(hWndC,WM_CAP_SAVEDIB,0,longint(pchar(c:\test.bmp)));

开始录像
SendMessage(hWndC,WM_CAP_FILE_SET_CAPTURE_FILEA,0, Longint(pchar(c:\test.avi)));
SendMessage(hWndC, WM_CAP_SEQUENCE, 0, 0);
*)

end.          
