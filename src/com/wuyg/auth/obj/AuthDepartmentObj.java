package com.wuyg.auth.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import java.util.Arrays;
import com.alibaba.fastjson.JSON;
import java.util.List;

public class AuthDepartmentObj extends BaseDbObj
{
	private Long id;
	private String departmentcode;
	private String departmentname;
	private String city;
	private String districtname;
	private String commentinfo;

	@Override
	public String findKeyColumnName()
	{
		return "id";
	}

	@Override
	public String findParentKeyColumnName()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String findTableName()
	{
		return "auth_department";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "AuthDepartment";
	}

	@Override
	public String getCnName()
	{
		return "null";
	}

	@Override
	public List<String> findUniqueIndexProperties()
	{
		return Arrays.asList(new String[]
		{ "departmentcode" });
	}

	public LinkedHashMap<String, String> findProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "流水号");
		pros.put("departmentcode", "部门编码");
		pros.put("departmentname", "部门名称");
		// pros.put("city", "city");
		// pros.put("districtname", "districtname");
		pros.put("commentinfo", "备注");
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

	public String getDepartmentcode()
	{
		return departmentcode;
	}

	public void setDepartmentcode(String departmentcode)
	{
		this.departmentcode = departmentcode;
	}

	public String getDepartmentname()
	{
		return departmentname;
	}

	public void setDepartmentname(String departmentname)
	{
		this.departmentname = departmentname;
	}

	public String getCity()
	{
		return city;
	}

	public void setCity(String city)
	{
		this.city = city;
	}

	public String getDistrictname()
	{
		return districtname;
	}

	public void setDistrictname(String districtname)
	{
		this.districtname = districtname;
	}

	public String getCommentinfo()
	{
		return commentinfo;
	}

	public void setCommentinfo(String commentinfo)
	{
		this.commentinfo = commentinfo;
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
