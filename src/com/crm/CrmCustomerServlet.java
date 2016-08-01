package com.crm;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.crm.obj.CrmBillObj;
import com.crm.obj.CrmCommercialOpportunityObj;
import com.crm.obj.CrmContactObj;
import com.crm.obj.CrmContractObj;
import com.crm.obj.CrmCustomerChangelogObj;
import com.crm.obj.CrmCustomerObj;
import com.crm.obj.CrmManagementActivityObj;
import com.crm.searchcondition.CrmCustomerSearchCondition;
import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.MyBeanUtils;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;
import com.wuyg.common.util.TimeUtil;
import com.wuyg.dictionary.DictionaryUtil;

public class CrmCustomerServlet extends AbstractBaseServletTemplate
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
		return com.crm.obj.CrmCustomerObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.crm.searchcondition.CrmCustomerSearchCondition.class;
	}

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// super.list(request, response);

		// 查询
		String where = " 1=1 ";
		// 先把domainInstance中非空的基本条件设置上
		where += MyBeanUtils.getWhereByBaseDbObj(domainInstance, getDomainDao().getTableMetaData(), true);
		// 再把其他条件设置上
		CrmCustomerSearchCondition condition = (CrmCustomerSearchCondition) domainSearchCondition;
		if (!StringUtil.isEmpty(condition.getCustomer_manager_account_list()))
		{
			List<String> customer_manager_account_list = DictionaryUtil.getKeyListFromMultiSelect(condition.getCustomer_manager_account_list());

			if (customer_manager_account_list.size() > 0)
			{
				where += " and ( 1=2 ";
			}
			for (int i = 0; i < customer_manager_account_list.size(); i++)
			{
				where += " or customer_manager_account like '%," + customer_manager_account_list.get(i) + ",%'";
			}

			where += ") ";
		}
		if (!StringUtil.isEmpty(condition.getService_engineer_account_list()))
		{
			List<String> service_engineer_account_list = DictionaryUtil.getKeyListFromMultiSelect(condition.getService_engineer_account_list());

			if (service_engineer_account_list.size() > 0)
			{
				where += " and ( 1=2 ";
			}
			for (int i = 0; i < service_engineer_account_list.size(); i++)
			{
				where += " or service_engineer_account like '%," + service_engineer_account_list.get(i) + ",%'";
			}

			where += ") ";
		}
		if (!StringUtil.isEmpty(condition.getService_due_date_start()))
		{
			where += " and service_due_date>='" + condition.getService_due_date_start() + "' ";
		}
		if (!StringUtil.isEmpty(condition.getService_due_date_end()))
		{
			where += " and service_due_date<='" + condition.getService_due_date_end() + "' ";
		}
		if (condition.getService_charge_peryear_min() != null)
		{
			where += " and service_charge_peryear>='" + condition.getService_charge_peryear_min() + "' ";
		}
		if (condition.getService_charge_peryear_max() != null)
		{
			where += " and service_charge_peryear<='" + condition.getService_charge_peryear_max() + "' ";
		}
		// 设置权限条件
		if (!currentUser.hasFunction("无限制查询"))
		{
			where += " and (customer_manager_account like '%," + currentUser.getAccount() + ",%' or service_engineer_account like '%," + currentUser.getAccount() + ",%')";
		}

		PaginationObj domainPagination = getDomainDao().searchPaginationByClause(getDomainInstanceClz(), where, StringUtil.isEmpty(domainSearchCondition.getOrderBy()) ? domainInstance.findDefaultOrderBy() : domainSearchCondition.getOrderBy(), domainSearchCondition.getPageNo(),
				domainSearchCondition.getPageCount());

		// 设置数据
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
		// super.addOrModify(request,response);

		// 前台多选字段特殊处理
		CrmCustomerObj customer = (CrmCustomerObj) domainInstance;
		customer.setCustomer_manager_account("," + StringUtil.getStringByList(Arrays.asList(request.getParameterValues("customer_manager_account")), false) + ",");
		customer.setService_engineer_account("," + StringUtil.getStringByList(Arrays.asList(request.getParameterValues("service_engineer_account")), false) + ",");

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

		// 修改前后对比
		if (success)
		{
			try
			{
				Object preDomainInstance = request.getSession().getAttribute("preDomainInstance");
				if (preDomainInstance != null)
				{
					String changeLog = customer.compare((CrmCustomerObj) preDomainInstance);
					logger.info("客户档案变化：\n" + changeLog);
					if (!StringUtil.isEmpty(changeLog))
					{
						CrmCustomerChangelogObj changelog = new CrmCustomerChangelogObj();
						changelog.setRecord_account(currentUser.getAccount());
						changelog.setRecord_time(TimeUtil.nowTime2TimeStamp());
						changelog.setCustomer_id(customer.getId() + "");
						changelog.setChange_log(changeLog);

						changelog.save();
					}
				}
			} catch (Exception e)
			{
				logger.error(e.getMessage(), e);
			}
		}

		// 用新的替换老的
		// IBaseDAO contactDao = new DefaultBaseDAO(CrmContactObj.class);
		//
		// boolean saveSuccess = false;
		// BaseDbObj childInstance = new CrmContactObj();
		// String[] contact_names = request.getParameterValues("contact_name");
		// if (contact_names != null)
		// {
		// // 先增加
		// List<BaseDbObj> contactList = MyBeanUtils.createInstanceListFromHttpRequest(request, domainInstance, childInstance.getClass(), contact_names.length, false);
		// saveSuccess = contactDao.save(contactList);
		//
		// // 再删除
		// if (contactList.size() > 0 && saveSuccess)
		// {
		// // 删除属于该父对象且子对象id小于本次插入的最小id的数据
		// contactDao.deleteByClause(childInstance.findParentKeyColumnName() + "=" + domainInstance.getKeyValue() + " and " + childInstance.findKeyColumnName() + "<" +
		// contactList.get(0).getKeyValue());
		// }
		// }

		// 声明是新增后转到的详情页面
		request.setAttribute("needRefresh", true);

		// 转向
		if (success)
		{
			detail4this(request, response);
		} else
		{
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	// 修改前查询领域对象信息
	public void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// super.preModify(request, response);
		// 查询
		Object domainObj = getDomainDao().searchByKey(getDomainInstanceClz(), domainInstance.getKeyValue() + "");

		if (domainObj != null)
		{
			request.setAttribute(DOMAIN_INSTANCE, domainObj);
		} else
		{
			request.setAttribute(DOMAIN_INSTANCE, domainInstance);
		}

		// 修改前对象
		request.getSession().setAttribute("preDomainInstance", domainObj);

		// 转向
		request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_ADD_OR_MODIFY + ".jsp").forward(request, response);
	}

	// 详情
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.detail(request, response);
	}

	// 删除
	public void delete4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// super.delete(request, response);

		int successCount = getDomainDao().deleteByKey(domainInstanceKeyValue);

		if (successCount > 0)
		{
			// 刪除联系人
			IBaseDAO dao = new DefaultBaseDAO(CrmContactObj.class);
			dao.deleteByClause("customer_id='" + domainInstanceKeyValue + "'");

			// 刪除商机
			dao = new DefaultBaseDAO(CrmCommercialOpportunityObj.class);
			dao.deleteByClause("customer_id='" + domainInstanceKeyValue + "'");

			// 刪除合同
			dao = new DefaultBaseDAO(CrmContractObj.class);
			dao.deleteByClause("customer_id='" + domainInstanceKeyValue + "'");

			// 刪除开票
			dao = new DefaultBaseDAO(CrmBillObj.class);
			dao.deleteByClause("customer_id='" + domainInstanceKeyValue + "'");

			// 刪除经营活动
			dao = new DefaultBaseDAO(CrmManagementActivityObj.class);
			dao.deleteByClause("customer_id='" + domainInstanceKeyValue + "'");
			

			// 刪除变更记录
			dao = new DefaultBaseDAO(CrmCustomerChangelogObj.class);
			dao.deleteByClause("customer_id='" + domainInstanceKeyValue + "'");
		}

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
