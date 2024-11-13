package com.icignal.core.security.dataencryption;


import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.core.env.Environment;

public interface DataEncryption {

	/**
	 * 데이터 암호화 키를 리턴함.
	 * @Method Name : getDataEncryptionKey
	 * @작성일   		: 2020. 1. 31.
	 * @작성자   		: knlee
	 * @변경이력  		:
	 * @Method 설명 	:
	 * @return
	 * @throws Exception 
	 */
	public String getDataEncryptionKey(Environment env, StandardPBEStringEncryptor encryptor ) throws Exception;
	
	
	
}
