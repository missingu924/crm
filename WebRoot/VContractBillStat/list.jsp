<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.VContractBillStatObj"%>
<%@page import="com.crm.searchcondition.VContractBillStatSearchCondition"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	VContractBillStatObj domainInstance = (VContractBillStatObj) request.getAttribute("domainInstance"); 
	// 该功能对象查询条件实例
	VContractBillStatSearchCondition domainSearchCondition = (VContractBillStatSearchCondition) request.getAttribute("domainSearchCondition");
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
	
	// 用户信息
	AuthUserObj user = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
	boolean cf=user.hasFunction("合同-CF字段管理");
%> 
<html> 
	<head> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" /> 
		<title><%=domainInstance.getCnName() %>列表</title> 
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
					<td align="right">
					<input name="searchButton" type="button" class="button button_set" value="查询设置" onClick="$('#search_condition_table').toggle();$('#showSearchConditionTable').val(!$('#search_condition_table').is(':hidden'));">
					</td>
				</tr>
			</table>
			<table id="search_condition_table" class="search_condition_table" align="center" width="98%" style="display:<%=domainSearchCondition.isShowSearchConditionTable()?"":"none" %>">
				<input type="hidden" id="showSearchConditionTable" name="showSearchConditionTable" value="<%=domainSearchCondition.isShowSearchConditionTable() %>">
				<tr>
					<td align="right">
						<%=domainInstance.getPropertyCnName("management_type_code")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("经营类型字典", "management_type_code", StringUtil.getNotEmptyStr(domainInstance.getManagement_type_code(), ""))%></td>
					<td align="left">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right"><%=domainInstance.getPropertyCnName("record_account")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("账号字典", "record_account", StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), ""))%></td>
					<td align="left">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right"><%=domainInstance.getPropertyCnName("id")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("合同字典-选择用", "id", StringUtil.getNotEmptyStr(domainInstance.getId(), ""), user.hasFunction("无限制查询") ? "" : "customer_id in(select id from crm_customer where (customer_manager_account like \\'%," + user.getAccount()
							+ ",%\\' or service_engineer_account like \\'%," + user.getAccount() + ",%\\'))")%></td>
					<td align="left">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right"><%=domainInstance.getPropertyCnName("customer_id")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""), user.hasFunction("无限制查询") ? "" : "id in(select id from crm_customer where (customer_manager_account like \\'%," + user.getAccount()
							+ ",%\\' or service_engineer_account like \\'%," + user.getAccount() + ",%\\'))")%></td>
					<td align="left">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right"><%=domainInstance.getPropertyCnName("contract_subject")%></td>
					<td align="left"><%=DictionaryUtil.getInputHtml("合同主体字典", "contract_subject", StringUtil.getNotEmptyStr(domainInstance.getContract_subject(), ""))%></td>
					<td align="left">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="right"><%=domainInstance.getPropertyCnName("contract_sign_time")%></td>
					<td align="left">
						<input name="contract_sign_time_start" type="text" id="contract_sign_time_start" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getContract_sign_time_start())%>" size="11" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyyMMdd'})">
						-
						<input name="contract_sign_time_end" type="text" id="contract_sign_time_end" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getContract_sign_time_end())%>" size="11" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyyMMdd'})">
					</td>
					<td align="left">
				<td align="right"><input name="searchButton2" type="button" class="button button_search" value="查询" onClick="toPage(1)"></td>
			  </tr> 
		  </table> 
 
			<table id="main_table" class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
						<input type="hidden" name="orderBy" id="orderBy" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getOrderBy(), "")%>">
						<th onClick="sortBy(this)" db_col="management_name" class="<%=domainSearchCondition.getSortClassByDbColumn("management_name")%>"><%=domainInstance.getPropertyCnName("management_name") %></th> 
						<th onClick="sortBy(this)" db_col="contract_sign_time" class="<%=domainSearchCondition.getSortClassByDbColumn("contract_sign_time")%>"><%=domainInstance.getPropertyCnName("contract_sign_time") %></th> 
						<th onClick="sortBy(this)" db_col="user_name" class="<%=domainSearchCondition.getSortClassByDbColumn("user_name")%>"><%=domainInstance.getPropertyCnName("user_name") %></th> 
						<th onClick="sortBy(this)" db_col="contract_name" class="<%=domainSearchCondition.getSortClassByDbColumn("contract_name")%>"><%=domainInstance.getPropertyCnName("contract_name") %></th> 
						<th onClick="sortBy(this)" db_col="customer_full_name" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_full_name")%>"><%=domainInstance.getPropertyCnName("customer_full_name") %></th> 
						<th onClick="sortBy(this)" db_col="subject_name" class="<%=domainSearchCondition.getSortClassByDbColumn("subject_name")%>"><%=domainInstance.getPropertyCnName("subject_name")%></th>
						<th onClick="sortBy(this)" db_col="contract_price" class="<%=domainSearchCondition.getSortClassByDbColumn("contract_price")%>"><%=domainInstance.getPropertyCnName("contract_price") %></th> 
						<th onClick="sortBy(this)" db_col="bill_number" class="<%=domainSearchCondition.getSortClassByDbColumn("bill_number")%>"><%=domainInstance.getPropertyCnName("bill_number") %></th> 
						<th onClick="sortBy(this)" db_col="bill_date" class="<%=domainSearchCondition.getSortClassByDbColumn("bill_date")%>"><%=domainInstance.getPropertyCnName("bill_date") %></th> 
						<th onClick="sortBy(this)" db_col="bill_money" class="<%=domainSearchCondition.getSortClassByDbColumn("bill_money")%>"><%=domainInstance.getPropertyCnName("bill_money") %></th> 
						<th onClick="sortBy(this)" db_col="gather_date" class="<%=domainSearchCondition.getSortClassByDbColumn("gather_date")%>"><%=domainInstance.getPropertyCnName("gather_date") %></th> 
						<th onClick="sortBy(this)" db_col="gather_money" class="<%=domainSearchCondition.getSortClassByDbColumn("gather_money")%>"><%=domainInstance.getPropertyCnName("gather_money") %></th> 
						<th onClick="sortBy(this)" db_col="bill_receivable" class="<%=domainSearchCondition.getSortClassByDbColumn("bill_receivable")%>"><%=domainInstance.getPropertyCnName("bill_receivable") %></th> 
						<th onClick="sortBy(this)" db_col="contract__receivable" class="<%=domainSearchCondition.getSortClassByDbColumn("contract__receivable")%>"><%=domainInstance.getPropertyCnName("contract__receivable") %></th> 
						<%if(cf){ %>
						<th onClick="sortBy(this)" db_col="c" class="<%=domainSearchCondition.getSortClassByDbColumn("c")%>"><%=domainInstance.getPropertyCnName("c") %></th> 
						<th onClick="sortBy(this)" db_col="f" class="<%=domainSearchCondition.getSortClassByDbColumn("f")%>"><%=domainInstance.getPropertyCnName("f") %></th> 
						<%} %>
						<th>详情</th>
					</tr> 
				</thead> 
				<% 
					double contract_price_sum=0,bill_money_sum=0,gather_money_sum=0,bill_receivable_sum=0,contract__receivable_sum=0;
					for (int i = 0; i < list.size(); i++) 
						{ 
							VContractBillStatObj o = (VContractBillStatObj) list.get(i); 
							contract_price_sum+=StringUtil.parseDouble(o.getContract_price());
							bill_money_sum+=StringUtil.parseDouble(o.getBill_money());
							gather_money_sum+=StringUtil.parseDouble(o.getGather_money());
							bill_receivable_sum+=StringUtil.parseDouble(o.getBill_receivable());
							contract__receivable_sum+=StringUtil.parseDouble(o.getContract__receivable());
				%> 
				<tr> 
					<td><%=StringUtil.getNotEmptyStr(o.getManagement_name())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContract_sign_time())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getUser_name())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContract_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getCustomer_full_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getSubject_name())%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getContract_price(),2)%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getBill_number()).replaceAll(",",",<br>")%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getBill_date()).replaceAll(",",",<br>")%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getBill_money(),2)%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getGather_date()).replaceAll(",",",<br>")%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getGather_money(),2)%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getBill_receivable(),2)%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getContract__receivable(),2)%></td> 
					<%if(cf){ %>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getC(),2)%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getF(),2)%></td> 
					<%} %>
					<td style="text-align: center">
						<input type="button" class="button button_detail" title="详情" onClick="winOpen('<%=contextPath%>/CrmContract/Servlet?method=detail4this&id=<%=o.getId()%>')">
					</td>
				</tr> 
				<% 
					} if(list.size()>0){
				%> 
				 
				<tr style="color:blue"> 
					<td>合计</td> 
					<td></td> 
					<td></td> 
					<td></td> 
					<td></td> 
					<td></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(contract_price_sum,2)%></td> 
					<td></td> 
					<td></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(bill_money_sum,2)%></td> 
					<td></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(gather_money_sum,2)%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(bill_receivable_sum,2)%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(contract__receivable_sum,2)%></td> 
					<td></td> 
					<%if(cf){ %>
					<td></td> 
					<td></td> 
					<%} %>
				</tr> 
				<%} %>
			</table> 
 
			<!-- 翻页操作栏 --> 
			<jsp:include page="../ToolBar/pagination_toolbar.jsp"> 
				<jsp:param name="basePath" value="<%=basePath%>"/> 
			</jsp:include> 
 
		</form>  
 
	</body> 
</html> 
