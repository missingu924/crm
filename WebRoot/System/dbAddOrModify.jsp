<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="java.util.List"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.obj.PaginationObj"%>
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%>
<%@page import="com.wuyg.dictionary.service.DictionaryService"%>
<%@page import="com.wuyg.dictionary.service.IDictionaryService"%>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
		String contextPath = request.getContextPath();

		String ip = StringUtil.getNotEmptyStr(request.getAttribute("ip"));
		String port = StringUtil.getNotEmptyStr(request.getAttribute("port"));
		String dbUser = StringUtil.getNotEmptyStr(request.getAttribute("dbUser"));
		String dbPassword = StringUtil.getNotEmptyStr(request.getAttribute("dbPassword"));
		String dbName = StringUtil.getNotEmptyStr(request.getAttribute("dbName"));
	%>
	<head>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>总账账套管理</title>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<script>
		//  新增或修改
		function addOrModify()
		{
						// 如果账号符合要求且未被使用，则监测其他的项
						if(!checkAllNotEmptyInput()) return false;
						
			$.ajax({   
			type:"post",     
			url:$('#mainForm').attr("action"),   
			data:$('#mainForm').serialize(),
			success:function(result){     
				 $("#result").html(result);     
			 },   
			 error:function(){   
				 alert("出现了点小问题哦");   
			 }   
		 }); 
		}
		</script>
		<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000
}
-->
</style>
	</head>
	<body>
		<form name="mainForm" id="mainForm" action="<%=contextPath%>/System/Servlet?method=dbAddOrModify" method="post">


			<!-- 表格标题 -->
			<table width="600" align="center" class="title_table">
				<tr>
					<td>
						<img src="../images/svg/heavy/green/receipt.png" width="18" height="18" align="absmiddle" />
						&nbsp;&nbsp;总账账套管理
					</td>
				</tr>
			</table>
			<!-- 详细信息 -->
			<table width="600" align="center" class="detail_table detail_table-bordered detail_table-striped">
				<tr>
					<td width="130" height="30" align="right" class="little_gray_font">
						<p>
							IP:
						</p>
					</td>
					<td>
						<input name="ip" type="text" id="ip" value="<%=ip%>" class="notEmpty" label="IP">
					</td>
				</tr>
				<tr>
					<td width="130" height="30" align="right" class="little_gray_font">
						端口:
					</td>
					<td>
						<label>
							<input name="port" type="text" id="port" label="端口" value="<%=StringUtil.getNotEmptyStr(port)%>" class="notEmpty">
						</label>
					</td>
				</tr>
				<tr>
					<td width="130" height="30" align="right" class="little_gray_font">
						用户名:
					</td>
					<td>
						<label>
							<input name="dbUser" type="text" id="dbUser" value="<%=StringUtil.getNotEmptyStr(dbUser)%>" class="notEmpty" label="用户名">
						</label>
					</td>
				</tr>
				<tr>
					<td width="130" height="30" align="right" class="little_gray_font">
						密码:
					</td>
					<td>
						<label>
							<input name="dbPassword" type="password" class="notEmpty" id="dbPassword" value="<%=StringUtil.getNotEmptyStr(dbPassword)%>" label="密码">
						</label>
					</td>
				</tr>
				<tr>
					<td width="130" height="30" align="right" class="little_gray_font">
						账套:
					</td>
					<td>
						<label>
							<input name="dbName" type="text" id="dbName" value="<%=StringUtil.getNotEmptyStr(dbName)%>" class="notEmpty" label="账套">
						</label>
					</td>
				</tr>
			</table>
						<!-- 工具栏 --> 
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" /> 
			
			<div name="result" id="result" align="center" style="color:#ff6600"></div>
		</form>

	</body>
</html>
