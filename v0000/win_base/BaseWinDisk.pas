unit BaseWinDisk;

interface

uses
  Windows;
  
type
  PWinDisk                = ^TWinDisk;
  TWinDisk                = record
    //lpRootPathName: PAnsiChar;
    DriveType             : UINT;
    SectorsPerCluster     : DWORD;
    BytesPerSector        : DWORD;
    NumberOfFreeClusters  : DWORD;
    TotalNumberOfClusters : DWORD;
  end;
  
implementation

(*
GetDiskFreeSpaceA 获取与一个磁盘的组织有关的信息，以及了解剩余空间的容量
GetDiskFreeSpaceExA 获取与一个磁盘的组织以及剩余空间容量有关的信息
GetDriveTypeA 判断一个磁盘驱动器的类型
GetLogicalDrives 判断系统中存在哪些逻辑驱动器字母
GetFullPathNameA 获取指定文件的详细路径
GetVolumeInformationA 获取与一个磁盘卷有关的信息
GetWindowsDirectoryA 获取Windows目录的完整路径名
GetSystemDirectoryA 取得Windows系统目录（即System目录）的完整路径名
*)
procedure OpenWinDisk(AWinDisk: PWinDisk);
var
  tmpMaximumComponentLength: DWORD;
  tmpFileSystemFlags: DWORD;
begin
  Windows.GetDiskFreeSpaceA('',
    AWinDisk.SectorsPerCluster,
    AWinDisk.BytesPerSector,
    AWinDisk.NumberOfFreeClusters,
    AWinDisk.TotalNumberOfClusters);
  AWinDisk.DriveType := Windows.GetDriveTypeA('c:');

  GetVolumeInformationA(
    '', //lpRootPathName: PAnsiChar;
    '', //lpVolumeNameBuffer: PAnsiChar;
    0, //nVolumeNameSize: DWORD;
    nil, //lpVolumeSerialNumber: PDWORD;
    tmpMaximumComponentLength,
    tmpFileSystemFlags,
    '', //lpFileSystemNameBuffer: PAnsiChar;
    0 //nFileSystemNameSize: DWORD
  );
  //Windows.GetFullPathNameA();
  //GetDiskFreeSpaceExA();
end;

end.
