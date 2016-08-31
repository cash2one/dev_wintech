unit html_utils;

interface

uses
  Classes, Sysutils,
  define_htmldom;

type
  DomException = class(Exception)
  public
    FCode: Integer;
  public
    constructor Create(code: Integer);
    property code: Integer read FCode;
  end;

const            
  ERR_INDEX_SIZE                 = 1;
  ERR_DOMSTRING_SIZE             = 2;
  ERR_HIERARCHY_REQUEST          = 3;
  ERR_WRONG_DOCUMENT             = 4;
  ERR_INVALID_CHARACTER          = 5;
  ERR_NO_DATA_ALLOWED            = 6;
  ERR_NO_MODIFICATION_ALLOWED    = 7;
  ERR_NOT_FOUND                  = 8;
  ERR_NOT_SUPPORTED              = 9;
  ERR_INUSE_ATTRIBUTE            = 10;
  ERR_INVALID_STATE              = 11;
  ERR_SYNTAX                     = 12;
  ERR_INVALID_MODIFICATION       = 13;
  ERR_NAMESPACE                  = 14;
  ERR_INVALID_ACCESS             = 15;

  function CharacterDataNodeGetLength(AHtmlDomNode: PHtmlDomNode): Integer;
  
  function AttrGetOwnerElement(AttribNode: PHtmlAttribDomNode): PHtmlElementDomNode;
  function AttrGetLength(AttribNode: PHtmlAttribDomNode): Integer;
                        
  function createEmptyDocument(doctype: PHtmlDocTypeDomNode): PHtmlDocDomNode;      
  function createDocumentType(const qualifiedName, publicId, systemId: WideString): PHtmlDocTypeDomNode;     
  function CheckOutHtmlDomNode(ANodeType: Integer; ownerDocument: PHtmlDocDomNode; const namespaceURI, qualifiedName: WideString; withNS: Boolean): PHtmlDomNode; overload; 
  function CheckOutElementDomNode(ownerDocument: PHtmlDocDomNode; const namespaceURI, qualifiedName: WideString; withNS: Boolean): PHtmlElementDomNode;     
  function CheckOutTextDomNode(ANodeType: Integer; ownerDocument: PHtmlDocDomNode; data: WideString): PHtmlDomNode; overload;
  function CheckOutEntityReferenceNode(ownerDocument: PHtmlDocDomNode; const name: WideString): PHtmlDomNode;
                                
  procedure HtmlDomNodeFree(var ADomNode: PHtmlDomNode);
  function HtmlDomNodeGetName(AHtmlDomNode: PHtmlDomNode): WideString;
  function HtmlDomNodeAppendChild(AHtmlDomNode, newChild: PHtmlDomNode): PHtmlDomNode;
  function NodeGetParentDomNode(AHtmlDomNode: PHtmlDomNode): PHtmlDomNode;
                           
  procedure HtmlDocSetDocType(ADocument: PHtmlDocDomNode; value: PHtmlDocTypeDomNode{TDocumentTypeObj});
  function HtmlDocGetDocumentElement(ADocument: PHtmlDocDomNode): PHtmlElementDomNode;
                                                
  function DecValue(const Digit: WideChar): Word;
  function HexValue(const HexChar: WideChar): Word;

implementation

uses
  html_helperclass, html_entity, define_htmltag;
              
const
  ExceptionMsg: array[ERR_INDEX_SIZE..ERR_INVALID_ACCESS] of String = (
    'Index or size is negative, or greater than the allowed value',
    'The specified range of text does not fit into a DOMString',
    'Node is inserted somewhere it doesn''t belong ',
    'Node is used in a different document than the one that created it',
    'Invalid or illegal character is specified, such as in a name',
    'Data is specified for a node which does not support data',
    'An attempt is made to modify an object where modifications are not allowed',
    'An attempt is made to reference a node in a context where it does not exist',
    'Implementation does not support the requested type of object or operation',
    'An attempt is made to add an attribute that is already in use elsewhere',
    'An attempt is made to use an object that is not, or is no longer, usable',
    'An invalid or illegal string is specified',
    'An attempt is made to modify the type of the underlying object',
    'An attempt is made to create or change an object in a way which is incorrect with regard to namespaces',
    'A parameter or an operation is not supported by the underlying object'
  );

constructor DomException.Create(code: Integer);
begin
  inherited Create(ExceptionMsg[code]);
  FCode := code
