 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.component;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 * 1. FileName	: Message.java
 * 2. Package	: com.icignal.core.component
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 24. 오후 3:38:00
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 24.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: Message
 * 2. 파일명	: Message.java
 * 3. 패키지명	: com.icignal.core.component
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class Messages {

	private static MessageSourceAccessor msAcc;
	
	/**
	 * Set the MessageSourceAccessor
	 * 
	 * @param msAcc		MessageSourceAccessor
	 */
	public void setMessageSourceAccessor(MessageSourceAccessor msAcc){
			Messages.msAcc = msAcc;
	 }
	 
	/**
	 * Retrieve the message for the given code and the default Locale
	 * 
	 * @param key	code of the message
	 * @return		the message
	 */
	public static String getMessage(String key, HttpServletRequest req) {
		return msAcc.getMessage(key, RequestContextUtils.getLocale(req));
	}

	public static String getMessage(String key, String lang) {
		return msAcc.getMessage(key, new Locale(lang));
	}
}



