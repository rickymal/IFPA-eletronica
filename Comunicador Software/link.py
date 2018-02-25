import time
import threading
import socket
import serial


serial1 = 5051;
serial2 = 5454;
localhost = "127.0.0.1"
porta = 'COM1'
status = False;

def t1():
    while True:
        mensagem = input('digite a mensagem: ');
        print('instrução {} enviada com sucesso!'.format(mensagem));
        if(mensagem == 'sair'):
             print('\r\n');
             break;
        elif mensagem == 'repeat':
            soquete = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            while True:                    
                soquete.sendto(mensagem.encode('utf-8'), (localhost, serial1));
                time.sleep(3);
        else:
            soquete = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            soquete.sendto(mensagem.encode('utf-8'), (localhost, serial1));
            
        
def t2():
    soquete = socket.socket(socket.AF_INET, socket.SOCK_DGRAM);
    soquete.bind((localhost, serial2));
    while True:
        print('recebido: {}'.format(soquete.recv(30)));


def iniciarUdp():
    print('\r\nIniciando programa udp\r\n')
    thread2 = threading.Thread(target = t2);
    thread2.start();
    thread1 = threading.Thread(target = t1);
    thread1.start();
    thread1.join();

def configurarSerial(self):
    self.baundrate = input('defina o baundrate ');
    self.porta = input('qual a porta? ')
    self.ser = serial.Serial();
    ser.baundrate = self.baundrate;
    ser.port = self.porta;
    
    try:
        ser.open()
        if ser.is_open:
            print('porta aberta com sucesso')
            self.status = True;
    finally:
        pass;

def serialMensagem(self):
    if(self.status == False):
        return;
    self.ser.write("Testando".format('ascii'));
    
    


print('Programa de comunicaçao entre canal udp e serial\r\n');

while True:
    comando = input('digite o comando que deseja executa: ');
    if comando == 'ajuda':
        print('digite \'ajuda\' para exibir esta lista.');
        print('digite \'udp\' para realizar configurações do servidor udp, tal como IP e portas.');
        print('digite \'serial\' para realizar configurações do canal serial, como baundrate e a porta manualmente.');
    elif comando == 'udp':
              x = input('digite o IP que será utilizado. (padrão: {})'.format(localhost))
              if x != "":
                  localhost = x;
              x = input('digite a porta para a comunicação entre serial e udp. (padrão: {}'.format(serial1))
              if x != "":
                  serial1 = x;
              x = input('digite a porta para a comunicaçao oposta, entre udp e serial. (padrão: {}'.format(serial2))
              if x != "":
                  serial2 = x;
    elif comando == 'serial':
        print('ainda será implementado\r\n');
    elif comando == 'iniciarUdp':
        iniciarUdp();
        time.sleep(0.5);
    else:
        print('comando não encontrado\r\n');



