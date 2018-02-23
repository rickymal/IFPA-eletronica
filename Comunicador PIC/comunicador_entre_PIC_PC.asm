
_assistente:

;comunicador_entre_PIC_PC.c,24 :: 		void assistente()  //método que realiza a limpeza do buffer, ou melhor, uma mensagem que já foi lida e interpretada
;comunicador_entre_PIC_PC.c,26 :: 		int x = margeIn;
	MOVF        _margeIn+0, 0 
	MOVWF       R1 
	MOVF        _margeIn+1, 0 
	MOVWF       R2 
;comunicador_entre_PIC_PC.c,27 :: 		int y = margeOut;
	MOVF        _margeOut+0, 0 
	MOVWF       R3 
	MOVF        _margeOut+1, 0 
	MOVWF       R4 
;comunicador_entre_PIC_PC.c,28 :: 		using_assist = 1;
	MOVLW       1
	MOVWF       _using_assist+0 
;comunicador_entre_PIC_PC.c,31 :: 		for(y; y > x;  y--) buffer[y] = 0xFF;
L_assistente0:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__assistente25
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__assistente25:
	BTFSC       STATUS+0, 0 
	GOTO        L_assistente1
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
	GOTO        L_assistente0
L_assistente1:
;comunicador_entre_PIC_PC.c,32 :: 		margeIn = margeOut = using_assist = 0;
	CLRF        _using_assist+0 
	CLRF        _margeOut+0 
	CLRF        _margeOut+1 
	CLRF        _margeIn+0 
	CLRF        _margeIn+1 
;comunicador_entre_PIC_PC.c,35 :: 		}
L_end_assistente:
	RETURN      0
; end of _assistente

_servico:

;comunicador_entre_PIC_PC.c,37 :: 		void servico(char intent_field){ //determina o serviço que será utilizado
;comunicador_entre_PIC_PC.c,38 :: 		tent = intent_field;
	MOVF        FARG_servico_intent_field+0, 0 
	MOVWF       _tent+0 
	MOVLW       0
	MOVWF       _tent+1 
;comunicador_entre_PIC_PC.c,39 :: 		assist = assistente;
	MOVLW       _assistente+0
	MOVWF       _assist+0 
	MOVLW       hi_addr(_assistente+0)
	MOVWF       _assist+1 
	MOVLW       0
	MOVWF       _assist+2 
	MOVLW       0
	MOVWF       _assist+3 
;comunicador_entre_PIC_PC.c,41 :: 		if(tent) overflow = 1;// provoco um estouro intencional para cuidar realizar assistencia no buffer
	MOVF        _tent+0, 0 
	IORWF       _tent+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_servico3
	BSF         TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
L_servico3:
;comunicador_entre_PIC_PC.c,43 :: 		}
L_end_servico:
	RETURN      0
; end of _servico

_read:

;comunicador_entre_PIC_PC.c,45 :: 		char read(char *mensagem) //retorna 1 se a mensagem for encontrada e zero caso não (no buffer, no caso)
;comunicador_entre_PIC_PC.c,49 :: 		for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
	CLRF        read_i_L0+0 
	CLRF        read_i_L0+1 
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
;comunicador_entre_PIC_PC.c,51 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j ++)
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
;comunicador_entre_PIC_PC.c,53 :: 		if(mensagem[j] == 0x00)
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
;comunicador_entre_PIC_PC.c,55 :: 		margeIn = i;
	MOVF        read_i_L0+0, 0 
	MOVWF       _margeIn+0 
	MOVF        read_i_L0+1, 0 
	MOVWF       _margeIn+1 
;comunicador_entre_PIC_PC.c,56 :: 		margeOut = i+j;
	MOVF        read_j_L0+0, 0 
	ADDWF       read_i_L0+0, 0 
	MOVWF       _margeOut+0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      read_i_L0+1, 0 
	MOVWF       _margeOut+1 
;comunicador_entre_PIC_PC.c,57 :: 		servico(servico_limpar_buffer);
	MOVLW       1
	MOVWF       FARG_servico_intent_field+0 
	CALL        _servico+0, 0
;comunicador_entre_PIC_PC.c,58 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_read
;comunicador_entre_PIC_PC.c,61 :: 		}
L_read10:
;comunicador_entre_PIC_PC.c,51 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j ++)
	INFSNZ      read_j_L0+0, 1 
	INCF        read_j_L0+1, 1 
;comunicador_entre_PIC_PC.c,64 :: 		}
	GOTO        L_read7
L_read8:
;comunicador_entre_PIC_PC.c,49 :: 		for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
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
;comunicador_entre_PIC_PC.c,66 :: 		}
	GOTO        L_read4
L_read5:
;comunicador_entre_PIC_PC.c,67 :: 		return 0;
	CLRF        R0 
;comunicador_entre_PIC_PC.c,68 :: 		}
L_end_read:
	RETURN      0
; end of _read

_loop:

;comunicador_entre_PIC_PC.c,70 :: 		unsigned char loop()
;comunicador_entre_PIC_PC.c,72 :: 		if(read("CELL:AcenderLED"))
	MOVLW       ?lstr1_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr1_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop11
