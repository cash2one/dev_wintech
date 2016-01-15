{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_menu;

interface

uses
  atmcmbaseconst, winconst, wintype;

const
  MF_INSERT = 0;
  MF_CHANGE = $80;
  MF_APPEND = $100;
  MF_DELETE = $200;
  MF_REMOVE = $1000;

  MF_BYCOMMAND = 0;
  MF_BYPOSITION = $400;

  MF_SEPARATOR = $800;

  MF_ENABLED = 0;
  MF_GRAYED = 1;
  MF_DISABLED = 2;

  MF_UNCHECKED = 0;
  MF_CHECKED = 8;
  MF_USECHECKBITMAPS = $200;

  MF_STRING = 0;
  MF_BITMAP = 4;
  MF_OWNERDRAW = $100;

  MF_POPUP = $10;
  MF_MENUBARBREAK = $20;
  MF_MENUBREAK = $40;

  MF_UNHILITE = 0;
  MF_HILITE = $80;

  MF_DEFAULT = $1000;
  MF_SYSMENU = $2000;
  MF_HELP = $4000;
  MF_RIGHTJUSTIFY = $4000;

  MF_MOUSESELECT = $8000;
  MF_END = $80;            { Obsolete -- only used by old RES files }

  MFT_STRING = MF_STRING;
  MFT_BITMAP = MF_BITMAP;
  MFT_MENUBARBREAK = MF_MENUBARBREAK;
  MFT_MENUBREAK = MF_MENUBREAK;
  MFT_OWNERDRAW = MF_OWNERDRAW;
  MFT_RADIOCHECK = $200;
  MFT_SEPARATOR = MF_SEPARATOR;
  MFT_RIGHTORDER = $2000;
  MFT_RIGHTJUSTIFY = MF_RIGHTJUSTIFY;

  { Menu flags for AddCheckEnableMenuItem() }
  MFS_GRAYED = 3;
  MFS_DISABLED = MFS_GRAYED;
  MFS_CHECKED = MF_CHECKED;
  MFS_HILITE = MF_HILITE;
  MFS_ENABLED = MF_ENABLED;
  MFS_UNCHECKED = MF_UNCHECKED;
  MFS_UNHILITE = MF_UNHILITE;
  MFS_DEFAULT = MF_DEFAULT;

  MFS_MASK = $108B;
  MFS_HOTTRACKDRAWN = $10000000;
  MFS_CACHEDBMP = $20000000;
  MFS_BOTTOMGAPDROP = $40000000;
  MFS_TOPGAPDROP = $80000000;
  MFS_GAPDROP = $C0000000;

  { MENUGETOBJECTINFO dwFlags values }
  MNGOF_GAP = 3;

  { MENUGETOBJECT returns values }
  MNGO_NOINTERFACE = 0;
  MNGO_NOERROR = 1;

  MIIM_STATE = 1;
  MIIM_ID = 2;
  MIIM_SUBMENU = 4;
  MIIM_CHECKMARKS = 8;
  MIIM_TYPE = $10;
  MIIM_DATA = $20;
  MIIM_STRING = $40;
  MIIM_BITMAP = $80;
  MIIM_FTYPE = $100;

  HBMMENU_CALLBACK = -1;
  HBMMENU_SYSTEM = 1;
  HBMMENU_MBAR_RESTORE = 2;
  HBMMENU_MBAR_MINIMIZE = 3;
  HBMMENU_MBAR_CLOSE = 5;
  HBMMENU_MBAR_CLOSE_D = 6;
  HBMMENU_MBAR_MINIMIZE_D = 7;
  HBMMENU_POPUP_CLOSE = 8;
  HBMMENU_POPUP_RESTORE = 9;
  HBMMENU_POPUP_MAXIMIZE = 10;
  HBMMENU_POPUP_MINIMIZE = 11;
                      
  { WM_MENUDRAG return values }
  MND_CONTINUE = 0;
  MND_ENDMENU = 1;

  function CreateMenu: HMENU; stdcall; external user32 name 'CreateMenu';
  function CreatePopupMenu: HMENU; stdcall; external user32 name 'CreatePopupMenu';
  function DestroyMenu(AMenu: HMENU): BOOL; stdcall; external user32 name 'DestroyMenu';
  function LoadMenu(AInstance: HINST; lpMenuName: PAnsiChar): HMENU; stdcall; external user32 name 'LoadMenuA';
  function LoadMenuIndirect(lpMenuTemplate: Pointer): HMENU; stdcall; external user32 name 'LoadMenuIndirectA';

  function GetMenu(AWnd: HWND): HMENU; stdcall; external user32 name 'GetMenu';
  function GetSubMenu(AMenu: HMENU; nPos: Integer): HMENU; stdcall; external user32 name 'GetSubMenu';
  function GetSystemMenu(AWnd: HWND; bRevert: BOOL): HMENU; stdcall; external user32 name 'GetSystemMenu';

(*
procedure TCustomForm.WMNCCreate(var Message: TWMNCCreate);

procedure ModifySystemMenu;
var
    SysMenu: HMENU;
begin
    ……
    { Modify the system menu to look more like it's s'pose to }
    SysMenu := GetSystemMenu(Handle, False);
    if FBorderStyle = bsDialog then
    begin
        { Make the system menu look like a dialog which has only
        Move and Close }
        DeleteMenu(SysMenu, SC_TASKLIST, MF_BYCOMMAND);
        DeleteMenu(SysMenu, 7, MF_BYPOSITION);
        DeleteMenu(SysMenu, 5, MF_BYPOSITION);
        DeleteMenu(SysMenu, SC_MAXIMIZE, MF_BYCOMMAND);
        DeleteMenu(SysMenu, SC_MINIMIZE, MF_BYCOMMAND);

        DeleteMenu(SysMenu, SC_SIZE, MF_BYCOMMAND);
        不响应WM_SIZE消息（SC_SIZE被删掉）

        DeleteMenu(SysMenu, SC_RESTORE, MF_BYCOMMAND);
    end else
    ……
end;

begin
    inherited;
    SetMenu(FMenu);
    if not (csDesigning in ComponentState) then ModifySystemMenu;
end;
*)
type
  PMenuInfo = ^TMenuInfo;
  TMenuInfo = packed record
    cbSize: DWORD;
    fMask: DWORD;
    dwStyle: DWORD;
    cyMax: UINT;
    hbrBack: HBRUSH;
    dwContextHelpID: DWORD;
    dwMenuData: DWORD;
  end;

  function GetMenuInfo(AMenu: HMENU; var lpmi: TMenuInfo): BOOL; stdcall; external user32 name 'GetMenuInfo';
  function SetMenuInfo(AMenu: HMENU; const lpcmi: TMenuInfo): BOOL; stdcall; external user32 name 'SetMenuInfo';

  function EndMenu: BOOL; stdcall; external user32 name 'EndMenu';

type
  PMenuBarInfo = ^TMenuBarInfo;
  TMenuBarInfo = packed record
    cbSize: DWORD;
    rcBar: TRect;        { rect of bar, popup, item }
    hMenu: HMENU;        { real menu handle of bar, popup }
    hwndMenu: HWND;      { hwnd of item submenu if one }
{    fBarFocused:1: BOOL;} { bar, popup has the focus }
{    fFocused:1: BOOL; }  { item has the focus }
    FocusedBits: BYTE;
  end;

  function GetMenuBarInfo(AWnd: HWND; idObject, idItem: Longint;
    var pmbi: TMenuBarInfo): BOOL; stdcall; external user32 name 'GetMenuBarInfo';
  function GetMenuString(AMenu: HMENU; uIDItem: UINT; lpString: PAnsiChar;
    nMaxCount: Integer; uFlag: UINT): Integer; stdcall; external user32 name 'GetMenuStringA';

  function GetMenuState(AMenu: HMENU; uId, uFlags: UINT): UINT; stdcall; external user32 name 'GetMenuState';
  function GetMenuCheckMarkDimensions: Longint; stdcall; external user32 name 'GetMenuCheckMarkDimensions';
  function GetMenuContextHelpId(AMenu: HMENU): DWORD; stdcall; external user32 name 'GetMenuContextHelpId';
  function SetMenuContextHelpId(AMenu: HMENU; HelpID: DWORD): BOOL; stdcall;external user32 name 'SetMenuContextHelpId';

  function GetMenuDefaultItem(AMenu: HMENU; fByPos, gmdiFlags: UINT): UINT; stdcall; external user32 name 'GetMenuDefaultItem';
  function SetMenuDefaultItem(AMenu: HMENU; uItem, fByPos: UINT): BOOL; stdcall; external user32 name 'SetMenuDefaultItem';

  function TrackPopupMenu(AMenu: HMENU; uFlags: UINT; x, y, nReserved: Integer;
    AWnd: HWND; prcRect: PRect): BOOL; stdcall; external user32 name 'TrackPopupMenu';

type
  PTPMParams = ^TTPMParams;
  TTPMParams = packed record
    cbSize: UINT;     { Size of structure }
    rcExclude: TRect; { Screen coordinates of rectangle to exclude when positioning }
  end;

  function TrackPopupMenuEx(AMenu: HMENU; Flags: UINT; x, y: Integer;
    Wnd: HWND; TPMParams: PTPMParams): BOOL; stdcall; external user32 name 'TrackPopupMenuEx';

  function InsertMenu(AMenu: HMENU; uPosition, uFlags, uIDNewItem: UINT;
    lpNewItem: PAnsiChar): BOOL; stdcall; external user32 name 'InsertMenuA';
  function AppendMenu(AMenu: HMENU; uFlags, uIDNewItem: UINT;
    lpNewItem: PAnsiChar): BOOL; stdcall; external user32 name 'AppendMenuA';
  function ModifyMenu(AMnu: HMENU; uPosition, uFlags, uIDNewItem: UINT;
    lpNewItem: PAnsiChar): BOOL; stdcall; external user32 name 'ModifyMenuA';

  function RemoveMenu(AMenu: HMENU; uPosition, uFlags: UINT): BOOL; stdcall; external user32 name 'RemoveMenu';
  function DeleteMenu(AMenu: HMENU; uPosition, uFlags: UINT): BOOL; stdcall; external user32 name 'DeleteMenu';
  function ChangeMenu(AMenu: HMENU; cmd: UINT; lpszNewItem: PAnsiChar;
    cmdInsert: UINT; flags: UINT): BOOL; stdcall; external user32 name 'ChangeMenuA';
  function DrawMenuBar(AWnd: HWND): BOOL; stdcall; external user32 name 'DrawMenuBar';
  function SetMenu(AWnd: HWND; AMenu: HMENU): BOOL; stdcall; external user32 name 'SetMenu';


  function GetMenuItemID(AMenu: HMENU; nPos: Integer): UINT; stdcall; external user32 name 'GetMenuItemID';
  function GetMenuItemCount(AMenu: HMENU): Integer; stdcall; external user32 name 'GetMenuItemCount';

type
  PMenuItemInfo = ^TMenuItemInfo;
  TMenuItemInfo = packed record
    cbSize: UINT;
    fMask: UINT;
    fType: UINT;             { used if MIIM_TYPE}
    fState: UINT;            { used if MIIM_STATE}
    wID: UINT;               { used if MIIM_ID}
    hSubMenu: HMENU;         { used if MIIM_SUBMENU}
    hbmpChecked: HBITMAP;    { used if MIIM_CHECKMARKS}
    hbmpUnchecked: HBITMAP;  { used if MIIM_CHECKMARKS}
    dwItemData: DWORD;       { used if MIIM_DATA}
    dwTypeData: PAnsiChar;      { used if MIIM_TYPE}
    cch: UINT;               { used if MIIM_TYPE}
    hbmpItem: HBITMAP;       { used if MIIM_BITMAP}
  end;

  function GetMenuItemInfo(p1: HMENU; p2: UINT; p3: BOOL;
    var p4: TMenuItemInfo): BOOL; stdcall; external user32 name 'GetMenuItemInfoA';
  function SetMenuItemInfo(p1: HMENU; p2: UINT; p3: BOOL;
    const p4: TMenuItemInfo): BOOL; stdcall; external user32 name 'SetMenuItemInfoA';

  function GetMenuItemRect(AWnd: HWND; hMenu: HMENU; uItem: UINT;
    var lprcItem: TRect): BOOL; stdcall; external user32 name 'GetMenuItemRect';

  function MenuItemFromPoint(AWnd: HWND; hMenu: HMENU;
    ptScreen: TPoint): BOOL; stdcall; external user32 name 'MenuItemFromPoint';

  function CheckMenuItem(AMenu: HMENU; uIDCheckItem, uCheck: UINT): DWORD; stdcall; external user32 name 'CheckMenuItem';
  function CheckMenuRadioItem(AMenu: HMENU; First, Last, Check,
    Flags: UINT): BOOL; stdcall; external user32 name 'CheckMenuRadioItem';

(*
  用下面的代码使关闭按钮无效：
　EnableMenultem(GetSystemMenu(hwnd，FALSE)，SC_CLOSE，MF_BYCOMMAND I MF_GRAYED)
*)
  function EnableMenuItem(AMenu: HMENU; uIDEnableItem,
    uEnable: UINT): BOOL; stdcall; external user32 name 'EnableMenuItem';
  function SetMenuItemBitmaps(hMenu: HMENU; uPosition, uFlags: UINT;
    hBitmapUnchecked: HBITMAP; hBitmapChecked: HBITMAP): BOOL; stdcall; external user32 name 'SetMenuItemBitmaps';

  function HiliteMenuItem(AWnd: HWND; hMenu: HMENU; uIDHiliteItem: UINT;
    uHilite: UINT): BOOL; stdcall; external user32 name 'HiliteMenuItem';

  function InsertMenuItem(p1: HMENU; p2: UINT; p3: BOOL;
    const p4: TMenuItemInfo): BOOL; stdcall; external user32 name 'InsertMenuItemA';

type
  PMenuGetObjectInfo = ^TMenuGetObjectInfo;
  TMenuGetObjectInfo = packed record
    dwFlags: DWORD;
    uPos: UINT;
    hmenu: HMENU;
    riid: Pointer;
    pvObj: Pointer;
  end;

const    
  { Flags for TrackPopupMenu }
  TPM_LEFTBUTTON = 0;
  TPM_RIGHTBUTTON = 2;
  TPM_LEFTALIGN = 0;
  TPM_CENTERALIGN = 4;
  TPM_RIGHTALIGN = 8;
  TPM_TOPALIGN = 0;
  TPM_VCENTERALIGN = $10;
  TPM_BOTTOMALIGN = $20;

  TPM_HORIZONTAL = 0;   { Horz alignment matters more }
  TPM_VERTICAL = $40;   { Vert alignment matters more }
  TPM_NONOTIFY = $80;   { Don't send any notification msgs }
  TPM_RETURNCMD = $100;
  TPM_RECURSE = $1;
  TPM_HORPOSANIMATION = $0400;
  TPM_HORNEGANIMATION = $0800;
  TPM_VERPOSANIMATION = $1000;
  TPM_VERNEGANIMATION = $2000;
  TPM_NOANIMATION     = $4000;

  
//
//  MENUSTYLE class parts and states
//
const
  VSCLASS_MENUSTYLE       = 'MENUSTYLE';
  VSCLASS_MENU    = 'MENU';

type
  MENUPARTS = Integer;
const
  MENUPartFiller0 = 0;
  MP_MENUITEM = 1;
  MP_MENUDROPDOWN = 2;
  MP_MENUBARITEM = 3;
  MP_MENUBARDROPDOWN = 4;
  MP_CHEVRON = 5;
  MP_SEPARATOR = 6;

  { For Windows >= Vista }
  MENU_MENUITEM_TMSCHEMA     = 1;
  MENU_MENUDROPDOWN_TMSCHEMA     = 2;
  MENU_MENUBARITEM_TMSCHEMA     = 3;
  MENU_MENUBARDROPDOWN_TMSCHEMA     = 4;
  MENU_CHEVRON_TMSCHEMA     = 5;
  MENU_SEPARATOR_TMSCHEMA     = 6;
  MENU_BARBACKGROUND     = 7;
  MENU_BARITEM     = 8;
  MENU_POPUPBACKGROUND     = 9;
  MENU_POPUPBORDERS     = 10;
  MENU_POPUPCHECK     = 11;
  MENU_POPUPCHECKBACKGROUND     = 12;
  MENU_POPUPGUTTER     = 13;
  MENU_POPUPITEM     = 14;
  MENU_POPUPSEPARATOR     = 15;
  MENU_POPUPSUBMENU     = 16;
  MENU_SYSTEMCLOSE     = 17;
  MENU_SYSTEMMAXIMIZE     = 18;
  MENU_SYSTEMMINIMIZE     = 19;
  MENU_SYSTEMRESTORE     = 20;

type                          
  { for ownerdraw }
  PMeasureItemStruct = ^TMeasureItemStruct;
  TMeasureItemStruct = packed record
    CtlType: UINT;
    CtlID: UINT;
    itemID: UINT;
    itemWidth: UINT;
    itemHeight: UINT;
    itemData: DWORD;
  end;

  { for ownerdraw }
  PDrawItemStruct = ^TDrawItemStruct;
  TDrawItemStruct = packed record
    CtlType: UINT;
    CtlID: UINT;
    itemID: UINT;
    itemAction: UINT;
    itemState: UINT;
    hwndItem: HWND;
    hDC: HDC;
    rcItem: TRect;
    itemData: DWORD;
  end;

  { for ownerdraw }
  PDeleteItemStruct = ^TDeleteItemStruct;
  TDeleteItemStruct = packed record
    CtlType: UINT;
    CtlID: UINT;
    itemID: UINT;
    hwndItem: HWND;
    itemData: UINT;
  end;

  { for ownerdraw sorting }
  PCompareItemStruct = ^TCompareItemStruct;
  TCompareItemStruct = packed record
    CtlType: UINT;
    CtlID: UINT;
    hwndItem: HWND;
    itemID1: UINT;
    itemData1: DWORD;
    itemID2: UINT;
    itemData2: DWORD;
    dwLocaleId: DWORD;
  end;

implementation

end.
