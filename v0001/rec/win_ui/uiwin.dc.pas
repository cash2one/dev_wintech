unit uiwin.dc;

interface
              
uses
  Windows,
  win.thread,
  uiwin.gdiobj,
  uiwin.wnd;

type
  PWinDC              = ^TWinDC;
  TWinDC              = packed record
    DCHandle          : HDC;
                         
    OldBitmap         : HBITMAP;
    OldFont           : HFont;
    OldBrush          : HBRUSH;
    OldPen            : HPen;
    
    Width             : Integer;
    Height            : Integer;
    BytesPerRow       : Integer;
    MemBitmap         : TWinBitmap;
  end;

  function CheckOutWinDC: PWinDC;
  procedure CheckInWinDC(var ADC: PWinDC);

  procedure CloseWinDC(ADC: PWinDC);
  procedure UpdateWinDC(ADC: PWinDC; AWidth, AHeight: integer);

implementation

function CheckOutWinDC: PWinDC;
begin
  Result := System.New(PWinDC);
  FillChar(Result^, SizeOf(TWinDC), 0);
end;

procedure CheckInWinDC(var ADC: PWinDC);
begin

end;

procedure CloseWinDC(ADC: PWinDC);
begin              
  SelectObject(ADC.DCHandle, ADC.OldBitmap);
  DeleteDC(ADC.DCHandle);
  ADC.DCHandle := 0;
  DeleteObject(ADC.MemBitmap.BitmapHandle);
  ADC.MemBitmap.BitmapHandle := 0;
end;

procedure UpdateWinDC(ADC: PWinDC; AWidth, AHeight: integer);
begin
//  AMemDC.Bitmap := CreateCompatibleBitmap();
  if 0 = ADC.DCHandle then
  begin
    ADC.DCHandle := CreateCompatibleDC(0);
  end;
  if (AWidth > ADC.MemBitmap.Width) or (AHeight > ADC.MemBitmap.Height) then
  begin
    if ADC.OldBitmap <> 0 then
    begin
      SelectObject(ADC.DCHandle, ADC.OldBitmap);
      if ADC.MemBitmap.BitmapHandle <> 0 then
      begin
        DeleteObject(ADC.MemBitmap.BitmapHandle);
        ADC.MemBitmap.BitmapHandle := 0;
      end;
    end;
    ADC.MemBitmap.BitmapInfo.bmiHeader.biSize := SizeOf(TbitmapinfoHeader);
    ADC.MemBitmap.BitmapInfo.bmiHeader.biPlanes := 1;
    ADC.MemBitmap.BitmapInfo.bmiHeader.biBitCount := 32;//32;
    ADC.MemBitmap.BitmapInfo.bmiHeader.biCompression := BI_RGB;

    if ADC.MemBitmap.Width < AWidth then
    begin
      // 这个再 resize 的时候很有用
      ADC.MemBitmap.Width := AWidth;    
//      AMemDC.ActualWidth := AWidth + 5;
    end;
    if ADC.MemBitmap.Height < AHeight then
    begin
      ADC.MemBitmap.Height := AHeight;
//      AMemDC.ActualHeight := AHeight + 5;
    end;
    ADC.MemBitmap.BitmapInfo.bmiHeader.biWidth := ADC.MemBitmap.Width;
    ADC.MemBitmap.BitmapInfo.bmiHeader.biHeight := -ADC.MemBitmap.Height;
    ADC.MemBitmap.BitmapHandle := CreateDIBSection(0, ADC.MemBitmap.BitmapInfo, DIB_RGB_COLORS, Pointer(ADC.MemBitmap.BitsData), 0, 0);
    if 0 <> ADC.MemBitmap.BitmapHandle then
    begin
      ADC.BytesPerRow := 0;
      ADC.OldBitmap := SelectObject(ADC.DCHandle, ADC.MemBitmap.BitmapHandle);
      ADC.Width := AWidth;
      ADC.Height := AHeight;
    end;
  end;
end;

end.
