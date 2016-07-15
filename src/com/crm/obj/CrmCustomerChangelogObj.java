package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class CrmCustomerChangelogObj extends BaseDbObj
{
private Long id;
private String customer_id;
private String change_log;
private String record_account;
private Timestamp record_time;
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
	return "crm_customer_changelog";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "CrmCustomerChangelog";
}
@Override
public String getCnName()
{
	return "客户档案变更记录";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "id" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("customer_id", "客户");
		pros.put("change_log", "变更记录");
		pros.put("record_account", "变更人");
		pros.put("record_time", "变更时间");
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
public String getCustomer_id()
{
	return customer_id;
}
public void setCustomer_id(String customer_id)
{
	this.customer_id = customer_id;
}
public String getChange_log()
{
	return change_log;
}
public void setChange_log(String change_log)
{
	this.change_log = change_log;
}
public String getRecord_account()
{
	return record_account;
}
public void setRecord_account(String record_account)
{
	this.record_account = record_account;
}
public Timestamp getRecord_time()
{
	return record_time;
}
public void setRecord_time(Timestamp record_time)
{
	this.record_time = record_time;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

