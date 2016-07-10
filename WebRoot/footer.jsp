<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.wuyg.common.licence.LicenceUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/global.css" rel="stylesheet" type="text/css">
<title>footer</title>
</head>
<body>
<div align="center"><font color="#999999">Copyright 2016-2020 <%=LicenceUtil.getLicencedMachine().getSupplier()%>技术支持</font></div>
<script>
window.status="<%=LicenceUtil.getLicencedMachine().getSupplier()%>技术支持";
</script>
</body>
</html>

