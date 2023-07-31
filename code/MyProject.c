// define delay sec and counter display
int tensCnt = 0;
int onesCnt = 0;
int south = 1;
int firstSwitch = 1;
#define sec delay_ms(1000)
#define Ones porta
#define Tens portc
// define leds
#define ledR1 portd.b0
#define ledY1 portd.b1
#define ledG1 portd.b2
#define ledR2 portd.b3
#define ledY2 portd.b4
#define ledG2 portd.b5

// statue of switch control
int statue = 1;

// External interrupt service routine
void interrupt()
{
    if (INTCON.INTF)
    {
        // Clear the interrupt flag
        INTCON.INTF = 0;
        // Toggle the LED state
        statue = 1 - statue;
        firstSwitch = 1 ;
    }
}

void main()
{
    // Initialize necessary ports and variables
    // Configure RB0 (INT) pin as an input with internal pull-up resistor
    TRISB0_bit = 1;
    OPTION_REG.INTEDG = 0; // Set interrupt on falling edge (change this if you need rising edge)
    // Enable external interrupt
    INTCON.INTE = 1; // Enable the external interrupt
    INTCON.GIE = 1;  // Enable global interrupt
    // go to set the logic of tris
    // set the leds off at start .
    trisd = 0;
    portd = 0;
    // set MUX of 7-seg and initialize with 0 ;
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
            // Manual Mode
            // Implement the manual mode logic here using switch(SWITCH_STREET_SELECT) state
            if (south)
            {
                if (portb.b1 || firstSwitch)
                {
                    while (portb.b1);
                    firstSwitch = 0;
                    portd = 0b10001;
                    porte = 2;
                    for (onesCnt = 3; onesCnt >= 0; onesCnt--)
                    {
                        Ones = onesCnt;
                        sec;
                    }
                    porte = 0;
                    ledY2 = 0;
                    ledG2 = 1;
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
                    ledY1 = 1;
                    for (onesCnt = 3; onesCnt >= 0; onesCnt--)
                    {
                        Ones = onesCnt;
                        sec;
                    }
                    porte = 0;
                    ledY1 = 0;
                    ledG1 = 1;
                    south = 1 - south;
                }
            }
        }
        else
        {
            // Automatic Mode
            // set initial street for manual mode
            // Implement the automatic mode logic here with specified timings
            porte = 1;
            portd = 0b1;
            for (tensCnt = 2; tensCnt >= 0 && statue; tensCnt--)
            {
                Tens = tensCnt;
                if (tensCnt == 2)
                {
                    ledY2 = 1;
                    for (onesCnt = 3; onesCnt >= 0 && statue; onesCnt--)
                    {
                        Ones = onesCnt;
                        sec;
                    }
                    ledY2 = 0;
                    ledG2 = 1;
                }
                else
                {
                    for (onesCnt = 9; onesCnt >= 0 && statue; onesCnt--)
                    {
                        Ones = onesCnt;
                        sec;
                    }
                }
            }
            porte = 2;
            portd = 0b1000;
            for (tensCnt = 1; tensCnt >= 0 && statue; tensCnt--)
            {
                Tens = tensCnt;
                if (tensCnt == 1)
                {
                    ledY1 = 1;
                    for (onesCnt = 5; onesCnt >= 0 && statue; onesCnt--)
                    {
                        if (onesCnt == 2)
                        {
                            ledY1 = 0;
                            ledG1 = 1;
                        }
                        Ones = onesCnt;
                        sec;
                    }
                }
                else
                {
                    for (onesCnt = 9; onesCnt >= 0 && statue; onesCnt--)
                    {
                        Ones = onesCnt;
                        sec;
                    }
                }
            }
            portd = 0;
            portc = 255;
            porta = 255;
        }
    }
}