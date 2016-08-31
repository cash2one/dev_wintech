unit HTMLParserAll3;

interface

uses
  Classes, Sysutils, WStrings,
  define_htmldom, define_htmlparser,
  html_helperclass, html_helper_tag;
                    
//=======================================================
// 
//=======================================================

  function HtmlParserParseString(const htmlStr: WideString): PHtmlDocDomNode; overload;
  function HtmlParserParseString(AHtmlParser: PHtmlParser; const htmlStr: WideString): PHtmlDocDomNode; overload;
  function CheckOutHtmlParser: PHtmlParser;
  procedure CheckInHtmlParser(var AHtmlParser: PHtmlParser);
                          
  procedure HtmlDomNodeFree(var ADomNode: PHtmlDomNode); 
  function HtmlDomNodeGetName(AHtmlDomNode: PHtmlDomNode): WideString;


implementation

uses
  html_entity,
  define_htmltag,
  html_utils;
         
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
        Result[Pos] := GetEntValue(HtmlDomNodeGetName(Node))
      end
    end
  end else
  begin
    Result := AHtmlDomNode.NodeValue;
  end;
end;
            
function HtmlParserGetMainElement(AHtmlParser: PHtmlParser; const tagName: WideString): PHtmlElementDomNode;
var
  child: PHtmlDomNode;
  I: Integer;
  tmpElement: PHtmlElementDomNode;
begin
  tmpElement := HtmlDocGetDocumentElement(AHtmlParser.HtmlDocument);
  if tmpElement = nil then
  begin
    tmpElement := CheckOutElementDomNode(AHtmlParser.HtmlDocument, '', htmlTagName, false);
    HtmlDomNodeappendChild(PHtmlDomNode(AHtmlParser.HtmlDocument), PHtmlDomNode(tmpElement));
    tmpElement := HtmlDocGetDocumentElement(AHtmlParser.HtmlDocument);
  end;

  for I := 0 to tmpElement.BaseDomNode.childNodes.length - 1 do
  begin
    child := tmpElement.BaseDomNode.childNodes.item(I);
    if (child.NodeType = HTMLDOM_NODE_ELEMENT) and (HtmlDomNodeGetName(child) = tagName) then
    begin
      Result := PHtmlElementDomNode(child);
      Exit
    end
  end;
  Result := CheckOutElementDomNode(AHtmlParser.HtmlDocument, '', tagName, false);
  HtmlDomNodeappendChild(PHtmlDomNode(tmpElement), PHtmlDomNode(Result));
end;

function HtmlParserFindParentElement(AHtmlParser: PHtmlParser; tagList: THtmlTagSet): PHtmlElementDomNode;
var
  Node: PHtmlDomNode;      
  HtmlTag: PHtmlTag;
begin
  Node := AHtmlParser.CurrentNode;
  while Node.NodeType = HTMLDOM_NODE_ELEMENT do
  begin
    HtmlTag := HtmlTagList.GetTagByName(HtmlDomNodeGetName(Node));
    if HtmlTag.Number in tagList then
    begin
      Result := PHtmlElementDomNode(Node);
      Exit
    end;
    Node := NodeGetParentDomNode(Node);
    if nil = node then Break;
  end;
  Result := nil
end;
               
function HtmlParserFindDefParent(AHtmlParser: PHtmlParser): PHtmlElementDomNode;
var
  tmpElement: PHtmlElementDomNode;
begin
  if AHtmlParser.CurrentTag.Number in [HEAD_TAG, BODY_TAG] then
  begin
    tmpElement := CheckOutElementDomNode(AHtmlParser.HtmlDocument, '', htmlTagName, false);
    Result := PHtmlElementDomNode(HtmlDomNodeappendChild(PHtmlDomNode(AHtmlParser.HtmlDocument), PHtmlDomNode(tmpElement)));
  end else
  if AHtmlParser.CurrentTag.Number in HeadTags then
  begin
    Result := HtmlParserGetMainElement(AHtmlParser, headTagName)
  end else
  begin
    Result := HtmlParserGetMainElement(AHtmlParser, bodyTagName)
  end;
end;

function HtmlParserFindTableParent(AHtmlParser: PHtmlParser): PHtmlElementDomNode;
var
  Node: PHtmlDomNode;
  HtmlTag: PHtmlTag;
begin
  Node := AHtmlParser.CurrentNode;
  while Node.NodeType = HTMLDOM_NODE_ELEMENT do
  begin
    HtmlTag := HtmlTagList.GetTagByName(HtmlDomNodeGetName(Node));
    if (HtmlTag.Number = TD_TAG) or (HtmlTag.Number in BlockTags) then
    begin
      Result := PHtmlElementDomNode(Node);
      Exit
    end;
    Node := NodeGetParentDomNode(Node);
    if nil = node then Break;
  end;
  Result := HtmlParserGetMainElement(AHtmlParser, bodyTagName)
