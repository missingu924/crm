package com.crm;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.log4j.Logger;

import com.crm.obj.CrmContactObj;
import com.crm.obj.VCrmContractObj;
import com.crm.searchcondition.CrmContactSearchCondition;
import com.crm.searchcondition.CrmContractSearchCondition;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.LunarCalendar;
import com.wuyg.common.util.MyBeanUtils;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;
import com.wuyg.common.util.TimeUtil;

public class CrmContactServlet extends AbstractBaseServletTemplate
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
		return com.crm.obj.CrmContactObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.crm.searchcondition.CrmContactSearchCondition.class;
	}

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// super.list(request,response);

		// 查询
		String where = " 1=1 ";
		// 先把domainInstance中非空的基本条件设置上
		where += MyBeanUtils.getWhereSqlFromBean(domainInstance, getDomainDao().getTableMetaData(), true);
		// 设置权限条件
		if (!currentUser.hasFunction("无限制查询"))
		{
			where += " and customer_id in(select id from crm_customer where (customer_manager_account like '%," + currentUser.getAccount() + ",%' or service_engineer_account like '%," + currentUser.getAccount() + ",%'))";
		}

		PaginationObj domainPagination = getDomainDao().searchPaginationByClause(getDomainInstanceClz(), where, StringUtil.isEmpty(domainSearchCondition.getOrderBy()) ? domainInstance.findDefaultOrderBy() : domainSearchCondition.getOrderBy(), domainSearchCondition.getPageNo(),
				domainSearchCondition.getPageCount());

		// 生日判断
		CrmContactSearchCondition condition = (CrmContactSearchCondition) domainSearchCondition;
		if (condition.getContact_birthday() > 0)
		{
			List<CrmContactObj> list = new ArrayList<CrmContactObj>();
			
			Date endDate = TimeUtil.computeDate(condition.getContact_birthday() + "D");
			Date startDate = new Date(TimeUtil.getToday());
			logger.info("startDate:"+TimeUtil.date2str(startDate)+",endDate:"+TimeUtil.date2str(endDate));
			int thisYear = Calendar.getInstance().get(Calendar.YEAR);
			int nextYear = thisYear + 1;

			List<CrmContactObj> dataList = domainPagination.getDataList();
			for (int i = 0; i < dataList.size(); i++)
			{
				CrmContactObj c = dataList.get(i);
				if (!StringUtil.isEmpty(c.getContact_birthday()))
				{
					try
					{
						String birthdayStr = thisYear + "-" + c.getContact_birthday_month() + "-" + c.getContact_birthday_day();
						Date birthday = TimeUtil.str2date(birthdayStr, "yyyy-M-d");
						if ("阴历".equalsIgnoreCase(c.getContact_birthday_type()))
						{
							// 阴历转阳历
							String birthdaySolar = LunarCalendar.lunarToSolar(TimeUtil.date2str(birthday, "yyyy-MM-dd"));
							birthday = TimeUtil.str2date(birthdaySolar, "yyyy-MM-dd");
						}
						logger.debug("birthday:"+TimeUtil.date2str(birthday));

						// 判断是否符合条件
						if (birthday.getTime() >= startDate.getTime() && birthday.getTime() <= endDate.getTime())
						{
							list.add(c);
						}
						
					} catch (Exception e)
					{
						// TODO: handle exception
					}
				}
			}
			
			domainPagination.setDataList(list);
			domainPagination.setTotalCount(list.size());
		}

		request.setAttribute(DOMAIN_INSTANCE, domainInstance);
		request.setAttribute(DOMAIN_SEARCH_CONDITION, domainSearchCondition);
		request.setAttribute(DOMAIN_PAGINATION, domainPagination);

		// 转向
		request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_LIST + ".jsp").forward(request, response);
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

	// 删除 按前台条件查出的所有数据
	public void deleteAll4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.deleteAll(request, response);
	}

	// 导出
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.exportFromHtml(request, response);
	}

}