;comunicador_entre_PIC_PC.c,74 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;comunicador_entre_PIC_PC.c,75 :: 		PORTB = 0xFF;
	MOVLW       255
	MOVWF       PORTB+0 
;comunicador_entre_PIC_PC.c,76 :: 		}
L_loop11:
;comunicador_entre_PIC_PC.c,79 :: 		if(read("CELL:ApagarLED"))
	MOVLW       ?lstr2_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr2_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop12
;comunicador_entre_PIC_PC.c,81 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;comunicador_entre_PIC_PC.c,83 :: 		}
L_loop12:
;comunicador_entre_PIC_PC.c,88 :: 		return 0;
	CLRF        R0 
;comunicador_entre_PIC_PC.c,89 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_interrupt_low:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;comunicador_entre_PIC_PC.c,92 :: 		void interrupt_low()  //a interrupção de baixa prioridade que chamará os serviços
;comunicador_entre_PIC_PC.c,94 :: 		if(timer4timer < 136) asm retfie;
	MOVLW       136
	SUBWF       _timer4timer+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt_low13
	RETFIE      0
L_interrupt_low13:
;comunicador_entre_PIC_PC.c,95 :: 		if(timer6timer < 136) asm retfie;
	MOVLW       136
	SUBWF       _timer6timer+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt_low14
	RETFIE      0
L_interrupt_low14:
;comunicador_entre_PIC_PC.c,97 :: 		if(overflow) assist();overflow = 0;
	BTFSS       TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
	GOTO        L_interrupt_low15
	MOVF        _assist+0, 0 
	MOVWF       R0 
	MOVF        _assist+1, 0 
	MOVWF       R1 
	CALL        _____DoIFC+0, 0
L_interrupt_low15:
	BCF         TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
;comunicador_entre_PIC_PC.c,99 :: 		} //end interrupt low
L_end_interrupt_low:
L__interrupt_low30:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _interrupt_low

_interrupt:

;comunicador_entre_PIC_PC.c,102 :: 		void interrupt() //a interrupção de alta prioridade apenas armazenará os dados recebidos (no momento apenas do computador)
;comunicador_entre_PIC_PC.c,105 :: 		buffer[posBuffer] = RC1REG;
	MOVLW       _buffer+0
	ADDWF       _posBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      _posBuffer+1, 0 
	MOVWF       FSR1H 
	MOVF        RC1REG+0, 0 
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,106 :: 		posBuffer++;
	INFSNZ      _posBuffer+0, 1 
	INCF        _posBuffer+1, 1 
;comunicador_entre_PIC_PC.c,107 :: 		buffer[posBuffer] = 0x00;
	MOVLW       _buffer+0
	ADDWF       _posBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      _posBuffer+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;comunicador_entre_PIC_PC.c,109 :: 		}
L_end_interrupt:
L__interrupt32:
	RETFIE      1
; end of _interrupt

_main:

;comunicador_entre_PIC_PC.c,111 :: 		void main()
;comunicador_entre_PIC_PC.c,124 :: 		TXSTA2.BRGH = 1; //Desabilita o Intenso Baundrate
	BSF         TXSTA2+0, 2 
;comunicador_entre_PIC_PC.c,125 :: 		BAUDCON2.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado,e descarta o SPBRGH1 quando esta em zero)
	BSF         BAUDCON2+0, 3 
;comunicador_entre_PIC_PC.c,126 :: 		SPBRGH2 = 0x00;
	CLRF        SPBRGH2+0 
;comunicador_entre_PIC_PC.c,127 :: 		SPBRG2 = 0x45; //baundrate configurado para (utilizando uma frequencia de aproxidamente 35MHz);
	MOVLW       69
	MOVWF       SPBRG2+0 
;comunicador_entre_PIC_PC.c,131 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;comunicador_entre_PIC_PC.c,132 :: 		TRISC = 0xFF; //os dois registradores acima possuem pinos referentes ao EUSART1 e EUSART2, respectivamente e devem ser setados como saída
	MOVLW       255
	MOVWF       TRISC+0 
;comunicador_entre_PIC_PC.c,133 :: 		TRISD = 0xFF;
	MOVLW       255
	MOVWF       TRISD+0 
;comunicador_entre_PIC_PC.c,145 :: 		TXSTA2.SYNC = 0;  //modo assincrono
	BCF         TXSTA2+0, 4 
;comunicador_entre_PIC_PC.c,146 :: 		RCSTA2.SPEN = 1;  //liga a eusart
	BSF         RCSTA2+0, 7 
;comunicador_entre_PIC_PC.c,147 :: 		TXSTA2.TXEN = 1;  //liga o circuito transmissor
	BSF         TXSTA2+0, 5 
;comunicador_entre_PIC_PC.c,148 :: 		TX2IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
	BCF         TX2IE_bit+0, BitPos(TX2IE_bit+0) 
;comunicador_entre_PIC_PC.c,149 :: 		ANSELD = 0x00;    //Os registrador Analogico-Digital devem estar desabilitado para que a comunicação funcione (ANSELB para o EUSART1 e ANSELC para EUSART2
	CLRF        ANSELD+0 
