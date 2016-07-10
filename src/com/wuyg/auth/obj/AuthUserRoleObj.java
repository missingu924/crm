package com.wuyg.auth.obj;

import java.sql.Timestamp;
import java.util.List;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import com.alibaba.fastjson.JSON;

public class AuthUserRoleObj extends BaseDbObj
{
	private Long id;
	private String useraccount;
	private String rolecode;

	@Override
	public String findKeyColumnName()
	{
		return "id";
	}

	@Override
	public String findParentKeyColumnName()
	{
		return "useraccount";
	}

	@Override
	public String findTableName()
	{
		return "auth_user_role";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "AuthUserRole";
	}

	@Override
	public String getCnName()
	{
		return "账号所辖角色";
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
		pros.put("useraccount", "账号");
		pros.put("rolecode", "角色");
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

	public String getUseraccount()
	{
		return useraccount;
	}

	public void setUseraccount(String useraccount)
	{
		this.useraccount = useraccount;
	}

	public String getRolecode()
	{
		return rolecode;
	}

	public void setRolecode(String rolecode)
	{
		this.rolecode = rolecode;
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
