package com.icignal.core.exception;

/**
 * 접근이 거부된 문서를 요청(권한)했을때 사용하는 예외 클래스 
 * 
 * @author jskim
 *
 */
public class DataForbiddenException extends BaseException{
	private static final long serialVersionUID = 3229214704010293009L;

	public DataForbiddenException(){
		super();
	}

	public DataForbiddenException(String message){
		super(message);
	}
	
	public DataForbiddenException(Throwable cause, String message){
		super(cause, message);
	}
}
