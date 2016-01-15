(*
          1    0 0022FAAC _dig_vec_lower
          2    1 0022FA84 _dig_vec_upper
          3    2 0000217B bmove_upp
          4    3 0022F8C8 client_errors
          5    4 00002FC2 delete_dynamic
          6    5 000044FD free_defaults
          7    6 000040A7 get_defaults_options
          8    7 00003A85 getopt_compare_strings
          9    8 000025F9 getopt_ull_limit_value
         10    9 00001C62 handle_options
         11    A 00003927 init_dynamic_array
         12    B 00001127 insert_dynamic
         13    C 00003044 int2str
         14    D 00003701 is_prefix
         15    E 0000251D list_add
         16    F 00003017 list_delete
         17   10 00001EE7 load_defaults
         18   11 0000392C modify_defaults_file
         19   12 00003B25 my_end
         20   13 0022FCF8 my_getopt_print_errors
         21   14 00004147 my_init
         22   15 00002077 my_malloc
         23   16 00002149 my_memdup
         24   17 0000478C my_no_flags_free
         25   18 00004115 my_path
         26   19 00002A22 my_print_help
         27   1A 0000142E my_print_variables
         28   1B 00004291 my_realloc
         29   1C 00003A12 my_strdup
         30   1D 00003A67 myodbc_remove_escape
         31   1E 000047DC mysql_affected_rows
         32   1F 00002C4D mysql_autocommit
         33   20 00001938 mysql_change_user
         34   21 00002AE0 mysql_character_set_name
         35   22 000032D8 mysql_close
         36   23 00002F68 mysql_commit
         37   24 00001208 mysql_data_seek
         38   25 000035BC mysql_debug
         39   26 000028F1 mysql_disable_reads_from_master
         40   27 000019C4 mysql_disable_rpl_parse
         41   28 000035B7 mysql_dump_debug_info
         42   29 00003706 mysql_embedded
         43   2A 00001A19 mysql_enable_reads_from_master
         44   2B 00003E45 mysql_enable_rpl_parse
         45   2C 0000269E mysql_eof
         46   2D 000035CB mysql_errno
         47   2E 000035C1 mysql_error
         48   2F 00002B03 mysql_escape_string
         49   30 00004921 mysql_fetch_field
         50   31 00002C1B mysql_fetch_field_direct
         51   32 00001532 mysql_fetch_fields
         52   33 000013B6 mysql_fetch_lengths
         53   34 00002DE2 mysql_fetch_row
         54   35 00001BA4 mysql_field_count
         55   36 00003C4C mysql_field_seek
         56   37 00001B9A mysql_field_tell
         57   38 00003535 mysql_free_result
         58   39 00002630 mysql_get_character_set_info
         59   3A 00003788 mysql_get_client_info
         60   3B 00002F9A mysql_get_client_version
         61   3C 000037DD mysql_get_host_info
         62   3D 0000116D mysql_get_parameters
         63   3E 00003CDD mysql_get_proto_info
         64   3F 000012B7 mysql_get_server_info
         65   40 00001019 mysql_get_server_version
         66   41 0000353A mysql_get_ssl_cipher
         67   42 00001514 mysql_hex_string
         68   43 00003FE4 mysql_info
         69   44 00004011 mysql_init
         70   45 000041F6 mysql_insert_id
         71   46 00003CC4 mysql_kill
         72   47 00002711 mysql_list_dbs
         73   48 00004269 mysql_list_fields
         74   49 000026D0 mysql_list_processes
         75   4A 0000224D mysql_list_tables
         76   4B 00003783 mysql_master_query
         77   4C 00003CD8 mysql_more_results
         78   4D 00002F86 mysql_next_result
         79   4E 000038AA mysql_num_fields
         80   4F 0000333C mysql_num_rows
         81   50 000030CB mysql_options
         82   51 00003D2D mysql_ping
         83   52 00004061 mysql_query
         84   53 000033CD mysql_read_query_result
         85   54 0000461F mysql_real_connect
         86   55 00001023 mysql_real_escape_string
         87   56 000040A2 mysql_real_query
         88   57 000025B3 mysql_refresh
         89   58 00002EFF mysql_rollback
         90   59 000032FB mysql_row_seek
         91   5A 00003279 mysql_row_tell
         92   5B 0000411A mysql_rpl_parse_enabled
         93   5C 0000326A mysql_rpl_probe
         94   5D 00002694 mysql_rpl_query_type
         95   5E 00003DF5 mysql_select_db
         96   5F 000021E9 mysql_send_query
         97   60 00004886 mysql_server_end
         98   61 00004561 mysql_server_init
         99   62 00002FEA mysql_set_character_set
        100   63 00002DE7 mysql_set_local_infile_default
        101   64 000014BA mysql_set_local_infile_handler
        102   65 000026E9 mysql_set_server_option
        103   66 0000119F mysql_shutdown
        104   67 00002298 mysql_slave_query
        105   68 00004188 mysql_sqlstate
        106   69 00003B9D mysql_ssl_set
        107   6A 0000189D mysql_stat
        108   6B 000033B4 mysql_stmt_affected_rows
        109   6C 00004796 mysql_stmt_attr_get
        110   6D 00003A2B mysql_stmt_attr_set
        111   6E 00002635 mysql_stmt_bind_param
        112   6F 000033A0 mysql_stmt_bind_result
        113   70 00003DF0 mysql_stmt_close
        114   71 000036C5 mysql_stmt_data_seek
        115   72 000029FA mysql_stmt_errno
        116   73 00002BEE mysql_stmt_error
        117   74 00002699 mysql_stmt_execute
        118   75 00003648 mysql_stmt_fetch
        119   76 00003607 mysql_stmt_fetch_column
        120   77 00003800 mysql_stmt_field_count
        121   78 00004368 mysql_stmt_free_result
        122   79 00002A9A mysql_stmt_init
        123   7A 00003305 mysql_stmt_insert_id
        124   7B 000034AE mysql_stmt_num_rows
        125   7C 000022ED mysql_stmt_param_count
        126   7D 0000218F mysql_stmt_param_metadata
        127   7E 0000348B mysql_stmt_prepare
        128   7F 0000373D mysql_stmt_reset
        129   80 000017F8 mysql_stmt_result_metadata
        130   81 000047FA mysql_stmt_row_seek
        131   82 00003675 mysql_stmt_row_tell
        132   83 0000157D mysql_stmt_send_long_data
        133   84 00001550 mysql_stmt_sqlstate
        134   85 000028DD mysql_stmt_store_result
        135   86 00003BDE mysql_store_result
        136   87 00001AC3 mysql_thread_end
        137   88 00003B61 mysql_thread_id
        138   89 000014F6 mysql_thread_init
        139   8A 0000143D mysql_thread_safe
        140   8B 00002810 mysql_use_result
        141   8C 0000222A mysql_warning_count
        142   8D 0000104B set_dynamic
        143   8E 00003FB2 strcend
        144   8F 00004039 strcont
        145   90 000036DE strdup_root
        146   91 00004002 strfill
        147   92 0000466A strinstr
        148   93 00003FC1 strmake
        149   94 000033D2 strmov
        150   95 00003FAD strxmov
*)
unit dll_libmysql;

interface

uses
  atmcmbaseconst, wintype;
   
