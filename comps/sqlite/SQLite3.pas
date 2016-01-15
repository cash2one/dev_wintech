{
  $Id: SQLite3.pas 9 2010-02-13 05:06:55Z yury@plashenkov.com $

  Complete SQLite3 API translation and simple wrapper for Delphi and FreePascal
  Copyright ?2010 IndaSoftware Inc. and contributors. All rights reserved.
  http://www.indasoftware.com/fordev/sqlite3/

  SQLite is a software library that implements a self-contained, serverless,
  zero-configuration, transactional SQL database engine. The source code for
  SQLite is in the public domain and is thus free for use for any purpose,
  commercial or private. SQLite is the most widely deployed SQL database engine
  in the world.

  This package contains complete SQLite3 API translation for Delphi and
  FreePascal, as well as a simple Unicode-enabled object wrapper to simplify
  the use of this database engine.

  The contents of this file are used with permission, subject to the Mozilla
  Public License Version 1.1 (the "License"); you may not use this file except
  in compliance with the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/MPL-1.1.html

  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
  the specific language governing rights and limitations under the License.
}

{
  SQLite3 API translation
  Version of SQLite: 3.6.22
}
unit SQLite3;

{$IFDEF MSWINDOWS}

{ $DEFINE SQLITE_DEPRECATED}              // Enable deprecated functions
{$DEFINE SQLITE_EXPERIMENTAL}            // Enable experimental functions

{$DEFINE SQLITE_ENABLE_COLUMN_METADATA}   // Enable functions to work with
                                          // column metadata:
                                          // table name, DB name, etc.

{ $DEFINE SQLITE_ENABLE_UNLOCK_NOTIFY}     // Enable sqlite3_unlock_notify()
                                          // function to receive DB unlock
                                          // notification

{ $DEFINE SQLITE_DEBUG}                   // Enable sqlite3_mutex_held() and
                                          // sqlite3_mutex_notheld() functions

{$ENDIF}

interface

{$IFDEF MSWINDOWS}
uses
  Windows, SysUtils;

type
  PPAnsiCharArray = ^TPAnsiCharArray;
  TPAnsiCharArray = array[0..MaxInt div SizeOf(PAnsiChar) - 1] of PAnsiChar;

//const
////{$IFDEF MSWINDOWS}
////  sqlite3_lib = 'sqlite3.dll';
////{$ENDIF}
////{$IFDEF UNIX}
////  sqlite3_lib = 'sqlite3.so';
////{$ENDIF}
////{$IFDEF DARWIN}
////  sqlite3_lib = 'libsqlite3.dylib';
////{$ENDIF}
//
//{$IF Defined(MSWINDOWS)}
//  sqlite3_lib = 'sqlite3.dll';
//{$ELSEIF Defined(DARWIN)}
//  sqlite3_lib = 'libsqlite3.dylib';
//  {$linklib libsqlite3}
//{$ELSEIF Defined(UNIX)}
//  sqlite3_lib = 'sqlite3.so';
//{$IFEND}

//var sqlite3_version: PAnsiChar;
function _sqlite3_libversion: PAnsiChar; cdecl;
function _sqlite3_sourceid: PAnsiChar; cdecl;
function _sqlite3_libversion_number: Integer; cdecl;

function _sqlite3_threadsafe: Integer; cdecl;

type
  PSQLite3 = type Pointer;

function _sqlite3_close(db: PSQLite3): Integer; cdecl;

type
  TSQLite3Callback = function(pArg: Pointer; nCol: Integer; argv: PPAnsiCharArray; colv: PPAnsiCharArray): Integer; cdecl;

function _sqlite3_exec(db: PSQLite3; const sql: PAnsiChar; callback: TSQLite3Callback; pArg: Pointer; errmsg: PPAnsiChar): Integer; cdecl;

const
  SQLITE_OK         = 0;
  SQLITE_ERROR      = 1;
  SQLITE_INTERNAL   = 2;
  SQLITE_PERM       = 3;
  SQLITE_ABORT      = 4;
  SQLITE_BUSY       = 5;
  SQLITE_LOCKED     = 6;
  SQLITE_NOMEM      = 7;
  SQLITE_READONLY   = 8;
  SQLITE_INTERRUPT  = 9;
  SQLITE_IOERR      = 10;
  SQLITE_CORRUPT    = 11;
  SQLITE_NOTFOUND   = 12;
  SQLITE_FULL       = 13;
  SQLITE_CANTOPEN   = 14;
  SQLITE_PROTOCOL   = 15;
  SQLITE_EMPTY      = 16;
  SQLITE_SCHEMA     = 17;
  SQLITE_TOOBIG     = 18;
  SQLITE_CONSTRAINT = 19;
  SQLITE_MISMATCH   = 20;
  SQLITE_MISUSE     = 21;
  SQLITE_NOLFS      = 22;
  SQLITE_AUTH       = 23;
  SQLITE_FORMAT     = 24;
  SQLITE_RANGE      = 25;
  SQLITE_NOTADB     = 26;
  SQLITE_ROW        = 100;
  SQLITE_DONE       = 101;

const
  SQLITE_IOERR_READ              = SQLITE_IOERR or (1 shl 8);
  SQLITE_IOERR_SHORT_READ        = SQLITE_IOERR or (2 shl 8);
  SQLITE_IOERR_WRITE             = SQLITE_IOERR or (3 shl 8);
  SQLITE_IOERR_FSYNC             = SQLITE_IOERR or (4 shl 8);
  SQLITE_IOERR_DIR_FSYNC         = SQLITE_IOERR or (5 shl 8);
  SQLITE_IOERR_TRUNCATE          = SQLITE_IOERR or (6 shl 8);
  SQLITE_IOERR_FSTAT             = SQLITE_IOERR or (7 shl 8);
  SQLITE_IOERR_UNLOCK            = SQLITE_IOERR or (8 shl 8);
  SQLITE_IOERR_RDLOCK            = SQLITE_IOERR or (9 shl 8);
  SQLITE_IOERR_DELETE            = SQLITE_IOERR or (10 shl 8);
  SQLITE_IOERR_BLOCKED           = SQLITE_IOERR or (11 shl 8);
  SQLITE_IOERR_NOMEM             = SQLITE_IOERR or (12 shl 8);
  SQLITE_IOERR_ACCESS            = SQLITE_IOERR or (13 shl 8);
  SQLITE_IOERR_CHECKRESERVEDLOCK = SQLITE_IOERR or (14 shl 8);
  SQLITE_IOERR_LOCK              = SQLITE_IOERR or (15 shl 8);
  SQLITE_IOERR_CLOSE             = SQLITE_IOERR or (16 shl 8);
  SQLITE_IOERR_DIR_CLOSE         = SQLITE_IOERR or (17 shl 8);
  SQLITE_LOCKED_SHAREDCACHE      = SQLITE_LOCKED or (1 shl 8);

const
  SQLITE_OPEN_READONLY       = $00000001;
  SQLITE_OPEN_READWRITE      = $00000002;
  SQLITE_OPEN_CREATE         = $00000004;
  SQLITE_OPEN_DELETEONCLOSE  = $00000008;
  SQLITE_OPEN_EXCLUSIVE      = $00000010;
  SQLITE_OPEN_MAIN_DB        = $00000100;
  SQLITE_OPEN_TEMP_DB        = $00000200;
  SQLITE_OPEN_TRANSIENT_DB   = $00000400;
  SQLITE_OPEN_MAIN_JOURNAL   = $00000800;
  SQLITE_OPEN_TEMP_JOURNAL   = $00001000;
  SQLITE_OPEN_SUBJOURNAL     = $00002000;
  SQLITE_OPEN_MASTER_JOURNAL = $00004000;

  // 则是多线程模式，对于写是互斥的，但是如果一个连接持续写，
  // 另外一个连接是无法写入的，只能是错误或者超时返回。不过
  //一个连接写，多个连接读，是没问题的。windows版本模式是SQLITE_OPEN_NOMUTEX
  SQLITE_OPEN_NOMUTEX        = $00008000;

  // 也就是串行化方式，则对于连接时互斥的，只有一个连接关闭，另外一个连接才能读写
  SQLITE_OPEN_FULLMUTEX      = $00010000;

  SQLITE_OPEN_SHAREDCACHE    = $00020000;
  SQLITE_OPEN_PRIVATECACHE   = $00040000;

const
  SQLITE_IOCAP_ATOMIC      = $00000001;
  SQLITE_IOCAP_ATOMIC512   = $00000002;
  SQLITE_IOCAP_ATOMIC1K    = $00000004;
  SQLITE_IOCAP_ATOMIC2K    = $00000008;
  SQLITE_IOCAP_ATOMIC4K    = $00000010;
  SQLITE_IOCAP_ATOMIC8K    = $00000020;
  SQLITE_IOCAP_ATOMIC16K   = $00000040;
  SQLITE_IOCAP_ATOMIC32K   = $00000080;
  SQLITE_IOCAP_ATOMIC64K   = $00000100;
  SQLITE_IOCAP_SAFE_APPEND = $00000200;
  SQLITE_IOCAP_SEQUENTIAL  = $00000400;

const
  SQLITE_LOCK_NONE      = 0;
  SQLITE_LOCK_SHARED    = 1;
  SQLITE_LOCK_RESERVED  = 2;
  SQLITE_LOCK_PENDING   = 3;
  SQLITE_LOCK_EXCLUSIVE = 4;

const
  SQLITE_SYNC_NORMAL   = $00002;
  SQLITE_SYNC_FULL     = $00003;
  SQLITE_SYNC_DATAONLY = $00010;

type
  PSQLite3File = ^TSQLite3File;
  PSQLite3IOMethods = ^TSQLite3IOMethods;

  sqlite3_file = record
    pMethods: PSQLite3IOMethods;
  end;
  TSQLite3File = sqlite3_file;

  sqlite3_io_methods = record
    iVersion: Integer;
    xClose: function(id: PSQLite3File): Integer; cdecl;
    xRead: function(id: PSQLite3File; pBuf: Pointer; iAmt: Integer; iOfst: Int64): Integer; cdecl;
    xWrite: function(id: PSQLite3File; const pBuf: Pointer; iAmt: Integer; iOfst: Int64): Integer; cdecl;
    xTruncate: function(id: PSQLite3File; size: Int64): Integer; cdecl;
    xSync: function(id: PSQLite3File; flags: Integer): Integer; cdecl;
    xFileSize: function(id: PSQLite3File; var pSize: Int64): Integer; cdecl;
    xLock: function(id: PSQLite3File; locktype: Integer): Integer; cdecl;
    xUnlock: function(id: PSQLite3File; locktype: Integer): Integer; cdecl;
    xCheckReservedLock: function(f: PSQLite3File; var pResOut: Integer): Integer; cdecl;
    xFileControl: function(id: PSQLite3File; op: Integer; pArg: Pointer): Integer; cdecl;
    xSectorSize: function(id: PSQLite3File): Integer; cdecl;
    xDeviceCharacteristics: function(id: PSQLite3File): Integer; cdecl;
  end;
  TSQLite3IOMethods = sqlite3_io_methods;

