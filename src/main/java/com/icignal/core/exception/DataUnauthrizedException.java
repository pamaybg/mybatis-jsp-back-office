package com.icignal.core.exception;

/**
 * 클라이언트의 - 인증 실패가 났을때 재로그인 요청시 사용하는 클래스
 * 
 * @author jskim
 *
 */
public class DataUnauthrizedException extends BaseException{
	private static final long serialVersionUID = -7738781356248247048L;

	public DataUnauthrizedException(){
		super();
	}

	public DataUnauthrizedException(String message){
		super(message);
	}
	
	public DataUnauthrizedException(Throwable cause, String message){
		super(cause, message);
	}
}
