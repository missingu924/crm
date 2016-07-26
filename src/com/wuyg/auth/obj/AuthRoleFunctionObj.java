package com.wuyg.auth.obj;

import java.sql.Timestamp;
import java.util.List;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import com.alibaba.fastjson.JSON;

public class AuthRoleFunctionObj extends BaseDbObj
{
	private Long id;
	private String rolecode;
	private String functioncode;

	@Override
	public String findKeyColumnName()
	{
		return "id";
	}

	@Override
	public String findParentKeyColumnName()
	{
		return "rolecode";
	}

	@Override
	public String findTableName()
	{
		return "auth_role_function";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "AuthRoleFunction";
	}

	@Override
	public String getCnName()
	{
		return "角色所辖权限项";
	}

	@Override
	public List<String> findUniqueIndexProperties()
	{
		return Arrays.asList(new String[]
		{ "null" });
	}

	public LinkedHashMap<String, String> findProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "流水号");
		pros.put("rolecode", "角色");
		pros.put("functioncode", "权限项");
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

	public String getRolecode()
	{
		return rolecode;
	}

	public void setRolecode(String rolecode)
	{
		this.rolecode = rolecode;
	}

	public String getFunctioncode()
	{
		return functioncode;
	}

	public void setFunctioncode(String functioncode)
	{
		this.functioncode = functioncode;
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
