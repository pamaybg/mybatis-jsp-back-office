 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.external.aws;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Optional;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.services.s3.model.S3ObjectSummary;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;


/**
 * 1. FileName	: S3Manager.java
 * 2. Package	: com.icignal.external.aws
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 26. 오전 10:16:42
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 26.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: S3Manager
 * 2. 파일명	: S3Manager.java
 * 3. 패키지명	: com.icignal.external.aws
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 * AWS S3 서비스를 이용하기 위한 레퍼 클래스 
 * 2.사용법 :
 		Credentials creds = new Credentials();
		creds.createAWSCredentials(encryptor.decrypt(env.getProperty("aws.credentials.access-key")),
		 encryptor.decrypt(env.getProperty("aws.credentials.secret-key")));
		String region = env.getProperty("aws.region");
    	S3Manager s3 = new S3Manager(creds, region);  	
 *
 * </PRE>
 */

public class S3Manager {

	
	private Credentials creds;

	private String region;

	private String bucketName;
	
	private AWSCredentialsProvider credentialsProvider;
	private AmazonS3 s3Client;
	
	
	public S3Manager() {		
		creds = BeansUtil.getAWSCredentials();
		region = BeansUtil.getAwsRegion();
		bucketName = BeansUtil.getApplicationProperty("aws.s3.bucket-name");
		createAWSS3Clinet();
	}
	
	
	public S3Manager(Credentials creds, String region) {
		this.creds = creds;
		this.region = region;
		createAWSS3Clinet();
	}
	
	
	public S3Manager(Credentials creds, String region, String bucketName) {
		this.creds = creds;
		this.region = region;
		this.bucketName = bucketName;
		this.setBucketName(this.bucketName);
		createAWSS3Clinet();
	}


	 /*
	  * 1. 메소드명: createAWSS3Clinet
	  * 2. 클래스명: S3Manager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	AWS S3를 사용하기 위한 S3Clinet 객체를 생성한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	private void createAWSS3Clinet() {

		credentialsProvider = new AWSStaticCredentialsProvider(creds.getBasicAWSCredentials());
		s3Client = AmazonS3ClientBuilder.standard()
		    		.withCredentials(credentialsProvider)
		    		.withRegion(region)
		    		.build();

	}
	
	
	 /*
	  * 1. 메소드명: getBucketObjectList
	  * 2. 클래스명: S3Manager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 S3 Bucket name에 대한 Object List를 가져온다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bucketName
	 *   @return	
	 */
	public  List<S3ObjectSummary> getBucketObjectList(String bucketName) {
		
		ObjectListing ol = s3Client.listObjects(bucketName);
		
		List<S3ObjectSummary> objects = ol.getObjectSummaries();
		/*
		for (S3ObjectSummary os: objects)  LogUtil.debug("S3Object.key: " + os.getKey());
		*/
		
		return objects; 
		
	}
	
	 /*
	  * 1. 메소드명: getBucketObjectList
	  * 2. 클래스명: S3Manager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	S3 Bucket name (application.yml -> aws.s3.bucket-name) 에 대한 Object List를 가져온다.
	 *      
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public  List<S3ObjectSummary> getBucketObjectList() {	
		return getBucketObjectList(Optional.ofNullable(bucketName)
										   .orElse(BeansUtil.getApplicationProperty("aws.s3.bucket-name")));
	
	}
	
	
	 /*
	  * 1. 메소드명: deleteObject
	  * 2. 클래스명: S3Manager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 Object(파일)를 삭제한다.
	 *   objKey : S3에 저장되어 있는 파일 UUID 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param objKey	
	 */
	public  boolean deleteObject(String objKey) {
		boolean result = false;
		s3Client.deleteObject(this.bucketName, objKey);
		result = true;
		return result;
	}
	
	
	
	 /*
	  * 1. 메소드명: putObject
	  * 2. 클래스명: S3Manager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 Uploads the specified file to Amazon S3 under the specified bucket and key name. 
	 *   특정 key이름에 File을 업로드한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param key S3 버킷에 대한 key 이름
	 *   @param file 업로드할 파일객체
	 *   @return	
	 */
	public boolean putObject(String key, File file) {
		boolean result = false;
		s3Client.putObject(bucketName, key, file);
		result = true;
		return result;
	}



	 /*
	  * 1. 메소드명: getBucketName
	  * 2. 클래스명: S3Manager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 버킷명을 가져온다
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public String getBucketName() {
		return bucketName;
	}
	
	
	
	 /*
	  * 1. 메소드명: writeFile
	  * 2. 클래스명: S3Manager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	S3 저장소에 파일을 작성한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param sourceFileName 작업대상 파일이름
	 *   @param targetFile	S3에 저장할 파일 객체
	 *   @return 성공 여부
	 */
	public boolean writeFile(String sourceFileName , File targetFile) {	
		boolean result = false;
	    S3Object o = s3Client.getObject(this.bucketName, sourceFileName);	    
	    S3ObjectInputStream s3is = o.getObjectContent();        
	    OutputStream os = null;
		try {
			os = new FileOutputStream(targetFile);
			byte[] bufTarget = new byte[s3is.available()];
			int len = 0;
			while ((len = s3is.read(bufTarget)) > 0) os.write(bufTarget, 0, len);
			result = true;
		} catch (IOException e) {
			result = false;
			LogUtil.error(e);
		}finally {
			if(os != null )	try {	os.close();	} catch (IOException e) {
				LogUtil.error(e);
			}
			if(s3is != null )	try {	s3is.close();	} catch (IOException e) {
				LogUtil.error(e);
			}
		}
		
		return result;
	}
	
	
	
	


	/**
	 * @param bucketName the bucketName to set
	 */
	public void setBucketName(String bucketName) {
		this.bucketName = bucketName;
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


	public AmazonS3 getS3Client() {
		return s3Client;
	}


	public void setS3Client(AmazonS3 s3Client) {
		this.s3Client = s3Client;
	}
	
	
	
	
	
	
}

