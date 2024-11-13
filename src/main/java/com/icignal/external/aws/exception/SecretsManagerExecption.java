package com.icignal.external.aws.exception;
import com.icignal.core.component.Messages;
/**
 * @author hy.jun
 * @description : AWS Secrets Manager 구성 에러 
 *
 */
public class SecretsManagerExecption extends Exception {
	
	private static final long serialVersionUID = -5425105460401693735L;

	public SecretsManagerExecption(){
		super();
	}
	
	public SecretsManagerExecption(String message) {
		super(message);
	}
	
	public SecretsManagerExecption(String message, String lang) {
		super(Messages.getMessage(message, lang));
	}
}
