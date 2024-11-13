package com.icignal.core.exception;

/**
 * Delete & Update 실패시 사용하는 예외 클래스
 * 
 * @author jskim
 *
 */
public class DataFailException extends BaseException {
	private static final long serialVersionUID = 3398559851098583261L;

	public DataFailException(){
		super();
	}

	public DataFailException(String message){
		super(message);
	}
	
	public DataFailException(Throwable cause, String message){
		super(cause, message);
	}
}
