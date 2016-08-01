<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmBillObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<!-- 基本信息 -->
<%
	// 上下文路径 
	String contextPath = request.getContextPath();

	// 对象实例 
	CrmBillObj domainInstance = new CrmBillObj();
	// 该功能基本路径 
	String basePath = domainInstance.getBasePath();

	// 如果是修改，则获取对象信息 
	Object domainInstanceObj = request.getAttribute("domainInstance");
	if (domainInstanceObj != null)
	{
		domainInstance = (CrmBillObj) domainInstanceObj;
	}

	// 是否是修改 
	boolean isModify = domainInstance.getKeyValue() > 0;
	// 唯一性检查用的字段 
	String keyCol = "null";

	// 用户信息
	AuthUserObj user = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
	
	// 是否需要开发票
	boolean needDrawBill = "是".equals(domainInstance.findContract().getDraw_bill());
%>
<html>
	<head>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />
		<title><%=isModify ? "修改" + domainInstance.getCnName() : "增加" + domainInstance.getCnName()%></title>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
		<link href="../css/table.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
		<script> 
		//  新增或修改 
		function addOrModify() 
		{	 

				// 做必要的检查 
		if(!checkNull("customer_id","<%=domainInstance.getPropertyCnName("customer_id")%>")) return false; 
		if(!checkNull("commerical_opportunity_id","<%=domainInstance.getPropertyCnName("commerical_opportunity_id")%>")) return false; 
		if(!checkNull("contract_id","<%=domainInstance.getPropertyCnName("contract_id")%>")) return false; 
		<%if(needDrawBill){%>
			if ($("#bill_money").val() == "" && $("#gather_money").val() == "") {
				alert("<%=domainInstance.getPropertyCnName("bill_money")%> 和 <%=domainInstance.getPropertyCnName("gather_money")%> 必须填写一项");
				return false;
			}
			if ($("#bill_money").val() != "") {
				if(!checkNull("bill_date","<%=domainInstance.getPropertyCnName("bill_date")%>")) return false; 
			}
			if ($("#gather_money").val() != "") {
				if(!checkNull("gather_date","<%=domainInstance.getPropertyCnName("gather_date")%>")) return false; 
			}
		<%} else {%>
			if(!checkNull("gather_money","<%=domainInstance.getPropertyCnName("gather_money")%>")) return false; 
			if(!checkNull("gather_date","<%=domainInstance.getPropertyCnName("gather_date")%>")) return false; 
		<%}%>
					 
			// 修改 
			if("true"=="<%=isModify%>") 
			{ 
				submit(); 
			} 
			// 新增 
			else 
			{ 
					// 新增时检查唯一性 
					$.post( 
					encodeURI("Servlet?method=checkId4this&isFromUrl=true&id=0&<%=keyCol%>="+$("#<%=keyCol%>").val()),  
					{Action:"post"},  
					function (data, textStatus){ 
						this; 
						if(data=="true")  
						{ 
							alert("该<%=domainInstance.getPropertyCnName(keyCol)%>已录入系统");  
							return false; 
						} 
						else 
						{ 
							submit(); 
						} 
					}); 
				}; 
		} 
		 
		// 提交保存或修改 
		function submit() 
		{ 
					$("#addOrModifyForm").submit(); 
		} 
		</script>
	</head>
	<body>
		<form name="addOrModifyForm" id="addOrModifyForm" action="<%=contextPath%>/<%=basePath%>/Servlet?method=addOrModify4this" method="post">
			<!-- 表格标题 -->
			<table width="720" align="center" class="title_table">
				<tr>
					<td>
						<%=isModify ? "修改" : "增加"%><%=domainInstance.getCnName()%>
					</td>
				</tr>
			</table>

			<!-- 详细信息 -->
			<table width="720" align="center" class="detail_table detail_table-bordered ">
				<input type="hidden" id="<%=domainInstance.findKeyColumnName()%>" name="<%=domainInstance.findKeyColumnName()%>" value="<%=domainInstance.getKeyValue()%>">
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("customer_id")%>:
					</td>
					<td colspan="3">
						<%=DictionaryUtil.getInputHtmlReadOnly("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""), 81)%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("commerical_opportunity_id")%>:
					</td>
					<td colspan="3">
						<%=DictionaryUtil.getInputHtmlReadOnly("商机字典", "commerical_opportunity_id", StringUtil.getNotEmptyStr(domainInstance.getCommerical_opportunity_id(), ""), 81)%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("contract_id")%>:
					</td>
					<td colspan="3">
						<%=DictionaryUtil.getInputHtmlReadOnly("合同字典", "contract_id", StringUtil.getNotEmptyStr(domainInstance.getContract_id(), ""), 81)%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("contract_user_account")%>:
					</td>
					<td colspan="3">
						<%=DictionaryUtil.getInputHtmlReadOnly("账号字典", "contract_user_account", StringUtil.getNotEmptyStr(domainInstance.getContract_user_account(), ""), 81)%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("gather_money")%>:
					</td>
					<td>
						<input name="gather_money" type="text" id="gather_money" value="<%=StringUtil.formatDouble(domainInstance.getGather_money(), 2)%>" size="20">
					</td>
					<td><%=domainInstance.getPropertyCnName("gather_date")%>:
					</td>
					<td>
						<input name="gather_date" type="text" id="gather_date" value="<%=StringUtil.getNotEmptyStr(TimeUtil.date2str(domainInstance.getGather_date(), "yyyy-MM-dd"), "")%>" size="20"
							onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
					</td>
				</tr>
				<%if(needDrawBill){ %>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("bill_money")%>:
					</td>
					<td>
						<input name="bill_money" type="text" id="bill_money" value="<%=StringUtil.formatDouble(domainInstance.getBill_money(), 2)%>" size="20">
					</td>
					<td><%=domainInstance.getPropertyCnName("bill_date")%>:
					</td>
					<td>
						<input name="bill_date" type="text" id="bill_date" value="<%=StringUtil.getNotEmptyStr(TimeUtil.date2str(domainInstance.getBill_date(), "yyyy-MM-dd"), "")%>" size="20"
							onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("bill_number")%>:
					</td>
					<td>
						<input name="bill_number" type="text" id="bill_number" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_number(), "")%>" size="20">
					</td>
					<td><%=domainInstance.getPropertyCnName("bill_receipt")%>:
					</td>
					<td>
						<%=DictionaryUtil.getSelectHtml("是否字典", "bill_receipt", StringUtil.getNotEmptyStr(domainInstance.getBill_receipt(), "否"))%>
					</td>
				</tr>
				<%} %>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("comment")%>:
					</td>
					<td colspan="3">
						<input name="comment" type="text" id="comment" value="<%=StringUtil.getNotEmptyStr(domainInstance.getComment())%>" size="81">
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("record_account")%>:
					</td>
					<td>
						<input type="text" readOnly value="<%=DictionaryUtil.getDictValueByDictKey("账号字典", StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), user.getAccount()))%>" size="20" style="background: #eeeeee;">
						<input name="record_account" type="hidden" id="record_account" value="<%=StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), user.getAccount())%>" size="20">
					</td>
					<td>
						<%=domainInstance.getPropertyCnName("record_time")%>:
					</td>
					<td>
						<input name="record_time" type="text" readOnly id="record_time" value="<%=StringUtil.getNotEmptyStr(TimeUtil.date2str(domainInstance.getRecord_time()), TimeUtil.nowTime2str())%>" size="20" style="background: #eeeeee;">
					</td>
				</tr>
			</table>

			<!-- 工具栏 -->
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" />
		</form>
	</body>
</html>
