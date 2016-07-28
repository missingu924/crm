package com.crm.searchcondition;

import com.wuyg.common.obj.BaseSearchCondition;

public class CrmContractSearchCondition extends BaseSearchCondition
{
	private Double contract_price_min;
	private Double contract_price_max;
	private String contract_sign_time_start;
	private String contract_sign_time_end;
	public Double getContract_price_min()
	{
		return contract_price_min;
	}
	public void setContract_price_min(Double contract_price_min)
	{
		this.contract_price_min = contract_price_min;
	}
	public String getContract_sign_time_start()
	{
		return contract_sign_time_start;
	}
	public void setContract_sign_time_start(String contract_sign_time_start)
	{
		this.contract_sign_time_start = contract_sign_time_start;
	}
	public Double getContract_price_max()
	{
		return contract_price_max;
	}
	public void setContract_price_max(Double contract_price_max)
	{
		this.contract_price_max = contract_price_max;
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