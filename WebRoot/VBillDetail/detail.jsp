<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.VBillDetailObj"%> 
<% 
	// 当前上下文路径  
	String contextPath = request.getContextPath();  
  
	// 该功能对象实例  
	VBillDetailObj domainInstance = (VBillDetailObj) request.getAttribute("domainInstance");  
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
					<%=domainInstance.getPropertyCnName("gather_date") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getGather_date())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("user_name") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getUser_name())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("customer_full_name") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_full_name())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("subject_name") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getSubject_name())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("management_name") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getManagement_name())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("draw_bill") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getDraw_bill())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("bill_money_total") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getBill_money_total())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("gather_money") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getGather_money())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("c") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getC())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("f") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getF())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("comment") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getComment())%></td> 
			</tr> 
		</table> 
		 
		<!-- 工具栏 --> 
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/> 
	</body> 
</html> 
