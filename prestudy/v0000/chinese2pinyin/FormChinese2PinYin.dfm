object Form1: TForm1
  Left = 462
  Top = 254
  Caption = 'Form1'
  ClientHeight = 332
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 16
    Top = 55
    Width = 385
    Height = 238
    Lines.Strings = (
      'mmo1')
    TabOrder = 0
  end
  object edtText: TEdit
    Left = 16
    Top = 24
    Width = 249
    Height = 21
    TabOrder = 1
    Text = 'edtText'
  end
  object btn1: TButton
    Left = 288
    Top = 22
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 2
    OnClick = btn1Click
  end
end
