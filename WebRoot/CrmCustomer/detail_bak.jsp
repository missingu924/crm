<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmCustomerObj"%> 
<% 
	// 当前上下文路径  
	String contextPath = request.getContextPath();  
  
	// 该功能对象实例  
	CrmCustomerObj domainInstance = (CrmCustomerObj) request.getAttribute("domainInstance");  
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
					<%=domainInstance.getPropertyCnName("id") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getId())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("customer_full_name") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_full_name())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("customer_type_code") %>: 
				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("客户分类字典",domainInstance.getCustomer_type_code())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("customer_region_code") %>: 
				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("区域字典",domainInstance.getCustomer_region_code())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("customer_address") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_address())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("customer_is_deal") %>: 
				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("是否字典",domainInstance.getCustomer_is_deal())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("customer_manager_account") %>: 
				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",domainInstance.getCustomer_manager_account())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("service_engineer_account") %>: 
				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",domainInstance.getService_engineer_account())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("product_code") %>: 
				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("产品字典",domainInstance.getProduct_code())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("product_version_code") %>: 
				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("产品版本字典",domainInstance.getProduct_version_code())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("byproduct") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getByproduct())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("module") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getModule())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("softdog") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getSoftdog())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("service_charge_peryear") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getService_charge_peryear())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("service_due_date") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getService_due_date())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("bill_title") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getBill_title())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("bill_info") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getBill_info())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("comment") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getComment())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("record_account") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getRecord_account())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("record_time") %>: 
				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getRecord_time())%></td> 
			</tr> 
		</table> 
		 
		<!-- 工具栏 --> 
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/> 
	</body> 
</html> 
