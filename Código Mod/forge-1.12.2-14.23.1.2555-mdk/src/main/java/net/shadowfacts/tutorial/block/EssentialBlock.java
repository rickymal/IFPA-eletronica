package net.shadowfacts.tutorial.block;

import net.minecraft.block.material.Material;
import net.minecraft.block.state.IBlockState;
import net.minecraft.world.World;
import net.shadowfacts.tutorial.block.counter.TileEntityComman;
import net.shadowfacts.tutorial.block.counter.TileEntityCounter;

public class EssentialBlock  extends BlockTileEntity<TileEntityComman> {

	public EssentialBlock(Material material, String name) {
		super(material, name);
		// TODO Auto-generated constructor stub
	}

	@Override
	public Class<TileEntityComman> getTileEntityClass() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TileEntityComman createTileEntity(World world, IBlockState state) {
		// TODO Auto-generated method stub
		return null;
	}

}