const 
  libmySQL                  = 'libmySQL.dll'; 
 
  MYSQL_ERRMSG_SIZE         = 512; 
  SQLSTATE_LENGTH           = 5; 
  MYSQL_PORT                = 3306; 
  LOCAL_HOST                = 'localhost';  
  MYSQL_UNIX_ADDR           = '/tmp/mysql.sock';  
  NAME_LEN                  = 64;  
  PROTOCOL_VERSION          = 10;  
  MYSQL_SERVER_VERSION      = '5.0.21'; 
  MYSQL_BASE_VERSION        = 'mysqld-5.0'; 
  MYSQL_SERVER_SUFFIX_DEF   = '-community-max-nt'; 
  FRM_VER                   = 6; 
  MYSQL_VERSION_ID          = 50021; 
  field_type_decimal        = 0;  
  field_type_tiny           = 1;  
  field_type_short          = 2; 
  field_type_long           = 3;  
  field_type_float          = 4;  
  field_type_double         = 5;  
  field_type_null           = 6;  
  field_type_timestamp      = 7;  
  field_type_longlong       = 8;  
  field_type_int24          = 9;  
  field_type_date           = 10;  
  field_type_time           = 11;  
  field_type_datetime       = 12;  
  field_type_enum           = 247;  
  field_type_set            = 248; 
  field_type_tiny_blob      = 249; 
  field_type_medium_blob    = 250; 
  field_type_long_blob      = 251; 
  field_type_blob           = 252; 
  field_type_var_string     = 253; 
  field_type_string         = 254; 
 
  SCRAMBLE_LENGTH           = 20; 
  SCRAMBLE_LENGTH_323       = 8; 
                               
  CLIENT_LONG_PASSWORD      = 1;     // new more secure passwords
  CLIENT_FOUND_ROWS         = 2;     // Found instead of affected rows
  CLIENT_LONG_FLAG          = 4;     // Get all column flags
  CLIENT_CONNECT_WITH_DB    = 8;     // One can specify db on connect
  CLIENT_NO_SCHEMA          = 16;    // Don't allow database.table.column
  CLIENT_COMPRESS           = 32;    // Can use compression protcol
  CLIENT_ODBC               = 64;    // Odbc client
  CLIENT_LOCAL_FILES        = 128;   // Can use LOAD DATA LOCAL
  CLIENT_IGNORE_SPACE       = 256;   // Ignore spaces before '('
  CLIENT_PROTOCOL_41        = 512;   // Support the mysql_change_user()
  CLIENT_INTERACTIVE        = 1024;  // This is an interactive client
  CLIENT_SSL                = 2048;  // Switch to SSL after handshake
  CLIENT_IGNORE_SIGPIPE     = 4096;  // IGNORE sigpipes
  CLIENT_TRANSACTIONS       = 8192;  // Client knows about transactions

  CLIENT_RESERVED           = 16384; // Old flag for 4.1 protocol (4.1.9)
  CLIENT_SECURE_CONNECTION  = 32768;// New 4.1 authentication

  CLIENT_MULTI_STATEMENTS   = 65536;   // Enable/disable multi-stmt support
  CLIENT_MULTI_RESULTS      = 131072;  // Enable/disable multi-results
  CLIENT_CAPABILITIES       = (CLIENT_LONG_PASSWORD or CLIENT_LONG_FLAG or CLIENT_LOCAL_FILES or CLIENT_TRANSACTIONS or CLIENT_PROTOCOL_41 or CLIENT_SECURE_CONNECTION or CLIENT_MULTI_STATEMENTS or CLIENT_MULTI_RESULTS);

  SERVER_STATUS_IN_TRANS    = 1;     // Transaction has started
  SERVER_STATUS_AUTOCOMMIT  = 2;   // Server in auto_commit mode
  SERVER_STATUS_MORE_RESULTS = 4; // More results on server
  SERVER_MORE_RESULTS_EXISTS = 8; // Multi query - next query exists 
  SERVER_QUERY_NO_GOOD_INDEX_USED = 16;
  SERVER_QUERY_NO_INDEX_USED = 32;

  NET_READ_TIMEOUT          = 30;      // Timeout on read
  NET_WRITE_TIMEOUT         = 60;      // Timeout on write
  NET_WAIT_TIMEOUT          = 8*60*60; // Wait for new query

type 
  PMysql_Statement          = Pointer;
  PMysql_BIND               = Pointer;

  PMysql_Lengths            = Pointer;
  Mysql_FIELD_OFFSET        = longword;  // offset to current field
  Mysql_ROW_OFFSET          = longword;

  enum_field_types          = byte;

  PByteBool                 = ^ByteBool;

  pcharset_info             = ^Tcharacter_set;
  Tcharacter_set            = record
    number                  : LongWord;
    state                   : LongWord;
    csname                  : PAnsiChar;
    name                    : PAnsiChar;
    comment                 : PAnsiChar;
    dir                     : PAnsiChar;
    mbminlen                : LongWord;
    mbmaxlen                : LongWord;
  end; 
  MY_CHARSET_INFO           = Tcharacter_set;

  TMysql_STATUS             = (Mysql_STATUS_READY,
                             Mysql_STATUS_GET_RESULT,
                             Mysql_STATUS_USE_RESULT);
  TMysql_OPTION             = (
    Mysql_OPT_CONNECT_TIMEOUT,
    Mysql_OPT_COMPRESS,
    Mysql_OPT_NAMED_PIPE,
    Mysql_INIT_COMMAND,
    Mysql_READ_DEFAULT_FILE,
    Mysql_READ_DEFAULT_GROUP,
    Mysql_SET_CHARSET_DIR,
    Mysql_SET_CHARSET_NAME,
    Mysql_OPT_LOCAL_INFILE,
    Mysql_OPT_PROTOCOL,
    Mysql_SHARED_MEMORY_BASE_NAME,
    Mysql_OPT_READ_TIMEOUT,
    Mysql_OPT_WRITE_TIMEOUT,
    Mysql_OPT_USE_RESULT,
    Mysql_OPT_USE_REMOTE_CONNECTION,
    Mysql_OPT_USE_EMBEDDED_CONNECTION,
    Mysql_OPT_GUESS_CONNECTION,
    Mysql_SET_CLIENT_IP,
    Mysql_SECURE_AUTH,
    Mysql_REPORT_DATA_TRUNCATION,
    Mysql_OPT_RECONNECT
  );

  TMysql_RPL_TYPE           = (
    Mysql_RPL_MASTER,
    Mysql_RPL_SLAVE,
    Mysql_RPL_ADMIN); 

  TMysql_SET_OPTION         = (
    Mysql_OPTION_MULTI_STATEMENTS_ON,
    Mysql_OPTION_MULTI_STATEMENTS_OFF);

  TMysql_SHUTDOWN_LEVEL     = (
    SHUTDOWN_DEFAULT        = 0,
    SHUTDOWN_WAIT_CONNECTIONS = 1, 
    SHUTDOWN_WAIT_TRANSACTIONS = 2, 
    SHUTDOWN_WAIT_UPDATES   = 8,
    SHUTDOWN_WAIT_ALL_BUFFERS = 16, 
    SHUTDOWN_WAIT_CRITICAL_BUFFERS = 17, 
    KILL_QUERY              = 254,
    KILL_CONNECTION         = 255
  ); 
 
  PMysql_list               = ^TMysql_list;
  TMysql_list               = record
    prev                    : PMysql_list;
    next                    : PMysql_list;
    data                    : Pointer;
  end; 
  LIST                      = TMysql_list;

  st_vio = record end;
  VIO = st_vio; 
 
  TMySQL_Net                = record 
    vio                     : ^VIO;
    buff                    : PAnsiChar;
    buff_end                : PAnsiChar;
    write_pos               : PAnsiChar;
    read_pos                : PAnsiChar;
    fd                      : Integer;
    max_packet              : LongWord;
    max_packet_size         : LongWord;
    pkt_nr                  : LongWord;
    compress_pkt_nr         : LongWord;
    write_timeout           : LongWord;
    read_timeout            : LongWord;
    retry_count             : LongWord;
    fcntl: Integer; 
    compress                : ByteBool;
    remain_in_buf           : LongWord;
    length                  : LongWord;
    buf_length              : LongWord;
    where_b                 : LongWord;
    return_status           : PLongWord;
    reading_or_writing      : AnsiChar;
    save_char               : AnsiChar;
    no_send_ok              : ByteBool;
    no_send_eof             : ByteBool;
    no_send_error           : ByteBool;
 
    last_error              : array [0..MYSQL_ERRMSG_SIZE-1] of AnsiChar;
    sqlstate                : array [0..SQLSTATE_LENGTH] of AnsiChar;
 
    last_errno              : LongWord;
    error                   : Ansichar;
    query_cache_query       : PAnsiChar;

    report_error            : ByteBool;
    return_errno            : ByteBool;
  end; 
  NET                       = TMySQL_Net; 
 
  PMysql_field411           = ^TMysql_field411;
  TMysql_field411           = record
    name                    : PAnsiChar;
    org_name                : PAnsiChar;
    table                   : PAnsiChar;
    org_table               : PAnsiChar;
    db                      : PAnsiChar;
    catalog                 : PAnsiChar;
    def                     : PAnsiChar;
    length                  : Cardinal;
    max_length              : Cardinal;
    name_length             : Cardinal;
    org_name_length         : Cardinal;
    table_length            : Cardinal;
    org_table_length        : Cardinal;
    db_length               : Cardinal;
    catalog_length          : Cardinal;
    def_length              : Cardinal;
    flags                   : Cardinal;
    decimals                : Cardinal;
    charsetnr               : Cardinal;
    fieldtype               : enum_field_types;
  end; 
  Mysql_FIELD               = TMysql_field411; 
               
  TMysql_fields             = array [0..$ff] of Mysql_FIELD; 
  PMysql_fields             = ^TMysql_fields;

  pused_mem                 = ^st_used_mem;
  st_used_mem               = record
    next                    : pused_mem; 
    left                    : LongWord;
    size                    : LongWord;
  end; 
  USED_MEM                  = st_used_mem;
 
  st_mem_root               = record
    free                    : pused_mem;
    used                    : pused_mem;
    pre_alloc               : pused_mem;
    min_malloc              : LongWord;
    block_size              : LongWord;
    block_num               : LongWord;
    first_block_usage       : LongWord;  
    error_handler           : Pointer;
  end; 
  MEM_ROOT                  = st_mem_root;
 
  PMYSQL_TIME               = ^TMYSQL_TIME;
  TMYSQL_TIME               = record
    year                    : longword;
    month                   : longword;
    day                     : longword;
    hour                    : longword;
    minute                  : longword;
    second                  : longword;
    second_part             : longword;
    neg                     : ByteBool;
    time_type               : integer;
  end;

  pdynamic_array            = ^st_dynamic_array;
  st_dynamic_array          = record
    buffer                  : PAnsiChar;
    elements                : LongWord;
    max_element             : LongWord;
    alloc_increment         : LongWord;
    size_of_element         : LongWord;
  end; 
  DYNAMIC_ARRAY             = st_dynamic_array;
 
  st_Mysql_options          = record
    connect_timeout         : LongWord;
    read_timeout            : LongWord;
    write_timeout           : LongWord;
    port                    : LongWord;
    protocol                : LongWord;
    client_flag             : LongWord;
 
    host                    : PAnsiChar;
    user                    : PAnsiChar;
    password                : PAnsiChar;
    unix_socket             : PAnsiChar;
    db                      : PAnsiChar;
 
    init_commands           : pdynamic_array;
 
    my_cnf_file             : PAnsiChar;
    my_cnf_group            : PAnsiChar;
    charset_dir             : PAnsiChar;
    charset_name            : PAnsiChar;
 
    ssl_key                 : PAnsiChar;
    ssl_cert                : PAnsiChar;
    ssl_ca                  : PAnsiChar;
    ssl_capath              : PAnsiChar;
    ssl_cipher              : PAnsiChar;
    shared_memory_base_name : PAnsiChar;
 
    max_allowed_packet      : LongWord; 
 
    use_ssl                 : ByteBool;
    compress                : ByteBool;
    named_pipe              : ByteBool;
 
    rpl_probe               : ByteBool;
    rpl_parse               : ByteBool;
 
    no_master_reads         : ByteBool;
 
    separate_thread         : ByteBool;
 
    methods_to_use          : TMysql_OPTION;
    client_ip               : PAnsiChar;
 
    secure_auth             : ByteBool;
    report_data_truncation  : ByteBool; 
 
    local_infile_init       : Pointer;
    local_infile_read       : Pointer;
    local_infile_end        : Pointer;
    local_infile_error      : Pointer;
    local_infile_userdata   : Pointer; 
  end; 
 
  PMysql_methods            = ^TMysql_methods;
  TMysql_methods            = record
