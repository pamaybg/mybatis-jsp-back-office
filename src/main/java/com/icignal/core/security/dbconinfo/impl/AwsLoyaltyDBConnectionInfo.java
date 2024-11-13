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

public class AwsLoyaltyDBConnectionInfo extends DBConnectionInfo {

	private static final String PROP_ENC_PASSWORD ="icignal.security.properties-data-encryption.password";
	private static final String ACCESSKEY ="aws.credentials.accesskey";
	private static final String SECRETKEY ="aws.credentials.secretkey";
	private static final String SECRETNAME ="aws.service.secret-manager.secret-name.loyalty-database";
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
