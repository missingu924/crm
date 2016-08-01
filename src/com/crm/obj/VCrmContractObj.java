package com.crm.obj;

public class VCrmContractObj extends CrmContractObj
{
	@Override
	public String findTableName()
	{
		String str="";
		str+=" (select  ";
		str+=" t1.*, ";
		str+=" isnull(t2.bill_money_total,0) bill_money_total, ";
		str+=" isnull(t2.gather_money_total,0) gather_money_total, ";
		str+=" isnull(t1.contract_price,0)-isnull(t2.gather_money_total,0) spare_money, ";
		str+=" isnull(t2.bill_money_total,0)-isnull(t2.gather_money_total,0) bill_spare_money ";
		str+=" from crm_contract t1 ";
		str+=" left join  ";
		str+=" ( ";
		str+=" select ";
		str+=" contract_id,SUM(isnull(bill_money,0)) bill_money_total,SUM(isnull(gather_money,0)) gather_money_total  ";
		str+=" from crm_bill ";
		str+=" group by ";
		str+=" contract_id ";
		str+=" ) t2 ";
		str+=" on t1.id=t2.contract_id ) t";
		
		return str;
	}
}
