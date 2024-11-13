/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: Decrypted.java
 * 2. Package	: com.icignal.core.annotation
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 15. 오후 11:54:12
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 15.		 | knlee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.core.annotation.personaldata;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;


/*
 * 1. 클래스명	: Decrypted
 * 2. 파일명	: Decrypted.java
 * 3. 패키지명	: com.icignal.core.annotation
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 15.
 */
/**
 * <PRE>
 * masked : 
 * 	 	full -> 전체 문자열 마스킹
 * 		tel  -> 전화번호 마스킹(010****1234)
 * 		custNm -> 이름 ( 홍*동)
 *      email -> k***@naver.com
 *      none -> 전체문자열 복호화
 *      cardNum -> 1234********3456
 *      webId -> k**3 
 * 
 * </PRE>
 */
@Documented
@Retention(RUNTIME)
@Target(FIELD)
public @interface Decrypted  {
	String masked() default "none";
}
