<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage=""%>
<table align="center" width="100%" class="toolbar_table">
	<tr>
		<td>
			<input name="saveButton" type="button" class="button button_save" value="保存" title="保存" onClick="addOrModify()">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input name="cancleButton" type="button" class="button button_cancel" value="取消" onClick="javascript:if(history.length>0){history.back();}else{window.close();}">
		</td>
	</tr>
</table>
<!-- JS函数 -->
<script>
			// 绑定enter事件
			$('body').keydown(function(){
			   if(event.keyCode == 13)
			   {
				 addOrModify();
			   }
			});
</script>
