package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class DictProductVersionObj extends BaseDbObj
{
private Long id;
private String version_code;
private String version_name;
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
	return "dict_product_version";
}
@Override 
public String findDefaultOrderBy()
{
	return "id asc";
}
@Override
public String getBasePath()
{
	return "DictProductVersion";
}
@Override
public String getCnName()
{
	return "产品版本管理";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "version_code" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

//		pros.put("id", "编号");
		pros.put("version_code", "版本编码");
		pros.put("version_name", "版本名称");
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
public String getVersion_code()
{
	return version_code;
}
public void setVersion_code(String version_code)
{
	this.version_code = version_code;
}
public String getVersion_name()
{
	return version_name;
}
public void setVersion_name(String version_name)
{
	this.version_name = version_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

