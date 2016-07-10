<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmManagementActivityObj"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	CrmManagementActivityObj domainInstance = (CrmManagementActivityObj) request.getAttribute("domainInstance"); 
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
						<%=DictionaryUtil.getSelectHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id()+"", ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("activity_type") %> 
						<%=DictionaryUtil.getSelectHtml("经营活动类型字典", "activity_type", StringUtil.getNotEmptyStr(domainInstance.getActivity_type(), ""))%> 
						&nbsp;  
						<%=domainInstance.getPropertyCnName("commercial_oppotunity_id") %> 
						<%=DictionaryUtil.getSelectHtml("商机字典", "commercial_oppotunity_id", StringUtil.getNotEmptyStr(domainInstance.getCommercial_oppotunity_id(), ""))%> 
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
						<th><%=domainInstance.getPropertyCnName("activity_type") %></th> 
						<th><%=domainInstance.getPropertyCnName("commercial_oppotunity_id") %></th> 
						<th><%=domainInstance.getPropertyCnName("record_account") %></th> 
						<th><%=domainInstance.getPropertyCnName("participant") %></th> 
						<th><%=domainInstance.getPropertyCnName("activity_date") %></th> 
						<th><%=domainInstance.getPropertyCnName("activity_content") %></th> 
						<th><%=domainInstance.getPropertyCnName("next_step") %></th> 
						<th>操作</th> 
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							CrmManagementActivityObj o = (CrmManagementActivityObj) list.get(i); 
				%> 
				<tr> 
					<td> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getKeyValue())%> </a> 
					</td> 
					<td><%=StringUtil.getNotEmptyStr(o.getCustomer_id())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("经营活动类型字典",o.getActivity_type())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("商机字典",o.getCommercial_oppotunity_id()+"")%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getRecord_account())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getParticipant())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getActivity_date())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getActivity_content())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getNext_step())%></td> 
					<td width="80" style="text-align:center"> 
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
 
		</form>  
 
	</body> 
</html> 
