
_assistente:

;comunicador_entre_PIC_PC.c,18 :: 		void assistente() //necessita de melhoras para melhor adaptação
;comunicador_entre_PIC_PC.c,20 :: 		int x = margeIn;
	MOVF        _margeIn+0, 0 
	MOVWF       R1 
	MOVF        _margeIn+1, 0 
	MOVWF       R2 
;comunicador_entre_PIC_PC.c,21 :: 		int y = margeOut;
	MOVF        _margeOut+0, 0 
	MOVWF       R3 
	MOVF        _margeOut+1, 0 
	MOVWF       R4 
;comunicador_entre_PIC_PC.c,22 :: 		using_assist = 1;
	MOVLW       1
	MOVWF       _using_assist+0 
;comunicador_entre_PIC_PC.c,24 :: 		if(buffer[margeOut] == 0x00)
	MOVLW       _buffer+0
	ADDWF       _margeOut+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      _margeOut+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_assistente0
;comunicador_entre_PIC_PC.c,25 :: 		for(y; y > x;  y--) buffer[y] = 0xFF;
L_assistente1:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__assistente13
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__assistente13:
	BTFSC       STATUS+0, 0 
	GOTO        L_assistente2
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
	GOTO        L_assistente1
L_assistente2:
L_assistente0:
;comunicador_entre_PIC_PC.c,26 :: 		margeIn = margeOut = using_assist = 0;
	CLRF        _using_assist+0 
	CLRF        _margeOut+0 
	CLRF        _margeOut+1 
	CLRF        _margeIn+0 
	CLRF        _margeIn+1 
;comunicador_entre_PIC_PC.c,27 :: 		}
L_end_assistente:
	RETURN      0
; end of _assistente

_servico:

;comunicador_entre_PIC_PC.c,29 :: 		void servico(char intent_field){
;comunicador_entre_PIC_PC.c,30 :: 		tent = intent_field;
	MOVF        FARG_servico_intent_field+0, 0 
	MOVWF       _tent+0 
	MOVLW       0
	MOVWF       _tent+1 
;comunicador_entre_PIC_PC.c,31 :: 		assist = assistente;
	MOVLW       _assistente+0
	MOVWF       _assist+0 
	MOVLW       hi_addr(_assistente+0)
	MOVWF       _assist+1 
	MOVLW       0
	MOVWF       _assist+2 
	MOVLW       0
	MOVWF       _assist+3 
;comunicador_entre_PIC_PC.c,32 :: 		overflow = 1;// provoco um estouro intencional para cuidar realizar assistencia no buffer
	BSF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;comunicador_entre_PIC_PC.c,33 :: 		}
L_end_servico:
	RETURN      0
; end of _servico

_read:

;comunicador_entre_PIC_PC.c,35 :: 		char read(char *mensagem) //retorna 1 se a mensagem for encontrada e zero caso não
;comunicador_entre_PIC_PC.c,37 :: 		int i = 0;
	CLRF        read_i_L0+0 
	CLRF        read_i_L0+1 
	CLRF        read_j_L0+0 
	CLRF        read_j_L0+1 
;comunicador_entre_PIC_PC.c,39 :: 		for(i += j ; buffer[i] != 0x00; i++)
	MOVF        read_j_L0+0, 0 
	ADDWF       read_i_L0+0, 1 
	MOVF        read_j_L0+1, 0 
	ADDWFC      read_i_L0+1, 1 
L_read4:
	MOVLW       _buffer+0
	ADDWF       read_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      read_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_read5
;comunicador_entre_PIC_PC.c,41 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j ++)
	CLRF        read_j_L0+0 
	CLRF        read_j_L0+1 
L_read7:
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
	GOTO        L_read8
;comunicador_entre_PIC_PC.c,43 :: 		if(mensagem[j] == 0x00)
	MOVF        read_j_L0+0, 0 
	ADDWF       FARG_read_mensagem+0, 0 
	MOVWF       FSR0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      FARG_read_mensagem+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_read10
;comunicador_entre_PIC_PC.c,45 :: 		margeIn = i;
	MOVF        read_i_L0+0, 0 
	MOVWF       _margeIn+0 
	MOVF        read_i_L0+1, 0 
	MOVWF       _margeIn+1 
;comunicador_entre_PIC_PC.c,46 :: 		margeOut = i+j;
	MOVF        read_j_L0+0, 0 
	ADDWF       read_i_L0+0, 0 
	MOVWF       _margeOut+0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      read_i_L0+1, 0 
	MOVWF       _margeOut+1 
;comunicador_entre_PIC_PC.c,47 :: 		servico(servico_limpar_buffer);
	MOVLW       7
	MOVWF       FARG_servico_intent_field+0 
	CALL        _servico+0, 0
;comunicador_entre_PIC_PC.c,50 :: 		}
L_read10:
;comunicador_entre_PIC_PC.c,41 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j ++)
	INFSNZ      read_j_L0+0, 1 
	INCF        read_j_L0+1, 1 
;comunicador_entre_PIC_PC.c,53 :: 		}
	GOTO        L_read7
L_read8:
;comunicador_entre_PIC_PC.c,39 :: 		for(i += j ; buffer[i] != 0x00; i++)
	INFSNZ      read_i_L0+0, 1 
	INCF        read_i_L0+1, 1 
;comunicador_entre_PIC_PC.c,55 :: 		}
	GOTO        L_read4
L_read5:
;comunicador_entre_PIC_PC.c,56 :: 		}
L_end_read:
	RETURN      0
; end of _read

_interrupt_low:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;comunicador_entre_PIC_PC.c,59 :: 		void interrupt_low()
;comunicador_entre_PIC_PC.c,61 :: 		if(overflow) assist();overflow = 0;
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt_low11
	MOVF        _assist+0, 0 
	MOVWF       R0 
	MOVF        _assist+1, 0 
	MOVWF       R1 
	CALL        _____DoIFC+0, 0
L_interrupt_low11:
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;comunicador_entre_PIC_PC.c,63 :: 		} //end interrupt low
L_end_interrupt_low:
L__interrupt_low17:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _interrupt_low

_interrupt:

;comunicador_entre_PIC_PC.c,66 :: 		void interrupt()
;comunicador_entre_PIC_PC.c,68 :: 		buffer[posBuffer] = RC1REG;
	MOVLW       _buffer+0
	ADDWF       _posBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      _posBuffer+1, 0 
	MOVWF       FSR1H 
	MOVF        RC1REG+0, 0 
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,69 :: 		buffer[posBuffer + 1] = 0x00;
	MOVLW       1
	ADDWF       _posBuffer+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _posBuffer+1, 0 
	MOVWF       R1 
	MOVLW       _buffer+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;comunicador_entre_PIC_PC.c,71 :: 		}
L_end_interrupt:
L__interrupt19:
	RETFIE      1
; end of _interrupt

_main:

;comunicador_entre_PIC_PC.c,73 :: 		void main()
;comunicador_entre_PIC_PC.c,78 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
