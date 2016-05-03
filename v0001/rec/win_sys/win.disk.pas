unit win.disk;

interface
           
uses
  Windows;

type
  PWinDiskDrive       = ^TWinDiskDrive;
  TWinDiskDrive       = packed record
    DriveType         : UINT;
    DriverPath        : array[0..2] of AnsiChar;
    SectorsPerCluster : DWORD;  // 一个簇内的扇区数
    BytesPerSector    : DWORD;  // 一个扇区内的字节数
    NumOfFreeClusters : DWORD;  // 可用容量
    TotalNumOfClusters: DWORD;  // 总共容量
  end;

  PWinDiskDrives      = ^TWinDiskDrives;
  TWinDiskDrives      = packed record
    DriveCount        : DWORD;
    Drives            : array[0..26] of PWinDiskDrive;
  end;

implementation

procedure GetDiskDriveInfo(ADiskDrive: PWinDiskDrive);
begin
  if nil <> ADiskDrive then
  begin
    ADiskDrive.DriveType := Windows.GetDriveTypeA(PAnsiChar(@ADiskDrive.DriverPath[0]));
    if DRIVE_CDROM = ADiskDrive.DriveType then
    begin         
    end;
    if Windows.GetDiskFreeSpaceA(PAnsiChar(@ADiskDrive.DriverPath[0]),
        ADiskDrive.SectorsPerCluster,
        ADiskDrive.BytesPerSector,
        ADiskDrive.NumOfFreeClusters,
        ADiskDrive.TotalNumOfClusters) then
    begin

    end;
  end;
end;
         
procedure GetDiskDrivesInfo(ADiskDrives: PWinDiskDrives);
begin
  ADiskDrives.DriveCount := Windows.GetLogicalDrives;
end;

(*//
  //  用 WMI 获取信息
{$APPTYPE CONSOLE}
 
uses
  SysUtils,
  ActiveX,
  ComObj,
  Variants;
 
 
function ListDrives : string;
var
  FSWbemLocator  : OLEVariant;
  objWMIService  : OLEVariant;
  colDiskDrives  : OLEVariant;
  colLogicalDisks: OLEVariant;
  colPartitions  : OLEVariant;
  objdiskDrive   : OLEVariant;
  objPartition   : OLEVariant;
  objLogicalDisk : OLEVariant;
  oEnumDiskDrive : IEnumvariant;
  oEnumPartition : IEnumvariant;
  oEnumLogical   : IEnumvariant;
  iValue         : LongWord;
  DeviceID       : string;
begin;
  Result:='';
  FSWbemLocator   := CreateOleObject('WbemScripting.SWbemLocator');
  objWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
  colDiskDrives   := objWMIService.ExecQuery('SELECT DeviceID FROM Win32_DiskDrive');
  oEnumDiskDrive  := IUnknown(colDiskDrives._NewEnum) as IEnumVariant;
  while oEnumDiskDrive.Next(1, objdiskDrive, iValue) = 0 do
   begin
      Writeln(Format('DeviceID %s',[string(objdiskDrive.DeviceID)]));
      DeviceID        := StringReplace(objdiskDrive.DeviceID,'\','\\',[rfReplaceAll]);
      colPartitions   := objWMIService.ExecQuery(Format('ASSOCIATORS OF {Win32_DiskDrive.DeviceID="%s"} WHERE AssocClass = Win32_DiskDriveToDiskPartition',[DeviceID]));
      oEnumPartition  := IUnknown(colPartitions._NewEnum) as IEnumVariant;
      while oEnumPartition.Next(1, objPartition, iValue) = 0 do
      begin
       if not VarIsNull(objPartition.DeviceID) then
       begin
        Writeln(Format('   Partition %s',[string(objPartition.DeviceID)]));
        colLogicalDisks := objWMIService.ExecQuery(
            'ASSOCIATORS OF {Win32_DiskPartition.DeviceID="'+VarToStr(objPartition.DeviceID)+'"} WHERE AssocClass = Win32_LogicalDiskToPartition');
        oEnumLogical  := IUnknown(colLogicalDisks._NewEnum) as IEnumVariant;
          while oEnumLogical.Next(1, objLogicalDisk, iValue) = 0 do
          begin
              Writeln(Format('     Logical Disk %s',[string(objLogicalDisk.DeviceID)]));
              objLogicalDisk:=Unassigned;
          end;
       end;
       objPartition:=Unassigned;
      end;
       objdiskDrive:=Unassigned;
   end;
end;
 
begin
 try
    CoInitialize(nil);
    try
      ListDrives;
    finally
      CoUninitialize;
    end;
 except
    on E:Exception do
        Writeln(E.Classname, ':', E.Message);
  end;
  Readln;
end.

DeviceID \\.\PHYSICALDRIVE1
   Partition Disk #1, Partition #0
     Logical Disk C:
DeviceID \\.\PHYSICALDRIVE0
   Partition Disk #0, Partition #0
     Logical Disk D:
   Partition Disk #0, Partition #1
     Logical Disk E:
   Partition Disk #0, Partition #2
     Logical Disk F:  
//*)
end.
