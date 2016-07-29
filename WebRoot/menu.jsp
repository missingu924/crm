<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>系统菜单</title>
	</head>
	<link href="css/global.css" rel="stylesheet" type="text/css" />
	<script src="js/jquery-2.0.3.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/css-1.7.0.min.js"></script>
	<script>
function openInMainFrame(td,url)
{	
	$(".menu_selected").attr("class","menu_not_selected");
	$(td).attr("class","menu_selected");
	parent.mainFrame.location = url;
}

function toggleMenuGroup(td,menuGroupId)
{
	$("#menu_group_" + menuGroupId).toggle();
	if($(td).attr("class")=="menu_header_not_expand")
	{
		$(td).attr("class","menu_header_expand");
	}
	else
	{
		$(td).attr("class","menu_header_not_expand");
	}
}
</script>
	<%
		String contextPath = request.getContextPath();

		// 用户信息
		AuthUserObj user = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

		//boolean isAdmin = SystemConstant.ROLE_ADMIN.equals(user.getRoleLevel());
		boolean isAdmin = user.hasRole(SystemConstant.ROLE_ADMIN);
	%>
	<body class="menu_bg">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="menu_header_expand" onclick="toggleMenuGroup(this,'01')">
					业务管理
				</td>
			</tr>
			<tr>
				<td>
					<table id="menu_group_01" width="100%" cellpadding="0" cellspacing="0" border="0">
						<%if(user.hasFunction("客户档案-查询")){ %>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/CrmCustomer/Servlet?method=list4this&showSearchConditionTable=false')">
								<img src="images/svg/heavy/green/shop.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;客户档案
							</td>
						</tr>
						<%} %>
						<%if(user.hasFunction("商机-查询")){ %>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/CrmCommercialOpportunity/Servlet?method=list4this&showSearchConditionTable=false')">
								<img src="images/svg/heavy/green/present.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;商机
							</td>
						</tr>
						<%} %>
						<%if(user.hasFunction("合同-查询")){ %>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/CrmContract/Servlet?method=list4this&showSearchConditionTable=false')">
								<img src="images/svg/heavy/green/receipt.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;合同
							</td>
						</tr>
						<%} %>
						<%if(user.hasFunction("开票收款-查询")){ %>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/CrmBill/Servlet?method=list4this&showSearchConditionTable=false')">
								<img src="images/svg/heavy/green/cart.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;开票收款
							</td>
						</tr>
						<%} %>
						<%if(user.hasFunction("经营活动-查询")){ %>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/CrmManagementActivity/Servlet?method=list4this&showSearchConditionTable=false')">
								<img src="images/svg/heavy/green/comment.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;经营活动
							</td>
						</tr>
						<%} %>
						<%if(user.hasFunction("联系人-查询")){ %>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/CrmContact/Servlet?method=list4this&showSearchConditionTable=false')">
								<img src="images/svg/heavy/green/user_list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;联系人
							</td>
						</tr>
						<%} %>
						
					</table>
				</td>
			</tr>
			<tr>
				<td class="menu_header_not_expand" onclick="toggleMenuGroup(this,'02')">
					报表
				</td>
			</tr>
			<tr>
				<td>
					<table id="menu_group_02" width="100%" cellpadding="0" cellspacing="0" border="0" style="display:none">
						<%if(user.hasFunction("合同开票收款统计表-查询")){ %>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/VContractBillStat/Servlet?method=list4this&showSearchConditionTable=false')">
								<img src="images/svg/heavy/green/pie_chart.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;合同开票收款统计表
							</td>
						</tr>
						<%} %>
						<%if(user.hasFunction("合同开票收款明细表-查询")){ %>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/VContractBillDetail/Servlet?method=list4this&showSearchConditionTable=false')">
								<img src="images/svg/heavy/green/stats.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;合同开票收款明细表
							</td>
						</tr>
						<%} %>
						<%if(user.hasFunction("收款明细表-查询")){ %>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/VBillDetail/Servlet?method=list4this&showSearchConditionTable=false')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;收款明细表
							</td>
						</tr>
						<%} %>
					</table>
				</td>
			</tr>
			<tr>
				<td class="menu_header_not_expand" onclick="toggleMenuGroup(this,'99')">
					个人管理
				</td>
			</tr>
			<tr>
				<td>
					<table id="menu_group_99" width="100%" cellpadding="0" cellspacing="0" border="0" style="display:none">
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'AuthUser/Servlet?method=detail4this&id=<%=user.getId()%>')">
								<img src="images/svg/heavy/green/user.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;我的账号
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'AuthUser/modifyPassword.jsp')">
								<img src="images/svg/heavy/green/locked.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;修改密码
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<%
				if (user.hasFunction("基础档案-管理"))
				{
			%>
			<tr>
				<td class="menu_header_not_expand" onclick="toggleMenuGroup(this,'05')">
					基础档案管理
				</td>
			</tr>
			<tr>
				<td>
					<table id="menu_group_05" width="100%" cellpadding="0" cellspacing="0" border="0" style="display:none">
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/DictCustomerType/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;客户分类
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/DictRegion/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;区域
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/DictSaleStage/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;销售阶段
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/DictManagementType/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;经营类型
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/DictProduct/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;产品线
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/DictProductVersion/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;产品版本
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/DictSubject/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;合同主体
							</td>
						</tr>
						
					</table>
				</td>
			</tr>
			
			<%} %>

			<%
				if (user.hasFunction("系统管理"))
				{
			%>

			<tr>
				<td class="menu_header_not_expand" onclick="toggleMenuGroup(this,'100')">
					系统管理
				</td>
			</tr>
			<tr>
				<td>
					<table id="menu_group_100" width="100%" cellpadding="0" cellspacing="0" border="0" style="display:none">
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/AuthUser/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/user.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;账号
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/AuthDepartment/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;部门
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/AuthRole/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;角色
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/AuthFunction/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;权限项
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/AuthOffice/Servlet?method=list4this')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;职务
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/AuthLogLogin/Servlet?method=list4this&pageCount=100')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;登录日志
							</td>
						</tr>
						<tr>
							<td class="menu_not_selected" onclick="openInMainFrame(this,'<%=request.getContextPath()%>/AuthLogOperation/Servlet?method=list4this&pageCount=100')">
								<img src="images/svg/heavy/green/list.png" width="12" height="12" align="middle" />
								&nbsp;&nbsp;操作日志
							</td>
						</tr>

					</table>
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</body>