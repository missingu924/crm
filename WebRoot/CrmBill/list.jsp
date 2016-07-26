<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmBillObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.crm.searchcondition.CrmBillSearchCondition"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<!-- 基本信息 -->
<%
	// 当前上下文路径 
	String contextPath = request.getContextPath();

	// 该功能对象实例 
	CrmBillObj domainInstance = (CrmBillObj) request.getAttribute("domainInstance");
	// 该功能对象查询条件实例
	CrmBillSearchCondition domainSearchCondition = (CrmBillSearchCondition) request.getAttribute("domainSearchCondition");
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
					<td align="left">
						<%=domainInstance.getPropertyCnName("customer_id")%>
						<%=DictionaryUtil.getInputHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""), user.hasRole(SystemConstant.ROLE_ADMIN) ? "" : "id in(select id from crm_customer where (customer_manager_account like \\'%," + user.getAccount()
							+ ",%\\' or service_engineer_account like \\'%," + user.getAccount() + ",%\\'))")%>
						&nbsp;
						<%=domainInstance.getPropertyCnName("contract_id")%>
						<%=DictionaryUtil.getInputHtml("合同字典", "contract_id", StringUtil.getNotEmptyStr(domainInstance.getContract_id(), ""), "客户字典", "customer_id", user.hasRole(SystemConstant.ROLE_ADMIN) ? "" : "customer_id in(select id from crm_customer where (customer_manager_account like \\'%,"
							+ user.getAccount() + ",%\\' or service_engineer_account like \\'%," + user.getAccount() + ",%\\'))", 10)%>
						&nbsp;
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)">
					</td>
				</tr>
			</table>

			<table id="main_table" class="table table-bordered table-striped" align="center" width="98%">
				<thead>
					<tr>
						<input type="hidden" name="orderBy" id="orderBy" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getOrderBy(), "")%>">
						<th onClick="sortBy(this)" db_col="contract_id" class="<%=domainSearchCondition.getSortClassByDbColumn("contract_id")%>"><%=domainInstance.getPropertyCnName("contract_id")%></th>
						<th onClick="sortBy(this)" db_col="customer_id" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_id")%>"><%=domainInstance.getPropertyCnName("customer_id")%></th>
						<th onClick="sortBy(this)" db_col="bill_date" class="<%=domainSearchCondition.getSortClassByDbColumn("bill_date")%>"><%=domainInstance.getPropertyCnName("bill_date")%></th>
						<th onClick="sortBy(this)" db_col="bill_money" class="<%=domainSearchCondition.getSortClassByDbColumn("bill_money")%>"><%=domainInstance.getPropertyCnName("bill_money")%></th>
						<th onClick="sortBy(this)" db_col="gather_date" class="<%=domainSearchCondition.getSortClassByDbColumn("gather_date")%>"><%=domainInstance.getPropertyCnName("gather_date")%></th>
						<th onClick="sortBy(this)" db_col="gather_money" class="<%=domainSearchCondition.getSortClassByDbColumn("gather_money")%>"><%=domainInstance.getPropertyCnName("gather_money")%></th>
						<th onClick="sortBy(this)" db_col="comment" class="<%=domainSearchCondition.getSortClassByDbColumn("comment")%>"><%=domainInstance.getPropertyCnName("comment")%></th>
						<th onClick="sortBy(this)" db_col="record_account" class="<%=domainSearchCondition.getSortClassByDbColumn("record_account")%>"><%=domainInstance.getPropertyCnName("record_account")%></th>
						<th onClick="sortBy(this)" db_col="record_time" class="<%=domainSearchCondition.getSortClassByDbColumn("record_time")%>"><%=domainInstance.getPropertyCnName("record_time")%></th>
						<th>
							详情
						</th>
					</tr>
				</thead>
				<%
					double bill_money_sum = 0, gather_money_sum = 0;
					for (int i = 0; i < list.size(); i++)
					{
						CrmBillObj o = (CrmBillObj) list.get(i);
						bill_money_sum += o.getBill_money()==null?0:o.getBill_money();
						gather_money_sum += o.getGather_money()==null?0:o.getGather_money();
				%>
				<tr>
					<td><%=DictionaryUtil.getDictValueByDictKey("合同字典", o.getContract_id() + "")%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("客户字典", o.getCustomer_id() + "")%></td>
					<td><%=TimeUtil.date2str(o.getBill_date(),"yyyy-MM-dd")%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getBill_money(), 2)%></td>
					<td><%=TimeUtil.date2str(o.getGather_date(),"yyyy-MM-dd")%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getGather_money(), 2)%></td>
					<td title="<%=StringUtil.getNotEmptyStr(o.getComment())%>"><%=StringUtil.getNotEmptyStr(o.getComment(), 10)%></td>
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
					<td style="text-align: right"><%=StringUtil.formatDouble(bill_money_sum, 2)%></td>
					<td></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(gather_money_sum, 2)%></td>
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
