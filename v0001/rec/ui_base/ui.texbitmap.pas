unit ui.texbitmap;

interface

uses
  Types, ui.texcolor;
  
type          
  PBitmapCoreHeader = ^TBitmapCoreHeader;
  TBitmapCoreHeader = packed record
    bcSize        : DWORD;
    bcWidth       : Word;
    bcHeight      : Word;
    bcPlanes      : Word;
    bcBitCount    : Word;
  end;
  
  PBitmapInfoHeader = ^TBitmapInfoHeader;
  TBitmapInfoHeader = packed record
    biSize        : DWORD;
    biWidth       : Longint;
    biHeight      : Longint;
    biPlanes      : Word;
    biBitCount    : Word;
    biCompression : DWORD;
    biSizeImage   : DWORD;
    biXPelsPerMeter: Longint;
    biYPelsPerMeter: Longint;
    biClrUsed     : DWORD;
    biClrImportant: DWORD;
  end;
              
  PBitmapInfo     = ^TBitmapInfo;
  TBitmapInfo     = packed record
    bmiHeader     : TBitmapInfoHeader;
    bmiColors     : array[0..0] of TRGBQuad;
  end;

  PBitmapCoreInfo = ^TBitmapCoreInfo;
  TBitmapCoreInfo = record
    bmciHeader    : TBitmapCoreHeader;
    bmciColors    : array[0..0] of TRGBTriple;
    Reserved      : array[0..0] of Char;
  end;

  PBitmapFileHeader = ^TBitmapFileHeader;
  TBitmapFileHeader = packed record
    bfType        : Word;
    bfSize        : DWORD;
    bfReserved1   : Word;
    bfReserved2   : Word;
    bfOffBits     : DWORD;
  end;
              
  PBitmap32       = ^TBitmap32;
  TBitmap32       = record
    Width         : integer;
    Height        : integer;
    Bits          : PColor32Array;
    //BackendExData : Pointer;  this data should save on draw session ????
  end;

implementation

end.
