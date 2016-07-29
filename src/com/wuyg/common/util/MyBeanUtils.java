package com.wuyg.common.util;

import java.beans.PropertyDescriptor;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;

import com.wuyg.common.dao.BaseDbObj;
import com.wuyg.common.obj.BaseSearchCondition;
import com.wuyg.dictionary.DictionaryUtil;

public class MyBeanUtils
{
	private static Logger logger = Logger.getLogger(MyBeanUtils.class);

	/**
	 * 根据java db对象实例来获取数据库表的字段列表，需要注意的是“数据库表的字段名需要跟数据库对象的字段名完全一致”
	 * 
	 * @param instance
	 * @return
	 * @throws NoSuchMethodException
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 */
	public static List<String> getColumnsByInstance(Object instance) throws Exception
	{
		Map properties = BeanUtils.describe(instance);

		List<String> columnList = new ArrayList<String>();

		Object[] keys = properties.keySet().toArray();

		for (int i = 0; i < keys.length; i++)
		{
			columnList.add((String) keys[i]);
		}

		return columnList;
	}

	/**
	 * 获取对象实例中除去class以外的所有属性的描述
	 * 
	 * @param instance
	 * @return
	 * @throws SQLException
	 */
	public static List<PropertyDescriptor> getPropertyDescriptors(Object instance, List<String> tableColumns) throws Exception
	{
		PropertyDescriptor[] propertyDescriptors = PropertyUtils.getPropertyDescriptors(instance);

		List<PropertyDescriptor> propertyDescriptorList = new ArrayList<PropertyDescriptor>();

		for (int i = 0; i < propertyDescriptors.length; i++)
		{
			PropertyDescriptor p = propertyDescriptors[i];
			if (p.getWriteMethod() != null && p.getReadMethod() != null)
			{
				if (tableColumns == null || tableColumns.size() == 0)
				{
					propertyDescriptorList.add(p);
				} else
				{
					for (int j = 0; j < tableColumns.size(); j++)
					{
						if (tableColumns.get(j).equalsIgnoreCase(p.getName()))
						{
							propertyDescriptorList.add(p);
							break;
						}
					}
				}
			}
		}

		return propertyDescriptorList;
	}

	/**
	 * 获取对象实例中不为空的属性的描述
	 * 
	 * @param object
	 * @return
	 * @throws NoSuchMethodException
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 */
	public static List<PropertyDescriptor> getNotNullPropertyDescriptors(Object instance, String keyColumm, List<String> tableColumns) throws Exception
	{
		List<PropertyDescriptor> propertyDescriptors = getPropertyDescriptors(instance, tableColumns);

		List<PropertyDescriptor> notNullPropertyDescriptors = new ArrayList<PropertyDescriptor>();

		for (int i = 0; i < propertyDescriptors.size(); i++)
		{
			PropertyDescriptor p = propertyDescriptors.get(i);
			String pName = p.getName();
			Object pValue = getPropertyValue(instance, pName);
			if (pValue != null && !p.getName().equals(keyColumm))
			{
				notNullPropertyDescriptors.add(p);
			}
		}

		return notNullPropertyDescriptors;
	}

	/**
	 * 获取属性值， Integer\Long等类型如果为null的话会报错，此处忽略null错误
	 * 
	 * @param instance
	 * @param pName
	 * @return
	 */
	public static Object getPropertyValue(Object instance, String pName)
	{
		// Integer\Long等类型如果为null的话会报错，此处忽略null错误
		Object pValue = null;
		try
		{
			pValue = PropertyUtils.getProperty(instance, pName);
		} catch (Exception e)
		{
		}
		return pValue;
	}

	/**
	 * 从HttpServletRequest里面获取数据并填充实例属性，只填充名称完全一致的字段
	 * 
	 * @param request
	 * @param instance
	 * @throws Exception
	 */
	public static Object createInstanceFromHttpRequest(Map<String, String[]> parameterMap, Class clz, boolean isFromUrl, int instanceIndex) throws Exception
	{
		Object instance = clz.newInstance();

		List<PropertyDescriptor> properties = MyBeanUtils.getPropertyDescriptors(instance, null);
		for (int i = 0; i < properties.size(); i++)
		{
			PropertyDescriptor property = properties.get(i);

			logger.debug("从Request里面抽取数据：" + instance.getClass() + "." + property.getPropertyType() + "." + property.getName());

			String[] propertyValues = parameterMap.get(property.getName());

			String propertyValueStr = (propertyValues == null || propertyValues.length <= instanceIndex) ? null : propertyValues[instanceIndex];// 取第instanceIndex个元素
			if (isFromUrl)
			{
				if (isFromUrl)
				{
					propertyValueStr = new String(StringUtil.getNotEmptyStr(propertyValueStr).getBytes("iso-8859-1"), "utf-8");
				}
			}

			Object propertyValue = null;

			if (!StringUtil.isEmpty(propertyValueStr))
			{
				logger.info("从Request里面抽取数据：" + instance.getClass() + "." + property.getPropertyType() + "." + property.getName() + "=" + propertyValueStr);

				Class propertyType = property.getPropertyType();

				if (propertyType.equals(Integer.class))
				{
					propertyValue = Integer.parseInt(propertyValueStr);
				} else if (propertyType.equals(Long.class))
				{
					propertyValue = Long.parseLong(propertyValueStr);
				} else if (propertyType.equals(Float.class))
				{
					propertyValue = Float.parseFloat(propertyValueStr);
				} else if (propertyType.equals(Double.class))
				{
					propertyValue = Double.parseDouble(propertyValueStr);
				} else if (propertyType.equals(Boolean.class))
				{
					propertyValue = Boolean.parseBoolean(propertyValueStr);
				} else if (propertyType.equals(Timestamp.class))
				{
					propertyValue = TimeUtil.getTimeStamp(propertyValueStr);
				} else if (propertyType.equals(Date.class))
				{
					propertyValue = TimeUtil.str2date(propertyValueStr);
				} else
				{
					propertyValue = propertyValueStr;
				}

				BeanUtils.setProperty(instance, property.getName(), propertyValue);
			}
		}

		return instance;
	}

