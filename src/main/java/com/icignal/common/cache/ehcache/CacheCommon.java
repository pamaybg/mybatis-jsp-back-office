package com.icignal.common.cache.ehcache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.CacheEvict;

import com.icignal.common.util.LogUtil;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

public class CacheCommon {
	
		
	/**
	 * <PRE>
	 * 1. 설명
	 * 캐시저장소에 하나의 캐시객체 저장
	 * 만들 key와 OBJECT(value)값을 받아서 Element객체에 할당후, cache.put을 사용해 저장 		
	 * 2. 사용법
	 * 	
	 * </PRE>
	 *   @param cachemanager
	 *   @param key
	 *   @param obj
	 *   @param cacheName	
	 */
	public  void insertValue(CacheManager cachemanager,String key,Object obj,String cacheName){
		Cache cache = cachemanager.getCache(cacheName);
		Element element = new Element(key,obj);
		//캐시저장소에 하나의 캐시객체 저장	
		cache.put(element);
	}
	
	 /*
	  * 1. 메소드명: getAllValue
	  * 2. 클래스명: CacheCommon
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 캐시에 있는 모든값을 가져오는 메소드
	 * 캐시저장소에서 모든Key를 List로 받고 forEach로 순회하면서 key와 value를 map으로 저장 
	 * 2. 사용법
	 * 
	 * </PRE>
	 *   @param cachemanager
	 *   @return	
	 */
	public  Map<String,Object> getAllValue(CacheManager cachemanager , String cacheName){
		Map<String,Object> map = new HashMap<>();
		Cache cache = cachemanager.getCache(cacheName);
		
		@SuppressWarnings("rawtypes")
		List cacheList = cache.getKeys();
		
		//캐시저장소를 순회하면서 모든 key를 각각 하나씩 가져옴
		for (Object key: cacheList) {
			Element element = cache.get(key);
			
			//가져온 Element값이 널이 아니면 해당 Element의 key와 value값을 map에 저장
			//if(element != null) {
				Object value = element.getObjectValue();
				LogUtil.debug("key="+key+"value="+value.toString());
				map.put(key.toString(),value);
		//	}
		}
		return map;
	}
		
		
		 /*
		  * 1. 메소드명: createCache
		  * 2. 클래스명: CacheCommon
		  * 3. 작성자명: jh.seo 
		  * 4. 작성일자: 2020. 2. 10.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *	프로그램 권한 관련 캐시에 조회해온 프로그램권한 객체값 저장	
		 * 2. 사용법
		 *	캐시매니저와,id(로그인 유저),객체를 조회해볼 List값으로 객체값 순회하면서 조회	
		 * </PRE>
		 *   @param cachemanager
		 *   @param id
		 *   @param obj	
		 */
		@SuppressWarnings({ "unchecked", "unused" })
	 public	 <T> void createCache(CacheManager cachemanager,String loginId, List<T> obj  , String cacheName) {
			//캐시 저장소를 불러와서 로그인한 아이디값으로 KEY값,value값으로 가져온 프로그램 목록 객체를 저장
//			Cache cache = cachemanager.getCache("ProgramCache");
			Cache cache = cachemanager.getCache(cacheName);
			cache.put(new Element(loginId,obj));
			
			//방금 저장한 캐시객체 List내용을 조회해보기위한 로직
			Element element = cache.get(loginId);
			
			//element에서 방금 저장한 프로그램 및 오브젝트 캐시를 저장
		//	List<T> objList = new ArrayList<T>();
			List<T> resDto = (List<T>) element.getObjectValue();
		}
		
		 /*
		  * 1. 메소드명: cacheRemove
		  * 2. 클래스명: CacheCommon
		  * 3. 작성자명: jh.seo
		  * 4. 작성일자: 2020. 2. 17.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 * 해당 캐시 저장소의 이름을 삭제하는 메소드
		 * 2. 사용법
		 * 해당 메소드를 호출하면 value값에 해당하는 캐시저장소의 내용을 삭제
		 *  	
		 * </PRE>
		 *   @param id
		 *   @param cacheName	
		 */
		@CacheEvict(value="ProgramCache")
		public void cacheRemove(String id, String cacheName) {
			LogUtil.debug("ProgramCache delete");
		}		
		
		public void printAllCaahe(CacheManager cachemanager,String cacheName){
			HashMap<String,String> map = new HashMap<String,String>();
			Cache cache = cachemanager.getCache(cacheName);
			List cacheList = cache.getKeys();
			LogUtil.debug("=========캐시 데이터 단순조회 시작==========");
			for (Object key: cacheList) {
				Element element = cache.get(key);
				if(element != null) {
					Object value = element.getObjectValue();
					//System.out.println("key="+key+"value="+value.toString());
					map.put(key.toString(),value.toString());
				}
			}
			LogUtil.debug("=========캐시 데이터 단순조회 끝==========");
		}
		
}