;comunicador_entre_PIC_PC.c,160 :: 		RCSTA2.CREN = 1; //similar ao spen. Habilita o circuito
	BSF         RCSTA2+0, 4 
;comunicador_entre_PIC_PC.c,163 :: 		while(PIR3.RC2IF) {RCREG2;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.
L_main16:
	BTFSS       PIR3+0, 5 
	GOTO        L_main17
	GOTO        L_main16
L_main17:
;comunicador_entre_PIC_PC.c,168 :: 		INTCON.GIE = 0x01;  //habilita a interrupção global
	BSF         INTCON+0, 7 
;comunicador_entre_PIC_PC.c,169 :: 		INTCON.PEIE = 0x01; //habilita a interrupção por periférico
	BSF         INTCON+0, 6 
;comunicador_entre_PIC_PC.c,170 :: 		RCON.IPEN = 0x01; //interrupção por prioridades habilitado (significa que poderá haver interrupção de alto nível e baixo nível no programa)
	BSF         RCON+0, 7 
;comunicador_entre_PIC_PC.c,181 :: 		IPR3.RC2IP = 0x01;         //recepção de dados (RX) possui interrupção de alta prioridade
	BSF         IPR3+0, 5 
;comunicador_entre_PIC_PC.c,182 :: 		IPR3.TX2IP = 0x01;         //tranmissao possui interrupção de alta prioridade
	BSF         IPR3+0, 4 
;comunicador_entre_PIC_PC.c,183 :: 		PIR3.TX2IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
	BCF         PIR3+0, 4 
;comunicador_entre_PIC_PC.c,184 :: 		PIE3.TX2IE = 0x00;            //desabilita interrupção por tx
	BCF         PIE3+0, 4 
;comunicador_entre_PIC_PC.c,185 :: 		PIR3.RC2IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
	BCF         PIR3+0, 5 
;comunicador_entre_PIC_PC.c,186 :: 		PIE3.RC2IE = 0x01;            // habilita a interrpção por rx
	BSF         PIE3+0, 5 
;comunicador_entre_PIC_PC.c,189 :: 		PIR5.TMR6IF = 0;
	BCF         PIR5+0, 2 
;comunicador_entre_PIC_PC.c,190 :: 		PIR5.TMR4IF = 0;
	BCF         PIR5+0, 0 
;comunicador_entre_PIC_PC.c,191 :: 		PIE5.TMR6IE = 1;
	BSF         PIE5+0, 2 
;comunicador_entre_PIC_PC.c,192 :: 		PIR5.TMR4IE = 1;
	BSF         PIR5+0, 0 
;comunicador_entre_PIC_PC.c,193 :: 		IPR5.TMR6IP = 0;
	BCF         IPR5+0, 2 
;comunicador_entre_PIC_PC.c,194 :: 		IPR5.TMR4IP = 0;
	BCF         IPR5+0, 0 
;comunicador_entre_PIC_PC.c,195 :: 		TMR6 = 0;
	CLRF        TMR6+0 
;comunicador_entre_PIC_PC.c,196 :: 		TMR4 = 0;
	CLRF        TMR4+0 
;comunicador_entre_PIC_PC.c,197 :: 		T6CON = 0b00111001; //os valores do timer ainda devem ser ajustados corretamente
	MOVLW       57
	MOVWF       T6CON+0 
;comunicador_entre_PIC_PC.c,198 :: 		T4CON = 0b00111001; //define um tempo para 10 ms (pode estar errao por hora) considerando uma entrada de 136 vezes na interrupção  e uma frequencia d 31MHz
	MOVLW       57
	MOVWF       T4CON+0 
;comunicador_entre_PIC_PC.c,199 :: 		T6CON.TMR6ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,200 :: 		T6CON.TMR4ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,205 :: 		for(i = 0; i < tamanhoBuffer;i++) buffer[i] = 0xFF;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main18:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVLW       0
	SUBWF       main_i_L0+0, 0 
L__main34:
	BTFSC       STATUS+0, 0 
	GOTO        L_main19
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
	GOTO        L_main18
L_main19:
;comunicador_entre_PIC_PC.c,208 :: 		while(1)
L_main21:
;comunicador_entre_PIC_PC.c,210 :: 		retorno = loop();
	CALL        _loop+0, 0
	MOVF        R0, 0 
	MOVWF       _retorno+0 
;comunicador_entre_PIC_PC.c,212 :: 		if(posBuffer > offset)
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       _posBuffer+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main35
	MOVF        _posBuffer+0, 0 
	SUBLW       128
L__main35:
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
;comunicador_entre_PIC_PC.c,214 :: 		posBuffer = 0;
	CLRF        _posBuffer+0 
	CLRF        _posBuffer+1 
;comunicador_entre_PIC_PC.c,216 :: 		}
L_main23:
;comunicador_entre_PIC_PC.c,219 :: 		}
	GOTO        L_main21
;comunicador_entre_PIC_PC.c,225 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
