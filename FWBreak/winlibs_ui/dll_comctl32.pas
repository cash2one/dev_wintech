(*
        401    0 0001D2E2 AddMRUStringW
        400    1 0001D531 CreateMRUListW
          8    2 0001D931 CreateMappedBitmap
         12    3 00033991 CreatePropertySheetPage
         18    4 00033991 CreatePropertySheetPageA
         19    5 00033977 CreatePropertySheetPageW
         20    6 00038D16 CreateStatusWindow
          6    7 00038D16 CreateStatusWindowA
         21    8 00038CD9 CreateStatusWindowW
          7    9 00039076 CreateToolbar
         22    A 0001E56B CreateToolbarEx
         16    B 0003C155 CreateUpDownControl
        328    C 00010BD1 DPA_Create
        337    D 00011708 DPA_DeleteAllPtrs
        336    E 000167FA DPA_DeletePtr
        329    F 00006AC8 DPA_Destroy
        386   10 00010669 DPA_DestroyCallback
        385   11 000106A4 DPA_EnumCallback
        332   12 0000E3C6 DPA_GetPtr
        334   13 0000687C DPA_InsertPtr
        339   14 00032859 DPA_Search
        335   15 0001C6F9 DPA_SetPtr
        338   16 00010A83 DPA_Sort
        320   17 0000B171 DSA_Create
        327   18 00030001 DSA_DeleteAllItems
        321   19 00009CC4 DSA_Destroy
        388   1A 00011D16 DSA_DestroyCallback
        323   1B 0000860C DSA_GetItemPtr
        324   1C 0000B19E DSA_InsertItem
        413   1D 00005F9E DefSubclassProc
         23   1E 0003369C DestroyPropertySheetPage
         24   1F 0006ABBB DllGetVersion
         25   20 0003311D DllInstall
         15   21 0003DB33 DrawInsert
         26   22 00038E5C DrawStatusText
          5   23 00038E5C DrawStatusTextA
         27   24 00030557 DrawStatusTextW
        403   25 0001DF6A EnumMRUListW
         28   26 000408FF FlatSB_EnableScrollBar
         29   27 00040740 FlatSB_GetScrollInfo
         30   28 000404FE FlatSB_GetScrollPos
         31   29 0004055A FlatSB_GetScrollProp
         32   2A 000406BE FlatSB_GetScrollRange
         33   2B 00040AF4 FlatSB_SetScrollInfo
         34   2C 000409A3 FlatSB_SetScrollPos
         35   2D 00040BC3 FlatSB_SetScrollProp
         36   2E 00040A18 FlatSB_SetScrollRange
         37   2F 0004080C FlatSB_ShowScrollBar
        152   30 0001D744 FreeMRUList
          4   31 000322E9 GetEffectiveClientRect
         38   32 000413BA GetMUILanguage
         39   33 00042ED9 ImageList_Add
         40   34 00043BC4 ImageList_AddIcon
         41   35 00011FF8 ImageList_AddMasked
         42   36 00042C6D ImageList_BeginDrag
         43   37 00042F6B ImageList_Copy
         44   38 00010205 ImageList_Create
         45   39 000103D8 ImageList_Destroy
         46   3A 00042CB5 ImageList_DragEnter
         47   3B 00042D0E ImageList_DragLeave
         48   3C 00042CE3 ImageList_DragMove
         49   3D 00042D36 ImageList_DragShowNolock
         50   3E 0001DFF1 ImageList_Draw
         51   3F 000168FD ImageList_DrawEx
         52   40 0000C2D4 ImageList_DrawIndirect
         53   41 00042DC4 ImageList_Duplicate
         54   42 00042C2F ImageList_EndDrag
         55   43 00018480 ImageList_GetBkColor
         56   44 00042BEA ImageList_GetDragImage
         57   45 00043155 ImageList_GetFlags
         58   46 000322A2 ImageList_GetIcon
         59   47 0000E33A ImageList_GetIconSize
         60   48 0000D578 ImageList_GetImageCount
         61   49 00043005 ImageList_GetImageInfo
         62   4A 00042E4E ImageList_GetImageRect
         63   4B 00044AA5 ImageList_LoadImage
         64   4C 00044AA5 ImageList_LoadImageA
         65   4D 00044848 ImageList_LoadImageW
         66   4E 0004304D ImageList_Merge
         67   4F 00044081 ImageList_Read
         68   50 000106DF ImageList_Remove
         69   51 00042F20 ImageList_Replace
         70   52 0000C7F4 ImageList_ReplaceIcon
         75   53 0000B66C ImageList_SetBkColor
         76   54 00042B96 ImageList_SetDragCursorImage
         77   55 00043101 ImageList_SetFilter
         78   56 000430BC ImageList_SetFlags
         79   57 00042FBD ImageList_SetIconSize
         80   58 00042E94 ImageList_SetImageCount
         81   59 00031408 ImageList_SetOverlayImage
         82   5A 00042E09 ImageList_Write
         17   5B 000065CF InitCommonControls
         83   5C 00003619 InitCommonControlsEx
         84   5D 0004138D InitMUILanguage
         85   5E 00040EA2 InitializeFlatSB
         14   5F 0003DA26 LBItemFromPt
         13   60 0003DF6D MakeDragList
          2   61 00041004 MenuHelp
         86   62 00038C81 PropertySheet
         87   63 00038C81 PropertySheetA
         88   64 00038C69 PropertySheetW
        412   65 000061F4 RemoveWindowSubclass
        410   66 0000636A SetWindowSubclass
          3   67 000411F6 ShowHideMenuCtl
        236   68 0001D4B9 Str_SetPtrW
         89   69 00040D77 UninitializeFlatSB
         90   6A 00021226 _TrackMouseEvent
*)
unit dll_comctl32;

