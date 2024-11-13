package com.icignal.common.util;

import java.util.Locale;

import org.springframework.context.support.MessageSourceAccessor;

/**
 * 메시지 관련 클래스
 * 
 * @author dg.ryu
 *
 */
public class MessagesUtil {

	private static MessageSourceAccessor msAcc;
	
	/**
	 * Set the MessageSourceAccessor
	 * 
	 * @param msAcc		MessageSourceAccessor
	 */
	public void setMessageSourceAccessor(MessageSourceAccessor msAcc){
			MessagesUtil.msAcc = msAcc;
	 }
	 
	public static String getMessage(String key, String lang) {
		return msAcc.getMessage(key, new Locale(lang));
	}
}

