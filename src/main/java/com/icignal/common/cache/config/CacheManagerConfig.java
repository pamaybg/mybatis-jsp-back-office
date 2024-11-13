package com.icignal.common.cache.config;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import com.icignal.common.cache.service.CacheManagerService;

/*
 * 1. 클래스명	: CacheMgtConfig
 * 2. 파일명	: CacheMgtConfig.java
 * 3. 패키지명	: com.icignal.common.cache.config
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 01. 10.
 */
/**
 * <PRE>
 * 1. 설명
 * cache 관련 configuration
 * </PRE>
 */ 
@Configuration
public class CacheManagerConfig  {
	
		@Autowired
		CacheManagerService cacheMgtService;

		 /*
		  * 1. 메소드명: cacheManager
		  * 2. 클래스명: CacheMgtConfig
		  * 3. 작성자명: hr.noh
		  * 4. 작성일자: 2020. 1. 17.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 * CacheManager Bean으로 등록	
		 * 2. 사용법
		 * Bean 어노테이션 사용		
		 * </PRE>
		 *   @return CacheManager	
		 */ 
		@Bean 
		public CacheManager cacheManager() {
		//	 return new EhCacheCacheManager(ehCacheCacheManager().getObject());		
			return new EhCacheCacheManager( Optional.ofNullable(ehCacheCacheManager().getObject()).get());
			
		}
		
		 /*
		  * 1. 메소드명: ehCacheCacheManager
		  * 2. 클래스명: CacheMgtConfig
		  * 3. 작성자명: hr.noh
		  * 4. 작성일자: 2020. 1. 17.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 * ehcache.xml파일을 읽어서 EhCacheManagerFactoryBean객체를 Bean으로 등록		
		 * 2. 사용법
		 * ehcache.xml를 클래스 경로에서 얻어와서 FactoryBean을 만들어낸다
		 * </PRE>
		 *   @return EhCacheManagerFactoryBean	
		 */
		@Bean 
		public EhCacheManagerFactoryBean ehCacheCacheManager() {
			EhCacheManagerFactoryBean factory = new EhCacheManagerFactoryBean();
			factory.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("/conf/cache/ehcache.xml"));
			factory.setShared(true); 
			return factory; 
		} 

		//@Bean
		 /*
		  * 1. 메소드명: selectMessageProperties
		  * 2. 클래스명: CacheMgtConfig
		  * 3. 작성자명: hr.noh
		  * 4. 작성일자: 2020. 1. 17.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 * ehcache를 이용하여 caching 현재 사용하지않음		
		 * 2. 사용법
		 * ehcache를 이용하여 caching 현재 사용하지않음		
		 * </PRE>
		 *   @return
		 *   @throws Exception	
		 */
		public List<Map<String, String>> selectMessageProperties() throws Exception{
			 
			//servlet_local.properties 에 있는 값을 가져온다.
			//String prop = Common.getInstance().getServletProp("view.message.property.use"); 
			//getApplicationPropertiesValue(이건 yml파읽어오는것임)
			//null 값에대한 예외처리와 DB/FILE 값에대한 처리
			/*if(prop !=null && prop.equals("DB")) { 
				return cacheMgtService.selectMessageProperties(); 
			}else { 
				return null; 
			}*/
			return null;

		}
	
		//@Bean
		 /*
		  * 1. 메소드명: selectCommCodeCache
		  * 2. 클래스명: CacheMgtConfig
		  * 3. 작성자명: jh.seo 
		  * 4. 작성일자: 2020. 2. 19.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 * 공통코드 프로퍼티를 생성(DB조회 (캐시사용유무가 Y인것만)		
		 * 2. 사용법
		 * 공통코드 객체를 List map으로 가져와서 저장
		 * </PRE>
		 *   @return
		 *   @throws Exception	
		 */
		public List<Map<String, String>> selectCommCodeCache() throws Exception{
			List<Map<String, String>> map = null;
			map = cacheMgtService.selectCommCode();
			
			return map;
		}
		
		

		
}