end;
                    
function DecValue(const Digit: WideChar): Word;
begin
  Result := Ord(Digit) - Ord('0')
end;

function HexValue(const HexChar: WideChar): Word;
var
  C: Char;
begin
  if Ord(HexChar) in define_htmltag.decDigit then
    Result := Ord(HexChar) - Ord('0')
  else
  begin
    C := UpCase(Chr(Ord(HexChar)));
    Result := Ord(C) - Ord('A')
  end
end;
       
procedure HtmlDomNodeFree(var ADomNode: PHtmlDomNode);
var
  i: integer;
  tmpNode: PHtmlDomNode;
begin
  if nil = ADomNode then
    exit;
  //Windows.InterlockedDecrement(GlobalTestNodeCount);

  if nil <> ADomNode.OwnerDocument then
  begin
    if (nil <> ADomNode.OwnerDocument.AllOwnedNodes) then
    begin
      i := ADomNode.OwnerDocument.AllOwnedNodes.IndexOf(ADomNode);
      if 0 <= i then
        ADomNode.OwnerDocument.AllOwnedNodes.Delete(i);
    end;
  end;     
  if (nil <> ADomNode.ChildNodes) then
  begin
    ADomNode.ChildNodes.NodeListClear(true);
    ADomNode.ChildNodes.Free;
    ADomNode.ChildNodes := nil;
  end;
  if (nil <> ADomNode.Attributes) then
  begin
    ADomNode.Attributes.NodeListClear(true);
    ADomNode.Attributes.Free;
    ADomNode.Attributes := nil;
  end;   

  if HTMLDOM_NODE_DOCUMENT = ADomNode.NodeType then
  begin
    if nil <> PHtmlDocDomNode(ADomNode).DocTypeDomNode then
    begin
      HtmlDomNodeFree(PHtmlDomNode(PHtmlDocDomNode(ADomNode).DocTypeDomNode));
    end;
    if nil <> PHtmlDocDomNode(ADomNode).AllOwnedNodes then
    begin
      while 0 < PHtmlDocDomNode(ADomNode).AllOwnedNodes.Count do
      begin
        tmpNode := PHtmlDocDomNode(ADomNode).AllOwnedNodes.Items[0];
        HtmlDomNodeFree(tmpNode);
      end;
      PHtmlDocDomNode(ADomNode).AllOwnedNodes.Free;
    end; 
    PHtmlDocDomNode(ADomNode).NamespaceURIList.Free;
    PHtmlDocDomNode(ADomNode).SearchNodeLists.Free;
  end;  
  FreeMem(ADomNode);
  ADomNode := nil;
end;
                            
procedure HtmlDocSetDocType(ADocument: PHtmlDocDomNode; value: PHtmlDocTypeDomNode{TDocumentTypeObj});
begin
  if (nil <> ADocument.DocTypeDomNode) then
  begin
    HtmlDomNodeFree(PHtmlDomNode(ADocument.DocTypeDomNode));
  end;
  ADocument.DocTypeDomNode := value;
end;
           
function CharacterDataNodeGetLength(AHtmlDomNode: PHtmlDomNode): Integer;
begin
  Result := System.Length(AHtmlDomNode.NodeValue)
end;
                   
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

function AttrGetLength(AttribNode: PHtmlAttribDomNode): Integer;
var
  Node: PHtmlDomNode;
  I: Integer;
begin
  Result := 0;
  for I := 0 to AttribNode.childNodes.length - 1 do
  begin
    Node := AttribNode.childNodes.item(I);
    if Node.NodeType = HTMLDOM_NODE_TEXT then
      Inc(Result, CharacterDataNodeGetLength(Node))
    else
    if Node.NodeType = HTMLDOM_NODE_ENTITY_REFERENCE then
      Inc(Result)
  end
end;
                        
procedure HtmlDomNodeSetNamespaceURI(AHtmlDomNode: PHtmlDomNode; const value: WideString);
begin
  if value <> '' then
    //TODO validate
    AHtmlDomNode.NamespaceURI := AHtmlDomNode.ownerDocument.namespaceURIList.Add(value)
end;
                         
function IsNCName(const Value: WideString): Boolean;
begin
  //TODO
  Result := true
end;

