#line 1 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
#line 13 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
char buffer[ 30 ];
int posBuffer = 0;
int margeIn;
int margeOut;
int tent;
char using_assist = 0;
unsigned short retorno;
char timer4timer , timer6timer;

void (*assist)();
unsigned char valor = 3 absolute 0x0F45;
static char const * const msgTable[];
#line 75 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
char read(char *mensagem)
{
int i;
int j = 0;
for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
{
 for(j = 0; mensagem[j] == buffer[i+j]; j++)
 {
 if(mensagem[j+1] == 0x00)
 {
 margeIn = i;
 margeOut = i+j;
 mensagem[j+1] = 0xFF;

 return 1;
 }
 }
}
return 0;
}

unsigned short loop()
{
 if(read("Enviando"))
 {
 PORTB.RB0 = ~PORTB.RB0;
 return 0;
 }

 if(read("Enviado"))
 {
 PORTB.RB1 = ~PORTB.RB1;
 }
return 0;
}

void interrupt_low()
{
if(timer4timer < 136) asm retfie;
if(timer6timer < 136) asm retfie;
if( TMR6IF_bit ) assist(); TMR6IF_bit  = 0;
}

void interrupt()
{
 buffer[posBuffer] = RC1REG;
 posBuffer++;
 buffer[posBuffer] = 0x00;
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
PIE5.TMR6IE = 1;
PIR5.TMR4IE = 1;
IPR5.TMR6IP = 0;
IPR5.TMR4IP = 0;
TMR6 = 0;
TMR4 = 0;
T6CON = 0b00111001;
T4CON = 0b00111001;
T6CON.TMR6ON = 0;
T6CON.TMR4ON = 0;
delay_ms(10);


for(i = 0; i <  30 ;i++) buffer[i] = 0xFF;
posBuffer = 0;
PORTB = 0x00;
while(1)
{
 retorno = loop();
 if(posBuffer >  3* 30 /2 )
 {
 posBuffer = 0;

 }
 }
}
