<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmCustomerObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.crm.searchcondition.CrmCustomerSearchCondition"%>
<!-- 基本信息 -->
<%
	// 当前上下文路径 
	String contextPath = request.getContextPath();

	// 该功能对象实例 
	CrmCustomerObj domainInstance = (CrmCustomerObj) request.getAttribute("domainInstance");
	// 该功能对象查询条件实例
	CrmCustomerSearchCondition domainSearchCondition = (CrmCustomerSearchCondition) request.getAttribute("domainSearchCondition");
	// 该功能路径 
	String basePath = domainInstance.getBasePath();

	// 查询结果 
	PaginationObj pagination = null;
	List list = new ArrayList();

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
		<style type="text/css">
.search_table td {
	padding: 2px;
}
</style>
	</head>
	<body>
		<form name="pageForm" id="pageForm" method="post" action="<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=list4this">

			<!-- 查询条件 -->
			<table class="search_table" align="center" width="98%">
				<tr>
					<td align="right">
						<%=domainInstance.getPropertyCnName("customer_full_name")%>&nbsp;
					</td>
					<td colspan="8" align="left">
						<input name="customer_full_name" type="text" id="customer_full_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_full_name())%>" size="50">
					</td>
					<td align="right">
						<input name="addButton" type="button" class="button button_add" value="新增客户" onClick="winOpen('<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this')">
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)">
					</td>
				</tr>
				<tr>
					<td align="right"><%=domainInstance.getPropertyCnName("customer_type_code")%>&nbsp;&nbsp;
						<br>
					</td>
					<td align="left"><%=DictionaryUtil.getInputHtml("客户分类字典", "customer_type_code", StringUtil.getNotEmptyStr(domainInstance.getCustomer_type_code(), ""))%></td>
					<td align="right"><%=domainInstance.getPropertyCnName("customer_region_code")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("区域字典", "customer_region_code", StringUtil.getNotEmptyStr(domainInstance.getCustomer_region_code(), ""))%></td>
					<td align="right"><%=domainInstance.getPropertyCnName("customer_manager_account")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("账号字典", "customer_manager_account_list", StringUtil.getNotEmptyStr(domainSearchCondition.getCustomer_manager_account_list(), ""))%></td>
					<td align="right"><%=domainInstance.getPropertyCnName("service_engineer_account")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("账号字典", "service_engineer_account_list", StringUtil.getNotEmptyStr(domainSearchCondition.getService_engineer_account_list(), ""))%></td>
					<td align="right"><%=domainInstance.getPropertyCnName("customer_is_deal")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("是否字典", "customer_is_deal", StringUtil.getNotEmptyStr(domainInstance.getCustomer_is_deal(), ""))%></td>
				</tr>
				<tr>
					<td align="right"><%=domainInstance.getPropertyCnName("product_code")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("产品字典", "product_code", StringUtil.getNotEmptyStr(domainInstance.getProduct_code(), ""))%></td>
					<td align="right"><%=domainInstance.getPropertyCnName("product_version_code")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("产品版本字典", "product_version_code", StringUtil.getNotEmptyStr(domainInstance.getProduct_version_code(), ""))%></td>
					<td align="right"><%=domainInstance.getPropertyCnName("service_due_date")%></td>
					<td colspan="3" align="left">
						<input name="service_due_date_start" type="text" id="service_due_date_start" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getService_due_date_start())%>" size="11" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
						-
						<input name="service_due_date_end" type="text" id="service_due_date_end" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getService_due_date_end())%>" size="11" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
					</td>
					<td align="right"><%=domainInstance.getPropertyCnName("service_charge_peryear")%></td>
					<td align="left">
						<input name="service_charge_peryear_min" type="text" id="service_charge_peryear_min" value="<%=StringUtil.formatDouble(domainSearchCondition.getService_charge_peryear_min(), 2)%>" size="11">
						-
						<input name="service_charge_peryear_max" type="text" id="service_charge_peryear_max" value="<%=StringUtil.formatDouble(domainSearchCondition.getService_charge_peryear_max(), 2)%>" size="11">
					</td>
				</tr>
			</table>

			<table class="table table-bordered table-striped table-sorted" align="center" width="98%">
				<thead>
					<tr>
						<input type="hidden" name="orderBy" id="orderBy" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getOrderBy(), "")%>">
						<th onClick="sortBy(this)" db_col="customer_full_name" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_full_name")%>"><%=domainInstance.getPropertyCnName("customer_full_name")%></th>
						<th onClick="sortBy(this)" db_col="customer_type_code" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_type_code")%>"><%=domainInstance.getPropertyCnName("customer_type_code")%></th>
						<th onClick="sortBy(this)" db_col="customer_region_code" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_region_code")%>"><%=domainInstance.getPropertyCnName("customer_region_code")%></th>
						<th onClick="sortBy(this)" db_col="customer_address" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_address")%>"><%=domainInstance.getPropertyCnName("customer_address")%></th>
						<th onClick="sortBy(this)" db_col="customer_is_deal" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_is_deal")%>"><%=domainInstance.getPropertyCnName("customer_is_deal")%></th>
						<th onClick="sortBy(this)" db_col="customer_manager_account" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_manager_account")%>"><%=domainInstance.getPropertyCnName("customer_manager_account")%></th>
						<th onClick="sortBy(this)" db_col="service_engineer_account" class="<%=domainSearchCondition.getSortClassByDbColumn("service_engineer_account")%>"><%=domainInstance.getPropertyCnName("service_engineer_account")%></th>
						<th onClick="sortBy(this)" db_col="product_code" class="<%=domainSearchCondition.getSortClassByDbColumn("product_code")%>"><%=domainInstance.getPropertyCnName("product_code")%></th>
						<th onClick="sortBy(this)" db_col="product_version_code" class="<%=domainSearchCondition.getSortClassByDbColumn("product_version_code")%>"><%=domainInstance.getPropertyCnName("product_version_code")%></th>
						<th onClick="sortBy(this)" db_col="softdog" class="<%=domainSearchCondition.getSortClassByDbColumn("softdog")%>"><%=domainInstance.getPropertyCnName("softdog")%></th>
						<th onClick="sortBy(this)" db_col="service_charge_peryear" class="<%=domainSearchCondition.getSortClassByDbColumn("service_charge_peryear")%>"><%=domainInstance.getPropertyCnName("service_charge_peryear")%></th>
						<th onClick="sortBy(this)" db_col="service_due_date" class="<%=domainSearchCondition.getSortClassByDbColumn("service_due_date")%>"><%=domainInstance.getPropertyCnName("service_due_date")%></th>
						<th>
							详情
						</th>
					</tr>
				</thead>
				<%
					double service_charge_peryear_sum = 0;
					for (int i = 0; i < list.size(); i++)
					{
						CrmCustomerObj o = (CrmCustomerObj) list.get(i);
						service_charge_peryear_sum += o.getService_charge_peryear() == null ? 0 : o.getService_charge_peryear();
				%>
				<tr>
					<td><%=StringUtil.getNotEmptyStr(o.getCustomer_full_name())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("客户分类字典", o.getCustomer_type_code())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("区域字典", o.getCustomer_region_code())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getCustomer_address())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("是否字典", o.getCustomer_is_deal())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", o.getCustomer_manager_account())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", o.getService_engineer_account())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("产品字典", o.getProduct_code())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("产品版本字典", o.getProduct_version_code())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getSoftdog())%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getService_charge_peryear(), 2)%></td>
					<td><%=TimeUtil.date2str(o.getService_due_date(), "yyyy-MM-dd")%></td>
					<td style="text-align: center">
						<input type="button" class="button button_detail" title="详情" onClick="winOpen('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')">
					</td>
				</tr>
				<%
					} if (list.size()>0){
				%>
				<tr style="color:blue">
					<td>合计</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(service_charge_peryear_sum, 2)%></td>
					<td></td>
					<td></td>
				</tr>
				<%} %>
			</table>

			<!-- 翻页操作栏 -->
			<jsp:include page="../ToolBar/pagination_toolbar.jsp">
				<jsp:param name="basePath" value="<%=basePath%>" />
			</jsp:include>

		</form>

	</body>
</html>
