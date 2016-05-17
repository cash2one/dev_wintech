unit win.mem.text;

interface

uses
  sysdef_bufsize;
  
type
  PTextBufferA          = ^TTextBufferA;
  TTextBufferA          = packed record
    Data                : array[0..64 * c_1k - 1] of AnsiChar;
  end;

  PTextBufferW          = ^TTextBufferW;
  TTextBufferW          = packed record
    Data                : array[0..64 * c_1k - 1] of WideChar;
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
  TTextBufferW_512      = packed record // c_1k
    Data                : array[0..512 - 1] of WideChar; // c_1k
  end;
             
  PTextBufferA_1k       = ^TTextBufferA_1k;
  TTextBufferA_1k       = packed record // c_1k
    Data                : array[0..c_1k - 1] of AnsiChar; // c_1k
  end;
  
  PTextBufferW_1k       = ^TTextBufferW_1k;
  TTextBufferW_1k       = packed record // c_1k * 2
    Data                : array[0..c_1k - 1] of WideChar; // c_1k * 2
  end;
          
  PTextBufferA_2k       = ^TTextBufferA_2k;
  TTextBufferA_2k       = packed record // c_1k * 2
    Data                : array[0..c_1k * 2 - 1] of AnsiChar; // c_1k * 2
  end;
  
  PTextBufferW_2k       = ^TTextBufferW_2k;
  TTextBufferW_2k       = packed record // c_1k * 4
    Data                : array[0..2 * c_1k - 1] of WideChar; // c_1k * 4
  end;
          
  PTextBufferA_4k       = ^TTextBufferA_4k;
  TTextBufferA_4k       = packed record // c_1k * 2
    Data                : array[0..c_1k * 4 - 1] of AnsiChar; // c_1k * 2
  end;

  PTextBufferW_4k       = ^TTextBufferW_4k;
  TTextBufferW_4k       = packed record // c_1k * 8
    Data                : array[0..4 * c_1k - 1] of WideChar; // c_1k * 8
  end;
            
  PTextBufferA_8k       = ^TTextBufferA_8k;
  TTextBufferA_8k       = packed record // c_1k * 8
    Data                : array[0..c_1k * 8 - 1] of AnsiChar; // c_1k * 2
  end;
  
  PTextBufferW_8k       = ^TTextBufferW_8k;
  TTextBufferW_8k       = packed record // c_1k * 16
    Data                : array[0..8 * c_1k - 1] of WideChar; // 16
  end;      
            
  PTextBufferA_16k      = ^TTextBufferA_16k;
  TTextBufferA_16k      = packed record // c_1k * 16
    Data                : array[0..c_1k * 16 - 1] of AnsiChar; // c_1k * 16
  end;

  PTextBufferW_16k      = ^TTextBufferW_16k;
  TTextBufferW_16k      = packed record // c_1k * 32
    Data                : array[0..16 * c_1k - 1] of WideChar; // 8
  end;
                 
  PTextBufferA_32k      = ^TTextBufferA_32k;
  TTextBufferA_32k      = packed record // c_1k * 32
    Data                : array[0..c_1k * 32 - 1] of AnsiChar; // c_1k * 32
  end;

  PTextBufferW_32k      = ^TTextBufferW_32k;
  TTextBufferW_32k      = packed record // c_1k * 64
    Data                : array[0..32 * c_1k - 1] of WideChar; // 8
  end;
            
  PTextBufferA_64k      = ^TTextBufferA_64k;
  TTextBufferA_64k      = packed record // c_1k * 64
    Data                : array[0..c_1k * 64 - 1] of AnsiChar; // c_1k * 32
  end;

  PTextBufferW_64k      = ^TTextBufferW_64k;
  TTextBufferW_64k      = packed record // c_1k * 128
    Data                : array[0..64 * c_1k - 1] of WideChar; // 8
  end;
                 
  PTextBufferA_128k     = ^TTextBufferA_128k;
  TTextBufferA_128k     = packed record // c_1k * 128
    Data                : array[0..c_1k * 128 - 1] of AnsiChar; // c_1k * 32
  end;

  PTextBufferA_256k     = ^TTextBufferA_256k;
  TTextBufferA_256k     = packed record // c_1k * 128
    Data                : array[0..c_1k * 256 - 1] of AnsiChar; // c_1k * 32
  end;
            
  PTextBufferA_512k     = ^TTextBufferA_512k;
  TTextBufferA_512k     = packed record // c_1k * 512
    Data                : array[0..c_1k * 512 - 1] of AnsiChar; // c_1k * 512
  end;
  
  PTextBufferA_1m       = ^TTextBufferA_1m;
  TTextBufferA_1m       = packed record // c_1k * 512
    Data                : array[0..c_1m - 1] of AnsiChar; // c_1k * 512
  end;
                                          
  PTextBufferA_2m       = ^TTextBufferA_2m;
  TTextBufferA_2m       = packed record // c_1k * 512
    Data                : array[0..c_1m * 2 - 1] of AnsiChar; // c_1k * 512
  end;
  
  PTextBufferA_4m       = ^TTextBufferA_4m;
  TTextBufferA_4m       = packed record // c_1k * 512
    Data                : array[0..c_1m * 4 - 1] of AnsiChar; // c_1k * 512
  end;

  PTextBufferA_8m       = ^TTextBufferA_8m;
  TTextBufferA_8m       = packed record // c_1k * 512
    Data                : array[0..c_1m * 8 - 1] of AnsiChar; // c_1k * 512
  end;

  PTextBufferA_16m      = ^TTextBufferA_16m;
  TTextBufferA_16m      = packed record // c_1k * 512
    Data                : array[0..c_1m * 16 - 1] of AnsiChar; // c_1k * 512
  end;
  
  PTextBufferA_32m       = ^TTextBufferA_32m;
  TTextBufferA_32m       = packed record // c_1k * 512
    Data                : array[0..c_1m * 32 - 1] of AnsiChar; // c_1k * 512
  end;
  
  PTextBufferA_64m       = ^TTextBufferA_64m;
  TTextBufferA_64m       = packed record // c_1k * 512
    Data                : array[0..c_1m * 64 - 1] of AnsiChar; // c_1k * 512
  end;

  PTextBufferA_128m     = ^TTextBufferA_128m;
  TTextBufferA_128m     = packed record // c_1k * 512
    Data                : array[0..c_1m * 128 - 1] of AnsiChar; // c_1k * 512
  end;

  PTextBufferA_256m     = ^TTextBufferA_256m;
  TTextBufferA_256m     = packed record // c_1k * 512
    Data                : array[0..c_1m * 256 - 1] of AnsiChar; // c_1k * 512
  end;

  PTextBufferA_512m     = ^TTextBufferA_512m;
  TTextBufferA_512m     = packed record // c_1k * 512
    Data                : array[0..c_1m * 512 - 1] of AnsiChar; // c_1k * 512
  end;
  
  PTextBufferNode       = ^TTextBufferNode;
  TTextBufferNode       = packed record       // 14
    PrevSibling         : PTextBufferNode;
    NextSibling         : PTextBufferNode;
    Buffer              : Pointer;
    ExParam             : Pointer; // 4
    BufferSize          : LongWord;  // 1
    BufferLen           : LongWord;  // 1
  end;
                
  PTextLine             = ^TTextLine;
  TTextLine             = packed record        // 8
    FirstCharBufferNode : PTextBufferNode;
    LastCharBufferNode  : PTextBufferNode;  
    ExParam             : Pointer; // 4
    TextLineLength      : LongWord;  // 1
  end;
            
  PTextLineNode         = ^TTextLineNode;
  TTextLineNode         = packed record       // 8
    PrevSibling         : PTextLineNode;
    NextSibling         : PTextLineNode;
    TextLine            : PTextLine;     
    RowIndex            : Integer;
  end;
              
  PTextMultiLine        = ^TTextMultiLine;
  TTextMultiLine        = packed record        // 8
    FirstTextLineNode   : PTextLineNode;
    LastTextLineNode    : PTextLineNode;  
    ExParam             : Pointer; // 4
    LineCount           : Integer;  // 1
  end;
               
  function CheckOutTextBufferNode(ASizeMode: Integer = SizeMode_256): PTextBufferNode; overload;
  function CheckOutTextBufferNode(ATextLine: PTextLine; APrevNode: PTextBufferNode; ASizeMode: Integer = SizeMode_256): PTextBufferNode; overload;
  procedure CheckInTextBufferNode(var ANode: PTextBufferNode);
  
  function CheckOutTextLine: PTextLine;
  procedure CheckInTextLine(var ATextLine: PTextLine);

  function CheckOutTextLineNode: PTextLineNode;
  procedure CheckInTextLineNode(var ANode: PTextLineNode);

  function CheckOutTextMultiLine: PTextMultiLine;
  procedure CheckInTextMultiLine(var ATextMultiLine: PTextMultiLine);
                           
  procedure AddTextBufferNode(ANode: PTextBufferNode; ATextLine: PTextLine; APrevNode: PTextBufferNode);
  procedure RemoveTextBufferNode(ANode: PTextBufferNode; ATextLine: PTextLine);

