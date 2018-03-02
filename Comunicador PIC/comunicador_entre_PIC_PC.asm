
_setTime:

;comunicador_entre_PIC_PC.c,42 :: 		void setTime(sfr unsigned short volatile *timer, double tempo_seg, double frequencia)
;comunicador_entre_PIC_PC.c,44 :: 		int prescaler = 1;
	MOVLW       1
	MOVWF       setTime_prescaler_L0+0 
	MOVLW       0
	MOVWF       setTime_prescaler_L0+1 
	MOVLW       1
	MOVWF       setTime_postscaler_L0+0 
	MOVLW       0
	MOVWF       setTime_postscaler_L0+1 
;comunicador_entre_PIC_PC.c,46 :: 		int Tmof = (int)(tempo_seg/(256*(frequencia*1000)/4));
	MOVF        FARG_setTime_frequencia+0, 0 
	MOVWF       R0 
	MOVF        FARG_setTime_frequencia+1, 0 
	MOVWF       R1 
	MOVF        FARG_setTime_frequencia+2, 0 
	MOVWF       R2 
	MOVF        FARG_setTime_frequencia+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       135
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
;comunicador_entre_PIC_PC.c,47 :: 		for(postscaler = 3; postscaler > 0; postscaler--)
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
	GOTO        L__setTime42
	MOVF        setTime_postscaler_L0+0, 0 
	SUBLW       0
L__setTime42:
	BTFSC       STATUS+0, 0 
	GOTO        L_setTime1
;comunicador_entre_PIC_PC.c,49 :: 		for(prescaler = 16; prescaler > 0; prescaler--)
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
	GOTO        L__setTime43
	MOVF        setTime_prescaler_L0+0, 0 
	SUBLW       0
L__setTime43:
	BTFSC       STATUS+0, 0 
	GOTO        L_setTime4
;comunicador_entre_PIC_PC.c,51 :: 		if(Tmof%(prescaler*postscaler) == 0) goto LABEL;
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
	GOTO        L__setTime44
	MOVLW       0
	XORWF       R0, 0 
L__setTime44:
	BTFSS       STATUS+0, 2 
	GOTO        L_setTime6
	GOTO        ___setTime_LABEL
L_setTime6:
;comunicador_entre_PIC_PC.c,49 :: 		for(prescaler = 16; prescaler > 0; prescaler--)
	MOVLW       1
	SUBWF       setTime_prescaler_L0+0, 1 
	MOVLW       0
	SUBWFB      setTime_prescaler_L0+1, 1 
;comunicador_entre_PIC_PC.c,52 :: 		}
	GOTO        L_setTime3
L_setTime4:
;comunicador_entre_PIC_PC.c,47 :: 		for(postscaler = 3; postscaler > 0; postscaler--)
	MOVLW       1
	SUBWF       setTime_postscaler_L0+0, 1 
	MOVLW       0
	SUBWFB      setTime_postscaler_L0+1, 1 
;comunicador_entre_PIC_PC.c,53 :: 		}
	GOTO        L_setTime0
L_setTime1:
;comunicador_entre_PIC_PC.c,54 :: 		LABEL:
___setTime_LABEL:
;comunicador_entre_PIC_PC.c,55 :: 		if(timer == &TMR6) //estou mexendo comm o Timer6?
	MOVF        FARG_setTime_timer+1, 0 
	XORLW       hi_addr(TMR6+0)
	BTFSS       STATUS+0, 2 
	GOTO        L__setTime45
	MOVLW       TMR6+0
	XORWF       FARG_setTime_timer+0, 0 
L__setTime45:
	BTFSS       STATUS+0, 2 
	GOTO        L_setTime7
;comunicador_entre_PIC_PC.c,57 :: 		T6CON = 0x00;
	CLRF        T6CON+0 
;comunicador_entre_PIC_PC.c,58 :: 		T6CON = prescaler <<  6;
	MOVLW       6
	MOVWF       R1 
	MOVF        setTime_prescaler_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__setTime46:
	BZ          L__setTime47
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__setTime46
L__setTime47:
	MOVF        R0, 0 
	MOVWF       T6CON+0 
