unit uiwin.dcdraw;

interface
               
uses
  Windows, uiwin.dc;

  procedure DrawRaiseOuterEffect(ADC: PWinDC; AClientRect: TRect);
  procedure DrawRaiseInnerEffect(ADC: PWinDC; AClientRect: TRect);
  procedure DrawSunKenOuterEffect(ADC: PWinDC; AClientRect: TRect);
  procedure DrawSunKenInnerEffect(ADC: PWinDC; AClientRect: TRect);

implementation

procedure DrawRaiseOuterEffect(ADC: PWinDC; AClientRect: TRect);
begin
  Windows.DrawEdge(ADC.DCHandle, AClientRect, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);
  Windows.DrawEdge(ADC.DCHandle, AClientRect, BDR_RAISEDOUTER, BF_TOPLEFT);
end;

procedure DrawRaiseInnerEffect(ADC: PWinDC; AClientRect: TRect);
begin
  Windows.DrawEdge(ADC.DCHandle, AClientRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
  Windows.DrawEdge(ADC.DCHandle, AClientRect, BDR_RAISEDINNER, BF_TOPLEFT);
end;

procedure DrawSunKenOuterEffect(ADC: PWinDC; AClientRect: TRect);
begin
  Windows.DrawEdge(ADC.DCHandle, AClientRect, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
  Windows.DrawEdge(ADC.DCHandle, AClientRect, BDR_SUNKENOUTER, BF_TOPLEFT);
end;

procedure DrawSunKenInnerEffect(ADC: PWinDC; AClientRect: TRect);
begin
  Windows.DrawEdge(ADC.DCHandle, AClientRect, BDR_SUNKENINNER, BF_BOTTOMRIGHT);
  Windows.DrawEdge(ADC.DCHandle, AClientRect, BDR_SUNKENINNER, BF_TOPLEFT);
end;

end.
