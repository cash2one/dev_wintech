unit uiview_text_ex;

interface

uses
  uiview_text;
  
  procedure TextLineAddCharW(ATextLine: PUITextLineW; ATextPos: PUITextLinePos; AChar: WideChar);

implementation

uses
  Windows;
  
procedure TextLineAddCharW(ATextLine: PUITextLineW; ATextPos: PUITextLinePos; AChar: WideChar);
begin
  if nil = ATextLine.FirstCharBufferNode then
  begin
    ATextLine.FirstCharBufferNode := CheckOutUICharBufferNodeW(ATextLine, nil);
  end;
  if nil = ATextPos.CurrentNode then
  begin
    ATextPos.CurrentNode := ATextLine.FirstCharBufferNode;
  end;
  if ATextPos.CurrentNode.BufferLen = ATextPos.CurrentNode.BufferSize then
  begin
    // 当前数据长度已经 是 Buffer 最后了
    if ATextPos.Position = ATextPos.CurrentNode.BufferSize then
    begin
      // 插入点在 Buffer 尾部
      ATextPos.CurrentNode := CheckOutUICharBufferNodeW(ATextLine, ATextPos.CurrentNode);
      ATextPos.Position := 0;
    end else
    begin
      // 插入点在 Buffer 中间
      CheckOutUICharBufferNodeW(ATextLine, ATextPos.CurrentNode);
      // 将插入点后面的 copy 到下一个 Buffer 中
      CopyMemory(
        @ATextPos.CurrentNode.NextSibling.Buffer.Data[0],
        @ATextPos.CurrentNode.Buffer.Data[ATextPos.Position],
        (ATextPos.CurrentNode.BufferLen - ATextPos.Position) * 2);
      ATextPos.CurrentNode.NextSibling.BufferLen :=
          ATextPos.CurrentNode.BufferLen - ATextPos.Position;
      // 清除原先插入点后面的 buffer 数据
      FillChar(ATextPos.CurrentNode.Buffer.Data[ATextPos.Position],
        ATextPos.CurrentNode.BufferLen - ATextPos.Position, 0);
      ATextPos.CurrentNode.BufferLen := ATextPos.Position;
    end;
  end;
  if ATextPos.Position = ATextPos.CurrentNode.BufferLen then
  begin
    ATextPos.CurrentNode.Buffer.Data[ATextPos.Position] := AChar;
    Inc(ATextPos.CurrentNode.BufferLen);
    ATextPos.Position := ATextPos.CurrentNode.BufferLen;
  end else
  begin
    CopyMemory(
      @ATextPos.CurrentNode.Buffer.Data[ATextPos.Position + 1],
      @ATextPos.CurrentNode.Buffer.Data[ATextPos.Position],
      (ATextPos.CurrentNode.BufferLen - ATextPos.Position) * 2);
    ATextPos.CurrentNode.Buffer.Data[ATextPos.Position] := AChar;
    Inc(ATextPos.CurrentNode.BufferLen);
    Inc(ATextPos.Position);
  end;
end;

end.
