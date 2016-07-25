package com.crm.obj;

import java.beans.PropertyDescriptor;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.util.MyBeanUtils;
import com.wuyg.common.util.StringUtil;

import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;

public class CrmCustomerObj extends BaseDbObj
{
	private Logger logger = Logger.getLogger(getClass());
	private Long id;
	private String customer_full_name;
	private String customer_type_code;
	private String customer_region_code;
	private String customer_address;
	private String customer_is_deal;
	private String customer_manager_account;
	private String service_engineer_account;
	private String product_code;
	private String product_version_code;
	private String byproduct;
	private String module;
	private String softdog;
	private Double service_charge_peryear;
	private Timestamp service_due_date;
	private String bill_company_name;
	private String bill_duty_number;
	private String bill_address;
	private String bill_telephone;
	private String bill_bank_name;
	private String bill_bank_account;
	private String comment;
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
		return "crm_customer";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return "id desc";
	}

	@Override
	public String getBasePath()
	{
		return "CrmCustomer";
	}

	@Override
	public String getCnName()
	{
		return "客户档案";
	}

	@Override
	public List<String> findUniqueIndexProperties()
	{
		return Arrays.asList(new String[]
		{ "customer_full_name" });
	}

	public LinkedHashMap<String, String> findProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("customer_full_name", "客户全称");
		pros.put("customer_type_code", "客户分类");
		pros.put("customer_region_code", "区域");
		pros.put("customer_address", "地址");
		pros.put("customer_is_deal", "成交客户");
		pros.put("customer_manager_account", "客户经理");
		pros.put("service_engineer_account", "服务经理");
		pros.put("product_code", "产品线");
		pros.put("product_version_code", "产品版本");
		pros.put("byproduct", "副产品");
		pros.put("module", "模块");
		pros.put("softdog", "加密狗号");
		pros.put("service_charge_peryear", "年服务费金额");
		pros.put("service_due_date", "服务到期日期");	
		pros.put("bill_company_name","公司名称");
		pros.put("bill_duty_number","税号");
		pros.put("bill_address","地址");
		pros.put("bill_telephone","电话");
		pros.put("bill_bank_name","开户行");
		pros.put("bill_bank_account","银行账号");
		pros.put("comment", "备注");
		pros.put("record_account", "录入人");
		pros.put("record_time", "录入日期");
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

	public String getCustomer_full_name()
	{
		return customer_full_name;
	}

	public void setCustomer_full_name(String customer_full_name)
	{
		this.customer_full_name = customer_full_name;
	}

	public String getCustomer_type_code()
	{
		return customer_type_code;
	}

	public void setCustomer_type_code(String customer_type_code)
	{
		this.customer_type_code = customer_type_code;
	}

	public String getCustomer_region_code()
	{
		return customer_region_code;
	}

	public void setCustomer_region_code(String customer_region_code)
	{
		this.customer_region_code = customer_region_code;
	}

	public String getCustomer_address()
	{
		return customer_address;
	}

	public void setCustomer_address(String customer_address)
	{
		this.customer_address = customer_address;
	}

	public String getCustomer_is_deal()
	{
		return customer_is_deal;
	}

	public void setCustomer_is_deal(String customer_is_deal)
	{
		this.customer_is_deal = customer_is_deal;
	}

	public String getCustomer_manager_account()
	{
		return customer_manager_account;
	}

	public void setCustomer_manager_account(String customer_manager_account)
	{
		this.customer_manager_account = customer_manager_account;
	}

	public String getService_engineer_account()
	{
		return service_engineer_account;
	}

	public void setService_engineer_account(String service_engineer_account)
	{
		this.service_engineer_account = service_engineer_account;
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

	public String getByproduct()
	{
		return byproduct;
	}

	public void setByproduct(String byproduct)
	{
		this.byproduct = byproduct;
	}

	public String getModule()
	{
		return module;
	}

	public void setModule(String module)
	{
		this.module = module;
	}

	public String getSoftdog()
	{
		return softdog;
	}

	public void setSoftdog(String softdog)
	{
		this.softdog = softdog;
	}

	public Double getService_charge_peryear()
	{
		return service_charge_peryear;
	}

	public void setService_charge_peryear(Double service_charge_peryear)
	{
		this.service_charge_peryear = service_charge_peryear;
	}

	public Timestamp getService_due_date()
	{
		return service_due_date;
	}

	public void setService_due_date(Timestamp service_due_date)
	{
		this.service_due_date = service_due_date;
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

	public String getComment()
	{
		return comment;
	}

	public void setComment(String comment)
	{
		this.comment = comment;
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

	// 联系人
	public List<CrmContactObj> findContactList()
	{
		IBaseDAO dao = new DefaultBaseDAO(CrmContactObj.class);

		return dao.searchByClause(CrmContactObj.class, "customer_id='" + this.id + "'", "id desc", 0, Integer.MAX_VALUE);
	}

	// 商机
	public List<CrmCommercialOpportunityObj> findCommericialOpportunityList()
	{
		IBaseDAO dao = new DefaultBaseDAO(CrmCommercialOpportunityObj.class);

		return dao.searchByClause(CrmCommercialOpportunityObj.class, "customer_id='" + this.id + "'", "id desc", 0, Integer.MAX_VALUE);
	}

	// 变更记录
	public List<CrmContactObj> findChangeLogList()
	{
		IBaseDAO dao = new DefaultBaseDAO(CrmCustomerChangelogObj.class);

		return dao.searchByClause(CrmCustomerChangelogObj.class, "customer_id='" + this.id + "'", "id desc", 0, Integer.MAX_VALUE);
	}

	// 合同
	public List<VCrmContractObj> findContractList()
	{
		IBaseDAO dao = new DefaultBaseDAO(VCrmContractObj.class);

		return dao.searchByClause(VCrmContractObj.class, "customer_id='" + this.id + "'", "id desc", 0, Integer.MAX_VALUE);
	}

	// 开票收款
	public List<CrmBillObj> findBillList()
	{
		IBaseDAO dao = new DefaultBaseDAO(CrmBillObj.class);

		return dao.searchByClause(CrmBillObj.class, "customer_id='" + this.id + "'", "id desc", 0, Integer.MAX_VALUE);
	}

	// 经营活动
	public List<CrmManagementActivityObj> findActivityList()
	{
		IBaseDAO dao = new DefaultBaseDAO(CrmManagementActivityObj.class);

		return dao.searchByClause(CrmManagementActivityObj.class, "customer_id='" + this.id + "'", "id desc", 0, Integer.MAX_VALUE);
	}

	public String compare(CrmCustomerObj preObject)
	{
		String changeLog = "";
		try
		{
			List<PropertyDescriptor> propertyList = MyBeanUtils.getNotNullPropertyDescriptors(this, findKeyColumnName(), null);

			for (int i = 0; i < propertyList.size(); i++)
			{
				String pname = propertyList.get(i).getName();
				Object currentValue = PropertyUtils.getProperty(this, pname);
				Object preValue = PropertyUtils.getProperty(preObject, pname);

				if (!currentValue.equals(preValue))
				{
					changeLog += getPropertyCnName(pname) + " : 从\"" + StringUtil.getNotEmptyStr(preValue, "空值") + "\" 变更为 \"" + currentValue + "\"\n";
				}
			}

		} catch (Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		return changeLog;
	}
}
