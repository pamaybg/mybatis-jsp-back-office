 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.component;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
 * 1. FileName	: ApplicationContextProvider.java
 * 2. Package	: com.icignal.core.component
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 11. 오후 4:11:36
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 11.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: ApplicationContextProvider
 * 2. 파일명	: ApplicationContextProvider.java
 * 3. 패키지명	: com.icignal.core.component
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
/*
 * 1. 클래스명	: ApplicationContextProvider
 * 2. 파일명	: ApplicationContextProvider.java
 * 3. 패키지명	: com.icignal.core.component
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Component
public class ApplicationContextProvider implements ApplicationContextAware{
	
	
	private static ApplicationContext applicationContext;

	

	/*
	 * 1. 메소드명: setApplicationContext
	 * 2. 클래스명: ApplicationContextAware
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 2. 11.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 *   @param applicationContext
	 *   @throws BeansException	
	 */
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {

		ApplicationContextProvider.applicationContext = applicationContext;
		
	}
	
	
	 /*
	  * 1. 메소드명: getApplicationContext
	  * 2. 클래스명: ApplicationContextProvider
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		spring IoC Container(ApplicationContext)에서 관리되는 Bean을 찾기 위해 ApplicationContext 객체를 가져옴
	 * 2. 사용법
	 *		static 메서드 및  new로 생성한 인스턴스에서 Bean을 참조해야 할 경우 이용
	 * </PRE>
	 *   @return	
	 */
	public static   ApplicationContext getApplicationContext() {
        return applicationContext;
    }




}