(*
typedef struct st_Mysql_methods 
{ 
  my_bool (*read_query_result)(MYSQL *mysql); 
  my_bool (*advanced_command)(MYSQL *mysql, 
			      enum enum_server_command command, 
			      const char *header, 
			      unsigned long header_length, 
			      const char *arg, 
			      unsigned long arg_length, 
			      my_bool skip_check); 
  MYSQL_DATA *(*read_rows)(MYSQL *mysql,MYSQL_FIELD *mysql_fields, 
			   unsigned int fields); 
  MYSQL_RES * (*use_result)(MYSQL *mysql); 
  void (*fetch_lengths)(unsigned long *to, 
			MYSQL_ROW column, unsigned int field_count); 
  void (*flush_use_result)(MYSQL *mysql); 
#if !defined(MYSQL_SERVER) || defined(EMBEDDED_LIBRARY) 
  MYSQL_FIELD * (*list_fields)(MYSQL *mysql); 
  my_bool (*read_prepare_result)(MYSQL *mysql, MYSQL_STMT *stmt); 
  int (*stmt_execute)(MYSQL_STMT *stmt); 
  int (*read_binary_rows)(MYSQL_STMT *stmt); 
  int (*unbuffered_fetch)(MYSQL *mysql, char **row); 
  void (*free_embedded_thd)(MYSQL *mysql); 
  const char *(*read_statistics)(MYSQL *mysql);
  my_bool (*next_result)(MYSQL *mysql); 
  int (*read_change_user_result)(MYSQL *mysql, char *buff, const char *passwd); 
  int (*read_rows_from_cursor)(MYSQL_STMT *stmt); 
#endif 
} Mysql_METHODS; 
 
*) 
  end; 
  Mysql_METHODS             = TMysql_methods;

  pembedded_query_result    = ^Tembedded_query_result;
  Tembedded_query_result    = record
  end; 
  EMBEDDED_QUERY_RESULT     = Tembedded_query_result; 
 
  PMysql_row                = ^TMysql_ROW; 
  TMysql_ROW                = array[0..255] of PAnsiChar;
 
  PMysql_rows               = ^TMysql_rows; 
  TMysql_rows               = record 
    next                    : PMysql_rows;
    data                    : TMysql_ROW;
    length                  : LongWord;
  end;
  Mysql_ROWS                = TMysql_rows;
 
  PMysql_data               = ^TMysql_data;
  TMysql_data               = record
    rows                    : int64;
    fields                  : LongWord;
    data                    : PMysql_rows;
    alloc                   : MEM_ROOT;
    embedded_info           : pembedded_query_result;
  end; 
  Mysql_DATA                = TMysql_data;
 
  PMysql                    = ^TMysql;
  TMysql                    = record
    net                     : NET;
    connector_fd            : PAnsiChar;
    host                    : PAnsiChar;
    user                    : PAnsiChar;
    passwd                  : PAnsiChar;
    unix_socket             : PAnsiChar;
    server_version          : PAnsiChar;
    host_info               : PAnsiChar;
    info                    : PAnsiChar;
    db                      : PAnsiChar;
    charset                 : PAnsiCharset_info;
    fields                  : PMysql_field411;
    field_alloc             : MEM_ROOT;
    affected_rows           : int64; 
    insert_id               : int64;
    extra_info              : int64;
    thread_id               : LongWord;
    packet_length           : LongWord;
    port                    : LongWord;
    client_flag             : LongWord;
    server_capabilities     : LongWord;
    protocol_version        : LongWord;
    field_count             : LongWord;
    server_status           : LongWord;
    server_language         : LongWord;
    warning_count           : LongWord;
    options                 : st_Mysql_options;
    status                  : TMysql_status;
    free_me                 : ByteBool;
    reconnect               : ByteBool;
    scramble                : array [0..SCRAMBLE_LENGTH] of AnsiChar;
    rpl_pivot               : ByteBool;
 
    master                  : PMysql;
    next_slave              : PMysql;
    last_used_slave         : pmysql;
    last_used_con           : pmysql;

    stmts                   : PMysql_list;

    methods                 : pmysql_methods;

    thd                     : Pointer;

    unbuffered_fetch_owner  : PByteBool;
 
    info_buffer             : PAnsiChar;
  end; 
  _Mysql                    = TMysql; 
 
  PMysql_res                = ^TMysql_res;
  TMysql_res                = record
    row_count               : int64;
    fields                  : PMysql_field411;
    data                    : PMysql_data;
    data_cursor             : PMysql_rows;
    lengths                 : PLongWord;
    handle                  : PMysql;
    field_alloc             : MEM_ROOT;
    field_count             : LongWord;
    current_field           : LongWord;
    row                     : TMysql_ROW;
    current_row             : TMysql_ROW;
    eof                     : ByteBool;
    unbuffered_fetch_cancelled  : ByteBool;
    methods                 : PMysql_methods;
  end; 
  Mysql_RES                 = TMysql_res;
 
  PMysql_parameters         = ^TMysql_parameters;
  TMysql_parameters         = record
    p_max_allowed_packet    : PLongWord;
    p_net_buffer_length     : PLongWord;
  end;
  Mysql_PARAMETERS          = TMysql_parameters;
 
  function mysql_affected_rows(mysql: pmysql): LongWord; stdcall; 
  function mysql_autocommit(mysql: pmysql; auto_mode: ByteBool): ByteBool; stdcall; 
  function mysql_change_user(mysql: pmysql; user, passwd, db: PAnsiChar): ByteBool; stdcall; 
  function mysql_character_set_name(mysql: pmysql): PAnsiChar; stdcall; 
  procedure mysql_close(mysql: pmysql); stdcall; 
  function mysql_commit(mysql: pmysql): ByteBool; stdcall; 
  procedure mysql_data_seek(result: pmysql_res; offset: int64); stdcall; 
  procedure mysql_debug(debug: PAnsiChar); stdcall; 
  procedure mysql_disable_reads_from_master(mysql: pmysql); stdcall; 
  procedure mysql_disable_rpl_parse(mysql: pmysql); stdcall; 
  function mysql_dump_debug_info(mysql: pmysql): Integer; stdcall; 
  function mysql_embedded(): ByteBool; stdcall; 
  procedure mysql_enable_reads_from_master(mysql: pmysql); stdcall; 
  procedure mysql_enable_rpl_parse(mysql: pmysql); stdcall; 
  function mysql_eof(result: pmysql_res): ByteBool; stdcall; 
  function mysql_errno(mysql: pmysql): Integer; stdcall; 
  function mysql_error(mysql: pmysql): PAnsiChar; stdcall; 
  function mysql_escape_string(ato: PAnsiChar; from: PAnsiChar; from_length: LongWord): LongWord; stdcall; 
  function mysql_fetch_field(result: pmysql_res): pmysql_field411; stdcall; 
  function mysql_fetch_field_direct(result: pmysql_res; fieldnr: LongWord): pmysql_field411; stdcall; 
  function mysql_fetch_fields(result: pmysql_res): pmysql_fields; stdcall; 
  function mysql_fetch_lengths(result: pmysql_res): LongWord; stdcall; 
  function mysql_fetch_row(result: pmysql_res): pmysql_row; stdcall; 
  function mysql_field_count(result: pmysql_res): LongWord; stdcall; 
  function mysql_field_seek(result: pmysql_res; offset: MYSQL_FIELD_OFFSET): MYSQL_FIELD_OFFSET; stdcall; 
  function mysql_field_tell(result: pmysql_res): MYSQL_FIELD_OFFSET; stdcall; 
  procedure mysql_free_result(mysql: pmysql_res); stdcall; 
  procedure mysql_get_character_set_info(mysql: pmysql; charset: PAnsiCharset_info); stdcall; 
  function mysql_get_client_info(): PAnsiChar; stdcall; 
  function mysql_get_client_version(): LongWord; stdcall; 
  function mysql_get_host_info(): PAnsiChar; stdcall; 
  function mysql_get_parameters(): pmysql_parameters; 
  function mysql_get_proto_info(mysql: pmysql): Integer; stdcall; 
  function mysql_get_server_info(mysql: pmysql): PAnsiChar; stdcall; 
  function mysql_get_server_version(mysql: pmysql): Integer; stdcall; 
  function mysql_hex_string(ato: PAnsiChar; from: PAnsiChar; from_length: LongWord): LongWord; stdcall; 
  function mysql_info(mysql: pmysql): PAnsiChar; stdcall; 
  function mysql_init(mysql: pmysql): pmysql; stdcall; 
  function mysql_insert_id(mysql: pmysql): Longword; stdcall; 
  function mysql_kill(mysql: pmysql; pid: LongWord): Integer; stdcall; 
  function mysql_list_dbs(mysql: pmysql; wild: PAnsiChar): pmysql_res; stdcall; 
  function mysql_list_fields(mysql: pmysql; table: PAnsiChar; wild: PAnsiChar): pmysql_res; stdcall; 
  function mysql_list_processes(mysql: pmysql): pmysql_res; stdcall; 
  function mysql_list_tables(mysql: pmysql; wild: PAnsiChar): pmysql_res; stdcall; 
  function mysql_master_query(mysql: pmysql; q: PAnsiChar; length: LongWord): ByteBool; stdcall; 
  function mysql_more_results(mysql: pmysql): ByteBool; stdcall; 
  function mysql_next_result(mysql: pmysql): Integer; stdcall; 
  function mysql_num_fields(result: pmysql_res): LongWord; stdcall; 
  function mysql_num_rows(result: pmysql_res): LongWord; stdcall; 
  // mysql_odbc_escape_string 
