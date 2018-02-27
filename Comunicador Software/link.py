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
        
        if(mensagem == 'sair'):
             print('\r\n');
             break;
        elif mensagem == 'repeat':
            soquete = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            soquete.sendto('enegia01'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia02'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia03'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia04'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia05'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia06'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia07'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia08'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia09'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia10'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia11'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);
            soquete.sendto('enegia12'.encode('utf-8'), (localhost, serial1));
            time.sleep(0.5);


        else:
            soquete = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            soquete.sendto(mensagem.encode('utf-8'), (localhost, serial1));
            print('instrução {} enviada com sucesso!'.format(mensagem));
            
        
def t2():
    soquete = socket.socket(socket.AF_INET, socket.SOCK_DGRAM);
    soquete.bind((localhost, serial2));
    print('entrando no buffer')
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
    baundrate = int(input('\r\ndefina o baundrate '));
    porta = input('qual a porta? ')
    global ser;
    ser.baundrate = baundrate;
    ser.port = porta;
    
    try:
        ser.open()
        if ser.is_open:
            print('\r\nporta aberta com sucesso')
            status = True;
            
    finally:
        pass;

def serialMensagem():
    global ser;
    asc = input('\r\ndigite a instrução de envio: ')
    ser.write(asc.encode())
    
    
def readSerial():
     print(ser.readline);

#o programa

print('Programa de comunicaçao entre canal udp e serial\r\n');

while True:
    comando = input('\r\ndigite o comando que deseja executa: ');  
    if comando == 'conf udp':
              x = input('digite o IP que será utilizado. (padrão: {})'.format(localhost))
              if x != "":
                  localhost = x;
              x = input('digite a porta para a comunicação entre serial e udp. (padrão: {}'.format(serial1))
              if x != "":
                  serial1 = x;
              x = input('digite a porta para a comunicaçao oposta, entre udp e serial. (padrão: {}'.format(serial2))
              if x != "":
                  serial2 = x;
    elif comando == 'conf serial':
        configurarSerial()
    elif comando == 'udp':
        iniciarUdp();
        time.sleep(0.5);
    elif comando == 'serial':
        serialMensagem();
    elif comando == 'readserial':
        readSerial();      
    else:
        print('comando não encontrado\r\n');



