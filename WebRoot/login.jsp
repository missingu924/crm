<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="java.util.Date"%>
<%@page import="com.wuyg.common.licence.LicenceUtil"%>
<%@page import="com.wuyg.common.licence.LicenseConstant"%>
<%@page import="com.wuyg.common.licence.LicenseGather"%>
<%@page import="com.wuyg.common.licence.MachineInfoObj"%>

<%
	String info = StringUtil.getNotEmptyStr(request.getParameter("info"));

	// 检查许可
	boolean licenceSucc = false;//许可成功
	String checkResult = LicenceUtil.check();
	if (LicenseConstant.MSG_LIC_SUCC.equals(checkResult))
	{
		licenceSucc = true;
	}
	
	// 测试期间，不判断许可
	licenceSucc = true;

	if (!licenceSucc)
	{
		info = "<span class=\"infoStyle\">" + checkResult + "，请复制以下内容并发送至开发商获取授权<br/><br/></span>" + LicenceUtil.encode(LicenseGather.getThisMachineInfo());
	} else if ("needReLogin".equalsIgnoreCase(info))
	{
		info = "请重新登录！";
	}

	// 读取许可信息
	MachineInfoObj licensedMachine = null;
	try
	{
		licensedMachine = LicenceUtil.getLicencedMachine();
		if (licensedMachine == null)
		{
			licensedMachine = new MachineInfoObj();
		}
	} catch (Exception e)
	{
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title><%=licensedMachine.getName()%></title>

		<link href="css/global.css" rel="stylesheet" type="text/css">
		<style type="text/css">
.loginTitle {
	font-size: 16px;
	font-weight: bold;
}

.infoStyle {
	font-size: 20px;
	color: #FF0000;
}

/* 背景图 */
.loginBg {
	background: top no-repeat url(images/background/login_new.jpg);
}
-->
</style>
	</head>
	<script type="text/javascript" src="js/jquery-2.0.3.min.js"></script>
	<script type="text/javascript" src="js/css-1.7.0.min.js"></script>
	<script src="js/utils.js"></script>
	<body>
		<div style='display: <%=(!licenceSucc) ? "none" : ""%>'>
			<form id="loginForm" name="loginForm" method="post" action="AuthUser/Servlet?method=login">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="center" height="100"><font color="red"><%=info%></font></td>
					</tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="15%" height="60"></td>
						<td align="left" class="little_gray_font">
							<img style="vertical-align:middle" src="images/SystemName.png" width="296" height="56">
							(<%=licensedMachine.getSystemVersion() %>版)
						</td>
						<td align="right" class="little_gray_font"><%=licensedMachine.getSlogan()%></td>
						<td width="15%"></td>
					</tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="loginBg">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="15%" height="420"></td>
									<td colspan="2" align="right" valign="middle">
										<table width="320" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
											<tr>
												<td height="10" align="center">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td bgcolor="#FFFFFF" height="60">&nbsp;
																
														  </td>
															<td width="239" align="center">
																<span class="loginTitle">系统登录</span>
															</td>
															<td bgcolor="#FFFFFF">&nbsp;
																
														  </td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="header_bottom" height="5"></td>
											</tr>
											<tr>
												<td height="50" align="center" valign="bottom">
													账号&nbsp;&nbsp;
													<input name="account" type="text" id="account" size="25" />
												</td>
											</tr>
											<tr>
												<td align="center" height="1" background="#CCCCCC"></td>
											</tr>
											<tr>
												<td height="50" align="center" valign="bottom">
													密码&nbsp;&nbsp;
													<input name="password" type="password" id="password" size="26" />
												</td>
											</tr>
											<tr>
												<td height="20" align="right" bgcolor="#FFFFFF"></td>
											</tr>
											<tr>
												<td align="center" valign="middle" bgcolor="#FFFFFF">
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input name="button" type="button" class="button blue_button" style="width:200px" onClick="login()" value="登录">
												</td>
											</tr>
											<tr>
												<td height="20" align="right" bgcolor="#FFFFFF"></td>
											</tr>
									  </table>
									</td>
									<td width="15%"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="15%" height="50"></td>
						<td align="left" class="little_gray_font">
							请使用1024*768以上分辨率
						</td>
						<td align="right" class="little_gray_font">
							授权给<%=licensedMachine.getCustomerName()%>使用&nbsp;&nbsp;|&nbsp;&nbsp;<%=licensedMachine.getSupplier()%>技术支持
						</td>
						<td width="15%">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style='display: <%=(!licenceSucc) ? "" : "none"%>'>
			<table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="center" valign="middle"><%=info%></td>
				</tr>
			</table>
		</div>
	</body>
	<script type="text/javascript">
	// 登录
	function login()
	{
		if(!checkNull("account","用户名")) return;
		//if(!checkNull("password","密码")) return;
		
		$('#loginForm').submit();
	}
	
	// 光标定位在第一个输入框
	$('input:text:first').focus();
        
	// 绑定enter事件
	$('body').keydown(function(){
	   if(event.keyCode == 13)
	   {
		 login();
	   }
	});
	
	if(parent.frames["mainFrame"])
		parent.location.replace(parent.location.href);
</script>
</html>
