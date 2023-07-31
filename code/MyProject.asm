
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,21 :: 		void interrupt()
;MyProject.c,23 :: 		if (INTCON.INTF)
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;MyProject.c,26 :: 		INTCON.INTF = 0;
	BCF        INTCON+0, 1
;MyProject.c,28 :: 		statue = 1 - statue;
	MOVF       _statue+0, 0
	SUBLW      1
	MOVWF      _statue+0
	MOVF       _statue+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       _statue+1
	SUBWF      _statue+1, 1
;MyProject.c,29 :: 		}
L_interrupt0:
;MyProject.c,30 :: 		}
L_end_interrupt:
L__interrupt70:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MyProject.c,32 :: 		void main()
;MyProject.c,36 :: 		TRISB0_bit = 1;
	BSF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
;MyProject.c,37 :: 		OPTION_REG.INTEDG = 0; // Set interrupt on falling edge (change this if you need rising edge)
	BCF        OPTION_REG+0, 6
;MyProject.c,39 :: 		INTCON.INTE = 1; // Enable the external interrupt
	BSF        INTCON+0, 4
;MyProject.c,40 :: 		INTCON.GIE = 1;  // Enable global interrupt
	BSF        INTCON+0, 7
;MyProject.c,43 :: 		trisd = 0;
	CLRF       TRISD+0
;MyProject.c,44 :: 		portd = 0;
	CLRF       PORTD+0
;MyProject.c,46 :: 		trisc = 0;
	CLRF       TRISC+0
;MyProject.c,47 :: 		portc = 255;
	MOVLW      255
	MOVWF      PORTC+0
;MyProject.c,48 :: 		trisa = 0;
	CLRF       TRISA+0
;MyProject.c,49 :: 		porta = 255;
	MOVLW      255
	MOVWF      PORTA+0
;MyProject.c,50 :: 		trise = 0;
	CLRF       TRISE+0
;MyProject.c,51 :: 		porte = 0;
	CLRF       PORTE+0
;MyProject.c,52 :: 		trisb.b1 = 1;
	BSF        TRISB+0, 1
;MyProject.c,53 :: 		while (1)
L_main1:
;MyProject.c,55 :: 		if (statue == 0)
	MOVLW      0
	XORWF      _statue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVLW      0
	XORWF      _statue+0, 0
L__main72:
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;MyProject.c,59 :: 		if (south)
	MOVF       _south+0, 0
	IORWF      _south+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;MyProject.c,61 :: 		if (portb.b1 || firstSwitch)
	BTFSC      PORTB+0, 1
	GOTO       L__main68
	MOVF       _firstSwitch+0, 0
	IORWF      _firstSwitch+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	GOTO       L_main7
L__main68:
;MyProject.c,63 :: 		while (portb.b1)
L_main8:
	BTFSS      PORTB+0, 1
	GOTO       L_main9
;MyProject.c,64 :: 		;
	GOTO       L_main8
L_main9:
;MyProject.c,65 :: 		firstSwitch = 0;
	CLRF       _firstSwitch+0
	CLRF       _firstSwitch+1
;MyProject.c,66 :: 		portd = 0b10001;
	MOVLW      17
	MOVWF      PORTD+0
;MyProject.c,67 :: 		porte = 2;
	MOVLW      2
	MOVWF      PORTE+0
;MyProject.c,68 :: 		for (onesCnt = 3; onesCnt >= 0; onesCnt--)
	MOVLW      3
	MOVWF      _onesCnt+0
	MOVLW      0
	MOVWF      _onesCnt+1
L_main10:
	MOVLW      128
	XORWF      _onesCnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main73
	MOVLW      0
	SUBWF      _onesCnt+0, 0
L__main73:
	BTFSS      STATUS+0, 0
	GOTO       L_main11
;MyProject.c,70 :: 		Ones = onesCnt;
	MOVF       _onesCnt+0, 0
	MOVWF      PORTA+0
;MyProject.c,71 :: 		sec;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
;MyProject.c,68 :: 		for (onesCnt = 3; onesCnt >= 0; onesCnt--)
	MOVLW      1
	SUBWF      _onesCnt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _onesCnt+1, 1
;MyProject.c,72 :: 		}
	GOTO       L_main10
