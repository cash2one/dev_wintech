unit html_helperclass;

interface

uses
  Classes, WStrings;
  
type
  TNodeList = class
  public
    FOwnerNode: Pointer{TNode};
    FList: TList;
  public
    function GetLength: Integer; virtual;
    function NodeListIndexOf(node: Pointer{TNode}): Integer;
    procedure NodeListAdd(node: Pointer{TNode});
    procedure NodeListDelete(I: Integer);
    procedure NodeListInsert(I: Integer; node: Pointer{TNode});
    procedure NodeListRemove(node: Pointer{TNode});
    procedure NodeListClear(WithItems: Boolean);
    property ownerNode: Pointer{TNode} read FOwnerNode;
    constructor Create(AOwnerNode: Pointer{TNode});
  public                                  
    destructor Destroy; override;
    function item(index: Integer): Pointer{TNode}; virtual;
    property length: Integer read GetLength;
  end;
          
  TNamedNodeMap = class(TNodeList)
  public
    function getNamedItem(const name: WideString): Pointer{TNode};
    function setNamedItem(arg: Pointer{TNode}): Pointer{TNode};
    function removeNamedItem(const name: WideString): Pointer{TNode};
    function getNamedItemNS(const namespaceURI, localName: WideString): Pointer{TNode};
    function setNamedItemNS(arg: Pointer{TNode}): Pointer{TNode};
    function removeNamedItemNS(const namespaceURI, localName: WideString): Pointer{TNode};
  end;

  TSearchNodeList = class(TNodeList)
  public
    FNamespaceParam : WideString;
    FNameParam : WideString;
    FSynchronized: Boolean;
    function GetLength: Integer; override;
    function acceptNode(node: Pointer{TNode}): Boolean;
    procedure TraverseTree(rootNode: Pointer{TNode});
    procedure Rebuild;
  public
    constructor Create(AOwnerNode: Pointer{TNode}; const namespaceURI, name: WideString);
    destructor Destroy; override;
    procedure Invalidate; 
    function item(index: Integer): Pointer{TNode}; override;
  end;
             
  TNamespaceURIList = class
  public
    FList: TWStringList;
    function GetItem(I: Integer): WideString;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Add(const NamespaceURI: WideString): Integer;
    property Item[I: Integer]: WideString read GetItem; default;
  end;

implementation

uses
  html_utils,
  HTMLParserAll3,
  define_htmldom;
  
constructor TNodeList.Create(AOwnerNode: Pointer{TNode});
begin
  inherited Create;
  FOwnerNode := AOwnerNode;
  FList := TList.Create
end;

destructor TNodeList.Destroy;
begin
  FList.Free;
  inherited Destroy
end;

function TNodeList.NodeListIndexOf(node: Pointer{TNode}): Integer;
begin
  Result := FList.IndexOf(node)
end;

function TNodeList.GetLength: Integer;
begin
  Result := FList.Count
end;

procedure TNodeList.NodeListInsert(I: Integer; Node: Pointer{TNode});
begin
  FList.Insert(I, Node)
end;

procedure TNodeList.NodeListDelete(I: Integer);
begin
  FList.Delete(I)
end;

procedure TNodeList.NodeListAdd(node: Pointer{TNode});
begin
  FList.Add(node)
end;

procedure TNodeList.NodeListRemove(node: Pointer{TNode});
begin
  FList.Remove(node)
end;

function TNodeList.item(index: Integer): Pointer{TNode};
begin
  if (index >= 0) and (index < length) then
    Result := FList[index]
  else
    Result := nil
end;

procedure TNodeList.NodeListClear(WithItems: Boolean);
var
  I: Integer;
  tmpDomNode: PHtmlDomNode;
begin
  if WithItems then
  begin
    for I := length - 1 downto 0 do
    begin
      tmpDomNode := item(I);
      HtmlDomNodeFree(tmpDomNode);
    end;
  end;
  FList.Clear
end;

constructor TSearchNodeList.Create(AOwnerNode: Pointer{TNode}; const namespaceURI, name: WideString);
begin
  inherited Create(AOwnerNode);
  FNamespaceParam := namespaceURI;
  FNameParam := name;
  Rebuild
end;
                              
procedure HtmlDocRemoveSearchNodeList(ADocument: PHtmlDocDomNode; NodeList: TNodeList);
begin
  ADocument.SearchNodeLists.Remove(NodeList)
end;
                 
destructor TSearchNodeList.Destroy;
begin
  if (nil <> ownerNode) then
  begin
    if (nil <> PHtmlDomNode(ownerNode).ownerDocument) then
    begin
      HtmlDocRemoveSearchNodeList(PHtmlDomNode(ownerNode).ownerDocument, Self);
    end;
  end;
  inherited Destroy
end;
                           
function TSearchNodeList.GetLength: Integer;
begin
  if not FSynchronized then
    Rebuild;
  Result := inherited GetLength
end;
                            
function HtmlDomNodeGetNamespaceURI(AHtmlDomNode: PHtmlDomNode): WideString;
begin
  Result := AHtmlDomNode.ownerDocument.namespaceURIList[AHtmlDomNode.NamespaceURI]
end;
                               
function HtmlDomNodeGetLocalName(AHtmlDomNode: PHtmlDomNode): WideString;
begin
  Result := AHtmlDomNode.NodeName;
end;

function TSearchNodeList.acceptNode(node: Pointer{TNode}): Boolean;
begin
  Result := (PHtmlDomNode(Node).NodeType = HTMLDOM_NODE_ELEMENT) and
            ((FNamespaceParam = '*') or (FNamespaceParam = HtmlDomNodeGetNamespaceURI(node))) and
            ((FNameParam = '*') or (FNameParam = HtmlDomNodeGetLocalName(node)))
