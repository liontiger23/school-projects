unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls, Buttons, PngSpeedButton, ExtCtrls,
  ToolWin, QDialogs;

type
  TFMain = class(TForm)
    Tabs: TPageControl;
    FilterSheet: TTabSheet;
    DictSheet: TTabSheet;
    FilterRes: TListBox;
    Dictionary: TListBox;
    CoolBar1: TCoolBar;
    LetterPanel: TPanel;
    ComboBox7: TComboBox;
    ComboBox6: TComboBox;
    ComboBox5: TComboBox;
    ComboBox4: TComboBox;
    ComboBox3: TComboBox;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    WordPanel: TPanel;
    FilterFind: TButton;
    Postfix: TComboBox;
    FilterEdit: TEdit;
    Prefix: TComboBox;
    CoolBar2: TCoolBar;
    Panel3: TPanel;
    DictEdit: TEdit;
    DictAdd: TPngSpeedButton;
    DictDel: TPngSpeedButton;
    procedure FilterFindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DictEditChange(Sender: TObject);
    procedure DictionaryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DictionaryMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DictionaryClick(Sender: TObject);  
    procedure DictRefresh;
    procedure DictDelClick(Sender: TObject);
    procedure DictAddClick(Sender: TObject);
    procedure PostfixChange(Sender: TObject);
    procedure PrefixChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure FilterKeyPress(Sender: TObject; var Key: Char);
    procedure DictEditClick(Sender: TObject);
    procedure FilterResKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FilterResMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FilterDel;
    procedure ComboBoxChange(CB:tcombobox);
    procedure SyFixChange(XFix:tcombobox);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const
  LayoutText='Переключите язык на русский!';
  NumberText='Введите число от 0 до 15';
  LetterText='Введите букву русского алфавита';

var
  FMain: TFMain;
  FillStart, FillEnd:integer;  
  Dict:tstrings;

implementation

uses Unit2;

{$R *.dfm}

//Поиск слов по фильтру
procedure TFMain.FilterFindClick(Sender: TObject);
var //Переменные циклов
    i,j,
    //Переменная для функции pos
    p1,
    stars,//Количество звездочек
    tstars:integer;//Временная переменная
    charar,//Массив для остальных букв
    tcharar:array [1..7] of char;//Временный массив
    tagset:set of 1..7;//Множество цифр от 1 до 7
    addbool:boolean;//

//Проверка принадлежности элемента массиву
function intcharar(x:char):boolean;
var i,j:integer;//Переменные циклов
begin
     for i:=1 to 7 do
      //Если элемент в массиве, то возвращаем true
      //и выходим из функции
      if x=tcharar[i] then
      begin
        tcharar[i]:=' ';
        result:=true;
        exit;
      end;
     //Если нет, то возвращаем false
     result:=false;
end;
begin

     tagset:=[1,2,3,4,5,6,7];
     stars:=0;
     with LetterPanel do
     begin
        for i:=0 to ControlCount-1 do
        if Controls[i].Tag in tagset then
        begin
          if (controls[i] as tcombobox).Text='*' then
            inc(stars)
          else
            charar[Controls[i].Tag]:=(controls[i] as tcombobox).Text[1];
        end;
     end;
     //----------------------------------
     FilterRes.Clear;
     //Проход по словарю
     for i:=0 to dict.Count-1 do
     begin
        //Обновление временных переменных
        tcharar:=charar;
        tstars:=stars;
        //Проверка по данному слову
        p1:=pos(ansiuppercase(FilterEdit.Text),dict[i]);
        if p1>0 then
        begin
           //Проверка по кол-ву букв префикса и постфикса
           if (p1-1<=strtoint(Prefix.Text)) and
              (length(Dict[i])-length(FilterEdit.Text)-p1+1<=strtoint(Postfix.Text)) then
           begin
              //----------------------------------
              addbool:=true;
              //Проверка на соответствие букв префикса
              for j:=1 to p1-1 do
              if not(intcharar(dict[i][j])) then
                if tstars<>0 then
                  dec(tstars)
                else
                  addbool:=false;     
              //Проверка на соответствие букв постфикса
              for j:=p1+length(FilterEdit.Text) to length(dict[i]) do
              if not(intcharar(dict[i][j])) then
                if tstars<>0 then
                  dec(tstars)
                else
                  addbool:=false;
              //Вывод слова
              if addbool then
                FilterRes.Items.Add(dict[i]);
           end;
        end;
     end;
