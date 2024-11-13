 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.annotation.commcode;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;


/**
 * 1. FileName	: MarkName.java
 * 2. Package	: com.icignal.core.annotation.commoncode
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 3. 4. 오후 1:28:21
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 3. 4.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: MarkName
 * 2. 파일명	: MarkName.java
 * 3. 패키지명	: com.icignal.core.annotation.commoncode
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 3. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Documented
@Retention(RUNTIME)
@Target(FIELD)
public @interface MarkName {
   String groupCode();
   String codeField();
   
   String lang() default "ko";
	
}

