package com.wuyg.dictionary.obj;

import java.sql.Timestamp;
import com.wuyg.common.dao.BaseDbObj;
import java.util.LinkedHashMap;
import com.alibaba.fastjson.JSON;

public class DictionaryObj extends BaseDbObj
{
	private Long id;
	private String dicttype;
	private String dictname;
	private String dictdbname;
	private String dicttable;
	private String dictkeycol;
	private String dictvaluecol;
	private String dictorderbycol;
	private String dictfilter;
	private String dictvalues;
	private String parentDictName;
	private String parentDictKey;
	private String dbFilter;

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
		return "dictionary";
	}

	@Override
	public String findDefaultOrderBy()
	{
		return super.findDefaultOrderBy();
	}

	@Override
	public String getBasePath()
	{
		return "Dictionary";
	}

	@Override
	public String getCnName()
	{
		return "字典管理";
	}

	public LinkedHashMap<String, String> findProperties()
	{
		LinkedHashMap<String, String> pros = new LinkedHashMap<String, String>();

		pros.put("id", "字典编号");
		pros.put("dicttype", "字典类型");
		pros.put("dictname", "字典名称");
		pros.put("dictdbname", "对应数据库");
		pros.put("dicttable", "对应表");
		pros.put("dictkeycol", "数据项编码对应字段");
		pros.put("dictvaluecol", "数据项名称对应字段");
		pros.put("dictorderbycol", "排序条件");
		pros.put("dictfilter", "过滤条件");
		pros.put("dictvalues", "枚举字典可选值");
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

	public String getDbFilter()
	{
		return dbFilter;
	}

	public void setDbFilter(String dbFilter)
	{
		this.dbFilter = dbFilter;
	}

	public String getDicttype()
	{
		return dicttype;
	}

	public void setDicttype(String dicttype)
	{
		this.dicttype = dicttype;
	}

	public String getDictname()
	{
		return dictname;
	}

	public void setDictname(String dictname)
	{
		this.dictname = dictname;
	}

	public String getParentDictName()
	{
		return parentDictName;
	}

	public void setParentDictName(String parentDictName)
	{
		this.parentDictName = parentDictName;
	}

	public String getParentDictKey()
	{
		return parentDictKey;
	}

	public void setParentDictKey(String parentDictKey)
	{
		this.parentDictKey = parentDictKey;
	}

	public String getDictdbname()
	{
		return dictdbname;
	}

	public void setDictdbname(String dictdbname)
	{
		this.dictdbname = dictdbname;
	}

	public String getDicttable()
	{
		return dicttable;
	}

	public void setDicttable(String dicttable)
	{
		this.dicttable = dicttable;
	}

	public String getDictkeycol()
	{
		return dictkeycol;
	}

	public void setDictkeycol(String dictkeycol)
	{
		this.dictkeycol = dictkeycol;
	}

	public String getDictvaluecol()
	{
		return dictvaluecol;
	}

	public void setDictvaluecol(String dictvaluecol)
	{
		this.dictvaluecol = dictvaluecol;
	}

	public String getDictorderbycol()
	{
		return dictorderbycol;
	}

	public void setDictorderbycol(String dictorderbycol)
	{
		this.dictorderbycol = dictorderbycol;
	}

	public String getDictfilter()
	{
		return dictfilter;
	}

	public void setDictfilter(String dictfilter)
	{
		this.dictfilter = dictfilter;
	}

	public String getDictvalues()
	{
		return dictvalues;
	}

	public void setDictvalues(String dictvalues)
	{
		this.dictvalues = dictvalues;
	}

	@Override
	public String toString()
	{
		return JSON.toJSONString(this);
	}
}
