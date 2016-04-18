
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_contentfilter;
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

  procedure InitCefContentFilter(ACefContentFilter: PCefIntfContentFilter);
  
implementation

uses
  cef_apilib;
  
procedure Cef_Content_Filter_process_data(self: PCefContentFilter;
        const data: Pointer; data_size: Integer;
        var substitute_data: PCefStreamReader); stdcall;
//(*//
var
  //fFileStream: TFileStream;
  tmpUrl: string;
  tmpfile: string;
  tmpstr: string;
  tmpPos: integer;
//*)
begin
  exit;
  //(*//
  if PCefExContentFilter(self).url <> '' then
  begin
    tmpUrl := lowercase(PCefExContentFilter(self).url);
    tmpfile := tmpUrl;
    tmpPos := Pos('://', tmpfile);
    tmpstr := Copy(tmpfile, 1, tmpPos - 1);
    if (tmpstr = 'http') or (tmpstr = 'https') then
    begin
      tmpfile := copy(tmpfile, tmpPos + 3, maxint);
      if pos('?', tmpfile) < 1 then
      begin
        // pfile -- http://www.2ccc.com:80/
        tmpfile := StringReplace(tmpfile, '/', '\', [rfReplaceAll]);

        tmpPos := Pos('\', tmpfile);
        if tmpPos > 0 then
        begin
          tmpstr := Copy(tmpfile, 1, tmpPos - 1);
          tmpfile := Copy(tmpfile, tmpPos + 1, maxint);

          tmpPos := Pos(':', tmpStr);
          if tmpPos > 0 then
          begin
            tmpfile := Copy(tmpstr, 1, tmpPos - 1) + '\' + tmpfile;
          end else
          begin
            tmpfile := tmpstr + '\' + tmpfile;
          end;
        end else
        begin
          // www.2ccc.com:80
          // root homepage
        end;
        tmpfile := extractFilePath(ParamStr(0)) +
            'webcache\' +
            tmpfile;

        Sysutils.ForceDirectories(ExtractFilePath(tmpfile));
        tmpstr := ExtractFileExt(tmpfile);
        if tmpstr <> '' then
        begin
          if (tmpstr = '.js') or
             (tmpstr = '.png') or
             (tmpstr = '.jpg') or
             (tmpstr = '.jpeg') or
             (tmpstr = '.gif') or
             (tmpstr = '.woff') or
             (tmpstr = '.css') then
          begin
            if FileExists(tmpfile) then
            begin
              //fFileStream := TFileStream.Create(tmpfile, fmOpenReadWrite or fmShareDenyNone);
            end else
            begin
              //fFileStream := TFileStream.Create(tmpfile, fmCreate or fmShareDenyNone);
            end;
            try
              //fFileStream.Position := fFileStream.Size;
              //fFileStream.Write(Data^, data_size);
            finally
              //fFileStream.Free;
            end;
          end else
          begin
            if tmpstr = 'test' then
            begin

            end;
          end;
        end;
      end;
    end;
  end;
  //*)
end;
    // Called when there is no more data to be processed. It is expected that
    // whatever data was retained in the last process_data() call, it should be
    // returned now by setting |remainder| if appropriate.
procedure Cef_Content_Filter_Drain(self: PCefContentFilter; var remainder: PCefStreamReader); stdcall;
begin

end;

procedure InitCefContentFilter(ACefContentFilter: PCefIntfContentFilter);
begin
  ACefContentFilter.IntfPtr := @ACefContentFilter.CefContentFilter;
  ACefContentFilter.CefContentFilter.base.size := SizeOf(TCefRequestHandler);
  ACefContentFilter.CefContentFilter.base.add_ref := @cef_base_add_ref;
  ACefContentFilter.CefContentFilter.base.release := @cef_base_release;
  ACefContentFilter.CefContentFilter.base.get_refct := @cef_base_get_refct;

  ACefContentFilter.CefContentFilter.process_data := @Cef_Content_Filter_process_data;
  ACefContentFilter.CefContentFilter.drain := @Cef_Content_Filter_Drain;
end;

end.
