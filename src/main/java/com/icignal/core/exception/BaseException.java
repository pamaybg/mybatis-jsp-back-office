package com.icignal.core.exception;

/**
 * 최상위 예외 클래스
 * 
 * @author jskim
 *
 */
public class BaseException extends RuntimeException{
	private static final long serialVersionUID = -2194023170637886663L;
	private String baseMessage;
	private String message;
	public BaseException(){
		super();
	}

	public BaseException(String message){
		super();
		this.message = message; 
		this.setBaseMessage(this.message);
	}

	public BaseException(Throwable cause, String message) {
		super(cause);
		this.message = message;
		this.setBaseMessage(this.message);
	}

	public String getBaseMessage() {
		return baseMessage;
	}

	public void setBaseMessage(String baseMessage) {
		this.baseMessage = baseMessage;
	}
}
