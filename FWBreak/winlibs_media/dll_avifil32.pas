(*
          1    0 00006AB8 AVIBuildFilter
          2    1 00006AB8 AVIBuildFilterA
          3    2 0000662A AVIBuildFilterW
          4    3 00003E9B AVIClearClipboard
          5    4 00005E48 AVIFileAddRef
          6    5 00005D7C AVIFileCreateStream
          7    6 00005D9D AVIFileCreateStreamA
          8    7 00005D7C AVIFileCreateStreamW
          9    8 00005E31 AVIFileEndRecord
         10    9 0000589F AVIFileExit
         11    A 00005D5C AVIFileGetStream
         12    B 00005C8B AVIFileInfo
         13    C 00005C8B AVIFileInfoA
         14    D 00005C58 AVIFileInfoW
         15    E 00005881 AVIFileInit
         16    F 00005BF6 AVIFileOpen
         17   10 00005BF6 AVIFileOpenA
         18   11 00005AA1 AVIFileOpenW
         19   12 00005E11 AVIFileReadData
         20   13 00005E5F AVIFileRelease
         21   14 00005FF3 AVIFileWriteData
         22   15 00003D6C AVIGetFromClipboard
         23   16 00006508 AVIMakeCompressedStream
         24   17 0000D1CB AVIMakeFileFromStreams
         25   18 0000D553 AVIMakeStreamFromClipboard
         26   19 00003D2A AVIPutFileOnClipboard
         27   1A 000028A8 AVISave
         28   1B 000028A8 AVISaveA
         29   1C 00003398 AVISaveOptions
         30   1D 00002989 AVISaveOptionsFree
         31   1E 00002843 AVISaveV
         32   1F 00002843 AVISaveVA
         33   20 00001A21 AVISaveVW
         34   21 00002762 AVISaveW
         35   22 00005E48 AVIStreamAddRef
         36   23 00006481 AVIStreamBeginStreaming
         37   24 000063FE AVIStreamCreate
         38   25 000064C9 AVIStreamEndStreaming
         39   26 00005FC5 AVIStreamFindSample
         40   27 0000FC23 AVIStreamGetFrame
         41   28 0000FC06 AVIStreamGetFrameClose
         42   29 0000FCE3 AVIStreamGetFrameOpen
         43   2A 00005EA9 AVIStreamInfo
         44   2B 00005EA9 AVIStreamInfoA
         45   2C 00005E76 AVIStreamInfoW
         46   2D 000060E7 AVIStreamLength
         47   2E 000063B9 AVIStreamOpenFromFile
         48   2F 000063B9 AVIStreamOpenFromFileA
         49   30 00006374 AVIStreamOpenFromFileW
         50   31 00006053 AVIStreamRead
         51   32 00006013 AVIStreamReadData
         52   33 00005FF3 AVIStreamReadFormat
         53   34 00005E5F AVIStreamRelease
         54   35 0000625A AVIStreamSampleToTime
         55   36 00005E11 AVIStreamSetFormat
         56   37 000060A8 AVIStreamStart
         57   38 0000612F AVIStreamTimeToSample
         58   39 0000607C AVIStreamWrite
         59   3A 00006033 AVIStreamWriteData
         60   3B 0000EEF0 CreateEditableStream
         61   3C 00006D8A DllCanUnloadNow
         62   3D 000055A3 DllGetClassObject
         63   3E 0000D70F EditStreamClone
         64   3F 0000D669 EditStreamCopy
         65   40 0000D619 EditStreamCut
         66   41 0000D6B9 EditStreamPaste
         67   42 0000D7A6 EditStreamSetInfo
         68   43 0000D7A6 EditStreamSetInfoA
         69   44 0000D759 EditStreamSetInfoW
         70   45 0000D952 EditStreamSetName
         71   46 0000D952 EditStreamSetNameA
         72   47 0000D8B4 EditStreamSetNameW
         73   48 000012E8 IID_IAVIEditStream
         74   49 00001328 IID_IAVIFile
         75   4A 00001318 IID_IAVIStream
         76   4B 000012F8 IID_IGetFrame
*)
unit dll_avifil32;

interface


type

 { TAVIFileInfoW record }

  LONG = Longint;
  PVOID = Pointer;

// TAVIFileInfo dwFlag values
const
  AVIF_HASINDEX		= $00000010;
  AVIF_MUSTUSEINDEX	= $00000020;
  AVIF_ISINTERLEAVED	= $00000100;
  AVIF_WASCAPTUREFILE	= $00010000;
  AVIF_COPYRIGHTED	= $00020000;
  AVIF_KNOWN_FLAGS	= $00030130;

type
  TAVIFileInfoW = record
    dwMaxBytesPerSec,	// max. transfer rate
    dwFlags,		// the ever-present flags
    dwCaps,
    dwStreams,
    dwSuggestedBufferSize,

    dwWidth,
    dwHeight,

    dwScale,
    dwRate,	// dwRate / dwScale == samples/second
    dwLength,

    dwEditCount: DWORD;

    szFileType: array[0..63] of WideChar;		// descriptive string for file type?
  end;
  PAVIFileInfoW = ^TAVIFileInfoW;

// TAVIStreamInfo dwFlag values
const
  AVISF_DISABLED	= $00000001;
  AVISF_VIDEO_PALCHANGES= $00010000;
  AVISF_KNOWN_FLAGS	= $00010001;

