unit dll_cabinet;

interface

implementation

(*
const  
  SHCONTCH_NOPROGRESSBOX = 4;  
  SHCONTCH_AUTORENAME = 8;  
  SHCONTCH_RESPONDYESTOALL = 16;  
  SHCONTF_INCLUDEHIDDEN = 128;  
  SHCONTF_FOLDERS = 32;  
  SHCONTF_NONFOLDERS = 64;  
  
function ShellUnzip(zipfile, targetfolder: string; filter: string = ''): boolean;  
var  
  shellobj: variant;  
  srcfldr, destfldr: variant;  
  shellfldritems: variant;  
begin  
  shellobj := CreateOleObject('Shell.Application');  
  
  srcfldr := shellobj.NameSpace(zipfile);  
  destfldr := shellobj.NameSpace(targetfolder);  
  
  shellfldritems := srcfldr.Items;  
  if (filter <> '') then  
    shellfldritems.Filter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS,filter);  
  
  destfldr.CopyHere(shellfldritems, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);  
end;  

function ShellZip(zipfile, sourcefolder:string; filter: string = ''): boolean;  
const  
  emptyzip: array[0..23] of byte  = (80,75,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);  
var  
  ms: TMemoryStream;  
  shellobj: variant;  
  srcfldr, destfldr: variant;  
  shellfldritems: variant;  
  numt: integer;  
begin  
  if not FileExists(zipfile) then  
  begin  
    // create a new empty ZIP file  
    ms := TMemoryStream.Create;  
    ms.WriteBuffer(emptyzip, sizeof(emptyzip));  
    ms.SaveToFile(zipfile);  
    ms.Free;  
  end;  
  
  numt := NumProcessThreads;  
  
  shellobj := CreateOleObject('Shell.Application');  
  
  srcfldr := shellobj.NameSpace(sourcefolder);  
  destfldr := shellobj.NameSpace(zipfile);  
  
  shellfldritems := srcfldr.Items;  
  
  if (filter <> '') then  
    shellfldritems.Filter(SHCONTF_INCLUDEHIDDEN or SHCONTF_NONFOLDERS or SHCONTF_FOLDERS,filter);  
  
  destfldr.CopyHere(shellfldritems, 0);  
  
  // wait till all shell threads are terminated  
  while NumProcessThreads <> numt do  
  begin  
    sleep(100);  
  end;  
end;  

{ Add files }
Shell := CreateOleObject('Shell.Application');
Zip := Shell.Namespace('C:\Test.zip');
Zip.CopyHere('C:\Unit1.pas');
repeat
Application.ProcessMessages;
until Zip.Items.Count = 1;
Zip := Unassigned;
Shell := Unassigned;
*)

(*
FCI包括5个API。 
FCICreate   创建   FCI   context 
FCIAddFile   向   cabinet   中添加文件 
FCIFlushCabinet   结束当前的   cabinet 
FCIFlushFolder   结束当前的folder   并建立新的   folder 
FCIDestroy   销毁   FCI   context 

FDI包括4个API。 
FDICreate   创建   FDI   context 
FDIIsCabinet   判断是否为CAB压缩文件，是则返回其属性 
FDICopy   解压 
FDIDestroy   销毁   FDI   context 
*)
end.