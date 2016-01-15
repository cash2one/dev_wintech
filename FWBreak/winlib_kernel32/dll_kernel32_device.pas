unit dll_kernel32_device;

interface
             
const
  DDD_RAW_TARGET_PATH             = $00000001; // 使用lpTargetPath参数
  DDD_REMOVE_DEFINITION           = $00000002; // 删除指定设备声明
  DDD_EXACT_MATCH_ON_REMOVE       = $00000004; // 确保不会删除未声明的对象
  DDD_NO_BROADCAST_SYSTEM         = $00000008; // 设置 WM_SETTINGCHANGE消息的状态为不发送。(默认情况下，该消息状态为发送）

(*
  //  DefineDosDevice函数控制虚拟驱动器

      使用SetVolumeMountPoint函数定义一个驱动器号。
      使用DeleteVolumeMountPoint函数删除一个已存在的驱动器号。
      在应用层调用DefinesDosDevice创建的符号链接，会放在内核对象空间\\Sessions\\X\\DosDevices\\xxxxxxxx\\ 下

      http://blog.csdn.net/timmy_zhou/article/details/8052143
      
      在NT系统中，每个设备都有几个特殊的路径，在访问这些设备时可以当成文件访问，这些路径不区分大小写。 
      访问硬盘最常用的路径是：//./PhysicalDrive＋数字，如//./PhysicalDrive0表示第一个物理硬盘。取得该硬盘句柄的方法一般用CreateFile（），如 
      CString hd=////.//PhysicalDrive0; 
      hDevice = CreateFile(hd, GENERIC_READ|GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL); 
      打开成功后就可以用ReadFile等函数进行读写操作。 
      访问硬盘还可以有其它路径，如“/Device/Harddisk0”。 
      如果想访问分区，可以有以下几种方法： 
      //?/C:表示C盘的路径，用访问硬盘的方法可以对它进行访问。C盘还可以用"/Device/HarddiskVolume1",
              "/Device/Harddisk0/Partition1",
              //?/Volume{385baaca-8b42-11dc-bb79-0013d324fc7d}/(用GetVolumeNameForVolumeMountPoint（）获得)。 
      提示：如果想获得硬盘整体的物理信息，可以用这个硬盘上任意一个分区的句柄来代替硬盘句柄。 
      如果发现某些路径用CreateFile打不开，可以用DefineDosDevice（）给它定义一个盘符，这个盘符可以是A:,B:，
          也可以是特殊符号(如[:,]:)甚至是数字(1:,2:)。对于非字母的的盘符，在我的电脑里是不可见的，
          只有程序可以访问，这种方法常用于访问隐藏分区。 
      例： 
      DefineDosDevice (DDD_RAW_TARGET_PATH, "[:" 
      "//Device//Harddisk0//Partition1");//分配一个“[:”盘符，该盘符不可见。 
      …………………………//处理代码 
      bRet = DefineDosDevice ( 
      DDD_RAW_TARGET_PATH|DDD_REMOVE_DEFINITION| 
      DDD_EXACT_MATCH_ON_REMOVE, "[:", 
      "//Device//Harddisk0//Partition1");//用完后删除这个盘符
      ====================================================================================================
      快速隐藏分区---实现代码
      功能需求相当于umount，要求在一秒种内只剩下C盘。

      QueryDosDevice(chDosDevice,chNtPath,MAX_PATH);
      for(int Mask=1;Mask;Mask<<=1,chDosDevice[0]++)
      {
      if(dwDisks&Mask)
      {
      QueryDosDevice(chDosDevice,chNtPath,MAX_PATH);

      SaveContext Context;
      Context.strDosDevice=chDosDevice;
      Context.strNtPath=chNtPath;

      //先保存符号名和设备之间的关系
      NtDevices.push_back(Context);

      cout<<Context.strDosDevice<<"<--->"<<Context.strNtPath<<endl;

      //除了C:以外其它的盘符正一个一个的不见了
      DefineDosDevice(DDD_REMOVE_DEFINITION,Context.strDosDevice.c_str(),NULL);
      }
      D:<--->/Device/HarddiskVolume2
      E:<--->/Device/CdRom0
      F:<--->/Device/CdRom1
      G:<--->/Device/HarddiskVolume4
      H:<--->/Device/HarddiskVolume5
      I:<--->/Device/HarddiskVolume6
      J:<--->/Device/HarddiskVolume7
      Z:<--->/Device/PGPdisks/PGPdiskVolume1
*)
  function DefineDosDeviceA(
      dwFlags: DWORD;
      // 设备名称字符串不是必须将冒号作为最后一个字符，
      // 除非一个驱动器号被定义，重新定义或删除。在任何情况下，一个反斜杆是不允许的
      lpDeviceName: PAnsiChar;
      // 指向路径字符串，如果设置DDD_RAW_TARGET_PATH参数，则指向路径字符串
      lpTargetPath: PAnsiChar
      ): BOOL; stdcall; external kernel32 name 'DefineDosDeviceA';
  function DefineDosDeviceW(
      dwFlags: DWORD;
      lpDeviceName: PWideChar;
      lpTargetPath: PWideChar
      ): BOOL; stdcall; external kernel32 name 'DefineDosDeviceW';

  function QueryDosDeviceA(
      lpDeviceName: PAnsiChar;
      lpTargetPath: PAnsiChar;
      ucchMax: DWORD): DWORD; stdcall; external kernel32 name 'QueryDosDeviceA';

  function QueryDosDeviceW(
      lpDeviceName: PWideChar;
      lpTargetPath: PWideChar;
      ucchMax: DWORD): DWORD; stdcall; external kernel32 name 'QueryDosDeviceW';

implementation

end.