;comunicador_entre_PIC_PC.c,59 :: 		T6CON += postscaler;
	MOVF        setTime_postscaler_L0+0, 0 
	ADDWF       T6CON+0, 1 
;comunicador_entre_PIC_PC.c,60 :: 		TMR6 = 0;
	CLRF        TMR6+0 
;comunicador_entre_PIC_PC.c,61 :: 		timer6timer = Tmof / (prescaler + postscaler);
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
;comunicador_entre_PIC_PC.c,62 :: 		return ;
	GOTO        L_end_setTime
;comunicador_entre_PIC_PC.c,63 :: 		}
L_setTime7:
;comunicador_entre_PIC_PC.c,64 :: 		}
L_end_setTime:
	RETURN      0
; end of _setTime

_read:

;comunicador_entre_PIC_PC.c,68 :: 		char read(char *mensagem, unsigned char *buf) //retorna 1 se a mensagem for encontrada e zero caso não (no buffer, no caso)
;comunicador_entre_PIC_PC.c,71 :: 		int j = 0;
	CLRF        read_j_L0+0 
	CLRF        read_j_L0+1 
;comunicador_entre_PIC_PC.c,72 :: 		for(i = 0 ; buf[i] != 0x00; i+= 1 + j)
	CLRF        R2 
	CLRF        R3 
L_read8:
	MOVF        R2, 0 
	ADDWF       FARG_read_buf+0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      FARG_read_buf+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_read9
;comunicador_entre_PIC_PC.c,74 :: 		for(j = 0; mensagem[j] == buf[i+j]; j++)
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
	MOVF        R0, 0 
	ADDWF       FARG_read_buf+0, 0 
	MOVWF       FSR2 
	MOVF        R1, 0 
	ADDWFC      FARG_read_buf+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_read12
;comunicador_entre_PIC_PC.c,76 :: 		if(mensagem[j+1] == 0x00)
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
;comunicador_entre_PIC_PC.c,78 :: 		buf[i+j] = 0xFF;
	MOVF        read_j_L0+0, 0 
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_read_buf+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FARG_read_buf+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,79 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_read
;comunicador_entre_PIC_PC.c,80 :: 		}
L_read14:
;comunicador_entre_PIC_PC.c,74 :: 		for(j = 0; mensagem[j] == buf[i+j]; j++)
	INFSNZ      read_j_L0+0, 1 
	INCF        read_j_L0+1, 1 
;comunicador_entre_PIC_PC.c,81 :: 		}
	GOTO        L_read11
L_read12:
;comunicador_entre_PIC_PC.c,72 :: 		for(i = 0 ; buf[i] != 0x00; i+= 1 + j)
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
;comunicador_entre_PIC_PC.c,82 :: 		}
	GOTO        L_read8
L_read9:
;comunicador_entre_PIC_PC.c,83 :: 		return 0;
	CLRF        R0 
;comunicador_entre_PIC_PC.c,84 :: 		}
L_end_read:
	RETURN      0
; end of _read

_escrever:

;comunicador_entre_PIC_PC.c,89 :: 		void escrever(char paraQuem, char *mensagem)
;comunicador_entre_PIC_PC.c,93 :: 		if(paraQuem = 'p') regSend = &TXREG1;
	MOVLW       112
	MOVWF       FARG_escrever_paraQuem+0 
	MOVLW       TXREG1+0
	MOVWF       R3 
	MOVLW       hi_addr(TXREG1+0)
	MOVWF       R4 
;comunicador_entre_PIC_PC.c,94 :: 		else regSend = &TXREG2;
L_escrever16:
;comunicador_entre_PIC_PC.c,95 :: 		for(i = 0; mensagem[i] != 0x00; i++)
	CLRF        R1 
	CLRF        R2 
L_escrever17:
	MOVF        R1, 0 
	ADDWF       FARG_escrever_mensagem+0, 0 
	MOVWF       FSR0 
	MOVF        R2, 0 
	ADDWFC      FARG_escrever_mensagem+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_escrever18
