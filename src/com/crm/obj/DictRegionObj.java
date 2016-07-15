package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class DictRegionObj extends BaseDbObj
{
private Long id;
private String region_code;
private String region_name;
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
	return "dict_region";
}
@Override 
public String findDefaultOrderBy()
{
	return "id asc";
}
@Override
public String getBasePath()
{
	return "DictRegion";
}
@Override
public String getCnName()
{
	return "区域";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "region_code" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

//		pros.put("id", "编号");
		pros.put("region_code", "区域编码");
		pros.put("region_name", "区域名称");
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
public String getRegion_code()
{
	return region_code;
}
public void setRegion_code(String region_code)
{
	this.region_code = region_code;
}
public String getRegion_name()
{
	return region_name;
}
public void setRegion_name(String region_name)
{
	this.region_name = region_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

