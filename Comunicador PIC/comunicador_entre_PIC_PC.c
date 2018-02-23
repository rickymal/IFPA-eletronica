#define tamanhoBuffer 256
#define offset 3*tamanhoBuffer/2
#define servico_limpar_buffer 1
#define servico_reiniciar_buffer 0
#define overflow TMR6IF_bit

#define moduloPC 1
#define moduloCelular 1

// https://pt.stackoverflow.com/questions/2983/como-passar-uma-fun��o-como-par�metro-em-c //

char buffer[tamanhoBuffer];  //armazena o buffer
int posBuffer = 0; //defina a atual posi��o do buffer
int margeIn; //define a posi��o m�nima de onde se encontra a �ttima mensagem recebida pro buffer
int margeOut; //define a posi��o m�xima de onde se encontra a �tlima mensagem recebida pro buffer
int tent; //auxiliar:recebe a instru��o que ser� usada na assistencia
char using_assist = 0; //flag:determina se a assist�ncia est� sendo utilizada
unsigned char retorno; //armazena o retorno da fun��o loop para um poss�vel tratamento (atualmente nenhum tratamnto � realizado)
char timer4timer , timer6timer; //auxiliares:determina um controle melhor dos timer's (atualmente ainda n�o utilizado, apenas escrito no c�digo mas sem nenhuma fun��o no momento)
//typedef int (*assist)();
void (*assist)(); //determina um ponteiro d efun��o que dir� o que ser� feito na assist�ncia (atualmente s� existe um comando, por�m ter� implementa��es)

void limpaBuffer()  //m�todo que realiza a limpeza do buffer, ou melhor, uma mensagem que j� foi lida e interpretada
{
  int x = margeIn;
  int y = margeOut;
  using_assist = 1;
  for(y; y > x;  y--) buffer[y] = 0xFF;
  margeIn = margeOut = using_assist = 0;

}

void servico(char intent_field){ //determina o servi�o que ser� utilizado
  tent = intent_field;
  assist = limpaBuffer;
  if(tent) overflow = 1;// provoco um estouro intencional para cuidar realizar assistencia no buffer
}


void setTime(sfr unsigned short volatile *timer, double tempo_seg, double frequencia)  //serve para os timer's 2/4/6
{
int Tof; //tempo de overflow
int Tmof; //tempo para todos os overflow (multiplos overflows
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
  if(timer == &TMR6) //estou mexendo comm o Timer6?
  {

  T6CON = prescaler <<  6;
  T6CON += postscaler;
  TMR6 = 0;
  timer6timer = Tmof / (prescaler + postscaler);
  return ;
  }
}

char read(char *mensagem) //retorna 1 se a mensagem for encontrada e zero caso n�o (no buffer, no caso)
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
   servico(servico_limpar_buffer);
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

void interrupt_low()  //a interrup��o de baixa prioridade que chamar� os servi�os
{
if(timer4timer < 136) asm retfie;
if(timer6timer < 136) asm retfie;
if(overflow) assist();overflow = 0;
} //end interrupt low

void interrupt() //a interrup��o de alta prioridade apenas armazenar� os dados recebidos (no momento apenas do computador)
{
  buffer[posBuffer] = RC1REG;
  posBuffer++;
  buffer[posBuffer] = 0x00;
}

void main()
{
int i;

//============ Configurando o BaundRate =========== //
#if moduloPc == 1
TXSTA1.BRGH = 1; //Habilita o Intenso Baundrate (usa dois registradores para realiar a contagem de bits por segundo)
BAUDCON1.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 � utilizado caso esteja em um,e descarta o SPBRGH1 quando esta em zero)
SPBRGH1 = 0x00;
SPBRG1 = 0x41; //baundrate configurado para 115200 (utilizando uma frequencia de aproxidamente 35MHz);
#endif

#if moduloCelular == 1
TXSTA2.BRGH = 1; //Desabilita o Intenso Baundrate
BAUDCON2.BRG16 = 1; //Contador utiliza os dezesseis bits (o registrador SPBRG1 � utilizado,e descarta o SPBRGH1 quando esta em zero)
SPBRGH2 = 0x00;
SPBRG2 = 0x45; //baundrate configurado para (utilizando uma frequencia de aproxidamente 35MHz);
#endif

//============ Configurando os Pinos ============== //
TRISB = 0xFF;
TRISC = 0xFF; //os dois registradores acima possuem pinos referentes ao EUSART1 e EUSART2, respectivamente e devem ser setados como sa�da
TRISD = 0xFF;
//============ Habilitando o transmissor =========== //
#if moduloPc == 1
TXSTA1.SYNC = 0;  //modo assincrono
RCSTA1.SPEN = 1;  //liga a eusart
TXSTA1.TXEN = 1;  //liga o circuito transmissor
TX1IE_bit = 0;    //flag do receptor setado para zero pois n�o ser� utilizado a interrup��o por envio de dados
ANSELB = 0x00;
ANSELC = 0x00;
#endif