const
  SQLITE_FCNTL_LOCKSTATE   = 1;
  SQLITE_GET_LOCKPROXYFILE = 2;
  SQLITE_SET_LOCKPROXYFILE = 3;
  SQLITE_LAST_ERRNO        = 4;

type
  PSQLite3Mutex = type Pointer;

type
  PSQLite3VFS = ^TSQLite3VFS;
  sqlite3_vfs = record
    iVersion: Integer;
    szOsFile: Integer;
    mxPathname: Integer;
    pNext: PSQLite3VFS;
    zName: PAnsiChar;
    pAppData: Pointer;
    xOpen: function(pVfs: PSQLite3VFS; const zName: PAnsiChar; id: PSQLite3File; flags: Integer; pOutFlags: PInteger): Integer; cdecl;
    xDelete: function(pVfs: PSQLite3VFS; const zName: PAnsiChar; syncDir: Integer): Integer; cdecl;
    xAccess: function(pVfs: PSQLite3VFS; const zName: PAnsiChar; flags: Integer; var pResOut: Integer): Integer; cdecl;
    xFullPathname: function(pVfs: PSQLite3VFS; const zName: PAnsiChar; nOut: Integer; zOut: PAnsiChar): Integer; cdecl;
    xDlOpen: function(pVfs: PSQLite3VFS; const zFilename: PAnsiChar): Pointer; cdecl;
    xDlError: procedure(pVfs: PSQLite3VFS; nByte: Integer; zErrMsg: PAnsiChar); cdecl;
    xDlSym: function(pVfs: PSQLite3VFS; pHandle: Pointer; const zSymbol: PAnsiChar): Pointer; cdecl;
    xDlClose: procedure(pVfs: PSQLite3VFS; pHandle: Pointer); cdecl;
    xRandomness: function(pVfs: PSQLite3VFS; nByte: Integer; zOut: PAnsiChar): Integer; cdecl;
    xSleep: function(pVfs: PSQLite3VFS; microseconds: Integer): Integer; cdecl;
    xCurrentTime: function(pVfs: PSQLite3VFS; var prNow: Double): Integer; cdecl;
    xGetLastError: function(pVfs: PSQLite3VFS; nBuf: Integer; zBuf: PAnsiChar): Integer; cdecl;
  end;
  TSQLite3VFS = sqlite3_vfs;

const
  SQLITE_ACCESS_EXISTS    = 0;
  SQLITE_ACCESS_READWRITE = 1;
  SQLITE_ACCESS_READ      = 2;

function _sqlite3_initialize: Integer; cdecl;
function _sqlite3_shutdown: Integer; cdecl;
function _sqlite3_os_init: Integer; cdecl;
function _sqlite3_os_end: Integer; cdecl;

{$IFDEF SQLITE_EXPERIMENTAL}
function _sqlite3_config(op: Integer{; ...}): Integer; cdecl;

function _sqlite3_db_config(db: PSQLite3; op: Integer{; ...}): Integer; cdecl;

type
  sqlite3_mem_methods = record
    xMalloc: function(nByte: Integer): Pointer; cdecl;
    xFree: procedure(pPrior: Pointer); cdecl;
    xRealloc: function(pPrior: Pointer; nByte: Integer): Pointer; cdecl;
    xSize: function(pPrior: Pointer): Integer; cdecl;
    xRoundup: function(n: Integer): Integer; cdecl;
    xInit: function(NotUsed: Pointer): Integer; cdecl;
    xShutdown: procedure(NotUsed: Pointer); cdecl;
    pAppData: Pointer;
  end;
  TSQLite3MemMethods = sqlite3_mem_methods;

const
  SQLITE_CONFIG_SINGLETHREAD = 1;
  SQLITE_CONFIG_MULTITHREAD  = 2;
  SQLITE_CONFIG_SERIALIZED   = 3;
  SQLITE_CONFIG_MALLOC       = 4;
  SQLITE_CONFIG_GETMALLOC    = 5;
  SQLITE_CONFIG_SCRATCH      = 6;
  SQLITE_CONFIG_PAGECACHE    = 7;
  SQLITE_CONFIG_HEAP         = 8;
  SQLITE_CONFIG_MEMSTATUS    = 9;
  SQLITE_CONFIG_MUTEX        = 10;
  SQLITE_CONFIG_GETMUTEX     = 11;
  //SQLITE_CONFIG_CHUNKALLOC   = 12;
  SQLITE_CONFIG_LOOKASIDE    = 13;
  SQLITE_CONFIG_PCACHE       = 14;
  SQLITE_CONFIG_GETPCACHE    = 15;

const
  SQLITE_DBCONFIG_LOOKASIDE  = 1001;
{$ENDIF}

function _sqlite3_extended_result_codes(db: PSQLite3; onoff: Integer): Integer; cdecl;

function _sqlite3_last_insert_rowid(db: PSQLite3): Int64; cdecl;

function _sqlite3_changes(db: PSQLite3): Integer; cdecl;

function _sqlite3_total_changes(db: PSQLite3): Integer; cdecl;

procedure _sqlite3_interrupt(db: PSQLite3); cdecl;

function _sqlite3_complete(const sql: PAnsiChar): Integer; cdecl;
function _sqlite3_complete16(const sql: PWideChar): Integer; cdecl;

type
  TSQLite3BusyCallback = function(ptr: Pointer; count: Integer): Integer; cdecl;

function _sqlite3_busy_handler(db: PSQLite3; xBusy: TSQLite3BusyCallback; pArg: Pointer): Integer; cdecl;

function _sqlite3_busy_timeout(db: PSQLite3; ms: Integer): Integer; cdecl;

function _sqlite3_get_table(db: PSQLite3; const zSql: PAnsiChar; var pazResult: PPAnsiCharArray; pnRow: PInteger; pnColumn: PInteger; pzErrmsg: PPAnsiChar): Integer; cdecl;
procedure _sqlite3_free_table(result: PPAnsiCharArray); cdecl;

function _sqlite3_mprintf(const zFormat: PAnsiChar{; ...}): PAnsiChar; cdecl;
function _sqlite3_vmprintf(const zFormat: PAnsiChar; ap: Pointer{va_list}): PAnsiChar; cdecl;
function _sqlite3_snprintf(n: Integer; zBuf: PAnsiChar; const zFormat: PAnsiChar{; ...}): PAnsiChar; cdecl;

function _sqlite3_malloc(n: Integer): Pointer; cdecl;
function _sqlite3_realloc(pOld: Pointer; n: Integer): Pointer; cdecl;
procedure _sqlite3_free(p: Pointer); cdecl;

function _sqlite3_memory_used: Int64; cdecl;
function _sqlite3_memory_highwater(resetFlag: Integer): Int64; cdecl;

procedure _sqlite3_randomness(N: Integer; P: Pointer); cdecl;

type
  TSQLite3AuthorizerCallback = function(pAuthArg: Pointer; code: Integer; const zTab: PAnsiChar; const zCol: PAnsiChar; const zDb: PAnsiChar; const zAuthContext: PAnsiChar): Integer; cdecl;

function _sqlite3_set_authorizer(db: PSQLite3; xAuth: TSQLite3AuthorizerCallback; pUserData: Pointer): Integer; cdecl;

const
  SQLITE_DENY   = 1;
  SQLITE_IGNORE = 2;

const
  SQLITE_CREATE_INDEX        = 1;
  SQLITE_CREATE_TABLE        = 2;
  SQLITE_CREATE_TEMP_INDEX   = 3;
  SQLITE_CREATE_TEMP_TABLE   = 4;
  SQLITE_CREATE_TEMP_TRIGGER = 5;
  SQLITE_CREATE_TEMP_VIEW    = 6;
  SQLITE_CREATE_TRIGGER      = 7;
  SQLITE_CREATE_VIEW         = 8;
  SQLITE_DELETE              = 9;
  SQLITE_DROP_INDEX          = 10;
  SQLITE_DROP_TABLE          = 11;
  SQLITE_DROP_TEMP_INDEX     = 12;
  SQLITE_DROP_TEMP_TABLE     = 13;
  SQLITE_DROP_TEMP_TRIGGER   = 14;
  SQLITE_DROP_TEMP_VIEW      = 15;
  SQLITE_DROP_TRIGGER        = 16;
  SQLITE_DROP_VIEW           = 17;
  SQLITE_INSERT              = 18;
  SQLITE_PRAGMA              = 19;
  SQLITE_READ                = 20;
  SQLITE_SELECT              = 21;
  SQLITE_TRANSACTION         = 22;
  SQLITE_UPDATE              = 23;
  SQLITE_ATTACH              = 24;
  SQLITE_DETACH              = 25;
  SQLITE_ALTER_TABLE         = 26;
  SQLITE_REINDEX             = 27;
  SQLITE_ANALYZE             = 28;
  SQLITE_CREATE_VTABLE       = 29;
  SQLITE_DROP_VTABLE         = 30;
  SQLITE_FUNCTION            = 31;
  SQLITE_SAVEPOINT           = 32;
  SQLITE_COPY                = 0;

{$IFDEF SQLITE_EXPERIMENTAL}
type
  TSQLite3TraceCallback = procedure(pTraceArg: Pointer; const zTrace: PAnsiChar); cdecl;
  TSQLite3ProfileCallback = procedure(pProfileArg: Pointer; const zSql: PAnsiChar; elapseTime: UInt64); cdecl;

function _sqlite3_trace(db: PSQLite3; xTrace: TSQLite3TraceCallback; pArg: Pointer): Pointer; cdecl;
function _sqlite3_profile(db: PSQLite3; xProfile: TSQLite3ProfileCallback; pArg: Pointer): Pointer; cdecl;
{$ENDIF}

type
  TSQLite3ProgressCallback = function(pProgressArg: Pointer): Integer; cdecl;

procedure _sqlite3_progress_handler(db: PSQLite3; nOps: Integer; xProgress: TSQLite3ProgressCallback; pArg: Pointer); cdecl;

function _sqlite3_open(const filename: PAnsiChar; var ppDb: PSQLite3): Integer; cdecl;
function _sqlite3_open16(const filename: PWideChar; var ppDb: PSQLite3): Integer; cdecl;
function _sqlite3_open_v2(const filename: PAnsiChar; var ppDb: PSQLite3; flags: Integer; const zVfs: PAnsiChar): Integer; cdecl;