end;

procedure TFMain.FormCreate(Sender: TObject);
var i,j,l:integer; s:string; NotRus:boolean;
begin
     //Загрузка и сортировка словаря
     s:='';
     i:=0;
     Dict:=tstringlist.Create;
     dict.LoadFromFile('Dictionary.txt');
     (dict as tstringlist).Sort;
     form2:=TForm2.Create(self);
     form2.Caption:='Загрузка словаря...';
     form2.PB.Max:=dict.Count; 
     form2.PB.Min:=0;
     //form2.Hide;
     form2.Show;
     j:=0;
     while i<=dict.Count-1 do
     begin
        notrus:=false;
        dict[i]:=ansiuppercase(dict[i]);   
        for l:=1 to length(dict[i]) do
          if not(dict[i][l] in ['а'..'z','А'..'Я','ё','Ё']) then
            notrus:=true
          else
            if dict[i][l]='Ё' then
              dict[i]:=copy(dict[i],1,l-1)+'Е'+copy(dict[i],l+1,length(dict[i]));
        if (dict[i]=s) or (length(dict[i])>15) or (NotRus) then
        begin
          dict.Delete(i);
        end else
        begin
          s:=dict[i];
          inc(i);
        end;
        if j=10 then
        begin
          form2.PB.StepBy(10);
          j:=0;
        end;
        inc(j);
     end;
     dict.SaveToFile('Dictionary.txt');
     dictionary.Items.AddStrings(dict);
     Tabs.TabIndex:=0;    
     form2.Hide;
end;

procedure TFMain.DictEditChange(Sender: TObject);
var i,j,ind:integer;
begin
     if length(dictedit.Text)>0 then
      for j:=1 to length(dictedit.Text) do
      begin
        case dictedit.Text[j] of
        'а'..'я','А'..'Я':;
        'a'..'z','A'..'Z':
        begin
          dictedit.Text:=copy(dictedit.Text,1,j-1)+
          copy(dictedit.Text,j+1,length(dictedit.Text));
          messagebox(Handle,pansichar(LayoutText),'Внимание!',MB_OK);
          exit;
        end;
        else
        begin
          dictedit.Text:=copy(dictedit.Text,1,j-1)+
          copy(dictedit.Text,j+1,length(dictedit.Text));
          messagebox(Handle,pansichar(LetterText),'Внимание!',MB_OK);
          exit;
        end;
        end;
      end;
     //Поиск строки из фильтра словаря
     begin
        ind:=-1;
        for i:=0 to dict.Count-1 do
          if pos(ansiuppercase(DictEdit.Text),dict[i])=1 then
          begin
            ind:=i;
            break;
          end;
        dictionary.ItemIndex:=ind;
     end;
end;

procedure TFMain.DictionaryKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin   
     if dictionary.ItemIndex>=0 then
      DictEdit.Text:=dictionary.Items[dictionary.itemindex];
     if key=vk_return then
      dictdelclick(nil);
end;

procedure TFMain.DictionaryMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if dictionary.ItemIndex>=0 then
      DictEdit.Text:=dictionary.Items[dictionary.itemindex]; 
     if button=mbRight then
      dictdelclick(nil);
end;

procedure TFMain.DictionaryClick(Sender: TObject);
begin
     if dictionary.ItemIndex>=0 then
      DictEdit.Text:=dictionary.Items[dictionary.itemindex];
end;

procedure TFMain.DictRefresh;
begin
     (dict as tstringlist).Sort;
     dict.SaveToFile('Dictionary.txt');
     dictionary.Clear;
     dictionary.Items.AddStrings(dict);
     filterfindclick(nil);
