package com.icignal.common.util;

import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.core.exception.DataSQLException;


/**
 * @name : infavor.icncommon.util
 * @date : 2015. 10. 21.
 * @author : 류동균
 * @description : object util
 */
public class ObjectUtil extends CommonUtil {
	
	static final Logger logger = LoggerFactory.getLogger(ObjectUtil.class);

	/**
	 * @name : isNotEmpty
	 * @date : 2015. 10. 21.
	 * @author : 류동균
	 * @description : Null 또는 빈값 확인
	 */
	public static boolean isNotEmpty(Object object) {

		return !isEmpty(object);
	}

	/**
	 * @name : isEmpty
	 * @date : 2015. 10. 21.
	 * @author : 류동균
	 * @description : Null 또는 빈값 확인
	 */
	@SuppressWarnings("unchecked")
	public static boolean isEmpty(Object object) {
		if (object == null) {
			return true;
		}

		if (object instanceof String) {
			String str = (String) object;
			return str.length() == 0;
		}

		if (object instanceof Collection) {
			Collection collection = (Collection) object;
			return collection.size() == 0;
		}
		
		if (object instanceof Map) {
			Map map = (Map) object;
			return map.isEmpty();
		}
		
		if (object.getClass().isArray()) {
			try {
				if (Array.getLength(object) == 0) {
					return true;
				}
			} catch (IllegalArgumentException e) {
				LogUtil.error(e);
			}
		}

		return false;
	}

	@SuppressWarnings("unchecked")
	public static Map ConverObjectToMap(Object obj){
		try {
			//Field[] fields = obj.getClass().getFields(); //private field는 나오지 않음.
			Field[] fields = obj.getClass().getDeclaredFields();
			Map resultMap = new HashMap();
			for(int i=0; i<=fields.length-1;i++){
				fields[i].setAccessible(true);
				resultMap.put(fields[i].getName(), fields[i].get(obj));
			}
			return resultMap;
		} catch (IllegalArgumentException e) {
			LogUtil.error(e);
		} catch (IllegalAccessException e) {
			LogUtil.error(e);
		}
		return null;
	}

	@SuppressWarnings("rawtypes")
	public static Object convertMapToObject(Map map, Class objClass){

		String keyAttribute = "";
		boolean rtnFlag = false;
		Object bean = null;

		try {

			//String 형 (map 결과는 하나만 나와야 한다.)
			if (objClass.equals(java.lang.String.class)){
				if (map.size() ==  1) {

					Iterator itr = map.keySet().iterator();
					while(itr.hasNext()){
						keyAttribute = (String) itr.next();
					}

					bean = map.get(keyAttribute);
					rtnFlag = true;
				}
			}
			//Integer 형 (map 결과는 하나만 나와야 한다.)
			else if (objClass.equals(java.lang.Integer.class)) {
				if (map.size() == 1) {
					Iterator itr = map.keySet().iterator();
					while(itr.hasNext()){
						keyAttribute = (String) itr.next();
					}

					bean =  Integer.parseInt((String) map.get(keyAttribute));
					rtnFlag = true;
				}
			}
			//그외 Object
			else {
				bean = objClass.newInstance();

				PropertyDescriptor[] targetPds = PropertyUtils.getPropertyDescriptors(objClass);
				for (PropertyDescriptor desc : targetPds) {
					Object value = map.get(desc.getName());
					if (value != null) {
						Method writeMethod = desc.getWriteMethod();
						if (writeMethod != null) {
							writeMethod.invoke(bean, new Object[] { value });

							if (!rtnFlag) rtnFlag = true;
						}
					}
				}
			}
		} catch (SecurityException e) {
			LogUtil.error(e);
		} catch (IllegalAccessException e) {
			LogUtil.error(e);
		} catch (IllegalArgumentException e) {
			LogUtil.error(e);
		} catch (InvocationTargetException e) {
			LogUtil.error(e);
		} catch (InstantiationException e) {
			
			LogUtil.error(e);
		}

		//결과값이 없을경우 null 반환
		if (!rtnFlag) bean = null;

		return bean;
	}

