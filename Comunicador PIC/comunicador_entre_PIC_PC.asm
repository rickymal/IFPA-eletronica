
_setTime:

;comunicador_entre_PIC_PC.c,42 :: 		void setTime(sfr unsigned short volatile *timer, double tempo_seg, double frequencia)
;comunicador_entre_PIC_PC.c,46 :: 		int i = 30;
;comunicador_entre_PIC_PC.c,48 :: 		int prescaler = 1;
	MOVLW       1
	MOVWF       setTime_prescaler_L0+0 
	MOVLW       0
	MOVWF       setTime_prescaler_L0+1 
	MOVLW       1
	MOVWF       setTime_postscaler_L0+0 
	MOVLW       0
	MOVWF       setTime_postscaler_L0+1 
;comunicador_entre_PIC_PC.c,50 :: 		Tof = 256*frequencia/4;
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       135
	MOVWF       R3 
	MOVF        FARG_setTime_frequencia+0, 0 
	MOVWF       R4 
	MOVF        FARG_setTime_frequencia+1, 0 
	MOVWF       R5 
	MOVF        FARG_setTime_frequencia+2, 0 
	MOVWF       R6 
	MOVF        FARG_setTime_frequencia+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;comunicador_entre_PIC_PC.c,51 :: 		Tmof = tempo_seg/Tof;
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FARG_setTime_tempo_seg+0, 0 
	MOVWF       R0 
	MOVF        FARG_setTime_tempo_seg+1, 0 
	MOVWF       R1 
	MOVF        FARG_setTime_tempo_seg+2, 0 
	MOVWF       R2 
	MOVF        FARG_setTime_tempo_seg+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       setTime_Tmof_L0+0 
	MOVF        R1, 0 
	MOVWF       setTime_Tmof_L0+1 
	MOVF        R2, 0 
	MOVWF       setTime_Tmof_L0+2 
	MOVF        R3, 0 
	MOVWF       setTime_Tmof_L0+3 
;comunicador_entre_PIC_PC.c,53 :: 		for(postscaler = 3; postscaler > 0; postscaler--)
	MOVLW       3
	MOVWF       setTime_postscaler_L0+0 
	MOVLW       0
	MOVWF       setTime_postscaler_L0+1 
L_setTime0:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       setTime_postscaler_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setTime31
	MOVF        setTime_postscaler_L0+0, 0 
	SUBLW       0
L__setTime31:
	BTFSC       STATUS+0, 0 
	GOTO        L_setTime1
;comunicador_entre_PIC_PC.c,55 :: 		for(prescaler = 16; prescaler > 0; prescaler--)
	MOVLW       16
	MOVWF       setTime_prescaler_L0+0 
	MOVLW       0
	MOVWF       setTime_prescaler_L0+1 
L_setTime3:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       setTime_prescaler_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setTime32
	MOVF        setTime_prescaler_L0+0, 0 
	SUBLW       0
L__setTime32:
	BTFSC       STATUS+0, 0 
	GOTO        L_setTime4
;comunicador_entre_PIC_PC.c,57 :: 		if((int)Tmof%(prescaler*postscaler) == 0) goto LABEL;
	MOVF        setTime_Tmof_L0+0, 0 
	MOVWF       R0 
	MOVF        setTime_Tmof_L0+1, 0 
	MOVWF       R1 
	MOVF        setTime_Tmof_L0+2, 0 
	MOVWF       R2 
	MOVF        setTime_Tmof_L0+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__setTime+0 
	MOVF        R1, 0 
	MOVWF       FLOC__setTime+1 
	MOVF        setTime_prescaler_L0+0, 0 
	MOVWF       R0 
	MOVF        setTime_prescaler_L0+1, 0 
	MOVWF       R1 
	MOVF        setTime_postscaler_L0+0, 0 
	MOVWF       R4 
	MOVF        setTime_postscaler_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        FLOC__setTime+0, 0 
	MOVWF       R0 
	MOVF        FLOC__setTime+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setTime33
	MOVLW       0
	XORWF       R0, 0 
L__setTime33:
	BTFSS       STATUS+0, 2 
	GOTO        L_setTime6
	GOTO        ___setTime_LABEL
