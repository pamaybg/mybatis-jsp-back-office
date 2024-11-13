package com.icignal.core.exception;

import com.icignal.common.util.LogUtil;

/**
 * 파일이 없을경우 exception 클래스
 * 
 * @author jskim
 *
 */
public class FileNameErrorException extends BaseException{
	private static final long serialVersionUID = -3798149102977208426L;

	public FileNameErrorException(){
		super();
	}

	public FileNameErrorException(String message){
		super(message);
		LogUtil.error(message);
	}
	
	public FileNameErrorException(Throwable cause, String message){
		super(cause, message);
	}
}
