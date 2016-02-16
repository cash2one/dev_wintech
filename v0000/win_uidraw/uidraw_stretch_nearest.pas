unit uidraw_stretch_nearest;

interface

uses
  ui.color, ui.bitmap, ui.space, uidraw.resampler;
                               
  procedure StretchDraw_Nearest(ADst: PBitmap32; ADstRect: TUIRect; ASrc: PBitmap32; ASrcRect: TUIRect);

implementation

uses
  Math,
  BaseType,
  win_data_move,
  uiwin.bitmap_draw,
  ui.bitmap_pixel;

procedure StretchDraw_Nearest(ADst: PBitmap32; ADstRect: TUIRect; ASrc: PBitmap32; ASrcRect: TUIRect);
var
  R: TUIRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: PIntegerArray;
  SrcLine, DstLine: PColor32Array;
  Buffer: TArrayOfColor32;
  Scale: TFloat;
  DstLinePtr, MapPtr: PColor32;
begin
  if (ASrcRect.Left < 0) or
     (ASrcRect.Top < 0) or
     (ASrcRect.Right > ASrc.Width) or
     (ASrcRect.Bottom > ASrc.Height) then
  begin
    exit;
  end;

  SrcW := ASrcRect.Right - ASrcRect.Left;
  SrcH := ASrcRect.Bottom - ASrcRect.Top;
  DstW := ADstRect.Right - ADstRect.Left;
  DstH := ADstRect.Bottom - ADstRect.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      Bitmap32Draw(ADst, ADstRect, ASrc, ASrcRect.Left, ASrcRect.Top);
    end
    else
    begin
      GetMem(MapHorz, DstClipW * SizeOf(Integer));
      try
        if DstW > 1 then
        begin
          if true {FullEdge} then
          begin
            Scale := SrcW / DstW;
            for I := 0 to DstClipW - 1 do
              MapHorz^[I] := Trunc(ASrcRect.Left + (I - ADstRect.Left) * Scale);
          end
          else
          begin
            Scale := (SrcW - 1) / (DstW - 1);
            for I := 0 to DstClipW - 1 do
              MapHorz^[I] := Round(ASrcRect.Left + (I - ADstRect.Left) * Scale);
          end;

          Assert(MapHorz^[0] >= ASrcRect.Left);
          Assert(MapHorz^[DstClipW - 1] < ASrcRect.Right);
        end
        else
          MapHorz^[0] := (ASrcRect.Left + ASrcRect.Right - 1) div 2;

        if DstH <= 1 then
          Scale := 0
        else if True {FullEdge} then
          Scale := SrcH / DstH
        else
          Scale := (SrcH - 1) / (DstH - 1);

          DstLine := PColor32Array(Bitmap32GetPixelPtr(ADst, ADstRect.Left, ADstRect.Top));
          OldSrcY := -1;

          for J := 0 to DstClipH - 1 do
          begin
            if DstH <= 1 then
              SrcY := (ASrcRect.Top + ASrcRect.Bottom - 1) div 2
            else if True {FullEdge} then
              SrcY := Trunc(ASrcRect.Top + (J - ADstRect.Top) * Scale)
            else
              SrcY := Round(ASrcRect.Top + (J - ADstRect.Top) * Scale);

            if SrcY <> OldSrcY then
            begin
              SrcLine := Bitmap32GetScanLine(ASrc, SrcY);
              DstLinePtr := @DstLine[0];
              MapPtr := @MapHorz^[0];
              for I := 0 to DstClipW - 1 do
              begin
                DstLinePtr^ := SrcLine[MapPtr^];
                Inc(DstLinePtr);
                Inc(MapPtr);
              end;
              OldSrcY := SrcY;
            end else
            begin
              MoveLongWord(DstLine[-ADst.Width], DstLine[0], DstClipW);
            end;
            Inc(DstLine, ADst.Width);
          end;
      finally
        FreeMem(MapHorz);
      end;
    end;
  finally
    //EMMS;
  end;
end;
  
end.
