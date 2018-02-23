
_limpaBuffer:

;comunicador_entre_PIC_PC.c,23 :: 		void limpaBuffer()  //método que realiza a limpeza do buffer, ou melhor, uma mensagem que já foi lida e interpretada
;comunicador_entre_PIC_PC.c,25 :: 		int x = margeIn;
	MOVF        _margeIn+0, 0 
	MOVWF       R1 
	MOVF        _margeIn+1, 0 
	MOVWF       R2 
;comunicador_entre_PIC_PC.c,26 :: 		int y = margeOut;
	MOVF        _margeOut+0, 0 
	MOVWF       R3 
	MOVF        _margeOut+1, 0 
	MOVWF       R4 
;comunicador_entre_PIC_PC.c,27 :: 		using_assist = 1;
	MOVLW       1
	MOVWF       _using_assist+0 
;comunicador_entre_PIC_PC.c,28 :: 		for(y; y > x;  y--) buffer[y] = 0xFF;
L_limpaBuffer0:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__limpaBuffer33
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__limpaBuffer33:
	BTFSC       STATUS+0, 0 
	GOTO        L_limpaBuffer1
	MOVLW       _buffer+0
	ADDWF       R3, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVLW       1
	SUBWF       R3, 1 
	MOVLW       0
	SUBWFB      R4, 1 
	GOTO        L_limpaBuffer0
L_limpaBuffer1:
;comunicador_entre_PIC_PC.c,29 :: 		margeIn = margeOut = using_assist = 0;
	CLRF        _using_assist+0 
	CLRF        _margeOut+0 
	CLRF        _margeOut+1 
	CLRF        _margeIn+0 
	CLRF        _margeIn+1 
;comunicador_entre_PIC_PC.c,31 :: 		}
L_end_limpaBuffer:
	RETURN      0
; end of _limpaBuffer

_servico:

;comunicador_entre_PIC_PC.c,33 :: 		void servico(char intent_field){ //determina o serviço que será utilizado
;comunicador_entre_PIC_PC.c,34 :: 		tent = intent_field;
	MOVF        FARG_servico_intent_field+0, 0 
	MOVWF       _tent+0 
	MOVLW       0
	MOVWF       _tent+1 
;comunicador_entre_PIC_PC.c,35 :: 		assist = limpaBuffer;
	MOVLW       _limpaBuffer+0
	MOVWF       _assist+0 
	MOVLW       hi_addr(_limpaBuffer+0)
	MOVWF       _assist+1 
	MOVLW       0
	MOVWF       _assist+2 
	MOVLW       0
	MOVWF       _assist+3 
;comunicador_entre_PIC_PC.c,36 :: 		if(tent) overflow = 1;// provoco um estouro intencional para cuidar realizar assistencia no buffer
	MOVF        _tent+0, 0 
	IORWF       _tent+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_servico3
	BSF         TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
L_servico3:
;comunicador_entre_PIC_PC.c,37 :: 		}
L_end_servico:
	RETURN      0
; end of _servico

_setTime:

;comunicador_entre_PIC_PC.c,40 :: 		void setTime(sfr unsigned short volatile *timer, double tempo_seg, double frequencia)  //serve para os timer's 2/4/6
;comunicador_entre_PIC_PC.c,44 :: 		int i = 30;
;comunicador_entre_PIC_PC.c,46 :: 		int prescaler = 1;
	MOVLW       1
	MOVWF       setTime_prescaler_L0+0 
	MOVLW       0
	MOVWF       setTime_prescaler_L0+1 
	MOVLW       1
	MOVWF       setTime_postscaler_L0+0 
	MOVLW       0
	MOVWF       setTime_postscaler_L0+1 
;comunicador_entre_PIC_PC.c,48 :: 		Tof = 256*frequencia/4;
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
	CALL        _double2int+0, 0
;comunicador_entre_PIC_PC.c,49 :: 		Tmof = tempo_seg/Tof;
	CALL        _int2double+0, 0
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
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       setTime_Tmof_L0+0 
	MOVF        R1, 0 
	MOVWF       setTime_Tmof_L0+1 
;comunicador_entre_PIC_PC.c,52 :: 		for(postscaler = 3; postscaler > 0; postscaler--)
	MOVLW       3
	MOVWF       setTime_postscaler_L0+0 
	MOVLW       0
	MOVWF       setTime_postscaler_L0+1 
