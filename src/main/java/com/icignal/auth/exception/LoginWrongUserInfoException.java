package com.icignal.auth.exception;

import com.icignal.core.exception.BaseException;

public class LoginWrongUserInfoException extends BaseException{
	public LoginWrongUserInfoException(){
		super();
	}

	public LoginWrongUserInfoException(String message){
		super(message);
	}
	
	public LoginWrongUserInfoException(Throwable cause, String message){
		super(cause, message);
	}
}