end;

function HtmlParserFindParent(AHtmlParser: PHtmlParser): PHtmlElementDomNode;
begin
  if (AHtmlParser.CurrentTag.Number = P_TAG) or (AHtmlParser.CurrentTag.Number in BlockTags) then
    Result := HtmlParserFindParentElement(AHtmlParser, BlockParentTags)
  else
  if AHtmlParser.CurrentTag.Number = LI_TAG then
    Result := HtmlParserFindParentElement(AHtmlParser, ListItemParentTags)
  else
  if AHtmlParser.CurrentTag.Number in [DD_TAG, DT_TAG] then
    Result := HtmlParserFindParentElement(AHtmlParser, DefItemParentTags)
  else
  if AHtmlParser.CurrentTag.Number in [TD_TAG, TH_TAG] then
    Result := HtmlParserFindParentElement(AHtmlParser, CellParentTags)
  else
  if AHtmlParser.CurrentTag.Number = TR_TAG then
    Result := HtmlParserFindParentElement(AHtmlParser, RowParentTags)
  else
  if AHtmlParser.CurrentTag.Number = COL_TAG then
    Result := HtmlParserFindParentElement(AHtmlParser, ColParentTags)
  else
  if AHtmlParser.CurrentTag.Number in [COLGROUP_TAG, THEAD_TAG, TFOOT_TAG, TBODY_TAG] then
    Result := HtmlParserFindParentElement(AHtmlParser, TableSectionParentTags)
  else
  if AHtmlParser.CurrentTag.Number = TABLE_TAG then
    Result := HtmlParserFindTableParent(AHtmlParser)
  else
  if AHtmlParser.CurrentTag.Number = OPTION_TAG then
    Result := HtmlParserFindParentElement(AHtmlParser, OptionParentTags)
  else
  if AHtmlParser.CurrentTag.Number in [HEAD_TAG, BODY_TAG] then
  begin
    Result := PHtmlElementDomNode(HtmlDocGetDocumentElement(AHtmlParser.HtmlDocument));
  end else
  begin
    Result := nil;
  end;
  if Result = nil then
    Result := HtmlParserFindDefParent(AHtmlParser)
end;
                           
function HtmlReaderGetNodeName(AHtmlReader: PHtmlReader): WideString;
begin
  if AHtmlReader.Prefix <> '' then
    Result := AHtmlReader.Prefix + ':' + AHtmlReader.LocalName
  else
    Result := AHtmlReader.LocalName
end;

function HtmlParserFindThisElement(AHtmlParser: PHtmlParser): PHtmlElementDomNode;
var
  Node: PHtmlDomNode;
begin
  Node := AHtmlParser.CurrentNode;
  while Node.NodeType = HTMLDOM_NODE_ELEMENT do
  begin
    Result := PHtmlElementDomNode(Node);
    if HtmlDomNodeGetName(PHtmlDomNode(Result)) = HtmlReaderGetNodeName(AHtmlParser.HtmlReader) then
      Exit;
    Node := NodeGetParentDomNode(Node);
    if nil = node then Break;
  end;
  Result := nil
end;
                
function ElementsetAttributeNode(AElement: PHtmlElementDomNode; newAttr: PHtmlAttribDomNode): PHtmlAttribDomNode;
begin
  if (nil <> AttrGetOwnerElement(PHtmlAttribDomNode(newAttr))) then
    raise DomException.Create(ERR_INUSE_ATTRIBUTE);
  Result := PHtmlAttribDomNode(AElement.BaseDomNode.attributes.setNamedItem(newAttr));
  if (nil <> Result) then
    Result.ParentDomNode := nil;
  newAttr.ParentDomNode := PHtmlDomNode(AElement);
end;

procedure HtmlParserProcessAttributeStart(AHtmlReader: PHtmlReader);
var
  Attr: PHtmlDomNode;
begin
  Attr := CheckOutHtmlDomNode(HTMLDOM_NODE_ATTRIBUTE, AHtmlReader.HtmlParser.HtmlDocument, '', HtmlReaderGetNodeName(AHtmlReader), false);
  ElementsetAttributeNode(PHtmlElementDomNode(AHtmlReader.HtmlParser.CurrentNode), PHtmlAttribDomNode(Attr));
  AHtmlReader.HtmlParser.CurrentNode := Attr;
end;

procedure HtmlParserProcessAttributeEnd(AHtmlReader: PHtmlReader);
begin
  AHtmlReader.HtmlParser.CurrentNode := PHtmlDomNode(AttrGetOwnerElement(PHtmlAttribDomNode(AHtmlReader.HtmlParser.CurrentNode)));
end;

procedure HtmlParserProcessCDataSection(AHtmlReader: PHtmlReader);
var
  CDataSection: PHtmlDomNode;
