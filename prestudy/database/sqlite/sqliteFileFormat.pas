unit sqliteFileFormat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TMetaChar = packed record
    SchemaVersion: Integer;
    FileFormatOfSchemaLayer: Integer;
    SizeOfPageCache: Integer;
    LargestRootPage: Integer;

    Charset: Integer;

    UserVersion: Integer;
    Data7: Integer;
    Data8: Integer;
    Data9: Integer;
    Data10: Integer;

    Data11: Integer;
    Data12: Integer;
    Data13: Integer;
    Data14: Integer;
    Data15: Integer;
  end;

  TSQLiteFileHead = packed record
    // SQLite Format 3
    Signature     : array[0..15] of AnsiChar; // 16
//    Signature     : array[0..14] of AnsiChar; // 16
    PageSize      : array[0..1] of Byte; // 2 16
//    PageSize      : Word; // 2 16
    WriteVersion  : Byte; // 1 18
    ReadVersion   : Byte; // 1 19
    ReserveSize   : Byte; // 1 20
    BTreeUseSize  : Byte; // 1 21 (255 = 100%) (64 = 25%)
    MinSizeSpaceUsed  : Byte; // 1 22
    MinSizePageUsed   : Byte; // 1 23
    ModifyCounter     : Integer; // 4 24 // 文件修改计数
    UnUsed1           : Integer; // 4 28
    FirstFreePagePointer: Integer; // 4 32
    FreePageCount: Integer; // 4 36
    MetaChar      : TMetaChar;
  end;

  PSQLitePageHead = ^TSQLitePageHead;
  TSQLitePageHead = packed record
    // 1 intkey
    // 2 zerodata
    // 4 leafdata
    // 8 leaf
    // $0D B+树叶子页
    // $05 B+树内部页
    // $0A B-树叶子页
    // $02 B-树内部页
    PageType: Byte;
    FirstFreeBlockOffset: Word; // 第一个自由块 偏移量
    UnitCountofPage: Word; // 本页单元数
//    StartOffset: Word; // 单元内容区 起始地址
    StartOffset: array[0..1] of Byte;
    FlagBytes: Byte; // 碎片字节数
    MostRightPageNo: LongWord; // 最右子节点 的页号
  end;

  TSQLitePage = packed record
    Data: array[0..1024 - SizeOf(TSQLitePageHead) - 1] of AnsiChar;
  end;

var
  head: TSQLiteFileHead;
  pagehead: TSQLitePageHead;
  page: TSQLitePage;

procedure TForm1.Button1Click(Sender: TObject);
type
  TBytes2 = record
    Byte1: Byte;
    Byte2: Byte;
  end;

var
  pfile: string;
  pfs: TFileStream;
  w: PWord;
  b2: TBytes2;
begin
  pfile := 'smart.db';
  if FileExists(pfile) then
  begin
    pfs := TFileStream.Create(pfile, fmOpenRead);
    try
      pfs.Position := 0;
      pfs.Read(head, sizeof(head));
      pfs.Read(page, SizeOf(page));
      pagehead := PSQLitePageHead(@page.Data[0])^;
      b2.Byte2 := pagehead.StartOffset[0];
      b2.Byte1 := pagehead.StartOffset[1];
      w := @b2;
      if head.PageSize[0] = 0 then
      begin

      end;

      pfs.Position := w^; // 934
      //  B+tree叶子页的单元格式
      pfs.Read(page, SizeOf(page));
    finally
      pfs.Free;
    end;
  end;
end;

end.
