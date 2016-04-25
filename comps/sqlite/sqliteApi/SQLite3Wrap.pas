unit SQLite3Wrap;

{$IFDEF MSWINDOWS}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}
{$ENDIF}

interface

{$IFDEF MSWINDOWS}
uses
  Windows, SysUtils, Classes, Types, SQLite3;

const
  SQLite_FirstBindParamIndex = 1;

type
  ESQLite3Error = class(Exception)
  public
    FErrorCode: Integer;
  public
    constructor Create(const Msg: string; ErrorCode: Integer); overload;
    constructor CreateFmt(const Msg: string; const Args: array of const; ErrorCode: Integer); overload;
    property ErrorCode: Integer read FErrorCode;
  end;

  TSQLite3Statement = class;
  TSQLite3BlobHandler = class;

  // Busy处理模式
  // bmAuto：自动，主线程为 bmOpenAlway，子线程为 bmOpenClose
  // bmOpenClose: 只在读写时打开，读写完成后关闭，效率会比较低
  // bmOpenAlway: 总是打开
  TSQLite3BusyMode = (bmAuto, bmOpenClose, bmOpenAlway);

  { TSQLite3Database class }

  TSQLite3Database = class(TObject)
  public
    FHandle: PSQLite3;
    FStatementList: TList;
    FBlobHandlerList: TList;
    FBlobStreamList: TList;
    FTransactionOpen: Boolean;
    FFileName: WideString;
    FLastError: Integer;

    procedure CheckHandle;
  public
    procedure DoAddBlobStream(BlobStream: TStream);
    procedure DoRemoveBlobStream(BlobStream: TStream);
  public
    constructor Create;
    destructor Destroy; override;
    function Check(const ErrCode: Integer; CheckCode: Integer = SQLITE_OK): Boolean; overload;
    function Check(const ErrCode: Integer; const CheckCode: array of Integer): Boolean; overload;

    function Open(const FileName: WideString;
      AOpenFlag: integer;// = SQLITE_OPEN_CREATE or SQLITE_OPEN_READWRITE or SQLITE_OPEN_NOMUTEX;
      Key: Pointer = nil;
      KeyLen: Integer = 0): Boolean; virtual;
    procedure Close; virtual;

    function Execute(const SQL: WideString): Boolean; overload;
    function Execute(const SQL: WideString; const CheckCode: array of Integer): Boolean; overload;
    function LastInsertRowID: Int64;
    function LastChanges: Integer;
    function Prepare(const SQL: WideString): TSQLite3Statement;
    function BlobOpen(const Table, Column: WideString; const RowID: Int64; const WriteAccess: Boolean = True): TSQLite3BlobHandler;
    function BlobOpenStream(const Table, Column: WideString; const RowID: Int64; const WriteAccess: Boolean = True; BusyMode: TSQLite3BusyMode = bmAuto): TStream; //TSQLite3BlobStream;
    function IndexStatement(Statement: TSQLite3Statement): Integer;

    procedure BeginTransaction;
    procedure Commit;
    procedure Rollback;

    property Handle: PSQLite3 read FHandle;
    property TransactionOpen: Boolean read FTransactionOpen;
    property FileName: WideString read FFileName;
    property LastError: Integer read FLastError;
  end;

  { TSQLite3Statement class }

  TSQLite3Statement = class(TObject)
  public
    FSql: string;
    FHandle: PSQLite3Stmt;
    FOwnerDatabase: TSQLite3Database;
    FStrList: TList;
    procedure ClearStrList;
    function ParamIndexByName(const ParamName: WideString): Integer;
  public
    constructor Create(OwnerDatabase: TSQLite3Database; const SQL: WideString);
    destructor Destroy; override;

    procedure BindInt(const ParamIndex: Integer; const Value: Integer); overload;
    procedure BindInt64(const ParamIndex: Integer; const Value: Int64); overload;
    procedure BindDouble(const ParamIndex: Integer; const Value: Double); overload;
    procedure BindText(const ParamIndex: Integer; const Value: WideString); overload;
    procedure BindAnsiText(const ParamIndex: Integer; const Value: AnsiString); overload;
    procedure BindTextPtr(const ParamIndex: Integer; Ptr: Pointer; Len: Integer); overload;
    procedure BindNull(const ParamIndex: Integer); overload;
    procedure BindBlob(const ParamIndex: Integer; Data: Pointer; const Size: Integer); overload;
    procedure BindZeroBlob(const ParamIndex: Integer; const Size: Integer); overload;

    procedure BindInt(const ParamName: WideString; const Value: Integer); overload;
    procedure BindInt64(const ParamName: WideString; const Value: Int64); overload;
    procedure BindDouble(const ParamName: WideString; const Value: Double); overload;
    procedure BindText(const ParamName: WideString; const Value: WideString); overload;
    procedure BindUnicodeText(const ParamIndex: Integer; const Value: string); overload;
    procedure BindUnicodeText(const ParamName: WideString; const Value: string); overload;
    procedure BindAnsiText(const ParamName: WideString; const Value: AnsiString); overload;
    procedure BindTextPtr(const ParamName: WideString; Ptr: Pointer; Len: Integer); overload;
    procedure BindNull(const ParamName: WideString); overload;
    procedure BindBlob(const ParamName: WideString; Data: Pointer; const Size: Integer); overload;
    procedure BindZeroBlob(const ParamName: WideString; const Size: Integer); overload;
	  procedure ClearBindings;

    function Step: Integer;

    function ColumnCount: Integer;
    function ColumnName(ColumnIndex: Integer): WideString;
    function ColumnType(ColumnIndex: Integer): Integer;
    function ColumnInt(ColumnIndex: Integer): Integer;
    function ColumnInt64(ColumnIndex: Integer): Int64;
    function ColumnDouble(ColumnIndex: Integer): Double;
    function ColumnAnsiText(ColumnIndex: Integer): AnsiString;
    function ColumnText(ColumnIndex: Integer): WideString;
    function ColumnUnicodeText(ColumnIndex: Integer): string;
    function ColumnTextPtr(ColumnIndex: Integer): Pointer;
    function ColumnTextToStream(ColumnIndex: Integer; Stream: TStream): Integer;
    function ColumnBlob(ColumnIndex: Integer): Pointer;
    function ColumnBlobToStream(ColumnIndex: Integer; Stream: TStream): Integer;
    function ColumnBytes(ColumnIndex: Integer): Integer;

    procedure Reset;
    procedure StepAndReset;

    property Handle: PSQLite3Stmt read FHandle;
    property OwnerDatabase: TSQLite3Database read FOwnerDatabase;
  end;

  { TSQLite3BlobHandler class }

  TSQLite3BlobHandler = class(TObject)
  public
    FHandle: PSQLite3Blob;
    FOwnerDatabase: TSQLite3Database;
  public
    constructor Create(OwnerDatabase: TSQLite3Database; const Table, Column: WideString; const RowID: Int64; const WriteAccess: Boolean = True);
    destructor Destroy; override;

    function Bytes: Integer;
    procedure Read(Buffer: Pointer; const Size, Offset: Integer);
    procedure Write(Buffer: Pointer; const Size, Offset: Integer);

    property Handle: PSQLite3Blob read FHandle;
    property OwnerDatabase: TSQLite3Database read FOwnerDatabase;
  end;

