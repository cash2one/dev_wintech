(*
------------------ lua5.2 -----------------------
          1    0 00012F10 luaL_addlstring
          2    1 00012F48 luaL_addstring
          3    2 00012FD4 luaL_addvalue
          4    3 00012608 luaL_argerror
          5    4 00013048 luaL_buffinit
          6    5 0001306C luaL_buffinitsize
          7    6 00013518 luaL_callmeta
          8    7 00012B0C luaL_checkany
          9    8 00012D50 luaL_checkinteger
         10    9 00012B4C luaL_checklstring
         11    A 00012CCC luaL_checknumber
         12    B 00012C00 luaL_checkoption
         13    C 00012A70 luaL_checkstack
         14    D 00012AD0 luaL_checktype
         15    E 00012A24 luaL_checkudata
         16    F 00012D94 luaL_checkunsigned
         17   10 00013B68 luaL_checkversion_ = _luaB_getmetatable
         18   11 000125B8 luaL_error
         19   12 0001284C luaL_execresult
         20   13 000127A8 luaL_fileresult
         21   14 00013488 luaL_getmetafield
         22   15 00013898 luaL_getsubtable
         23   16 00013A50 luaL_gsub
         24   17 00013594 luaL_len
         25   18 0001340C luaL_loadbufferx
         26   19 000131F8 luaL_loadfilex
         27   1A 00013448 luaL_loadstring
         28   1B 000128C4 luaL_newmetatable
         29   1C 00013B2C luaL_newstate
         30   1D 00013C5C luaL_openlib
         31   1E 0001C860 luaL_openlibs
         32   1F 00012DD8 luaL_optinteger
         33   20 00012B98 luaL_optlstring
         34   21 00012D10 luaL_optnumber
         35   22 00012E18 luaL_optunsigned
         36   23 00012E58 luaL_prepbuffsize
         37   24 0001370C luaL_pushmodule
         38   25 00012F7C luaL_pushresult
         39   26 00012FC0 luaL_pushresultsize
         40   27 000130A0 luaL_ref
         41   28 00013940 luaL_requiref
         42   29 000137E8 luaL_setfuncs
         43   2A 0001295C luaL_setmetatable
         44   2B 00012994 luaL_testudata
         45   2C 000135F8 luaL_tolstring
         46   2D 00012218 luaL_traceback
         47   2E 00013180 luaL_unref
         48   2F 00012534 luaL_where

         49   30 0000155C lua_absindex
         50   31 00001884 lua_arith
         51   32 00001520 lua_atpanic
         52   33 00002728 lua_callk
         53   34 00001444 lua_checkstack
         54   35 0000D8AC lua_close
         55   36 00001928 lua_compare
         56   37 00002B54 lua_concat
         57   38 0000168C lua_copy
         58   39 000021B8 lua_createtable
         59   3A 00002978 lua_dump
         60   3B 00002AF8 lua_error
         61   3C 000029CC lua_gc
         62   3D 00002BFC lua_getallocf
         63   3E 00002700 lua_getctx
         64   3F 00002090 lua_getfield
         65   40 00001FF4 lua_getglobal = _need_value.clone.2
         66   41 00004CD4 lua_gethook
         67   42 00004CEC lua_gethookcount
         68   43 00004CE0 lua_gethookmask
         69   44 00004E10 lua_getinfo
         70   45 00004D38 lua_getlocal
         71   46 0000221C lua_getmetatable
         72   47 00004CF8 lua_getstack
         73   48 0000205C lua_gettable
         74   49 00001584 lua_gettop
         75   4A 00002C84 lua_getupvalue
         76   4B 00002290 lua_getuservalue
         77   4C 00001624 lua_insert
         78   4D 0000172C lua_iscfunction
         79   4E 0000175C lua_isnumber
         80   4F 000017A4 lua_isstring
         81   50 000017CC lua_isuserdata
         82   51 00002BC8 lua_len = _exp2reg
         83   52 0000289C lua_load
         84   53 0000D684 lua_newstate
         85   54 0000D4F0 lua_newthread
         86   55 00002C38 lua_newuserdata
         87   56 00002B0C lua_next
         88   57 000027B8 lua_pcallk
         89   58 00001F8C lua_pushboolean
         90   59 00001EF0 lua_pushcclosure
         91   5A 00001EB8 lua_pushfstring
         92   5B 00001D80 lua_pushinteger
         93   5C 00001FB0 lua_pushlightuserdata
         94   5D 00001DD0 lua_pushlstring
         95   5E 00001D20 lua_pushnil
         96   5F 00001D38 lua_pushnumber
         97   60 00001E1C lua_pushstring
         98   61 00001FCC lua_pushthread
         99   62 00001D94 lua_pushunsigned
        100   63 000016B0 lua_pushvalue
        101   64 00001E7C lua_pushvfstring
        102   65 000017FC lua_rawequal
        103   66 000020E8 lua_rawget
        104   67 00002124 lua_rawgeti
        105   68 00002168 lua_rawgetp
        106   69 00001BDC lua_rawlen
        107   6A 000023E4 lua_rawset
        108   6B 0000246C lua_rawseti
        109   6C 000024F0 lua_rawsetp
        110   6D 000015E4 lua_remove
        111   6E 00001668 lua_replace
        112   6F 000062FC lua_resume
        113   70 00002C20 lua_setallocf
        114   71 00002380 lua_setfield = _luaK_concat
        115   72 000022D4 lua_setglobal
        116   73 00004C84 lua_sethook
        117   74 00004DBC lua_setlocal
        118   75 00002580 lua_setmetatable
        119   76 00002344 lua_settable
        120   77 0000159C lua_settop
        121   78 00002CD8 lua_setupvalue
        122   79 00002680 lua_setuservalue
        123   7A 000029C0 lua_status
        124   7B 00001B2C lua_toboolean
        125   7C 00001C34 lua_tocfunction
        126   7D 00001A54 lua_tointegerx
        127   7E 00001B64 lua_tolstring
        128   7F 000019F4 lua_tonumberx
        129   80 00001CC8 lua_topointer
        130   81 00001CA8 lua_tothread
        131   82 00001AC0 lua_tounsignedx
        132   83 00001C68 lua_touserdata
        133   84 000016DC lua_type
        134   85 0000171C lua_typename
        135   86 00002D78 lua_upvalueid
        136   87 00002DE8 lua_upvaluejoin = _luaK_exp2anyregup
        137   88 0000153C lua_version
        138   89 000014CC lua_xmove
        139   8A 00006424 lua_yieldk
        140   8B 00014E4C luaopen_base
        141   8C 00011C48 luaopen_bit32
        142   8D 0001CD60 luaopen_coroutine
        143   8E 00015EF4 luaopen_debug
        144   8F 00017130 luaopen_io
        145   90 00017B88 luaopen_math
        146   91 000184E8 luaopen_os
        147   92 0001C614 luaopen_package
        148   93 0001B3F4 luaopen_string
        149   94 00018FD0 luaopen_table
*)
unit dll_lua;

