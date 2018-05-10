unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ColorBox,
  Grids, Buttons, StdCtrls;

type

  { TEditorForm }

  TEditorForm = class(TForm)
    BotButton: TButton;
    GoldButton: TButton;
    SpikeButton: TButton;
    EditName: TEdit;
    SaveButton: TButton;
    LabelName: TLabel;
    Tunelbutton: TButton;
    WallButton: TButton;
    DrawGrid1: TDrawGrid;
    StringGrid1: TStringGrid;

    procedure BotButtonClick(Sender: TObject);
    procedure GoldButtonClick(Sender: TObject);
    procedure SpikeButtonClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);


    //procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
    //  aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);

    procedure TunelbuttonClick(Sender: TObject);
    procedure WallButtonClick(Sender: TObject);


  private
    { private declarations }
  public
    { public declarations }
  end;

var
  EditorForm: TEditorForm;
   map:array[0..9,0..18] of integer;
   i,j,l:integer;
   ButtonReg:integer;
   t:TextFile;
implementation

{$R *.lfm}

{ TEditorForm }

procedure TEditorForm.FormCreate(Sender: TObject);
begin

 for i:=0 to 9 do begin
  for j:=0 to 18 do begin
   StringGrid1.Cells[j,i]:= inttostr(1);
  end;
 end;

end;










//procedure TEditorForm.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
//  aRect: TRect; aState: TGridDrawState);
//begin
// randomize;
//  for i:=0 to 9 do begin
//  for j:=0 to 18 do begin
//  // map[i,j]:=strtoin t(stringGrid1.Cells[aCol,aRow]);
//
//    if inttostr(2)>StringGrid1.Cells[j,i] then begin
//    stringGrid1.Canvas.Brush.Color:=clRed;
//    StringGrid1.Canvas.FillRect(aRect);
//    StringGrid1.Canvas.TextRect(aRect, aRect.Left + 2, aRect.Top + 2, StringGrid1.Cells[j,i]);
//    end;
//    end;
//    end;
//    end;

procedure TEditorForm.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
 LabelName.Caption:=inttostr(ButtonReg);
  StringGrid1.Cells[aCol,aRow]:=inttostr(ButtonReg);
end;










procedure TEditorForm.TunelbuttonClick(Sender: TObject);   // Кнопка тунеля
begin
    ButtonReg:=0;
end;

procedure TEditorForm.WallButtonClick(Sender: TObject); //Кнопка стены
begin
   ButtonReg:=1;
end;
 procedure TEditorForm.BotButtonClick(Sender: TObject); //Кнопка бота
begin
    ButtonReg:=3;
end;

procedure TEditorForm.GoldButtonClick(Sender: TObject);
begin
   ButtonReg:=6;
end;

procedure TEditorForm.SpikeButtonClick(Sender: TObject);
begin
 ButtonReg:=2;
end;


 procedure TEditorForm.SaveButtonClick(Sender: TObject);
begin
   AssignFile(t,'C:\Users\Fargus19\Desktop\Гальцов Илья 404 Курсовой Digger\'+EditName.Text+'.txt');
   Rewrite(t);
   For i:=0 to 9 do begin
       For j:=0 to 18 do begin
        map[i,j]:=strtoint(StringGrid1.Cells[j,i]);
      Write(t,map[i,j]);
       end;
       Writeln(t);
   end;
   CloseFile(t);
end;


end.