L_setTime4:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       setTime_postscaler_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setTime36
	MOVF        setTime_postscaler_L0+0, 0 
	SUBLW       0
L__setTime36:
	BTFSC       STATUS+0, 0 
	GOTO        L_setTime5
;comunicador_entre_PIC_PC.c,54 :: 		for(prescaler = 16; prescaler > 0; prescaler--)
	MOVLW       16
	MOVWF       setTime_prescaler_L0+0 
	MOVLW       0
	MOVWF       setTime_prescaler_L0+1 
L_setTime7:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       setTime_prescaler_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setTime37
	MOVF        setTime_prescaler_L0+0, 0 
	SUBLW       0
L__setTime37:
	BTFSC       STATUS+0, 0 
	GOTO        L_setTime8
;comunicador_entre_PIC_PC.c,56 :: 		if(Tmof%(prescaler*postscaler) == 0) goto LABEL;
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
	MOVF        setTime_Tmof_L0+0, 0 
	MOVWF       R0 
	MOVF        setTime_Tmof_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__setTime38
	MOVLW       0
	XORWF       R0, 0 
L__setTime38:
	BTFSS       STATUS+0, 2 
	GOTO        L_setTime10
	GOTO        ___setTime_LABEL
L_setTime10:
;comunicador_entre_PIC_PC.c,54 :: 		for(prescaler = 16; prescaler > 0; prescaler--)
	MOVLW       1
	SUBWF       setTime_prescaler_L0+0, 1 
	MOVLW       0
	SUBWFB      setTime_prescaler_L0+1, 1 
;comunicador_entre_PIC_PC.c,59 :: 		}
	GOTO        L_setTime7
L_setTime8:
;comunicador_entre_PIC_PC.c,52 :: 		for(postscaler = 3; postscaler > 0; postscaler--)
	MOVLW       1
	SUBWF       setTime_postscaler_L0+0, 1 
	MOVLW       0
	SUBWFB      setTime_postscaler_L0+1, 1 
;comunicador_entre_PIC_PC.c,62 :: 		}
	GOTO        L_setTime4
L_setTime5:
;comunicador_entre_PIC_PC.c,64 :: 		LABEL:
___setTime_LABEL:
;comunicador_entre_PIC_PC.c,65 :: 		if(timer == &TMR6) //estou mexendo comm o Timer6?
	MOVF        FARG_setTime_timer+1, 0 
	XORLW       hi_addr(TMR6+0)
	BTFSS       STATUS+0, 2 
	GOTO        L__setTime39
	MOVLW       TMR6+0
	XORWF       FARG_setTime_timer+0, 0 
L__setTime39:
	BTFSS       STATUS+0, 2 
	GOTO        L_setTime11
;comunicador_entre_PIC_PC.c,68 :: 		T6CON = prescaler <<  6;
	MOVLW       6
	MOVWF       R1 
	MOVF        setTime_prescaler_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__setTime40:
	BZ          L__setTime41
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__setTime40
L__setTime41:
	MOVF        R0, 0 
	MOVWF       T6CON+0 
;comunicador_entre_PIC_PC.c,69 :: 		T6CON += postscaler;
	MOVF        setTime_postscaler_L0+0, 0 
	ADDWF       T6CON+0, 1 
;comunicador_entre_PIC_PC.c,70 :: 		TMR6 = 0;
	CLRF        TMR6+0 
;comunicador_entre_PIC_PC.c,71 :: 		timer6timer = Tmof / (prescaler + postscaler);
	MOVF        setTime_postscaler_L0+0, 0 
	ADDWF       setTime_prescaler_L0+0, 0 
	MOVWF       R4 
	MOVF        setTime_postscaler_L0+1, 0 
	ADDWFC      setTime_prescaler_L0+1, 0 
	MOVWF       R5 
	MOVF        setTime_Tmof_L0+0, 0 
	MOVWF       R0 
	MOVF        setTime_Tmof_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _timer6timer+0 
;comunicador_entre_PIC_PC.c,72 :: 		return ;
	GOTO        L_end_setTime
;comunicador_entre_PIC_PC.c,73 :: 		}
L_setTime11:
;comunicador_entre_PIC_PC.c,74 :: 		}
L_end_setTime:
	RETURN      0
; end of _setTime

_read:

