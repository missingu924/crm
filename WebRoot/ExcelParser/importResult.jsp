<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<html> 
	<head> 
		<base target="_self" /> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />		<title>Excel导入结果</title> 
		<link href="../css/global.css" rel="stylesheet" type="text/css"> 
		<link href="../css/table.css" rel="stylesheet" type="text/css"> 
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>  
	</head> 
	<body> 
			<!-- 表格标题 --> 
			<table width="98%" align="center" class="detail_table"> 
				<tr> 
					<td>
		<%
		Object errorMessageObj = request.getAttribute("errorMessage");
		if(errorMessageObj!=null)
		{
			Exception e=(Exception)errorMessageObj;
			out.print("<h3><font color=\"red\">Excel解析出错了，具体原因如下:<br></h3></font>"+e.getMessage().replaceAll("\n|\r","<br>"));
		}
		else
		{
		
			out.print("<h3><font color=\"green\">Excel数据导入成功</font></h3><br>");
			out.print("<h3>"+StringUtil.getNotEmptyStr(request.getAttribute("message")).replaceAll("\n|\r","<br>")+"</h3>");
		}
		 %>
						
					</td> 
				</tr> 
			</table>
			
			<!-- 工具栏 --> 
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/> 
	</body> 
</html> 
