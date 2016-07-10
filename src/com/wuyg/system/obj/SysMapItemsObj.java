package com.wuyg.system.obj;
import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import com.alibaba.fastjson.JSON;
public class SysMapItemsObj extends BaseDbObj
{
private Long id;
private Long map_id;
private String source_id;
private String source_name;
private String dest_id;
private String dest_name;
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
	return "sys_map_items";
}
@Override 
public String findDefaultOrderBy()
{
	return super.findDefaultOrderBy();
}
@Override
public String getBasePath()
{
	return "SysMapItems";
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
		pros.put("map_id", "所属对照关系");
		pros.put("source_id", "外部接口对应编号");
		pros.put("source_name", "外部接口对应名字");
		pros.put("dest_id", "总账系统对应编号");
		pros.put("dest_name", "总账系统对应名字");
		return pros;
}
public Long getId()
{
	return id;
}
public void setId(Long id)
{
	this.id = id;
}
public Long getMap_id()
{
	return map_id;
}
public void setMap_id(Long map_id)
{
	this.map_id = map_id;
}
public String getSource_id()
{
	return source_id;
}
public void setSource_id(String source_id)
{
	this.source_id = source_id;
}
public String getSource_name()
{
	return source_name;
}
public void setSource_name(String source_name)
{
	this.source_name = source_name;
}
public String getDest_id()
{
	return dest_id;
}
public void setDest_id(String dest_id)
{
	this.dest_id = dest_id;
}
public String getDest_name()
{
	return dest_name;
}
public void setDest_name(String dest_name)
{
	this.dest_name = dest_name;
}
@Override
public String toString()
{
	return JSON.toJSONString(this);
}
}

