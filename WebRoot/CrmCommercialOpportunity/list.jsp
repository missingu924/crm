<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmCommercialOpportunityObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.crm.searchcondition.CrmCommercialOpportunitySearchCondition"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<!-- 基本信息 -->
<%
	// 当前上下文路径 
	String contextPath = request.getContextPath();

	// 该功能对象实例 
	CrmCommercialOpportunityObj domainInstance = (CrmCommercialOpportunityObj) request.getAttribute("domainInstance");
	// 该功能对象查询条件实例
	CrmCommercialOpportunitySearchCondition domainSearchCondition = (CrmCommercialOpportunitySearchCondition) request.getAttribute("domainSearchCondition");
	// 该功能路径 
	String basePath = domainInstance.getBasePath();

	// 查询结果 
	PaginationObj pagination = null;
	List list = new ArrayList();

	// 用户信息
	AuthUserObj user = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

	Object paginationObj = request.getAttribute("domainPagination");
	if (paginationObj != null)
	{
		pagination = (PaginationObj) paginationObj;
		list = (List) pagination.getDataList();
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />
		<title><%=domainInstance.getCnName()%>列表</title>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
	</head>
	<body>
		<form name="pageForm" id="pageForm" method="post" action="<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=list4this">

			<!-- 查询条件 -->
			<table class="search_table" align="center" width="98%">
				<tr>
					<td><%=domainInstance.getPropertyCnName("opportunity_name")%></td>
					<td>
						<input name="opportunity_name" type="text" id="opportunity_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getOpportunity_name())%>" size="40">
					</td>
					<td>
						<input name="searchButton2" type="button" class="button button_search" value="查询数据" onClick="toPage(1)">
						<input name="searchButton" type="button" class="button button_set" value="高级查询" onClick="$('#search_condition_table').toggle();$('#showSearchConditionTable').val(!$('#search_condition_table').is(':hidden'));">
					</td>
				</tr>
			</table>
			<table id="search_condition_table" class="search_condition_table" align="center" width="98%" style='display: <%=domainSearchCondition.isShowSearchConditionTable() ? "" : "none"%>'>
				<input type="hidden" id="showSearchConditionTable" name="showSearchConditionTable" value="<%=domainSearchCondition.isShowSearchConditionTable()%>">
				<tr>
					<td><%=domainInstance.getPropertyCnName("customer_id")%></td>
					<td><%=DictionaryUtil.getInputHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""), user.hasFunction("无限制查询") ? "" : "id in(select id from crm_customer where (customer_manager_account like \\'%," + user.getAccount()
							+ ",%\\' or service_engineer_account like \\'%," + user.getAccount() + ",%\\'))")%></td>
					<td><%=domainInstance.getPropertyCnName("management_account")%></td>
					<td><%=DictionaryUtil.getInputHtml("账号字典", "management_account", StringUtil.getNotEmptyStr(domainInstance.getManagement_account(), ""))%></td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("management_type_code")%></td>
					<td><%=DictionaryUtil.getInputHtml("经营类型字典", "management_type_code", StringUtil.getNotEmptyStr(domainInstance.getManagement_type_code(), ""))%></td>
					<td><%=domainInstance.getPropertyCnName("sale_stage_code")%></td>
					<td><%=DictionaryUtil.getInputHtml("销售阶段字典", "sale_stage_code", StringUtil.getNotEmptyStr(domainInstance.getSale_stage_code(), ""))%></td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("estimate_sign_time")%></td>
					<td>
						<input name="estimate_sign_time_start" type="text" id="estimate_sign_time_start" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getEstimate_sign_time_start())%>" size="15" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
						-
						<input name="estimate_sign_time_end" type="text" id="estimate_sign_time_end" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getEstimate_sign_time_end())%>" size="15" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
					</td>
					<td><%=domainInstance.getPropertyCnName("target_price")%></td>
					<td>
						<input name="target_price_min" type="text" id="target_price_min" value="<%=StringUtil.formatDouble(domainSearchCondition.getTarget_price_min(), 2)%>" size="15">
						-
						<input name="target_price_max" type="text" id="target_price_max" value="<%=StringUtil.formatDouble(domainSearchCondition.getTarget_price_max(), 2)%>" size="15">
					</td>
				</tr>
			</table>

			<table id="main_table" class="table table-bordered table-striped" align="center" width="98%">
				<thead>
					<tr>
						<input type="hidden" name="orderBy" id="orderBy" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getOrderBy(), "")%>">
						<th onClick="sortBy(this)" db_col="opportunity_name" class="<%=domainSearchCondition.getSortClassByDbColumn("opportunity_name")%>"><%=domainInstance.getPropertyCnName("opportunity_name")%></th>
						<th onClick="sortBy(this)" db_col="customer_id" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_id")%>"><%=domainInstance.getPropertyCnName("customer_id")%></th>
						<th onClick="sortBy(this)" db_col="management_type_code" class="<%=domainSearchCondition.getSortClassByDbColumn("management_type_code")%>"><%=domainInstance.getPropertyCnName("management_type_code")%></th>
						<th onClick="sortBy(this)" db_col="sale_stage_code" class="<%=domainSearchCondition.getSortClassByDbColumn("sale_stage_code")%>"><%=domainInstance.getPropertyCnName("sale_stage_code")%></th>
						<th onClick="sortBy(this)" db_col="target_price" class="<%=domainSearchCondition.getSortClassByDbColumn("target_price")%>"><%=domainInstance.getPropertyCnName("target_price")%></th>
						<th onClick="sortBy(this)" db_col="estimate_sign_time" class="<%=domainSearchCondition.getSortClassByDbColumn("estimate_sign_time")%>"><%=domainInstance.getPropertyCnName("estimate_sign_time")%></th>
						<th onClick="sortBy(this)" db_col="management_account" class="<%=domainSearchCondition.getSortClassByDbColumn("management_account")%>"><%=domainInstance.getPropertyCnName("management_account")%></th>
						<th onClick="sortBy(this)" db_col="customer_request" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_request")%>"><%=domainInstance.getPropertyCnName("customer_request")%></th>
						<th onClick="sortBy(this)" db_col="next_step" class="<%=domainSearchCondition.getSortClassByDbColumn("next_step")%>"><%=domainInstance.getPropertyCnName("next_step")%></th>
						<th onClick="sortBy(this)" db_col="record_account" class="<%=domainSearchCondition.getSortClassByDbColumn("record_account")%>"><%=domainInstance.getPropertyCnName("record_account")%></th>
						<th onClick="sortBy(this)" db_col="record_time" class="<%=domainSearchCondition.getSortClassByDbColumn("record_time")%>"><%=domainInstance.getPropertyCnName("record_time")%></th>
						<th>
							详情
						</th>
					</tr>
				</thead>
				<%
					double target_price_sum = 0;

					for (int i = 0; i < list.size(); i++)
					{
						CrmCommercialOpportunityObj o = (CrmCommercialOpportunityObj) list.get(i);
						target_price_sum += o.getTarget_price() == null ? 0 : o.getTarget_price();
				%>
				<tr>
					<td><%=StringUtil.getNotEmptyStr(o.getOpportunity_name())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("客户字典", o.getCustomer_id() + "")%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("经营类型字典", o.getManagement_type_code())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("销售阶段字典", o.getSale_stage_code())%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getTarget_price(), 2)%></td>
					<td><%=TimeUtil.date2str(o.getEstimate_sign_time(), "yyyy-MM-dd")%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", o.getManagement_account())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getCustomer_request(), 10)%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getNext_step(), 10)%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", o.getRecord_account())%></td>
					<td><%=TimeUtil.date2str(o.getRecord_time())%></td>
					<td style="text-align: center">
						<input type="button" class="button button_detail" title="详情" onClick="winOpen('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')">
					</td>
				</tr>
				<%
					}
					if (list.size() > 0)
					{
				%>
				<tr style="color: blue">
					<td>
						合计
					</td>
					<td></td>
					<td></td>
					<td></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(target_price_sum, 2)%></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<%
					}
				%>
			</table>

			<!-- 翻页操作栏 -->
			<jsp:include page="../ToolBar/pagination_toolbar.jsp">
				<jsp:param name="basePath" value="<%=basePath%>" />
			</jsp:include>

		</form>

	</body>
</html>
