<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmCommercialOpportunityObj"%> 
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
%> 
<html> 
	<head> 
		<base target="_self" /> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />		<title><%=isModify ? "修改" + domainInstance.getCnName() : "增加" + domainInstance.getCnName()%></title> 
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
			<table width="700" align="center" class="title_table"> 
				<tr> 
					<td> 
						<img src="../images/svg/heavy/green/list.png" width="18" height="18" align="absmiddle"> 
						&nbsp;&nbsp;<%=isModify ? "修改" : "增加"%><%=domainInstance.getCnName()%> 
					</td> 
				</tr>
			</table> 
 
			<!-- 详细信息 --> 
			<table width="700" align="center" class="detail_table detail_table-bordered"> 
				<input type="hidden" id="<%=domainInstance.findKeyColumnName()%>" name="<%=domainInstance.findKeyColumnName()%>" value="<%=domainInstance.getKeyValue()%>"> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("customer_id") %>: 
					</td> 
					<td> 
						<%=DictionaryUtil.getSelectHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""))%> 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("opportunity_name") %>: 
					</td> 
					<td> 
						<input name="opportunity_name" type="text" id="opportunity_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getOpportunity_name(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("management_type_code") %>: 
					</td> 
					<td> 
						<%=DictionaryUtil.getSelectHtml("经营类型字典", "management_type_code", StringUtil.getNotEmptyStr(domainInstance.getManagement_type_code(), ""))%> 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("sale_stage_code") %>: 
					</td> 
					<td> 
						<%=DictionaryUtil.getSelectHtml("销售阶段字典", "sale_stage_code", StringUtil.getNotEmptyStr(domainInstance.getSale_stage_code(), ""))%> 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("target_price") %>: 
					</td> 
					<td> 
						<input name="target_price" type="text" id="target_price" value="<%=StringUtil.getNotEmptyStr(domainInstance.getTarget_price(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("estimate_sign_time") %>: 
					</td> 
					<td> 
						<input name="estimate_sign_time" type="text" id="estimate_sign_time" value="<%=StringUtil.getNotEmptyStr(domainInstance.getEstimate_sign_time(),"")%>" size="20" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})" > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("management_account") %>: 
					</td> 
					<td> 
						<%=DictionaryUtil.getSelectHtml("账号字典", "management_account", StringUtil.getNotEmptyStr(domainInstance.getManagement_account(), ""))%> 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("customer_request") %>: 
					</td> 
					<td> 
						<input name="customer_request" type="text" id="customer_request" value="<%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_request(),"")%>" size="20"  > 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("next_step") %>: 
					</td> 
					<td> 
						<input name="next_step" type="text" id="next_step" value="<%=StringUtil.getNotEmptyStr(domainInstance.getNext_step(),"")%>" size="20"  > 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("record_account") %>: 
					</td> 
					<td> 
						<input name="record_account" type="text" id="record_account" value="<%=StringUtil.getNotEmptyStr(domainInstance.getRecord_account(),"")%>" size="20"  > 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("record_time") %>: 
					</td> 
					<td> 
						<input name="record_time" type="text" id="record_time" value="<%=StringUtil.getNotEmptyStr(domainInstance.getRecord_time(),"")%>" size="20" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})" > 
					</td> 
				</tr> 
			</table> 
			 
			<!-- 工具栏 --> 
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" /> 
		</form> 
	</body> 
</html> 
