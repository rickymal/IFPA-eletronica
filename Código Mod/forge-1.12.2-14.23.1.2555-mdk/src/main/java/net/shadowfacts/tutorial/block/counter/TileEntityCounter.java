package net.shadowfacts.tutorial.block.counter;

import net.minecraft.nbt.NBTTagCompound;
import net.minecraft.tileentity.TileEntity;

//é uma extenção do TileEntity, ou seja, o minecraft saberá o que fazer com essa classe
public class TileEntityCounter extends TileEntity {
	
	public int count;
	public boolean ativado = false;
	
	public int getTileEntityCounter()
	{
		return count;
	}
	
	public void setTileEntityCounter(int count)
	{
		this.count =  count;
	}
	
	public void setPowerTag(Boolean b)
	{
		ativado = b;
	}
	
	public boolean getPowerTag()
	{
		return ativado;
	}
	
	
	public TileEntityCounter getTileEntityForTag()
	{
		return this;
	}

	public void decrementCount() {
		// TODO Auto-generated method stub
		count--;
		this.markDirty(); //método que diz ao minecraft que as tileEntity do objeto foram alteradas
		
	}

	public void incrementCount() {
		// TODO Auto-generated method stub
		count++;
		this.markDirty();
		
	}

	public int getCount() {
		// TODO Auto-generated method stub
		return count;
	}
	
	//gravará os dados do computador em NBT para persistência de dados
	@Override
	public NBTTagCompound writeToNBT(NBTTagCompound compound)
	{
		compound.setInteger("count", count);
		return super.writeToNBT(compound);
		
	
	}
	
	//procurará os referidos dados NBT's assim que o servidor for ligado de novo
	@Override
	public void readFromNBT(NBTTagCompound compound)
	{
		
		count = compound.getInteger("count");
		
		super.readFromNBT(compound);
	}

}
