package com.wuyg.common.dao;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.sun.xml.internal.bind.v2.model.core.ID;
import com.wuyg.common.util.StringUtil;

/**
 * 
 * 
 * @author wuyugang
 * 
 */
public abstract class BaseDbObj
{
	private Logger logger = Logger.getLogger(getClass());

	/**
	 * 获取该对象对应的表名
	 * 
	 * @return
	 */
	public abstract String findTableName();

	/**
	 * 获取该对象对应表的主键字段名
	 * 
	 * @return
	 */
	public abstract String findKeyColumnName();

	/**
	 * 获取父对象的主键在该表中对应的字段名
	 * 
	 * @return
	 */
	public abstract String findParentKeyColumnName();

	/**
	 * 获取父对象的主键在该表中对应的字段名
	 * 
	 * @return
	 */
	public String findDefaultOrderBy()
	{
		return StringUtil.getNotEmptyStr(findKeyColumnName());
	}

	/**
	 * 获取目录名
	 * 
	 * @return
	 */
	public abstract String getBasePath();

	/**
	 * 获取该类的中文名
	 * 
	 * @return
	 */
	public abstract String getCnName();

	/**
	 * 获取导出excel是的列明及其字段对应关系
	 * 
	 * @return
	 */
	public abstract LinkedHashMap<String, String> findProperties();

	/**
	 * 根据表的主键获取实例对象的主键值
	 * 
	 * @return
	 * @throws Exception
	 */
	public long getKeyValue() throws Exception
	{
		return Long.parseLong(StringUtil.getNotEmptyStr(BeanUtils.getProperty(this, findKeyColumnName()), "-1"));
	}

	/**
	 * 根据表的主键设置实例对象的主键值
	 * 
	 * @return
	 * @throws Exception
	 */
	public void setId(Long value) throws Exception
	{
		BeanUtils.setProperty(this, findKeyColumnName(), value);
	}

	/**
	 * 获取主键中文名
	 * 
	 * @return
	 * @throws Exception
	 */
	public String getKeyCnName() throws Exception
	{
		return findProperties().get(findKeyColumnName());
	}

	/**
	 * 根据对象属性的英文名获取中文名
	 * 
	 * @param key
	 * @return
	 */
	public String getPropertyCnName(String cnName)
	{
		return StringUtil.getNotEmptyStr(findProperties().get(cnName));
	}

	/**
	 * 获取该类用于进行唯一索引检查的字段，默认不做唯一性检查
	 * 
	 * @return
	 */
	public List<String> findUniqueIndexProperties()
	{
		List<String> uniqueIndexProperties = new ArrayList<String>();
		uniqueIndexProperties.add(findKeyColumnName());// 默认用主键
		return uniqueIndexProperties;
	}

	/**
	 * 获取根据唯一所以查询时构造的查询条件，即 (a='1' and b='2') 这样的样式
	 * 
	 * @return
	 * @throws Exception
	 */
	public String findUniqueIndexClause() throws Exception
	{
		String clause = "";

		List<String> uniqueIndexProperties = findUniqueIndexProperties();

		for (int i = 0; i < uniqueIndexProperties.size(); i++)
		{
			String property = uniqueIndexProperties.get(i);
			String value = BeanUtils.getProperty(this, property);

			if (i > 0)
			{
				clause += " and ";
			}

			clause += " " + property + "='" + value + "' ";
		}

		return "(" + clause + ")";
	}

	@Override
	public boolean equals(Object other)
	{
		boolean isEquals = true;
		try
		{
			List<String> uniqueIndexProperties = findUniqueIndexProperties();

			for (int i = 0; i < uniqueIndexProperties.size(); i++)
			{
				String property = uniqueIndexProperties.get(i);
				String thisPropertyValue = BeanUtils.getProperty(this, property);
				String otherPropertyValue = BeanUtils.getProperty(other, property);

				if (thisPropertyValue == null && otherPropertyValue == null)
				{
					// 均为空
					isEquals &= true;
				} else if (thisPropertyValue != null && thisPropertyValue.equals(otherPropertyValue))
				{
					// 相等
					isEquals &= true;
				} else
				{
					// 不相等
					isEquals &= false;
				}

				if (!isEquals)
				{
					break;
				}
			}

			return isEquals;

		} catch (Exception e)
		{
			logger.error(e.getMessage(), e);
		}

		return false;
	}

	/**
	 * 根据property名字获取property值
	 * 
	 * @param propertyName
	 * @return
	 */
	public String getPropertyValue(String propertyName)
	{
		try
		{
			return BeanUtils.getProperty(this, propertyName);
		} catch (Exception e)
		{
			logger.error(propertyName + " " + e.getMessage(), e);
		}

		return null;
	}

	/**
	 * 设置父对象ID
	 * 
	 * @param parentId
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	public void setParentKeyValue(Long parentKeyValue) throws Exception
	{
		String parentKeyColumnName = findParentKeyColumnName();
		if (!StringUtil.isEmpty(parentKeyColumnName))
		{
			BeanUtils.setProperty(this, parentKeyColumnName, parentKeyValue);
		}
	}
}
