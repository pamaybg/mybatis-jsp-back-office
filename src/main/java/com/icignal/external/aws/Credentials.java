package com.icignal.external.aws;

import com.amazonaws.auth.BasicAWSCredentials;

public class Credentials {

	public BasicAWSCredentials creds; 
	
	/**
	 * AWS 자격증명 객체를 생성한다
	 * @Method Name : createAWSCredentials
	 * @작성일   		: 2020. 1. 28.
	 * @작성자   		: knlee
	 * @변경이력  		:
	 * @Method 설명 	:
	 * @param accesskey
	 * @param secretkey
	 * @return
	 */
	public void createAWSCredentials(String accesskey, String secretkey) {
		 creds = new BasicAWSCredentials(accesskey, secretkey);
	}
	
	public BasicAWSCredentials getBasicAWSCredentials() {
		return creds;
	}
	
	
}