var
  SQLiteLogError: procedure(ALog: string);
  SQLiteLogErrorFormat: procedure(const format: string; const args: array of const);
         
const
  SQLITE_MAINTHREAD_BUSYTIME = 30 * 1000;   // 主线程等待超时时间

var
  G_SqliteMainBusy: Boolean;  // 主线程是否正忙
  G_SqliteAnyBusy: Boolean;   // 任何一个线程是否正忙
  G_BusyStart: Cardinal;

{$ENDIF}

implementation

{$IFDEF MSWINDOWS}
uses
  SQLite3Utils,
  SQLite3WrapBlob;

resourcestring
  SErrorMessage = 'SQLite3 error: %s';
  SDatabaseNotConnected = 'SQLite3 error: database is not connected.';
  STransactionAlreadyOpen = 'Transaction is already opened.';
  SNoTransactionOpen = 'No transaction is open';

function DoSQLite3BusyCallback(ptr: Pointer; count: Integer): Integer; cdecl;
begin
  G_SqliteAnyBusy := True;

  if GetCurrentThreadId = MainThreadID then
  begin
    G_SqliteMainBusy := True;

    if count = 0 then
    begin
      G_BusyStart := GetTickCount;
      Result := 1;
    end
    else if GetTickCount - G_BusyStart > SQLITE_MAINTHREAD_BUSYTIME then
      Result := 0
    else
      Result := 1;
  end
  else
  begin
    Result := 1; // 子线程里面就无限等待
  end;