;comunicador_entre_PIC_PC.c,76 :: 		char read(char *mensagem) //retorna 1 se a mensagem for encontrada e zero caso não (no buffer, no caso)
;comunicador_entre_PIC_PC.c,80 :: 		for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
	CLRF        read_i_L0+0 
	CLRF        read_i_L0+1 
L_read12:
	MOVLW       _buffer+0
	ADDWF       read_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      read_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_read13
;comunicador_entre_PIC_PC.c,82 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j ++)
	CLRF        read_j_L0+0 
	CLRF        read_j_L0+1 
L_read15:
	MOVF        read_j_L0+0, 0 
	ADDWF       FARG_read_mensagem+0, 0 
	MOVWF       FSR0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      FARG_read_mensagem+1, 0 
	MOVWF       FSR0H 
	MOVF        read_j_L0+0, 0 
	ADDWF       read_i_L0+0, 0 
	MOVWF       R0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      read_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       _buffer+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_read16
;comunicador_entre_PIC_PC.c,84 :: 		if(mensagem[j] == 0x00)
	MOVF        read_j_L0+0, 0 
	ADDWF       FARG_read_mensagem+0, 0 
	MOVWF       FSR0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      FARG_read_mensagem+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_read18
;comunicador_entre_PIC_PC.c,86 :: 		margeIn = i;
	MOVF        read_i_L0+0, 0 
	MOVWF       _margeIn+0 
	MOVF        read_i_L0+1, 0 
	MOVWF       _margeIn+1 
;comunicador_entre_PIC_PC.c,87 :: 		margeOut = i+j;
	MOVF        read_j_L0+0, 0 
	ADDWF       read_i_L0+0, 0 
	MOVWF       _margeOut+0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      read_i_L0+1, 0 
	MOVWF       _margeOut+1 
;comunicador_entre_PIC_PC.c,88 :: 		servico(servico_limpar_buffer);
	MOVLW       1
	MOVWF       FARG_servico_intent_field+0 
	CALL        _servico+0, 0
;comunicador_entre_PIC_PC.c,89 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_read
;comunicador_entre_PIC_PC.c,90 :: 		}
L_read18:
;comunicador_entre_PIC_PC.c,82 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j ++)
	INFSNZ      read_j_L0+0, 1 
	INCF        read_j_L0+1, 1 
;comunicador_entre_PIC_PC.c,91 :: 		}
	GOTO        L_read15
L_read16:
;comunicador_entre_PIC_PC.c,80 :: 		for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
	MOVLW       1
	ADDWF       read_j_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      read_j_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       read_i_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      read_i_L0+1, 1 
;comunicador_entre_PIC_PC.c,92 :: 		}
	GOTO        L_read12
L_read13:
;comunicador_entre_PIC_PC.c,93 :: 		return 0;
	CLRF        R0 
;comunicador_entre_PIC_PC.c,94 :: 		}
L_end_read:
	RETURN      0
; end of _read

_loop:

;comunicador_entre_PIC_PC.c,96 :: 		unsigned char loop()
;comunicador_entre_PIC_PC.c,98 :: 		if(read("CELL:AcenderLED"))
	MOVLW       ?lstr1_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr1_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop19
;comunicador_entre_PIC_PC.c,100 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;comunicador_entre_PIC_PC.c,101 :: 		PORTB = 0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;comunicador_entre_PIC_PC.c,102 :: 		}
L_loop19:
;comunicador_entre_PIC_PC.c,104 :: 		if(read("CELL:ApagarLED"))
	MOVLW       ?lstr2_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr2_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop20
;comunicador_entre_PIC_PC.c,106 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;comunicador_entre_PIC_PC.c,107 :: 		}
L_loop20:
;comunicador_entre_PIC_PC.c,109 :: 		return 0;
	CLRF        R0 
;comunicador_entre_PIC_PC.c,110 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_interrupt_low:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;comunicador_entre_PIC_PC.c,112 :: 		void interrupt_low()  //a interrupção de baixa prioridade que chamará os serviços
;comunicador_entre_PIC_PC.c,114 :: 		if(timer4timer < 136) asm retfie;
	MOVLW       136
	SUBWF       _timer4timer+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt_low21
	RETFIE      0
L_interrupt_low21:
;comunicador_entre_PIC_PC.c,115 :: 		if(timer6timer < 136) asm retfie;
	MOVLW       136
	SUBWF       _timer6timer+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt_low22
	RETFIE      0
