package com.icignal.core.security.dataencryption.impl;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.security.Key;
import java.util.Optional;

import javax.crypto.spec.SecretKeySpec;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.env.Environment;

import com.amazonaws.util.IOUtils;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.security.dataencryption.DataEncryption;
import com.icignal.external.aws.Credentials;
import com.icignal.external.aws.KMSManager;

public class FileDataAwsKmsEncryption implements DataEncryption {

	private Logger log = LoggerFactory.getLogger(this.getClass().getName());

	/*
	 * 1. 메소드명: getDataEncryptionKey
	 * 2. 클래스명: DatabaseDataAwsKmsEncryption
	 * 3. 작성자명: knlee
	 * 4. 작성시간: 2020. 1. 31. 오후 5:13:33
	 */

	/**
	 * <PRE>
	 * 1. 설명
	 *	 데이터 암호화키에 대한 문자열을 가져온다.
	 * </PRE>
	 *   @return
	 * @throws Exception
	 */
	@Override
	public String getDataEncryptionKey(Environment env, StandardPBEStringEncryptor encryptor ) throws Exception {

		log.info("########## 데이터베이스 Data 암호화(AWS KMS) Key 생성  ##########");

        String fileName =    Optional.ofNullable(env.getProperty("icignal.security.data-encryption.file.key-file"))
        					.orElseThrow(() -> new NoSuchFieldError("application.properties 항목 [icignal.security.data-encryption.file.key-file]에 대한 value가 셋팅되어 있지 않습니다."));

    	ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
    	InputStream  inputStream = classLoader.getResourceAsStream(fileName);
    	String  stringKey ;
    	try {
	        Optional.ofNullable(inputStream).orElseThrow(() -> new FileNotFoundException("Securety Key File does not exist.")) ;
	    	byte[] keyByte = IOUtils.toByteArray(inputStream);
	    	
	
			//byte => Hex => Base64 byte => SecretKey
	        Key keyObject = new SecretKeySpec(keyByte, "AES");
	
	    	Credentials creds = new Credentials();
			creds.createAWSCredentials(encryptor.decrypt(env.getProperty("aws.credentials.access-key")), encryptor.decrypt(env.getProperty("aws.credentials.secret-key")));
			String region = env.getProperty("aws.region");
	
	    	KMSManager kms = new KMSManager(creds, region);
	
	    	byte[] keyObjectByte = keyObject.getEncoded();
	    	String plainTextDataKey = kms.decrypt(keyObjectByte);
	
	        stringKey = SecurityUtil.generateHMAC(plainTextDataKey, "123456789012") + "@@@!!!" + plainTextDataKey;
	        log.debug("stringKey: " + stringKey);
	    } finally {
	    	inputStream.close();
	    }
		return stringKey;
	}

	/**
	 * ByteBuffer값을 byte 배열로 변환
	 * @param String buf : 바이트 배열로 변환할 ByteBuffer 값
	 * @return byte[] : 변환된 바이트 배열
	 */
	public  byte[] getByteArray(ByteBuffer buf) {
		buf.rewind();
		byte[] byteArray = new byte[buf.remaining()];
		buf.get(byteArray);
		return byteArray;
	}

	public Logger getLog() {
		return log;
	}

	public void setLog(Logger log) {
		this.log = log;
	}
	

}