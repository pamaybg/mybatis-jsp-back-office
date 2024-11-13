 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.cache.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

/**
 * 1. FileName	: ChacheMapper.java
 * 2. Package	: com.icignal.common.chache.mapper
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 19. 오전 11:23:09
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 19.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: ChacheMapper
 * 2. 파일명	: ChacheMapper.java
 * 3. 패키지명	: com.icignal.common.chache.mapper
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface CacheManagerMapper {

	 /*
	  * 1. 메소드명: selectMessageProperties
	  * 2. 클래스명: CacheMapper
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	메시지프로퍼티를  조회한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public List<Map<String, String>> selectMessageProperties ();

	 /*
	  * 1. 메소드명: selectCommCode
	  * 2. 클래스명: CacheMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 공통코드를  조회한다.		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public List<Map<String, String>> selectCommCode();
	
	
	
}

