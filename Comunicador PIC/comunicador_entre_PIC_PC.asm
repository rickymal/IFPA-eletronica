
_read:

;comunicador_entre_PIC_PC.c,75 :: 		char read(char *mensagem) //retorna 1 se a mensagem for encontrada e zero caso não (no buffer, no caso)
;comunicador_entre_PIC_PC.c,78 :: 		int j = 0;
	CLRF        read_j_L0+0 
	CLRF        read_j_L0+1 
;comunicador_entre_PIC_PC.c,79 :: 		for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
	CLRF        R2 
	CLRF        R3 
L_read0:
	MOVLW       _buffer+0
	ADDWF       R2, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_read1
;comunicador_entre_PIC_PC.c,81 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j++)
	CLRF        read_j_L0+0 
	CLRF        read_j_L0+1 
L_read3:
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
	MOVLW       _buffer+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_read4
;comunicador_entre_PIC_PC.c,83 :: 		if(mensagem[j+1] == 0x00)
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
	GOTO        L_read6
;comunicador_entre_PIC_PC.c,85 :: 		margeIn = i;
	MOVF        R2, 0 
	MOVWF       _margeIn+0 
	MOVF        R3, 0 
	MOVWF       _margeIn+1 
;comunicador_entre_PIC_PC.c,86 :: 		margeOut = i+j;
	MOVF        read_j_L0+0, 0 
	ADDWF       R2, 0 
	MOVWF       _margeOut+0 
	MOVF        read_j_L0+1, 0 
	ADDWFC      R3, 0 
	MOVWF       _margeOut+1 
;comunicador_entre_PIC_PC.c,87 :: 		mensagem[j+1] = 0xFF;
	MOVLW       1
	ADDWF       read_j_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      read_j_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_read_mensagem+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FARG_read_mensagem+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,89 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_read
;comunicador_entre_PIC_PC.c,90 :: 		}
L_read6:
;comunicador_entre_PIC_PC.c,81 :: 		for(j = 0; mensagem[j] == buffer[i+j]; j++)
	INFSNZ      read_j_L0+0, 1 
	INCF        read_j_L0+1, 1 
;comunicador_entre_PIC_PC.c,91 :: 		}
	GOTO        L_read3
L_read4:
;comunicador_entre_PIC_PC.c,79 :: 		for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
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
;comunicador_entre_PIC_PC.c,92 :: 		}
	GOTO        L_read0
L_read1:
;comunicador_entre_PIC_PC.c,93 :: 		return 0;
	CLRF        R0 
;comunicador_entre_PIC_PC.c,94 :: 		}
L_end_read:
	RETURN      0
; end of _read

_loop:

;comunicador_entre_PIC_PC.c,96 :: 		unsigned short loop()
;comunicador_entre_PIC_PC.c,98 :: 		if(read("Enviando"))
	MOVLW       ?lstr1_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr1_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop7
;comunicador_entre_PIC_PC.c,100 :: 		PORTB.RB0 = ~PORTB.RB0;
	BTG         PORTB+0, 0 
;comunicador_entre_PIC_PC.c,101 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_loop
;comunicador_entre_PIC_PC.c,102 :: 		}
L_loop7:
;comunicador_entre_PIC_PC.c,104 :: 		if(read("Enviado"))
	MOVLW       ?lstr2_comunicador_entre_PIC_PC+0
	MOVWF       FARG_read_mensagem+0 
	MOVLW       hi_addr(?lstr2_comunicador_entre_PIC_PC+0)
	MOVWF       FARG_read_mensagem+1 
	CALL        _read+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_loop8
;comunicador_entre_PIC_PC.c,106 :: 		PORTB.RB1 = ~PORTB.RB1;
	BTG         PORTB+0, 1 
;comunicador_entre_PIC_PC.c,107 :: 		}
L_loop8:
;comunicador_entre_PIC_PC.c,108 :: 		return 0;
	CLRF        R0 
;comunicador_entre_PIC_PC.c,109 :: 		}
L_end_loop:
	RETURN      0
; end of _loop

_interrupt_low:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;comunicador_entre_PIC_PC.c,111 :: 		void interrupt_low()  //a interrupção de baixa prioridade que chamará os serviços
;comunicador_entre_PIC_PC.c,113 :: 		if(timer4timer < 136) asm retfie;
	MOVLW       136
	SUBWF       _timer4timer+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt_low9
	RETFIE      0
