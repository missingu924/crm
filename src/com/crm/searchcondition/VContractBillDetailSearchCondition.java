package com.crm.searchcondition;

import com.wuyg.common.obj.BaseSearchCondition;

public class VContractBillDetailSearchCondition extends BaseSearchCondition
{
	private String gather_date_start;
	private String gather_date_end;
	private String bill_date_start;
	private String bill_date_end;
	private String contract_sign_time_start;
	private String contract_sign_time_end;
	private Double contract_price_min;
	private Double contract_price_max;
	public Double getContract_price_min()
	{
		return contract_price_min;
	}
	public void setContract_price_min(Double contract_price_min)
	{
		this.contract_price_min = contract_price_min;
	}
	public Double getContract_price_max()
	{
		return contract_price_max;
	}
	public void setContract_price_max(Double contract_price_max)
	{
		this.contract_price_max = contract_price_max;
	}
	public String getGather_date_start()
	{
		return gather_date_start;
	}
	public void setGather_date_start(String gather_date_start)
	{
		this.gather_date_start = gather_date_start;
	}
	public String getGather_date_end()
	{
		return gather_date_end;
	}
	public void setGather_date_end(String gather_date_end)
	{
		this.gather_date_end = gather_date_end;
	}
	public String getBill_date_start()
	{
		return bill_date_start;
	}
	public void setBill_date_start(String bill_date_start)
	{
		this.bill_date_start = bill_date_start;
	}
	public String getBill_date_end()
	{
		return bill_date_end;
	}
	public void setBill_date_end(String bill_date_end)
	{
		this.bill_date_end = bill_date_end;
	}
	public String getContract_sign_time_start()
	{
		return contract_sign_time_start;
	}
	public void setContract_sign_time_start(String contract_sign_time_start)
	{
		this.contract_sign_time_start = contract_sign_time_start;
	}
	public String getContract_sign_time_end()
	{
		return contract_sign_time_end;
	}
	public void setContract_sign_time_end(String contract_sign_time_end)
	{
		this.contract_sign_time_end = contract_sign_time_end;
	}
	
	
}