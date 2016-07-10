package com.wuyg.dictionary;

import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.inspur.common.dictionary.Dictionary;
import com.inspur.common.dictionary.pojo.DictItem;
import com.wuyg.common.util.MySqlUtil;
import com.wuyg.common.util.StringUtil;
import com.wuyg.common.util.SystemConstant;
import com.wuyg.dictionary.service.DictionaryService;

public class DictionaryUtil
{
	private static Logger logger = Logger.getLogger(DictionaryUtil.class);

	/**
	 * 根据字典数据生成html的select元素
	 * 
	 * @param items
	 * @param selectName
	 * @param selectedItemKey
	 * @return
	 */
	public static String getSelectHtml(String dictName, String selectName)
	{
		return getSelectHtml(dictName, selectName, null);
	}

	/**
	 * 根据字典数据生成html的select元素
	 * 
	 * @param items
	 * @param selectName
	 * @param selectedItemKey
	 * @return
	 */
	public static String getSelectHtml(String dictName, String selectName, String selectedItemKey)
	{
		List<DictItem> items = new DictionaryService().getDictItemsByDictName(dictName, false);

		StringBuffer sb = new StringBuffer();

		sb.append("<select name='" + selectName + "' size='1' id='" + selectName + "' >");
		for (int i = 0; i < items.size(); i++)
		{
			DictItem item = items.get(i);

			sb.append("<option value='" + item.getK() + "' " + (item.getK().equals(selectedItemKey) ? "selected='selected'" : "") + ">" + item.getV() + "</option>");
		}
		sb.append("</select>");

		return sb.toString();
	}

	/**
	 * 获取输入及显示内容html
	 * 
	 * @param dictName
	 * @param inputName
	 * @param inputValue
	 * @return
	 */
	public static String getInputHtml(String dictName, String inputName, String inputValue)
	{
		return getInputHtml(dictName, inputName, inputValue, null, null);
	}

	/**
	 * 获取输入及显示内容html
	 * 
	 * @param dictName
	 * @param inputName
	 * @param inputValue
	 * @return
	 */
	public static String getInputHtml(String dictName, String inputName, String inputValue, String parentDictName, String parentDictInputName)
	{
		StringBuffer sb = new StringBuffer();

		String inputName4show = inputName + "_4show";
		sb.append("<input type=\"text\" id=\"" + inputName4show + "\" name=\"" + inputName4show + "\" value=\"" + getValueByKey(dictName, inputValue) + "\" onclick=\"selectFromDictionary('" + dictName + "','" + inputName + "','" + inputName4show + "'"
				+ (!StringUtil.isEmpty(parentDictName) ? (",'" + parentDictName + "',$('#" + parentDictInputName) + "').val()" : "") + ")\" readOnly><input id=\"" + inputName + "_clear_btn\" type=\"button\" class=\"button button_clear\" title=\"重置\" onclick=\"$('#" + inputName + "').val('');$('#"
				+ inputName4show + "').val('');\" > \n");
		sb.append("<input type=\"hidden\" id=\"" + inputName + "\" name=\"" + inputName + "\" value=\"" + inputValue + "\"> \n");

		return sb.toString();
	}

	public static String getDictValueByDictKey(String dictName, String key)
	{
		return getDictValueByDictKey(dictName, key, false);
	}

	public static String getDictValueByDictKey(String dictName, String key, String dbName)
	{
		return getDictValueByDictKey(dictName, key, false, dbName);
	}

	public static String getDictValueByDictKey(String dictName, String key, boolean showKey)
	{
		String dbName = StringUtil.getNotEmptyStr(new Dictionary().getDictByName(dictName).getDbName(), SystemConstant.DEFAULT_DB);

		return getDictValueByDictKey(dictName, key, showKey, dbName);
	}

	public static String getDictValueByDictKey(String dictName, String key, boolean showKey, String dbName)
	{
		try
		{
			if (StringUtil.isEmpty(key))
			{
				return "";
			}
			
			Dictionary dictionary = new Dictionary();
			
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

	private static String getValueByKey(String dictName, String key)
	{
		if (key == null || key.length() == 0)
		{
			return "";
		}

		List<DictItem> items = new DictionaryService().getDictItemsByDictName(dictName, false);

		for (int i = 0; i < items.size(); i++)
		{
			DictItem item = items.get(i);

			if (key.equalsIgnoreCase(item.getK()))
			{
				return item.getV();
			}
		}

		return "";
	}
}
