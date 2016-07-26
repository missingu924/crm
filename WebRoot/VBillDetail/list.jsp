<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.VBillDetailObj"%>
<%@page import="com.crm.searchcondition.VBillDetailSearchCondition"%>
<%@page import="java.util.Map"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	VBillDetailObj domainInstance = (VBillDetailObj) request.getAttribute("domainInstance"); 
	// 该功能对象查询条件实例
	VBillDetailSearchCondition domainSearchCondition = (VBillDetailSearchCondition) request.getAttribute("domainSearchCondition");
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
						<%=domainInstance.getPropertyCnName("gather_date") %> 
						<input name="gather_date_start" type="text" id="gather_date_start" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getGather_date_start())%>" size="11" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyyMMdd'})">
						-
						<input name="gather_date_end" type="text" id="gather_date_end" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getGather_date_end())%>" size="11" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyyMMdd'})">
						&nbsp;  
						<input name="searchButton" type="button" class="button button_search" value="查询" onClick="toPage(1)"> 
					</td> 
				</tr> 
			</table> 
 
			<table id="main_table" class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
						<input type="hidden" name="orderBy" id="orderBy" value="<%=StringUtil.getNotEmptyStr(domainSearchCondition.getOrderBy(), "")%>">
						<th onClick="sortBy(this)" db_col="gather_date" class="<%=domainSearchCondition.getSortClassByDbColumn("gather_date")%>"><%=domainInstance.getPropertyCnName("gather_date") %></th> 
						<th onClick="sortBy(this)" db_col="contract_name" class="<%=domainSearchCondition.getSortClassByDbColumn("contract_name")%>"><%=domainInstance.getPropertyCnName("contract_name") %></th> 
						<th onClick="sortBy(this)" db_col="user_name" class="<%=domainSearchCondition.getSortClassByDbColumn("user_name")%>"><%=domainInstance.getPropertyCnName("user_name") %></th> 
						<th onClick="sortBy(this)" db_col="customer_full_name" class="<%=domainSearchCondition.getSortClassByDbColumn("customer_full_name")%>"><%=domainInstance.getPropertyCnName("customer_full_name") %></th> 
						<th onClick="sortBy(this)" db_col="subject_name" class="<%=domainSearchCondition.getSortClassByDbColumn("subject_name")%>"><%=domainInstance.getPropertyCnName("subject_name") %></th> 
						<th onClick="sortBy(this)" db_col="management_name" class="<%=domainSearchCondition.getSortClassByDbColumn("management_name")%>"><%=domainInstance.getPropertyCnName("management_name") %></th> 
						<th onClick="sortBy(this)" db_col="draw_bill" class="<%=domainSearchCondition.getSortClassByDbColumn("draw_bill")%>"><%=domainInstance.getPropertyCnName("draw_bill") %></th> 
						<th onClick="sortBy(this)" db_col="bill_money_total" class="<%=domainSearchCondition.getSortClassByDbColumn("bill_money_total")%>"><%=domainInstance.getPropertyCnName("bill_money_total") %></th> 
						<th onClick="sortBy(this)" db_col="gather_money" class="<%=domainSearchCondition.getSortClassByDbColumn("gather_money")%>"><%=domainInstance.getPropertyCnName("gather_money") %></th> 
						<th onClick="sortBy(this)" db_col="c" class="<%=domainSearchCondition.getSortClassByDbColumn("c")%>"><%=domainInstance.getPropertyCnName("c") %></th> 
						<th onClick="sortBy(this)" db_col="f" class="<%=domainSearchCondition.getSortClassByDbColumn("f")%>"><%=domainInstance.getPropertyCnName("f") %></th> 
						<th onClick="sortBy(this)" db_col="comment" class="<%=domainSearchCondition.getSortClassByDbColumn("comment")%>"><%=domainInstance.getPropertyCnName("comment") %></th> 
					</tr> 
				</thead> 
				<% 
					double bill_money_sum=0,gather_money_sum=0;
					List<String> contract_id_list = new ArrayList<String>();
					for (int i = 0; i < list.size(); i++) 
						{ 
							VBillDetailObj o = (VBillDetailObj) list.get(i); 
							
							// 按合同统计开票合计
							if(!contract_id_list.contains(o.getContract_id()))
							{
								bill_money_sum+=StringUtil.parseDouble(o.getBill_money_total());
								contract_id_list.add(o.getContract_id());
							}
							
							gather_money_sum+=StringUtil.parseDouble(o.getGather_money());
				%> 
				<tr> 
					<td><%=StringUtil.getNotEmptyStr(o.getGather_date())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContract_name())%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getUser_name())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getCustomer_full_name())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getSubject_name())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getManagement_name())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getDraw_bill())%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getBill_money_total(),2)%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getGather_money(),2)%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getC(),2)%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getF(),2)%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getComment())%></td> 
				</tr> 
				<% 
					} if(list.size()>0){
				%> 
				 
				<tr style="color:blue"> 
					<td>合计</td> 
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(bill_money_sum,2)%></td> 
					<td style="text-align: right"><%=StringUtil.formatDouble(gather_money_sum,2)%></td> 
					<td></td>	
					<td></td>	
					<td></td>
				</tr> 
				<%} %>
			</table> 
 
			<!-- 翻页操作栏 --> 
			<jsp:include page="../ToolBar/pagination_toolbar.jsp"> 
				<jsp:param name="basePath" value="<%=basePath%>"/> 
			</jsp:include> 
 
		</form>  
 
	</body> 
</html> 
