#define tamanhoBuffer 256
#define offset 3*tamanhoBuffer/2
#define servico_limpar_buffer 7
#define overflow TMR0IF_bit

// https://pt.stackoverflow.com/questions/2983/como-passar-uma-função-como-parâmetro-em-c //

char buffer[tamanhoBuffer];
int posBuffer = 0;
int margeIn;
int margeOut;
int tent;
char using_assist = 0;
unsigned char retorno;
//typedef int (*assist)();
void (*assist)();

void assistente() //necessita de melhoras para melhor adaptação
{
  int x = margeIn;
  int y = margeOut;
  using_assist = 1;

  if(buffer[margeOut] == 0x00)
  for(y; y > x;  y--) buffer[y] = 0xFF;
  margeIn = margeOut = using_assist = 0;
}

void servico(char intent_field){
  tent = intent_field;
  assist = assistente;
  overflow = 1;// provoco um estouro intencional para cuidar realizar assistencia no buffer
}

char read(char *mensagem) //retorna 1 se a mensagem for encontrada e zero caso não
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
   servico(servico_limpar_buffer);
  
  
  }
 
 
 }

}
}


void interrupt_low()
{
if(overflow) assist();overflow = 0;

} //end interrupt low


void interrupt()
{
  buffer[posBuffer] = RC1REG;
  buffer[posBuffer + 1] = 0x00;

}

void main()
{



}