	public <T extends Map<String, Object>, C> List<C> convertMapToBean(List<T> list, Class<C> clazz) {
		List<C> beanList = new ArrayList<C>();
		for (T source : list) {
			C bean = null;
			
				try {
					bean = clazz.newInstance();
				} catch (InstantiationException e) {
					LogUtil.error(e);
				} catch (IllegalAccessException e) {
					LogUtil.error(e);
				}
				
				PropertyDescriptor[] targetPds = PropertyUtils.getPropertyDescriptors(clazz);
				for (PropertyDescriptor desc : targetPds) {
					Object value = source.get(desc.getName());
					if (value != null) {
						Method writeMethod = desc.getWriteMethod();
						if (writeMethod != null) {
							try {
								writeMethod.invoke(bean, new Object[] { value });
							} catch (IllegalAccessException e) {
								LogUtil.error(e);
							} catch (IllegalArgumentException e) {
								LogUtil.error(e);
							} catch (InvocationTargetException e) {
								LogUtil.error(e);
							}
						}
					}
				}
			
			beanList.add(bean);
		}

		return beanList;
	}
	
	public static Field findUnderlying(Class<?> clazz, String fieldName) {
		Class<?> current = clazz;
		do {
			
				try {
					return current.getDeclaredField(fieldName);
				} catch (NoSuchFieldException | SecurityException e) {
                     LogUtil.error(e);
				}
			
		} while((current = current.getSuperclass()) != null);
    
		return null;
	}
	
	/**
	 * IFVMObkectUtility
	 * */
	/**
		/**
	 * @name : isNotEmpty
	 * @date : 2015. 10. 21.
	 * @author : 류동균
	 * @description : Null 또는 빈값 확인
	 */
//	public static boolean isNotEmpty(Object object) {
//
//		return !isEmpty(object);
//	}

