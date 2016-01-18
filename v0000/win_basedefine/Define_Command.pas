unit Define_Command;

interface

const                         
  Cmd_SysBase         = 100;
  Cmd_AppBase         = 200;
  // 外部通知自身 关闭
  Cmd_S2C_ClientShutdown  = Cmd_AppBase + 1;
  // 外部通知自身 重启
  Cmd_S2C_ClientRestart   = Cmd_AppBase + 2;
  
  Cmd_CustomAppBase   = 500;

implementation

end.
