package com.crm.obj;

public class VCrmCommercialOpportunityObj extends CrmCommercialOpportunityObj
{
	@Override
	public String findTableName()
	{
		return "(select o.*,u.customer_region_code,u.customer_is_deal from crm_commercial_opportunity o left join crm_customer u on o.customer_id=u.id) t";
	}
}