	/**
	 * @name : isEmpty
	 * @date : 2015. 10. 21.
	 * @author : 류동균
	 * @description : Null 또는 빈값 확인
	 */
//	@SuppressWarnings("unchecked")
//	public static boolean isEmpty(Object object) {
//		if (object == null) {
//			return true;
//		}
//
//		if (object instanceof String) {
//			String str = (String) object;
//			return str.length() == 0;
//		}
//
//		if (object instanceof Collection) {
//			Collection collection = (Collection) object;
//			return collection.size() == 0;
//		}
//
//		if (object instanceof Map) {
//            return ((Map<?, ?>)object).isEmpty();
//        }
//
//		if (object instanceof List) {
//            return ((List<?>)object).isEmpty();
//        }
//
//		if (object.getClass().isArray()) {
//			try {
//				if (Array.getLength(object) == 0) {
//					return true;
//				}
//			} catch (IllegalArgumentException e) {
//				LogUtil.error(e);
//			}
//		}
//
//		return false;
//	}
//
//	@SuppressWarnings("unchecked")
//	public static Map ConverObjectToMap(Object obj){
//		try {
//			//Field[] fields = obj.getClass().getFields(); //private field는 나오지 않음.
//			Field[] fields = obj.getClass().getDeclaredFields();
//			Map resultMap = new HashMap();
//			for(int i=0; i<=fields.length-1;i++){
//				fields[i].setAccessible(true);
//				resultMap.put(fields[i].getName(), fields[i].get(obj));
//			}
//			return resultMap;
//		} catch (IllegalArgumentException e) {
//			LogUtil.error(e);
//		} catch (IllegalAccessException e) {
//			LogUtil.error(e);
//		}
//		return null;
//	}

//	@SuppressWarnings("rawtypes")
//	public static Object convertMapToObject(Map map, Class objClass){
//
//		String keyAttribute = "";
//		boolean rtnFlag = false;
//		Object bean = null;
//
//		try {
//
//			//String 형 (map 결과는 하나만 나와야 한다.)
//			if (objClass.equals(java.lang.String.class)){
//				if (map.size() ==  1) {
//
//					Iterator itr = map.keySet().iterator();
//					while(itr.hasNext()){
//						keyAttribute = (String) itr.next();
//					}
//
//					bean = map.get(keyAttribute);
//					rtnFlag = true;
//				}
//			}
//			//Integer 형 (map 결과는 하나만 나와야 한다.)
//			else if (objClass.equals(java.lang.Integer.class)) {
//				if (map.size() == 1) {
//					Iterator itr = map.keySet().iterator();
//					while(itr.hasNext()){
//						keyAttribute = (String) itr.next();
//					}
//
//					bean =  Integer.parseInt((String) map.get(keyAttribute));
//					rtnFlag = true;
//				}
//			}
//			//그외 Object
//			else {
//				bean = objClass.newInstance();
//
//				PropertyDescriptor[] targetPds = PropertyUtils.getPropertyDescriptors(objClass);
//				for (PropertyDescriptor desc : targetPds) {
// 					Object value = map.get(desc.getName());
//					if (value != null) {
//						Method writeMethod = desc.getWriteMethod();
//						if (writeMethod != null) {
//							writeMethod.invoke(bean, new Object[] { value });
//
//							if (!rtnFlag) rtnFlag = true;
//						}
//					}
//				}
//			}
//		} catch (SecurityException e) {
//			LogUtil.error(e);
//		} catch (IllegalAccessException e) {
//			LogUtil.error(e);
//		} catch (IllegalArgumentException e) {
//			LogUtil.error(e);
//		} catch (InvocationTargetException e) {
//			LogUtil.error(e);
//		} catch (InstantiationException e) {
//
//			LogUtil.error(e);
//		}
//
//		//결과값이 없을경우 null 반환
//		if (!rtnFlag) bean = null;
//
//		return bean;
//	}

//	public <T extends Map<String, Object>, C> List<C> convertMapToBean(List<T> list, Class<C> clazz) {
//		List<C> beanList = new ArrayList<C>();
//		for (T source : list) {
//			C bean = null;
//			try {
//				bean = clazz.newInstance();
//				PropertyDescriptor[] targetPds = PropertyUtils.getPropertyDescriptors(clazz);
//				for (PropertyDescriptor desc : targetPds) {
//					Object value = source.get(desc.getName());
//					if (value != null) {
//						Method writeMethod = desc.getWriteMethod();
//						if (writeMethod != null) {
//							writeMethod.invoke(bean, new Object[] { value });
//						}
//					}
//				}
//			} catch (Exception e) {
//				LogUtil.error(e);
//			}
//			beanList.add(bean);
//		}
//
//		return beanList;
//	}

	/**
	 * @name : ConverMapToJSONString
	 * @date : 2017. 6. 26.
	 * @author : "dg.ryu"
	 * @return : String
	 * @description : Map > Json String 변환
	 */
	public static String ConvertMapToJSONString(Map<String, String[]> map){

		JSONObject json = new JSONObject();
		for( Map.Entry<String, String[]> entry : map.entrySet() ) {
			String key = entry.getKey();
			Object value = entry.getValue();
			try {
				json.put(key, value);
			} catch (JSONException e) {

				LogUtil.error(e);
			}
		}

		return json.toString();
	}
	
	public static String ConvertMapToJSONString2(Map<String, Object> map){

		JSONObject json = new JSONObject();
		for( Map.Entry<String, Object> entry : map.entrySet() ) {
			String key = entry.getKey();
			Object value = entry.getValue();
			try {
				json.put(key, value);
			} catch (JSONException e) {

				LogUtil.error(e);
			}
		}

		return json.toString();
	}
	
