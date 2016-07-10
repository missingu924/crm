<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmCustomerObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.crm.obj.CrmCommercialOpportunityObj"%>
<%@page import="com.wuyg.common.dao.BaseDbObj"%>
<%@page import="com.crm.obj.CrmContractObj"%>
<%@page import="com.crm.obj.CrmBillObj"%>
<%@page import="com.crm.obj.CrmManagementActivityObj"%>
<%
	// 当前上下文路径  
	String contextPath = request.getContextPath();

	// 该功能对象实例  
	CrmCustomerObj domainInstance = (CrmCustomerObj) request.getAttribute("domainInstance");
	// 该功能路径  
	String basePath = domainInstance.getBasePath();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />
		<title><%=domainInstance.getCnName()%>详情</title>
		<link href="../css/global.css" rel="stylesheet" type="text/css" />
		<link href="../css/table.css" rel="stylesheet" type="text/css" />
		<script src="../js/jquery-2.0.3.min.js"></script>
		<script src="../js/utils.js"></script>
	</head>
	<body>
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
				<td>
					<%=domainInstance.getPropertyCnName("customer_full_name")%>:
				</td>
				<td colspan="3">
					<%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_full_name())%>
				</td>
			</tr>
			<tr>
				<td>
					<%=domainInstance.getPropertyCnName("customer_type_code")%>:
				</td>
				<td>
					<%=DictionaryUtil.getDictValueByDictKey("客户分类字典", StringUtil.getNotEmptyStr(domainInstance.getCustomer_type_code(), ""))%>
				</td>
				<td><%=domainInstance.getPropertyCnName("customer_is_deal")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("是否字典", StringUtil.getNotEmptyStr(domainInstance.getCustomer_is_deal(), ""))%>
				</td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("customer_region_code")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("区域字典", StringUtil.getNotEmptyStr(domainInstance.getCustomer_region_code(), ""))%>
				</td>
				<td><%=domainInstance.getPropertyCnName("customer_address")%>:
				</td>
				<td>
					<%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_address(), "")%>
				</td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("customer_manager_account")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", StringUtil.getNotEmptyStr(domainInstance.getCustomer_manager_account(), ""))%>
				</td>
				<td><%=domainInstance.getPropertyCnName("service_engineer_account")%>:
				</td>
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典", StringUtil.getNotEmptyStr(domainInstance.getService_engineer_account(), ""))%>
				</td>
			</tr>
			<tr>
				<td><%=domainInstance.getPropertyCnName("record_account")%>:
				</td>
				<td>
					<%=StringUtil.getNotEmptyStr(domainInstance.getRecord_account())%>
				</td>
				<td><%=domainInstance.getPropertyCnName("record_time")%>:
				</td>
				<td>
					<%=TimeUtil.date2str(domainInstance.getRecord_time())%>
				</td>
			</tr>
		</table>

		<table id="tab_table" width="800" align="center" class="sub_title_table">
			<tr>
				<td div_id="product_info_div" style="width: 80px">
					产品信息
				</td>
				<td div_id="service_info_div" style="width: 80px">
					服务信息
				</td>
				<td div_id="bill_info_div" style="width: 80px">
					开票信息
				</td>
				<td></td>
			</tr>
		</table>

		<div id="product_info_div">
			<table width="800" align="center" class="detail_table detail_table-bordered">
				<tr>
					<td><%=domainInstance.getPropertyCnName("product_code")%>:
					</td>
					<td><%=DictionaryUtil.getDictValueByDictKey("产品字典", StringUtil.getNotEmptyStr(domainInstance.getProduct_code(), ""))%>
					</td>
					<td><%=domainInstance.getPropertyCnName("product_version_code")%>:
					</td>
					<td><%=DictionaryUtil.getDictValueByDictKey("产品版本字典", StringUtil.getNotEmptyStr(domainInstance.getProduct_version_code(), ""))%>
					</td>
					<td><%=domainInstance.getPropertyCnName("softdog")%>:
					</td>
					<td>
						<%=StringUtil.getNotEmptyStr(domainInstance.getSoftdog(), "")%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("byproduct")%>:
					</td>
					<td colspan="5">
						<%=StringUtil.getNotEmptyStr(domainInstance.getByproduct(), "")%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("module")%>:
					</td>
					<td colspan="5">
						<%=StringUtil.getNotEmptyStr(domainInstance.getModule(), "")%>
					</td>
				</tr>
			</table>
		</div>

		<div id="bill_info_div">
			<table width="800" align="center" class="detail_table detail_table-bordered">
				<tr>
					<td><%=domainInstance.getPropertyCnName("bill_title")%>:
					</td>
					<td colspan="3">
						<%=StringUtil.getNotEmptyStr(domainInstance.getBill_title(), "")%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("bill_info")%>:
					</td>
					<td colspan="3">
						<%=StringUtil.getNotEmptyStr(domainInstance.getBill_info(), "")%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("comment")%>:
					</td>
					<td colspan="3">
						<%=StringUtil.getNotEmptyStr(domainInstance.getComment(), "")%>
					</td>
				</tr>
			</table>
		</div>

		<div id="service_info_div">
			<table width="800" align="center" class="detail_table detail_table-bordered">
				<tr>
					<td><%=domainInstance.getPropertyCnName("service_charge_peryear")%>:
					</td>
					<td>
						<%=StringUtil.getNotEmptyStr(domainInstance.getService_charge_peryear(), "")%>
					</td>
					<td><%=domainInstance.getPropertyCnName("service_due_date")%>:
					</td>
					<td>
						<%=TimeUtil.date2str(domainInstance.getService_due_date(), "yyyy-MM-dd")%>
					</td>
				</tr>
			</table>
		</div>
		
		<table id="releated_info_tab_table" width="800" align="center" class="sub_title_table">
			<tr>
				<td div_id="opportunity_info_div" style="width: 80px">
					商机记录
				</td>
				<td div_id="contract_info_div" style="width: 80px">
					合同记录
				</td>
				<td div_id="bill_gather_info_div" style="width: 100px">
					开票收款记录
				</td>
				<td div_id="activity_info_div" style="width: 100px">
					经营活动记录
				</td>
				<td></td>
			</tr>
		</table>
		
		<%
			BaseDbObj d = new CrmCommercialOpportunityObj();
			List dataList = domainInstance.findCommericialOpportunityList();
		%>
		<div id="opportunity_info_div">
		<table class="table table-bordered table-striped" align="center" width="800"> 
				<thead> 
					<tr>
						<th><%=d.getPropertyCnName("opportunity_name") %></th> 
						<th><%=d.getPropertyCnName("management_type_code") %></th> 
						<th><%=d.getPropertyCnName("sale_stage_code") %></th> 
						<th><%=d.getPropertyCnName("target_price") %></th> 
						<th><%=d.getPropertyCnName("estimate_sign_time") %></th> 
						<th><%=d.getPropertyCnName("management_account") %></th> 
						<th><%=d.getPropertyCnName("customer_request") %></th> 
						<th><%=d.getPropertyCnName("next_step") %></th> 
						<th><%=d.getPropertyCnName("record_account") %></th> 
						<th><%=d.getPropertyCnName("record_time") %></th>
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < dataList.size(); i++) 
						{ 
							CrmCommercialOpportunityObj o = (CrmCommercialOpportunityObj) dataList.get(i); 
				%> 
				<tr> 
					<td> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=d.getBasePath()%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getOpportunity_name())%> </a> 
					</td>
					<td><%=DictionaryUtil.getDictValueByDictKey("经营类型字典",o.getManagement_type_code())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("销售阶段字典",o.getSale_stage_code())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getTarget_price())%></td> 
					<td><%=TimeUtil.date2str(o.getEstimate_sign_time(),"yyyy-MM-dd")%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getManagement_account())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getCustomer_request())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getNext_step())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getRecord_account())%></td> 
					<td><%=TimeUtil.date2str(o.getRecord_time(),"yyyy-MM-dd HH:mm:ss")%></td> 
				</tr> 
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
		<table class="table table-bordered table-striped" align="center" width="800"> 
				<thead> 
					<tr>
						<th><%=d.getPropertyCnName("contract_name") %></th> 
						<th><%=d.getPropertyCnName("commerical_opportunity_id") %></th> 
						<th><%=d.getPropertyCnName("contract_sign_time") %></th> 
						<th><%=d.getPropertyCnName("contract_price") %></th> 
						<th><%=d.getPropertyCnName("bill_money_total") %></th> 
						<th><%=d.getPropertyCnName("gather_money_total") %></th> 
						<th><%=d.getPropertyCnName("is_finished") %></th> 
						<th><%=d.getPropertyCnName("record_account") %></th> 
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < dataList.size(); i++) 
						{ 
							CrmContractObj o = (CrmContractObj) dataList.get(i); 
				%> 
				<tr> 
					<td> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=d.getBasePath()%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getContract_name())%> </a> 
					</td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("商机字典",o.getCommerical_opportunity_id()+"")%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContract_sign_time())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getContract_price())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getBill_money_total())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getGather_money_total())%></td> 
					<td><%=DictionaryUtil.getDictValueByDictKey("是否字典",o.getIs_finished())%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getRecord_account())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getRecord_time())%></td> 
				</tr> 
				<% 
					} 
				%> 
			</table> 
		</div>
		
		<%
			 d = new CrmBillObj();
			 dataList = domainInstance.findBillList();
		%>
		<div id="bill_gather_info_div">
		<table class="table table-bordered table-striped" align="center" width="800"> 
				<thead> 
					<tr>
						<th><%=d.getPropertyCnName("contract_id") %></th> 
						<th><%=d.getPropertyCnName("bill_money") %></th> 
						<th><%=d.getPropertyCnName("gather_money") %></th> 
						<th><%=d.getPropertyCnName("record_account") %></th> 
						<th><%=d.getPropertyCnName("record_time") %></th> 
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < dataList.size(); i++) 
						{ 
							CrmBillObj o = (CrmBillObj) dataList.get(i); 
				%> 
				<tr>
					<td><%=DictionaryUtil.getDictValueByDictKey("合同字典",o.getContract_id()+"")%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getBill_money())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getGather_money())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getRecord_account())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getRecord_time())%></td> 
				</tr> 
				<% 
					} 
				%> 
			</table> 
		</div>
		
		<%
			 d = new CrmManagementActivityObj();
			 dataList = domainInstance.findActivityList();
		%>
		<div id="activity_info_div">
		<table class="table table-bordered table-striped" align="center" width="800"> 
				<thead> 
					<tr>
						<th><%=d.getPropertyCnName("id") %></th> 
						<th><%=d.getPropertyCnName("activity_type") %></th> 
						<th><%=d.getPropertyCnName("commercial_oppotunity_id") %></th> 
						<th><%=d.getPropertyCnName("record_account") %></th> 
						<th><%=d.getPropertyCnName("participant") %></th> 
						<th><%=d.getPropertyCnName("activity_date") %></th> 
						<th><%=d.getPropertyCnName("activity_content") %></th> 
						<th><%=d.getPropertyCnName("next_step") %></th>
					</tr> 
				</thead> 
				<% 
					for (int i = 0; i < dataList.size(); i++) 
						{ 
							CrmManagementActivityObj o = (CrmManagementActivityObj) dataList.get(i); 
				%> 
				<tr>
					<td> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/<%=d.getBasePath()%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"> <%=StringUtil.getNotEmptyStr(o.getKeyValue())%> </a> 
					</td>
					<td><%=DictionaryUtil.getDictValueByDictKey("经营活动类型字典",o.getActivity_type())%></td>  
					<td><%=DictionaryUtil.getDictValueByDictKey("商机字典",o.getCommercial_oppotunity_id()+"")%></td>  
					<td><%=StringUtil.getNotEmptyStr(o.getRecord_account())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getParticipant())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getActivity_date())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getActivity_content())%></td> 
					<td><%=StringUtil.getNotEmptyStr(o.getNext_step())%></td> 
				</tr> 
				<% 
					} 
				%> 
			</table> 
		</div>
		<!-- 工具栏 -->
		<jsp:include page="../ToolBar/detail_toolbar.jsp" />


		<script type="text/javascript">
		// 应用tab页
		useAsTab("tab_table");
		
		useAsTab("releated_info_tab_table");
		</script>
</html>
