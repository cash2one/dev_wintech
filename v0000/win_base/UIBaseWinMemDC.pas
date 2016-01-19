unit UIBaseWinMemDC;

interface

uses
  Windows,
  uiwin.gdi,
  UIWinColor;
  
type            
  PWinMemDC           = ^TWinMemDC;
  TWinMemDC           = record
    DCHandle          : HDC;
    OldBitmap         : HBITMAP;
    CurrentFont       : HFont;

    OldFont           : HFont;
    Width             : Integer;
    Height            : Integer;
    BytesPerRow       : Integer;
    MemBitmap         : TWinBitmap;
  end;
             
  procedure UpdateMemDC(AMemDC: PWinMemDC; AWidth, AHeight: integer);
  
implementation

procedure UpdateMemDC(AMemDC: PWinMemDC; AWidth, AHeight: integer);
begin
//  AMemDC.Bitmap := CreateCompatibleBitmap();
  if 0 = AMemDC.DCHandle then
  begin
    AMemDC.DCHandle := CreateCompatibleDC(0);
  end;
  if (AWidth > AMemDC.MemBitmap.Width) or (AHeight > AMemDC.MemBitmap.Height) then
  begin
    if AMemDC.OldBitmap <> 0 then
    begin
      SelectObject(AMemDC.DCHandle, AMemDC.OldBitmap);
      if AMemDC.MemBitmap.BitmapHandle <> 0 then
      begin
        DeleteObject(AMemDC.MemBitmap.BitmapHandle);
        AMemDC.MemBitmap.BitmapHandle := 0;
      end;
    end;
    AMemDC.MemBitmap.BitmapInfo.bmiHeader.biSize := SizeOf(TbitmapinfoHeader);
    AMemDC.MemBitmap.BitmapInfo.bmiHeader.biPlanes := 1;
    AMemDC.MemBitmap.BitmapInfo.bmiHeader.biBitCount := 32;//32;
    AMemDC.MemBitmap.BitmapInfo.bmiHeader.biCompression := BI_RGB;

    if AMemDC.MemBitmap.Width < AWidth then
    begin
      // 这个再 resize 的时候很有用
      AMemDC.MemBitmap.Width := AWidth;    
//      AMemDC.ActualWidth := AWidth + 5;
    end;
    if AMemDC.MemBitmap.Height < AHeight then
    begin
      AMemDC.MemBitmap.Height := AHeight;
//      AMemDC.ActualHeight := AHeight + 5;
    end;
    AMemDC.MemBitmap.BitmapInfo.bmiHeader.biWidth := AMemDC.MemBitmap.Width;
    AMemDC.MemBitmap.BitmapInfo.bmiHeader.biHeight := -AMemDC.MemBitmap.Height;
    AMemDC.MemBitmap.BitmapHandle := CreateDIBSection(0, AMemDC.MemBitmap.BitmapInfo, DIB_RGB_COLORS, Pointer(AMemDC.MemBitmap.BitsData), 0, 0);
    if 0 <> AMemDC.MemBitmap.BitmapHandle then
    begin
      AMemDC.BytesPerRow := 0;
      AMemDC.OldBitmap := SelectObject(AMemDC.DCHandle, AMemDC.MemBitmap.BitmapHandle);
      AMemDC.Width := AWidth;
      AMemDC.Height := AHeight;
    end;
  end;
end;

procedure CloseWinMemDC(AMemDC: PWinMemDC);
begin
  SelectObject(AMemDC.DCHandle, AMemDC.OldBitmap);
  DeleteDC(AMemDC.DCHandle);
  AMemDC.DCHandle := 0;
  DeleteObject(AMemDC.MemBitmap.BitmapHandle);
  AMemDC.MemBitmap.BitmapHandle := 0;
end;
  
end.
