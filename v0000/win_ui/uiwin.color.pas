unit uiwin.color;

interface

uses
  ui.color;
  
  function WinColor(Color32: TColor32): TColor;  
  function Color32(WinColor: TColor): TColor32; 

implementation

uses
  Windows;
                         
function WinColor(Color32: TColor32): TColor;
{$IFDEF PUREPASCAL}
begin
  Result := ((Color32 and $00FF0000) shr 16) or
             (Color32 and $0000FF00) or
            ((Color32 and $000000FF) shl 16);
{$ELSE}
asm
{$IFDEF TARGET_x64}
        MOV     EAX, ECX
{$ENDIF}
        // the alpha channel byte is set to zero!
        ROL     EAX, 8  // ABGR  ->  RGBA
        XOR     AL, AL  // BGRA  ->  BGR0
        BSWAP   EAX     // BGR0  ->  0RGB
{$ENDIF}
end;

function Color32(WinColor: TColor): TColor32; overload;
{$IFDEF WIN_COLOR_FIX}
var
  I: Longword;
{$ENDIF}
begin
  if WinColor < 0 then
  begin
    WinColor := GetSysColor(WinColor and $000000FF);
  end;
{$IFDEF WIN_COLOR_FIX}
  Result := $FF000000;
  I := (WinColor and $00FF0000) shr 16;
  if I <> 0 then Result := Result or TColor32(Integer(I) - 1);
  I := WinColor and $0000FF00;
  if I <> 0 then Result := Result or TColor32(Integer(I) - $00000100);
  I := WinColor and $000000FF;
  if I <> 0 then Result := Result or TColor32(Integer(I) - 1) shl 16;
{$ELSE}
{$IFDEF USENATIVECODE}
  Result := $FF shl 24 + (WinColor and $FF0000) shr 16 + (WinColor and $FF00) +
    (WinColor and $FF) shl 16;
{$ELSE}
  asm
        MOV     EAX,WinColor
        BSWAP   EAX
        MOV     AL,$FF
        ROR     EAX,8
        MOV     Result,EAX
  end;
{$ENDIF}
{$ENDIF}
end;

end.
