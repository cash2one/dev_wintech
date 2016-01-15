unit dll_winmm_midi;

interface

uses
  atmcmbaseconst, winconst, wintype, dll_winmm;

type
  PHMIDI = ^HMIDI;
  HMIDI = Integer;
  PHMIDIIN = ^HMIDIIN;
  HMIDIIN = Integer;
  
  PHMIDIOUT = ^HMIDIOUT;
  HMIDIOUT = Integer;
  PHMIDISTRM = ^HMIDISTRM;
  HMIDISTRM = Integer;

  function midiConnect(hmi: HMIDI; hmo: HMIDIOUT; pReserved: Pointer): MMRESULT; stdcall;
    external winmm name 'midiConnect';
  function midiDisconnect(hmi: HMIDI; hmo: HMIDIOUT; pReserved: Pointer): MMRESULT; stdcall;
    external winmm name 'midiDisconnect';
  function midiInAddBuffer(hMidiIn: HMIDIIN; lpMidiInHdr: PMidiHdr; uSize: UINT): MMRESULT; stdcall;
    external winmm name 'midiInAddBuffer';
  function midiInClose(hMidiIn: HMIDIIN): MMRESULT; stdcall; external winmm name 'midiInClose';
  function midiInGetDevCaps(DeviceID: UINT; lpCaps: PMidiInCaps; uSize: UINT): MMRESULT; stdcall;
    external winmm name 'midiInGetDevCapsA';
  function midiInGetErrorText(mmrError: MMRESULT; pszText: PChar; uSize: UINT): MMRESULT; stdcall;
    external winmm name 'midiInGetErrorTextA';
  function midiInGetID(hMidiIn: HMIDIIN; lpuDeviceID: PUINT): MMRESULT; stdcall; external winmm name 'midiInGetID';
  function midiInGetNumDevs: UINT; stdcall; external winmm name 'midiInGetNumDevs';
  function midiInMessage(hMidiIn: HMIDIIN; uMessage: UINT; dw1, dw2: DWORD): MMRESULT; stdcall; external winmm name 'midiInMessage';
  function midiInOpen(lphMidiIn: PHMIDIIN; uDeviceID: UINT;
    dwCallback, dwInstance, dwFlags: DWORD): MMRESULT; stdcall; external winmm name 'midiInOpen';
  function midiInPrepareHeader(hMidiIn: HMIDIIN; lpMidiInHdr: PMidiHdr; uSize: UINT): MMRESULT; stdcall;
    external winmm name 'midiInPrepareHeader';
  function midiInUnprepareHeader(hMidiIn: HMIDIIN; lpMidiInHdr: PMidiHdr; uSize: UINT): MMRESULT; stdcall;
     external winmm name 'midiInUnprepareHeader';
  function midiInReset(hMidiIn: HMIDIIN): MMRESULT; stdcall; external winmm name 'midiInReset';
  function midiInStart(hMidiIn: HMIDIIN): MMRESULT; stdcall; external winmm name 'midiInStart';
  function midiInStop(hMidiIn: HMIDIIN): MMRESULT; stdcall; external winmm name 'midiInStop';

  function midiOutCacheDrumPatches(hMidiOut: HMIDIOUT;
    uPatch: UINT; lpwKeyArray: PWord; uFlags: UINT): MMRESULT; stdcall; external winmm name 'midiOutCacheDrumPatches';
  function midiOutCachePatches(hMidiOut: HMIDIOUT;
    uBank: UINT; lpwPatchArray: PWord; uFlags: UINT): MMRESULT; stdcall; external winmm name 'midiOutCachePatches';
  function midiOutGetDevCaps(uDeviceID: UINT; lpCaps: PMidiOutCaps; uSize: UINT): MMRESULT; stdcall;
    external winmm name 'midiOutGetDevCapsA';
  function midiOutGetErrorText(mmrError: MMRESULT; pszText: PChar; uSize: UINT): MMRESULT; stdcall;
    external winmm name 'midiOutGetErrorTextA';
  function midiOutGetID(hMidiOut: HMIDIOUT; lpuDeviceID: PUINT): MMRESULT; stdcall; external winmm name 'midiOutGetID';
  function midiOutGetNumDevs: UINT; stdcall; external winmm name 'midiOutGetNumDevs';
  function midiOutMessage(hMidiOut: HMIDIOUT; uMessage: UINT; dw1, dw2: DWORD): MMRESULT; stdcall; external winmm name 'midiOutMessage';

  function midiOutOpen(lphMidiOut: PHMIDIOUT; uDeviceID: UINT;
    dwCallback, dwInstance, dwFlags: DWORD): MMRESULT; stdcall; external winmm name 'midiOutOpen';
  function midiOutClose(hMidiOut: HMIDIOUT): MMRESULT; stdcall; external winmm name 'midiOutClose';
  function midiOutReset(hMidiOut: HMIDIOUT): MMRESULT; stdcall; external winmm name 'midiOutReset';

  function midiOutPrepareHeader(hMidiOut: HMIDIOUT; lpMidiOutHdr: PMidiHdr; uSize: UINT): MMRESULT; stdcall;
    external winmm name 'midiOutPrepareHeader';
  function midiOutUnprepareHeader(hMidiOut: HMIDIOUT; lpMidiOutHdr: PMidiHdr; uSize: UINT): MMRESULT; stdcall;
    external winmm name 'midiOutUnprepareHeader';

  function midiOutGetVolume(hmo: HMIDIOUT; lpdwVolume: PDWORD): MMRESULT; stdcall; external winmm name 'midiOutGetVolume';
  function midiOutSetVolume(hmo: HMIDIOUT; dwVolume: DWORD): MMRESULT; stdcall; external winmm name 'midiOutSetVolume';

  function midiOutShortMsg(hMidiOut: HMIDIOUT; dwMsg: DWORD): MMRESULT; stdcall; external winmm name 'midiOutShortMsg';
  function midiOutLongMsg(hMidiOut: HMIDIOUT; lpMidiOutHdr: PMidiHdr; uSize: UINT): MMRESULT; stdcall; external winmm name 'midiOutLongMsg';

  function midiStreamOpen(phms: PHMIDISTRM; puDeviceID: PUINT; 
    cMidi, dwCallback, dwInstance, fdwOpen: DWORD): MMRESULT; stdcall; external winmm name 'midiStreamOpen';
  function midiStreamClose(hms: HMIDISTRM): MMRESULT; stdcall; external winmm name 'midiStreamClose';
  function midiStreamRestart(hms: HMIDISTRM): MMRESULT; stdcall; external winmm name 'midiStreamRestart';
  function midiStreamStop(hms: HMIDISTRM): MMRESULT; stdcall; external winmm name 'midiStreamStop';
  function midiStreamPause(hms: HMIDISTRM): MMRESULT; stdcall; external winmm name 'midiStreamPause';

  function midiStreamOut(hms: HMIDISTRM; pmh: PMidiHdr; cbmh: UINT): MMRESULT; stdcall;
    external winmm name 'midiStreamOut';
  function midiStreamPosition(hms: HMIDISTRM; lpmmt: PMMTime; cbmmt: UINT): MMRESULT; stdcall;
    external winmm name 'midiStreamPosition';
  function midiStreamProperty(hms: HMIDISTRM; lppropdata: PBYTE; dwProperty: DWORD): MMRESULT; stdcall;
    external winmm name 'midiStreamProperty';

implementation

end.