end;

{ TSQLite3Database }

procedure TSQLite3Database.BeginTransaction;
begin
  if not FTransactionOpen then
  begin
    Execute('BEGIN TRANSACTION;'); // TODO: BEGIN TRANSACTION
    FTransactionOpen := True;
  end
  else
  begin
    if Assigned(SQLiteLogError)  then
      SQLiteLogError('SQLite: Transaction is already open.');
//    raise ESQLite3Error.Create(STransactionAlreadyOpen);
  end;
end;

function TSQLite3Database.BlobOpen(const Table, Column: WideString;
  const RowID: Int64; const WriteAccess: Boolean): TSQLite3BlobHandler;
begin
  Result := TSQLite3BlobHandler.Create(Self, Table, Column, RowID, WriteAccess);
end;

function TSQLite3Database.BlobOpenStream(const Table, Column: WideString;
  const RowID: Int64; const WriteAccess: Boolean; BusyMode: TSQLite3BusyMode): TStream; //TSQLite3BlobStream;
begin
  Result := TSQLite3BlobStream.Create(Self, Table, Column, RowID, WriteAccess, BusyMode);
end;

function TSQLite3Database.Check(const ErrCode: Integer; CheckCode: Integer): Boolean;
var
  errorMessage: string;
begin
  Result := ErrCode = CheckCode;
  FLastError := ErrCode;
  if ErrCode <> CheckCode then
  begin
    errorMessage := Format(SErrorMessage, [UTF8ToStr(_sqlite3_errmsg(FHandle))]);
    if Assigned(SQLiteLogErrorFormat) then
    begin
      SQLiteLogErrorFormat('SQLite Error: %s. ErrorCode: %d', [errorMessage, ErrCode]);
//    raise ESQLite3Error.Create(errorMessage, ErrCode);
    end;
  end;
end;

function TSQLite3Database.Check(const ErrCode: Integer;
  const CheckCode: array of Integer): Boolean;
var
  i: Integer;
begin
//  Result := false;
  FLastError := ErrCode;
  for i := Low(CheckCode) to High(CheckCode) do
  begin
    if CheckCode[i] = ErrCode then
    begin
      Result := true;
      Exit;
    end;
  end;
  raise ESQLite3Error.CreateFmt(SErrorMessage, [UTF8ToStr(_sqlite3_errmsg(FHandle))], ErrCode);
end;

procedure TSQLite3Database.CheckHandle;
begin
  if FHandle = nil then
    raise ESQLite3Error.Create(SDatabaseNotConnected);
end;

procedure TSQLite3Database.Close;
var
  I: Integer;
begin
  if FHandle <> nil then
  begin
    if FTransactionOpen then
      Rollback;
    // Delete all statements
    for I := FStatementList.Count - 1 downto 0 do
      TSQLite3Statement(FStatementList[I]).Free;
    // Delete all blob handlers
    for I := FBlobHandlerList.Count - 1 downto 0 do
      TSQLite3BlobHandler(FBlobHandlerList[I]).Free;
    // Delete all blob writestreams
    for I := FBlobStreamList.Count - 1 downto 0 do
      TSQLite3BlobStream(FBlobStreamList[I]).Free;
      
    _sqlite3_close(FHandle);
    FHandle := nil;
  end;

  FFileName := '';
end;

procedure TSQLite3Database.Commit;
begin
  if FTransactionOpen then
  begin
    Execute('COMMIT;');
    FTransactionOpen := False;
  end
  else
    raise ESQLite3Error.Create(SNoTransactionOpen);
end;

