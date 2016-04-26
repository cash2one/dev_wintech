unit HttpResCache;

interface

uses
  win.diskfile;
  
type
  PHttpResCacheNode         = ^THttpResCacheNode;
  THttpResCacheNode         = record
    FileSession             : PWinFile;

    AccessHour              : Integer; //
    AccessMinute            : Integer; //
    AccessSecond            : Integer; // 
    AccessCounterPerSecond  : Integer; // 一秒内访问次数
    AccessCounterPerMinute  : Integer; // 一分钟内访问次数
    // 如果访问一个资源过于频繁,资源大小不是很大的话 可以
    // 全部加载到内存中 关闭文件句柄
    CacheMemory             : Pointer;
  end;

  THttpResCache = record

  end;
  
implementation

end.
