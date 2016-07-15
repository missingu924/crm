<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmCustomerObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.dao.BaseDbObj"%>
<%@page import="com.crm.obj.CrmContactObj"%>
<!-- 基本信息 -->
<%
	// 用户信息
	AuthUserObj user = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);

	// 上下文路径 
	String contextPath = request.getContextPath();

	// 对象实例 
	CrmCustomerObj domainInstance = new CrmCustomerObj();
	// 该功能基本路径 
	String basePath = domainInstance.getBasePath();

	// 如果是修改，则获取对象信息 
	Object domainInstanceObj = request.getAttribute("domainInstance");
	if (domainInstanceObj != null)
	{
		domainInstance = (CrmCustomerObj) domainInstanceObj;
	}

	// 是否是修改 
	boolean isModify = domainInstance.getKeyValue() > 0;
	// 唯一性检查用的字段 
	String keyCol = "customer_full_name";
%>
<html>
	<head>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no" />
		<title><%=isModify ? "修改" + domainInstance.getCnName() : "增加" + domainInstance.getCnName()%></title>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
		<link href="../css/table.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
		<script> 
		//  新增或修改 
		function addOrModify() 
		{	 
				// 做必要的检查 
		if(!checkNull("id","<%=domainInstance.getPropertyCnName("id")%>")) return false; 
		if(!checkNull("customer_full_name","<%=domainInstance.getPropertyCnName("customer_full_name")%>")) return false; 
		if(!checkNull("customer_type_code","<%=domainInstance.getPropertyCnName("customer_type_code")%>")) return false; 
		if(!checkNull("customer_region_code","<%=domainInstance.getPropertyCnName("customer_region_code")%>")) return false; 
		if(!checkNull("customer_address","<%=domainInstance.getPropertyCnName("customer_address")%>")) return false; 
		if(!checkNull("customer_is_deal","<%=domainInstance.getPropertyCnName("customer_is_deal")%>")) return false; 
		if(!checkNull("customer_manager_account","<%=domainInstance.getPropertyCnName("customer_manager_account")%>")) return false; 
		if(!checkNull("service_engineer_account","<%=domainInstance.getPropertyCnName("service_engineer_account")%>")) return false; 
					 
			// 修改 
			if("true"=="<%=isModify%>") 
			{ 
				submit(); 
			} 
			// 新增 
			else 
			{ 
					// 新增时检查唯一性 
					$.post( 
					encodeURI("Servlet?method=checkId4this&isFromUrl=true&id=0&<%=keyCol%>="+$("#<%=keyCol%>").val()),  
					{Action:"post"},  
					function (data, textStatus){ 
						this; 
						if(data=="true")  
						{ 
							alert("该<%=domainInstance.getPropertyCnName(keyCol)%>已录入系统");  
							return false; 
						} 
						else 
						{ 
							submit(); 
						} 
					}); 
				}; 
		} 
		 
		// 提交保存或修改 
		function submit() 
		{ 
					$("#addOrModifyForm").submit(); 
		} 
		</script>
	</head>
	<body>
		<form name="addOrModifyForm" id="addOrModifyForm" action="<%=contextPath%>/<%=basePath%>/Servlet?method=addOrModify4this" method="post">
			<!-- 表格标题 -->
			<table width="800" align="center" class="title_table">
				<tr>
					<td>
						<%=isModify ? "修改" : "增加"%><%=domainInstance.getCnName()%>
					</td>
				</tr>
			</table>

			<!-- 详细信息 -->
			<table width="800" align="center" class="detail_table detail_table-bordered">
				<input type="hidden" id="<%=domainInstance.findKeyColumnName()%>" name="<%=domainInstance.findKeyColumnName()%>" value="<%=domainInstance.getKeyValue()%>">
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("customer_full_name")%>:
					</td>
					<td colspan="3">
						<input name="customer_full_name" type="text" id="customer_full_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_full_name(), "")%>" size="70" <%=isModify ? "readOnly" : ""%>>
						<font color="red">*</font>
						<font color="red"><%=isModify ? "(不可修改)" : "(不能重复)"%></font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("customer_type_code")%>:
					</td>
					<td>
						<%=DictionaryUtil.getSelectHtml("客户分类字典", "customer_type_code", StringUtil.getNotEmptyStr(domainInstance.getCustomer_type_code(), ""))%>
						<font color="red">*</font>
					</td>
					<td><%=domainInstance.getPropertyCnName("customer_is_deal")%>:
					</td>
					<td><%=DictionaryUtil.getSelectHtml("是否字典", "customer_is_deal", StringUtil.getNotEmptyStr(domainInstance.getCustomer_is_deal(), ""))%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("customer_region_code")%>:
					</td>
					<td><%=DictionaryUtil.getSelectHtml("区域字典", "customer_region_code", StringUtil.getNotEmptyStr(domainInstance.getCustomer_region_code(), ""))%>
						<font color="red">*</font>
					</td>
					<td><%=domainInstance.getPropertyCnName("customer_address")%>:
					</td>
					<td>
						<input name="customer_address" type="text" id="customer_address" value="<%=StringUtil.getNotEmptyStr(domainInstance.getCustomer_address(), "")%>" size="50">
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("customer_manager_account")%>:
					</td>
					<td><%=DictionaryUtil.getSelectHtml("账号字典", "customer_manager_account", StringUtil.getNotEmptyStr(domainInstance.getCustomer_manager_account(), ""))%>
						<font color="red">*</font>
					</td>
					<td><%=domainInstance.getPropertyCnName("service_engineer_account")%>:
					</td>
					<td><%=DictionaryUtil.getSelectHtml("账号字典", "service_engineer_account", StringUtil.getNotEmptyStr(domainInstance.getService_engineer_account(), ""))%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("comment")%>:
					</td>
					<td colspan="3">
						<textarea name="comment" cols="53" rows="2" id="comment"><%=StringUtil.getNotEmptyStr(domainInstance.getComment(), "")%></textarea>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("record_account")%>:
					</td>
					<td>
						<input type="text" readOnly value="<%=DictionaryUtil.getDictValueByDictKey("账号字典",StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), user.getAccount()))%>" size="12">
						<input name="record_account" type="hidden" id="record_account" value="<%=StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), user.getAccount())%>" size="20">					 
				    </td>
					<td><%=domainInstance.getPropertyCnName("record_time")%>:
					</td>
					<td>
						<input name="record_time" type="text" id="record_time" value="<%=TimeUtil.nowTime2str()%>" size="20">
					</td>
				</tr>
			</table>

			<table id="tab_table" width="800" align="center" class="sub_title_table">
				<tr>
					<td div_id="contact_info_div" style="width: 80px">
						联系人
					</td>
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

			<%
				BaseDbObj d = new CrmContactObj();
				List dataList = domainInstance.findContactList();
			%>
			<div id="contact_info_div">
				<table id="contact_table" class="table table-bordered table-striped" align="center" width="100%">
					<thead>
						<tr>
							<th><%=d.getPropertyCnName("contact_name")%></th>
							<th><%=d.getPropertyCnName("contact_sex")%></th>
							<th><%=d.getPropertyCnName("contact_birthday")%></th>
							<th><%=d.getPropertyCnName("contact_telephone")%></th>
							<th><%=d.getPropertyCnName("contact_email")%></th>
							<th>
								操作
							</th>
						</tr>
					</thead>
					<%
						for (int i = 0; i < dataList.size(); i++)
							{
								CrmContactObj o = (CrmContactObj) dataList.get(i);
					%>
					<tr>
						<td>
							<input name="contact_name" type="text" id="contact_name" value="<%=StringUtil.getNotEmptyStr(o.getContact_name(), "")%>" size="15">
						</td>
						<td>
							<%=DictionaryUtil.getSelectHtml("性别字典", "contact_sex", StringUtil.getNotEmptyStr(o.getContact_sex(), ""))%>
						</td>
						<td>
							<input name="contact_birthday" type="text" id="contact_birthday" value="<%=TimeUtil.date2str(o.getContact_birthday(), "yyyy-MM-dd")%>" size="15" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
						</td>
						<td>
							<input name="contact_telephone" type="text" id="contact_telephone" value="<%=StringUtil.getNotEmptyStr(o.getContact_telephone(), "")%>" size="15">
						</td>
						<td>
							<input name="contact_email" type="text" id="contact_email" value="<%=StringUtil.getNotEmptyStr(o.getContact_email(), "")%>" size="20">
						</td>
						<td>
							<input type="button" class="button button_delete" title="删除" contact_id="<%=o.getId() %>" onClick="delContact(this)" />
						</td>
					</tr>
					<%
						}
					%>
					<tr id="contact_template_tr" style="display:<%=dataList.size()>0?"none":"" %>">
						<td>
							<input name="contact_name" type="text" id="contact_name" value="" size="15">
						</td>
						<td>
							<%=DictionaryUtil.getSelectHtml("性别字典", "contact_sex", "")%>
						</td>
						<td>
							<input name="contact_birthday" type="text" id="contact_birthday" value="" size="15" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
						</td>
						<td>
							<input name="contact_telephone" type="text" id="contact_telephone" value="" size="15">
						</td>
						<td>
							<input name="contact_email" type="text" id="contact_email" value="" size="20">
						</td>
						<td>
							<input type="button" class="button button_delete" title="删除" onClick="delContact(this)" />
						</td>
					</tr>
				</table>
				<div style="text-align: right">
					<input name="addButton" type="button" class="button button_add_square" value="增加联系人" onClick="addContact()" />
				</div>
			</div>

			<div id="product_info_div">
				<table width="100%" align="center" class="detail_table detail_table-bordered">
					<tr>
						<td><%=domainInstance.getPropertyCnName("product_code")%>:
						</td>
						<td><%=DictionaryUtil.getSelectHtml("产品字典", "product_code", StringUtil.getNotEmptyStr(domainInstance.getProduct_code(), ""))%>
						</td>
						<td><%=domainInstance.getPropertyCnName("product_version_code")%>:
						</td>
						<td><%=DictionaryUtil.getSelectHtml("产品版本字典", "product_version_code", StringUtil.getNotEmptyStr(domainInstance.getProduct_version_code(), ""))%>
						</td>
						<td><%=domainInstance.getPropertyCnName("softdog")%>:
						</td>
						<td>
							<input name="softdog" type="text" id="softdog" value="<%=StringUtil.getNotEmptyStr(domainInstance.getSoftdog(), "")%>" size="20">
						</td>
					</tr>
					<tr>
						<td><%=domainInstance.getPropertyCnName("byproduct")%>:
						</td>
						<td colspan="5">
							<textarea name="byproduct" cols="50" rows="2" id="byproduct"><%=StringUtil.getNotEmptyStr(domainInstance.getByproduct(), "")%></textarea>
						</td>
					</tr>
					<tr>
						<td><%=domainInstance.getPropertyCnName("module")%>:
						</td>
						<td colspan="5">
							<textarea name="module" cols="50" rows="2" id="module"><%=StringUtil.getNotEmptyStr(domainInstance.getModule(), "")%></textarea>
						</td>
					</tr>
				</table>
			</div>

			<div id="bill_info_div">
				<table width="100%" align="center" class="detail_table detail_table-bordered">
					<tr>
						<td><%=domainInstance.getPropertyCnName("bill_title")%>:
						</td>
						<td colspan="3">
							<input name="bill_title" type="text" id="bill_title" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_title(), "")%>" size="70">
						</td>
					</tr>
					<tr>
						<td><%=domainInstance.getPropertyCnName("bill_info")%>:
						</td>
						<td colspan="3">
							<textarea name="bill_info" cols="50" rows="2" id="bill_info"><%=StringUtil.getNotEmptyStr(domainInstance.getBill_info(), "")%></textarea>
						</td>
					</tr>
				</table>
			</div>

			<div id="service_info_div">
				<table width="100%" align="center" class="detail_table detail_table-bordered">
					<tr>
						<td><%=domainInstance.getPropertyCnName("service_charge_peryear")%>:
						</td>
						<td>
							<input name="service_charge_peryear" type="text" id="service_charge_peryear" value="<%=StringUtil.getNotEmptyStr(domainInstance.getService_charge_peryear(), "")%>" size="20">
						</td>
						<td><%=domainInstance.getPropertyCnName("service_due_date")%>:
						</td>
						<td>
							<input name="service_due_date" type="text" id="service_due_date" value="<%=TimeUtil.date2str(domainInstance.getService_due_date(), "yyyy-MM-dd")%>" size="20" onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
						</td>
					</tr>
				</table>
			</div>
			<!-- 工具栏 -->
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" />
		</form>

		<script>
		// 应用tab页
		useAsTab("tab_table",800,200);
		
		// 增加联系人
		var contact_template_tr = "<tr>"+$("#contact_template_tr").html()+"</tr>";
		function addContact()
		{
			$("#contact_table").append(contact_template_tr);
		}
		
		// 删除联系人
		function delContact(delButton)
		{
			var contact_id = $(delButton).attr("contact_id");
			
			if(contact_id==null){
				$(delButton).parents('tr').remove();
			}else{
				if(confirm("确定要删除该联系人吗？")){
					$.post( 
					encodeURI("<%=contextPath%>/CrmContact/Servlet?method=delete4this&id="+contact_id),  
					{Action:"post"},  
					function (data, status){ 
						if(status=="success")  
						{ 
							$(delButton).parents('tr').remove();
						} 
						else 
						{ 
							alert("删除联系人失败"); 
						} 
					}); 
				}
			}
		}
		</script>
	</body>
</html>
