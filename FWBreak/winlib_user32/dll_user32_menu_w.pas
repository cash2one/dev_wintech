{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_menu_w;

interface

uses
  atmcmbaseconst, winconst, wintype;

  function LoadMenuW(hInstance: HINST; lpMenuName: PWideChar): HMENU; stdcall; external user32 name 'LoadMenuW';
  function LoadMenuIndirectW(lpMenuTemplate: Pointer): HMENU; stdcall; external user32 name 'LoadMenuIndirectW';


  function GetMenuStringW(hMenu: HMENU; uIDItem: UINT; lpString: PWideChar;
    nMaxCount: Integer; uFlag: UINT): Integer; stdcall; external user32 name 'GetMenuStringW';

  function InsertMenuW(hMenu: HMENU; uPosition, uFlags, uIDNewItem: UINT;
    lpNewItem: PWideChar): BOOL; stdcall; external user32 name 'InsertMenuW';
  function AppendMenuW(hMenu: HMENU; uFlags, uIDNewItem: UINT;
    lpNewItem: PWideChar): BOOL; stdcall; external user32 name 'AppendMenuW';
  function ModifyMenuW(hMnu: HMENU; uPosition, uFlags, uIDNewItem: UINT;
    lpNewItem: PWideChar): BOOL; stdcall; external user32 name 'ModifyMenuW';

  function ChangeMenuW(hMenu: HMENU; cmd: UINT; lpszNewItem: PWideChar;
    cmdInsert: UINT; flags: UINT): BOOL; stdcall; external user32 name 'ChangeMenuW';


type
  PMenuItemInfoW = ^TMenuItemInfoW;
  TMenuItemInfoW = packed record
    cbSize: UINT;
    fMask: UINT;
    fType: UINT;             { used if MIIM_TYPE}
    fState: UINT;            { used if MIIM_STATE}
    wID: UINT;               { used if MIIM_ID}
    hSubMenu: HMENU;         { used if MIIM_SUBMENU}
    hbmpChecked: HBITMAP;    { used if MIIM_CHECKMARKS}
    hbmpUnchecked: HBITMAP;  { used if MIIM_CHECKMARKS}
    dwItemData: DWORD;       { used if MIIM_DATA}
    dwTypeData: PWideChar;      { used if MIIM_TYPE}
    cch: UINT;               { used if MIIM_TYPE}
    hbmpItem: HBITMAP;       { used if MIIM_BITMAP}
  end;

  function GetMenuItemInfoW(p1: HMENU; p2: UINT; p3: BOOL;
    var p4: TMenuItemInfoW): BOOL; stdcall; external user32 name 'GetMenuItemInfoW';
  function SetMenuItemInfoW(p1: HMENU; p2: UINT; p3: BOOL;
    const p4: TMenuItemInfoW): BOOL; stdcall; external user32 name 'SetMenuItemInfoW';

  function InsertMenuItemW(p1: HMENU; p2: UINT; p3: BOOL;
    const p4: TMenuItemInfoW): BOOL; stdcall; external user32 name 'InsertMenuItemW';

implementation

end.