//  function mysql_options(mysql: pmysql; option: MYSQL_OPTION; arg: PAnsiChar): Integer; stdcall;
  function mysql_ping(mysql: pmysql): Integer; stdcall; 
  function mysql_query(mysql: pmysql; q: PAnsiChar): Integer; stdcall; 
  function mysql_read_query_result(mysql: pmysql): ByteBool; stdcall; 
  function mysql_real_connect(mysql: pmysql; const host, user, passwd, db: PAnsiChar; port: Cardinal; unix_socket: PAnsiChar; clientflag: Cardinal): pmysql; stdcall; 
  function mysql_real_escape_string(mysql: pmysql; ato: PAnsiChar; from: PAnsiChar; from_length: LongWord): LongWord; stdcall; 
  function mysql_real_query(mysql: pmysql; q: PAnsiChar; length: LongWord): Integer; stdcall; 
  function mysql_refresh(mysql: pmysql; refresh_options: LongWord): Integer; stdcall; 
  function mysql_rollback(mysql: pmysql): ByteBool; stdcall; 
  function mysql_row_seek(result: pmysql_res; offset: MYSQL_ROW_OFFSET): MYSQL_ROW_OFFSET; stdcall; 
  function mysql_row_tell(result: pmysql_res): MYSQL_ROW_OFFSET; stdcall; 
  function mysql_rpl_parse_enabled(mysql: pmysql): Integer; stdcall; 
  function mysql_rpl_probe(mysql: pmysql): ByteBool; stdcall; 
  function mysql_rpl_query_type(q: PAnsiChar; length: Integer): TMYSQL_RPL_TYPE; stdcall;
  function mysql_select_db(mysql: pmysql; db: PAnsiChar): Integer; stdcall; 
  function mysql_send_query(mysql: pmysql; q: PAnsiChar; length: LongWord): Integer; stdcall; 
  procedure mysql_server_end(); stdcall; 
  function mysql_server_init(argc: Integer; argv: Pointer; groups: Pointer): Integer; stdcall; 
  function mysql_set_character_set(mysql: pmysql; csname: PAnsiChar): Integer; stdcall; 
  procedure mysql_set_local_infile_default(mysql: pmysql); stdcall; 
  // mysql_set_local_infile_handler 
  function mysql_set_server_option(mysql: pmysql; option: TMYSQL_SET_OPTION): Integer; stdcall; 
  function mysql_shutdown(mysql: pmysql; shutdown_level: TMYSQL_SHUTDOWN_LEVEL): Integer; stdcall; 
  function mysql_slave_query(mysql: pmysql; q: PAnsiChar; length: LongWord): Integer; stdcall; 
  function mysql_sqlstate(mysql: pmysql): PAnsiChar; stdcall; 
  // mysql_ssl_set 
  function mysql_stat(mysql: pmysql): PAnsiChar; stdcall; 
  function mysql_store_result(mysql: pmysql): pmysql_res; stdcall; 
  // mysql_thread_end 
  // mysql_thread_id 
  // mysql_thread_init 
  // mysql_thread_safe 
  function mysql_use_result(mysql: pmysql): pmysql_res; stdcall; 
  function mysql_warning_count(mysql: pmysql): Integer; stdcall;