interface


{ Property Sheets }
function CreatePropertySheetPage; external cctrl name 'CreatePropertySheetPageA';
function CreatePropertySheetPageA; external cctrl name 'CreatePropertySheetPageA';
function CreatePropertySheetPageW; external cctrl name 'CreatePropertySheetPageW';
function DestroyPropertySheetPage; external cctrl name 'DestroyPropertySheetPage';
function PropertySheet; external cctrl name 'PropertySheetA';
function PropertySheetA; external cctrl name 'PropertySheetA';
function PropertySheetW; external cctrl name 'PropertySheetW';

{ Image List }
function ImageList_Create; external cctrl name 'ImageList_Create';
function ImageList_Destroy; external cctrl name 'ImageList_Destroy';
function ImageList_GetImageCount; external cctrl name 'ImageList_GetImageCount';
function ImageList_SetImageCount; external cctrl name 'ImageList_SetImageCount';
function ImageList_Add; external cctrl name 'ImageList_Add';
function ImageList_ReplaceIcon; external cctrl name 'ImageList_ReplaceIcon';
function ImageList_SetBkColor; external cctrl name 'ImageList_SetBkColor';
function ImageList_GetBkColor; external cctrl name 'ImageList_GetBkColor';
function ImageList_SetOverlayImage; external cctrl name 'ImageList_SetOverlayImage';

{ Flat Scrollbar APIs }

function FlatSB_EnableScrollBar;        external cctrl name 'FlatSB_EnableScrollBar';
function FlatSB_GetScrollInfo;          external cctrl name 'FlatSB_GetScrollInfo';
function FlatSB_GetScrollPos;           external cctrl name 'FlatSB_GetScrollPos';
function FlatSB_GetScrollProp;          external cctrl name 'FlatSB_GetScrollProp';
function FlatSB_GetScrollRange;         external cctrl name 'FlatSB_GetScrollRange';
function FlatSB_SetScrollInfo;          external cctrl name 'FlatSB_SetScrollInfo';
function FlatSB_SetScrollPos;           external cctrl name 'FlatSB_SetScrollPos';
function FlatSB_SetScrollProp;          external cctrl name 'FlatSB_SetScrollProp';
function FlatSB_SetScrollRange;         external cctrl name 'FlatSB_SetScrollRange';
function FlatSB_ShowScrollBar;          external cctrl name 'FlatSB_ShowScrollBar';
function InitializeFlatSB;              external cctrl name 'InitializeFlatSB';
procedure UninitializeFlatSB;           external cctrl name 'UninitializeFlatSB';


{ TrackMouseEvent }

function _TrackMouseEvent;              external cctrl name '_TrackMouseEvent';

implementation

end.