unit dll_ole32_intf;

interface 

uses
  atmcmbaseconst, winconst, wintype, dll_ole32, Intf_oledata;

  function RegisterDragDrop(Awnd: HWnd; dropTarget: IDropTarget): HResult; stdcall; external ole32 name 'RegisterDragDrop';
  function RevokeDragDrop(Awnd: HWnd): HResult; stdcall; external ole32 name 'RevokeDragDrop';

  { }
  function DoDragDrop(
    dataObj: Intf_oledata.IDataObject;
    dropSource: Intf_oledata.IDropSource;
    dwOKEffects: Longint; var dwEffect: Longint): HResult; stdcall; external ole32 name 'DoDragDrop';

const
  DRAGDROP_S_DROP   = $40100;
  DRAGDROP_S_CANCEL = $40101;
  DRAGDROP_S_USEDEFAULTCURSORS = $40102;

implementation

end.