procedure HtmlDomNodeSetPrefix(AHtmlDomNode: PHtmlDomNode; const value: WideString);
begin
  if not IsNCName(value) then
    raise DomException.Create(ERR_INVALID_CHARACTER);
  AHtmlDomNode.Prefix := value
end;
                    
procedure HtmlDomNodeSetLocalName(AHtmlDomNode: PHtmlDomNode; const value: WideString);
begin
  if not IsNCName(value) then
    raise DomException.Create(ERR_INVALID_CHARACTER);
  AHtmlDomNode.NodeName := value
end;

procedure DomNodeInitialize(AHtmlDomNode: PHtmlDomNode; ANodeType: Integer; ownerDocument: PHtmlDocDomNode; const namespaceURI, qualifiedName: WideString; withNS: Boolean);
var
  I: Integer;
begin
  AHtmlDomNode.NodeType := ANodeType;
  AHtmlDomNode.OwnerDocument := ownerDocument;
  HtmlDomNodeSetNamespaceURI(AHtmlDomNode, namespaceURI);
  if withNS then
  begin
    I := Pos(':', qualifiedName);
    if I <> 0 then
    begin
      HtmlDomNodeSetPrefix(AHtmlDomNode, Copy(qualifiedName, 1, I - 1));
      HtmlDomNodeSetLocalName(AHtmlDomNode, Copy(qualifiedName, I + 1, Length(qualifiedName) - I))
    end else
    begin
      HtmlDomNodeSetLocalName(AHtmlDomNode, qualifiedName)
    end;
  end else
  begin
    HtmlDomNodeSetLocalName(AHtmlDomNode, qualifiedName);
  end;
  AHtmlDomNode.ChildNodes := TNodeList.Create(AHtmlDomNode);
end;

function CheckOutHtmlDomNode(ANodeType: Integer; ownerDocument: PHtmlDocDomNode; const namespaceURI, qualifiedName: WideString; withNS: Boolean): PHtmlDomNode; overload; 
begin                   
  Result := System.New(PHtmlDomNode);
  FillChar(Result^, SizeOf(THtmlDomNode), 0);
  
  //Windows.InterlockedIncrement(GlobalTestNodeCount);
  ownerDocument.AllOwnedNodes.Add(Result);
  
  DomNodeInitialize(Result, ANodeType, ownerDocument, namespaceURI, qualifiedName, withNS);
end;

function CheckOutHtmlDomNode(ownerDocument: PHtmlDocDomNode): PHtmlDomNode; overload;
begin
  Result := System.New(PHtmlDomNode);
  FillChar(Result^, SizeOf(THtmlDomNode), 0);

  //Windows.InterlockedIncrement(GlobalTestNodeCount);
  ownerDocument.AllOwnedNodes.Add(Result);  
end;
              
function CheckOutEntityReferenceNode(ownerDocument: PHtmlDocDomNode; const name: WideString): PHtmlDomNode;
begin
  Result := CheckOutHtmlDomNode(ownerDocument);
  DomNodeInitialize(Result, HTMLDOM_NODE_ENTITY_REFERENCE, ownerDocument, '', name, false);
end;
     
//constructor TCharacterDataNode.Create(ANodeType: Integer; ownerDocument: PHtmlDocDomNode; const data: WideString);
//begin
//  inherited Create(ANodeType, ownerDocument, '', '', false);
//  NodeSetValue(@fNodeData, data);
//end;
                           
function HtmlDomNodeGetFirstChild(AHtmlDomNode: PHtmlDomNode): PHtmlDomNode;
begin
  if AHtmlDomNode.childNodes.length <> 0 then
  begin
    Result := PHtmlDomNode(AHtmlDomNode.childNodes.item(0));
  end else
  begin
    Result := nil
  end;
end;
                          
function HtmlDocGetDocumentElement(ADocument: PHtmlDocDomNode): PHtmlElementDomNode;
var
  Child: PHtmlDomNode;
  I: Integer;
begin
  for I := 0 to ADocument.BaseDomNode.childNodes.length - 1 do
  begin
    Child := ADocument.BaseDomNode.childNodes.item(I);
    if HTMLDOM_NODE_ELEMENT = Child.NodeType then
    begin
      Result := PHtmlElementDomNode(Child);
      Exit
    end
  end;
  Result := nil
end;
            
