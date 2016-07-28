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
<%@page import="com.crm.searchcondition.CrmContactSearchCondition"%> 
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.LunarCalendar"%>
<%@page import="java.util.Date"%>
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	CrmContactObj domainInstance = (CrmContactObj) request.getAttribute("domainInstance"); 
	// 该功能对象查询条件实例
	CrmContactSearchCondition domainSearchCondition = (CrmContactSearchCondition) request.getAttribute("domainSearchCondition");
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
	// 用户信息
	AuthUserObj user= (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
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
					<td align="right"><%=domainInstance.getPropertyCnName("contact_name") %></td>
				    <td align="right"><input name="contact_name" type="text" id="contact_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_name())%>" size="40" ></td>
				    <td align="right"><%=domainInstance.getPropertyCnName("contact_birthday") %></td>
				    <td align="right"><%=DictionaryUtil.getSelectHtml("近几天字典", "contact_birthday", StringUtil.getNotEmptyStr(domainSearchCondition.getContact_birthday()+"", ""))%>&nbsp;&nbsp;<font color="#999999">今天是：阳历<%=TimeUtil.nowTime2str("yyyy年M月d日") %>，阴历<%=LunarCalendar.solarToLunar(new Date()) %></font></td>
				    <td align="right"><input name="searchButton2" type="button" class="button button_search" value="查询数据" onClick="toPage(1)">
                      <input name="searchButton" type="button" class="button button_set" value="高级查询" onClick="$('#search_condition_table').toggle();$('#showSearchConditionTable').val(!$('#search_condition_table').is(':hidden'));"></td>
				</tr>
			</table>
			<table id="search_condition_table" class="search_condition_table" align="center" width="98%" style="display:<%=domainSearchCondition.isShowSearchConditionTable()?"":"none" %>">
				<input type="hidden" id="showSearchConditionTable" name="showSearchConditionTable" value="<%=domainSearchCondition.isShowSearchConditionTable() %>">
				<tr> 
				  <td><%=domainInstance.getPropertyCnName("customer_id") %></td> 
					<td><%=DictionaryUtil.getInputHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id()+"", ""),user.hasFunction("无限制查询") ? "" : "id in(select id from crm_customer where (customer_manager_account like \\'%," + user.getAccount()
							+ ",%\\' or service_engineer_account like \\'%," + user.getAccount() + ",%\\'))")%></td>
					<td><%=domainInstance.getPropertyCnName("contact_telephone") %></td>
				    <td><input name="contact_telephone" type="text" id="contact_telephone" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_telephone())%>" size="40" ></td>
				</tr> 
				<tr> 
				  <td><%=domainInstance.getPropertyCnName("contact_qq") %></td>
				    <td><input name="contact_qq" type="text" id="contact_qq" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_qq())%>" size="40" ></td>
					<td><%=domainInstance.getPropertyCnName("contact_weixin") %></td>
				    <td><input name="contact_weixin" type="text" id="contact_weixin" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_weixin())%>" size="40" ></td>
				</tr> 
		  </table> 
 
			<table class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
						<input type="hidden" name="orderBy" id="orderBy" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getOrderBy(), "")%>">
						<th onClick="sortBy(this)" db_col="contact_name" class="<%=domainSearchCondition.getSortClassByDbColumn("contact_name")%>"><%=domainInstance.getPropertyCnName("contact_name") %></th> 
						<th onClick="sortBy(this)" db_col="customer_id" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_id")%>"><%=domainInstance.getPropertyCnName("customer_id") %></th> 
						<th onClick="sortBy(this)" db_col="contact_sex" class="<%=domainSearchCondition.getSortClassByDbColumn("contact_sex")%>"><%=domainInstance.getPropertyCnName("contact_sex") %></th> 
						<th onClick="sortBy(this)" db_col="contact_birthday_type+cast(contact_birthday_month as varchar(100))+cast(contact_birthday_day as varchar(100))" class="<%=domainSearchCondition.getSortClassByDbColumn("contact_birthday_type+cast(contact_birthday_month as varchar(100))+cast(contact_birthday_day as varchar(100))")%>"><%=domainInstance.getPropertyCnName("contact_birthday") %></th> 
						<th onClick="sortBy(this)" db_col="contact_telephone" class="<%=domainSearchCondition.getSortClassByDbColumn("contact_telephone")%>"><%=domainInstance.getPropertyCnName("contact_telephone") %></th> 
						<th onClick="sortBy(this)" db_col="contact_email" class="<%=domainSearchCondition.getSortClassByDbColumn("contact_email")%>"><%=domainInstance.getPropertyCnName("contact_email") %></th> 
						<th onClick="sortBy(this)" db_col="contact_qq" class="<%=domainSearchCondition.getSortClassByDbColumn("contact_qq")%>"><%=domainInstance.getPropertyCnName("contact_qq") %></th> 
						<th onClick="sortBy(this)" db_col="contact_weixin" class="<%=domainSearchCondition.getSortClassByDbColumn("contact_weixin")%>"><%=domainInstance.getPropertyCnName("contact_weixin") %></th> 
						<th onClick="sortBy(this)" db_col="contact_hobby" class="<%=domainSearchCondition.getSortClassByDbColumn("contact_hobby")%>"><%=domainInstance.getPropertyCnName("contact_hobby") %></th> 
						<th onClick="sortBy(this)" db_col="record_account" class="<%=domainSearchCondition.getSortClassByDbColumn("record_account")%>"><%=domainInstance.getPropertyCnName("record_account") %></th> 
						<th onClick="sortBy(this)" db_col="record_time" class="<%=domainSearchCondition.getSortClassByDbColumn("record_time")%>"><%=domainInstance.getPropertyCnName("record_time")%></th>
						<th>
							详情
						</th>
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < list.size(); i++) 
						{ 
							CrmContactObj o = (CrmContactObj) list.get(i); 
				%> 
				<tr> 
					
					<td><%=StringUtil.getNotEmptyStr(o.getContact_name())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("客户字典",o.getCustomer_id()+"")%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("性别字典",o.getContact_sex())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getContact_birthday(),"")%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContact_telephone())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContact_email())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContact_qq())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContact_weixin())%></td> 
					<td title="<%=StringUtil.getNotEmptyStr(o.getContact_hobby())%>"><%=StringUtil.getNotEmptyStr(o.getContact_hobby(),10)%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getRecord_account())%></td> 
					<td><%=TimeUtil.date2str(o.getRecord_time())%></td> 
					<td style="text-align: center">
						<input type="button" class="button button_detail" title="详情" onClick="winOpen('<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')">
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