begin
  CDataSection := CheckOutTextDomNode(HTMLDOM_NODE_CDATA_SECTION, 
      AHtmlReader.HtmlParser.HtmlDocument,
      AHtmlReader.HtmlParser.HtmlReader.nodeValue);
  HtmlDomNodeappendChild(AHtmlReader.HtmlParser.CurrentNode, CDataSection);
end;

procedure HtmlParserProcessComment(AHtmlReader: PHtmlReader);
var
  Comment: PHtmlDomNode;
begin
  Comment := CheckOutTextDomNode(HTMLDOM_NODE_COMMENT,
      AHtmlReader.HtmlParser.HtmlDocument,
      AHtmlReader.HtmlParser.HtmlReader.nodeValue);
  HtmlDomNodeappendChild(AHtmlReader.HtmlParser.CurrentNode, Comment);
end;
                 
procedure HtmlDocSetDocType(ADocument: PHtmlDocDomNode; value: PHtmlDocTypeDomNode{TDocumentTypeObj});
begin
  if (nil <> ADocument.DocTypeDomNode) then
  begin
    HtmlDomNodeFree(PHtmlDomNode(ADocument.DocTypeDomNode));
  end;
  ADocument.DocTypeDomNode := value;
end;
                
procedure HtmlParserProcessDocType(AHtmlReader: PHtmlReader);
var
  tmpDocType: PHtmlDocTypeDomNode;
begin
  //with fHtmlParserData.HtmlReader do
  tmpDocType := createDocumentType(
        HtmlReaderGetNodeName(AHtmlReader.HtmlParser.HtmlReader),
        AHtmlReader.HtmlParser.HtmlReader.publicID,
        AHtmlReader.HtmlParser.HtmlReader.systemID);
    HtmlDocSetdocType(AHtmlReader.HtmlParser.HtmlDocument, tmpDocType);
end;

procedure HtmlParserProcessElementEnd(AHtmlReader: PHtmlReader);
begin
  if AHtmlReader.HtmlParser.HtmlReader.isEmptyElement or (AHtmlReader.HtmlParser.CurrentTag.Number in EmptyTags) then
    AHtmlReader.HtmlParser.CurrentNode := NodeGetParentDomNode(AHtmlReader.HtmlParser.CurrentNode);
  AHtmlReader.HtmlParser.CurrentTag := nil
end;

procedure HtmlParserProcessElementStart(AHtmlReader: PHtmlReader);
var
  Element: PHtmlElementDomNode;
  Parent: PHtmlDomNode;
begin
  AHtmlReader.HtmlParser.CurrentTag := HtmlTagList.GetTagByName(HtmlReaderGetNodeName(AHtmlReader.HtmlParser.HtmlReader));
  if AHtmlReader.HtmlParser.CurrentTag.Number in NeedFindParentTags + BlockTags then
  begin
    Parent := PHtmlDomNode(HtmlParserFindParent(AHtmlReader.HtmlParser));
    if (nil = Parent) then
      raise DomException.Create(ERR_HIERARCHY_REQUEST);
    AHtmlReader.HtmlParser.CurrentNode := Parent;
  end;
  Element := CheckOutElementDomNode(AHtmlReader.HtmlParser.HtmlDocument, '', HtmlReaderGetNodeName(AHtmlReader.HtmlParser.HtmlReader), false);
  HtmlDomNodeappendChild(AHtmlReader.HtmlParser.CurrentNode, PHtmlDomNode(Element));
  AHtmlReader.HtmlParser.CurrentNode := PHtmlDomNode(Element);
end;

procedure HtmlParserProcessEndElement(AHtmlReader: PHtmlReader);
var
  Element: PHtmlElementDomNode;
begin
  Element := HtmlParserFindThisElement(AHtmlReader.HtmlParser);
  if (nil <> Element) then
    AHtmlReader.HtmlParser.CurrentNode := NodeGetParentDomNode(PHtmlDomNode(Element));
{  else
  if IsBlockTagName(FHtmlReader.nodeName) then
    raise DomException.Create(HIERARCHY_REQUEST_ERR)}
end;

procedure HtmlParserProcessEntityReference(AHtmlReader: PHtmlReader);
var
  EntityReference: PHtmlDomNode;
begin                          
  EntityReference := CheckOutEntityReferenceNode(
      AHtmlReader.HtmlParser.HtmlDocument,
      HtmlReaderGetNodeName(AHtmlReader));
  HtmlDomNodeappendChild(AHtmlReader.HtmlParser.CurrentNode, EntityReference);
end;

procedure HtmlParserProcessTextNode(AHtmlReader: PHtmlReader);
begin
  HtmlDomNodeappendChild(AHtmlReader.HtmlParser.CurrentNode,
      CheckOutTextDomNode(HTMLDOM_NODE_TEXT, AHtmlReader.HtmlParser.HtmlDocument, AHtmlReader.nodeValue));
