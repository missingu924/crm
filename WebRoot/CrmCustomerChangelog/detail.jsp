<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmCustomerChangelogObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%> 
<% 
	// 当前上下文路径  
	String contextPath = request.getContextPath();  
  
	// 该功能对象实例  
	CrmCustomerChangelogObj domainInstance = (CrmCustomerChangelogObj) request.getAttribute("domainInstance");  
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
		<table width="700" align="center" class="title_table"> 
			<tr> 
				<td> 
					<img src="../images/svg/heavy/green/list.png" width="18" height="18" align="absmiddle"> 
					&nbsp;&nbsp;<%=domainInstance.getCnName()%>信息 
				</td> 
			</tr> 
		</table> 
		<!-- 详细信息 --> 
		<table width="700" align="center" class="detail_table detail_table-bordered detail_table-striped"> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("customer_id") %>: 
				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("客户字典",domainInstance.getCustomer_id())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("change_log") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getChange_log().replaceAll("\n","<br>"))%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("record_account") %>: 
				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",domainInstance.getRecord_account())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("record_time") %>: 
				</td> 
				<td><%=TimeUtil.date2str(domainInstance.getRecord_time())%></td> 
			</tr> 
		</table> 
		 
		<!-- 工具栏 --> 
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/> 
	</body> 
</html> 
