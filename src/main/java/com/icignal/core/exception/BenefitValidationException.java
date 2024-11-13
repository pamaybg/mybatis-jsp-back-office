package com.icignal.core.exception;

import com.icignal.core.component.Messages;

/**
 * 혜택 관련 에러
 * 
 * @author jskim
 *
 */
public class BenefitValidationException extends BaseException{
	private static final long serialVersionUID = 3398559851098583261L;

	public BenefitValidationException(){
		super();
	}

	public BenefitValidationException(String message, String lang) {
		super(Messages.getMessage(message, lang));
	}
	
	public BenefitValidationException(Throwable cause, String message){
		super(cause, message);
	}
}
