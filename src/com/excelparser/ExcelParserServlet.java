package com.excelparser;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.excelparser.obj.ExcelParserObj;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.ExcelParserUtil;
import com.wuyg.common.util.StringUtil;
import com.wuyg.excelparser.ExcelParser;
import com.wuyg.excelparser.obj.ExcelColumnObj;
import com.wuyg.excelparser.obj.ExcelParserConfigObj;

public class ExcelParserServlet extends AbstractBaseServletTemplate
{
	private Logger logger = Logger.getLogger(getClass());

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
		return com.excelparser.obj.ExcelParserObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.excelparser.searchcondition.ExcelParserSearchCondition.class;
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
		super.addOrModify(request, response);
	}

	// 修改前查询领域对象信息
	public void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.preModify(request, response);
	}

	// 详情
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.detail(request, response);
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

	// 上传文件并预览
	public void uploadFile(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try
		{
			List<BaseDbObj> excelDataList = new ArrayList();
			List inDbDataList = new ArrayList();
			List justInExcelDataList = new ArrayList();

			request.setAttribute(DOMAIN_INSTANCE, domainInstance);

			ExcelParserObj excelParserObj = (ExcelParserObj) domainInstance;

			// 1、======保存Excel文件
			// File saveFile = saveFile(request);

			File saveFile = super.savedFile;
			if (saveFile == null)
			{
				throw new Exception("文件上传出错，请检查是否选择了合适的文件");
			}

			// 2、======Excel解析到javabean

			// 获取解析器配置信息
			ExcelParserConfigObj excelParserConfig = null;
			try
			{
				// 优先根据 解析器名字 从配置文件中获取excel解析器
				excelParserConfig = ExcelParser.getExcelParserByName(excelParserObj.getParser_name());
			} catch (Exception e)
			{
				logger.error(e.getMessage());

				// 如果配置文件中没有配置该excel解析器，则根据前台传递过来的excel对应的basedbobj类来获取默认解析器
				String basedbobj_class = excelParserObj.getBasedbobj_class();
				logger.info("使用basedbobj类获取excel解析配置器,对应的类为：" + basedbobj_class);
				BaseDbObj baseDbObj = (BaseDbObj) Thread.currentThread().getContextClassLoader().loadClass(basedbobj_class).newInstance();
				excelParserConfig = ExcelParserUtil.getExcelParserConfigByBaseDbObj(baseDbObj);
			}

			if (excelParserConfig == null)
			{
				throw new Exception("找不到解析该Excel文件所需的配置信息，请检查Excel解析配置文件。");
			}

			Class javaBeanClass = Thread.currentThread().getContextClassLoader().loadClass(excelParserConfig.getJavaBean());

			// 解析Excel文件
			Map paramMap = new HashMap();
			paramMap.put("request", request);
			paramMap.put("response", response);

			excelDataList = ExcelParser.parse(saveFile, excelParserConfig, paramMap);
			logger.info("Excel解析出的数据共" + excelDataList.size() + "条:");

			// 3、======数据比对（用唯一标识字段比较excel中的数据与数据库中的数据）

			// 根据唯一标识从数据库中抓取数据
			List<ExcelColumnObj> uniqueColumns = excelParserConfig.getUniqueColumns();
			
			String inDbSql=getInDbSql(excelDataList,uniqueColumns);

			IBaseDAO dao = new DefaultBaseDAO(javaBeanClass);
			List dbSearchedDataList = dao.searchByClause(javaBeanClass, inDbSql.toString(), null, 0, Integer.MAX_VALUE);

			logger.info("需更新数据共" + dbSearchedDataList.size() + "条:");

			// 比对数据情况:新增 或 更新
			for (int i = 0; i < excelDataList.size(); i++)
			{
				BaseDbObj excelRowObj = (BaseDbObj) excelDataList.get(i);

				String uniqueColumnsValueInExcel = getUniqueColumnsValue(uniqueColumns, excelRowObj);
				boolean isInDb = false;
				for (int j = 0; j < dbSearchedDataList.size(); j++)
				{
					BaseDbObj dbRowObj = (BaseDbObj) dbSearchedDataList.get(j);
					String uniqueColumnsValueInDb = getUniqueColumnsValue(uniqueColumns, dbRowObj);
					if (uniqueColumnsValueInExcel.trim().equalsIgnoreCase(uniqueColumnsValueInDb.trim()))
					{
						isInDb = true;
						excelRowObj.setId(dbRowObj.getKeyValue());// 用数据库中的id填充
						inDbDataList.add(excelRowObj);
						break;
					}
				}

				if (!isInDb)
				{
					justInExcelDataList.add(excelRowObj);
				}
			}

			logger.info("新增数据共" + justInExcelDataList.size() + "条:");

			request.getSession().setAttribute("excelDataList", excelDataList);
			request.getSession().setAttribute("inDbDataList", inDbDataList);
			request.getSession().setAttribute("justInExcelDataList", justInExcelDataList);
			request.getSession().setAttribute("excelParserConfig", excelParserConfig);

			// 4、反馈预览

			// response.getWriter().print(URLEncoder.encode("保存数据成功", "utf-8"));

		} catch (Exception e)
		{
			request.setAttribute("errorMessage", e);
			logger.error(e.getCause(), e);
			request.getRequestDispatcher("/" + getBasePath() + "/importResult.jsp").forward(request, response);
		} finally
		{
			request.getRequestDispatcher("/" + getBasePath() + "/uploadPreview.jsp").forward(request, response);
		}
	}
	
	private String getInDbSql(List<BaseDbObj> excelDataList,List<ExcelColumnObj> uniqueColumns) throws Exception
	{
		StringBuffer inDbSql = new StringBuffer("( 1=0 ");
		for (int i = 0; i < excelDataList.size(); i++)
		{
			String clause = "";
			Object obj = excelDataList.get(i);
			for (int j = 0; j < uniqueColumns.size(); j++)
			{
				ExcelColumnObj uniqueColumn = uniqueColumns.get(j);
				String uniqueColumnName = uniqueColumn.getJavaBeanProperty();
				String uniqueColumnValue = BeanUtils.getProperty(obj, uniqueColumnName);

				clause += (j == 0 ? "" : " and ") + uniqueColumnName + "='" + uniqueColumnValue + "' ";
			}

			if (!StringUtil.isEmpty(clause))
			{
				inDbSql.append(" or (" + clause + ") ");
			}
		}
		inDbSql.append(" )");
		
		return inDbSql.toString();
	}

	private String getUniqueColumnsValue(List<ExcelColumnObj> uniqueColumns, BaseDbObj baseDbObj) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException
	{
		String uniqueColumnsValue = "";
		for (int j = 0; j < uniqueColumns.size(); j++)
		{
			uniqueColumnsValue += "--" + BeanUtils.getProperty(baseDbObj, uniqueColumns.get(j).getJavaBeanProperty());
		}
		return uniqueColumnsValue;
	}

	// 上传文件并预览
	public void import2db(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try
		{
			ExcelParserObj excelParserObj = (ExcelParserObj) domainInstance;

			List excelDataList = new ArrayList(); // 本次解析出的所有记录
			List inDbDataList = new ArrayList(); // 数据库中已经存在的记录
			List justInExcelDataList = new ArrayList(); // 本次新增的记录

			ExcelParserConfigObj excelParserConfig = null;

			Object tmpObj = request.getSession().getAttribute("excelDataList");
			if (tmpObj != null)
			{
				excelDataList = (List) tmpObj;
			}

			tmpObj = request.getSession().getAttribute("inDbDataList");
			if (tmpObj != null)
			{
				inDbDataList = (List) tmpObj;
			}

			tmpObj = request.getSession().getAttribute("justInExcelDataList");
			if (tmpObj != null)
			{
				justInExcelDataList = (List) tmpObj;
			}

			tmpObj = request.getSession().getAttribute("excelParserConfig");
			if (tmpObj != null)
			{
				excelParserConfig = (ExcelParserConfigObj) tmpObj;
			}

			String message = "";
			IBaseDAO dao = new DefaultBaseDAO(Thread.currentThread().getContextClassLoader().loadClass(excelParserConfig.getJavaBean()));
			if ("新增".equalsIgnoreCase(excelParserObj.getImport_type()))
			{
				// 保存新增数据

				if (justInExcelDataList.size() > 0)
				{
					dao.save(justInExcelDataList);
					message += "新增数据：" + justInExcelDataList.size() + "条\n";
				}

				if ("覆盖系统中相同数据".equalsIgnoreCase(excelParserObj.getSame_record_process_type()))
				{
					// 覆盖系统中相同数据
					if (inDbDataList.size() > 0)
					{
						dao.update(inDbDataList);
						message += "覆盖系统中相同数据：" + inDbDataList.size() + "条\n";
					}

				}
			} else if ("覆盖".equalsIgnoreCase(excelParserObj.getImport_type()))
			{
				// 先删除
				dao.deleteByClause(getInDbSql(excelDataList, excelParserConfig.getUniqueColumns()));
				
				getInDbSql(excelDataList, excelParserConfig.getUniqueColumns());

				// 再入库
				if (excelDataList.size() > 0)
				{
					long maxKeyValue= dao.getMaxKeyValue();
					for (int i = 0; i < excelDataList.size(); i++)
					{
						BaseDbObj excelData=(BaseDbObj)excelDataList.get(i);
						excelData.setId(maxKeyValue++);
					}
					dao.save(excelDataList);
				}

				message += "删除系统中原有数据，并导入新数据：" + excelDataList.size() + "条\n";
			}
			if (StringUtil.isEmpty(message))
			{
				message = "本次导入没有任何数据受影响";
			}
			logger.info(message);
			request.setAttribute("message", message);

			request.setAttribute("needRefresh", true);// 刷新数据
		} catch (Exception e)
		{
			request.setAttribute("errorMessage", e.getMessage());
			throw e;
		} finally
		{
			request.getRequestDispatcher("/" + getBasePath() + "/importResult.jsp").forward(request, response);
		}
	}

}
