package net.shadowfacts.tutorial.block.counter;

import java.util.Random;

import net.minecraft.block.Block;
import net.minecraft.block.material.Material;
import net.minecraft.block.state.IBlockState;
import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.util.EnumFacing;
import net.minecraft.util.EnumHand;
import net.minecraft.util.math.BlockPos;
import net.minecraft.util.text.TextComponentString;
import net.minecraft.world.IBlockAccess;
import net.minecraft.world.World;
import net.shadowfacts.tutorial.block.BlockTileEntity;

public class BlockCounterv2 extends BlockTileEntity<TileEntityCounter> {
	TileEntityCounter tile;
	public static Conector conexao;
	public static int intensidadeSinal;
	public int setSinal = 0; //se 0, faz nada, se 1, liga se 2 desliga
	public boolean havePower = false;
	public int lastCounterValue = 0;
	boolean tempSinal;
	TileEntityCounter entityCounter;
	
	

	public BlockCounterv2(Material material, String name) {
		super(Material.ROCK, "newcounter");
		this.setCreativeTab(CreativeTabs.MATERIALS); //ajustar isso melhor, não sei se vou coloar sempre na CreativeTabs Material
		this.setTickRandomly(true);
		//this.name = "ore_copper";
		// TODO Auto-generated constructor stub
	}

	@Override
	public Class<TileEntityCounter> getTileEntityClass() {
		// TODO Auto-generated method stub
		return TileEntityCounter.class;
	}

	@Override
	public TileEntityCounter createTileEntity(World world, IBlockState state) {
		// TODO Auto-generated method stub
		tile = new TileEntityCounter();
		return tile;
	}
	
	@Override
	public void updateTick(World worldIn, BlockPos pos, IBlockState state, Random rand) 
	{
		 entityCounter = this.getTileEntity(worldIn, pos);
		
		
		if(tile.getTileEntityCounter() == -5)
		{
			setUdpConnection();
		}
		else if(tile.getTileEntityCounter() == 2)
		{
			if(conexao.dadoNumerico == 2)
			{
				tile.setPowerTag(true);
				
			}
			else if(tile.getTileEntityCounter() == 3)
			{
				tile.setPowerTag(false);

			}
			
		}
		else if(tile.getTileEntityCounter() == 4)
		{
			if(conexao.dadoNumerico == 4)
			{
				tile.setPowerTag(true);
			}
			else if(tile.getTileEntityCounter() == 5)
			{
				tile.setPowerTag(false);
			}
			
		}
		
		
		worldIn.notifyNeighborsOfStateChange(new BlockPos(pos.getX(), pos.getY(), pos.getZ()), this, true);
		worldIn.scheduleUpdate(new BlockPos(pos.getX(), pos.getY(), pos.getZ()), this, this.tickRate(worldIn));	
		
		
	}
	
	@Override
	public int getStrongPower(IBlockState blockState, IBlockAccess blockAccess, BlockPos pos, EnumFacing side) 
	{

		return tile.getPowerTag() ? intensidadeSinal : 0;
		
		
		

	}
	
	public void setUdpConnection()
	{
		Thread t = new Thread() {
			public void run() {
				try {
					for (;;) {
						java.net.DatagramSocket serverSocket = new java.net.DatagramSocket(5051);
						java.net.DatagramPacket receivePacket = new java.net.DatagramPacket(new byte[128], 128);
						serverSocket.receive(receivePacket);
						String data = new String(receivePacket.getData()).trim();
						if (data.contains("AcionarCarga"))
							conexao.valor = !conexao.valor;
						else
						{
							int pos = data.indexOf("valor");							
							if(pos != -1)
							{
								char charactere = data.charAt(pos+5);
								conexao.dadoNumerico = Character.getNumericValue(charactere);
								System.out.println("Valor número obtido: " + conexao.dadoNumerico);
							}
							pos = data.indexOf("energia");
							if(pos != -1)
							{
								char charactere = data.charAt(pos+7);	
								char segundoChar = data.charAt(pos+8);
								intensidadeSinal = Character.getNumericValue(segundoChar) + Character.getNumericValue(charactere)*10;
								System.out.println("valor de energia: " + intensidadeSinal);
							}
							
						}
						serverSocket.disconnect();
						serverSocket.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
		t.start();
		System.setProperty("udp.server", "run");
	}
	
	
	@Override
	public boolean onBlockActivated(World worldIn, BlockPos pos, IBlockState state, EntityPlayer playerIn,
			EnumHand hand, EnumFacing facing, float hitX, float hitY, float hitZ) {

		// servidor fisico em multiplayey ou logico no single? (se fosse true, então
		// está sndo executado no cliente, o que não é o certo)
		if (worldIn.isRemote == false) {
			TileEntityCounter tile = getTileEntity(worldIn, pos);
			if (facing == EnumFacing.DOWN) {
				tile.decrementCount();

			} else if (facing == EnumFacing.UP) {

				tile.incrementCount();
			}

			playerIn.sendMessage(new TextComponentString("Count: " + tile.getCount()));
			// o nome original era addChatMessage
			System.out.println("O valor do count é: " + tile.getCount());
		}
		return true;
	}
	
	

	@Override
	public void onBlockAdded(World worldIn, BlockPos pos, IBlockState state) {
		System.out.println("Bloco adicionado com sucesso");
		worldIn.scheduleUpdate(new BlockPos(pos.getX(), pos.getY(), pos.getZ()), this, this.tickRate(worldIn));
		// TODO Auto-generated method stub
		super.onBlockAdded(worldIn, pos, state);
	}

	@Override
	public void neighborChanged(IBlockState state, World worldIn, BlockPos pos, Block blockIn, BlockPos fromPos) {
		// TODO Auto-generated method stub
		TileEntityCounter tile = (TileEntityCounter) worldIn.getTileEntity(pos);
		
		if(tile.getTileEntityCounter() == 6) 
		{
		
			if(worldIn.isBlockIndirectlyGettingPowered(pos) > 0)
			{
				System.out.println("Este bloco recebeu energia");			
				String mensagem = "BlocoEnergizado:" + tile.getTileEntityCounter() + ":Intensidade:" + worldIn.isBlockIndirectlyGettingPowered(pos);
				
				try
				{
					java.net.DatagramSocket socket = new java.net.DatagramSocket();
					socket.send(new java.net.DatagramPacket((mensagem + "" + (char) 13).getBytes(), (mensagem + "" + (char) 13).getBytes().length,
							java.net.InetAddress.getByName("127.0.0.1"), 5454));
					socket.close();
				}
				catch(Exception e)
				{
					
				}
			}
		}
		//super.neighborChanged(state, worldIn, pos, blockIn, fromPos);
	}

}
