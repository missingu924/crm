package com.wuyg.system;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.util.MySqlUtil;
import com.wuyg.common.util.RequestUtil;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;
import com.wuyg.system.obj.SystemConfigDbObj;

public class SystemServlet extends HttpServlet
{
	private Logger logger = Logger.getLogger(getClass());

	private IBaseDAO systemConfigDao = new DefaultBaseDAO(SystemConfigDbObj.class, SystemConstant.DEFAULT_DB);

	private String U8_DB = SystemConstant.U8_DB;

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy()
	{
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			// 获取执行的方法
			String method = request.getParameter("method");

			if (method.equals("preDbAddOrModify"))
			{
				preDbAddOrModify(request, response);
			} else if (method.equals("dbAddOrModify"))
			{
				dbAddOrModify(request, response);
			}
			else if (method.equals("downloadManual"))
			{
				downloadManual(request, response);
			}

		} catch (Exception e)
		{
			logger.error(e.getMessage(), e);
		}
	}

	private void dbAddOrModify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String ip = StringUtil.getNotEmptyStr(request.getParameter("ip"));
		String port = StringUtil.getNotEmptyStr(request.getParameter("port"));
		String dbName = StringUtil.getNotEmptyStr(request.getParameter("dbName"));

		String dbUser = StringUtil.getNotEmptyStr(request.getParameter("dbUser"));
		String dbPassword = StringUtil.getNotEmptyStr(request.getParameter("dbPassword"));

		String dbUrl = "jdbc:sqlserver://" + ip + ":" + port + ";DatabaseName=" + dbName;
		systemConfigDao.saveOrUpdate(new SystemConfigDbObj(U8_DB + ".dbUrl", dbUrl));
		systemConfigDao.saveOrUpdate(new SystemConfigDbObj(U8_DB + ".dbUser", dbUser));
		systemConfigDao.saveOrUpdate(new SystemConfigDbObj(U8_DB + ".dbPassword", dbPassword));
		systemConfigDao.saveOrUpdate(new SystemConfigDbObj(U8_DB + ".dbDriverClassName", "com.microsoft.sqlserver.jdbc.SQLServerDriver"));

		request.setAttribute("message", "数据库连接成功，账套设置成功");

		Connection conn = null;
		try
		{
			conn = MySqlUtil.getConnection(U8_DB);
		} catch (Exception e)
		{
			request.setAttribute("message", "数据库连接失败，请重新设置！" + e.getMessage());
		} finally
		{
			MySqlUtil.closeConnection(conn);
		}

		request.getRequestDispatcher("result.jsp").forward(request, response);
	}

	private void preDbAddOrModify(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		SystemConfigDbObj o = new SystemConfigDbObj(U8_DB + ".dbUrl", null);
		o = (SystemConfigDbObj) systemConfigDao.searchByUniqueIndex(o);
		if (o != null)
		{
			// jdbc:sqlserver://115.29.146.96:1433;DatabaseName=UFDATA_888_2010
			String url = ((SystemConfigDbObj) o).getValue() + "~";
			String ip = StringUtil.substr(url, "jdbc:sqlserver://", ":");
			String port = StringUtil.substr(StringUtil.substr(url, "//", "DatabaseName"), ":", ";");
			String dbName = StringUtil.substr(url, "DatabaseName=", "~");

			request.setAttribute("ip", ip);
			request.setAttribute("port", port);
			request.setAttribute("dbName", dbName);
		}

		o = new SystemConfigDbObj(U8_DB + ".dbUser", null);
		o = (SystemConfigDbObj) systemConfigDao.searchByUniqueIndex(o);
		if (o != null)
		{
			request.setAttribute("dbUser", ((SystemConfigDbObj) o).getValue());
		}

		o = new SystemConfigDbObj(U8_DB + ".dbPassword", null);
		o = (SystemConfigDbObj) systemConfigDao.searchByUniqueIndex(o);
		if (o != null)
		{
			request.setAttribute("dbPassword", ((SystemConfigDbObj) o).getValue());
		}

		request.getRequestDispatcher("/System/dbAddOrModify.jsp").forward(request, response);
	}
	
	// 下载凭证导入的模板
	public void downloadManual (HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String templeteFile = getServletContext().getRealPath("/System") + "/使用手册.docx";
		RequestUtil.downloadFile(response, templeteFile);
	}

	public static void main(String[] args)
	{
		String url = "jdbc:sqlserver://115.29.146.96:1433;DatabaseName=UFDATA_888_2010~";
		String ip = StringUtil.substr(url, "jdbc:sqlserver://", ":");
		System.out.println(ip);
		String port = StringUtil.substr(StringUtil.substr(url, "//", "DatabaseName"), ":", ";");
		System.out.println(port);
		String DatabaseName = StringUtil.substr(url, "DatabaseName=", "~");
		System.out.println(DatabaseName);
	}
}