function NodeIsCanInsert(AOwnerNode, AChildNode: PHtmlDomNode): Boolean;
begin
  Result := false;   
  if HTMLDOM_NODE_ATTRIBUTE = AOwnerNode.NodeType then
  begin      
    Result := AChildNode.NodeType in [HTMLDOM_NODE_ENTITY_REFERENCE, HTMLDOM_NODE_TEXT];
    exit;
  end;         
  if HTMLDOM_NODE_ELEMENT = AOwnerNode.NodeType then
  begin
    Result := not (AChildNode.NodeType in [HTMLDOM_NODE_ENTITY, HTMLDOM_NODE_DOCUMENT, HTMLDOM_NODE_DOCUMENT_TYPE, HTMLDOM_NODE_NOTATION]);
    exit;
  end;        
  if HTMLDOM_NODE_DOCUMENT_FRAGMENT = AOwnerNode.NodeType then
  begin
    Result := not (AChildNode.NodeType in [HTMLDOM_NODE_ENTITY, HTMLDOM_NODE_DOCUMENT, HTMLDOM_NODE_DOCUMENT_TYPE, HTMLDOM_NODE_NOTATION]);
    exit;
  end;         
  if HTMLDOM_NODE_DOCUMENT = AOwnerNode.NodeType then
  begin
    Result := (AChildNode.NodeType in [HTMLDOM_NODE_TEXT, HTMLDOM_NODE_COMMENT, HTMLDOM_NODE_PROCESSING_INSTRUCTION]) or
            (AChildNode.NodeType = HTMLDOM_NODE_ELEMENT) and (HtmlDocGetDocumentElement(PHtmlDocDomNode(AOwnerNode)) = nil);
  end;
end;
                           
function NodeGetParentDomNode(AHtmlDomNode: PHtmlDomNode): PHtmlDomNode;
begin
  Result := nil;
  if nil <> AHtmlDomNode then
  begin
    if HTMLDOM_NODE_ATTRIBUTE = AHtmlDomNode.NodeType then
    begin
      Result := nil;
    end else
    begin
      Result := AHtmlDomNode.ParentDomNode;
    end;
  end;
end;
               
function HtmlDomNodeIsAncestorOf(AHtmlDomNode: PHtmlDomNode; node: PHtmlDomNode): Boolean;
var
  tmpDomNode: PHtmlDomNode;
begin
  tmpDomNode := node;
  while (nil <> tmpDomNode) do
  begin
    if tmpDomNode = AHtmlDomNode then
    begin
      Result := true;
      Exit
    end;
    tmpDomNode := NodeGetParentDomNode(tmpDomNode);
  end;
  Result := false;
end;
                          
procedure HtmlDocInvalidateSearchNodeLists(ADocument: PHtmlDocDomNode);
var
  I: Integer;
begin
  for I := 0 to ADocument.SearchNodeLists.Count - 1 do
    TSearchNodeList(ADocument.SearchNodeLists[I]).Invalidate
end;
  
function HtmlDomNodeRemoveChild(AHtmlDomNode, oldChild: PHtmlDomNode): PHtmlDomNode;
var
  I: Integer;
begin
  I := AHtmlDomNode.ChildNodes.NodeListIndexOf(oldChild);
  if I < 0 then
    raise DomException.Create(ERR_NOT_FOUND);
  AHtmlDomNode.ChildNodes.NodeListDelete(I);
  oldChild.ParentDomNode := nil;
  Result := oldChild;
  if (nil <> AHtmlDomNode.ownerDocument) then
    HtmlDocInvalidateSearchNodeLists(AHtmlDomNode.ownerDocument)
end;

function HtmlDomNodeInsertSingleNode(AHtmlDomNode, newChild, refChild: PHtmlDomNode): PHtmlDomNode;
var
  I: Integer;
  tmpNode: PHtmlDomNode;
begin
  if not NodeIsCanInsert(AHtmlDomNode, newChild) or HtmlDomNodeIsAncestorOf(newChild, AHtmlDomNode) then
    raise DomException.Create(ERR_HIERARCHY_REQUEST);
  if newChild <> refChild then
  begin
    if (nil <> refChild) then
    begin
      I := AHtmlDomNode.ChildNodes.NodeListIndexOf(refChild);
      if I < 0 then
        raise DomException.Create(ERR_NOT_FOUND);
      AHtmlDomNode.ChildNodes.NodeListInsert(I, newChild)
    end else
    begin
      AHtmlDomNode.ChildNodes.NodeListAdd(newChild);
    end;
    tmpNode := NodeGetParentDomNode(newChild);
    if (nil <> tmpNode) then
      HtmlDomNoderemoveChild(tmpNode, newChild);
    newChild.ParentDomNode := AHtmlDomNode;
  end;
  Result := newChild