L_interrupt_low22:
;comunicador_entre_PIC_PC.c,116 :: 		if(overflow) assist();overflow = 0;
	BTFSS       TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
	GOTO        L_interrupt_low23
	MOVF        _assist+0, 0 
	MOVWF       R0 
	MOVF        _assist+1, 0 
	MOVWF       R1 
	CALL        _____DoIFC+0, 0
L_interrupt_low23:
	BCF         TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
;comunicador_entre_PIC_PC.c,117 :: 		} //end interrupt low
L_end_interrupt_low:
L__interrupt_low45:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _interrupt_low

_interrupt:

;comunicador_entre_PIC_PC.c,119 :: 		void interrupt() //a interrupção de alta prioridade apenas armazenará os dados recebidos (no momento apenas do computador)
;comunicador_entre_PIC_PC.c,121 :: 		buffer[posBuffer] = RC1REG;
	MOVLW       _buffer+0
	ADDWF       _posBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      _posBuffer+1, 0 
	MOVWF       FSR1H 
	MOVF        RC1REG+0, 0 
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,122 :: 		posBuffer++;
	INFSNZ      _posBuffer+0, 1 
	INCF        _posBuffer+1, 1 
;comunicador_entre_PIC_PC.c,123 :: 		buffer[posBuffer] = 0x00;
	MOVLW       _buffer+0
	ADDWF       _posBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      _posBuffer+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;comunicador_entre_PIC_PC.c,124 :: 		}
L_end_interrupt:
L__interrupt47:
	RETFIE      1
; end of _interrupt

_main:

;comunicador_entre_PIC_PC.c,126 :: 		void main()
;comunicador_entre_PIC_PC.c,139 :: 		TXSTA2.BRGH = 1; //Desabilita o Intenso Baundrate
	BSF         TXSTA2+0, 2 
;comunicador_entre_PIC_PC.c,140 :: 		BAUDCON2.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado,e descarta o SPBRGH1 quando esta em zero)
	BSF         BAUDCON2+0, 3 
;comunicador_entre_PIC_PC.c,141 :: 		SPBRGH2 = 0x00;
	CLRF        SPBRGH2+0 
;comunicador_entre_PIC_PC.c,142 :: 		SPBRG2 = 0x45; //baundrate configurado para (utilizando uma frequencia de aproxidamente 35MHz);
	MOVLW       69
	MOVWF       SPBRG2+0 
;comunicador_entre_PIC_PC.c,146 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;comunicador_entre_PIC_PC.c,147 :: 		TRISC = 0xFF; //os dois registradores acima possuem pinos referentes ao EUSART1 e EUSART2, respectivamente e devem ser setados como saída
	MOVLW       255
	MOVWF       TRISC+0 
;comunicador_entre_PIC_PC.c,148 :: 		TRISD = 0xFF;
	MOVLW       255
	MOVWF       TRISD+0 
;comunicador_entre_PIC_PC.c,160 :: 		TXSTA2.SYNC = 0;  //modo assincrono
	BCF         TXSTA2+0, 4 
;comunicador_entre_PIC_PC.c,161 :: 		RCSTA2.SPEN = 1;  //liga a eusart
	BSF         RCSTA2+0, 7 
;comunicador_entre_PIC_PC.c,162 :: 		TXSTA2.TXEN = 1;  //liga o circuito transmissor
	BSF         TXSTA2+0, 5 
;comunicador_entre_PIC_PC.c,163 :: 		TX2IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
	BCF         TX2IE_bit+0, BitPos(TX2IE_bit+0) 
;comunicador_entre_PIC_PC.c,164 :: 		ANSELD = 0x00;    //Os registrador Analogico-Digital devem estar desabilitado para que a comunicação funcione (ANSELB para o EUSART1 e ANSELC para EUSART2
	CLRF        ANSELD+0 
;comunicador_entre_PIC_PC.c,175 :: 		RCSTA2.CREN = 1; //similar ao spen. Habilita o circuito
	BSF         RCSTA2+0, 4 
