<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmCommercialOpportunityObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.crm.obj.CrmManagementActivityObj"%>
<%@page import="com.wuyg.common.dao.BaseDbObj"%>
<%@page import="com.crm.obj.CrmContractObj"%>
<%
	// 当前上下文路径  
	String contextPath = request.getContextPath();

	// 该功能对象实例  
	CrmCommercialOpportunityObj domainInstance = (CrmCommercialOpportunityObj) request.getAttribute("domainInstance");
	// 该功能路径  
	String basePath = domainInstance.getBasePath();
%>
<html>

	<head>
		<base target="_self" />
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
		<table width="800" align="center" class="top_tools_table">
			<tr>
				<td>
					<a href='<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>'> <input name="modifyOpportunityButton" type="button" class="button button_modify" value="修改" /> </a>
					<input name="deleteButton" type="button" class="button button_delete" value="删除" onClick="deleteIt('<%=contextPath%>/<%=basePath%>/Servlet?method=delete4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>')">
					<input id="followOpportunityButton" type="button" class="button button_add"
						onClick="openBigModalDialog('<%=contextPath%>/CrmManagementActivity/Servlet?method=preModify4this&id=-1&activity_type=01&customer_id=<%=domainInstance.getCustomer_id()%>&commercial_oppotunity_id=<%=domainInstance.getKeyValue()%>')" value="跟进商机" />
					<input id="createCrontractButton" type="button" class="button button_add_square" onClick="openBigModalDialog('<%=contextPath%>/CrmContract/Servlet?method=preModify4this&id=-1&customer_id=<%=domainInstance.getCustomer_id()%>&commercial_oppotunity_id=<%=domainInstance.getKeyValue()%>')"
						value="生成合同" />
				</td>
			</tr>
		</table>
		<!-- 表格标题 -->
		<table width="800" align="center" class="title_table">
			<tr>
				<td>
					<%=domainInstance.getCnName()%>信息
				</td>
			</tr>
		</table>
		<!-- 详细信息 -->
		<table width="800" align="center" class="detail_table detail_table-bordered">
			<tr>
				<td><%=domainInstance.getPropertyCnName("opportunity_name")%>:
				</td>
				<td colspan="5"><%=StringUtil.getNotEmptyStr(domainInstance.getOpportunity_name(), "")%></td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("customer_id")%>:
				</td>
				<td colspan="5">
					<a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCustomer/Servlet?method=detail4this&id=<%=domainInstance.getCustomer_id()%>')"> <%=DictionaryUtil.getDictValueByDictKey("客户字典", domainInstance.getCustomer_id() + "")%> </a>
				</td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("management_account")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", StringUtil.getNotEmptyStr(domainInstance.getManagement_account(), ""))%>
				</td>
				<td><%=domainInstance.getPropertyCnName("management_type_code")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("经营类型字典", StringUtil.getNotEmptyStr(domainInstance.getManagement_type_code(), ""))%>
				</td>
				<td><%=domainInstance.getPropertyCnName("sale_stage_code")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("销售阶段字典", StringUtil.getNotEmptyStr(domainInstance.getSale_stage_code(), ""))%>
				</td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("target_price")%>:
				</td>
				<td><%=StringUtil.formatDouble(domainInstance.getTarget_price(), 2)%></td>
				<td><%=domainInstance.getPropertyCnName("estimate_sign_time")%>:
				</td>
				<td colspan="3"><%=TimeUtil.date2str(domainInstance.getEstimate_sign_time(), "yyyy-MM-dd")%></td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("customer_request")%>:
				</td>
				<td colspan="5"><%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_request(), "")%>
				</td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("next_step")%>:
				</td>
				<td colspan="5"><%=StringUtil.getNotEmptyStr(domainInstance.getNext_step(), "")%>
				</td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("record_account")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", domainInstance.getRecord_account())%>
				</td>
				<td><%=domainInstance.getPropertyCnName("record_time")%>:
				</td>
				<td colspan="3"><%=TimeUtil.date2str(domainInstance.getRecord_time())%></td>
			</tr>
		</table>

		<table id="tab_table" width="800" align="center" class="sub_title_table">
			<tr>
				<td div_id="activity_info_div" style="width: 80px">
					跟进记录
				</td>
				<td div_id="contract_info_div" style="width: 80px">
					合同信息
				</td>
				<td></td>
			</tr>
		</table>
		<%
			BaseDbObj d = new CrmManagementActivityObj();
			List dataList = domainInstance.findActivityList();
		%>
		<div id="activity_info_div">
			<table class="table table-bordered table-striped" align="center" width="100%">
				<thead>
					<tr>
						<th><%=d.getPropertyCnName("activity_date")%></th>
						<th><%=d.getPropertyCnName("participant")%></th>
						<th><%=d.getPropertyCnName("sale_stage_code")%></th>
						<th><%=d.getPropertyCnName("activity_content")%></th>
						<th><%=d.getPropertyCnName("next_step")%></th>
						<th><%=d.getPropertyCnName("record_account")%></th>
						<th><%=d.getPropertyCnName("record_time")%></th>
						<th>
							详情
						</th>
					</tr>
				</thead>
				<%
					for (int i = 0; i < dataList.size(); i++)
					{
						CrmManagementActivityObj o = (CrmManagementActivityObj) dataList.get(i);
				%>
				<tr>
					<td><%=TimeUtil.date2str(o.getActivity_date(), "yyyy-MM-dd")%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getParticipant())%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("销售阶段字典", o.getSale_stage_code())%></td>
					<td title="<%=StringUtil.getNotEmptyStr(o.getActivity_content())%>">
						<%=StringUtil.getNotEmptyStr(o.getActivity_content(), 10)%></td>
					<td title="<%=StringUtil.getNotEmptyStr(o.getNext_step())%>"><%=StringUtil.getNotEmptyStr(o.getNext_step(), 10)%></td>
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
				<script type="text/javascript">
					$('#followOpportunityButton').hide();
				</script>
				<%
					}
				%>
			</table>

		</div>

		<%
			d = new CrmContractObj();
			dataList = domainInstance.findContractList();
		%>
		<div id="contract_info_div">
			<table class="table table-bordered table-striped" align="center" width="100%">
				<thead>
					<tr>
						<th><%=d.getPropertyCnName("contract_name")%></th>
						<th><%=d.getPropertyCnName("contract_sign_time")%></th>
						<th><%=d.getPropertyCnName("contract_price")%></th>
						<th><%=d.getPropertyCnName("bill_money_total")%></th>
						<th><%=d.getPropertyCnName("gather_money_total")%></th>
						<th><%=d.getPropertyCnName("is_finished")%></th>
						<th><%=d.getPropertyCnName("record_account")%></th>
						<th><%=d.getPropertyCnName("record_time")%></th>
						<th>
							详情
						</th>
					</tr>
				</thead>
				<%
					for (int i = 0; i < dataList.size(); i++)
					{
						CrmContractObj o = (CrmContractObj) dataList.get(i);
				%>
				<tr>
					<td>
						<%=StringUtil.getNotEmptyStr(o.getContract_name())%></td>
					<td><%=TimeUtil.date2str(o.getContract_sign_time(), "yyyy-MM-dd")%></td>
					<td><%=StringUtil.formatDouble(o.getContract_price(), 2)%></td>
					<td><%=StringUtil.formatDouble(o.getBill_money_total(), 2)%></td>
					<td><%=StringUtil.formatDouble(o.getGather_money_total(), 2)%></td>
					<td><%=DictionaryUtil.getDictValueByDictKey("是否字典", o.getIs_finished())%></td>
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
				<script type="text/javascript">
					$('#createCrontractButton').hide();
				</script>
				<%
					}
				%>
			</table>
		</div>

		<script type="text/javascript">
			// 应用tab页
			useAsTab("tab_table","800");
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
