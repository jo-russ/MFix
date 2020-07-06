object Form1: TForm1
  Left = 0
  Top = 0
  Width = 194
  Height = 230
  Caption = 'MFix'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 2
    Top = 2
    Height = 20
    TabOrder = 1
    Width = 182
    onChange = ComboBox1Change
  end
  object CheckBox1: TCheckBox
    Left = 2
    Top = 42
    Height = 20
    Width = 182
    TabOrder = 0
    Caption = 'Enable'
    Checked = True
    State = cbChecked
    onClick = CheckBox1Click
  end
  object Label1: TLabel
    Left = 2
    Top = 22
    Height = 20
    Width = 182
  end
  object Label2: TLabel
    Left = 2
    Top = 37
    Height = 20
    Width = 182
  end
  object Label3: TLabel
    Left = 50
    Top = 92
    Height = 20
    Width = 120
    Caption = 'Additional clipping'
  end
  object Memo1: TMemo
    Left = 2
    Top = 150
    Height = 45
    Width = 182
    Font.Color = clRed
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object Button1: TButton
    Left = 130
    Top = 120
    Width = 50
    Height = 25
    Caption = 'Exit'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 80
    Top = 55
    Width = 30
    Height = 21
    TabOrder = 2
    Text = '0'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 2
    Top = 90
    Width = 30
    Height = 21
    TabOrder = 3
    Text = '0'
    OnChange = Edit2Change
  end
  object Edit3: TEdit
    Left = 152
    Top = 90
    Width = 30
    Height = 21
    TabOrder = 4
    Text = '0'
    OnChange = Edit3Change
  end
  object Edit4: TEdit
    Left = 80
    Top = 125
    Width = 30
    Height = 21
    TabOrder = 5
    Text = '0'
    OnChange = Edit4Change
  end
  object Timer1: TTimer
    Interval = 1000
    Enabled = True
    OnTimer = Timer1Timer
    Left = 8
    Top = 8
  end
end
