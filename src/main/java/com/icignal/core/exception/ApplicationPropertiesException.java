 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.exception;

import com.icignal.core.component.Messages;

/**
 * 1. FileName	: ApplicationPropertiesException.java
 * 2. Package	: com.icignal.core.common.exception
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 7. 오후 7:15:25
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 7.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: ApplicationPropertiesException
 * 2. 파일명	: ApplicationPropertiesException.java
 * 3. 패키지명	: com.icignal.core.common.exception
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 7.
 */
/**
 * <PRE>
 * application propertis (application-***.yml) 미정의 및 오류 발생시 Exception 처리
 *
 * </PRE>
 */

public class ApplicationPropertiesException extends Exception {

	/*
	 * 1. 필드종류	: long
	 * 2. 필드명	: serialVersionUID
	 * 3. 작성자명	: knlee
	 * 4. 작성일자: 2020. 2. 7.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * </PRE>
	 */
	private static final long serialVersionUID = 8673038967697577506L;

	public ApplicationPropertiesException(){
		super();
	}
	
	public ApplicationPropertiesException(String text) {
		super(text);
	}
	
	public ApplicationPropertiesException(String messageKey, String lang) {
		super(Messages.getMessage(messageKey, lang));
	}
	
	
}

