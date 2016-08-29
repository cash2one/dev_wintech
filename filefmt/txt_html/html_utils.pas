unit html_utils;

interface

uses
  define_htmldom;
                   
  function AttrGetOwnerElement(AttribNode: PHtmlAttribDomNode): PHtmlElementDomNode;

implementation
          
function AttrGetOwnerElement(AttribNode: PHtmlAttribDomNode): PHtmlElementDomNode;
begin
  if nil = AttribNode.ParentDomNode then
  begin
    Result := nil;
  end else
  begin
    Result := PHtmlElementDomNode(AttribNode.ParentDomNode);
  end;
end;
    
end.
