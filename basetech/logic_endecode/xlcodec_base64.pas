unit xlcodec_base64;

interface

uses
  define_char;

(*
Base64是网络上最常见的用于传输8Bit字节代码的编码方式之一，
大家可以查看RFC2045～RFC2049，上面有MIME的详细规范。
Base64编码可用于在HTTP环境下传递较长的标识信息。例如，
在Java Persistence系统Hibernate中，就采用了Base64来将一个较长
的唯一标识符（一般为128-bit的UUID）编码为一个字符串，
用作HTTP表单和HTTP GET URL中的参数。在其他应用程序中，
也常常需要把二进制数据编码为适合放在URL（包括隐藏表单域）
中的形式。此时，采用Base64编码具有不可读性，即所编码的数据不会被人用肉眼所直接看到
*)
        
const
  Base64TableLength = 64;
  AA_BASE64: array[0..Base64TableLength - 1] of AnsiChar = (
    AC_CAPITAL_A, AC_CAPITAL_B, AC_CAPITAL_C, AC_CAPITAL_D, AC_CAPITAL_E, AC_CAPITAL_F,
    AC_CAPITAL_G, AC_CAPITAL_H, AC_CAPITAL_I, AC_CAPITAL_J, AC_CAPITAL_K, AC_CAPITAL_L,
    AC_CAPITAL_M, AC_CAPITAL_N, AC_CAPITAL_O, AC_CAPITAL_P, AC_CAPITAL_Q, AC_CAPITAL_R,
    AC_CAPITAL_S, AC_CAPITAL_T, AC_CAPITAL_U, AC_CAPITAL_V, AC_CAPITAL_W, AC_CAPITAL_X,
    AC_CAPITAL_Y, AC_CAPITAL_Z,       
    AC_SMALL_A, AC_SMALL_B, AC_SMALL_C, AC_SMALL_D, AC_SMALL_E, AC_SMALL_F,
    AC_SMALL_G, AC_SMALL_H, AC_SMALL_I, AC_SMALL_J, AC_SMALL_K, AC_SMALL_L,
    AC_SMALL_M, AC_SMALL_N, AC_SMALL_O, AC_SMALL_P, AC_SMALL_Q, AC_SMALL_R,
    AC_SMALL_S, AC_SMALL_T, AC_SMALL_U, AC_SMALL_V, AC_SMALL_W, AC_SMALL_X,
    AC_SMALL_Y, AC_SMALL_Z,   
    AC_DIGIT_ZERO, AC_DIGIT_ONE, AC_DIGIT_TWO, AC_DIGIT_THREE, AC_DIGIT_FOUR,
    AC_DIGIT_FIVE, AC_DIGIT_SIX, AC_DIGIT_SEVEN, AC_DIGIT_EIGHT, AC_DIGIT_NINE,
    AC_PLUS_SIGN, AC_SOLIDUS
    );
                    
//  Base64Table: AnsiChar[Base64TableLength]='ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
//                                           'abcdefghijklmnopqrstuvwxyz' +
//                                           '0123456789+/';
  Pad = AC_EQUALS_SIGN;
  
implementation

end.