L_setTime6:
;comunicador_entre_PIC_PC.c,55 :: 		for(prescaler = 16; prescaler > 0; prescaler--)
	MOVLW       1
	SUBWF       setTime_prescaler_L0+0, 1 
	MOVLW       0
	SUBWFB      setTime_prescaler_L0+1, 1 
;comunicador_entre_PIC_PC.c,58 :: 		}
	GOTO        L_setTime3
L_setTime4:
;comunicador_entre_PIC_PC.c,53 :: 		for(postscaler = 3; postscaler > 0; postscaler--)
	MOVLW       1
	SUBWF       setTime_postscaler_L0+0, 1 
	MOVLW       0
	SUBWFB      setTime_postscaler_L0+1, 1 
;comunicador_entre_PIC_PC.c,59 :: 		}
	GOTO        L_setTime0
L_setTime1:
;comunicador_entre_PIC_PC.c,60 :: 		LABEL:
___setTime_LABEL:
;comunicador_entre_PIC_PC.c,61 :: 		if(timer == &TMR6) //estou mexendo comm o Timer6?
	MOVF        FARG_setTime_timer+1, 0 
	XORLW       hi_addr(TMR6+0)
	BTFSS       STATUS+0, 2 
	GOTO        L__setTime34
	MOVLW       TMR6+0
	XORWF       FARG_setTime_timer+0, 0 
L__setTime34:
	BTFSS       STATUS+0, 2 
	GOTO        L_setTime7
;comunicador_entre_PIC_PC.c,63 :: 		T6CON = 0x00;
	CLRF        T6CON+0 
;comunicador_entre_PIC_PC.c,64 :: 		T6CON = prescaler <<  6;
	MOVLW       6
	MOVWF       R1 
	MOVF        setTime_prescaler_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__setTime35:
	BZ          L__setTime36
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__setTime35
L__setTime36:
	MOVF        R0, 0 
	MOVWF       T6CON+0 
;comunicador_entre_PIC_PC.c,65 :: 		T6CON += postscaler;
	MOVF        setTime_postscaler_L0+0, 0 
	ADDWF       T6CON+0, 1 
;comunicador_entre_PIC_PC.c,66 :: 		TMR6 = 0;
	CLRF        TMR6+0 
;comunicador_entre_PIC_PC.c,67 :: 		timer6timer = Tmof / (prescaler + postscaler);
	MOVF        setTime_postscaler_L0+0, 0 
	ADDWF       setTime_prescaler_L0+0, 0 
	MOVWF       R0 
	MOVF        setTime_postscaler_L0+1, 0 
	ADDWFC      setTime_prescaler_L0+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        setTime_Tmof_L0+0, 0 
	MOVWF       R0 
	MOVF        setTime_Tmof_L0+1, 0 
	MOVWF       R1 
	MOVF        setTime_Tmof_L0+2, 0 
	MOVWF       R2 
	MOVF        setTime_Tmof_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2byte+0, 0
	MOVF        R0, 0 
	MOVWF       _timer6timer+0 
;comunicador_entre_PIC_PC.c,68 :: 		return ;
	GOTO        L_end_setTime
;comunicador_entre_PIC_PC.c,69 :: 		}
L_setTime7:
;comunicador_entre_PIC_PC.c,70 :: 		}
L_end_setTime:
	RETURN      0
; end of _setTime

_read:

;comunicador_entre_PIC_PC.c,97 :: 		char read(char *mensagem) //retorna 1 se a mensagem for encontrada e zero caso não (no buffer, no caso)
;comunicador_entre_PIC_PC.c,100 :: 		int j = 0;
	CLRF        read_j_L0+0 
	CLRF        read_j_L0+1 
;comunicador_entre_PIC_PC.c,101 :: 		for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
	CLRF        R2 
	CLRF        R3 
L_read8:
	MOVLW       buffer+0
	ADDWF       R2, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(buffer+0)
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_read9
;comunicador_entre_PIC_PC.c,103 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j++)
	CLRF        read_j_L0+0 
	CLRF        read_j_L0+1 
