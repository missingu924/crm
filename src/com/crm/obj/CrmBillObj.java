package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class CrmBillObj extends BaseDbObj
{
private Long id;
private Long customer_id;
private Long commerical_opportunity_id;
private Long contract_id;
private Double bill_money;
private Double gather_money;
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
	return "contract_id";
}
@Override
public String findTableName()
{
	return "crm_bill";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "CrmBill";
}
@Override
public String getCnName()
{
	return "开票收款";
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
		pros.put("commerical_opportunity_id", "商机");
		pros.put("contract_id", "合同");
		pros.put("bill_money", "本次开票金额");
		pros.put("gather_money", "本次收款金额");
		pros.put("record_account", "录入人");
		pros.put("record_time", "录入时间");
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
public Long getCustomer_id()
{
	return customer_id;
}
public void setCustomer_id(Long customer_id)
{
	this.customer_id = customer_id;
}
public Long getCommerical_opportunity_id()
{
	return commerical_opportunity_id;
}
public void setCommerical_opportunity_id(Long commerical_opportunity_id)
{
	this.commerical_opportunity_id = commerical_opportunity_id;
}
public Long getContract_id()
{
	return contract_id;
}
public void setContract_id(Long contract_id)
{
	this.contract_id = contract_id;
}
public Double getBill_money()
{
	return bill_money;
}
public void setBill_money(Double bill_money)
{
	this.bill_money = bill_money;
}
public Double getGather_money()
{
	return gather_money;
}
public void setGather_money(Double gather_money)
{
	this.gather_money = gather_money;
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

