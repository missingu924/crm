<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmContractObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.wuyg.common.dao.BaseDbObj"%>
<%@page import="com.crm.obj.CrmManagementActivityObj"%>
<%@page import="com.crm.obj.CrmBillObj"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<%
	// 当前上下文路径  
	String contextPath = request.getContextPath();

	// 该功能对象实例  
	CrmContractObj domainInstance = (CrmContractObj) request.getAttribute("domainInstance");
	// 该功能路径  
	String basePath = domainInstance.getBasePath();
	// 用户信息
	AuthUserObj user= (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
	boolean cf=user.hasFunction("合同-CF字段管理");
%>
<html>
	<head>
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />
		<title><%=domainInstance.getCnName()%>详情</title>
		<link href="../css/global.css" rel="stylesheet" type="text/css" />
		<link href="../css/table.css" rel="stylesheet" type="text/css" />
		<script src="../js/jquery-2.0.3.min.js"></script>
		<script src="../js/utils.js"></script>
	</head>
	<body>

		<!-- 操作栏 -->
		<table width="720" align="center" class="top_tools_table">
			<tr>
				<td>
					<%if(user.hasFunction("合同-修改")){ %><a href='<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>'> <input name="button" type="button" class="button button_modify" value="修改" /> </a><%} %>
					<%if(user.hasFunction("合同-删除")){ %><input id="deleteButton" type="button" class="button button_delete" value="删除" onClick="deleteIt('<%=contextPath%>/<%=basePath%>/Servlet?method=delete4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>')"><%} %>
					
					<%
					if(user.hasFunction("开票收款-增加")){ 
						if ("否".equals(domainInstance.getIs_finished()))
						{
					%>
					<input name="billButton" type="button" class="button button_add"
						onClick="openBigModalDialog('<%=contextPath%>/CrmBill/Servlet?method=preModify4this&id=-1&customer_id=<%=domainInstance.getCustomer_id()%>&commerical_opportunity_id=<%=domainInstance.getCommercial_oppotunity_id()%>&contract_id=<%=domainInstance.getKeyValue()%>&contract_user_account=<%=domainInstance.getRecord_account()%>')" value="开票收款" />
					<%
						}
					}
					%>
				</td>
			</tr>
		</table>
		<!-- 表格标题 -->
		<table width="720" align="center" class="title_table">
			<tr>
				<td>
					<%=domainInstance.getCnName()%>信息
				</td>
			</tr>
		</table>
		<!-- 详细信息 -->
		<table width="720" align="center" class="detail_table detail_table-bordered ">
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("contract_name")%>:
				</td>
				<td colspan="3"><%=StringUtil.getNotEmptyStr(domainInstance.getContract_name())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("customer_id")%>:
				</td>
				<td colspan="3">
				<%if(user.hasFunction("客户档案-查询")){ %>
					<a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCustomer/Servlet?method=detail4this&id=<%=domainInstance.getCustomer_id()%>')"><%=DictionaryUtil.getDictValueByDictKey("客户字典", domainInstance.getCustomer_id() + "")%></a>
				<%} else { %>
					<%=DictionaryUtil.getDictValueByDictKey("客户字典", domainInstance.getCustomer_id() + "")%>
				<%} %>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("commercial_oppotunity_id")%>:
				</td>
				<td colspan="3">
				<%if(user.hasFunction("商机-查询")){ %>
					<a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCommercialOpportunity/Servlet?method=detail4this&id=<%=domainInstance.getCommercial_oppotunity_id()%>')"><%=DictionaryUtil.getDictValueByDictKey("商机字典", domainInstance.getCommercial_oppotunity_id() + "")%></a>
				<%} else { %>
					<%=DictionaryUtil.getDictValueByDictKey("商机字典", domainInstance.getCommercial_oppotunity_id() + "")%>
				<%} %>
				</td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("management_type_code")%>:
				</td>
				<td colspan="3"><%=DictionaryUtil.getDictValueByDictKey("经营类型字典", domainInstance.getManagement_type_code())%></td>
			<tr>
				<td><%=domainInstance.getPropertyCnName("contract_subject")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("合同主体字典", domainInstance.getContract_subject())%></td>
				<td><%=domainInstance.getPropertyCnName("is_finished")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("是否字典", domainInstance.getIs_finished())%></td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("contract_sign_time")%>:
				</td>
				<td><%=TimeUtil.date2str(domainInstance.getContract_sign_time(), "yyyy-MM-dd")%></td>
				<td><%=domainInstance.getPropertyCnName("contract_price")%>:
				</td>
				<td><%=StringUtil.formatDouble(domainInstance.getContract_price(), 2)%></td>
			</tr>
			<%if(cf){ %>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("c")%>:
				</td>
				<td><%=StringUtil.formatDouble(domainInstance.getC(), 2)%></td>
				<td><%=domainInstance.getPropertyCnName("f")%>:
				</td>
				<td><%=StringUtil.formatDouble(domainInstance.getF(), 2)%></td>
			</tr>
			<%} %>
			<tr>
				<td><%=domainInstance.getPropertyCnName("gather_money_total")%>:
				</td>
				<td><%=StringUtil.formatDouble(domainInstance.getGather_money_total(), 2)%>&nbsp;
					<font color="green">(<%=domainInstance.getPropertyCnName("spare_money")%>:<%=StringUtil.formatDouble(domainInstance.getSpare_money(), 2)%>)</font>
				</td>
				<td><%=domainInstance.getPropertyCnName("bill_money_total")%>:
				</td>
				<td><%=StringUtil.formatDouble(domainInstance.getBill_money_total(), 2)%>&nbsp;
				<font color="green">(<%=domainInstance.getPropertyCnName("bill_spare_money")%>:<%=StringUtil.formatDouble(domainInstance.getBill_spare_money(), 2)%>)</font>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("comment")%>:
				</td>
				<td colspan="3">
					<%=StringUtil.getNotEmptyStr(domainInstance.getComment(), "").replaceAll("\n","<br>")%>
				</td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("record_account")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", domainInstance.getRecord_account())%></td>
				<td><%=domainInstance.getPropertyCnName("record_time")%>:
				</td>
				<td><%=TimeUtil.date2str(domainInstance.getRecord_time())%></td>
			</tr>
		</table>

		<table id="tab_table" width="720" align="center" class="sub_title_table">
			<tr>
				<td div_id="bill_info_div" style="width: 80px">
					开票信息
				</td>
				<td div_id="bill_gather_info_div" style="width: 80px">
					开票收款记录
				</td>
				<td></td>
			</tr>
		</table>

		<div id="bill_info_div">
			<table width="100%" align="center" class="detail_table detail_table-bordered ">
				<tr>
					<td><%=domainInstance.getPropertyCnName("draw_bill")%>:
					</td>
					<td><%=DictionaryUtil.getDictValueByDictKey("是否字典", StringUtil.getNotEmptyStr(domainInstance.getDraw_bill(), ""))%></td>
					<%
					if ("是".equalsIgnoreCase(domainInstance.getDraw_bill()))
					{
					%>
					<td><%=domainInstance.getPropertyCnName("bill_type")%>:
					</td>
					<td><%=DictionaryUtil.getDictValueByDictKey("发票类型字典", StringUtil.getNotEmptyStr(domainInstance.getBill_type(), ""))%></td>
					<%} %>
				</tr>
				<%
					if ("是".equalsIgnoreCase(domainInstance.getDraw_bill()))
					{
				%>
				<tr>
					<td><%=domainInstance.getPropertyCnName("bill_company_name")%>:
					</td>
					<td colspan="3">
						<%=StringUtil.getNotEmptyStr(domainInstance.getBill_company_name(), "")%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("bill_duty_number")%>:
					</td>
					<td colspan="3">
						<%=StringUtil.getNotEmptyStr(domainInstance.getBill_duty_number(), "")%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("bill_address")%>:
					</td>
					<td colspan="3">
						<%=StringUtil.getNotEmptyStr(domainInstance.getBill_address(), "")%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("bill_telephone")%>:
					</td>
					<td colspan="3">
						<%=StringUtil.getNotEmptyStr(domainInstance.getBill_telephone(), "")%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("bill_bank_name")%>:
					</td>
					<td colspan="3">
						<%=StringUtil.getNotEmptyStr(domainInstance.getBill_bank_name(), "")%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("bill_bank_account")%>:
					</td>
					<td colspan="3">
						<%=StringUtil.getNotEmptyStr(domainInstance.getBill_bank_account(), "")%>
					</td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			BaseDbObj d = new CrmBillObj();
			List dataList = domainInstance.findBillList();
		%>
		<div id="bill_gather_info_div">
			<table class="table table-bordered table-striped" align="center" width="100%">
				<thead>
					<tr>
						
						<th><%=d.getPropertyCnName("bill_date")%></th>
						<th><%=d.getPropertyCnName("bill_money")%></th>
						<th><%=d.getPropertyCnName("gather_date")%></th>
						<th><%=d.getPropertyCnName("gather_money")%></th>
						<th><%=d.getPropertyCnName("bill_number")%></th>
						<th><%=d.getPropertyCnName("bill_receipt")%></th>
						<th><%=d.getPropertyCnName("comment")%></th>
						<th><%=d.getPropertyCnName("record_account")%></th>
						<th><%=d.getPropertyCnName("record_time")%></th>
						<th>
							详情
						</th>
					</tr>
				</thead>
				<%
					double billTotal = 0, gatherTotal = 0;
					for (int i = 0; i < dataList.size(); i++)
					{
						CrmBillObj o = (CrmBillObj) dataList.get(i);
						billTotal += o.getBill_money() == null ? 0:o.getBill_money();
						gatherTotal += o.getGather_money() == null ? 0:o.getGather_money();
				%>
				<tr>
					<td><%=TimeUtil.date2str(o.getBill_date(),"yyyy-MM-dd")%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getBill_money(), 2)%></td>
					<td><%=TimeUtil.date2str(o.getGather_date(),"yyyy-MM-dd")%></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(o.getGather_money(), 2)%></td>
					<td><%=StringUtil.getNotEmptyStr(o.getBill_number(),"") %></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("是否字典", o.getBill_receipt())%></td>
					<td title="<%=StringUtil.getNotEmptyStr(o.getComment())%>"><%=StringUtil.getNotEmptyStr(o.getComment(), 10)%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", o.getRecord_account())%></td>
					<td><%=TimeUtil.date2str(o.getRecord_time())%></td>
					<td style="text-align: center">
						<input type="button" class="button button_detail" onClick="openBigModalDialog('<%=contextPath%>/<%=d.getBasePath()%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')">
					</td>
				</tr>
				<%
					}
					if (dataList.size() > 0)
					{
				%>
				<tr style="color: blue">
					<td>
						合计
					</td>
					<td style="text-align: right"><%=StringUtil.formatDouble(billTotal, 2)%></td>
					<td></td>
					<td style="text-align: right"><%=StringUtil.formatDouble(gatherTotal, 2)%></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>	
				</tr>
				<%
					}
				%>
			</table>
			<%
				if (dataList.size() > 0)
				{
			%>
			<script type="text/javascript">
		  // 隐藏删除按钮
		  $("#deleteButton").hide();
		  </script>
			<%
				}
			%>
		</div>

		<script type="text/javascript">
		// 应用tab页
		useAsTab("tab_table","720");
		
		// 刷新详情页
		function freshMe() {
			$("body").append("<a href='<%=contextPath%>/<%=basePath%>/Servlet?method=detail4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>&needRefresh=true'><span id='refresh_href'></span></a>");
			$("#refresh_href").click();
		}
		</script>

		<!-- 工具栏 -->
		<jsp:include page="../ToolBar/detail_toolbar.jsp" />
	</body>
</html>