end;

function HtmlDomNodeinsertBefore(AHtmlDomNode, newChild, refChild: PHtmlDomNode): PHtmlDomNode;
var
  tmpDomNode: PHtmlDomNode;
begin
  if newChild.ownerDocument <> AHtmlDomNode.ownerDocument then
    raise DomException.Create(ERR_WRONG_DOCUMENT);
  if newChild.NodeType = HTMLDOM_NODE_DOCUMENT_FRAGMENT then
  begin
    tmpDomNode := HtmlDomNodeGetfirstChild(newChild);
    while (nil <> tmpDomNode) do
    begin
      HtmlDomNodeInsertSingleNode(AHtmlDomNode, tmpDomNode, refChild);
      tmpDomNode := HtmlDomNodeGetfirstChild(newChild);
    end;
    Result := newChild
  end else
  begin
    Result := HtmlDomNodeInsertSingleNode(AHtmlDomNode, newChild, refChild);
  end;
  if (nil <> AHtmlDomNode.ownerDocument) then
    HtmlDocInvalidateSearchNodeLists(AHtmlDomNode.ownerDocument)
end;
    
function HtmlDomNodeAppendChild(AHtmlDomNode, newChild: PHtmlDomNode): PHtmlDomNode;
begin
  Result := HtmlDomNodeinsertBefore(AHtmlDomNode, newChild, nil);
  if (nil <> AHtmlDomNode.ownerDocument) then
    HtmlDocInvalidateSearchNodeLists(AHtmlDomNode.ownerDocument)
end;
                   
function HtmlDomNodeGetName(AHtmlDomNode: PHtmlDomNode): WideString;
begin
  if HTMLDOM_NODE_CDATA_SECTION = AHtmlDomNode.NodeType then
  begin      
    Result := '#cdata-section';
    exit;
  end;    
  if HTMLDOM_NODE_COMMENT = AHtmlDomNode.NodeType then
  begin    
    Result := '#comment';
    exit;
  end;          
  if HTMLDOM_NODE_TEXT = AHtmlDomNode.NodeType then
  begin    
    Result := '#text';
    exit;
  end;      
  if HTMLDOM_NODE_DOCUMENT_FRAGMENT = AHtmlDomNode.NodeType then
  begin
    Result := '#document-fragment';
    exit;
  end;       
  if HTMLDOM_NODE_DOCUMENT = AHtmlDomNode.NodeType then
  begin
    Result := '#document';
    Exit;
  end;
  if AHtmlDomNode.Prefix <> '' then
  begin
    Result := AHtmlDomNode.Prefix + ':' + AHtmlDomNode.NodeName;
  end else
  begin
    Result := AHtmlDomNode.NodeName;
  end;
end;
          
function NodeGetValue(AHtmlDomNode: PHtmlDomNode): WideString;  
var
  Node: PHtmlDomNode;
  Len, Pos, I, J: Integer;
begin
  Result := '';
  if nil = AHtmlDomNode then
    exit;
  if HTMLDOM_NODE_ATTRIBUTE = AHtmlDomNode.NodeType then
  begin
    Len := AttrGetLength(PHtmlAttribDomNode(AHtmlDomNode));
    SetLength(Result, Len);
    Pos := 0;
    for I := 0 to AHtmlDomNode.childNodes.length - 1 do
    begin
      Node := AHtmlDomNode.childNodes.item(I);
      if Node.NodeType = HTMLDOM_NODE_TEXT then
      begin
        for J := 1 to CharacterDataNodeGetLength(Node) do
        begin
          Inc(Pos);
          Result[Pos] := Node.NodeValue[J]
        end
      end else if Node.NodeType = HTMLDOM_NODE_ENTITY_REFERENCE then
      begin
        Inc(Pos);
        Result[Pos] := html_entity.GetEntValue(HtmlDomNodeGetName(Node))
      end
    end
  end else
  begin
    Result := AHtmlDomNode.NodeValue;
  end;
end;
     
