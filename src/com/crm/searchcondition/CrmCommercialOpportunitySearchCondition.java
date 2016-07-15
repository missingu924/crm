package com.crm.searchcondition;

import java.sql.Timestamp;

import com.wuyg.common.obj.BaseSearchCondition;

public class CrmCommercialOpportunitySearchCondition extends BaseSearchCondition
{
	private Double target_price_min;
	private String estimate_sign_time_start;
	private Double target_price_max;
	private String estimate_sign_time_end;

	public Double getTarget_price_min()
	{
		return target_price_min;
	}

	public void setTarget_price_min(Double target_price_min)
	{
		this.target_price_min = target_price_min;
	}

	public String getEstimate_sign_time_start()
	{
		return estimate_sign_time_start;
	}

	public void setEstimate_sign_time_start(String estimate_sign_time_start)
	{
		this.estimate_sign_time_start = estimate_sign_time_start;
	}

	public Double getTarget_price_max()
	{
		return target_price_max;
	}

	public void setTarget_price_max(Double target_price_max)
	{
		this.target_price_max = target_price_max;
	}

	public String getEstimate_sign_time_end()
	{
		return estimate_sign_time_end;
	}

	public void setEstimate_sign_time_end(String estimate_sign_time_end)
	{
		this.estimate_sign_time_end = estimate_sign_time_end;
	}
}