end;

function HtmlParserparseString(const htmlStr: WideString): PHtmlDocDomNode; overload;
var
  tmpHtmlParser: PHtmlParser;
begin
  tmpHtmlParser := CheckoutHtmlParser;
  try
    Result := HtmlParserparseString(tmpHtmlParser, htmlStr);
  finally
    CheckInHtmlParser(tmpHtmlParser);
  end;
end;
             
procedure HtmlReaderSetHtmlStr(AHtmlReader: PHtmlReader; const Value: WideString);
begin
  AHtmlReader.HtmlStr := Value;
  AHtmlReader.Position := 1
end;
                   
function DecValue(const Digit: WideChar): Word;
begin
  Result := Ord(Digit) - Ord('0')
end;

function HexValue(const HexChar: WideChar): Word;
var
  C: Char;
begin
  if Ord(HexChar) in decDigit then
    Result := Ord(HexChar) - Ord('0')
  else
  begin
    C := UpCase(Chr(Ord(HexChar)));
    Result := Ord(C) - Ord('A')
  end
end;
                      
function CheckOutHtmlReader: PHtmlReader;
begin
  Result := System.New(PHtmlReader);
  FillChar(Result^, SizeOf(THtmlReader), 0);
  //fHtmlReaderData.HtmlStr := fHtmlReaderData.HtmlStr;
  Result.Position := 1
end;

function HtmlReaderGetToken(AHtmlReader: PHtmlReader; Delimiters: TDelimiters): WideString;
var
  Start: Integer;
begin
  Start := AHtmlReader.Position;
  while (AHtmlReader.Position <= Length(AHtmlReader.HtmlStr)) and not (Ord(AHtmlReader.HtmlStr[AHtmlReader.Position]) in Delimiters) do
    Inc(AHtmlReader.Position);
  Result := Copy(AHtmlReader.HtmlStr, Start, AHtmlReader.Position - Start)
end;

function HtmlReaderIsAttrTextChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  if AHtmlReader.State = rsInQuotedValue then
    Result := (Ord(WC) <> AHtmlReader.Quotation) and (Ord(WC) <> startEntity)
  else
    Result := not (Ord(WC) in notAttrText)
end;

function HtmlReaderIsDigit(AHtmlReader: PHtmlReader; HexBase: Boolean): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) in decDigit;
  if not Result and HexBase then
    Result := Ord(WC) in hexDigit
end;

function HtmlReaderIsEndEntityChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) = endEntity
end;

function HtmlReaderIsEntityChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := not (Ord(WC) in notEntity)
end;

function HtmlReaderIsEqualChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) = equalChar
end;

function HtmlReaderIsHexEntityChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) in hexEntity
end;

function HtmlReaderIsNumericEntity(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) = numericEntity
end;

function HtmlReaderIsQuotation(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  if AHtmlReader.Quotation = 0 then
    Result := Ord(WC) in quotation
  else
    Result := Ord(WC) = AHtmlReader.Quotation
end;

function HtmlReaderIsSlashChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) = slashChar
end;

function HtmlReaderIsSpecialTagChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) = specialTagChar
end;

function HtmlReaderIsStartEntityChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) = startEntity
end;

function HtmlReaderIsStartMarkupChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) in startMarkup
end;

function HtmlReaderIsStartTagChar(AHtmlReader: PHtmlReader): Boolean;
var
  WC: WideChar;
begin
  WC := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Result := Ord(WC) = startTagChar
end;

function HtmlReaderMatch(AHtmlReader: PHtmlReader; const Signature: WideString; IgnoreCase: Boolean): Boolean;
var
  I, J: Integer;
  W1, W2: WideChar;
begin
  Result := false;
  for I := 1 to Length(Signature) do
  begin
    J := AHtmlReader.Position + I - 1;
    if (J < 1) or (J > Length(AHtmlReader.HtmlStr)) then
      Exit;
    W1 := Signature[I];
    W2 := AHtmlReader.HtmlStr[J];
    if (W1 <> W2) and (not IgnoreCase or (UpperCase(W1) <> UpperCase(W2))) then
      Exit
  end;
  Result := true
end;

procedure HtmlReaderSkipWhiteSpaces(AHtmlReader: PHtmlReader);
begin
  while (AHtmlReader.Position <= Length(AHtmlReader.HtmlStr)) and (Ord(AHtmlReader.HtmlStr[AHtmlReader.Position]) in whiteSpace) do
    Inc(AHtmlReader.Position)
end;

procedure HtmlReaderSetNodeName(AHtmlReader: PHtmlReader; Value: WideString);
var
  I: Integer;
begin
  I := Pos(':', Value);
  if I > 0 then
  begin
    AHtmlReader.Prefix := Copy(Value, 1, I - 1);
    AHtmlReader.LocalName := Copy(Value, I + 1, Length(Value) - I)
  end
  else
  begin
    AHtmlReader.Prefix := '';
    AHtmlReader.LocalName := Value
  end
