package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class DictCustomerTypeObj extends BaseDbObj
{
private Long id;
private String customer_type_code;
private String customer_type_name;
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
	return "dict_customer_type";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "DictCustomerType";
}
@Override
public String getCnName()
{
	return "客户分类";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "customer_type_code" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

//		pros.put("id", "编号");
		pros.put("customer_type_code", "客户分类编码");
		pros.put("customer_type_name", "客户分类名称");
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
public String getCustomer_type_code()
{
	return customer_type_code;
}
public void setCustomer_type_code(String customer_type_code)
{
	this.customer_type_code = customer_type_code;
}
public String getCustomer_type_name()
{
	return customer_type_name;
}
public void setCustomer_type_name(String customer_type_name)
{
	this.customer_type_name = customer_type_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

