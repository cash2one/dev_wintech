
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_streamreader;
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

  procedure InitCefStreamReader(ACefStreamReader: PCefIntfStreamReader);

implementation

uses
  BaseApp, cef_app, cef_apilib;

    // Read raw binary data.
function Cef_Stream_Reader_read(self: PCefStreamReader; ptr: Pointer; size, n: Cardinal): Cardinal; stdcall;
begin
  Result := 0;
//  if PCefExStreamReader(self).FileStream = nil then
//  begin
//    if PCefExStreamReader(self).FileUrl <> '' then
//    begin
//      if FileExists(PCefExStreamReader(self).FileUrl) then
//      begin
//        PCefExStreamReader(self).FileStream := TFileStream.Create(PCefExStreamReader(self).FileUrl, fmOpenRead or fmShareDenyNone);
//      end;
//    end;
//  end;
//  if PCefExStreamReader(self).FileStream <> nil then
//  begin
//    Result := PCefExStreamReader(self).FileStream.Read(ptr^, size);
//  end;
end;

    // Seek to the specified offset position. |whence| may be any one of SEEK_CUR,
    // SEEK_END or SEEK_SET. Returns zero on success and non-zero on failure.
function Cef_Stream_Reader_seek(self: PCefStreamReader; offset: Int64; whence: Integer): Integer; stdcall;
begin
  Result := 1;
//  if PCefExStreamReader(self).FileStream <> nil then
//  begin
//    PCefExStreamReader(self).FileStream.Position := offset;
//    Result := 0;
//  end;
end;

    // Return the current offset position.
function Cef_Stream_Reader_tell(self: PCefStreamReader): Int64; stdcall;
begin
  Result := 0;
//  if PCefExStreamReader(self).FileStream <> nil then
//  begin
//    Result := PCefExStreamReader(self).FileStream.Position;
//  end;
end;

// Return non-zero if at end of file.
function Cef_Stream_Reader_eof(self: PCefStreamReader): Integer; stdcall;
begin
  Result := 1;
  if PCefExStreamReader(self).FileUrl <> '' then
  begin
    if PCefExStreamReader(self).FileUrl <> '' then
    begin
//      if PCefExStreamReader(self).FileStream <> nil then
//      begin
//        Result := 0;
//        if PCefExStreamReader(self).FileStream.Position >= PCefExStreamReader(self).FileStream.Size - 1 then
//        begin
//          Result := 1;
//        end;
//      end;
    end;
  end;
end;

procedure InitCefStreamReader(ACefStreamReader: PCefIntfStreamReader);
begin
  ACefStreamReader.IntfPtr := @ACefStreamReader.CefStreamReader;
  ACefStreamReader.CefStreamReader.base.size := SizeOf(TCefStreamReader);
  ACefStreamReader.CefStreamReader.base.add_ref := @cef_base_add_ref;
  ACefStreamReader.CefStreamReader.base.release := @cef_base_release;
  ACefStreamReader.CefStreamReader.base.get_refct := @cef_base_get_refct;

  ACefStreamReader.CefStreamReader.read := @Cef_Stream_Reader_read;
  ACefStreamReader.CefStreamReader.seek := @Cef_Stream_Reader_seek;
  ACefStreamReader.CefStreamReader.tell := @Cef_Stream_Reader_tell;
  ACefStreamReader.CefStreamReader.eof := @Cef_Stream_Reader_eof;
end;

end.
