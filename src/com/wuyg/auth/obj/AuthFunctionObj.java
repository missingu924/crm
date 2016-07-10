package com.wuyg.auth.obj;

import java.sql.Timestamp;
import java.util.List;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import com.alibaba.fastjson.JSON;

public class AuthFunctionObj extends BaseDbObj
{
	private Long id;
	private String functioncode;
	private String functionname;
	private String functiondiscription;

	@Override
	public String findKeyColumnName()
	{
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
		return "auth_function";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "AuthFunction";
	}

	@Override
	public String getCnName()
	{
		return "权限项";
	}

	@Override
	public List<String> findUniqueIndexProperties()
	{
		return Arrays.asList(new String[]
		{ "functioncode" });
	}

	public LinkedHashMap<String, String> findProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "流水号");
		pros.put("functioncode", "权限项编码");
		pros.put("functionname", "权限项名称");
		pros.put("functiondiscription", "备注");
		return pros;
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getFunctioncode()
	{
		return functioncode;
	}

	public void setFunctioncode(String functioncode)
	{
		this.functioncode = functioncode;
	}

	public String getFunctionname()
	{
		return functionname;
	}

	public void setFunctionname(String functionname)
	{
		this.functionname = functionname;
	}

	public String getFunctiondiscription()
	{
		return functiondiscription;
	}

	public void setFunctiondiscription(String functiondiscription)
	{
		this.functiondiscription = functiondiscription;
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
