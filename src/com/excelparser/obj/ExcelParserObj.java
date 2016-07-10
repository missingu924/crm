package com.excelparser.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import com.alibaba.fastjson.JSON;
public class ExcelParserObj extends BaseDbObj
{
private Long id;

private String parser_name; // 解析器名称

private String basedbobj_class; // excel对应的数据库基础类

private String source_file_name;
private Long file_length;
private String dest_file_path;

private String user_account;
private Timestamp time_stamp;

private String import_type;// 数据导入方式：新增、覆盖
private String same_record_process_type;// 相同数据处理方式：保持系统中数据不变、覆盖系统中相同数据

@Override
public String findKeyColumnName()
{
	return "id";
}
@Override
public String findParentKeyColumnName()
{
	// TODO Auto-generated method stub
	return null;
}
@Override
public String findTableName()
{
	return "excel_parser";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "ExcelParser";
}
@Override
public String getCnName()
{
	return "Excel解析器";
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("parser_name", "解析器名称");
		pros.put("source_file_name", "源文件名");
		pros.put("file_length", "源文件大小");
		pros.put("dest_file_path", "上传后文件路径");
		pros.put("user_account", "用户名");
		pros.put("time_stamp", "时间戳");
		pros.put("import_type", "导入方式");
		pros.put("same_record_process_type", "相同数据处理方式");
		return pros;
}

public String getBasedbobj_class()
{
	return basedbobj_class;
}
public void setBasedbobj_class(String basedbobj_class)
{
	this.basedbobj_class = basedbobj_class;
}
public Long getId()
{
	return id;
}
public void setId(Long id)
{
	this.id = id;
}
public String getImport_type()
{
	return import_type;
}
public void setImport_type(String import_type)
{
	this.import_type = import_type;
}
public String getSame_record_process_type()
{
	return same_record_process_type;
}
public void setSame_record_process_type(String same_record_process_type)
{
	this.same_record_process_type = same_record_process_type;
}
public String getParser_name()
{
	return parser_name;
}
public void setParser_name(String parser_name)
{
	this.parser_name = parser_name;
}
public String getSource_file_name()
{
	return source_file_name;
}
public void setSource_file_name(String source_file_name)
{
	this.source_file_name = source_file_name;
}
public Long getFile_length()
{
	return file_length;
}
public void setFile_length(Long file_length)
{
	this.file_length = file_length;
}
public String getDest_file_path()
{
	return dest_file_path;
}
public void setDest_file_path(String dest_file_path)
{
	this.dest_file_path = dest_file_path;
}
public String getUser_account()
{
	return user_account;
}
public void setUser_account(String user_account)
{
	this.user_account = user_account;
}
public Timestamp getTime_stamp()
{
	return time_stamp;
}
public void setTime_stamp(Timestamp time_stamp)
{
	this.time_stamp = time_stamp;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

