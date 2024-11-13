package com.icignal.core.exception;

/**
 * 데이터 입출력 관련 에러가 났을때 사용하는 클래스
 * 
 * @author jskim
 *
 */
public class DataIOException extends BaseException{
	private static final long serialVersionUID = -5205454366372208886L;

	public DataIOException(){
		super();
	}
	
	public DataIOException(String message){
		super(message);
	}
	
	public DataIOException(Throwable cause, String message){
		super(cause, message);
	}
}
