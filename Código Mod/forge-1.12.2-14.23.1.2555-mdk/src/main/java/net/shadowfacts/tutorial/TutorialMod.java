package net.shadowfacts.tutorial;

import net.minecraft.block.Block;
import net.minecraft.item.Item;
import net.minecraftforge.client.event.ModelRegistryEvent;
import net.minecraftforge.event.RegistryEvent;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.SidedProxy;
import net.minecraftforge.fml.common.event.FMLInitializationEvent;
import net.minecraftforge.fml.common.event.FMLPostInitializationEvent;
import net.minecraftforge.fml.common.event.FMLPreInitializationEvent;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import net.minecraftforge.fml.common.registry.GameRegistry;
import net.shadowfacts.tutorial.block.ModBlocks;
import net.shadowfacts.tutorial.item.ModItems;
import net.shadowfacts.tutorial.proxy.CommonProxy;
import net.shadowfacts.tutorial.world.ModWorldGen;

@Mod(modid = TutorialMod.modId, name = TutorialMod.name, version = TutorialMod.version)
public class TutorialMod {

	public static final String modId = "tutorial";
	public static final String name = "trabalho para o Ifpa";
	public static final String version = "1.0.0";

	// manipulador de registros, este que irá gerenciar todos os registros de
	// coisas, seja item, bloco ou eventos no geral, a anotação eventsubscriber
	// permite criar metodos que criarão eventos específicos dentro do jogo
	@Mod.EventBusSubscriber
	public static class RegistrationHandler {

		// metodos criados para a adição de itens

		@SubscribeEvent
		public static void registerItems(RegistryEvent.Register<Item> event) {
			ModItems.register(event.getRegistry());
			ModBlocks.registerItemBlocks(event.getRegistry()); //para os itemblocks

		}
		
		// metodo criado para adição de blocos
		@SubscribeEvent
		public static void registerBlocks(RegistryEvent.Register<Block> event) {

			ModBlocks.register(event.getRegistry());
		}

		//metodo criado para definir os modelos
		@SubscribeEvent
		public static void registerItems(ModelRegistryEvent event) {
			ModItems.registerModels();
			ModBlocks.registerModels();

		}


	}

	@SidedProxy(serverSide = "net.shadowfacts.tutorial.proxy.CommonProxy", clientSide = "net.shadowfacts.tutorial.proxy.ClientProxy")
	public static CommonProxy proxy;

	@Mod.Instance(modId)
	public static TutorialMod instance;

	@Mod.EventHandler
	public void preInit(FMLPreInitializationEvent event) {
		GameRegistry.registerWorldGenerator(new ModWorldGen(), 3); //registar o WorldGen

	}

	@Mod.EventHandler
	public void init(FMLInitializationEvent event) {

	}

	@Mod.EventHandler
	public void postInit(FMLPostInitializationEvent event) {

	}

}
