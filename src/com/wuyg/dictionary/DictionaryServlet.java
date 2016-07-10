package com.wuyg.dictionary;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.log4j.Logger;

import com.inspur.common.dictionary.pojo.DictItem;
import com.inspur.common.dictionary.util.DictionaryUtil;
import com.wuyg.common.dao.DefaultBaseDAO;
import com.wuyg.common.dao.IBaseDAO;
import com.wuyg.common.obj.PaginationObj;
import com.wuyg.common.servlet.AbstractBaseServletTemplate;
import com.wuyg.common.util.StringUtil;
import com.wuyg.dictionary.obj.DictionaryObj;
import com.wuyg.dictionary.service.DictionaryService;

public class DictionaryServlet extends AbstractBaseServletTemplate
{
	private Logger logger = Logger.getLogger(getClass());
	private DictionaryService dictionaryService = new DictionaryService();

	@Override
	public String getBasePath()
	{
		return domainInstance.getBasePath();
	}

	@Override
	public IBaseDAO getDomainDao()
	{
		return new DefaultBaseDAO(getDomainInstanceClz());
	}

	@Override
	public Class getDomainInstanceClz()
	{
		return com.wuyg.dictionary.obj.DictionaryObj.class;
	}

	@Override
	public Class getDomainSearchConditionClz()
	{
		return com.wuyg.dictionary.searchcondition.DictionarySearchCondition.class;
	}

	// 查询
	public void list4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.list(request, response);
	}

	// 查询字典可选项
	public void listItems4select(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		DictionaryObj dictionaryObj = (DictionaryObj) domainInstance;

		List<DictItem> dictItems = new ArrayList<DictItem>();
		if (!StringUtil.isEmpty(dictionaryObj.getParentDictName()) && !(StringUtil.isEmpty(dictionaryObj.getParentDictKey())))
		{
			// 根据父字典管理子字典
			dictItems = dictionaryService.getDictItemsFromTo(dictionaryObj.getParentDictName(), dictionaryObj.getDictname(), dictionaryObj.getParentDictKey(), false);
		} else
		{
			// 直接查询字典数据项
			dictItems = dictionaryService.getDictItemsByDictName(dictionaryObj.getDictname(), true);
		}

		request.setAttribute("dictItems", dictItems);
		request.setAttribute("multiSelect", request.getParameter("multiSelect"));
		request.setAttribute("selectedKeys", new String((request.getParameter("selectedKeys") + "").getBytes("iso-8859-1"), "utf-8"));

		request.setAttribute(DOMAIN_INSTANCE, domainInstance);

		request.getRequestDispatcher("/" + getBasePath() + "/" + BASE_METHOD_LIST + "4select.jsp").forward(request, response);
	}

	// 查询字典数据项
	public void getDict(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String dictName = request.getParameter("dictName");

		List<DictItem> items = new ArrayList<DictItem>();

		items = dictionaryService.getDictItemsByDictName(dictName, true);

		request.setAttribute("items", items);

		super.list(request, response);
	}

	// 根据父字典及其键值查询子字典数据项
	public void getSubDict(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String fromDictName = request.getParameter("fromDictName");
		String toDictName = request.getParameter("toDictName");
		String fromDictKey = request.getParameter("fromDictKey");

		List<DictItem> items = new ArrayList<DictItem>();

		items = dictionaryService.getDictItemsFromTo(fromDictName, toDictName, fromDictKey, true);

		request.setAttribute("items", items);

		super.list(request, response);
	}

	// 获取字典构造的select html
	public void getDictHtml(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String dictName = request.getParameter("dictName");

		String fromDictName = request.getParameter("fromDictName");
		String toDictName = request.getParameter("toDictName");
		String fromDictKeyISO88591 = request.getParameter("fromDictKey");
		String fromDictKey = new String(StringUtil.getNotEmptyStr(fromDictKeyISO88591).getBytes("iso-8859-1"), "utf-8");

		String addItemForAllStr = request.getParameter("addItemForAll");
		boolean addItemForAll = "true".equalsIgnoreCase(addItemForAllStr);

		String selectName = request.getParameter("selectName");
		String selectedItemKeyISO88591 = request.getParameter("selectedItemKey");
		String selectedItemKey = new String(StringUtil.getNotEmptyStr(selectedItemKeyISO88591).getBytes("iso-8859-1"), "utf-8");

		String notEmpty = request.getParameter("notEmpty");

		List<DictItem> dictItems = new ArrayList<DictItem>();
		if (!StringUtil.isEmpty(dictName))
		{
			dictItems = dictionaryService.getDictItemsByDictName(dictName, addItemForAll);
		} else if (!StringUtil.isEmpty(fromDictName) && !StringUtil.isEmpty(toDictName))
		{
			dictItems = dictionaryService.getDictItemsFromTo(fromDictName, toDictName, fromDictKey, addItemForAll);
		}

		request.setAttribute("dictItems", dictItems);

		response.setCharacterEncoding("utf-8");

		String html = DictionaryUtil.getSelectHtml(dictItems, selectName, selectName, selectedItemKey, notEmpty);

		if (!StringUtil.isEmpty(html))
		{
			html = StringUtil.substr(html, ">", "</select>");
		}

		response.getWriter().print(html);
	}

	// 检查ID是否已录入系统
	public void checkId4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.checkId(request, response);
	}

	// 增加 or 修改
	public void addOrModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.addOrModify(request, response);
	}

	// 修改前查询领域对象信息
	public void preModify4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.preModify(request, response);
	}

	// 详情
	public void detail4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.detail(request, response);
	}

	// 删除
	public void delete4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.delete(request, response);
	}

	// 导出
	public void export4this(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		super.export(request, response);
	}

}
