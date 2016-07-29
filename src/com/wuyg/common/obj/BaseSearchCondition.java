package com.wuyg.common.obj;

import com.wuyg.auth.obj.AuthUserObj;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;

public abstract class BaseSearchCondition
{
	private BaseDbObj domainObj;// 业务对象

	private AuthUserObj user;// 用户登录账号
	private int pageNo = 1; // 第几页
	private int pageCount = SystemConstant.PAGE_ROWS;// 每页几行
	private String orderBy;// 排序条件
	private boolean showSearchConditionTable = true;// 默认呈现查询条件设置区域
	private boolean useLike = true;// 针对domainObj中的字符型字段在构造查询条件时是否使用like进行模糊查找，如果不使用like则使用等号进行精确查找。默认使用like
	private String otherWhere;// 其他where条件

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

	public BaseDbObj getDomainObj()
	{
		return domainObj;
	}

	public void setDomainObj(BaseDbObj domainObj)
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

	public boolean isShowSearchConditionTable()
	{
		return showSearchConditionTable;
	}

	public void setShowSearchConditionTable(boolean showSearchConditionTable)
	{
		this.showSearchConditionTable = showSearchConditionTable;
	}

	public boolean isUseLike()
	{
		return useLike;
	}

	public void setUseLike(boolean useLike)
	{
		this.useLike = useLike;
	}

	public String getOtherWhere()
	{
		return otherWhere;
	}

	public void setOtherWhere(String otherWhere)
	{
		this.otherWhere = otherWhere;
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
