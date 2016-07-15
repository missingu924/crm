package com.wuyg.common.obj;

import com.wuyg.auth.obj.AuthUserObj;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;

public abstract class BaseSearchCondition
{
	private Object domainObj;// 业务对象

	private AuthUserObj user;// 用户登录账号
	private int pageNo = 1;
	private int pageCount = SystemConstant.PAGE_ROWS;
	private String orderBy;// 排序条件

	public AuthUserObj getUser()
	{
		return user;
	}

	public void setUser(AuthUserObj user)
	{
		this.user = user;
	}

	public int getPageNo()
	{
		return pageNo;
	}

	public void setPageNo(int pageNo)
	{
		this.pageNo = pageNo;
	}

	public int getPageCount()
	{
		return pageCount;
	}

	public void setPageCount(int pageCount)
	{
		this.pageCount = pageCount;
	}

	public Object getDomainObj()
	{
		return domainObj;
	}

	public void setDomainObj(Object domainObj)
	{
		this.domainObj = domainObj;
	}
	
	public String getOrderBy()
	{
		return orderBy;
	}

	public void setOrderBy(String orderBy)
	{
		this.orderBy = orderBy;
	}

	/**
	 * 根据排序字段获取前台展示的css类
	 * 
	 * @param dbColumn
	 * @return
	 */
	public String getSortClassByDbColumn(String dbColumn)
	{
		if (StringUtil.isEmpty(this.orderBy))
		{
			return "table-sorted-none";
		} else if (this.orderBy.equalsIgnoreCase(dbColumn + " asc"))
		{
			return "table-sorted-asc";
		} else if (this.orderBy.equalsIgnoreCase(dbColumn + " desc"))
		{
			return "table-sorted-desc";
		}
		return "table-sorted-none";
	}
}