L_interrupt_low9:
;comunicador_entre_PIC_PC.c,114 :: 		if(timer6timer < 136) asm retfie;
	MOVLW       136
	SUBWF       _timer6timer+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt_low10
	RETFIE      0
L_interrupt_low10:
;comunicador_entre_PIC_PC.c,115 :: 		if(overflow) assist();overflow = 0;
	BTFSS       TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
	GOTO        L_interrupt_low11
	MOVF        _assist+0, 0 
	MOVWF       R0 
	MOVF        _assist+1, 0 
	MOVWF       R1 
	CALL        _____DoIFC+0, 0
L_interrupt_low11:
	BCF         TMR6IF_bit+0, BitPos(TMR6IF_bit+0) 
;comunicador_entre_PIC_PC.c,116 :: 		} //end interrupt low
L_end_interrupt_low:
L__interrupt_low26:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _interrupt_low

_interrupt:

;comunicador_entre_PIC_PC.c,118 :: 		void interrupt() //a interrupção de alta prioridade apenas armazenará os dados recebidos (no momento apenas do computador)
;comunicador_entre_PIC_PC.c,120 :: 		buffer[posBuffer] = RC1REG;
	MOVLW       _buffer+0
	ADDWF       _posBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      _posBuffer+1, 0 
	MOVWF       FSR1H 
	MOVF        RC1REG+0, 0 
	MOVWF       POSTINC1+0 
;comunicador_entre_PIC_PC.c,121 :: 		posBuffer++;
	INFSNZ      _posBuffer+0, 1 
	INCF        _posBuffer+1, 1 
;comunicador_entre_PIC_PC.c,122 :: 		buffer[posBuffer] = 0x00;
	MOVLW       _buffer+0
	ADDWF       _posBuffer+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	ADDWFC      _posBuffer+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;comunicador_entre_PIC_PC.c,123 :: 		}
L_end_interrupt:
L__interrupt28:
	RETFIE      1
; end of _interrupt

_main:

;comunicador_entre_PIC_PC.c,125 :: 		void main()
;comunicador_entre_PIC_PC.c,130 :: 		TXSTA1.BRGH = 1; //Habilita o Intenso Baundrate (usa dois registradores para realiar a contagem de bits por segundo)
	BSF         TXSTA1+0, 2 
;comunicador_entre_PIC_PC.c,131 :: 		BAUDCON1.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado caso esteja em um,e descarta o SPBRGH1 quando esta em zero)
	BSF         BAUDCON1+0, 3 
;comunicador_entre_PIC_PC.c,132 :: 		SPBRGH1 = 0x00;
	CLRF        SPBRGH1+0 
;comunicador_entre_PIC_PC.c,133 :: 		SPBRG1 = 0x41; //baundrate configurado para 115200 (utilizando uma frequencia de aproxidamente 35MHz);
	MOVLW       65
	MOVWF       SPBRG1+0 
;comunicador_entre_PIC_PC.c,135 :: 		TXSTA2.BRGH = 1; //Desabilita o Intenso Baundrate
	BSF         TXSTA2+0, 2 
;comunicador_entre_PIC_PC.c,136 :: 		BAUDCON2.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado,e descarta o SPBRGH1 quando esta em zero)
	BSF         BAUDCON2+0, 3 
;comunicador_entre_PIC_PC.c,137 :: 		SPBRGH2 = 0x00;
	CLRF        SPBRGH2+0 
;comunicador_entre_PIC_PC.c,138 :: 		SPBRG2 = 0x45; //baundrate configurado para (utilizando uma frequencia de aproxidamente 35MHz);
	MOVLW       69
	MOVWF       SPBRG2+0 
;comunicador_entre_PIC_PC.c,141 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;comunicador_entre_PIC_PC.c,142 :: 		TRISC = 0xFF; //os dois registradores acima possuem pinos referentes ao EUSART1 e EUSART2, respectivamente e devem ser setados como saída
	MOVLW       255
	MOVWF       TRISC+0 
;comunicador_entre_PIC_PC.c,143 :: 		TRISD = 0xFF;
	MOVLW       255
	MOVWF       TRISD+0 
;comunicador_entre_PIC_PC.c,144 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;comunicador_entre_PIC_PC.c,147 :: 		TXSTA1.SYNC = 0;  //modo assincrono
	BCF         TXSTA1+0, 4 
