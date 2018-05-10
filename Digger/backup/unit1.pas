unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLType, ExtCtrls, ExtDlgs;
//LCLType Позволяет Использовать vK_LEFT и прочие клавиши все для удобства

type

  { TForm1 }

  TForm1 = class(TForm)
    GameButton: TButton;
    Button4: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Text1: TLabel;
    ScoreLabel: TLabel;
    Timer: TTimer;
    procedure GameButtonClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

    type
      THero=record
      x,y:integer;
      lives:integer;
      end;

    type
      TEnemy=record
      x,y:integer;
      end;

    //10
    //19
    const  speed_hero=2;
    const speed_hero_step=1;
    const BotSpeed=1;

var
   Form1: TForm1;
  // mas:array[1..mas_ground1,1..mas_ground2] of Tbitmap;
   x_ground,y_ground,x1,x2:integer;
   MoveBotCheck:integer;//переменная используется для движения бота по горизонтали и вертикали значения 1 и 2
   ThisKey:Word;
   Anim_Heroes:string;
   Hero:THero;
   Enemy:TEnemy;
   f:TextFile;
   map:array[1..10,1..19] of char; //массив карты
   mapx:integer;
   mapy:integer;
  Bitmap:Tbitmap;

  ScoreInt:integer;
implementation

{$R *.lfm}
// 1216 x 640 размер поля
//   x  -  y
{ TForm1 }

procedure Gold;
begin
   if  map[Hero.y div 64,Hero.x div 64]='6' then begin
       ScoreInt:=ScoreInt+100;
       Form1.ScoreLabel.Caption:=inttostr(ScoreInt);
   end;
end;

procedure AnimHero;  //процедура анимации героя и его движения

            begin
                 If ThisKey=VK_LEFT  then begin  //ДВИЖЕНИЕ ВЛЕВО

                     Anim_Heroes:='Images\5.bmp';
                     Hero.x:=Hero.x-64;
                     Gold;

                     map[Hero.x div 64,Hero.y div 64]:='3';
                          Bitmap:=Graphics.TBitmap.Create;
                       Bitmap.LoadFromFile('Images\4.bmp');
                       Form1.Image1.Canvas.Draw((Hero.x+64),Hero.y,Bitmap);
                       Bitmap.Free;

                     map[(Hero.x div 64)-1,Hero.y div 64]:='0';
                     end;

                 If ThisKey=VK_RIGHT then begin    //ДВИЖЕНИЕ ВПРАВО
                     Anim_Heroes:='Images\6.bmp';
                     Hero.x:=Hero.x+64;
                     Gold;
                     map[Hero.x div 64,Hero.y div 64]:='3';
                         Bitmap:=Graphics.TBitmap.Create;
                       Bitmap.LoadFromFile('Images\4.bmp');
                       Form1.Image1.Canvas.Draw((Hero.x-64),Hero.y,Bitmap);
                       Bitmap.Free;

                     map[Hero.x div 64,Hero.y div 64]:='0';
                     end;

                 If ThisKey=VK_UP    then begin      //ДВИЖЕНИЕ ВВЕРХ
                     Anim_Heroes:='Images\7.bmp';
                     Hero.y:=Hero.y-64;
                     Gold;
                     map[Hero.x div 64,Hero.y div 64]:='3';

                       Bitmap:=Graphics.TBitmap.Create;
                       Bitmap.LoadFromFile('Images\4.bmp');
                       Form1.Image1.Canvas.Draw(Hero.x,(Hero.y+64),Bitmap);
                       Bitmap.Free;

                     map[Hero.x div 64,Hero.y div 64]:='0';
                     end;

                 If ThisKey=VK_DOWN  then begin  //ДВИЖЕНИЕ ВНИЗ
                     Anim_Heroes:='Images\8.bmp';
                     Hero.y:=Hero.y+64;
                     Gold;
                     map[Hero.x div 64,Hero.y div 64]:='3';
                       Bitmap:=Graphics.TBitmap.Create;
                       Bitmap.LoadFromFile('Images\4.bmp');
                       Form1.Image1.Canvas.Draw(Hero.x,(Hero.y-64),Bitmap);
                       Bitmap.Free;
                     map[Hero.x div 64,Hero.y div 64]:='0';
                     end;
            end;


  procedure EvilBot; //процедура движения бота
            begin
                 if (Hero.x=Enemy.x) or (Hero.x+64=Enemy.x)then begin
                   Hero.x:=16;
                   Hero.y:=16;
                 end;



            end;

  procedure Wall;   // стена
            begin
                 If Hero.x>=1216-64 then Hero.x:=1216-64;
                 If Hero.x<=0 then Hero.x:=0;
                 If Hero.y>=576 then Hero.y:=576;
                 If Hero.y<=0 then Hero.y:=0;
            end;




