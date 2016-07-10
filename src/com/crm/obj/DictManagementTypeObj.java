package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class DictManagementTypeObj extends BaseDbObj
{
private Long id;
private String management_code;
private String management_name;
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
	return "dict_management_type";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "DictManagementType";
}
@Override
public String getCnName()
{
	return "经营类型";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "management_code" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

//		pros.put("id", "编号");
		pros.put("management_code", "经营类型编码");
		pros.put("management_name", "经营类型名称");
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
public String getManagement_code()
{
	return management_code;
}
public void setManagement_code(String management_code)
{
	this.management_code = management_code;
}
public String getManagement_name()
{
	return management_name;
}
public void setManagement_name(String management_name)
{
	this.management_name = management_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

