package com.icignal.core.exception;

/**
 * 금칙어를 포함할때 사용하는 예외 클래스
 * 
 * @author jskim
 *
 */
public class DataBanWordRequestException extends BaseException{
	private static final long serialVersionUID = 7095599426649312338L;

	public DataBanWordRequestException(){
		super();
	}

	public DataBanWordRequestException(String message){
		super(message);
	}
	
	public DataBanWordRequestException(Throwable cause, String message){
		super(cause, message);
	}
}
