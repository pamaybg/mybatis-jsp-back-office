package com.icignal.external.aws;

import java.util.Map;

import org.springframework.boot.json.JsonParserFactory;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.services.secretsmanager.AWSSecretsManager;
import com.amazonaws.services.secretsmanager.AWSSecretsManagerClientBuilder;
import com.amazonaws.services.secretsmanager.model.AWSSecretsManagerException;
import com.amazonaws.services.secretsmanager.model.CreateSecretRequest;
import com.amazonaws.services.secretsmanager.model.DeleteSecretRequest;
import com.amazonaws.services.secretsmanager.model.GetSecretValueRequest;
import com.amazonaws.services.secretsmanager.model.UpdateSecretRequest;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.exception.DataFailException;
import com.icignal.external.aws.dto.request.AwsSecretManagerReqDto;

/*
 * 1. 클래스명	: SecretsManager
 * 2. 파일명	: SecretsManager.java
 * 3. 패키지명	: com.icignal.external.aws
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 3. 6.
 */
/**
 * <PRE>
 * 1. 설명 : AWS SecretsManager 서비스 관리 객체
 *
 * 2. 사용법: 
 *  
 *				Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
				 BeansUtil.getAwsRegion()
				 ).getSecretMap(dbInfo.getSecretNm());
				
 *
 * </PRE>
 */ 
public final class SecretsManager  {

	private Credentials creds;

	private String region;

	private AWSCredentialsProvider credentialsProvider;
	private AWSSecretsManager clientBuilder;

	public SecretsManager(Credentials creds, String region) {
		this.creds = creds;
		this.region = region;
		createAWSSecretsManager();
	}
	
	

	public AWSSecretsManager createAWSSecretsManager() {

		credentialsProvider = new AWSStaticCredentialsProvider(creds.getBasicAWSCredentials());
		clientBuilder = AWSSecretsManagerClientBuilder.standard()
		    		.withCredentials(credentialsProvider)
		    		.withRegion(region)
		    		.build();

        return clientBuilder;

	}

	/**
	 * secrete name에 저장되어 있는 문자열을 가져온다.
	 * @Method Name : getSecretString
	 * @작성일   		: 2020. 1. 28.
	 * @작성자   		: knlee
	 * @변경이력  		:
	 * @Method 설명 	:
	 * @param secreteName
	 * @return secrete name에 저장되어 있는 문자열
	 */
	public String getSecretString(String secreteName) {
		
		return  this.clientBuilder.getSecretValue(new GetSecretValueRequest().withSecretId(secreteName)).getSecretString();
	}
	
	
	
	 /*
	  * 1. 메소드명: getSecretMap
	  * 2. 클래스명: SecretsManager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 3. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		secretName에 저장되어 있는 json 문자열을 map 객체로 반환한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param secreteName
	 *   @return	json 맵 객첵
	 */
	public Map<String, Object> getSecretMap(String secreteName){
		return JsonParserFactory.getJsonParser().parseMap(  getSecretString(secreteName));
		
	}
	
	

	 /*
	  * 1. 메소드명: createSecret
	  * 2. 클래스명: SecretsManager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public boolean createSecret(AwsSecretManagerReqDto param) {
		CreateSecretRequest createSecretRequest = new CreateSecretRequest();
		createSecretRequest.setRequestCredentialsProvider(credentialsProvider);
	    createSecretRequest.setName(param.getName());
	    createSecretRequest.setDescription(param.getDescription());
	    createSecretRequest.setSecretString(StringUtil.getJSONtoObject(param.getSecretKeyValue()));
	    boolean result = false;
		try {
		    result = clientBuilder.createSecret(createSecretRequest).getSdkHttpMetadata().getHttpStatusCode() == 200 ?  true : false;
		  } catch(AWSSecretsManagerException e) {
			 LogUtil.error(e);
		//	  throw new DataFailException("AWS SecretKey creation failed. " + e.getErrorMessage());  //작업도중실패
		  }
		return result;
	    
	}

	  /*
	  * 1. 메소드명: editSecretKey
	  * 2. 클래스명: SecretsManager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public boolean editSecretKey(AwsSecretManagerReqDto param) {
		UpdateSecretRequest updateSecretRequest = new UpdateSecretRequest();
		//요청객체 세팅
		updateSecretRequest.setRequestCredentialsProvider(credentialsProvider);
		updateSecretRequest.setSecretId(param.getSecretId());
		updateSecretRequest.setDescription(param.getDescription());
		updateSecretRequest.setSecretString(StringUtil.getJSONtoObject(param.getSecretKeyValue()));
		boolean result = false;
		try {	
			 return clientBuilder.updateSecret(updateSecretRequest).getSdkHttpMetadata().getHttpStatusCode() == 200 ? true : false;
		} catch(AWSSecretsManagerException e) {
			LogUtil.error(e);
			//throw new DataFailException("AWS SecretKey edit failed " + e.getErrorMessage());
		}
		return result;
	 }



	  /*
	  * 1. 메소드명: removeSecretKey
	  * 2. 클래스명: SecretsManager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 10.
	  */
	/**
	 * <PRE>
	 * 1. sec
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public boolean removeSecretKey(AwsSecretManagerReqDto param) {
		DeleteSecretRequest deleteSecretRequest = new DeleteSecretRequest();			
		deleteSecretRequest.setRequestCredentialsProvider(credentialsProvider);
		deleteSecretRequest.setSecretId(param.getSecretId());
		deleteSecretRequest.setRecoveryWindowInDays(param.getRecoveryWindowInDays());
		boolean result = false;
		try {
			return clientBuilder.deleteSecret(deleteSecretRequest).getSdkHttpMetadata().getHttpStatusCode() == 200 ? true : false;
		} catch(AWSSecretsManagerException e) {
			LogUtil.error(e);
			//throw new DataFailException("AWS SecretKey remove failed. : " + e.getErrorMessage()); //작업도중실패
		}
		return result;
	 }



	public Credentials getCreds() {
		return creds;
	}



	public void setCreds(Credentials creds) {
		this.creds = creds;
	}



	public String getRegion() {
		return region;
	}



	public void setRegion(String region) {
		this.region = region;
	}



	public AWSCredentialsProvider getCredentialsProvider() {
		return credentialsProvider;
	}



	public void setCredentialsProvider(AWSCredentialsProvider credentialsProvider) {
		this.credentialsProvider = credentialsProvider;
	}



	public AWSSecretsManager getClientBuilder() {
		return clientBuilder;
	}



	public void setClientBuilder(AWSSecretsManager clientBuilder) {
		this.clientBuilder = clientBuilder;
	}
	
	
	



}
