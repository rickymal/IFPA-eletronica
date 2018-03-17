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

//genérico TileEntityCounter visto que este é o tileentity para o bloco 
public class BlockCounter extends BlockTileEntity<TileEntityCounter> {
	
	protected TileEntityCounter tile;
	protected TileEntityCounter entityCounter;
	
	protected int intensidadeSinal = 15;
	protected boolean onlyOneTime = false;
	protected Conector conexao;
	protected BlockPos rp;
	protected int comp;
	protected int lastEntity;
	BlockPos posi;
	

	public BlockCounter() {
		super(Material.ROCK, "counter");
		this.setCreativeTab(CreativeTabs.MATERIALS); //ajustar isso melhor, não sei se vou coloar sempre na CreativeTabs Material
		this.setTickRandomly(true);
		//this.name = "ore_copper";
	}

	@Override
	public int tickRate(World worldIn) {
		// TODO Auto-generated method stub
		return 10;
	}

	// metodo necessário para registrar as TileEntity com o nome, permitindo o
	// ModBlocks automaticamente reigstar a TileEntityCounter para o nome
	// tutorial:counter
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
	public void updateTick(World worldIn, BlockPos pos, IBlockState state, Random rand) {
		entityCounter = this.getTileEntity(worldIn, pos);
		rp = pos;
		
		if(this.onlyOneTime == false)
		{
			this.onlyOneTime = true;
			for(int i =  0 ; i < 10 ; i++)
			{
				System.out.println("Entrando na tick");
			}
		}
		
		if(entityCounter.getTileEntityCounter() == -6)
		{
          
		if (System.getProperty("udp.server") == null) {
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
		
			
		}
		else if(entityCounter.getTileEntityCounter() == 2)
		{
			//System.out.println("entrando em 2 sim");
			if(conexao.dadoNumerico == 2)
			{
				//System.out.println("entrou no valor2 para o bloco de id:" + entityCounter.getTileEntityCounter());
				entityCounter.setPowerTag(true);
				
			}
			else if(conexao.dadoNumerico == 3)
			{
				//System.out.println("entrou no valor6 para o bloco de id:" + entityCounter.getTileEntityCounter());
				entityCounter.setPowerTag(false);
			
			}		
		
		}
		else if(entityCounter.getTileEntityCounter() == 4)
		{
			//System.out.println("entrando em 3 sim");
			if(conexao.dadoNumerico == 4)
			{
				entityCounter.setPowerTag(true);
			
			}
			else if(conexao.dadoNumerico == 5)
			{
				entityCounter.setPowerTag(false);
		;
			}
		
		}
		else if(entityCounter.getTileEntityCounter() == 6)
		{
			//System.out.println("entrando em 4 sim");
			if(conexao.dadoNumerico == 6)
			{
				entityCounter.setPowerTag(true);
			
			}
			else if(conexao.dadoNumerico == 7)
			{
				entityCounter.setPowerTag(false);
			e;
			}
	
		}
		else if(entityCounter.getTileEntityCounter() == 0)
		{
			return;
		}
		else if(entityCounter.getTileEntityCounter() == 8)
		{
			return; //talvez tenha que tirar para receber os dados
		}
		else if(entityCounter.getTileEntityCounter() == 10) //colocado depois da build
		{
			return;
		}
		

		//System.out.println("entrou no valor " + conexao.dadoNumerico + " para o bloco de id:" + entityCounter.getTileEntityCounter() + "com valor " + entityCounter.getPowerTag());
		worldIn.notifyNeighborsOfStateChange(new BlockPos(pos.getX(), pos.getY(), pos.getZ()), this, true);
		worldIn.scheduleUpdate(new BlockPos(pos.getX(), pos.getY(), pos.getZ()), this, this.tickRate(worldIn));	
		//entityCounter.setTileEntityCounter(0);
		

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
		
		if(tile.getTileEntityCounter() == 8 || tile.getTileEntityCounter() == 10) 
		{
		
			if(worldIn.isBlockIndirectlyGettingPowered(pos) > 0)
			{
				//System.out.println("Este bloco recebeu energia");			
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

	@Override
	public int getWeakPower(IBlockState blockState, IBlockAccess blockAccess, BlockPos pos, EnumFacing side) {
		// TODO Auto-generated method stub
		Block bloco = blockState.getBlock();
		BlockCounter b = (BlockCounter)bloco;
		TileEntityCounter t = (b.getTileEntity(blockAccess, pos));
		int valor = t.getTileEntityCounter();
		System.out.println("na get weak temos id: "+ valor);
		
		if(valor == 2)
		{
			return conexao.primeiraCarga ? intensidadeSinal : 0;
		}
		else if(valor == 3)
		{
			return conexao.segundaCarga ? intensidadeSinal : 0;
		}
		else if(valor == 4)
		{
			return conexao.terceiraCarga ? intensidadeSinal : 0;
		}
		else
		{
			return 0;
		}
		

	}

	@Override
	public int getStrongPower(IBlockState blockState, IBlockAccess blockAccess, BlockPos pos, EnumFacing side) {
		// TODO Auto-generated method stub
	
		

		//System.out.println("O valor da powerTag é: " + entityCounter.getPowerTag());
		return entityCounter.getPowerTag() ? intensidadeSinal : 0;
	}

	@Override
	public boolean onBlockActivated(World worldIn, BlockPos pos, IBlockState state, EntityPlayer playerIn,
			EnumHand hand, EnumFacing facing, float hitX, float hitY, float hitZ) {

		// servidor fisico em multiplayer ou logico no single? (se fosse true, então
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
			//System.out.println("O valor do count é: " + tile.getCount());
		}
		return true;
	}

	public boolean onBlockActivated_off__(World worldIn, BlockPos pos, IBlockState state, EntityPlayer playerIn,
			EnumHand hand, EnumFacing facing, float hitX, float hitY, float hitZ) {
		// TODO Auto-generated method stub
		return super.onBlockActivated(worldIn, pos, state, playerIn, hand, facing, hitX, hitY, hitZ);
	}

}
