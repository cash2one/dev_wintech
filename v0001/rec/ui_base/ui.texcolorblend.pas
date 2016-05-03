unit ui.texcolorblend;

interface

uses
  ui.texcolor;
  
type            
  TCombineMode = (cmBlend, cmMerge);
  
  TBlendReg    = function(F, B: TColor32): TColor32;
  TBlendMem    = procedure(F: TColor32; var B: TColor32);
  TBlendMems   = procedure(F: TColor32; B: PColor32; Count: Integer);
  TBlendRegEx  = function(F, B, M: TColor32): TColor32;
  TBlendMemEx  = procedure(F: TColor32; var B: TColor32; M: TColor32);
  TBlendRegRGB = function(F, B, W: TColor32): TColor32;
  TBlendMemRGB = procedure(F: TColor32; var B: TColor32; W: TColor32);
  TBlendLine   = procedure(Src, Dst: PColor32; Count: Integer);
  TBlendLineEx = procedure(Src, Dst: PColor32; Count: Integer; M: TColor32);
  TCombineReg  = function(X, Y, W: TColor32): TColor32;
  TCombineMem  = procedure(X: TColor32; var Y: TColor32; W: TColor32);
  TCombineLine = procedure(Src, Dst: PColor32; Count: Integer; W: TColor32);
  TLightenReg  = function(C: TColor32; Amount: Integer): TColor32;
              
{$IFDEF TEST_BLENDMEMRGB128SSE4}
  TBlendMemRGB128 = procedure(F: TColor32; var B: TColor32; W: UInt64);
{$ENDIF}

  TBlendFunction = record
    { Function Variables }
    BlendReg: TBlendReg;

    BlendMem: TBlendMem;
    BlendMems: TBlendMems;
    BlendRegEx: TBlendRegEx;
    BlendMemEx: TBlendMemEx;
    BlendRegRGB: TBlendRegRGB;
    BlendMemRGB: TBlendMemRGB;
  {$IFDEF TEST_BLENDMEMRGB128SSE4}
    BlendMemRGB128: TBlendMemRGB128;
  {$ENDIF}

    BlendLine: TBlendLine;
    BlendLineEx: TBlendLineEx;

    CombineReg: TCombineReg;
    CombineMem: TCombineMem;
    CombineLine: TCombineLine;

    MergeReg: TBlendReg;
    MergeMem: TBlendMem;

    MergeRegEx: TBlendRegEx;
    MergeMemEx: TBlendMemEx;

    MergeLine: TBlendLine;
    MergeLineEx: TBlendLineEx;

  { Color algebra functions }
    ColorAdd: TBlendReg;
    ColorSub: TBlendReg;
    ColorDiv: TBlendReg;
    ColorModulate: TBlendReg;
    ColorMax: TBlendReg;
    ColorMin: TBlendReg;
    ColorDifference: TBlendReg;
    ColorAverage: TBlendReg;
    ColorExclusion: TBlendReg;
    ColorScale: TBlendReg;
    { Misc stuff }
    LightenReg: TLightenReg;
  end;

var
  BlendFuncs: TBlendFunction;
  
const
  BLEND_REG: array[TCombineMode] of ^TBlendReg = ((@@BlendFuncs.BlendReg),(@@BlendFuncs.MergeReg));
  BLEND_MEM: array[TCombineMode] of ^TBlendMem = ((@@BlendFuncs.BlendMem),(@@BlendFuncs.MergeMem));
  BLEND_REG_EX: array[TCombineMode] of ^TBlendRegEx = ((@@BlendFuncs.BlendRegEx),(@@BlendFuncs.MergeRegEx));
  BLEND_MEM_EX: array[TCombineMode] of ^TBlendMemEx = ((@@BlendFuncs.BlendMemEx),(@@BlendFuncs.MergeMemEx));
  BLEND_LINE: array[TCombineMode] of ^TBlendLine = ((@@BlendFuncs.BlendLine),(@@BlendFuncs.MergeLine));
  BLEND_LINE_EX: array[TCombineMode] of ^TBlendLineEx = ((@@BlendFuncs.BlendLineEx),(@@BlendFuncs.MergeLineEx));

implementation

end.
