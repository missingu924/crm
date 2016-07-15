package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class DictSaleStageObj extends BaseDbObj
{
private Long id;
private String sale_stage_code;
private String sale_stage_name;
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
	return "dict_sale_stage";
}
@Override 
public String findDefaultOrderBy()
{
	return "id asc";
}
@Override
public String getBasePath()
{
	return "DictSaleStage";
}
@Override
public String getCnName()
{
	return "销售阶段";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "sale_stage_code" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

//		pros.put("id", "编号");
		pros.put("sale_stage_code", "销售阶段编码");
		pros.put("sale_stage_name", "销售阶段名称");
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
public String getSale_stage_code()
{
	return sale_stage_code;
}
public void setSale_stage_code(String sale_stage_code)
{
	this.sale_stage_code = sale_stage_code;
}
public String getSale_stage_name()
{
	return sale_stage_name;
}
public void setSale_stage_name(String sale_stage_name)
{
	this.sale_stage_name = sale_stage_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

