<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.auth.obj.AuthRoleObj"%> 
<% 
	// 当前上下文路径  
	String contextPath = request.getContextPath();  
  
	// 该功能对象实例  
	AuthUserObj domainInstance = (AuthUserObj) request.getAttribute("domainInstance");  
	// 该功能路径  
	String basePath = domainInstance.getBasePath();  
%> 
<html> 
	<head> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />		<title><%=domainInstance.getCnName()%>详情</title> 
		<link href="../css/global.css" rel="stylesheet" type="text/css" /> 
		<link href="../css/table.css" rel="stylesheet" type="text/css" /> 
		<script src="../js/jquery-2.0.3.min.js"></script> 
		<script src="../js/utils.js"></script> 
	</head> 
	<body> 
		<!-- 表格标题 --> 
		<table width="700" align="center" class="title_table"> 
			<tr> 
				<td> 
					<img src="../images/svg/heavy/green/list.png" width="18" height="18" align="absmiddle"> 
					&nbsp;&nbsp;<%=domainInstance.getCnName()%>信息 
				</td> 
			</tr> 
		</table> 
		<!-- 详细信息 --> 
		<table width="700" align="center" class="detail_table detail_table-bordered detail_table-striped"> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("id") %>:				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getId())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("account") %>:				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getAccount())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("name") %>:				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getName())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("sex") %>:				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("性别字典",domainInstance.getSex())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("telephone") %>:				</td> 
				<td><%=StringUtil.getNotEmptyStr(domainInstance.getTelephone())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("departmentcode") %>:				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("部门字典",domainInstance.getDepartmentcode())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("officecode") %>:				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("职务字典",domainInstance.getOfficecode())%></td> 
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("enable") %>:				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("是否字典",domainInstance.getEnable())%></td> 
			</tr> 
		</table> 
		
		<!-- 角色选择 --> 
		<jsp:include page="../Dictionary/list4parent.jsp">
			<jsp:param name="clzFullName" value="<%=AuthRoleObj.class.getCanonicalName() %>"/>
			<jsp:param name="dictName" value="角色字典"/>
			<jsp:param name="isAddOrModify" value="false"/>
		</jsp:include>
			
		<!-- 工具栏 --> 
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/> 
	</body> 
</html> 
