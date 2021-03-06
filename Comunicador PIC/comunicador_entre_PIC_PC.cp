#line 1 "C:/Users/Henrique Mauler/Documents/Programa��o/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
#line 24 "C:/Users/Henrique Mauler/Documents/Programa��o/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
register char bufferPc[ 60 ];
register char bufferModulo[ 60 ];
volatile int posBufferPc = 0;
volatile int posBufferModulo = 0;
unsigned short retorno;
unsigned char timer4timer , timer6timer;
unsigned int lastPos;
unsigned int margeIn,margeOut = 0;
#pragma pack(2)
#line 36 "C:/Users/Henrique Mauler/Documents/Programa��o/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
struct flags
{
unsigned short flag1 : 1;
unsigned short : 1;
unsigned short flag2 : 4;
struct flags (*find)(void);
};
typedef struct flags filesys;
filesys bandeira;




void setTime(sfr unsigned short volatile *timer, double tempo_seg, double frequencia)
{
int prescaler = 1;
int postscaler = 1;
int Tmof = (int)(tempo_seg/(256*(frequencia*1000)/4));
for(postscaler = 3; postscaler > 0; postscaler--)
{
 for(prescaler = 16; prescaler > 0; prescaler--)
 {
 if(Tmof%(prescaler*postscaler) == 0) goto LABEL;
 }
}
LABEL:
 if(timer == &TMR6)
 {
 T6CON = 0x00;
 T6CON = prescaler << 6;
 T6CON += postscaler;
 TMR6 = 0;
 timer6timer = Tmof / (prescaler + postscaler);
 return ;
 }
}



char read(char *mensagem, unsigned char *buf)
{
int i;
int j = 0;
for(i = 0 ; buf[i] != 0x00; i+= 1 + j)
{
 for(j = 0; mensagem[j] == buf[i+j]; j++)
 {
 if(mensagem[j+1] == 0x00)
 {
 margeIn = i;
 margeOut = i+j;
 buf[margeOut] = buf[margeIn] = 0xFF;
 return 1;
 }
 }
}
return 0;
}




void escrever(char paraQuem, char *mensagem)
{
 int i;
 sfr unsigned short volatile *regSend;
 if(paraQuem = 'p') regSend = &TXREG1;
 else regSend = &TXREG2;
 for(i = 0; mensagem[i] != 0x00; i++)
 {
 *regSend = mensagem[i];
 delay_ms(1);
 }
 *regSend = '\n';
}

unsigned short loop()
{

 if(read("relatorio",bufferPc)) 
{
 escrever('p', "Autor: Henrique Mauler Borges");
 escrever('p', "Curso t�cnico em eletr�nica");
 return 0;
}

 if(read("Qual a sua frequencia?",bufferPc)) 
{
 char saidaclock[10];
 unsigned short clock = Clock_MHz();
 escrever('p', "A frequencia de trabalho �: ");
 escrever('p', saidaclock);
 return 0;
}

 if(read("invadido",bufferPc)) 
{
 escrever('m',"invasao");
 return 0;
}


 if(read("Me responda micro!",bufferPc)) 
{
 TRISB = 0x00;
 PORTB = 0xFF;
 delay_ms(2000);
 PORTB = 0x00;
 delay_ms(20000);
 PORTB = 0xFF;
 escrever('p',"valor2");
 return 0;


}

 if(read("BlocoEnergizado:8:Intensidade:15",bufferPc)) 
{
 escrever('m',"Invadido");
}
else  if(read("BlocoEnergizado:10:Intensidade:15",bufferPc)) 
{
 escrever('m',"Horario:dia");
}
else  if(read("BlocoEnergizado:10:Intensidade:1",bufferPc)) 
{
 escrever('m',"Horario:noite");
}







 if(read("LED1",bufferModulo))  escrever('p',"valor2");
else  if(read("LED2",bufferModulo))  escrever('p',"valor3");
else  if(read("LED3",bufferModulo))  escrever('p',"valor4");
else  if(read("LED4",bufferModulo))  escrever('p',"valor5");
 return 1;





}

void interrupt()
{
 if(RC1IF_bit)
 {
 bufferPc[posBufferPc] = RC1REG;
 posBufferPc++;
 bufferPc[posBufferPc] = 0x00;
 }
 else if(RC2IF_bit)
 {

 bufferModulo[posBufferModulo] = RC2REG;
 posBufferModulo++;
 bufferModulo[posBufferModulo] = 0x00;
 }
 T6CON.TMR6ON = 1;
 TMR6 = 0;
}

void main()
{
int i;



TXSTA1.BRGH = 1;
BAUDCON1.BRG16 = 1;
SPBRGH1 = 0x00;
SPBRG1 = 0x41;

TXSTA2.BRGH = 1;
BAUDCON2.BRG16 = 1;
SPBRGH2 = 0x00;
SPBRG2 = 0x45;


TRISB = 0x00;
TRISC = 0xFF;
TRISD = 0xFF;
PORTB = 0x00;


TXSTA1.SYNC = 0;
RCSTA1.SPEN = 1;
TXSTA1.TXEN = 1;
TX1IE_bit = 0;
ANSELB = 0x00;
ANSELC = 0x00;

TXSTA2.SYNC = 0;
RCSTA2.SPEN = 1;
TXSTA2.TXEN = 1;
TX2IE_bit = 0;
ANSELD = 0x00;



RCSTA1.CREN = 1;


while(PIR1.RC1IF) {RCREG1;}

RCSTA2.CREN = 1;


while(PIR3.RC2IF) {RCREG2;}



INTCON.GIE = 0x01;
INTCON.PEIE = 0x01;
RCON.IPEN = 0x01;

IPR1.RC1IP = 0x01;
IPR1.TX1IP = 0x01;
PIR1.TX1IF = 0x00;
PIE1.TX1IE = 0x00;
PIR1.RC1IF = 0x00;
PIE1.RC1IE = 0x01;

IPR3.RC2IP = 0x01;
IPR3.TX2IP = 0x01;
PIR3.TX2IF = 0x00;
PIE3.TX2IE = 0x00;
PIR3.RC2IF = 0x00;
PIE3.RC2IE = 0x01;


PIR5.TMR6IF = 0;
PIR5.TMR4IF = 0;
IPR5.TMR6IP = 0;
IPR5.TMR4IP = 0;
TMR6 = 0;
TMR4 = 0;
T6CON = 0b01111011;
T4CON = 0b00111001;
T6CON.TMR6ON = 0;
T6CON.TMR4ON = 0;



for(i = 0; i <  60 ;i++) bufferPc[i] = bufferModulo[i] = 0xFF;



posBufferPc = 0;
posBufferModulo = 0;
PORTB = 0x00;
while(1)
{
 retorno = loop();

 if(PIR5.TMR6IF)
 {
 PIR5.TMR6IF = 0;
 T6CON.TMR6ON = 0;
 if(posBufferPc >  2* 60 /3  + 5)
 {
 posBufferPc = 0;
 }
 if(posBufferModulo >  2* 60 /3 )
 {
 posBufferModulo = 0;
 }
 }
 }
}
