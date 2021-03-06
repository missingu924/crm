package com.crm.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;

import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;

public class CrmCommercialOpportunityObj extends BaseDbObj
{
	private Long id;
	private String customer_id;
	private String opportunity_name;
	private String management_type_code;
	private String sale_stage_code;
	private Double target_price;
	private Timestamp estimate_sign_time;
	private String management_account;
	private String source;
	private String customer_request;
	private String next_step;
	private String record_account;
	private Timestamp record_time;
	private String product_code;
	private String product_version_code;
	private String customer_region_code;
	private String customer_is_deal;
	

	@Override
	public String findKeyColumnName()
	{
		return "id";
	}

	@Override
	public String findParentKeyColumnName()
	{
		return "customer_id";
	}

	@Override
	public String findTableName()
	{
		return "crm_commercial_opportunity";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return "id desc";
	}

	@Override
	public String getBasePath()
	{
		return "CrmCommercialOpportunity";
	}

	@Override
	public String getCnName()
	{
		return "商机";
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
		pros.put("management_type_code", "经营类型");
		pros.put("opportunity_name", "商机名称");
		pros.put("sale_stage_code", "销售阶段");
		pros.put("target_price", "目标金额");
		pros.put("estimate_sign_time", "预计签约日期");
		pros.put("management_account", "经营人");
		pros.put("product_code", "销售产品");
		pros.put("product_version_code", "销售产品版本");
		pros.put("source", "信息来源");
		pros.put("customer_request", "客户需求");
		pros.put("next_step", "下一步计划");
		pros.put("record_account", "录入人");
		pros.put("record_time", "录入时间");
		pros.put("customer_region_code", "区域");
		pros.put("customer_is_deal", "成交客户");
		return pros;
	}

	public String getCustomer_region_code()
	{
		return customer_region_code;
	}

	public void setCustomer_region_code(String customer_region_code)
	{
		this.customer_region_code = customer_region_code;
	}

	public String getCustomer_is_deal()
	{
		return customer_is_deal;
	}

	public void setCustomer_is_deal(String customer_is_deal)
	{
		this.customer_is_deal = customer_is_deal;
	}

	public String getProduct_code()
	{
		return product_code;
	}

	public void setProduct_code(String product_code)
	{
		this.product_code = product_code;
	}

	public String getProduct_version_code()
	{
		return product_version_code;
	}

	public void setProduct_version_code(String product_version_code)
	{
		this.product_version_code = product_version_code;
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getOpportunity_name()
	{
		return opportunity_name;
	}

	public void setOpportunity_name(String opportunity_name)
	{
		this.opportunity_name = opportunity_name;
	}

	public String getCustomer_id()
	{
		return customer_id;
	}

	public String getSource()
	{
		return source;
	}

	public void setSource(String source)
	{
		this.source = source;
	}

	public void setCustomer_id(String customer_id)
	{
		this.customer_id = customer_id;
	}

	public String getManagement_type_code()
	{
		return management_type_code;
	}

	public void setManagement_type_code(String management_type_code)
	{
		this.management_type_code = management_type_code;
	}

	public String getSale_stage_code()
	{
		return sale_stage_code;
	}

	public void setSale_stage_code(String sale_stage_code)
	{
		this.sale_stage_code = sale_stage_code;
	}

	public Double getTarget_price()
	{
		return target_price;
	}

	public void setTarget_price(Double target_price)
	{
		this.target_price = target_price;
	}

	public Timestamp getEstimate_sign_time()
	{
		return estimate_sign_time;
	}

	public void setEstimate_sign_time(Timestamp estimate_sign_time)
	{
		this.estimate_sign_time = estimate_sign_time;
	}

	public String getManagement_account()
	{
		return management_account;
	}

	public void setManagement_account(String management_account)
	{
		this.management_account = management_account;
	}

	public String getCustomer_request()
	{
		return customer_request;
	}

	public void setCustomer_request(String customer_request)
	{
		this.customer_request = customer_request;
	}

	public String getNext_step()
	{
		return next_step;
	}

	public void setNext_step(String next_step)
	{
		this.next_step = next_step;
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

	// 经营活动
	public List<CrmManagementActivityObj> findActivityList()
	{
		IBaseDAO dao = new DefaultBaseDAO(CrmManagementActivityObj.class);

		return dao.searchByClause(CrmManagementActivityObj.class, "commercial_oppotunity_id='" + this.id + "'", "id desc", 0, Integer.MAX_VALUE);
	}
	
	// 合同
	public List<CrmContractObj> findContractList()
	{
		IBaseDAO dao = new DefaultBaseDAO(VCrmContractObj.class);

		return dao.searchByClause(CrmContractObj.class, "commercial_oppotunity_id='" + this.id + "'", "id desc", 0, Integer.MAX_VALUE);
	}
}
