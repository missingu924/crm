package com.wuyg.auth.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class AuthOfficeObj extends BaseDbObj
{
private Long id;
private String officecode;
private String officename;
private String officecomment;
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
	return "auth_office";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "AuthOffice";
}
@Override
public String getCnName()
{
	return "职务";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "officecode" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "流水号");
		pros.put("officecode", "职务编码");
		pros.put("officename", "职务名称");
		pros.put("officecomment", "备注");
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
public String getOfficecode()
{
	return officecode;
}
public void setOfficecode(String officecode)
{
	this.officecode = officecode;
}
public String getOfficename()
{
	return officename;
}
public void setOfficename(String officename)
{
	this.officename = officename;
}
public String getOfficecomment()
{
	return officecomment;
}
public void setOfficecomment(String officecomment)
{
	this.officecomment = officecomment;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

