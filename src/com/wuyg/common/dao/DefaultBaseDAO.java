package com.wuyg.common.dao;

import java.util.List;

import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.util.SystemConstant;

public class DefaultBaseDAO extends AbstractBaseDAOTemplate
{
	private BaseDbObj baseDbObject;

	public DefaultBaseDAO(BaseDbObj baseDbObject)
	{
		this(baseDbObject, SystemConstant.DEFAULT_DB);// 默认连接SystemConfig.xml里面的db数据库
	}

	public DefaultBaseDAO(BaseDbObj baseDbObject, String dbName)
	{
		this.baseDbObject = baseDbObject;
		this.dbName = dbName;
	}

	public DefaultBaseDAO(Class clz)
	{
		this(clz, SystemConstant.DEFAULT_DB);
	}

	public DefaultBaseDAO(Class clz, String dbName)
	{
		try
		{
			this.baseDbObject = (BaseDbObj) clz.newInstance();
			this.dbName = dbName;
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	@Override
	public String getKeyColumnName()
	{
		return baseDbObject.findKeyColumnName();
	}

	@Override
	public String getParentKeyColumnName()
	{
		return baseDbObject.findParentKeyColumnName();
	}

	@Override
	public String getTableName()
	{
		return baseDbObject.findTableName();
	}
	
	@Override
	public List<String> getUniqueIndexColumns()
	{
		return baseDbObject.findUniqueIndexProperties();
	}
	
	@Override
	public String getDbType()
	{
		return dbType;
	}

	@Override
	public String getDbName()
	{
		return dbName;
	}	
}
