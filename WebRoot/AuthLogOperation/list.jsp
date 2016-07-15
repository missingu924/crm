<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.wuyg.auth.obj.AuthLogOperationObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.wuyg.auth.searchcondition.AuthLogOperationSearchCondition"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	AuthLogOperationObj domainInstance = (AuthLogOperationObj) request.getAttribute("domainInstance"); 
	// 该功能对象查询条件实例
	AuthLogOperationSearchCondition domainSearchCondition = (AuthLogOperationSearchCondition) request.getAttribute("domainSearchCondition"); 
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
						<%=domainInstance.getPropertyCnName("useraccount") %> 
						<%=DictionaryUtil.getInputHtml("账号字典", "useraccount", StringUtil.getNotEmptyStr(domainInstance.getUseraccount(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("userdepartmentcode") %> 
						<%=DictionaryUtil.getInputHtml("部门字典", "userdepartmentcode", StringUtil.getNotEmptyStr(domainInstance.getUserdepartmentcode(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("module_name") %> 
						<input name="module_name" type="text" id="module_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getModule_name())%>" size="20" > 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("module_method") %> 
						<%=DictionaryUtil.getInputHtml("操作名字典", "module_method", StringUtil.getNotEmptyStr(domainInstance.getModule_method(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("timestamp") %> 
						<input name="timestamp" type="text" id="timestamp" value="<%=StringUtil.getNotEmptyStr(domainInstance.getTimestamp())%>" size="20" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})"> 
						&nbsp;  
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)"> 
					</td>
				</tr> 
			</table> 
 
			<table class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
						<input type="hidden" name="orderBy" id="orderBy" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getOrderBy(),"") %>">
						<th onClick="sortBy(this)" db_col="id" class="<%=domainSearchCondition.getSortClassByDbColumn("id") %>"><%=domainInstance.getPropertyCnName("id") %></th> 
						<th onClick="sortBy(this)" db_col="useraccount" class="<%=domainSearchCondition.getSortClassByDbColumn("useraccount") %>"><%=domainInstance.getPropertyCnName("useraccount") %></th> 
						<th onClick="sortBy(this)" db_col="username" class="<%=domainSearchCondition.getSortClassByDbColumn("username") %>"><%=domainInstance.getPropertyCnName("username") %></th> 
						<th onClick="sortBy(this)" db_col="userdepartmentcode" class="<%=domainSearchCondition.getSortClassByDbColumn("userdepartmentcode") %>"><%=domainInstance.getPropertyCnName("userdepartmentcode") %></th> 
						<th onClick="sortBy(this)" db_col="module_name" class="<%=domainSearchCondition.getSortClassByDbColumn("module_name") %>"><%=domainInstance.getPropertyCnName("module_name") %></th> 
						<th onClick="sortBy(this)" db_col="module_method" class="<%=domainSearchCondition.getSortClassByDbColumn("module_method") %>"><%=domainInstance.getPropertyCnName("module_method") %></th> 
						<th onClick="sortBy(this)" db_col="timestamp" class="<%=domainSearchCondition.getSortClassByDbColumn("timestamp") %>"><%=domainInstance.getPropertyCnName("timestamp") %></th> 
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							AuthLogOperationObj o = (AuthLogOperationObj) list.get(i); 
				%> 
				<tr> 
					<td> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getKeyValue())%> </a> 
					</td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getUseraccount())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getUsername())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("部门字典",o.getUserdepartmentcode())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getModule_name())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("操作名字典",o.getModule_method())%></td>
					<td><%=TimeUtil.date2str(o.getTimestamp())%></td> 
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
