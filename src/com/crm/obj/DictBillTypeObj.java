package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class DictBillTypeObj extends BaseDbObj
{
private Long id;
private String bill_type_code;
private String bill_type_name;
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
	return "dict_bill_type";
}
@Override 
public String findDefaultOrderBy()
{
	return "id asc";
}
@Override
public String getBasePath()
{
	return "DictBillType";
}
@Override
public String getCnName()
{
	return "收款类型";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "bill_type_code" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

//		pros.put("id", "编号");
		pros.put("bill_type_code", "收款类型编码");
		pros.put("bill_type_name", "收款类型名称");
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
public String getBill_type_code()
{
	return bill_type_code;
}
public void setBill_type_code(String bill_type_code)
{
	this.bill_type_code = bill_type_code;
}
public String getBill_type_name()
{
	return bill_type_name;
}
public void setBill_type_name(String bill_type_name)
{
	this.bill_type_name = bill_type_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

