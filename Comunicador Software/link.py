import socket
import serial
import time
import threading

class udpServer():
        def __init__(self, IP = '127.0.0.1', portaEnvio = 5051, portaRecepção = 5454):
                self.ip = IP;
                self.porta1 = portaEnvio;
                self.porta2 = portaRecepção;
                self.status_Trans = False;
                self.status_Recept = False;



        def ligarCanal(self):
                print('ligando canal udp');
                self.sock1 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM);
                self.status_Trans = True;
                self.sock2 = socket.socket(socket.AF_INET, socket.SOCK_DGRAM);
                self.status_Recept = True;


        def enviarMensagem(self,msn):
                print(msn);
                self.sock1.sendto(msn.encode('utf-8') , (self.ip, self.porta1));
        def rcp1(self):
            self.sock2.bind((self.ip, self.porta2))
            while True:
                mensagemRecebida = self.sock2.recv(50);
                print('recebido pela udp o comando: {}'.format(mensagemRecebida));
                print('esta mensagem recebida é do tipo {}'.format(type(mensagemRecebida)));
                tempV = str(mensagemRecebida[:len(variavel)-1]);
                tempV = tempV[2:len(tempV) -1];
                print('mensagem enviada com sucesso: {}'.format(tempV));
                print('enviando para serial')
                portaSerial.enviarMensagem(temV);



        def recepção1(self):
                self.threadUdp = threading.Thread(target = self.rcp1);
                self.threadUdp.start();



                
class serialServer():
    def __init__(self, baundrate = 115200, porta = 'COM5'):
        self.status_conectado = False;
        self.portaSerial = serial.Serial(porta, baundrate);
        try:
            self.portaSerial.close();
        except ValueError:
            pass;

    def ligarCanal(self):
        try:
            self.portaSerial.open();
            if(self.portaSerial.is_open):
                    print('porta serial aberta com sucesso')
                    self.status_conectado = True;
        except ValueError:
                print('a porta não pode ser aberta');
                pass;


    def enviarMensagem(self,msn):
        self.portaSerial.write(msn.encode());

    def rcp2(self):
        while True:
            variavel = self.portaSerial.readline(30);
            tempV = str(variavel[:len(variavel)-1]);
            tempV = tempV[2:len(tempV) -1];
            print('mensagem enviada com sucesso: {}'.format(tempV));
            print('Esta variavel na serial é recebida pelo formato de {}'.format(type(tempV)));
            try:
                    canalUdp.enviarMensagem(tempV);
            except ValueError:
                    print('não foi possivel enviar para o jogo');

    def recepção(self):
        self.threadSerial = threading.Thread(target = self.rcp2);
        self.threadSerial.start();







#Inicio do programa



print('Iniciando programa de comunicação entre Celular e jogo');

try:
    print('preparando o canal udp...');
    canalUdp = udpServer();
    print('preparando o canal serial...');
    portaSerial = serialServer();
except ValueError:
    print('um dos canais não pode ser criado.');

print('Iniciando canais do comunicação');
canalUdp.recepção();
portaSerial.recepção1();
print('canais estabelecidos');