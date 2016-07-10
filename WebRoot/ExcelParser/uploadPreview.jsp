<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 --> 
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.common.obj.PaginationObj"%> 
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%> 
<%@page import="com.wuyg.dictionary.service.DictionaryService"%> 
<%@page import="com.excelparser.obj.ExcelParserObj"%>
<%@page import="com.wuyg.common.dao.BaseDbObj"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.beanutils.BeanUtils"%>
<%@page import="com.wuyg.excelparser.obj.ExcelParserConfigObj"%> 
<!-- 基本信息 --> 
<% 
	// 当前上下文路径 
	String contextPath = request.getContextPath(); 
 
	// 该功能对象实例 
	ExcelParserObj domainInstance = (ExcelParserObj) request.getAttribute("domainInstance"); 
	// 该功能路径 
	String basePath = domainInstance.getBasePath(); 
%> 
<html> 
	<head> 
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />		<title><%=domainInstance.getCnName() %>列表</title> 
		<link href="../css/global.css" rel="stylesheet" type="text/css"> 
		<link href="../css/table.css" rel="stylesheet" type="text/css"> 
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script> 
		<script type="text/javascript" src="../js/utils.js"></script> 
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script> 
	</head> 
	<body> 
		
		
		<%
		Object errorMessageObj = request.getAttribute("errorMessage");
		if(errorMessageObj!=null)
		{
			Exception e=(Exception)errorMessageObj;
			out.print("<table width='90%' align='center'><tr><td><h3><font color=\"red\">出错了:<br>"+e.getMessage()+"</font></h3></td></tr></table>");
		}
		else
		{
		 %>
		
		<form name="pageForm" id="pageForm" method="post" action="<%=request.getContextPath()%>/<%=basePath%>/Servlet?method=import2db"> 
		
			<!-- 数据处理方式 --> 
			<table class="search_table" align="center" width="98%"> 
				<tr> 
					<td align="left"> 
						请选择导入方式
						<%=DictionaryUtil.getSelectHtml(new DictionaryService().getDictItemsByDictName("导入数据处理方式字典", false), "import_type", "", StringUtil.getNotEmptyStr(domainInstance.getImport_type(), ""), "notEmpty")%> 
						&nbsp;  
						 
					</td> 
					<td align="right"> 
						<input name="addButton" type="button" class="button button_add" value="导入" onclick="import2db()"> 
					</td> 
				</tr> 
			</table> 
 
			<!-- 查询结果 --> 
			<% 
				List excelDataList = new ArrayList(); // 本次解析出的所有记录
				List inDbDataList = new ArrayList(); // 数据库中已经存在的记录
				List justInExcelDataList = new ArrayList(); // 本次新增的记录
				
				ExcelParserConfigObj excelParserConfig = null;
				
				Object tmpObj = request.getSession().getAttribute("excelDataList"); 
				if (tmpObj != null) 
				{ 
					excelDataList = (List)tmpObj; 
				} 
 
				tmpObj = request.getSession().getAttribute("inDbDataList"); 
				if (tmpObj != null) 
				{ 
					inDbDataList = (List)tmpObj; 
				} 
				
				tmpObj = request.getSession().getAttribute("justInExcelDataList"); 
				if (tmpObj != null) 
				{ 
					justInExcelDataList = (List)tmpObj; 
				}
				
				tmpObj = request.getSession().getAttribute("excelParserConfig"); 
				if (tmpObj != null) 
				{ 
					excelParserConfig = (ExcelParserConfigObj)tmpObj; 
				}
				
				Class javaBeanClass = Thread.currentThread().getContextClassLoader().loadClass(excelParserConfig.getJavaBean());
				
				if(javaBeanClass!=null)
				{					
			%> 
			
		<!-- 本次新增数据 --> 
		<div id="new_data_div"  style="display:none">
		<table width="98%" align="center" class="title_table"> 
			<tr> 
				<td> 
					<img src="../images/excel.png" width="18" height="18" align="absmiddle"> 
					&nbsp;&nbsp;<font color="#ff9900"><%=justInExcelDataList.size()%></font>条新数据
				</td> 
			</tr> 
		</table> 
			<table class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
					<% 
						BaseDbObj javaBean = (BaseDbObj)javaBeanClass.newInstance();
						Iterator columnEnNamesIter = javaBean.findProperties().keySet().iterator();
						List<String> columnEnNamesList = new ArrayList<String>();
						while(columnEnNamesIter.hasNext())
						{
							String columnEnName = (String)columnEnNamesIter.next();
							if(javaBean.findKeyColumnName().equalsIgnoreCase(columnEnName))
							{
								continue; // 忽略key
							}
							columnEnNamesList.add(columnEnName);
						}
						
						for(int n=0;n<columnEnNamesList.size();n++)
						{
								String columnEnName = columnEnNamesList.get(n);
								String columnCnName = javaBean.findProperties().get(columnEnName);
					%>
						<th><%= columnCnName%></th>
					<%	} %>
					</tr> 
				</thead> 
				<% 
					
					for (int i = 0; i < justInExcelDataList.size(); i++) 
					{ 
							BaseDbObj o = (BaseDbObj) justInExcelDataList.get(i); 
							
							out.println("<tr>");
							for(int n=0;n<columnEnNamesList.size();n++)
							{
								String columnEnName = columnEnNamesList.get(n);
								out.print("<td>"+StringUtil.getNotEmptyStr(BeanUtils.getProperty(o,columnEnName))+"</td>"); 
							} 
							
							out.println("</tr>");
					}
				%> 
			</table> 
		</div>
		
		
		<div id="same_data_div" style="display:none">
		<!-- 数据库中已经存在的数据 --> 
		<table width="98%" align="center" class="title_table"> 
			<tr> 
				<td> 
					<img src="../images/excel.png" width="18" height="18" align="absmiddle"> 
					&nbsp;&nbsp;<font color="#ff9900"><%=inDbDataList.size()%></font>条数据在系统中已存在
				</td>
				<td style="text-align:right">
				<div id="same_record_process_type_div" style="display:none">
				请选择处理方式
						<%=DictionaryUtil.getSelectHtml(new DictionaryService().getDictItemsByDictName("导入相同数据处理方式字典", false), "same_record_process_type", "", StringUtil.getNotEmptyStr(domainInstance.getImport_type(), ""), "notEmpty")%> 
				</div>	
				</td> 
			</tr> 
		</table> 
			<table class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
					<% 

						for(int n=0;n<columnEnNamesList.size();n++)
						{
								String columnEnName = columnEnNamesList.get(n);
								String columnCnName = javaBean.findProperties().get(columnEnName);
					%>
						<th><%= columnCnName%></th>
					<%	} %>
					</tr> 
				</thead> 
				<% 
					
					for (int i = 0; i < inDbDataList.size(); i++) 
					{ 
							BaseDbObj o = (BaseDbObj) inDbDataList.get(i); 
							
							out.println("<tr>");
							for(int n=0;n<columnEnNamesList.size();n++)
							{
								String columnEnName = columnEnNamesList.get(n);
								out.print("<td>"+StringUtil.getNotEmptyStr(BeanUtils.getProperty(o,columnEnName))+"</td>"); 
							} 
							
							out.println("</tr>");
					}
				%> 
			</table> 
			</div>
			
		<div id="all_data_div"  style="display:">
		<!-- 所有的数据 --> 
		<table width="98%" align="center" class="title_table"> 
			<tr> 
				<td> 
					<img src="../images/excel.png" width="18" height="18" align="absmiddle"> 
					&nbsp;&nbsp;共解析出<font color="#ff9900"><%=excelDataList.size()%></font>条数据<span id="cover_info" style="display:none;color:#ff9900">，将删除系统中已有数据并导入这些新数据</span>
				
				</td> 
			</tr> 
		</table> 
			<table class="table table-bordered table-striped" align="center" width="98%"> 
				<thead> 
					<tr> 
					<% 

						for(int n=0;n<columnEnNamesList.size();n++)
						{
								String columnEnName = columnEnNamesList.get(n);
								String columnCnName = javaBean.findProperties	().get(columnEnName);
					%>
						<th><%= columnCnName%></th>
					<%	} %>
					</tr> 
				</thead> 
				<% 
					
					for (int i = 0; i < excelDataList.size(); i++) 
					{ 
							BaseDbObj o = (BaseDbObj) excelDataList.get(i); 
							
							out.println("<tr>");
							for(int n=0;n<columnEnNamesList.size();n++)
							{
								String columnEnName = columnEnNamesList.get(n);
								out.print("<td>"+StringUtil.getNotEmptyStr(BeanUtils.getProperty(o,columnEnName))+"</td>"); 
							} 
							
							out.println("</tr>");
					}
				%> 
			</table> 
			</div>
			
	<script>
			
	 function import2db()
	 {
		 if(!checkNull("import_type","<%=domainInstance.getPropertyCnName("import_type")%>")) return false; 
	 	 
	 	 
	 	 if('新增'==$('#import_type').val()
	 	 &&<%=inDbDataList.size()%>>0
	 	 )// 新增 且 数据库中有相同数据
	 	 {
	 	 	if(!checkNull("same_record_process_type","<%=domainInstance.getPropertyCnName("same_record_process_type")%>")) return false; 
	 	 }
	 	 
	 	 if(
	 	 '新增'==$('#import_type').val()
	 	 &&<%=justInExcelDataList.size()%>==0
	 	 &&$("#same_record_process_type").val()=='保持系统中数据不变'
	 	 )// 新增 且 没有新增数据 且 相同数据的处理方式选择了 保持系统中数据不变
	 	 {
	 	 	alert("'没有新增数据'且对于相同数据的处理方式您选择了'保持系统中数据不变' ，因此没有任何数据需要导入，请重新选择");
	 	 	return false; 
	 	 }
	 	 
	 	 $('#pageForm').submit();
	 	 
	 }
	 
	 
	 $('#import_type').change(function(){
	 	var selected = $(this).val();
	 	var new_data_div = $('#new_data_div');
	 	var same_data_div = $('#same_data_div');
	 	var all_data_div = $('#all_data_div');
	 	var cover_info = $('#cover_info');
	 	var same_record_process_type_div = $('#same_record_process_type_div');
	 	if('新增'==selected)
	 	{
	 		new_data_div.show();
	 		same_data_div.show();
	 		all_data_div.hide();
	 		same_record_process_type_div.show();
	 	}
	 	else if('覆盖'==selected)
	 	{
	 		new_data_div.hide();
	 		same_data_div.hide();
	 		all_data_div.show();
	 		cover_info.show();
	 	}
	 	else if(''==selected)
	 	{
	 		new_data_div.hide();
	 		same_data_div.hide();
	 		all_data_div.show();
	 		cover_info.hide();
	 	}
	 });
	 </script>
			
			<%} 
			
			}
			%>
  
		</form>  
	
	 
	
	</body> 
</html> 
