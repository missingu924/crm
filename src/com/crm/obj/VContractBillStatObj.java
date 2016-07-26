package com.crm.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;

public class VContractBillStatObj extends BaseDbObj
{
	private Long id;
	private String contract_name;
	private String management_name;
	private String contract_sign_time;
	private String bill_number;
	private String bill_date;
	private String user_name;
	private String customer_id;
	private String customer_full_name;
	private Double contract_price;
	private Double bill_money;
	private String gather_date;
	private Double gather_money;
	private Double bill_receivable;
	private Double contract__receivable;
	private Double c;
	private Double f;

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
		return "v_contract_bill_stat";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "VContractBillStat";
	}

	@Override
	public String getCnName()
	{
		return "合同开票收款统计表";
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
		pros.put("contract_name", "合同");
		pros.put("management_name", "经营类型");
		pros.put("contract_sign_time", "合同日期");
		pros.put("bill_number", "发票号");
		pros.put("bill_date", "发票日期");
		pros.put("user_name", "录合同人");
		pros.put("customer_full_name", "公司名称");
		pros.put("contract_price", "合同金额");
		pros.put("bill_money", "累计开票金额");
		pros.put("gather_date", "收款日期");
		pros.put("gather_money", "累计收款金额");
		pros.put("bill_receivable", "发票应收账款");
		pros.put("contract__receivable", "合同应收");
		pros.put("c", "C");
		pros.put("f", "F");
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

	public String getManagement_name()
	{
		return management_name;
	}

	public String getContract_name()
	{
		return contract_name;
	}

	public void setContract_name(String contract_name)
	{
		this.contract_name = contract_name;
	}

	public void setManagement_name(String management_name)
	{
		this.management_name = management_name;
	}

	public String getContract_sign_time()
	{
		return contract_sign_time;
	}

	public String getCustomer_id()
	{
		return customer_id;
	}

	public void setCustomer_id(String customer_id)
	{
		this.customer_id = customer_id;
	}

	public void setContract_sign_time(String contract_sign_time)
	{
		this.contract_sign_time = contract_sign_time;
	}

	public String getBill_number()
	{
		return bill_number;
	}

	public void setBill_number(String bill_number)
	{
		this.bill_number = bill_number;
	}

	public String getBill_date()
	{
		return bill_date;
	}

	public void setBill_date(String bill_date)
	{
		this.bill_date = bill_date;
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

	public Double getContract_price()
	{
		return contract_price;
	}

	public void setContract_price(Double contract_price)
	{
		this.contract_price = contract_price;
	}

	public Double getBill_money()
	{
		return bill_money;
	}

	public void setBill_money(Double bill_money)
	{
		this.bill_money = bill_money;
	}

	public String getGather_date()
	{
		return gather_date;
	}

	public void setGather_date(String gather_date)
	{
		this.gather_date = gather_date;
	}

	public Double getGather_money()
	{
		return gather_money;
	}

	public void setGather_money(Double gather_money)
	{
		this.gather_money = gather_money;
	}

	public Double getBill_receivable()
	{
		return bill_receivable;
	}

	public void setBill_receivable(Double bill_receivable)
	{
		this.bill_receivable = bill_receivable;
	}

	public Double getContract__receivable()
	{
		return contract__receivable;
	}

	public void setContract__receivable(Double contract__receivable)
	{
		this.contract__receivable = contract__receivable;
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

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
