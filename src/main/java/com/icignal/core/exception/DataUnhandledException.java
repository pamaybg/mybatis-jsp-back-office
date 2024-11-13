package com.icignal.core.exception;

/**
 * 서버 에러가 났을대 사용하는 클래스
 * 
 * @author jskim
 *
 */
public class DataUnhandledException extends BaseException{
	private static final long serialVersionUID = -2402581569011747367L;

	public DataUnhandledException(){
		super();
	}

	public DataUnhandledException(String message){
		super(message);
	}
	
	public DataUnhandledException(Throwable cause, String message){
		super(cause, message);
	}
}
