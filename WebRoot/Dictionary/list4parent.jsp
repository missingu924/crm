<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.wuyg.auth.obj.AuthRoleObj"%>
<%@page import="com.wuyg.common.dao.BaseDbObj"%>
<%@page import="com.inspur.common.dictionary.Dictionary"%>
<%@page import="com.inspur.common.dictionary.pojo.Dict"%>
<!-- 基本信息 -->
<%
	String clzFullName = request.getParameter("clzFullName");// 该对象类全名
	String tableId = request.getParameter("tableId");// 数据所在table的id
	String fieldName = request.getParameter("fieldName");// 数据选择之后放到哪个字段中
	String dictName = request.getParameter("dictName");// 字典名称
	
	// 字典信息
	Dictionary dictionary = new Dictionary();
	Dict dict = dictionary.getDictByName(dictName);
	String keyColName = dict.getDictKeyCol();
	String valueColName = dict.getDictValueCol();
	
	tableId = StringUtil.getNotEmptyStr(tableId,"sub_list_table");// 如果未传递tableId过来则默认用sub_list_table
	fieldName = StringUtil.getNotEmptyStr(fieldName,keyColName);// 如果为传递fieldName过来则默认用字典的keyColName
	
	// 当前上下文路径 
	String contextPath = request.getContextPath();
	// 该功能对象实例 
	BaseDbObj domainInstance = (BaseDbObj)Class.forName(clzFullName).newInstance();
	// 该功能路径 
	String basePath = domainInstance.getBasePath();
	// 是否增加或修改
	boolean isAddOrModify = "true".equalsIgnoreCase(request.getParameter("isAddOrModify"));
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />
		<link href="../css/global.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
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
					<input name="addButton" type="button" class="button button_add_square" value="增加" onClick="createRowFromDictionary('<%=dictName %>','<%=tableId %>','<%=fieldName %>')">
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
		<table id="<%=tableId %>" class="table table-bordered table-striped" align="center" width="700">
			<thead>
				<tr>
					<th><%=domainInstance.getPropertyCnName(keyColName)%></th>
					<th><%=domainInstance.getPropertyCnName(valueColName)%></th>
					<%if(isAddOrModify){ %>
					<th width="40px" style="text-align: left">
						<input name="delAllButton" type="button" class="button button_delete_square" value="全删" onClick="$('#<%=tableId %> tr:not(:first)').remove()">
					</th>
					<%} %>
				</tr>
			</thead>
			<%
				for (int i = 0; i < list.size(); i++)
				{
					BaseDbObj o = (BaseDbObj) list.get(i);
			%>
			<tr>
				<td><%=StringUtil.getNotEmptyStr(o.getPropertyValue(keyColName))%></td>
				<td><%=StringUtil.getNotEmptyStr(o.getPropertyValue(valueColName))%></td>
				<%if(isAddOrModify){ %>
				<td>
					<input type="hidden" name="<%=fieldName %>" value="<%=o.getPropertyValue(keyColName)%>">
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