constructor TSQLite3Database.Create;
begin
  FHandle := nil;
  FStatementList := TList.Create;
  FBlobHandlerList := TList.Create;
  FBlobStreamList := TList.Create;
end;

destructor TSQLite3Database.Destroy;
begin
  Close;
  FBlobStreamList.Free;
  FBlobHandlerList.Free;
  FStatementList.Free;
  inherited;
end;

procedure TSQLite3Database.DoAddBlobStream(BlobStream: TStream);
begin
  FBlobStreamList.Add(BlobStream);
end;

procedure TSQLite3Database.DoRemoveBlobStream(BlobStream: TStream);
begin
  FBlobStreamList.Remove(BlobStream);
end;

function TSQLite3Database.Execute(const SQL: WideString; const CheckCode: array of Integer): Boolean;
var
  ret: integer;
begin
  CheckHandle;
  ret := _sqlite3_exec(FHandle, PAnsiChar(StrToUTF8(SQL)), nil, nil, nil);
  Result := Check(ret, CheckCode);
end;

function TSQLite3Database.Execute(const SQL: WideString): Boolean;
begin
  CheckHandle;
  Result := Check(_sqlite3_exec(FHandle, PAnsiChar(StrToUTF8(SQL)), nil, nil, nil));
end;

function TSQLite3Database.IndexStatement(Statement: TSQLite3Statement): Integer;
begin
  Result := FStatementList.IndexOf(Statement);
end;

function TSQLite3Database.LastChanges: Integer;
begin
  CheckHandle;
  Result := _sqlite3_changes(FHandle);
end;

function TSQLite3Database.LastInsertRowID: Int64;
begin
  CheckHandle;
  Result := _sqlite3_last_insert_rowid(FHandle);
end;

// TODO: SQLITE_OPEN_FULLMUTEX将导致SQLite运行在serialized mode，而不是Multi-thread，后续可以优化
// Paul 2012-06-12

//  rc = sqlite3_open(":memory:", &db); sqlite 内存模式
function TSQLite3Database.Open(const FileName: WideString;
  AOpenFlag: integer
//     = SQLITE_OPEN_CREATE or
//    SQLITE_OPEN_READWRITE or
//    SQLITE_OPEN_NOMUTEX // 也就是串行化方式，则对于连接时互斥的，只有一个连接关闭，另外一个连接才能读写
    ;
  Key: Pointer = nil; KeyLen: Integer = 0): Boolean;
var
  ret: integer;
begin
  Close;
  // 采用UTF-8的编码方式
  ret := _sqlite3_open_v2(PAnsiChar(StrToUTF8(FileName)), FHandle,
    AOpenFlag, nil);
  Result := Check(ret);
  if Result then
  begin
    if (Key <> nil) and (KeyLen > 0) then
    try
      Result := Check(_sqlite3_key(FHandle, Key, KeyLen));
    except
      _sqlite3_close(FHandle);
      FHandle := nil;
      raise;
    end;
    Check(_sqlite3_busy_handler(FHandle, @DoSQLite3BusyCallback, Self));
  end;

  FFileName := FileName;
end;

function TSQLite3Database.Prepare(const SQL: WideString): TSQLite3Statement;
begin
  Result := TSQLite3Statement.Create(Self, SQL);
end;

procedure TSQLite3Database.Rollback;
begin
  if FTransactionOpen then
  begin
    Execute('ROLLBACK;');
    FTransactionOpen := False;
  end
  else
    raise ESQLite3Error.Create(SNoTransactionOpen);
end;

{ TSQLite3Statement }

procedure TSQLite3Statement.BindBlob(const ParamIndex: Integer; Data: Pointer;
  const Size: Integer);
begin
  FOwnerDatabase.Check(_sqlite3_bind_blob(FHandle, ParamIndex, Data, Size, SQLITE_STATIC));
end;

procedure TSQLite3Statement.BindDouble(const ParamIndex: Integer;
  const Value: Double);
begin
  FOwnerDatabase.Check(_sqlite3_bind_double(FHandle, ParamIndex, Value));
end;

procedure TSQLite3Statement.BindInt(const ParamIndex, Value: Integer);
begin
  FOwnerDatabase.Check(_sqlite3_bind_int(FHandle, ParamIndex, Value));
