package com.icignal.core.exception;

public class MbrException extends BaseException{
	/*
	 * 1. 필드종류	: long
	 * 2. 필드명	: serialVersionUID
	 * 3. 작성자명	: knlee
	 * 4. 작성일자: 2020. 2. 27.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * </PRE>
	 */
	private static final long serialVersionUID = 1L;
	private int errorType;
	
	public MbrException(){
		super();
	}

	public MbrException(String message){
		super(message);
	}
	
	public MbrException(Throwable cause, String message){
		super(cause, message);
	}
	
	public MbrException(int errorType, String message){
		super(message);
		this.errorType = errorType;
	}

	public int getErrorType() {
		return errorType;
	}

	public void setErrorType(int errorType) {
		this.errorType = errorType;
	}
}
