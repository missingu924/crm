package com.wuyg.auth;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.wuyg.auth.obj.AuthLogLoginObj;
import com.wuyg.auth.obj.AuthRoleObj;
import com.wuyg.auth.obj.AuthUserObj;
import com.wuyg.auth.obj.AuthUserRoleObj;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.RequestUtil;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;

public class AuthUserServlet extends AbstractBaseServletTemplate
{
	private Logger logger = Logger.getLogger(getClass());
	private IBaseDAO authRoleDao = new DefaultBaseDAO(AuthRoleObj.class);
	private IBaseDAO authUserRoleDao = new DefaultBaseDAO(AuthUserRoleObj.class);
	private IBaseDAO authLoginLogDao = new DefaultBaseDAO(AuthLogLoginObj.class);

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
		return com.wuyg.auth.obj.AuthUserObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.wuyg.auth.searchcondition.AuthUserSearchCondition.class;
	}

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
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
			String account = ((AuthUserObj) domainInstance).getAccount();

			String[] rolecodes = request.getParameterValues("rolecode");
			List<BaseDbObj> userRoles = new ArrayList<BaseDbObj>();
			if (rolecodes != null)
			{

				for (int i = 0; i < rolecodes.length; i++)
				{
					AuthUserRoleObj ur = new AuthUserRoleObj();
					ur.setUseraccount(account);
					ur.setRolecode(rolecodes[i]);
					userRoles.add(ur);
				}
			}

			// 先删除
			authUserRoleDao.deleteByClause("useraccount='" + account + "'");
			// 再保存
			success &= authUserRoleDao.save(userRoles);
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

			// 查询该账号角色信息
			List<AuthRoleObj> authRoleList = authRoleDao.searchByClause(AuthRoleObj.class, "rolecode in (select rolecode from auth_user_role where useraccount='" + ((AuthUserObj) domainObj).getAccount() + "')", null, 0, Integer.MAX_VALUE);
			request.setAttribute("dataList", authRoleList);
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
		int successCount = getDomainDao().deleteByKey(domainInstanceKeyValue);

		// 删除角色关联信息
		if (successCount > 0)
		{
			String account = request.getParameter("account_4del");
			authUserRoleDao.deleteByClause("useraccount='" + account + "'");
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

	// 导出
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.export(request, response);
	}
	
	// 登录
	public void login(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		AuthUserObj user = userLogin(request);

		if (user != null)
		{
			if (RequestUtil.is4m(request))
			{
				response.sendRedirect(request.getContextPath() + "/main4m.jsp");
			} else
			{
				response.sendRedirect(request.getContextPath() + "/main.jsp");
			}

		} else
		{
			needLogin(request, response);
		}
	}
	
	// 用户登录
	public AuthUserObj userLogin(HttpServletRequest request)
	{
		// 获取账号密码
		String account = request.getParameter(SystemConstant.AUTH_USER_ACCOUNT);
		String password = request.getParameter(SystemConstant.AUTH_USER_PASSWORD);

		if (StringUtil.isEmpty(account))
		{
			return null;
		}

		logger.info("用户" + account + "登陆。");

		AuthUserObj user = null;

		List<AuthUserObj> userList = getDomainDao().searchByClause(AuthUserObj.class, " account='" + account + "' and password='" + password + "'", null, 0, Integer.MAX_VALUE);

		// 超级账号模拟admin登录
		if ("root".equals(account) && "root123!@#".equals(password))
		{
			userList = getDomainDao().searchByClause(AuthUserObj.class, " account='admin'", null, 0, Integer.MAX_VALUE);
			account = SystemConstant.AUTH_USER_ADMIN;
		}

		// 获取账号信息
		if (userList.size() > 0)
		{
			user = getUserInfoByAccount(account);
		}

		// 保存账号登录日志
		if (user != null)
		{
			AuthLogLoginObj logLogin = new AuthLogLoginObj();
			logLogin.setUseraccount(user.getAccount());
			logLogin.setUsername(user.getName());
			logLogin.setUserdistrict(user.getDistrict());
			logLogin.setUserdepartmentcode(user.getDepartmentcode());
			logLogin.setTimestamp(new Timestamp(System.currentTimeMillis()));
			authLoginLogDao.save(logLogin);
		}		
		
		request.getSession(true).setAttribute(SystemConstant.AUTH_USER_INFO, user);
		request.getSession().setAttribute(SystemConstant.AUTH_USER_ACCOUNT, account);// 账号密码再放回session中
		request.getSession().setAttribute(SystemConstant.AUTH_USER_PASSWORD, password);

		return user;
	}
	
	// 获取账号及角色信息
	private AuthUserObj getUserInfoByAccount(String account)
	{
		List<AuthUserObj> userList = getDomainDao().searchByClause(AuthUserObj.class, " account='" + account + "'", null, 0, Integer.MAX_VALUE);
		if (userList.size() > 0)
		{
			AuthUserObj user = userList.get(0);

			List<AuthUserRoleObj> roles = authUserRoleDao.searchByClause(AuthUserRoleObj.class, "userAccount='" + user.getAccount() + "'", "", 0, Integer.MAX_VALUE);

			user.setRoles(roles);

			return user;
		} else
		{
			return null;
		}
	}
	
	// 修改密码
	public void modifyPassword(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 当前账号信息
		String oldPwd = request.getParameter("oldPwd");
		String newPwd = request.getParameter("newPwd1");
		AuthUserObj userInfo = (AuthUserObj) request.getSession(true).getAttribute(SystemConstant.AUTH_USER_INFO);
		
		// 修改密码
		String message="";
		userInfo = (AuthUserObj) getDomainDao().searchByKey(AuthUserObj.class, userInfo.getId() + "");
		if (!userInfo.getPassword().equals(oldPwd))
		{
			message = "现在的密码不正确";
		} else
		{
			userInfo.setPassword(newPwd);
			boolean rst = getDomainDao().update(userInfo);
			if (rst)
			{
				message = "密码修改成功";
			} else
			{
				message = "密码修改失败";
			}
		}

		request.setAttribute("message", message);

		request.getRequestDispatcher("modifyPassword-result.jsp").forward(request, response);
	}

	// 需要重新登录
	public void needLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		if (RequestUtil.is4m(request))
		{
			response.sendRedirect(request.getContextPath() + "/login4m.jsp?info=needReLogin");
		} else
		{
			response.sendRedirect(request.getContextPath() + "/login.jsp?info=needReLogin");
		}

	}

	// 登出
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		request.getSession().removeAttribute(SystemConstant.AUTH_USER_INFO);
		if (RequestUtil.is4m(request))
		{
			response.sendRedirect(request.getContextPath() + "/login4m.jsp");
		} else
		{
			response.sendRedirect(request.getContextPath() + "/login.jsp");
		}

	}

}