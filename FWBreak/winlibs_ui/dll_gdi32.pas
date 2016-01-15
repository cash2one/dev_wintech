{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdi32;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype;

const
  CCHDEVICENAME       = 32;     { size of a device name string  }    
  CCHFORMNAME         = 32;     { size of a form name string  }    
                            
  { Ternary raster operations }
  SRCCOPY             = $00CC0020;     { dest = source                    }
  SRCPAINT            = $00EE0086;     { dest = source OR dest            }
  SRCAND              = $008800C6;     { dest = source AND dest           }
  SRCINVERT           = $00660046;     { dest = source XOR dest           }
  SRCERASE            = $00440328;     { dest = source AND (NOT dest )    }

  NOTSRCCOPY          = $00330008;     { dest = (NOT source)              }
  NOTSRCERASE         = $001100A6;     { dest = (NOT src) AND (NOT dest)  }
  
  MERGECOPY           = $00C000CA;     { dest = (source AND pattern)      }
  MERGEPAINT          = $00BB0226;     { dest = (NOT source) OR dest      }

  PATCOPY             = $00F00021;     { dest = pattern                   }
  PATPAINT            = $00FB0A09;     { dest = DPSnoo                    }
  PATINVERT           = $005A0049;     { dest = pattern XOR dest          }

  // Inverts the destination rectangle
  DSTINVERT           = $00550009;     { dest = (NOT dest)                }
  
  BLACKNESS           = $00000042;     { dest = BLACK                     }
  WHITENESS           = $00FF0062;     { dest = WHITE                     }

  (* copy Screen                        
  BitBlt(bmp.Canvas.Handle,Left, Top, Width, Height, GetDC(0), Left, Top, SRCCOPY or CAPTUREBLT); //*)
  CAPTUREBLT          = $40000000;
  (*
  http://blog.163.com/xmh_2006/blog/static/2495631720089635810420/

  位图是windows图形编程中非常重要的一个方面。在进行普通的位图操作中，如GDI函数BitBlt，StretchBlt, StretchDIBits，
  都会用到一个光栅操作码，即ROP码，像SRCCOPY，PATPAINT，SRCAND等，由于最近在开发图形驱动，涉及了许多的ROP2，
  ROP3和ROP4码的操作
  ---------------------------------------------------------------
  二元光栅操作：我们在使用GDI画线和填充区域时，GDI使用二元光栅操作码ROP2组合画笔或画刷像素和目标像素以得到
  新的目标像素。如SetROP2函数和GetROP2函数支持16种二元光栅操作，如：(具体见wingdi.h)
  #define R2_NOT              6   // Dn
  #define R2_XORPEN           7   // DPx
  ---------------------------------------------------------------
  三元光栅操作：对于图像有同样的光栅操作用于生成各种特殊效果，我们要处理的有三种像素，源图像像素、目标图像
  像素和画刷像素（模板图像像素），称之为三元光栅操作，使用的是ROP3码，如：(更多的参见wingdi.h)
  #define SRCPAINT (DWORD)0x00EE0086 // dest = source OR dest
  #define SRCAND   (DWORD)0x008800C6 // dest = source AND dest
  ---------------------------------------------------------------
  四元光栅操作：是混合了源图像像素，目标图像像素和模板画刷像素外，又增加了一个掩码位图，用到4个变量形成了
  四元光栅操作，相应的为ROP4码，GDI函数中MaskBlt函数使用的是ROP4码，也是唯一接受四元光栅操作的API函数
  ---------------------------------------------------------------
  光栅操作的编码：
  一个字节可以编码256种光栅操作，假定P为画笔或画刷的位，S为源图像的位，D为目标图像的位。如果操作的结果和P
  一样，编码为0xF0，如果操作的结果和S一样，编码为0xCC，如果操作的结果和D一样，编码为0xAA。
  Const BYTE rop_P  =0xF0; // 1 1 1 1 0 0 0 0
  Const BYTE rop_S  =0xCC; // 1 1 0 0 1 1 0 0
  Const BYTE rop_D  =0xAA; // 1 0 1 0 1 0 1 0       
  *)
  // Prevents the bitmap from being mirrored
  NOMIRRORBITMAP      = $80000000;

  { constants for the biCompression field }
  BI_RGB = 0;
  BI_RLE8 = 1;
  BI_RLE4 = 2;
  BI_BITFIELDS = 3;

type                      
  PBitmapInfoHeader   = ^TBitmapInfoHeader;
  TBitmapInfoHeader   = packed record
    biSize            : DWORD;
    biWidth           : Longint;
    biHeight          : Longint;
    biPlanes          : Word;
    biBitCount        : Word;
    biCompression     : DWORD;
    biSizeImage       : DWORD;
    biXPelsPerMeter   : Longint;
    biYPelsPerMeter   : Longint;
    biClrUsed         : DWORD;
    biClrImportant    : DWORD;
  end;

{ Bitmap Header Definition }
  PBitmap             = ^TBitmap;
  TBitmap             = packed record
    bmType            : Longint;
    bmWidth           : Longint;
    bmHeight          : Longint;
    bmWidthBytes      : Longint;
    bmPlanes          : Word;
    bmBitsPixel       : Word;
    bmBits            : Pointer;
  end;

  PRGBTriple          = ^TRGBTriple;
  TRGBTriple          = packed record
    rgbtBlue          : Byte;
    rgbtGreen         : Byte;
    rgbtRed           : Byte;
  end;

  PRGBQuad            = ^TRGBQuad;
  TRGBQuad            = packed record
    rgbBlue           : Byte;
    rgbGreen          : Byte;
    rgbRed            : Byte;
    rgbReserved       : Byte;
  end;

  PBitmapInfo         = ^TBitmapInfo;
  TBitmapInfo         = packed record
    bmiHeader         : TBitmapInfoHeader;
    bmiColors         : array[0..0] of TRGBQuad;
  end;
                                      
  PDeviceModeA        = ^TDeviceModeA;
  TDeviceModeA        = packed record
    dmDeviceName      : array[0..CCHDEVICENAME - 1] of AnsiChar;
    dmSpecVersion     : Word;
    dmDriverVersion   : Word;
    dmSize            : Word;
    dmDriverExtra     : Word;
    dmFields          : DWORD;
    dmOrientation     : SHORT;
    dmPaperSize       : SHORT;
    dmPaperLength     : SHORT;
    dmPaperWidth      : SHORT;
    dmScale           : SHORT;
    dmCopies          : SHORT;
    dmDefaultSource   : SHORT;
    dmPrintQuality    : SHORT;
    dmColor           : SHORT;
    dmDuplex          : SHORT;
    dmYResolution     : SHORT;
    dmTTOption        : SHORT;
    dmCollate         : SHORT;
    dmFormName        : array[0..CCHFORMNAME - 1] of AnsiChar;
    dmLogPixels       : Word;
    dmBitsPerPel      : DWORD;
    dmPelsWidth       : DWORD;
    dmPelsHeight      : DWORD;
    dmDisplayFlags    : DWORD;
    dmDisplayFrequency: DWORD;
    dmICMMethod       : DWORD;
    dmICMIntent       : DWORD;
    dmMediaType       : DWORD;
    dmDitherType      : DWORD;
    dmICCManufacturer : DWORD;
    dmICCModel        : DWORD;
    dmPanningWidth    : DWORD;
    dmPanningHeight   : DWORD;
  end;

  PDeviceModeW        = ^TDeviceModeW;
  TDeviceModeW        = record
    dmDeviceName      : array[0..CCHDEVICENAME - 1] of WideChar;
    dmSpecVersion     : Word;
    dmDriverVersion   : Word;
    dmSize            : Word;
    dmDriverExtra     : Word;
    dmFields          : DWORD;
    dmOrientation     : SHORT;
    dmPaperSize       : SHORT;
    dmPaperLength     : SHORT;
    dmPaperWidth      : SHORT;
    dmScale           : SHORT;
    dmCopies          : SHORT;
    dmDefaultSource   : SHORT;
    dmPrintQuality    : SHORT;
    dmColor           : SHORT;
    dmDuplex          : SHORT;
    dmYResolution     : SHORT;
    dmTTOption        : SHORT;
    dmCollate         : SHORT;
    dmFormName        : array[0..CCHFORMNAME - 1] of WideChar;
    dmLogPixels       : Word;
    dmBitsPerPel      : DWORD;
    dmPelsWidth       : DWORD;
    dmPelsHeight      : DWORD;
    dmDisplayFlags    : DWORD;
    dmDisplayFrequency: DWORD;
    dmICMMethod       : DWORD;
    dmICMIntent       : DWORD;
    dmMediaType       : DWORD;
    dmDitherType      : DWORD;
    dmICCManufacturer : DWORD;
    dmICCModel        : DWORD;
    dmPanningWidth    : DWORD;
    dmPanningHeight   : DWORD;
  end;

//  PDevMode            = PDeviceMode;  {compatibility with Delphi 1.0}
//  TDevMode            = TDeviceMode;  {compatibility with Delphi 1.0}

  PPixelFormatDescriptor = ^TPixelFormatDescriptor;
  TPixelFormatDescriptor = packed record
    nSize             : Word;
    nVersion          : Word;
    dwFlags           : DWORD;
    iPixelType        : Byte;
    cColorBits        : Byte;
    cRedBits          : Byte;
    cRedShift         : Byte;
    cGreenBits        : Byte;
    cGreenShift       : Byte;
    cBlueBits         : Byte;
    cBlueShift        : Byte;
    cAlphaBits        : Byte;
    cAlphaShift       : Byte;
    cAccumBits        : Byte;
    cAccumRedBits     : Byte;
    cAccumGreenBits   : Byte;
    cAccumBlueBits    : Byte;
    cAccumAlphaBits   : Byte;
    cDepthBits        : Byte;
    cStencilBits      : Byte;
    cAuxBuffers       : Byte;
    iLayerType        : Byte;
    bReserved         : Byte;
    dwLayerMask       : DWORD;
    dwVisibleMask     : DWORD;
    dwDamageMask      : DWORD;
  end;
                                           
  PXForm              = ^TXForm;
  TXForm              = packed record
    eM11              : Single;
    eM12              : Single;
    eM21              : Single;
    eM22              : Single;
    eDx               : Single;
    eDy               : Single;
  end;

  function SelectObject(ADC: HDC; p2: HGDIOBJ): HGDIOBJ; stdcall; external gdi32 name 'SelectObject';
  function DeleteObject(p1: HGDIOBJ): BOOL; stdcall; external gdi32 name 'DeleteObject';
  
  function MoveToEx(ADC: HDC; p2, p3: Integer; p4: PPoint): BOOL; stdcall; external gdi32 name 'MoveToEx';
  function LineTo(ADC: HDC; X, Y: Integer): BOOL; stdcall; external gdi32 name 'LineTo';
  function Pie(ADC: HDC; X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer): BOOL; stdcall; external gdi32 name 'Pie';
  function Rectangle(ADC: HDC; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external gdi32 name 'Rectangle';
  
const
  { Background Modes }
  TRANSPARENT = 1;
  OPAQUE = 2;
  BKMODE_LAST = 2;

  function SetBkMode(ADC: HDC; BkMode: Integer): Integer; stdcall; external gdi32 name 'SetBkMode';

  function RoundRect(ADC: HDC; X1, Y1, X2, Y2, X3, Y3: Integer): BOOL; stdcall; external gdi32 name 'RoundRect';

  function AngleArc(ADC: HDC; p2, p3: Integer; p4: DWORD; p5, p6: Single): BOOL; stdcall; external gdi32 name 'AngleArc';
  function Arc(ADC: HDC; left, top, right, bottom, startX, startY, endX, endY: Integer): BOOL; stdcall; external gdi32 name 'Arc';
  function ArcTo(ADC: HDC; RLeft, RTop, RRight, RBottom: Integer; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external gdi32 name 'ArcTo';

  function BeginPath(ADC: HDC): BOOL; stdcall; external gdi32 name 'BeginPath';
  function CloseFigure(ADC: HDC): BOOL; stdcall; external gdi32 name 'CloseFigure';
  function EndPath(ADC: HDC): BOOL; stdcall; external gdi32 name 'EndPath';
  function FillPath(ADC: HDC): BOOL; stdcall; external gdi32 name 'FillPath';

  function StartPage(ADC: HDC): Integer; stdcall; external gdi32 name 'StartPage';
  function EndPage(ADC: HDC): Integer; stdcall; external gdi32 name 'EndPage';

  function Chord(ADC: HDC; X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer): BOOL; stdcall; external gdi32 name 'Chord';
  function Ellipse(ADC: HDC; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external gdi32 name 'Ellipse';
  function Polygon(ADC: HDC; var Points; Count: Integer): BOOL; stdcall; external gdi32 name 'Polygon';
  function Polyline(ADC: HDC; var Points; Count: Integer): BOOL; stdcall; external gdi32 name 'Polyline';
  function PolyBezier(ADC: HDC; const Points; Count: DWORD): BOOL; stdcall; external gdi32 name 'PolyBezier';
  function PolyBezierTo(ADC: HDC; const Points; Count: DWORD): BOOL; stdcall; external gdi32 name 'PolyBezierTo';

  // CreateDIBSection创建的是一个DIBSECTION结构，而CreateDIBitmap创建的是BITMAP结构
  {
  CreateDIBitmap The DDB that is created will be whatever bit depth your reference DC is.
  CreateDIBSection To create a bitmap that is of different bit depth
  首先要搞明白DIB和DDB的区别，对于DDB到DIB的转换，只要加上一个位图信息头就是了；但是从DIB到DDB的转换，
  要根据当前DC的位图格式（多少位色彩），可能要扩展也可能要减少色彩位数，如果你考虑这个因素，可以认为是由速度的损失。
  因此GDI下DDB作图肯定是最快的，直接拷贝位图数据到显存即可

  使用CreateDIBSection()容易控制,因为你构造的BITMAPINFO是多少bit就按多少bit来操作它的位数据.
  而CreateDIBitmap(), create出来的是DDB,是和屏幕色深相同的,在这台机它可能是16Bit的,而在那台
  机器它可能是24bit或者是32bit,明显不利于代码操控/维护
  }
  
const
  DIB_RGB_COLORS = 0;     { color table in RGBs  }
  DIB_PAL_COLORS = 1;     { color table in palette indices  }

  function CreateDIBSection(ADC: HDC; const p2: TBitmapInfo; p3: UINT;
      var p4: Pointer; p5: THandle; p6: DWORD): HBITMAP; stdcall; external gdi32 name 'CreateDIBSection';

  { dwUsage =
        CBM_INIT  此函数使用此信息息头结构来获取位图所需的宽度、高度以及其他信息
                        系统将使用lpblnit和lpbmi两个参数指向的数据来对位图中的位进行初始化
                        fdwlnit为0，那么系统不会对位图的位进行初始化
    wUsage
        DIB_PAL_COLORS  提供一个颜色表，并且该表由该位图要选入的设备环境的逻辑调色板的16位索引值数组组成
        DIB_RGB_COLORS  提供一个颜色表，并且表中包含了原义的RGB值

    bitinfo.bmiHeader.biSize          = sizeof(BITMAPINFOHEADER);
    bitinfo.bmiHeader.biWidth         = lWidth;
    bitinfo.bmiHeader.biHeight        = lHeight;
    bitinfo.bmiHeader.biPlanes        = 1;
    bitinfo.bmiHeader.biBitCount      = wBitCount;
    bitinfo.bmiHeader.biCompression   = BI_RGB;
    bitinfo.bmiHeader.biSizeImage     = lWidth*lHeight*(wBitCount/8);
    bitinfo.bmiHeader.biXPelsPerMeter = 96;
    bitinfo.bmiHeader.biYPelsPerMeter = 96;
    bitinfo.bmiHeader.biClrUsed       = 0;
    bitinfo.bmiHeader.biClrImportant  = 0;
  }
  function CreateDIBitmap(ADC: HDC; var InfoHeader: TBitmapInfoHeader;
      dwUsage: DWORD; InitBits: PAnsiChar; var InitInfo: TBitmapInfo; wUsage: UINT): HBITMAP; stdcall; external gdi32 name 'CreateDIBitmap';
  { return ERROR_INVALID_BITMAP
    CreateBitmap()要设定大小、图象深度（即每个象素多少位），CreateCompatibleBitmap()则从相关联地DC中获取图象深度
  }
  function CreateBitmap(Width, Height: Integer; Planes, BitCount: Longint; Bits: Pointer): HBITMAP; stdcall; external gdi32 name 'CreateBitmap';
  function CreateBitmapIndirect(const p1: TBitmap): HBITMAP; stdcall; external gdi32 name 'CreateBitmapIndirect';

  { HDC memDC = CreateCompatibleDC ( hDC );
    HBITMAP memBM = CreateCompatibleBitmap ( hDC, nWidth, nHeight );
    SelectObject ( memDC, memBM )
  }
  function CreateCompatibleBitmap(ADC: HDC; Width, Height: Integer): HBITMAP; stdcall; external gdi32 name 'CreateCompatibleBitmap';
  function CreateDiscardableBitmap(ADC: HDC; p2, p3: Integer): HBITMAP; stdcall; external gdi32 name 'CreateDiscardableBitmap';

  function CreateCompatibleDC(ADC: HDC): HDC; stdcall; external gdi32 name 'CreateCompatibleDC';
  function DeleteDC(ADC: HDC): BOOL; stdcall; external gdi32 name 'DeleteDC';

  function CreateDC(lpszDriver, lpszDevice, lpszOutput: PAnsiChar; lpdvmInit: PDeviceModeA): HDC; stdcall; external gdi32 name 'CreateDCA';
  function ResetDC(ADC: HDC; const InitData: TDeviceModeA): HDC; stdcall; external gdi32 name 'ResetDCA';

  // 该函数通过把数据描述选定对象和图形模式
  // （如位图、画笔、调色板、字体、笔、区域、绘图模式、映射模式）拷贝到描述表推栈中为保存，指定设备上下文环境的当前状态
  function SaveDC(ADC: HDC): Integer; stdcall; external gdi32 name 'SaveDC';
  function RestoreDC(ADC: HDC; SavedDC: Integer): BOOL; stdcall; external gdi32 name 'RestoreDC';

  // 该函数的功能是把设备上下文环境中悬而未决的操作取消
  // CancelDc函数一般由多线程应用程序使用，用来取消一个冗长的绘画操作，
  // 如果线程A激活了一个冗长的绘画操作，线程B可以通过调用此函数来取消它
  // 如果一个操作被取消，那么受影响的线程将返回一个错误，并且该绘画操作的结果是不确定的，
  // 如果一个程序中并没有绘画操作，但调用了该函数，其结果也是不确定的
  function CancelDC(ADC: HDC): BOOL; stdcall; external gdi32 name 'CancelDC';

  function BitBlt(DestDC: HDC; X, Y, Width, Height: Integer; SrcDC: HDC;
      XSrc, YSrc: Integer; Rop: DWORD): BOOL; stdcall; external gdi32 name 'BitBlt';
  function GetStretchBltMode(ADC: HDC): Integer; stdcall; external gdi32 name 'GetStretchBltMode';
  function StretchBlt(DestDC: HDC; X, Y, Width, Height: Integer; SrcDC: HDC;
      XSrc, YSrc, SrcWidth, SrcHeight: Integer; Rop: DWORD): BOOL; stdcall; external gdi32 name 'StretchBlt';
  function StretchDIBits(ADC: HDC; DestX, DestY, DestWidth, DestHeight, SrcX,
      SrcY, SrcWidth, SrcHeight: Integer; Bits: Pointer; var BitsInfo: TBitmapInfo;
      Usage: UINT; Rop: DWORD): Integer; stdcall; external gdi32 name 'StretchDIBits';

  {
      设定当前前景色的混合模式。
          R2_NOT  就是取反的意思
      3. R2_NOPPixel remains unchanged.
      4. R2_NOTPixel is the inverse of the screen color. //当前绘制的像素值设为屏幕像素值的反，这样可以覆盖掉上次的绘图，（自动擦除上次绘制的图形）
      5. R2_COPYPENPixel is the pen color. //使用当前的画笔的颜色
      6. R2_NOTCOPYPENPixel is the inverse of the pen color.
      //下面是当前画笔的颜色和屏幕色的组合运算得到的绘图模式。
      7. R2_MERGEPENNOTPixel is a combination of the pen color and the inverse of the screen color (final pixel = (NOT screen pixel) OR pen).
      8. R2_MASKPENNOTPixel is a combination of the colors common to both the pen and the inverse of the screen (final pixel = (NOT screen pixel) AND pen). //R2_COPYPEN和R2_NOT的交集
      9. R2_MERGENOTPENPixel is a combination of the screen color and the inverse of the pen color (final pixel = (NOT pen) OR screen pixel). //R2_NOTCOPYPEN和屏幕像素值的并集
      10. R2_MASKNOTPENPixel is a combination of the colors common to both the screen and the inverse of the pen (final pixel = (NOT pen) AND screen pixel). //R2_NOTCOPYPEN和屏幕像素值的交集
      11. R2_MERGEPENPixel is a combination of the pen color and the screen color (final pixel = pen OR screen pixel). //R2_COPYPEN和屏幕像素值的并集
      12. R2_NOTMERGEPENPixel is the inverse of the R2_MERGEPEN color (final pixel = NOT(pen OR screen pixel)). //R2_MERGEPEN的反色
      13. R2_MASKPENPixel is a combination of the colors common to both the pen and the screen (final pixel = pen AND screen pixel). //R2_COPYPEN和屏幕像素值的交集
      14. R2_NOTMASKPENPixel is the inverse of the R2_MASKPEN color (final pixel = NOT(pen AND screen pixel)). //R2_MASKPEN的反色
      15. R2_XORPENPixel is a combination of the colors that are in the pen or in the screen, but not in both (final pixel = pen XOR screen pixel). //R2_COPYPEN和屏幕像素值的异或
      16. R2_NOTXORPENPixel is the inverse of the R2_XORPEN color (final pixel = NOT(pen XOR screen pixel)). //R2_XORPEN的反色
  }
const
  R2_BLACK       = 1;     {  0   } //所有绘制出来的像素为黑色
  R2_NOTMERGEPEN = 2;     { DPon } //所有绘制出来的像素为白色
  R2_MASKNOTPEN  = 3;     { DPna } //任何绘制将不改变当前的状态
  R2_NOTCOPYPEN  = 4;     { PN   }
  R2_MASKPENNOT  = 5;     { PDna }
  R2_NOT         = 6;     { Dn   } //当前画笔的反色
  R2_XORPEN      = 7;     { DPx  }
  R2_NOTMASKPEN  = 8;     { DPan }
  R2_MASKPEN     = 9;     { DPa  }
  R2_NOTXORPEN   = 10;    { DPxn }
  R2_NOP         = 11;    { D    }
  R2_MERGENOTPEN = 12;    { DPno }
  R2_COPYPEN     = 13;    { P    }
  R2_MERGEPENNOT = 14;    { PDno }
  R2_MERGEPEN    = 15;    { DPo  }
  R2_WHITE       = $10;   {  1   }

  { 橡皮筋绘图程序的使用实例
      // 按下左键移动开始画图
      if (nFlags == MK_LBUTTON)
      {   // 创建画笔RGB(0x00, 0x00, 0xFF)
          HPEN hPen = ::CreatePen(PS_SOLID, m_PenWidth, RGB(0x00, 0x00, 0xFF));
          // 使用画笔
          ::SelectObject(m_hMemDC, hPen);
          //设置系统色彩模式取反色
          int oldRop=::SetROP2(m_hMemDC,R2_NOTXORPEN);
          // 画线
          ::MoveToEx(m_hMemDC,m_pOrigin.x,m_pOrigin.y, NULL);
          ::LineTo(m_hMemDC, m_pPrev.x,m_pPrev.y);
          //恢复系统默认色彩模式
          ::SetROP2(m_hMemDC,oldRop);
          ::MoveToEx(m_hMemDC, m_pOrigin.x, m_pOrigin.y, NULL);
          ::LineTo(m_hMemDC, point.x, point.y);
          m_pPrev = point;
          Invalidate(FALSE);
  }
  function SetROP2(ADC: HDC; p2: Integer): Integer; stdcall; external gdi32 name 'SetROP2';

const
  { StretchBlt() Modes }
  // 使用消除和现在的像素颜色值进行逻辑AND（与）操作运算。如果该位图是单色位图，
  // 那么该模式以牺牲白色像素为代价，保留黑色像素点
  BLACKONWHITE = 1;
  // 使用颜色值进行逻辑OR（或）操作，如果该位图为单色位图，那么该模式以牺牲黑色像素为代价，保留白色像素点
  WHITEONBLACK = 2;
  //删除像素。该模式删除所有消除的像素行，不保留其信息
  COLORONCOLOR = 3;
  // 将源矩形区中的像素映射到目标矩形区的像素块中，覆盖目标像素块的一般颜色与源像素的颜色接近。
  // 在设置完HALFTONE拉伸模之后，应用程序必须调用SetBrushOrgEx函数来设置刷子的起始点。如果没有
  // 成功，那么会出现刷子没对准的情况
  HALFTONE = 4;
  MAXSTRETCHBLTMODE = 4;

  // 该函数可以设置指定设备环境中的位图拉伸模式
  // 如果函数执行成功，那么返回值就是先前的拉伸模式，如果函数执行失败，那么返回值为0
  function SetStretchBltMode(ADC: HDC; StretchMode: Integer): Integer; stdcall; external gdi32 name 'SetStretchBltMode';

  function CheckColorsInGamut(ADC: HDC; var RGBQuads, Results; Count: DWORD): BOOL; stdcall; external gdi32 name 'CheckColorsInGamut';

  function ChoosePixelFormat(ADC: HDC; p2: PPixelFormatDescriptor): Integer; stdcall; external gdi32 name 'ChoosePixelFormat';
  function SetPixelFormat(ADC: HDC; PixelFormat: Integer; FormatDef: PPixelFormatDescriptor): BOOL; stdcall; external gdi32 name 'SetPixelFormat';

  function GetDeviceCaps(ADC: HDC; Index: Integer): Integer; stdcall; external gdi32 name 'GetDeviceCaps';

  //=====================================================================
  function GetViewportExtEx(ADC: HDC; var Size: TSize): BOOL; stdcall; external gdi32 name 'GetViewportExtEx';
  // 取得目前设备和窗口的原点
  function GetViewportOrgEx(ADC: HDC; var Point: TPoint): BOOL; stdcall; external gdi32 name 'GetViewportOrgEx';
  function GetWindowExtEx(ADC: HDC; var Size: TSize): BOOL; stdcall; external gdi32 name 'GetWindowExtEx';
  function GetWindowOrgEx(ADC: HDC; var Point: TPoint): BOOL; stdcall; external gdi32 name 'GetWindowOrgEx';

  function GetWorldTransform(ADC: HDC; var p2: TXForm): BOOL; stdcall; external gdi32 name 'GetWorldTransform';
  function ModifyWorldTransform(ADC: HDC; const p2: TXForm; p3: DWORD): BOOL; stdcall; external gdi32 name 'ModifyWorldTransform';

  // 逻辑点(0,0)将映像为设备点(cxClient/2,cyClient/2)
  function SetViewportOrgEx(ADC: HDC; X, Y: Integer; Point: PPoint): BOOL; stdcall; external gdi32 name 'SetViewportOrgEx';
  function SetViewportExtEx(ADC: HDC; XExt, YExt: Integer; Size: PSize): BOOL; stdcall; external gdi32 name 'SetViewportExtEx';
  function SetWindowOrgEx(ADC: HDC; X, Y: Integer; Point: PPoint): BOOL; stdcall; external gdi32 name 'SetWindowOrgEx';
  function SetWindowExtEx(ADC: HDC; XExt, YExt: Integer; Size: PSize): BOOL; stdcall; external gdi32 name 'SetWindowExtEx';


  function SetWorldTransform(ADC: HDC; const p2: TXForm): BOOL; stdcall; external gdi32 name 'SetWorldTransform';
  function SetBrushOrgEx(ADC: HDC; X, Y: Integer; PrevPt: PPoint): BOOL; stdcall; external gdi32 name 'SetBrushOrgEx';
  //=====================================================================

  function OffsetViewportOrgEx(ADC: HDC; X, Y: Integer; var Points): BOOL; stdcall; overload; external gdi32 name 'OffsetViewportOrgEx';
  function OffsetViewportOrgEx(ADC: HDC; X, Y: Integer; Points: PPoint): BOOL; stdcall; overload; external gdi32 name 'OffsetViewportOrgEx';

  function OffsetWindowOrgEx(ADC: HDC; X, Y: Integer; var Points): BOOL; stdcall; overload; external gdi32 name 'OffsetWindowOrgEx';
  function OffsetWindowOrgEx(ADC: HDC; X, Y: Integer; Points: PPoint): BOOL; stdcall; overload; external gdi32 name 'OffsetWindowOrgEx';
  function ScaleViewportExtEx(ADC: HDC; XM, XD, YM, YD: Integer; Size: PSize): BOOL; stdcall; external gdi32 name 'ScaleViewportExtEx';
  function ScaleWindowExtEx(ADC: HDC; XM, XD, YM, YD: Integer; Size: PSize): BOOL; stdcall; external gdi32 name 'ScaleWindowExtEx';

  function WidenPath(ADC: HDC): BOOL; stdcall; external gdi32 name 'WidenPath';
  function StrokePath(ADC: HDC): BOOL; stdcall; external gdi32 name 'StrokePath';
  function StrokeAndFillPath(ADC: HDC): BOOL; stdcall; external gdi32 name 'StrokeAndFillPath';
  function SelectClipPath(ADC: HDC; Mode: Integer): BOOL; stdcall; external gdi32 name 'SelectClipPath';

  // SwapBuffer每次调用都在GetAPI，而GetAPI先LoadLibrary,再GetProcAddress；
  // 虽然SwapBuffers每次LoadLibrary/FreeLibaray也许只是改变引用计数，但是我
  // 想GetProcAddress总是有开销的，即便有Cache机制也会有开销的。追根溯源，我
  // 又找到了GetProcAdress的source code，发现GetProcAddress是调用LdrGetProcedureAddress，继续追查，LdrGetProcedureAddress：
  // http://www.cnblogs.com/cgwolver/archive/2009/04/01/1427317.html
  // 平均每帧多开销0.5个毫秒。想一下，FPS达到 30帧的时候，每帧可用时间片只有33毫秒，却被它白白浪费的0.5个毫秒
  // 要避免这个问题，最好还是自己去获得 wglSwapBuffers 这个函数
  // 在软模式opengl下，它也会回调os 的 GdiSwapBuffers
  // 其他API的问题也是这样的 ChoosePixelFormat，DescribePixelFormat，GetPixelFormat，SetPixelFormat
  // opengl32.dll
  // 一种解决的方法是，在调用ChoosePixelFormat，DescribePixelFormat，GetPixelFormat，SetPixelFormat这些函数之前，
  // 先调用 LoadLibrary("OpenGL32.dll")；这样就不会频繁的加载卸载dll
  function SwapBuffers(ADC: HDC): BOOL; stdcall; external gdi32 name 'SwapBuffers';
  // wglSwapMultipleBuffers --- an undocumented wgl api

  function CreateBrushIndirect(const p1: TLogBrush): HBRUSH; stdcall; external gdi32 name 'CreateBrushIndirect';
  function CreatePatternBrush(ABitmap: HBITMAP): HBRUSH; stdcall; external gdi32 name 'CreatePatternBrush';
  
type  { Logical Pen }
  PLogPen           = ^TLogPen;
  TLogPen           = packed record
    lopnStyle       : UINT;
    lopnWidth       : TPoint;
    lopnColor       : COLORREF;
  end;
  
const                 
  { Brush Styles }
  BS_SOLID                = 0;
  BS_NULL                 = 1;
  BS_HOLLOW               = BS_NULL;
  BS_HATCHED              = 2;
  BS_PATTERN              = 3;
  BS_INDEXED              = 4;
  BS_DIBPATTERN           = 5;
  BS_DIBPATTERNPT         = 6;
  BS_PATTERN8X8           = 7;
  BS_DIBPATTERN8X8        = 8;
  BS_MONOPATTERN          = 9;
                 
  { Pen Styles }
  PS_SOLID       = 0;
  PS_DASH        = 1;      { ------- }
  PS_DOT         = 2;      { ....... }
  PS_DASHDOT     = 3;      { _._._._ }
  PS_DASHDOTDOT  = 4;      { _.._.._ }
  PS_NULL = 5;
  PS_INSIDEFRAME = 6;
  PS_USERSTYLE = 7;
  PS_ALTERNATE = 8;
  PS_STYLE_MASK = 15;

  PS_ENDCAP_ROUND = 0;
  PS_ENDCAP_SQUARE = $100;
  PS_ENDCAP_FLAT = $200;
  PS_ENDCAP_MASK = 3840;

  PS_JOIN_ROUND = 0;
  PS_JOIN_BEVEL = $1000;
  PS_JOIN_MITER = $2000;
  PS_JOIN_MASK = 61440;

  PS_COSMETIC = 0;
  PS_GEOMETRIC = $10000;
  PS_TYPE_MASK = $F0000;

  function CreatePen(Style, Width: Integer; Color: COLORREF): HPEN; stdcall; external gdi32 name 'CreatePen';
  function CreatePenIndirect(const LogPen: TLogPen): HPEN; stdcall; external gdi32 name 'CreatePenIndirect';

  function PtInRegion(RGN: HRGN; X, Y: Integer): BOOL; stdcall; external gdi32 name 'PtInRegion';
  function PtVisible(ADC: HDC; X, Y: Integer): BOOL; stdcall; external gdi32 name 'PtVisible';


const
  RDH_RECTANGLES = 1;

type
  PRgnDataHeader = ^TRgnDataHeader;
  TRgnDataHeader = packed record
    dwSize: DWORD;
    iType: DWORD;
    nCount: DWORD;
    nRgnSize: DWORD;
    rcBound: TRect;
  end;

  PRgnData = ^TRgnData;
  TRgnData = record
    rdh: TRgnDataHeader;
    Buffer: array[0..0] of AnsiChar;
    Reserved: array[0..2] of AnsiChar;
  end;

  function GetRegionData(ARGN: HRGN; p2: DWORD; p3: PRgnData): DWORD; stdcall; external gdi32 name 'GetRegionData';
  function GetRgnBox(ARGN: HRGN; var p2: TRect): Integer; stdcall; external gdi32 name 'GetRgnBox';

const
  { Object Definitions for EnumObjects() }
  OBJ_PEN         = 1;
  OBJ_BRUSH       = 2;
  OBJ_DC          = 3;
  OBJ_METADC      = 4;
  OBJ_PAL         = 5;
  OBJ_FONT        = 6;
  OBJ_BITMAP      = 7;
  OBJ_REGION      = 8;
  OBJ_METAFILE    = 9;
  OBJ_MEMDC       = 10;
  OBJ_EXTPEN      = 11;
  OBJ_ENHMETADC   = 12;
  OBJ_ENHMETAFILE = 13;

type
  TFNGObjEnumProc = TFarProc;
  
  function GetObjectType(h: HGDIOBJ): DWORD; stdcall; external gdi32 name 'GetObjectType';
  function EnumObjects(ADC: HDC; p2: Integer; p3: TFNGObjEnumProc; p4: LPARAM): Integer; stdcall; external gdi32 name 'EnumObjects';


const // Region identifiers for GetRandomRgn
  CLIPRGN = 1;
  METARGN = 2;
  APIRGN = 3;
  SYSRGN = 4;
  
  function GetRandomRgn(ADC: HDC; Rgn: HRGN; iNum: Integer): Integer; stdcall; external gdi32;
  function OffsetRgn(ARGN: HRGN; XOffset, YOffset: Integer): Integer; stdcall; external gdi32 name 'OffsetRgn';
  function OffsetClipRgn(ADC: HDC; XOffset, YOffset: Integer): Integer; stdcall; external gdi32 name 'OffsetClipRgn';
  function PaintRgn(ADC: HDC; RGN: HRGN): BOOL; stdcall; external gdi32 name 'PaintRgn';

const
  { Stock Logical Objects }
  WHITE_BRUSH   = 0;
  LTGRAY_BRUSH  = 1;
  GRAY_BRUSH    = 2;
  DKGRAY_BRUSH  = 3;
  BLACK_BRUSH   = 4;
  NULL_BRUSH    = 5;
  HOLLOW_BRUSH  = NULL_BRUSH;
  WHITE_PEN     = 6;
  BLACK_PEN     = 7;
  NULL_PEN      = 8;
  OEM_FIXED_FONT    = 10;
  ANSI_FIXED_FONT   = 11;
  ANSI_VAR_FONT     = 12;
  SYSTEM_FONT       = 13;
  DEVICE_DEFAULT_FONT = 14;  // 默认字体
  DEFAULT_PALETTE   = 15;
  SYSTEM_FIXED_FONT = $10;
  DEFAULT_GUI_FONT  = 17;
  DC_BRUSH          = 18;
  DC_PEN            = 19;
  STOCK_LAST        = 19;
  
  function GetStockObject(Index: Integer): HGDIOBJ; stdcall; external gdi32 name 'GetStockObject';

  
  function CreateRoundRectRgn(ALeft, ATop, ARight, ABottom,
    AEllipseX, AEllipseY: Integer): HRGN; stdcall; external gdi32 name 'CreateRoundRectRgn';

  function DrawEscape(ADC: HDC; p2, p3: Integer; p4: LPCSTR): BOOL; stdcall; external gdi32 name 'DrawEscape';

  function GetBkColor(ADC: HDC): COLORREF; stdcall; external gdi32 name 'GetBkColor';
  function GetDCBrushColor(ADC: HDC): COLORREF; stdcall; external gdi32 name 'GetDCBrushColor';
  function GetDCPenColor(ADC: HDC): COLORREF; stdcall; external gdi32 name 'GetDCPenColor';
  function GetDCOrgEx(ADC: HDC; var Origin: TPoint): BOOL; stdcall; external gdi32 name 'GetDCOrgEx';

  function GetBkMode(ADC: HDC): Integer; stdcall; external gdi32 name 'GetBkMode';
  function GetBoundsRect(ADC: HDC; var Bounds: TRect; Flags: UINT): UINT; stdcall; external gdi32 name 'GetBoundsRect';
  function GetBrushOrgEx(ADC: HDC; var lppt: TPoint): BOOL; stdcall; external gdi32 name 'GetBrushOrgEx';

  {该函数重置一个逻辑调色板。它指导系统去映射调色板，虽然它以前并没有被映射过，下一次该应用为一个指定的调色板调用函数时，
   该系统把该逻辑调色板完全重新映射到系统调色板中 }
  function UnrealizeObject(AGDIObj: HGDIOBJ): BOOL; stdcall; external gdi32 name 'UnrealizeObject';

  {执行任何未决的绘图操作}
  function GdiFlush: BOOL; stdcall; external gdi32 name 'GdiFlush';

  { 最好不要用 SetBitmapBits,应该用api函数SetDIBits代替 ??? }
  function SetBitmapBits(
      p1: HBITMAP;
      p2: DWORD;
      bits: Pointer): Longint; stdcall; external gdi32 name 'SetBitmapBits';


  function GetDIBits(DC: HDC; Bitmap: HBitmap; StartScan, NumScans: UINT;
    Bits: Pointer; var BitInfo: TBitmapInfo; Usage: UINT): Integer; stdcall; external gdi32 name 'GetDIBits';

  function SetDIBits(
      ADC: HDC;
      ABitmap: HBITMAP;
      AStartScan: UINT;
      ANumScans: UINT;
      ABits: Pointer;
      var BitsInfo: TBitmapInfo;
      Usage: UINT
      ): Integer; stdcall; external gdi32 name 'SetDIBits';

  { 这个应该是还是有两份 Memory
        HBitmap 一份 自身 Bit 一份
        HBitmap 的内存控制 应该还是用 CreateBitmap / CreateBitmapIndirect
  }
  function SetDIBitsToDevice(
      ADC: HDC;
      DestX: Integer; DestY: Integer;
      Width: DWORD; Height: DWORD;
      SrcX: Integer; SrcY: Integer;
      nStartScan: UINT;  // 从什么位置开始显示dib
      NumScans: UINT;    // 扫描多少行
      Bits: Pointer;     //指定从dib的什么位置开始扫描
      var BitsInfo: TBitmapInfo;
      Usage: UINT   // DIB_RGB_COLORS
      ): Integer; stdcall; external gdi32 name 'SetDIBitsToDevice';
  // http://topic.csdn.net/u/20120921/16/DE29E5A8-911E-44B5-A776-0FAEBD02BA85.html

const
  { Mapping Modes }
  MM_TEXT = 1;
  MM_LOMETRIC = 2;
  MM_HIMETRIC = 3;
  MM_LOENGLISH = 4;
  MM_HIENGLISH = 5;
  MM_TWIPS = 6;
  MM_ISOTROPIC = 7;
  MM_ANISOTROPIC = 8;

  { Min and Max Mapping Mode values }
  MM_MIN = MM_TEXT;
  MM_MAX = MM_ANISOTROPIC;
  MM_MAX_FIXEDSCALE = MM_TWIPS;

  function SetMapMode(ADC: HDC; p2: Integer): Integer; stdcall; external gdi32 name 'SetMapMode';
  // SetWindowOrg
  function SetMapperFlags(ADC: HDC; AFlag: DWORD): DWORD; stdcall; external gdi32 name 'SetMapperFlags';
  function SetGraphicsMode(ADC: HDC; iMode: Integer): Integer; stdcall; external gdi32 name 'SetGraphicsMode';

//  function AlphaBlend(ADC: HDC; p2, p3, p4, p5: Integer;
//      DC6: HDC; p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall; external msimg32 name 'AlphaBlend';
//  function AlphaDIBBlend(ADC: HDC; p2, p3, p4, p5: Integer; const p6: Pointer;
//      const p7: PBitmapInfo; p8: UINT; p9, p10, p11, p12: Integer; p13: TBlendFunction): BOOL; stdcall; external msimg32 name 'AlphaDIBBlend';
//  function TransparentBlt(ADC: HDC; p2, p3, p4, p5: Integer;
//      ADC6: HDC; p7, p8, p9, p10: Integer; p11: UINT): BOOL; stdcall; external msimg32 name 'TransparentBlt';
  function TransparentDIBits(ADC: HDC; p2, p3, p4, p5: Integer; const p6: Pointer;
      const p7: PBitmapInfo; p8: UINT; p9, p10, p11, p12: Integer; p13: UINT): BOOL; stdcall; external gdi32 name 'TransparentDIBits';

  { 取回指定DC的图形模式 }
  function GetGraphicsMode(ADC: HDC): Integer; stdcall; external gdi32 name 'GetGraphicsMode';

  // 该函数检索打印机设备驱动器的性能

const
  { device capabilities indices }
  DC_FIELDS = 1;
  DC_PAPERS = 2;
  DC_PAPERSIZE = 3;
  DC_MINEXTENT = 4;
  DC_MAXEXTENT = 5;
  DC_BINS = 6;
  DC_DUPLEX = 7;
  DC_SIZE = 8;
  DC_EXTRA = 9;
  DC_VERSION = 10;
  DC_DRIVER = 11;
  DC_BINNAMES = 12;
  DC_ENUMRESOLUTIONS = 13;
  DC_FILEDEPENDENCIES = 14;
  DC_TRUETYPE = 15;
  DC_PAPERNAMES = 16;
  DC_ORIENTATION = 17;
  DC_COPIES = 18;
  DC_BINADJUST = 19;
  DC_EMF_COMPLIANT = 20;
  DC_DATATYPE_PRODUCED = 21;
  DC_COLLATE = 22;
  DC_MANUFACTURER = 23;
  DC_MODEL = 24;
  DC_COLORDEVICE = 23;
  DC_NUP = 24;
  DC_PERSONALITY = 25;
  DC_PRINTRATE = 26;
  DC_PRINTRATEUNIT = 27;

  PRINTRATEUNIT_PPM = 1;
  PRINTRATEUNIT_CPS = 2;
  PRINTRATEUNIT_LPM = 3;
  PRINTRATEUNIT_IPM = 4;

  DC_PRINTERMEM = 28;
  DC_MEDIAREADY = 29;

  { bit fields of the return value (DWORD) for DC_TRUETYPE }
  DCTT_BITMAP = 1;
  DCTT_DOWNLOAD = 2;
  DCTT_SUBDEV = 4;
  DCTT_DOWNLOAD_OUTLINE = 8;

  { return values for DC_BINADJUST }
  DCBA_FACEUPNONE = 0;
  DCBA_FACEUPCENTER = 1;
  DCBA_FACEUPLEFT = 2;
  DCBA_FACEUPRIGHT = 3;
  DCBA_FACEDOWNNONE = $100;
  DCBA_FACEDOWNCENTER = 257;
  DCBA_FACEDOWNLEFT = 258;
  DCBA_FACEDOWNRIGHT = 259;

  function DeviceCapabilitiesA(
      pDriverName: PAnsiChar;
      pDeviceName: PAnsiChar;
      pPort: PAnsiChar;
      iIndex: Integer;
      pOutput: PAnsiChar;
      DevMode: PDeviceModeA
      ): Integer; stdcall; external gdi32 name 'DeviceCapabilitiesA';
  function DeviceCapabilitiesW(
      pDriverName: PWideChar;
      pDeviceName: PWideChar;
      pPort: PWideChar;
      iIndex: Integer;
      pOutput: PWideChar;
      DevMode: PDeviceModeW
      ): Integer; stdcall; external gdi32 name 'DeviceCapabilitiesW';
  
implementation

end.
