package com.wuyg.auth.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class AuthLogOperationObj extends BaseDbObj
{
private Long id;
private String useraccount;
private String username;
private String userdepartmentcode;
private String module_name;
private String module_method;
private String full_info;
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
	return "auth_log_operation";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "AuthLogOperation";
}
@Override
public String getCnName()
{
	return "操作日志";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "id" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("useraccount", "登录账号");
		pros.put("username", "用户名");
		pros.put("userdepartmentcode", "部门");
		pros.put("module_name", "模块");
		pros.put("module_method", "操作名");
		pros.put("full_info", "操作信息");
		pros.put("timestamp", "操作时间");
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
public String getUserdepartmentcode()
{
	return userdepartmentcode;
}
public void setUserdepartmentcode(String userdepartmentcode)
{
	this.userdepartmentcode = userdepartmentcode;
}
public String getModule_name()
{
	return module_name;
}
public void setModule_name(String module_name)
{
	this.module_name = module_name;
}
public String getModule_method()
{
	return module_method;
}
public void setModule_method(String module_method)
{
	this.module_method = module_method;
}
public String getFull_info()
{
	return full_info;
}
public void setFull_info(String full_info)
{
	this.full_info = full_info;
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

