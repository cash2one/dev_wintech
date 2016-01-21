unit chromium_dom;

interface

uses
  sysutils,
  cef_type, cef_api, cef_apilib;

type  
  TCefDomVisitProc = procedure (self: PCefDomVisitor; document: PCefDomDocument); stdcall;

  { 遍历 html dom 节点 }
  procedure TestTraverseChromiumDom(AClientObject: PCefClientObject; ACefDomVisitProc: TCefDomVisitProc);

implementation

type
  PDomTraverseParam = ^TDomTraverseParam;
  TDomTraverseParam = record
    Level: integer;
  end;

procedure TraverseDomNode_Proc(ANode: PCefDomNode; ADomTraverseParam: PDomTraverseParam);
var
  tmpName: ustring;
  tmpAttrib: ustring;
  tmpStr: ustring;
  tmpCefStr: TCefString;
  tmpChild: PCefDomNode; 
begin
  { 处理当前节点 }
  tmpName := CefStringFreeAndGet(ANode.get_name(ANode));  
  if SameText(tmpName, '#text') then
  begin
  end;
  tmpCefStr := CefString('href');
  tmpAttrib := CefStringFreeAndGet(ANode.get_element_attribute(ANode, @tmpCefStr)); 
  tmpStr := CefStringFreeAndGet(ANode.get_element_inner_text(ANode));

  { 处理子节点 }
  ADomTraverseParam.Level := ADomTraverseParam.Level + 1;
  tmpChild := ANode.get_first_child(ANode);
  while tmpChild <> nil do
  begin
    TraverseDomNode_Proc(tmpChild, ADomTraverseParam);
    tmpChild := tmpChild.get_next_sibling(tmpChild);
  end;
  ADomTraverseParam.Level := ADomTraverseParam.Level - 1;
end;

procedure CefDomVisit_Proc(self: PCefDomVisitor; document: PCefDomDocument); stdcall;
var
  tmpNode: PCefDomNode;
  tmpDomTraverseParam: TDomTraverseParam;
begin           
  if document <> nil then
  begin
    tmpNode := document.get_document(document);
    if tmpNode <> nil then
    begin
      FillChar(tmpDomTraverseParam, SizeOf(tmpDomTraverseParam), 0);
      TraverseDomNode_Proc(tmpNode, @tmpDomTraverseParam);
    end;
  end;
end;

procedure TestTraverseChromiumDom(AClientObject: PCefClientObject; ACefDomVisitProc: TCefDomVisitProc);
var
  tmpMainFrame: PCefFrame;
  tmpCefDomVisitor: TCefIntfDomVisitor;
begin
  tmpMainFrame := AClientObject.CefBrowser.get_main_frame(AClientObject.CefBrowser);
  if tmpMainFrame <> nil then
  begin
    if Assigned(ACefDomVisitProc) then
    begin
      InitCefDomVisitor(@tmpCefDomVisitor, AClientObject, ACefDomVisitProc);
    end else
    begin
      InitCefDomVisitor(@tmpCefDomVisitor, AClientObject, CefDomVisit_Proc);
    end;
    tmpMainFrame.visit_dom(tmpMainFrame, @tmpCefDomVisitor.CefDomVisitor);
  end;
end;

end.
