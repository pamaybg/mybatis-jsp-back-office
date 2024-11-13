 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.security.dbconinfo.impl;

import java.util.Map;
import java.util.Optional;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.modelmapper.ModelMapper;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.core.env.Environment;

import com.icignal.common.util.LogUtil;
import com.icignal.core.exception.ApplicationPropertiesException;
import com.icignal.core.security.dbconinfo.DBConnectionInfo;
import com.icignal.external.aws.Credentials;
import com.icignal.external.aws.SecretsManager;

/**
 * 1. FileName	: AwsMartDBConnectionInfo.java
 * 2. Package	: com.icignal.security.dbconinfo.impl
 * 3. Comments	: AWS Secret Manager에 등록되어 있는 Mart DB 정보를 획득하는 클래스 
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 5. 오후 9:06:11
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 5.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: AwsMartDBConnectionInfo
 * 2. 파일명	: AwsMartDBConnectionInfo.java
 * 3. 패키지명	: com.icignal.security.dbconinfo.impl
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class AwsMartDBConnectionInfo  extends DBConnectionInfo {

	private static final String PROP_ENC_PASSWORD ="icignal.security.properties-data-encryption.password";
	private static final String ACCESSKEY ="aws.credentials.accesskey";
	private static final String SECRETKEY ="aws.credentials.secretkey";
	private static final String SECRETNAME ="aws.service.secret-manager.secret-name.mart-database";
	private static final String REGION ="aws.region";
	
	
	
	public void registerProps(Environment env) throws ApplicationPropertiesException {
				
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();

		encryptor.setPassword(Optional.ofNullable(env.getProperty(PROP_ENC_PASSWORD))
				.orElseThrow(() -> new ApplicationPropertiesException("Application Properties Key [ "+ PROP_ENC_PASSWORD +"] not found.")));
		
		// 자격증명 생성
		Credentials creds = new Credentials();
		creds.createAWSCredentials(encryptor.decrypt(Optional.ofNullable(env.getProperty(ACCESSKEY))
															 .orElseThrow(() -> new ApplicationPropertiesException(
																	 "Application Properties Key [ "+ ACCESSKEY +"] not found. ")))		
								  ,encryptor.decrypt(Optional.ofNullable(env.getProperty(SECRETKEY))
										  					  .orElseThrow(() -> new ApplicationPropertiesException(
										  							  "Application Properties Key [ "+ SECRETKEY +"] not found. ")))
								  );
		LogUtil.info("region: " + env.getProperty(REGION));
		SecretsManager sm = new SecretsManager(creds, Optional.ofNullable(env.getProperty(REGION))
				 .orElseThrow(() -> new ApplicationPropertiesException("Application Properties Key ["+ REGION +"] not found.")));
		
		sm.createAWSSecretsManager();
		
		String secretStr = sm.getSecretString(
				encryptor.decrypt(Optional.ofNullable(env.getProperty(SECRETNAME))
				.orElseThrow(() -> new ApplicationPropertiesException("Application Properties Key ["+ SECRETNAME +"] not found."))
				));

		Map<String, Object> map = JsonParserFactory.getJsonParser().parseMap(secretStr);
		ModelMapper modelMapper = new ModelMapper();
		modelMapper.map(map, this);

	}
	

}

