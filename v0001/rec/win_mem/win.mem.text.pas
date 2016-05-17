unit win.mem.text;

interface

const
  v_1k = 1024;  
  v_1m = v_1k * v_1k;
  //v_1g = v_1m * v_1m;
  //v_1t = v_1g * v_1g;
  
type
  PTextBufferA          = ^TTextBufferA;
  TTextBufferA          = packed record
    Data                : array[0..64 * v_1k - 1] of AnsiChar;
  end;

  PTextBufferW          = ^TTextBufferW;
  TTextBufferW          = packed record
    Data                : array[0..64 * v_1k - 1] of WideChar;
  end;

  PTextBufferA_8        = ^TTextBufferA_8;
  TTextBufferA_8        = packed record // 8
    Data                : array[0..8 - 1] of AnsiChar; // 8
  end;

  PTextBufferW_8        = ^TTextBufferW_8;
  TTextBufferW_8        = packed record // 16
    Data                : array[0..8 - 1] of WideChar; // 16
  end;
              
  PTextBufferA_16       = ^TTextBufferA_16;
  TTextBufferA_16       = packed record // 16
    Data                : array[0..16 - 1] of AnsiChar; // 16
  end;

  PTextBufferW_16       = ^TTextBufferW_16;
  TTextBufferW_16       = packed record // 32
    Data                : array[0..16 - 1] of WideChar; // 32
  end;
             
  PTextBufferA_32       = ^TTextBufferA_32;
  TTextBufferA_32       = packed record // 32
    Data                : array[0..32 - 1] of AnsiChar; // 32
  end;

  PTextBufferW_32       = ^TTextBufferW_32;
  TTextBufferW_32       = packed record // 64
    Data                : array[0..32 - 1] of WideChar; // 64
  end;
          
  PTextBufferA_64       = ^TTextBufferA_64;
  TTextBufferA_64       = packed record // 64
    Data                : array[0..64 - 1] of AnsiChar; // 64
  end;
  
  PTextBufferW_64       = ^TTextBufferW_64;
  TTextBufferW_64       = packed record // 128
    Data                : array[0..64 - 1] of WideChar; // 8
  end;
            
  PTextBufferA_128      = ^TTextBufferA_128;
  TTextBufferA_128      = packed record // 128
    Data                : array[0..128 - 1] of AnsiChar; // 128
  end;
  
  PTextBufferW_128      = ^TTextBufferW_128;
  TTextBufferW_128      = packed record // 256
    Data                : array[0..128 - 1] of WideChar; // 256
  end;
                 
  PTextBufferA_256      = ^TTextBufferA_256;
  TTextBufferA_256      = packed record // 256
    Data                : array[0..256 - 1] of AnsiChar; // 256
  end;
  
  PTextBufferW_256      = ^TTextBufferW_256;
  TTextBufferW_256      = packed record // 512
    Data                : array[0..256 - 1] of WideChar; // 512
  end;
           
  PTextBufferA_512      = ^TTextBufferA_512;
  TTextBufferA_512      = packed record // 512
    Data                : array[0..512 - 1] of AnsiChar; // 512
  end;
  
  PTextBufferW_512      = ^TTextBufferW_512;
  TTextBufferW_512      = packed record // v_1k
    Data                : array[0..512 - 1] of WideChar; // v_1k
  end;
             
  PTextBufferA_1k       = ^TTextBufferA_1k;
  TTextBufferA_1k       = packed record // v_1k
    Data                : array[0..v_1k - 1] of AnsiChar; // v_1k
  end;
  
  PTextBufferW_1k       = ^TTextBufferW_1k;
  TTextBufferW_1k       = packed record // v_1k * 2
    Data                : array[0..v_1k - 1] of WideChar; // v_1k * 2
  end;
          
  PTextBufferA_2k       = ^TTextBufferA_2k;
  TTextBufferA_2k       = packed record // v_1k * 2
    Data                : array[0..v_1k * 2 - 1] of AnsiChar; // v_1k * 2
  end;
  
  PTextBufferW_2k       = ^TTextBufferW_2k;
  TTextBufferW_2k       = packed record // v_1k * 4
    Data                : array[0..2 * v_1k - 1] of WideChar; // v_1k * 4
  end;
          
  PTextBufferA_4k       = ^TTextBufferA_4k;
  TTextBufferA_4k       = packed record // v_1k * 2
    Data                : array[0..v_1k * 4 - 1] of AnsiChar; // v_1k * 2
  end;

  PTextBufferW_4k       = ^TTextBufferW_4k;
  TTextBufferW_4k       = packed record // v_1k * 8
    Data                : array[0..4 * v_1k - 1] of WideChar; // v_1k * 8
  end;
            
  PTextBufferA_8k       = ^TTextBufferA_8k;
  TTextBufferA_8k       = packed record // v_1k * 8
    Data                : array[0..v_1k * 8 - 1] of AnsiChar; // v_1k * 2
  end;
  
  PTextBufferW_8k       = ^TTextBufferW_8k;
  TTextBufferW_8k       = packed record // v_1k * 16
    Data                : array[0..8 * v_1k - 1] of WideChar; // 16
  end;      
            
  PTextBufferA_16k      = ^TTextBufferA_16k;
  TTextBufferA_16k      = packed record // v_1k * 16
    Data                : array[0..v_1k * 16 - 1] of AnsiChar; // v_1k * 16
  end;

  PTextBufferW_16k      = ^TTextBufferW_16k;
  TTextBufferW_16k      = packed record // v_1k * 32
    Data                : array[0..16 * v_1k - 1] of WideChar; // 8
  end;
                 
  PTextBufferA_32k      = ^TTextBufferA_32k;
  TTextBufferA_32k      = packed record // v_1k * 32
    Data                : array[0..v_1k * 32 - 1] of AnsiChar; // v_1k * 32
  end;

  PTextBufferW_32k      = ^TTextBufferW_32k;
  TTextBufferW_32k      = packed record // v_1k * 64
    Data                : array[0..32 * v_1k - 1] of WideChar; // 8
  end;
            
  PTextBufferA_64k      = ^TTextBufferA_64k;
  TTextBufferA_64k      = packed record // v_1k * 64
    Data                : array[0..v_1k * 64 - 1] of AnsiChar; // v_1k * 32
  end;

  PTextBufferW_64k      = ^TTextBufferW_64k;
  TTextBufferW_64k      = packed record // v_1k * 128
    Data                : array[0..64 * v_1k - 1] of WideChar; // 8
  end;
                 
  PTextBufferA_128k     = ^TTextBufferA_128k;
  TTextBufferA_128k     = packed record // v_1k * 128
    Data                : array[0..v_1k * 128 - 1] of AnsiChar; // v_1k * 32
  end;

  PTextBufferA_256k     = ^TTextBufferA_256k;
  TTextBufferA_256k     = packed record // v_1k * 128
    Data                : array[0..v_1k * 256 - 1] of AnsiChar; // v_1k * 32
  end;
            
  PTextBufferA_512k     = ^TTextBufferA_512k;
  TTextBufferA_512k     = packed record // v_1k * 512
    Data                : array[0..v_1k * 512 - 1] of AnsiChar; // v_1k * 512
  end;
  
  PTextBufferA_1m       = ^TTextBufferA_1m;
  TTextBufferA_1m       = packed record // v_1k * 512
    Data                : array[0..v_1m - 1] of AnsiChar; // v_1k * 512
  end;
                                          
  PTextBufferA_2m       = ^TTextBufferA_2m;
  TTextBufferA_2m       = packed record // v_1k * 512
    Data                : array[0..v_1m * 2 - 1] of AnsiChar; // v_1k * 512
  end;
  
  PTextBufferA_4m       = ^TTextBufferA_4m;
  TTextBufferA_4m       = packed record // v_1k * 512
    Data                : array[0..v_1m * 4 - 1] of AnsiChar; // v_1k * 512
  end;

  PTextBufferA_8m       = ^TTextBufferA_8m;
  TTextBufferA_8m       = packed record // v_1k * 512
    Data                : array[0..v_1m * 8 - 1] of AnsiChar; // v_1k * 512
  end;

  PTextBufferA_16m      = ^TTextBufferA_16m;
  TTextBufferA_16m      = packed record // v_1k * 512
    Data                : array[0..v_1m * 16 - 1] of AnsiChar; // v_1k * 512
  end;
  
  PTextBufferA_32m       = ^TTextBufferA_32m;
  TTextBufferA_32m       = packed record // v_1k * 512
    Data                : array[0..v_1m * 32 - 1] of AnsiChar; // v_1k * 512
  end;
  
  PTextBufferA_64m       = ^TTextBufferA_64m;
  TTextBufferA_64m       = packed record // v_1k * 512
    Data                : array[0..v_1m * 64 - 1] of AnsiChar; // v_1k * 512
  end;

  PTextBufferA_128m     = ^TTextBufferA_128m;
  TTextBufferA_128m     = packed record // v_1k * 512
    Data                : array[0..v_1m * 128 - 1] of AnsiChar; // v_1k * 512
  end;

  PTextBufferA_256m     = ^TTextBufferA_256m;
  TTextBufferA_256m     = packed record // v_1k * 512
    Data                : array[0..v_1m * 256 - 1] of AnsiChar; // v_1k * 512
  end;

  PTextBufferA_512m     = ^TTextBufferA_512m;
  TTextBufferA_512m     = packed record // v_1k * 512
    Data                : array[0..v_1m * 512 - 1] of AnsiChar; // v_1k * 512
  end;
  
  PTextBufferNodeW    = ^TTextBufferNodeW;
  TTextBufferNodeW    = packed record       // 14
    PrevSibling         : PTextBufferNodeW;
    NextSibling         : PTextBufferNodeW;
    Buffer              : PTextBufferW;
    ExParam             : Pointer; // 4
    BufferSize          : LongWord;  // 1
    BufferLen           : LongWord;  // 1
  end;
          
  PTextLineW            = ^TTextLineW;
  TTextLineW            = packed record        // 8
    FirstCharBufferNode : PTextBufferNodeW;
    LastCharBufferNode  : PTextBufferNodeW;  
    ExParam             : Pointer; // 4
    TextLineLength      : LongWord;  // 1
  end;
            
  PTextLineNodeW        = ^TTextLineNodeW;
  TTextLineNodeW        = packed record       // 8
    PrevSibling         : PTextLineNodeW;
    NextSibling         : PTextLineNodeW;
    TextLine            : PTextLineW;     
    RowIndex            : Integer;
  end;
              
  PTextMultiLineW       = ^TTextMultiLineW;
  TTextMultiLineW       = packed record        // 8
    FirstTextLineNode   : PTextLineNodeW;
    LastTextLineNode    : PTextLineNodeW;  
    ExParam             : Pointer; // 4
    LineCount           : Integer;  // 1
  end;
               
  function CheckOutTextBufferNodeW(ATextLine: PTextLineW; APrevNode: PTextBufferNodeW): PTextBufferNodeW;
  procedure CheckInTextBufferNodeW(var ANode: PTextBufferNodeW);
  
  function CheckOutTextLineW: PTextLineW;
  procedure CheckInTextLineW(var ATextLine: PTextLineW);

  function CheckOutTextLineNodeW: PTextLineNodeW;
  procedure CheckInTextLineNodeW(var ANode: PTextLineNodeW);

  function CheckOutTextMultiLineW: PTextMultiLineW;
  procedure CheckInTextMultiLineW(var ATextMultiLine: PTextMultiLineW);
                           
  procedure AddTextBufferNodeW(ANode: PTextBufferNodeW; ATextLine: PTextLineW; APrevNode: PTextBufferNodeW); 
  procedure RemoveTextBufferNodeW(ANode: PTextBufferNodeW; ATextLine: PTextLineW);

