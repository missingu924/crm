package com.wuyg.auth;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.log4j.Logger;

import com.wuyg.auth.obj.AuthFunctionObj;
import com.wuyg.auth.obj.AuthRoleFunctionObj;
import com.wuyg.auth.obj.AuthRoleObj;
import com.wuyg.auth.obj.AuthUserObj;
import com.wuyg.auth.obj.AuthUserRoleObj;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.StringUtil;
import com.wuyg.dictionary.DictionaryUtil;

public class AuthRoleServlet extends AbstractBaseServletTemplate
{
	private Logger logger = Logger.getLogger(getClass());
	private IBaseDAO authFunctionDao=new DefaultBaseDAO(AuthFunctionObj.class);
	private IBaseDAO authRoleFunctionDao=new DefaultBaseDAO(AuthRoleFunctionObj.class);

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
		return com.wuyg.auth.obj.AuthRoleObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.wuyg.auth.searchcondition.AuthRoleSearchCondition.class;
	}

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.list(request,response);
	}

	// 检查ID是否已录入系统
	public void checkId4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.checkId(request,response);
	}

	// 增加 or 修改
	public void addOrModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
//		super.addOrModify(request,response);
		// 保存或更新
		if (domainInstance.getKeyValue() < 0)
		{
			long keyValue = getDomainDao().getMaxKeyValue();
			domainInstance.setId(keyValue);
		}

		boolean success = getDomainDao().saveOrUpdate(domainInstance);

		// 保存角色信息
		if (success)
		{
			String rolecode = ((AuthRoleObj) domainInstance).getRolecode();

			String[] functioncodes = request.getParameterValues("functioncode");
			List<BaseDbObj> functions = new ArrayList<BaseDbObj>();
			if (functioncodes != null)
			{
				for (int i = 0; i < functioncodes.length; i++)
				{
					AuthRoleFunctionObj rf = new AuthRoleFunctionObj();
					rf.setRolecode(rolecode);
					rf.setFunctioncode(functioncodes[i]);
					functions.add(rf);
				}
			}

			// 先删除
			authRoleFunctionDao.deleteByClause("rolecode='" + rolecode + "'");
			// 再保存
			success &= authRoleFunctionDao.save(functions);
		}

		// 声明是新增后转到的详情页面
		request.setAttribute("needRefresh", true);

		// 转向
		if (success)
		{
			detail4this(request, response);
			// list(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	// 修改前查询领域对象信息
	public void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
//		super.preModify(request,response);
		
		searchDetail(request);

		// 转向
		request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_ADD_OR_MODIFY + ".jsp").forward(request, response);
	}
	
	private void searchDetail(HttpServletRequest request) throws Exception
	{
		// 查询
		Object domainObj = getDomainDao().searchByKey(getDomainInstanceClz(), domainInstance.getKeyValue() + "");

		if (domainObj != null)
		{
			request.setAttribute(DOMAIN_INSTANCE, domainObj);

			// 查询该角色的权限信息
			List<AuthFunctionObj> authFunctionList = authFunctionDao.searchByClause(AuthFunctionObj.class, "functioncode in (select functioncode from auth_role_function where rolecode='" + ((AuthRoleObj) domainObj).getRolecode() + "')", null, 0, Integer.MAX_VALUE);
			request.setAttribute("dataList", authFunctionList);
		}
	}

	// 详情
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		searchDetail(request);

		// 转向
		request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_DETAIL + ".jsp").forward(request, response);
	}

	// 删除
	public void delete4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
//		super.delete(request,response);
		AuthRoleObj obj = (AuthRoleObj)domainInstance.searchBykey(domainInstanceKeyValue);
		
		int successCount = getDomainDao().deleteByKey(domainInstanceKeyValue);
		
		// 删除角色关联信息
		if (successCount > 0)
		{
			authRoleFunctionDao.deleteByClause("rolecode='" + obj.getRolecode() + "'");
		}

		// 转向
		if (successCount > 0)
		{
			list4this(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	// 删除 按前台条件查出的所有数据
	public void deleteAll4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.deleteAll(request,response);
	}

	// 导出
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.export(request,response);
	}

}
