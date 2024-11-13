package com.icignal.core.exception;

/**
 * SQL 에러가 났을때 사용하는 클래스
 * 
 * @author jskim
 *
 */
public class DataSQLException extends BaseException{
	private static final long serialVersionUID = -3798149102977208426L;

	public DataSQLException(){
		super();
	}

	public DataSQLException(String message){
		super(message);
	}
	
	public DataSQLException(Throwable cause, String message){
		super(cause, message);
	}
}
