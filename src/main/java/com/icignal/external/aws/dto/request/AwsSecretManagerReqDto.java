package com.icignal.external.aws.dto.request;

import java.util.Map;

import net.sf.oval.constraint.MaxLength;

/**
* @name : infavor.base.dto.request.AWSSMCreateSecretRequestDTO
* @date : 2019. 2. 8.
* @author : hy.jun
* @description : AWS 시크릿매니저
*/
public class AwsSecretManagerReqDto {
	
	@MaxLength(64)
	private String name;
	@MaxLength(2048)
	private String description;
	private Map<String,String> secretKeyValue;
	
	private String secretId;
	
	private Long recoveryWindowInDays; //삭제 대기 (ex)30:30일 유예)
	
	public Long getRecoveryWindowInDays() {
		return recoveryWindowInDays;
	}
	public void setRecoveryWindowInDays(Long recoveryWindowInDays) {
		this.recoveryWindowInDays = recoveryWindowInDays;
	}

	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setSecretKeyValue(Map<String, String> secretKeyValue) {
		this.secretKeyValue = secretKeyValue;
	}
	public Map<String, String> getSecretKeyValue() {
		return secretKeyValue;
	}
	/**
	 * @return the secretId
	 */
	public String getSecretId() {
		return secretId;
	}
	/**
	 * @param secretId the secretId to set
	 */
	public void setSecretId(String secretId) {
		this.secretId = secretId;
	}
}
