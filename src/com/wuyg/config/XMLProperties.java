/**
 *
 *Copyright (c) 2004 Langchao LG Information System Co.,Ltd. All Rights Reserved.
 *
 */
package com.wuyg.config;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;



public class XMLProperties
{
   private boolean autoSave = true;
   private File file;
   private Document doc;
   private Map propertyCache = new HashMap();


   public XMLProperties(String file, boolean autoSave, boolean validate) throws
       JDOMException
   {
      this.autoSave = autoSave;
      this.file = new File(file);
      SAXBuilder builder = new SAXBuilder(validate);
      try
      {
         doc = builder.build(file);
      }
      catch (IOException ex)
      {
         ex.printStackTrace();
      }
      catch (JDOMException ex)
      {
         ex.printStackTrace();
         throw new JDOMException("�����̳��ִ��� " + ex);
      }
   }

   /**
    * ���캯��Ĭ��ֵ����֤���ṩ�Ƿ��Զ����̵ı�־��
    *
    * @param file     ������ȡ��ݵ�XML�ļ����
    * @param autoSave �Ƿ��Զ����̵ı�־
    * @throws JDOMException
    */
   public XMLProperties(String file, boolean autoSave) throws JDOMException
   {
      this(file, autoSave, false);
   }

   /**
    * ���캯��Ĭ��ֵ����֤�����Զ����̡�
    *
    * @param file ������ȡ��ݵ�XML�ļ����
    * @throws JDOMException
    */
   public XMLProperties(String file) throws JDOMException
   {
      this(file, false, false);
   }

   /**
    * �鿴�Ƿ������Զ�����
    *
    * @return boolean �Զ����̵ı�־������ֵ
    */
   public boolean isAutoSave()
   {
      return autoSave;
   }

   /**
    * �����Զ����̱�ʶ
    *
    * @param autoSave �Զ����̱�ʶ������ֵ
    */
   public void setAutoSave(boolean autoSave)
   {
      this.autoSave = autoSave;
   }

   /**
    * ��XML�ĵ����̣�ԭ�е��ļ����Ϻ�׺.bak
    *
    * @throws IOException
    */
   public synchronized void saveProperties() throws IOException
   {
      if (autoSave == false)
      {
         return;
      }
      Format fmt = Format.getPrettyFormat();
      fmt.setEncoding("GB2312");
      XMLOutputter out = new XMLOutputter(fmt);
      File temp = null;
      FileWriter writer = null;
      boolean isError = false;
      try
      {
         //�����һ����ʱ�ļ�
         temp = new File(file.getParent(), file.getName() + ".tmp");
         writer = new FileWriter(temp);
         out.output(doc, writer);
      }
      catch (IOException ex)
      {
         isError = true;
         ex.printStackTrace();
         throw new IOException("�����ʱ�ļ����ִ���" + ex);
      }
      finally
      {
         writer.close();
      }
      //����Դ�ļ���������ļ�
      if (isError == false)
      {
         File bak = new File(file.getParent(), file.getName() + ".bak");
         //ɾ��ԭ���ı����ļ�
         if (bak.exists())
         {
            bak.delete();
         }
         boolean isSuccess = file.renameTo(bak);
         file.delete();
         //��ʱ�ļ������ʽ�ļ�
         isSuccess = temp.renameTo(file);
         if (isSuccess == false)
         {
            throw new IOException("�����ļ���̳��ִ���");
         }
      }
   }

   /**
    * ����ָ��Ԫ�ص����ݣ��ַ��ʽ
    *
    * @param name Ԫ�ص���ƣ���ʽΪ X.Y.Z��
    * @return String Ԫ�ص����ݣ�null��ʾû��ƥ���Ԫ��
    */
   public String getPorperty(String name)
   {
      if (propertyCache.containsKey(name))
      {
         return propertyCache.get(name).toString();
      }

      //����ָ����Ԫ��Ԫ��
      Element element = this.findOnly(name);
      if (element == null)
      {
         return null;
      }

      String value = element.getTextTrim();
      propertyCache.put(name, value);
      return value;
   }