;comunicador_entre_PIC_PC.c,148 :: 		RCSTA1.SPEN = 1;  //liga a eusart
	BSF         RCSTA1+0, 7 
;comunicador_entre_PIC_PC.c,149 :: 		TXSTA1.TXEN = 1;  //liga o circuito transmissor
	BSF         TXSTA1+0, 5 
;comunicador_entre_PIC_PC.c,150 :: 		TX1IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
	BCF         TX1IE_bit+0, BitPos(TX1IE_bit+0) 
;comunicador_entre_PIC_PC.c,151 :: 		ANSELB = 0x00;
	CLRF        ANSELB+0 
;comunicador_entre_PIC_PC.c,152 :: 		ANSELC = 0x00;
	CLRF        ANSELC+0 
;comunicador_entre_PIC_PC.c,154 :: 		TXSTA2.SYNC = 0;  //modo assincrono
	BCF         TXSTA2+0, 4 
;comunicador_entre_PIC_PC.c,155 :: 		RCSTA2.SPEN = 1;  //liga a eusart
	BSF         RCSTA2+0, 7 
;comunicador_entre_PIC_PC.c,156 :: 		TXSTA2.TXEN = 1;  //liga o circuito transmissor
	BSF         TXSTA2+0, 5 
;comunicador_entre_PIC_PC.c,157 :: 		TX2IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
	BCF         TX2IE_bit+0, BitPos(TX2IE_bit+0) 
;comunicador_entre_PIC_PC.c,158 :: 		ANSELD = 0x00;    //Os registrador Analogico-Digital devem estar desabilitado para que a comunicação funcione (ANSELB para o EUSART1 e ANSELC para EUSART2
	CLRF        ANSELD+0 
;comunicador_entre_PIC_PC.c,162 :: 		RCSTA1.CREN = 1; //similar ao spen. Habilita o circuito
	BSF         RCSTA1+0, 4 
