package com.icignal.core.exception;

/**
 * SQL 에러가 났을때 사용하는 클래스
 * 
 * @author jskim
 *
 */
public class DataSQLNonPopException extends BaseException{
	private static final long serialVersionUID = -3798149102977208426L;

	public DataSQLNonPopException(){
		super();
	}

	public DataSQLNonPopException(String message){
		super(message);
	}

	public DataSQLNonPopException(Throwable cause, String message){
		super(cause, message);
	}
}
