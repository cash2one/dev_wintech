unit xlencrypt_aes;

interface
              
(*
    高级加密标准（英语：Advanced Encryption Standard，缩写：AES）
    在密码学中又称Rijndael加密法

    严格地说，AES和Rijndael加密法并不完全一样（虽然在实际应用中二者可以互换），
    因为Rijndael加密法可以支持更大范围的区块和密钥长度：AES的区块长度固定为128 比特，
    密钥长度则可以是128，192或256比特；而Rijndael使用的密钥和区块长度可以是32位的
    整数倍，以128位为下限，256比特为上限。加密过程中使用的密钥是由Rijndael密钥生成方案产生。
    大多数AES计算是在一个特别的有限域完成的。
*)

uses
  BaseType;

type
  TAESBuffer          = TByte16; //array [0..15] of Byte;
  TAESKey128          = TByte16; //array [0..15] of Byte;
  TAESKey192          = array [0..23] of Byte;
  TAESKey256          = TByte32; //array [0..31] of Byte;
  TAESExpandedKey128  = array [0..43] of LongWord;
  TAESExpandedKey192  = array [0..53] of LongWord;
  TAESExpandedKey256  = array [0..63] of LongWord;
                     
  PAESBuffer          = ^TAESBuffer;
  PAESKey128          = ^TAESKey128;
  PAESKey192          = ^TAESKey192;
  PAESKey256          = ^TAESKey256;
  PAESExpandedKey128  = ^TAESExpandedKey128;
  PAESExpandedKey192  = ^TAESExpandedKey192;
  PAESExpandedKey256  = ^TAESExpandedKey256;

// ECB 模式
// CBC 模式

implementation

end.
