package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class CrmContractObj extends BaseDbObj
{
private Long id;
private Long customer_id;
private Long commerical_opportunity_id;
private String contract_name;
private Timestamp contract_sign_time;
private Double contract_price;
private Double bill_money_total;
private Double gather_money_total;
private String is_finished;
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
	return "commerical_opportunity_id";
}
@Override
public String findTableName()
{
	return "crm_contract";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "CrmContract";
}
@Override
public String getCnName()
{
	return "合同";
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
		pros.put("contract_name", "合同名称");
		pros.put("contract_sign_time", "合同签订日期");
		pros.put("contract_price", "合同金额");
		pros.put("bill_money_total", "累计已开发票金额");
		pros.put("gather_money_total", "累计收款金额");
		pros.put("is_finished", "是否结束");
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
public String getContract_name()
{
	return contract_name;
}
public void setContract_name(String contract_name)
{
	this.contract_name = contract_name;
}
public void setCommerical_opportunity_id(Long commerical_opportunity_id)
{
	this.commerical_opportunity_id = commerical_opportunity_id;
}
public Timestamp getContract_sign_time()
{
	return contract_sign_time;
}
public void setContract_sign_time(Timestamp contract_sign_time)
{
	this.contract_sign_time = contract_sign_time;
}
public Double getContract_price()
{
	return contract_price;
}
public void setContract_price(Double contract_price)
{
	this.contract_price = contract_price;
}
public Double getBill_money_total()
{
	return bill_money_total;
}
public void setBill_money_total(Double bill_money_total)
{
	this.bill_money_total = bill_money_total;
}
public Double getGather_money_total()
{
	return gather_money_total;
}
public void setGather_money_total(Double gather_money_total)
{
	this.gather_money_total = gather_money_total;
}
public String getIs_finished()
{
	return is_finished;
}
public void setIs_finished(String is_finished)
{
	this.is_finished = is_finished;
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