L_read11:
	MOVF        read_j_L0+0, 0 
	ADDWF       FARG_read_mensagem+0, 0 
	MOVWF       FSR0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      FARG_read_mensagem+1, 0 
	MOVWF       FSR0H 
	MOVF        read_j_L0+0, 0 
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       buffer+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(buffer+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_read12
;comunicador_entre_PIC_PC.c,105 :: 		if(mensagem[j+1] == 0x00)
	MOVLW       1
	ADDWF       read_j_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      read_j_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_read_mensagem+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_read_mensagem+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_read14
;comunicador_entre_PIC_PC.c,107 :: 		margeIn = i;
	MOVF        R2, 0 
	MOVWF       _margeIn+0 
	MOVF        R3, 0 
	MOVWF       _margeIn+1 
;comunicador_entre_PIC_PC.c,108 :: 		margeOut = i+j;
	MOVF        read_j_L0+0, 0 
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _margeOut+0 
	MOVF        R1, 0 
	MOVWF       _margeOut+1 
;comunicador_entre_PIC_PC.c,109 :: 		buffer[i+j] = 0xFF;
	MOVLW       buffer+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(buffer+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,110 :: 		buffer[i+j-1] = 0xFF;
	MOVF        read_j_L0+0, 0 
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       buffer+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(buffer+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,111 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_read
;comunicador_entre_PIC_PC.c,112 :: 		}
L_read14:
;comunicador_entre_PIC_PC.c,103 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j++)
	INFSNZ      read_j_L0+0, 1 
	INCF        read_j_L0+1, 1 
;comunicador_entre_PIC_PC.c,113 :: 		}
	GOTO        L_read11
L_read12:
;comunicador_entre_PIC_PC.c,101 :: 		for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
	MOVLW       1
	ADDWF       read_j_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      read_j_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       R2, 1 
	MOVF        R1, 0 
	ADDWFC      R3, 1 
;comunicador_entre_PIC_PC.c,114 :: 		}
	GOTO        L_read8
L_read9:
;comunicador_entre_PIC_PC.c,115 :: 		return 0;
	CLRF        R0 
;comunicador_entre_PIC_PC.c,116 :: 		}
L_end_read:
	RETURN      0
; end of _read

_loop:

;comunicador_entre_PIC_PC.c,120 :: 		unsigned short loop()
;comunicador_entre_PIC_PC.c,122 :: 		read("left") PORTB = 0xFF;
	MOVLW       ?lstr1_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr1_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop15
	MOVLW       255
	MOVWF       PORTB+0 
L_loop15:
;comunicador_entre_PIC_PC.c,124 :: 		read("right") PORTB = 0x00;
	MOVLW       ?lstr2_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr2_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop16
	CLRF        PORTB+0 
L_loop16:
;comunicador_entre_PIC_PC.c,126 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_interrupt:

;comunicador_entre_PIC_PC.c,130 :: 		void interrupt() //a interrupção de alta prioridade apenas armazenará os dados recebidos (no momento apenas do computador)
;comunicador_entre_PIC_PC.c,132 :: 		if(RC1IF_bit)
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_interrupt17
;comunicador_entre_PIC_PC.c,134 :: 		buffer[posBuffer] = RC1REG;
	MOVLW       buffer+0
	ADDWF       _posBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(buffer+0)
	ADDWFC      _posBuffer+1, 0 
	MOVWF       FSR1H 
	MOVF        RC1REG+0, 0 
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,135 :: 		posBuffer++;
	MOVLW       1
	ADDWF       _posBuffer+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _posBuffer+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _posBuffer+0 
	MOVF        R1, 0 
	MOVWF       _posBuffer+1 
;comunicador_entre_PIC_PC.c,136 :: 		buffer[posBuffer] = 0x00;
	MOVLW       buffer+0
	ADDWF       _posBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(buffer+0)
	ADDWFC      _posBuffer+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;comunicador_entre_PIC_PC.c,137 :: 		}
L_interrupt17:
;comunicador_entre_PIC_PC.c,139 :: 		if(RC2IF_bit)
	BTFSS       RC2IF_bit+0, BitPos(RC2IF_bit+0) 
	GOTO        L_interrupt18
