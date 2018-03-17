package net.shadowfacts.tutorial.block;

import java.util.Random;

import net.minecraft.block.Block;
import net.minecraft.block.material.Material;
import net.minecraft.block.state.IBlockState;
import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.Item;
import net.minecraft.item.ItemBlock;
import net.minecraft.util.math.BlockPos;
import net.minecraft.world.World;
import net.shadowfacts.tutorial.TutorialMod;

public class BlockBase extends Block {
	protected String name;

	public BlockBase(Material material, String name) {
		super(material);
		this.name = name;

		this.setUnlocalizedName(name);
		this.setRegistryName(name);
	}

	public void registerItemModel(Item itemBlock) {

		TutorialMod.proxy.registerItemRenderer(itemBlock, 0, name);

	}

	public Item createItemBlock() {

		return new ItemBlock(this).setRegistryName(this.getRegistryName());

	}

	@Override
	public BlockBase setCreativeTab(CreativeTabs tab) {

		super.setCreativeTab(tab);
		return this;

	}

	
	//Metodo que será chamado toda vez que houver alguma pertubação no bloco
	@Override
	public void neighborChanged(IBlockState state, World worldIn, BlockPos pos, Block blockIn, BlockPos fromPos) {
		// TODO Auto-generated method stub
		//System.out.println("O bloco recebeu uma pertubação"); adicionado para teste, talvez depois seja usado aqui ou em seus herdeiros
		//super.neighborChanged(state, worldIn, pos, blockIn, fromPos);
	}

	@Override
	public void updateTick(World worldIn, BlockPos pos, IBlockState state, Random rand) {
		// TODO Auto-generated method stub
		super.updateTick(worldIn, pos, state, rand);

	}
	
	
	

	
	
	
	

}