type   
  PMysql5                       = ^TMysql5;
  TMysql5                       = record
    Module                          : THandle;
    // 返回被最新的UPDATE, DELETE或INSERT查询影响的行数。
    Mysql_affected_rows             : function(AMysql: PMysql): Longword; stdcall;
    Mysql_autocommit                : function(AMysql: PMysql;  auto_mode: ByteBool): ByteBool; stdcall;
    Mysql_change_user               : function(AMysql: PMysql; const user, passwd, db: PAnsiChar): ByteBool; stdcall;
    Mysql_character_set_name        : function(AMysql: PMysql): PAnsiChar; stdcall;
    // 关闭一个服务器连接
    Mysql_close                     : procedure(AMysql: PMysql); stdcall;
    Mysql_commit                    : function(AMysql: PMysql): ByteBool; stdcall;
    // 在一个查询结果集合中搜寻一任意行
    Mysql_data_seek                 : procedure(AResult: pmysql_res; offset: int64); stdcall;
    Mysql_debug                     : procedure(const debug: PAnsiChar); stdcall; 
    Mysql_disable_reads_from_master : procedure(AMysql: PMysql); stdcall;
    Mysql_disable_rpl_parse         : procedure(AMysql: PMysql); stdcall;
    Mysql_dump_debug_info           : function(AMysql: PMysql): integer; stdcall;
    Mysql_embedded                  : function: ByteBool; stdcall;
    Mysql_enable_reads_from_master  : procedure(AMysql: PMysql); stdcall;
    Mysql_enable_rpl_parse          : procedure(AMysql: PMysql); stdcall;
    // 定是否已经读到一个结果集合的最后一行。这功能被反对; mysql_errno()或mysql_error()可以相反被使用
    Mysql_eof                       : function(AResult: pmysql_res): ByteBool; stdcall;
    Mysql_errno                     : function(AMysql: PMysql): Integer; stdcall;
    Mysql_error                     : function(AMysql: PMysql): PAnsiChar; stdcall;
    // 用在SQL语句中的字符串的转义特殊字符 
    Mysql_escape_string             : function(ATo: PAnsiChar; AFrom: PAnsiChar; from_length: LongWord): Longword; stdcall; 
    Mysql_fetch_field               : function(AResult: pmysql_res): pmysql_field411; stdcall; 
    Mysql_fetch_field_direct        : function(AResult: pmysql_res; fieldnr: longword): pmysql_field411; stdcall;
    // 返回当前行中所有列的长度
    Mysql_fetch_fields              : function(AResult: pmysql_res): PMysql_FIELDS; stdcall; 
    Mysql_fetch_lengths             : function(AResult: pmysql_res): PMysql_LENGTHS; stdcall;
    Mysql_fetch_row                 : function(AResult: pmysql_res): PMysql_ROW; stdcall;

    Mysql_field_count               : function(AMysql: PMysql): Longword; stdcall;
    // 把列光标放在一个指定的列上
    Mysql_field_seek                : function(AResult: pmysql_res; offset: Mysql_FIELD_OFFSET): Mysql_FIELD_OFFSET; stdcall;
    // 返回用于最后一个mysql_fetch_field()的字段光标的位置 
    Mysql_field_tell                : function(AResult: pmysql_res): MYSQL_FIELD_OFFSET; stdcall;
     
    Mysql_free_result               : procedure(AResult: pmysql_res); stdcall; 
    Mysql_get_character_set_info    : procedure(AMysql: PMysql; charset: PAnsiCharset_info); stdcall;
    Mysql_get_client_info           : function: PAnsiChar; stdcall; 
    Mysql_get_client_version        : function: Longword; stdcall; 
    Mysql_get_host_info             : function(AMysql: PMysql): PAnsiChar; stdcall;
    Mysql_get_parameters            : function: pmysql_parameters; stdcall;
    Mysql_get_proto_info            : function(AMysql: PMysql): Longword; stdcall;
    Mysql_get_server_info           : function(AMysql: PMysql): PAnsiChar; stdcall;
    Mysql_get_server_version        : function(AMysql: PMysql): Integer; stdcall; 
    Mysql_get_ssl_cipher            : function: Longword; stdcall; 
    Mysql_hex_string                : function(ato: PAnsiChar; from: PAnsiChar; from_length: LongWord): Longword; stdcall; 
    Mysql_info                      : function(AMysql: PMysql): PAnsiChar; stdcall;
    Mysql_init                      : function(AMysql: PMysql): PMysql; stdcall;
    Mysql_insert_id                 : function(AMysql: PMysql): Longword; stdcall;
    Mysql_kill                      : function(AMysql: PMysql; pid: longword): Integer; stdcall;
    Mysql_list_dbs                  : function(AMysql: PMysql; wild: PAnsiChar): pmysql_res; stdcall;
    Mysql_list_fields               : function(AMysql: PMysql; table: PAnsiChar; wild: PAnsiChar): pmysql_res; stdcall; 
    Mysql_list_processes            : function(AMysql: PMysql): pmysql_res; stdcall; 
    Mysql_list_tables               : function(AMysql: PMysql; wild: PAnsiChar): pmysql_res; stdcall; 
    Mysql_master_query              : function(AMysql: PMysql; q: PAnsiChar; length: LongWord): ByteBool; stdcall; 
    Mysql_more_results              : function(AMysql: PMysql): ByteBool; stdcall; 
    Mysql_next_result               : function(AMysql: PMysql): ByteBool; stdcall;
    Mysql_num_fields                : function(AResult: pmysql_res): Longword; stdcall;
    Mysql_num_rows                  : function(AResult: pmysql_res): Longword; stdcall;
    // 设置对mysql_connect()的连接选项
    Mysql_options                   : function(AMysql: PMysql; option: integer; var arg: integer): Integer; stdcall;
    Mysql_ping                      : function(AMysql: PMysql): Longint; stdcall; 
    Mysql_query                     : function(AMysql: PMysql; const q: PAnsiChar): longint; stdcall;
    Mysql_read_query_result         : function(AMysql: PMysql): longint; stdcall;
    Mysql_real_connect              : function(AMysql: PMysql;
                                                host, user, passwd, db: PAnsiChar;
                                                port: longword;
                                                unix_socket: PAnsiChar;
                                                clientflag: longword): PMysql; stdcall; 
    Mysql_real_escape_string        : function(AMysql: PMysql; ato: PAnsiChar; from: PAnsiChar; from_length: LongWord): Longword; stdcall; 
    Mysql_real_query                : function(AMysql: PMysql; const sql: PAnsiChar; length: longword): Integer; stdcall;
    Mysql_refresh                   : function(AMysql: PMysql; refresh_options: LongWord): Integer; stdcall; 
    Mysql_rollback                  : function(AMysql: PMysql): ByteBool; stdcall;
    Mysql_row_seek                  : function(AResult: pmysql_res; offset: Mysql_ROW_OFFSET): Mysql_ROW_OFFSET; stdcall;
    Mysql_row_tell                  : function(AResult: pmysql_res): PMysql_ROWS; stdcall; 
    Mysql_rpl_parse_enabled         : function(AMysql: PMysql): Integer; stdcall; 
    Mysql_rpl_probe                 : function(AMysql: PMysql): ByteBool; stdcall; 
    Mysql_rpl_query_type            : function(q: PAnsiChar; length: Integer): TMYSQL_RPL_TYPE; stdcall;
    Mysql_select_db                 : function(AMysql: PMysql; const db: PAnsiChar): Integer; stdcall;
    Mysql_send_query                : function(AMysql: PMysql; const q: PAnsiChar; length: longword): longint; stdcall;
    Mysql_server_end                : procedure; stdcall;
    Mysql_server_init               : function(argc: integer; argv: PPChar; groups: PPChar): Integer; stdcall;
    Mysql_set_character_set         : function(AMysql: PMysql; csname: PAnsiChar): Integer; stdcall;
    Mysql_set_local_infile_default  : procedure(AMysql: PMysql); stdcall;
    Mysql_set_local_infile_handler  : function: Longword; stdcall;
    Mysql_set_server_option         : function(AMysql: PMysql; option: TMYSQL_SET_OPTION): Integer; stdcall;
    Mysql_shutdown                  : function(AMysql: PMysql; shutdown_level: TMYSQL_SHUTDOWN_LEVEL): Integer; stdcall;
//    Mysql_shutdown                  : function(AMysql: PMysql): Integer; stdcall;
    Mysql_slave_query               : function(AMysql: PMysql; q: PAnsiChar; length: LongWord): Integer; stdcall;
    Mysql_sqlstate                  : function(AMysql: PMysql): PAnsiChar; stdcall; 
    Mysql_ssl_set                   : function(AMysql: PMysql; const key, cert, ca, capath, cipher: PAnsiChar): Integer; stdcall;
    Mysql_stat                      : function(AMysql: PMysql): PAnsiChar; stdcall;
    Mysql_stmt_affected_rows        : function(APStatement: PMysql_Statement): int64; stdcall; 
    Mysql_stmt_attr_get             : function: Longword; stdcall; 
    Mysql_stmt_attr_set             : function: Longword; stdcall; 
    Mysql_stmt_bind_param           : function(APStatement: PMysql_Statement;  bnd: PMysql_BIND): ByteBool; stdcall;
    Mysql_stmt_bind_result          : function(APStatement: PMysql_Statement;  pbnd: PMysql_BIND): ByteBool; stdcall; 
    Mysql_stmt_close                : function(APStatement: PMysql_Statement): ByteBool; stdcall; 
    Mysql_stmt_data_seek            : function: Longword; stdcall; 
    Mysql_stmt_errno                : function(APStatement: PMysql_Statement): UINT; stdcall; 
    Mysql_stmt_error                : function(APStatement: PMysql_Statement): PAnsiChar; stdcall; 
    Mysql_stmt_execute              : function(APStatement: PMysql_Statement): integer; stdcall;
    Mysql_stmt_fetch                : function(APStatement: PMysql_Statement): integer; stdcall; 
    Mysql_stmt_fetch_column         : function(APStatement: PMysql_Statement; bnd: PMysql_BIND; column: uint; offset: longword): integer; stdcall; 
    Mysql_stmt_field_count          : function(APStatement: PMysql_Statement): UINT; stdcall; 
    Mysql_stmt_free_result          : function(APStatement: PMysql_Statement): ByteBool; stdcall; 
    Mysql_stmt_init                 : function(AMysql: PMysql): PMysql_Statement; stdcall; 
    Mysql_stmt_insert_id            : function: Longword; stdcall; 
    Mysql_stmt_num_rows             : function: Longword; stdcall; 
    Mysql_stmt_param_count          : function(APStatement: PMysql_Statement): UINT; stdcall;
    Mysql_stmt_param_metadata       : function(APStatement: PMysql_Statement): pmysql_res; stdcall; 
    Mysql_stmt_prepare              : function(APStatement: PMysql_Statement; query: PAnsiChar; length: UINT): integer; stdcall; 
    Mysql_stmt_reset                : function: Longword; stdcall; 
    Mysql_stmt_result_metadata      : function(APStatement: PMysql_Statement): pmysql_res; stdcall; 
    Mysql_stmt_row_seek             : function: Longword; stdcall; 
    Mysql_stmt_row_tell             : function: Longword; stdcall; 
    Mysql_stmt_send_long_data       : function(APStatement: PMysql_Statement;  param_number: UINT;  data: PAnsiChar;  length: UINT): ByteBool; stdcall; 
    Mysql_stmt_sqlstate             : function: Longword; stdcall; 
    Mysql_stmt_store_result         : function(APStatement: PMysql_Statement): integer; stdcall;
    (*
    在使用mysql_query()进行一个查询后，一般要用这两个函数之一来把结果存到一个MYSQL_RES *变量中。
    两者的主要区别是，mysql_use_result()的结果必须“一次性用完”，也就是说用它得到一个result后，
    必须反复用mysql_fetch_row()读取其结果直至该函数返回null为止，否则如果你再次进行mysql查询，
    会得到“Commands out of sync; you can't run this command now”的错误。而mysql_store_result()得到result是存下来的，
    你无需把全部行结果读完，就可以进行另外的查询。比如你进行一个查询，得到一系列记录，再根据这些结果，
    用一个循环再进行数据库查询，就只能用mysql_store_result()。
    *)
    Mysql_store_result              : function(AMysql: PMysql): pmysql_res; stdcall;
    Mysql_thread_end                : function: Longword; stdcall;
    Mysql_thread_id                 : function(AMysql: PMysql): Longword; stdcall;
    Mysql_thread_init               : function: Longword; stdcall;
    Mysql_thread_safe               : function: Longword; stdcall;
    Mysql_use_result                : function(AMysql: PMysql): pmysql_res; stdcall;
    Mysql_warning_count             : function(AMysql: PMysql): Integer; stdcall;
    _dig_vec_lower                  : function: Longword; stdcall;
    _dig_vec_upper                  : function: Longword; stdcall;
    bmove_upp                       : function: Longword; stdcall;
    client_errors                   : function: Longword; stdcall;
    delete_dynamic                  : function: Longword; stdcall;
    free_defaults                   : function: Longword; stdcall;
    get_defaults_options            : function: Longword; stdcall;
    getopt_compare_strings          : function: Longword; stdcall;
    getopt_ull_limit_value          : function: Longword; stdcall;
    handle_options                  : function: Longword; stdcall;
    init_dynamic_array              : function: Longword; stdcall;
    insert_dynamic                  : function: Longword; stdcall;
    int2str                         : function: Longword; stdcall;
    is_prefix                       : function: Longword; stdcall;
    list_add                        : function: Longword; stdcall;
    list_delete                     : function: Longword; stdcall;
    load_defaults                   : function: Longword; stdcall;
    modify_defaults_file            : function: Longword; stdcall;
    my_end                          : function: Longword; stdcall;
    my_getopt_print_errors          : function: Longword; stdcall;
    my_init                         : function: Longword; stdcall;
    my_malloc                       : function: Longword; stdcall;
    my_memdup                       : function: Longword; stdcall;
    my_no_flags_free                : function: Longword; stdcall;
    my_path                         : function: Longword; stdcall;
    my_print_help                   : function: Longword; stdcall;
    my_print_variables              : function: Longword; stdcall;
    my_realloc                      : function: Longword; stdcall;
    my_strdup                       : function: Longword; stdcall;
    myodbc_remove_escape            : function: Longword; stdcall;
    set_dynamic                     : function: Longword; stdcall;
    strcend                         : function: Longword; stdcall;
    strcont                         : function: Longword; stdcall;
    strdup_root                     : function: Longword; stdcall;
    strfill                         : function: Longword; stdcall;
    strinstr                        : function: Longword; stdcall;
    strmake                         : function: Longword; stdcall;
    strmov                          : function: Longword; stdcall;
    strxmov                         : function: Longword; stdcall;
  end;

  procedure InitMySQL(AMysql5: PMysql5);

