#define tamanhoBuffer 60
#define offset 2*tamanhoBuffer/3
#define servico_limpar_buffer 1
#define servico_reiniciar_buffer 0
#define overflow TMR6IF_bit
#define bgtile (char*) 0x0F45
//#include <stdarg.h>

        //variaveis não utilizada
//typedef int (*entradaParaFunc)();
//void (*assist)();                                                                         //determina um ponteiro d efunção que dirá o que será feito na assistência (atualmente só existe um comando, porém terá implementações)
//unsigned char valor = 3 absolute 0x0F45;
//static char const * const msgTable[];
//typedef char BBuffer[tamanhoBuffer];   //cria uma variavel do tipo "BBuffer" (que na verdade é um char de tamanho 'tamanhoBuffer'
//register BBuffer cache;
//BBuffer *pCache; // ou char (*pCache)[tamanhoBuffer];



// https://pt.stackoverflow.com/questions/2983/como-passar-uma-função-como-parâmetro-em-c //

// double *p[x] != double(*p)[x]    O primeiro cria um vetor de ponteiros para inteiros e o segundo cria um único ponteiro para um vetor de x posições

register char bufferPc[tamanhoBuffer];
register char bufferModulo[tamanhoBuffer];
volatile int posBufferPc = 0;
volatile int posBufferModulo = 0;
unsigned short retorno;
unsigned char timer4timer , timer6timer;
unsigned int lastPos;
unsigned int margeIn,margeOut = 0;



#pragma pack(2)
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
  if(timer == &TMR6) //estou mexendo comm o Timer6?
  {
  T6CON = 0x00;
  T6CON = prescaler <<  6;
  T6CON += postscaler;
  TMR6 = 0;
  timer6timer = Tmof / (prescaler + postscaler);
  return ;
  }
}  
#define setTime(t,p) setTime(&t,p,Get_Fosc_kHz(void))


char read(char *mensagem, unsigned char *buf) //retorna 1 se a mensagem for encontrada e zero caso não (no buffer, no caso)
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
#define read(t) if(read(t,bufferPc)) //dados recebidos do modulo
read("relatorio")
{
 escrever('p', "Autor: Henrique Mauler Borges");
 escrever('p', "Curso técnico em eletrônica");
 return 0;
}

read("Qual a sua frequencia?")
{
 char saidaclock[10];
 unsigned short clock = Clock_MHz();
 escrever('p', "A frequencia de trabalho é: ");
 escrever('p', saidaclock);
 return 0;
}

read("invadido")
{
 escrever('m',"invasao");
 return 0;
}


read("Me responda micro!")
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

read("BlocoEnergizado:8:Intensidade:15")
{
 escrever('m',"Invadido");
}
else read("BlocoEnergizado:10:Intensidade:15")
{
 escrever('m',"Horario:dia");
}
else read("BlocoEnergizado:10:Intensidade:1")
{
 escrever('m',"Horario:noite");
}


#define read(t) if(read(t,bufferModulo)) //dados recebidos do modulo




read("LED1") escrever('p',"valor2");
else read("LED2") escrever('p',"valor3");
else read("LED3") escrever('p',"valor4");
else read("LED4") escrever('p',"valor5");
 return 1;





}

void interrupt() //a interrupção de alta prioridade apenas armazenará os dados recebidos (no momento apenas do computador)
{
  if(RC1IF_bit)
  {
    bufferPc[posBufferPc] = RC1REG;
    posBufferPc++;
    bufferPc[posBufferPc] = 0x00;
  }
  else if(RC2IF_bit)
  {
     //*(volatile int *)&GameBuffer[posGameBuffer] = RC2REG; //método para não termos otimização nesta área em específica, sem precisar do volatile
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

//============ Configurando o BaundRate =========== //

TXSTA1.BRGH = 1; //Habilita o Intenso Baundrate (usa dois registradores para realiar a contagem de bits por segundo)
BAUDCON1.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado caso esteja em um,e descarta o SPBRGH1 quando esta em zero)
SPBRGH1 = 0x00;
SPBRG1 = 0x41; //baundrate configurado para 115200 (utilizando uma frequencia de aproxidamente 35MHz);

TXSTA2.BRGH = 1; //Desabilita o Intenso Baundrate
BAUDCON2.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 é utilizado,e descarta o SPBRGH1 quando esta em zero)
SPBRGH2 = 0x00;
SPBRG2 = 0x45; //baundrate configurado para (utilizando uma frequencia de aproxidamente 35MHz);

