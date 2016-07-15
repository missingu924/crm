<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.auth.obj.AuthRoleObj"%> 
<!-- 基本信息 -->  
<% 
	// 上下文路径 
	String contextPath = request.getContextPath(); 
	 
	// 对象实例 
	AuthUserObj domainInstance = new AuthUserObj(); 
	// 该功能基本路径 
	String basePath = domainInstance.getBasePath(); 
 
	// 如果是修改，则获取对象信息 
	Object domainInstanceObj = request.getAttribute("domainInstance"); 
	if (domainInstanceObj != null) 
	{ 
		domainInstance = (AuthUserObj) domainInstanceObj; 
	} 
 
	// 是否是修改 
	boolean isModify = domainInstance.getKeyValue() >= 0; 
	// 唯一性检查用的字段 
	String keyCol = "account"; 
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
		if(!checkNull("account","<%=domainInstance.getPropertyCnName("account")%>")) return false; 
		if(!checkNull("password","<%=domainInstance.getPropertyCnName("password")%>")) return false; 
		if(!checkNull("name","<%=domainInstance.getPropertyCnName("name")%>")) return false; 
		if(!checkNull("sex","<%=domainInstance.getPropertyCnName("sex")%>")) return false;  
		if(!checkNull("departmentcode","<%=domainInstance.getPropertyCnName("departmentcode")%>")) return false;  
					 
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
		<form name="addOrModifyForm" id="addOrModifyForm" action="<%=contextPath%>/<%=basePath%>/Servlet?method=addOrModify4this" method="post">&nbsp;  
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
						<%=domainInstance.getPropertyCnName("account") %>:					</td> 
					<td> 
						<input name="account" type="text" id="account" value="<%=StringUtil.getNotEmptyStr(domainInstance.getAccount(),"")%>" size="20"  <%=isModify?"readOnly":""%>> 
						<font color="red">*</font> 
						<font color="red"><%=isModify?"(不可修改)":"(不能重复)"%></font>					</td> 
		        </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("password") %>:					</td> 
					<td> 
						<input name="password" type="password" id="password" value="<%=StringUtil.getNotEmptyStr(domainInstance.getPassword(),"")%>" size="20"  > 
						<font color="red">*</font>					</td> 
		        </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("name") %>:					</td> 
					<td> 
						<input name="name" type="text" id="name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getName(),"")%>" size="20"  > 
						<font color="red">*</font>					</td> 
		        </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("sex") %>:					</td> 
					<td> 
						<%=DictionaryUtil.getSelectHtml("性别字典", "sex", StringUtil.getNotEmptyStr(domainInstance.getSex(), ""))%> 
						<font color="red">*</font>					</td> 
			    </tr> 
				<tr> 
					<td><%=domainInstance.getPropertyCnName("telephone") %>: </td> 
					<td><input name="telephone" type="text" id="telephone" value="<%=StringUtil.getNotEmptyStr(domainInstance.getTelephone(),"")%>" size="20"  ></td> 
			    </tr>
				<tr>
				  <td><%=domainInstance.getPropertyCnName("departmentcode") %>: </td>
				  <td><%=DictionaryUtil.getSelectHtml("部门字典", "departmentcode", StringUtil.getNotEmptyStr(domainInstance.getDepartmentcode(), ""))%> <font color="red">*</font></td>
			  </tr>
				<tr>
				  <td><%=domainInstance.getPropertyCnName("officecode") %>: </td>
				  <td><%=DictionaryUtil.getSelectHtml("职务字典", "officecode", StringUtil.getNotEmptyStr(domainInstance.getOfficecode(), ""))%> </td>
			  </tr> 
			</table> 
			
			<!-- 角色选择 --> 
			<jsp:include page="../Dictionary/list4parent.jsp">
				<jsp:param name="clzFullName" value="<%=AuthRoleObj.class.getCanonicalName() %>"/>
				<jsp:param name="dictName" value="角色字典"/>
				<jsp:param name="isAddOrModify" value="true"/>
			</jsp:include>
			

			<!-- 工具栏 --> 
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" /> 
		</form> 
	</body> 
</html> 