end;

procedure TSQLite3Statement.BindInt64(const ParamIndex: Integer;
  const Value: Int64);
begin
  FOwnerDatabase.Check(_sqlite3_bind_int64(FHandle, ParamIndex, Value));
end;

procedure TSQLite3Statement.BindNull(const ParamIndex: Integer);
begin
  FOwnerDatabase.Check(_sqlite3_bind_null(FHandle, ParamIndex));
end;

procedure TSQLite3Statement.BindAnsiText(const ParamIndex: Integer;
  const Value: AnsiString);
var
  P: PAnsiString;
begin
  New(P);
  FStrList.Add(P);
  P^ := Value;
  FOwnerDatabase.Check(
    _sqlite3_bind_text(FHandle, ParamIndex, PAnsiChar(P^), Length(P^), SQLITE_STATIC)
  );
end;

procedure TSQLite3Statement.BindText(const ParamIndex: Integer;
  const Value: WideString);
var
//  S: AnsiString; { UTF-8 string }
  P: PAnsiString;
begin
  // 修改 BindText 的一处 BUG
  // 由于 BindXXX 方法要求在 BindXXX 之后，Step 之前一直有效
  // 参数 const Value: WideString 由于字符串自动管理的特性，可能会被释放
  // 因此增加缓存字符串解决此问题
  New(P);
  FStrList.Add(P);
  P^ := StrToUTF8(Value);
  FOwnerDatabase.Check(
    _sqlite3_bind_text(FHandle, ParamIndex, PAnsiChar(P^), Length(P^), SQLITE_STATIC)
  );
end;

procedure TSQLite3Statement.BindTextPtr(const ParamIndex: Integer; Ptr: Pointer;
  Len: Integer);
begin
  FOwnerDatabase.Check(
    _sqlite3_bind_text(FHandle, ParamIndex, Ptr, Len, SQLITE_STATIC)
  );
end;

procedure TSQLite3Statement.BindZeroBlob(const ParamIndex, Size: Integer);
begin
  FOwnerDatabase.Check(_sqlite3_bind_zeroblob(FHandle, ParamIndex, Size));
end;

procedure TSQLite3Statement.ClearBindings;
begin
  FOwnerDatabase.Check(_sqlite3_clear_bindings(FHandle));
  ClearStrList;
end;

procedure TSQLite3Statement.ClearStrList;
var
  i: Integer;
  pStr: PAnsiString;
begin
  if FStrList <> nil then
  begin
    for i := 0 to FStrList.Count - 1 do
    begin
      pStr := FStrList[i];
      Dispose(pStr);
    end;
    FStrList.Clear;
  end;
end;

function TSQLite3Statement.ColumnAnsiText(ColumnIndex: Integer): AnsiString;
var
  Len: Integer;
  P: PAnsiChar;
begin
  Len := ColumnBytes(ColumnIndex);
  SetLength(Result, Len);
  if Len > 0 then
  begin
    P := _sqlite3_column_text(FHandle, ColumnIndex);
    Move(P^, PAnsiChar(Result)^, Len);
  end;
end;

function TSQLite3Statement.ColumnBlob(ColumnIndex: Integer): Pointer;
begin
  Result := _sqlite3_column_blob(FHandle, ColumnIndex);
end;

function TSQLite3Statement.ColumnBlobToStream(ColumnIndex: Integer;
  Stream: TStream): Integer;
var
  Len: Integer;
  P: Pointer;
begin
  Len := ColumnBytes(ColumnIndex);
  if Len > 0 then
  begin
    P := _sqlite3_column_blob(FHandle, ColumnIndex);
    if P <> nil then
    begin
      Result := Stream.Write(P^, Len);
      Exit;
    end;
  end;

  Result := 0;
end;

function TSQLite3Statement.ColumnBytes(ColumnIndex: Integer): Integer;
begin
  Result := _sqlite3_column_bytes(FHandle, ColumnIndex);
end;

function TSQLite3Statement.ColumnCount: Integer;
begin
  Result := _sqlite3_column_count(FHandle);
end;