   /**
    * ����ָ��Ԫ�ص�Attribute���ݣ��ַ��ʽ
    *
    * @param name Ԫ�ص���ƣ���ʽΪ X.Y.Z��
    * @param attr Attribute���
    * @return String Attribute�����ݣ�null��ʾû��ƥ���Ԫ��(Attribute)
    */
   public String getPorperty(String name, String attr)
   {
      String nameAttr = name + ":" + attr;
      if (propertyCache.containsKey(nameAttr))
      {
         return propertyCache.get(nameAttr).toString();
      }

      //����ָ����Ԫ��Ԫ��
      Element element = this.findOnly(name);
      if (element == null)
      {
         return null;
      }

      String value = element.getAttributeValue(attr);
      propertyCache.put(nameAttr, value);
      return value;
   }

   /**
    * ����һ��Ԫ��ֵ�����ָ����Ԫ�ز����ڣ����Զ�������Ԫ�ء�
    *
    * @param name  ��Ҫ��ֵ��Ԫ����ƣ���ʽΪ X.Y.Z
    * @param value Ԫ��ֵ
    * @throws IOException
    */
   public void setProperty(String name, String value) throws IOException
   {
      propertyCache.put(name, value);

      //����ָ����Ԫ��Ԫ��
      Element element = this.findCreate(name);
      element.setText(value);
      saveProperties();
   }

   /**
    * ����һ��Ԫ�ص�Attributeֵ�����ָ����Ԫ�ز����ڣ����Զ�������Ԫ�ء�
    *
    * @param name  ��Ҫ��ֵ��Ԫ����ƣ���ʽΪ X.Y.Z
    * @param attr  Attribute���
    * @param value Ԫ��ֵ
    * @throws IOException
    */
   public void setProperty(String name, String attr, String value) throws
       IOException
   {
      String nameAttr = name + ":" + attr;
      propertyCache.put(nameAttr, value);

      //����ָ����Ԫ��Ԫ��
      Element element = this.findCreate(name);
      element.setAttribute(attr, value);
      saveProperties();
   }

   /**
    * ɾ��ָ����Ԫ�أ�����Ԫ�ز����ڣ������κ�����
    *
    * @param name Ҫɾ���Ԫ�ص���ƣ���ʽΪ X.Y.Z
    * @throws IOException
    */
   public void deleteProperty(String name) throws IOException
   {
      if (propertyCache.containsKey(name))
      {
         propertyCache.remove(name);
      }

      Element element = this.findOnly(name);
      if (element != null)
      {
         element.detach();
      }
      saveProperties();
   }

   /**
    * ɾ��ָ����Ԫ�ص�Attribute������Ԫ�ػ���Attribute�����ڣ������κ�����
    *
    * @param name Ԫ�ص���ƣ���ʽΪ X.Y.Z
    * @param attr Attribute�����
    * @throws IOException
    */
   public void deleteProperty(String name, String attr) throws IOException
   {
      String nameAttr = name + ":" + attr;
      if (propertyCache.containsKey(nameAttr))
      {
         propertyCache.remove(nameAttr);
      }

      Element element = this.findOnly(name);
      if (element != null)
      {
         element.removeAttribute(attr);
      }
      saveProperties();
   }

   /**
    * ���ָ��Ԫ�ص�������Ԫ����ơ�������X.Y.A, X.Y.B ��X.Y.C��ʹ��
    * getChildrenProperties("X.Y")�����һ��������ַ�����顣���û��
    * ƥ���Ԫ�أ�����һ���յ����顣
    *
    * @param parent Ԫ�ص���ƣ���ʽΪ X.Y.Z
    * @return String[] ָ��Ԫ�ص�������Ԫ����Ƶ����飬���߿����顣
    */
   public String[] getChildrenProperties(String parent)
   {
      //�ֽ�Ԫ�ص����
      String[] propName = parsePropertyName(parent);
      Element element = doc.getRootElement();
      //��������ƥ���Ԫ��
      for (int i = 0; i < propName.length; i++)
      {
         element = element.getChild(propName[i]);
         //û��ƥ���Ԫ�أ�����һ���յ�����
         if (element == null)
         {
            return new String[]
                {};
         }
      }
      //�ҵ�����
      List children = element.getChildren();
      String[] childrenName = new String[children.size()];
      for (int i = 0; i < children.size(); i++)
      {
         childrenName[i] = ( (Element) children.get(i)).getName();
      }
      return childrenName;
   }

