<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmManagementActivityObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.crm.searchcondition.CrmManagementActivitySearchCondition"%> 
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	CrmManagementActivityObj domainInstance = (CrmManagementActivityObj) request.getAttribute("domainInstance"); 
	// 该功能对象查询条件实例
	CrmManagementActivitySearchCondition domainSearchCondition = (CrmManagementActivitySearchCondition) request.getAttribute("domainSearchCondition"); 
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
					<td align="left"> 
						<%=domainInstance.getPropertyCnName("customer_id") %> 
						<%=DictionaryUtil.getInputHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""),user.hasRole(SystemConstant.ROLE_ADMIN) ? "" : "id in(select id from crm_customer where (customer_manager_account like \\'%," + user.getAccount()
								+ ",%\\' or service_engineer_account like \\'%," + user.getAccount() + ",%\\'))")%>
						&nbsp; 
						<%=domainInstance.getPropertyCnName("commercial_oppotunity_id") %> 
						<%=DictionaryUtil.getInputHtml("商机字典", "commercial_oppotunity_id", StringUtil.getNotEmptyStr(domainInstance.getCommercial_oppotunity_id(), ""),"客户字典","customer_id",user.hasRole(SystemConstant.ROLE_ADMIN) ? "" : "customer_id in(select id from crm_customer where (customer_manager_account like \\'%," + user.getAccount()
								+ ",%\\' or service_engineer_account like \\'%," + user.getAccount() + ",%\\'))",10)%> 
						&nbsp; 
						<%=domainInstance.getPropertyCnName("activity_type") %> 
						<%=DictionaryUtil.getInputHtml("经营活动类型字典", "activity_type", StringUtil.getNotEmptyStr(domainInstance.getActivity_type(), ""))%> 
						&nbsp;  
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)"> 
					</td> 
				</tr> 
			</table> 
 
			<table id="main_table" class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
						<input type="hidden" name="orderBy" id="orderBy" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getOrderBy(),"") %>">
						<th onClick="sortBy(this)" db_col="customer_id" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_id") %>"><%=domainInstance.getPropertyCnName("customer_id") %></th> 
						<th onClick="sortBy(this)" db_col="activity_type" class="<%=domainSearchCondition.getSortClassByDbColumn("activity_type") %>"><%=domainInstance.getPropertyCnName("activity_type") %></th> 
						<th onClick="sortBy(this)" db_col="commercial_oppotunity_id" class="<%=domainSearchCondition.getSortClassByDbColumn("commercial_oppotunity_id") %>"><%=domainInstance.getPropertyCnName("commercial_oppotunity_id") %></th> 
						<th onClick="sortBy(this)" db_col="activity_date" class="<%=domainSearchCondition.getSortClassByDbColumn("activity_date") %>"><%=domainInstance.getPropertyCnName("activity_date") %></th> 
						<th onClick="sortBy(this)" db_col="participant" class="<%=domainSearchCondition.getSortClassByDbColumn("participant") %>"><%=domainInstance.getPropertyCnName("participant") %></th> 
						<th onClick="sortBy(this)" db_col="sale_stage_code" class="<%=domainSearchCondition.getSortClassByDbColumn("sale_stage_code") %>"><%=domainInstance.getPropertyCnName("sale_stage_code") %></th> 
						<th onClick="sortBy(this)" db_col="activity_content" class="<%=domainSearchCondition.getSortClassByDbColumn("activity_content") %>"><%=domainInstance.getPropertyCnName("activity_content") %></th> 
						<th onClick="sortBy(this)" db_col="next_step" class="<%=domainSearchCondition.getSortClassByDbColumn("next_step") %>"><%=domainInstance.getPropertyCnName("next_step") %></th> 
						<th onClick="sortBy(this)" db_col="record_account" class="<%=domainSearchCondition.getSortClassByDbColumn("record_account") %>"><%=domainInstance.getPropertyCnName("record_account") %></th> 
						<th onClick="sortBy(this)" db_col="record_time" class="<%=domainSearchCondition.getSortClassByDbColumn("record_time") %>"><%=domainInstance.getPropertyCnName("record_time") %></th> 
						<th>详情</th>
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							CrmManagementActivityObj o = (CrmManagementActivityObj) list.get(i); 
				%> 
				<tr> 
					<td>
						<%=DictionaryUtil.getDictValueByDictKey("客户字典",o.getCustomer_id()+"")%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("经营活动类型字典",o.getActivity_type())%></td>  
					<td><%if(o.isOpportunityActivity()){ %>
						<%=DictionaryUtil.getDictValueByDictKey("商机字典",o.getCommercial_oppotunity_id()+"")%>
						<%} %></td>  
					<td><%=TimeUtil.date2str(o.getActivity_date(),"yyyy-MM-dd")%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",StringUtil.getNotEmptyStr(o.getParticipant()))%></td> 
					<td><%=o.isOpportunityActivity()?DictionaryUtil.getDictValueByDictKey("销售阶段字典",o.getSale_stage_code()+""):""%></td>  
					<td title="<%=StringUtil.getNotEmptyStr(o.getActivity_content())%>"><%=StringUtil.getNotEmptyStr(o.getActivity_content(),10)%></td> 
					<td title="<%=StringUtil.getNotEmptyStr(o.getNext_step())%>"><%=StringUtil.getNotEmptyStr(o.getNext_step(),10)%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getRecord_account())%></td> 
					<td><%=TimeUtil.date2str(o.getRecord_time())%></td> 
					<td style="text-align:center"><input type="button"  class="button button_detail" title="详情" onClick="winOpen('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"></td>
				</tr> 
				<% 
					} 
				%> 
			</table> 
 
			<!-- 翻页操作栏 --> 
			<jsp:include page="../ToolBar/pagination_toolbar.jsp"> 
				<jsp:param name="basePath" value="<%=basePath%>"/> 
			</jsp:include> 
 
		</form>  
 
	</body> 
</html> 
