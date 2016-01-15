{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}
unit dll_sqlite3;
              
{ $DEFINE SQLITE_DEPRECATED}              // Enable deprecated functions
{ $DEFINE SQLITE_EXPERIMENTAL}            // Enable experimental functions

{$DEFINE SQLITE_ENABLE_COLUMN_METADATA}   // Enable functions to work with
                                          // column metadata:
                                          // table name, DB name, etc.

{$DEFINE SQLITE_ENABLE_UNLOCK_NOTIFY}     // Enable sqlite3_unlock_notify()
                                          // function to receive DB unlock
                                          // notification

{ $DEFINE SQLITE_DEBUG}                   // Enable sqlite3_mutex_held() and
                                          // sqlite3_mutex_notheld() functions
                
interface

uses
  atmcmbaseconst, winconst, wintype;

const
  SQLITE_OK                         = 0;
  SQLITE_ERROR                      = 1;
  SQLITE_INTERNAL                   = 2;
  SQLITE_PERM                       = 3;
  SQLITE_ABORT                      = 4;
  SQLITE_BUSY                       = 5;
  SQLITE_LOCKED                     = 6;
  SQLITE_NOMEM                      = 7;
  SQLITE_READONLY                   = 8;
  SQLITE_INTERRUPT                  = 9;
  SQLITE_IOERR                      = 10;
  SQLITE_CORRUPT                    = 11;
  SQLITE_NOTFOUND                   = 12;
  SQLITE_FULL                       = 13;
  SQLITE_CANTOPEN                   = 14;
  SQLITE_PROTOCOL                   = 15;
  SQLITE_EMPTY                      = 16;
  SQLITE_SCHEMA                     = 17;
  SQLITE_TOOBIG                     = 18;
  SQLITE_CONSTRAINT                 = 19;
  SQLITE_MISMATCH                   = 20;
  SQLITE_MISUSE                     = 21;
  SQLITE_NOLFS                      = 22;
  SQLITE_AUTH                       = 23;
  SQLITE_FORMAT                     = 24;
  SQLITE_RANGE                      = 25;
  SQLITE_NOTADB                     = 26;
  SQLITE_ROW                        = 100;
  SQLITE_DONE                       = 101;

  SQLITE_IOERR_READ                 = SQLITE_IOERR or (1 shl 8);
  SQLITE_IOERR_SHORT_READ           = SQLITE_IOERR or (2 shl 8);
  SQLITE_IOERR_WRITE                = SQLITE_IOERR or (3 shl 8);
  SQLITE_IOERR_FSYNC                = SQLITE_IOERR or (4 shl 8);
  SQLITE_IOERR_DIR_FSYNC            = SQLITE_IOERR or (5 shl 8);
  SQLITE_IOERR_TRUNCATE             = SQLITE_IOERR or (6 shl 8);
  SQLITE_IOERR_FSTAT                = SQLITE_IOERR or (7 shl 8);
  SQLITE_IOERR_UNLOCK               = SQLITE_IOERR or (8 shl 8);
  SQLITE_IOERR_RDLOCK               = SQLITE_IOERR or (9 shl 8);
  SQLITE_IOERR_DELETE               = SQLITE_IOERR or (10 shl 8);
  SQLITE_IOERR_BLOCKED              = SQLITE_IOERR or (11 shl 8);
  SQLITE_IOERR_NOMEM                = SQLITE_IOERR or (12 shl 8);
  SQLITE_IOERR_ACCESS               = SQLITE_IOERR or (13 shl 8);
  SQLITE_IOERR_CHECKRESERVEDLOCK    = SQLITE_IOERR or (14 shl 8);
  SQLITE_IOERR_LOCK                 = SQLITE_IOERR or (15 shl 8);
  SQLITE_IOERR_CLOSE                = SQLITE_IOERR or (16 shl 8);
  SQLITE_IOERR_DIR_CLOSE            = SQLITE_IOERR or (17 shl 8);
  SQLITE_LOCKED_SHAREDCACHE         = SQLITE_LOCKED or (1 shl 8);

  SQLITE_OPEN_READONLY              = $00000001;
  SQLITE_OPEN_READWRITE             = $00000002;
  SQLITE_OPEN_CREATE                = $00000004;
  SQLITE_OPEN_DELETEONCLOSE         = $00000008;
  SQLITE_OPEN_EXCLUSIVE             = $00000010;
  SQLITE_OPEN_MAIN_DB               = $00000100;
  SQLITE_OPEN_TEMP_DB               = $00000200;
  SQLITE_OPEN_TRANSIENT_DB          = $00000400;
  SQLITE_OPEN_MAIN_JOURNAL          = $00000800;
  SQLITE_OPEN_TEMP_JOURNAL          = $00001000;
  SQLITE_OPEN_SUBJOURNAL            = $00002000;
  SQLITE_OPEN_MASTER_JOURNAL        = $00004000;
  SQLITE_OPEN_NOMUTEX               = $00008000;
  SQLITE_OPEN_FULLMUTEX             = $00010000;
  SQLITE_OPEN_SHAREDCACHE           = $00020000;
  SQLITE_OPEN_PRIVATECACHE          = $00040000;

  SQLITE_IOCAP_ATOMIC               = $00000001;
  SQLITE_IOCAP_ATOMIC512            = $00000002;
  SQLITE_IOCAP_ATOMIC1K             = $00000004;
  SQLITE_IOCAP_ATOMIC2K             = $00000008;
  SQLITE_IOCAP_ATOMIC4K             = $00000010;
  SQLITE_IOCAP_ATOMIC8K             = $00000020;
  SQLITE_IOCAP_ATOMIC16K            = $00000040;
  SQLITE_IOCAP_ATOMIC32K            = $00000080;
  SQLITE_IOCAP_ATOMIC64K            = $00000100;
  SQLITE_IOCAP_SAFE_APPEND          = $00000200;
  SQLITE_IOCAP_SEQUENTIAL           = $00000400;

  SQLITE_LOCK_NONE                  = 0;
  SQLITE_LOCK_SHARED                = 1;
  SQLITE_LOCK_RESERVED              = 2;
  SQLITE_LOCK_PENDING               = 3;
  SQLITE_LOCK_EXCLUSIVE             = 4;

  SQLITE_SYNC_NORMAL                = $00002;
  SQLITE_SYNC_FULL                  = $00003;
  SQLITE_SYNC_DATAONLY              = $00010;
           
  SQLITE_FCNTL_LOCKSTATE            = 1;
  SQLITE_GET_LOCKPROXYFILE          = 2;
  SQLITE_SET_LOCKPROXYFILE          = 3;
  SQLITE_LAST_ERRNO                 = 4;
          
  SQLITE_ACCESS_EXISTS              = 0;
  SQLITE_ACCESS_READWRITE           = 1;
  SQLITE_ACCESS_READ                = 2;
                 
