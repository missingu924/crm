<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%> 
<%@page import="com.wuyg.dictionary.service.DictionaryService"%> 
<%@page import="com.wuyg.dictionary.service.IDictionaryService"%> 
<%@page import="com.excelparser.obj.ExcelParserObj"%>
<%@page import="com.wuyg.common.dao.BaseDbObj"%> 
<!-- 基本信息 -->  
<% 
	// 上下文路径 
	String contextPath = request.getContextPath(); 
	 
	// 对象实例 
	ExcelParserObj domainInstance = new ExcelParserObj(); 
	// 该功能基本路径 
	String basePath = domainInstance.getBasePath(); 
 
	// 解析器名称 或 basedbobj 类全名
	String parser_name = StringUtil.getNotEmptyStr(request.getParameter("parser_name")) ;
	String basedbobj_class = StringUtil.getNotEmptyStr(request.getParameter("basedbobj_class"));
	
	if(StringUtil.isEmpty(parser_name))
	{
		BaseDbObj basedbobj = (BaseDbObj) Thread.currentThread().getContextClassLoader().loadClass(basedbobj_class).newInstance();
		parser_name = basedbobj.getCnName();
	}
	
%> 
<html> 
	<head> 
		<base target="_self" /> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />		<title><%=domainInstance.getCnName()%></title> 
		<link href="../css/global.css" rel="stylesheet" type="text/css"> 
		<link href="../css/table.css" rel="stylesheet" type="text/css"> 
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script> 
		<script type="text/javascript" src="../js/utils.js"></script> 
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>  
	</head> 
	<body> 
		<form name="addOrModifyForm" id="addOrModifyForm" action="<%=contextPath%>/<%=basePath%>/Servlet?method=uploadFile" enctype="multipart/form-data" method="post"> 
			
			<!-- 表格标题 --> 
			<table width="98%" align="center" class="title_table"> 
				<tr> 
					<td> 
						<img src="../images/excel.png" width="18" height="18" align="absmiddle"> 
						&nbsp;&nbsp;<%=parser_name %> - Excel数据导入
					</td> 
				</tr> 
			</table> 
 
			<!-- 详细信息 --> 
			<table width="98%" align="center" class="detail_table detail_table-bordered detail_table-striped"> 
			<input type="hidden" id="parser_name" name="parser_name" value="<%=parser_name %>">
			<input type="hidden" id="basedbobj_class" name="basedbobj_class" value="<%=basedbobj_class %>">
				<tr> 
					<td style="width:200px;text-align:center"> 
						请选择要导入的Excel数据文件:<br>(支持Office2007及以下版本)
					</td> 
					<td> 
						<input id="file_upload" name="file_upload" type="file" size="50"/> 
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="submit" class="button button_add" value="预览"/> 
					</td> 
				</tr> 
			</table> 
		</form> 
	</body> 
</html> 