	public static String ConvertListMapToJSONString(List<Map<String, Object>> list)
	{       
	    JSONArray json_arr=new JSONArray();
	    for (Map<String, Object> map : list) {
	        JSONObject json_obj=new JSONObject();
	        for (Map.Entry<String, Object> entry : map.entrySet()) {
	            String key = entry.getKey();
	            Object value = entry.getValue();
	            try {
	                json_obj.put(key,value);
	            } catch (JSONException e) {
	            	LogUtil.error(e);
	            }                           
	        }
	        json_arr.put(json_obj);
	    }
	    return json_arr.toString();
	}

	/**
	 * @name : ConvertObjectToJSONString
	 * @date : 2017. 6. 26.
	 * @author : "dg.ryu"
	 * @return : String
	 * @description :Object > Json String 변환
	 */
	/*public static String ConvertObjectToJSONString(Object obj) {

		JSONObject jsonObj = new JSONObject( obj );

		return jsonObj.toString();
	}
	*/
	
	
	/**
     * list를 Grid로 변환
     *
     * @programId :
     * @name : setGrid
     * @date : 2018. 3. 26.
     * @author : jh.kim
     * @table :
     * @param obj
     * @param rsList
     * @param rsTotalCount
     * @param dbType
     * @return
     * @description :
     */
    public static GridPagingResDto ConvertListToGrid(GridPagingReqDto obj, List rsList, Integer rsTotalCount, String dbType) {
        GridPagingResDto rtnValue = new GridPagingResDto();
        try {
            if (rsList.size() > 0) {
                int page = 0;
                int totalCount = 0;
                int pageCount = 1;

                obj.init(DB_TYPE.MYSQL);
                GridPagingReqDto parseParam = obj;
                page = parseParam.getPage();
                totalCount = 0;
                pageCount = 1;

                if (rsTotalCount != null) {
                    totalCount = rsTotalCount;
                }

                if (parseParam.getRows() != 0) {
                    if (totalCount % parseParam.getRows() == 0) {
                        pageCount = totalCount / parseParam.getRows();
                    }
                    else {
                        pageCount = totalCount / parseParam.getRows() + 1;
                    }
                }

                rtnValue.setSuccess(true);
                rtnValue.setRows(rsList);
                rtnValue.setRecords(totalCount);
                rtnValue.setPage(page);
                rtnValue.setTotal(pageCount);
            }
        }
        catch (Exception e) {
            LogUtil.error(e.getMessage(), e);
            throw new DataSQLException();
        }

        return rtnValue;
    }
    
    /**
     * @name : equalsObject
     * @date : 2017. 8. 17.
     * @author : "dg.ryu"
     * @return : boolean
     * @description : Object 비교
     */
	public static<T> boolean equalsObject(T target1, T target2, Class<T> targetClass) {
    	boolean rtnValue = true;
    	
        try {
            for (PropertyDescriptor pd : Introspector.getBeanInfo(targetClass, Object.class).getPropertyDescriptors()) {
            	Method method = pd.getReadMethod();
            	
            	Object value1 = null;
            	
            	try {
            		value1 = method.invoke(target1);
            	} catch (IllegalAccessException e) {
            		LogUtil.error(e);
            	} catch (IllegalArgumentException e) {
            		LogUtil.error(e);
            	} catch (InvocationTargetException e) {
            		LogUtil.error(e);
            	} 
            	
            	Object value2 = null;
            	try {
            		value2 = method.invoke(target2);
            	} catch (IllegalAccessException e) {
            		LogUtil.error(e);
            	} catch (IllegalArgumentException e) {
            		LogUtil.error(e);
            	} catch (InvocationTargetException e) {
            		LogUtil.error(e);
            	}

                boolean isNotEqualValue = value1 == value2 || value1 != null && value1.equals(value2);
                if (!isNotEqualValue && !"poolName".equals(pd.getName())) {
                    LogUtil.info(String.format("%s의 값이 다름. value1 : %s, value2 : %s", pd.getName(), value1, value2));
                    
                    rtnValue = false;
                    
                    break;
                }
            }
        } catch (IntrospectionException e) {
        	LogUtil.error(e.toString());
        	
        	rtnValue = false;
        }
        
        return rtnValue;
    }

}