end;
                   
procedure HtmlReaderFireEvent(AHtmlReader: PHtmlReader; Event: THtmlReaderEvent);
begin
  if Assigned(Event) then
    Event(AHtmlReader)
end;

function HtmlReaderReadAttrNode(AHtmlReader: PHtmlReader): Boolean;
var
  AttrName: WideString;
begin
  Result := false;
  HtmlReaderSkipWhiteSpaces(AHtmlReader);
  AttrName := LowerCase(HtmlReaderGetToken(AHtmlReader, attrNameDelimiter));
  if AttrName = '' then
    Exit;
  HtmlReaderSetNodeName(AHtmlReader, AttrName);
  HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnAttributeStart);
  AHtmlReader.State := rsBeforeValue;
  AHtmlReader.Quotation := 0;
  Result := true
end;

function HtmlReaderReadAttrTextNode(AHtmlReader: PHtmlReader): Boolean;
var
  Start: Integer;
begin
  Result := false;
  Start := AHtmlReader.Position;
  while (AHtmlReader.Position <= Length(AHtmlReader.HtmlStr)) and HtmlReaderIsAttrTextChar(AHtmlReader) do
    Inc(AHtmlReader.Position);
  if AHtmlReader.Position = Start then
    Exit;
  AHtmlReader.NodeType := HTMLDOM_NODE_TEXT;
  AHtmlReader.NodeValue:= Copy(AHtmlReader.HtmlStr, Start, AHtmlReader.Position - Start);
  HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnTextNode);
  Result := true
end;
                           
function HtmlReaderSkipTo(AHtmlReader: PHtmlReader; const Signature: WideString): Boolean;
begin
  while AHtmlReader.Position <= Length(AHtmlReader.HtmlStr) do
  begin
    if HtmlReaderMatch(AHtmlReader, Signature, false) then
    begin
      Inc(AHtmlReader.Position, Length(Signature));
      Result := true;
      Exit
    end;
    Inc(AHtmlReader.Position)
  end;
  Result := false
end;

function HtmlReaderReadCharacterData(AHtmlReader: PHtmlReader): Boolean;
var
  StartPos: Integer;
begin
  Inc(AHtmlReader.Position, Length(CDataStartStr));
  StartPos := AHtmlReader.Position;
  Result := HtmlReaderSkipTo(AHtmlReader, CDataEndStr);
  if Result then
  begin
    AHtmlReader.NodeType := HTMLDOM_NODE_CDATA_SECTION;
    AHtmlReader.NodeValue := Copy(AHtmlReader.HtmlStr, StartPos, AHtmlReader.Position - StartPos - Length(CDataEndStr));
    HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnCDataSection)
  end
end;

function HtmlReaderReadComment(AHtmlReader: PHtmlReader): Boolean;
var
  StartPos: Integer;
begin
  Inc(AHtmlReader.Position, Length(CommentStartStr));
  StartPos := AHtmlReader.Position;
  Result := HtmlReaderSkipTo(AHtmlReader, CommentEndStr);
  if Result then
  begin
    AHtmlReader.NodeType := HTMLDOM_NODE_COMMENT;
    AHtmlReader.NodeValue := Copy(AHtmlReader.HtmlStr, StartPos, AHtmlReader.Position - StartPos - Length(CommentEndStr));
    HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnComment)
  end
end;
                        
function HtmlReaderReadQuotedValue(AHtmlReader: PHtmlReader; var Value: WideString): Boolean;
var
  QuotedChar: WideChar;
  Start: Integer;
begin
  QuotedChar := AHtmlReader.HtmlStr[AHtmlReader.Position];
  Inc(AHtmlReader.Position);
  Start := AHtmlReader.Position;
  Result := HtmlReaderSkipTo(AHtmlReader, QuotedChar);
  if Result then
    Value := Copy(AHtmlReader.HtmlStr, Start, AHtmlReader.Position - Start)
end;

function HtmlReaderReadDocumentType(AHtmlReader: PHtmlReader): Boolean;
var
  Name: WideString;
begin
  Result := false;
  Inc(AHtmlReader.Position, Length(DocTypeStartStr));
  HtmlReaderSkipWhiteSpaces(AHtmlReader);
  Name := HtmlReaderGetToken(AHtmlReader, tagNameDelimiter);
  if Name = '' then
    Exit;
  HtmlReaderSetNodeName(AHtmlReader, Name);
  HtmlReaderSkipWhiteSpaces(AHtmlReader);
  HtmlReaderGetToken(AHtmlReader, tagNameDelimiter);
  HtmlReaderSkipWhiteSpaces(AHtmlReader);
  if not HtmlReaderReadQuotedValue(AHtmlReader, AHtmlReader.PublicID) then
    Exit;
  HtmlReaderSkipWhiteSpaces(AHtmlReader);
  if AHtmlReader.HtmlStr[AHtmlReader.Position] = '"' then
  begin
    if not HtmlReaderReadQuotedValue(AHtmlReader, AHtmlReader.SystemID) then
      Exit
  end;
  Result := HtmlReaderSkipTo(AHtmlReader, DocTypeEndStr)
