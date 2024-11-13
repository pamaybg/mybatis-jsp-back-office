package com.icignal.core.exception;

/**
 * 클라이언트의 잘못된 요청으로 처리할 수 없을때 사용하는 예외 클래스
 * 
 * @author jskim
 *
 */
public class DataBadRequestException extends BaseException{
	private static final long serialVersionUID = 7095599426659312339L;

	public DataBadRequestException(){
		super();
	}

	public DataBadRequestException(String message){
		super(message);
	}
	
	public DataBadRequestException(Throwable cause, String message){
		super(cause, message);
	}
}
