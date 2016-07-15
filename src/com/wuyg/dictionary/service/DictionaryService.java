package com.wuyg.dictionary.service;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.inspur.common.dictionary.Dictionary;
import com.inspur.common.dictionary.pojo.Dict;
import com.inspur.common.dictionary.pojo.DictItem;
import com.wuyg.common.util.MySqlUtil;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;

public class DictionaryService implements IDictionaryService
{
	private Logger logger = Logger.getLogger(getClass());
	private Dictionary dictionary = new Dictionary();
	private final String pleaseSelect = "--请选择--";
	private final String DICT_SELF = "DICT_SELF";

	public List<DictItem> getDictItemsByDict(Dict dict, boolean addItemForAll)
	{
		try
		{
			DataSource ds = MySqlUtil.getDataSource(SystemConstant.DEFAULT_DB);
			List<DictItem> items = dictionary.getDictItemsByDict(dict, addItemForAll, ds);
			if (addItemForAll == false)
			{
				items.add(0, new DictItem(0, "", pleaseSelect));
			}
			return items;
		} catch (Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		return new ArrayList<DictItem>();
	}

	public List<DictItem> getDictItemsByDictName(String dictName, String dbFilter, boolean addItemForAll)
	{
		logger.info("字典名:" + dictName);

		List<DictItem> items = new ArrayList<DictItem>();
		try
		{
			if (DICT_SELF.equalsIgnoreCase(dictName))
			{
				// 字典配置文件中的字典信息
				List<Dict> allDicts = dictionary.getAllDictionaries();
				for (int i = 0; i < allDicts.size(); i++)
				{
					DictItem item = new DictItem();
					item.setK(allDicts.get(i).getDictName());
					item.setV(allDicts.get(i).getDictName());
					items.add(item);
				}
			} else
			{
				String dbName = StringUtil.getNotEmptyStr(dictionary.getDictByName(dictName).getDbName(), SystemConstant.DEFAULT_DB);
				DataSource ds = MySqlUtil.getDataSource(dbName);
				items = dictionary.getDictItemsByDictName(dictName, addItemForAll, ds, dbFilter);
			}

			if (addItemForAll == false)
			{
				items.add(0, new DictItem(0, "", pleaseSelect));
			}
		} catch (Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		return items;
	}

	public List<DictItem> getDictItemsByDictName(String dictName, boolean addItemForAll)
	{
		return getDictItemsByDictName(dictName, null, addItemForAll);
	}

	public List<DictItem> getDictItemsByDictName(String dictName, boolean addItemForAll, String dbName)
	{
		try
		{
			DataSource ds = MySqlUtil.getDataSource(dbName);
			List<DictItem> items = dictionary.getDictItemsByDictName(dictName, addItemForAll, ds);
			if (addItemForAll == false)
			{
				items.add(0, new DictItem(0, "", pleaseSelect));
			}
			return items;
		} catch (Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		return new ArrayList<DictItem>();
	}

	public List<DictItem> getDictItemsByDictNameExcludeKey(String dictName, boolean addItemForAll, String excloudKey)
	{
		List<DictItem> tempItems = getDictItemsByDictName(dictName, addItemForAll);

		List<DictItem> items = new ArrayList<DictItem>();

		for (int i = 0; i < tempItems.size(); i++)
		{
			DictItem item = tempItems.get(i);
			if (!item.getK().equalsIgnoreCase(excloudKey))
			{
				items.add(item);
			}
		}

		return items;
	}

	public List<DictItem> getDictItemsFromTo(String fromDictName, String toDictName, String fromDictKey, String dbFilter, boolean addItemForAll)
	{
		try
		{
			String dbName = StringUtil.getNotEmptyStr(dictionary.getDictByName(fromDictName).getDbName(), SystemConstant.DEFAULT_DB);
			DataSource ds = MySqlUtil.getDataSource(dbName);
			List<DictItem> items = dictionary.getDictItemsFromTo(fromDictName, toDictName, fromDictKey, addItemForAll, ds, dbFilter);
			if (addItemForAll == false)
			{
				items.add(0, new DictItem(0, "", pleaseSelect));
			}
			return items;
		} catch (Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		return new ArrayList<DictItem>();
	}

	public String getDictValueByDictKey(String dictName, String key)
	{
		return getDictValueByDictKey(dictName, key, false);
	}

	public String getDictValueByDictKey(String dictName, String key, String dbName)
	{
		return getDictValueByDictKey(dictName, key, false, dbName);
	}

	public String getDictValueByDictKey(String dictName, String key, boolean showKey)
	{
		String dbName = StringUtil.getNotEmptyStr(dictionary.getDictByName(dictName).getDbName(), SystemConstant.DEFAULT_DB);

		return getDictValueByDictKey(dictName, key, showKey, dbName);
	}

	public String getDictValueByDictKey(String dictName, String key, boolean showKey, String dbName)
	{
		try
		{
			// 先从缓存中取，如果取不到再从数据库中取
			String value = dictionary.getDictValueByDictKeyFromCache(dictName, key);
			if (StringUtil.isEmpty(value))
			{
				DataSource ds = MySqlUtil.getDataSource(dbName);
				value = dictionary.getDictValueByDictKeyFromDb(dictName, key, ds);
			}
			if (showKey && !StringUtil.isEmpty(value))
			{
				value += "(" + key + ")";
			}
			return value;
		} catch (Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		return "";
	}
}
