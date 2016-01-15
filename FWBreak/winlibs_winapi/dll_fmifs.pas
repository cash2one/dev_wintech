(*
fmifs.dll, which are used to format fixed or removable 
disk drives and perform disk checks on Windows NT4 and later. 

It supports any local disk drive that has been assigned a 
drive letter by Windows, just like the normal format and 
check disk tools in Windows.

    Chkdsk := GetProcAddress (MagFmifsib, 'Chkdsk') ;
    FormatEx := GetProcAddress (MagFmifsib, 'FormatEx') ;
    EnableVolumeCompession := GetProcAddress (MagFmifsib, 'EnableVolumeCompession') ;
*)
unit dll_fmifs;

interface

const    
  fmifs = 'fmifs.dll' ;
// media flags
  FMIFS_HARDDISK = $0C ;
  FMIFS_FLOPPY   = $08 ;


// Callback command types
    TCallBackCommand = (
        PROGRESS,
        DONEWITHSTRUCTURE,
    	UNKNOWN2,
	    UNKNOWN3,
    	UNKNOWN4,
	    UNKNOWN5,
    	INSUFFICIENTRIGHTS,
	    FSNOTSUPPORTED,  // added 1.1
    	VOLUMEINUSE,     // added 1.1
    	UNKNOWN9,
	    UNKNOWNA,
    	DONE,
	    UNKNOWNC,
    	UNKNOWND,
    	OUTPUT,
        STRUCTUREPROGRESS,
        CLUSTERSIZETOOSMALL, // 16
        UNKNOWN11,
        UNKNOWN12,
        UNKNOWN13,
        UNKNOWN14,
        UNKNOWN15,
        UNKNOWN16,
        UNKNOWN17,
        UNKNOWN18,
        PROGRESS2,      // added 1.1, Vista percent done seems to duplicate PROGRESS
        UNKNOWN1A) ;

Chkdsk: procedure (
    DriveRoot: PWCHAR;
    Format: PWChar ;
    CorrectErrors: BOOL;
	Verbose: BOOL;
	CheckOnlyIfDirty: BOOL;
	ScanDrive: BOOL;
	Unused2: DWORD;
	Unused3: DWORD;
	Callback: Pointer); stdcall;
FormatEx: procedure (
    DriveRoot: PWCHAR;
	MediaFlag: DWORD;
	Format: PWCHAR;
	DiskLabel: PWCHAR;
	QuickFormat: BOOL;
	ClusterSize: DWORD;
	Callback: Pointer); stdcall;
EnableVolumeCompession: function (
    DriveRoot: PWCHAR;
	Enable: BOOL): BOOLEAN; stdcall;

implementation

function FormatCallback (Command: TCallBackCommand; SubAction: DWORD;
                                             ActionInfo: Pointer): Boolean; stdcall;
begin
end;

function ChkDskCallback (Command: TCallBackCommand; SubAction: DWORD;
                                             ActionInfo: Pointer): Boolean; stdcall;
begin
end;

(*

function TMagFmtChkDsk.FormatDisk (const DrvRoot: string; MediaType: TMediaType;
                               FileSystem: TFileSystem; const DiskLabel: string;
                                  QuickFormat: boolean; ClusterSize: integer): boolean ;
var
    wdrive, wformat, wfilesystem, wdisklabel: widestring ;
    mediaflags, newsize: DWORD ;

begin
    result := false ;
    if NOT LoadFmifs then exit ;
    wdrive := Uppercase (DrvRoot) ;
//    wdrive := 'T:\' ; // TESTING
    wdisklabel := Uppercase (DiskLabel) ;
    if MediaType = mtHardDisk then
        mediaflags := FMIFS_HARDDISK
    else if MediaType = mtFloppy then
        mediaflags := FMIFS_FLOPPY
    else
        exit ;
    if FileSystem = fsFAT then
        wfilesystem := 'FAT'
    else if FileSystem = fsFAT32 then
        wfilesystem := 'FAT32'
    else if FileSystem = fsNTFS then
        wfilesystem := 'NTFS'
    else
        exit ;
    newsize := 0 ;
    if ((ClusterSize = 512) or (ClusterSize = 1024) or (ClusterSize = 2048) or
        (ClusterSize = 4096) or (ClusterSize = 8192) or (ClusterSize = 16384) or
            (ClusterSize = 32768) or (ClusterSize = 65536)) then newsize := ClusterSize ;
    fDoneOK := false ;
    if DiskSize (Ord (WDrive [1]) - 64) > 100 then  // don't check drive unless it exists
    begin
        doInfoEvent (WDrive + ' Checking Existing Drive Format') ;
        if NOT CheckDriveExists (wdrive, true, wformat) then exit ;
        if wformat <> wfilesystem then QuickFormat := false ;
    end
    else
    begin
        if (Length (WDrive) < 2) or (WDrive [2] <> ':') then
        begin
            raise FmtChkException.Create('Invalid Drive Specification: ' + WDrive);
            exit ;
        end ;
        doInfoEvent (WDrive + ' Appears to be Unformatted or No Drive') ;
        QuickFormat := false ;
    end ;
    MagFmtObj := Self ;
    fFirstErrorLine := '' ;
    doInfoEvent (WDrive + ' Starting to Format Drive') ;

    ---------------------------------------------------------------------------------
    FormatEx (PWchar (wdrive), mediaflags, PWchar (wfilesystem), PWchar (wdisklabel),
                                                 QuickFormat, newsize, @FormatCallback) ;
    ---------------------------------------------------------------------------------
    result := fDoneOK  ;
    if NOT result then exit ;
    doInfoEvent (WDrive + ' Checking New Drive Format') ;
    if NOT CheckDriveExists (wdrive, false, wformat) then exit ;
    doInfoEvent (WDrive + ' New Volume Space: ' + IntToStr (DiskFree (Ord (WDrive [1]) - 64))) ;
end ;

function TMagFmtChkDsk.CheckDisk (const DrvRoot: string; CorrectErrors, Verbose,
                                          CheckOnlyIfDirty, ScanDrive: boolean): boolean ;
var
    wdrive, wformat: widestring ;
begin
    result := false ;
    if NOT LoadFmifs then exit ;
    wdrive := Uppercase (DrvRoot) ;
    if NOT CheckDriveExists (wdrive, CorrectErrors, wformat) then exit ;
    MagFmtObj := Self ;
    fDoneOK := false ;
    fFileSysProblem := false ;
    fFreeSpaceAlloc := false ;
    fFirstErrorLine := '' ;
    ---------------------------------------------------------------------------------
    Chkdsk (PWchar (wdrive), PWchar (wformat), CorrectErrors, Verbose,
                             CheckOnlyIfDirty, ScanDrive, 0, 0, @ChkDskCallback) ;
    ---------------------------------------------------------------------------------
    if fFileSysProblem then
        result := true  // ignore stopped if got an error
    else
        result := fDoneOK ;
end ;

function TMagFmtChkDsk.VolumeCompression (const DrvRoot: string; Enable: boolean): boolean ;
var
    wdrive, wformat: widestring ;
begin
    result := false ;
    if NOT LoadFmifs then exit ;
    wdrive := Uppercase (DrvRoot) ;
    if NOT CheckDriveExists (wdrive, true, wformat) then exit ;
    ---------------------------------------------------------------------------------
    result := EnableVolumeCompession (PWchar (wdrive), Enable) ;
    ---------------------------------------------------------------------------------
end ;

*)
end.