L_main11:
;MyProject.c,73 :: 		porte = 0;
	CLRF       PORTE+0
;MyProject.c,74 :: 		ledY2 = 0;
	BCF        PORTD+0, 4
;MyProject.c,75 :: 		ledG2 = 1;
	BSF        PORTD+0, 5
;MyProject.c,76 :: 		south = 1 - south;
	MOVF       _south+0, 0
	SUBLW      1
	MOVWF      _south+0
	MOVF       _south+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       _south+1
	SUBWF      _south+1, 1
;MyProject.c,77 :: 		}
L_main7:
;MyProject.c,78 :: 		}
	GOTO       L_main14
L_main4:
;MyProject.c,81 :: 		if (portb.b1)
	BTFSS      PORTB+0, 1
	GOTO       L_main15
;MyProject.c,83 :: 		while (portb.b1)
L_main16:
	BTFSS      PORTB+0, 1
	GOTO       L_main17
;MyProject.c,84 :: 		;
	GOTO       L_main16
L_main17:
;MyProject.c,85 :: 		portd = 0b1010;
	MOVLW      10
	MOVWF      PORTD+0
;MyProject.c,86 :: 		porte = 1;
	MOVLW      1
	MOVWF      PORTE+0
;MyProject.c,87 :: 		ledY1 = 1;
	BSF        PORTD+0, 1
;MyProject.c,88 :: 		for (onesCnt = 3; onesCnt >= 0; onesCnt--)
	MOVLW      3
	MOVWF      _onesCnt+0
	MOVLW      0
	MOVWF      _onesCnt+1
L_main18:
	MOVLW      128
	XORWF      _onesCnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVLW      0
	SUBWF      _onesCnt+0, 0
L__main74:
	BTFSS      STATUS+0, 0
	GOTO       L_main19
;MyProject.c,90 :: 		Ones = onesCnt;
	MOVF       _onesCnt+0, 0
	MOVWF      PORTA+0
;MyProject.c,91 :: 		sec;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	DECFSZ     R11+0, 1
	GOTO       L_main21
	NOP
	NOP
;MyProject.c,88 :: 		for (onesCnt = 3; onesCnt >= 0; onesCnt--)
	MOVLW      1
	SUBWF      _onesCnt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _onesCnt+1, 1
;MyProject.c,92 :: 		}
	GOTO       L_main18
L_main19:
;MyProject.c,93 :: 		porte = 0;
	CLRF       PORTE+0
;MyProject.c,94 :: 		ledY1 = 0;
	BCF        PORTD+0, 1
;MyProject.c,95 :: 		ledG1 = 1;
	BSF        PORTD+0, 2
;MyProject.c,96 :: 		south = 1 - south;
	MOVF       _south+0, 0
	SUBLW      1
	MOVWF      _south+0
	MOVF       _south+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       _south+1
	SUBWF      _south+1, 1
;MyProject.c,97 :: 		}
L_main15:
;MyProject.c,98 :: 		}
L_main14:
;MyProject.c,99 :: 		}
	GOTO       L_main22
L_main3:
;MyProject.c,104 :: 		firstSwitch = 1;
	MOVLW      1
	MOVWF      _firstSwitch+0
	MOVLW      0
	MOVWF      _firstSwitch+1
;MyProject.c,106 :: 		porte = 1;
	MOVLW      1
	MOVWF      PORTE+0
;MyProject.c,107 :: 		portd = 0b1;
	MOVLW      1
	MOVWF      PORTD+0
;MyProject.c,108 :: 		for (tensCnt = 2; tensCnt >= 0 && statue; tensCnt--)
	MOVLW      2
	MOVWF      _tensCnt+0
	MOVLW      0
	MOVWF      _tensCnt+1
L_main23:
	MOVLW      128
	XORWF      _tensCnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVLW      0
	SUBWF      _tensCnt+0, 0
L__main75:
	BTFSS      STATUS+0, 0
	GOTO       L_main24
	MOVF       _statue+0, 0
	IORWF      _statue+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
L__main67:
;MyProject.c,110 :: 		Tens = tensCnt;
	MOVF       _tensCnt+0, 0
	MOVWF      PORTC+0
