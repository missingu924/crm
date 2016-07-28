package com.crm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.crm.obj.CrmBillObj;
import com.crm.obj.CrmContractObj;
import com.crm.obj.VCrmContractObj;
import com.crm.searchcondition.CrmBillSearchCondition;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.MyBeanUtils;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;

public class CrmBillServlet extends AbstractBaseServletTemplate
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
		return com.crm.obj.CrmBillObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.crm.searchcondition.CrmBillSearchCondition.class;
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
		CrmBillSearchCondition condition = (CrmBillSearchCondition) domainSearchCondition;
		if (!StringUtil.isEmpty(condition.getGather_date_start()))
		{
			where += " and gather_date>='" + condition.getGather_date_start() + "' ";
		}
		if (!StringUtil.isEmpty(condition.getGather_date_end()))
		{
			where += " and gather_date<='" + condition.getGather_date_end() + "' ";
		}
		if (!StringUtil.isEmpty(condition.getBill_date_start()))
		{
			where += " and bill_date>='" + condition.getBill_date_start() + "' ";
		}
		if (!StringUtil.isEmpty(condition.getBill_date_end()))
		{
			where += " and bill_date<='" + condition.getBill_date_end() + "' ";
		}
		// 设置权限条件
		if (!currentUser.hasRole(SystemConstant.ROLE_ADMIN) && !currentUser.hasRole(SystemConstant.ROLE_CAIWU))
		{
			where += " and customer_id in(select id from crm_customer where (customer_manager_account like '%," + currentUser.getAccount() + ",%' or service_engineer_account like '%," + currentUser.getAccount() + ",%'))";
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

		// 更新合同是否结束字段，如果没有余款了则自动结束
		CrmBillObj bill = (CrmBillObj) domainInstance;
		if (success)
		{
			VCrmContractObj vContract = (VCrmContractObj) new DefaultBaseDAO(VCrmContractObj.class).searchByKey(VCrmContractObj.class, bill.getContract_id());

			if (vContract.getSpare_money() == 0)
			{
				CrmContractObj contract = new CrmContractObj();
				contract.setId(StringUtil.parseLong(bill.getContract_id()));
				contract.setIs_finished("是");
				contract.update();
			}
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