;comunicador_entre_PIC_PC.c,141 :: 		*(volatile int *)&GameBuffer[posGameBuffer] = RC2REG; //método para não termos otimização nesta área em específica, sem precisar do volatile
	MOVLW       GameBuffer+0
	ADDWF       _posGameBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(GameBuffer+0)
	ADDWFC      _posGameBuffer+1, 0 
	MOVWF       FSR1H 
	MOVF        RC2REG+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,142 :: 		posGameBuffer++;
	MOVLW       1
	ADDWF       _posGameBuffer+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _posGameBuffer+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _posGameBuffer+0 
	MOVF        R1, 0 
	MOVWF       _posGameBuffer+1 
;comunicador_entre_PIC_PC.c,143 :: 		GameBuffer[posGameBuffer] = 0x00;
	MOVLW       GameBuffer+0
	ADDWF       _posGameBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(GameBuffer+0)
	ADDWFC      _posGameBuffer+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;comunicador_entre_PIC_PC.c,145 :: 		}
L_interrupt18:
;comunicador_entre_PIC_PC.c,148 :: 		}
L_end_interrupt:
L__interrupt40:
	RETFIE      1
; end of _interrupt

_main:

;comunicador_entre_PIC_PC.c,150 :: 		void main()
;comunicador_entre_PIC_PC.c,155 :: 		TXSTA1.BRGH = 1; //Habilita o Intenso Baundrate (usa dois registradores para realiar a contagem de bits por segundo)
	BSF         TXSTA1+0, 2 
;comunicador_entre_PIC_PC.c,156 :: 		BAUDCON1.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado caso esteja em um,e descarta o SPBRGH1 quando esta em zero)
	BSF         BAUDCON1+0, 3 
;comunicador_entre_PIC_PC.c,157 :: 		SPBRGH1 = 0x00;
	CLRF        SPBRGH1+0 
;comunicador_entre_PIC_PC.c,158 :: 		SPBRG1 = 0x41; //baundrate configurado para 115200 (utilizando uma frequencia de aproxidamente 35MHz);
	MOVLW       65
	MOVWF       SPBRG1+0 
;comunicador_entre_PIC_PC.c,160 :: 		TXSTA2.BRGH = 1; //Desabilita o Intenso Baundrate
	BSF         TXSTA2+0, 2 
;comunicador_entre_PIC_PC.c,161 :: 		BAUDCON2.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado,e descarta o SPBRGH1 quando esta em zero)
	BSF         BAUDCON2+0, 3 
;comunicador_entre_PIC_PC.c,162 :: 		SPBRGH2 = 0x00;
	CLRF        SPBRGH2+0 
;comunicador_entre_PIC_PC.c,163 :: 		SPBRG2 = 0x45; //baundrate configurado para (utilizando uma frequencia de aproxidamente 35MHz);
	MOVLW       69
	MOVWF       SPBRG2+0 
;comunicador_entre_PIC_PC.c,166 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;comunicador_entre_PIC_PC.c,167 :: 		TRISC = 0xFF; //os dois registradores acima possuem pinos referentes ao EUSART1 e EUSART2, respectivamente e devem ser setados como saída
	MOVLW       255
	MOVWF       TRISC+0 
;comunicador_entre_PIC_PC.c,168 :: 		TRISD = 0xFF;
	MOVLW       255
	MOVWF       TRISD+0 
;comunicador_entre_PIC_PC.c,169 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;comunicador_entre_PIC_PC.c,172 :: 		TXSTA1.SYNC = 0;  //modo assincrono
	BCF         TXSTA1+0, 4 
;comunicador_entre_PIC_PC.c,173 :: 		RCSTA1.SPEN = 1;  //liga a eusart
	BSF         RCSTA1+0, 7 
;comunicador_entre_PIC_PC.c,174 :: 		TXSTA1.TXEN = 1;  //liga o circuito transmissor
	BSF         TXSTA1+0, 5 
;comunicador_entre_PIC_PC.c,175 :: 		TX1IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
	BCF         TX1IE_bit+0, BitPos(TX1IE_bit+0) 
