package com.icignal.common.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 로그 관련 Util 클래스
 * 
 * @author dg.ryu
 * 
 */
public class LogUtil {

	static final Logger logger = LoggerFactory.getLogger(LogUtil.class);
	
	/**
	 * 파라미터 로그 작성 함수
	 * 
	 * @param param 파라미터
	 */
	public  final static void param(Class cls, Object param) {
		StackTraceElement[] stacktrace = Thread.currentThread().getStackTrace();
		StackTraceElement e = stacktrace[2];//maybe this number needs to be corrected
		String methodName = e.getMethodName();
		
		if (param == null){
			logger.debug("null");
		}
		else if(param.getClass().getName().equalsIgnoreCase("string")){
			
			logger.debug(param.toString());
		}else{
			logger.debug("(" + cls.getName() + ")["+methodName+"]" +  StringUtil.getJSONtoObject(param).trim().replace("\r\n", ""));
		}
	}

	/**
	 * 에러 로그 작성 함수
	 * 
	 * @param message 에러 메시지
	 */
	public  final static void error(String message) {
		logger.error(message);
	}
	
	/**
	 * 에러 로그 작성 함수
	 * 
	 * @param message 에러 메시지
	 */
	public final static void error(Exception e) {
		logger.error("Exception: ", e);
	}
	
	/**
	 * 에러 로그 작성 함수
	 * 
	 * @param message 에러 메시지
	 */
	public final static void error(String message, Exception e) {
		logger.error(message, e);
	}
	
	

	/**
	 * 디버그 로그 작성 함수
	 * 
	 * @param message 디버깅 메시지
	 */
	public  final static void debug(String message) {
		logger.debug(message);
	}

	/**
	 * 인포 로그 작성 함수
	 * 
	 * @param message 디버깅 메시지
	 */
	public  final static void info(String message) {
		logger.info(message);
	}
	
	
}