end;

procedure TSearchNodeList.TraverseTree(rootNode: Pointer{TNode});
var
  I: Integer;
begin
  if (rootNode <> ownerNode) and acceptNode(rootNode) then
    NodeListAdd(rootNode);
  for I := 0 to PhtmlDomNode(rootNode).childNodes.length - 1 do
    TraverseTree(PhtmlDomNode(rootNode).childNodes.item(I))
end;
                    
procedure HtmlDocAddSearchNodeList(ADocument: PHtmlDocDomNode; NodeList: TNodeList);
begin
  if ADocument.SearchNodeLists.IndexOf(NodeList) < 0 then
    ADocument.SearchNodeLists.Add(Nodelist)
end;

procedure TSearchNodeList.Rebuild;
begin
  NodeListClear(false);
  if (nil <> ownerNode) and (nil <> PHtmlDomNode(ownerNode).ownerDocument) then
  begin
    TraverseTree(ownerNode);
    HtmlDocAddSearchNodeList(PHtmlDomNode(ownerNode).ownerDocument, Self)
  end;
  Fsynchronized := true
end;
                           
procedure TSearchNodeList.Invalidate;
begin
  FSynchronized := false
end;

 function TSearchNodeList.item(index: Integer): Pointer{TNode};
begin
  if not FSynchronized then
    Rebuild;
  Result := inherited item(index)
end;

function TNamedNodeMap.getNamedItem(const name: WideString): Pointer{TNode};
var
  I: Integer;
begin
  for I := 0 to length - 1 do
  begin
    Result := item(I);
    if HtmlDomNodeGetName(Result) = name then
      Exit
  end;
  Result := nil
end;

function TNamedNodeMap.setNamedItem(arg: Pointer{TNode}): Pointer{TNode};
var
  Attr: PHtmlAttribDomNode;
  tmpOwnerElement: PHtmlElementDomNode;
begin
  if PHtmlDomNode(arg).ownerDocument <> PHtmlDomNode(ownerNode).ownerDocument then
    raise DomException(ERR_WRONG_DOCUMENT);
  if PHtmlDomNode(arg).NodeType = HTMLDOM_NODE_ATTRIBUTE then
  begin
    Attr := PHtmlAttribDomNode(arg);
    tmpOwnerElement := AttrGetOwnerElement(PHtmlAttribDomNode(Attr));
    if (nil <> tmpOwnerElement) and
      (tmpOwnerElement <> ownerNode) then
      raise DomException(ERR_INUSE_ATTRIBUTE)
  end;
  Result := getNamedItem(HtmlDomNodeGetName(arg));
  if (nil <> Result) then
    NodeListRemove(Result);
  NodeListAdd(arg)
end;

function TNamedNodeMap.removeNamedItem(const name: WideString): Pointer{TNode};
var
  Node: PHtmlDomNode;
begin
  Node := getNamedItem(name);
  if Node = nil then
    raise DomException.Create(ERR_NOT_FOUND);
  NodeListRemove(Node);
  Result := Node
end;

function TNamedNodeMap.getNamedItemNS(const namespaceURI, localName: WideString): Pointer{TNode};
var
  I: Integer;
begin
  for I := 0 to length - 1 do
  begin
    Result := item(I);
    if (HtmlDomNodeGetLocalName(Result) = localName) and
       (HtmlDomNodeGetNamespaceURI(Result) = namespaceURI) then
      Exit
  end;
  Result := nil
end;

function TNamedNodeMap.setNamedItemNS(arg: Pointer{TNode}): Pointer{TNode};
var
  Attr: PHtmlAttribDomNode;
  tmpOwnerElement: PHtmlElementDomNode;
begin
  if PHtmlDomNode(arg).ownerDocument <> PHtmlDomNode(ownerNode).ownerDocument then
    raise DomException(ERR_WRONG_DOCUMENT);
  if PHtmlDomNode(arg).NodeType = HTMLDOM_NODE_ATTRIBUTE then
  begin
    Attr := arg;
    tmpOwnerElement := AttrGetOwnerElement(PHtmlAttribDomNode(Attr));
    if (nil <> tmpOwnerElement) and
      (tmpOwnerElement <> ownerNode) then
      raise DomException(ERR_INUSE_ATTRIBUTE)
  end;
  Result := getNamedItemNS(HtmlDomNodeGetNamespaceURI(arg), HtmlDomNodeGetLocalName(arg));
  if (nil <> Result) then
    NodeListRemove(Result);
  NodeListAdd(arg)
end;

function TNamedNodeMap.removeNamedItemNS(const namespaceURI, localName: WideString): Pointer{TNode};
var
  Node: PHtmlDomNode;
begin
  Node := getNamedItemNS(namespaceURI, localName);
  if Node = nil then
    raise DomException.Create(ERR_NOT_FOUND);
  NodeListRemove(Node);
  Result := Node
end;

constructor TNamespaceURIList.Create;
begin
  inherited Create;
  FList := TWStringList.Create;
  FList.Add('')
end;

destructor TNamespaceURIList.Destroy;
begin
  FList.Free;
  inherited Destroy
end;
procedure TNamespaceURIList.Clear;
begin
  FList.Clear
end;

function TNamespaceURIList.GetItem(I: Integer): WideString;
begin
  Result := FList[I]
end;

function TNamespaceURIList.Add(const NamespaceURI: WideString): Integer;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    if FList[I] = NamespaceURI then
    begin
      Result := I;
      Exit
    end;
  Result := FList.Add(NamespaceURI)
end;
                   
end.
