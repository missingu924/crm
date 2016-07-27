package com.crm.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;

public class VBillDetailObj extends BaseDbObj
{
	private Long id;
	private String gather_date;
	private String contract_id;
	private String contract_name;
	private String record_account;
	private String user_name;
	private String customer_id;
	private String customer_full_name;
	private String contract_subject;
	private String contract_sign_time;
	private Double contract_price;
	private String subject_name;
	private String management_type_code;
	private String management_name;
	private String draw_bill;
	private Double bill_money_total;
	private Double gather_money;
	private Double c;
	private Double f;
	private String comment;

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
		return "v_bill_detail";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "VBillDetail";
	}

	@Override
	public String getCnName()
	{
		return "收款明细表";
	}

	@Override
	public List<String> findUniqueIndexProperties()
	{
		return Arrays.asList(new String[]
		{ "null" });
	}

	public LinkedHashMap<String, String> findProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		// pros.put("id", "id");
		pros.put("gather_date", "收款日期");
		pros.put("contract_id", "合同");
		pros.put("contract_name", "合同");
		pros.put("user_name", "录合同人");
		pros.put("record_account", "录合同人");
		pros.put("customer_id", "客户");
		pros.put("customer_full_name", "客户");
		pros.put("contract_subject", "合同主体");
		pros.put("subject_name", "合同主体");
		pros.put("contract_sign_time", "合同日期");
		pros.put("contract_price", "合同金额");
		pros.put("management_type_code", "经营类型");
		pros.put("management_name", "经营类型");
		pros.put("draw_bill", "是否开发票");
		pros.put("bill_money_total", "累计开票金额");
		pros.put("gather_money", "本次收款金额");
		pros.put("c", "C");
		pros.put("f", "F");
		pros.put("comment", "备注");
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

	public String getGather_date()
	{
		return gather_date;
	}

	public String getManagement_type_code()
	{
		return management_type_code;
	}

	public void setManagement_type_code(String management_type_code)
	{
		this.management_type_code = management_type_code;
	}

	public void setGather_date(String gather_date)
	{
		this.gather_date = gather_date;
	}

	public String getContract_sign_time()
	{
		return contract_sign_time;
	}

	public void setContract_sign_time(String contract_sign_time)
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

	public String getContract_name()
	{
		return contract_name;
	}

	public void setContract_name(String contract_name)
	{
		this.contract_name = contract_name;
	}

	public String getCustomer_id()
	{
		return customer_id;
	}

	public void setCustomer_id(String customer_id)
	{
		this.customer_id = customer_id;
	}

	public String getContract_id()
	{
		return contract_id;
	}

	public void setContract_id(String contract_id)
	{
		this.contract_id = contract_id;
	}

	public String getUser_name()
	{
		return user_name;
	}

	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}

	public String getCustomer_full_name()
	{
		return customer_full_name;
	}

	public void setCustomer_full_name(String customer_full_name)
	{
		this.customer_full_name = customer_full_name;
	}

	public String getSubject_name()
	{
		return subject_name;
	}

	public void setSubject_name(String subject_name)
	{
		this.subject_name = subject_name;
	}

	public String getManagement_name()
	{
		return management_name;
	}

	public void setManagement_name(String management_name)
	{
		this.management_name = management_name;
	}

	public String getDraw_bill()
	{
		return draw_bill;
	}

	public void setDraw_bill(String draw_bill)
	{
		this.draw_bill = draw_bill;
	}

	public Double getBill_money_total()
	{
		return bill_money_total;
	}

	public String getContract_subject()
	{
		return contract_subject;
	}

	public void setContract_subject(String contract_subject)
	{
		this.contract_subject = contract_subject;
	}

	public void setBill_money_total(Double bill_money_total)
	{
		this.bill_money_total = bill_money_total;
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

	public Double getC()
	{
		return c;
	}

	public void setC(Double c)
	{
		this.c = c;
	}

	public Double getF()
	{
		return f;
	}

	public void setF(Double f)
	{
		this.f = f;
	}

	public String getComment()
	{
		return comment;
	}

	public void setComment(String comment)
	{
		this.comment = comment;
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
