object frmHtmlParser: TfrmHtmlParser
  Left = 562
  Top = 190
  Caption = 'frmHtmlParser'
  ClientHeight = 444
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRight: TPanel
    Left = 458
    Top = 0
    Width = 185
    Height = 444
    Align = alRight
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object vthtmldomnode: TVirtualStringTree
      Align = alClient
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.MainColumn = -1
      TabOrder = 0
      OnGetText = vthtmldomnodeGetText
      Columns = <>
    end
  end
  object spl1: TSplitter
    Left = 455
    Top = 0
    Height = 444
    Align = alRight
  end
  object pnlmain: TPanel
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    object mmo1: TMemo
      Align = alClient
      Ctl3D = False
      ParentCtl3D = False
      ScrollBars = ssBoth
    end
    object pnl1: TPanel
      Left = 0
      Top = 403
      Width = 455
      Height = 41
      Align = alBottom
      DesignSize = (
        455
        41)
      object btnParser: TButton
        Left = 358
        Top = 6
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Parser'
        OnClick = btnParserClick
      end
    end
  end
end
