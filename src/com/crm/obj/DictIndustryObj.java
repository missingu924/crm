package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class DictIndustryObj extends BaseDbObj
{
private Long id;
private String industry_code;
private String industry_name;
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
	return "dict_industry";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "DictIndustry";
}
@Override
public String getCnName()
{
	return "行业";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "industry_code" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

//		pros.put("id", "id");
		pros.put("industry_code", "行业编码");
		pros.put("industry_name", "行业名称");
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
public String getIndustry_code()
{
	return industry_code;
}
public void setIndustry_code(String industry_code)
{
	this.industry_code = industry_code;
}
public String getIndustry_name()
{
	return industry_name;
}
public void setIndustry_name(String industry_name)
{
	this.industry_name = industry_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

