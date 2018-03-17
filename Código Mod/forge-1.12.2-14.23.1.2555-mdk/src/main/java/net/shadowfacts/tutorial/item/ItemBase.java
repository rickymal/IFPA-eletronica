package net.shadowfacts.tutorial.item;

import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.Item;
import net.shadowfacts.tutorial.TutorialMod;

public class ItemBase extends Item { // Objeto que será responsável por adicionar um item novo
	protected String name;

	public ItemBase(String name) {
		this.name = name;
		this.setUnlocalizedName(name);
		this.setRegistryName(name);
	}

	public void registerItemModel() {
		TutorialMod.proxy.registerItemRenderer(this, 0, name);

	}

	@Override
	public ItemBase setCreativeTab(CreativeTabs tab) { // Metodo sobrescrito para retonar uma ItemBase em vez de uma
														// Item, isto evita que o mesmo tenha que ser "casteado caso
														// necessário mais na frente"

		super.setCreativeTab(tab);
		return this;
	}

}