;MyProject.c,111 :: 		if (tensCnt == 2)
	MOVLW      0
	XORWF      _tensCnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main76
	MOVLW      2
	XORWF      _tensCnt+0, 0
L__main76:
	BTFSS      STATUS+0, 2
	GOTO       L_main28
;MyProject.c,113 :: 		ledY2 = 1;
	BSF        PORTD+0, 4
;MyProject.c,114 :: 		for (onesCnt = 3; onesCnt >= 0 && statue; onesCnt--)
	MOVLW      3
	MOVWF      _onesCnt+0
	MOVLW      0
	MOVWF      _onesCnt+1
L_main29:
	MOVLW      128
	XORWF      _onesCnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main77
	MOVLW      0
	SUBWF      _onesCnt+0, 0
L__main77:
	BTFSS      STATUS+0, 0
	GOTO       L_main30
	MOVF       _statue+0, 0
	IORWF      _statue+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main30
L__main66:
;MyProject.c,116 :: 		Ones = onesCnt;
	MOVF       _onesCnt+0, 0
	MOVWF      PORTA+0
;MyProject.c,117 :: 		sec;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	DECFSZ     R11+0, 1
	GOTO       L_main34
	NOP
	NOP
;MyProject.c,114 :: 		for (onesCnt = 3; onesCnt >= 0 && statue; onesCnt--)
	MOVLW      1
	SUBWF      _onesCnt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _onesCnt+1, 1
;MyProject.c,118 :: 		}
	GOTO       L_main29
L_main30:
;MyProject.c,119 :: 		ledY2 = 0;
	BCF        PORTD+0, 4
;MyProject.c,120 :: 		ledG2 = 1;
	BSF        PORTD+0, 5
;MyProject.c,121 :: 		}
	GOTO       L_main35
L_main28:
;MyProject.c,124 :: 		for (onesCnt = 9; onesCnt >= 0 && statue; onesCnt--)
	MOVLW      9
	MOVWF      _onesCnt+0
	MOVLW      0
	MOVWF      _onesCnt+1
L_main36:
	MOVLW      128
	XORWF      _onesCnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main78
	MOVLW      0
	SUBWF      _onesCnt+0, 0
L__main78:
	BTFSS      STATUS+0, 0
	GOTO       L_main37
	MOVF       _statue+0, 0
	IORWF      _statue+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main37
L__main65:
;MyProject.c,126 :: 		Ones = onesCnt;
	MOVF       _onesCnt+0, 0
	MOVWF      PORTA+0
;MyProject.c,127 :: 		sec;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
	NOP
;MyProject.c,124 :: 		for (onesCnt = 9; onesCnt >= 0 && statue; onesCnt--)
	MOVLW      1
	SUBWF      _onesCnt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _onesCnt+1, 1
;MyProject.c,128 :: 		}
	GOTO       L_main36
L_main37:
;MyProject.c,129 :: 		}
L_main35:
;MyProject.c,108 :: 		for (tensCnt = 2; tensCnt >= 0 && statue; tensCnt--)
	MOVLW      1
	SUBWF      _tensCnt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _tensCnt+1, 1
;MyProject.c,130 :: 		}
	GOTO       L_main23
L_main24:
;MyProject.c,131 :: 		porte = 2;
	MOVLW      2
	MOVWF      PORTE+0
;MyProject.c,132 :: 		portd = 0b1000;
	MOVLW      8
	MOVWF      PORTD+0
;MyProject.c,133 :: 		for (tensCnt = 1; tensCnt >= 0 && statue; tensCnt--)
	MOVLW      1
	MOVWF      _tensCnt+0
	MOVLW      0
	MOVWF      _tensCnt+1
L_main42:
	MOVLW      128
	XORWF      _tensCnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main79
	MOVLW      0
	SUBWF      _tensCnt+0, 0
L__main79:
	BTFSS      STATUS+0, 0
	GOTO       L_main43
	MOVF       _statue+0, 0
	IORWF      _statue+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main43
L__main64:
;MyProject.c,135 :: 		Tens = tensCnt;
	MOVF       _tensCnt+0, 0
	MOVWF      PORTC+0
;MyProject.c,136 :: 		if (tensCnt == 1)
	MOVLW      0
	XORWF      _tensCnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main80
	MOVLW      1
	XORWF      _tensCnt+0, 0
