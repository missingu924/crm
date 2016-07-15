<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmManagementActivityObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%> 
<% 
	// 当前上下文路径  
	String contextPath = request.getContextPath();  
  
	// 该功能对象实例  
	CrmManagementActivityObj domainInstance = (CrmManagementActivityObj) request.getAttribute("domainInstance");  
	// 该功能路径  
	String basePath = domainInstance.getBasePath();  
	// 是否商机跟进活动
	boolean isOpportunityActivity = domainInstance.isOpportunityActivity();
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
						<%=domainInstance.getPropertyCnName("customer_id") %>:					</td> 
					<td colspan="3"> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCustomer/Servlet?method=detail4this&id=<%=domainInstance.getCustomer_id()%>')"><%=DictionaryUtil.getDictValueByDictKey("客户字典", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id()+"", ""))%></a>  
											</td> 
			    </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("activity_type") %>:					</td> 
					<td colspan="3"> 
						<%=DictionaryUtil.getDictValueByDictKey("经营活动类型字典", StringUtil.getNotEmptyStr(domainInstance.getActivity_type(), ""))%> 
										</td> 
			    </tr>
			    <%if(isOpportunityActivity){ %>
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("commercial_oppotunity_id") %>:					</td> 
					<td colspan="3"> 
						<a href="#" onClick="openBigModalDialog('<%=contextPath%>/CrmCommercialOpportunity/Servlet?method=detail4this&id=<%=domainInstance.getCommercial_oppotunity_id()%>')"><%=DictionaryUtil.getDictValueByDictKey("商机字典",  StringUtil.getNotEmptyStr(domainInstance.getCommercial_oppotunity_id(), ""))%></a> 
										</td> 
			    </tr> 
			    <tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("sale_stage_code") %>:					</td> 
					<td colspan="3"> 
						<%=DictionaryUtil.getDictValueByDictKey("销售阶段字典",  StringUtil.getNotEmptyStr(domainInstance.getSale_stage_code(), ""))%> 
										</td> 
			    </tr> 
			    <%} %>
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("activity_date") %>:					</td> 
					<td colspan="3"> 
						<%=TimeUtil.date2str(domainInstance.getActivity_date(),"yyyy-MM-dd")%> 
									</td> 
			    </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("participant") %>:					</td> 
					<td colspan="3"> 
						<%=DictionaryUtil.getDictValueByDictKey("账号字典",StringUtil.getNotEmptyStr(domainInstance.getParticipant()))%>
						</td> 
			    </tr> 
				
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("activity_content") %>:					</td> 
					<td colspan="3"> 
						<%=StringUtil.getNotEmptyStr(domainInstance.getActivity_content(),"")%> 
									</td> 
			    </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("next_step") %>:					</td> 
					<td colspan="3"> 
						<%=StringUtil.getNotEmptyStr(domainInstance.getNext_step(),"")%>
					</td> 
			    </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("record_account") %>:					</td> 
					<td> 
						<%=DictionaryUtil.getDictValueByDictKey("账号字典",domainInstance.getRecord_account())%>
						</td> 
				    <td><%=domainInstance.getPropertyCnName("record_time") %>: </td>
				    <td><%=TimeUtil.date2str(domainInstance.getRecord_time())%></td>
				</tr> 
		</table> 
		 
		<!-- 工具栏 --> 
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/> 
	</body> 
</html> 
