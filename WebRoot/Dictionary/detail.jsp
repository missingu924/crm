<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.service.DictionaryService"%> 
<%@page import="com.wuyg.dictionary.obj.DictionaryObj"%> 
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
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />		<title><%=domainInstance.getCnName()%>详情</title> 
		<link href="../css/global.css" rel="stylesheet" type="text/css" /> 
		<link href="../css/table.css" rel="stylesheet" type="text/css" /> 
		<script src="../js/jquery-2.0.3.min.js"></script> 
		<script src="../js/utils.js"></script> 
	</head> 
	<body> 
		<!-- 表格标题 --> 
		<table width="600" align="center" class="title_table"> 
			<tr> 
				<td> 
					<img src="../images/svg/heavy/green/list.png" width="18" height="18" align="absmiddle"> 
					&nbsp;&nbsp;<%=domainInstance.getCnName()%>信息 
				</td> 
			</tr> 
		</table> 
		<!-- 详细信息 --> 
		<table width="600" align="center" class="detail_table detail_table-bordered detail_table-striped"> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("id") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getId())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("dicttype") %>: 
				</td> 
				<td><%=new DictionaryService().getDictValueByDictKey("字典类型字典",domainInstance.getDicttype())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("dictname") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getDictname())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("dictdbname") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getDictdbname())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("dicttable") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getDicttable())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("dictkeycol") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getDictkeycol())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("dictvaluecol") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getDictvaluecol())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("dictorderbycol") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getDictorderbycol())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("dictfilter") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getDictfilter())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("dictvalues") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getDictvalues())%></td> 
			</tr> 
		</table> 
		 
		<!-- 工具栏 --> 
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/> 
	</body> 
</html> 
