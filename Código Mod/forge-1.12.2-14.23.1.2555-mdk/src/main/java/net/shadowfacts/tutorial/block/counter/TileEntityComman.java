package net.shadowfacts.tutorial.block.counter;

import net.minecraft.nbt.NBTTagCompound;
import net.minecraft.tileentity.TileEntity;
import net.minecraft.world.World;

public class TileEntityComman extends TileEntity {
	
	String comando = "";
	

	@Override
	public World getWorld() {
		// TODO Auto-generated method stub
		return super.getWorld();
	}

	@Override
	public void readFromNBT(NBTTagCompound compound) {
		// TODO Auto-generated method stub
		comando = compound.getString("comando");
		super.readFromNBT(compound);
	}

	@Override
	public NBTTagCompound writeToNBT(NBTTagCompound compound) {
		// TODO Auto-generated method stub
		
		compound.setString("comando", comando);
		return super.writeToNBT(compound);
	}

	@Override
	public void markDirty() {
		// TODO Auto-generated method stub
		super.markDirty();
	}

}
