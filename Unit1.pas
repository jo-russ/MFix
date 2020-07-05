unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Inifiles, StrUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    ComboBox1: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  checkTime: integer = 0;
  checkInterval: integer = 10;
const
  rate = 50;
  iniName = 'MFix.ini';

implementation

{$R *.dfm}
var ini: TIniFile;

procedure TForm1.FormShow(Sender: TObject);
var last: string;
  i: integer;
begin
  Application.Title := Form1.Caption;
  ini := TIniFIle.Create(ExtractFilePath(paramstr(0)) + '\' + iniName);
  ini.ReadSections(ComboBox1.Items);
  for i := 1 to ComboBox1.Items.Count do
  begin
    if (ComboBox1.Items.strings[i-1] = 'Settings') then
    begin
      ComboBox1.Items.Delete(i-1);
      break;
    end;
  end;
  last := ini.ReadString('Settings', 'Last', '');
  checkInterval := strtoint(ini.ReadString('Settings', 'Delay', '10'));
//  MessageDlg(last, mtError, mbOkCancel, 0);
  Edit1.text := ini.ReadString(last, 'Top', '0');
  Edit2.text := ini.ReadString(last, 'Left', '0');
  Edit3.text := ini.ReadString(last, 'Right', '0');
  Edit4.text := ini.ReadString(last, 'Bottom', '0');
  // make it check for window right after startup
  checkTime := checkInterval-1;
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(last);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  close();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var wndClass: string;
  h, fg: HWND;
  r: TRect;
begin
  inc(checkTime);
  label1.Caption := DupeString('|', trunc(45 * ( 1.0 - (checktime mod checkInterval) / (checkInterval-1) ) ));
  try
    if (ComboBox1.Text <> '') then
    begin
      wndClass := ini.ReadString(ComboBox1.Text, 'Class','');
      h := FindWindow(PChar(wndClass), nil);

      if (h = 0) then
      begin
        Label2.Caption := 'No window "' + wndClass + '"';
      end else
      begin
        getWindowRect(h,r);
        Label2.Caption := format('Window size: %d x %d ',[r.right - r.left, r.bottom - r.top]);
      end;
      if (checkTime mod checkInterval = 0) then
      begin
        Memo1.lines.clear();
        fg := GetForegroundWindow();
        if (fg = h) then
        begin
          r.top:=r.top + strtoint(Edit1.text);
          r.left:=r.left + strtoint(Edit2.text);
          r.right:=r.right - strtoint(Edit3.text);
          r.bottom:=r.bottom - strtoint(Edit4.text);
          clipcursor(@r);
          Memo1.lines.add('Window found! Clipping mouse.');
        end else
        begin
          Memo1.lines.add('Not foreground window. Unclipping mouse.');
          clipcursor(nil);
        end;
      end;
    end else
    begin
      Memo1.lines.clear();
      Memo1.lines.add('Ini section not found');
    end;
  except
    on E : Exception do
    begin
      Memo1.lines.clear();
      Memo1.lines.add('Error: ' + E.Message);
    end;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Memo1.lines.clear();
  Memo1.lines.add('Selecting ' + ComboBox1.Text);
  ini.WriteString('Settings', 'Last', ComboBox1.Text);

  Edit1.text := ini.ReadString(ComboBox1.Text, 'Top', '0');
  Edit2.text := ini.ReadString(ComboBox1.Text, 'Left', '0');
  Edit3.text := ini.ReadString(ComboBox1.Text, 'Right', '0');
  Edit4.text := ini.ReadString(ComboBox1.Text, 'Bottom', '0');

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if (ComboBox1.Text <> '') then
  begin
    ini.WriteString(ComboBox1.Text, 'Top', inttostr(strtoint(Edit1.text)));
  end;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  if (ComboBox1.Text <> '') then
  begin
    ini.WriteString(ComboBox1.Text, 'Left', inttostr(strtoint(Edit2.text)));
  end;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
  if (ComboBox1.Text <> '') then
  begin
    ini.WriteString(ComboBox1.Text, 'Right', inttostr(strtoint(Edit3.text)));
  end;
end;

procedure TForm1.Edit4Change(Sender: TObject);
begin
  if (ComboBox1.Text <> '') then
  begin
    ini.WriteString(ComboBox1.Text, 'Bottom', inttostr(strtoint(Edit4.text)));
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ini.free();
end;

end.