end;

function HtmlReaderReadElementNode(AHtmlReader: PHtmlReader): Boolean;
var
  TagName: WideString;
begin
  Result := false;
  if AHtmlReader.Position < Length(AHtmlReader.HtmlStr) then
  begin
    TagName := LowerCase(HtmlReaderGetToken(AHtmlReader, tagNameDelimiter));
    if TagName = '' then
      Exit;
    AHtmlReader.NodeType := HTMLDOM_NODE_ELEMENT;
    HtmlReaderSetNodeName(AHtmlReader, TagName);
    AHtmlReader.State := rsBeforeAttr;
    HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnElementStart);
    Result := true
  end
end;

function HtmlReaderReadEndElementNode(AHtmlReader: PHtmlReader): Boolean;
var
  TagName: WideString;
begin
  Result := false;
  Inc(AHtmlReader.Position);
  if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
    Exit;
  TagName := LowerCase(HtmlReaderGetToken(AHtmlReader, tagNameDelimiter));
  if TagName = '' then
    Exit;
  Result := HtmlReaderSkipTo(AHtmlReader, WideChar(endTagChar));
  if Result then
  begin
    AHtmlReader.NodeType := HTMLDOM_NODE_END_ELEMENT;
    HtmlReaderSetNodeName(AHtmlReader, TagName);
    HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnEndElement);
    Result := true
  end
end;

function HtmlReaderReadNumericEntityNode(AHtmlReader: PHtmlReader): Boolean;
var
  Value: Word;
  HexBase: Boolean;
begin
  Result := false;
  if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
    Exit;
  HexBase := HtmlReaderIsHexEntityChar(AHtmlReader);
  if HexBase then
    Inc(AHtmlReader.Position);
  Value := 0;
  while (AHtmlReader.Position <= Length(AHtmlReader.HtmlStr)) and HtmlReaderIsDigit(AHtmlReader, HexBase) do
  begin
    try
      if HexBase then
        Value := Value * 16 + HexValue(AHtmlReader.HtmlStr[AHtmlReader.Position])
      else
        Value := Value * 10 + DecValue(AHtmlReader.HtmlStr[AHtmlReader.Position])
    except
      Exit
    end;
    Inc(AHtmlReader.Position)
  end;
  if (AHtmlReader.Position > Length(AHtmlReader.HtmlStr)) or not HtmlReaderIsEndEntityChar(AHtmlReader) then
    Exit;
  Inc(AHtmlReader.Position);
  AHtmlReader.NodeType := HTMLDOM_NODE_TEXT;
  AHtmlReader.NodeValue := WideChar(Value);
  HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnTextNode);
  Result := true
end;

function HtmlReaderReadNamedEntityNode(AHtmlReader: PHtmlReader): Boolean;
var
  Start: Integer;
begin    
  Result := false;
  if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
    Exit;
  Start := AHtmlReader.Position;
  while (AHtmlReader.Position <= Length(AHtmlReader.HtmlStr)) and HtmlReaderIsEntityChar(AHtmlReader) do
    Inc(AHtmlReader.Position);
  if (AHtmlReader.Position > Length(AHtmlReader.HtmlStr)) or not HtmlReaderIsEndEntityChar(AHtmlReader) then
    Exit;
  AHtmlReader.NodeType := HTMLDOM_NODE_ENTITY_REFERENCE;
  HtmlReaderSetNodeName(AHtmlReader, Copy(AHtmlReader.HtmlStr, Start, AHtmlReader.Position - Start));
  Inc(AHtmlReader.Position);
  HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnEntityReference);
  Result := true
end;

function HtmlReaderReadEntityNode(AHtmlReader: PHtmlReader): Boolean;
var
  CurrPos: Integer;
begin
  Result := false;
  CurrPos := AHtmlReader.Position;
  Inc(AHtmlReader.Position);
  if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
    Exit;
  if HtmlReaderIsNumericEntity(AHtmlReader) then
  begin
    Inc(AHtmlReader.Position);
    Result := HtmlReaderReadNumericEntityNode(AHtmlReader)
  end
  else
    Result := HtmlReaderReadNamedEntityNode(AHtmlReader);
  if Result then
  begin
    AHtmlReader.NodeType := HTMLDOM_NODE_ENTITY_REFERENCE;
    //FireEvent(FOnEntityReference);  VVV - remove, entity node is added in ReadXXXEntityNode
  end
  else
    AHtmlReader.Position := CurrPos
