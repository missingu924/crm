package com.wuyg.common.servlet;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.registry.infomodel.User;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.MethodUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.inspur.common.dictionary.Dictionary;
import com.wuyg.auth.obj.AuthLogOperationObj;
import com.wuyg.auth.obj.AuthUserObj;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.BaseSearchCondition;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.util.MyBeanUtils;
import com.wuyg.common.util.RequestUtil;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;
import com.wuyg.common.util.TimeUtil;
import com.wuyg.dictionary.DictionaryUtil;

public abstract class AbstractBaseServletTemplate extends HttpServlet
{
	private Logger log = Logger.getLogger(getClass());

	// 当前登陆用户
	public AuthUserObj currentUser;

	// 领域实例主键值
	public String domainInstanceKeyValue;
	// 领域实例
	public BaseDbObj domainInstance;
	// 查询条件
	public BaseSearchCondition domainSearchCondition;

	// 上传的文件，只保存第一个
	protected File savedFile = null;

	// 虚方法：获取领域DAO，具体继承类实现
	public abstract IBaseDAO getDomainDao();

	// 虚方法：获取领域对象类，具体继承类实现
	public abstract Class getDomainInstanceClz();

	// 虚方法：获取领域查询条件类，具体继承类实现
	public abstract Class getDomainSearchConditionClz();

	// 虚方法：获取领域基本路径，url中使用，具体继承类实现
	public abstract String getBasePath();

	public static final String METHOD = "method";

	public static final String BASE_METHOD_LIST = "list";// 查询
	public static final String BASE_METHOD_ADD_OR_MODIFY = "addOrModify";// 添加或修改
	public static final String BASE_METHOD_PRE_MODIFY = "preModify";// 修改前查询领域对象信息
	public static final String BASE_METHOD_DETAIL = "detail";// 详情
	public static final String BASE_METHOD_DELETE = "delete";// 删除
	public static final String BASE_METHOD_EXPORT = "export";// 导出
	public static final String BASE_METHOD_CHECK_ID = "checkId";// 检查我一性

	public static final String DOMAIN_INSTANCE = "domainInstance";
	public static final String DOMAIN_SEARCH_CONDITION = "domainSearchCondition";
	public static final String DOMAIN_PAGINATION = "domainPagination";

