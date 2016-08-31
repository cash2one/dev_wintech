unit define_htmlparser;

interface

uses
  define_htmldom, html_helper_tag;
  
type
  TDelimiters = set of Byte;
  TReaderState = (rsInitial, rsBeforeAttr, rsBeforeValue, rsInValue, rsInQuotedValue);

  PHtmlReader = ^THtmlReader;
                  
  THtmlReaderEvent = procedure(AHtmlReader: PHtmlReader);
                      
  PHtmlParser = ^THtmlParser;
  
  THtmlReader       = record
    Position        : Integer;
    NodeType        : Integer;
    HtmlParser      : PHtmlParser;
    IsEmptyElement  : Boolean;
    Quotation       : Word;
    State           : TReaderState;
    PublicID        : WideString;
    SystemID        : WideString;
    Prefix          : WideString;
    LocalName       : WideString;
    NodeValue       : WideString;
    HtmlStr         : WideString;
    
    OnAttributeEnd  : THtmlReaderEvent;
    OnAttributeStart: THtmlReaderEvent;
    OnCDataSection  : THtmlReaderEvent;
    OnComment       : THtmlReaderEvent;
    OnDocType       : THtmlReaderEvent;
    OnElementEnd    : THtmlReaderEvent;
    OnElementStart  : THtmlReaderEvent;
    OnEndElement    : THtmlReaderEvent;
    OnEntityReference: THtmlReaderEvent;
    OnNotation      : THtmlReaderEvent;
    OnProcessingInstruction: THtmlReaderEvent;
    OnTextNode      : THtmlReaderEvent;
  end;
                  
  THtmlParser       = record
    HtmlDocument    : PHtmlDocDomNode;
    HtmlReader      : PHtmlReader;
    CurrentNode     : PHtmlDomNode;
    CurrentTag      : PHtmlTag;
    
//    EntityList: TEntList;
//    HtmlTagList: THtmlTagList;
//    URLSchemes: TURLSchemes;
  end;
        
implementation

end.
