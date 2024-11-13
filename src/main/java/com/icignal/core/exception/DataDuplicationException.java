package com.icignal.core.exception;

/**
 * 데이타 중복 관련 예외 처리 클래스
 * 
 * @author jskim
 *
 */
public class DataDuplicationException extends BaseException{
	private static final long serialVersionUID = 3210742995308188209L;

	public DataDuplicationException(){
		super();
	}
	
	public DataDuplicationException(String message){
		super(message);
	}
	
	public DataDuplicationException(Throwable cause, String message){
		super(cause, message);
	}
}
