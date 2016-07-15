<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmCustomerChangelogObj"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	CrmCustomerChangelogObj domainInstance = (CrmCustomerChangelogObj) request.getAttribute("domainInstance"); 
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
						<%=domainInstance.getPropertyCnName("customer_id") %> 
						<%=DictionaryUtil.getSelectHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("record_account") %> 
						<%=DictionaryUtil.getSelectHtml("账号字典", "record_account", StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), ""))%> 
						&nbsp;  
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)"> 
					</td> 
					<td align="right"> 
						<input name="addButton" type="button" class="button button_add" value="增加" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this')"> 
						<%if(list.size()>0){ %> 
						<input name="deleteAllButton" type="button" class="button button_delete" value="全删" onClick="if(confirm('您确认要删除本次查询出的 <%=list.size() %> 条数据吗?')){$('#pageForm').attr('action','<%=contextPath%>/<%=basePath%>/Servlet?method=deleteAll4this').submit();}"> 
						<%} %> 
					</td> 
				</tr> 
			</table> 
 
			<table class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
						<th><%=domainInstance.getPropertyCnName("id") %></th> 
						<th><%=domainInstance.getPropertyCnName("customer_id") %></th> 
						<th><%=domainInstance.getPropertyCnName("change_log") %></th> 
						<th><%=domainInstance.getPropertyCnName("record_account") %></th> 
						<th><%=domainInstance.getPropertyCnName("record_time") %></th> 
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							CrmCustomerChangelogObj o = (CrmCustomerChangelogObj) list.get(i); 
				%> 
				<tr> 
					<td> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getKeyValue())%> </a> 
					</td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("客户字典",o.getCustomer_id())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getChange_log())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getRecord_account())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getRecord_time())%></td> 
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