//============ Configurando os Pinos ============== //
TRISB = 0x00;
TRISC = 0xFF; //os dois registradores acima possuem pinos referentes ao EUSART1 e EUSART2, respectivamente e devem ser setados como saída
TRISD = 0xFF;
PORTB = 0x00;
//============ Habilitando o transmissor =========== //

TXSTA1.SYNC = 0;  //modo assincrono
RCSTA1.SPEN = 1;  //liga a eusart
TXSTA1.TXEN = 1;  //liga o circuito transmissor
TX1IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
ANSELB = 0x00;
ANSELC = 0x00;

TXSTA2.SYNC = 0;  //modo assincrono
RCSTA2.SPEN = 1;  //liga a eusart
TXSTA2.TXEN = 1;  //liga o circuito transmissor
TX2IE_bit = 0;    //flag do receptor setado para zero pois não será utilizado a interrupção por envio de dados
ANSELD = 0x00;    //Os registrador Analogico-Digital devem estar desabilitado para que a comunicação funcione (ANSELB para o EUSART1 e ANSELC para EUSART2

//============= Habilitando o receptor ============= //

RCSTA1.CREN = 1; //similar ao spen. Habilita o circuito
//RCSTA1.FERR = 0; // indica que o byte não foi recebido. CAso queira resetar o apenas apenas reinicie o bit SPEN de RCSTA1
//RCSTA1.OERR = 0; indica um erro de overflow. POde ser reinicado assim que os dados forem lido e o bit SPEN for reiniciado (ou o CREN)
while(PIR1.RC1IF) {RCREG1;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.

RCSTA2.CREN = 1; //similar ao spen. Habilita o circuito
//RCSTA2.FERR = 0; // indica que o byte não foi recebido. CAso queira resetar o apenas apenas reinicie o bit SPEN de RCSTA1
//RCSTA2.OERR = 0; indica um erro de overflow. POde ser reinicado assim que os dados forem lido e o bit SPEN for reiniciado (ou o CREN)
while(PIR3.RC2IF) {RCREG2;} //para limpar o buffer. Uma precaução antes de iniciar o programa. Enquanto houver dados no buffer, lê-los.

//============= Configurações de Prioridade =============== //
//TXSTA1.SENDB = 1; //enviar o byte de quebra
INTCON.GIE = 0x01;  //habilita a interrupção global
INTCON.PEIE = 0x01; //habilita a interrupção por periférico
RCON.IPEN = 0x01; //interrupção por prioridades habilitado (significa que poderá haver interrupção de alto nível e baixo nível no programa)

IPR1.RC1IP = 0x01;         //recepção de dados (RX) possui interrupção de baixa prioridade
IPR1.TX1IP = 0x01;         //tranmissao possui interrupção de baixa prioridade
PIR1.TX1IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
PIE1.TX1IE = 0x00;            //desabilita interrupção por tx
PIR1.RC1IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
PIE1.RC1IE = 0x01;            // habilita a interrpção por rx

IPR3.RC2IP = 0x01;         //recepção de dados (RX) possui interrupção de alta prioridade
IPR3.TX2IP = 0x01;         //tranmissao possui interrupção de alta prioridade
PIR3.TX2IF = 0x00;            //flag setada para um toda vez que a transmissão eusart estiver habilitada e não houver dados sendo segurados no TXREG. é apenas zero quando o registrador tsr esta ocupado com um byte e um byte está a espara para a tranmissão em txreg
PIE3.TX2IE = 0x00;            //desabilita interrupção por tx
PIR3.RC2IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
PIE3.RC2IE = 0x01;            // habilita a interrpção por rx

//============= Configurações de Timer's =============== //
PIR5.TMR6IF = 0;
PIR5.TMR4IF = 0;
IPR5.TMR6IP = 0;
IPR5.TMR4IP = 0;
TMR6 = 0;
TMR4 = 0;
T6CON = 0b01111011; //os valores do timer ainda devem ser ajustados corretamente
T4CON = 0b00111001; //define um tempo para 10 ms (pode estar errao por hora) considerando uma entrada de 136 vezes na interrupção  e uma frequencia d 31MHz
T6CON.TMR6ON = 0;
T6CON.TMR4ON = 0;
//setTime(TMR6, 0.5);

//============= Inicio do programa =============== //
for(i = 0; i < tamanhoBuffer;i++) bufferPc[i] = bufferModulo[i] = 0xFF;



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
     if(posBufferPc > offset + 5)
     {
     posBufferPc = 0;
     }
    if(posBufferModulo > offset)
     {
     posBufferModulo = 0;
     }
    }
  }
}