program htmlparsertest;

uses
  Forms,
  VirtualTrees in '..\..\..\devdcomps\virtualtree\VirtualTrees.pas',
  windef_msg in '..\..\v0001\windef\windef_msg.pas',
  BaseApp in '..\..\v0001\obj\app_base\BaseApp.pas',
  BasePath in '..\..\v0001\obj\app_base\BasePath.pas',
  BaseWinFormApp in '..\..\v0001\obj\win_app\BaseWinFormApp.pas',
  BaseWinApp in '..\..\v0001\obj\win_app\BaseWinApp.pas',
  BaseForm in '..\..\v0001\obj\win_uiform\BaseForm.pas' {frmBase},
  htmlparserform in 'htmlparserform.pas' {frmHtmlParser},
  WStrings in 'WStrings.pas',
  HTMLParserAll3 in 'HTMLParserAll3.pas';

{$R *.res}

begin
  SimpleRunWinFormApp(TfrmHtmlParser);
end.
