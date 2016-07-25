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
	private Double c;
	private Double f;
	private Double bill_money_total;
	private Double gather_money_total;
	private Double spare_money;
	private String contract_subject;
	private String is_finished;
	private String draw_bill;
	private String bill_type;
	private String bill_company_name;
	private String bill_duty_number;
	private String bill_address;
	private String bill_telephone;
	private String bill_bank_name;
	private String bill_bank_account;
	private String record_account;
	private Timestamp record_time;
	private String comment;

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
		pros.put("contract_subject","合同主体");
		pros.put("is_finished", "是否结束");
		pros.put("draw_bill", "是否开发票");
		pros.put("bill_type", "发票类型");
		pros.put("bill_company_name","公司名称");
		pros.put("bill_duty_number","税号");
		pros.put("bill_address","地址");
		pros.put("bill_telephone","电话");
		pros.put("bill_bank_name","开户行");
		pros.put("bill_bank_account","银行账号");
		pros.put("contract_price", "合同金额");
		pros.put("c", "C");
		pros.put("f", "F");
		pros.put("bill_money_total", "累计开票");
		pros.put("gather_money_total", "累计收款");
		pros.put("spare_money", "余款");
		pros.put("record_account", "录入人");
		pros.put("record_time", "录入时间");
		pros.put("comment", "合同关键点");
		return pros;
	}

	public String getDraw_bill()
	{
		return draw_bill;
	}

	public void setDraw_bill(String draw_bill)
	{
		this.draw_bill = draw_bill;
	}

	public String getBill_type()
	{
		return bill_type;
	}

	public void setBill_type(String bill_type)
	{
		this.bill_type = bill_type;
	}


	public String getBill_company_name()
	{
		return bill_company_name;
	}

	public void setBill_company_name(String bill_company_name)
	{
		this.bill_company_name = bill_company_name;
	}

	public String getBill_duty_number()
	{
		return bill_duty_number;
	}

	public void setBill_duty_number(String bill_duty_number)
	{
		this.bill_duty_number = bill_duty_number;
	}

	public String getBill_address()
	{
		return bill_address;
	}

	public void setBill_address(String bill_address)
	{
		this.bill_address = bill_address;
	}

	public String getBill_telephone()
	{
		return bill_telephone;
	}

	public void setBill_telephone(String bill_telephone)
	{
		this.bill_telephone = bill_telephone;
	}

	public String getBill_bank_name()
	{
		return bill_bank_name;
	}

	public void setBill_bank_name(String bill_bank_name)
	{
		this.bill_bank_name = bill_bank_name;
	}

	public String getBill_bank_account()
	{
		return bill_bank_account;
	}

	public void setBill_bank_account(String bill_bank_account)
	{
		this.bill_bank_account = bill_bank_account;
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

	public String getContract_subject()
	{
		return contract_subject;
	}

	public void setContract_subject(String contract_subject)
	{
		this.contract_subject = contract_subject;
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

	public String getComment()
	{
		return comment;
	}

	public void setComment(String comment)
	{
		this.comment = comment;
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
	
	// 客户信息
	public CrmCustomerObj findCustomer()
	{
		CrmCustomerObj customer = new CrmCustomerObj();
		
		IBaseDAO dao = new DefaultBaseDAO(CrmCustomerObj.class);
		
		Object customerObj = dao.searchByKey(CrmCustomerObj.class, this.customer_id);
		if (customerObj!=null)
		{
			customer = (CrmCustomerObj)customerObj; 
		}
		
		return customer;
	}
	
}
