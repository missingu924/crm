<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.VContractBillStatObj"%> 
<!-- 基本信息 -->  
<% 
	// 上下文路径 
	String contextPath = request.getContextPath(); 
	 
	// 对象实例 
	VContractBillStatObj domainInstance = new VContractBillStatObj(); 
	// 该功能基本路径 
	String basePath = domainInstance.getBasePath(); 
 
	// 如果是修改，则获取对象信息 
	Object domainInstanceObj = request.getAttribute("domainInstance"); 
	if (domainInstanceObj != null) 
	{ 
		domainInstance = (VContractBillStatObj) domainInstanceObj; 
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
		if(!checkNull("id","<%=domainInstance.getPropertyCnName("id")%>")) return false; 
		if(!checkNull("management_name","<%=domainInstance.getPropertyCnName("management_name")%>")) return false; 
		if(!checkNull("contract_sign_time","<%=domainInstance.getPropertyCnName("contract_sign_time")%>")) return false; 
		if(!checkNull("bill_number","<%=domainInstance.getPropertyCnName("bill_number")%>")) return false; 
		if(!checkNull("bill_date","<%=domainInstance.getPropertyCnName("bill_date")%>")) return false; 
		if(!checkNull("user_name","<%=domainInstance.getPropertyCnName("user_name")%>")) return false; 
		if(!checkNull("customer_full_name","<%=domainInstance.getPropertyCnName("customer_full_name")%>")) return false; 
		if(!checkNull("contract_price","<%=domainInstance.getPropertyCnName("contract_price")%>")) return false; 
		if(!checkNull("bill_money","<%=domainInstance.getPropertyCnName("bill_money")%>")) return false; 
		if(!checkNull("gather_date","<%=domainInstance.getPropertyCnName("gather_date")%>")) return false; 
		if(!checkNull("gather_money","<%=domainInstance.getPropertyCnName("gather_money")%>")) return false; 
		if(!checkNull("bill_receivable","<%=domainInstance.getPropertyCnName("bill_receivable")%>")) return false; 
		if(!checkNull("contract__receivable","<%=domainInstance.getPropertyCnName("contract__receivable")%>")) return false; 
		if(!checkNull("c","<%=domainInstance.getPropertyCnName("c")%>")) return false; 
		if(!checkNull("f","<%=domainInstance.getPropertyCnName("f")%>")) return false; 
					 
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
						<%=domainInstance.getPropertyCnName("management_name") %>: 
					</td> 
					<td> 
						<input name="management_name" type="text" id="management_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getManagement_name(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contract_sign_time") %>: 
					</td> 
					<td> 
						<input name="contract_sign_time" type="text" id="contract_sign_time" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContract_sign_time(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("bill_number") %>: 
					</td> 
					<td> 
						<input name="bill_number" type="text" id="bill_number" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_number(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("bill_date") %>: 
					</td> 
					<td> 
						<input name="bill_date" type="text" id="bill_date" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_date(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("user_name") %>: 
					</td> 
					<td> 
						<input name="user_name" type="text" id="user_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getUser_name(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("customer_full_name") %>: 
					</td> 
					<td> 
						<input name="customer_full_name" type="text" id="customer_full_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_full_name(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contract_price") %>: 
					</td> 
					<td> 
						<input name="contract_price" type="text" id="contract_price" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContract_price(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("bill_money") %>: 
					</td> 
					<td> 
						<input name="bill_money" type="text" id="bill_money" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_money(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("gather_date") %>: 
					</td> 
					<td> 
						<input name="gather_date" type="text" id="gather_date" value="<%=StringUtil.getNotEmptyStr(domainInstance.getGather_date(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("gather_money") %>: 
					</td> 
					<td> 
						<input name="gather_money" type="text" id="gather_money" value="<%=StringUtil.getNotEmptyStr(domainInstance.getGather_money(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("bill_receivable") %>: 
					</td> 
					<td> 
						<input name="bill_receivable" type="text" id="bill_receivable" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_receivable(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contract__receivable") %>: 
					</td> 
					<td> 
						<input name="contract__receivable" type="text" id="contract__receivable" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContract__receivable(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("c") %>: 
					</td> 
					<td> 
						<input name="c" type="text" id="c" value="<%=StringUtil.getNotEmptyStr(domainInstance.getC(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("f") %>: 
					</td> 
					<td> 
						<input name="f" type="text" id="f" value="<%=StringUtil.getNotEmptyStr(domainInstance.getF(),"")%>" size="20"  > 
						<font color="red">*</font> 
					</td> 
				</tr> 
			</table> 
			 
			<!-- 工具栏 --> 
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" /> 
		</form> 
	</body> 
</html> 
