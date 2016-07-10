package com.wuyg.system;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.log4j.Logger;

import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.StringUtil;
import com.wuyg.system.obj.SysMapInfoObj;
import com.wuyg.system.obj.SysMapItemsObj;

public class SysMapItemsServlet extends AbstractBaseServletTemplate
{
	private Logger logger = Logger.getLogger(getClass());

	private IBaseDAO sysMapInfoDao = new DefaultBaseDAO(SysMapInfoObj.class);

	@Override
	public String getBasePath()
	{
		return domainInstance.getBasePath();
	}

	@Override
	public IBaseDAO getDomainDao()
	{
		return new DefaultBaseDAO(getDomainInstanceClz());
	}

	@Override
	public Class getDomainInstanceClz()
	{
		return com.wuyg.system.obj.SysMapItemsObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.wuyg.system.searchcondition.SysMapItemsSearchCondition.class;
	}

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String map_id = request.getParameter("map_id");
		IBaseDAO dao=new DefaultBaseDAO(SysMapInfoObj.class);
		Object sysMapInfo = dao.searchByKey(SysMapInfoObj.class, map_id);
		request.setAttribute("sysMapInfo", sysMapInfo);
		
		super.list(request, response);
	}

	// 检查ID是否已录入系统
	public void checkId4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.checkId(request, response);
	}

	// 增加 or 修改
	public void addOrModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.addOrModify(request, response);
	}

	// 修改前查询领域对象信息
	public void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 查询
		Object domainObj = getDomainDao().searchByKey(getDomainInstanceClz(), domainInstance.getKeyValue() + "");

		if (domainObj != null)
		{
			domainInstance = (BaseDbObj)domainObj;
		} 
		
		request.setAttribute(DOMAIN_INSTANCE, domainInstance);
		

		SysMapInfoObj sysMapInfo = (SysMapInfoObj) sysMapInfoDao.searchByKey(SysMapInfoObj.class, ((SysMapItemsObj) domainInstance).getMap_id() + "");
		request.setAttribute("sysMapInfo", sysMapInfo);

		// 转向
		if ("true".equalsIgnoreCase(request.getParameter("4m")))
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_ADD_OR_MODIFY + "4m.jsp").forward(request, response);
		} else
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_ADD_OR_MODIFY + ".jsp").forward(request, response);
		}

		// super.preModify(request,response);
	}

	// 详情
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 查询
		Object domainObj = getDomainDao().searchByKey(getDomainInstanceClz(), domainInstance.getKeyValue() + "");

		if (domainObj != null)
		{
			domainInstance = (BaseDbObj)domainObj;
		} 
		
		request.setAttribute(DOMAIN_INSTANCE, domainInstance);

		// 转向
		if ("true".equalsIgnoreCase(request.getParameter("4m")))
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_DETAIL + "4m.jsp").forward(request, response);
		} else
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_DETAIL + ".jsp").forward(request, response);
		}
	}

	// 删除
	public void delete4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.delete(request, response);
	}

	// 导出
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.export(request, response);
	}

}
