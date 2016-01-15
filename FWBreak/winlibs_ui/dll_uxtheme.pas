(*
          5    0 00004773 CloseThemeData
          6    1 00002BEF DrawThemeBackground
         47    2 00005458 DrawThemeBackgroundEx
         12    3 0001CFD4 DrawThemeEdge -- DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT)
                                           DrawThemeEdge(Theme[Element], DC, Part, State, R, Edge, Flags, ContentRect);
         37    4 0002C63F DrawThemeIcon
         38    5 0001AF7D DrawThemeParentBackground
         39    6 00002FF8 DrawThemeText
         40    7 0000B45B EnableThemeDialogTexture
         41    8 0002D01E EnableTheming
         42    9 0000B76A GetCurrentThemeName
         49    A 0001C261 GetThemeAppProperties
         50    B 00003E8A GetThemeBackgroundContentRect
         51    C 0001B1AD GetThemeBackgroundExtent
         52    D 00007DD3 GetThemeBackgroundRegion
         53    E 0000BEA5 GetThemeBool
         54    F 0000459D GetThemeColor
         55   10 0002D3AF GetThemeDocumentationProperty
         56   11 0000459D GetThemeEnumValue
         57   12 0002C05D GetThemeFilename
         58   13 0000BE06 GetThemeFont
         59   14 0000459D GetThemeInt
         67   15 0002BFF1 GetThemeIntList
         68   16 0000B0D2 GetThemeMargins
         69   17 0001CA91 GetThemeMetric
         70   18 000041A9 GetThemePartSize
         71   19 0002BF85 GetThemePosition
         72   1A 0002BF19 GetThemePropertyOrigin
         74   1B 0000BF0A GetThemeRect
         75   1C 0002C05D GetThemeString
         76   1D 0002D167 GetThemeSysBool
         77   1E 0001CB82 GetThemeSysColor
         78   1F 0002D04D GetThemeSysColorBrush
         79   20 0002C979 GetThemeSysFont
         80   21 0002CB9D GetThemeSysInt
         81   22 0002D2AE GetThemeSysSize
         82   23 0002CAFD GetThemeSysString
         83   24 00002E63 GetThemeTextExtent
         84   25 0001B293 GetThemeTextMetrics
         85   26 0002D0D4 GetWindowTheme
         86   27 0000B999 HitTestThemeBackground
         87   28 00008B4D IsAppThemed
         88   29 00008B85 IsThemeActive
         89   2A 0001AEF2 IsThemeBackgroundPartiallyTransparent
         90   2B 0002D124 IsThemeDialogTextureEnabled
         91   2C 0000A35A IsThemePartDefined
         92   2D 000073B8 OpenThemeData
         93   2E 0002D335 SetThemeAppProperties
         94   2F 0000B39E SetWindowTheme
*)
unit dll_uxtheme;

interface

implementation

end.