;comunicador_entre_PIC_PC.c,97 :: 		*regSend = mensagem[i];
	MOVF        R1, 0 
	ADDWF       FARG_escrever_mensagem+0, 0 
	MOVWF       FSR0 
	MOVF        R2, 0 
	ADDWFC      FARG_escrever_mensagem+1, 0 
	MOVWF       FSR0H 
	MOVFF       R3, FSR1
	MOVFF       R4, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,98 :: 		delay_ms(1);
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       15
	MOVWF       R13, 0
L_escrever20:
	DECFSZ      R13, 1, 1
	BRA         L_escrever20
	DECFSZ      R12, 1, 1
	BRA         L_escrever20
;comunicador_entre_PIC_PC.c,95 :: 		for(i = 0; mensagem[i] != 0x00; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;comunicador_entre_PIC_PC.c,99 :: 		}
	GOTO        L_escrever17
L_escrever18:
;comunicador_entre_PIC_PC.c,100 :: 		*regSend = '\n';
	MOVFF       R3, FSR1
	MOVFF       R4, FSR1H
	MOVLW       10
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,101 :: 		}
L_end_escrever:
	RETURN      0
; end of _escrever

_loop:

;comunicador_entre_PIC_PC.c,103 :: 		unsigned short loop()
;comunicador_entre_PIC_PC.c,108 :: 		read("esta vivo?") escrever('p', "Estou vivo sim, muito obrigado pela preocupacao!");
	MOVLW       ?lstr1_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr1_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	MOVLW       bufferPc+0
	MOVWF       FARG_read_buf+0 
	MOVLW       hi_addr(bufferPc+0)
	MOVWF       FARG_read_buf+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop21
	MOVLW       112
	MOVWF       FARG_escrever_paraQuem+0 
	MOVLW       ?lstr2_comunicador_entre_PIC_PC+0
	MOVWF       FARG_escrever_mensagem+0 
	MOVLW       hi_addr(?lstr2_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_escrever_mensagem+1 
	CALL        _escrever+0, 0
L_loop21:
;comunicador_entre_PIC_PC.c,110 :: 		read("BlocoEnergizado")
	MOVLW       ?lstr3_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr3_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	MOVLW       bufferPc+0
	MOVWF       FARG_read_buf+0 
	MOVLW       hi_addr(bufferPc+0)
	MOVWF       FARG_read_buf+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop22
;comunicador_entre_PIC_PC.c,112 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;comunicador_entre_PIC_PC.c,113 :: 		PORTB = 0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;comunicador_entre_PIC_PC.c,114 :: 		delay_ms(1000);
	MOVLW       40
	MOVWF       R11, 0
	MOVLW       81
	MOVWF       R12, 0
	MOVLW       211
	MOVWF       R13, 0
L_loop23:
	DECFSZ      R13, 1, 1
	BRA         L_loop23
	DECFSZ      R12, 1, 1
	BRA         L_loop23
	DECFSZ      R11, 1, 1
	BRA         L_loop23
;comunicador_entre_PIC_PC.c,115 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;comunicador_entre_PIC_PC.c,116 :: 		}
L_loop22:
;comunicador_entre_PIC_PC.c,118 :: 		read("relatorio")
	MOVLW       ?lstr4_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr4_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	MOVLW       bufferPc+0
	MOVWF       FARG_read_buf+0 
	MOVLW       hi_addr(bufferPc+0)
	MOVWF       FARG_read_buf+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop24
;comunicador_entre_PIC_PC.c,120 :: 		escrever('p', "Autor: Henrique Mauler Borges");
	MOVLW       112
	MOVWF       FARG_escrever_paraQuem+0 
	MOVLW       ?lstr5_comunicador_entre_PIC_PC+0
	MOVWF       FARG_escrever_mensagem+0 
	MOVLW       hi_addr(?lstr5_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_escrever_mensagem+1 
	CALL        _escrever+0, 0
;comunicador_entre_PIC_PC.c,121 :: 		}
L_loop24:
;comunicador_entre_PIC_PC.c,123 :: 		read("Qual a sua frequencia?")
	MOVLW       ?lstr6_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr6_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	MOVLW       bufferPc+0
	MOVWF       FARG_read_buf+0 
	MOVLW       hi_addr(bufferPc+0)
	MOVWF       FARG_read_buf+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop25
