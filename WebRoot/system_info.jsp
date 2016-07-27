<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.wuyg.common.licence.LicenceUtil"%>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<link href="css/global.css" rel="stylesheet" type="text/css">
<title>系统信息</title>
</head>
<body>
<table width="700" align="center" class="title_table"> 
			<tr> 
				<td> 
					<img src="images/svg/light/green/16/comment.png" align="absmiddle"> 
					系统信息 
				</td> 
			</tr> 
		</table> 
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0" class="detail_table detail_table-bordered detail_table-striped">
  <tr>
    <td>开发语言:</td>
    <td>java+html+jquery+css3 </td>
  </tr>
  <tr>
    <td>数据库版本:</td>
    <td>SqlServer2008 </td>
  </tr>
  <tr>
    <td>开发厂商:</td>
    <td><%=LicenceUtil.getLicencedMachine().getSupplier() %></td>
  </tr>
   <tr>
    <td>当前版本:</td>
    <td><%=LicenceUtil.getLicencedMachine().getSystemVersion() %></td>
  </tr>
  <tr>
    <td>系统简介:</td>
    <td>1、该系统适用于<%=LicenceUtil.getLicencedMachine().getCustomerName() %>，主要用来进行客户、商机、合同、开票管理
    <br>
    2、同时间多个经营类型的销售机会要按照不同的经营类型录入多个商机。商机与合同为一对一的关系。
   
    </td>
  </tr>
</table>
</body>
</html>