implementation 

uses
  dll_kernel;
   
function mysql_affected_rows(mysql: pmysql): LongWord; stdcall; external libmySQL; 
function mysql_autocommit(mysql: pmysql; auto_mode: ByteBool): ByteBool; stdcall; external libmySQL; 
function mysql_change_user(mysql: pmysql; user, passwd, db: PAnsiChar): ByteBool; stdcall; external libmySQL; 
function mysql_character_set_name(mysql: pmysql): PAnsiChar; stdcall; external libmySQL; 
procedure mysql_close(mysql: pmysql); stdcall; external libmySQL; 
function mysql_commit(mysql: pmysql): ByteBool; stdcall; external libmySQL; 
procedure mysql_data_seek(result: pmysql_res; offset: int64); stdcall; external libmySQL; 
procedure mysql_debug(debug: PAnsiChar); stdcall; external libmySQL; 
procedure mysql_disable_reads_from_master(mysql: pmysql); stdcall; external libmySQL; 
procedure mysql_disable_rpl_parse(mysql: pmysql); stdcall; external libmySQL; 
function mysql_dump_debug_info(mysql: pmysql): Integer; stdcall; external libmySQL; 
function mysql_embedded(): ByteBool; stdcall; external libmySQL; 
procedure mysql_enable_reads_from_master(mysql: pmysql); stdcall; external libmySQL; 
procedure mysql_enable_rpl_parse(mysql: pmysql); stdcall; external libmySQL; 
function mysql_eof(result: pmysql_res): ByteBool; stdcall; external libmySQL; 
function mysql_errno(mysql: pmysql): Integer; stdcall; external libmySQL; 
function mysql_error(mysql: pmysql): PAnsiChar; stdcall; external libmySQL; 
function mysql_escape_string(ato: PAnsiChar; from: PAnsiChar; from_length: LongWord): LongWord; stdcall; external libmySQL; 
function mysql_fetch_field(result: pmysql_res): pmysql_field411; stdcall; external libmySQL;
function mysql_fetch_field_direct(result: pmysql_res; fieldnr: LongWord): pmysql_field411; stdcall; external libmySQL; 
function mysql_fetch_fields(result: pmysql_res): pmysql_fields; stdcall; external libmySQL; 
function mysql_fetch_lengths(result: pmysql_res): LongWord; stdcall; external libmySQL; 
function mysql_fetch_row(result: pmysql_res): pmysql_row; stdcall; external libmySQL; 
function mysql_field_count(result: pmysql_res): LongWord; stdcall; external libmySQL; 
function mysql_field_seek(result: pmysql_res; offset: MYSQL_FIELD_OFFSET): MYSQL_FIELD_OFFSET; stdcall; external libmySQL; 
function mysql_field_tell(result: pmysql_res): MYSQL_FIELD_OFFSET; stdcall; external libmySQL; 
procedure mysql_free_result(mysql: pmysql_res); stdcall; external libmySQL; 
procedure mysql_get_character_set_info(mysql: pmysql; charset: PAnsiCharset_info); stdcall; external libmySQL; 
function mysql_get_client_info(): PAnsiChar; stdcall; external libmySQL; 
function mysql_get_client_version(): LongWord; stdcall; external libmySQL; 
function mysql_get_host_info(): PAnsiChar; stdcall; external libmySQL; 
function mysql_get_parameters(): pmysql_parameters; external libmySQL; 
function mysql_get_proto_info(mysql: pmysql): Integer; stdcall; external libmySQL; 
function mysql_get_server_info(mysql: pmysql): PAnsiChar; stdcall; external libmySQL; 
function mysql_get_server_version(mysql: pmysql): Integer; stdcall; external libmySQL; 
function mysql_hex_string(ato: PAnsiChar; from: PAnsiChar; from_length: LongWord): LongWord; stdcall; external libmySQL; 
function mysql_info(mysql: pmysql): PAnsiChar; stdcall; external libmySQL; 
function mysql_init(mysql: pmysql): pmysql; stdcall; external libmySQL; 
function mysql_insert_id(mysql: pmysql): Longword; stdcall; external libmySQL; 
function mysql_kill(mysql: pmysql; pid: LongWord): Integer; stdcall; external libmySQL; 
function mysql_list_dbs(mysql: pmysql; wild: PAnsiChar): pmysql_res; stdcall; external libmySQL; 
function mysql_list_fields(mysql: pmysql; table: PAnsiChar; wild: PAnsiChar): pmysql_res; stdcall; external libmySQL; 
function mysql_list_processes(mysql: pmysql): pmysql_res; stdcall; external libmySQL; 
function mysql_list_tables(mysql: pmysql; wild: PAnsiChar): pmysql_res; stdcall; external libmySQL; 
function mysql_master_query(mysql: pmysql; q: PAnsiChar; length: LongWord): ByteBool; stdcall; external libmySQL; 
function mysql_more_results(mysql: pmysql): ByteBool; stdcall; external libmySQL; 
function mysql_next_result(mysql: pmysql): Integer; stdcall; external libmySQL; 
function mysql_num_fields(result: pmysql_res): LongWord; stdcall; external libmySQL; 
function mysql_num_rows(result: pmysql_res): LongWord; stdcall; external libmySQL; 
//function mysql_options(mysql: pmysql; option: MYSQL_OPTION; arg: PAnsiChar): Integer; stdcall; external libmySQL;
function mysql_ping(mysql: pmysql): Integer; stdcall; external libmySQL; 
function mysql_query(mysql: pmysql; q: PAnsiChar): Integer; stdcall; external libmySQL; 
function mysql_read_query_result(mysql: pmysql): ByteBool; stdcall; external libmySQL; 
function mysql_real_connect(mysql: pmysql; const host, user, passwd, db: PAnsiChar; port: Cardinal; unix_socket: PAnsiChar; clientflag: Cardinal): pmysql; stdcall; external libmySQL; 
function mysql_real_escape_string(mysql: pmysql; ato: PAnsiChar; from: PAnsiChar; from_length: LongWord): LongWord; stdcall; external libmySQL; 
function mysql_real_query(mysql: pmysql; q: PAnsiChar; length: LongWord): Integer; stdcall; external libmySQL; 
function mysql_refresh(mysql: pmysql; refresh_options: LongWord): Integer; stdcall; external libmySQL; 
function mysql_rollback(mysql: pmysql): ByteBool; stdcall; external libmySQL; 
function mysql_row_seek(result: pmysql_res; offset: MYSQL_ROW_OFFSET): MYSQL_ROW_OFFSET; stdcall; external libmySQL; 
function mysql_row_tell(result: pmysql_res): MYSQL_ROW_OFFSET; stdcall; external libmySQL; 
function mysql_rpl_parse_enabled(mysql: pmysql): Integer; stdcall; external libmySQL; 
function mysql_rpl_probe(mysql: pmysql): ByteBool; stdcall; external libmySQL; 
function mysql_rpl_query_type(q: PAnsiChar; length: Integer): TMYSQL_RPL_TYPE; stdcall; external libmySQL; 
function mysql_select_db(mysql: pmysql; db: PAnsiChar): Integer; stdcall; external libmySQL; 
function mysql_send_query(mysql: pmysql; q: PAnsiChar; length: LongWord): Integer; stdcall; external libmySQL; 
procedure mysql_server_end(); stdcall; external libmySQL; 
function mysql_server_init(argc: Integer; argv: Pointer; groups: Pointer): Integer; stdcall; external libmySQL; 
function mysql_set_character_set(mysql: pmysql; csname: PAnsiChar): Integer; stdcall; external libmySQL; 
procedure mysql_set_local_infile_default(mysql: pmysql); stdcall; external libmySQL; 
function mysql_set_server_option(mysql: pmysql; option: TMYSQL_SET_OPTION): Integer; stdcall; external libmySQL;
function mysql_shutdown(mysql: pmysql; shutdown_level: TMYSQL_SHUTDOWN_LEVEL): Integer; stdcall; external libmySQL; 
function mysql_slave_query(mysql: pmysql; q: PAnsiChar; length: LongWord): Integer; stdcall; external libmySQL; 
function mysql_sqlstate(mysql: pmysql): PAnsiChar; stdcall; external libmySQL; 
function mysql_stat(mysql: pmysql): PAnsiChar; stdcall; external libmySQL; 
function mysql_store_result(mysql: pmysql): pmysql_res; stdcall; external libmySQL; 
function mysql_use_result(mysql: pmysql): pmysql_res; stdcall; external libmySQL; 
function mysql_warning_count(mysql: pmysql): Integer; stdcall; external libmySQL; 
  
