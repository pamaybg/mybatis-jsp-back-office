package com.icignal.core.security.dbconinfo.impl;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.core.env.Environment;

import com.icignal.core.security.dbconinfo.DBConnectionInfo;

public class LocalMartDBConnectionInfo  extends DBConnectionInfo {

	public static final String ENV_PATH = "icignal.db-connection-info.local.mart-db";


	@Override
	public void registerProps(Environment env) {    
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();

		encryptor.setPassword(env.getProperty("icignal.security.properties-data-encryption.password"));

		String driverClassName =	encryptor.decrypt(env.getProperty(ENV_PATH.concat(".driver-class-name")));
		String dataSourceClassName =	encryptor.decrypt(env.getProperty(ENV_PATH.concat(".data-source-class-Name")));
		String jdbcUrl =	encryptor.decrypt(env.getProperty(ENV_PATH + ".jdbc-url"));
		String userName =	encryptor.decrypt(env.getProperty(ENV_PATH + ".username"));
		String password =	encryptor.decrypt(env.getProperty(ENV_PATH + ".password"));

		setDriverClassName(driverClassName);
		setDataSourceClassName(dataSourceClassName);
		setUrl(jdbcUrl);
		setUserName(userName);
		setPassword(password);
	}
	
	


}
