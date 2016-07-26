<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmCommercialOpportunityObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<!-- 基本信息 -->
<%
	// 上下文路径 
	String contextPath = request.getContextPath();

	// 对象实例 
	CrmCommercialOpportunityObj domainInstance = new CrmCommercialOpportunityObj();
	// 该功能基本路径 
	String basePath = domainInstance.getBasePath();

	// 如果是修改，则获取对象信息 
	Object domainInstanceObj = request.getAttribute("domainInstance");
	if (domainInstanceObj != null)
	{
		domainInstance = (CrmCommercialOpportunityObj) domainInstanceObj;
	}

	// 是否是修改 
	boolean isModify = domainInstance.getKeyValue() > 0;
	// 唯一性检查用的字段 
	String keyCol = "null";

	// 用户信息
	AuthUserObj user = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
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
		if(!checkNull("opportunity_name","<%=domainInstance.getPropertyCnName("opportunity_name")%>")) return false; 
		if(!checkNull("management_type_code","<%=domainInstance.getPropertyCnName("management_type_code")%>")) return false; 
		if(!checkNull("sale_stage_code","<%=domainInstance.getPropertyCnName("sale_stage_code")%>")) return false; 
		if(!checkNull("target_price","<%=domainInstance.getPropertyCnName("target_price")%>")) return false; 
		if(!checkNull("estimate_sign_time","<%=domainInstance.getPropertyCnName("estimate_sign_time")%>")) return false; 
		if(!checkNull("management_account","<%=domainInstance.getPropertyCnName("management_account")%>")) return false; 
					 
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
			<table width="800" align="center" class="title_table">
				<tr>
					<td>
						<%=isModify ? "修改" : "增加"%><%=domainInstance.getCnName()%>
					</td>
				</tr>
			</table>

			<!-- 详细信息 -->
			<table width="800" align="center" class="detail_table detail_table-bordered">
				<input type="hidden" id="<%=domainInstance.findKeyColumnName()%>" name="<%=domainInstance.findKeyColumnName()%>" value="<%=domainInstance.getKeyValue()%>">
				<tr>
					<td><%=domainInstance.getPropertyCnName("opportunity_name")%>:
					</td>
					<td colspan="5">
						<input name="opportunity_name" type="text" id="opportunity_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getOpportunity_name(), "")%>" size="50">
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("customer_id")%>:
					</td>
					<td colspan="5"><%=DictionaryUtil.getInputHtmlReadOnly("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""), 50)%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("management_account")%>:
					</td>
					<td><%=DictionaryUtil.getInputHtmlReadOnly("账号字典", "management_account", StringUtil.getNotEmptyStr(domainInstance.getManagement_account(), user.getAccount()),20)%>
						<font color="red">*</font>
					</td>
					<td><%=domainInstance.getPropertyCnName("management_type_code")%>:
					</td>
					<td><%=DictionaryUtil.getSelectHtml("经营类型字典", "management_type_code", StringUtil.getNotEmptyStr(domainInstance.getManagement_type_code(), ""))%>
						<font color="red">*</font>
					</td>
					<td><%=domainInstance.getPropertyCnName("sale_stage_code")%>:
					</td>
					<td><%=DictionaryUtil.getSelectHtml("销售阶段字典", "sale_stage_code", StringUtil.getNotEmptyStr(domainInstance.getSale_stage_code(), ""))%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("target_price")%>:
					</td>
					<td>
						<input name="target_price" type="text" id="target_price" value="<%=StringUtil.formatDouble(domainInstance.getTarget_price(), 2)%>" size="20">
						<font color="red">*</font>
					</td>
					<td><%=domainInstance.getPropertyCnName("estimate_sign_time")%>:
					</td>
					<td colspan="3">
						<input name="estimate_sign_time" type="text" id="estimate_sign_time" value="<%=TimeUtil.date2str(domainInstance.getEstimate_sign_time(), "yyyy-MM-dd")%>" size="20" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("source")%>:
					</td>
					<td colspan="5">
						<input type="text" name="source" id="source" size="70" value="<%=StringUtil.getNotEmptyStr(domainInstance.getSource(), "")%>">
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("customer_request")%>:
					</td>
					<td colspan="5">
						<textarea name="customer_request" cols="52" rows="3" id="customer_request"><%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_request(), "")%></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("next_step")%>:
					</td>
					<td colspan="5">
						<textarea name="next_step" cols="52" rows="3" id="next_step"><%=StringUtil.getNotEmptyStr(domainInstance.getNext_step(), "")%></textarea>
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
					<td colspan="3">
						<input name="record_time" type="text" readOnly id="record_time" value="<%=StringUtil.getNotEmptyStr(TimeUtil.date2str(domainInstance.getRecord_time()), TimeUtil.nowTime2str())%>" size="20" style="background: #eeeeee;">
					</td>
				</tr>
			</table>

			<!-- 工具栏 -->
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" />
		</form>
	</body>
</html>
