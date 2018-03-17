package net.shadowfacts.tutorial.block;

import net.minecraft.block.material.Material;
import net.minecraft.creativetab.CreativeTabs;


public class BlockOre extends BlockBase {
	Material tst;

	public BlockOre(Material material, String name) {

		super(material.ROCK, name);
		// TODO Auto-generated constructor stub
		tst = material;

		this.setHardness(3f);
		this.setResistance(5f);
	}

	@Override
	public BlockOre setCreativeTab(CreativeTabs tab) {

		super.setCreativeTab(tab);
		return this;
	}

}
