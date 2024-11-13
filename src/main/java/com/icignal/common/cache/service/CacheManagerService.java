package com.icignal.common.cache.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import com.icignal.common.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.cache.mapper.CacheManagerMapper;
import com.icignal.common.util.LogUtil;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

/**
 * @name : com.icignal.common.cache.service.impl.CacheMgtService
 * @date : 2020. 01. 13.
 * @author : hr.noh
 * @history : 
 * @since : JDK1.8
 * @see : 
 * @description : cache 관련 service
*/
@Service
public class CacheManagerService  {
	
	@Autowired CacheManagerMapper cacheMapper;
	
	@Autowired CacheManager cachemanager;
	
	Cache cache;
	
	Element element;
	
	@PostConstruct
	public void init() {
		
		cache = null; 
		element = null;
	}
		
	 /*
	  * 1. 메소드명: createCommCodeProperty
	  * 2. 클래스명: CacheMgtService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * DB에서 가져온 공통코드목록 캐시저장
	 * 2. 사용법
	 * DB에서 캐시여부 체크되어있는 공통코드 목록을 가져와서 map으로 저장한뒤	해당 map을 공통코드 캐시저장소에 저장	
	 * </PRE>
	 *   @return	
	 */
	public List<Map<String, String>> selectCommCode() {
		Cache cache = cachemanager.getCache("commCodeCache");
		List<Map<String, String>> commCodeCacheList = cacheMapper.selectCommCode();
	
		//map으로 가져온 공통코드 List값을 cache에 저장
		for(Map<String,String> map : commCodeCacheList) {
			//String key = CommonUtil.CacheKeyProduce(commCodeCacheList.getGroupCode(),reqDto.getCodeName(),reqDto.getLang());
			cache.put(new Element(map.get("KEY"),map.get("VALUE")));
		}
		
		return commCodeCacheList;
	}
	
	 /*
	  * 1. 메소드명: createMessageProperties
	  * 2. 클래스명: CacheMgtService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * DB에서 가져온 메시지프로퍼티 캐시저장	
	 * 2. 사용법
	 * DB에서 캐시여부 체크되어있는 공통코드 목록을 가져와서 map으로 저장한뒤	해당 map을 메시지프로퍼티 캐시저장소에 저장		
	 * </PRE>
	 *   @return	
	 */
	@Cacheable("messagePropertyCache")
	public List<Map<String, String>> selectMessageProperties() {
		List<Map<String, String>> messageProperties =  cacheMapper.selectMessageProperties();		
		cache = cachemanager.getCache("messagePropertyCache");
		String key = null;
		String value = null;
		
		//map으로 가져온 공통코드 List값을 cache에 저장
    	for(Map<String, String> map : messageProperties) {        		
			key = map.get("KEY");
			value = map.get("VALUE");    			
			element = new Element(key, value);    			
			cache.put(element);
		}
      
        
		return messageProperties;
	}
	
	 /*
	  * 1. 메소드명: insertMessagePropertyCache
	  * 2. 클래스명: CacheMgtService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 캐시저장소에 1개의 캐시객체 추가로 저장	
	 * 2. 사용법
	 * 캐시저장소에서 key와 value를 가져와 기존 캐시를 담고있던 객채에 추가로 저장한다			
	 * </PRE>
	 *   @param key
	 *   @param value	
	 */
	public void insertMessagePropertyCache(String key, String value){
		
		cache = cachemanager.getCache("messagePropertyCache");
		
		//key와 value가 null이 아니라면 해당 캐시를 저장
		if(key !=null && value != null) {				
				element = new Element(key, value);
				cache.put(element);	
		}
		
	}
	
	 /*
	  * 1. 메소드명: deleteMessagePropertyCache
	  * 2. 클래스명: CacheMgtService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 메시지프로퍼티 캐시에서 key값에 해당하는 캐시 삭제		
	 * 2. 사용법
	 * cache.remove메소드를 사용해 해당 key값 캐시에서 삭제		
	 * </PRE>
	 *   @param key	
	 */
	@CacheEvict("messagePropertyCache")
	public void deleteMessagePropertyCache(String key) {
		
		cache = cachemanager.getCache("messagePropertyCache");
		
		//key값에 해당하는 캐시 삭제
		cache.remove(key);
		
	}
	
	 /*
	  * 1. 메소드명: clearCache
	  * 2. 클래스명: CacheMgtService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 메시지프로퍼티 캐시 삭제	
	 * 2. 사용법
	 * @CacheEvict를 사용해 캐시 삭제	
	 * </PRE>
	 *   @param key
	 *   @param value	
	 */
	@CacheEvict(cacheNames = {"messagePropertyCache"})
    public void clearCache(String key, String value){
		//캐시 지우기 메소드
	}
	


