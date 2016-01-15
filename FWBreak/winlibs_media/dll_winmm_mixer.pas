unit dll_winmm_mixer;

interface

uses
  atmcmbaseconst, winconst, wintype, dll_winmm;

const
  MIXER_SHORT_NAME_CHARS   = 16;
  MIXER_LONG_NAME_CHARS    = 64;

type
  PHMIXEROBJ = ^HMIXEROBJ;
  HMIXEROBJ = Integer;

  PHMIXER = ^HMIXER;
  HMIXER = Integer;

  PMixerControlDetails = ^TMixerControlDetails;
  tMIXERCONTROLDETAILS = record
    cbStruct: DWORD;       { size in bytes of MIXERCONTROLDETAILS }
    dwControlID: DWORD;    { control id to get/set details on }
    cChannels: DWORD;      { number of channels in paDetails array }
    case Integer of
	   0: (hwndOwner: HWND);        { for MIXER_SETCONTROLDETAILSF_CUSTOM }
	   1: (cMultipleItems: DWORD;   { if _MULTIPLE, the number of items per channel }
	       cbDetails: DWORD;        { size of _one_ details_XX struct }
	       paDetails: Pointer);     { pointer to array of details_XX structs }
  end;

  PMixerCapsA = ^TMixerCapsA;
  PMixerCaps = PMixerCapsA;
  tagMIXERCAPSA = record
    wMid: WORD;                    { manufacturer id }
    wPid: WORD;                    { product id }
    vDriverVersion: MMVERSION;     { version of the driver }
    szPname: array [0..MAXPNAMELEN - 1] of AnsiChar;   { product name }
    fdwSupport: DWORD;             { misc. support bits }
    cDestinations: DWORD;          { count of destinations }
  end;
  tagMIXERCAPS = tagMIXERCAPSA;
  TMixerCapsA = tagMIXERCAPSA;
  TMixerCaps = TMixerCapsA;
  MIXERCAPSA = tagMIXERCAPSA;
  MIXERCAPS = MIXERCAPSA;

  PMixerControlA = ^TMixerControlA;
  PMixerControl = PMixerControlA;
  tagMIXERCONTROLA = packed record
    cbStruct: DWORD;           { size in bytes of MIXERCONTROL }
    dwControlID: DWORD;        { unique control id for mixer device }
    dwControlType: DWORD;      { MIXERCONTROL_CONTROLTYPE_xxx }
    fdwControl: DWORD;         { MIXERCONTROL_CONTROLF_xxx }
    cMultipleItems: DWORD;     { if MIXERCONTROL_CONTROLF_MULTIPLE set }
    szShortName: array[0..MIXER_SHORT_NAME_CHARS - 1] of AnsiChar;
    szName: array[0..MIXER_LONG_NAME_CHARS - 1] of AnsiChar;
    Bounds: record
      case Integer of
        0: (lMinimum, lMaximum: Longint);
        1: (dwMinimum, dwMaximum: DWORD);
        2: (dwReserved: array[0..5] of DWORD);
    end;
    Metrics: record
      case Integer of
        0: (cSteps: DWORD);        { # of steps between min & max }
        1: (cbCustomData: DWORD);  { size in bytes of custom data }
        2: (dwReserved: array[0..5] of DWORD);
    end;
  end;
  tagMIXERCONTROL = tagMIXERCONTROLA;
  TMixerControlA = tagMIXERCONTROLA;
  TMixerControl = TMixerControlA;
  MIXERCONTROLA = tagMIXERCONTROLA;
  MIXERCONTROL = MIXERCONTROLA;

  PMixerLineControlsA = ^TMixerLineControlsA;
  PMixerLineControls = PMixerLineControlsA;
  tagMIXERLINECONTROLSA = record
    cbStruct: DWORD;               { size in bytes of MIXERLINECONTROLS }
    dwLineID: DWORD;               { line id (from MIXERLINE.dwLineID) }
    case Integer of
      0: (dwControlID: DWORD);     { MIXER_GETLINECONTROLSF_ONEBYID }
      1: (dwControlType: DWORD;    { MIXER_GETLINECONTROLSF_ONEBYTYPE }
          cControls: DWORD;        { count of controls pmxctrl points to }
          cbmxctrl: DWORD;         { size in bytes of _one_ MIXERCONTROL }
          pamxctrl: PMixerControlA);   { pointer to first MIXERCONTROL array }
  end;
  tagMIXERLINECONTROLS = tagMIXERLINECONTROLSA;
  TMixerLineControlsA = tagMIXERLINECONTROLSA;
  TMixerLineControls = TMixerLineControlsA;
  MIXERLINECONTROLSA = tagMIXERLINECONTROLSA;
  MIXERLINECONTROLS = MIXERLINECONTROLSA;

  PMixerLineA = ^TMixerLineA;
  PMixerLine = PMixerLineA;
  tagMIXERLINEA = record
    cbStruct: DWORD;               { size of MIXERLINE structure }
    dwDestination: DWORD;          { zero based destination index }
    dwSource: DWORD;               { zero based source index (if source) }
    dwLineID: DWORD;               { unique line id for mixer device }
    fdwLine: DWORD;                { state/information about line }
    dwUser: DWORD;                 { driver specific information }
    dwComponentType: DWORD;        { component type line connects to }
    cChannels: DWORD;              { number of channels line supports }
    cConnections: DWORD;           { number of connections [possible] }
    cControls: DWORD;              { number of controls at this line }
    szShortName: array[0..MIXER_SHORT_NAME_CHARS - 1] of AnsiChar;
    szName: array[0..MIXER_LONG_NAME_CHARS - 1] of AnsiChar;
    Target: record
      dwType: DWORD;                 { MIXERLINE_TARGETTYPE_xxxx }
      dwDeviceID: DWORD;             { target device ID of device type }
      wMid: WORD;                                   { of target device }
      wPid: WORD;                                   {      " }
      vDriverVersion: MMVERSION;                    {      " }
      szPname: array[0..MAXPNAMELEN - 1] of AnsiChar;  {      " }
	 end;
  end;
  tagMIXERLINE = tagMIXERLINEA;
  TMixerLineA = tagMIXERLINEA;
  TMixerLine = TMixerLineA;
  MIXERLINEA = tagMIXERLINEA;
  MIXERLINE = MIXERLINEA;

function mixerClose(hmx: HMIXER): MMRESULT; stdcall; external winmm name 'mixerClose';
function mixerGetControlDetails(hmxobj: HMIXEROBJ; pmxcd: PMixerControlDetails; fdwDetails: DWORD): MMRESULT; stdcall; external winmm name 'mixerGetControlDetailsA';
function mixerGetDevCaps(uMxId: UINT; pmxcaps: PMixerCaps; cbmxcaps: UINT): MMRESULT; stdcall; external winmm name 'mixerGetDevCapsA';
function mixerGetID(hmxobj: HMIXEROBJ; var puMxId: UINT; fdwId: DWORD): MMRESULT; stdcall; external winmm name 'mixerGetID';
function mixerGetLineControls(hmxobj: HMIXEROBJ; pmxlc: PMixerLineControls; fdwControls: DWORD): MMRESULT; stdcall; external winmm name 'mixerGetLineControlsA';
function mixerGetLineInfo(hmxobj: HMIXEROBJ; pmxl: PMixerLine; fdwInfo: DWORD): MMRESULT; stdcall; external winmm name 'mixerGetLineInfoA';
function mixerGetNumDevs: UINT; stdcall; external winmm name 'mixerGetNumDevs';
function mixerMessage(hmx: HMIXER; uMsg: UINT; dwParam1, dwParam2: DWORD): DWORD; stdcall; external winmm name 'mixerMessage';
function mixerOpen(phmx: PHMIXER; uMxId: UINT; dwCallback, dwInstance, fdwOpen: DWORD): MMRESULT; stdcall; external winmm name 'mixerOpen';
function mixerSetControlDetails(hmxobj: HMIXEROBJ; pmxcd: PMixerControlDetails; fdwDetails: DWORD): MMRESULT; stdcall; external winmm name 'mixerSetControlDetails';

implementation

end.
