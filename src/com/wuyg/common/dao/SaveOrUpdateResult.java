package com.wuyg.common.dao;

public class SaveOrUpdateResult
{
	private boolean saveSuccess;// 保存结果
	private long savedRows;// 保存的行数

	private boolean updateSuccess;// 更新结果
	private long updatedRows;// 更新的行数

	public boolean isSaveSuccess()
	{
		return saveSuccess;
	}

	public void setSaveSuccess(boolean saveSuccess)
	{
		this.saveSuccess = saveSuccess;
	}

	public long getSavedRows()
	{
		return savedRows;
	}

	public void setSavedRows(long savedRows)
	{
		this.savedRows = savedRows;
	}

	public boolean isUpdateSuccess()
	{
		return updateSuccess;
	}

	public void setUpdateSuccess(boolean updateSuccess)
	{
		this.updateSuccess = updateSuccess;
	}

	public long getUpdatedRows()
	{
		return updatedRows;
	}

	public void setUpdatedRows(long updatedRows)
	{
		this.updatedRows = updatedRows;
	}

	public boolean isSuccess()
	{
		return saveSuccess || updateSuccess;
	}

	@Override
	public String toString()
	{
		if (savedRows > 0 || updatedRows > 0)
		{
			String s = "本次共";

			if (isSaveSuccess())
			{
				s += "新增" + savedRows + "条数据,";
			}

			if (isUpdateSuccess())
			{
				s += "更新" + updatedRows + "条数据,";
			}

			return s + "执行完成";
		} else
		{
			return "本次未执行任何操作";
		}
	}

}
