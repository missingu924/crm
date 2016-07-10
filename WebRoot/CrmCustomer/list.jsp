<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmCustomerObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	CrmCustomerObj domainInstance = (CrmCustomerObj) request.getAttribute("domainInstance"); 
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
						<%=domainInstance.getPropertyCnName("customer_full_name") %> 
						<input name="customer_full_name" type="text" id="customer_full_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_full_name())%>" size="20" > 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("customer_type_code") %> 
						<%=DictionaryUtil.getSelectHtml("客户分类字典", "customer_type_code", StringUtil.getNotEmptyStr(domainInstance.getCustomer_type_code(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("customer_region_code") %> 
						<%=DictionaryUtil.getSelectHtml("区域字典", "customer_region_code", StringUtil.getNotEmptyStr(domainInstance.getCustomer_region_code(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("customer_is_deal") %> 
						<%=DictionaryUtil.getSelectHtml("是否字典", "customer_is_deal", StringUtil.getNotEmptyStr(domainInstance.getCustomer_is_deal(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("customer_manager_account") %> 
						<%=DictionaryUtil.getSelectHtml("账号字典", "customer_manager_account", StringUtil.getNotEmptyStr(domainInstance.getCustomer_manager_account(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("service_engineer_account") %> 
						<%=DictionaryUtil.getSelectHtml("账号字典", "service_engineer_account", StringUtil.getNotEmptyStr(domainInstance.getService_engineer_account(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("product_code") %> 
						<%=DictionaryUtil.getSelectHtml("产品字典", "product_code", StringUtil.getNotEmptyStr(domainInstance.getProduct_code(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("product_version_code") %> 
						<%=DictionaryUtil.getSelectHtml("产品版本字典", "product_version_code", StringUtil.getNotEmptyStr(domainInstance.getProduct_version_code(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("service_due_date") %> 
						<input name="service_due_date" type="text" id="service_due_date" value="<%=StringUtil.getNotEmptyStr(domainInstance.getService_due_date())%>" size="20" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})"> 
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
						<th><%=domainInstance.getPropertyCnName("customer_full_name") %></th> 
						<th><%=domainInstance.getPropertyCnName("customer_type_code") %></th> 
						<th><%=domainInstance.getPropertyCnName("customer_region_code") %></th> 
						<th><%=domainInstance.getPropertyCnName("customer_address") %></th> 
						<th><%=domainInstance.getPropertyCnName("customer_is_deal") %></th> 
						<th><%=domainInstance.getPropertyCnName("customer_manager_account") %></th> 
						<th><%=domainInstance.getPropertyCnName("service_engineer_account") %></th> 
						<th><%=domainInstance.getPropertyCnName("product_code") %></th> 
						<th><%=domainInstance.getPropertyCnName("product_version_code") %></th> 
						<th><%=domainInstance.getPropertyCnName("softdog") %></th> 
						<th><%=domainInstance.getPropertyCnName("service_charge_peryear") %></th> 
						<th><%=domainInstance.getPropertyCnName("service_due_date") %></th> 
						<th>操作</th> 
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							CrmCustomerObj o = (CrmCustomerObj) list.get(i); 
				%> 
				<tr> 
					<td> 
						<a href="#" onClick="winOpen('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getKeyValue())%> </a>					</td> 
					<td><%=StringUtil.getNotEmptyStr(o.getCustomer_full_name())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("客户分类字典",o.getCustomer_type_code())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("区域字典",o.getCustomer_region_code())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getCustomer_address())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("是否字典",o.getCustomer_is_deal())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getCustomer_manager_account())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getService_engineer_account())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("产品字典",o.getProduct_code())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("产品版本字典",o.getProduct_version_code())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getSoftdog())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getService_charge_peryear())%></td> 
					<td><%=TimeUtil.date2str(o.getService_due_date(),"yyyy-MM-dd")%></td> 
					<td width="80" style="text-align:center"> 
						<input type="button" class="button button_modify" title="修改" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')" /> 
						&nbsp; 
						<input type="button" class="button button_delete" title="删除" 
							onClick="javascript: 
								$('#pageForm').attr('action','<%=contextPath%>/<%=basePath%>/Servlet?method=delete4this&<%=o.findKeyColumnName()%>_4del=<%=o.getKeyValue()%>'); 
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
 
		</form>  
 
	</body> 
</html> 
