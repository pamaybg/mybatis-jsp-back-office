 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


/**
 * 1. FileName	: HttpUtil.java
 * 2. Package	: com.icignal.core.util
 * 3. Comments	:	HTTP 관련 유틸리티
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 18. 오전 10:21:34
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 18.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: HttpUtil
 * 2. 파일명	: HttpUtil.java
 * 3. 패키지명	: com.icignal.core.util
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 18.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class HttpUtil {

	 /*
	  * 1. 메소드명: covertJsonString
	  * 2. 클래스명: HttpUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		DTO 및 VO 오브젝트를 Json 문자열로 변환하여 반환한다. 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param obj  변환할 VO 및 DTO 객체
	 *   @return json 문자열
	 */
	public static final String covertJsonString(final Object obj) {
		
	  return Optional.ofNullable(obj)
			  		 .map(o -> {
								 try {
										return new ObjectMapper().writeValueAsString(o);
								     } catch (JsonProcessingException e) { LogUtil.error(e); return "";}
			
			  		 			})
			  		 .orElse("");
		
		
	}
	
	
	


	public static void main(String[] args) {

		Map<String, String> map = new HashMap<>();
		map.put("duplicatedLogin", "false");
		map.put("pwChangeExp", "true");
		String mapper =	HttpUtil.covertJsonString(map);
		LogUtil.info("mapper: " + mapper);
		
		
	}
	
	
	
}

