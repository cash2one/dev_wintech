unit BaseDataIO;

interface

uses
  DataChain;
  
type
  PDataIO           = ^TDataIO;   
  PDataBuffer       = ^TDataBuffer; 
  PDataBufferNode   = ^TDataBufferNode;

  TDataIO           = packed record
    Owner           : Pointer;
    DoDataIn        : procedure(ADataIO: PDataIO; AData: PDataBuffer);
    DoDataOut       : procedure(ADataIO: PDataIO; AData: PDataBuffer);
  end;

  TDataBufferHead   = packed record
    DataType        : Integer;
    Owner           : Pointer;
    ChainNode       : PChainNode;
    BufferSize      : Integer;
    DataLength      : Integer;
  end;

  TDataBuffer       = packed record
    BufferHead      : TDataBufferHead;
    Data            : array[0..64 * 1024 - 1] of AnsiChar;
  end;

  TDataBufferNodeHead = packed record
    DataType        : Integer;
    Buffer          : PDataBuffer;
    BufferSize      : Integer;
    DataLength      : Integer;
    PrevSibling     : PDataBufferNode;
    NextSibling     : PDataBufferNode;  
  end;

  TDataBufferNode   = packed record
    NodeHead        : TDataBufferNodeHead;
    Data            : array[0..4 * 1024 - 1] of AnsiChar;
  end;
  
implementation

end.