type
  TAVIStreamInfoA = record
    fccType,
    fccHandler,
    dwFlags,        // Contains AVITF_* flags
    dwCaps: DWORD;
    wPriority,
    wLanguage: WORD;
    dwScale,
    dwRate, // dwRate / dwScale == samples/second
    dwStart,
    dwLength, // In units above...
    dwInitialFrames,
    dwSuggestedBufferSize,
    dwQuality,
    dwSampleSize: DWORD;
    rcFrame: TRect;
    dwEditCount,
    dwFormatChangeCount: DWORD;
    szName:  array[0..63] of AnsiChar;
  end;
  TAVIStreamInfo = TAVIStreamInfoA;
  PAVIStreamInfo = ^TAVIStreamInfo;

  { TAVIStreamInfoW record }

  TAVIStreamInfoW = record
    fccType,
    fccHandler,
    dwFlags,        // Contains AVITF_* flags
    dwCaps: DWORD;
    wPriority,
    wLanguage: WORD;
    dwScale,
    dwRate, // dwRate / dwScale == samples/second
    dwStart,
    dwLength, // In units above...
    dwInitialFrames,
    dwSuggestedBufferSize,
    dwQuality,
    dwSampleSize: DWORD;
    rcFrame: TRect;
    dwEditCount,
    dwFormatChangeCount: DWORD;
    szName:  array[0..63] of WideChar;
  end;

  PAVIStream = pointer;
  PAVIFile = pointer;
  TAVIStreamList = array[0..0] of PAVIStream;
  PAVIStreamList = ^TAVIStreamList;
  TAVISaveCallback = function (nPercent: integer): LONG; stdcall;

  TAVICompressOptions = packed record
    fccType		: DWORD;
    fccHandler		: DWORD;
    dwKeyFrameEvery	: DWORD;
    dwQuality		: DWORD;
    dwBytesPerSecond	: DWORD;
    dwFlags		: DWORD;
    lpFormat		: pointer;
    cbFormat		: DWORD;
    lpParms		: pointer;
    cbParms		: DWORD;
    dwInterleaveEvery	: DWORD;
  end;
  PAVICompressOptions = ^TAVICompressOptions;

// Palette change data record
const
  RIFF_PaletteChange: DWORD = 1668293411;
type
  TAVIPalChange = packed record
    bFirstEntry		: byte;
    bNumEntries		: byte;
    wFlags		: WORD;
    peNew		: array[byte] of TPaletteEntry;
  end;
  PAVIPalChange = ^TAVIPalChange;

  procedure AVIFileInit; stdcall;
  procedure AVIFileExit; stdcall;
  function AVIFileOpen(var ppfile: PAVIFile; szFile: PAnsiChar; uMode: UINT; lpHandler: pointer): HResult; stdcall;
  function AVIFileCreateStream(pfile: PAVIFile; var ppavi: PAVISTREAM; var psi: TAVIStreamInfo): HResult; stdcall;
  function AVIStreamSetFormat(pavi: PAVIStream; lPos: LONG; lpFormat: pointer; cbFormat: LONG): HResult; stdcall;
  function AVIStreamReadFormat(pavi: PAVIStream; lPos: LONG; lpFormat: pointer; var cbFormat: LONG): HResult; stdcall;
  function AVIStreamWrite(pavi: PAVIStream; lStart, lSamples: LONG; lpBuffer: pointer; cbBuffer: LONG; dwFlags: DWORD; 
      var plSampWritten: LONG; var plBytesWritten: LONG): HResult; stdcall;
  function AVIStreamWriteData(pavi: PAVIStream; ckid: DWORD; lpData: pointer; cbData: LONG): HResult; stdcall;
  function AVIStreamRelease(pavi: PAVISTREAM): ULONG; stdcall;
  function AVIFileRelease(pfile: PAVIFile): ULONG; stdcall;
  function AVIFileGetStream(pfile: PAVIFile; var ppavi: PAVISTREAM; fccType: DWORD; lParam: LONG): HResult; stdcall;
  function AVIStreamBeginStreaming(pavi: PAVISTREAM; lStart, lEnd: LONG; lRate: LONG): HResult; stdcall;
  function AVIStreamEndStreaming(pavi: PAVISTREAM): HResult; stdcall;
  function AVIStreamGetFrameOpen(pavi: PAVISTREAM; var lpbiWanted: TBitmapInfoHeader): pointer; stdcall;
  function AVIStreamGetFrame(pgf: pointer; lPos: LONG): pointer; stdcall;
  function AVIStreamGetFrameClose(pget: pointer): HResult; stdcall;
  function AVIStreamInfo(pavi: PAVISTREAM; var psi: TAVIStreamInfo; lSize: LONG): HResult; stdcall;
  function AVIStreamLength(pavi: PAVISTREAM): LONG; stdcall;
  function CreateEditableStream(var ppsEditable: PAVISTREAM; psSource: PAVISTREAM): HResult; stdcall;
  function EditStreamSetInfo(pavi: PAVISTREAM; var lpInfo: TAVIStreamInfo; cbInfo: LONG): HResult; stdcall;
  function AVIMakeFileFromStreams(var ppfile: PAVIFILE; nStreams: integer; papStreams: PAVIStreamList): HResult; stdcall;
  function AVISave(szFile: PAnsiChar; pclsidHandler: PCLSID; lpfnCallback: TAVISaveCallback;
      nStreams: integer; pavi: PAVISTREAM; lpOptions: PAVICompressOptions): HResult; stdcall;


implementation

end.
