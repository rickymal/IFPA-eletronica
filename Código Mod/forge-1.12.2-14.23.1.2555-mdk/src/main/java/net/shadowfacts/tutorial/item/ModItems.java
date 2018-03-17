package net.shadowfacts.tutorial.item;

import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.Item;
import net.minecraftforge.registries.IForgeRegistry;

//esta classe contem uma  instancia de todos os itens registrados
public class ModItems {
	
	//Um tem sendo criado
	public static ItemBase ingotCopper = new ItemBase("ingot_copper").setCreativeTab(CreativeTabs.MATERIALS);

	public static void register(IForgeRegistry<Item> registry) {
		
		registry.registerAll(ingotCopper);
		

	}

	public static void registerModels() {
		ingotCopper.registerItemModel();

	}

}
