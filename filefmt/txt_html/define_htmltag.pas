unit define_htmltag;

interface

const
  UNKNOWN_TAG    = 0;
  A_TAG          = 1;
  ABBR_TAG       = 2;
  ACRONYM_TAG    = 3;
  ADDRESS_TAG    = 4;
  APPLET_TAG     = 5;
  AREA_TAG       = 6;
  B_TAG          = 7;
  BASE_TAG       = 8;
  BASEFONT_TAG   = 9;
  BDO_TAG        = 10;
  BIG_TAG        = 11;
  BLOCKQUOTE_TAG = 12;
  BODY_TAG       = 13;
  BR_TAG         = 14;
  BUTTON_TAG     = 15;
  CAPTION_TAG    = 16;
  CENTER_TAG     = 17;
  CITE_TAG       = 18;
  CODE_TAG       = 19;
  COL_TAG        = 20;
  COLGROUP_TAG   = 21;
  DD_TAG         = 22;
  DEL_TAG        = 23;
  DFN_TAG        = 24;
  DIR_TAG        = 25;
  DIV_TAG        = 26;
  DL_TAG         = 27;
  DT_TAG         = 28;
  EM_TAG         = 29;
  FIELDSET_TAG   = 30;
  FONT_TAG       = 31;
  FORM_TAG       = 32;
  FRAME_TAG      = 33;
  FRAMESET_TAG   = 34;
  H1_TAG         = 35;
  H2_TAG         = 36;
  H3_TAG         = 37;
  H4_TAG         = 38;
  H5_TAG         = 39;
  H6_TAG         = 40;
  HEAD_TAG       = 41;
  HR_TAG         = 42;
  HTML_TAG       = 43;
  I_TAG          = 44;
  IFRAME_TAG     = 45;
  IMG_TAG        = 46;
  INPUT_TAG      = 47;
  INS_TAG        = 48;
  ISINDEX_TAG    = 49;
  KBD_TAG        = 50;
  LABEL_TAG      = 51;
  LEGEND_TAG     = 52;
  LI_TAG         = 53;
  LINK_TAG       = 54;
  MAP_TAG        = 55;
  MENU_TAG       = 56;
  META_TAG       = 57;
  NOFRAMES_TAG   = 58;
  NOSCRIPT_TAG   = 59;
  OBJECT_TAG     = 60;
  OL_TAG         = 61;
  OPTGROUP_TAG   = 62;
  OPTION_TAG     = 63;
  P_TAG          = 64;
  PARAM_TAG      = 65;
  PRE_TAG        = 66;
  Q_TAG          = 67;
  S_TAG          = 68;
  SAMP_TAG       = 69;
  SCRIPT_TAG     = 70;
  SELECT_TAG     = 71;
  SMALL_TAG      = 72;
  SPAN_TAG       = 73;
  STRIKE_TAG     = 74;
  STRONG_TAG     = 75;
  STYLE_TAG      = 76;
  SUB_TAG        = 77;
  SUP_TAG        = 78;
  TABLE_TAG      = 79;
  TBODY_TAG      = 80;
  TD_TAG         = 81;
  TEXTAREA_TAG   = 82;
  TFOOT_TAG      = 83;
  TH_TAG         = 84;
  THEAD_TAG      = 85;
  TITLE_TAG      = 86;
  TR_TAG         = 87;
  TT_TAG         = 88;
  U_TAG          = 89;
  UL_TAG         = 90;
  VAR_TAG        = 91;

  BlockTags               = [ADDRESS_TAG, BLOCKQUOTE_TAG, CENTER_TAG, DIV_TAG, DL_TAG, FIELDSET_TAG, {FORM_TAG,} H1_TAG, H2_TAG, H3_TAG, H4_TAG, H5_TAG, H6_TAG, HR_TAG, NOSCRIPT_TAG, OL_TAG, PRE_TAG, TABLE_TAG, UL_TAG];
  BlockParentTags         = [ADDRESS_TAG, BLOCKQUOTE_TAG, CENTER_TAG, DIV_TAG, DL_TAG, FIELDSET_TAG, H1_TAG, H2_TAG, H3_TAG, H4_TAG, H5_TAG, H6_TAG, HR_TAG, LI_TAG, NOSCRIPT_TAG, OL_TAG, PRE_TAG, TD_TAG, TH_TAG, UL_TAG];
  HeadTags                = [BASE_TAG, LINK_TAG, META_TAG, SCRIPT_TAG, STYLE_TAG, TITLE_TAG];
  {Elements forbidden from having an end tag, and therefore are empty; from HTML 4.01 spec}
  EmptyTags               = [AREA_TAG, BASE_TAG, BASEFONT_TAG, BR_TAG, COL_TAG, FRAME_TAG, HR_TAG, IMG_TAG, INPUT_TAG, ISINDEX_TAG, LINK_TAG, META_TAG, PARAM_TAG];
  PreserveWhiteSpaceTags  = [PRE_TAG];
  NeedFindParentTags      = [COL_TAG, COLGROUP_TAG, DD_TAG, DT_TAG, LI_TAG, OPTION_TAG, P_TAG, TABLE_TAG, TBODY_TAG, TD_TAG, TFOOT_TAG, TH_TAG, THEAD_TAG, TR_TAG];
  ListItemParentTags      = [DIR_TAG, MENU_TAG, OL_TAG, UL_TAG];
  DefItemParentTags       = [DL_TAG];
  TableSectionParentTags  = [TABLE_TAG];
  ColParentTags           = [COLGROUP_TAG];
  RowParentTags           = [TABLE_TAG, TBODY_TAG, TFOOT_TAG, THEAD_TAG];
  CellParentTags          = [TR_TAG];
  OptionParentTags        = [OPTGROUP_TAG, SELECT_TAG];
                  
const
  htmlTagName = 'html';
  headTagName = 'head';
  bodyTagName = 'body';
  
const                   
  TAB = 9;
  LF = 10;
  CR = 13;
  SP = 32;

  WhiteSpace = [TAB, LF, CR, SP];

  startTagChar = Ord('<');
  endTagChar = Ord('>');
  specialTagChar = Ord('!');
  slashChar = Ord('/');
  equalChar = Ord('=');
  quotation = [Ord(''''), Ord('"')];
  tagDelimiter = [slashChar, endTagChar];
  tagNameDelimiter = whiteSpace + tagDelimiter;
  attrNameDelimiter = tagNameDelimiter + [equalChar];
  startEntity = Ord('&');
  startMarkup = [startTagChar, startEntity];
  endEntity = Ord(';');
  notEntity = [endEntity] + startMarkup + whiteSpace;
  notAttrText = whiteSpace + quotation + tagDelimiter;
  numericEntity = Ord('#');
  hexEntity = [Ord('x'), Ord('X')];
  decDigit = [Ord('0')..Ord('9')];
  hexDigit = [Ord('a')..Ord('f'), Ord('A')..Ord('F')];

  DocTypeStartStr = 'DOCTYPE';
  DocTypeEndStr = '>';
  CDataStartStr = '[CDATA[';
  CDataEndStr = ']]>';
  CommentStartStr = '--';
  CommentEndStr = '-->';
                       
const
  {HTML DTDs}
  DTD_HTML_STRICT    = 1;
  DTD_HTML_LOOSE     = 2;
  DTD_HTML_FRAMESET  = 3;
  DTD_XHTML_STRICT   = 4;
  DTD_XHTML_LOOSE    = 5;
  DTD_XHTML_FRAMESET = 6;

implementation

end.