end;

function HtmlReaderIsStartCharacterData(AHtmlReader: PHtmlReader): Boolean;
begin    
  Result := HtmlReaderMatch(AHtmlReader, CDataStartStr, false)
end;

function HtmlReaderIsStartComment(AHtmlReader: PHtmlReader): Boolean;
begin
  Result := HtmlReaderMatch(AHtmlReader, CommentStartStr, false)
end;

function HtmlReaderIsStartDocumentType(AHtmlReader: PHtmlReader): Boolean;
begin
  Result := HtmlReaderMatch(AHtmlReader, DocTypeStartStr, true)
end;

function HtmlReaderReadSpecialNode(AHtmlReader: PHtmlReader): Boolean;
begin
  Result := false;
  Inc(AHtmlReader.Position);
  if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
    Exit;
  if HtmlReaderIsStartDocumentType(AHtmlReader) then
    Result := HtmlReaderReadDocumentType(AHtmlReader)
  else
  if HtmlReaderIsStartCharacterData(AHtmlReader) then
    Result := HtmlReaderReadCharacterData(AHtmlReader)
  else
  if HtmlReaderIsStartComment(AHtmlReader) then
    Result := HtmlReaderReadComment(AHtmlReader)
end;

function HtmlReaderReadTagNode(AHtmlReader: PHtmlReader): Boolean;
var
  CurrPos: Integer;
begin
  Result := false;
  CurrPos := AHtmlReader.Position;
  Inc(AHtmlReader.Position);
  if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
    Exit;
  if HtmlReaderIsSlashChar(AHtmlReader) then
    Result := HtmlReaderReadEndElementNode(AHtmlReader)
  else
  if HtmlReaderIsSpecialTagChar(AHtmlReader) then
    Result := HtmlReaderReadSpecialNode(AHtmlReader)
  else
    Result := HtmlReaderReadElementNode(AHtmlReader);
  if not Result then
    AHtmlReader.Position := CurrPos
end;

function HtmlReaderReadValueNode(AHtmlReader: PHtmlReader): Boolean;
begin
  Result := false;
  if AHtmlReader.State = rsBeforeValue then
  begin
    HtmlReaderSkipWhiteSpaces(AHtmlReader);
    if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
      Exit;
    if not HtmlReaderIsEqualChar(AHtmlReader) then
      Exit;
    Inc(AHtmlReader.Position);
    HtmlReaderSkipWhiteSpaces(AHtmlReader);
    if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
       Exit;
    if HtmlReaderIsQuotation(AHtmlReader) then
    begin
      AHtmlReader.Quotation := Ord(AHtmlReader.HtmlStr[AHtmlReader.Position]);
      Inc(AHtmlReader.Position);
      AHtmlReader.State := rsInQuotedValue
    end
    else
      AHtmlReader.State := rsInValue
  end;
  if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
    Exit;
  if HtmlReaderIsStartEntityChar(AHtmlReader) then
  begin
    Result := true;
    if HtmlReaderReadEntityNode(AHtmlReader) then
      Exit;
    Inc(AHtmlReader.Position);
    AHtmlReader.NodeType := HTMLDOM_NODE_ENTITY_REFERENCE;
    HtmlReaderSetNodeName(AHtmlReader, 'amp');
    HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnEntityReference)
  end
  else
    Result := HtmlReaderReadAttrTextNode(AHtmlReader)
end;
                  
procedure HtmlReaderReadElementTail(AHtmlReader: PHtmlReader);
begin
  HtmlReaderSkipWhiteSpaces(AHtmlReader);
  if (AHtmlReader.Position <= Length(AHtmlReader.HtmlStr)) and HtmlReaderIsSlashChar(AHtmlReader) then
  begin
    AHtmlReader.IsEmptyElement := true;
    Inc(AHtmlReader.Position)
  end;
  HtmlReaderSkipTo(AHtmlReader, WideChar(endTagChar));
    AHtmlReader.NodeType := HTMLDOM_NODE_ELEMENT;
  HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnElementEnd)
end;
                
procedure HtmlReaderReadTextNode(AHtmlReader: PHtmlReader);
var
  Start: Integer;
begin
  Start := AHtmlReader.Position;
  repeat
    Inc(AHtmlReader.Position)
  until (AHtmlReader.Position > Length(AHtmlReader.HtmlStr)) or HtmlReaderIsStartMarkupChar(AHtmlReader);
  AHtmlReader.NodeType := HTMLDOM_NODE_TEXT;
  AHtmlReader.NodeValue:= Copy(AHtmlReader.HtmlStr, Start, AHtmlReader.Position - Start);
  HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnTextNode)
end;
 
