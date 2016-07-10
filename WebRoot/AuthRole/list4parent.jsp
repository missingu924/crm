<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.wuyg.auth.obj.AuthRoleObj"%>
<!-- 基本信息 -->
<%
	// 当前上下文路径 
	String contextPath = request.getContextPath();
	// 该功能对象实例 
	AuthRoleObj domainInstance = new AuthRoleObj();
	// 该功能路径 
	String basePath = domainInstance.getBasePath();
	// 是否增加或修改
	boolean isAddOrModify = "true".equalsIgnoreCase(request.getParameter("isAddOrModify"));
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />
		<title><%=domainInstance.getCnName()%>列表</title>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
		<link href="../css/table.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
	</head>
	<body>
		<!-- 表格标题 -->
		<table width="700" align="center" class="sub_title_table">
			<tr>
				<td>
					<img src="../images/svg/heavy/green/list.png" width="16" height="16" align="absmiddle">
					&nbsp;&nbsp;<%=isAddOrModify?"修改":"" %>拥有的<%=domainInstance.getCnName()%>
				</td>
				<%if(isAddOrModify){ %>
				<td width="40px" style="text-align: left">
					<input name="addButton" type="button" class="button button_add_square" value="增加" onClick="createRowFromDictionary('角色字典','sub_list_table','rolecode')">
				</td>
				<%} %>
			</tr>
		</table>

		<!-- 查询结果 -->
		<%
			List list = new ArrayList();

			Object tempObj = request.getAttribute("dataList");
			if (tempObj != null)
			{
				list = (List) tempObj;
			}
		%>
		<table id="sub_list_table" class="table table-bordered table-striped" align="center" width="700">
			<thead>
				<tr>
					<th><%=domainInstance.getPropertyCnName("rolecode")%></th>
					<th><%=domainInstance.getPropertyCnName("rolename")%></th>
					<%if(isAddOrModify){ %>
					<th width="40px" style="text-align: left">
						<input name="delAllButton" type="button" class="button button_delete_square" value="全删" onClick="$('#sub_list_table tr:not(:first)').remove()">
					</th>
					<%} %>
				</tr>
			</thead>
			<%
				for (int i = 0; i < list.size(); i++)
				{
					AuthRoleObj o = (AuthRoleObj) list.get(i);
			%>
			<tr>
				<td><%=StringUtil.getNotEmptyStr(o.getRolecode())%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getRolename())%></td>
				<%if(isAddOrModify){ %>
				<td>
					<input type="hidden" name="rolecode" value="<%=o.getRolecode()%>">
					<input type="button" class="button button_delete" title="删除" onClick="$(this).parents('tr').remove();" />
				</td>
				<%} %>
			</tr>
			<%
				}
			%>
		</table>
	</body>
</html>