implementation

function CheckOutTextBuffer(ASizeMode: Integer = SizeMode_256) : PTextBufferW;
begin
  Result := System.New(PTextBufferW);
  FillChar(Result^, SizeOf(TTextBufferW), 0);
end;

procedure CheckInTextBuffer(var ACharBuffer: PTextBufferW);
begin
end;

function CheckOutTextBufferNode(ASizeMode: Integer = SizeMode_256): PTextBufferNode;
begin
  Result := System.New(PTextBufferNode);
  FillChar(Result^, SizeOf(TTextBufferNode), 0);
  Result.Buffer := CheckOutTextBuffer(ASizeMode);
  Result.BufferSize := GetModeSize(ASizeMode);
end;

function CheckOutTextBufferNode(ATextLine: PTextLine; APrevNode: PTextBufferNode; ASizeMode: Integer = SizeMode_256): PTextBufferNode; 
begin
  Result := CheckOutTextBufferNode(ASizeMode);
  AddTextBufferNode(Result, ATextLine, nil);
end;
             
procedure CheckInTextBufferNode(var ANode: PTextBufferNode);
begin
end;

procedure AddTextBufferNode(ANode: PTextBufferNode; ATextLine: PTextLine; APrevNode: PTextBufferNode);
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

procedure RemoveTextBufferNode(ANode: PTextBufferNode; ATextLine: PTextLine);
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

function CheckOutTextLine: PTextLine;
begin
  Result := System.New(PTextLine);
  FillChar(Result^, SizeOf(TTextLine), 0);
end;

procedure CheckInTextLine(var ATextLine: PTextLine);
begin
end;

function CheckOutTextLineNode: PTextLineNode;
begin                      
  Result := System.New(PTextLineNode);
  FillChar(Result^, SizeOf(TTextLineNode), 0);
end;

procedure CheckInTextLineNode(var ANode: PTextLineNode);
begin
end;

function CheckOutTextMultiLine: PTextMultiLine;
begin
  Result := System.New(PTextMultiLine);
  FillChar(Result^, SizeOf(TTextMultiLine), 0);
end;                                                

procedure CheckInTextMultiLine(var ATextMultiLine: PTextMultiLine);
begin                         
end;

end.