function HtmlReaderRead(AHtmlReader: PHtmlReader): Boolean;
begin
  AHtmlReader.NodeType := HTMLDOM_NODE_NONE;
  AHtmlReader.Prefix := '';
  AHtmlReader.LocalName := '';
  AHtmlReader.NodeValue := '';
  AHtmlReader.PublicID := '';
  AHtmlReader.SystemID := '';
  AHtmlReader.IsEmptyElement := false;
  Result := false;
  if AHtmlReader.Position > Length(AHtmlReader.HtmlStr) then
    Exit;
  Result := true;
  if AHtmlReader.State in [rsBeforeValue, rsInValue, rsInQuotedValue] then
  begin
    if HtmlReaderReadValueNode(AHtmlReader) then
      Exit;
    if AHtmlReader.State = rsInQuotedValue then
      Inc(AHtmlReader.Position);
    AHtmlReader.NodeType := HTMLDOM_NODE_ATTRIBUTE;
    HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnAttributeEnd);
    AHtmlReader.State := rsBeforeAttr
  end
  else
  if AHtmlReader.State = rsBeforeAttr then
  begin
    if HtmlReaderReadAttrNode(AHtmlReader) then
      Exit;
    HtmlReaderReadElementTail(AHtmlReader);
    AHtmlReader.State := rsInitial;
  end
  else
  if HtmlReaderIsStartTagChar(AHtmlReader) then
  begin
    if HtmlReaderReadTagNode(AHtmlReader) then
      Exit;
    Inc(AHtmlReader.Position);
    AHtmlReader.NodeType := HTMLDOM_NODE_ENTITY_REFERENCE;
    HtmlReaderSetNodeName(AHtmlReader, 'lt');
    HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnEntityReference);
  end
  else
  if HtmlReaderIsStartEntityChar(AHtmlReader) then
  begin
    if HtmlReaderReadEntityNode(AHtmlReader) then
      Exit;
    Inc(AHtmlReader.Position);
    AHtmlReader.NodeType := HTMLDOM_NODE_ENTITY_REFERENCE;
    HtmlReaderSetNodeName(AHtmlReader, 'amp');
    HtmlReaderFireEvent(AHtmlReader, AHtmlReader.OnEntityReference)
  end
  else
    HtmlReaderReadTextNode(AHtmlReader)
end;

function HtmlParserparseString(AHtmlParser: PHtmlParser; const htmlStr: WideString): PHtmlDocDomNode; overload;
begin
  HtmlReaderSetHtmlStr(AHtmlParser.HtmlReader, htmlStr);
  AHtmlParser.HtmlDocument := createEmptyDocument(nil);
  AHtmlParser.CurrentNode := PHtmlDomNode(AHtmlParser.HtmlDocument);
  try
  while HtmlReaderRead(AHtmlParser.HtmlReader) do;
  except
    // TODO: Add event ?
  end;
  Result := AHtmlParser.HtmlDocument;
end;
                        
function CheckOutHtmlParser: PHtmlParser;
begin
  Result := System.New(PHtmlParser);
  FillChar(Result^, SizeOf(THtmlParser), 0);
  
  Result.HtmlReader := CheckOutHtmlReader;
  Result.HtmlReader.HtmlParser := Result;
  Result.HtmlReader.OnAttributeEnd := HtmlParserProcessAttributeEnd;
  Result.HtmlReader.OnAttributeStart := HtmlParserProcessAttributeStart;
  Result.HtmlReader.OnCDataSection := HtmlParserProcessCDataSection;
  Result.HtmlReader.OnComment := HtmlParserProcessComment;
  Result.HtmlReader.OnDocType := HtmlParserProcessDocType;
  Result.HtmlReader.OnElementEnd := HtmlParserProcessElementEnd;
  Result.HtmlReader.OnElementStart := HtmlParserProcessElementStart;
  Result.HtmlReader.OnEndElement := HtmlParserProcessEndElement;
  Result.HtmlReader.OnEntityReference := HtmlParserProcessEntityReference;
    //OnNotation := ProcessNotation;
    //OnProcessingInstruction := ProcessProcessingInstruction;
  Result.HtmlReader.OnTextNode := HtmlParserProcessTextNode;
end;

procedure CheckInHtmlParser(var AHtmlParser: PHtmlParser);
begin
  if nil <> AHtmlParser then
  begin
    if nil <> AHtmlParser.HtmlReader then
    begin
      AHtmlParser.HtmlReader.PublicID := '';
      AHtmlParser.HtmlReader.SystemID := '';
      AHtmlParser.HtmlReader.Prefix := '';
      AHtmlParser.HtmlReader.LocalName := '';
      AHtmlParser.HtmlReader.NodeValue := '';
      AHtmlParser.HtmlReader.HtmlStr := '';

      FreeMem(AHtmlParser.HtmlReader);
      AHtmlParser.HtmlReader := nil;
    end;
    FreeMem(AHtmlParser);
    AHtmlParser := nil;
  end;
end;   
              
end.
