{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit winconst_imm;

interface
                     
const
{ parameter of ImmGetCompositionString }
  GCS_COMPREADSTR                = $0001;
  GCS_COMPREADATTR               = $0002;
  GCS_COMPREADCLAUSE             = $0004;
  GCS_COMPSTR                    = $0008;
  GCS_COMPATTR                   = $0010;
  GCS_COMPCLAUSE                 = $0020;
  GCS_CURSORPOS                  = $0080;
  GCS_DELTASTART                 = $0100;
  GCS_RESULTREADSTR              = $0200;
  GCS_RESULTREADCLAUSE           = $0400;
  GCS_RESULTSTR                  = $0800;
  GCS_RESULTCLAUSE               = $1000;

{ style bit flags for WM_IME_COMPOSITION }
  CS_INSERTCHAR                  = $2000;
  CS_NOMOVECARET                 = $4000;

{ bit field for IMC_SETCOMPOSITIONWINDOW, IMC_SETCANDIDATEWINDOW }
  CFS_DEFAULT                    = $0000;
  CFS_RECT                       = $0001;
  CFS_POINT                      = $0002;
  CFS_SCREEN                     = $0004;	{ removed in 4.0 SDK }
  CFS_FORCE_POSITION             = $0020;
  CFS_CANDIDATEPOS               = $0040;
  CFS_EXCLUDE                    = $0080;

{ wParam for WM_IME_CONTROL }
  IMC_GETCANDIDATEPOS            = $0007;
  IMC_SETCANDIDATEPOS            = $0008;
  IMC_GETCOMPOSITIONFONT         = $0009;
  IMC_SETCOMPOSITIONFONT         = $000A;
  IMC_GETCOMPOSITIONWINDOW       = $000B;
  IMC_SETCOMPOSITIONWINDOW       = $000C;
  IMC_GETSTATUSWINDOWPOS         = $000F;
  IMC_SETSTATUSWINDOWPOS         = $0010;
  IMC_CLOSESTATUSWINDOW          = $0021;
  IMC_OPENSTATUSWINDOW           = $0022;
                        
{ wParam for WM_IME_CONTROL to the soft keyboard }
{ dwAction for ImmNotifyIME }
  NI_OPENCANDIDATE               = $0010;
  NI_CLOSECANDIDATE              = $0011;
  NI_SELECTCANDIDATESTR          = $0012;
  NI_CHANGECANDIDATELIST         = $0013;
  NI_FINALIZECONVERSIONRESULT    = $0014;
  NI_COMPOSITIONSTR              = $0015;
  NI_SETCANDIDATE_PAGESTART      = $0016;
  NI_SETCANDIDATE_PAGESIZE       = $0017;

{ lParam for WM_IME_SETCONTEXT }
  ISC_SHOWUICANDIDATEWINDOW      = $00000001;
  ISC_SHOWUICOMPOSITIONWINDOW    = $80000000;
  ISC_SHOWUIGUIDELINE            = $40000000;
  ISC_SHOWUIALLCANDIDATEWINDOW   = $0000000F;
  ISC_SHOWUIALL                  = $C000000F;

{ dwIndex for ImmNotifyIME/NI_COMPOSITIONSTR }
  CPS_COMPLETE                   = $0001;
  CPS_CONVERT                    = $0002;
  CPS_REVERT                     = $0003;
  CPS_CANCEL                     = $0004;


{ the modifiers of hot key }
  MOD_ALT                        = $0001;
  MOD_CONTROL                    = $0002;
  MOD_SHIFT                      = $0004;
  MOD_LEFT                       = $8000;
  MOD_RIGHT                      = $4000;
  MOD_ON_KEYUP                   = $0800;
  MOD_IGNORE_ALL_MODIFIER        = $0400;

{ Windows for Simplified Chinese Edition hot key ID from #10 - #2F }
  IME_CHOTKEY_IME_NONIME_TOGGLE          = $10;
  IME_CHOTKEY_SHAPE_TOGGLE               = $11;
  IME_CHOTKEY_SYMBOL_TOGGLE              = $12;

{ Windows for Japanese Edition hot key ID from #30 - #4F }
  IME_JHOTKEY_CLOSE_OPEN                 = $30;

{ Windows for Korean Edition hot key ID from #50 - #6F }
  IME_KHOTKEY_SHAPE_TOGGLE               = $50;
  IME_KHOTKEY_HANJACONVERT               = $51;
  IME_KHOTKEY_ENGLISH                    = $52;

{ Windows for Tranditional Chinese Edition hot key ID from #70 - #8F }
  IME_THOTKEY_IME_NONIME_TOGGLE          = $70;
  IME_THOTKEY_SHAPE_TOGGLE               = $71;
  IME_THOTKEY_SYMBOL_TOGGLE              = $72;

{ direct switch hot key ID from #100 - #11F }
  IME_HOTKEY_DSWITCH_FIRST               = $100;
  IME_HOTKEY_DSWITCH_LAST                = $11F;

{ IME private hot key from #200 - #21F }
  IME_HOTKEY_PRIVATE_FIRST               = $200;
  IME_ITHOTKEY_RESEND_RESULTSTR          = $200;
  IME_ITHOTKEY_PREVIOUS_COMPOSITION      = $201;
  IME_ITHOTKEY_UISTYLE_TOGGLE            = $202;
  IME_HOTKEY_PRIVATE_LAST                = $21F;

{ bits of fdwInit of INPUTCONTEXT }
{ IME version constants }
  IMEVER_0310                    = $0003000A;
  IMEVER_0400                    = $00040000;

{ IME property bits }
  IME_PROP_AT_CARET              = $00010000;
  IME_PROP_SPECIAL_UI            = $00020000;
  IME_PROP_CANDLIST_START_FROM_1 = $00040000;
  IME_PROP_UNICODE               = $00080000;

{ IME UICapability bits }
  UI_CAP_2700                    = $00000001;
  UI_CAP_ROT90                   = $00000002;
  UI_CAP_ROTANY                  = $00000004;

{ ImmSetCompositionString Capability bits }
  SCS_CAP_COMPSTR                = $00000001;
  SCS_CAP_MAKEREAD               = $00000002;

{ IME WM_IME_SELECT inheritance Capability bits }
  SELECT_CAP_CONVERSION          = $00000001;
  SELECT_CAP_SENTENCE            = $00000002;

{ ID for deIndex of ImmGetGuideLine }
  GGL_LEVEL                      = $00000001;
  GGL_INDEX                      = $00000002;
  GGL_STRING                     = $00000003;
  GGL_PRIVATE                    = $00000004;

{ ID for dwLevel of GUIDELINE Structure }
  GL_LEVEL_NOGUIDELINE           = $00000000;
  GL_LEVEL_FATAL                 = $00000001;
  GL_LEVEL_ERROR                 = $00000002;
  GL_LEVEL_WARNING               = $00000003;
  GL_LEVEL_INFORMATION           = $00000004;

{ ID for dwIndex of GUIDELINE Structure }
  GL_ID_UNKNOWN                  = $00000000;
  GL_ID_NOMODULE                 = $00000001;
  GL_ID_NODICTIONARY             = $00000010;
  GL_ID_CANNOTSAVE               = $00000011;
  GL_ID_NOCONVERT                = $00000020;
  GL_ID_TYPINGERROR              = $00000021;
  GL_ID_TOOMANYSTROKE            = $00000022;
  GL_ID_READINGCONFLICT          = $00000023;
  GL_ID_INPUTREADING             = $00000024;
  GL_ID_INPUTRADICAL             = $00000025;
  GL_ID_INPUTCODE                = $00000026;
  GL_ID_INPUTSYMBOL              = $00000027;
  GL_ID_CHOOSECANDIDATE          = $00000028;
  GL_ID_REVERSECONVERSION        = $00000029;
  GL_ID_PRIVATE_FIRST            = $00008000;
  GL_ID_PRIVATE_LAST             = $0000FFFF;

{ ID for dwIndex of ImmGetProperty }
  IGP_GETIMEVERSION              = 4;
  IGP_PROPERTY                   = $00000004;
  IGP_CONVERSION                 = $00000008;
  IGP_SENTENCE                   = $0000000c;
  IGP_UI                         = $00000010;
  IGP_SETCOMPSTR                 = $00000014;
  IGP_SELECT                     = $00000018;

{ dwIndex for ImmSetCompositionString API }
  SCS_SETSTR                     = (GCS_COMPREADSTR or GCS_COMPSTR);
  SCS_CHANGEATTR                 = (GCS_COMPREADATTR or GCS_COMPATTR);
  SCS_CHANGECLAUSE               = (GCS_COMPREADCLAUSE or GCS_COMPCLAUSE);

{ attribute for COMPOSITIONSTRING Structure }
  ATTR_INPUT                     = $00;
  ATTR_TARGET_CONVERTED          = $01;
  ATTR_CONVERTED                 = $02;
  ATTR_TARGET_NOTCONVERTED       = $03;
  ATTR_INPUT_ERROR               = $04;

{ conversion direction for ImmGetConversionList }
  GCL_CONVERSION                 = $0001;
  GCL_REVERSECONVERSION          = $0002;
  GCL_REVERSE_LENGTH             = $0003;

{ bit field for conversion mode }
  IME_CMODE_ALPHANUMERIC         = $0000;
  IME_CMODE_NATIVE               = $0001;
  IME_CMODE_CHINESE              = IME_CMODE_NATIVE;
  IME_CMODE_HANGEUL              = IME_CMODE_NATIVE;
  IME_CMODE_HANGUL               = IME_CMODE_NATIVE;
  IME_CMODE_JAPANESE             = IME_CMODE_NATIVE;
  IME_CMODE_KATAKANA             = $0002;  { effective only under IME_CMODE_NATIVE}
  IME_CMODE_LANGUAGE             = $0003;
  IME_CMODE_FULLSHAPE            = $0008;
  IME_CMODE_ROMAN                = $0010;
  IME_CMODE_CHARCODE             = $0020;
  IME_CMODE_HANJACONVERT         = $0040;
  IME_CMODE_SOFTKBD              = $0080;
  IME_CMODE_NOCONVERSION         = $0100;
  IME_CMODE_EUDC                 = $0200;
  IME_CMODE_SYMBOL               = $0400;

  IME_SMODE_NONE                 = $0000;
  IME_SMODE_PLAURALCLAUSE        = $0001;
  IME_SMODE_SINGLECONVERT        = $0002;
  IME_SMODE_AUTOMATIC            = $0004;
  IME_SMODE_PHRASEPREDICT        = $0008;

{ style of candidate }
  IME_CAND_UNKNOWN               = $0000;
  IME_CAND_READ                  = $0001;
  IME_CAND_CODE                  = $0002;
  IME_CAND_MEANING               = $0003;
  IME_CAND_RADICAL               = $0004;
  IME_CAND_STROKE                = $0005;

{ wParam of report message WM_IME_NOTIFY }
  IMN_CLOSESTATUSWINDOW          = $0001;
  IMN_OPENSTATUSWINDOW           = $0002;
  IMN_CHANGECANDIDATE            = $0003;
  IMN_CLOSECANDIDATE             = $0004;
  IMN_OPENCANDIDATE              = $0005;
  IMN_SETCONVERSIONMODE          = $0006;
  IMN_SETSENTENCEMODE            = $0007;
  IMN_SETOPENSTATUS              = $0008;
  IMN_SETCANDIDATEPOS            = $0009;
  IMN_SETCOMPOSITIONFONT         = $000A;
  IMN_SETCOMPOSITIONWINDOW       = $000B;
  IMN_SETSTATUSWINDOWPOS         = $000C;
  IMN_GUIDELINE                  = $000D;
  IMN_PRIVATE                    = $000E;

{ error code of ImmGetCompositionString }
  IMM_ERROR_NODATA               = -1;
  IMM_ERROR_GENERAL              = -2;

{ dialog mode of ImmConfigureIME }
  IME_CONFIG_GENERAL             = 1;
  IME_CONFIG_REGISTERWORD        = 2;
  IME_CONFIG_SELECTDICTIONARY    = 3;

{ dialog mode of ImmEscape }
  IME_ESC_QUERY_SUPPORT          = $0003;
  IME_ESC_RESERVED_FIRST         = $0004;
  IME_ESC_RESERVED_LAST          = $07FF;
  IME_ESC_PRIVATE_FIRST          = $0800;
  IME_ESC_PRIVATE_LAST           = $0FFF;
  IME_ESC_SEQUENCE_TO_INTERNAL   = $1001;
  IME_ESC_GET_EUDC_DICTIONARY    = $1003;
  IME_ESC_SET_EUDC_DICTIONARY    = $1004;
  IME_ESC_MAX_KEY                = $1005;
  IME_ESC_IME_NAME               = $1006;
  IME_ESC_SYNC_HOTKEY            = $1007;
  IME_ESC_HANJA_MODE             = $1008;
  IME_ESC_AUTOMATA               = $1009;
  IME_ESC_PRIVATE_HOTKEY         = $100A;

{ style of word registration }
  IME_REGWORD_STYLE_EUDC         = $00000001;
  IME_REGWORD_STYLE_USER_FIRST   = $80000000;
  IME_REGWORD_STYLE_USER_LAST    = $FFFFFFFF;

{ type of soft keyboard }
{ for Windows Tranditional Chinese Edition }
{ for Windows Simplified Chinese Edition }
  SOFTKEYBOARD_TYPE_C1           = $0002;
  
implementation

end.
