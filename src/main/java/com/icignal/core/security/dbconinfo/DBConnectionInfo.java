package com.icignal.core.security.dbconinfo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.core.env.Environment;

import com.icignal.core.exception.ApplicationPropertiesException;

public abstract class DBConnectionInfo {

	private String url;
	
	private String driverClassName;
	private String dataSourceClassName;
	
	private String userName;
	
	private String password;
	
	public String  toString(){
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	
	
	public abstract void registerProps(Environment env) throws ApplicationPropertiesException;

	public String getDriverClassName() {
		return this.driverClassName;
	}

	
	public String getUserName() {
		return this.userName;
	}

	
	
	public void setDriverClassName(String driverClassName) {
		this.driverClassName = driverClassName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}


	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}


	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}


	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}


	/**
	 * @param url the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * @return the dataSourceClassName
	 */
	public String getDataSourceClassName() {
		return dataSourceClassName;
	}

	/**
	 * @param dataSourceClassName the dataSourceClassName to set
	 */
	public void setDataSourceClassName(String dataSourceClassName) {
		this.dataSourceClassName = dataSourceClassName;
	}
	
	
	
	
	
}