function TSQLite3Statement.ColumnDouble(ColumnIndex: Integer): Double;
begin
  Result := _sqlite3_column_double(FHandle, ColumnIndex);
end;

function TSQLite3Statement.ColumnInt(ColumnIndex: Integer): Integer;
begin
  Result := _sqlite3_column_int(FHandle, ColumnIndex);
end;

function TSQLite3Statement.ColumnInt64(ColumnIndex: Integer): Int64;
begin
  Result := _sqlite3_column_int64(FHandle, ColumnIndex);
end;

function TSQLite3Statement.ColumnName(ColumnIndex: Integer): WideString;
begin
  Result := UTF8ToStr(_sqlite3_column_name(FHandle, ColumnIndex));
end;

function TSQLite3Statement.ColumnText(ColumnIndex: Integer): WideString;
var
  Len: Integer;
begin
  Len := ColumnBytes(ColumnIndex);
  Result := UTF8ToStr(_sqlite3_column_text(FHandle, ColumnIndex), Len);
end;

function TSQLite3Statement.ColumnUnicodeText(ColumnIndex: Integer): string;
begin
  {$IF CompilerVersion >= 21.0} // DELPHIXE2
  Result := UTF8ToString(_sqlite3_column_text(FHandle, ColumnIndex));
  {$ELSE}
  Result := _sqlite3_column_text(FHandle, ColumnIndex);
  {$IFEND}
end;

function TSQLite3Statement.ColumnTextPtr(ColumnIndex: Integer): Pointer;
begin
  Result := _sqlite3_column_text(FHandle, ColumnIndex);
end;

function TSQLite3Statement.ColumnTextToStream(ColumnIndex: Integer;
  Stream: TStream): Integer;
var
  Len: Integer;
  P: PAnsiChar;
begin
  Len := ColumnBytes(ColumnIndex);
  if Len > 0 then
  begin
    P := _sqlite3_column_text(FHandle, ColumnIndex);
    if P <> nil then
    begin
      Result := Stream.Write(P^, Len);
      Exit;
    end;
  end;

  Result := 0;
end;

function TSQLite3Statement.ColumnType(ColumnIndex: Integer): Integer;
begin
  Result := _sqlite3_column_type(FHandle, ColumnIndex);
end;

constructor TSQLite3Statement.Create(OwnerDatabase: TSQLite3Database;
  const SQL: WideString);
begin
  FOwnerDatabase := OwnerDatabase;
  FSql := SQL;
  FOwnerDatabase.CheckHandle;
  FOwnerDatabase.Check(
    _sqlite3_prepare_v2(FOwnerDatabase.Handle, PAnsiChar(StrToUTF8(SQL)), -1, FHandle, nil)
  );
  FOwnerDatabase.FStatementList.Add(Self);
  FStrList := TList.Create;
end;

destructor TSQLite3Statement.Destroy;
begin
  ClearStrList;
  FreeAndNil(FStrList);

  FOwnerDatabase.FStatementList.Remove(Self);
  if FHandle <> nil then
    _sqlite3_finalize(FHandle);
  inherited;
end;

function TSQLite3Statement.ParamIndexByName(const ParamName: WideString): Integer;
begin
  Result := _sqlite3_bind_parameter_index(FHandle, PAnsiChar(StrToUTF8(ParamName)));
end;

procedure TSQLite3Statement.Reset;
begin
  _sqlite3_reset(FHandle);
  ClearStrList;
end;

function TSQLite3Statement.Step: Integer;
//var
//  errnum: Integer;
begin
  Result := _sqlite3_step(FHandle);
  if Result = SQLITE_FULL then
  begin
  end;
end;

procedure TSQLite3Statement.StepAndReset;
begin
  Step;
  Reset;
end;

procedure TSQLite3Statement.BindAnsiText(const ParamName: WideString;
  const Value: AnsiString);
begin
  BindAnsiText(ParamIndexByName(ParamName), Value);
end;

procedure TSQLite3Statement.BindBlob(const ParamName: WideString; Data: Pointer;
  const Size: Integer);
begin
  BindBlob(ParamIndexByName(ParamName), Data, Size);
end;

procedure TSQLite3Statement.BindDouble(const ParamName: WideString;
  const Value: Double);