;comunicador_entre_PIC_PC.c,176 :: 		ANSELB = 0x00;
	CLRF        ANSELB+0 
;comunicador_entre_PIC_PC.c,177 :: 		ANSELC = 0x00;
	CLRF        ANSELC+0 
;comunicador_entre_PIC_PC.c,179 :: 		TXSTA2.SYNC = 0;  //modo assincrono
	BCF         TXSTA2+0, 4 
;comunicador_entre_PIC_PC.c,180 :: 		RCSTA2.SPEN = 1;  //liga a eusart
	BSF         RCSTA2+0, 7 
;comunicador_entre_PIC_PC.c,181 :: 		TXSTA2.TXEN = 1;  //liga o circuito transmissor
	BSF         TXSTA2+0, 5 
;comunicador_entre_PIC_PC.c,182 :: 		TX2IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
	BCF         TX2IE_bit+0, BitPos(TX2IE_bit+0) 
;comunicador_entre_PIC_PC.c,183 :: 		ANSELD = 0x00;    //Os registrador Analogico-Digital devem estar desabilitado para que a comunicação funcione (ANSELB para o EUSART1 e ANSELC para EUSART2
	CLRF        ANSELD+0 
;comunicador_entre_PIC_PC.c,187 :: 		RCSTA1.CREN = 1; //similar ao spen. Habilita o circuito
	BSF         RCSTA1+0, 4 
