<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmContactObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%> 
<!-- 基本信息 -->  
<% 
	// 上下文路径 
	String contextPath = request.getContextPath(); 
	 
	// 对象实例 
	CrmContactObj domainInstance = new CrmContactObj(); 
	// 该功能基本路径 
	String basePath = domainInstance.getBasePath(); 
 
	// 如果是修改，则获取对象信息 
	Object domainInstanceObj = request.getAttribute("domainInstance"); 
	if (domainInstanceObj != null) 
	{ 
		domainInstance = (CrmContactObj) domainInstanceObj; 
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
		if(!checkNull("contact_name","<%=domainInstance.getPropertyCnName("contact_name")%>")) return false; 
		if(!checkNull("contact_telephone","<%=domainInstance.getPropertyCnName("contact_telephone")%>")) return false; 
					 
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
			<table width="720" align="center" class="detail_table detail_table-bordered"> 
				<input type="hidden" id="<%=domainInstance.findKeyColumnName()%>" name="<%=domainInstance.findKeyColumnName()%>" value="<%=domainInstance.getKeyValue()%>"> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("customer_id") %>:					</td> 
					<td colspan="3"> 
						<%=DictionaryUtil.getInputHtmlReadOnly("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""), 92)%> 
						<font color="red">*</font></td> 
			    </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_name") %>:					</td> 
					<td colspan="3"> 
						<input name="contact_name" type="text" id="contact_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_name(),"")%>" size="20"  > 
						<font color="red">*</font>					</td> 
			    </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_sex") %>:					</td> 
					<td> 
						<%=DictionaryUtil.getSelectHtml("性别字典", "contact_sex", StringUtil.getNotEmptyStr(domainInstance.getContact_sex(), ""))%></td> 
				    <td><%=domainInstance.getPropertyCnName("contact_birthday") %>: </td>
				    <td>
				    <%=DictionaryUtil.getSelectHtml("阴阳历字典", "contact_birthday_type", StringUtil.getNotEmptyStr(domainInstance.getContact_birthday_type(), ""))%>
				    <%=DictionaryUtil.getSelectHtml("月字典", "contact_birthday_month", StringUtil.getNotEmptyStr(domainInstance.getContact_birthday_month(), ""))%>月
				    <%=DictionaryUtil.getSelectHtml("日字典", "contact_birthday_day", StringUtil.getNotEmptyStr(domainInstance.getContact_birthday_day(), ""))%>日</td>
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_telephone") %>:					</td> 
					<td> 
						<input name="contact_telephone" type="text" id="contact_telephone" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_telephone(),"")%>" size="20"  > 
						<font color="red">*</font></td> 
				    <td><%=domainInstance.getPropertyCnName("contact_email") %>: </td>
				    <td><input name="contact_email" type="text" id="contact_email" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_email(),"")%>" size="44"  ></td>
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_qq") %>:					</td> 
					<td> 
						<input name="contact_qq" type="text" id="contact_qq" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_qq(),"")%>" size="20"  > 
					</td> 
				    <td><%=domainInstance.getPropertyCnName("contact_weixin") %>: </td>
				    <td><input name="contact_weixin" type="text" id="contact_weixin" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContact_weixin(),"")%>" size="44"  ></td>
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_hobby") %>:					</td> 
					<td colspan="3"> 
						<textarea name="contact_hobby" cols="70" id="contact_hobby"><%=StringUtil.getNotEmptyStr(domainInstance.getContact_hobby(),"")%></textarea> 
					</td>
				</tr>
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("record_account") %>:					</td> 
					<td> 
						<input type="text" readOnly value="<%=DictionaryUtil.getDictValueByDictKey("账号字典",StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), user.getAccount()))%>" size="20" style="background: #eeeeee;">
						<input name="record_account" type="hidden" id="record_account" value="<%=StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), user.getAccount())%>" size="20">					</td> 
				    <td><%=domainInstance.getPropertyCnName("record_time") %>: </td>
				    <td><input name="record_time" type="text" readonly id="record_time" value="<%=StringUtil.getNotEmptyStr(TimeUtil.date2str(domainInstance.getRecord_time()), TimeUtil.nowTime2str())%>" size="44" style="background: #eeeeee;"></td>
				</tr> 
			</table> 
			 
			<!-- 工具栏 --> 
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" /> 
		</form> 
	</body> 
</html> 
