package com.wuyg.auth.obj;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.util.StringUtil;

public class AuthUserObj extends BaseDbObj
{
	private Long id;
	private String account;
	private String password;
	private String name;
	private String sex;
	private String telephone;
	private String province;
	private String city;
	private String district;
	private String departmentcode;
	private String officecode;
	private String rolelevel;
	private String enable;
	private List<AuthUserRoleObj> roles = new ArrayList<AuthUserRoleObj>();// 所具备的角色ID列表

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
		return "auth_user";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "AuthUser";
	}

	@Override
	public String getCnName()
	{
		return "账号";
	}

	@Override
	public List<String> findUniqueIndexProperties()
	{
		return Arrays.asList(new String[]
		{ "account" });
	}

	public LinkedHashMap<String, String> findProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "流水号");
		pros.put("account", "账号");
		pros.put("password", "密码");
		pros.put("name", "姓名");
		pros.put("sex", "性别");
		pros.put("telephone", "电话");
		// pros.put("province", "province");
		// pros.put("city", "city");
		pros.put("district", "对应U8职员");
		pros.put("departmentcode", "部门");
		// pros.put("departmentname", "departmentname");
		pros.put("officecode", "职务");
		pros.put("enable", "是否启用");
		pros.put("rolelevel", "角色");
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

	public String getAccount()
	{
		return account;
	}

	public String getEnable()
	{
		return enable;
	}

	public void setEnable(String enable)
	{
		this.enable = enable;
	}

	public List<AuthUserRoleObj> getRoles()
	{
		return roles;
	}

	public void setRoles(List<AuthUserRoleObj> roles)
	{
		this.roles = roles;
	}

	public void setAccount(String account)
	{
		this.account = account;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getSex()
	{
		return sex;
	}

	public void setSex(String sex)
	{
		this.sex = sex;
	}

	public String getTelephone()
	{
		return telephone;
	}

	public void setTelephone(String telephone)
	{
		this.telephone = telephone;
	}

	public String getProvince()
	{
		return province;
	}

	public void setProvince(String province)
	{
		this.province = province;
	}

	public String getCity()
	{
		return city;
	}

	public void setCity(String city)
	{
		this.city = city;
	}

	public String getDistrict()
	{
		return district;
	}

	public void setDistrict(String district)
	{
		this.district = district;
	}

	public String getDepartmentcode()
	{
		return departmentcode;
	}

	public void setDepartmentcode(String departmentcode)
	{
		this.departmentcode = departmentcode;
	}

	public String getOfficecode()
	{
		return officecode;
	}

	public void setOfficecode(String officecode)
	{
		this.officecode = officecode;
	}

	public String getRolelevel()
	{
		return rolelevel;
	}

	public void setRolelevel(String rolelevel)
	{
		this.rolelevel = rolelevel;
	}

	public boolean hasRole(String rolecode)
	{
		if (StringUtil.isEmpty(rolecode))
		{
			return true;
		}
		for (int i = 0; i < roles.size(); i++)
		{
			if (rolecode.equals(roles.get(i).getRolecode()))
			{
				return true;
			}
		}
		return false;
	}

	public boolean hasFunction(String functioncode)
	{
		if (StringUtil.isEmpty(functioncode))
		{
			return true;
		}

		for (int i = 0; i < roles.size(); i++)
		{
			List<AuthRoleFunctionObj> functions = new DefaultBaseDAO(AuthRoleFunctionObj.class).searchByParentKey(AuthRoleFunctionObj.class, roles.get(i).getRolecode(), null);

			for (int j = 0; j < functions.size(); j++)
			{
				if (functioncode.equalsIgnoreCase(functions.get(j).getFunctioncode()))
				{
					return true;
				}
			}
		}

		return false;

	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
