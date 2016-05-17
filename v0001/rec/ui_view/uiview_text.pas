unit uiview_text;

interface

type
  PUICharBufferW        = ^TUICharBufferW;
  TUICharBufferW        = packed record
    Data                : array[0..256 - 1] of WideChar;
  end;
  
  PUICharBufferW_8      = ^TUICharBufferW_8;
  TUICharBufferW_8      = packed record // 16
    Data                : array[0..7] of WideChar; // 8
  end;
                  
  PUICharBufferW_16     = ^TUICharBufferW_16;
  TUICharBufferW_16     = packed record // 16
    Data                : array[0..16 - 1] of WideChar; // 8
  end;
  
  PUICharBufferW_32     = ^TUICharBufferW_32;
  TUICharBufferW_32     = packed record // 64
    Data                : array[0..32 - 1] of WideChar; // 8
  end;

  PUICharBufferW_64     = ^TUICharBufferW_64;
  TUICharBufferW_64     = packed record // 128
    Data                : array[0..64 - 1] of WideChar; // 8
  end;

  PUICharBufferW_128    = ^TUICharBufferW_128;
  TUICharBufferW_128    = packed record // 256
    Data                : array[0..128 - 1] of WideChar; // 8
  end;

  PUICharBufferW_256    = ^TUICharBufferW_256;
  TUICharBufferW_256    = packed record // 512
    Data                : array[0..256 - 1] of WideChar; // 8
  end;
  
  PUICharBufferNodeW    = ^TUICharBufferNodeW;
  TUICharBufferNodeW    = packed record       // 14
    PrevSibling         : PUICharBufferNodeW;
    NextSibling         : PUICharBufferNodeW;
    Buffer              : PUICharBufferW;
    ExParam             : Pointer; // 4
    BufferSize          : Byte;  // 1
    BufferLen           : Byte;  // 1
  end;
          
  PUITextLineW          = ^TUITextLineW;
  TUITextLineW          = packed record        // 8
    FirstCharBufferNode : PUICharBufferNodeW;
    LastCharBufferNode  : PUICharBufferNodeW;  
    ExParam             : Pointer; // 4
    TextLineLength      : Word;  // 1
  end;
            
  PUITextLineNodeW      = ^TUITextLineNodeW;
  TUITextLineNodeW      = packed record       // 8
    PrevSibling         : PUITextLineNodeW;
    NextSibling         : PUITextLineNodeW;
    TextLine            : PUITextLineW;
  end;
              
  PUITextMultiLineW     = ^TUITextMultiLineW;
  TUITextMultiLineW     = packed record        // 8
    FirstTextLineNode   : PUITextLineNodeW;
    LastTextLineNode    : PUITextLineNodeW;  
    ExParam             : Pointer; // 4
    LineCount           : Integer;  // 1
  end;
               
  PUITextLinePos        = ^TUITextLinePos;
  TUITextLinePos        = packed record
    CurrentNode         : PUICharBufferNodeW;
    Position            : Integer;
  end;

  //function CheckOutUICharBufferW : PUICharBufferW;
  //procedure CheckInUICharBufferW(var ACharBuffer: PUICharBufferW);

  function CheckOutUICharBufferNodeW(ATextLine: PUITextLineW; APrevNode: PUICharBufferNodeW): PUICharBufferNodeW;
  procedure CheckInUICharBufferNodeW(var ANode: PUICharBufferNodeW);
  
  function CheckOutUITextLineW: PUITextLineW;
  procedure CheckInUITextLineW(var ATextLine: PUITextLineW);

  function CheckOutUITextLineNodeW: PUITextLineNodeW;
  procedure CheckInUITextLineNodeW(var ANode: PUITextLineNodeW);

  function CheckOutUITextMultiLineW: PUITextMultiLineW;
  procedure CheckInUITextMultiLineW(var AUITextMultiLine: PUITextMultiLineW);

implementation

function CheckOutUICharBufferW : PUICharBufferW;
begin
  Result := System.New(PUICharBufferW);
  FillChar(Result^, SizeOf(TUICharBufferW), 0);
end;

procedure CheckInUICharBufferW(var ACharBuffer: PUICharBufferW);
begin
end;

function CheckOutUICharBufferNodeW(ATextLine: PUITextLineW; APrevNode: PUICharBufferNodeW): PUICharBufferNodeW;
begin
  Result := System.New(PUICharBufferNodeW);
  FillChar(Result^, SizeOf(TUICharBufferNodeW), 0);
  Result.Buffer := CheckOutUICharBufferW;
end;

procedure CheckInUICharBufferNodeW(var ANode: PUICharBufferNodeW);
begin
end;

function CheckOutUITextLineW: PUITextLineW;
begin
  Result := System.New(PUITextLineW);
  FillChar(Result^, SizeOf(TUITextLineW), 0);
end;

procedure CheckInUITextLineW(var ATextLine: PUITextLineW);
begin
end;

function CheckOutUITextLineNodeW: PUITextLineNodeW;
begin                      
  Result := System.New(PUITextLineNodeW);
  FillChar(Result^, SizeOf(TUITextLineNodeW), 0);
end;

procedure CheckInUITextLineNodeW(var ANode: PUITextLineNodeW);
begin
end;

function CheckOutUITextMultiLineW: PUITextMultiLineW;
begin
  Result := System.New(PUITextMultiLineW);
  FillChar(Result^, SizeOf(TUITextMultiLineW), 0);
end;

procedure CheckInUITextMultiLineW(var AUITextMultiLine: PUITextMultiLineW);
begin

end;

end.
