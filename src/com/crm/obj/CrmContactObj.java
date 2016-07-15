package com.crm.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;

public class CrmContactObj extends BaseDbObj
{
	private Long id;
	private Long customer_id;
	private String contact_name;
	private String contact_sex;
	private Timestamp contact_birthday;
	private String contact_telephone;
	private String contact_email;
	private String contact_qq;
	private String contact_weixin;
	private String contact_hobby;
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
		return "customer_id";
	}

	@Override
	public String findTableName()
	{
		return "crm_contact";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "CrmContact";
	}

	@Override
	public String getCnName()
	{
		return "客户联系人";
	}

	@Override
	public List<String> findUniqueIndexProperties()
	{
		return Arrays.asList(new String[]
		{ "customer_id", "contact_name" });
	}

	public LinkedHashMap<String, String> findProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("customer_id", "客户");
		pros.put("contact_name", "姓名");
		pros.put("contact_sex", "性别");
		pros.put("contact_birthday", "生日");
		pros.put("contact_telephone", "电话");
		pros.put("contact_email", "E-mail");
		pros.put("contact_qq", "QQ");
		pros.put("contact_weixin", "微信");
		pros.put("contact_hobby", "兴趣爱好");
		pros.put("record_account", "录入人");
		pros.put("record_time", "录入时间");
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

	public String getContact_name()
	{
		return contact_name;
	}

	public String getContact_qq()
	{
		return contact_qq;
	}

	public void setContact_qq(String contact_qq)
	{
		this.contact_qq = contact_qq;
	}

	public String getContact_weixin()
	{
		return contact_weixin;
	}

	public void setContact_weixin(String contact_weixin)
	{
		this.contact_weixin = contact_weixin;
	}

	public String getContact_hobby()
	{
		return contact_hobby;
	}

	public void setContact_hobby(String contact_hobby)
	{
		this.contact_hobby = contact_hobby;
	}

	public void setContact_name(String contact_name)
	{
		this.contact_name = contact_name;
	}

	public String getContact_sex()
	{
		return contact_sex;
	}

	public void setContact_sex(String contact_sex)
	{
		this.contact_sex = contact_sex;
	}

	public Timestamp getContact_birthday()
	{
		return contact_birthday;
	}

	public void setContact_birthday(Timestamp contact_birthday)
	{
		this.contact_birthday = contact_birthday;
	}

	public String getContact_telephone()
	{
		return contact_telephone;
	}

	public void setContact_telephone(String contact_telephone)
	{
		this.contact_telephone = contact_telephone;
	}

	public String getContact_email()
	{
		return contact_email;
	}

	public void setContact_email(String contact_email)
	{
		this.contact_email = contact_email;
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
}
