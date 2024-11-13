 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.annotation.handler;

import java.lang.annotation.Annotation;
import java.util.Optional;

/**
 * 1. FileName	: PersonalDataHandler.java
 * 2. Package	: com.icignal.core.annotation.handler
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 28. 오후 3:44:15
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 28.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: PersonalDataHandler
 * 2. 파일명	: PersonalDataHandler.java
 * 3. 패키지명	: com.icignal.core.annotation.handler
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 28.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public abstract class AnnotationHandler {

	 protected Object item;
	
	 /*
	  * 1. 메소드명: isAnotationObject
	  * 2. 클래스명: AnnotationHandler
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	어노테이션 객체여부를 확인한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param targetObj 검사할 객체
	 *   @param cls 어노테이션 클래스
	 *   @return 어노테이션객체여부
	 */
	public final static boolean  isAnotationObject(Object targetObj , Class<? extends Annotation> cls) {
		return Optional.ofNullable(targetObj)
					   .map(x -> Optional.ofNullable(targetObj.getClass().getAnnotation(cls))
							             .map(o-> true)
							             .orElse(false))
					   .orElse(false);
    }
	
	public Object getItem() {
		return this.item;
	}
	
	
	
	 /*
	  * 1. 메소드명: proceed
	  * 2. 클래스명: AnnotationHandler
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	어노테이션에  객체에 대해 작업을 수행한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param targetOb	
	 */
	protected abstract  void proceed(Object targetOb);


	
	
	
}

