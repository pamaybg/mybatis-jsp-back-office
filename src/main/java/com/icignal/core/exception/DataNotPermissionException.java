package com.icignal.core.exception;

/**
 * 인증 처리되지 않은 회원이 Data를 요청했을때 사용하는 클래스
 * 
 * @author jskim
 *
 */
public class DataNotPermissionException extends BaseException{
	private static final long serialVersionUID = -7073560354114867975L;

	public DataNotPermissionException(){
		super();
	}

	public DataNotPermissionException(String message){
		super(message);
	}
	
	public DataNotPermissionException(Throwable cause, String message){
		super(cause, message);
	}
}