	/**
	 * 从HttpServletRequest里面获取数据并构造对象列表，如果有父对象，则将子对象的父对象id填充上
	 * 
	 * @param request
	 * @param parentObj
	 * @param childObjClz
	 * @param childrenObjCount
	 * @param isFromUrl
	 * @return
	 * @throws Exception
	 */
	public static List<BaseDbObj> createInstanceListFromHttpRequest(HttpServletRequest request, BaseDbObj parentObj, Class childObjClz, int childrenObjCount, boolean isFromUrl) throws Exception
	{
		List<BaseDbObj> childrenList = new ArrayList<BaseDbObj>();
		for (int i = 0; i < childrenObjCount; i++)
		{
			BaseDbObj child = (BaseDbObj) MyBeanUtils.createInstanceFromHttpRequest(request.getParameterMap(), childObjClz, isFromUrl, i);
			child.setId(-1l);// 防止父对象的主键值填充到子对象的主键中
			if (parentObj != null)
			{
				child.setParentKeyValue(parentObj.getKeyValue());
			}

			if (child.uniqueIndexValueIsEmpty())
			{
				logger.info(child.getClass() + ":唯一索引字段有空值，丢弃该对象。");
			} else
			{
				childrenList.add(child);
			}
		}
		return childrenList;
	}

	/**
	 * 根据BaseDbObj对象来构造查询条件
	 * 
	 * @param baseDbObj
	 * @param tableColumns
	 * @param useLike
	 * @return
	 * @throws Exception
	 */
	public static String getWhereByBaseDbObj(BaseDbObj baseDbObj, List<String> tableColumns, boolean useLike) throws Exception
	{
		StringBuffer where = new StringBuffer();

		List<PropertyDescriptor> notNullProperties = getNotNullPropertyDescriptors(baseDbObj, baseDbObj.findKeyColumnName(), tableColumns);
		for (int i = 0; i < notNullProperties.size(); i++)
		{
			PropertyDescriptor p = notNullProperties.get(i);
			String pName = p.getName();
			String pValue = BeanUtils.getProperty(baseDbObj, pName);

			if (p.getPropertyType().equals(String.class))
			{
				// 如果是多选的，则使用in条件
				if (pValue.indexOf("multi:") == 0)
				{
					where.append(" and " + pName + " in( " + StringUtil.getStringByList(DictionaryUtil.getKeyListFromMultiSelect(pValue), true) + ")");
				} else
				{
					if (useLike)
					{
						where.append(" and " + pName + " like '%" + pValue + "%'");
					} else
					{
						where.append(" and " + pName + " = '" + pValue + "'");
					}
				}

			} else
			{
				where.append(" and " + pName + " = '" + pValue + "'");
			}
		}
		return where.toString();
	}

	public static String getWhereByBaseSearchCondition(BaseSearchCondition condition, List<String> tableColumns, boolean useLike) throws Exception
	{
		StringBuffer where = new StringBuffer();

		BaseDbObj baseDbObj = condition.getDomainObj();

		// 把domainInstance非空的基本条件设置上
		String baseDbObjWhere = getWhereByBaseDbObj(baseDbObj, tableColumns, useLike);
		where.append(baseDbObjWhere);

		// 把condition非空的其他与domainInstance相关的条件设置上
		List<PropertyDescriptor> baseDbObjPropertyDescriptors = getPropertyDescriptors(baseDbObj, tableColumns);// dbobj和数据库表重合的字段
		PropertyDescriptor[] conditionPropertyDescriptors = PropertyUtils.getPropertyDescriptors(condition);// condition中的字段

		if (conditionPropertyDescriptors != null)
		{
			for (int i = 0; i < baseDbObjPropertyDescriptors.size(); i++)
			{
				PropertyDescriptor dp = baseDbObjPropertyDescriptors.get(i);
				String pName = dp.getName();
				String pNameMin = pName + "_min";
				String pNameMax = pName + "_max";

				for (int j = 0; j < conditionPropertyDescriptors.length; j++)
				{
					PropertyDescriptor cp = conditionPropertyDescriptors[j];
					String cpName = cp.getName();
					String cpValue = BeanUtils.getProperty(condition, cpName);
					if (!StringUtil.isEmpty(cpValue))
					{
						if (pNameMin.equals(cpName))
						{
							where.append(" and " + pName + ">='" + cpValue + "'");
						}

						if (pNameMax.equals(cpName))
						{
							where.append(" and " + pName + "<='" + cpValue + "'");
						}
					}
				}

			}
		}

		// 加上其他where条件
		if (!StringUtil.isEmpty(condition.getOtherWhere()))
		{
			where.append(" and ").append(condition.getOtherWhere());
		}

		return where.toString();
	}
}
