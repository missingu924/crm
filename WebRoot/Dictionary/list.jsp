<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%> 
<%@page import="com.wuyg.dictionary.service.DictionaryService"%> 
<%@page import="com.wuyg.dictionary.obj.DictionaryObj"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	DictionaryObj domainInstance = (DictionaryObj) request.getAttribute("domainInstance"); 
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
					<td align="left"> 
						<%=domainInstance.getPropertyCnName("dicttype") %> 
						<%=DictionaryUtil.getSelectHtml(new DictionaryService().getDictItemsByDictName("字典类型字典", false), "dicttype", "", StringUtil.getNotEmptyStr(domainInstance.getDicttype(), ""), "notEmpty")%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("dictname") %> 
						<input name="dictname" type="text" id="dictname" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDictname())%>" size="20" > 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("dictdbname") %> 
						<input name="dictdbname" type="text" id="dictdbname" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDictdbname())%>" size="20" > 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("dicttable") %> 
						<input name="dicttable" type="text" id="dicttable" value="<%=StringUtil.getNotEmptyStr(domainInstance.getDicttable())%>" size="20" > 
						&nbsp;  
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)"> 
					</td> 
					<td align="right"> 
						<input name="addButton" type="button" class="button button_add" value="增加" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this')"> 
						<input name="uploadButton" type="button" class="button button_upload" value="导入" onClick="openBigModalDialog('<%=contextPath%>/ExcelParser/uploadFile.jsp?basedbobj_class=<%=domainInstance.getClass().getCanonicalName()%>')">
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
						<th><%=domainInstance.getPropertyCnName("dicttype") %></th> 
						<th><%=domainInstance.getPropertyCnName("dictname") %></th> 
						<th><%=domainInstance.getPropertyCnName("dictdbname") %></th> 
						<th><%=domainInstance.getPropertyCnName("dicttable") %></th> 
						<th><%=domainInstance.getPropertyCnName("dictkeycol") %></th> 
						<th><%=domainInstance.getPropertyCnName("dictvaluecol") %></th> 
						<th><%=domainInstance.getPropertyCnName("dictorderbycol") %></th> 
						<th><%=domainInstance.getPropertyCnName("dictfilter") %></th> 
						<th><%=domainInstance.getPropertyCnName("dictvalues") %></th> 
						<th>操作</th> 
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							DictionaryObj o = (DictionaryObj) list.get(i); 
				%> 
				<tr> 
					<td> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getKeyValue())%> </a> 
					</td> 
					<td><%=new DictionaryService().getDictValueByDictKey("字典类型字典",o.getDicttype())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getDictname())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getDictdbname())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getDicttable())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getDictkeycol())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getDictvaluecol())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getDictorderbycol())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getDictfilter())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getDictvalues())%></td> 
					<td align="left" style="cursor: pointer"> 
						<input type="button" class="button button_modify" title="修改" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')" /> 
						&nbsp; 
						<input type="button" class="button button_delete" title="删除" 
							onClick="javascript: 
								$('#pageForm').attr('action','<%=contextPath%>/<%=basePath%>/Servlet?method=delete4this&<%=o.findKeyColumnName()%>_4del=<%=o.getKeyValue()%>'); 
								$('#pageForm').submit(); 
								" /> 
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
 
			<% 
				} 
			%> 
		</form>  
 
	</body> 
</html> 
