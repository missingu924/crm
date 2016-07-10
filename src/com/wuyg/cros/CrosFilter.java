package com.wuyg.cros;

import java.io.IOException;
import java.util.logging.LogRecord;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CrosFilter implements Filter, java.util.logging.Filter
{

	public void destroy()
	{
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest rst, ServletResponse res, FilterChain chain) throws IOException, ServletException
	{
		HttpServletRequest request = (HttpServletRequest) rst;
		HttpServletResponse response = (HttpServletResponse) res;
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
		response.addHeader("Access-Control-Allow-Headers", "origin, content-type, accept, x-requested-with, sid, mycustom, smuser");
		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException
	{
		// TODO Auto-generated method stub

	}

	public boolean isLoggable(LogRecord arg0)
	{
		// TODO Auto-generated method stub
		return false;
	}
	
	public static void main(String[] args)
	{
		int[] arr = new int[]{8,2,1,0,3};
		int[] index = new int[]{2,0,3,2,4,0,1,3,2,3,3};
		String tel = "";
		for (int i : index)
		{
			tel+=arr[i];
		}
		System.out.println(tel);
	}

}