procedure TForm1.GameButtonClick(Sender: TObject); //Кнопка игра
          var Bitmap:Tbitmap;
          begin

              Anim_Heroes:='Images\6.bmp';

               GameButton.Visible:=False;

               Button4.Visible:=False;

               AssignFile(f,'level.txt');   //чтение из фаила уровня
               reset(f);
               while not eoln(f) do begin
                   for x1:=0 to 11 do begin
                        for x2:=0 to 20 do begin
                            read(f,map[x1,x2]);   //запись в массив
                           // showmessage(map[x1,x2]);
                        end;
                   end;

               end;
                  closeFile(f);   //конец чтения


          //     for x1:=1 to 10 do begin
          //         if x1=1 then y_ground:=0
          //            else y_ground:=y_ground+64;
          //            x_ground:=0;
          //
          //                        for x2:=1 to 19 do begin
          //                            Bitmap:=Graphics.TBitmap.Create;
          //                            Bitmap.LoadFromFile('Images\1.bmp');
          //                            Image1.Canvas.Draw(x_ground,y_ground,Bitmap);
          //                            Bitmap.Free;
          //                            x_ground:=x_ground+64
          //                        end;
          //
          //     end;
          //     Timer.Enabled:=True;
          //end;

          mapy:=0;
          mapx:=0;
          for x1:=0 to 11 do begin

              if x1=0 then mapy:=0
                 else  mapy:=mapy+64;
                  mapx:=0;

              for x2:=0 to 20 do begin
                   if map[x1,x2]='6' then begin  //ПРОРИСОВКА ЗОЛОТА
                      Bitmap:=Graphics.TBitmap.Create;
                      Bitmap.LoadFromFile('Images\9.bmp');
                      Image1.Canvas.Draw(mapx,mapy,Bitmap);
                      Bitmap.Free;
                       end;
                    if map[x1,x2]='2' then begin   //ПРОРИСОВКА ШИПОВ
                      Bitmap:=Graphics.TBitmap.Create;
                      Bitmap.LoadFromFile('Images\12.bmp');
                      Image1.Canvas.Draw(mapx,mapy,Bitmap);
                      Bitmap.Free;
                      end;
                  if map[x1,x2]='1' then begin  //ПРОРИСОВКА ЗЕМЛИ
                      Bitmap:=Graphics.TBitmap.Create;
                      Bitmap.LoadFromFile('Images\1.bmp');
                      Image1.Canvas.Draw(mapx,mapy,Bitmap);
                      Bitmap.Free;
                  end;
                  if map[x1,x2]='3' then begin  //ПРОРИСОВКА ПЕРСОНАЖА
                      Bitmap:=Graphics.TBitmap.Create;
                      Bitmap.LoadFromFile('Images\6.bmp');
                      Image1.Canvas.Draw(mapx,mapy,Bitmap);
                      Hero.x:=mapx;
                      Hero.y:=mapy;
                      Bitmap.Free;
                  end;
                mapx:=mapx+64;
              end;

          end;
     Timer.Enabled:=True;
  end;

procedure TForm1.Button4Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);  //создание формы
begin
     //Hero.x:=16;
     //Hero.y:=16;
     Hero.lives:=3;

     Enemy.x:=256;
     Enemy.y:=256;

     MoveBotCheck:=1; //значение 1 значит бот будет двигаться по горизонтали
     y_ground:=0; //теставая переменная массива битмепа
     x_ground:=0; //теставая переменная массива битмепа
end;



procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
ThisKey:=Key;

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;


procedure TForm1.TimerTimer(Sender: TObject);
var Bitmap:TBitMap;
  GoldIntMax:integer;
begin
            GoldIntMax:=0;
     for x1:=0 to 11 do begin
         for x2:=0 to 20 do begin
             if  map[x1,x2]='6' then GoldIntMax:=GoldIntMax+1;
         end;
     end;




  Label1.Caption:=inttostr(Hero.x);
  Label2.Caption:=inttostr(Hero.y);


//Bitmap:=Graphics.TBitmap.Create;
//Bitmap.LoadFromFile(Anim_Heroes);
//Image1.Canvas.Draw(x,y,Bitmap);
//      Bitmap.Free;



AnimHero; // Анимация героя

Bitmap:=Graphics.TBitmap.Create;
Bitmap.LoadFromFile(Anim_Heroes);
Image1.Canvas.Draw(Hero.x,Hero.y,Bitmap);
      Bitmap.Free;

      //Bitmap:=Graphics.TBitmap.Create;
      //Bitmap.LoadFromFile('Images\4.bmp');
      //Image1.Canvas.Draw(Hero.x,Hero.y,Bitmap);
      //      Bitmap.Free;

      Bitmap:=Graphics.TBitmap.Create;
      Bitmap.LoadFromFile('Images\3.bmp');  //прорисовка бота
      Image1.Canvas.Draw(Enemy.x,Enemy.y,Bitmap);
       Bitmap.Free;
      //Evilbot;//анимация бота


Wall; // Игровая стена
     If GoldIntMax=0 then showmessage('END');
end;
end.

