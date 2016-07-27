package com.crm.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.util.StringUtil;
import com.wuyg.dictionary.DictionaryUtil;

import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.List;
import com.alibaba.fastjson.JSON;

public class CrmContactObj extends BaseDbObj
{
	private Long id;
	private String customer_id;
	private String contact_name;
	private String contact_sex;
	private String contact_birthday_type;
	private Long contact_birthday_month;
	private Long contact_birthday_day;
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

	public String getCustomer_id()
	{
		return customer_id;
	}

	public void setCustomer_id(String customer_id)
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

	public String getContact_birthday_type()
	{
		return contact_birthday_type;
	}

	public void setContact_birthday_type(String contact_birthday_type)
	{
		this.contact_birthday_type = contact_birthday_type;
	}

	public Long getContact_birthday_month()
	{
		return contact_birthday_month;
	}

	public void setContact_birthday_month(Long contact_birthday_month)
	{
		this.contact_birthday_month = contact_birthday_month;
	}

	public Long getContact_birthday_day()
	{
		return contact_birthday_day;
	}

	public void setContact_birthday_day(Long contact_birthday_day)
	{
		this.contact_birthday_day = contact_birthday_day;
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

	public String getContact_birthday()
	{
		if (StringUtil.isEmpty(this.contact_birthday_type))
		{
			return "";
		}
		return this.contact_birthday_type + this.contact_birthday_month + "月" + this.contact_birthday_day + "日";
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