{$IFDEF SQLITE_EXPERIMENTAL}
  SQLITE_CONFIG_SINGLETHREAD        = 1;
  SQLITE_CONFIG_MULTITHREAD         = 2;
  SQLITE_CONFIG_SERIALIZED          = 3;
  SQLITE_CONFIG_MALLOC              = 4;
  SQLITE_CONFIG_GETMALLOC           = 5;
  SQLITE_CONFIG_SCRATCH             = 6;
  SQLITE_CONFIG_PAGECACHE           = 7;
  SQLITE_CONFIG_HEAP                = 8;
  SQLITE_CONFIG_MEMSTATUS           = 9;
  SQLITE_CONFIG_MUTEX               = 10;
  SQLITE_CONFIG_GETMUTEX            = 11;
  //SQLITE_CONFIG_CHUNKALLOC        = 12;
  SQLITE_CONFIG_LOOKASIDE           = 13;
  SQLITE_CONFIG_PCACHE              = 14;
  SQLITE_CONFIG_GETPCACHE           = 15;

  SQLITE_DBCONFIG_LOOKASIDE         = 1001;
{$ENDIF}

  SQLITE_DENY                       = 1;
  SQLITE_IGNORE                     = 2;

  SQLITE_CREATE_INDEX               = 1;
  SQLITE_CREATE_TABLE               = 2;
  SQLITE_CREATE_TEMP_INDEX          = 3;
  SQLITE_CREATE_TEMP_TABLE          = 4;
  SQLITE_CREATE_TEMP_TRIGGER        = 5;
  SQLITE_CREATE_TEMP_VIEW           = 6;
  SQLITE_CREATE_TRIGGER             = 7;
  SQLITE_CREATE_VIEW                = 8;
  SQLITE_DELETE                     = 9;
  SQLITE_DROP_INDEX                 = 10;
  SQLITE_DROP_TABLE                 = 11;
  SQLITE_DROP_TEMP_INDEX            = 12;
  SQLITE_DROP_TEMP_TABLE            = 13;
  SQLITE_DROP_TEMP_TRIGGER          = 14;
  SQLITE_DROP_TEMP_VIEW             = 15;
  SQLITE_DROP_TRIGGER               = 16;
  SQLITE_DROP_VIEW                  = 17;
  SQLITE_INSERT                     = 18;
  SQLITE_PRAGMA                     = 19;
  SQLITE_READ                       = 20;
  SQLITE_SELECT                     = 21;
  SQLITE_TRANSACTION                = 22;
  SQLITE_UPDATE                     = 23;
  SQLITE_ATTACH                     = 24;
  SQLITE_DETACH                     = 25;
  SQLITE_ALTER_TABLE                = 26;
  SQLITE_REINDEX                    = 27;
  SQLITE_ANALYZE                    = 28;
  SQLITE_CREATE_VTABLE              = 29;
  SQLITE_DROP_VTABLE                = 30;
  SQLITE_FUNCTION                   = 31;
  SQLITE_SAVEPOINT                  = 32;
  SQLITE_COPY                       = 0;
                       
  SQLITE_LIMIT_LENGTH               = 0;
  SQLITE_LIMIT_SQL_LENGTH           = 1;
  SQLITE_LIMIT_COLUMN               = 2;
  SQLITE_LIMIT_EXPR_DEPTH           = 3;
  SQLITE_LIMIT_COMPOUND_SELECT      = 4;
  SQLITE_LIMIT_VDBE_OP              = 5;
  SQLITE_LIMIT_FUNCTION_ARG         = 6;
  SQLITE_LIMIT_ATTACHED             = 7;
  SQLITE_LIMIT_LIKE_PATTERN_LENGTH  = 8;
  SQLITE_LIMIT_VARIABLE_NUMBER      = 9;
  SQLITE_LIMIT_TRIGGER_DEPTH        = 10;

  SQLITE_STATIC                     = Pointer(0);
  SQLITE_TRANSIENT                  = Pointer(-1);

  SQLITE_INTEGER                    = 1;
  SQLITE_FLOAT                      = 2;  
  SQLITE_TEXT                       = 3;
  SQLITE_BLOB                       = 4;
  SQLITE_NULL                       = 5;
  
  SQLITE_UTF8                       = 1;
  SQLITE_UTF16LE                    = 2;
  SQLITE_UTF16BE                    = 3;
  SQLITE_UTF16                      = 4;
  SQLITE_ANY                        = 5;
  SQLITE_UTF16_ALIGNED              = 8;

  SQLITE_INDEX_CONSTRAINT_EQ        = 2;
  SQLITE_INDEX_CONSTRAINT_GT        = 4;
  SQLITE_INDEX_CONSTRAINT_LE        = 8;
  SQLITE_INDEX_CONSTRAINT_LT        = 16;
  SQLITE_INDEX_CONSTRAINT_GE        = 32;
  SQLITE_INDEX_CONSTRAINT_MATCH     = 64;

  SQLITE_MUTEX_FAST                 = 0;
  SQLITE_MUTEX_RECURSIVE            = 1;
  SQLITE_MUTEX_STATIC_MASTER        = 2;
  SQLITE_MUTEX_STATIC_MEM           = 3;
  SQLITE_MUTEX_STATIC_MEM2          = 4;
  SQLITE_MUTEX_STATIC_OPEN          = 4;
  SQLITE_MUTEX_STATIC_PRNG          = 5;
  SQLITE_MUTEX_STATIC_LRU           = 6;
  SQLITE_MUTEX_STATIC_LRU2          = 7;

  SQLITE_TESTCTRL_FIRST             = 5;
  SQLITE_TESTCTRL_PRNG_SAVE         = 5;
  SQLITE_TESTCTRL_PRNG_RESTORE      = 6;
  SQLITE_TESTCTRL_PRNG_RESET        = 7;
  SQLITE_TESTCTRL_BITVEC_TEST       = 8;
  SQLITE_TESTCTRL_FAULT_INSTALL     = 9;
  SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS = 10;
  SQLITE_TESTCTRL_PENDING_BYTE      = 11;
  SQLITE_TESTCTRL_ASSERT            = 12;
  SQLITE_TESTCTRL_ALWAYS            = 13;
  SQLITE_TESTCTRL_RESERVE           = 14;
  SQLITE_TESTCTRL_OPTIMIZATIONS     = 15;
  SQLITE_TESTCTRL_ISKEYWORD         = 16;
  SQLITE_TESTCTRL_LAST              = 16;

  SQLITE_STATUS_MEMORY_USED         = 0;
  SQLITE_STATUS_PAGECACHE_USED      = 1;
  SQLITE_STATUS_PAGECACHE_OVERFLOW  = 2;
  SQLITE_STATUS_SCRATCH_USED        = 3;
  SQLITE_STATUS_SCRATCH_OVERFLOW    = 4;
  SQLITE_STATUS_MALLOC_SIZE         = 5;
  SQLITE_STATUS_PARSER_STACK        = 6;
  SQLITE_STATUS_PAGECACHE_SIZE      = 7;
  SQLITE_STATUS_SCRATCH_SIZE        = 8;

  SQLITE_DBSTATUS_LOOKASIDE_USED    = 0;

  SQLITE_STMTSTATUS_FULLSCAN_STEP   = 1;
  SQLITE_STMTSTATUS_SORT            = 2;

type
  PPAnsiCharArray = ^TPAnsiCharArray;
  TPAnsiCharArray = array[0..MaxInt div SizeOf(PAnsiChar) - 1] of PAnsiChar;
//
//const
//  sqlite3_lib = 'sqlite3.dll';

//var sqlite3_version: PAnsiChar;
  Tsq3_libversion     = function : PAnsiChar; cdecl;
  Tsq3_sourceid       = function : PAnsiChar; cdecl;
  Tsq3_libversion_number = function : Integer; cdecl;
  Tsq3_threadsafe     = function : Integer; cdecl;
  PSQLite3            = type Pointer;

  Tsq3_close          = function (db: PSQLite3): Integer; cdecl;

  Tsqlite3Callback    = function(pArg: Pointer; nCol: Integer; argv: PPAnsiCharArray; colv: PPAnsiCharArray): Integer; cdecl;

  Tsq3_exec           = function (db: PSQLite3; const sql: PAnsiChar; callback: Tsqlite3Callback;
      pArg: Pointer; errmsg: PPAnsiChar): Integer; cdecl;

  PSQLite3File        = ^Tsqlite3File;
  PSQLite3IOMethods   = ^Tsqlite3IOMethods;

  sqlite3_file        = record
    pMethods          : PSQLite3IOMethods;
  end;
  Tsqlite3File        = sqlite3_file;

  sqlite3_io_methods  = record
    iVersion          : Integer;
    xClose            : function(id: PSQLite3File): Integer; cdecl;
    xRead             : function(id: PSQLite3File; pBuf: Pointer; iAmt: Integer; iOfst: Int64): Integer; cdecl;
    xWrite            : function(id: PSQLite3File; const pBuf: Pointer; iAmt: Integer; iOfst: Int64): Integer; cdecl;
    xTruncate         : function(id: PSQLite3File; size: Int64): Integer; cdecl;
    xSync             : function(id: PSQLite3File; flags: Integer): Integer; cdecl;
    xFileSize         : function(id: PSQLite3File; var pSize: Int64): Integer; cdecl;
    xLock             : function(id: PSQLite3File; locktype: Integer): Integer; cdecl;
    xUnlock           : function(id: PSQLite3File; locktype: Integer): Integer; cdecl;
    xCheckReservedLock: function(f: PSQLite3File; var pResOut: Integer): Integer; cdecl;
    xFileControl      : function(id: PSQLite3File; op: Integer; pArg: Pointer): Integer; cdecl;
    xSectorSize       : function(id: PSQLite3File): Integer; cdecl;
    xDeviceCharacteristics: function(id: PSQLite3File): Integer; cdecl;
  end;
  Tsqlite3IOMethods   = sqlite3_io_methods;

  PSQLite3Mutex       = type Pointer;

  PSQLite3VFS         = ^Tsqlite3VFS;
  sqlite3_vfs         = record
    iVersion          : Integer;
    szOsFile          : Integer;
    mxPathname        : Integer;
    pNext             : PSQLite3VFS;
    zName             : PAnsiChar;
    pAppData          : Pointer;
    xOpen             : function(pVfs: PSQLite3VFS; const zName: PAnsiChar; id: PSQLite3File; flags: Integer; pOutFlags: PInteger): Integer; cdecl;
    xDelete           : function(pVfs: PSQLite3VFS; const zName: PAnsiChar; syncDir: Integer): Integer; cdecl;
    xAccess           : function(pVfs: PSQLite3VFS; const zName: PAnsiChar; flags: Integer; var pResOut: Integer): Integer; cdecl;
    xFullPathname     : function(pVfs: PSQLite3VFS; const zName: PAnsiChar; nOut: Integer; zOut: PAnsiChar): Integer; cdecl;
    xDlOpen           : function(pVfs: PSQLite3VFS; const zFilename: PAnsiChar): Pointer; cdecl;
    xDlError          : procedure(pVfs: PSQLite3VFS; nByte: Integer; zErrMsg: PAnsiChar); cdecl;
    xDlSym            : function(pVfs: PSQLite3VFS; pHandle: Pointer; const zSymbol: PAnsiChar): Pointer; cdecl;
    xDlClose          : procedure(pVfs: PSQLite3VFS; pHandle: Pointer); cdecl;
    xRandomness       : function(pVfs: PSQLite3VFS; nByte: Integer; zOut: PAnsiChar): Integer; cdecl;
    xSleep            : function(pVfs: PSQLite3VFS; microseconds: Integer): Integer; cdecl;
    xCurrentTime      : function(pVfs: PSQLite3VFS; var prNow: Double): Integer; cdecl;
    xGetLastError     : function(pVfs: PSQLite3VFS; nBuf: Integer; zBuf: PAnsiChar): Integer; cdecl;
  end;
  Tsqlite3VFS         = sqlite3_vfs;

  Tsq3_initialize     = function : Integer; cdecl;
  Tsq3_shutdown       = function : Integer; cdecl;
  Tsq3_os_init        = function : Integer; cdecl;
  Tsq3_os_end         = function : Integer; cdecl;

