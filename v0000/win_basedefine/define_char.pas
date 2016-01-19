unit define_char;

interface

const
  AC_NULL         = AnsiChar(#$00);      //
  AC_TAB          = AnsiChar(#$09);      //
  AC_LF           = AnsiChar(#$000A);    //
  AC_CR           = AnsiChar(#$000D);    //
  
  AA_CRLF : array[0..1] of AnsiChar = (#13, #10);
  AS_CRLF = AnsiString(#$0D#$0A);
  
  AC_SPACE        = AnsiChar(#$20);      //
  AC_EXCLAMATION_MARK = AnsiChar(#$21);  //
  AC_QUOTATION_MARK = AnsiChar(#$22);    //
  AC_NUMBER_SIGN  = AnsiChar(#$23);      //
  AC_DOLLAR_SIGN  = AnsiChar(#$24);      //
  AC_PERCENT_SIGN = AnsiChar(#$25);      //
  AC_AMPERSAND    = AnsiChar(#$26);      //
  AC_APOSTROPHE   = AnsiChar(#$27);      //
  AC_LEFT_PARENTHESIS = AnsiChar(#$28);  //
  AC_RIGHT_PARENTHESIS = AnsiChar(#$29); //
  AC_ASTERISK     = AnsiChar(#$2A);      //
  AC_PLUS_SIGN    = AnsiChar(#$2B);      //
  AC_COMMA        = AnsiChar(#$2C);      //
  AC_HYPHEN_MINUS = AnsiChar(#$2D);      //
  AC_FULL_STOP    = AnsiChar(#$2E);      //
  AC_SOLIDUS      = AnsiChar(#$2F);      //
                                         //
  AC_DIGIT_ZERO   = AnsiChar(#$30);      //
  AC_DIGIT_ONE    = AnsiChar(#$31);      //
  AC_DIGIT_TWO    = AnsiChar(#$32);      //
  AC_DIGIT_THREE  = AnsiChar(#$33);      //
  AC_DIGIT_FOUR   = AnsiChar(#$34);      //
  AC_DIGIT_FIVE   = AnsiChar(#$35);      //
  AC_DIGIT_SIX    = AnsiChar(#$36);      //
  AC_DIGIT_SEVEN  = AnsiChar(#$37);      //
  AC_DIGIT_EIGHT  = AnsiChar(#$38);      //
  AC_DIGIT_NINE   = AnsiChar(#$39);      //
                                         //
  AC_COLON        = AnsiChar(#$3A);      // : Ã°ºÅ
  AC_SEMICOLON    = AnsiChar(#$3B);      // ; ·ÖºÅ

  AC_LESS_THAN_SIGN = AnsiChar(#$3C);       // <
  AC_EQUALS_SIGN  = AnsiChar(#$3D);         // =
  AC_GREATER_THAN_SIGN = AnsiChar(#$3E);    //
  AC_QUESTION_MARK = AnsiChar(#$3F);        //
  AC_COMMERCIAL_AT = AnsiChar(#$40);        //
  AC_REVERSE_SOLIDUS = AnsiChar(#$5C);      //
  AC_LOW_LINE     = AnsiChar(#$5F);         //
  AC_SOFT_HYPHEN  = AnsiChar(#$AD);         //

  AC_CAPITAL_A    = AnsiChar(#$41);         //
  AC_CAPITAL_B    = AnsiChar(#$42);         //
  AC_CAPITAL_C    = AnsiChar(#$43);         //
  AC_CAPITAL_D    = AnsiChar(#$44);         //
  AC_CAPITAL_E    = AnsiChar(#$45);         //
  AC_CAPITAL_F    = AnsiChar(#$46);         //
  AC_CAPITAL_G    = AnsiChar(#$47);         //
  AC_CAPITAL_H    = AnsiChar(#$48);         //
  AC_CAPITAL_I    = AnsiChar(#$49);         //
  AC_CAPITAL_J    = AnsiChar(#$4A);         //
  AC_CAPITAL_K    = AnsiChar(#$4B);         //
  AC_CAPITAL_L    = AnsiChar(#$4C);         //
  AC_CAPITAL_M    = AnsiChar(#$4D);         //
  AC_CAPITAL_N    = AnsiChar(#$4E);         //
  AC_CAPITAL_O    = AnsiChar(#$4F);         //
  AC_CAPITAL_P    = AnsiChar(#$50);         //
  AC_CAPITAL_Q    = AnsiChar(#$51);         //
  AC_CAPITAL_R    = AnsiChar(#$52);         //
  AC_CAPITAL_S    = AnsiChar(#$53);         //
  AC_CAPITAL_T    = AnsiChar(#$54);         //
  AC_CAPITAL_U    = AnsiChar(#$55);         //
  AC_CAPITAL_V    = AnsiChar(#$56);         //
  AC_CAPITAL_W    = AnsiChar(#$57);         //
  AC_CAPITAL_X    = AnsiChar(#$58);         //
  AC_CAPITAL_Y    = AnsiChar(#$59);         //
  AC_CAPITAL_Z    = AnsiChar(#$5A);         //
                                            //
  AC_GRAVE_ACCENT = AnsiChar(#$60);         //
                                            //
  AC_SMALL_A      = AnsiChar(#$61);         //
  AC_SMALL_B      = AnsiChar(#$62);         //
  AC_SMALL_C      = AnsiChar(#$63);         //
  AC_SMALL_D      = AnsiChar(#$64);         //
  AC_SMALL_E      = AnsiChar(#$65);         //
  AC_SMALL_F      = AnsiChar(#$66);         //
  AC_SMALL_G      = AnsiChar(#$67);         //
  AC_SMALL_H      = AnsiChar(#$68);         //
  AC_SMALL_I      = AnsiChar(#$69);         //
  AC_SMALL_J      = AnsiChar(#$6A);         //
  AC_SMALL_K      = AnsiChar(#$6B);         //
  AC_SMALL_L      = AnsiChar(#$6C);         //
  AC_SMALL_M      = AnsiChar(#$6D);         //
  AC_SMALL_N      = AnsiChar(#$6E);         //
  AC_SMALL_O      = AnsiChar(#$6F);         //
  AC_SMALL_P      = AnsiChar(#$70);         //
  AC_SMALL_Q      = AnsiChar(#$71);         //
  AC_SMALL_R      = AnsiChar(#$72);         //
  AC_SMALL_S      = AnsiChar(#$73);         //
  AC_SMALL_T      = AnsiChar(#$74);         //
  AC_SMALL_U      = AnsiChar(#$75);         //
  AC_SMALL_V      = AnsiChar(#$76);         //
  AC_SMALL_W      = AnsiChar(#$77);         //
  AC_SMALL_X      = AnsiChar(#$78);         //
  AC_SMALL_Y      = AnsiChar(#$79);         //
  AC_SMALL_Z      = AnsiChar(#$7A);         //
                                            //
  AC_NO_BREAK_SPACE = AnsiChar(#$A0);       //


  WC_NULL         = WideChar(#$0000);
  WC_0001         = WideChar(#$0001);
  WC_0008         = WideChar(#$0008);
  WC_TAB          = WideChar(#$0009);
  WC_LF           = WideChar(#$000A);
  WC_000B         = WideChar(#$000B);
  WC_000C         = WideChar(#$000C);
  WC_CR           = WideChar(#$000D);
  WC_000E         = WideChar(#$000E); 
  WC_SPACE        = WideChar(#$0020);
  WC_EXCLAMATION_MARK = WideChar(#$0021);
  WC_QUOTATION_MARK = WideChar(#$0022);
  WC_NUMBER_SIGN  = WideChar(#$0023);
  WC_DOLLAR_SIGN  = WideChar(#$0024);
  WC_PERCENT_SIGN = WideChar(#$0025);
  WC_AMPERSAND    = WideChar(#$0026);
  WC_APOSTROPHE   = WideChar(#$0027);
  WC_LEFT_PARENTHESIS = WideChar(#$0028);
  WC_RIGHT_PARENTHESIS = WideChar(#$0029);
  WC_ASTERISK     = WideChar(#$002A);
  WC_PLUS_SIGN    = WideChar(#$002B);
  WC_COMMA        = WideChar(#$002C);
  WC_HYPHEN_MINUS = WideChar(#$002D);
  WC_FULL_STOP    = WideChar(#$002E);
  WC_SOLIDUS      = WideChar(#$002F);

  WC_DIGIT_ZERO   = WideChar(#$0030);
  WC_DIGIT_ONE    = WideChar(#$0031);
  WC_DIGIT_TWO    = WideChar(#$0032);
  WC_DIGIT_THREE  = WideChar(#$0033);
  WC_DIGIT_FOUR   = WideChar(#$0034);
  WC_DIGIT_FIVE   = WideChar(#$0035);
  WC_DIGIT_SIX    = WideChar(#$0036);
  WC_DIGIT_SEVEN  = WideChar(#$0037);
  WC_DIGIT_EIGHT  = WideChar(#$0038);
  WC_DIGIT_NINE   = WideChar(#$0039);
  
  WC_COLON        = WideChar(#$003A);
  WC_SEMICOLON    = WideChar(#$003B);
  WC_LESS_THAN_SIGN = WideChar(#$003C);
  WC_EQUALS_SIGN  = WideChar(#$003D);
  WC_GREATER_THAN_SIGN = WideChar(#$003E);
  WC_QUESTION_MARK = WideChar(#$003F);  
  WC_COMMERCIAL_AT = WideChar(#$0040);

  WC_CAPITAL_A    = WideChar(#$0041);
  WC_CAPITAL_B    = WideChar(#$0042);
  WC_CAPITAL_C    = WideChar(#$0043);
  WC_CAPITAL_D    = WideChar(#$0044);
  WC_CAPITAL_E    = WideChar(#$0045);
  WC_CAPITAL_F    = WideChar(#$0046);
  WC_CAPITAL_G    = WideChar(#$0047);
  WC_CAPITAL_H    = WideChar(#$0048);
  WC_CAPITAL_I    = WideChar(#$0049);
  WC_CAPITAL_J    = WideChar(#$004A);
  WC_CAPITAL_K    = WideChar(#$004B);
  WC_CAPITAL_L    = WideChar(#$004C);
  WC_CAPITAL_M    = WideChar(#$004D);
  WC_CAPITAL_N    = WideChar(#$004E);
  WC_CAPITAL_O    = WideChar(#$004F);
  WC_CAPITAL_P    = WideChar(#$0050);
  WC_CAPITAL_Q    = WideChar(#$0051);
  WC_CAPITAL_R    = WideChar(#$0052);
  WC_CAPITAL_S    = WideChar(#$0053);
  WC_CAPITAL_T    = WideChar(#$0054);
  WC_CAPITAL_U    = WideChar(#$0055);
  WC_CAPITAL_V    = WideChar(#$0056);
  WC_CAPITAL_W    = WideChar(#$0057);
  WC_CAPITAL_X    = WideChar(#$0058);
  WC_CAPITAL_Y    = WideChar(#$0059);
  WC_CAPITAL_Z    = WideChar(#$005A);

  WC_LEFT_SQUARE_BRACKET = WideChar(#$005B);

  WC_REVERSE_SOLIDUS = WideChar(#$005C);

  WC_RIGHT_SQUARE_BRACKET = WideChar(#$005D);

  WC_CIRCUMFLEX_ACCENT = WideChar(#$005E);

  WC_LOW_LINE = WideChar(#$005F);

  WC_GRAVE_ACCENT = WideChar(#$0060);

  WC_SMALL_A = WideChar(#$0061);
  WC_SMALL_B = WideChar(#$0062);
  WC_SMALL_C = WideChar(#$0063);
  WC_SMALL_D = WideChar(#$0064);
  WC_SMALL_E = WideChar(#$0065);
  WC_SMALL_F = WideChar(#$0066);
  WC_SMALL_G = WideChar(#$0067);
  WC_SMALL_H = WideChar(#$0068);
  WC_SMALL_I = WideChar(#$0069);
  WC_SMALL_J = WideChar(#$006A);
  WC_SMALL_K = WideChar(#$006B);
  WC_SMALL_L = WideChar(#$006C);
  WC_SMALL_M = WideChar(#$006D);
  WC_SMALL_N = WideChar(#$006E);
  WC_SMALL_O = WideChar(#$006F);
  WC_SMALL_P = WideChar(#$0070);
  WC_SMALL_Q = WideChar(#$0071);
  WC_SMALL_R = WideChar(#$0072);
  WC_SMALL_S = WideChar(#$0073);
  WC_SMALL_T = WideChar(#$0074);
  WC_SMALL_U = WideChar(#$0075);
  WC_SMALL_V = WideChar(#$0076);
  WC_SMALL_W = WideChar(#$0077);
  WC_SMALL_X = WideChar(#$0078);
  WC_SMALL_Y = WideChar(#$0079);
  WC_SMALL_Z = WideChar(#$007A);

  WC_LEFT_CURLY_BRACKET = WideChar(#$007B);
  WC_VERTICAL_LINE = WideChar(#$007C);
  WC_RIGHT_CURLY_BRACKET = WideChar(#$007D);
  WC_TILDE = WideChar(#$007E);

  WC_NO_BREAK_SPACE = WideChar(#$00A0);
  WC_SOFT_HYPHEN = WideChar(#$00AD);
  WC_EN_DASH = WideChar(#$2013);
  WC_LINE_SEPARATOR = WideChar($2028);
  WC_REPLACEMENT_CHARACTER = WideChar(#$FFFD);

  AC_DRIVE_DELIMITER = AC_COLON;            // :   
  WC_DRIVE_DELIMITER: WideChar = WC_COLON;

  WA_CRLF: array[0..1] of WideChar = (#13, #10);
  WS_CRLF = WideString(#$000D#$000A);

  AS_DIGITS = [AC_DIGIT_ZERO..AC_DIGIT_NINE];
  WS_DIGITS = [WC_DIGIT_ZERO..WC_DIGIT_NINE];
                         
  AS_HEX_DIGITS = [
    AC_DIGIT_ZERO..AC_DIGIT_NINE,
    AC_CAPITAL_A..AC_CAPITAL_F,
    AC_SMALL_A, AC_SMALL_F];   
  WS_HEX_DIGITS = [
    WC_DIGIT_ZERO..WC_DIGIT_NINE,
    WC_CAPITAL_A..WC_CAPITAL_F,
    WC_SMALL_A..WC_SMALL_F];
                                
  AS_WHITE_SPACE = [AC_NULL..AC_SPACE];
  WS_WHITE_SPACE = [WC_NULL..WC_SPACE];
  
  AA_NUM_TO_HEX: array[0..$F] of AnsiChar = (
    AC_DIGIT_ZERO,
    AC_DIGIT_ONE,
    AC_DIGIT_TWO,
    AC_DIGIT_THREE,
    AC_DIGIT_FOUR,
    AC_DIGIT_FIVE,
    AC_DIGIT_SIX,
    AC_DIGIT_SEVEN,
    AC_DIGIT_EIGHT,
    AC_DIGIT_NINE,
    AC_CAPITAL_A,
    AC_CAPITAL_B,
    AC_CAPITAL_C,
    AC_CAPITAL_D,
    AC_CAPITAL_E,
    AC_CAPITAL_F);
                    
  WA_NUM_TO_HEX: array[0..$F] of WideChar = (
    WC_DIGIT_ZERO,
    WC_DIGIT_ONE,
    WC_DIGIT_TWO,
    WC_DIGIT_THREE,
    WC_DIGIT_FOUR,
    WC_DIGIT_FIVE,
    WC_DIGIT_SIX,
    WC_DIGIT_SEVEN,
    WC_DIGIT_EIGHT,
    WC_DIGIT_NINE,
    WC_CAPITAL_A,
    WC_CAPITAL_B,
    WC_CAPITAL_C,
    WC_CAPITAL_D,
    WC_CAPITAL_E,
    WC_CAPITAL_F);

  BOM_UTF_8: array[0..2] of AnsiChar = (#$EF, #$BB, #$BF);
  BOM_UTF_16_BE: array[0..1] of AnsiChar = (#$FE, #$FF);
  BOM_UTF_16_LE: array[0..1] of AnsiChar = (#$FF, #$FE);
  BOM_UTF_32_BE: array[0..3] of AnsiChar = (#$00, #$00, #$FE, #$FF);
  BOM_UTF_32_LE: array[0..3] of AnsiChar = (#$FF, #$FE, #$00, #$00);

implementation

end.
