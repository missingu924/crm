<!DOCTYPE html> 
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%> 
<!-- 引入类 -->  
<%@page import="java.util.List"%> 
<%@page import="com.wuyg.common.util.StringUtil"%> 
<%@page import="com.wuyg.dictionary.DictionaryUtil"%> 
<%@page import="com.crm.obj.CrmContactObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%> 
<% 
	// 当前上下文路径  
	String contextPath = request.getContextPath();  
  
	// 该功能对象实例  
	CrmContactObj domainInstance = (CrmContactObj) request.getAttribute("domainInstance");  
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
		<table width="90%" align="center"  class="top_tools_table">
          <tr>
            <td><a href='<%=contextPath%>/<%=basePath%>/Servlet?method=preModify4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>'>
              <input name="modifyOpportunityButton" type="button" class="button button_modify" value="修改"/>
              </a>
              	<input name="deleteButton" type="button" class="button button_delete" value="删除" onClick="deleteIt('<%=contextPath%>/<%=basePath%>/Servlet?method=delete4this&<%=domainInstance.findKeyColumnName()%>=<%=domainInstance.getKeyValue()%>')">
            </td>
          </tr>
        </table>
		<!-- 表格标题 --> 
		<table width="90%" align="center" class="title_table"> 
			<tr> 
				<td> 
					<%=domainInstance.getCnName()%>信息 
				</td> 
			</tr> 
		</table> 
		<!-- 详细信息 --> 
		<table width="90%" align="center" class="detail_table detail_table-bordered detail_table-striped"> 
			<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("customer_id") %>:					</td> 
					<td colspan="3"> 
						<%=DictionaryUtil.getDictValueByDictKey("客户字典", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""))%> 
						</td> 
			    </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_name") %>:					</td> 
					<td colspan="3"> 
						<%=StringUtil.getNotEmptyStr(domainInstance.getContact_name(),"")%> 
										</td> 
			    </tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_sex") %>:					</td> 
					<td> 
						<%=DictionaryUtil.getDictValueByDictKey("性别字典", StringUtil.getNotEmptyStr(domainInstance.getContact_sex(), ""))%>					</td> 
				    <td><%=domainInstance.getPropertyCnName("contact_birthday") %>: </td>
				    <td><%=StringUtil.getNotEmptyStr(domainInstance.getContact_birthday(),"")%></td>
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_telephone") %>:					</td> 
					<td> 
						<%=StringUtil.getNotEmptyStr(domainInstance.getContact_telephone(),"")%>					</td> 
				    <td><%=domainInstance.getPropertyCnName("contact_email") %>: </td>
				    <td><%=StringUtil.getNotEmptyStr(domainInstance.getContact_email(),"")%></td>
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_qq") %>:					</td> 
					<td> 
						<%=StringUtil.getNotEmptyStr(domainInstance.getContact_qq(),"")%>
					</td> 
				    <td><%=domainInstance.getPropertyCnName("contact_weixin") %>: </td>
				    <td><%=StringUtil.getNotEmptyStr(domainInstance.getContact_weixin(),"")%></td>
				</tr> 
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("contact_hobby") %>:					</td> 
					<td colspan="3"> 
						<%=StringUtil.getNotEmptyStr(domainInstance.getContact_hobby(),"")%>
					</td>
				</tr>
				<tr> 
					<td> 
						<%=domainInstance.getPropertyCnName("record_account") %>:					</td> 
					<td> 
						<%=DictionaryUtil.getDictValueByDictKey("账号字典",domainInstance.getRecord_account())%></td> 
				    <td><%=domainInstance.getPropertyCnName("record_time") %>: </td>
				    <td><%=StringUtil.getNotEmptyStr(TimeUtil.date2str(domainInstance.getRecord_time()), TimeUtil.nowTime2str())%></td>
				</tr> 
		</table> 
		 
		<!-- 工具栏 --> 
		<jsp:include page="../ToolBar/detail_toolbar.jsp"/> 
	</body> 
</html> 
