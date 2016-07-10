package com.wuyg.system.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import com.alibaba.fastjson.JSON;
public class SysMapInfoObj extends BaseDbObj
{
private Long id;
private String name;
private String map_type;// 科室，科目
private String comment;
private String source_name;
private String source_dict_name;
private String dest_name;
private String dest_dict_name;
private String source_system;// 外部系统
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
	return "sys_map_info";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "SysMapInfo";
}
@Override
public String getCnName()
{
	return "对照关系";
}
public LinkedHashMap<String, String> findProperties()
{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "编号");
		pros.put("name", "对照关系名");
		pros.put("map_type", "对照关系类型");
		pros.put("source_system", "外部接口名称");
		pros.put("source_name", "外部接口字段名");
		pros.put("source_dict_name", "外部接口字段-字典");
		pros.put("dest_name", "总账系统字段名");
		pros.put("dest_dict_name", "总账系统字段-字典");
		pros.put("comment", "对照关系描述");
		
		
		return pros;
}
public String getMap_type()
{
	return map_type;
}
public void setMap_type(String map_type)
{
	this.map_type = map_type;
}
public String getSource_name()
{
	return source_name;
}
public void setSource_name(String source_name)
{
	this.source_name = source_name;
}
public String getDest_name()
{
	return dest_name;
}
public void setDest_name(String dest_name)
{
	this.dest_name = dest_name;
}
public Long getId()
{
	return id;
}
public void setId(Long id)
{
	this.id = id;
}
public String getName()
{
	return name;
}
public void setName(String name)
{
	this.name = name;
}
public String getComment()
{
	return comment;
}
public void setComment(String comment)
{
	this.comment = comment;
}

public String getSource_dict_name()
{
	return source_dict_name;
}
public void setSource_dict_name(String source_dict_name)
{
	this.source_dict_name = source_dict_name;
}

public String getDest_dict_name()
{
	return dest_dict_name;
}
public void setDest_dict_name(String dest_dict_name)
{
	this.dest_dict_name = dest_dict_name;
}

public String getSource_system()
{
	return source_system;
}
public void setSource_system(String source_system)
{
	this.source_system = source_system;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

