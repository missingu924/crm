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
<% 
	// 当前上下文路径  
	String contextPath = request.getContextPath();  
  
	// 该功能对象实例  
	CrmContractObj domainInstance = (CrmContractObj) request.getAttribute("domainInstance");  
	// 该功能路径  
	String basePath = domainInstance.getBasePath();  
%> 
<html> 
	<head> 
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />		<title><%=domainInstance.getCnName()%>详情</title> 
		<link href="../css/global.css" rel="stylesheet" type="text/css" /> 
		<link href="../css/table.css" rel="stylesheet" type="text/css" /> 
		<script src="../js/jquery-2.0.3.min.js"></script> 
		<script src="../js/utils.js"></script> 
	</head> 
	<body> 
	
		<!-- 操作栏 --> 
		<table width="800" align="center" class="top_tools_table">
          <tr>
            <td><a href='<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>'>
              <input name="button" type="button" class="button button_modify" value="修改"/>
              </a>
              	<input name="deleteButton" type="button" class="button button_delete" value="删除" onClick="deleteIt('<%=contextPath%>/<%=basePath%>/Servlet?method=delete4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>')">
                <%if("0".equals(domainInstance.getIs_finished())){ %>
                <input name="billButton" type="button" class="button button_add" onClick="openBigModalDialog('<%=contextPath%>/CrmBill/Servlet?method=preModify4this&id=-1&customer_id=<%=domainInstance.getCustomer_id() %>&commerical_opportunity_id=<%=domainInstance.getCommercial_oppotunity_id() %>&contract_id=<%=domainInstance.getKeyValue() %>')" value="开票收款"/>
           		<%} %>
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
		<table width="800" align="center" class="detail_table detail_table-bordered "> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("contract_name") %>:				</td> 
				<td colspan="5"><%=StringUtil.getNotEmptyStr(domainInstance.getContract_name())%></td> 
		    </tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("customer_id") %>:				</td> 
				<td colspan="5"><a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCustomer/Servlet?method=detail4this&id=<%=domainInstance.getCustomer_id()%>')"><%=DictionaryUtil.getDictValueByDictKey("客户字典",domainInstance.getCustomer_id()+"")%></a></td> 
		    </tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("commercial_oppotunity_id") %>:				</td> 
				<td colspan="5"><a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCommercialOpportunity/Servlet?method=detail4this&id=<%=domainInstance.getCommercial_oppotunity_id()%>')"><%=DictionaryUtil.getDictValueByDictKey("商机字典",domainInstance.getCommercial_oppotunity_id()+"")%></a></td> 
		    </tr>
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("contract_sign_time") %>:				</td> 
				<td><%=TimeUtil.date2str(domainInstance.getContract_sign_time(),"yyyy-MM-dd")%></td> 
			    <td><%=domainInstance.getPropertyCnName("is_finished") %>: </td>
			    <td><%=DictionaryUtil.getDictValueByDictKey("是否字典",domainInstance.getIs_finished())%></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			</tr> 
			<tr> 
				<td><%=domainInstance.getPropertyCnName("contract_price") %>: </td> 
				<td><%=StringUtil.formatDouble(domainInstance.getContract_price(),2)%></td> 
			    <td><%=domainInstance.getPropertyCnName("gather_money_total") %>: </td>
			    <td><%=StringUtil.formatDouble(domainInstance.getGather_money_total(),2)%>&nbsp;<font color="green">(余款<%=StringUtil.formatDouble(domainInstance.getSpare_money(),2) %>)</font></td>
			    <td><%=domainInstance.getPropertyCnName("bill_money_total") %>: </td>
			    <td><%=StringUtil.formatDouble(domainInstance.getBill_money_total(),2)%></td>
			</tr> 
			<tr> 
				<td> 
					<%=domainInstance.getPropertyCnName("record_account") %>:				</td> 
				<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",domainInstance.getRecord_account())%></td> 
			    <td><%=domainInstance.getPropertyCnName("record_time") %>: </td>
			    <td><%=TimeUtil.date2str(domainInstance.getRecord_time())%></td>
			    <td>&nbsp;</td>
			    <td>&nbsp;</td>
			</tr> 
		</table> 
		
		<table id="tab_table" width="800" align="center" class="sub_title_table">
			<tr>
				<td div_id="bill_gather_info_div" style="width: 80px">
					开票信息
				</td>
				<td></td>
			</tr>
		</table>
		<%
			BaseDbObj d = new CrmBillObj();
			List dataList = domainInstance.findBillList();
		%>
		<div id="bill_gather_info_div">
		<table class="table table-bordered table-striped" align="center" width="100%"> 
				<thead> 
					<tr>
						<th><%=d.getPropertyCnName("record_account") %></th> 
						<th><%=d.getPropertyCnName("record_time") %></th> 
						<th><%=d.getPropertyCnName("bill_money") %></th> 
						<th><%=d.getPropertyCnName("gather_money") %></th> 
						<th>详情</th> 
					</tr> 
				</thead> 
				<% 
					double billTotal = 0, gatherTotal = 0;
					for (int i = 0; i < dataList.size(); i++) 
						{ 
							CrmBillObj o = (CrmBillObj) dataList.get(i); 
							billTotal+=o.getBill_money().doubleValue();
							gatherTotal+=o.getGather_money().doubleValue();
				%> 
				<tr>
					<td><%=DictionaryUtil.getDictValueByDictKey("账号字典",o.getRecord_account())%></td> 
					<td><%=TimeUtil.date2str(o.getRecord_time())%></td> 
					<td style="text-align:right"><%=StringUtil.formatDouble(o.getBill_money(),2)%></td> 
					<td style="text-align:right"><%=StringUtil.formatDouble(o.getGather_money(),2)%></td>
					<td style="text-align:center"><input type="button"  class="button button_detail" onClick="openBigModalDialog('<%=contextPath%>/<%=d.getBasePath()%>/Servlet?method=detail4this&<%=o.findKeyColumnName()%>=<%=o.getKeyValue()%>')"></td>	
				</tr> 
				<% 
					}
					if(dataList.size()>0){
				%> 
				<tr style="color:blue">
					<td colspan="2" style="text-align:center">合计</td> 
					<td style="text-align:right"><%=StringUtil.formatDouble(billTotal,2)%></td> 
					<td style="text-align:right"><%=StringUtil.formatDouble(gatherTotal,2)%></td> 
					<td></td>
				</tr> 
				<%} %>
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
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/> 
	</body> 
</html> 
