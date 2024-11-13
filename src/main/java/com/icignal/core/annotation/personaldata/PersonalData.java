 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.annotation.personaldata;

import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;




/**
 * 1. FileName	: PersonalData.java
 * 2. Package	: com.icignal.core.annotation
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 14. 오후 5:03:20
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 14.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: PersonalData
 * 2. 파일명	: PersonalData.java
 * 3. 패키지명	: com.icignal.core.annotation
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 14.
 */
/**
 * <PRE>
 * 1. 설명 
 * 개인정보 항목이 들어 있음을 알려주는 어노테이션
 * </PRE>
 */
@Documented
@Retention(RUNTIME)
@Target(TYPE)
public @interface PersonalData {

 
	
}

