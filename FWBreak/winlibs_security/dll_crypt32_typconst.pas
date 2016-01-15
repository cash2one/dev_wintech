{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_crypt32_typconst;

interface
               
uses
  atmcmbaseconst, wintype;
  
const
  Crypt32 = 'Crypt32.dll';
                  
type              
  PCRYPTOAPI_BLOB = ^TCRYPTOAPI_BLOB;
  TCRYPTOAPI_BLOB = packed record
    cbData        : DWORD;
    pbData        : PLargeBytes;
  end;

  PCRYPTPROTECT_PROMPTSTRUCT = ^TCRYPTPROTECT_PROMPTSTRUCT;
  TCRYPTPROTECT_PROMPTSTRUCT = packed record
    cbSize        : DWORD;
    dwPromptFlags : DWORD;
    hwndApp       : HWND;
    szPrompt      : LPCWSTR;
  end;
  TCryptProtectPromptStruct  = TCRYPTPROTECT_PROMPTSTRUCT;
  PCryptProtectPromptStruct  = ^TCryptProtectPromptStruct;

implementation

end.
