unit SQLite3WrapApi;

interface

uses
  Windows, SQLite3;
  
type
  PSQL3Db         = ^TSQL3Db;
  TSQL3Db         = record
    Handle        : PSQLite3;
    LastError     : Integer;
    IsTransactionOpen: Boolean;
  end;

  PSQL3Statement  = ^TSQL3Statement;
  TSQL3Statement  = record
    Handle        : PSQLite3Stmt;
    Db            : PSQL3Db;
    Sql           : string;
  end;

  PSQL3Blob       = ^TSQL3Blob;
  TSQL3Blob       = record
    Handle        : PSQLite3Blob;
  end;
  
  function SQL3DbCheck(ADataBase: PSQL3Db; const AErrCode: Integer; ACheckCode: Integer = SQLITE_OK): Boolean;

  function SQL3DbOpen(ADataBase: PSQL3Db; AFileName: WideString; AOpenFlag: integer;
      Key: Pointer = nil; KeyLen: Integer = 0): Boolean;  
  procedure SQL3DbClose(ADataBase: PSQL3Db);

  function SQL3DbExecute(ADataBase: PSQL3Db; const ASQL: WideString): Boolean;

  procedure SQL3DbBeginTransaction(ADataBase: PSQL3Db);     
  procedure SQL3DbCommit(ADataBase: PSQL3Db);
  procedure SQL3DbRollback(ADataBase: PSQL3Db);      
           
  function CheckOutSql3Statement(ADataBase: PSQL3Db): PSQL3Statement;          
  function SQL3StatementStep(AStatement: PSQL3Statement): Integer;
  procedure SQL3StatementReset(AStatement: PSQL3Statement);

implementation

uses
  SQLite3Utils;
                 
function SQL3DBCheck(ADataBase: PSQL3Db; const AErrCode: Integer; ACheckCode: Integer = SQLITE_OK): Boolean;
//var
//  errorMessage: string;
begin
  Result := AErrCode = ACheckCode;
  ADataBase.LastError := AErrCode;
  if AErrCode <> ACheckCode then
  begin
    //errorMessage := Format(SErrorMessage, [UTF8ToStr(_sqlite3_errmsg(FHandle))]);
    //if Assigned(SQLiteLogErrorFormat) then
    //begin
      //SQLiteLogErrorFormat('SQLite Error: %s. ErrorCode: %d', [errorMessage, ErrCode]);
//    raise ESQLite3Error.Create(errorMessage, ErrCode);
    //end;
  end;
end;
                  
function DoSQLite3BusyCallback(ptr: Pointer; count: Integer): Integer; cdecl;
begin        
  Result := 0;
//  G_SqliteAnyBusy := True;
//
//  if GetCurrentThreadId = MainThreadID then
//  begin
//    G_SqliteMainBusy := True;
//
//    if count = 0 then
//    begin
//      G_BusyStart := GetTickCount;
//      Result := 1;
//    end
//    else if GetTickCount - G_BusyStart > SQLITE_MAINTHREAD_BUSYTIME then
//      Result := 0
//    else
//      Result := 1;
//  end else
//  begin
//    Result := 1; // 子线程里面就无限等待
//  end;
end;

function SQL3DbOpen(ADataBase: PSQL3Db; AFileName: WideString; AOpenFlag: integer;
  Key: Pointer = nil; KeyLen: Integer = 0): Boolean;   
var
  ret: integer;
begin
  SQL3DbClose(ADataBase);
  // 采用UTF-8的编码方式
  ret := _sqlite3_open_v2(PAnsiChar(SQLite3Utils.StrToUTF8(AFileName)), ADataBase.Handle, AOpenFlag, nil);
  Result := SQL3DBCheck(ADataBase, ret);
  if Result then
  begin
    if (Key <> nil) and (KeyLen > 0) then
    try
      Result := SQL3DBCheck(ADataBase, _sqlite3_key(ADataBase.Handle, Key, KeyLen));
    except
      _sqlite3_close(ADataBase.Handle);
      ADataBase.Handle := nil;
      raise;
    end;
    SQL3DBCheck(ADataBase, _sqlite3_busy_handler(ADataBase.Handle, @DoSQLite3BusyCallback, ADataBase));
  end;