;comunicador_entre_PIC_PC.c,165 :: 		while(PIR1.RC1IF) {RCREG1;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.
L_main12:
	BTFSS       PIR1+0, 5 
	GOTO        L_main13
	GOTO        L_main12
L_main13:
;comunicador_entre_PIC_PC.c,167 :: 		RCSTA2.CREN = 1; //similar ao spen. Habilita o circuito
	BSF         RCSTA2+0, 4 
;comunicador_entre_PIC_PC.c,170 :: 		while(PIR3.RC2IF) {RCREG2;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.
L_main14:
	BTFSS       PIR3+0, 5 
	GOTO        L_main15
	GOTO        L_main14
L_main15:
;comunicador_entre_PIC_PC.c,174 :: 		INTCON.GIE = 0x01;  //habilita a interrupção global
	BSF         INTCON+0, 7 
;comunicador_entre_PIC_PC.c,175 :: 		INTCON.PEIE = 0x01; //habilita a interrupção por periférico
	BSF         INTCON+0, 6 
;comunicador_entre_PIC_PC.c,176 :: 		RCON.IPEN = 0x01; //interrupção por prioridades habilitado (significa que poderá haver interrupção de alto nível e baixo nível no programa)
	BSF         RCON+0, 7 
;comunicador_entre_PIC_PC.c,178 :: 		IPR1.RC1IP = 0x01;         //recepção de dados (RX) possui interrupção de baixa prioridade
	BSF         IPR1+0, 5 
;comunicador_entre_PIC_PC.c,179 :: 		IPR1.TX1IP = 0x01;         //tranmissao possui interrupção de baixa prioridade
	BSF         IPR1+0, 4 
;comunicador_entre_PIC_PC.c,180 :: 		PIR1.TX1IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
	BCF         PIR1+0, 4 
;comunicador_entre_PIC_PC.c,181 :: 		PIE1.TX1IE = 0x00;            //desabilita interrupção por tx
	BCF         PIE1+0, 4 
;comunicador_entre_PIC_PC.c,182 :: 		PIR1.RC1IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
	BCF         PIR1+0, 5 
;comunicador_entre_PIC_PC.c,183 :: 		PIE1.RC1IE = 0x01;            // habilita a interrpção por rx
	BSF         PIE1+0, 5 
;comunicador_entre_PIC_PC.c,185 :: 		IPR3.RC2IP = 0x01;         //recepção de dados (RX) possui interrupção de alta prioridade
	BSF         IPR3+0, 5 
;comunicador_entre_PIC_PC.c,186 :: 		IPR3.TX2IP = 0x01;         //tranmissao possui interrupção de alta prioridade
	BSF         IPR3+0, 4 
;comunicador_entre_PIC_PC.c,187 :: 		PIR3.TX2IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
	BCF         PIR3+0, 4 
;comunicador_entre_PIC_PC.c,188 :: 		PIE3.TX2IE = 0x00;            //desabilita interrupção por tx
	BCF         PIE3+0, 4 
;comunicador_entre_PIC_PC.c,189 :: 		PIR3.RC2IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
	BCF         PIR3+0, 5 
;comunicador_entre_PIC_PC.c,190 :: 		PIE3.RC2IE = 0x01;            // habilita a interrpção por rx
	BSF         PIE3+0, 5 
;comunicador_entre_PIC_PC.c,193 :: 		PIR5.TMR6IF = 0;
	BCF         PIR5+0, 2 
;comunicador_entre_PIC_PC.c,194 :: 		PIR5.TMR4IF = 0;
	BCF         PIR5+0, 0 
;comunicador_entre_PIC_PC.c,195 :: 		PIE5.TMR6IE = 1;
	BSF         PIE5+0, 2 
;comunicador_entre_PIC_PC.c,196 :: 		PIR5.TMR4IE = 1;
	BSF         PIR5+0, 0 
;comunicador_entre_PIC_PC.c,197 :: 		IPR5.TMR6IP = 0;
	BCF         IPR5+0, 2 
;comunicador_entre_PIC_PC.c,198 :: 		IPR5.TMR4IP = 0;
	BCF         IPR5+0, 0 
;comunicador_entre_PIC_PC.c,199 :: 		TMR6 = 0;
	CLRF        TMR6+0 
;comunicador_entre_PIC_PC.c,200 :: 		TMR4 = 0;
	CLRF        TMR4+0 
;comunicador_entre_PIC_PC.c,201 :: 		T6CON = 0b00111001; //os valores do timer ainda devem ser ajustados corretamente
	MOVLW       57
	MOVWF       T6CON+0 
;comunicador_entre_PIC_PC.c,202 :: 		T4CON = 0b00111001; //define um tempo para 10 ms (pode estar errao por hora) considerando uma entrada de 136 vezes na interrupção  e uma frequencia d 31MHz
	MOVLW       57
	MOVWF       T4CON+0 
;comunicador_entre_PIC_PC.c,203 :: 		T6CON.TMR6ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,204 :: 		T6CON.TMR4ON = 0;
	BCF         T6CON+0, 2 
;comunicador_entre_PIC_PC.c,205 :: 		delay_ms(10);
	MOVLW       101
	MOVWF       R12, 0
	MOVLW       165
	MOVWF       R13, 0
L_main16:
	DECFSZ      R13, 1, 1
	BRA         L_main16
	DECFSZ      R12, 1, 1
	BRA         L_main16
;comunicador_entre_PIC_PC.c,208 :: 		for(i = 0; i < tamanhoBuffer;i++) buffer[i] = 0xFF;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main17:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main30
	MOVLW       30
	SUBWF       main_i_L0+0, 0 
L__main30:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
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
	GOTO        L_main17
L_main18:
;comunicador_entre_PIC_PC.c,209 :: 		posBuffer = 0;
	CLRF        _posBuffer+0 
	CLRF        _posBuffer+1 
;comunicador_entre_PIC_PC.c,210 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;comunicador_entre_PIC_PC.c,211 :: 		while(1)
L_main20:
;comunicador_entre_PIC_PC.c,213 :: 		retorno = loop();
	CALL        _loop+0, 0
	MOVF        R0, 0 
	MOVWF       _retorno+0 
;comunicador_entre_PIC_PC.c,214 :: 		if(posBuffer > offset)   //chance de corrupção de dados
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _posBuffer+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVF        _posBuffer+0, 0 
	SUBLW       45
L__main31:
	BTFSC       STATUS+0, 0 
	GOTO        L_main22
;comunicador_entre_PIC_PC.c,216 :: 		posBuffer = 0;
	CLRF        _posBuffer+0 
	CLRF        _posBuffer+1 
;comunicador_entre_PIC_PC.c,218 :: 		}
L_main22:
;comunicador_entre_PIC_PC.c,219 :: 		}
	GOTO        L_main20
;comunicador_entre_PIC_PC.c,220 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
