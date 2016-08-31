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
  HTMLParserAll3 in 'HTMLParserAll3.pas',
  define_htmldom in 'define_htmldom.pas',
  html_helperclass in 'html_helperclass.pas',
  html_utils in 'html_utils.pas',
  define_htmltag in 'define_htmltag.pas',
  html_helper_tag in 'html_helper_tag.pas',
  html_entity in 'html_entity.pas';

{$R *.res}

begin
  SimpleRunWinFormApp(TfrmHtmlParser);
end.
