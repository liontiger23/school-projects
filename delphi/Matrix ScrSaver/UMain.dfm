object Form1: TForm1
  Left = 146
  Top = 96
  Width = 870
  Height = 500
  AlphaBlend = True
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 862
    Height = 469
    Align = alClient
    BorderStyle = bsNone
    Color = clBlack
    DefaultColWidth = 12
    DefaultRowHeight = 14
    FixedCols = 0
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = []
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
    OnKeyDown = StringGrid1KeyDown
    OnKeyUp = StringGrid1KeyUp
    OnMouseDown = StringGrid1MouseDown
    OnMouseMove = StringGrid1MouseMove
    OnMouseUp = StringGrid1MouseUp
  end
  object StringGrid2: TStringGrid
    Left = 96
    Top = 16
    Width = 641
    Height = 313
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 1
    Visible = False
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 24
    Top = 16
  end
end
