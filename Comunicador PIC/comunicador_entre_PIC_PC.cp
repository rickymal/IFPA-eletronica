#line 1 "C:/Users/Henrique Mauler/Documents/Programação/C/Trabalhos 2018/PIC18F45K22/Intercomunicador serial - udp/comunicador_entre_PIC_PC.c"







char buffer[ 256 ];
int posBuffer = 0;
int margeIn;
int margeOut;
int tent;
char using_assist = 0;
unsigned char retorno;

void (*assist)();

void assistente()
{
 int x = margeIn;
 int y = margeOut;
 using_assist = 1;

 if(buffer[margeOut] == 0x00)
 for(y; y > x; y--) buffer[y] = 0xFF;
 margeIn = margeOut = using_assist = 0;
}

void servico(char intent_field){
 tent = intent_field;
 assist = assistente;
  TMR0IF_bit  = 1;
}

char read(char *mensagem)
{
int i = 0;
int j = 0;
for(i += j ; buffer[i] != 0x00; i++)
{
 for(j = 0; mensagem[j] == buffer[i+j]; j ++)
 {
 if(mensagem[j] == 0x00)
 {
 margeIn = i;
 margeOut = i+j;
 servico( 7 );


 }


 }

}
}


void interrupt_low()
{
if( TMR0IF_bit ) assist(); TMR0IF_bit  = 0;

}


void interrupt()
{
 buffer[posBuffer] = RC1REG;
 buffer[posBuffer + 1] = 0x00;

}

void main()
{



}
