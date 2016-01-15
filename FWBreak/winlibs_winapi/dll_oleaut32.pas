unit dll_oleaut32;

interface 

uses
  atmcmbaseconst, winconst, wintype;
  
const
  oleaut32 = 'oleaut32.dll';

function SysAllocString(psz: POleStr): TBStr; stdcall; external oleaut32 name 'SysAllocString';
function SysReAllocString(var bstr: TBStr; psz: POleStr): Integer; stdcall; external oleaut32 name 'SysReAllocString';
function SysAllocStringLen(psz: POleStr; len: Integer): TBStr; stdcall; external oleaut32 name 'SysAllocStringLen';
function SysReAllocStringLen(var bstr: TBStr; psz: POleStr; len: Integer): Integer; stdcall; external oleaut32 name 'SysReAllocStringLen';
procedure SysFreeString(bstr: TBStr); stdcall; external oleaut32 name 'SysFreeString';

function SysStringLen(bstr: TBStr): Integer; stdcall; external oleaut32 name 'SysStringLen';
function SysStringByteLen(bstr: TBStr): Integer; stdcall; external oleaut32 name 'SysStringByteLen';
function SysAllocStringByteLen(psz: PAnsiChar; len: Integer): TBStr; stdcall; external oleaut32 name 'SysAllocStringByteLen';

function DosDateTimeToVariantTime(wDosDate, wDosTime: Word; out vtime: TOleDate): Integer; stdcall;      external oleaut32 name 'DosDateTimeToVariantTime';
function VariantTimeToDosDateTime(vtime: TOleDate; out wDosDate, wDosTime: Word): Integer; stdcall;      external oleaut32 name 'VariantTimeToDosDateTime';
function SystemTimeToVariantTime(var SystemTime: TSystemTime; out vtime: TOleDate): Integer; stdcall;       external oleaut32 name 'SystemTimeToVariantTime';
function VariantTimeToSystemTime(vtime: TOleDate; out SystemTime: TSystemTime): Integer; stdcall; external oleaut32 name 'VariantTimeToSystemTime';

