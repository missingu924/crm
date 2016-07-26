<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmBillObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<%
	// 当前上下文路径  
	String contextPath = request.getContextPath();

	// 该功能对象实例  
	CrmBillObj domainInstance = (CrmBillObj) request.getAttribute("domainInstance");
	// 该功能路径  
	String basePath = domainInstance.getBasePath();
	// 用户信息
	AuthUserObj user = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
%>
<html>
	<head>
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />
		<title><%=domainInstance.getCnName()%>详情</title>
		<link href="../css/global.css" rel="stylesheet" type="text/css" />
		<link href="../css/table.css" rel="stylesheet" type="text/css" />
		<script src="../js/jquery-2.0.3.min.js"></script>
		<script src="../js/utils.js"></script>
	</head>
	<body>
		<!-- 操作栏 -->
		<table width="800" align="center" class="top_tools_table">
			<tr>
				<td>
					<%if(user.hasFunction("开票收款-修改")){ %><a href='<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>'> <input name="modifyOpportunityButton" type="button" class="button button_modify" value="修改" /> </a><%} %>
					<%if(user.hasFunction("开票收款-删除")){ %><input name="deleteButton" type="button" class="button button_delete" value="删除" onClick="deleteIt('<%=contextPath%>/<%=basePath%>/Servlet?method=delete4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>')"><%} %>
				</td>
			</tr>
		</table>
		<!-- 表格标题 -->
		<table width="800" align="center" class="title_table">
			<tr>
				<td>
					<%=domainInstance.getCnName()%>信息
				</td>
			</tr>
		</table>
		<!-- 详细信息 -->
		<table width="800" align="center" class="detail_table detail_table-bordered ">
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("customer_id")%>:
				</td>
				<td colspan="3">
					<a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCustomer/Servlet?method=detail4this&id=<%=domainInstance.getCustomer_id()%>')"><%=DictionaryUtil.getDictValueByDictKey("客户字典", domainInstance.getCustomer_id() + "")%></a>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("commerical_opportunity_id")%>:
				</td>
				<td colspan="3">
					<a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCommercialOpportunity/Servlet?method=detail4this&id=<%=domainInstance.getCommerical_opportunity_id()%>')"><%=DictionaryUtil.getDictValueByDictKey("商机字典", domainInstance.getCommerical_opportunity_id() + "")%></a>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("contract_id")%>:
				</td>
				<td colspan="3">
					<a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmContract/Servlet?method=detail4this&id=<%=domainInstance.getContract_id()%>')"><%=DictionaryUtil.getDictValueByDictKey("合同字典", domainInstance.getContract_id() + "")%></a>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("bill_money")%>:
				</td>
				<td><%=StringUtil.formatDouble(domainInstance.getBill_money(), 2)%></td>
				<td><%=domainInstance.getPropertyCnName("bill_date")%>:
				</td>
				<td><%=TimeUtil.date2str(domainInstance.getBill_date(), "yyyy-MM-dd")%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("gather_money")%>:
				</td>
				<td><%=StringUtil.formatDouble(domainInstance.getGather_money(), 2)%></td>
				<td><%=domainInstance.getPropertyCnName("gather_date")%>:
				</td>
				<td><%=TimeUtil.date2str(domainInstance.getGather_date(), "yyyy-MM-dd")%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("bill_number")%>:
				</td>
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getBill_number())%></td>
				<td><%=domainInstance.getPropertyCnName("bill_receipt")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("是否字典", domainInstance.getBill_receipt())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("comment")%>:
				</td>
				<td colspan="3"><%=StringUtil.getNotEmptyStr(domainInstance.getComment())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("record_account")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", domainInstance.getRecord_account())%></td>
				<td><%=domainInstance.getPropertyCnName("record_time")%>:
				</td>
				<td><%=TimeUtil.date2str(domainInstance.getRecord_time())%></td>
			</tr>
		</table>

		<!-- 工具栏 -->
		<jsp:include page="../ToolBar/detail_toolbar.jsp" />
	</body>
</html>
