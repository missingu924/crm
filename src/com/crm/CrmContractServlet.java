package com.crm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.crm.obj.CrmBillObj;
import com.crm.obj.CrmCommercialOpportunityObj;
import com.crm.obj.CrmContractObj;
import com.crm.obj.CrmCustomerObj;
import com.crm.obj.CrmManagementActivityObj;
import com.crm.obj.VCrmContractObj;
import com.crm.searchcondition.CrmContractSearchCondition;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.MyBeanUtils;
import com.wuyg.common.util.RequestUtil;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;

public class CrmContractServlet extends AbstractBaseServletTemplate
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
		return com.crm.obj.CrmContractObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.crm.searchcondition.CrmContractSearchCondition.class;
	}

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// super.list(request,response);

		// 查询
		String where = " 1=1 ";
		// 先把domainInstance中非空的基本条件设置上
		where += MyBeanUtils.getWhereSqlFromBean(domainInstance, getDomainDao().getTableMetaData(), true);
		// 设置其他条件
		CrmContractSearchCondition condition = (CrmContractSearchCondition)domainSearchCondition;
		if (!StringUtil.isEmpty(condition.getContract_sign_time_start()))
		{
			where += " and contract_sign_time>='" + condition.getContract_sign_time_start() + "' ";
		}
		if (!StringUtil.isEmpty(condition.getContract_sign_time_end()))
		{
			where += " and contract_sign_time<='" + condition.getContract_sign_time_end() + "' ";
		}
		if (condition.getContract_price_min() != null)
		{
			where += " and contract_price>='" + condition.getContract_price_min() + "' ";
		}
		if (condition.getContract_price_max() != null)
		{
			where += " and contract_price<='" + condition.getContract_price_max() + "' ";
		}
		// 设置权限条件
		if (!currentUser.hasRole(SystemConstant.ROLE_ADMIN))
		{
			where += " and customer_id in(select id from crm_customer where (customer_manager_account like '%," + currentUser.getAccount() + ",%' or service_engineer_account like '%," + currentUser.getAccount() + ",%'))";
		}

		Class clz = VCrmContractObj.class;
		IBaseDAO vCrmContractDao = new DefaultBaseDAO(clz);

		PaginationObj domainPagination = vCrmContractDao.searchPaginationByClause(getDomainInstanceClz(), where, StringUtil.isEmpty(domainSearchCondition.getOrderBy()) ? domainInstance.findDefaultOrderBy() : domainSearchCondition.getOrderBy(), domainSearchCondition.getPageNo(),
				domainSearchCondition.getPageCount());

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

		// 更新商机状态为 成交 ，
		CrmContractObj contract = (CrmContractObj) domainInstance;
		if (success)
		{
			CrmCommercialOpportunityObj opportunity = new CrmCommercialOpportunityObj();
			opportunity.setId(StringUtil.parseLong(contract.getCommercial_oppotunity_id()));
			opportunity.setSale_stage_code("成交");
			opportunity.update();
		}

		// 更新客户状态
		if (success)
		{
			CrmCustomerObj customer = new CrmCustomerObj();
			customer.setId(StringUtil.parseLong(contract.getCustomer_id()));
			customer.setCustomer_is_deal("是");
			customer.update();
		}

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
		super.preModify(request, response);
	}

	// 详情
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// super.detail(request,response);

		// 查询
		Class clz = VCrmContractObj.class;
		IBaseDAO vCrmContractDao = new DefaultBaseDAO(clz);

		Object domainObj = vCrmContractDao.searchByKey(clz, domainInstance.getKeyValue() + "");

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
		request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_DETAIL + ".jsp").forward(request, response);
	}

	// 删除
	public void delete4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// super.delete(request, response);

		int successCount = getDomainDao().deleteByKey(domainInstanceKeyValue);

		if (successCount > 0)
		{
			// 刪除开票
			IBaseDAO dao = new DefaultBaseDAO(CrmBillObj.class);
			dao.deleteByClause("contract_id='" + domainInstanceKeyValue + "'");

			// 刪除经营活动
			dao = new DefaultBaseDAO(CrmManagementActivityObj.class);
			dao.deleteByClause("contract_id='" + domainInstanceKeyValue + "'");
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
//		super.export(request, response);
		// 导出时不限条数，放到最大值
		PaginationObj domainPagination = new DefaultBaseDAO(VCrmContractObj.class).searchPaginationByDomainInstance(domainInstance, StringUtil.isEmpty(domainSearchCondition.getOrderBy()) ? domainInstance.findDefaultOrderBy() : domainSearchCondition.getOrderBy(), 1, Integer.MAX_VALUE);

		RequestUtil.downloadFile(this, response, domainPagination.getDataList(), getDomainInstanceClz());
	}

}
