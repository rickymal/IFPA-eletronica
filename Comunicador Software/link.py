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
		self.sock1.sendto(msn.encode('utf-8') , (self.ip, self.porta1));

	def rcp1(self):
		self.sock2.bind((self.ip, self.porta2));
		while True:
			print('recebido pela udp o comando: {}'.format(self.sock2.recv(30)));

	def recepção1(self):
		self.threadUdp = threading.Thread(target = self.rcp1);
		self.threadUdp.start();



		
class serialServer():
	def __init__(self, baundrate = 115200, porta = 'COM5'):
		self.status_conectado = False;
		self.portaSerial = serial.Serial(porta, baundrate);
		self.portaSerial.close();



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
			print('recebido pela serial o comando: {}'.format(self.portaSerial.readline(30)));

	def recepção(self):
		self.threadSerial = threading.Thread(target = self.rcp2);
		self.threadSerial.start();









portaSerial = serialServer();
canalUdp = udpServer();


while True:
	comando  = input('digite os comandos com os argumentos correto: ');
	x = comando.split();
	print ('comando splitado')

	if x[0] == 'iniciar':
		if x[1] == 'udp':
			canalUdp.ligarCanal();
			print('canal udp estabilizado com sucesso!');
		elif x[1] == 'serial':
			portaSerial.ligarCanal();
			print('canal serial estabilizado com sucesso!');
	elif x[0] == 'enviar':
		if x[1] =='udp':
			mensagem = x[2];
			canalUdp.enviarMensagem(mensagem);
		elif x[1] == 'serial':
			mensagem = x[2];
			portaSerial.enviarMensagem(mensagem);
	elif x[0] == 'receber':
		if x[1] == 'udp':
			canalUdp.recepção1();
		elif x[1] == 'serial':
			portaSerial.recepção();
	else:
		print('comando não encontrado');



