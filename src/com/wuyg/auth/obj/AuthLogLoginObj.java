package com.wuyg.auth.obj;

import java.sql.Timestamp;
import java.util.List;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import com.alibaba.fastjson.JSON;

public class AuthLogLoginObj extends BaseDbObj
{
	private Long id;
	private String useraccount;
	private String username;
	private String userdistrict;
	private String userdepartmentcode;
	private Timestamp timestamp;

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
		return "auth_log_login";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "AuthLogLogin";
	}

	@Override
	public String getCnName()
	{
		return "登录日志";
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
		pros.put("username", "姓名");
		// pros.put("userdistrict", "userdistrict");
		// pros.put("userdepartmentid", "userdepartmentid");
		pros.put("userdepartmentcode", "部门");
		pros.put("timestamp", "登录时间");
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

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getUserdistrict()
	{
		return userdistrict;
	}

	public void setUserdistrict(String userdistrict)
	{
		this.userdistrict = userdistrict;
	}


	public String getUserdepartmentcode()
	{
		return userdepartmentcode;
	}

	public void setUserdepartmentcode(String userdepartmentcode)
	{
		this.userdepartmentcode = userdepartmentcode;
	}

	public Timestamp getTimestamp()
	{
		return timestamp;
	}

	public void setTimestamp(Timestamp timestamp)
	{
		this.timestamp = timestamp;
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