function _sqlite3_errcode(db: PSQLite3): Integer; cdecl;
function _sqlite3_extended_errcode(db: PSQLite3): Integer; cdecl;
function _sqlite3_errmsg(db: PSQLite3): PAnsiChar; cdecl;
function _sqlite3_errmsg16(db: PSQLite3): PWideChar; cdecl;

type
  PSQLite3Stmt = type Pointer;

function _sqlite3_limit(db: PSQLite3; limitId: Integer; newLimit: Integer): Integer; cdecl;

const
  SQLITE_LIMIT_LENGTH              = 0;
  SQLITE_LIMIT_SQL_LENGTH          = 1;
  SQLITE_LIMIT_COLUMN              = 2;
  SQLITE_LIMIT_EXPR_DEPTH          = 3;
  SQLITE_LIMIT_COMPOUND_SELECT     = 4;
  SQLITE_LIMIT_VDBE_OP             = 5;
  SQLITE_LIMIT_FUNCTION_ARG        = 6;
  SQLITE_LIMIT_ATTACHED            = 7;
  SQLITE_LIMIT_LIKE_PATTERN_LENGTH = 8;
  SQLITE_LIMIT_VARIABLE_NUMBER     = 9;
  SQLITE_LIMIT_TRIGGER_DEPTH       = 10;

function _sqlite3_prepare(db: PSQLite3; const zSql: PAnsiChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPAnsiChar): Integer; cdecl;
function _sqlite3_prepare_v2(db: PSQLite3; const zSql: PAnsiChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPAnsiChar): Integer; cdecl;
function _sqlite3_prepare16(db: PSQLite3; const zSql: PWideChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPWideChar): Integer; cdecl;
function _sqlite3_prepare16_v2(db: PSQLite3; const zSql: PWideChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPWideChar): Integer; cdecl;

function _sqlite3_sql(pStmt: PSQLite3Stmt): PAnsiChar; cdecl;

type
  PSQLite3Value = ^TSQLite3Value;
  sqlite3_value = type Pointer;
  TSQLite3Value = sqlite3_value;

  PPSQLite3ValueArray = ^TPSQLite3ValueArray;
  TPSQLite3ValueArray = array[0..MaxInt div SizeOf(PSQLite3Value) - 1] of PSQLite3Value;

type
  PSQLite3Context = type Pointer;

type
  TSQLite3DestructorType = procedure(p: Pointer); cdecl;

const
  SQLITE_STATIC    = Pointer(0);
  SQLITE_TRANSIENT = Pointer(-1);

function _sqlite3_bind_blob(pStmt: PSQLite3Stmt; i: Integer; const zData: Pointer; n: Integer; xDel: TSQLite3DestructorType): Integer; cdecl;
function _sqlite3_bind_double(pStmt: PSQLite3Stmt; i: Integer; rValue: Double): Integer; cdecl;
function _sqlite3_bind_int(p: PSQLite3Stmt; i: Integer; iValue: Integer): Integer; cdecl;
function _sqlite3_bind_int64(pStmt: PSQLite3Stmt; i: Integer; iValue: Int64): Integer; cdecl;
function _sqlite3_bind_null(pStmt: PSQLite3Stmt; i: Integer): Integer; cdecl;
function _sqlite3_bind_text(pStmt: PSQLite3Stmt; i: Integer; const zData: PAnsiChar; n: Integer; xDel: TSQLite3DestructorType): Integer; cdecl;
function _sqlite3_bind_text16(pStmt: PSQLite3Stmt; i: Integer; const zData: PWideChar; nData: Integer; xDel: TSQLite3DestructorType): Integer; cdecl;
function _sqlite3_bind_value(pStmt: PSQLite3Stmt; i: Integer; const pValue: PSQLite3Value): Integer; cdecl;
function _sqlite3_bind_zeroblob(pStmt: PSQLite3Stmt; i: Integer; n: Integer): Integer; cdecl;

function _sqlite3_bind_parameter_count(pStmt: PSQLite3Stmt): Integer; cdecl;

function _sqlite3_bind_parameter_name(pStmt: PSQLite3Stmt; i: Integer): PAnsiChar; cdecl;

function _sqlite3_bind_parameter_index(pStmt: PSQLite3Stmt; const zName: PAnsiChar): Integer; cdecl;

function _sqlite3_clear_bindings(pStmt: PSQLite3Stmt): Integer; cdecl;

function _sqlite3_column_count(pStmt: PSQLite3Stmt): Integer; cdecl;

