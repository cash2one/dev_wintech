unit html_helper_tag;

interface

uses
  Classes, SysUtils;
          
const                  
  MAX_TAGS_COUNT  = 128;
  MAX_FLAGS_COUNT = 32;

type         
  THtmlTagSet       = set of 0..MAX_TAGS_COUNT - 1;

  THtmlTagFlags     = set of 0..MAX_FLAGS_COUNT - 1;

  PHtmlTag          = ^THtmlTag;
  THtmlTag          = record
    Number          : Integer;
    ParserFlags     : THtmlTagFlags;
    FormatterFlags  : THtmlTagFlags;
    Name            : WideString;
  end;
                    
  TCompareTag       = function(Tag: PHtmlTag): Integer of object;
              
  THtmlTagList = class
  private
    FList: TList;
    FUnknownTag: PHtmlTag;
    FSearchName: WideString;
    FSearchNumber: Integer;
    function CompareName(Tag: PHtmlTag): Integer;
    function CompareNumber(Tag: PHtmlTag): Integer;
    function GetTag(Compare: TCompareTag): PHtmlTag;
  public
    constructor Create;
    destructor Destroy; override;
    function GetTagByName(const Name: WideString): PHtmlTag;
    function GetTagByNumber(Number: Integer): PHtmlTag;
  end;
  
var
  HtmlTagList: THtmlTagList = nil;
  
implementation
             
uses
  define_htmltag;
    
function CheckOutHtmlTag(const AName: WideString; ANumber: Integer; AParserFlags, AFormatterFlags: THtmlTagFlags): PHtmlTag;
begin
  Result := System.New(PHtmlTag);
  FillChar(Result^, SizeOf(THtmlTag), 0);
  Result.Name := AName;
  Result.Number := ANumber;
end;