;comunicador_entre_PIC_PC.c,178 :: 		while(PIR3.RC2IF) {RCREG2;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.
L_main24:
	BTFSS       PIR3+0, 5 
	GOTO        L_main25
	GOTO        L_main24
L_main25:
;comunicador_entre_PIC_PC.c,183 :: 		INTCON.GIE = 0x01;  //habilita a interrupção global
	BSF         INTCON+0, 7 
;comunicador_entre_PIC_PC.c,184 :: 		INTCON.PEIE = 0x01; //habilita a interrupção por periférico
	BSF         INTCON+0, 6 
;comunicador_entre_PIC_PC.c,185 :: 		RCON.IPEN = 0x01; //interrupção por prioridades habilitado (significa que poderá haver interrupção de alto nível e baixo nível no programa)
	BSF         RCON+0, 7 
;comunicador_entre_PIC_PC.c,196 :: 		IPR3.RC2IP = 0x01;         //recepção de dados (RX) possui interrupção de alta prioridade
	BSF         IPR3+0, 5 
;comunicador_entre_PIC_PC.c,197 :: 		IPR3.TX2IP = 0x01;         //tranmissao possui interrupção de alta prioridade
	BSF         IPR3+0, 4 
;comunicador_entre_PIC_PC.c,198 :: 		PIR3.TX2IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
	BCF         PIR3+0, 4 
;comunicador_entre_PIC_PC.c,199 :: 		PIE3.TX2IE = 0x00;            //desabilita interrupção por tx
	BCF         PIE3+0, 4 
;comunicador_entre_PIC_PC.c,200 :: 		PIR3.RC2IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
	BCF         PIR3+0, 5 
;comunicador_entre_PIC_PC.c,201 :: 		PIE3.RC2IE = 0x01;            // habilita a interrpção por rx
	BSF         PIE3+0, 5 
;comunicador_entre_PIC_PC.c,204 :: 		PIR5.TMR6IF = 0;
	BCF         PIR5+0, 2 
;comunicador_entre_PIC_PC.c,205 :: 		PIR5.TMR4IF = 0;
	BCF         PIR5+0, 0 
;comunicador_entre_PIC_PC.c,206 :: 		PIE5.TMR6IE = 1;
	BSF         PIE5+0, 2 
;comunicador_entre_PIC_PC.c,207 :: 		PIR5.TMR4IE = 1;
	BSF         PIR5+0, 0 
;comunicador_entre_PIC_PC.c,208 :: 		IPR5.TMR6IP = 0;
	BCF         IPR5+0, 2 
;comunicador_entre_PIC_PC.c,209 :: 		IPR5.TMR4IP = 0;
	BCF         IPR5+0, 0 
;comunicador_entre_PIC_PC.c,210 :: 		TMR6 = 0;
	CLRF        TMR6+0 
;comunicador_entre_PIC_PC.c,211 :: 		TMR4 = 0;
	CLRF        TMR4+0 
;comunicador_entre_PIC_PC.c,212 :: 		T6CON = 0b00111001; //os valores do timer ainda devem ser ajustados corretamente
	MOVLW       57
	MOVWF       T6CON+0 
;comunicador_entre_PIC_PC.c,213 :: 		T4CON = 0b00111001; //define um tempo para 10 ms (pode estar errao por hora) considerando uma entrada de 136 vezes na interrupção  e uma frequencia d 31MHz
	MOVLW       57
	MOVWF       T4CON+0 
;comunicador_entre_PIC_PC.c,214 :: 		T6CON.TMR6ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,215 :: 		T6CON.TMR4ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,218 :: 		for(i = 0; i < tamanhoBuffer;i++) buffer[i] = 0xFF;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main26:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main49
	MOVLW       0
	SUBWF       main_i_L0+0, 0 
L__main49:
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
	MOVLW       _buffer+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
	GOTO        L_main26
L_main27:
;comunicador_entre_PIC_PC.c,219 :: 		while(1)
L_main29:
;comunicador_entre_PIC_PC.c,221 :: 		retorno = loop();
	CALL        _loop+0, 0
	MOVF        R0, 0 
	MOVWF       _retorno+0 
;comunicador_entre_PIC_PC.c,222 :: 		if(posBuffer > offset)
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       _posBuffer+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main50
	MOVF        _posBuffer+0, 0 
	SUBLW       128
L__main50:
	BTFSC       STATUS+0, 0 
	GOTO        L_main31
;comunicador_entre_PIC_PC.c,224 :: 		posBuffer = 0;
	CLRF        _posBuffer+0 
	CLRF        _posBuffer+1 
;comunicador_entre_PIC_PC.c,226 :: 		}
L_main31:
;comunicador_entre_PIC_PC.c,227 :: 		}
	GOTO        L_main29
;comunicador_entre_PIC_PC.c,228 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
