{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_clipboard;

interface
                 
uses
  atmcmbaseconst, winconst, wintype;

  function OpenClipboard(hWndNewOwner: HWND): BOOL; stdcall; external user32 name 'OpenClipboard';
  function CloseClipboard: BOOL; stdcall; external user32 name 'CloseClipboard';
  function GetClipboardSequenceNumber: DWORD; stdcall; external user32 name 'GetClipboardSequenceNumber';

  function GetClipboardOwner: HWND; stdcall; external user32 name 'GetClipboardOwner';

  function SetClipboardViewer(hWndNewViewer: HWND): HWND; stdcall; external user32 name 'SetClipboardViewer';
  function GetClipboardViewer: HWND; stdcall; external user32 name 'GetClipboardViewer';
  function ChangeClipboardChain(hWndRemove, hWndNewNext: HWND): BOOL; stdcall; external user32 name 'ChangeClipboardChain';
  function SetClipboardData(uFormat: UINT; hMem: THandle): THandle; stdcall; external user32 name 'SetClipboardData';
  function GetClipboardData(uFormat: UINT): THandle; stdcall; external user32 name 'GetClipboardData';
  function RegisterClipboardFormatA(lpszFormat: PAnsiChar): UINT; stdcall; external user32 name 'RegisterClipboardFormatA';
  function CountClipboardFormats: Integer; stdcall; external user32 name 'CountClipboardFormats';
  function EnumClipboardFormats(format: UINT): UINT; stdcall; external user32 name 'EnumClipboardFormats';
  function GetClipboardFormatNameA(format: UINT; lpszFormatName: PAnsiChar;
    cchMaxCount: Integer): Integer; stdcall; external user32 name 'GetClipboardFormatNameA';
  function EmptyClipboard: BOOL; stdcall; external user32 name 'EmptyClipboard';
  function IsClipboardFormatAvailable(format: UINT): BOOL; stdcall; external user32 name 'IsClipboardFormatAvailable';
  function GetPriorityClipboardFormat(var paFormatPriorityList;
    cFormats: Integer): Integer; stdcall; external user32 name 'GetPriorityClipboardFormat';
  function GetOpenClipboardWindow: HWND; stdcall; external user32 name 'GetOpenClipboardWindow';

//
//const
//{ Clipboard format which may be supported by IDataObject from system
//  defined shell folders (such as directories, network, ...). }
//  CFSTR_SHELLIDLIST           = 'Shell IDList Array';     { CF_IDLIST }
//  CFSTR_SHELLIDLISTOFFSET     = 'Shell Object Offsets';   { CF_OBJECTPOSITIONS }
//  CFSTR_NETRESOURCES          = 'Net Resource';           { CF_NETRESOURCE }
//  CFSTR_FILEDESCRIPTORA       = 'FileGroupDescriptor';    { CF_FILEGROUPDESCRIPTORA }
//  CFSTR_FILEDESCRIPTORW       = 'FileGroupDescriptorW';   { CF_FILEGROUPDESCRIPTORW }
//  CFSTR_FILECONTENTS          = 'FileContents';           { CF_FILECONTENTS }
//  CFSTR_FILENAMEA             = 'FileName';               { CF_FILENAMEA }
//  CFSTR_FILENAMEW             = 'FileNameW';              { CF_FILENAMEW }
//  CFSTR_PRINTERGROUP          = 'PrinterFriendlyName';    { CF_PRINTERS }
//  CFSTR_FILENAMEMAPA          = 'FileNameMap';            { CF_FILENAMEMAPA }
//  CFSTR_FILENAMEMAPW          = 'FileNameMapW';           { CF_FILENAMEMAPW }
//  CFSTR_SHELLURL              = 'UniformResourceLocator';
//  CFSTR_PREFERREDDROPEFFECT   = 'Preferred DropEffect';
//  CFSTR_PERFORMEDDROPEFFECT   = 'Performed DropEffect';
//  CFSTR_PASTESUCCEEDED        = 'Paste Succeeded';
//  CFSTR_INDRAGLOOP            = 'InShellDragLoop';
//
//  CFSTR_FILEDESCRIPTOR        = CFSTR_FILEDESCRIPTORA;
//  CFSTR_FILENAME              = CFSTR_FILENAMEA;
//  CFSTR_FILENAMEMAP           = CFSTR_FILENAMEMAPA;
//{ CF_OBJECTPOSITIONS }
//  DVASPECT_SHORTNAME     = 2; { use for CF_HDROP to get short name version }
//  
implementation

end.