;comunicador_entre_PIC_PC.c,126 :: 		unsigned short clock = Clock_MHz();
	MOVLW       31
	MOVWF       loop_clock_L1+0 
;comunicador_entre_PIC_PC.c,127 :: 		ShortToStr(clock, saidaclock);
	MOVF        loop_clock_L1+0, 0 
	MOVWF       FARG_ShortToStr_input+0 
	MOVLW       loop_saidaclock_L1+0
	MOVWF       FARG_ShortToStr_output+0 
	MOVLW       hi_addr(loop_saidaclock_L1+0)
	MOVWF       FARG_ShortToStr_output+1 
	CALL        _ShortToStr+0, 0
;comunicador_entre_PIC_PC.c,129 :: 		escrever('p', "A frequencia de trabalho é: ");
	MOVLW       112
	MOVWF       FARG_escrever_paraQuem+0 
	MOVLW       ?lstr7_comunicador_entre_PIC_PC+0
	MOVWF       FARG_escrever_mensagem+0 
	MOVLW       hi_addr(?lstr7_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_escrever_mensagem+1 
	CALL        _escrever+0, 0
;comunicador_entre_PIC_PC.c,130 :: 		escrever('p', saidaclock);
	MOVLW       112
	MOVWF       FARG_escrever_paraQuem+0 
	MOVLW       loop_saidaclock_L1+0
	MOVWF       FARG_escrever_mensagem+0 
	MOVLW       hi_addr(loop_saidaclock_L1+0)
	MOVWF       FARG_escrever_mensagem+1 
	CALL        _escrever+0, 0
;comunicador_entre_PIC_PC.c,135 :: 		}
L_loop25:
;comunicador_entre_PIC_PC.c,147 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_interrupt:

;comunicador_entre_PIC_PC.c,149 :: 		void interrupt() //a interrupção de alta prioridade apenas armazenará os dados recebidos (no momento apenas do computador)
;comunicador_entre_PIC_PC.c,151 :: 		if(RC1IF_bit)
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_interrupt26
;comunicador_entre_PIC_PC.c,153 :: 		bufferPc[posBufferPc] = RC1REG;
	MOVLW       bufferPc+0
	ADDWF       _posBufferPc+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(bufferPc+0)
	ADDWFC      _posBufferPc+1, 0 
	MOVWF       FSR1H 
	MOVF        RC1REG+0, 0 
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,154 :: 		posBufferPc++;
	MOVLW       1
	ADDWF       _posBufferPc+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _posBufferPc+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _posBufferPc+0 
	MOVF        R1, 0 
	MOVWF       _posBufferPc+1 
;comunicador_entre_PIC_PC.c,155 :: 		bufferPc[posBufferPc] = 0x00;
	MOVLW       bufferPc+0
	ADDWF       _posBufferPc+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(bufferPc+0)
	ADDWFC      _posBufferPc+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;comunicador_entre_PIC_PC.c,156 :: 		}
	GOTO        L_interrupt27
L_interrupt26:
;comunicador_entre_PIC_PC.c,157 :: 		else if(RC2IF_bit)
	BTFSS       RC2IF_bit+0, BitPos(RC2IF_bit+0) 
	GOTO        L_interrupt28
;comunicador_entre_PIC_PC.c,160 :: 		bufferModulo[posBufferModulo] = RC2REG;
	MOVLW       bufferModulo+0
	ADDWF       _posBufferModulo+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(bufferModulo+0)
	ADDWFC      _posBufferModulo+1, 0 
	MOVWF       FSR1H 
	MOVF        RC2REG+0, 0 
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,161 :: 		posBufferModulo++;
	MOVLW       1
	ADDWF       _posBufferModulo+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _posBufferModulo+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _posBufferModulo+0 
	MOVF        R1, 0 
	MOVWF       _posBufferModulo+1 
;comunicador_entre_PIC_PC.c,162 :: 		bufferModulo[posBufferModulo] = 0x00;
	MOVLW       bufferModulo+0
	ADDWF       _posBufferModulo+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(bufferModulo+0)
	ADDWFC      _posBufferModulo+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;comunicador_entre_PIC_PC.c,163 :: 		}
