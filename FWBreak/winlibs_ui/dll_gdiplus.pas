{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdiplus;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype;

const
  gdiplus = 'gdiplus.dll';

type
  TGPStatus = (
    gpOk,
    gpGenericError,
    gpInvalidParameter,
    gpOutOfMemory,
    gpObjectBusy,
    gpInsufficientBuffer,
    gpNotImplemented,
    gpWin32Error,
    gpWrongState,
    gpAborted,
    gpFileNotFound,
    gpValueOverflow,
    gpAccessDenied,
    gpUnknownImageFormat,
    gpFontFamilyNotFound,
    gpFontStyleNotFound,
    gpNotTrueTypeFont,
    gpUnsupportedGdiplusVersion,
    gpNotInitialized,
    gpPropertyNotFound,
    gpPropertyNotSupported,
    gpProfileNotFound
  );
                 
  PARGB                 = ^DWORD;
  ARGB                  = DWORD;
  TGpGraphics           = Pointer;
  TGpImage              = Pointer;
  TGpBrush              = Pointer;
  TGpBitmap             = Pointer;
  TGpFontFamily         = Pointer;
  TGpFont               = Pointer;
  TGpStrFormat          = Pointer;
  TGpCachedBitmap       = Pointer;
  TGpMatrix             = Pointer;
  TGpPath               = Pointer;
  TGpRegion             = Pointer;
  TGpPathIterator       = Pointer;
  TGpImageAttributes    = Pointer;
  TGpTexture            = Pointer;
  TGpSolidFill          = Pointer;
  TGpLineGradient       = Pointer;
  TGpPathGradient       = Pointer;
  TGpHatch              = Pointer;
  TGpFontCollection     = Pointer;
  TGpPen                = Pointer;
  TGpCustomLineCap      = Pointer;
  TGpAdjustableArrowCap = Pointer;   
  TGpStringFormat       = Pointer;
                             
  PGPColor              = ^TGPColor;
  TGPColor              = 0..$FFFFFFFF;
  TGPPixelFormat        = Integer;
               
  TGPFlushIntention     = (
    FlushIntentionFlush,  // Flush all batched rendering operations
    FlushIntentionSync    // Flush all batched rendering operations and wait for them to complete
  );
                      
  TGPMatrixOrder        = (
    MatrixOrderPrepend,
    MatrixOrderAppend
  );
                     
  PGPPointF             = ^TGPPointF;
  TGPPointF             = packed record
    X                   : Single;
    Y                   : Single;
  end;
            
  PGPPoint              = ^TGPPoint;
  TGPPoint              = packed record
    X                   : Integer;
    Y                   : Integer;
  end;
  
  PGPRect               = ^TGPRect;
  TGPRect               = packed record
    X                   : Integer;
    Y                   : Integer;
    Width               : Integer;
    Height              : Integer;
  end;

  PGPRectF              = ^TGPRectF;
  TGPRectF              = packed record
    X                   : Single;
    Y                   : Single;
    Width               : Single;
    Height              : Single;
  end;

  PGPSize               = ^TGPSize;
  TGPSize               = packed record
    Width               : Integer;
    Height              : Integer;
  end;
         
  PGPSizeF              = ^TGPSizeF;
  TGPSizeF              = packed record
    Width               : Single;
    Height              : Single;
  end;
          
  TGPUnit               = (
    UnitWorld,      // 0 -- World coordinate (non-physical unit)
    UnitDisplay,    // 1 -- Variable -- for PageTransform only
    UnitPixel,      // 2 -- Each unit is one device pixel.
    UnitPoint,      // 3 -- Each unit is a printer's point, or 1/72 inch.
    UnitInch,       // 4 -- Each unit is 1 inch.
    UnitDocument,   // 5 -- Each unit is 1/300 inch.
    UnitMillimeter  // 6 -- Each unit is 1 millimeter.
  );
                            
  TGPWrapMode           = (
    WrapModeTile,        // 0
    WrapModeTileFlipX,   // 1
    WrapModeTileFlipY,   // 2
    WrapModeTileFlipXY,  // 3
    WrapModeClamp        // 4
  );
                   
  TGPFillMode           = (
    FillModeAlternate,        // 0
    FillModeWinding           // 1
  );
           
  TGPDebugEventLevel    = (
    DebugEventLevelFatal,
    DebugEventLevelWarning
  );
                
  TGPDebugEventProc         = procedure(level: TGPDebugEventLevel; message: PAnsiChar); stdcall;   
  TGPNotifyHookProc         = function(out token: ULONG): TGPStatus; stdcall;
  TGPNotifyUnhookProc       = procedure(token: ULONG); stdcall;
                                           
  PGPStartInput             = ^TGPStartInput;   
  PGPStartOutput            = ^TGPStartOutput;
  
  TGPStartInput             = packed record
    Version                 : Cardinal;       // Must be 1
    DebugEventCallback      : TGPDebugEventProc; // Ignored on free builds
    SuppressBackgroundThread: BOOL;           // FALSE unless you're prepared to call
                                              // the hook/unhook functions properly
    SuppressExternalCodecs  : BOOL;           // FALSE unless you want GDI+ only to use
  end;
                                    // its internal image codecs.
  TGPStartOutput            = packed record
    NotifyHook              : TGPNotifyHookProc;
    NotifyUnhook            : TGPNotifyUnhookProc;
  end;
          
  function GdiplusStartup(out token: ULONG; input: PGPStartInput; output: PGPStartOutput): TGPStatus; stdcall; external gdiplus;
  // 清理由Microsoft Windows GDI+使用过的资源
  // 每次调用GdiplusStartup函数都要对应的使用一次该函数来完成清理工作
  // 必须在使用该函数之前删除所有的GDI+的对象
  procedure GdiplusShutdown(token: ULONG); stdcall; external gdiplus;
  function GdipAlloc(size: ULONG): pointer; stdcall; external gdiplus;
  procedure GdipFree(ptr: pointer); stdcall; external gdiplus;

implementation

end.
