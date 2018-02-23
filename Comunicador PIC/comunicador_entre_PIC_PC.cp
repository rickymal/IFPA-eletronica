#line 1 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
#line 12 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
char buffer[ 256 ];
int posBuffer = 0;
int margeIn;
int margeOut;
int tent;
char using_assist = 0;
unsigned char retorno;
char timer4timer , timer6timer;

void (*assist)();

void limpaBuffer()
{
 int x = margeIn;
 int y = margeOut;
 using_assist = 1;
 for(y; y > x; y--) buffer[y] = 0xFF;
 margeIn = margeOut = using_assist = 0;

}

void servico(char intent_field){
 tent = intent_field;
 assist = limpaBuffer;
 if(tent)  TMR6IF_bit  = 1;
}


void setTime(sfr unsigned short volatile *timer, double tempo_seg, double frequencia)
{
int Tof;
int Tmof;
int i = 30;
int resposta[30];
int prescaler = 1;
int postscaler = 1;
Tof = 256*frequencia/4;
Tmof = tempo_seg/Tof;


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

 T6CON = prescaler << 6;
 T6CON += postscaler;
 TMR6 = 0;
 timer6timer = Tmof / (prescaler + postscaler);
 return ;
 }
}

char read(char *mensagem)
{
int i;
int j;
for(i = 0 ; buffer[i] != 0x00; i+= 1 + j)
{
 for(j = 0; mensagem[j] == buffer[i+j]; j ++)
 {
 if(mensagem[j] == 0x00)
 {
 margeIn = i;
 margeOut = i+j;
 servico( 1 );
 return 1;
 }
 }
}
return 0;
}

unsigned char loop()
{
 if(read("CELL:AcenderLED"))
 {
 TRISB = 0x00;
 PORTB = 0xFF;
 }

 if(read("CELL:ApagarLED"))
 {
 PORTB = 0x00;
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
#line 139 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
TXSTA2.BRGH = 1;
BAUDCON2.BRG16 = 1;
SPBRGH2 = 0x00;
SPBRG2 = 0x45;



TRISB = 0xFF;
TRISC = 0xFF;
TRISD = 0xFF;
#line 160 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
TXSTA2.SYNC = 0;
RCSTA2.SPEN = 1;
TXSTA2.TXEN = 1;
TX2IE_bit = 0;
ANSELD = 0x00;
#line 175 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
RCSTA2.CREN = 1;


while(PIR3.RC2IF) {RCREG2;}




INTCON.GIE = 0x01;
INTCON.PEIE = 0x01;
RCON.IPEN = 0x01;
#line 196 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/Conectando Celular e Minecraft/Comunicador PIC/comunicador_entre_PIC_PC.c"
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


for(i = 0; i <  256 ;i++) buffer[i] = 0xFF;
while(1)
{
 retorno = loop();
 if(posBuffer >  3* 256 /2 )
 {
 posBuffer = 0;

 }
 }
}
