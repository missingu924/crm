package com.crm.searchcondition;

import com.wuyg.common.obj.BaseSearchCondition;

public class VBillDetailSearchCondition extends BaseSearchCondition
{
	private String gather_date_start;
	private String gather_date_end;

	
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
	
}