{$IFDEF SQLITE_EXPERIMENTAL}
  Tsq3_config         = function (op: Integer{; ...}): Integer; cdecl;
  Tsq3_db_config      = function (db: PSQLite3; op: Integer{; ...}): Integer; cdecl;

  sqlite3_mem_methods = record
    xMalloc           : function(nByte: Integer): Pointer; cdecl;
    xFree             : procedure(pPrior: Pointer); cdecl;
    xRealloc          : function(pPrior: Pointer; nByte: Integer): Pointer; cdecl;
    xSize             : function(pPrior: Pointer): Integer; cdecl;
    xRoundup          : function(n: Integer): Integer; cdecl;
    xInit             : function(NotUsed: Pointer): Integer; cdecl;
    xShutdown         : procedure(NotUsed: Pointer); cdecl;
    pAppData          : Pointer;
  end;
  Tsqlite3MemMethods  = sqlite3_mem_methods;

{$ENDIF}
  Tsq3_extended_result_codes = function (db: PSQLite3; onoff: Integer): Integer; cdecl;
  Tsq3_last_insert_rowid = function (db: PSQLite3): Int64; cdecl;
  Tsq3_changes        = function (db: PSQLite3): Integer; cdecl;
  Tsq3_total_changes  = function (db: PSQLite3): Integer; cdecl;
  Tsq3_interrupt      = procedure (db: PSQLite3); cdecl;
  Tsq3_complete       = function (const sql: PAnsiChar): Integer; cdecl;
  Tsq3_complete16     = function (const sql: PWideChar): Integer; cdecl;
  Tsqlite3BusyCallback = function(ptr: Pointer; count: Integer): Integer; cdecl;
  Tsq3_busy_handler   = function (db: PSQLite3; xBusy: Tsqlite3BusyCallback; pArg: Pointer): Integer; cdecl;
  Tsq3_busy_timeout   = function (db: PSQLite3; ms: Integer): Integer; cdecl;
  Tsq3_get_table      = function (db: PSQLite3; const zSql: PAnsiChar; var pazResult: PPAnsiCharArray; pnRow: PInteger; pnColumn: PInteger; pzErrmsg: PPAnsiChar): Integer; cdecl;
  Tsq3_free_table     = procedure (result: PPAnsiCharArray); cdecl;
  Tsq3_mprintf        = function (const zFormat: PAnsiChar{; ...}): PAnsiChar; cdecl;
  Tsq3_vmprintf       = function (const zFormat: PAnsiChar; ap: Pointer{va_list}): PAnsiChar; cdecl;
  Tsq3_snprintf       = function (n: Integer; zBuf: PAnsiChar; const zFormat: PAnsiChar{; ...}): PAnsiChar; cdecl;
  Tsq3_malloc         = function (n: Integer): Pointer; cdecl;
  Tsq3_realloc        = function (pOld: Pointer; n: Integer): Pointer; cdecl;
  Tsq3_free           = procedure (p: Pointer); cdecl;
  Tsq3_memory_used    = function : Int64; cdecl;
  Tsq3_memory_highwater = function (resetFlag: Integer): Int64; cdecl;
  Tsq3_randomness     = procedure (N: Integer; P: Pointer); cdecl;
  Tsqlite3AuthorizerCallback = function(pAuthArg: Pointer; code: Integer; const zTab: PAnsiChar; const zCol: PAnsiChar; const zDb: PAnsiChar; const zAuthContext: PAnsiChar): Integer; cdecl;
  Tsq3_set_authorizer = function (db: PSQLite3; xAuth: Tsqlite3AuthorizerCallback; pUserData: Pointer): Integer; cdecl;
  {$IFDEF SQLITE_EXPERIMENTAL}
  Tsqlite3TraceCallback = procedure(pTraceArg: Pointer; const zTrace: PAnsiChar); cdecl;
  Tsqlite3ProfileCallback = procedure(pProfileArg: Pointer; const zSql: PAnsiChar; elapseTime: UInt64); cdecl;
  Tsq3_trace          = function (db: PSQLite3; xTrace: Tsqlite3TraceCallback; pArg: Pointer): Pointer; cdecl;
  Tsq3_profile        = function (db: PSQLite3; xProfile: Tsqlite3ProfileCallback; pArg: Pointer): Pointer; cdecl;
  {$ENDIF}
  Tsqlite3ProgressCallback = function(pProgressArg: Pointer): Integer; cdecl;
  Tsq3_progress_handler = procedure (db: PSQLite3; nOps: Integer; xProgress: Tsqlite3ProgressCallback; pArg: Pointer); cdecl;
  Tsq3_open           = function (const filename: PAnsiChar; var ppDb: PSQLite3): Integer; cdecl;
  Tsq3_open16         = function (const filename: PWideChar; var ppDb: PSQLite3): Integer; cdecl;
  Tsq3_open_v2        = function (const filename: PAnsiChar; var ppDb: PSQLite3; flags: Integer; const zVfs: PAnsiChar): Integer; cdecl;
  Tsq3_errcode        = function (db: PSQLite3): Integer; cdecl;
  Tsq3_extended_errcode = function (db: PSQLite3): Integer; cdecl;
  Tsq3_errmsg         = function (db: PSQLite3): PAnsiChar; cdecl;
  Tsq3_errmsg16       = function (db: PSQLite3): PWideChar; cdecl;

  PSQLite3Stmt        = type Pointer;

  Tsq3_limit          = function (db: PSQLite3; limitId: Integer; newLimit: Integer): Integer; cdecl;

  Tsq3_prepare        = function (db: PSQLite3; const zSql: PAnsiChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPAnsiChar): Integer; cdecl;
  Tsq3_prepare_v2     = function (db: PSQLite3; const zSql: PAnsiChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPAnsiChar): Integer; cdecl;
  Tsq3_prepare16      = function (db: PSQLite3; const zSql: PWideChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPWideChar): Integer; cdecl;
  Tsq3_prepare16_v2   = function (db: PSQLite3; const zSql: PWideChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPWideChar): Integer; cdecl;

  Tsq3_sql            = function (pStmt: PSQLite3Stmt): PAnsiChar; cdecl;

  PSQLite3Value       = ^Tsqlite3Value;
  sqlite3_value       = type Pointer;
  Tsqlite3Value       = sqlite3_value;

  PPSQLite3ValueArray = ^TPSQLite3ValueArray;
  TPSQLite3ValueArray = array[0..MaxInt div SizeOf(PSQLite3Value) - 1] of PSQLite3Value;

  PSQLite3Context     = type Pointer;

  Tsqlite3DestructorType = procedure(p: Pointer); cdecl;

  Tsq3_bind_blob      = function (pStmt: PSQLite3Stmt; i: Integer; const zData: Pointer; n: Integer; xDel: Tsqlite3DestructorType): Integer; cdecl;
  Tsq3_bind_double    = function (pStmt: PSQLite3Stmt; i: Integer; rValue: Double): Integer; cdecl;
  Tsq3_bind_int       = function (p: PSQLite3Stmt; i: Integer; iValue: Integer): Integer; cdecl;
  Tsq3_bind_int64     = function (pStmt: PSQLite3Stmt; i: Integer; iValue: Int64): Integer; cdecl;
  Tsq3_bind_null      = function (pStmt: PSQLite3Stmt; i: Integer): Integer; cdecl;
  Tsq3_bind_text      = function (pStmt: PSQLite3Stmt; i: Integer; const zData: PAnsiChar; n: Integer; xDel: Tsqlite3DestructorType): Integer; cdecl;
  Tsq3_bind_text16    = function (pStmt: PSQLite3Stmt; i: Integer; const zData: PWideChar; nData: Integer; xDel: Tsqlite3DestructorType): Integer; cdecl;
  Tsq3_bind_value     = function (pStmt: PSQLite3Stmt; i: Integer; const pValue: PSQLite3Value): Integer; cdecl;
  Tsq3_bind_zeroblob  = function (pStmt: PSQLite3Stmt; i: Integer; n: Integer): Integer; cdecl;
  Tsq3_bind_parameter_count = function (pStmt: PSQLite3Stmt): Integer; cdecl;
  Tsq3_bind_parameter_name = function (pStmt: PSQLite3Stmt; i: Integer): PAnsiChar; cdecl;
  Tsq3_bind_parameter_index = function (pStmt: PSQLite3Stmt; const zName: PAnsiChar): Integer; cdecl;
  Tsq3_clear_bindings = function (pStmt: PSQLite3Stmt): Integer; cdecl;
  Tsq3_column_count   = function (pStmt: PSQLite3Stmt): Integer; cdecl;

  Tsq3_column_name    = function (pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
  Tsq3_column_name16  = function (pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;

  {$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
  Tsq3_column_database_name = function (pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
  Tsq3_column_database_name16 = function (pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;
  Tsq3_column_table_name = function (pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
  Tsq3_column_table_name16 = function (pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;
  Tsq3_column_origin_name = function (pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
  Tsq3_column_origin_name16 = function (pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;
  {$ENDIF}

  Tsq3_column_decltype = function (pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
  Tsq3_column_decltype16 = function (pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;

  Tsq3_step = function (pStmt: PSQLite3Stmt): Integer; cdecl;

  Tsq3_data_count = function (pStmt: PSQLite3Stmt): Integer; cdecl;


  Tsq3_column_blob = function (pStmt: PSQLite3Stmt; iCol: Integer): Pointer; cdecl;
  Tsq3_column_bytes = function (pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl;
  Tsq3_column_bytes16 = function (pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl;
  Tsq3_column_double = function (pStmt: PSQLite3Stmt; iCol: Integer): Double; cdecl;
  Tsq3_column_int = function (pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl;
  Tsq3_column_int64 = function (pStmt: PSQLite3Stmt; iCol: Integer): Int64; cdecl;
  Tsq3_column_text = function (pStmt: PSQLite3Stmt; iCol: Integer): PAnsiChar; cdecl;
  Tsq3_column_text16 = function (pStmt: PSQLite3Stmt; iCol: Integer): PWideChar; cdecl;
  Tsq3_column_type = function (pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl;
  Tsq3_column_value = function (pStmt: PSQLite3Stmt; iCol: Integer): PSQLite3Value; cdecl;

  Tsq3_finalize = function (pStmt: PSQLite3Stmt): Integer; cdecl;

  Tsq3_reset = function (pStmt: PSQLite3Stmt): Integer; cdecl;

  Tsqlite3RegularFunction = procedure(ctx: PSQLite3Context; n: Integer; apVal: PPSQLite3ValueArray); cdecl;
  Tsqlite3AggregateStep = procedure(ctx: PSQLite3Context; n: Integer; apVal: PPSQLite3ValueArray); cdecl;
  Tsqlite3AggregateFinalize = procedure(ctx: PSQLite3Context); cdecl;

  Tsq3_create_function = function (db: PSQLite3; const zFunctionName: PAnsiChar; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: Tsqlite3RegularFunction; xStep: Tsqlite3AggregateStep; xFinal: Tsqlite3AggregateFinalize): Integer; cdecl;
  Tsq3_create_function16 = function (db: PSQLite3; const zFunctionName: PWideChar; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: Tsqlite3RegularFunction; xStep: Tsqlite3AggregateStep; xFinal: Tsqlite3AggregateFinalize): Integer; cdecl;

  {$IFDEF SQLITE_DEPRECATED}
  Tsqlite3MemoryAlarmCallback = procedure(pArg: Pointer; used: Int64; N: Integer); cdecl;

  Tsq3_aggregate_count = function (p: PSQLite3Context): Integer; cdecl;
  Tsq3_expired = function (pStmt: PSQLite3Stmt): Integer; cdecl;
  Tsq3_transfer_bindings = function (pFromStmt: PSQLite3Stmt; pToStmt: PSQLite3Stmt): Integer; cdecl;
  Tsq3_global_recover = function : Integer; cdecl;
  Tsq3_thread_cleanup = procedure ; cdecl;
  Tsq3_memory_alarm = function (xCallback: Tsqlite3MemoryAlarmCallback; pArg: Pointer; iThreshold: Int64): Integer; cdecl;
  {$ENDIF}

  Tsq3_value_blob = function (pVal: PSQLite3Value): Pointer; cdecl;
  Tsq3_value_bytes = function (pVal: PSQLite3Value): Integer; cdecl;
  Tsq3_value_bytes16 = function (pVal: PSQLite3Value): Integer; cdecl;
  Tsq3_value_double = function (pVal: PSQLite3Value): Double; cdecl;
  Tsq3_value_int = function (pVal: PSQLite3Value): Integer; cdecl;
  Tsq3_value_int64 = function (pVal: PSQLite3Value): Int64; cdecl;
  Tsq3_value_text = function (pVal: PSQLite3Value): PAnsiChar; cdecl;
  Tsq3_value_text16 = function (pVal: PSQLite3Value): PWideChar; cdecl;
  Tsq3_value_text16le = function (pVal: PSQLite3Value): Pointer; cdecl;
  Tsq3_value_text16be = function (pVal: PSQLite3Value): Pointer; cdecl;
  Tsq3_value_type = function (pVal: PSQLite3Value): Integer; cdecl;
  Tsq3_value_numeric_type = function (pVal: PSQLite3Value): Integer; cdecl;

  Tsq3_aggregate_context = function (p: PSQLite3Context; nBytes: Integer): Pointer; cdecl;

  Tsq3_user_data = function (p: PSQLite3Context): Pointer; cdecl;

  Tsq3_context_db_handle = function (p: PSQLite3Context): PSQLite3; cdecl;

  Tsqlite3AuxDataDestructor = procedure(pAux: Pointer); cdecl;

  Tsq3_get_auxdata = function (pCtx: PSQLite3Context; N: Integer): Pointer; cdecl;
  Tsq3_set_auxdata = procedure (pCtx: PSQLite3Context; N: Integer; pAux: Pointer; xDelete: Tsqlite3AuxDataDestructor); cdecl;

  Tsq3_result_blob = procedure (pCtx: PSQLite3Context; const z: Pointer; n: Integer; xDel: Tsqlite3DestructorType); cdecl;
  Tsq3_result_double = procedure (pCtx: PSQLite3Context; rVal: Double); cdecl;
  Tsq3_result_error = procedure (pCtx: PSQLite3Context; const z: PAnsiChar; n: Integer); cdecl;
  Tsq3_result_error16 = procedure (pCtx: PSQLite3Context; const z: PWideChar; n: Integer); cdecl;
  Tsq3_result_error_toobig = procedure (pCtx: PSQLite3Context); cdecl;
  Tsq3_result_error_nomem = procedure (pCtx: PSQLite3Context); cdecl;
  Tsq3_result_error_code = procedure (pCtx: PSQLite3Context; errCode: Integer); cdecl;Tsq3_result_int = procedure (pCtx: PSQLite3Context; iVal: Integer); cdecl;
  Tsq3_result_int64 = procedure (pCtx: PSQLite3Context; iVal: Int64); cdecl;
  Tsq3_result_null = procedure (pCtx: PSQLite3Context); cdecl;
  Tsq3_result_text = procedure (pCtx: PSQLite3Context; const z: PAnsiChar; n: Integer; xDel: Tsqlite3DestructorType); cdecl;
  Tsq3_result_text16 = procedure (pCtx: PSQLite3Context; const z: PWideChar; n: Integer; xDel: Tsqlite3DestructorType); cdecl;
  Tsq3_result_text16le = procedure (pCtx: PSQLite3Context; const z: Pointer; n: Integer; xDel: Tsqlite3DestructorType); cdecl;
  Tsq3_result_text16be = procedure (pCtx: PSQLite3Context; const z: Pointer; n: Integer; xDel: Tsqlite3DestructorType); cdecl;
  Tsq3_result_value = procedure (pCtx: PSQLite3Context; pValue: PSQLite3Value); cdecl;
  Tsq3_result_zeroblob = procedure (pCtx: PSQLite3Context; n: Integer); cdecl;

  Tsqlite3CollationCompare = procedure(pUser: Pointer; n1: Integer; const z1: Pointer; n2: Integer; const z2: Pointer); cdecl;
  Tsqlite3CollationDestructor = procedure(pUser: Pointer); cdecl;

  Tsq3_create_collation = function (db: PSQLite3; const zName: PAnsiChar; eTextRep: Integer; pUser: Pointer; xCompare: Tsqlite3CollationCompare): Integer; cdecl;
  Tsq3_create_collation_v2 = function (db: PSQLite3; const zName: PAnsiChar; eTextRep: Integer; pUser: Pointer; xCompare: Tsqlite3CollationCompare; xDestroy: Tsqlite3CollationDestructor): Integer; cdecl;
  Tsq3_create_collation16 = function (db: PSQLite3; const zName: PWideChar; eTextRep: Integer; pUser: Pointer; xCompare: Tsqlite3CollationCompare): Integer; cdecl;

  Tsqlite3CollationNeededCallback = procedure(pCollNeededArg: Pointer; db: PSQLite3; eTextRep: Integer; const zExternal: PAnsiChar); cdecl;
  Tsqlite3CollationNeededCallback16 = procedure(pCollNeededArg: Pointer; db: PSQLite3; eTextRep: Integer; const zExternal: PWideChar); cdecl;

  Tsq3_collation_needed = function (db: PSQLite3; pCollNeededArg: Pointer; xCollNeeded: Tsqlite3CollationNeededCallback): Integer; cdecl;
  Tsq3_collation_needed16 = function (db: PSQLite3; pCollNeededArg: Pointer; xCollNeeded16: Tsqlite3CollationNeededCallback16): Integer; cdecl;

  //function sqlite3_key(db: PSQLite3; const pKey: Pointer; nKey: Integer): Integer; cdecl; 

  //function sqlite3_rekey(db: PSQLite3; const pKey: Pointer; nKey: Integer): Integer; cdecl; 

  Tsq3_sleep = function (ms: Integer): Integer; cdecl;

  //var sqlite3_temp_directory: PAnsiChar;

  Tsq3_get_autocommit = function (db: PSQLite3): Integer; cdecl;

  Tsq3_db_handle = function (pStmt: PSQLite3Stmt): PSQLite3; cdecl;

  Tsq3_next_stmt = function (pDb: PSQLite3; pStmt: PSQLite3Stmt): PSQLite3Stmt; cdecl;

  Tsqlite3CommitCallback = function(pCommitArg: Pointer): Integer; cdecl;
  Tsqlite3RollbackCallback = procedure(pRollbackArg: Pointer); cdecl;

  Tsq3_commit_hook = function (db: PSQLite3; xCallback: Tsqlite3CommitCallback; pArg: Pointer): Pointer; cdecl;
  Tsq3_rollback_hook = function (db: PSQLite3; xCallback: Tsqlite3RollbackCallback; pArg: Pointer): Pointer; cdecl;

  Tsqlite3UpdateCallback = procedure(pUpdateArg: Pointer; op: Integer; const zDb: PAnsiChar; const zTbl: PAnsiChar; iKey: Int64); cdecl;

  Tsq3_update_hook = function (db: PSQLite3; xCallback: Tsqlite3UpdateCallback; pArg: Pointer): Pointer; cdecl;

  Tsq3_enable_shared_cache = function (enable: Integer): Integer; cdecl;

  Tsq3_release_memory = function (n: Integer): Integer; cdecl;

  Tsq3_soft_heap_limit = procedure (n: Integer); cdecl;

  {$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
  Tsq3_table_column_metadata = function (db: PSQLite3; const zDbName: PAnsiChar; const zTableName: PAnsiChar; const zColumnName: PAnsiChar; const pzDataType: PPAnsiChar; const pzCollSeq: PPAnsiChar; pNotNull: PInteger; pPrimaryKey: PInteger; pAutoinc: PInteger): Integer; cdecl;
  {$ENDIF}

  Tsq3_load_extension = function (db: PSQLite3; const zFile: PAnsiChar; const zProc: PAnsiChar; pzErrMsg: PPAnsiChar): Integer; cdecl;

  Tsq3_enable_load_extension = function (db: PSQLite3; onoff: Integer): Integer; cdecl;

  TSQLiteAutoExtensionEntryPoint = procedure; cdecl;

  Tsq3_auto_extension = function (xEntryPoint: TSQLiteAutoExtensionEntryPoint): Integer; cdecl;

  Tsq3_reset_auto_extension = procedure ; cdecl;

  {$IFDEF SQLITE_EXPERIMENTAL}
  Tsqlite3FTS3Func = procedure(pContext: PSQLite3Context; argc: Integer; argv: PPSQLite3ValueArray); cdecl;

  PSQLite3VTab = ^Tsqlite3VTab;
  PSQLite3IndexInfo = ^Tsqlite3IndexInfo;
  PSQLite3VTabCursor = ^Tsqlite3VTabCursor;
  PSQLite3Module = ^Tsqlite3Module;

  sqlite3_module = record
    iVersion: Integer;
    xCreate: function(db: PSQLite3; pAux: Pointer; argc: Integer; const argv: PPAnsiCharArray; var ppVTab: PSQLite3VTab; var pzErr: PAnsiChar): Integer; cdecl;
    xConnect: function(db: PSQLite3; pAux: Pointer; argc: Integer; const argv: PPAnsiCharArray; var ppVTab: PSQLite3VTab; var pzErr: PAnsiChar): Integer; cdecl;
    xBestIndex: function(pVTab: PSQLite3VTab; pInfo: PSQLite3IndexInfo): Integer; cdecl;
    xDisconnect: function(pVTab: PSQLite3VTab): Integer; cdecl;
    xDestroy: function(pVTab: PSQLite3VTab): Integer; cdecl;
    xOpen: function(pVTab: PSQLite3VTab; var ppCursor: PSQLite3VTabCursor): Integer; cdecl;
    xClose: function(pVtabCursor: PSQLite3VTabCursor): Integer; cdecl;
    xFilter: function(pVtabCursor: PSQLite3VTabCursor; idxNum: Integer; const idxStr: PAnsiChar; argc: Integer; argv: PPSQLite3ValueArray): Integer; cdecl;
    xNext: function(pVtabCursor: PSQLite3VTabCursor): Integer; cdecl;
    xEof: function(pVtabCursor: PSQLite3VTabCursor): Integer; cdecl;
    xColumn: function(pVtabCursor: PSQLite3VTabCursor; sContext: PSQLite3Context; p2: Integer): Integer; cdecl;
    xRowid: function(pVtabCursor: PSQLite3VTabCursor; var pRowid: Int64): Integer; cdecl;
    xUpdate: function(pVtab: PSQLite3VTab; nArg: Integer; ppArg: PPSQLite3ValueArray; var pRowid: Int64): Integer; cdecl;
    xBegin: function(pVTab: PSQLite3VTab): Integer; cdecl;
    xSync: function(pVTab: PSQLite3VTab): Integer; cdecl;
    xCommit: function(pVTab: PSQLite3VTab): Integer; cdecl;
    xRollback: function(pVTab: PSQLite3VTab): Integer; cdecl;
    xFindFunction: function(pVtab: PSQLite3VTab; nArg: Integer; const zName: PAnsiChar; var pxFunc: Tsqlite3FTS3Func; var ppArg: Pointer): Integer; cdecl;
    xRename: function(pVtab: PSQLite3VTab; const zNew: PAnsiChar): Integer; cdecl;
  end;
  Tsqlite3Module = sqlite3_module;

  sqlite3_index_constraint = record
    iColumn: Integer;
    op: Byte;
    usable: Byte;
    iTermOffset: Integer;
  end;
  Tsqlite3IndexConstraint = sqlite3_index_constraint;

  PSQLite3IndexConstraintArray = ^Tsqlite3IndexConstraintArray;
  Tsqlite3IndexConstraintArray = array[0..MaxInt div SizeOf(Tsqlite3IndexConstraint) - 1] of Tsqlite3IndexConstraint;

  sqlite3_index_orderby = record
    iColumn: Integer;
    desc: Byte;
  end;
  Tsqlite3IndexOrderBy = sqlite3_index_orderby;

  PSQLite3IndexOrderByArray = ^Tsqlite3IndexOrderByArray;
  Tsqlite3IndexOrderByArray = array[0..MaxInt div SizeOf(Tsqlite3IndexOrderBy) - 1] of Tsqlite3IndexOrderBy;

  sqlite3_index_constraint_usage = record
    argvIndex: Integer;
    omit: Byte;
  end;
  Tsqlite3IndexConstraintUsage = sqlite3_index_constraint_usage;

  PSQLite3IndexConstraintUsageArray = ^Tsqlite3IndexConstraintUsageArray;
  Tsqlite3IndexConstraintUsageArray = array[0..MaxInt div SizeOf(Tsqlite3IndexConstraintUsage) - 1] of Tsqlite3IndexConstraintUsage;

  sqlite3_index_info = record
    nConstraint: Integer;
    aConstraint: PSQLite3IndexConstraintArray;
    nOrderBy: Integer;
    aOrderBy: PSQLite3IndexOrderByArray;
    aConstraintUsage: PSQLite3IndexConstraintUsageArray;
    idxNum: Integer;
    idxStr: PAnsiChar;
    needToFreeIdxStr: Integer;
    orderByConsumed: Integer;
    estimatedCost: Double;
  end;
  Tsqlite3IndexInfo = sqlite3_index_info;

  sqlite3_vtab = record
    pModule: PSQLite3Module;
    nRef: Integer;
    zErrMsg: PAnsiChar;
  end;
  Tsqlite3VTab = sqlite3_vtab;

  sqlite3_vtab_cursor = record
    pVtab: PSQLite3VTab;
  end;
  Tsqlite3VTabCursor = sqlite3_vtab_cursor;

  Tsq3_create_module = function (db: PSQLite3; const zName: PAnsiChar; const p: PSQLite3Module; pClientData: Pointer): Integer; cdecl;

  Tsqlite3ModuleDestructor = procedure(pAux: Pointer); cdecl;

  Tsq3_create_module_v2 = function (db: PSQLite3; const zName: PAnsiChar; const p: PSQLite3Module; pClientData: Pointer; xDestroy: Tsqlite3ModuleDestructor): Integer; cdecl;

  Tsq3_declare_vtab = function (db: PSQLite3; const zSQL: PAnsiChar): Integer; cdecl;

  Tsq3_overload_function = function (db: PSQLite3; const zFuncName: PAnsiChar; nArg: Integer): Integer; cdecl;
  {$ENDIF}

  PSQLite3BlobData = type Pointer;

  Tsq3_blob_open = function (db: PSQLite3; const zDb: PAnsiChar; const zTable: PAnsiChar;
    const zColumn: PAnsiChar; iRow: Int64; flags: Integer;
    var ppBlob: PSQLite3BlobData): Integer; cdecl;

  Tsq3_blob_close = function (pBlob: PSQLite3BlobData): Integer; cdecl;
  Tsq3_blob_bytes = function (pBlob: PSQLite3BlobData): Integer; cdecl;
  Tsq3_blob_read = function (pBlob: PSQLite3BlobData; Z: Pointer; N: Integer; iOffset: Integer): Integer; cdecl;
  Tsq3_blob_write = function (pBlob: PSQLite3BlobData; const z: Pointer; n: Integer; iOffset: Integer): Integer; cdecl;
  Tsq3_vfs_find = function (const zVfsName: PAnsiChar): PSQLite3VFS; cdecl;
  Tsq3_vfs_register = function (pVfs: PSQLite3VFS; makeDflt: Integer): Integer; cdecl;
  Tsq3_vfs_unregister = function (pVfs: PSQLite3VFS): Integer; cdecl;
  Tsq3_mutex_alloc = function (id: Integer): PSQLite3Mutex; cdecl;
  Tsq3_mutex_free = procedure (p: PSQLite3Mutex); cdecl;
  Tsq3_mutex_enter = procedure (p: PSQLite3Mutex); cdecl;
  Tsq3_mutex_try = function (p: PSQLite3Mutex): Integer; cdecl;
  Tsq3_mutex_leave = procedure (p: PSQLite3Mutex); cdecl;

{$IFDEF SQLITE_EXPERIMENTAL}
  sqlite3_mutex_methods = record
    xMutexInit: function: Integer; cdecl;
    xMutexEnd: function: Integer; cdecl;
    xMutexAlloc: function(id: Integer): PSQLite3Mutex; cdecl;
    xMutexFree: procedure(p: PSQLite3Mutex); cdecl;
    xMutexEnter: procedure(p: PSQLite3Mutex); cdecl;
    xMutexTry: function(p: PSQLite3Mutex): Integer; cdecl;
    xMutexLeave: procedure(p: PSQLite3Mutex); cdecl;
    xMutexHeld: function(p: PSQLite3Mutex): Integer; cdecl;
    xMutexNotheld: function(p: PSQLite3Mutex): Integer; cdecl;
  end;
  Tsqlite3MutexMethods = sqlite3_mutex_methods;
  {$ENDIF}

  {$IFDEF SQLITE_DEBUG}
  Tsq3_mutex_held = function (p: PSQLite3Mutex): Integer; cdecl;
  Tsq3_mutex_notheld = function (p: PSQLite3Mutex): Integer; cdecl;
  {$ENDIF}

  Tsq3_db_mutex = function (db: PSQLite3): PSQLite3Mutex; cdecl;

  Tsq3_file_control = function (db: PSQLite3; const zDbName: PAnsiChar; op: Integer; pArg: Pointer): Integer; cdecl;

  Tsq3_test_control = function (op: Integer{; ...}): Integer; cdecl;

  {$IFDEF SQLITE_EXPERIMENTAL}
  Tsq3_status = function (op: Integer; var pCurrent: Integer; var pHighwater: Integer; resetFlag: Integer): Integer; cdecl;

  Tsq3_db_status = function (db: PSQLite3; op: Integer; var pCur: Integer; var pHiwtr: Integer; resetFlg: Integer): Integer; cdecl;

  Tsq3_stmt_status = function (pStmt: PSQLite3Stmt; op: Integer; resetFlg: Integer): Integer; cdecl;

  PSQLite3PCache = type Pointer;

  sqlite3_pcache_methods = record
    pArg      : Pointer;
    xInit     : function(pArg: Pointer): Integer; cdecl;
    xShutdown : procedure(pArg: Pointer); cdecl;
    xCreate   : function(szPage: Integer; bPurgeable: Integer): PSQLite3PCache; cdecl;
    xCachesize: procedure(pCache: PSQLite3PCache; nCachesize: Integer); cdecl;
    xPagecount: function(pCache: PSQLite3PCache): Integer; cdecl;
    xFetch    : function(pCache: PSQLite3PCache; key: Cardinal; createFlag: Integer): Pointer; cdecl;
    xUnpin    : procedure(pCache: PSQLite3PCache; pPg: Pointer; discard: Integer); cdecl;
    xRekey    : procedure(pCache: PSQLite3PCache; pPg: Pointer; oldKey: Cardinal; newKey: Cardinal); cdecl;
    xTruncate : procedure(pCache: PSQLite3PCache; iLimit: Cardinal); cdecl;
    xDestroy  : procedure(pCache: PSQLite3PCache); cdecl;
  end;
  Tsqlite3PCacheMethods = sqlite3_pcache_methods;

  PSQLite3Backup = type Pointer;

  Tsq3_backup_init = function (pDest: PSQLite3; const zDestName: PAnsiChar; pSource: PSQLite3; const zSourceName: PAnsiChar): PSQLite3Backup; cdecl;
  Tsq3_backup_step = function (p: PSQLite3Backup; nPage: Integer): Integer; cdecl;
  Tsq3_backup_finish = function (p: PSQLite3Backup): Integer; cdecl;
  Tsq3_backup_remaining = function (p: PSQLite3Backup): Integer; cdecl;
  Tsq3_backup_pagecount = function (p: PSQLite3Backup): Integer; cdecl; 

  {$IFDEF SQLITE_ENABLE_UNLOCK_NOTIFY}
  Tsqlite3UnlockNotifyCallback = procedure(apArg: PPointerArray; nArg: Integer); cdecl;

  Tsq3_unlock_notify = function (pBlocked: PSQLite3; xNotify: Tsqlite3UnlockNotifyCallback; pNotifyArg: Pointer): Integer; cdecl;
  {$ENDIF}

  Tsq3_strnicmp = function (const zLeft: PAnsiChar; const zRight: PAnsiChar; N: Integer): Integer; cdecl;
  {$ENDIF}

//function sqlite3_win32_mbcs_to_utf8(const S: PAnsiChar): PAnsiChar; cdecl; 
            
type
  PSqlite3Module      = ^TSqlite3Module;
  TSqlite3Module      = record
    Handle            : HModule;   
//    RollBackStr       : string; //PStr; // 'ROLLBACK;'
//    BeginTransStr     : string; //PStr; // 'BEGIN TRANSACTION;'
//    CommitStr         : string; //PStr; // 'COMMIT;'
    libversion        : Tsq3_libversion;
    sourceid          : Tsq3_sourceid;

    libversion_number : Tsq3_libversion_number;
    threadsafe        : Tsq3_threadsafe;
    close             : Tsq3_close;
    exec              : Tsq3_exec;
    initialize        : Tsq3_initialize;
    shutdown          : Tsq3_shutdown;
    os_init           : Tsq3_os_init;
    os_end            : Tsq3_os_end;
    {$IFDEF SQLITE_EXPERIMENTAL}
    config            : Tsq3_config;
    db_config         : Tsq3_db_config;
    {$ENDIF}
    extended_result_codes: Tsq3_extended_result_codes;
    last_insert_rowid : Tsq3_last_insert_rowid;
    changes           : Tsq3_changes;
    total_changes     : Tsq3_total_changes;
    interrupt         : Tsq3_interrupt;
    complete          : Tsq3_complete;
    complete16        : Tsq3_complete16;
    busy_handler      : Tsq3_busy_handler;
    busy_timeout      : Tsq3_busy_timeout;
    get_table         : Tsq3_get_table;
    free_table        : Tsq3_free_table;
    mprintf           : Tsq3_mprintf;
    vmprintf          : Tsq3_vmprintf;
    snprintf          : Tsq3_snprintf;
    malloc            : Tsq3_malloc;
    realloc           : Tsq3_realloc;
    free              : Tsq3_free;
    memory_used       : Tsq3_memory_used;
    memory_highwater  : Tsq3_memory_highwater;
    randomness        : Tsq3_randomness;
    set_authorizer    : Tsq3_set_authorizer;
    {$IFDEF SQLITE_EXPERIMENTAL}
    trace             : Tsq3_trace;
    profile           : Tsq3_profile;
    {$ENDIF}
    progress_handler  : Tsq3_progress_handler;
    open              : Tsq3_open;
    open16            : Tsq3_open16;
    open_v2           : Tsq3_open_v2;
    errcode           : Tsq3_errcode;
    extended_errcode  : Tsq3_extended_errcode;
    errmsg            : Tsq3_errmsg;
    errmsg16          : Tsq3_errmsg16;
    limit             : Tsq3_limit;

    prepare           : Tsq3_prepare;
    prepare_v2        : Tsq3_prepare_v2;
    prepare16         : Tsq3_prepare16;
    prepare16_v2      : Tsq3_prepare16_v2;

    sql               : Tsq3_sql;

    bind_blob         : Tsq3_bind_blob;
    bind_double       : Tsq3_bind_double;
    bind_int          : Tsq3_bind_int;
    bind_int64        : Tsq3_bind_int64;
    bind_null         : Tsq3_bind_null;
    bind_text         : Tsq3_bind_text;
    bind_text16       : Tsq3_bind_text16;
    bind_value        : Tsq3_bind_value;
    bind_zeroblob     : Tsq3_bind_zeroblob;

    bind_param_count  : Tsq3_bind_parameter_count;

    bind_param_name   : Tsq3_bind_parameter_name;

    bind_param_index  : Tsq3_bind_parameter_index;

    clear_bindings    : Tsq3_clear_bindings;

    column_count      : Tsq3_column_count;

    column_name       : Tsq3_column_name;
    column_name16     : Tsq3_column_name16;

    {$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
    column_db_name    : Tsq3_column_database_name;
    column_db_name16  : Tsq3_column_database_name16;
    column_table_name : Tsq3_column_table_name;
    column_table_name16: Tsq3_column_table_name16;
    column_origin_name: Tsq3_column_origin_name;
    column_origin_name16: Tsq3_column_origin_name16;
    {$ENDIF}

    column_decltype   : Tsq3_column_decltype;
    column_decltype16 : Tsq3_column_decltype16;

    step              : Tsq3_step;

    data_count        : Tsq3_data_count;

    column_blob       : Tsq3_column_blob;
    column_bytes      : Tsq3_column_bytes;
    column_bytes16    : Tsq3_column_bytes16;
    column_double     : Tsq3_column_double;
    column_int        : Tsq3_column_int;
    column_int64      : Tsq3_column_int64;
    column_text       : Tsq3_column_text;
    column_text16     : Tsq3_column_text16;
    column_type       : Tsq3_column_type;
    column_value      : Tsq3_column_value;

    finalize          : Tsq3_finalize;

    reset             : Tsq3_reset;

    create_function   : Tsq3_create_function;
    create_function16 : Tsq3_create_function16;

    {$IFDEF SQLITE_DEPRECATED}
    aggregate_count   : Tsq3_aggregate_count;
    expired           : Tsq3_expired;
    transfer_bindings : Tsq3_transfer_bindings;
    global_recover    : Tsq3_global_recover;
    thread_cleanup    : Tsq3_thread_cleanup;
    memory_alarm      : Tsq3_memory_alarm;
    {$ENDIF}

    value_blob        : Tsq3_value_blob;
    value_bytes       : Tsq3_value_bytes;
    value_bytes16     : Tsq3_value_bytes16;
    value_double      : Tsq3_value_double;
    value_int         : Tsq3_value_int;
    value_int64       : Tsq3_value_int64;
    value_text        : Tsq3_value_text;
    value_text16      : Tsq3_value_text16;
    value_text16le    : Tsq3_value_text16le;
    value_text16be    : Tsq3_value_text16be;
    value_type        : Tsq3_value_type;
    value_numeric_type: Tsq3_value_numeric_type;

    aggregate_context : Tsq3_aggregate_context;

    user_data         : Tsq3_user_data;

    context_db_handle : Tsq3_context_db_handle;

    get_auxdata       : Tsq3_get_auxdata;
    set_auxdata       : Tsq3_set_auxdata;

    result_blob       : Tsq3_result_blob;
    result_double     : Tsq3_result_double;
    result_error      : Tsq3_result_error;
    result_error16    : Tsq3_result_error16;
    result_error_toobig: Tsq3_result_error_toobig;
    result_error_nomem: Tsq3_result_error_nomem;
    result_error_code : Tsq3_result_error_code;
    result_int        : Tsq3_result_int;
    result_int64      : Tsq3_result_int64;
    result_null       : Tsq3_result_null;
    result_text       : Tsq3_result_text;
    result_text16     : Tsq3_result_text16;
    result_text16le   : Tsq3_result_text16le;
    result_text16be   : Tsq3_result_text16be;
    result_value      : Tsq3_result_value;
    result_zeroblob   : Tsq3_result_zeroblob;

    create_collation  : Tsq3_create_collation;
    create_collation_v2: Tsq3_create_collation_v2;
    create_collation16: Tsq3_create_collation16;

    collation_needed  : Tsq3_collation_needed;
    collation_needed16: Tsq3_collation_needed16;

    sleep             : Tsq3_sleep;

    //var temp_directory: PAnsiChar;

    get_autocommit    : Tsq3_get_autocommit;

    db_handle         : Tsq3_db_handle;

    next_stmt         : Tsq3_next_stmt;

    commit_hook       : Tsq3_commit_hook;
    rollback_hook     : Tsq3_rollback_hook;

    update_hook       : Tsq3_update_hook;

    enable_shared_cache: Tsq3_enable_shared_cache;

    release_memory    : Tsq3_release_memory;

    soft_heap_limit   : Tsq3_soft_heap_limit;

    {$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
    table_column_metadata: Tsq3_table_column_metadata;
    {$ENDIF}

    load_extension    : Tsq3_load_extension;

    enable_load_extension: Tsq3_enable_load_extension;

    auto_extension    : Tsq3_auto_extension;

    reset_auto_extension: Tsq3_reset_auto_extension;

    {$IFDEF SQLITE_EXPERIMENTAL}
    create_module     : Tsq3_create_module;

    create_module_v2  : Tsq3_create_module_v2;
    declare_vtab      : Tsq3_declare_vtab;

    overload_function : Tsq3_overload_function;
    {$ENDIF}

    blob_open         : Tsq3_blob_open;
    blob_close        : Tsq3_blob_close;
    blob_bytes        : Tsq3_blob_bytes;
    blob_read         : Tsq3_blob_read;
    blob_write        : Tsq3_blob_write;

    vfs_find          : Tsq3_vfs_find;
    vfs_register      : Tsq3_vfs_register;
    vfs_unregister    : Tsq3_vfs_unregister;

    mutex_alloc       : Tsq3_mutex_alloc;
    mutex_free        : Tsq3_mutex_free;
    mutex_enter       : Tsq3_mutex_enter;
    mutex_try         : Tsq3_mutex_try;
    mutex_leave       : Tsq3_mutex_leave;

    {$IFDEF SQLITE_DEBUG}
    mutex_held        : Tsq3_mutex_held;
    mutex_notheld     : Tsq3_mutex_notheld;
    {$ENDIF}

    db_mutex          : Tsq3_db_mutex;
    file_control      : Tsq3_file_control;

    test_control      : Tsq3_test_control;

    {$IFDEF SQLITE_EXPERIMENTAL}
    status            : Tsq3_status;
    db_status         : Tsq3_db_status;
    stmt_status       : Tsq3_stmt_status;
    backup_init       : Tsq3_backup_init;
    backup_step       : Tsq3_backup_step;
    backup_finish     : Tsq3_backup_finish;
    backup_remaining  : Tsq3_backup_remaining;
    backup_pagecount  : Tsq3_backup_pagecount;
    {$IFDEF SQLITE_ENABLE_UNLOCK_NOTIFY}
    unlock_notify     : Tsq3_unlock_notify;
    {$ENDIF}
    strnicmp          : Tsq3_strnicmp;
    {$ENDIF}
  end;
                      
  function InitSqliteModule(ASqlite3: PSqlite3Module): Boolean;

implementation

uses
  dll_kernel;
  
function InitSqliteModule(ASqlite3: PSqlite3Module): Boolean;
begin
  Result := false;
  if ASqlite3^.Handle = 0 then
    exit;                                  
//  ASqlite3^.RollBackStr := 'ROLLBACK;';//CheckOutStr();
//  ASqlite3^.CommitStr := 'COMMIT;';
//  ASqlite3^.BeginTransStr := 'BEGIN TRANSACTION;';
  ASqlite3^.libversion := GetProcAddress(ASqlite3^.Handle, 'sqlite3_libversion');
  ASqlite3^.sourceid:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_sourceid');
  ASqlite3^.libversion_number:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_libversion_number');
  ASqlite3^.threadsafe:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_threadsafe');
  ASqlite3^.close:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_close');
  ASqlite3^.exec:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_exec');
  ASqlite3^.initialize:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_initialize');
  ASqlite3^.shutdown:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_shutdown');
  ASqlite3^.os_init:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_os_init');
  ASqlite3^.os_end:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_os_end');
  {$IFDEF SQLITE_EXPERIMENTAL}
  ASqlite3^.config:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_config');
  ASqlite3^.db_config:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_db_config');
  {$ENDIF}
  ASqlite3^.extended_result_codes:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_extended_result_codes');
  ASqlite3^.last_insert_rowid:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_last_insert_rowid');
  ASqlite3^.changes:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_changes');
  ASqlite3^.total_changes:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_total_changes');
  ASqlite3^.interrupt:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_interrupt');
  ASqlite3^.complete:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_complete');
  ASqlite3^.complete16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_complete16');
  ASqlite3^.busy_handler:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_busy_handler');
  ASqlite3^.busy_timeout:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_busy_timeout');
  ASqlite3^.get_table:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_get_table');
  ASqlite3^.free_table:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_free_table');
  ASqlite3^.mprintf:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_mprintf');
  ASqlite3^.vmprintf:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_vmprintf');
  ASqlite3^.snprintf:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_snprintf');
  ASqlite3^.malloc:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_malloc');
  ASqlite3^.realloc:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_realloc');
  ASqlite3^.free:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_free');
  ASqlite3^.memory_used:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_memory_used');
  ASqlite3^.memory_highwater:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_memory_highwater');
  ASqlite3^.randomness:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_randomness');
  ASqlite3^.set_authorizer:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_set_authorizer');
  {$IFDEF SQLITE_EXPERIMENTAL}
  ASqlite3^.trace:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_trace');
  ASqlite3^.profile:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_profile');
  {$ENDIF}
  ASqlite3^.progress_handler:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_progress_handler');
  ASqlite3^.open:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_open');
  ASqlite3^.open16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_open16');
  ASqlite3^.open_v2:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_open_v2');

  ASqlite3^.errcode:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_errcode');
  ASqlite3^.extended_errcode:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_extended_errcode');
  ASqlite3^.errmsg:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_errmsg');
  ASqlite3^.errmsg16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_errmsg16');
  ASqlite3^.limit:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_limit');
  ASqlite3^.prepare:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_prepare');
  ASqlite3^.prepare_v2:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_prepare_v2');
  ASqlite3^.prepare16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_prepare16');
  ASqlite3^.prepare16_v2:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_prepare16_v2');
  ASqlite3^.sql:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_sql');
  ASqlite3^.bind_blob:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_blob');
  ASqlite3^.bind_double:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_double');
  ASqlite3^.bind_int:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_int');
  ASqlite3^.bind_int64:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_int64');
  ASqlite3^.bind_null:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_null');
  ASqlite3^.bind_text:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_text');
  ASqlite3^.bind_text16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_text16');
  ASqlite3^.bind_value:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_value');
  ASqlite3^.bind_zeroblob:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_zeroblob');
  ASqlite3^.bind_param_count:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_parameter_count');
  ASqlite3^.bind_param_name:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_parameter_name');
  ASqlite3^.bind_param_index:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_bind_parameter_index');
  ASqlite3^.clear_bindings:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_clear_bindings');
  ASqlite3^.column_count:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_count');
  ASqlite3^.column_name:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_name');
  ASqlite3^.column_name16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_name16');

  {$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
  ASqlite3^.column_db_name:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_database_name');
  ASqlite3^.column_db_name16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_database_name16');
  ASqlite3^.column_table_name:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_table_name');
  ASqlite3^.column_table_name16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_table_name16');
  ASqlite3^.column_origin_name:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_origin_name');
  ASqlite3^.column_origin_name16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_origin_name16');
  {$ENDIF}

  ASqlite3^.column_decltype:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_decltype');
  ASqlite3^.column_decltype16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_decltype16');

  ASqlite3^.step:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_step');

  ASqlite3^.data_count:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_data_count');

  ASqlite3^.column_blob:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_blob');
  ASqlite3^.column_bytes:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_bytes');
  ASqlite3^.column_bytes16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_bytes16');
  ASqlite3^.column_double:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_double');
  ASqlite3^.column_int:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_int');
  ASqlite3^.column_int64:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_int64');
  ASqlite3^.column_text:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_text');
  ASqlite3^.column_text16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_text16');
  ASqlite3^.column_type:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_type');
  ASqlite3^.column_value:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_column_value');

  ASqlite3^.finalize:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_finalize');

  ASqlite3^.reset:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_reset');
                             
  ASqlite3^.create_function:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_create_function');
  ASqlite3^.create_function16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_create_function16');

  {$IFDEF SQLITE_DEPRECATED}
  ASqlite3^.aggregate_count:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_aggregate_count');
  ASqlite3^.expired:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_expired');
  ASqlite3^.transfer_bindings:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_transfer_bindings');
  ASqlite3^.global_recover:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_global_recover');
  ASqlite3^.thread_cleanup:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_thread_cleanup');
  ASqlite3^.memory_alarm:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_memory_alarm');
  {$ENDIF}

  ASqlite3^.value_blob:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_blob');
  ASqlite3^.value_bytes:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_bytes');
  ASqlite3^.value_bytes16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_bytes16');
  ASqlite3^.value_double:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_double');
  ASqlite3^.value_int:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_int');
  ASqlite3^.value_int64:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_int64');
  ASqlite3^.value_text:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_text');
  ASqlite3^.value_text16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_text16');
  ASqlite3^.value_text16le:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_text16le');
  ASqlite3^.value_text16be:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_text16be');
  ASqlite3^.value_type:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_type');
  ASqlite3^.value_numeric_type:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_value_numeric_type');
  ASqlite3^.aggregate_context:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_aggregate_context');
  ASqlite3^.user_data:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_user_data');
  ASqlite3^.context_db_handle:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_context_db_handle');
  ASqlite3^.get_auxdata:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_get_auxdata');
  ASqlite3^.set_auxdata:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_set_auxdata');
  ASqlite3^.result_blob:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_blob');
  ASqlite3^.result_double:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_double');
  ASqlite3^.result_error:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_error');
  ASqlite3^.result_error16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_error16');
  ASqlite3^.result_error_toobig:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_error_toobig');
  ASqlite3^.result_error_nomem:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_error_nomem');
  ASqlite3^.result_error_code:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_error_code');
  ASqlite3^.result_int:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_int');
  ASqlite3^.result_int64:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_int64');
  ASqlite3^.result_null:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_null');
  ASqlite3^.result_text:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_text');
  ASqlite3^.result_text16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_text16');
  ASqlite3^.result_text16le:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_text16le');
  ASqlite3^.result_text16be:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_text16be');
  ASqlite3^.result_value:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_value');
  ASqlite3^.result_zeroblob:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_result_zeroblob');

  ASqlite3^.create_collation:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_create_collation');
  ASqlite3^.create_collation_v2:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_create_collation_v2');
  ASqlite3^.create_collation16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_create_collation16');

  ASqlite3^.collation_needed:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_collation_needed');
  ASqlite3^.collation_needed16:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_collation_needed16');

  ASqlite3^.sleep:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_sleep');

  //var sqlite3_temp_directory: PAnsiChar');

  ASqlite3^.get_autocommit:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_get_autocommit');

  ASqlite3^.db_handle:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_db_handle');

  ASqlite3^.next_stmt:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_next_stmt');

  ASqlite3^.commit_hook:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_commit_hook');
  ASqlite3^.rollback_hook:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_rollback_hook');

  ASqlite3^.update_hook:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_update_hook');

  ASqlite3^.enable_shared_cache:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_enable_shared_cache');

  ASqlite3^.release_memory:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_release_memory');

  ASqlite3^.soft_heap_limit:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_soft_heap_limit');

  {$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
  ASqlite3^.table_column_metadata:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_table_column_metadata');
  {$ENDIF}

  ASqlite3^.load_extension:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_load_extension');

  ASqlite3^.enable_load_extension:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_enable_load_extension');

  ASqlite3^.auto_extension:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_auto_extension');

  ASqlite3^.reset_auto_extension:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_reset_auto_extension');

  {$IFDEF SQLITE_EXPERIMENTAL}
  ASqlite3^.create_module:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_create_module');

  ASqlite3^.create_module_v2:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_create_module_v2');
  ASqlite3^.declare_vtab:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_declare_vtab');

  ASqlite3^.overload_function:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_overload_function');
  {$ENDIF}

  ASqlite3^.blob_open:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_blob_open');

  ASqlite3^.blob_close:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_blob_close');

  ASqlite3^.blob_bytes:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_blob_bytes');

  ASqlite3^.blob_read:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_blob_read');

  ASqlite3^.blob_write:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_blob_write');

  ASqlite3^.vfs_find:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_vfs_find');
  ASqlite3^.vfs_register:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_vfs_register');
  ASqlite3^.vfs_unregister:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_vfs_unregister');

  ASqlite3^.mutex_alloc:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_mutex_alloc');
  ASqlite3^.mutex_free:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_mutex_free');
  ASqlite3^.mutex_enter:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_mutex_enter');
  ASqlite3^.mutex_try:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_mutex_try');
  ASqlite3^.mutex_leave:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_mutex_leave');

  {$IFDEF SQLITE_DEBUG}
  ASqlite3^.mutex_held:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_mutex_held');
  ASqlite3^.mutex_notheld:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_mutex_notheld');
  {$ENDIF}

  ASqlite3^.db_mutex:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_db_mutex');
  ASqlite3^.file_control:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_file_control');

  ASqlite3^.test_control:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_test_control');

  {$IFDEF SQLITE_EXPERIMENTAL}
  ASqlite3^.status:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_status');

  ASqlite3^.db_status:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_db_status');

  ASqlite3^.stmt_status:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_stmt_status');
  ASqlite3^.backup_init:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_backup_init');
  ASqlite3^.backup_step:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_backup_step');
  ASqlite3^.backup_finish:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_backup_finish');
  ASqlite3^.backup_remaining:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_backup_remaining');
  ASqlite3^.backup_pagecount:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_backup_pagecount');

  {$IFDEF SQLITE_ENABLE_UNLOCK_NOTIFY}
  ASqlite3^.unlock_notify:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_unlock_notify');
  {$ENDIF}
  ASqlite3^.strnicmp:= GetProcAddress(ASqlite3^.Handle, 'sqlite3_strnicmp');
  {$ENDIF}
  Result := true;
end;

end.