L__main80:
	BTFSS      STATUS+0, 2
	GOTO       L_main47
;MyProject.c,138 :: 		ledY1 = 1;
	BSF        PORTD+0, 1
;MyProject.c,139 :: 		for (onesCnt = 5; onesCnt >= 0 && statue; onesCnt--)
	MOVLW      5
	MOVWF      _onesCnt+0
	MOVLW      0
	MOVWF      _onesCnt+1
L_main48:
	MOVLW      128
	XORWF      _onesCnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main81
	MOVLW      0
	SUBWF      _onesCnt+0, 0
L__main81:
	BTFSS      STATUS+0, 0
	GOTO       L_main49
	MOVF       _statue+0, 0
	IORWF      _statue+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main49
L__main63:
;MyProject.c,141 :: 		if (onesCnt == 2)
	MOVLW      0
	XORWF      _onesCnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main82
	MOVLW      2
	XORWF      _onesCnt+0, 0
L__main82:
	BTFSS      STATUS+0, 2
	GOTO       L_main53
;MyProject.c,143 :: 		ledY1 = 0;
	BCF        PORTD+0, 1
;MyProject.c,144 :: 		ledG1 = 1;
	BSF        PORTD+0, 2
;MyProject.c,145 :: 		}
L_main53:
;MyProject.c,146 :: 		Ones = onesCnt;
	MOVF       _onesCnt+0, 0
	MOVWF      PORTA+0
;MyProject.c,147 :: 		sec;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main54:
	DECFSZ     R13+0, 1
	GOTO       L_main54
	DECFSZ     R12+0, 1
	GOTO       L_main54
	DECFSZ     R11+0, 1
	GOTO       L_main54
	NOP
	NOP
;MyProject.c,139 :: 		for (onesCnt = 5; onesCnt >= 0 && statue; onesCnt--)
	MOVLW      1
	SUBWF      _onesCnt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _onesCnt+1, 1
;MyProject.c,148 :: 		}
	GOTO       L_main48
L_main49:
;MyProject.c,149 :: 		}
	GOTO       L_main55
L_main47:
;MyProject.c,152 :: 		for (onesCnt = 9; onesCnt >= 0 && statue; onesCnt--)
	MOVLW      9
	MOVWF      _onesCnt+0
	MOVLW      0
	MOVWF      _onesCnt+1
L_main56:
	MOVLW      128
	XORWF      _onesCnt+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main83
	MOVLW      0
	SUBWF      _onesCnt+0, 0
L__main83:
	BTFSS      STATUS+0, 0
	GOTO       L_main57
	MOVF       _statue+0, 0
	IORWF      _statue+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main57
L__main62:
;MyProject.c,154 :: 		Ones = onesCnt;
	MOVF       _onesCnt+0, 0
	MOVWF      PORTA+0
;MyProject.c,155 :: 		sec;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main61:
	DECFSZ     R13+0, 1
	GOTO       L_main61
	DECFSZ     R12+0, 1
	GOTO       L_main61
	DECFSZ     R11+0, 1
	GOTO       L_main61
	NOP
	NOP
;MyProject.c,152 :: 		for (onesCnt = 9; onesCnt >= 0 && statue; onesCnt--)
	MOVLW      1
	SUBWF      _onesCnt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _onesCnt+1, 1
;MyProject.c,156 :: 		}
	GOTO       L_main56
L_main57:
;MyProject.c,157 :: 		}
L_main55:
;MyProject.c,133 :: 		for (tensCnt = 1; tensCnt >= 0 && statue; tensCnt--)
	MOVLW      1
	SUBWF      _tensCnt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _tensCnt+1, 1
;MyProject.c,158 :: 		}
	GOTO       L_main42
L_main43:
;MyProject.c,159 :: 		portd = 0;
	CLRF       PORTD+0
;MyProject.c,160 :: 		portc = 255;
	MOVLW      255
	MOVWF      PORTC+0
;MyProject.c,161 :: 		porta = 255;
	MOVLW      255
	MOVWF      PORTA+0
;MyProject.c,162 :: 		}
L_main22:
;MyProject.c,163 :: 		}
	GOTO       L_main1
;MyProject.c,164 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
