#define tamanhoBuffer 256
#define offset 3*tamanhoBuffer/2
#define intent_clear_buffer 7
#define overflow TMR5IF_bit
// https://pt.stackoverflow.com/questions/2983/como-passar-uma-função-como-parâmetro-em-c //

char buffer[tamanhoBuffer];
int posBuffer = 0;
int margeIn;
int margeOut;
int tent;
char using_assist = 0;
unsigned char retorno;
//typedef int (*assist)(); 
int (*assist)();

void interrupt()
{
buffer[posBuffer] = RC1REG;
buffer[posBuffer + 1] = 0x00;

}

int Assist() //necessita de melhoras para melhor adaptação
{
using_assist = 1;
int x = margeIn;
int y = margeOut;
if(buffer[margeOut] == 0x00)
for(y; y > x;  y--) buffer[y] = 0xFF;
margeIn = margeOut = using_assist = 0;
}

char read(char *mensagem) //retorna 1 se a mensagem for encontrada e zero caso não
{
int i;
//if(buffer[margeOut] == 0x00) i = margeOut + 1;
//else i = 0;


i = 0;

//for(;;)
for(i; buffer[i] != "0x00" ; i++) 
for(int j = 0;buffer[i+j] == mensagem[j]; j++) 
if(mensagem[j] == "0x00")
{
margeIn = i;
margeOut = margeIn + j;
intent(intent_clear_buffer);
return 1;
}
i += j;

return 0;
}

void intent(char intent_field){
tent = intent_field;
assist = &Assist;
overflow = 1;// provoco um estouro intencional para cuidar realizar assistencia no buffer 


}


void interrupt_low()
{
if(overflow) assist();overflow = 0;




} //end interrupt low



void config() //atualização de todas as bios
{


}

unsigned char loop() //coloca em outro documento vazio
{


if(read("Teste"))
{
delay_ms(1000);
PORTB = 0xFF:
delay_ms(1000);
PORTB = 0x00;
delay_ms(1000);
PORTB = 0xFF:
delay_ms(1000);
PORTB = 0x00;
delay_ms(1000);
PORTB = 0xFF:
delay_ms(1000);
PORTB = 0x00;
return 1;

}





}

int main()
{
for(int i = 0; i < tamanhoBuffer;i++) buffer[i] = 0xFF;
config();


for(;;)
{
retorno = loop();





} //end for






}
