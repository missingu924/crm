package com.wuyg.auth.obj;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.wuyg.common.dao.BaseDbObj;

public class AuthRoleObj extends BaseDbObj
{
	private Long id;
	private String rolecode;
	private String rolename;
	private String rolediscription;

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
		return "auth_role";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "AuthRole";
	}

	@Override
	public String getCnName()
	{
		return "角色";
	}

	@Override
	public List<String> findUniqueIndexProperties()
	{
		return Arrays.asList(new String[]
		{ "rolecode" });
	}

	public LinkedHashMap<String, String> findProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "流水号");
		pros.put("rolecode", "角色编码");
		pros.put("rolename", "角色名称");
		pros.put("rolediscription", "备注");
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

	public String getRolename()
	{
		return rolename;
	}

	public void setRolename(String rolename)
	{
		this.rolename = rolename;
	}

	public String getRolediscription()
	{
		return rolediscription;
	}

	public void setRolediscription(String rolediscription)
	{
		this.rolediscription = rolediscription;
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
