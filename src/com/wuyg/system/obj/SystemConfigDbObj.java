package com.wuyg.system.obj;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import com.wuyg.common.dao.BaseDbObj;

public class SystemConfigDbObj extends BaseDbObj
{
	private Long id;
	private String name;
	private String value;

	public SystemConfigDbObj()
	{
		// TODO Auto-generated constructor stub
	}
	
	public SystemConfigDbObj(String name, String value)
	{
		this.name = name;
		this.value = value;
	}

	@Override
	public String findKeyColumnName()
	{
		// TODO Auto-generated method stub
		return "id";
	}

	@Override
	public String findParentKeyColumnName()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String findTableName()
	{
		// TODO Auto-generated method stub
		return "system_config";
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}


	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getValue()
	{
		return value;
	}

	public void setValue(String value)
	{
		this.value = value;
	}

	@Override
	public String toString()
	{
		return name + "=" + value;
	}

	@Override
	public String getBasePath()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getCnName()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public LinkedHashMap<String, String> findProperties()
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<String> findUniqueIndexProperties()
	{
		List<String> l = new ArrayList<String>();
		l.add("name");
		return l;
	}

}
