(*
          1    0 00001A40 GetFileVersionInfoA
          2    1 000019EF GetFileVersionInfoSizeA
          3    2 0000138C GetFileVersionInfoSizeW
          4    3 0000166F GetFileVersionInfoW
          5    4 000024CD VerFindFileA
          6    5 000033A8 VerFindFileW
          7    6 000026F7 VerInstallFileA
          8    7 00003756 VerInstallFileW
          9    8          VerLanguageNameA (forwarded to KERNEL32.VerLanguageNameA)
         10    9          VerLanguageNameW (forwarded to KERNEL32.VerLanguageNameW)
         11    A 000018AA VerQueryValueA
         12    B 00002958 VerQueryValueIndexA
         13    C 0000297F VerQueryValueIndexW
         14    D 00001805 VerQueryValueW
*)
unit dll_version;

interface

implementation

end.