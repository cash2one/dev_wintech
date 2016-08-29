unit define_htmldom;

interface

uses
  Classes,
  html_helperclass;
  
const
  HTMLDOM_NODE_NONE              = 0;  // extension
  HTMLDOM_NODE_ELEMENT           = 1;
  HTMLDOM_NODE_ATTRIBUTE         = 2;
  HTMLDOM_NODE_TEXT              = 3;
  HTMLDOM_NODE_CDATA_SECTION     = 4;
  HTMLDOM_NODE_ENTITY_REFERENCE  = 5;
  HTMLDOM_NODE_ENTITY            = 6;
  HTMLDOM_NODE_PROCESSING_INSTRUCTION = 7;
  HTMLDOM_NODE_COMMENT           = 8;
  HTMLDOM_NODE_DOCUMENT          = 9;
  HTMLDOM_NODE_DOCUMENT_TYPE     = 10;
  HTMLDOM_NODE_DOCUMENT_FRAGMENT = 11;
  HTMLDOM_NODE_NOTATION          = 12;

  HTMLDOM_NODE_END_ELEMENT       = 255; // extension

type
  PHtmlDomNode        = ^THtmlDomNode;   
  PHtmlDocDomNode     = ^THtmlDocDomNode; 
  PHtmlAttribDomNode  = ^THtmlDomNode;
  PHtmlTextDomNode    = ^THtmlDomNode;
  PHtmlDocTypeDomNode = ^THtmlDocTypeDomNode;
  PHtmlElementDomNode = ^THtmlElementDomNode;

  THtmlDomNode        = record
    NodeType          : Integer;
    OwnerDocument     : PHtmlDocDomNode;
    ParentDomNode     : PHtmlDomNode;
    NamespaceURI      : Integer;
    Attributes        : TNamedNodeMap;
    ChildNodes        : TNodeList;
    Prefix            : WideString;
    NodeName          : WideString;
    NodeValue         : WideString;
  end;

  THtmlDocDomNode     = record
    BaseDomNode       : THtmlDomNode;
    DocTypeDomNode    : PHtmlDocTypeDomNode;
    NamespaceURIList  : TNamespaceURIList;
    SearchNodeLists   : TList;
    AllOwnedNodes     : TList;
  end;

  THtmlElementDomNode = record
    BaseDomNode       : THtmlDomNode;
    IsEmpty           : Boolean;
  end;

  THtmlDocTypeDomNode = record
    BaseDomNode       : THtmlDomNode;
    //Entities        : DomNodeList.TNamedNodeMap;
    //Notations       : DomNodeList.TNamedNodeMap;
    PublicID          : WideString;
    SystemID          : WideString;
    InternalSubset    : WideString;
  end;
  
implementation

end.
