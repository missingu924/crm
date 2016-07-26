package com.crm.searchcondition;

import com.wuyg.common.obj.BaseSearchCondition;

public class VContractBillStatSearchCondition extends BaseSearchCondition
{
	private String contract_sign_time_start;
	private String contract_sign_time_end;
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