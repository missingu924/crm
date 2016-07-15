<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<table align="center" width="100%" class="toolbar_table">
	<tr>
		<td>
		
			<input name="closeButton" type="button" class="button button_close" value="关闭" title="关闭" onClick="javascript:window.close();" />
		 
		</td>
	</tr>
</table>

<script>
		<%if("true".equalsIgnoreCase(request.getAttribute("needRefresh")+"")){%>
			// 绑定关闭事件
			
			// 父窗口刷新，适用于window.open()打开的窗口
			if(window.opener){
				window.opener.eval("freshCurrentPage()");
			}

			// 父窗口刷新，适用于showModaldialog()打开的窗口
			if(window.dialogArguments){ 
				window.dialogArguments.eval("freshCurrentPage()");
				window.dialogArguments.eval("freshMe()"); 
			}
		<%}%>
</script>
