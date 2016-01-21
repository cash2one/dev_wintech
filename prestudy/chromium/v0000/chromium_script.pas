unit chromium_script;

interface

uses
  sysutils,
  cef_apilib, cef_api, cef_type;
  
  procedure TestRunScript(AClientObject: PCefClientObject);

implementation

procedure TestRunScript(AClientObject: PCefClientObject);
var
  tmpMainFrame: PCefFrame;
  tmpUrl: ustring;
  tmpJs: ustring;
  tmpJsCode: TCefString;
  tmpScriptUrl: TCefString;
begin
  tmpMainFrame := AClientObject.CefBrowser.get_main_frame(AClientObject.CefBrowser);
  if tmpMainFrame <> nil then
  begin
    tmpUrl := CefStringFreeAndGet(tmpMainFrame.get_url(tmpMainFrame));
    if Pos('login', LowerCase(tmpUrl)) > 0 then
    begin
      tmpJs :=
          'document.getElementById("accountInput").value = "' + '' +'"' + ';' +
          'document.getElementById("passwordInput").value = "' + '' + '"' + ';';
      tmpJsCode := CefString(tmpJs);
      tmpScriptUrl := CefString('');
      tmpMainFrame.execute_java_script(tmpMainFrame, @tmpJsCode, @tmpScriptUrl, 0);
      tmpJs :=
          'document.getElementById("userSmbBtn").click()' + ';';
      tmpJsCode := CefString(tmpJs);   
      tmpMainFrame.execute_java_script(tmpMainFrame, @tmpJsCode, @tmpScriptUrl, 0);
    end;
  end;
end;

end.