begin
  BindDouble(ParamIndexByName(ParamName), Value);
end;

procedure TSQLite3Statement.BindInt(const ParamName: WideString;
  const Value: Integer);
begin
  BindInt(ParamIndexByName(ParamName), Value);
end;

procedure TSQLite3Statement.BindInt64(const ParamName: WideString;
  const Value: Int64);
begin
  BindInt64(ParamIndexByName(ParamName), Value);
end;

procedure TSQLite3Statement.BindNull(const ParamName: WideString);
begin
  BindNull(ParamIndexByName(ParamName));
end;

procedure TSQLite3Statement.BindText(const ParamName, Value: WideString);
begin
  BindText(ParamIndexByName(ParamName), Value);
end;

procedure TSQLite3Statement.BindUnicodeText(const ParamName: WideString; const Value: string);
var
  ParamIndex: Integer;
begin
  ParamIndex := ParamIndexByName(ParamName);
  BindUnicodeText(ParamIndex, value);
end;

procedure TSQLite3Statement.BindUnicodeText(const ParamIndex: Integer; const Value: string);
var
//  S: AnsiString; { UTF-8 string }
  P: PAnsiString;
begin
  // 修改 BindText 的一处 BUG
  // 由于 BindXXX 方法要求在 BindXXX 之后，Step 之前一直有效
  // 参数 const Value: WideString 由于字符串自动管理的特性，可能会被释放
  // 因此增加缓存字符串解决此问题
  New(P);
  FStrList.Add(P);
  P^ := UTF8Encode(Value);
  FOwnerDatabase.Check(
    _sqlite3_bind_text(FHandle, ParamIndex, PAnsiChar(P^), Length(P^), SQLITE_STATIC)
  );
end;

procedure TSQLite3Statement.BindTextPtr(const ParamName: WideString;
  Ptr: Pointer; Len: Integer);
begin
  BindTextPtr(ParamIndexByName(ParamName), Ptr, Len);
end;

procedure TSQLite3Statement.BindZeroBlob(const ParamName: WideString;
  const Size: Integer);
begin
  BindZeroBlob(ParamIndexByName(ParamName), Size);
end;

{ TSQLite3BlobHandler }

function TSQLite3BlobHandler.Bytes: Integer;
begin
  Result := _sqlite3_blob_bytes(FHandle);
end;

constructor TSQLite3BlobHandler.Create(OwnerDatabase: TSQLite3Database; const Table,
  Column: WideString; const RowID: Int64; const WriteAccess: Boolean);
begin
  FOwnerDatabase := OwnerDatabase;
  FOwnerDatabase.CheckHandle;
  FOwnerDatabase.Check(
    _sqlite3_blob_open(FOwnerDatabase.FHandle, 'main', PAnsiChar(StrToUTF8(Table)),
      PAnsiChar(StrToUTF8(Column)), RowID, Ord(WriteAccess), FHandle)
  );
  FOwnerDatabase.FBlobHandlerList.Add(Self);
end;

destructor TSQLite3BlobHandler.Destroy;
begin
  FOwnerDatabase.FBlobHandlerList.Remove(Self);
  _sqlite3_blob_close(FHandle);
  inherited;
end;

procedure TSQLite3BlobHandler.Read(Buffer: Pointer; const Size,
  Offset: Integer);
begin
  FOwnerDatabase.Check(_sqlite3_blob_read(FHandle, Buffer, Size, Offset));
end;

procedure TSQLite3BlobHandler.Write(Buffer: Pointer; const Size,
  Offset: Integer);
begin
  FOwnerDatabase.Check(_sqlite3_blob_write(FHandle, Buffer, Size, Offset));
end;

{ ESQLite3Error }

constructor ESQLite3Error.Create(const Msg: string; ErrorCode: Integer);
begin
  FErrorCode := ErrorCode;
  inherited Create(Msg);
end;

constructor ESQLite3Error.CreateFmt(const Msg: string;
  const Args: array of const; ErrorCode: Integer);
begin
  FErrorCode := ErrorCode;
  inherited CreateFmt(Msg, Args);
end;

{$ENDIF}

end.