implementation

function CheckOutTextBufferW : PTextBufferW;
begin
  Result := System.New(PTextBufferW);
  FillChar(Result^, SizeOf(TTextBufferW), 0);
end;

procedure CheckInTextBufferW(var ACharBuffer: PTextBufferW);
begin
end;

function CheckOutTextBufferNodeW(ATextLine: PTextLineW; APrevNode: PTextBufferNodeW): PTextBufferNodeW;
begin
  Result := System.New(PTextBufferNodeW);
  FillChar(Result^, SizeOf(TTextBufferNodeW), 0);
  Result.Buffer := CheckOutTextBufferW;
  Result.BufferSize := 255;
  
  AddTextBufferNodeW(Result, ATextLine, nil);
end;
             
procedure CheckInTextBufferNodeW(var ANode: PTextBufferNodeW);
begin
end;

procedure AddTextBufferNodeW(ANode: PTextBufferNodeW; ATextLine: PTextLineW; APrevNode: PTextBufferNodeW);
begin
  if nil = ATextLine.FirstCharBufferNode then
  begin
    ATextLine.FirstCharBufferNode := ANode;
  end;
  if (nil <> APrevNode) { and (APrevSibling.Owner = ATextLine)} then
  begin
    ANode.PrevSibling := APrevNode;
    ANode.NextSibling := APrevNode.NextSibling;
    if nil <> APrevNode.NextSibling then
    begin
      APrevNode.NextSibling.PrevSibling := ANode;
    end;
    APrevNode.NextSibling := ANode;
    if ANode.NextSibling = nil then
    begin
      ATextLine.LastCharBufferNode := ANode;
    end;
  end else
  begin
    // insert to the last position
    if nil <> ATextLine.LastCharBufferNode then
    begin
      ANode.PrevSibling := ATextLine.LastCharBufferNode;
      ATextLine.LastCharBufferNode.NextSibling := ANode;
    end;
    ATextLine.LastCharBufferNode := ANode;
  end;
