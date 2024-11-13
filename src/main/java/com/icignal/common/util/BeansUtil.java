 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;

import com.icignal.core.component.ApplicationContextProvider;
import com.icignal.external.aws.Credentials;

/**
 * 1. FileName	: BeansUtil.java
 * 2. Package	: com.icignal.core.util
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 11. 오후 4:18:12
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 11.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: BeansUtil
 * 2. 파일명	: BeansUtil.java
 * 3. 패키지명	: com.icignal.core.util
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class BeansUtil {
	
	
	 /*
	  * 1. 메소드명: getBean
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	Bean 이름에 대한 빈 객체를 얻어온다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param beanName 빈객체명
	 *   @return	
	 */
	public static Object getBean(String beanName) {
        ApplicationContext applicationContext = ApplicationContextProvider.getApplicationContext();      
        // String array[] =  applicationContext.getBeanDefinitionNames();
       
        return applicationContext.getBean(beanName);
    }
	
	
	 /*
	  * 1. 메소드명: getApplicationProperty
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 * 어플리케이션 프로퍼티스 파일(application.yml)에 저장되어 있는 프로퍼티 값을 가져온다. 
	 *		
	 * 2. 사용법
	 *	BeansUtil.getApplicationProperty("icignal.aws.region");
	 * </PRE>
	 *   @param key
	 *   @return 프로퍼티키에 대한 값	
	 */
	public static String getApplicationProperty(String key) {
		Environment env = (Environment)getBean("env");
		String value = env.getProperty(key);		
		if(value == null ) return "";
		return value;
	}

	
	public static List<String> getApplicationProperties(String key) {
		Environment env = (Environment)getBean("env");
		String value = env.getProperty(key);	
		if(value == null ) return new ArrayList<String>();
		return Arrays.asList(value.split(",")) ;
	}
	
	
	 /*
	  * 1. 메소드명: getEncryptor
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 application.yml 파일내의 데이터를 암호화하는  org.jasypt.encryption.pbe.StandardPBEStringEncryptor 객체를 가져온다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public static StandardPBEStringEncryptor getEncryptor() {
		
		return  (StandardPBEStringEncryptor)getBean("encryptor");
	}
	
	
	
	
	
	 /*
	  * 1. 메소드명: getFileCryptorKey
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	File 암호화키를 리턴한다.	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public static String getFileCryptorKey() {
		
		String key = (String)getBean("fileCryptorKey");
		
		if(key.indexOf("@@@!!!") != -1)	return Arrays.asList(key.split("@@@!!!")).get(1);		
		return key;

		
	}
	
	

	
	 /*
	  * 1. 메소드명: getAWSCredentials
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	AWS 자격증명 객체 (Credentials)를 가져온다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public static Credentials getAWSCredentials() {
		
		Credentials creds = new Credentials();		
		 creds.createAWSCredentials(getEncryptor().decrypt(getApplicationProperty("aws.credentials.access-key")),
				getEncryptor().decrypt(getApplicationProperty("aws.credentials.secret-key")));
		return creds;
	}
	
	
	

	 /*
	  * 1. 메소드명: getAwsRegion
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	aws region 정보를 가졍온다
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public static String getAwsRegion() {
		return BeansUtil.getApplicationProperty("aws.region");
	}
	
	
	 /*
	  * 1. 메소드명: getAwsBucketName
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	AWS BucketName을 가져온다
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public static String getAwsBucketName() {
		return BeansUtil.getApplicationProperty("aws.s3.bucket-name");
	}
	
	
	
	
	 /*
	  * 1. 메소드명: getApplicationProperties
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		어플리케이션 프로퍼티스 파일(application.yml)에 저장되어 있는 프로퍼티 값을 가져온다.
	 * 2. 사용법
	 *		int val = BeansUtils.getApplicationProperty("icignal.login.lock.cnt", Integer.class)
	 * </PRE>
	 *   @param key
	 *   @param targetType
	 *   @return	
	 */
	public static <T> T getApplicationProperty(String key, Class<T> targetType) {
		Environment env = (Environment)getBean("env");
		return  env.getProperty(key, targetType);
	}
	
	
	 /*
	  * 1. 메소드명: getApplicationProperty
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	어플리케이션 프로퍼티스 파일(application.yml)에 저장되어 있는 프로퍼티 값을 가져온다.
	 *
	 * 2. 사용법
	 *  ex) BeansUtil.getApplicationProperty("icignal.async.thread-pool.init", Integer.class , 1)		
	 * </PRE>
	 *   @param string 프로퍼티 키
	 *   @param class1 반환타입.
	 *   @param i  null일경우 디폴트값
	 *   @return	
	 */
	
	public static <T> T getApplicationProperty(String key, Class<T> targetType, T defaultValue) {
		Environment env = (Environment)getBean("env");
		return  env.getProperty(key, targetType, defaultValue);
	}
	
	
	
	 /*
	  * 1. 메소드명: getDbEncryptDataKey
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 * DB 암호화 키중 데이터키만을 리턴한다.
	 * </PRE>
	 *   @return DB암호화 데이터키 문자열
	 */
	public static String getDbEncryptDataKey() {
		return Arrays.asList(BeansUtil.getDBEncryptKey().split("@@@!!!")).get(1);
	}

	
	 /*
	  * 1. 메소드명: getDBEncryptKey
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 * DB 암호화 키를 리턴한다. (HMAC문자열 + 구분문자열 + 데이터키) 
	 * </PRE>
	 *   @return DB암호화키 문자열
	 */
	public static String getDBEncryptKey() {
		return (String)BeansUtil.getBean("dbCryptorKey");
	}
	
	
	 /*
	  * 1. 메소드명: getPropDataEnvPwd
	  * 2. 클래스명: BeansUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	Application Property 의  암호화된 문자열 복호화를 위한 키를 반환한다.	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return 암호화키
	 */
	public static String getPropertyEncryptKey() {
		return BeansUtil.getApplicationProperty("icignal.security.properties-data-encryption.password");
	}


	

}