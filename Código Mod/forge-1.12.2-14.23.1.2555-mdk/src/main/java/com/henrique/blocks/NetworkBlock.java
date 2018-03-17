package com.henrique.blocks;
import net.minecraft.block.material.Material;
import net.minecraft.block.state.IBlockState;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.util.EnumFacing;
import net.minecraft.util.EnumHand;
import net.minecraft.util.math.BlockPos;
import net.minecraft.util.text.TextComponentString;
import net.minecraft.world.World;
import net.shadowfacts.tutorial.block.BlockTileEntity;
import net.shadowfacts.tutorial.block.counter.TileEntityCounter;

public class NetworkBlock extends BlockTileEntity<TileEntityCounter> {
	
	BlockPos p;
	World w;
	int cmd;
	int TAGvalue;
	
	
	

	public NetworkBlock(Material material, String name, int cmd) {	
		super(material, name);
		this.cmd = cmd;
		
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
		
		TileEntityCounter tempTile = new TileEntityCounter();
		TAGvalue = tempTile.count;
		
		return tempTile;
	}
	
	//segue abaixo todos os métodos que serão utilizados para criar o bloco
	
	@Override
	public boolean onBlockActivated(World worldIn, BlockPos pos, IBlockState state, EntityPlayer playerIn,
			EnumHand hand, EnumFacing facing, float hitX, float hitY, float hitZ) {
		
		p = pos;
		w = worldIn;
		

		// servidor fisico em multiplay ou logico no single? (se fosse true, então
		// está sendo executado no cliente, o que não é o certo)
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
	public int tickRate(World worldIn) {
		// TODO Auto-generated method stub
		
		if(variaveis.comandoID1 == TAGvalue) //então este objeto deve ser ativado
		{
			
			
			
			
			
		}
		
		
		return super.tickRate(worldIn);
	}


}