end;

procedure RemoveTextBufferNodeW(ANode: PTextBufferNodeW; ATextLine: PTextLineW);
begin
  if ANode.PrevSibling <> nil then
  begin
    ANode.PrevSibling.NextSibling := ANode.NextSibling
  end else
  begin
    ATextLine.FirstCharBufferNode := ANode.NextSibling;
//    ANode.Owner.FirstData := ANode.NextSibling;
  end;
  if ANode.NextSibling <> nil then
  begin
    ANode.NextSibling.PrevSibling := ANode.PrevSibling;
  end else
  begin
    ATextLine.LastCharBufferNode := ANode.PrevSibling;
//    ANode.Owner.LastData := ANode.PrevSibling;
  end;
  ANode.PrevSibling := nil;
  ANode.NextSibling := nil;
end;

function CheckOutTextLineW: PTextLineW;
begin
  Result := System.New(PTextLineW);
  FillChar(Result^, SizeOf(TTextLineW), 0);
end;

procedure CheckInTextLineW(var ATextLine: PTextLineW);
begin
end;

function CheckOutTextLineNodeW: PTextLineNodeW;
begin                      
  Result := System.New(PTextLineNodeW);
  FillChar(Result^, SizeOf(TTextLineNodeW), 0);
end;

procedure CheckInTextLineNodeW(var ANode: PTextLineNodeW);
begin
end;

function CheckOutTextMultiLineW: PTextMultiLineW;
begin
  Result := System.New(PTextMultiLineW);
  FillChar(Result^, SizeOf(TTextMultiLineW), 0);
end;                                                

procedure CheckInTextMultiLineW(var ATextMultiLine: PTextMultiLineW);
begin

end;

end.