procedure InitMySQL(AMysql5: PMysql5);
begin
  if AMysql5.Module = 0 then
    exit;
  AMysql5.mysql_affected_rows             := GetProcAddress(AMysql5.Module, 'mysql_affected_rows');
  AMysql5.mysql_autocommit                := GetProcAddress(AMysql5.Module, 'mysql_autocommit');
  AMysql5.mysql_change_user               := GetProcAddress(AMysql5.Module, 'mysql_change_user');
  AMysql5.mysql_character_set_name        := GetProcAddress(AMysql5.Module, 'mysql_character_set_name');
  AMysql5.mysql_close                     := GetProcAddress(AMysql5.Module, 'mysql_close');
  AMysql5.mysql_commit                    := GetProcAddress(AMysql5.Module, 'mysql_commit');
  AMysql5.mysql_data_seek                 := GetProcAddress(AMysql5.Module, 'mysql_data_seek');
  AMysql5.mysql_debug                     := GetProcAddress(AMysql5.Module, 'mysql_debug');
  AMysql5.mysql_disable_reads_from_master := GetProcAddress(AMysql5.Module, 'mysql_disable_reads_from_master');
  AMysql5.mysql_disable_rpl_parse         := GetProcAddress(AMysql5.Module, 'mysql_disable_rpl_parse');
  AMysql5.mysql_dump_debug_info           := GetProcAddress(AMysql5.Module, 'mysql_dump_debug_info');
  AMysql5.mysql_embedded                  := GetProcAddress(AMysql5.Module, 'mysql_embedded');
  AMysql5.mysql_enable_reads_from_master  := GetProcAddress(AMysql5.Module, 'mysql_enable_reads_from_master');
  AMysql5.mysql_enable_rpl_parse          := GetProcAddress(AMysql5.Module, 'mysql_enable_rpl_parse');
  AMysql5.mysql_eof                       := GetProcAddress(AMysql5.Module, 'mysql_eof');
  AMysql5.mysql_errno                     := GetProcAddress(AMysql5.Module, 'mysql_errno');
  AMysql5.mysql_error                     := GetProcAddress(AMysql5.Module, 'mysql_error');
  AMysql5.mysql_escape_string             := GetProcAddress(AMysql5.Module, 'mysql_escape_string');
  AMysql5.mysql_fetch_field               := GetProcAddress(AMysql5.Module, 'mysql_fetch_field');
  AMysql5.mysql_fetch_field_direct        := GetProcAddress(AMysql5.Module, 'mysql_fetch_field_direct');
  AMysql5.mysql_fetch_fields              := GetProcAddress(AMysql5.Module, 'mysql_fetch_fields');
  AMysql5.mysql_fetch_lengths             := GetProcAddress(AMysql5.Module, 'mysql_fetch_lengths');
  AMysql5.mysql_fetch_row                 := GetProcAddress(AMysql5.Module, 'mysql_fetch_row');
  AMysql5.mysql_field_count               := GetProcAddress(AMysql5.Module, 'mysql_field_count');
  AMysql5.mysql_field_seek                := GetProcAddress(AMysql5.Module, 'mysql_field_seek');
  AMysql5.mysql_field_tell                := GetProcAddress(AMysql5.Module, 'mysql_field_tell');
  AMysql5.mysql_free_result               := GetProcAddress(AMysql5.Module, 'mysql_free_result');
  AMysql5.mysql_get_character_set_info    := GetProcAddress(AMysql5.Module, 'mysql_get_character_set_info');
  AMysql5.mysql_get_client_info           := GetProcAddress(AMysql5.Module, 'mysql_get_client_info');
  AMysql5.mysql_get_client_version        := GetProcAddress(AMysql5.Module, 'mysql_get_client_version');
  AMysql5.mysql_get_host_info             := GetProcAddress(AMysql5.Module, 'mysql_get_host_info');
  AMysql5.mysql_get_parameters            := GetProcAddress(AMysql5.Module, 'mysql_get_parameters');
  AMysql5.mysql_get_proto_info            := GetProcAddress(AMysql5.Module, 'mysql_get_proto_info');
  AMysql5.mysql_get_server_info           := GetProcAddress(AMysql5.Module, 'mysql_get_server_info');
  AMysql5.mysql_get_server_version        := GetProcAddress(AMysql5.Module, 'mysql_get_server_version');
  AMysql5.mysql_get_ssl_cipher            := GetProcAddress(AMysql5.Module, 'mysql_get_ssl_cipher');
  AMysql5.mysql_hex_string                := GetProcAddress(AMysql5.Module, 'mysql_hex_string');
  AMysql5.mysql_info                      := GetProcAddress(AMysql5.Module, 'mysql_info');
  AMysql5.mysql_init                      := GetProcAddress(AMysql5.Module, 'mysql_init');
  AMysql5.mysql_insert_id                 := GetProcAddress(AMysql5.Module, 'mysql_insert_id');
  AMysql5.mysql_kill                      := GetProcAddress(AMysql5.Module, 'mysql_kill');
  AMysql5.mysql_list_dbs                  := GetProcAddress(AMysql5.Module, 'mysql_list_dbs');
  AMysql5.mysql_list_fields               := GetProcAddress(AMysql5.Module, 'mysql_list_fields');
  AMysql5.mysql_list_processes            := GetProcAddress(AMysql5.Module, 'mysql_list_processes');
  AMysql5.mysql_list_tables               := GetProcAddress(AMysql5.Module, 'mysql_list_tables');
  AMysql5.mysql_master_query              := GetProcAddress(AMysql5.Module, 'mysql_master_query');
  AMysql5.mysql_more_results              := GetProcAddress(AMysql5.Module, 'mysql_more_results');
  AMysql5.mysql_next_result               := GetProcAddress(AMysql5.Module, 'mysql_next_result');
  AMysql5.mysql_num_fields                := GetProcAddress(AMysql5.Module, 'mysql_num_fields');
  AMysql5.mysql_num_rows                  := GetProcAddress(AMysql5.Module, 'mysql_num_rows');
  AMysql5.mysql_options                   := GetProcAddress(AMysql5.Module, 'mysql_options');
  AMysql5.mysql_ping                      := GetProcAddress(AMysql5.Module, 'mysql_ping');
  AMysql5.mysql_query                     := GetProcAddress(AMysql5.Module, 'mysql_query');
  AMysql5.mysql_read_query_result         := GetProcAddress(AMysql5.Module, 'mysql_read_query_result');
  AMysql5.mysql_real_connect              := GetProcAddress(AMysql5.Module, 'mysql_real_connect');
  AMysql5.mysql_real_escape_string        := GetProcAddress(AMysql5.Module, 'mysql_real_escape_string');
  AMysql5.mysql_real_query                := GetProcAddress(AMysql5.Module, 'mysql_real_query');
  AMysql5.mysql_refresh                   := GetProcAddress(AMysql5.Module, 'mysql_refresh');
  AMysql5.mysql_rollback                  := GetProcAddress(AMysql5.Module, 'mysql_rollback');
  AMysql5.mysql_row_seek                  := GetProcAddress(AMysql5.Module, 'mysql_row_seek');
  AMysql5.mysql_row_tell                  := GetProcAddress(AMysql5.Module, 'mysql_row_tell');
  AMysql5.mysql_rpl_parse_enabled         := GetProcAddress(AMysql5.Module, 'mysql_rpl_parse_enabled');
  AMysql5.mysql_rpl_probe                 := GetProcAddress(AMysql5.Module, 'mysql_rpl_probe');
  AMysql5.mysql_rpl_query_type            := GetProcAddress(AMysql5.Module, 'mysql_rpl_query_type');
  AMysql5.mysql_select_db                 := GetProcAddress(AMysql5.Module, 'mysql_select_db');
  AMysql5.mysql_send_query                := GetProcAddress(AMysql5.Module, 'mysql_send_query');
  AMysql5.mysql_server_end                := GetProcAddress(AMysql5.Module, 'mysql_server_end');
  AMysql5.mysql_server_init               := GetProcAddress(AMysql5.Module, 'mysql_server_init');
  AMysql5.mysql_set_character_set         := GetProcAddress(AMysql5.Module, 'mysql_set_character_set');
  AMysql5.mysql_set_local_infile_default  := GetProcAddress(AMysql5.Module, 'mysql_set_local_infile_default');
  AMysql5.mysql_set_local_infile_handler  := GetProcAddress(AMysql5.Module, 'mysql_set_local_infile_handler');
  AMysql5.mysql_set_server_option         := GetProcAddress(AMysql5.Module, 'mysql_set_server_option');
  AMysql5.mysql_shutdown                  := GetProcAddress(AMysql5.Module, 'mysql_shutdown');
  AMysql5.mysql_slave_query               := GetProcAddress(AMysql5.Module, 'mysql_slave_query');
  AMysql5.mysql_sqlstate                  := GetProcAddress(AMysql5.Module, 'mysql_sqlstate');
  AMysql5.mysql_ssl_set                   := GetProcAddress(AMysql5.Module, 'mysql_ssl_set');
  AMysql5.mysql_stat                      := GetProcAddress(AMysql5.Module, 'mysql_stat');
  AMysql5.mysql_stmt_affected_rows        := GetProcAddress(AMysql5.Module, 'mysql_stmt_affected_rows');
  AMysql5.mysql_stmt_attr_get             := GetProcAddress(AMysql5.Module, 'mysql_stmt_attr_get');
  AMysql5.mysql_stmt_attr_set             := GetProcAddress(AMysql5.Module, 'mysql_stmt_attr_set');
  AMysql5.mysql_stmt_bind_param           := GetProcAddress(AMysql5.Module, 'mysql_stmt_bind_param');
  AMysql5.mysql_stmt_bind_result          := GetProcAddress(AMysql5.Module, 'mysql_stmt_bind_result');
  AMysql5.mysql_stmt_close                := GetProcAddress(AMysql5.Module, 'mysql_stmt_close');
  AMysql5.mysql_stmt_data_seek            := GetProcAddress(AMysql5.Module, 'mysql_stmt_data_seek');
  AMysql5.mysql_stmt_errno                := GetProcAddress(AMysql5.Module, 'mysql_stmt_errno');
  AMysql5.mysql_stmt_error                := GetProcAddress(AMysql5.Module, 'mysql_stmt_error');
  AMysql5.mysql_stmt_execute              := GetProcAddress(AMysql5.Module, 'mysql_stmt_execute');
  AMysql5.mysql_stmt_fetch                := GetProcAddress(AMysql5.Module, 'mysql_stmt_fetch');
  AMysql5.mysql_stmt_fetch_column         := GetProcAddress(AMysql5.Module, 'mysql_stmt_fetch_column');
  AMysql5.mysql_stmt_field_count          := GetProcAddress(AMysql5.Module, 'mysql_stmt_field_count');
  AMysql5.mysql_stmt_free_result          := GetProcAddress(AMysql5.Module, 'mysql_stmt_free_result');
  AMysql5.mysql_stmt_init                 := GetProcAddress(AMysql5.Module, 'mysql_stmt_init');
  AMysql5.mysql_stmt_insert_id            := GetProcAddress(AMysql5.Module, 'mysql_stmt_insert_id');
  AMysql5.mysql_stmt_num_rows             := GetProcAddress(AMysql5.Module, 'mysql_stmt_num_rows');
  AMysql5.mysql_stmt_param_count          := GetProcAddress(AMysql5.Module, 'mysql_stmt_param_count');
  AMysql5.mysql_stmt_param_metadata       := GetProcAddress(AMysql5.Module, 'mysql_stmt_param_metadata');
  AMysql5.mysql_stmt_prepare              := GetProcAddress(AMysql5.Module, 'mysql_stmt_prepare');
  AMysql5.mysql_stmt_reset                := GetProcAddress(AMysql5.Module, 'mysql_stmt_reset');
  AMysql5.mysql_stmt_result_metadata      := GetProcAddress(AMysql5.Module, 'mysql_stmt_result_metadata');
  AMysql5.mysql_stmt_row_seek             := GetProcAddress(AMysql5.Module, 'mysql_stmt_row_seek');
  AMysql5.mysql_stmt_row_tell             := GetProcAddress(AMysql5.Module, 'mysql_stmt_row_tell');
  AMysql5.mysql_stmt_send_long_data       := GetProcAddress(AMysql5.Module, 'mysql_stmt_send_long_data');
  AMysql5.mysql_stmt_sqlstate             := GetProcAddress(AMysql5.Module, 'mysql_stmt_sqlstate');
  AMysql5.mysql_stmt_store_result         := GetProcAddress(AMysql5.Module, 'mysql_stmt_store_result');
  AMysql5.mysql_store_result              := GetProcAddress(AMysql5.Module, 'mysql_store_result');
  AMysql5.mysql_thread_end                := GetProcAddress(AMysql5.Module, 'mysql_thread_end');
  AMysql5.mysql_thread_id                 := GetProcAddress(AMysql5.Module, 'mysql_thread_id');
  AMysql5.mysql_thread_init               := GetProcAddress(AMysql5.Module, 'mysql_thread_init');
  AMysql5.mysql_thread_safe               := GetProcAddress(AMysql5.Module, 'mysql_thread_safe');
  AMysql5.mysql_use_result                := GetProcAddress(AMysql5.Module, 'mysql_use_result');
  AMysql5.mysql_warning_count             := GetProcAddress(AMysql5.Module, 'mysql_warning_count');
  AMysql5._dig_vec_lower                  := GetProcAddress(AMysql5.Module, '_dig_vec_lower');
  AMysql5._dig_vec_upper                  := GetProcAddress(AMysql5.Module, '_dig_vec_upper');
  AMysql5.bmove_upp                       := GetProcAddress(AMysql5.Module, 'bmove_upp');
  AMysql5.client_errors                   := GetProcAddress(AMysql5.Module, 'client_errors');
  AMysql5.delete_dynamic                  := GetProcAddress(AMysql5.Module, 'delete_dynamic');
  AMysql5.free_defaults                   := GetProcAddress(AMysql5.Module, 'free_defaults');
  AMysql5.get_defaults_options            := GetProcAddress(AMysql5.Module, 'get_defaults_options');
  AMysql5.getopt_compare_strings          := GetProcAddress(AMysql5.Module, 'getopt_compare_strings');
  AMysql5.getopt_ull_limit_value          := GetProcAddress(AMysql5.Module, 'getopt_ull_limit_value');
  AMysql5.handle_options                  := GetProcAddress(AMysql5.Module, 'handle_options');
  AMysql5.init_dynamic_array              := GetProcAddress(AMysql5.Module, 'init_dynamic_array');
  AMysql5.insert_dynamic                  := GetProcAddress(AMysql5.Module, 'insert_dynamic');
  AMysql5.int2str                         := GetProcAddress(AMysql5.Module, 'int2str');
  AMysql5.is_prefix                       := GetProcAddress(AMysql5.Module, 'is_prefix');
  AMysql5.list_add                        := GetProcAddress(AMysql5.Module, 'list_add');
  AMysql5.list_delete                     := GetProcAddress(AMysql5.Module, 'list_delete');
  AMysql5.load_defaults                   := GetProcAddress(AMysql5.Module, 'load_defaults');
  AMysql5.modify_defaults_file            := GetProcAddress(AMysql5.Module, 'modify_defaults_file');
  AMysql5.my_end                          := GetProcAddress(AMysql5.Module, 'my_end');
  AMysql5.my_getopt_print_errors          := GetProcAddress(AMysql5.Module, 'my_getopt_print_errors');
  AMysql5.my_init                         := GetProcAddress(AMysql5.Module, 'my_init');
  AMysql5.my_malloc                       := GetProcAddress(AMysql5.Module, 'my_malloc');
  AMysql5.my_memdup                       := GetProcAddress(AMysql5.Module, 'my_memdup');
  AMysql5.my_no_flags_free                := GetProcAddress(AMysql5.Module, 'my_no_flags_free');
  AMysql5.my_path                         := GetProcAddress(AMysql5.Module, 'my_path');
  AMysql5.my_print_help                   := GetProcAddress(AMysql5.Module, 'my_print_help');
  AMysql5.my_print_variables              := GetProcAddress(AMysql5.Module, 'my_print_variables');
  AMysql5.my_realloc                      := GetProcAddress(AMysql5.Module, 'my_realloc');
  AMysql5.my_strdup                       := GetProcAddress(AMysql5.Module, 'my_strdup');
  AMysql5.myodbc_remove_escape            := GetProcAddress(AMysql5.Module, 'myodbc_remove_escape');
  AMysql5.set_dynamic                     := GetProcAddress(AMysql5.Module, 'set_dynamic');
  AMysql5.strcend                         := GetProcAddress(AMysql5.Module, 'strcend');
  AMysql5.strcont                         := GetProcAddress(AMysql5.Module, 'strcont');
  AMysql5.strdup_root                     := GetProcAddress(AMysql5.Module, 'strdup_root');
  AMysql5.strfill                         := GetProcAddress(AMysql5.Module, 'strfill');
  AMysql5.strinstr                        := GetProcAddress(AMysql5.Module, 'strinstr');
  AMysql5.strmake                         := GetProcAddress(AMysql5.Module, 'strmake');
  AMysql5.strmov                          := GetProcAddress(AMysql5.Module, 'strmov');
  AMysql5.strxmov                         := GetProcAddress(AMysql5.Module, 'strxmov');
end;

end.
