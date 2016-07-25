package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class DictSubjectObj extends BaseDbObj
{
private Long id;
private String subject_code;
private String subject_name;
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
	return "dict_subject";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "DictSubject";
}
@Override
public String getCnName()
{
	return "合同主体";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "subject_code" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("subject_code", "合同主体代码");
		pros.put("subject_name", "合同主体名称");
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
public String getSubject_code()
{
	return subject_code;
}
public void setSubject_code(String subject_code)
{
	this.subject_code = subject_code;
}
public String getSubject_name()
{
	return subject_name;
}
public void setSubject_name(String subject_name)
{
	this.subject_name = subject_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

