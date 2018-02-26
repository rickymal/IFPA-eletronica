import time
import threading
import socket
import serial


serial1 = 5051;
serial2 = 5454;
localhost = "127.0.0.1"
porta = 'COM1'
status = False;
ser = serial.Serial();

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

def configurarSerial():
    baundrate = int(input('defina o baundrate '));
    porta = input('qual a porta? ')
    global ser;
    ser.baundrate = baundrate;
    ser.port = porta;
    
    try:
        ser.open()
        if ser.is_open:
            print('porta aberta com sucesso')
            status = True;
            
    finally:
        pass;

def serialMensagem():
    global ser;
    asc = input('digite a instrução de envio: ')
    ser.write(asc.encode())
    
    
def readSerial():
     print(ser.read(3));

#o programa

print('Programa de comunicaçao entre canal udp e serial\r\n');
ser.baundrate = 115200;
ser.port = 'COM5'
ser.open();
while True:
    comando = input('digite o comando que deseja executa: ');  
    if comando == 'ajuda':
        print('digite \'ajuda\' para exibir esta lista.');
        print('digite \'configurarUdp\' para realizar configurações do servidor udp, tal como IP e portas.');
        print('digite \'configurarSerial\' para realizar configurações do canal serial, como baundrate e a porta manualmente.');
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
    elif comando == 'configurarserial':
        configurarSerial()
    elif comando == 'initudp':
        iniciarUdp();
        time.sleep(0.5);
    elif comando == 'initserial':
        serialMensagem();
    elif comando == 'readserial':
        readSerial();
    else:
        print('comando não encontrado\r\n');