L_interrupt28:
L_interrupt27:
;comunicador_entre_PIC_PC.c,164 :: 		T6CON.TMR6ON = 1;
	BSF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,165 :: 		TMR6 = 0;
	CLRF        TMR6+0 
;comunicador_entre_PIC_PC.c,166 :: 		}
L_end_interrupt:
L__interrupt52:
	RETFIE      1
; end of _interrupt

_main:

;comunicador_entre_PIC_PC.c,168 :: 		void main()
;comunicador_entre_PIC_PC.c,173 :: 		TXSTA1.BRGH = 1; //Habilita o Intenso Baundrate (usa dois registradores para realiar a contagem de bits por segundo)
	BSF         TXSTA1+0, 2 
;comunicador_entre_PIC_PC.c,174 :: 		BAUDCON1.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado caso esteja em um,e descarta o SPBRGH1 quando esta em zero)
	BSF         BAUDCON1+0, 3 
;comunicador_entre_PIC_PC.c,175 :: 		SPBRGH1 = 0x00;
	CLRF        SPBRGH1+0 
;comunicador_entre_PIC_PC.c,176 :: 		SPBRG1 = 0x41; //baundrate configurado para 115200 (utilizando uma frequencia de aproxidamente 35MHz);
	MOVLW       65
	MOVWF       SPBRG1+0 
;comunicador_entre_PIC_PC.c,178 :: 		TXSTA2.BRGH = 1; //Desabilita o Intenso Baundrate
	BSF         TXSTA2+0, 2 
;comunicador_entre_PIC_PC.c,179 :: 		BAUDCON2.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado,e descarta o SPBRGH1 quando esta em zero)
	BSF         BAUDCON2+0, 3 
;comunicador_entre_PIC_PC.c,180 :: 		SPBRGH2 = 0x00;
	CLRF        SPBRGH2+0 
;comunicador_entre_PIC_PC.c,181 :: 		SPBRG2 = 0x45; //baundrate configurado para (utilizando uma frequencia de aproxidamente 35MHz);
	MOVLW       69
	MOVWF       SPBRG2+0 
;comunicador_entre_PIC_PC.c,184 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;comunicador_entre_PIC_PC.c,185 :: 		TRISC = 0xFF; //os dois registradores acima possuem pinos referentes ao EUSART1 e EUSART2, respectivamente e devem ser setados como saída
	MOVLW       255
	MOVWF       TRISC+0 
;comunicador_entre_PIC_PC.c,186 :: 		TRISD = 0xFF;
	MOVLW       255
	MOVWF       TRISD+0 
;comunicador_entre_PIC_PC.c,187 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;comunicador_entre_PIC_PC.c,190 :: 		TXSTA1.SYNC = 0;  //modo assincrono
	BCF         TXSTA1+0, 4 
;comunicador_entre_PIC_PC.c,191 :: 		RCSTA1.SPEN = 1;  //liga a eusart
	BSF         RCSTA1+0, 7 
;comunicador_entre_PIC_PC.c,192 :: 		TXSTA1.TXEN = 1;  //liga o circuito transmissor
	BSF         TXSTA1+0, 5 
;comunicador_entre_PIC_PC.c,193 :: 		TX1IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
	BCF         TX1IE_bit+0, BitPos(TX1IE_bit+0) 
;comunicador_entre_PIC_PC.c,194 :: 		ANSELB = 0x00;
	CLRF        ANSELB+0 
;comunicador_entre_PIC_PC.c,195 :: 		ANSELC = 0x00;
	CLRF        ANSELC+0 
;comunicador_entre_PIC_PC.c,197 :: 		TXSTA2.SYNC = 0;  //modo assincrono
	BCF         TXSTA2+0, 4 
;comunicador_entre_PIC_PC.c,198 :: 		RCSTA2.SPEN = 1;  //liga a eusart
	BSF         RCSTA2+0, 7 
;comunicador_entre_PIC_PC.c,199 :: 		TXSTA2.TXEN = 1;  //liga o circuito transmissor
	BSF         TXSTA2+0, 5 
;comunicador_entre_PIC_PC.c,200 :: 		TX2IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
	BCF         TX2IE_bit+0, BitPos(TX2IE_bit+0) 
