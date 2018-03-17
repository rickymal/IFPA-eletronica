package net.shadowfacts.tutorial.block.counter;

public class Conector {
	public static boolean valor = false;
	public static boolean primeiraCarga = false;
	public static boolean segundaCarga = false;
	public static boolean terceiraCarga = false;
	public static int dadoNumerico = 0;
	static boolean temEnergia = false;
	
	
	
	public void setBooleanValue(int valor)
	{
		if(valor == 1)
		{
			primeiraCarga = !primeiraCarga;
		}
		else if(valor == 2)
		{
			segundaCarga = !segundaCarga;
		}
		else if(valor == 3)
		{
			terceiraCarga = !terceiraCarga;
		}
	}
	
	

}
