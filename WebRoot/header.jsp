<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<%@page import="com.wuyg.common.licence.LicenceUtil"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title></title>
		<link href="css/global.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="js/css-1.7.0.min.js"></script>
		<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
		<style type="text/css">
<!--
a {
	color: #fff;
	text-decoration: none;
}

.STYLE2 {
	color: #000000;
	line-height: 20px;
}

.STYLE3 {
	font-size: 24px;
	font-family: Aldhabi, "黑体";
	font-weight: bold;
	color: #FF0000;
}
-->
</style>
		<script type="text/javascript" src="js/utils.js"></script>
	</head>
	<%
		AuthUserObj user = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
	%>
	<body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
			<tr>
				<td width="400" height="65" valign="middle" style="vertical-align: middle" class="little_gray_font">
					<img style="vertical-align: middle" src="images/SystemName.png" width="340" height="65" />
					(<%=LicenceUtil.getLicencedMachine().getSystemVersion()%>版)
				</td>
				<td align="right" valign="bottom" style="background-image: url(images/background/bg_header_cloud.png); background-position: right; background-repeat: no-repeat; padding: 0px 10px 5px 0px">

					<table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center"></td>
							<td align="right">
								<span class="STYLE2"><%=user.getName() %></span>
							</td>
							<td width="20" align="right"></td>
							<td width="1" align="right" bgcolor="#999999"></td>
							<td width="30" align="right">
								<img src="images/svg/light/green/16/comment.png" title="系统信息" style="cursor: pointer" onclick="openBigModalDialog('system_info.jsp')"></img>
							</td>
							<td width="30" align="right">
								<form id="downloadForm" action="<%=request.getContextPath()%>/System/Servlet?method=downloadManual" method="post">
									<img src="images/svg/light/green/16/text_document.png" title="使用手册" style="cursor: pointer" onclick="$('#downloadForm').submit()"></img>
								</form>
							</td>
							<td width="30" align="right">
								<img src="images/svg/light/green/16/arrow_left.png" title="退出" style="cursor: pointer" onclick="logout()"></img>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="8" colspan="2" class="header_bottom"></td>
			</tr>
		</table>
		<script>
	function logout()
	{
		parent.location.href="AuthUser/Servlet?method=logout";
	}
	</script>
	</body>
</html>