function _sqlite3_column_name(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
function _sqlite3_column_name16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;

//{$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
//function _sqlite3_column_database_name(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
//function _sqlite3_column_database_name16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;
//function _sqlite3_column_table_name(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
//function _sqlite3_column_table_name16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;
//function _sqlite3_column_origin_name(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
//function _sqlite3_column_origin_name16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;
//{$ENDIF}

function _sqlite3_column_decltype(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl;
function _sqlite3_column_decltype16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl;

function _sqlite3_step(pStmt: PSQLite3Stmt): Integer; cdecl;

function _sqlite3_data_count(pStmt: PSQLite3Stmt): Integer; cdecl;

const
  SQLITE_INTEGER = 1;
  SQLITE_FLOAT   = 2;
  SQLITE_BLOB    = 4;
  SQLITE_NULL    = 5;
  SQLITE_TEXT    = 3;
  SQLITE3_TEXT   = 3;

function _sqlite3_column_blob(pStmt: PSQLite3Stmt; iCol: Integer): Pointer; cdecl;
function _sqlite3_column_bytes(pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl;
function _sqlite3_column_bytes16(pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl;
function _sqlite3_column_double(pStmt: PSQLite3Stmt; iCol: Integer): Double; cdecl;
function _sqlite3_column_int(pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl;
function _sqlite3_column_int64(pStmt: PSQLite3Stmt; iCol: Integer): Int64; cdecl;
function _sqlite3_column_text(pStmt: PSQLite3Stmt; iCol: Integer): PAnsiChar; cdecl;
function _sqlite3_column_text16(pStmt: PSQLite3Stmt; iCol: Integer): PWideChar; cdecl;
function _sqlite3_column_type(pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl;
function _sqlite3_column_value(pStmt: PSQLite3Stmt; iCol: Integer): PSQLite3Value; cdecl;

function _sqlite3_finalize(pStmt: PSQLite3Stmt): Integer; cdecl;

function _sqlite3_reset(pStmt: PSQLite3Stmt): Integer; cdecl;

type
  TSQLite3RegularFunction = procedure(ctx: PSQLite3Context; n: Integer; apVal: PPSQLite3ValueArray); cdecl;
  TSQLite3AggregateStep = procedure(ctx: PSQLite3Context; n: Integer; apVal: PPSQLite3ValueArray); cdecl;
  TSQLite3AggregateFinalize = procedure(ctx: PSQLite3Context); cdecl;

function _sqlite3_create_function(db: PSQLite3; const zFunctionName: PAnsiChar; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: TSQLite3RegularFunction; xStep: TSQLite3AggregateStep; xFinal: TSQLite3AggregateFinalize): Integer; cdecl;
function _sqlite3_create_function16(db: PSQLite3; const zFunctionName: PWideChar; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: TSQLite3RegularFunction; xStep: TSQLite3AggregateStep; xFinal: TSQLite3AggregateFinalize): Integer; cdecl;

const
  SQLITE_UTF8          = 1;
  SQLITE_UTF16LE       = 2;
  SQLITE_UTF16BE       = 3;
  SQLITE_UTF16         = 4;
  SQLITE_ANY           = 5;
  SQLITE_UTF16_ALIGNED = 8;

{$IFDEF SQLITE_DEPRECATED}
type
  TSQLite3MemoryAlarmCallback = procedure(pArg: Pointer; used: Int64; N: Integer); cdecl;

function _sqlite3_aggregate_count(p: PSQLite3Context): Integer; cdecl;
function _sqlite3_expired(pStmt: PSQLite3Stmt): Integer; cdecl;
function _sqlite3_transfer_bindings(pFromStmt: PSQLite3Stmt; pToStmt: PSQLite3Stmt): Integer; cdecl;
function _sqlite3_global_recover: Integer; cdecl;
procedure _sqlite3_thread_cleanup; cdecl;
function _sqlite3_memory_alarm(xCallback: TSQLite3MemoryAlarmCallback; pArg: Pointer; iThreshold: Int64): Integer; cdecl;
{$ENDIF}

function _sqlite3_value_blob(pVal: PSQLite3Value): Pointer; cdecl;
function _sqlite3_value_bytes(pVal: PSQLite3Value): Integer; cdecl;
function _sqlite3_value_bytes16(pVal: PSQLite3Value): Integer; cdecl;
function _sqlite3_value_double(pVal: PSQLite3Value): Double; cdecl;
function _sqlite3_value_int(pVal: PSQLite3Value): Integer; cdecl;
function _sqlite3_value_int64(pVal: PSQLite3Value): Int64; cdecl;
function _sqlite3_value_text(pVal: PSQLite3Value): PAnsiChar; cdecl;
function _sqlite3_value_text16(pVal: PSQLite3Value): PWideChar; cdecl;
function _sqlite3_value_text16le(pVal: PSQLite3Value): Pointer; cdecl;
function _sqlite3_value_text16be(pVal: PSQLite3Value): Pointer; cdecl;
function _sqlite3_value_type(pVal: PSQLite3Value): Integer; cdecl;
function _sqlite3_value_numeric_type(pVal: PSQLite3Value): Integer; cdecl;

function _sqlite3_aggregate_context(p: PSQLite3Context; nBytes: Integer): Pointer; cdecl;

function _sqlite3_user_data(p: PSQLite3Context): Pointer; cdecl;

function _sqlite3_context_db_handle(p: PSQLite3Context): PSQLite3; cdecl;

type
  TSQLite3AuxDataDestructor = procedure(pAux: Pointer); cdecl;

function _sqlite3_get_auxdata(pCtx: PSQLite3Context; N: Integer): Pointer; cdecl;
procedure _sqlite3_set_auxdata(pCtx: PSQLite3Context; N: Integer; pAux: Pointer; xDelete: TSQLite3AuxDataDestructor); cdecl;

procedure _sqlite3_result_blob(pCtx: PSQLite3Context; const z: Pointer; n: Integer; xDel: TSQLite3DestructorType); cdecl;
procedure _sqlite3_result_double(pCtx: PSQLite3Context; rVal: Double); cdecl;
procedure _sqlite3_result_error(pCtx: PSQLite3Context; const z: PAnsiChar; n: Integer); cdecl;
procedure _sqlite3_result_error16(pCtx: PSQLite3Context; const z: PWideChar; n: Integer); cdecl;
procedure _sqlite3_result_error_toobig(pCtx: PSQLite3Context); cdecl;
procedure _sqlite3_result_error_nomem(pCtx: PSQLite3Context); cdecl;
procedure _sqlite3_result_error_code(pCtx: PSQLite3Context; errCode: Integer); cdecl;
procedure _sqlite3_result_int(pCtx: PSQLite3Context; iVal: Integer); cdecl;
procedure _sqlite3_result_int64(pCtx: PSQLite3Context; iVal: Int64); cdecl;
procedure _sqlite3_result_null(pCtx: PSQLite3Context); cdecl;
procedure _sqlite3_result_text(pCtx: PSQLite3Context; const z: PAnsiChar; n: Integer; xDel: TSQLite3DestructorType); cdecl;
procedure _sqlite3_result_text16(pCtx: PSQLite3Context; const z: PWideChar; n: Integer; xDel: TSQLite3DestructorType); cdecl;
procedure _sqlite3_result_text16le(pCtx: PSQLite3Context; const z: Pointer; n: Integer; xDel: TSQLite3DestructorType); cdecl;
procedure _sqlite3_result_text16be(pCtx: PSQLite3Context; const z: Pointer; n: Integer; xDel: TSQLite3DestructorType); cdecl;
procedure _sqlite3_result_value(pCtx: PSQLite3Context; pValue: PSQLite3Value); cdecl;
procedure _sqlite3_result_zeroblob(pCtx: PSQLite3Context; n: Integer); cdecl;

type
  TSQLite3CollationCompare = procedure(pUser: Pointer; n1: Integer; const z1: Pointer; n2: Integer; const z2: Pointer); cdecl;
  TSQLite3CollationDestructor = procedure(pUser: Pointer); cdecl;

function _sqlite3_create_collation(db: PSQLite3; const zName: PAnsiChar; eTextRep: Integer; pUser: Pointer; xCompare: TSQLite3CollationCompare): Integer; cdecl;
function _sqlite3_create_collation_v2(db: PSQLite3; const zName: PAnsiChar; eTextRep: Integer; pUser: Pointer; xCompare: TSQLite3CollationCompare; xDestroy: TSQLite3CollationDestructor): Integer; cdecl;
function _sqlite3_create_collation16(db: PSQLite3; const zName: PWideChar; eTextRep: Integer; pUser: Pointer; xCompare: TSQLite3CollationCompare): Integer; cdecl;

type
  TSQLite3CollationNeededCallback = procedure(pCollNeededArg: Pointer; db: PSQLite3; eTextRep: Integer; const zExternal: PAnsiChar); cdecl;
  TSQLite3CollationNeededCallback16 = procedure(pCollNeededArg: Pointer; db: PSQLite3; eTextRep: Integer; const zExternal: PWideChar); cdecl;

function _sqlite3_collation_needed(db: PSQLite3; pCollNeededArg: Pointer; xCollNeeded: TSQLite3CollationNeededCallback): Integer; cdecl;
function _sqlite3_collation_needed16(db: PSQLite3; pCollNeededArg: Pointer; xCollNeeded16: TSQLite3CollationNeededCallback16): Integer; cdecl;

function _sqlite3_key(db: PSQLite3; const pKey: Pointer; nKey: Integer): Integer; cdecl;
function _sqlite3_rekey(db: PSQLite3; const pKey: Pointer; nKey: Integer): Integer; cdecl;

function _sqlite3_sleep(ms: Integer): Integer; cdecl;

//var sqlite3_temp_directory: PAnsiChar;

function _sqlite3_get_autocommit(db: PSQLite3): Integer; cdecl;

function _sqlite3_db_handle(pStmt: PSQLite3Stmt): PSQLite3; cdecl;

function _sqlite3_next_stmt(pDb: PSQLite3; pStmt: PSQLite3Stmt): PSQLite3Stmt; cdecl;

type
  TSQLite3CommitCallback = function(pCommitArg: Pointer): Integer; cdecl;
  TSQLite3RollbackCallback = procedure(pRollbackArg: Pointer); cdecl;

function _sqlite3_commit_hook(db: PSQLite3; xCallback: TSQLite3CommitCallback; pArg: Pointer): Pointer; cdecl;
function _sqlite3_rollback_hook(db: PSQLite3; xCallback: TSQLite3RollbackCallback; pArg: Pointer): Pointer; cdecl;

type
  TSQLite3UpdateCallback = procedure(pUpdateArg: Pointer; op: Integer; const zDb: PAnsiChar; const zTbl: PAnsiChar; iKey: Int64); cdecl;

function _sqlite3_update_hook(db: PSQLite3; xCallback: TSQLite3UpdateCallback; pArg: Pointer): Pointer; cdecl;

function _sqlite3_enable_shared_cache(enable: Integer): Integer; cdecl;

function _sqlite3_release_memory(n: Integer): Integer; cdecl;

procedure _sqlite3_soft_heap_limit(n: Integer); cdecl;

//{$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
//function _sqlite3_table_column_metadata(db: PSQLite3; const zDbName: PAnsiChar; const zTableName: PAnsiChar; const zColumnName: PAnsiChar; const pzDataType: PPAnsiChar; const pzCollSeq: PPAnsiChar; pNotNull: PInteger; pPrimaryKey: PInteger; pAutoinc: PInteger): Integer; cdecl;
//{$ENDIF}

function _sqlite3_load_extension(db: PSQLite3; const zFile: PAnsiChar; const zProc: PAnsiChar; pzErrMsg: PPAnsiChar): Integer; cdecl;

function _sqlite3_enable_load_extension(db: PSQLite3; onoff: Integer): Integer; cdecl;

type
  TSQLiteAutoExtensionEntryPoint = procedure; cdecl;

function _sqlite3_auto_extension(xEntryPoint: TSQLiteAutoExtensionEntryPoint): Integer; cdecl;

procedure _sqlite3_reset_auto_extension; cdecl;

{$IFDEF SQLITE_EXPERIMENTAL}
type
  TSQLite3FTS3Func = procedure(pContext: PSQLite3Context; argc: Integer; argv: PPSQLite3ValueArray); cdecl;

type
  PSQLite3VTab = ^TSQLite3VTab;
  PSQLite3IndexInfo = ^TSQLite3IndexInfo;
  PSQLite3VTabCursor = ^TSQLite3VTabCursor;
  PSQLite3Module = ^TSQLite3Module;

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
    xFindFunction: function(pVtab: PSQLite3VTab; nArg: Integer; const zName: PAnsiChar; var pxFunc: TSQLite3FTS3Func; var ppArg: Pointer): Integer; cdecl;
    xRename: function(pVtab: PSQLite3VTab; const zNew: PAnsiChar): Integer; cdecl;
  end;
  TSQLite3Module = sqlite3_module;

  sqlite3_index_constraint = record
    iColumn: Integer;
    op: Byte;
    usable: Byte;
    iTermOffset: Integer;
  end;
  TSQLite3IndexConstraint = sqlite3_index_constraint;

  PSQLite3IndexConstraintArray = ^TSQLite3IndexConstraintArray;
  TSQLite3IndexConstraintArray = array[0..MaxInt div SizeOf(TSQLite3IndexConstraint) - 1] of TSQLite3IndexConstraint;

  sqlite3_index_orderby = record
    iColumn: Integer;
    desc: Byte;
  end;
  TSQLite3IndexOrderBy = sqlite3_index_orderby;

  PSQLite3IndexOrderByArray = ^TSQLite3IndexOrderByArray;
  TSQLite3IndexOrderByArray = array[0..MaxInt div SizeOf(TSQLite3IndexOrderBy) - 1] of TSQLite3IndexOrderBy;

  sqlite3_index_constraint_usage = record
    argvIndex: Integer;
    omit: Byte;
  end;
  TSQLite3IndexConstraintUsage = sqlite3_index_constraint_usage;

  PSQLite3IndexConstraintUsageArray = ^TSQLite3IndexConstraintUsageArray;
  TSQLite3IndexConstraintUsageArray = array[0..MaxInt div SizeOf(TSQLite3IndexConstraintUsage) - 1] of TSQLite3IndexConstraintUsage;

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
  TSQLite3IndexInfo = sqlite3_index_info;

  sqlite3_vtab = record
    pModule: PSQLite3Module;
    nRef: Integer;
    zErrMsg: PAnsiChar;
  end;
  TSQLite3VTab = sqlite3_vtab;

  sqlite3_vtab_cursor = record
    pVtab: PSQLite3VTab;
  end;
  TSQLite3VTabCursor = sqlite3_vtab_cursor;

const
  SQLITE_INDEX_CONSTRAINT_EQ    = 2;
  SQLITE_INDEX_CONSTRAINT_GT    = 4;
  SQLITE_INDEX_CONSTRAINT_LE    = 8;
  SQLITE_INDEX_CONSTRAINT_LT    = 16;
  SQLITE_INDEX_CONSTRAINT_GE    = 32;
  SQLITE_INDEX_CONSTRAINT_MATCH = 64;

function _sqlite3_create_module(db: PSQLite3; const zName: PAnsiChar; const p: PSQLite3Module; pClientData: Pointer): Integer; cdecl;

type
  TSQLite3ModuleDestructor = procedure(pAux: Pointer); cdecl;

function _sqlite3_create_module_v2(db: PSQLite3; const zName: PAnsiChar; const p: PSQLite3Module; pClientData: Pointer; xDestroy: TSQLite3ModuleDestructor): Integer; cdecl;

function _sqlite3_declare_vtab(db: PSQLite3; const zSQL: PAnsiChar): Integer; cdecl;

function _sqlite3_overload_function(db: PSQLite3; const zFuncName: PAnsiChar; nArg: Integer): Integer; cdecl;
{$ENDIF}

type
  PSQLite3Blob = type Pointer;

function _sqlite3_blob_open(db: PSQLite3; const zDb: PAnsiChar; const zTable: PAnsiChar; const zColumn: PAnsiChar; iRow: Int64; flags: Integer; var ppBlob: PSQLite3Blob): Integer; cdecl;

function _sqlite3_blob_close(pBlob: PSQLite3Blob): Integer; cdecl;

function _sqlite3_blob_bytes(pBlob: PSQLite3Blob): Integer; cdecl;

function _sqlite3_blob_read(pBlob: PSQLite3Blob; Z: Pointer; N: Integer; iOffset: Integer): Integer; cdecl;

function _sqlite3_blob_write(pBlob: PSQLite3Blob; const z: Pointer; n: Integer; iOffset: Integer): Integer; cdecl;

function _sqlite3_vfs_find(const zVfsName: PAnsiChar): PSQLite3VFS; cdecl;
function _sqlite3_vfs_register(pVfs: PSQLite3VFS; makeDflt: Integer): Integer; cdecl;
function _sqlite3_vfs_unregister(pVfs: PSQLite3VFS): Integer; cdecl;

function _sqlite3_mutex_alloc(id: Integer): PSQLite3Mutex; cdecl;
procedure _sqlite3_mutex_free(p: PSQLite3Mutex); cdecl;
procedure _sqlite3_mutex_enter(p: PSQLite3Mutex); cdecl;
function _sqlite3_mutex_try(p: PSQLite3Mutex): Integer; cdecl;
procedure _sqlite3_mutex_leave(p: PSQLite3Mutex); cdecl;

{$IFDEF SQLITE_EXPERIMENTAL}
type
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
  TSQLite3MutexMethods = sqlite3_mutex_methods;
{$ENDIF}

{$IFDEF SQLITE_DEBUG}
function _sqlite3_mutex_held(p: PSQLite3Mutex): Integer; cdecl;
function _sqlite3_mutex_notheld(p: PSQLite3Mutex): Integer; cdecl;
{$ENDIF}

const
  SQLITE_MUTEX_FAST          = 0;
  SQLITE_MUTEX_RECURSIVE     = 1;
  SQLITE_MUTEX_STATIC_MASTER = 2;
  SQLITE_MUTEX_STATIC_MEM    = 3;
  SQLITE_MUTEX_STATIC_MEM2   = 4;
  SQLITE_MUTEX_STATIC_OPEN   = 4;
  SQLITE_MUTEX_STATIC_PRNG   = 5;
  SQLITE_MUTEX_STATIC_LRU    = 6;
  SQLITE_MUTEX_STATIC_LRU2   = 7;

function _sqlite3_db_mutex(db: PSQLite3): PSQLite3Mutex; cdecl;

function _sqlite3_file_control(db: PSQLite3; const zDbName: PAnsiChar; op: Integer; pArg: Pointer): Integer; cdecl;

function _sqlite3_test_control(op: Integer{; ...}): Integer; cdecl;

const
  SQLITE_TESTCTRL_FIRST               = 5;
  SQLITE_TESTCTRL_PRNG_SAVE           = 5;
  SQLITE_TESTCTRL_PRNG_RESTORE        = 6;
  SQLITE_TESTCTRL_PRNG_RESET          = 7;
  SQLITE_TESTCTRL_BITVEC_TEST         = 8;
  SQLITE_TESTCTRL_FAULT_INSTALL       = 9;
  SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS = 10;
  SQLITE_TESTCTRL_PENDING_BYTE        = 11;
  SQLITE_TESTCTRL_ASSERT              = 12;
  SQLITE_TESTCTRL_ALWAYS              = 13;
  SQLITE_TESTCTRL_RESERVE             = 14;
  SQLITE_TESTCTRL_OPTIMIZATIONS       = 15;
  SQLITE_TESTCTRL_ISKEYWORD           = 16;
  SQLITE_TESTCTRL_LAST                = 16;

{$IFDEF SQLITE_EXPERIMENTAL}
function _sqlite3_status(op: Integer; var pCurrent: Integer; var pHighwater: Integer; resetFlag: Integer): Integer; cdecl;

const
  SQLITE_STATUS_MEMORY_USED        = 0;
  SQLITE_STATUS_PAGECACHE_USED     = 1;
  SQLITE_STATUS_PAGECACHE_OVERFLOW = 2;
  SQLITE_STATUS_SCRATCH_USED       = 3;
  SQLITE_STATUS_SCRATCH_OVERFLOW   = 4;
  SQLITE_STATUS_MALLOC_SIZE        = 5;
  SQLITE_STATUS_PARSER_STACK       = 6;
  SQLITE_STATUS_PAGECACHE_SIZE     = 7;
  SQLITE_STATUS_SCRATCH_SIZE       = 8;

function _sqlite3_db_status(db: PSQLite3; op: Integer; var pCur: Integer; var pHiwtr: Integer; resetFlg: Integer): Integer; cdecl;

const
  SQLITE_DBSTATUS_LOOKASIDE_USED = 0;

function _sqlite3_stmt_status(pStmt: PSQLite3Stmt; op: Integer; resetFlg: Integer): Integer; cdecl;

const
  SQLITE_STMTSTATUS_FULLSCAN_STEP = 1;
  SQLITE_STMTSTATUS_SORT          = 2;

type
  PSQLite3PCache = type Pointer;

type
  sqlite3_pcache_methods = record
    pArg: Pointer;
    xInit: function(pArg: Pointer): Integer; cdecl;
    xShutdown: procedure(pArg: Pointer); cdecl;
    xCreate: function(szPage: Integer; bPurgeable: Integer): PSQLite3PCache; cdecl;
    xCachesize: procedure(pCache: PSQLite3PCache; nCachesize: Integer); cdecl;
    xPagecount: function(pCache: PSQLite3PCache): Integer; cdecl;
    xFetch: function(pCache: PSQLite3PCache; key: Cardinal; createFlag: Integer): Pointer; cdecl;
    xUnpin: procedure(pCache: PSQLite3PCache; pPg: Pointer; discard: Integer); cdecl;
    xRekey: procedure(pCache: PSQLite3PCache; pPg: Pointer; oldKey: Cardinal; newKey: Cardinal); cdecl;
    xTruncate: procedure(pCache: PSQLite3PCache; iLimit: Cardinal); cdecl;
    xDestroy: procedure(pCache: PSQLite3PCache); cdecl;
  end;
  TSQLite3PCacheMethods = sqlite3_pcache_methods;

type
  PSQLite3Backup = type Pointer;

function _sqlite3_backup_init(pDest: PSQLite3; const zDestName: PAnsiChar;
    pSource: PSQLite3; const zSourceName: PAnsiChar): PSQLite3Backup; cdecl;
function _sqlite3_backup_step(p: PSQLite3Backup; nPage: Integer): Integer; cdecl;
function _sqlite3_backup_finish(p: PSQLite3Backup): Integer; cdecl;
function _sqlite3_backup_remaining(p: PSQLite3Backup): Integer; cdecl;
function _sqlite3_backup_pagecount(p: PSQLite3Backup): Integer; cdecl;

{$IFDEF SQLITE_ENABLE_UNLOCK_NOTIFY}
type
  TSQLite3UnlockNotifyCallback = procedure(apArg: System.PPointerArray; nArg: Integer); cdecl;

function _sqlite3_unlock_notify(pBlocked: PSQLite3;
  xNotify: TSQLite3UnlockNotifyCallback; pNotifyArg: Pointer): Integer; cdecl;
{$ENDIF}

function _sqlite3_strnicmp(const zLeft: PAnsiChar; const zRight: PAnsiChar; N: Integer): Integer; cdecl;
{$ENDIF}

//function _sqlite3_win32_mbcs_to_utf8(const S: PAnsiChar): PAnsiChar; cdecl;

{$ENDIF}

implementation

{$IFDEF MSWINDOWS}

function __ftol: Integer;
var
  f: double;
begin
  asm
    lea    eax, f             //  BC++ passes floats on the FPU stack
    fstp  qword ptr [eax]     //  Delphi passes floats on the CPU stack
  end;
  Result := Trunc(f);
end;

procedure __lldiv; //JOH Version
asm
        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        MOV     EBX, [ESP+16]
        MOV     ECX, [ESP+20]
        MOV     ESI, EDX
        MOV     EDI, ECX
        SAR     ESI, 31
        XOR     EAX, ESI
        XOR     EDX, ESI
        SUB     EAX, ESI
        SBB     EDX, ESI          // EDX:EAX := abs(Dividend)
        SAR     EDI, 31
        XOR     ESI, EDI          // 0 if X and Y have same sign
        XOR     EBX, EDI
        XOR     ECX, EDI
        SUB     EBX, EDI
        SBB     ECX, EDI          // ECX:EBX := abs(Divisor)
        JNZ     @@BigDivisor      // divisor > 32^32-1
        CMP     EDX, EBX          // only one division needed ? (ecx = 0)
        JB      @@OneDiv          // yes, one division sufficient
        MOV     ECX, EAX          // save dividend-lo in ecx
        MOV     EAX, EDX          // get dividend-hi
        XOR     EDX, EDX          // zero extend it into edx:eax
        DIV     EBX               // quotient-hi in eax
        XCHG    EAX, ECX          // ecx = quotient-hi, eax =dividend-lo
@@OneDiv:
        DIV     EBX               // eax = quotient-lo
        MOV     EDX, ECX          // edx = quotient-hi(quotient in edx:eax)
        JMP     @SetSign
@@BigDivisor:
        SUB     ESP, 12           // Create three local variables.
        MOV     [ESP  ], EAX      // dividend_lo
        MOV     [ESP+4], EBX      // divisor_lo
        MOV     [ESP+8], EDX      // dividend_hi
        MOV     EDI, ECX          //  edi:ebx and ecx:esi
        SHR     EDX, 1            // shift both
        RCR     EAX, 1            //  divisor and
        ROR     EDI, 1            //   and dividend
        RCR     EBX, 1            //    right by 1 bit
        BSR     ECX, ECX          // ecx = number of remaining shifts
        SHRD    EBX, EDI, CL      // scale down divisor and
        SHRD    EAX, EDX, CL      //   dividend such that divisor
        SHR     EDX, CL           //    less than 2^32 (i.e. fits in ebx)
        ROL     EDI, 1            // restore original divisor (edi:esi)
        DIV     EBX               // compute quotient
        MOV     EBX, [ESP]        // dividend_lo
        MOV     ECX, EAX          // save quotient
        IMUL    EDI, EAX          // quotient * divisor hi-word (low only)
        MUL     DWORD PTR [ESP+4] // quotient * divisor low word
        ADD     EDX, EDI          // edx:eax = quotient * divisor
        SUB     EBX, EAX          // dividend-lo - (quot.*divisor)-lo
        MOV     EAX, ECX          // get quotient
        MOV     ECX, [ESP+8]      // dividend_hi
        SBB     ECX, EDX          // subtract divisor * quot. from dividend
        SBB     EAX, 0            // Adjust quotient if remainder is negative.
        XOR     EDX, EDX          // clear hi-word of quot (eax<=FFFFFFFFh)
        ADD     ESP, 12           // Remove local variables.
@SetSign:
        XOR     EAX, ESI          // If (quotient < 0),
        XOR     EDX, ESI          //   compute 1's complement of result.
        SUB     EAX, ESI          // If (quotient < 0),
        SBB     EDX, ESI          //   compute 2's complement of result.
@Done:
        POP     EDI
        POP     ESI
        POP     EBX
        RET     8
end;

procedure __llmod;
asm
        push    ebp
        push    ebx
        push    esi
        push    edi
        xor   edi,edi
//
//       dividend is pushed last, therefore the first in the args
//       divisor next.
//
        mov     ebx,20[esp]             // get the first low word
        mov     ecx,24[esp]             // get the first high word
        or      ecx,ecx
        jnz     @__llmod@slow_ldiv      // both high words are zero

        or      edx,edx
        jz      @__llmod@quick_ldiv

        or      ebx,ebx
        jz      @__llmod@quick_ldiv     // if ecx:ebx == 0 force a zero divide
          // we don't expect this to actually
          // work
@__llmod@slow_ldiv:
//
//               Signed division should be done.  Convert negative
//               values to positive and do an unsigned division.
//               Store the sign value in the next higher bit of
//               di (test mask of 4).  Thus when we are done, testing
//               that bit will determine the sign of the result.
//
        or      edx,edx                 // test sign of dividend
        jns     @__llmod@onepos
        neg     edx
        neg     eax
        sbb     edx,0                   // negate dividend
        or      edi,1

@__llmod@onepos:
        or      ecx,ecx                 // test sign of divisor
        jns     @__llmod@positive
        neg     ecx
        neg     ebx
        sbb     ecx,0                   // negate divisor

@__llmod@positive:
        mov     ebp,ecx
        mov     ecx,64                  // shift counter
        push    edi                     // save the flags
//
//       Now the stack looks something like this:
//
//               24[esp]: divisor (high dword)
//               20[esp]: divisor (low dword)
//               16[esp]: return EIP
//               12[esp]: previous EBP
//                8[esp]: previous EBX
//                4[esp]: previous ESI
//                 [esp]: previous EDI
//
        xor     edi,edi                 // fake a 64 bit dividend
        xor     esi,esi

@__llmod@xloop:
        shl     eax,1                   // shift dividend left one bit
        rcl     edx,1
        rcl     esi,1
        rcl     edi,1
        cmp     edi,ebp                 // dividend larger?
        jb      @__llmod@nosub
        ja      @__llmod@subtract
        cmp     esi,ebx                 // maybe
        jb      @__llmod@nosub

@__llmod@subtract:
        sub     esi,ebx
        sbb     edi,ebp                 // subtract the divisor
        inc     eax                     // build quotient

@__llmod@nosub:
        loop    @__llmod@xloop
//
//       When done with the loop the four registers values' look like:
//
//       |     edi    |    esi     |    edx     |    eax     |
//       |        remainder        |         quotient        |
//
        mov     eax,esi
        mov     edx,edi                 // use remainder

        pop     ebx                     // get control bits
        test    ebx,1                   // needs negative
        jz      @__llmod@finish
        neg     edx
        neg     eax
        sbb     edx,0                    // negate

@__llmod@finish:
        pop     edi
        pop     esi
        pop     ebx
        pop     ebp
        ret     8

@__llmod@quick_ldiv:
        div     ebx                     // unsigned divide
        xchg  eax,edx
        xor     edx,edx
        jmp     @__llmod@finish
end;

procedure __llmul;
asm
        push  edx
        push  eax

  // Param2 : [ESP+16]:[ESP+12]  (hi:lo)
  // Param1 : [ESP+4]:[ESP]      (hi:lo)

        mov   eax, [esp+16]
        mul   dword ptr [esp]
        mov   ecx, eax

        mov   eax, [esp+4]
        mul   dword ptr [esp+12]
        add   ecx, eax

        mov   eax, [esp]
        mul   dword ptr [esp+12]
        add   edx, ecx

        pop   ecx
        pop   ecx

        ret     8
end;

procedure __lludiv;
asm
        push    ebp
        push    ebx
        push    esi
        push    edi
//
//       Now the stack looks something like this:
//
//               24[esp]: divisor (high dword)
//               20[esp]: divisor (low dword)
//               16[esp]: return EIP
//               12[esp]: previous EBP
//                8[esp]: previous EBX
//                4[esp]: previous ESI
//                 [esp]: previous EDI
//

//       dividend is pushed last, therefore the first in the args
//       divisor next.
//
        mov     ebx,20[esp]             // get the first low word
        mov     ecx,24[esp]             // get the first high word

        or      ecx,ecx
        jnz     @__lludiv@slow_ldiv     // both high words are zero

        or      edx,edx
        jz      @__lludiv@quick_ldiv

        or      ebx,ebx
        jz      @__lludiv@quick_ldiv    // if ecx:ebx == 0 force a zero divide
          // we don't expect this to actually
          // work

@__lludiv@slow_ldiv:
        mov     ebp,ecx
        mov     ecx,64                  // shift counter
        xor     edi,edi                 // fake a 64 bit dividend
        xor     esi,esi

@__lludiv@xloop:
        shl     eax,1                   // shift dividend left one bit
        rcl     edx,1
        rcl     esi,1
        rcl     edi,1
        cmp     edi,ebp                 // dividend larger?
        jb      @__lludiv@nosub
        ja      @__lludiv@subtract
        cmp     esi,ebx                 // maybe
        jb      @__lludiv@nosub

@__lludiv@subtract:
        sub     esi,ebx
        sbb     edi,ebp                 // subtract the divisor
        inc     eax                     // build quotient

@__lludiv@nosub:
        loop    @__lludiv@xloop
//
//       When done with the loop the four registers values' look like:
//
//       |     edi    |    esi     |    edx     |    eax     |
//       |        remainder        |         quotient        |
//

@__lludiv@finish:
        pop     edi
        pop     esi
        pop     ebx
        pop     ebp
        ret     8

@__lludiv@quick_ldiv:
        div     ebx                     // unsigned divide
        xor     edx,edx
        jmp     @__lludiv@finish
end;

procedure __llshl;
asm
        cmp cl, 32
        jl  @__llshl@below32
        cmp cl, 64
        jl  @__llshl@below64
        xor edx, edx
        xor eax, eax
        ret

@__llshl@below64:
        mov edx, eax
        shl edx, cl
        xor eax, eax
        ret

@__llshl@below32:
        shld  edx, eax, cl
        shl eax, cl
        ret
end;

procedure __llshr;
asm
        cmp cl, 32
        jl  @__llshr@below32
        cmp cl, 64
        jl  @__llshr@below64
        sar edx, 1fh
        mov eax,edx
        ret

@__llshr@below64:
        mov eax, edx
        cdq
        sar eax,cl
        ret

@__llshr@below32:
        shrd  eax, edx, cl
        sar edx, cl
        ret
end;

procedure __llumod;
asm
        push    ebp
        push    ebx
        push    esi
        push    edi
//
//       Now the stack looks something like this:
//
//               24[esp]: divisor (high dword)
//               20[esp]: divisor (low dword)
//               16[esp]: return EIP
//               12[esp]: previous EBP
//                8[esp]: previous EBX
//                4[esp]: previous ESI
//                 [esp]: previous EDI
//

//       dividend is pushed last, therefore the first in the args
//       divisor next.
//
        mov     ebx,20[esp]             // get the first low word
        mov     ecx,24[esp]             // get the first high word
        or      ecx,ecx
        jnz     @__llumod@slow_ldiv     // both high words are zero

        or      edx,edx
        jz      @__llumod@quick_ldiv

        or      ebx,ebx
        jz      @__llumod@quick_ldiv    // if ecx:ebx == 0 force a zero divide
          // we don't expect this to actually
          // work
@__llumod@slow_ldiv:
        mov     ebp,ecx
        mov     ecx,64                  // shift counter
        xor     edi,edi                 // fake a 64 bit dividend
        xor     esi,esi                 //

@__llumod@xloop:
        shl     eax,1                   // shift dividend left one bit
        rcl     edx,1
        rcl     esi,1
        rcl     edi,1
        cmp     edi,ebp                 // dividend larger?
        jb      @__llumod@nosub
        ja      @__llumod@subtract
        cmp     esi,ebx                 // maybe
        jb      @__llumod@nosub

@__llumod@subtract:
        sub     esi,ebx
        sbb     edi,ebp                 // subtract the divisor
        inc     eax                     // build quotient

@__llumod@nosub:
        loop    @__llumod@xloop
//
//       When done with the loop the four registers values' look like:
//
//       |     edi    |    esi     |    edx     |    eax     |
//       |        remainder        |         quotient        |
//
        mov     eax,esi
        mov     edx,edi                 // use remainder

@__llumod@finish:
        pop     edi
        pop     esi
        pop     ebx
        pop     ebp
        ret     8

@__llumod@quick_ldiv:
        div     ebx                     // unsigned divide
        xchg  eax,edx
        xor     edx,edx
        jmp     @__llumod@finish
end;

procedure _localtime; external 'msvcrt.dll' name 'localtime';

function  _strcmp(lpString1, lpString2: PAnsiChar): Integer; cdecl;
begin
  Result := StrComp(lpString1, lpString2);
end;

function  _strncmp(lpString1, lpString2: PAnsiChar; count: Integer): Integer; cdecl;
begin
  Result := StrLComp(lpString1, lpString2, count);
end;

procedure _memset(P: Pointer; B: Byte; count: Integer);cdecl;
begin
  FillChar(P^, count, B);
end;

function _malloc(size: Integer): Pointer; cdecl;
begin
  GetMem(Result, size);
end;

procedure _free(P: Pointer); cdecl;
begin
  FreeMem(P);
end;

function _realloc(P: Pointer; size: Integer): Pointer; cdecl;
begin
  Result := P;
  ReallocMem(Result, size);
end;

procedure _memcpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

procedure _memmove(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

procedure _memcmp; external 'msvcrt.dll' name 'memcmp';

var
  __turboFloat: LongBool = False;

{$L note.sqlite3secure.v3.7.14.obj}

function _sqlite3_libversion: PAnsiChar; cdecl; external;
function _sqlite3_sourceid: PAnsiChar; cdecl; external;
function _sqlite3_libversion_number: Integer; cdecl; external;
function _sqlite3_threadsafe: Integer; cdecl; external;
function _sqlite3_close(db: PSQLite3): Integer; cdecl; external;
function _sqlite3_exec(db: PSQLite3; const sql: PAnsiChar; callback: TSQLite3Callback; pArg: Pointer; errmsg: PPAnsiChar): Integer; cdecl; external;
function _sqlite3_initialize: Integer; cdecl; external;
function _sqlite3_shutdown: Integer; cdecl; external;
function _sqlite3_os_init: Integer; cdecl; external;
function _sqlite3_os_end: Integer; cdecl; external;
{$IFDEF SQLITE_EXPERIMENTAL}
function _sqlite3_config(op: Integer{; ...}): Integer; cdecl; external;
function _sqlite3_db_config(db: PSQLite3; op: Integer{; ...}): Integer; cdecl; external;
{$ENDIF}
function _sqlite3_extended_result_codes(db: PSQLite3; onoff: Integer): Integer; cdecl; external;
function _sqlite3_last_insert_rowid(db: PSQLite3): Int64; cdecl; external;
function _sqlite3_changes(db: PSQLite3): Integer; cdecl; external;
function _sqlite3_total_changes(db: PSQLite3): Integer; cdecl; external;
procedure _sqlite3_interrupt(db: PSQLite3); cdecl; external;
function _sqlite3_complete(const sql: PAnsiChar): Integer; cdecl; external;
function _sqlite3_complete16(const sql: PWideChar): Integer; cdecl; external;
function _sqlite3_busy_handler(db: PSQLite3; xBusy: TSQLite3BusyCallback; pArg: Pointer): Integer; cdecl; external;
function _sqlite3_busy_timeout(db: PSQLite3; ms: Integer): Integer; cdecl; external;
function _sqlite3_get_table(db: PSQLite3; const zSql: PAnsiChar; var pazResult: PPAnsiCharArray; pnRow: PInteger; pnColumn: PInteger; pzErrmsg: PPAnsiChar): Integer; cdecl; external;
procedure _sqlite3_free_table(result: PPAnsiCharArray); cdecl; external;
function _sqlite3_mprintf(const zFormat: PAnsiChar{; ...}): PAnsiChar; cdecl; external;
function _sqlite3_vmprintf(const zFormat: PAnsiChar; ap: Pointer{va_list}): PAnsiChar; cdecl; external;
function _sqlite3_snprintf(n: Integer; zBuf: PAnsiChar; const zFormat: PAnsiChar{; ...}): PAnsiChar; cdecl; external;
function _sqlite3_malloc(n: Integer): Pointer; cdecl; external;
function _sqlite3_realloc(pOld: Pointer; n: Integer): Pointer; cdecl; external;
procedure _sqlite3_free(p: Pointer); cdecl; external;
function _sqlite3_memory_used: Int64; cdecl; external;
function _sqlite3_memory_highwater(resetFlag: Integer): Int64; cdecl; external;
procedure _sqlite3_randomness(N: Integer; P: Pointer); cdecl; external;
function _sqlite3_set_authorizer(db: PSQLite3; xAuth: TSQLite3AuthorizerCallback; pUserData: Pointer): Integer; cdecl; external;
procedure _sqlite3_progress_handler(db: PSQLite3; nOps: Integer; xProgress: TSQLite3ProgressCallback; pArg: Pointer); cdecl; external;
function _sqlite3_open(const filename: PAnsiChar; var ppDb: PSQLite3): Integer; cdecl; external ;
function _sqlite3_open16(const filename: PWideChar; var ppDb: PSQLite3): Integer; cdecl; external;
function _sqlite3_open_v2(const filename: PAnsiChar; var ppDb: PSQLite3; flags: Integer; const zVfs: PAnsiChar): Integer; cdecl; external;
function _sqlite3_errcode(db: PSQLite3): Integer; cdecl; external;
function _sqlite3_extended_errcode(db: PSQLite3): Integer; cdecl; external;
function _sqlite3_errmsg(db: PSQLite3): PAnsiChar; cdecl; external;
function _sqlite3_errmsg16(db: PSQLite3): PWideChar; cdecl; external;
function _sqlite3_limit(db: PSQLite3; limitId: Integer; newLimit: Integer): Integer; cdecl; external;
function _sqlite3_prepare(db: PSQLite3; const zSql: PAnsiChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPAnsiChar): Integer; cdecl; external;
function _sqlite3_prepare_v2(db: PSQLite3; const zSql: PAnsiChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPAnsiChar): Integer; cdecl; external;
function _sqlite3_prepare16(db: PSQLite3; const zSql: PWideChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPWideChar): Integer; cdecl; external;
function _sqlite3_prepare16_v2(db: PSQLite3; const zSql: PWideChar; nByte: Integer; var ppStmt: PSQLite3Stmt; const pzTail: PPWideChar): Integer; cdecl; external;
function _sqlite3_sql(pStmt: PSQLite3Stmt): PAnsiChar; cdecl; external;
function _sqlite3_bind_blob(pStmt: PSQLite3Stmt; i: Integer; const zData: Pointer; n: Integer; xDel: TSQLite3DestructorType): Integer; cdecl; external;
function _sqlite3_bind_double(pStmt: PSQLite3Stmt; i: Integer; rValue: Double): Integer; cdecl; external;
function _sqlite3_bind_int(p: PSQLite3Stmt; i: Integer; iValue: Integer): Integer; cdecl; external;
function _sqlite3_bind_int64(pStmt: PSQLite3Stmt; i: Integer; iValue: Int64): Integer; cdecl; external;
function _sqlite3_bind_null(pStmt: PSQLite3Stmt; i: Integer): Integer; cdecl; external;
function _sqlite3_bind_text(pStmt: PSQLite3Stmt; i: Integer; const zData: PAnsiChar; n: Integer; xDel: TSQLite3DestructorType): Integer; cdecl; external;
function _sqlite3_bind_text16(pStmt: PSQLite3Stmt; i: Integer; const zData: PWideChar; nData: Integer; xDel: TSQLite3DestructorType): Integer; cdecl; external;
function _sqlite3_bind_value(pStmt: PSQLite3Stmt; i: Integer; const pValue: PSQLite3Value): Integer; cdecl; external;
function _sqlite3_bind_zeroblob(pStmt: PSQLite3Stmt; i: Integer; n: Integer): Integer; cdecl; external;
function _sqlite3_bind_parameter_count(pStmt: PSQLite3Stmt): Integer; cdecl; external;
function _sqlite3_bind_parameter_name(pStmt: PSQLite3Stmt; i: Integer): PAnsiChar; cdecl; external;
function _sqlite3_bind_parameter_index(pStmt: PSQLite3Stmt; const zName: PAnsiChar): Integer; cdecl; external;
function _sqlite3_clear_bindings(pStmt: PSQLite3Stmt): Integer; cdecl; external;
function _sqlite3_column_count(pStmt: PSQLite3Stmt): Integer; cdecl; external;
function _sqlite3_column_name(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl; external;
function _sqlite3_column_name16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl; external;
//{$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
//function _sqlite3_column_database_name(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl; external;
//function _sqlite3_column_database_name16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl; external;
//function _sqlite3_column_table_name(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl; external;
//function _sqlite3_column_table_name16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl; external;
//function _sqlite3_column_origin_name(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl; external;
//function _sqlite3_column_origin_name16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl; external;
//{$ENDIF}
function _sqlite3_column_decltype(pStmt: PSQLite3Stmt; N: Integer): PAnsiChar; cdecl; external;
function _sqlite3_column_decltype16(pStmt: PSQLite3Stmt; N: Integer): PWideChar; cdecl; external;
function _sqlite3_step(pStmt: PSQLite3Stmt): Integer; cdecl; external;
function _sqlite3_data_count(pStmt: PSQLite3Stmt): Integer; cdecl; external;
function _sqlite3_column_blob(pStmt: PSQLite3Stmt; iCol: Integer): Pointer; cdecl; external;
function _sqlite3_column_bytes(pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl; external;
function _sqlite3_column_bytes16(pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl; external;
function _sqlite3_column_double(pStmt: PSQLite3Stmt; iCol: Integer): Double; cdecl; external;
function _sqlite3_column_int(pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl; external;
function _sqlite3_column_int64(pStmt: PSQLite3Stmt; iCol: Integer): Int64; cdecl; external;
function _sqlite3_column_text(pStmt: PSQLite3Stmt; iCol: Integer): PAnsiChar; cdecl; external;
function _sqlite3_column_text16(pStmt: PSQLite3Stmt; iCol: Integer): PWideChar; cdecl; external;
function _sqlite3_column_type(pStmt: PSQLite3Stmt; iCol: Integer): Integer; cdecl; external;
function _sqlite3_column_value(pStmt: PSQLite3Stmt; iCol: Integer): PSQLite3Value; cdecl; external;
function _sqlite3_finalize(pStmt: PSQLite3Stmt): Integer; cdecl; external;
function _sqlite3_reset(pStmt: PSQLite3Stmt): Integer; cdecl; external;
function _sqlite3_create_function(db: PSQLite3; const zFunctionName: PAnsiChar; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: TSQLite3RegularFunction; xStep: TSQLite3AggregateStep; xFinal: TSQLite3AggregateFinalize): Integer; cdecl; external;
function _sqlite3_create_function16(db: PSQLite3; const zFunctionName: PWideChar; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: TSQLite3RegularFunction; xStep: TSQLite3AggregateStep; xFinal: TSQLite3AggregateFinalize): Integer; cdecl; external;
{$IFDEF SQLITE_DEPRECATED}
function _sqlite3_aggregate_count(p: PSQLite3Context): Integer; cdecl; external;
function _sqlite3_expired(pStmt: PSQLite3Stmt): Integer; cdecl; external;
function _sqlite3_transfer_bindings(pFromStmt: PSQLite3Stmt; pToStmt: PSQLite3Stmt): Integer; cdecl; external;
function _sqlite3_global_recover: Integer; cdecl; external;
procedure _sqlite3_thread_cleanup; cdecl; external;
function _sqlite3_memory_alarm(xCallback: TSQLite3MemoryAlarmCallback; pArg: Pointer; iThreshold: Int64): Integer; cdecl; external;
{$ENDIF}
function _sqlite3_value_blob(pVal: PSQLite3Value): Pointer; cdecl; external;
function _sqlite3_value_bytes(pVal: PSQLite3Value): Integer; cdecl; external;
function _sqlite3_value_bytes16(pVal: PSQLite3Value): Integer; cdecl; external;
function _sqlite3_value_double(pVal: PSQLite3Value): Double; cdecl; external;
function _sqlite3_value_int(pVal: PSQLite3Value): Integer; cdecl; external;
function _sqlite3_value_int64(pVal: PSQLite3Value): Int64; cdecl; external;
function _sqlite3_value_text(pVal: PSQLite3Value): PAnsiChar; cdecl; external;
function _sqlite3_value_text16(pVal: PSQLite3Value): PWideChar; cdecl; external;
function _sqlite3_value_text16le(pVal: PSQLite3Value): Pointer; cdecl; external;
function _sqlite3_value_text16be(pVal: PSQLite3Value): Pointer; cdecl; external;
function _sqlite3_value_type(pVal: PSQLite3Value): Integer; cdecl; external;
function _sqlite3_value_numeric_type(pVal: PSQLite3Value): Integer; cdecl; external;
function _sqlite3_aggregate_context(p: PSQLite3Context; nBytes: Integer): Pointer; cdecl; external;
function _sqlite3_user_data(p: PSQLite3Context): Pointer; cdecl; external;
function _sqlite3_context_db_handle(p: PSQLite3Context): PSQLite3; cdecl; external;
function _sqlite3_get_auxdata(pCtx: PSQLite3Context; N: Integer): Pointer; cdecl; external;
procedure _sqlite3_set_auxdata(pCtx: PSQLite3Context; N: Integer; pAux: Pointer; xDelete: TSQLite3AuxDataDestructor); cdecl; external;
procedure _sqlite3_result_blob(pCtx: PSQLite3Context; const z: Pointer; n: Integer; xDel: TSQLite3DestructorType); cdecl; external;
procedure _sqlite3_result_double(pCtx: PSQLite3Context; rVal: Double); cdecl; external;
procedure _sqlite3_result_error(pCtx: PSQLite3Context; const z: PAnsiChar; n: Integer); cdecl; external;
procedure _sqlite3_result_error16(pCtx: PSQLite3Context; const z: PWideChar; n: Integer); cdecl; external;
procedure _sqlite3_result_error_toobig(pCtx: PSQLite3Context); cdecl; external;
procedure _sqlite3_result_error_nomem(pCtx: PSQLite3Context); cdecl; external;
procedure _sqlite3_result_error_code(pCtx: PSQLite3Context; errCode: Integer); cdecl; external;
procedure _sqlite3_result_int(pCtx: PSQLite3Context; iVal: Integer); cdecl; external;
procedure _sqlite3_result_int64(pCtx: PSQLite3Context; iVal: Int64); cdecl; external;
procedure _sqlite3_result_null(pCtx: PSQLite3Context); cdecl; external;
procedure _sqlite3_result_text(pCtx: PSQLite3Context; const z: PAnsiChar; n: Integer; xDel: TSQLite3DestructorType); cdecl; external;
procedure _sqlite3_result_text16(pCtx: PSQLite3Context; const z: PWideChar; n: Integer; xDel: TSQLite3DestructorType); cdecl; external;
procedure _sqlite3_result_text16le(pCtx: PSQLite3Context; const z: Pointer; n: Integer; xDel: TSQLite3DestructorType); cdecl; external;
procedure _sqlite3_result_text16be(pCtx: PSQLite3Context; const z: Pointer; n: Integer; xDel: TSQLite3DestructorType); cdecl; external;
procedure _sqlite3_result_value(pCtx: PSQLite3Context; pValue: PSQLite3Value); cdecl; external;
procedure _sqlite3_result_zeroblob(pCtx: PSQLite3Context; n: Integer); cdecl; external;
function _sqlite3_create_collation(db: PSQLite3; const zName: PAnsiChar; eTextRep: Integer; pUser: Pointer; xCompare: TSQLite3CollationCompare): Integer; cdecl; external;
function _sqlite3_create_collation_v2(db: PSQLite3; const zName: PAnsiChar; eTextRep: Integer; pUser: Pointer; xCompare: TSQLite3CollationCompare; xDestroy: TSQLite3CollationDestructor): Integer; cdecl; external;
function _sqlite3_create_collation16(db: PSQLite3; const zName: PWideChar; eTextRep: Integer; pUser: Pointer; xCompare: TSQLite3CollationCompare): Integer; cdecl; external;
function _sqlite3_collation_needed(db: PSQLite3; pCollNeededArg: Pointer; xCollNeeded: TSQLite3CollationNeededCallback): Integer; cdecl; external;
function _sqlite3_collation_needed16(db: PSQLite3; pCollNeededArg: Pointer; xCollNeeded16: TSQLite3CollationNeededCallback16): Integer; cdecl; external;
function _sqlite3_key(db: PSQLite3; const pKey: Pointer; nKey: Integer): Integer; cdecl; external;
function _sqlite3_rekey(db: PSQLite3; const pKey: Pointer; nKey: Integer): Integer; cdecl; external;
function _sqlite3_sleep(ms: Integer): Integer; cdecl; external;
function _sqlite3_get_autocommit(db: PSQLite3): Integer; cdecl; external;
function _sqlite3_db_handle(pStmt: PSQLite3Stmt): PSQLite3; cdecl; external;
function _sqlite3_next_stmt(pDb: PSQLite3; pStmt: PSQLite3Stmt): PSQLite3Stmt; cdecl; external;
function _sqlite3_commit_hook(db: PSQLite3; xCallback: TSQLite3CommitCallback; pArg: Pointer): Pointer; cdecl; external;
function _sqlite3_rollback_hook(db: PSQLite3; xCallback: TSQLite3RollbackCallback; pArg: Pointer): Pointer; cdecl; external;
function _sqlite3_update_hook(db: PSQLite3; xCallback: TSQLite3UpdateCallback; pArg: Pointer): Pointer; cdecl; external;
function _sqlite3_enable_shared_cache(enable: Integer): Integer; cdecl; external;
function _sqlite3_release_memory(n: Integer): Integer; cdecl; external;
procedure _sqlite3_soft_heap_limit(n: Integer); cdecl; external;
//{$IFDEF SQLITE_ENABLE_COLUMN_METADATA}
//function _sqlite3_table_column_metadata(db: PSQLite3; const zDbName: PAnsiChar; const zTableName: PAnsiChar; const zColumnName: PAnsiChar; const pzDataType: PPAnsiChar; const pzCollSeq: PPAnsiChar; pNotNull: PInteger; pPrimaryKey: PInteger; pAutoinc: PInteger): Integer; cdecl; external;
//{$ENDIF}
function _sqlite3_load_extension(db: PSQLite3; const zFile: PAnsiChar; const zProc: PAnsiChar; pzErrMsg: PPAnsiChar): Integer; cdecl; external;
function _sqlite3_enable_load_extension(db: PSQLite3; onoff: Integer): Integer; cdecl; external;
function _sqlite3_auto_extension(xEntryPoint: TSQLiteAutoExtensionEntryPoint): Integer; cdecl; external;
procedure _sqlite3_reset_auto_extension; cdecl; external;
{$IFDEF SQLITE_EXPERIMENTAL}
function _sqlite3_create_module(db: PSQLite3; const zName: PAnsiChar; const p: PSQLite3Module; pClientData: Pointer): Integer; cdecl; external;
function _sqlite3_create_module_v2(db: PSQLite3; const zName: PAnsiChar; const p: PSQLite3Module; pClientData: Pointer; xDestroy: TSQLite3ModuleDestructor): Integer; cdecl; external;
function _sqlite3_declare_vtab(db: PSQLite3; const zSQL: PAnsiChar): Integer; cdecl; external;
function _sqlite3_overload_function(db: PSQLite3; const zFuncName: PAnsiChar; nArg: Integer): Integer; cdecl; external;
{$ENDIF}
function _sqlite3_blob_open(db: PSQLite3; const zDb: PAnsiChar; const zTable: PAnsiChar; const zColumn: PAnsiChar; iRow: Int64; flags: Integer; var ppBlob: PSQLite3Blob): Integer; cdecl; external;
function _sqlite3_blob_close(pBlob: PSQLite3Blob): Integer; cdecl; external;
function _sqlite3_blob_bytes(pBlob: PSQLite3Blob): Integer; cdecl; external;
function _sqlite3_blob_read(pBlob: PSQLite3Blob; Z: Pointer; N: Integer; iOffset: Integer): Integer; cdecl; external;
function _sqlite3_blob_write(pBlob: PSQLite3Blob; const z: Pointer; n: Integer; iOffset: Integer): Integer; cdecl; external;
function _sqlite3_vfs_find(const zVfsName: PAnsiChar): PSQLite3VFS; cdecl; external;
function _sqlite3_vfs_register(pVfs: PSQLite3VFS; makeDflt: Integer): Integer; cdecl; external;
function _sqlite3_vfs_unregister(pVfs: PSQLite3VFS): Integer; cdecl; external;
function _sqlite3_mutex_alloc(id: Integer): PSQLite3Mutex; cdecl; external;
procedure _sqlite3_mutex_free(p: PSQLite3Mutex); cdecl; external;
procedure _sqlite3_mutex_enter(p: PSQLite3Mutex); cdecl; external;
function _sqlite3_mutex_try(p: PSQLite3Mutex): Integer; cdecl; external;
procedure _sqlite3_mutex_leave(p: PSQLite3Mutex); cdecl; external;
{$IFDEF SQLITE_DEBUG}
function _sqlite3_mutex_held(p: PSQLite3Mutex): Integer; cdecl; external;
function _sqlite3_mutex_notheld(p: PSQLite3Mutex): Integer; cdecl; external;
{$ENDIF}
function _sqlite3_db_mutex(db: PSQLite3): PSQLite3Mutex; cdecl; external;
function _sqlite3_file_control(db: PSQLite3; const zDbName: PAnsiChar;
    op: Integer; pArg: Pointer): Integer; cdecl; external;
function _sqlite3_test_control(op: Integer{; ...}): Integer; cdecl; external;
{$IFDEF SQLITE_EXPERIMENTAL}
function _sqlite3_trace(db: PSQLite3;
    xTrace: TSQLite3TraceCallback; pArg: Pointer): Pointer; cdecl; external;
function _sqlite3_profile(db: PSQLite3;
    xProfile: TSQLite3ProfileCallback; pArg: Pointer): Pointer; cdecl; external;

function _sqlite3_status(op: Integer; var pCurrent: Integer;
    var pHighwater: Integer; resetFlag: Integer): Integer; cdecl; external;
function _sqlite3_db_status(db: PSQLite3; op: Integer; var pCur: Integer;
    var pHiwtr: Integer; resetFlg: Integer): Integer; cdecl; external;
function _sqlite3_stmt_status(pStmt: PSQLite3Stmt; op: Integer; resetFlg: Integer): Integer; cdecl; external;
function _sqlite3_backup_init(pDest: PSQLite3; const zDestName: PAnsiChar;
    pSource: PSQLite3; const zSourceName: PAnsiChar): PSQLite3Backup; cdecl; external;
function _sqlite3_backup_step(p: PSQLite3Backup; nPage: Integer): Integer; cdecl; external;
function _sqlite3_backup_finish(p: PSQLite3Backup): Integer; cdecl; external;
function _sqlite3_backup_remaining(p: PSQLite3Backup): Integer; cdecl; external;
function _sqlite3_backup_pagecount(p: PSQLite3Backup): Integer; cdecl; external;
{$IFDEF SQLITE_ENABLE_UNLOCK_NOTIFY}
function _sqlite3_unlock_notify(pBlocked: PSQLite3;
  xNotify: TSQLite3UnlockNotifyCallback; pNotifyArg: Pointer): Integer; cdecl; external;
{$ENDIF}

function _sqlite3_strnicmp(const zLeft: PAnsiChar; const zRight: PAnsiChar; N: Integer): Integer; cdecl; external;
{$ENDIF}

{$ENDIF}

end.
