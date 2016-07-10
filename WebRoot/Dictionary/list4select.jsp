<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<!-- 引入类 -->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.wuyg.common.util.StringUtil"%>
<%@page import="com.inspur.common.dictionary.util.DictionaryUtil"%>
<%@page import="com.wuyg.dictionary.service.DictionaryService"%>
<%@page import="com.wuyg.dictionary.obj.DictionaryObj"%>
<%@page import="com.inspur.common.dictionary.pojo.DictItem"%>
<!-- 基本信息 -->
<%
	// 当前上下文路径 
	String contextPath = request.getContextPath();
	// 该功能对象实例 
	DictionaryObj domainInstance = (DictionaryObj) request.getAttribute("domainInstance");
	// 该功能路径 
	String basePath = domainInstance.getBasePath();
	// 是否多选
	boolean isMultiSelect ="true".equalsIgnoreCase(request.getAttribute("multiSelect")+"");
	// 已选的key
	List<String> selectedKeys = StringUtil.getStringListByString(request.getAttribute("selectedKeys")+"");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>数据项选择</title>
		<link href="../css/global.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="../js/utils.js"></script>
	</head>
	<body>
	
		<!-- 查询条件 --> 
		<table class="search_table" align="center" width="90%"> 
			<tr> 
				<td align="center">
					<input type="text" name="dict_search_input" id="dict_search_input" value="" size="40"> 
				</td> 
				<%if(isMultiSelect){ %>
				<td align="right"> 
					<input name="addButton" type="button" class="button button_confirm" value="确认" onClick="confirmSelect()"> 
				</td> 
				<%} %>
			</tr> 
		</table> 
		
		<!-- 字典信息表 -->
		<table id="dict_table_list" width="90%" class="table table-bordered" align="center">
			<thead>
				<tr name="header">
				<%if(isMultiSelect){ %>
					<th style="text-align:center;padding:0">
						<input type="checkbox" id="checkAllBox">
					</th>
				 <%} %>
					<th>
						编号
					</th>
					<th>
						名称
					</th>
				</tr>
			</thead>
			<%
				List<DictItem> items = (ArrayList<DictItem>) request.getAttribute("dictItems");

				if (items == null)
				{
					items = new ArrayList<DictItem>();
				}

				for (int i = 1; i < items.size(); i++)
				{
					DictItem item = items.get(i);
					
					// 没有选择过的才显示
					if(!selectedKeys.contains(item.getK()))
					{
			%>
			<tr <%if(!isMultiSelect){ %>onclick="rowClick('<%=item.getK()%>','<%=item.getV()%>')"<%} %>>
				<%if(isMultiSelect){ %>
				<td width="40" style="text-align:center;padding:0">
					<input type="checkbox" id="key_box" value="<%=item.getK()%>" label="<%=item.getV()%>">
				</td>
				 <%} %>
				<td><%=item.getK()%></td>
				<td><%=item.getV()%></td>
			</tr>
			<%
					}
				}
			%>

		</table>
		<script>
		var defaultValue = "输入编号或名称自动检索";
		// 设置检索框值
		function setDictSearchInpuValue(inputValue)
		{
			$("#dict_search_input").val(inputValue).css("color","#000000");
			
			// 光标聚焦到文字尾部
			setCursorLocation(inputValue.length);
		}
		// 设置检索框默认值
		function initDictSearchInput()
		{
			$("#dict_search_input").val(defaultValue).css("color","#999999");
			
			// 光标聚焦到文字首部
			setCursorLocation(0);
		}
		// 光标聚焦到输入框指定位置
		function setCursorLocation(location)
		{
			
			var range = document.getElementById("dict_search_input").createTextRange();  
			range.collapse(true);
			range.moveStart('character',location);
			range.select();  
		}
		
		// 检索框初始化
		initDictSearchInput();	
		
		// 字典检索
		$('#dict_search_input').bind('input propertychange',function(){dictSearch();});
		$('#dict_search_input').click(function(){dictSearch();});
		
		function dictSearch(){
			var search_value = $.trim($('#dict_search_input').val().replace(defaultValue,""));
			
			if(search_value!=""){
			
				// 替换默认以后的内容
				setDictSearchInpuValue(search_value);
				
				$('#dict_table_list tr').each(function(){
					var tr = $(this);
					if(
						$(tr).attr('name')=='header'||//表头
						$(tr).text().toUpperCase().indexOf(search_value.toUpperCase())>=0
					)
					{
						$(tr).show();
					}
					else
					{
						$(tr).hide();
					}
					
				});
			}
			else
			{
				// 初始化输入框
				initDictSearchInput();
				
				$('#dict_table_list tr').each(function(){
				
					$(this).show();
					
				});
			}
		}
		
		// 单选： 选中一行直接返回
		function rowClick(key,value)
		{
			window.returnValue = key+'='+value;
			window.close();
		}
		
		// 多选：全选 取消全选
		$("#checkAllBox").click(function(){
				$("[id='key_box']").each(function(){
					// 只对显示的行进行操作
					if($(this).parents('tr').css('display')!='none')
					{
						if($("#checkAllBox").prop("checked")==true)
						{
							$(this).prop("checked",true);//全选
						}
						else
						{
							$(this).prop("checked",false);//取消全选
						}
					}
				});
		});
		
		// 多选：确认选择
		function confirmSelect()
		{		
			var selectValue = "";
			$("[id='key_box']").each(function()
			{
				if($(this).prop('checked'))
				{
					// 格式为：key1=value1;key2=value2
					selectValue+= $(this).attr('value')+"="+$(this).attr('label')+";";
				}
			});
			
			if(selectValue.length>0)
			{
				selectValue = selectValue.substring(0,selectValue.length-1);
			}
			
			window.returnValue = selectValue;
			window.close();
		}
			
	</script>
	</body>
</html>