end;

procedure TFMain.DictDelClick(Sender: TObject);
begin
     if (dictionary.ItemIndex>-1) and
     (messagebox(Handle,pansichar('Вы уверены, что хотите удалить слово '+
     dict[dictionary.itemindex]),'Удаление',MB_YESNO)=IDYES)
     then
     begin
        dict.Delete(dictionary.ItemIndex);
        dictrefresh;
     end;
end;

procedure TFMain.DictAddClick(Sender: TObject);
begin
     if dictionary.ItemIndex>-1 then
     begin
        if dictionary.Items[dictionary.ItemIndex]<>dictedit.Text then
        begin
          dict.Add(ansiuppercase(DictEdit.Text));
          dictrefresh;
        end;
     end else
     begin  
        dict.Add(ansiuppercase(DictEdit.Text));
        dictrefresh;
     end;
end;

procedure TFMain.PostfixChange(Sender: TObject);
begin
     SyFixChange(Postfix);
end;

procedure TFMain.PrefixChange(Sender: TObject);
begin
     SyFixChange(Prefix);
end;

procedure TFMain.ComboBox1Change(Sender: TObject);
begin
     ComboBoxChange(Combobox1);
end;

procedure TFMain.ComboBox2Change(Sender: TObject);
begin
     ComboBoxChange(Combobox2);
end;

procedure TFMain.ComboBox3Change(Sender: TObject);
begin
     ComboBoxChange(Combobox3);
end;

procedure TFMain.ComboBox4Change(Sender: TObject);
begin
     ComboBoxChange(Combobox4);
end;

procedure TFMain.ComboBox5Change(Sender: TObject);
begin
     ComboBoxChange(Combobox5);
end;

procedure TFMain.ComboBox6Change(Sender: TObject);
begin
     ComboBoxChange(Combobox6);
end;

procedure TFMain.ComboBox7Change(Sender: TObject);
begin
     ComboBoxChange(Combobox7);
end;

procedure TFMain.FilterKeyPress(Sender: TObject; var Key: Char);
var s:string;
begin
     if ord(key)=13 then
     begin
       Perform(WM_NEXTDLGCTL, 0, 0);
       key:=#0;
     end;
end;

procedure TFMain.DictEditClick(Sender: TObject);
begin
     dicteditchange(nil);
end;

procedure TFMain.FilterResKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s:string;
begin
     if key=vk_return then
      filterdel;
end;

procedure TFMain.FilterResMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var s:string;
begin
     if button=mbRight then
      filterdel;
end;

procedure TFMain.FilterDel;
var s:string;
begin
     if (filterres.ItemIndex>=0) and
     (messagebox(Handle,pansichar('Вы уверены, что хотите удалить слово '+
     dict[dictionary.itemindex]),'Удаление',MB_YESNO)=IDYES)
     then
     begin
        s:=dictedit.Text;
        dictedit.Text:=FilterRes.Items[filterres.itemindex];
        dict.Delete(dictionary.ItemIndex);
        dictedit.Text:=s;
        dictrefresh;
     end;
end;

procedure TFMain.ComboBoxChange(CB:tcombobox);
begin  
     case CB.Text[1] of
     'a'..'z','A'..'Z':
     begin
        CB.Text:=CB.Items[0];
        messagebox(Handle,pansichar(LayoutText),'Внимание!',MB_OK);
     end;
     'а'..'я','А'..'Я':;
     '*':;
     else
     begin
        CB.Text:=CB.Items[0];
        messagebox(Handle,pansichar(LetterText),'Внимание!',MB_OK);
     end;
     end;
end;

procedure TFMain.SyFixChange(XFix:tcombobox);
begin
     if not(Xfix.Text[1] in ['0'..'9']) then
     begin
        Xfix.Text:=Xfix.Items[0];
        messagebox(Handle,pansichar(NumberText),'Внимание!',MB_OK);
     end;
end;

end.


