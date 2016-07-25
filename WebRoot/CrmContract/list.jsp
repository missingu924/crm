<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmContractObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.crm.searchcondition.CrmContractSearchCondition"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<!-- 基本信息 -->
<%
	// 当前上下文路径 
	String contextPath = request.getContextPath();

	// 该功能对象实例 
	CrmContractObj domainInstance = (CrmContractObj) request.getAttribute("domainInstance");
	// 该功能对象查询条件实例
	CrmContractSearchCondition domainSearchCondition = (CrmContractSearchCondition) request.getAttribute("domainSearchCondition");
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
						<%=domainInstance.getPropertyCnName("contract_name")%></td>
					<td align="left">
						<input name="contract_name" type="text" id="contract_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContract_name())%>" size="30">
					</td>
					<td align="right"><%=domainInstance.getPropertyCnName("customer_id")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""), user.hasRole(SystemConstant.ROLE_ADMIN) ? "" : "id in(select id from crm_customer where (customer_manager_account like \\'%," + user.getAccount()
							+ ",%\\' or service_engineer_account like \\'%," + user.getAccount() + ",%\\'))")%></td>
					<td align="right"><%=domainInstance.getPropertyCnName("is_finished")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("是否字典", "is_finished", StringUtil.getNotEmptyStr(domainInstance.getIs_finished(), ""))%></td>
					<td align="right">
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)">
					</td>
				</tr>
				<tr>
					<td align="right"><%=domainInstance.getPropertyCnName("contract_sign_time")%></td>
					<td align="left">
						<input name="contract_sign_time_start" type="text" id="contract_sign_time_start" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getContract_sign_time_start())%>" size="11" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
						-
						<input name="contract_sign_time_end" type="text" id="contract_sign_time_end" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getContract_sign_time_end())%>" size="11" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
					</td>
					<td align="right"><%=domainInstance.getPropertyCnName("contract_price")%></td>
					<td colspan="3" align="left">
						<input name="contract_price_min" type="text" id="contract_price_min" value="<%=StringUtil.formatDouble(domainSearchCondition.getContract_price_min(), 2)%>" size="11">
						-
						<input name="contract_price_max" type="text" id="contract_price_max" value="<%=StringUtil.formatDouble(domainSearchCondition.getContract_price_max(), 2)%>" size="11">
					</td>
					<td align="left">
						&nbsp;
					</td>
				</tr>
			</table>

			<table class="table table-bordered table-striped" align="center" width="98%">
				<thead>
					<tr>
						<input type="hidden" name="orderBy" id="orderBy" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getOrderBy(), "")%>">
						<th onClick="sortBy(this)" db_col="contract_name" class="<%=domainSearchCondition.getSortClassByDbColumn("contract_name")%>"><%=domainInstance.getPropertyCnName("contract_name")%></th>
						<th onClick="sortBy(this)" db_col="customer_id" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_id")%>"><%=domainInstance.getPropertyCnName("customer_id")%></th>
						<th onClick="sortBy(this)" db_col="contract_sign_time" class="<%=domainSearchCondition.getSortClassByDbColumn("contract_sign_time")%>"><%=domainInstance.getPropertyCnName("contract_sign_time")%></th>
						<th onClick="sortBy(this)" db_col="draw_bill" class="<%=domainSearchCondition.getSortClassByDbColumn("draw_bill")%>"><%=domainInstance.getPropertyCnName("draw_bill")%></th>
						<th onClick="sortBy(this)" db_col="contract_price" class="<%=domainSearchCondition.getSortClassByDbColumn("contract_price")%>"><%=domainInstance.getPropertyCnName("contract_price")%></th>
						<th onClick="sortBy(this)" db_col="bill_money_total" class="<%=domainSearchCondition.getSortClassByDbColumn("bill_money_total")%>"><%=domainInstance.getPropertyCnName("bill_money_total")%></th>
						<th onClick="sortBy(this)" db_col="gather_money_total" class="<%=domainSearchCondition.getSortClassByDbColumn("gather_money_total")%>"><%=domainInstance.getPropertyCnName("gather_money_total")%></th>
						<th onClick="sortBy(this)" db_col="spare_money" class="<%=domainSearchCondition.getSortClassByDbColumn("spare_money")%>"><%=domainInstance.getPropertyCnName("spare_money")%></th>
						<th onClick="sortBy(this)" db_col="is_finished" class="<%=domainSearchCondition.getSortClassByDbColumn("is_finished")%>"><%=domainInstance.getPropertyCnName("is_finished")%></th>
						<th onClick="sortBy(this)" db_col="record_account" class="<%=domainSearchCondition.getSortClassByDbColumn("record_account")%>"><%=domainInstance.getPropertyCnName("record_account")%></th>
						<th onClick="sortBy(this)" db_col="record_time" class="<%=domainSearchCondition.getSortClassByDbColumn("record_time")%>"><%=domainInstance.getPropertyCnName("record_time")%></th>
						<th>
							详情
						</th>
					</tr>
				</thead>
				<%
					double contract_price_sum=0,bill_money_sum = 0, gather_money_sum = 0, spare_money_sum = 0;
					for (int i = 0; i < list.size(); i++)
					{
						CrmContractObj o = (CrmContractObj) list.get(i);
						contract_price_sum+=o.getContract_price()==null?0:o.getContract_price();
						bill_money_sum += o.getBill_money_total()==null?0:o.getBill_money_total();
						gather_money_sum += o.getGather_money_total()==null?0:o.getGather_money_total();
						spare_money_sum += o.getSpare_money()==null?0:o.getSpare_money();
				%>
				<tr>
					<td><%=StringUtil.getNotEmptyStr(o.getContract_name())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("客户字典", o.getCustomer_id() + "")%></td>
					<td><%=TimeUtil.date2str(o.getContract_sign_time(), "yyyy-MM-dd")%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("是否字典", o.getDraw_bill())%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getContract_price(), 2)%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getBill_money_total(), 2)%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getGather_money_total(), 2)%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getSpare_money(), 2)%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("是否字典", o.getIs_finished())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", o.getRecord_account())%></td>
					<td><%=TimeUtil.date2str(o.getRecord_time())%></td>
					<td style="text-align: center">
						<input type="button" class="button button_detail" title="详情" onClick="winOpen('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')">
					</td>
				</tr>
				<%
					}if(list.size()>0){
				%>
				<tr style="color:blue">
					<td>合计</td>
					<td></td>
					<td></td>
					<td></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(contract_price_sum, 2)%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(bill_money_sum, 2)%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(gather_money_sum, 2)%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(spare_money_sum, 2)%></td>
					<td></td>
					<td></td>
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