	 /*
	  * 1. 메소드명: getCacheValue
	  * 2. 클래스명: CacheMgtService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 메시지프로퍼티 캐시에서 하나의 key값에 해당하는 value출력	
	 * 2. 사용법
	 * cache.get메소드를 사용해 key값을 넣고 받은 element의 value값을 출력		
	 * </PRE>
	 *   @param key
	 *   @return	
	 */
	public Object getCacheValue(String key) {
		
		cache = cachemanager.getCache("messagePropertyCache");
		element = cache.get(key);
		return element.getObjectValue().toString();
	}
	
     /*
      * 1. 메소드명: printAllCache
      * 2. 클래스명: CacheMgtService
      * 3. 작성자명: hr.noh 
      * 4. 작성일자: 2020. 2. 19.
      */
    /**
     * <PRE>
     * 1. 설명
     * 메시지프로퍼티 캐시 값 전체 조회		
     * 2. 사용법
     * List로 모든 Key값을 가져오고 해당 key값을 foreach문으로 순회하면서 출력	
     * </PRE>	
     */
    public void printAllCache() {
    	
    	List<?> strArr = cachemanager.getCache("messagePropertyCache").getKeys();
    	
		for (Object string : strArr) {
		 
			element = cache.get(string);
			LogUtil.debug("messagePropertyCache : "+string.toString() +" & "+ element.getObjectValue().toString()); 
		}
		 
		LogUtil.debug("[Cache Size] : "+strArr.size());
    }
	
	 /*
	  * 1. 메소드명: updateCommCodeCache
	  * 2. 클래스명: CacheMgtService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 캐시저장소에 1개의 캐시객체 추가로 저장		
	 * 2. 사용법
	 * 캐시저장소에서 key와 value를 가져와 기존 캐시를 담고있던 객채에 추가로 저장한다	
	 * </PRE>
	 *   @param key
	 *   @param value
	 *   @return boolean
	 */
	public boolean updateCommCodeCache(String key,String value) {
		boolean cacheSucces = false;
		Cache cache = cachemanager.getCache("commCodeCache");
		
		//캐시저장소에 Element객체(한개의 캐시객체)로 저장
		cache.put(new Element(key,value));
		cacheSucces = true;
		
		return cacheSucces;
	}

	 /*
	  * 1. 메소드명: getComCode
	  * 2. 클래스명: CacheMgtService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 공통코드 캐시저장소에서 key값에 맞는 value값을 출력	
	 * 2. 사용법
	 *	캐시저장소를 가져온후에 해당 캐시저장소에서 key값에 맞는 element를 조회후에 
	 *  getObjectValue메소드를 사용하여 출력
	 * </PRE>
	 *   @param key	
	 */
	public void getComCode(String key) {
		Cache cache = cachemanager.getCache("commCodeCache");
		Element element = cache.get(key);
		Object result = element.getObjectValue();
		
		LogUtil.debug("commCodeCache 캐시의 값 : "+result);
	}

	 /*
	  * 1. 메소드명: getCacheValue
	  * 2. 클래스명: CacheManagerService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param loginId
	 *   @param string
	 *   @param url
	 *   @return	
	 */
	
	public ProgramCache getCacheValue(String key, String cacheName, String url) {
		LogUtil.param(this.getClass(), url);
		String inUrl = url;
		//캐시 저장소와 저장소에 있는 값을 받을 Element값 선언
		Cache cache = cachemanager.getCache(cacheName);
		Element element = null; 
		
		//프로그램캐시를 저장할 객체와 현재 프로그램 권한캐시에 담긴 전체값을 담을 객체 선언
		ProgramCache pgmResDto = new ProgramCache();
		List<ProgramCache> resDto = new ArrayList<ProgramCache>();
		
		//URL경로에 .jsp를 붙여줌
		//url = CommonUtil.setProgramUrl(url);
		if(inUrl.charAt(0) == '/') inUrl = inUrl.substring(1) + ".jsp" ;
		else inUrl = inUrl + ".jsp";
		
		//프로그램권한 캐시 저장소에서 Key값(로그인아이디)로 조회한후 해당 Element값 저장
		element = cache.get(key);
	    //캐시에서 조회한 값이 존재한다면 그 Key값의 Value값 프로그램 캐시 객체을 List형식으로 다시 저장
		if(StringUtil.isNotEmpty(element))resDto = (List<ProgramCache>) element.getObjectValue();
			
		//List로 담긴 프로그램 권한캐시 객체를 조회하면서 요청받은 URL이 존재한다면 해당 프로그램객체값을 저장
		// db에서 가져온 url만 처리하도록 개선 하세요... to 서정환..
		for(ProgramCache pgm : resDto) {			
			if(pgm.getUrl().equals(inUrl)) {
				pgmResDto = pgm;
				break;
			}
		}
	
		return pgmResDto;
	}

}
