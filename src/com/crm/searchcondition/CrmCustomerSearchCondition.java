package com.crm.searchcondition;

import com.wuyg.common.obj.BaseSearchCondition;

public class CrmCustomerSearchCondition extends BaseSearchCondition
{
	private String service_due_date_start;
	private String service_due_date_end;
	private Double service_charge_peryear_min;
	private Double service_charge_peryear_max;
	private String customer_manager_account_list;
	private String service_engineer_account_list;

	public String getCustomer_manager_account_list()
	{
		return customer_manager_account_list;
	}

	public void setCustomer_manager_account_list(String customer_manager_account_list)
	{
		this.customer_manager_account_list = customer_manager_account_list;
	}

	public String getService_engineer_account_list()
	{
		return service_engineer_account_list;
	}

	public void setService_engineer_account_list(String service_engineer_account_list)
	{
		this.service_engineer_account_list = service_engineer_account_list;
	}

	public String getService_due_date_start()
	{
		return service_due_date_start;
	}

	public void setService_due_date_start(String service_due_date_start)
	{
		this.service_due_date_start = service_due_date_start;
	}

	public String getService_due_date_end()
	{
		return service_due_date_end;
	}

	public void setService_due_date_end(String service_due_date_end)
	{
		this.service_due_date_end = service_due_date_end;
	}

	public Double getService_charge_peryear_min()
	{
		return service_charge_peryear_min;
	}

	public void setService_charge_peryear_min(Double service_charge_peryear_min)
	{
		this.service_charge_peryear_min = service_charge_peryear_min;
	}

	public Double getService_charge_peryear_max()
	{
		return service_charge_peryear_max;
	}

	public void setService_charge_peryear_max(Double service_charge_peryear_max)
	{
		this.service_charge_peryear_max = service_charge_peryear_max;
	}

}