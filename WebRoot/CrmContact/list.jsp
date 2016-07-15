<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmContactObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	CrmContactObj domainInstance = (CrmContactObj) request.getAttribute("domainInstance"); 
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
						<%=DictionaryUtil.getInputHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id()+"", ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("contact_name") %> 
						<input name="contact_name" type="text" id="contact_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_name())%>" size="20" > 
						&nbsp;  
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)"> 
					</td> 
					<td align="right"> 
						<input name="addButton" type="button" class="button button_add" value="增加" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this')"> 
						
					</td> 
				</tr> 
			</table> 
 
			<table class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
						<th><%=domainInstance.getPropertyCnName("contact_name") %></th> 
						<th><%=domainInstance.getPropertyCnName("customer_id") %></th> 
						<th><%=domainInstance.getPropertyCnName("contact_sex") %></th> 
						<th><%=domainInstance.getPropertyCnName("contact_birthday") %></th> 
						<th><%=domainInstance.getPropertyCnName("contact_telephone") %></th> 
						<th><%=domainInstance.getPropertyCnName("contact_email") %></th> 
						<th><%=domainInstance.getPropertyCnName("record_account") %></th> 
						<th><%=domainInstance.getPropertyCnName("record_time") %></th> 
						<th>操作</th> 
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							CrmContactObj o = (CrmContactObj) list.get(i); 
				%> 
				<tr> 
					
					<td> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getContact_name())%> </a> 
					</td>
					<td>
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCustomer/Servlet?method=detail4this&id=<%=o.getCustomer_id()%>')"> <%=DictionaryUtil.getDictValueByDictKey("客户字典",o.getCustomer_id()+"")%> </a>
					</td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("性别字典",o.getContact_sex())%></td>  
					<td><%=TimeUtil.date2str(o.getContact_birthday(),"yyyy-MM-dd")%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContact_telephone())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContact_email())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getRecord_account())%></td> 
					<td><%=TimeUtil.date2str(o.getRecord_time())%></td> 
					<td width="80" style="text-align:center"> 
						<input type="button" class="button button_modify" title="修改" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')" /> 
						&nbsp; 
						<input type="button" class="button button_delete" title="删除" 
							onClick="confirmDelete('<%=contextPath%>/<%=basePath%>/Servlet?method=delete4this&<%=o.findKeyColumnName()%>_4del=<%=o.getKeyValue()%>')" /> 
					</td> 
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