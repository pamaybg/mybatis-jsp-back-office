package com.icignal.external.aws;

import java.nio.ByteBuffer;
import java.security.Key;
import java.util.Base64;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.services.kms.AWSKMS;
import com.amazonaws.services.kms.AWSKMSClientBuilder;
import com.amazonaws.services.kms.model.DecryptRequest;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;


public class KMSManager {
	
	private Credentials creds;
	private String region;
	
	private AWSCredentialsProvider credentialsProvider;
	private AWSKMS clientBuilder;
	
	
	public KMSManager() {
		this.creds =  BeansUtil.getAWSCredentials();
		this.region = BeansUtil.getAwsRegion();
		this.clientBuilder = createAWSKMS();
		
	}
	
	public KMSManager(Credentials creds, String region) {
		this.creds = creds;
		this.region = region;
		this.clientBuilder = createAWSKMS();
		
	}
	
	
	private AWSKMS createAWSKMS() {
		credentialsProvider = new AWSStaticCredentialsProvider(creds.getBasicAWSCredentials());
		clientBuilder = AWSKMSClientBuilder.standard()
		    		.withCredentials(credentialsProvider)
		    		.withRegion(region)
		    		.build();
        return clientBuilder;
		
	}
	
	
	 /*
	  * 1. 메소드명: decrypt
	  * 2. 클래스명: KMSManager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 1. 31.
	  */
	/**
	 * <PRE>
	 * 1. 암화화된 데이터 키를 Byte배열로 입력받아 Plaintext 데이터키 문자열을 리턴함
	 * 	AWS KMS Flow 요약:
	 * 		1단계: encryption data key 취득
	 *      (input)masterkey -> kms 암호화 알고리즘 -> (output)encryption data ke
	 * 		2단계 : encryption data key를 이용하여 Plaintext data key 취득      
	 *      (input) encryption data key -> kms 암호화 알고리즘 -> (output) plaintext data key
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param keyByte
	 *   @return 평문 데이터 키 문자열
	 *   @throws DecoderException	
	 */
	public String decrypt(byte keyByte []) throws DecoderException {
		
		String stringKey = Base64.getEncoder().encodeToString(keyByte);
		DecryptRequest decryptRequest = new DecryptRequest();
		decryptRequest.setRequestCredentialsProvider(credentialsProvider);
		decryptRequest.withCiphertextBlob(ByteBuffer.wrap(Hex.decodeHex(stringKey)));
		ByteBuffer plainTextKey = clientBuilder.decrypt(decryptRequest).getPlaintext();
		// Hex.decodeHex(Hex.encodeHex(plainTextKey));

		Key key =  new SecretKeySpec(Hex.decodeHex(Hex.encodeHex(plainTextKey)), "AES");

        stringKey = Hex.encodeHexString(key.getEncoded(), false); // false : 대문자 문자열로 리턴, true: 소문자 문자열로 리턴
		return stringKey;
				
	}
	
	
	 /*
	  * 1. 메소드명: getSecretKey
	  * 2. 클래스명: KMSManager
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	KMS의 SecretKey 객체를 반환한다.
	 * 2. 사용법	
		KMSManager kms = new KMSManager();
		SecretKey  secretKey = kms.getSecretKey(BeansUtil.getFileCryptorKey());
	 * </PRE>
	 *   @param encryptKey
	 *   @return	
	 */
	public SecretKey getSecretKey (String encryptKey) {
    	DecryptRequest decryptRequest = new DecryptRequest();
		decryptRequest.setRequestCredentialsProvider(credentialsProvider);
		try {
			decryptRequest.withCiphertextBlob(ByteBuffer.wrap(Hex.decodeHex(encryptKey)));
		} catch (DecoderException e) {
			LogUtil.error(e);
		}
		ByteBuffer plainTextKey = clientBuilder.decrypt(decryptRequest).getPlaintext();
		byte[] keyByte = new byte[plainTextKey.remaining()];
    	
    	//SecretKey 생성
		return new SecretKeySpec(keyByte, 0, keyByte.length, "AES");
    		
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

	public AWSKMS getClientBuilder() {
		return clientBuilder;
	}

	public void setClientBuilder(AWSKMS clientBuilder) {
		this.clientBuilder = clientBuilder;
	}
	
	
	
	
	
}
