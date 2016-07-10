package com.wuyg.common.obj;

import com.wuyg.auth.obj.AuthUserObj;
import com.wuyg.common.util.SystemConstant;

public abstract class BaseSearchCondition
{
	private Object domainObj;// 业务对象

	private AuthUserObj user;// 用户登录账号
	private int pageNo = 1;
	private int pageCount = SystemConstant.PAGE_ROWS;

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
}
