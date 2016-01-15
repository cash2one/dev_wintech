{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdiplus_image;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype, dll_gdiplus;


const
  ImageFormatUndefined : TGUID = '{b96b3ca9-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatMemoryBMP : TGUID = '{b96b3caa-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatBMP       : TGUID = '{b96b3cab-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatEMF       : TGUID = '{b96b3cac-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatWMF       : TGUID = '{b96b3cad-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatJPEG      : TGUID = '{b96b3cae-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatPNG       : TGUID = '{b96b3caf-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatGIF       : TGUID = '{b96b3cb0-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatTIFF      : TGUID = '{b96b3cb1-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatEXIF      : TGUID = '{b96b3cb2-0728-11d3-9d7b-0000f81ef32e}';
  ImageFormatIcon      : TGUID = '{b96b3cb5-0728-11d3-9d7b-0000f81ef32e}';
               
type  
  TGPImageAbort             = function ( callbackData: Pointer ): BOOL; stdcall;
  TGPDrawImageAbort         = TGPImageAbort;
  TGPGetThumbnailImageAbort = TGPImageAbort;


  TGPEncoderParameter       = packed record
    Guid                    : TGUID;   // GUID of the parameter
    NumberOfValues          : ULONG;   // Number of the parameter values
    DataType                : ULONG;   // Value type, like ValueTypeLONG  etc.
    Value                   : Pointer; // A pointer to the parameter values
  end;

  PGPEncoderParameter       = ^TGPEncoderParameter;

  TGPEncoderParameters      = packed record
    Count                   : UINT;               // Number of parameters in this structure
    Parameter               : array[0..0] of TGPEncoderParameter;  // Parameter values
  end;
  PGPEncoderParameters      = ^TGPEncoderParameters;


  TGPImageType              = (
    ImageTypeUnknown,   // 0
    ImageTypeBitmap,    // 1
    ImageTypeMetafile   // 2
  );
                   
  TGPColorPalette           = packed record
    Flags                   : UINT;                 // Palette flags
    Count                   : UINT;                 // Number of color entries
    Entries                 : array [0..0] of TGPColor ; // Palette color entries
  end;

  PGPColorPalette           = ^TGPColorPalette;
                                          
  TGPRotateFlipType         = (
    RotateNoneFlipNone      = 0,
    Rotate90FlipNone        = 1,
    Rotate180FlipNone       = 2,
    Rotate270FlipNone       = 3,

    RotateNoneFlipX         = 4,
    Rotate90FlipX           = 5,
    Rotate180FlipX          = 6,
    Rotate270FlipX          = 7,
    RotateNoneFlipY         = Rotate180FlipX,
    Rotate90FlipY           = Rotate270FlipX,
    Rotate180FlipY          = RotateNoneFlipX,
    Rotate270FlipY          = Rotate90FlipX,
    RotateNoneFlipXY        = Rotate180FlipNone,
    Rotate90FlipXY          = Rotate270FlipNone,
    Rotate180FlipXY         = RotateNoneFlipNone,
    Rotate270FlipXY         = Rotate90FlipNone
  );
                     
  TGPColorAdjustType        = (
    ColorAdjustTypeDefault,
    ColorAdjustTypeBitmap,
    ColorAdjustTypeBrush,
    ColorAdjustTypePen,
    ColorAdjustTypeText,
    ColorAdjustTypeCount,
    ColorAdjustTypeAny      // Reserved
  );
                              
  TGPColorMatrix            = packed array[0..4, 0..4] of Single;
  PGPColorMatrix            = ^TGPColorMatrix;
                         
  TGPColorMatrixFlags       = (
    ColorMatrixFlagsDefault,
    ColorMatrixFlagsSkipGrays,
    ColorMatrixFlagsAltGray
  );
                
  TGPColorChannelFlags      = (
    ColorChannelFlagsC,
    ColorChannelFlagsM,
    ColorChannelFlagsY,
    ColorChannelFlagsK,
    ColorChannelFlagsLast
  );
             
  TGPColorMap               = packed record
    oldColor                : TGPColor;
    newColor                : TGPColor;
  end;
  PGPColorMap               = ^TGPColorMap;
    
//  function GdipLoadImageFromStream(AStream: ISTREAM; out AImage: TGpImage): TGpStatus; stdcall; external gdiplus;
  function GdipLoadImageFromFile(filename: PWideChar; out AImage: TGpImage): TGpStatus; stdcall; external gdiplus;
  function GdipCloneImage(AImage: TGpImage; out ACloneImage: TGpImage): TGpStatus; stdcall; external gdiplus;
  function GdipDisposeImage(AImage: TGpImage): TGpStatus; stdcall; external gdiplus;
  function GdipDrawImage(AGraphics: TGpGraphics; AImage: TGpImage; x: Single; y: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawImageI(AGraphics: TGpGraphics; AImage: TGpImage; x: Integer; y: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawImageRect(AGraphics: TGpGraphics; AImage: TGpImage; x: Single;
      y: Single; width: Single; height: Single): TGpStatus; stdcall; external gdiplus;

  function GdipDrawImageRectI(AGraphics: TGpGraphics; AImage: TGpImage; x: Integer;
      y: Integer; width: Integer; height: Integer): TGpStatus; stdcall; external gdiplus;

  function GdipDrawImagePoints(AGraphics: TGpGraphics; AImage: TGpImage;
      dstpoints: TGPPOINTF; count: Integer): TGpStatus; stdcall; external gdiplus;

  function GdipDrawImagePointsI(AGraphics: TGpGraphics; AImage: TGpImage;
      dstpoints: TGPPOINT; count: Integer): TGpStatus; stdcall; external gdiplus;

  function GdipDrawImagePointRect(AGraphics: TGpGraphics; AImage: TGpImage;
      x: Single; y: Single; srcx: Single; srcy: Single; srcwidth: Single;
      srcheight: Single; srcUnit: TGPUNIT): TGpStatus; stdcall; external gdiplus;

  function GdipDrawImagePointRectI(AGraphics: TGpGraphics; AImage: TGpImage;
      x: Integer; y: Integer; srcx: Integer; srcy: Integer; srcwidth: Integer;
      srcheight: Integer; srcUnit: TGPUNIT): TGpStatus; stdcall; external gdiplus;

  function GdipDrawImageRectRect(AGraphics: TGpGraphics; AImage: TGpImage;
      dstx: Single; dsty: Single; dstwidth: Single; dstheight: Single;
      srcx: Single; srcy: Single; srcwidth: Single; srcheight: Single;
      srcUnit: TGPUNIT; imageAttributes: TGpImageAttributes;
      callback: TGPDrawImageAbort; callbackData: Pointer): TGpStatus; stdcall; external gdiplus;

  function GdipDrawImageRectRectI(AGraphics: TGpGraphics; AImage: TGpImage;
      dstx: Integer; dsty: Integer; dstwidth: Integer; dstheight: Integer;
      srcx: Integer; srcy: Integer; srcwidth: Integer; srcheight: Integer;
      srcUnit: TGPUNIT; imageAttributes: TGpImageAttributes;
      callback: TGPDrawImageAbort; callbackData: Pointer): TGpStatus; stdcall; external gdiplus;

  function GdipDrawImagePointsRect(AGraphics: TGpGraphics; AImage: TGpImage;
      points: TGPPOINTF; count: Integer; srcx: Single; srcy: Single;
      srcwidth: Single; srcheight: Single; srcUnit: TGPUNIT;
      imageAttributes: TGpImageAttributes; callback: TGPDrawImageAbort;
      callbackData: Pointer): TGpStatus; stdcall; external gdiplus;

  function GdipDrawImagePointsRectI(AGraphics: TGpGraphics; AImage: TGpImage;
      points: TGPPOINT; count: Integer; srcx: Integer; srcy: Integer;
      srcwidth: Integer; srcheight: Integer; srcUnit: TGPUNIT;
      imageAttributes: TGpImageAttributes; callback: TGPDrawImageAbort;
      callbackData: Pointer): TGpStatus; stdcall; external gdiplus;


  function GdipSaveAdd(AImage: TGpImage; encoderParams: PGPEncoderParameters): TGpStatus; stdcall; external gdiplus;
  function GdipSaveAddImage(AImage: TGpImage; newImage: TGpImage; encoderParams: PGPEncoderParameters): TGpStatus; stdcall; external gdiplus;
  function GdipGetImageGraphicsContext(AImage: TGpImage; out graphics: TGpGraphics): TGpStatus; stdcall; external gdiplus;
  function GdipSaveImageToFile(AImage: TGpImage; filename: PWideChar; clsidEncoder: PGUID;
      encoderParams: PGPEncoderParameters): TGpStatus; stdcall; external gdiplus;

  function GdipGetImagePixelFormat(AImage: TGpImage; out format: TGPPixelFormat): TGpStatus; stdcall; external gdiplus;
  function GdipGetImageThumbnail(AImage: TGpImage; thumbWidth: UINT; thumbHeight: UINT;
      out thumbImage: TGpImage; callback: TGPGetThumbnailImageAbort; callbackData: Pointer): TGpStatus; stdcall; external gdiplus;

  function GdipGetImageDimension(AImage: TGpImage; var width: Single; var height: Single): TGpStatus; stdcall; external gdiplus;
  function GdipGetImageType(AImage: TGpImage; var type_: TGPImageType): TGpStatus; stdcall; external gdiplus;
  function GdipGetImageWidth(AImage: TGpImage; var width: UINT): TGpStatus; stdcall; external gdiplus;
  function GdipGetImageHeight(AImage: TGpImage; var height: UINT): TGpStatus; stdcall; external gdiplus;
  function GdipGetImageBounds(AImage: TGpImage; srcRect: TGPRECTF; var srcUnit: TGPUNIT): TGpStatus; stdcall; external gdiplus;

  function GdipGetImageHorizontalResolution(AImage: TGpImage; var resolution: Single): TGpStatus; stdcall; external gdiplus;
  function GdipGetImageVerticalResolution(AImage: TGpImage; var resolution: Single): TGpStatus; stdcall; external gdiplus;

  function GdipGetImageFlags(AImage: TGpImage; var flags: UINT): TGpStatus; stdcall; external gdiplus;
  function GdipGetEncoderParameterListSize(AImage: TGpImage; clsidEncoder: PGUID; out size: UINT): TGpStatus; stdcall; external gdiplus;
  function GdipGetEncoderParameterList(AImage: TGpImage; clsidEncoder: PGUID;
      size: UINT; buffer: PGPEncoderParameters): TGpStatus; stdcall; external gdiplus;
  function GdipImageGetFrameDimensionsCount(AImage: TGpImage;
      var count: UINT): TGpStatus; stdcall; external gdiplus;
  function GdipImageGetFrameDimensionsList(AImage: TGpImage; dimensionIDs: PGUID;
      count: UINT): TGpStatus; stdcall; external gdiplus;
  function GdipImageGetFrameCount(AImage: TGpImage; dimensionID: PGUID; var count: UINT): TGpStatus; stdcall; external gdiplus;
                             
  function GdipImageSelectActiveFrame(AImage: TGpImage; const DimensionID: TGUID; FrameIndex: Cardinal): TGPStatus; stdcall; external gdiplus;
  function GdipImageRotateFlip(AImage: TGpImage; ARotateType: TGPRotateFlipType): TGpStatus; stdcall; external gdiplus;

  function GdipGetImageRawFormat(AImage: TGpImage; format: PGUID): TGpStatus; stdcall; external gdiplus;
  function GdipCreateImageAttributes(out AImageattr: TGpImageAttributes): TGpStatus; stdcall; external gdiplus;
  function GdipCloneImageAttributes(AImageattr: TGpImageAttributes;
    out cloneImageattr: TGpImageAttributes): TGpStatus; stdcall; external gdiplus;
  function GdipDisposeImageAttributes(
    imageattr: TGpImageAttributes): TGpStatus; stdcall; external gdiplus;
  function GdipSetImageAttributesToIdentity(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType): TGpStatus; stdcall; external gdiplus;
  function GdipResetImageAttributes(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType): TGpStatus; stdcall; external gdiplus;
  function GdipSetImageAttributesColorMatrix(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType; enableFlag: Bool; colorMatrix: PGPColorMatrix;
    grayMatrix: PGPColorMatrix; flags: TGPColorMatrixFlags): TGpStatus; stdcall; external gdiplus;
  function GdipSetImageAttributesThreshold(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType; enableFlag: Bool;
    threshold: Single): TGpStatus; stdcall; external gdiplus;
  function GdipSetImageAttributesGamma(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType; enableFlag: Bool; gamma: Single): TGpStatus; stdcall; external gdiplus;
  function GdipSetImageAttributesNoOp(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType; enableFlag: Bool): TGpStatus; stdcall; external gdiplus;
  function GdipSetImageAttributesColorKeys(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType; enableFlag: Bool; colorLow: TGPColor;
    colorHigh: TGPColor): TGpStatus; stdcall; external gdiplus;

  function GdipSetImageAttributesOutputChannel(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType; enableFlag: Bool;
    channelFlags: TGPColorChannelFlags): TGpStatus; stdcall; external gdiplus;

  function GdipSetImageAttributesOutputChannelColorProfile(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType; enableFlag: Bool;
    colorProfileFilename: PWideChar): TGpStatus; stdcall; external gdiplus;

  function GdipSetImageAttributesRemapTable(AImageattr: TGpImageAttributes;
    AType: TGPColorAdjustType; enableFlag: Bool; mapSize: UINT;
    map: PGPColorMap): TGpStatus; stdcall; external gdiplus;

  function GdipSetImageAttributesWrapMode(AImageattr: TGpImageAttributes;
    wrap: TGPWrapMode; argb: TGPColor; clamp: Bool): TGpStatus; stdcall; external gdiplus;

  function GdipSetImageAttributesICMMode(AImageattr: TGpImageAttributes;
    on_: Bool): TGpStatus; stdcall; external gdiplus;

  function GdipGetImageAttributesAdjustedPalette(AImageattr: TGpImageAttributes;
    colorPalette: PGPColorPalette;
    colorAdjustType: TGPColorAdjustType): TGpStatus; stdcall; external gdiplus;

implementation

end.