;comunicador_entre_PIC_PC.c,190 :: 		while(PIR1.RC1IF) {RCREG1;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.
L_main19:
	BTFSS       PIR1+0, 5 
	GOTO        L_main20
	GOTO        L_main19
L_main20:
;comunicador_entre_PIC_PC.c,192 :: 		RCSTA2.CREN = 1; //similar ao spen. Habilita o circuito
	BSF         RCSTA2+0, 4 
;comunicador_entre_PIC_PC.c,195 :: 		while(PIR3.RC2IF) {RCREG2;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.
L_main21:
	BTFSS       PIR3+0, 5 
	GOTO        L_main22
	GOTO        L_main21
L_main22:
;comunicador_entre_PIC_PC.c,199 :: 		INTCON.GIE = 0x01;  //habilita a interrupção global
	BSF         INTCON+0, 7 
;comunicador_entre_PIC_PC.c,200 :: 		INTCON.PEIE = 0x01; //habilita a interrupção por periférico
	BSF         INTCON+0, 6 
;comunicador_entre_PIC_PC.c,201 :: 		RCON.IPEN = 0x01; //interrupção por prioridades habilitado (significa que poderá haver interrupção de alto nível e baixo nível no programa)
	BSF         RCON+0, 7 
;comunicador_entre_PIC_PC.c,203 :: 		IPR1.RC1IP = 0x01;         //recepção de dados (RX) possui interrupção de baixa prioridade
	BSF         IPR1+0, 5 
;comunicador_entre_PIC_PC.c,204 :: 		IPR1.TX1IP = 0x01;         //tranmissao possui interrupção de baixa prioridade
	BSF         IPR1+0, 4 
;comunicador_entre_PIC_PC.c,205 :: 		PIR1.TX1IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
	BCF         PIR1+0, 4 
;comunicador_entre_PIC_PC.c,206 :: 		PIE1.TX1IE = 0x00;            //desabilita interrupção por tx
	BCF         PIE1+0, 4 
;comunicador_entre_PIC_PC.c,207 :: 		PIR1.RC1IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
	BCF         PIR1+0, 5 
;comunicador_entre_PIC_PC.c,208 :: 		PIE1.RC1IE = 0x01;            // habilita a interrpção por rx
	BSF         PIE1+0, 5 
;comunicador_entre_PIC_PC.c,210 :: 		IPR3.RC2IP = 0x01;         //recepção de dados (RX) possui interrupção de alta prioridade
	BSF         IPR3+0, 5 
;comunicador_entre_PIC_PC.c,211 :: 		IPR3.TX2IP = 0x01;         //tranmissao possui interrupção de alta prioridade
	BSF         IPR3+0, 4 
;comunicador_entre_PIC_PC.c,212 :: 		PIR3.TX2IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
	BCF         PIR3+0, 4 
;comunicador_entre_PIC_PC.c,213 :: 		PIE3.TX2IE = 0x00;            //desabilita interrupção por tx
	BCF         PIE3+0, 4 
;comunicador_entre_PIC_PC.c,214 :: 		PIR3.RC2IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
	BCF         PIR3+0, 5 
;comunicador_entre_PIC_PC.c,215 :: 		PIE3.RC2IE = 0x01;            // habilita a interrpção por rx
	BSF         PIE3+0, 5 
;comunicador_entre_PIC_PC.c,219 :: 		PIR5.TMR6IF = 0;
	BCF         PIR5+0, 2 
;comunicador_entre_PIC_PC.c,220 :: 		PIR5.TMR4IF = 0;
	BCF         PIR5+0, 0 
;comunicador_entre_PIC_PC.c,221 :: 		PIE5.TMR6IE = 1;
	BSF         PIE5+0, 2 
;comunicador_entre_PIC_PC.c,222 :: 		PIR5.TMR4IE = 1;
	BSF         PIR5+0, 0 
;comunicador_entre_PIC_PC.c,223 :: 		IPR5.TMR6IP = 0;
	BCF         IPR5+0, 2 
;comunicador_entre_PIC_PC.c,224 :: 		IPR5.TMR4IP = 0;
	BCF         IPR5+0, 0 
;comunicador_entre_PIC_PC.c,225 :: 		TMR6 = 0;
	CLRF        TMR6+0 
;comunicador_entre_PIC_PC.c,226 :: 		TMR4 = 0;
	CLRF        TMR4+0 
;comunicador_entre_PIC_PC.c,227 :: 		T6CON = 0b00111001; //os valores do timer ainda devem ser ajustados corretamente
	MOVLW       57
	MOVWF       T6CON+0 
;comunicador_entre_PIC_PC.c,228 :: 		T4CON = 0b00111001; //define um tempo para 10 ms (pode estar errao por hora) considerando uma entrada de 136 vezes na interrupção  e uma frequencia d 31MHz
	MOVLW       57
	MOVWF       T4CON+0 
;comunicador_entre_PIC_PC.c,230 :: 		T6CON.TMR6ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,231 :: 		T6CON.TMR4ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,232 :: 		delay_ms(10);
	MOVLW       101
	MOVWF       R12, 0
	MOVLW       165
	MOVWF       R13, 0
L_main23:
	DECFSZ      R13, 1, 1
	BRA         L_main23
	DECFSZ      R12, 1, 1
	BRA         L_main23
;comunicador_entre_PIC_PC.c,235 :: 		for(i = 0; i < tamanhoBuffer;i++) buffer[i] = 0xFF;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main24:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main42
	MOVLW       40
	SUBWF       main_i_L0+0, 0 
L__main42:
	BTFSC       STATUS+0, 0 
	GOTO        L_main25
	MOVLW       buffer+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(buffer+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
	GOTO        L_main24
L_main25:
;comunicador_entre_PIC_PC.c,237 :: 		posBuffer = 0;
	CLRF        _posBuffer+0 
	CLRF        _posBuffer+1 
;comunicador_entre_PIC_PC.c,238 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;comunicador_entre_PIC_PC.c,239 :: 		while(1)
L_main27:
;comunicador_entre_PIC_PC.c,241 :: 		retorno = loop();
	CALL        _loop+0, 0
	MOVF        R0, 0 
	MOVWF       _retorno+0 
;comunicador_entre_PIC_PC.c,242 :: 		if(posBuffer > 35)   //chance de corrupção de dados
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _posBuffer+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main43
	MOVF        _posBuffer+0, 0 
	SUBLW       35
L__main43:
	BTFSC       STATUS+0, 0 
	GOTO        L_main29
;comunicador_entre_PIC_PC.c,244 :: 		posBuffer = 0;
	CLRF        _posBuffer+0 
	CLRF        _posBuffer+1 
;comunicador_entre_PIC_PC.c,246 :: 		}
L_main29:
;comunicador_entre_PIC_PC.c,247 :: 		}
	GOTO        L_main27
;comunicador_entre_PIC_PC.c,248 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
