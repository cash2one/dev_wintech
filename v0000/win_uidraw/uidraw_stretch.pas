unit uidraw_stretch;

interface

uses
  ui.color, ui.bitmap, ui.space, uidraw.resampler;
                   
  procedure Bitmap32Stretch(ADstBitmap32: PBitmap32; ADstRect: TUIRect; ASrc: PBitmap32; ASrcRect: TUIRect; AResampler: PBaseResampler);  

implementation

uses
  Math,
  BaseType,
  uidraw_stretch_nearest,
  uiwin.bitmap_draw,
  win_data_move,
  ui.bitmap_pixel;

procedure Bitmap32Stretch(ADstBitmap32: PBitmap32; ADstRect: TUIRect; ASrc: PBitmap32; ASrcRect: TUIRect; AResampler: PBaseResampler);
var
  RatioX: Single;
  RatioY: Single; 
  DstBoundsRect: TUIRect;    
  R: TUIRect;         
  SrcW, SrcH: Integer;
  DstW, DstH: Integer;
begin         
  // transform dest rect when the src rect is out of the src bitmap's bounds
  if (ASrcRect.Left < 0) or (ASrcRect.Right > ASrc.Width) or
    (ASrcRect.Top < 0) or (ASrcRect.Bottom > ASrc.Height) then
  begin
    RatioX := (ADstRect.Right - ADstRect.Left) / (ASrcRect.Right - ASrcRect.Left);
    RatioY := (ADstRect.Bottom - ADstRect.Top) / (ASrcRect.Bottom - ASrcRect.Top);

    if ASrcRect.Left < 0 then
    begin
      ADstRect.Left := ADstRect.Left + Math.Ceil(-ASrcRect.Left * RatioX);
      ASrcRect.Left := 0;
    end;

    if ASrcRect.Top < 0 then
    begin
      ADstRect.Top := ADstRect.Top + Ceil(-ASrcRect.Top * RatioY);
      ASrcRect.Top := 0;
    end;

    if ASrcRect.Right > ASrc.Width then
    begin
      ADstRect.Right := ADstRect.Right - Floor((ASrcRect.Right - ASrc.Width) * RatioX);
      ASrcRect.Right := ASrc.Width;
    end;

    if ASrcRect.Bottom > ASrc.Height then
    begin
      ADstRect.Bottom := ADstRect.Bottom - Floor((ASrcRect.Bottom - ASrc.Height) * RatioY);
      ASrcRect.Bottom := ASrc.Height;
    end;
  end;

  DstBoundsRect.Left := 0;
  DstBoundsRect.Top := 0;
  DstBoundsRect.Right := ADstBitmap32.Width;
  DstBoundsRect.Bottom := ADstBitmap32.Height;
    
  SrcW := ASrcRect.Right - ASrcRect.Left;
  SrcH := ASrcRect.Bottom - ASrcRect.Top;
  DstW := ADstRect.Right - ADstRect.Left;
  DstH := ADstRect.Bottom - ADstRect.Top;

  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      Bitmap32Draw(ADstBitmap32, ADstRect, ASrc, ASrcRect.Left, ASrcRect.Top);
    end else
    begin
      StretchDraw_Nearest(ADstBitmap32, ADstRect, ASrc, ASrcRect);
//      DoResample_Nearest(
//        ADstBitmap32, ADstRect, DstClip,
//        ASrc, ASrcDrawSession, ASrcRect, CombineOp, CombineCallBack);
    end;
  finally
    //EMMS;
  end;
end;

end.
