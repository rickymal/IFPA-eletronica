package net.shadowfacts.tutorial.block;

import net.minecraft.block.Block;
import net.minecraft.block.material.Material;
import net.minecraft.client.Minecraft;
import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.Item;
import net.minecraftforge.fml.common.registry.GameRegistry;
import net.minecraftforge.registries.IForgeRegistry;
import net.shadowfacts.tutorial.block.counter.BlockCounter;
import net.shadowfacts.tutorial.block.counter.BlockCounterv2;

//conceito identico ao itemBlock (adicionar os blocos)
public class ModBlocks {

	public static BlockOre oreCopper = new BlockOre(Material.ROCK ,"ore_copper").setCreativeTab(CreativeTabs.MATERIALS);
	public static BlockCounter counter = new BlockCounter();
	public static BlockCounterv2 newcounter = new BlockCounterv2(null, null);
	Minecraft oJogo;
	
	public static void register(IForgeRegistry<Block> registry) {
		registry.registerAll(oreCopper,counter);
		
		//registrando TileEntity
		GameRegistry.registerTileEntity(counter.getTileEntityClass(), counter.getRegistryName().toString());
		//GameRegistry.registerTileEntity(newcounter.getTileEntityClass(), newcounter.getRegistryName().toString());

	}

	public static void registerItemBlocks(IForgeRegistry<Item> registry) {

		registry.registerAll(oreCopper.createItemBlock(), counter.createItemBlock(), newcounter.createItemBlock());

	}

	public static void registerModels() {
		oreCopper.registerItemModel(Item.getItemFromBlock(oreCopper));
		counter.registerItemModel(Item.getItemFromBlock(counter)); //talvez seja isso
		//newcounter.registerItemModel(Item.getItemFromBlock(newcounter));
		//counter.registerBlocks();
		

	}

}