end;
      
procedure SQL3DbClose(ADataBase: PSQL3Db);
begin
  if nil <> ADataBase.Handle then
  begin
    if ADataBase.IsTransactionOpen then
      SQL3DbRollback(ADataBase);
    // Delete all statements
    //for I := FStatementList.Count - 1 downto 0 do
    //  TSQLite3Statement(FStatementList[I]).Free;
    // Delete all blob handlers
    //for I := FBlobHandlerList.Count - 1 downto 0 do
    //  TSQLite3BlobHandler(FBlobHandlerList[I]).Free;
    // Delete all blob writestreams
    //for I := FBlobStreamList.Count - 1 downto 0 do
    //  TSQLite3BlobStream(FBlobStreamList[I]).Free;
      
    _sqlite3_close(ADataBase.Handle);
    ADataBase.Handle := nil;
  end;
  //ADataBase.FileName := '';
end;
                      
function SQL3DbExecute(ADataBase: PSQL3Db; const ASQL: WideString): Boolean; 
begin
  //CheckHandle;
  Result := SQL3DBCheck(ADataBase, _sqlite3_exec(ADataBase.Handle, PAnsiChar(StrToUTF8(ASQL)), nil, nil, nil));
end;

procedure SQL3DbBeginTransaction(ADataBase: PSQL3Db);
begin
  if not ADataBase.IsTransactionOpen then
  begin
    SQL3DbExecute(ADataBase, 'BEGIN TRANSACTION;'); // TODO: BEGIN TRANSACTION
    ADataBase.IsTransactionOpen := True;
  end else
  begin
    //if Assigned(SQLiteLogError)  then
    //  SQLiteLogError('SQLite: Transaction is already open.');
//    raise ESQLite3Error.Create(STransactionAlreadyOpen);
  end;
end;
                   
procedure SQL3DbCommit(ADataBase: PSQL3Db);
begin
  if ADataBase.IsTransactionOpen then
  begin
    SQL3DbExecute(ADataBase, 'COMMIT;');
    ADataBase.IsTransactionOpen := False;
  end else
  begin
    //raise ESQLite3Error.Create(SNoTransactionOpen);
  end;
end;
          
procedure SQL3DbRollback(ADataBase: PSQL3Db);
begin
  if ADataBase.IsTransactionOpen then
  begin
    SQL3DbExecute(ADataBase, 'ROLLBACK;');
    ADataBase.IsTransactionOpen := False;
  end else
  begin
    //raise ESQLite3Error.Create(SNoTransactionOpen);
  end;
end;

function CheckOutSql3Statement(ADataBase: PSQL3Db): PSQL3Statement;
begin
  Result := System.New(PSQL3Statement);
  FillChar(Result^, SizeOf(TSQL3Statement), 0);

  Result.Db := ADataBase;
  Result.Sql := '';//SQL;
  //FOwnerDatabase.CheckHandle;
  SQL3DBCheck(
    ADataBase,
    _sqlite3_prepare_v2(ADataBase.Handle, PAnsiChar(StrToUTF8(Result.Sql)), -1, Result.Handle, nil)
  );
  //FOwnerDatabase.FStatementList.Add(Self);
  //FStrList := TList.Create;
end;

function SQL3StatementStep(AStatement: PSQL3Statement): Integer;
//var
//  errnum: Integer;
begin
  Result := _sqlite3_step(AStatement.Handle);
  if Result = SQLITE_FULL then
  begin
  end;
end;

procedure SQL3StatementReset(AStatement: PSQL3Statement);
begin
  _sqlite3_reset(AStatement.Handle);
  //ClearStrList;
end;

end.
