<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmManagementActivityObj"%> 
<!-- 基本信息 -->  
<% 
	// 上下文路径 
	String contextPath = request.getContextPath(); 
	 
	// 对象实例 
	CrmManagementActivityObj domainInstance = new CrmManagementActivityObj(); 
	// 该功能基本路径 
	String basePath = domainInstance.getBasePath(); 
 
	// 如果是修改，则获取对象信息 
	Object domainInstanceObj = request.getAttribute("domainInstance"); 
	if (domainInstanceObj != null) 
	{ 
		domainInstance = (CrmManagementActivityObj) domainInstanceObj; 
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
		if(!checkNull("activity_type","<%=domainInstance.getPropertyCnName("activity_type")%>")) return false; 
		if(!checkNull("commercial_oppotunity_id","<%=domainInstance.getPropertyCnName("commercial_oppotunity_id")%>")) return false; 
		if(!checkNull("record_account","<%=domainInstance.getPropertyCnName("record_account")%>")) return false; 
		if(!checkNull("participant","<%=domainInstance.getPropertyCnName("participant")%>")) return false; 
		if(!checkNull("activity_date","<%=domainInstance.getPropertyCnName("activity_date")%>")) return false; 
		if(!checkNull("activity_content","<%=domainInstance.getPropertyCnName("activity_content")%>")) return false; 
					 
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
			<table width="700" align="center" class="detail_table detail_table-bordered detail_table-striped"> 
				<input type="hidden" id="<%=domainInstance.findKeyColumnName()%>" name="<%=domainInstance.findKeyColumnName()%>" value="<%=domainInstance.getKeyValue()%>"> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("customer_id") %>: 
					</td> 
					<td> 
						<%=DictionaryUtil.getSelectHtml("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id()+"", ""))%>  
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("activity_type") %>: 
					</td> 
					<td> 
						<%=DictionaryUtil.getSelectHtml("经营活动类型字典", "activity_type", StringUtil.getNotEmptyStr(domainInstance.getActivity_type(), ""))%> 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("commercial_oppotunity_id") %>: 
					</td> 
					<td> 
						<%=DictionaryUtil.getSelectHtml("商机字典", "commercial_oppotunity_id", StringUtil.getNotEmptyStr(domainInstance.getCommercial_oppotunity_id(), ""))%> 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("record_account") %>: 
					</td> 
					<td> 
						<input name="record_account" type="text" id="record_account" value="<%=StringUtil.getNotEmptyStr(domainInstance.getRecord_account(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("participant") %>: 
					</td> 
					<td> 
						<input name="participant" type="text" id="participant" value="<%=StringUtil.getNotEmptyStr(domainInstance.getParticipant(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("activity_date") %>: 
					</td> 
					<td> 
						<input name="activity_date" type="text" id="activity_date" value="<%=StringUtil.getNotEmptyStr(domainInstance.getActivity_date(),"")%>" size="20" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})" > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("activity_content") %>: 
					</td> 
					<td> 
						<input name="activity_content" type="text" id="activity_content" value="<%=StringUtil.getNotEmptyStr(domainInstance.getActivity_content(),"")%>" size="20"  > 
						<font color="red">*</font> 
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
			</table> 
			 
			<!-- 工具栏 --> 
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" /> 
		</form> 
	</body> 
</html> 
