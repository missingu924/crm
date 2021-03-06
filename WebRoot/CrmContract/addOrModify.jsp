<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.wuyg.dictionary.DictionaryUtil"%>
<%@page import="com.crm.obj.CrmContractObj"%>
<%@page import="com.wuyg.common.util.TimeUtil"%>
<%@page import="com.wuyg.auth.obj.AuthUserObj"%>
<%@page import="com.wuyg.common.util.SystemConstant"%>
<%@page import="com.crm.obj.CrmCustomerObj"%>
<!-- 基本信息 -->
<%
	// 上下文路径 
	String contextPath = request.getContextPath();

	// 对象实例 
	CrmContractObj domainInstance = new CrmContractObj();
	// 该功能基本路径 
	String basePath = domainInstance.getBasePath();

	// 如果是修改，则获取对象信息 
	Object domainInstanceObj = request.getAttribute("domainInstance");
	if (domainInstanceObj != null)
	{
		domainInstance = (CrmContractObj) domainInstanceObj;
	}

	// 是否是修改 
	boolean isModify = domainInstance.getKeyValue() > 0;
	// 唯一性检查用的字段 
	String keyCol = "null";

	// 用户信息
	AuthUserObj user = (AuthUserObj) request.getSession().getAttribute(SystemConstant.AUTH_USER_INFO);
	boolean cf=user.hasFunction("合同-CF字段管理");
	boolean otherColums=user.hasFunction("合同-除CF之外的其他字段管理");

	// 开票信息
	CrmCustomerObj customer = new CrmCustomerObj();
	//if (!isModify)
	{
		// 新增时默认取当前客户的开票信息
		customer = domainInstance.findCustomer();
	}
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
		if(!checkNull("customer_id","<%=domainInstance.getPropertyCnName("customer_id")%>")) return false; 
		if(!checkNull("commercial_oppotunity_id","<%=domainInstance.getPropertyCnName("commercial_oppotunity_id")%>")) return false; 
		if(!checkNull("contract_name","<%=domainInstance.getPropertyCnName("contract_name")%>")) return false; 
		if(!checkNull("contract_subject","<%=domainInstance.getPropertyCnName("contract_subject")%>")) return false; 
		if(!checkNull("is_finished","<%=domainInstance.getPropertyCnName("is_finished")%>")) return false; 
		if(!checkNull("contract_sign_time","<%=domainInstance.getPropertyCnName("contract_sign_time")%>")) return false; 
		if(!checkNull("contract_price","<%=domainInstance.getPropertyCnName("contract_price")%>")) return false; 
		if(!checkNull("draw_bill","<%=domainInstance.getPropertyCnName("draw_bill")%>")) return false; 
					 
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
			<table width="720" align="center" class="title_table">
				<tr>
					<td>
						<%=isModify ? "修改" : "增加"%><%=domainInstance.getCnName()%>
					</td>
				</tr>
			</table>

			<!-- 详细信息 -->
			<table width="720" align="center" class="detail_table detail_table-bordered ">
				<input type="hidden" id="<%=domainInstance.findKeyColumnName()%>" name="<%=domainInstance.findKeyColumnName()%>" value="<%=domainInstance.getKeyValue()%>">
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("contract_name")%>:
					</td>
					<td colspan="3">
						<input name="contract_name" type="text" id="contract_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getContract_name(), "")%>" size="81">
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("customer_id")%>:
					</td>
					<td colspan="3">
						<%=DictionaryUtil.getInputHtmlReadOnly("客户字典", "customer_id", StringUtil.getNotEmptyStr(domainInstance.getCustomer_id(), ""), 81)%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("commercial_oppotunity_id")%>:
					</td>
					<td colspan="3">
						<%=DictionaryUtil.getInputHtmlReadOnly("商机字典", "commercial_oppotunity_id", StringUtil.getNotEmptyStr(domainInstance.getCommercial_oppotunity_id(), ""), 81)%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("management_type_code")%>:
					</td>
					<td colspan="3">
						<%=DictionaryUtil.getInputHtmlReadOnly("经营类型字典", "management_type_code", StringUtil.getNotEmptyStr(domainInstance.getManagement_type_code(), ""), 81)%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("product_code")%>:
					</td>
					<td><%=DictionaryUtil.getInputHtmlReadOnly("产品字典", "product_code", StringUtil.getNotEmptyStr(domainInstance.getProduct_code(), ""),20)%>
					</td>
					<td><%=domainInstance.getPropertyCnName("product_version_code")%>:
					</td>
					<td><%=DictionaryUtil.getInputHtmlReadOnly("产品版本字典", "product_version_code", StringUtil.getNotEmptyStr(domainInstance.getProduct_version_code(), ""),20)%>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("contract_subject")%>:
					</td>
					<td><%=DictionaryUtil.getSelectHtml("合同主体字典", "contract_subject", StringUtil.getNotEmptyStr(domainInstance.getContract_subject(), "否"))%>
						<font color="red">*</font>
					</td>
					<td><%=domainInstance.getPropertyCnName("is_finished")%>:
					</td>
					<td><%=DictionaryUtil.getSelectHtml("是否字典", "is_finished", StringUtil.getNotEmptyStr(domainInstance.getIs_finished(), "否"))%>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("contract_sign_time")%>:
					</td>
					<td>
						<input name="contract_sign_time" type="text" id="contract_sign_time" value="<%=StringUtil.getNotEmptyStr(TimeUtil.date2str(domainInstance.getContract_sign_time(), "yyyy-MM-dd"), TimeUtil.nowTime2str("yyyy-MM-dd"))%>" size="20"
							onFocus="WdatePicker({isShowClear:false,readOnly:false,highLineWeekDay:true,dateFmt:'yyyy-MM-dd'})">
						<font color="red">*</font>
					</td>
					<td><%=domainInstance.getPropertyCnName("contract_price")%>:
					</td>
					<td>
						<input name="contract_price" type="text" id="contract_price" value="<%=StringUtil.formatDouble(domainInstance.getContract_price(), 2)%>" size="20"> 
						<font color="red">*</font>
					</td>
				</tr>
				<%if(cf){ %>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("c")%>:
					</td>
					<td>
						<input name="c" type="text" id="c" value="<%=StringUtil.formatDouble(domainInstance.getC(), 2)%>" size="20"> 
					</td>
					<td><%=domainInstance.getPropertyCnName("f")%>:
					</td>
					<td>
						<input name="f" type="text" id="f" value="<%=StringUtil.formatDouble(domainInstance.getF(), 2)%>" size="20"> 
					</td>
				</tr>
				<%} %>
				<tr>
					<td>
						<%=domainInstance.getPropertyCnName("comment")%>:
					</td>
					<td colspan="3">
						<textarea name="comment" cols="61" rows="5" id="comment"><%=StringUtil.getNotEmptyStr(domainInstance.getComment(), "")%></textarea>
					</td>
				</tr>
				<tr>
					<td><%=domainInstance.getPropertyCnName("record_account")%>:
					</td>
					<td>
						<input type="text" readOnly value="<%=DictionaryUtil.getDictValueByDictKey("账号字典", StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), user.getAccount()))%>" size="20" style="background: #eeeeee;">
						<input name="record_account" type="hidden" id="record_account" value="<%=StringUtil.getNotEmptyStr(domainInstance.getRecord_account(), user.getAccount())%>" size="20">
					</td>
					<td><%=domainInstance.getPropertyCnName("record_time")%>:
					</td>
					<td>
						<input name="record_time" type="text" readonly id="record_time" value="<%=StringUtil.getNotEmptyStr(TimeUtil.date2str(domainInstance.getRecord_time()), TimeUtil.nowTime2str())%>" size="20" style="background: #eeeeee;">
					</td>
				</tr>
			</table>

			<table id="tab_table" width="720" align="center" class="sub_title_table">
				<tr>
					<td div_id="bill_info_div" style="width: 80px">
						开票信息
					</td>
					<td></td>
				</tr>
			</table>

			<div id="bill_info_div">
				<table width="100%" align="center" class="detail_table detail_table-bordered ">
					<tr>
						<td><%=domainInstance.getPropertyCnName("draw_bill")%>:						</td>
						<td><%=DictionaryUtil.getSelectHtml("是否字典", "draw_bill", StringUtil.getNotEmptyStr(domainInstance.getDraw_bill(), "是"))%>
							<font color="red">*</font>						</td>
						<td label="bill_detail"><%=domainInstance.getPropertyCnName("bill_type")%>:						</td>
						<td label="bill_detail"><%=DictionaryUtil.getSelectHtml("发票类型字典", "bill_type", StringUtil.getNotEmptyStr(domainInstance.getBill_type(), "普票"))%>
							<font color="red">*</font>						</td>
					</tr>
					
					<tr label="bill_detail">
						<td><%=domainInstance.getPropertyCnName("bill_company_name")%>:						</td>
						<td colspan="3">
							<input name="bill_company_name" type="text" id="bill_company_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_company_name(), StringUtil.getNotEmptyStr(customer.getBill_company_name(),""))%>" size="81" readOnly  style="background: #eeeeee;">						</td>
					</tr>
					<tr label="bill_detail">
						<td><%=domainInstance.getPropertyCnName("bill_duty_number")%>:						</td>
						<td colspan="3"><input name="bill_duty_number" type="text" id="bill_duty_number" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_duty_number(), StringUtil.getNotEmptyStr(customer.getBill_duty_number(),""))%>" size="81" readonly style="background: #eeeeee;"></td>
					</tr>
					<tr label="bill_detail">
						<td><%=domainInstance.getPropertyCnName("bill_address")%>:						</td>
						<td colspan="3">
							<input name="bill_address" type="text" id="bill_address" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_address(), StringUtil.getNotEmptyStr(customer.getBill_address(),""))%>" size="81" readOnly style="background: #eeeeee;">						</td>
					</tr>
					<tr label="bill_detail">
						<td><%=domainInstance.getPropertyCnName("bill_telephone")%>:						</td>
						<td colspan="3">
							<input name="bill_telephone" type="text" id="bill_telephone" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_telephone(), StringUtil.getNotEmptyStr(customer.getBill_telephone(),""))%>" size="81" readOnly style="background: #eeeeee;">						</td>
					</tr>
					<tr label="bill_detail">
						<td><%=domainInstance.getPropertyCnName("bill_bank_name")%>:						</td>
						<td colspan="3">
							<input name="bill_bank_name" type="text" id="bill_bank_name" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_bank_name(), StringUtil.getNotEmptyStr(customer.getBill_bank_name(),""))%>" size="81" readOnly style="background: #eeeeee;">						</td>
					</tr>
					<tr label="bill_detail">
						<td><%=domainInstance.getPropertyCnName("bill_bank_account")%>:						</td>
						<td colspan="3">
							<input name="bill_bank_account" type="text" id="bill_bank_account" value="<%=StringUtil.getNotEmptyStr(domainInstance.getBill_bank_account(), StringUtil.getNotEmptyStr(customer.getBill_bank_account(),""))%>" size="81" readOnly style="background: #eeeeee;">						</td>
					</tr>
				</table>
			</div>

			<script type="text/javascript">
			// 应用tab页
			useAsTab("tab_table","720");
			
			// 监听“是否开发票”事件
			$("#draw_bill").change(function(){
				if($(this).val()=='是')
				{
					$("[label=bill_detail]").each(function(){$(this).show()});
				}
				else
				{
					$("[label=bill_detail]").each(function(){$(this).hide()});
				}
			});
			
			// 如果不开发票，则不显示开票信息
			if($("#draw_bill").val()!='是')
			{
				$("[label=bill_detail]").each(function(){$(this).hide()});
			}
			
			// 如果不具备其他字段的修改权限，则将其他字段置为只读
			<%if(!otherColums){%>
				setDisabled("contract_name");
				setDisabled("contract_subject");
				setDisabled("is_finished");
				setDisabled("contract_sign_time");
				setDisabled("contract_price");
				setDisabled("comment");
				setDisabled("draw_bill");
				setDisabled("bill_type");
			<%}%>
			
			function setDisabled(id){
				$("#"+id).attr("disabled","disabled");
				$("#"+id).css("background","#eeeeee");
			}
			
			</script>

			<!-- 工具栏 -->
			<jsp:include page="../ToolBar/addOrModify_toolbar.jsp" />
		</form>
	</body>
</html>