	@Override
	public void init() throws ServletException
	{
		// TODO Auto-generated method stub
		super.init();

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
	 * This method is called when a form has its tag value method equals to post.
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
			// 获取当前用户信息
			currentUser = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

			// 获取执行的方法
			String method = request.getParameter(METHOD);

			// 从页面传递过来的参数里面获取基本信息
			parseParameters(request, method);

			// 设置response编码
			response.setCharacterEncoding("UTF-8");
			// 跨域
			response.setHeader("Access-Control-Allow-Origin", "*");

			// 记录操作日志
			if (currentUser != null && !exceptModule(domainInstance.getBasePath()))
			{
				// 忽略操作日志自身
				saveOperationLog(method);
			}

			// 执行相关方法
			if (BASE_METHOD_LIST.equals(method))
			{
				list(request, response);
			} else if (BASE_METHOD_CHECK_ID.equals(method))
			{
				checkId(request, response);
			} else if (BASE_METHOD_ADD_OR_MODIFY.equals(method))
			{
				addOrModify(request, response);
			} else if (BASE_METHOD_PRE_MODIFY.equals(method))
			{
				preModify(request, response);
			} else if (BASE_METHOD_DETAIL.equals(method))
			{
				detail(request, response);
			} else if (BASE_METHOD_EXPORT.equals(method))
			{
				export(request, response);
			} else if (BASE_METHOD_DELETE.equals(method))
			{
				delete(request, response);
			} else
			{
				// 执行相应方法，除了基本的增删改查方法以外，其他方法要在继承该类的具体类中实现
				MethodUtils.invokeMethod(this, method, new Object[]
				{ request, response }, new Class[]
				{ request.getClass(), response.getClass() });
			}

		} catch (Exception e)
		{
			log.error(e.getMessage(), e);
		}
	}

	// 以下模块不记录日志
	private boolean exceptModule(String basePath)
	{
		String[] exceptModules=new String[]{"AuthLogOperation","Dictionary"};
		return Arrays.asList(exceptModules).contains(basePath);
	}

	// 保存操作日志
	private void saveOperationLog(String method)
	{
		try
		{
			String domainInstanceJson = JSON.toJSONString(domainInstance, true);
//			String domainSearchConditionJson = JSON.toJSONString(domainSearchCondition, true);

			AuthLogOperationObj operation = new AuthLogOperationObj();
			operation.setUseraccount(currentUser.getAccount());
			operation.setUsername(currentUser.getName());
			operation.setUserdepartmentcode(currentUser.getDepartmentcode());
			operation.setModule_name(domainInstance.getCnName());
			operation.setModule_method(method);
			operation.setFull_info(domainInstanceJson);
			operation.setTimestamp(TimeUtil.nowTime2TimeStamp());

			operation.save();
		} catch (Exception e)
		{
			log.error(e.getMessage(), e);
		}
	}

	// 查询
	public void list(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 查询
		PaginationObj domainPagination = getDomainDao().searchPaginationByDomainInstance(domainInstance, true, StringUtil.isEmpty(domainSearchCondition.getOrderBy()) ? domainInstance.findDefaultOrderBy() : domainSearchCondition.getOrderBy(), domainSearchCondition.getPageNo(),
				domainSearchCondition.getPageCount());// 使用like构造条件

		request.setAttribute(DOMAIN_INSTANCE, domainInstance);
		request.setAttribute(DOMAIN_SEARCH_CONDITION, domainSearchCondition);
		request.setAttribute(DOMAIN_PAGINATION, domainPagination);

		// 转向
		if ("true".equalsIgnoreCase(request.getParameter("4m")))
		{
			// request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_LIST + "4m.jsp").forward(request, response);
			response.getWriter().write(JSON.toJSONString(domainPagination));
		} else
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_LIST + ".jsp").forward(request, response);
		}
	}

	// 检查唯一索引值是否已录入系统
	public void checkId(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		List<String> uniqueIndexProperties = domainInstance.findUniqueIndexProperties();

		String whereSql = " 1=1 ";
		for (int i = 0; i < uniqueIndexProperties.size(); i++)
		{
			// 取用于唯一性检查的字段的值
			String propName = uniqueIndexProperties.get(i);
			whereSql += " and " + propName + "='" + BeanUtils.getProperty(domainInstance, propName) + "'";
		}

		int num = getDomainDao().countByClause(whereSql);
		if (num > 0)
		{
			response.getWriter().write("true");
		} else
		{
			response.getWriter().write("false");
		}
		response.flushBuffer();
	}

	// 增加 or 修改
	public void addOrModify(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 保存或更新
		boolean success = false;
		if (domainInstance.getKeyValue() < 0)
		{
			domainInstance.setId(getDomainDao().getMaxKeyValue());
			success = getDomainDao().save(domainInstance);
		} else
		{
			success = getDomainDao().update(domainInstance);
		}

		// 声明是新增后转到的详情页面
		request.setAttribute("needRefresh", true);

		// 转向
		if (success)
		{
			detail(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	// 修改前查询领域对象信息
	public void preModify(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 查询
		Object domainObj = getDomainDao().searchByKey(getDomainInstanceClz(), domainInstance.getKeyValue() + "");

		if (domainObj != null)
		{
			request.setAttribute(DOMAIN_INSTANCE, domainObj);
		} else
		{
			request.setAttribute(DOMAIN_INSTANCE, domainInstance);
		}

		// 转向
		if ("true".equalsIgnoreCase(request.getParameter("4m")))
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_ADD_OR_MODIFY + "4m.jsp").forward(request, response);
		} else
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_ADD_OR_MODIFY + ".jsp").forward(request, response);
		}
	}

	// 详情
	public void detail(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 查询
		Object domainObj = getDomainDao().searchByKey(getDomainInstanceClz(), domainInstance.getKeyValue() + "");

		if (domainObj != null)
		{
			request.setAttribute(DOMAIN_INSTANCE, domainObj);
		}

		// 传递needRefresh
		if (request.getAttribute("needRefresh") == null)
		{
			request.setAttribute("needRefresh", request.getParameter("needRefresh"));
		}

		// 转向
		if ("true".equalsIgnoreCase(request.getParameter("4m")))
		{
			// request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_DETAIL + "4m.jsp").forward(request, response);
			response.getWriter().write(JSON.toJSONString(domainObj));
		} else
		{
			request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_DETAIL + ".jsp").forward(request, response);
		}
	}

	// 删除
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		int successCount = getDomainDao().deleteByKey(domainInstanceKeyValue);

		// 传递needRefresh
		request.setAttribute("needRefresh", true);

		// 转向
		if (successCount > 0)
		{
			list(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	// 删除 按前台条件查出的所有数据
	public void deleteAll(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		int successCount = getDomainDao().deleteByDomainInstance(domainInstance, true);// 默认使用like构造条件

		// 转向
		if (successCount > 0)
		{
			list(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	// 导出
	public void export(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 导出时不限条数，放到最大值
		PaginationObj domainPagination = getDomainDao().searchPaginationByDomainInstance(domainInstance, StringUtil.isEmpty(domainSearchCondition.getOrderBy()) ? domainInstance.findDefaultOrderBy() : domainSearchCondition.getOrderBy(), 1, Integer.MAX_VALUE);

		RequestUtil.downloadFile(this, response, domainPagination.getDataList(), getDomainInstanceClz());
	}

	// 上传文件
	public void uploadFile(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		if (this.savedFile == null)
		{
			throw new Exception("文件上传出错，请检查是否选择了合适的文件");
		}
	}

	// 解析前台传递过来的数据
	private void parseParameters(HttpServletRequest request, String method) throws Exception
	{
		Map<String, String[]> parameterMap = request.getParameterMap();

		// 处理enctype="multipart/form-data"的form，保存文件+抽取参数
		parameterMap = parseMuiltipartRequest(request);

		// 参数是否是通过url传递过来的
		boolean isFromUrl = "true".equalsIgnoreCase(request.getParameter("isFromUrl"));

		// 获取领域对象基本信息
		domainInstance = (BaseDbObj) MyBeanUtils.createInstanceFromHttpRequest(parameterMap, getDomainInstanceClz(), isFromUrl, 0);

		// 获取领域对象主键值
		domainInstanceKeyValue = request.getParameter(domainInstance.findKeyColumnName());
		if (BASE_METHOD_DELETE.equalsIgnoreCase(method) || StringUtil.isEmpty(domainInstanceKeyValue))
		{
			domainInstanceKeyValue = request.getParameter(domainInstance.findKeyColumnName() + "_4del");
		}

		// 获取领域对象查询查询条件
		domainSearchCondition = (BaseSearchCondition) MyBeanUtils.createInstanceFromHttpRequest(parameterMap, getDomainSearchConditionClz(), isFromUrl, 0);

		// 设置查询条件的业务对象
		domainSearchCondition.setDomainObj(domainInstance);

		// 设置当前账号
		domainSearchCondition.setUser(currentUser);
	}

	// 判断form enctype="multipart/form-data"并保存文件+抽取参数
	private Map<String, String[]> parseMuiltipartRequest(HttpServletRequest request) throws FileUploadException, UnsupportedEncodingException, Exception, IOException
	{
		Map<String, String[]> parameterMap = new HashMap<String, String[]>();

		// 文件置空
		this.savedFile = null;

		Enumeration<String> parameterNames = request.getParameterNames();
		while (parameterNames.hasMoreElements())
		{
			String parameterName = (String) parameterNames.nextElement();
			parameterMap.put(parameterName, request.getParameterValues(parameterName));
		}

		if (ServletFileUpload.isMultipartContent(request))
		{
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			upload.setHeaderEncoding("utf-8");
			List<FileItem> fileList = upload.parseRequest(request);
			for (int i = 0; i < fileList.size(); i++)
			{
				FileItem item = fileList.get(i);
				if (item.isFormField())
				{
					// 构造map,普通参数放入map
					parameterMap.put(item.getFieldName(), new String[]
					{ new String(item.getString().getBytes("iso-8859-1"), "utf-8") });
				} else if (this.savedFile == null)
				{
					// 文件保存,每次请求只保存第一个文件
					String fileName = item.getName();
					if (fileName == null || fileName.trim().equals(""))
					{
						continue;
					}

					String destFileName = TimeUtil.nowTime2str("yyyyMMddHHmmss_") + fileName;

					String baseDir = this.getServletConfig().getServletContext().getRealPath("/upload/");
					savedFile = new File(baseDir + "/" + destFileName);
					if (!savedFile.getParentFile().exists())
					{
						savedFile.getParentFile().mkdirs();
					}
					item.write(savedFile);

					log.info("文件上传成功，保存位置:" + savedFile.getCanonicalPath() + ",大小:" + savedFile.length());
				}
			}
		}
		return parameterMap;
	}

	private String getParameterFromUrl(HttpServletRequest request, String parameterName) throws UnsupportedEncodingException
	{
		String pValueISO88591 = request.getParameter(parameterName);
		String pValueUtf8 = new String(StringUtil.getNotEmptyStr(pValueISO88591).getBytes("iso-8859-1"), "utf-8");
		return pValueUtf8;
	}
}