constructor THtmlTagList.Create;
begin
  inherited Create;
  FList := TList.Create;
  FList.Capacity := MAX_TAGS_COUNT;
  FList.Add(CheckOutHtmlTag('a',          A_TAG,          [], []));
  FList.Add(CheckOutHtmlTag('abbr',       ABBR_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('acronym',    ACRONYM_TAG,    [], []));
  FList.Add(CheckOutHtmlTag('address',    ADDRESS_TAG,    [], []));
  FList.Add(CheckOutHtmlTag('applet',     APPLET_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('area',       AREA_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('b',          B_TAG,          [], []));
  FList.Add(CheckOutHtmlTag('base',       BASE_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('basefont',   BASEFONT_TAG,   [], []));
  FList.Add(CheckOutHtmlTag('bdo',        BDO_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('big',        BIG_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('blockquote', BLOCKQUOTE_TAG, [], []));
  FList.Add(CheckOutHtmlTag('body',       BODY_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('br',         BR_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('button',     BUTTON_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('caption',    CAPTION_TAG,    [], []));
  FList.Add(CheckOutHtmlTag('center',     CENTER_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('cite',       CITE_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('code',       CODE_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('col',        COL_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('colgroup',   COLGROUP_TAG,   [], []));
  FList.Add(CheckOutHtmlTag('dd',         DD_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('del',        DEL_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('dfn',        DFN_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('dir',        DIR_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('div',        DIV_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('dl',         DL_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('dt',         DT_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('em',         EM_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('fieldset',   FIELDSET_TAG,   [], []));
  FList.Add(CheckOutHtmlTag('font',       FONT_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('form',       FORM_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('frame',      FRAME_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('frameset',   FRAMESET_TAG,   [], []));
  FList.Add(CheckOutHtmlTag('h1',         H1_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('h2',         H2_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('h3',         H3_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('h4',         H4_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('h5',         H5_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('h6',         H6_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('head',       HEAD_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('hr',         HR_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('html',       HTML_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('i',          I_TAG,          [], []));
  FList.Add(CheckOutHtmlTag('iframe',     IFRAME_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('img',        IMG_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('input',      INPUT_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('ins',        INS_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('isindex',    ISINDEX_TAG,    [], []));
  FList.Add(CheckOutHtmlTag('kbd',        KBD_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('label',      LABEL_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('legend',     LEGEND_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('li',         LI_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('link',       LINK_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('map',        MAP_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('menu',       MENU_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('meta',       META_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('noframes',   NOFRAMES_TAG,   [], []));
  FList.Add(CheckOutHtmlTag('noscript',   NOSCRIPT_TAG,   [], []));
  FList.Add(CheckOutHtmlTag('object',     OBJECT_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('ol',         OL_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('optgroup',   OPTGROUP_TAG,   [], []));
  FList.Add(CheckOutHtmlTag('option',     OPTION_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('p',          P_TAG,          [], []));
  FList.Add(CheckOutHtmlTag('param',      PARAM_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('pre',        PRE_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('q',          Q_TAG,          [], []));
  FList.Add(CheckOutHtmlTag('s',          S_TAG,          [], []));
  FList.Add(CheckOutHtmlTag('samp',       SAMP_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('script',     SCRIPT_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('select',     SELECT_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('small',      SMALL_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('span',       SPAN_TAG,       [], []));
  FList.Add(CheckOutHtmlTag('strike',     STRIKE_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('strong',     STRONG_TAG,     [], []));
  FList.Add(CheckOutHtmlTag('style',      STYLE_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('sub',        SUB_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('sup',        SUP_TAG,        [], []));
  FList.Add(CheckOutHtmlTag('table',      TABLE_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('tbody',      TBODY_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('td',         TD_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('textarea',   TEXTAREA_TAG,   [], []));
  FList.Add(CheckOutHtmlTag('tfoot',      TFOOT_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('th',         TH_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('thead',      THEAD_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('title',      TITLE_TAG,      [], []));
  FList.Add(CheckOutHtmlTag('tr',         TR_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('tt',         TT_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('u',          U_TAG,          [], []));
  FList.Add(CheckOutHtmlTag('ul',         UL_TAG,         [], []));
  FList.Add(CheckOutHtmlTag('var',        VAR_TAG,        [], []));
  FUnknownTag := CheckOutHtmlTag('', UNKNOWN_TAG, [], [])
end;

destructor THtmlTagList.Destroy;
var
  I: Integer;
begin
  for I := FList.Count - 1 downto 0 do
  begin
    FreeMem(PHtmlTag(FList[I]));
  end;
  FList.Clear;
  FList.Free;
  FreeMem(FUnknownTag);
  inherited Destroy
end;

function THtmlTagList.GetTag(Compare: TCompareTag): PHtmlTag;
var
  I, Low, High, Rel: Integer;
begin
  Low := -1;
  High := FList.Count - 1;
  while High - Low > 1 do
  begin
    I := (High + Low) div 2;
    Result := FList[I];
    Rel := Compare(Result);
    if Rel < 0 then
      High := I
    else
    if Rel > 0 then
      Low := I
    else
      Exit
  end;
  if High >= 0 then
  begin
    Result := FList[High];
    if Compare(Result) = 0 then
      Exit
  end;
  Result := nil
end;

function THtmlTagList.CompareName(Tag: PHtmlTag): Integer;
begin
  Result := CompareStr(FSearchName, Tag.Name)
end;

function THtmlTagList.CompareNumber(Tag: PHtmlTag): Integer;
begin
  Result := FSearchNumber - Tag.Number
end;

function THtmlTagList.GetTagByName(const Name: WideString): PHtmlTag;
begin
  FSearchName := Name;
  Result := GetTag(CompareName);
  if Result = nil then
    Result := FUnknownTag
end;

function THtmlTagList.GetTagByNumber(Number: Integer): PHtmlTag;
begin
  FSearchNumber := Number;
  Result := GetTag(CompareNumber)
end;
    
initialization
  HtmlTagList := THtmlTagList.Create;

finalization       
  HtmlTagList.Free;
    
end.
