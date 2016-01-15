unit dll_winmm_wave;

interface

uses
  atmcmbaseconst, winconst, wintype, dll_winmm;

type
  PHWAVE = ^HWAVE;
  HWAVE = Integer;
  PHWAVEIN = ^HWAVEIN;
  HWAVEIN = Integer;
  PHWAVEOUT = ^HWAVEOUT;
  HWAVEOUT = Integer;

  TFNWaveCallBack = TFNDrvCallBack;

  PWaveHdr = ^TWaveHdr;
  wavehdr_tag = record
    lpData: PAnsiChar;              { pointer to locked data buffer }
    dwBufferLength: DWORD;      { length of data buffer }
    dwBytesRecorded: DWORD;     { used for input only }
    dwUser: DWORD;              { for client's use }
    dwFlags: DWORD;             { assorted flags (see defines) }
    dwLoops: DWORD;             { loop control counter }
    lpNext: PWaveHdr;           { reserved for driver }
    reserved: DWORD;            { reserved for driver }
  end;
  TWaveHdr = wavehdr_tag;
  WAVEHDR = wavehdr_tag;

  PWaveInCapsA = ^TWaveInCapsA;
  PWaveInCaps = PWaveInCapsA;
  tagWAVEINCAPSA = record
    wMid: Word;                   { manufacturer ID }
    wPid: Word;                   { product ID }
    vDriverVersion: MMVERSION;         { version of the driver }
    szPname: array[0..MAXPNAMELEN-1] of AnsiChar;    { product name (NULL terminated AnsiString) }
    dwFormats: DWORD;             { formats supported }
    wChannels: Word;              { number of channels supported }
    wReserved1: Word;             { structure packing }
  end;
  tagWAVEINCAPS = tagWAVEINCAPSA;
  TWaveInCapsA = tagWAVEINCAPSA;
  TWaveInCaps = TWaveInCapsA;
  WAVEINCAPSA = tagWAVEINCAPSA;
  WAVEINCAPS = WAVEINCAPSA;

  PWaveFormatEx = ^TWaveFormatEx;
  tWAVEFORMATEX = packed record
    wFormatTag: Word;         { format type }
    nChannels: Word;          { number of channels (i.e. mono, stereo, etc.) }
    nSamplesPerSec: DWORD;  { sample rate }
    nAvgBytesPerSec: DWORD; { for buffer estimation }
    nBlockAlign: Word;      { block size of data }
    wBitsPerSample: Word;   { number of bits per sample of mono data }
    cbSize: Word;           { the count in bytes of the size of }
  end;

function waveInAddBuffer(hWaveIn: HWAVEIN; lpWaveInHdr: PWaveHdr;
  uSize: UINT): MMRESULT; stdcall; external winmm name 'waveInAddBuffer';
function waveInClose(hWaveIn: HWAVEIN): MMRESULT; stdcall; external winmm name 'waveInClose';
function waveInGetDevCaps(hwo: HWAVEOUT; lpCaps: PWaveInCaps; uSize: UINT): MMRESULT; stdcall; external winmm name 'waveInGetDevCapsA';
function waveInGetErrorText(mmrError: MMRESULT; lpText: PAnsiChar; uSize: UINT): MMRESULT; stdcall; external winmm name 'waveInGetErrorTextA';
function waveInGetID(hWaveIn: HWAVEIN; lpuDeviceID: PUINT): MMRESULT; stdcall; external winmm name 'waveInGetID';
function waveInGetNumDevs: UINT; stdcall; external winmm name 'waveInGetNumDevs';
function waveInGetPosition(hWaveIn: HWAVEIN; lpInfo: PMMTime;
  uSize: UINT): MMRESULT; stdcall; external winmm name 'waveInGetPosition';
function waveInMessage(hWaveIn: HWAVEIN; uMessage: UINT;
  dw1, dw2: DWORD): MMRESULT; stdcall; external winmm name 'waveInMessage';
function waveInOpen(lphWaveIn: PHWAVEIN; uDeviceID: UINT;
  lpFormatEx: PWaveFormatEx; dwCallback, dwInstance, dwFlags: DWORD): MMRESULT; stdcall; external winmm name 'waveInOpen';
function waveInPrepareHeader(hWaveIn: HWAVEIN; lpWaveInHdr: PWaveHdr;
  uSize: UINT): MMRESULT; stdcall; external winmm name 'waveInPrepareHeader';
function waveInReset(hWaveIn: HWAVEIN): MMRESULT; stdcall; external winmm name 'waveInReset';
function waveInStart(hWaveIn: HWAVEIN): MMRESULT; stdcall; external winmm name 'waveInStart';
function waveInStop(hWaveIn: HWAVEIN): MMRESULT; stdcall; external winmm name 'waveInStop';
function waveInUnprepareHeader(hWaveIn: HWAVEIN; lpWaveInHdr: PWaveHdr;
  uSize: UINT): MMRESULT; stdcall; external winmm name 'waveInUnprepareHeader';

type
  PWaveOutCapsA = ^TWaveOutCapsA;
  PWaveOutCaps = PWaveOutCapsA;
  tagWAVEOUTCAPSA = record
    wMid: Word;                 { manufacturer ID }
    wPid: Word;                 { product ID }
    vDriverVersion: MMVERSION;       { version of the driver }
    szPname: array[0..MAXPNAMELEN-1] of AnsiChar;  { product name (NULL terminated AnsiString) }
    dwFormats: DWORD;          { formats supported }
    wChannels: Word;            { number of sources supported }
    dwSupport: DWORD;          { functionality supported by driver }
  end;
  tagWAVEOUTCAPS = tagWAVEOUTCAPSA;
  TWaveOutCapsA = tagWAVEOUTCAPSA;
  TWaveOutCaps = TWaveOutCapsA;
  WAVEOUTCAPSA = tagWAVEOUTCAPSA;
  WAVEOUTCAPS = WAVEOUTCAPSA;

function waveOutBreakLoop(hWaveOut: HWAVEOUT): MMRESULT; stdcall; external winmm name 'waveOutBreakLoop';
function waveOutClose(hWaveOut: HWAVEOUT): MMRESULT; stdcall; external winmm name 'waveOutClose';
function waveOutGetDevCaps(uDeviceID: UINT; lpCaps: PWaveOutCaps; uSize: UINT): MMRESULT; stdcall; external winmm name 'waveOutGetDevCapsA';
function waveOutGetErrorText(mmrError: MMRESULT; lpText: PAnsiChar; uSize: UINT): MMRESULT; stdcall; external winmm name 'waveOutGetErrorTextA';
function waveOutGetID(hWaveOut: HWAVEOUT; lpuDeviceID: PUINT): MMRESULT; stdcall; external winmm name 'waveOutGetID';
function waveOutGetNumDevs: UINT; stdcall; external winmm name 'waveOutGetNumDevs';
function waveOutGetPitch(hWaveOut: HWAVEOUT; lpdwPitch: PDWORD): MMRESULT; stdcall; external winmm name 'waveOutGetPitch';
function waveOutGetPlaybackRate(hWaveOut: HWAVEOUT; lpdwRate: PDWORD): MMRESULT; stdcall; external winmm name 'waveOutGetPlaybackRate';
function waveOutGetPosition(hWaveOut: HWAVEOUT; lpInfo: PMMTime; uSize: UINT): MMRESULT; stdcall; external winmm name 'waveOutGetPosition';
function waveOutGetVolume(hwo: HWAVEOUT; lpdwVolume: PDWORD): MMRESULT; stdcall; external winmm name 'waveOutGetVolume';
function waveOutMessage(hWaveOut: HWAVEOUT; uMessage: UINT; dw1, dw2: DWORD): Longint; stdcall; external winmm name 'waveOutMessage';
function waveOutOpen(lphWaveOut: PHWaveOut; uDeviceID: UINT;
  lpFormat: PWaveFormatEx; dwCallback, dwInstance, dwFlags: DWORD): MMRESULT; stdcall; external winmm name 'waveOutOpen';
function waveOutPause(hWaveOut: HWAVEOUT): MMRESULT; stdcall; external winmm name 'waveOutPause';
function waveOutPrepareHeader(hWaveOut: HWAVEOUT; lpWaveOutHdr: PWaveHdr;
  uSize: UINT): MMRESULT; stdcall; external winmm name 'waveOutPrepareHeader';
function waveOutReset(hWaveOut: HWAVEOUT): MMRESULT; stdcall; external winmm name 'waveOutReset';
function waveOutRestart(hWaveOut: HWAVEOUT): MMRESULT; stdcall; external winmm name 'waveOutRestart';
function waveOutSetPitch(hWaveOut: HWAVEOUT; dwPitch: DWORD): MMRESULT; stdcall; external winmm name 'waveOutSetPitch';
function waveOutSetPlaybackRate(hWaveOut: HWAVEOUT; dwRate: DWORD): MMRESULT; stdcall; external winmm name 'waveOutSetPlaybackRate';
function waveOutSetVolume(hwo: HWAVEOUT; dwVolume: DWORD): MMRESULT; stdcall; external winmm name 'waveOutSetVolume';
function waveOutUnprepareHeader(hWaveOut: HWAVEOUT; lpWaveOutHdr: PWaveHdr;
  uSize: UINT): MMRESULT; stdcall; external winmm name 'waveOutUnprepareHeader';
function waveOutWrite(hWaveOut: HWAVEOUT; lpWaveOutHdr: PWaveHdr;
  uSize: UINT): MMRESULT; stdcall; external winmm name 'waveOutWrite';


implementation

end.
