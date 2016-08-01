package com.crm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.crm.obj.CrmBillObj;
import com.crm.obj.CrmCommercialOpportunityObj;
import com.crm.obj.CrmContactObj;
import com.crm.obj.CrmContractObj;
import com.crm.obj.CrmManagementActivityObj;
import com.crm.obj.VCrmCommercialOpportunityObj;
import com.crm.searchcondition.CrmCommercialOpportunitySearchCondition;
import com.crm.searchcondition.CrmCustomerSearchCondition;
import com.inspur.common.dictionary.Dictionary;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.MyBeanUtils;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;
import com.wuyg.dictionary.DictionaryUtil;

public class CrmCommercialOpportunityServlet extends AbstractBaseServletTemplate
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
		return com.crm.obj.CrmCommercialOpportunityObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.crm.searchcondition.CrmCommercialOpportunitySearchCondition.class;
	}

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
//		super.list(request, response);
		
		IBaseDAO dao = new DefaultBaseDAO(VCrmCommercialOpportunityObj.class);
		
		// 查询
		String where = " 1=1 ";
		// 先把domainInstance中非空的基本条件设置上
		where += MyBeanUtils.getWhereByBaseDbObj(domainInstance, dao.getTableMetaData(), true);
		CrmCommercialOpportunitySearchCondition condition = (CrmCommercialOpportunitySearchCondition)domainSearchCondition;
		// 设置其他条件
		if (!StringUtil.isEmpty(condition.getEstimate_sign_time_start()))
		{
			where += " and estimate_sign_time>='" + condition.getEstimate_sign_time_start() + "' ";
		}
		if (!StringUtil.isEmpty(condition.getEstimate_sign_time_end()))
		{
			where += " and estimate_sign_time<='" + condition.getEstimate_sign_time_end() + "' ";
		}
		if (condition.getTarget_price_min() != null)
		{
			where += " and target_price>='" + condition.getTarget_price_min() + "' ";
		}
		if (condition.getTarget_price_max() != null)
		{
			where += " and target_price<='" + condition.getTarget_price_max() + "' ";
		}
		// 设置权限条件
		if (!currentUser.hasFunction("无限制查询"))
		{
			where += " and customer_id in(select id from crm_customer where (customer_manager_account like '%," + currentUser.getAccount() + ",%' or service_engineer_account like '%," + currentUser.getAccount() + ",%'))";
		}

		PaginationObj domainPagination = dao.searchPaginationByClause(VCrmCommercialOpportunityObj.class, where, StringUtil.isEmpty(domainSearchCondition.getOrderBy()) ? domainInstance.findDefaultOrderBy() : domainSearchCondition.getOrderBy(), domainSearchCondition.getPageNo(),
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
		super.addOrModify(request, response);
	}

	// 修改前查询领域对象信息
	public void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.preModify(request, response);
	}
	
	// 复制
	public void copy4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 查询
		Object domainObj4copy = getDomainDao().searchByKey(getDomainInstanceClz(), domainInstance.getKeyValue() + "");
		
		CrmCommercialOpportunityObj commercialOpportunity = new CrmCommercialOpportunityObj();

		if (domainObj4copy != null)
		{
			//复制商机时，商机名称、经营类型、目标金额不用带过来
			CrmCommercialOpportunityObj commercialOpportunity4copy = (CrmCommercialOpportunityObj)domainObj4copy;
			commercialOpportunity.setCustomer_id(commercialOpportunity4copy.getCustomer_id());
			commercialOpportunity.setCustomer_request(commercialOpportunity4copy.getCustomer_request());
			commercialOpportunity.setEstimate_sign_time(commercialOpportunity4copy.getEstimate_sign_time());
			commercialOpportunity.setManagement_account(commercialOpportunity4copy.getManagement_account());
			commercialOpportunity.setNext_step(commercialOpportunity4copy.getNext_step());
			commercialOpportunity.setSale_stage_code(commercialOpportunity4copy.getSale_stage_code());
			commercialOpportunity.setSource(commercialOpportunity4copy.getSource());
			commercialOpportunity.setProduct_code(commercialOpportunity4copy.getProduct_code());
			commercialOpportunity.setProduct_version_code(commercialOpportunity4copy.getProduct_version_code());
			
		} 
		request.setAttribute(DOMAIN_INSTANCE, commercialOpportunity);

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
			// 刪除合同
			IBaseDAO dao = new DefaultBaseDAO(CrmContractObj.class);
			dao.deleteByClause("commercial_oppotunity_id='" + domainInstanceKeyValue + "'");

			// 刪除开票
			dao = new DefaultBaseDAO(CrmBillObj.class);
			dao.deleteByClause("commerical_opportunity_id='" + domainInstanceKeyValue + "'");

			// 刪除经营活动
			dao = new DefaultBaseDAO(CrmManagementActivityObj.class);
			dao.deleteByClause("commercial_oppotunity_id='" + domainInstanceKeyValue + "'");
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