;comunicador_entre_PIC_PC.c,201 :: 		ANSELD = 0x00;    //Os registrador Analogico-Digital devem estar desabilitado para que a comunicação funcione (ANSELB para o EUSART1 e ANSELC para EUSART2
	CLRF        ANSELD+0 
;comunicador_entre_PIC_PC.c,205 :: 		RCSTA1.CREN = 1; //similar ao spen. Habilita o circuito
	BSF         RCSTA1+0, 4 
;comunicador_entre_PIC_PC.c,208 :: 		while(PIR1.RC1IF) {RCREG1;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.
L_main29:
	BTFSS       PIR1+0, 5 
	GOTO        L_main30
	GOTO        L_main29
L_main30:
;comunicador_entre_PIC_PC.c,210 :: 		RCSTA2.CREN = 1; //similar ao spen. Habilita o circuito
	BSF         RCSTA2+0, 4 
;comunicador_entre_PIC_PC.c,213 :: 		while(PIR3.RC2IF) {RCREG2;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.
L_main31:
	BTFSS       PIR3+0, 5 
	GOTO        L_main32
	GOTO        L_main31
L_main32:
;comunicador_entre_PIC_PC.c,217 :: 		INTCON.GIE = 0x01;  //habilita a interrupção global
	BSF         INTCON+0, 7 
;comunicador_entre_PIC_PC.c,218 :: 		INTCON.PEIE = 0x01; //habilita a interrupção por periférico
	BSF         INTCON+0, 6 
;comunicador_entre_PIC_PC.c,219 :: 		RCON.IPEN = 0x01; //interrupção por prioridades habilitado (significa que poderá haver interrupção de alto nível e baixo nível no programa)
	BSF         RCON+0, 7 
;comunicador_entre_PIC_PC.c,221 :: 		IPR1.RC1IP = 0x01;         //recepção de dados (RX) possui interrupção de baixa prioridade
	BSF         IPR1+0, 5 
;comunicador_entre_PIC_PC.c,222 :: 		IPR1.TX1IP = 0x01;         //tranmissao possui interrupção de baixa prioridade
	BSF         IPR1+0, 4 
;comunicador_entre_PIC_PC.c,223 :: 		PIR1.TX1IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
	BCF         PIR1+0, 4 
;comunicador_entre_PIC_PC.c,224 :: 		PIE1.TX1IE = 0x00;            //desabilita interrupção por tx
	BCF         PIE1+0, 4 
;comunicador_entre_PIC_PC.c,225 :: 		PIR1.RC1IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
	BCF         PIR1+0, 5 
;comunicador_entre_PIC_PC.c,226 :: 		PIE1.RC1IE = 0x01;            // habilita a interrpção por rx
	BSF         PIE1+0, 5 
;comunicador_entre_PIC_PC.c,228 :: 		IPR3.RC2IP = 0x01;         //recepção de dados (RX) possui interrupção de alta prioridade
	BSF         IPR3+0, 5 
;comunicador_entre_PIC_PC.c,229 :: 		IPR3.TX2IP = 0x01;         //tranmissao possui interrupção de alta prioridade
	BSF         IPR3+0, 4 
;comunicador_entre_PIC_PC.c,230 :: 		PIR3.TX2IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
	BCF         PIR3+0, 4 
;comunicador_entre_PIC_PC.c,231 :: 		PIE3.TX2IE = 0x00;            //desabilita interrupção por tx
	BCF         PIE3+0, 4 
;comunicador_entre_PIC_PC.c,232 :: 		PIR3.RC2IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
	BCF         PIR3+0, 5 
;comunicador_entre_PIC_PC.c,233 :: 		PIE3.RC2IE = 0x01;            // habilita a interrpção por rx
	BSF         PIE3+0, 5 
;comunicador_entre_PIC_PC.c,236 :: 		PIR5.TMR6IF = 0;
	BCF         PIR5+0, 2 
;comunicador_entre_PIC_PC.c,237 :: 		PIR5.TMR4IF = 0;
	BCF         PIR5+0, 0 
;comunicador_entre_PIC_PC.c,240 :: 		IPR5.TMR6IP = 0;
	BCF         IPR5+0, 2 
;comunicador_entre_PIC_PC.c,241 :: 		IPR5.TMR4IP = 0;
	BCF         IPR5+0, 0 
;comunicador_entre_PIC_PC.c,242 :: 		TMR6 = 0;
	CLRF        TMR6+0 
;comunicador_entre_PIC_PC.c,243 :: 		TMR4 = 0;
	CLRF        TMR4+0 
;comunicador_entre_PIC_PC.c,244 :: 		T6CON = 0b01111011; //os valores do timer ainda devem ser ajustados corretamente
	MOVLW       123
	MOVWF       T6CON+0 
;comunicador_entre_PIC_PC.c,245 :: 		T4CON = 0b00111001; //define um tempo para 10 ms (pode estar errao por hora) considerando uma entrada de 136 vezes na interrupção  e uma frequencia d 31MHz
	MOVLW       57
	MOVWF       T4CON+0 
;comunicador_entre_PIC_PC.c,246 :: 		T6CON.TMR6ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,247 :: 		T6CON.TMR4ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,251 :: 		for(i = 0; i < tamanhoBuffer;i++) bufferPc[i] = bufferModulo[i] = 0xFF;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main33:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main54
	MOVLW       50
	SUBWF       main_i_L0+0, 0 
L__main54:
	BTFSC       STATUS+0, 0 
	GOTO        L_main34
	MOVLW       bufferPc+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(bufferPc+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       R3 
	MOVLW       bufferModulo+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       hi_addr(bufferModulo+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       R1 
	MOVFF       R0, FSR1
	MOVFF       R1, FSR1H
	MOVLW       255
	MOVWF       POSTINC1+0 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
	GOTO        L_main33
L_main34:
;comunicador_entre_PIC_PC.c,255 :: 		posBufferPc = 0;
	CLRF        _posBufferPc+0 
	CLRF        _posBufferPc+1 
;comunicador_entre_PIC_PC.c,256 :: 		posBufferModulo = 0;
	CLRF        _posBufferModulo+0 
	CLRF        _posBufferModulo+1 
;comunicador_entre_PIC_PC.c,257 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;comunicador_entre_PIC_PC.c,258 :: 		while(1)
L_main36:
;comunicador_entre_PIC_PC.c,260 :: 		retorno = loop();
	CALL        _loop+0, 0
	MOVF        R0, 0 
	MOVWF       _retorno+0 
;comunicador_entre_PIC_PC.c,261 :: 		if(PIR5.TMR6IF)
	BTFSS       PIR5+0, 2 
	GOTO        L_main38
;comunicador_entre_PIC_PC.c,263 :: 		PIR5.TMR6IF = 0;
	BCF         PIR5+0, 2 
;comunicador_entre_PIC_PC.c,264 :: 		T6CON.TMR6ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,265 :: 		if(posBufferPc > offset + 5)   //chance de corrupção de dados
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _posBufferPc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main55
	MOVF        _posBufferPc+0, 0 
	SUBLW       38
L__main55:
	BTFSC       STATUS+0, 0 
	GOTO        L_main39
;comunicador_entre_PIC_PC.c,267 :: 		posBufferPc = 0;
	CLRF        _posBufferPc+0 
	CLRF        _posBufferPc+1 
;comunicador_entre_PIC_PC.c,268 :: 		}
L_main39:
;comunicador_entre_PIC_PC.c,269 :: 		if(posBufferModulo > offset)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _posBufferModulo+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVF        _posBufferModulo+0, 0 
	SUBLW       33
L__main56:
	BTFSC       STATUS+0, 0 
	GOTO        L_main40
;comunicador_entre_PIC_PC.c,271 :: 		posBufferModulo = 0;
	CLRF        _posBufferModulo+0 
	CLRF        _posBufferModulo+1 
;comunicador_entre_PIC_PC.c,272 :: 		}
L_main40:
;comunicador_entre_PIC_PC.c,275 :: 		}
L_main38:
;comunicador_entre_PIC_PC.c,276 :: 		}
	GOTO        L_main36
;comunicador_entre_PIC_PC.c,277 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
