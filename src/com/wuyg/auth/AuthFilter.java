package com.wuyg.auth;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.wuyg.auth.obj.AuthUserObj;
import com.wuyg.common.util.SystemConstant;

public class AuthFilter implements Filter
{
	private Logger logger = Logger.getLogger(getClass());

	private final List<String> notCheckURLList = new ArrayList<String>();

	public void destroy()
	{
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest rst, ServletResponse res, FilterChain chain) throws IOException, ServletException
	{
		HttpServletRequest request = (HttpServletRequest) rst;
		HttpServletResponse response = (HttpServletResponse) res;

		request.setCharacterEncoding("UTF-8");

		if (checkRequestURIIntNotFilterList(request))
		{
			chain.doFilter(request, response);
			return;
		}

		AuthUserObj user = null;

		Object userObj = request.getSession(true).getAttribute(SystemConstant.AUTH_USER_INFO);
		if (userObj == null)
		{
			user = new AuthUserServlet().userLogin(request);// 自动重登陆
		} else
		{
			user = (AuthUserObj) userObj;
		}

		if (user != null)
		{
			chain.doFilter(request, response);
		} else
		{
			response.sendRedirect(request.getContextPath() + "/login.jsp?info=needReLogin");
		}
	}

	private boolean checkRequestURIIntNotFilterList(HttpServletRequest request)
	{

		String uri = request.getServletPath();

		for (String path : notCheckURLList)
		{
			if (uri.startsWith(path))
				return true;
		}

		return false;
	}

	public void init(FilterConfig filterConfig) throws ServletException
	{
		notCheckURLList.add("/login");
		notCheckURLList.add("/Auth");
		notCheckURLList.add("/images");
		notCheckURLList.add("/css/global.css");
		notCheckURLList.add("/css/table.css");
		notCheckURLList.add("/js");
		notCheckURLList.add("/console");
	}

}
