package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class DictProductObj extends BaseDbObj
{
private Long id;
private String product_code;
private String product_name;
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
	return "dict_product";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "DictProduct";
}
@Override
public String getCnName()
{
	return "产品管理";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "product_code" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

//		pros.put("id", "编号");
		pros.put("product_code", "产品编码");
		pros.put("product_name", "产品名称");
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
public String getProduct_code()
{
	return product_code;
}
public void setProduct_code(String product_code)
{
	this.product_code = product_code;
}
public String getProduct_name()
{
	return product_name;
}
public void setProduct_name(String product_name)
{
	this.product_name = product_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

