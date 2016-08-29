unit htmlparserform;

interface

uses
  Windows, Forms, StdCtrls, Classes, Controls,
  ExtCtrls, Sysutils,
  BaseForm, VirtualTrees, HTMLParserAll3;

type
  TfrmHtmlParser = class(TfrmBase)
    pnlRight: TPanel;
    pnlmain: TPanel;
    mmo1: TMemo;
    vthtmldomnode: TVirtualStringTree;
    pnl1: TPanel;
    btnParser: TButton;
    spl1: TSplitter;
    procedure btnParserClick(Sender: TObject);
    procedure vthtmldomnodeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
  protected
    fRootHtmlDomNode: PHtmlDocDomNode;    
    procedure AddHtmlDomTree(AParentNode: PVirtualNode; AHtmlDomNode: PHtmlDomNode);
  public             
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

type
  PHtmlDomPointerNode = ^THtmlDomPointerNode;
  THtmlDomPointerNode = record
    DomNode: PHtmlDomNode;
  end;

constructor TfrmHtmlParser.Create(AOwner: TComponent);
begin
  inherited;
  vthtmldomnode.NodeDataSize := SizeOf(THtmlDomPointerNode);
  vthtmldomnode.OnGetText := vthtmldomnodeGetText;
end;

procedure TfrmHtmlParser.btnParserClick(Sender: TObject);
begin
  fRootHtmlDomNode := HtmlParserParseString(mmo1.Lines.Text);
  vthtmldomnode.Clear;
  AddHtmlDomTree(nil, PHtmlDomNode(fRootHtmlDomNode));
end;

function getNodeTypeText(ANodeType: integer): string;
begin
  case ANodeType of
    HTMLDOM_NODE_NONE              : Result := 'none'; //= 0;  // extension
    HTMLDOM_NODE_ELEMENT           : Result := 'element'; //= 1;
    HTMLDOM_NODE_ATTRIBUTE         : Result := 'attrib'; //= 2;
    HTMLDOM_NODE_TEXT              : Result := 'text'; //= 3;
    HTMLDOM_NODE_CDATA_SECTION     : Result := 'cdata'; //= 4;
    HTMLDOM_NODE_ENTITY_REFERENCE  : Result := 'entityref'; //= 5;
    HTMLDOM_NODE_ENTITY            : Result := 'entity'; //= 6;
    HTMLDOM_NODE_PROCESSING_INSTRUCTION : Result := 'process'; //= 7;
    HTMLDOM_NODE_COMMENT           : Result := 'comment'; //= 8;
    HTMLDOM_NODE_DOCUMENT          : Result := 'doc'; //= 9;
    HTMLDOM_NODE_DOCUMENT_TYPE     : Result := 'doctype'; //= 10;
    HTMLDOM_NODE_DOCUMENT_FRAGMENT : Result := 'docfrag'; //= 11;
    HTMLDOM_NODE_NOTATION          : Result := 'notation'; //= 12;
    HTMLDOM_NODE_END_ELEMENT       : Result := 'elementend'; //= 255; // extension
    else
      Result := 'unknown' + IntToStr(ANodeType);
  end;
end;

procedure TfrmHtmlParser.vthtmldomnodeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var  
  tmpVNodeData: PHtmlDomPointerNode;
begin
  CellText := '';    
  tmpVNodeData := vthtmldomnode.GetNodeData(Node);
  if nil <> tmpVNodeData then
  begin
    if nil <> tmpVNodeData.DomNode then
    begin
      if '' <> tmpVNodeData.DomNode.Prefix then
      begin
        CellText := tmpVNodeData.DomNode.Prefix + ':';
      end; 
      if HTMLDOM_NODE_TEXT = tmpVNodeData.DomNode.NodeType then
      begin
        CellText := getNodeTypeText(tmpVNodeData.DomNode.NodeType) + ':' +
          tmpVNodeData.DomNode.NodeName + '/' + tmpVNodeData.DomNode.NodeValue;
      end else
      begin
        CellText := getNodeTypeText(tmpVNodeData.DomNode.NodeType) + ':' +
          tmpVNodeData.DomNode.NodeName + '/' + tmpVNodeData.DomNode.NodeValue;
      end;
    end;
  end;
end;

procedure TfrmHtmlParser.AddHtmlDomTree(AParentNode: PVirtualNode; AHtmlDomNode: PHtmlDomNode);
var
  tmpVNode: PVirtualNode;
  tmpVNodeData: PHtmlDomPointerNode;
  i: integer;
begin
  if nil = AHtmlDomNode then
    exit;
  tmpVNode := vthtmldomnode.AddChild(AParentNode);
  tmpVNodeData := vthtmldomnode.GetNodeData(tmpVNode);
  tmpVNodeData.DomNode := AHtmlDomNode;    
  if HTMLDOM_NODE_DOCUMENT  = AHtmlDomNode.NodeType then
  begin
    if nil <> PHtmlDocDomNode(AHtmlDomNode).DocTypeDomNode then
    begin
      AddHtmlDomTree(tmpVNode, PHtmlDomNode(PHtmlDocDomNode(AHtmlDomNode).DocTypeDomNode));
    end;
  end;
  if nil <> AHtmlDomNode.ChildNodes then
  begin
    for i := 0 to AHtmlDomNode.ChildNodes.FList.Count - 1 do
    begin
      AddHtmlDomTree(tmpVNode, AHtmlDomNode.ChildNodes.FList.Items[i]);
    end;
  end;
  if nil <> AHtmlDomNode.Attributes then
  begin
    for i := 0 to AHtmlDomNode.Attributes.length - 1 do
    begin
      AddHtmlDomTree(tmpVNode, AHtmlDomNode.Attributes.item(i));
    end;
  end;
end;

end.
