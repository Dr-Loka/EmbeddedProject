#line 1 "D:/Project/code/MyProject.c"

int tensCnt = 0;
int onesCnt = 0;
int south = 1;
int firstSwitch = 1;
#line 18 "D:/Project/code/MyProject.c"
int statue = 1;


void interrupt()
{
 if (INTCON.INTF)
 {

 INTCON.INTF = 0;

 statue = 1 - statue;
 }
}

void main()
{


 TRISB0_bit = 1;
 OPTION_REG.INTEDG = 0;

 INTCON.INTE = 1;
 INTCON.GIE = 1;


 trisd = 0;
 portd = 0;

 trisc = 0;
 portc = 255;
 trisa = 0;
 porta = 255;
 trise = 0;
 porte = 0;
 trisb.b1 = 1;
 while (1)
 {
 if (statue == 0)
 {


 if (south)
 {
 if (portb.b1 || firstSwitch)
 {
 while (portb.b1)
 ;
 firstSwitch = 0;
 portd = 0b10001;
 porte = 2;
 for (onesCnt = 3; onesCnt >= 0; onesCnt--)
 {
  porta  = onesCnt;
  delay_ms(1000) ;
 }
 porte = 0;
  portd.b4  = 0;
  portd.b5  = 1;
 south = 1 - south;
 }
 }
 else
 {
 if (portb.b1)
 {
 while (portb.b1)
 ;
 portd = 0b1010;
 porte = 1;
  portd.b1  = 1;
 for (onesCnt = 3; onesCnt >= 0; onesCnt--)
 {
  porta  = onesCnt;
  delay_ms(1000) ;
 }
 porte = 0;
  portd.b1  = 0;
  portd.b2  = 1;
 south = 1 - south;
 }
 }
 }
 else
 {


 firstSwitch = 1;

 porte = 1;
 portd = 0b1;
 for (tensCnt = 2; tensCnt >= 0 && statue; tensCnt--)
 {
  portc  = tensCnt;
 if (tensCnt == 2)
 {
  portd.b4  = 1;
 for (onesCnt = 3; onesCnt >= 0 && statue; onesCnt--)
 {
  porta  = onesCnt;
  delay_ms(1000) ;
 }
  portd.b4  = 0;
  portd.b5  = 1;
 }
 else
 {
 for (onesCnt = 9; onesCnt >= 0 && statue; onesCnt--)
 {
  porta  = onesCnt;
  delay_ms(1000) ;
 }
 }
 }
 porte = 2;
 portd = 0b1000;
 for (tensCnt = 1; tensCnt >= 0 && statue; tensCnt--)
 {
  portc  = tensCnt;
 if (tensCnt == 1)
 {
  portd.b1  = 1;
 for (onesCnt = 5; onesCnt >= 0 && statue; onesCnt--)
 {
 if (onesCnt == 2)
 {
  portd.b1  = 0;
  portd.b2  = 1;
 }
  porta  = onesCnt;
  delay_ms(1000) ;
 }
 }
 else
 {
 for (onesCnt = 9; onesCnt >= 0 && statue; onesCnt--)
 {
  porta  = onesCnt;
  delay_ms(1000) ;
 }
 }
 }
 portd = 0;
 portc = 255;
 porta = 255;
 }
 }
}
