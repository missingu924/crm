package com.crm.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;
public class CrmManagementActivityObj extends BaseDbObj
{
private Long id;
private Long customer_id;
private String activity_type;
private Long commercial_oppotunity_id;
private String record_account;
private String participant;
private Timestamp activity_date;
private String activity_content;
private String next_step;
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
	return "crm_management_activity";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "CrmManagementActivity";
}
@Override
public String getCnName()
{
	return "经营活动";
}
@Override
public List<String> findUniqueIndexProperties()
{
	return Arrays.asList(new String[]
	{ "null" });
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("customer_id", "客户");
		pros.put("activity_type", "经营活动类型");
		pros.put("commercial_oppotunity_id", "商机");
		pros.put("record_account", "录入人");
		pros.put("participant", "参与人");
		pros.put("activity_date", "活动日期");
		pros.put("activity_content", "活动内容");
		pros.put("next_step", "下一步计划");
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
public Long getCustomer_id()
{
	return customer_id;
}
public void setCustomer_id(Long customer_id)
{
	this.customer_id = customer_id;
}
public String getActivity_type()
{
	return activity_type;
}
public void setActivity_type(String activity_type)
{
	this.activity_type = activity_type;
}
public Long getCommercial_oppotunity_id()
{
	return commercial_oppotunity_id;
}
public void setCommercial_oppotunity_id(Long commercial_oppotunity_id)
{
	this.commercial_oppotunity_id = commercial_oppotunity_id;
}
public String getRecord_account()
{
	return record_account;
}
public void setRecord_account(String record_account)
{
	this.record_account = record_account;
}
public String getParticipant()
{
	return participant;
}
public void setParticipant(String participant)
{
	this.participant = participant;
}
public Timestamp getActivity_date()
{
	return activity_date;
}
public void setActivity_date(Timestamp activity_date)
{
	this.activity_date = activity_date;
}
public String getActivity_content()
{
	return activity_content;
}
public void setActivity_content(String activity_content)
{
	this.activity_content = activity_content;
}
public String getNext_step()
{
	return next_step;
}
public void setNext_step(String next_step)
{
	this.next_step = next_step;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