procedure NodeSetValue(AHtmlDomNode: PHtmlDomNode; const value: WideString); 
begin
  if HTMLDOM_NODE_ATTRIBUTE = AHtmlDomNode.NodeType then
  begin
    AHtmlDomNode.ChildNodes.NodeListClear(false);
    HtmlDomNodeappendChild(AHtmlDomNode, CheckOutTextDomNode(HTMLDOM_NODE_TEXT, AHtmlDomNode.ownerDocument, value));
    exit;
  end;
  if (HTMLDOM_NODE_TEXT = AHtmlDomNode.NodeType) or
     (HTMLDOM_NODE_COMMENT = AHtmlDomNode.NodeType) or
     (HTMLDOM_NODE_CDATA_SECTION = AHtmlDomNode.NodeType) then
  begin
    // charset node
    AHtmlDomNode.NodeValue := value
  end;
end;
           
function CheckOutTextDomNode(ANodeType: Integer; ownerDocument: PHtmlDocDomNode; data: WideString): PHtmlDomNode; overload;
begin                   
  Result := System.New(PHtmlDomNode);
  FillChar(Result^, SizeOf(THtmlDomNode), 0);

  //Windows.InterlockedIncrement(GlobalTestNodeCount);
  ownerDocument.AllOwnedNodes.Add(Result);
  
  DomNodeInitialize(Result, ANodeType, ownerDocument, '', '', false);    
  NodeSetValue(Result, data);
end;
          
function CheckOutElementDomNode(ownerDocument: PHtmlDocDomNode; const namespaceURI, qualifiedName: WideString; withNS: Boolean): PHtmlElementDomNode;
begin
  Result := System.New(PHtmlElementDomNode);
  FillChar(Result^, SizeOf(THtmlElementDomNode), 0);

  //Windows.InterlockedIncrement(GlobalTestNodeCount);
  ownerDocument.AllOwnedNodes.Add(Result);
  
  DomNodeInitialize(PHtmlDomNode(Result), HTMLDOM_NODE_ELEMENT, ownerDocument, namespaceURI, qualifiedName, withNS);
  Result.BaseDomNode.Attributes := TNamedNodeMap.Create(Result);
end;

function CheckOutDocTypeDomNode(ownerDocument: PHtmlDocDomNode; const name, publicId, systemId: WideString): PHtmlDocTypeDomNode;
begin
  Result := System.New(PHtmlDocTypeDomNode);
  FillChar(Result^, SizeOf(THtmlDocTypeDomNode), 0);

  //Windows.InterlockedIncrement(GlobalTestNodeCount);
  ownerDocument.AllOwnedNodes.Add(Result);

  DomNodeInitialize(PHtmlDomNode(Result), HTMLDOM_NODE_DOCUMENT_TYPE, ownerDocument, '', name, false);
  Result.PublicID := publicId;
  Result.SystemID := systemId;
end;
                 
function createDocumentType(const qualifiedName, publicId, systemId: WideString): PHtmlDocTypeDomNode;
begin
  Result := CheckOutDocTypeDomNode(nil, qualifiedName, publicId, systemId);
end;
   
function CheckOutDocDomNode(doctype: PHtmlDocTypeDomNode): PHtmlDocDomNode;
begin
  Result := System.New(PHtmlDocDomNode);
  FillChar(Result^, SizeOf(THtmlDocDomNode), 0);

  //Windows.InterlockedIncrement(GlobalTestNodeCount);
  Result.AllOwnedNodes := TList.Create;
  
  DomNodeInitialize(PHtmlDomNode(Result), HTMLDOM_NODE_DOCUMENT, Result, '', '', false);
  if nil <> doctype then
  begin
    Result.DocTypeDomNode := doctype;
  end;
  if (nil <> Result.DocTypeDomNode) then
    Result.DocTypeDomNode.BaseDomNode.OwnerDocument := Result;
  Result.NamespaceURIList := TNamespaceURIList.Create;
  Result.SearchNodeLists := TList.Create;
end;
           
function createEmptyDocument(doctype: PHtmlDocTypeDomNode): PHtmlDocDomNode;
begin
  Result := nil;
  if (nil <> doctype) and (nil <> doctype.BaseDomNode.ownerDocument) then
  begin
//    raise DomException.Create(ERR_WRONG_DOCUMENT);
  end;
  Result := CheckOutDocDomNode(doctype);
end;

end.
