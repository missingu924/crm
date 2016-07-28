<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.wuyg.auth.obj.AuthUserObj"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	AuthUserObj domainInstance = (AuthUserObj) request.getAttribute("domainInstance"); 
	// 该功能路径 
	String basePath = domainInstance.getBasePath(); 
%> 
<html> 
	<head> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />		<title><%=domainInstance.getCnName() %>列表</title> 
		<link href="../css/global.css" rel="stylesheet" type="text/css"> 
		<link href="../css/table.css" rel="stylesheet" type="text/css"> 
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script> 
		<script type="text/javascript" src="../js/utils.js"></script> 
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script> 
	</head> 
	<body> 
		<form name="pageForm" id="pageForm" method="post" action="<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=list4this"> 
			 
			<!-- 查询条件 --> 
			<table class="search_table" align="center" width="98%"> 
				<tr> 
				<td style="width:0"></td>
					<td align="left"> 
						<%=domainInstance.getPropertyCnName("account") %> 
						<input name="account" type="text" id="account" value="<%=StringUtil.getNotEmptyStr(domainInstance.getAccount())%>" size="20" > 
						&nbsp;
						<%=domainInstance.getPropertyCnName("name") %> 
						<input name="name" type="text" id="name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getName())%>" size="20" > 
						&nbsp; 
						<%=domainInstance.getPropertyCnName("departmentcode") %> 
						<%=DictionaryUtil.getInputHtml("部门字典", "departmentcode", StringUtil.getNotEmptyStr(domainInstance.getDepartmentcode(), ""))%> 
						&nbsp;   
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)"> 
					</td> 
					<td align="right"> 
						<input name="addButton" type="button" class="button button_add" value="增加" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this')"> 
					</td> 
				</tr> 
			</table> 
 
			<!-- 查询结果 --> 
			<% 
				PaginationObj pagination = null; 
				List list = new ArrayList(); 
 
				Object paginationObj = request.getAttribute("domainPagination"); 
				if (paginationObj != null) 
				{ 
					pagination = (PaginationObj) paginationObj; 
					list = (List) pagination.getDataList(); 
				} 
				if (paginationObj == null) 
				{ 
					out.print("没有符合条件的数据，请重新设置条件再查询。"); 
				} else 
				{ 
			%> 
			<table class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
						<th><%=domainInstance.getPropertyCnName("id") %></th> 
						<th><%=domainInstance.getPropertyCnName("account") %></th> 
						<th><%=domainInstance.getPropertyCnName("name") %></th> 
						<th><%=domainInstance.getPropertyCnName("sex") %></th> 
						<th><%=domainInstance.getPropertyCnName("telephone") %></th> 
						<th><%=domainInstance.getPropertyCnName("departmentcode") %></th> 
						<th><%=domainInstance.getPropertyCnName("officecode") %></th> 
						<th><%=domainInstance.getPropertyCnName("enable") %></th> 
						<th>操作</th> 
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							AuthUserObj o = (AuthUserObj) list.get(i); 
				%> 
				<tr> 
					<td> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getKeyValue())%> </a>					</td> 
					<td><%=StringUtil.getNotEmptyStr(o.getAccount())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getName())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("性别字典",o.getSex())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getTelephone())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("部门字典",o.getDepartmentcode())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("职务字典",o.getOfficecode())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("是否字典",o.getEnable())%></td> 
					<td width="80" style="text-align:center"> 
						<input type="button" class="button button_modify" title="修改" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')" /> 
						&nbsp; 
						<input type="button" class="button button_delete" title="删除" 
							onClick="javascript: 
								$('#pageForm').attr('action','<%=contextPath%>/<%=basePath%>/Servlet?method=delete4this&account_4del=<%=o.getAccount() %>&<%=o.findKeyColumnName()%>_4del=<%=o.getKeyValue()%>'); 
								$('#pageForm').submit(); 
								" />					</td> 
				</tr> 
				<% 
					} 
				%> 
			</table> 
 
			<!-- 翻页操作栏 --> 
			<jsp:include page="../ToolBar/pagination_toolbar.jsp"> 
				<jsp:param name="basePath" value="<%=basePath%>"/> 
			</jsp:include> 
 
			<% 
				} 
			%> 
		</form>  
 
	</body> 
</html> 
