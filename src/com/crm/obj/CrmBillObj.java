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
private String customer_id;
private String commerical_opportunity_id;
private String contract_id;
private String comment;
private Double bill_money;
private Timestamp bill_date;
private String bill_number;
private String bill_receipt;
private Double gather_money;
private Timestamp gather_date;
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
		pros.put("comment", "备注");
		pros.put("bill_money", "本次开票金额");
		pros.put("bill_date", "本次开票日期");
		pros.put("gather_money", "本次收款金额");
		pros.put("gather_date", "本次收款日期");
		pros.put("bill_number", "发票号");
		pros.put("bill_receipt", "发票签收已回");
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
public String getCustomer_id()
{
	return customer_id;
}
public void setCustomer_id(String customer_id)
{
	this.customer_id = customer_id;
}
public String getCommerical_opportunity_id()
{
	return commerical_opportunity_id;
}

public Timestamp getBill_date()
{
	return bill_date;
}
public void setBill_date(Timestamp bill_date)
{
	this.bill_date = bill_date;
}
public String getBill_number()
{
	return bill_number;
}
public void setBill_number(String bill_number)
{
	this.bill_number = bill_number;
}
public String getBill_receipt()
{
	return bill_receipt;
}
public void setBill_receipt(String bill_receipt)
{
	this.bill_receipt = bill_receipt;
}
public Timestamp getGather_date()
{
	return gather_date;
}
public void setGather_date(Timestamp gather_date)
{
	this.gather_date = gather_date;
}
public String getComment()
{
	return comment;
}
public void setComment(String comment)
{
	this.comment = comment;
}
public void setCommerical_opportunity_id(String commerical_opportunity_id)
{
	this.commerical_opportunity_id = commerical_opportunity_id;
}
public String getContract_id()
{
	return contract_id;
}
public void setContract_id(String contract_id)
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