#if moduloCelular == 1
TXSTA2.SYNC = 0;  //modo assincrono
RCSTA2.SPEN = 1;  //liga a eusart
TXSTA2.TXEN = 1;  //liga o circuito transmissor
TX2IE_bit = 0;    //flag do receptor setado para zero pois n�o ser� utilizado a interrup��o por envio de dados
ANSELD = 0x00;    //Os registrador Analogico-Digital devem estar desabilitado para que a comunica��o funcione (ANSELB para o EUSART1 e ANSELC para EUSART2
#endif
//============= Habilitando o receptor ============= //
#if moduloPc == 1
RCSTA1.CREN = 1; //similar ao spen. Habilita o circuito
//RCSTA1.FERR = 0; // indica que o byte n�o foi recebido. CAso queira resetar o apenas apenas reinicie o bit SPEN de RCSTA1
//RCSTA1.OERR = 0; indica um erro de overflow. POde ser reinicado assim que os dados forem lido e o bit SPEN for reiniciado (ou o CREN)
while(PIR1.RC1IF) {RCREG1;} //para limpar o buffer. Uma precau��o antes de iniciar o programa. Enquanto houver dados no buffer, l�-los.
#endif

#if moduloCelular == 1
RCSTA2.CREN = 1; //similar ao spen. Habilita o circuito
//RCSTA2.FERR = 0; // indica que o byte n�o foi recebido. CAso queira resetar o apenas apenas reinicie o bit SPEN de RCSTA1
//RCSTA2.OERR = 0; indica um erro de overflow. POde ser reinicado assim que os dados forem lido e o bit SPEN for reiniciado (ou o CREN)
while(PIR3.RC2IF) {RCREG2;} //para limpar o buffer. Uma precau��o antes de iniciar o programa. Enquanto houver dados no buffer, l�-los.
#endif

//============= Configura��es de Prioridade =============== //
//TXSTA1.SENDB = 1; //enviar o byte de quebra
INTCON.GIE = 0x01;  //habilita a interrup��o global
INTCON.PEIE = 0x01; //habilita a interrup��o por perif�rico
RCON.IPEN = 0x01; //interrup��o por prioridades habilitado (significa que poder� haver interrup��o de alto n�vel e baixo n�vel no programa)
#if moduloPc == 1
IPR1.RC1IP = 0x01;         //recep��o de dados (RX) possui interrup��o de baixa prioridade
IPR1.TX1IP = 0x01;         //tranmissao possui interrup��o de baixa prioridade
PIR1.TX1IF = 0x00;            //flag setada para um toda vez que a transmiss�o eusart estiver habilitada e n�o houver dados sendo segurados no TXREG. � apenas zero quando o registrador tsr esta ocupado com um byte e um byte est� a espara para a tranmiss�o em txreg
PIE1.TX1IE = 0x00;            //desabilita interrup��o por tx
PIR1.RC1IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
PIE1.RC1IE = 0x01;            // habilita a interrp��o por rx
#endif

#if moduloCelular == 1
IPR3.RC2IP = 0x01;         //recep��o de dados (RX) possui interrup��o de alta prioridade
IPR3.TX2IP = 0x01;         //tranmissao possui interrup��o de alta prioridade
PIR3.TX2IF = 0x00;            //flag setada para um toda vez que a transmiss�o eusart estiver habilitada e n�o houver dados sendo segurados no TXREG. � apenas zero quando o registrador tsr esta ocupado com um byte e um byte est� a espara para a tranmiss�o em txreg
PIE3.TX2IE = 0x00;            //desabilita interrup��o por tx
PIR3.RC2IF = 0x00;            //flag setada para um enquanto houver dados para receber e tratar
PIE3.RC2IE = 0x01;            // habilita a interrp��o por rx
#endif
//============= Configura��es de Timer's =============== //
PIR5.TMR6IF = 0;
PIR5.TMR4IF = 0;
PIE5.TMR6IE = 1;
PIR5.TMR4IE = 1;
IPR5.TMR6IP = 0;
IPR5.TMR4IP = 0;
TMR6 = 0;
TMR4 = 0;
T6CON = 0b00111001; //os valores do timer ainda devem ser ajustados corretamente
T4CON = 0b00111001; //define um tempo para 10 ms (pode estar errao por hora) considerando uma entrada de 136 vezes na interrup��o  e uma frequencia d 31MHz
T6CON.TMR6ON = 0;
T6CON.TMR4ON = 0;

//============= Inicio do programa =============== //
for(i = 0; i < tamanhoBuffer;i++) buffer[i] = 0xFF;
while(1)
{
    retorno = loop();
    if(posBuffer > offset)
    {
     posBuffer = 0;
    // while(buffer[posBuffer] != 0xFF) posBuffer++;
    }
  }
}