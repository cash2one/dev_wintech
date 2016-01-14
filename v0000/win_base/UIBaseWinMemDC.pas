unit UIBaseWinMemDC;

interface

uses
  Windows;
  
type            
  PMemDC            = ^TMemDC;
  TMemDC            = record
    Handle          : HDC;
    CurrentBitmap   : HBITMAP;
    OldBitmap       : HBITMAP;
    CurrentFont     : HFont;

    OldFont         : HFont;
    Width           : Integer;
    Height          : Integer;

    ActualWidth     : Integer;
    ActualHeight    : Integer;

    BytesPerRow     : Integer;
    Bmpinfo         : TBitmapInfo;
    MemData         : Pointer;
  end;
             
  procedure UpdateMemDC(AMemDC: PMemDC; AWidth, AHeight: integer);
  
implementation

procedure UpdateMemDC(AMemDC: PMemDC; AWidth, AHeight: integer);
begin
//  AMemDC.Bitmap := CreateCompatibleBitmap();
  if AMemDC.Handle = 0 then
  begin
    AMemDC.Handle := CreateCompatibleDC(0);
  end;
  if (AWidth > AMemDC.ActualWidth) or (AHeight > AMemDC.ActualHeight) then
  begin
    if AMemDC.OldBitmap <> 0 then
    begin
      SelectObject(AMemDC.Handle, AMemDC.OldBitmap);
      if AMemDC.CurrentBitmap <> 0 then
      begin
        DeleteObject(AMemDC.CurrentBitmap);
        AMemDC.CurrentBitmap := 0;
      end;
    end;
    AMemDC.bmpinfo.bmiHeader.biSize := SizeOf(TbitmapinfoHeader);
    AMemDC.bmpinfo.bmiHeader.biPlanes := 1;
    AMemDC.bmpinfo.bmiHeader.biBitCount := 32;//32;
    AMemDC.bmpinfo.bmiHeader.biCompression := BI_RGB;

    if AMemDC.ActualWidth < AWidth then
    begin
      // 这个再 resize 的时候很有用
      AMemDC.ActualWidth := AWidth;    
//      AMemDC.ActualWidth := AWidth + 5;
    end;
    if AMemDC.ActualHeight < AHeight then
    begin
      AMemDC.ActualHeight := AHeight;
//      AMemDC.ActualHeight := AHeight + 5;
    end;
    AMemDC.bmpinfo.bmiHeader.biWidth := AMemDC.ActualWidth;
    AMemDC.bmpinfo.bmiHeader.biHeight := -AMemDC.ActualHeight;
    AMemDC.CurrentBitmap := CreateDIBSection(0, AMemDC.bmpinfo, DIB_RGB_COLORS, Pointer(AMemDC.MemData), 0, 0);
    if AMemDC.CurrentBitmap <> 0 then
    begin
      AMemDC.BytesPerRow := 0;
      AMemDC.OldBitmap := SelectObject(AMemDC.Handle, AMemDC.CurrentBitmap);
      AMemDC.Width := AWidth;
      AMemDC.Height := AHeight;
    end;
  end;
end;
  
end.
