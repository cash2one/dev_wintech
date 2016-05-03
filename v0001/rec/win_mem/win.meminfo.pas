unit win.meminfo;

interface

uses
  Types;

type
  PMemoryBasicInformation = ^TMemoryBasicInformation;
  TMemoryBasicInformation = record
    BaseAddress       : Pointer;
    AllocationBase    : Pointer;
    AllocationProtect : DWORD;
    RegionSize        : DWORD;
    State             : DWORD;
    Protect           : DWORD;
    Type_9            : DWORD;
  end;

implementation

end.
