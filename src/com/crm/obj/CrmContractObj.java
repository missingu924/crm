package com.crm.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;

import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;

public class CrmContractObj extends BaseDbObj
{
	private Long id;
	private String customer_id;
	private String commercial_oppotunity_id;
	private String contract_name;
	private Timestamp contract_sign_time;
	private Double contract_price;
	private Double bill_money_total;
	private Double gather_money_total;
	private Double spare_money;
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
		return "commercial_oppotunity_id";
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
		pros.put("commercial_oppotunity_id", "商机");
		pros.put("contract_name", "合同名称");
		pros.put("contract_sign_time", "签订日期");
		pros.put("contract_price", "合同金额");
		pros.put("bill_money_total", "累计开票");
		pros.put("gather_money_total", "累计收款");
		pros.put("spare_money", "余款");
		pros.put("is_finished", "合同是否结束");
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

	public String getCommercial_oppotunity_id()
	{
		return commercial_oppotunity_id;
	}

	public void setCommercial_oppotunity_id(String commercial_oppotunity_id)
	{
		this.commercial_oppotunity_id = commercial_oppotunity_id;
	}

	public String getContract_name()
	{
		return contract_name;
	}

	public void setContract_name(String contract_name)
	{
		this.contract_name = contract_name;
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

	public Double getSpare_money()
	{
		return spare_money;
	}

	public void setSpare_money(Double spare_money)
	{
		this.spare_money = spare_money;
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
	
	// 开票收款
	public List<CrmBillObj> findBillList()
	{
		IBaseDAO dao = new DefaultBaseDAO(CrmBillObj.class);

		return dao.searchByClause(CrmBillObj.class, "contract_id='" + this.id + "'", "id desc", 0, Integer.MAX_VALUE);
	}
	
}
