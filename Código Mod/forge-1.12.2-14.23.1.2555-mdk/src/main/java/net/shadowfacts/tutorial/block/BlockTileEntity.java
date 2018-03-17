package net.shadowfacts.tutorial.block;

import javax.annotation.Nullable;

import net.minecraft.block.material.Material;
import net.minecraft.block.state.IBlockState;
import net.minecraft.tileentity.TileEntity;
import net.minecraft.util.math.BlockPos;
import net.minecraft.world.IBlockAccess;
import net.minecraft.world.World;
import net.shadowfacts.tutorial.block.counter.TileEntityCounter;

/*A classe herda de BlockBase, ou seja, tem todos os m�todos auxiliares
 *  utilizados para a cria��o de um bloco. O gen�rito TE � o tipo da tile entity 
 *  que ser� utilizado
 */
public abstract class BlockTileEntity<TE extends TileEntity> extends BlockBase {
	public TileEntityCounter tile;

	public BlockTileEntity(Material material, String name) {
		super(material, name);
		// TODO Auto-generated constructor stub
	}

	public abstract Class<TE> getTileEntityClass();

	// Obtem o referido bloco em uma posi��o espec�fica (ou seja, os dados deste
	// respectivo bloco no mundo)
	public TE getTileEntity(IBlockAccess world, BlockPos pos) {
		tile = (TileEntityCounter) world.getTileEntity(pos);
		return (TE) world.getTileEntity(pos);

	}

	// O bloco em quest�o tem uma tile entity (afirmando = true)
	@Override
	public boolean hasTileEntity(IBlockState state) {

		return true;
	}

	// este m�todo ser� chamado para dentro do jogo toda vez que um bloco com tile
	// entity for posto
	@Nullable
	@Override
	public abstract TE createTileEntity(World world, IBlockState state);
	
	

}