function SafeArrayAllocDescriptor(cDims: Integer; out psaOut: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayAllocDescriptor';
function SafeArrayAllocData(psa: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayAllocData';
function SafeArrayCreate(vt: TVarType; cDims: Integer; const rgsabound): PSafeArray; stdcall; external oleaut32 name 'SafeArrayCreate';
function SafeArrayCreateEx(vt: TVarType; cDims: Integer; const rgsabound; pvExtra: pointer): PSafeArray; stdcall; external oleaut32 name 'SafeArrayCreateEx';
function SafeArrayCreateVector(vt: TVarType; Lbound, cElements: Longint): PSafeArray; stdcall; external oleaut32 name 'SafeArrayCreateVector';
function SafeArrayCreateVectorEx(vt: TVarType; LBound, cElements: Longint; pvExta: pointer): PSafeArray; stdcall; external oleaut32 name 'SafeArrayCreateVectorEx';
function SafeArrayCopyData(psaSource, psaTarget: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayCopyData';
function SafeArrayDestroyDescriptor(psa: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayDestroyDescriptor';
function SafeArrayDestroyData(psa: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayDestroyData';
function SafeArrayDestroy(psa: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayDestroy';
function SafeArrayRedim(psa: PSafeArray; const saboundNew: TSafeArrayBound): HResult; stdcall; external oleaut32 name 'SafeArrayRedim';
function SafeArrayGetDim(psa: PSafeArray): Integer; stdcall; external oleaut32 name 'SafeArrayGetDim';
function SafeArrayGetElemsize(psa: PSafeArray): Integer; stdcall; external oleaut32 name 'SafeArrayGetElemsize';
function SafeArrayGetUBound(psa: PSafeArray; nDim: Integer; out lUbound: Longint): HResult; stdcall; external oleaut32 name 'SafeArrayGetUBound';
function SafeArrayGetLBound(psa: PSafeArray; nDim: Integer; out lLbound: Longint): HResult; stdcall; external oleaut32 name 'SafeArrayGetLBound';
function SafeArrayLock(psa: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayLock';
function SafeArrayUnlock(psa: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayUnlock';
function SafeArrayAccessData(psa: PSafeArray; out pvData: Pointer): HResult; stdcall; external oleaut32 name 'SafeArrayAccessData';
function SafeArrayUnaccessData(psa: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayUnaccessData';
function SafeArrayGetElement(psa: PSafeArray; const rgIndices; out pv): HResult; stdcall; external oleaut32 name 'SafeArrayGetElement';
function SafeArrayPutElement(psa: PSafeArray; const rgIndices; const pv): HResult; stdcall; external oleaut32 name 'SafeArrayPutElement';
function SafeArrayCopy(psa: PSafeArray; out psaOut: PSafeArray): HResult; stdcall; external oleaut32 name 'SafeArrayCopy';
function SafeArrayPtrOfIndex(psa: PSafeArray; var rgIndices; out pvData: Pointer): HResult; stdcall; external oleaut32 name 'SafeArrayPtrOfIndex';

procedure VariantInit(var varg: OleVariant); stdcall; external oleaut32 name 'VariantInit';
function VariantClear(var varg: OleVariant): HResult; stdcall; external oleaut32 name 'VariantClear';
function VariantCopy(var vargDest: OleVariant; const vargSrc: OleVariant): HResult; stdcall; external oleaut32 name 'VariantCopy';
function VariantCopyInd(var varDest: OleVariant; const vargSrc: OleVariant): HResult; stdcall; external oleaut32 name 'VariantCopyInd';
function VariantChangeType(var vargDest: OleVariant; const vargSrc: OleVariant;
  wFlags: Word; vt: TVarType): HResult; stdcall; external oleaut32 name 'VariantChangeType';
function VariantChangeTypeEx(var vargDest: OleVariant; const vargSrc: OleVariant;
  lcid: TLCID; wFlags: Word; vt: TVarType): HResult; stdcall;external oleaut32 name 'VariantChangeTypeEx';
function VectorFromBstr(bstr: TBStr; out psa: PSafeArray): HResult; stdcall; external oleaut32 name 'VectorFromBstr';
function BstrFromVector(psa: PSafeArray; out bstr: TBStr): HResult; stdcall; external oleaut32 name 'BstrFromVector';
function VarUI1FromI2(sIn: Smallint; out bOut: Byte): HResult; stdcall; external oleaut32 name 'VarUI1FromI2';
function VarUI1FromI4(lIn: Longint; out bOut: Byte): HResult; stdcall; external oleaut32 name 'VarUI1FromI4';
//function VarUI1FromR4;                  external oleaut32 name 'VarUI1FromR4';
//function VarUI1FromR8;                  external oleaut32 name 'VarUI1FromR8';
//function VarUI1FromCy;                  external oleaut32 name 'VarUI1FromCy';
//function VarUI1FromDate;                external oleaut32 name 'VarUI1FromDate';
//function VarUI1FromStr;                 external oleaut32 name 'VarUI1FromStr';
//function VarUI1FromDisp;                external oleaut32 name 'VarUI1FromDisp';
//function VarUI1FromBool;                external oleaut32 name 'VarUI1FromBool';
//function VarUI1FromI1;                  external oleaut32 name 'VarUI1FromI1';
//function VarUI1FromUI2;                 external oleaut32 name 'VarUI1FromUI2';
//function VarUI1FromUI4;                 external oleaut32 name 'VarUI1FromUI4';
//function VarUI1FromDec;                 external oleaut32 name 'VarUI1FromDec';
//function VarI2FromUI1;                  external oleaut32 name 'VarI2FromUI1';
//function VarI2FromI4;                   external oleaut32 name 'VarI2FromI4';
//function VarI2FromR4;                   external oleaut32 name 'VarI2FromR4';
//function VarI2FromR8;                   external oleaut32 name 'VarI2FromR8';
//function VarI2FromCy;                   external oleaut32 name 'VarI2FromCy';
//function VarI2FromDate;                 external oleaut32 name 'VarI2FromDate';
//function VarI2FromStr;                  external oleaut32 name 'VarI2FromStr';
//function VarI2FromDisp;                 external oleaut32 name 'VarI2FromDisp';
//function VarI2FromBool;                 external oleaut32 name 'VarI2FromBool';
//function VarI2FromI1;                   external oleaut32 name 'VarI2FromI1';
//function VarI2FromUI2;                  external oleaut32 name 'VarI2FromUI2';
//function VarI2FromUI4;                  external oleaut32 name 'VarI2FromUI4';
//function VarI2FromDec;                  external oleaut32 name 'VarI2FromDec';
//function VarI4FromUI1;                  external oleaut32 name 'VarI4FromUI1';
//function VarI4FromI2;                   external oleaut32 name 'VarI4FromI2';
//function VarI4FromR4;                   external oleaut32 name 'VarI4FromR4';
//function VarI4FromR8;                   external oleaut32 name 'VarI4FromR8';
//function VarI4FromCy;                   external oleaut32 name 'VarI4FromCy';
//function VarI4FromDate;                 external oleaut32 name 'VarI4FromDate';
//function VarI4FromStr;                  external oleaut32 name 'VarI4FromStr';
//function VarI4FromDisp;                 external oleaut32 name 'VarI4FromDisp';
//function VarI4FromBool;                 external oleaut32 name 'VarI4FromBool';
//function VarI4FromI1;                   external oleaut32 name 'VarI4FromI1';
//function VarI4FromUI2;                  external oleaut32 name 'VarI4FromUI2';
//function VarI4FromUI4;                  external oleaut32 name 'VarI4FromUI4';
//function VarI4FromDec;                  external oleaut32 name 'VarI4FromDec';
//function VarI4FromInt;                  external oleaut32 name 'VarI4FromInt';
//function VarR4FromUI1;                  external oleaut32 name 'VarR4FromUI1';
//function VarR4FromI2;                   external oleaut32 name 'VarR4FromI2';
//function VarR4FromI4;                   external oleaut32 name 'VarR4FromI4';
//function VarR4FromR8;                   external oleaut32 name 'VarR4FromR8';
//function VarR4FromCy;                   external oleaut32 name 'VarR4FromCy';
//function VarR4FromDate;                 external oleaut32 name 'VarR4FromDate';
//function VarR4FromStr;                  external oleaut32 name 'VarR4FromStr';
//function VarR4FromDisp;                 external oleaut32 name 'VarR4FromDisp';
//function VarR4FromBool;                 external oleaut32 name 'VarR4FromBool';
//function VarR4FromI1;                   external oleaut32 name 'VarR4FromI1';
//function VarR4FromUI2;                  external oleaut32 name 'VarR4FromUI2';
//function VarR4FromUI4;                  external oleaut32 name 'VarR4FromUI4';
//function VarR4FromDec;                  external oleaut32 name 'VarR4FromDec';
//function VarR8FromUI1;                  external oleaut32 name 'VarR8FromUI1';
//function VarR8FromI2;                   external oleaut32 name 'VarR8FromI2';
//function VarR8FromI4;                   external oleaut32 name 'VarR8FromI4';
//function VarR8FromR4;                   external oleaut32 name 'VarR8FromR4';
//function VarR8FromCy;                   external oleaut32 name 'VarR8FromCy';
//function VarR8FromDate;                 external oleaut32 name 'VarR8FromDate';
//function VarR8FromStr;                  external oleaut32 name 'VarR8FromStr';
//function VarR8FromDisp;                 external oleaut32 name 'VarR8FromDisp';
//function VarR8FromBool;                 external oleaut32 name 'VarR8FromBool';
//function VarR8FromI1;                   external oleaut32 name 'VarR8FromI1';
//function VarR8FromUI2;                  external oleaut32 name 'VarR8FromUI2';
//function VarR8FromUI4;                  external oleaut32 name 'VarR8FromUI4';
//function VarR8FromDec;                  external oleaut32 name 'VarR8FromDec';
//function VarDateFromUI1;                external oleaut32 name 'VarDateFromUI1';
//function VarDateFromI2;                 external oleaut32 name 'VarDateFromI2';
//function VarDateFromI4;                 external oleaut32 name 'VarDateFromI4';
//function VarDateFromR4;                 external oleaut32 name 'VarDateFromR4';
//function VarDateFromR8;                 external oleaut32 name 'VarDateFromR8';
//function VarDateFromCy;                 external oleaut32 name 'VarDateFromCy';
//function VarDateFromStr;                external oleaut32 name 'VarDateFromStr';
//function VarDateFromDisp;               external oleaut32 name 'VarDateFromDisp';
//function VarDateFromBool;               external oleaut32 name 'VarDateFromBool';
//function VarDateFromI1;                 external oleaut32 name 'VarDateFromI1';
//function VarDateFromUI2;                external oleaut32 name 'VarDateFromUI2';
//function VarDateFromUI4;                external oleaut32 name 'VarDateFromUI4';
//function VarDateFromDec;                external oleaut32 name 'VarDateFromDec';
//function VarCyFromUI1;                  external oleaut32 name 'VarCyFromUI1';
//function VarCyFromI2;                   external oleaut32 name 'VarCyFromI2';
//function VarCyFromI4;                   external oleaut32 name 'VarCyFromI4';
//function VarCyFromR4;                   external oleaut32 name 'VarCyFromR4';
//function VarCyFromR8;                   external oleaut32 name 'VarCyFromR8';
//function VarCyFromDate;                 external oleaut32 name 'VarCyFromDate';
//function VarCyFromStr;                  external oleaut32 name 'VarCyFromStr';
//function VarCyFromDisp;                 external oleaut32 name 'VarCyFromDisp';
//function VarCyFromBool;                 external oleaut32 name 'VarCyFromBool';
//function VarCyFromI1;                   external oleaut32 name 'VarCyFromI1';
//function VarCyFromUI2;                  external oleaut32 name 'VarCyFromUI2';
//function VarCyFromUI4;                  external oleaut32 name 'VarCyFromUI4';
//function VarCyFromDec;                  external oleaut32 name 'VarCyFromDec';
//function VarBStrFromUI1;                external oleaut32 name 'VarBStrFromUI1';
//function VarBStrFromI2;                 external oleaut32 name 'VarBStrFromI2';
//function VarBStrFromI4;                 external oleaut32 name 'VarBStrFromI4';
//function VarBStrFromR4;                 external oleaut32 name 'VarBStrFromR4';
//function VarBStrFromR8;                 external oleaut32 name 'VarBStrFromR8';
//function VarBStrFromCy;                 external oleaut32 name 'VarBStrFromCy';
//function VarBStrFromDate;               external oleaut32 name 'VarBStrFromDate';
//function VarBStrFromDisp;               external oleaut32 name 'VarBStrFromDisp';
//function VarBStrFromBool;               external oleaut32 name 'VarBStrFromBool';
//function VarBstrFromI1;                 external oleaut32 name 'VarBstrFromI1';
//function VarBstrFromUI2;                external oleaut32 name 'VarBstrFromUI2';
//function VarBstrFromUI4;                external oleaut32 name 'VarBstrFromUI4';
//function VarBstrFromDec;                external oleaut32 name 'VarBstrFromDec';
//function VarBoolFromUI1;                external oleaut32 name 'VarBoolFromUI1';
//function VarBoolFromI2;                 external oleaut32 name 'VarBoolFromI2';
//function VarBoolFromI4;                 external oleaut32 name 'VarBoolFromI4';
//function VarBoolFromR4;                 external oleaut32 name 'VarBoolFromR4';
//function VarBoolFromR8;                 external oleaut32 name 'VarBoolFromR8';
//function VarBoolFromDate;               external oleaut32 name 'VarBoolFromDate';
//function VarBoolFromCy;                 external oleaut32 name 'VarBoolFromCy';
//function VarBoolFromStr;                external oleaut32 name 'VarBoolFromStr';
//function VarBoolFromDisp;               external oleaut32 name 'VarBoolFromDisp';
//function VarBoolFromI1;                 external oleaut32 name 'VarBoolFromI1';
//function VarBoolFromUI2;                external oleaut32 name 'VarBoolFromUI2';
//function VarBoolFromUI4;                external oleaut32 name 'VarBoolFromUI4';
//function VarBoolFromDec;                external oleaut32 name 'VarBoolFromDec';
function LHashValOfNameSys(syskind: TSysKind; lcid: TLCID;
  szName: POleStr): Longint; stdcall;external oleaut32 name 'LHashValOfNameSys';
function LHashValOfNameSysA(syskind: TSysKind; lcid: TLCID;
  szName: PAnsiChar): Longint; stdcall;external oleaut32 name 'LHashValOfNameSysA';
function LoadTypeLib(szFile: POleStr; out tlib: ITypeLib): HResult; stdcall;external oleaut32 name 'LoadTypeLib';
function LoadTypeLibEx(szFile: POleStr; regkind: TRegKind; out tlib: ITypeLib): HResult; stdcall;external oleaut32 name 'LoadTypeLibEx';
function LoadRegTypeLib(const guid: TGUID; wVerMajor, wVerMinor: Word;
  lcid: TLCID; out tlib: ITypeLib): HResult; stdcall;external oleaut32 name 'LoadRegTypeLib';
function QueryPathOfRegTypeLib(const guid: TGUID; wMaj, wMin: Word;
  lcid: TLCID; out bstrPathName: WideString): HResult; stdcall;external oleaut32 name 'QueryPathOfRegTypeLib';
function RegisterTypeLib(tlib: ITypeLib; szFullPath, szHelpDir: POleStr): HResult; stdcall;external oleaut32 name 'RegisterTypeLib';
function UnRegisterTypeLib(const libID: TGUID; wVerMajor, wVerMinor: Word;
  lcid: TLCID; syskind: TSysKind): HResult; stdcall;external oleaut32 name 'UnRegisterTypeLib';
function CreateTypeLib(syskind: TSysKind; szFile: POleStr;
  out ctlib: ICreateTypeLib): HResult; stdcall;external oleaut32 name 'CreateTypeLib';
function CreateTypeLib2(syskind: TSysKind; szFile: POleStr;
  out ctlib: ICreateTypeLib2): HResult; stdcall;external oleaut32 name 'CreateTypeLib2';
function DispGetParam(const dispparams: TDispParams; position: Integer;
  vtTarg: TVarType; var varResult: OleVariant; var puArgErr: Integer): HResult; stdcall;external oleaut32 name 'DispGetParam';
function DispGetIDsOfNames(tinfo: ITypeInfo; rgszNames: POleStrList;
  cNames: Integer; rgdispid: PDispIDList): HResult; stdcall;external oleaut32 name 'DispGetIDsOfNames';
function DispInvoke(This: Pointer; tinfo: ITypeInfo; dispidMember: TDispID;
  wFlags: Word; var params: TDispParams; varResult: PVariant;
  excepinfo: PExcepInfo; puArgErr: PInteger): HResult; stdcall;external oleaut32 name 'DispInvoke';
function CreateDispTypeInfo(var idata: TInterfaceData; lcid: TLCID;
  out tinfo: ITypeInfo): HResult; stdcall;external oleaut32 name 'CreateDispTypeInfo';
function CreateStdDispatch(unkOuter: IUnknown; pvThis: Pointer;
  tinfo: ITypeInfo; out unkStdDisp: IUnknown): HResult; stdcall; external oleaut32 name 'CreateStdDispatch';
function DispCallFunc(pvInstance: Pointer; oVft: Longint; cc: TCallConv;
  vtReturn: TVarType; cActuals: Longint; var rgvt: TVarType; var prgpvarg: OleVariant;
  var vargResult: OleVariant): HResult; stdcall; external oleaut32 name 'DispCallFunc';
function RegisterActiveObject(unk: IUnknown; const clsid: TCLSID;
  dwFlags: Longint; out dwRegister: Longint): HResult; stdcall; external oleaut32 name 'RegisterActiveObject';
function RevokeActiveObject(dwRegister: Longint; pvReserved: Pointer): HResult; stdcall; external oleaut32 name 'RevokeActiveObject';
function GetActiveObject(const clsid: TCLSID; pvReserved: Pointer;
  out unk: IUnknown): HResult; stdcall; external oleaut32 name 'GetActiveObject';
function SetErrorInfo(dwReserved: Longint; errinfo: IErrorInfo): HResult; stdcall; external oleaut32 name 'SetErrorInfo';
function GetErrorInfo(dwReserved: Longint; out errinfo: IErrorInfo): HResult; stdcall; external oleaut32 name 'GetErrorInfo';
function CreateErrorInfo(out errinfo: ICreateErrorInfo): HResult; stdcall; external oleaut32 name 'CreateErrorInfo';
function OaBuildVersion: Longint; stdcall; external oleaut32 name 'OaBuildVersion';
procedure ClearCustData(var pCustData: TCustData); stdcall; external oleaut32 name 'ClearCustData';

implementation

end.