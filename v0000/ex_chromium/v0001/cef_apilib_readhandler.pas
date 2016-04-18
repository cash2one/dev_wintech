
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_readhandler;
{$ALIGN ON}
{$MINENUMSIZE 4}
{$I cef.inc}

interface

uses
  Windows, Messages, Sysutils, //Classes,
  //sdlogutils, 
  Cef_api,
  cef_type,
  cef_apiobj;

  procedure InitCefReaderHandler(ACefReadHandler: PCefIntfReadHandler);

implementation

uses
  BaseApp, cef_app, cef_apilib;

function Cef_Read_Handler_read(self: PCefReadHandler; ptr: Pointer;
      size, n: Cardinal): Cardinal; stdcall;
begin
  Result := 0;
//  if PCefExReadHandler(self).FileStream = nil then
//  begin
//    if PCefExReadHandler(self).FileUrl <> '' then
//    begin
//      if FileExists(PCefExReadHandler(self).FileUrl) then
//      begin
//        PCefExReadHandler(self).FileStream := TFileStream.Create(PCefExReadHandler(self).FileUrl, fmOpenRead or fmShareDenyNone);
//      end;
//    end;
//  end;
//  // size = 1 n = 999999
//  if PCefExReadHandler(self).FileStream <> nil then
//  begin
//    result := Cardinal(PCefExReadHandler(self).FileStream.Read(ptr^, n * size)) div size;
//  end;
end;

const
  SEEK_SET = 0; //文件开头
  SEEK_CUR = 1; //当前位置
  SEEK_END = 2; //文件结尾

    // Seek to the specified offset position. |whence| may be any one of SEEK_CUR,
    // SEEK_END or SEEK_SET. Return zero on success and non-zero on failure.
function Cef_Read_Handler_seek(self: PCefReadHandler; offset: Int64;
      whence: Integer): Integer; stdcall;
begin
  Result := 1;
//  if PCefExReadHandler(self).FileStream = nil then
//  begin
//    if PCefExReadHandler(self).FileUrl <> '' then
//    begin
//      if FileExists(PCefExReadHandler(self).FileUrl) then
//      begin
//        PCefExReadHandler(self).FileStream := TFileStream.Create(PCefExReadHandler(self).FileUrl, fmOpenRead or fmShareDenyNone);
//      end;
//    end;
//  end;
//  if PCefExReadHandler(self).FileStream <> nil then
//  begin
//    case whence of
//      SEEK_SET: begin
//        PCefExReadHandler(self).FileStream.Position := offset;
//        Result := 0;
//      end;
//      SEEK_CUR: begin
//        PCefExReadHandler(self).FileStream.Position := PCefExReadHandler(self).FileStream.Position + offset;
//        Result := 0;
//      end;
//      SEEK_END: begin
//        PCefExReadHandler(self).FileStream.Position := PCefExReadHandler(self).FileStream.Size;
//        Result := 0;
//      end;
//    end;
//  end;
end;

    // Return the current offset position.
function Cef_Read_Handler_tell(self: PCefReadHandler): Int64; stdcall;
begin
  Result := 0;
//  if PCefExReadHandler(self).FileStream <> nil then
//  begin
//    Result := PCefExReadHandler(self).FileStream.Position;
//  end;
end;
    // Return non-zero if at end of file.
function Cef_Read_Handler_eof(self: PCefReadHandler): Integer; stdcall;
begin
  Result := 1;
  if PCefExReadHandler(self).FileUrl <> '' then
  begin
//      if PCefExReadHandler(self).FileStream <> nil then
//      begin
//        Result := 0;
//        if PCefExReadHandler(self).FileStream.Position >= PCefExReadHandler(self).FileStream.Size - 1 then
//        begin
//          Result := 1;
//        end;
//      end;
  end;
end;

procedure InitCefReaderHandler(ACefReadHandler: PCefIntfReadHandler);
begin
  ACefReadHandler.IntfPtr := @ACefReadHandler.CefReadReader;
  ACefReadHandler.CefReadReader.base.size := SizeOf(TCefReadHandler);
  ACefReadHandler.CefReadReader.base.add_ref := @cef_base_add_ref;
  ACefReadHandler.CefReadReader.base.release := @cef_base_release;
  ACefReadHandler.CefReadReader.base.get_refct := @cef_base_get_refct;

  ACefReadHandler.CefReadReader.read := @Cef_Read_Handler_read;
  ACefReadHandler.CefReadReader.seek := @Cef_Read_Handler_seek;
  ACefReadHandler.CefReadReader.tell := @Cef_Read_Handler_tell;
  ACefReadHandler.CefReadReader.eof := @Cef_Read_Handler_eof;
end;

end.