   /**
    * ���ָ��Ԫ�أ������ֵƥ�������ֵ
    * @param parent   ��Ԫ�����
    * @param seName   ԴԪ�����
    * @param teName   Ŀ���������
    * @param attributeName   �������
    * @param seValue      Ҫƥ���ԴԪ��ֵ
    * @param attrValue     Ҫƥ���Ŀ������ֵ
    * @return
    */
   public String getProperties(String parent, String seName, String teName,
                               String attributeName, String seValue,
                               String attrValue)
   {
      //�ֽ�Ԫ�ص����
      String[] propName = parsePropertyName(parent);
      Element element = doc.getRootElement();

      //��������ƥ���Ԫ��
      for (int i = 0; i < propName.length; i++)
      {
         List list = element.getChildren(propName[i]);

         //û��ƥ���Ԫ�أ�����һ���յ�����
         if (list == null)
         {
            return null;
         }
         else
         {
            for (Iterator iter = list.iterator(); ; iter.hasNext())
            {
               Element lastelement = (Element) iter.next();
               if (seValue.equals(lastelement.getChildText(seName)))
               {
                  if (attributeName == null)
                  {
                     //ֱ�ӷ��ص�һ��Ԫ��ֵ
                     return lastelement.getChildText(teName);

                  }
                  else
                  {
                     //�������ֵ����Ҫ������Թ���
                     List implList = lastelement.getChildren(teName);
                     for (Iterator implIter = implList.iterator(); ;
                          implIter.hasNext())
                     {
                        Element implClass = (Element) implIter.next();
                        if (attrValue.equals(implClass.getAttributeValue(
                            attributeName)))
                        {
                           return implClass.getTextTrim();
                        }
                     }
                  }
               }
            }
         }
      }
      return "";
   }

   /**
    * helper����������һ���ַ����飬���ֽ���Ԫ����ơ� ���� "prop.name.is.this"
    * ��Ԫ�ػ᷵�ذ��ĸ��ַ�����顣
    *
    * @param name Ԫ�ص���ƣ���ʽΪ X.Y.Z
    * @return String[] ���ֽ��Ԫ����Ƶ��ַ�����
    */
   private String[] parsePropertyName(String name)
   {
      //��Ϊ���"."�Ǳ����ַ����Բ���ʹ��String.split()
      //�����Ƚ���һ�����
      return name.replace('.', '#').split("#");
   }

   /**
    * helper����������һ��ָ����Ԫ��
    *
    * @param name Ԫ����ƣ���ʽΪ X.Y.Z
    * @return Element ����ҵ��ͷ������Ԫ�أ����򷵻�null
    */
   private Element findOnly(String name)
   {
      //�ֽ�Ԫ�ص����
      String[] propName = parsePropertyName(name);
      Element element = this.doc.getRootElement();
      //��������ƥ���Ԫ��
      for (int i = 0; i < propName.length; i++)
      {
         element = element.getChild(propName[i]);
         if (element == null)
         {
            return null;
         }
      }
      //�ҵ�����
      return element;
   }

   /**
    * helper����������һ��ָ����Ԫ��,������Ԫ�ز����ڣ�������
    *
    * @param name Ԫ����ƣ���ʽΪ X.Y.Z
    * @return Element �ҵ��ͷ������Ԫ�أ����򷵻ش�������Ԫ��
    */
   private Element findCreate(String name)
   {
      //�ֽ�Ԫ�ص����
      String[] propName = parsePropertyName(name);
      Element element = doc.getRootElement();
      //��������ƥ���Ԫ�أ��������򴴽���
      for (int i = 0; i < propName.length; i++)
      {
         if (element.getChild(propName[i]) == null)
         {
            //�Զ�������Ԫ��
            element.addContent(new Element(propName[i]));
         }
         element = element.getChild(propName[i]);
      }
      //�ҵ�����
      return element;
   }
}