interface
const
  LUA_TNONE	= -1;
  LUA_TNIL = 0;
  LUA_TBOOLEAN = 1;
  LUA_TLIGHTUSERDATA = 2;
  LUA_TNUMBER = 3;
  LUA_TSTRING = 4;
  LUA_TTABLE =5;

  LUA_REGISTRYINDEX	= -10000;
  LUA_GLOBALSINDEX= -10001;

  LUA_ERRRUN = 1;
  LUA_ERRFILE = 2;
  LUA_ERRSYNTAX = 3;
  LUA_ERRMEM = 4;
  LUA_ERRERR = 5;

  Lua52 = 'lua52.dll';

  function lua_open: Pointer; cdecl;external Lua52;
  procedure lua_close(L: Pointer); cdecl; external Lua52;
  function lua_gettop(L: Pointer): Integer; cdecl; external Lua52;
  procedure lua_settop(L: Pointer; NDX: Integer); cdecl; external Lua52;
  function lua_type(L: Pointer; NDX: Integer): Integer; cdecl; external Lua52;

  function lua_tonumber(L: Pointer; NDX: Integer): Double; cdecl; external Lua52;
  function lua_toboolean(L: Pointer; NDX: Integer): LongBool; cdecl; external Lua52;
  function lua_tostring(L: Pointer; NDX: Integer): PAnsiChar; cdecl; external Lua52;
  function lua_topointer(L: Pointer; NDX: Integer): Pointer; cdecl; external Lua52;

  procedure lua_pushnumber(L: Pointer;n: Double); cdecl; external Lua52;
  procedure lua_pushstring(L: Pointer;s: PAnsiChar); cdecl; external Lua52;
  procedure lua_pushboolean(L: Pointer;b: LongBool); cdecl; external Lua52;

  function lua_pcall(L: Pointer;nargs,nresults,errfunc: Integer): Integer; cdecl; external Lua52;
  function lua_error(L: Pointer): Integer; cdecl; external Lua52;

  function luaopen_base(L: Pointer): Integer; cdecl; external Lua52;
  function luaopen_table(L: Pointer): Integer; cdecl; external Lua52;
  function luaopen_io(L: Pointer): Integer; cdecl; external Lua52;
  function luaopen_string(L: Pointer): Integer; cdecl; external Lua52;
  function luaopen_math(L: Pointer): Integer; cdecl; external Lua52;
  function luaopen_debug(L: Pointer): Integer; cdecl; external Lua52;
  function luaopen_loadlib(L: Pointer): Integer; cdecl; external Lua52;

  function lua_dostring(L: Pointer;Str: PAnsiChar): Integer; cdecl; external Lua52;
  procedure lua_settable(L: Pointer; NDX: Integer); cdecl; external Lua52;

  procedure lua_remove(L: Pointer; NDX: Integer); cdecl; external Lua52;
  procedure lua_insert(L: Pointer; NDX: Integer); cdecl; external Lua52;
  procedure lua_replace(L: Pointer; NDX: Integer); cdecl; external Lua52;
  procedure lua_gettable(L: Pointer; NDX: Integer); cdecl; external Lua52;

  procedure lua_newtable(L: Pointer); cdecl; external Lua52;
  procedure lua_rawgeti(L: Pointer;TIndex,Index: Integer); cdecl; external Lua52;
  procedure lua_rawseti(L: Pointer;TIndex,Index: Integer); cdecl; external Lua52;
  
implementation

end.
