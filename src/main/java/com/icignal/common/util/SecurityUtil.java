 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Optional;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.Mac;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.io.FileUtils;
/**
 * 1. FileName	: SecurityUtil.java
 * 2. Package	: com.icignal.core.util
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 17. 오전 11:12:53
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 17.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */
import org.apache.commons.lang3.StringUtils;

/*
 * 1. 클래스명	: SecurityUtil
 * 2. 파일명	: SecurityUtil.java
 * 3. 패키지명	: com.icignal.core.util
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class SecurityUtil {
	
	
	
	
	 /*
	  * 1. 메소드명: encodeAES256
	  * 2. 클래스명: SecurityUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명 : DB 개인정보 필드의 암호화를 처리하기 위해  개인정보 데이터 암호화한다.
	 * 2. 사용법 :   
	 * 			String dataKey = BeansUtil.getDbEncryptDataKey();
	 * 			SecurityUtil.encodeDbAES256(dataKey, "홍길동");
	 * (참고사항)
	 * 아래와 같이 Exception이 발생할 경우  ( jdk1.8 까지  자국 미 만 aes256만 지원하도록 되어 있으며, 그외 국가는 aes128을 표준으로 함.)
	 * java.security.InvalidKeyException: Illegal key size
	 * lib/UnlimitedCEPolicyJDK8 폴더에 있는 local_policy.jar, US_export_policy.jar를 
	 * jvm 설치폴더 -> $JAVA_HOME/jre/lib/security 경로에 덮어씌우기
	 *		
	 * </PRE>
	 *   @param dataKey 암호화 처리를 위한 암호화 데이터 키
	 *   @param plainText 평문 데이터
	 *   @return 암호화된 HAX 문자열
	 */
	public final static String encodeDbAES256(final String dataKey, final String plainText) {
		
		if(StringUtils.isBlank(plainText)) return "";
		
	  	return Optional.ofNullable(plainText)
	  				   .map(o -> {	  		                     
								  	try {										
										 Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
										 c.init(Cipher.ENCRYPT_MODE, new SecretKeySpec( Hex.decodeHex(dataKey), "AES"), 
												 new IvParameterSpec("5845673849586734".getBytes()));
										 return new String(Hex.encodeHex(c.doFinal(o.getBytes("UTF-8")))).toUpperCase();
									    }catch (Exception e) {LogUtil.error(e); return "";}
	  				   				})
	  				   .orElse("");
	}
	
	
	
	
	 /*
	  * 1. 메소드명: encodeAES256
	  * 2. 클래스명: SecurityUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 9. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명 : DB 개인정보 필드의 암호화를 처리하기 위해  개인정보 데이터 암호화한다.
	 * 2. 사용법 :   
	 * 			SecurityUtil.encodeDbAES256(dataKey, "홍길동");
	 * (참고사항)
	 * 아래와 같이 Exception이 발생할 경우  ( jdk1.8 까지  자국 미 만 aes256만 지원하도록 되어 있으며, 그외 국가는 aes128을 표준으로 함.)
	 * java.security.InvalidKeyException: Illegal key size
	 * lib/UnlimitedCEPolicyJDK8 폴더에 있는 local_policy.jar, US_export_policy.jar를 
	 * jvm 설치폴더 -> $JAVA_HOME/jre/lib/security 경로에 덮어씌우기
	 *		
	 * </PRE>
	 *   @param plainText 평문 데이터
	 *   @return 암호화된 HAX 문자열
	 */
	public final static String encodeDbAES256( final String plainText) {		
		return encodeDbAES256(BeansUtil.getDbEncryptDataKey(), plainText);
		
	}
	
	 
	 /*
	  * 1. 메소드명: decodeDbAES256
	  * 2. 클래스명: SecurityUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 09. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명 : DB 개인정보 필드의 암호화 데이터를 복호화 한다.
	 * 2. 사용법 :
	 * 			SecurityUtil.decodeDbAES256( "DSFDASFDSAS");		
	 * (참고사항)
	 * 아래와 같이 Exception이 발생할 경우  ( jdk1.8 까지  자국 미국만 aes256만 지원하도록 되어 있으며, 그외 국가는 aes128을 표준으로 함.)
	 * java.security.InvalidKeyException: Illegal key size
	 * lib/UnlimitedCEPolicyJDK8 폴더에 있는 local_policy.jar, US_export_policy.jar를 
	 * jvm 설치폴더 -> $JAVA_HOME/jre/lib/security 경로에 덮어씌우기
	 *		
	 *		
	 * </PRE>
	 *   @param encText 암호화 데이터
	 *   @return 복호화 문자열
	 */
	public final static String decodeDbAES256( final String encText) {
		 
		 return decodeDbAES256(BeansUtil.getDbEncryptDataKey(), encText);
	 }
	
	
	
	
	 /*
	  * 1. 메소드명: decodeDbAES256
	  * 2. 클래스명: SecurityUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명 : DB 개인정보 필드의 암호화 데이터를 복호화 한다.
	 * 2. 사용법 :
	 * 			String dataKey = BeansUtil.getDbEncryptDataKey();
	 * 			SecurityUtil.decodeDbAES256(dataKey, "DSFDASFDSAS");		
	 * (참고사항)
	 * 아래와 같이 Exception이 발생할 경우  ( jdk1.8 까지  자국 미국만 aes256만 지원하도록 되어 있으며, 그외 국가는 aes128을 표준으로 함.)
	 * java.security.InvalidKeyException: Illegal key size
	 * lib/UnlimitedCEPolicyJDK8 폴더에 있는 local_policy.jar, US_export_policy.jar를 
	 * jvm 설치폴더 -> $JAVA_HOME/jre/lib/security 경로에 덮어씌우기
	 *		
	 *		
	 * </PRE>
	 *   @param dataKey 암호화 처리를 위한 암호화 데이터 키
	 *   @param encText 암호화 데이터
	 *   @return 복호화 문자열
	 */
	public final static String decodeDbAES256(final String dataKey, final String encText) {
		if(StringUtils.isBlank(encText)) return "";
		
		return Optional.ofNullable(encText)
				.map(o -> {	  		                     
							try { 
				  		  		 Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
				  		  		 c.init(Cipher.DECRYPT_MODE, new SecretKeySpec(Hex.decodeHex(dataKey), "AES"), 
				  		  				 new IvParameterSpec("5845673849586734".getBytes("UTF-8")));
				  		  	     return new String(c.doFinal(Hex.decodeHex(o)),"UTF-8");
								}catch (Exception e) {LogUtil.error(e); return "";}
	   				       })
				.orElse("");
		
	
	}
	
	
	public final static String decodePBKDF2WithHmacSHA1(String ciphertext, 
			String salt, String iv, String passPhrase, int iterationCount) {
		String rtnValue = "";
        String passphrase = passPhrase.substring(0, 16);
        int keySize = 128;
        
        try {
	        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
	        KeySpec spec = new PBEKeySpec(passphrase.toCharArray(), Hex.decodeHex(salt.toCharArray()), iterationCount, keySize);
	        SecretKey key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");        
	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(Hex.decodeHex(iv.toCharArray())));        
	        byte[] decrypted = cipher.doFinal(Base64.decodeBase64(ciphertext));
	        rtnValue =  new String(decrypted, "UTF-8");
		} catch (NoSuchAlgorithmException e) {
			
			LogUtil.error(e);
		} catch (DecoderException e) {
			
			LogUtil.error(e);
		} catch (InvalidKeySpecException e) {
			
			LogUtil.error(e);
		} catch (NoSuchPaddingException e) {
			
			LogUtil.error(e);
		} catch (InvalidKeyException e) {
			
			LogUtil.error(e);
		} catch (InvalidAlgorithmParameterException e) {
			
			LogUtil.error(e);
		} catch (IllegalBlockSizeException e) {
			
			LogUtil.error(e);
		} catch (BadPaddingException e) {
			
			LogUtil.error(e);
		} catch (UnsupportedEncodingException e) {
			
			LogUtil.error(e);
		}
	    
		return rtnValue ;
	}
	
	

	
	/**
	* @programId :
	* @name : encryptFile
	* @date : 2019. 1. 30.
	* @author : hy.jun
	* @table :
	* @return : void
	* @description :
	* - Cipher.ENCRYPT_MODE / DECRYPT_MODE
	*/
	public static void createCryptoFile(int cipherMode, String key, 
			File inputFile, File outputFile, String transformation) {
		try {
			Key secretKey = new SecretKeySpec(Hex.decodeHex(key), transformation);
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(cipherMode, secretKey);
		
			FileInputStream inputStream = new FileInputStream(inputFile);
			byte[] inputBytes = new byte[(int) inputFile.length()];
			inputStream.read(inputBytes);
			
			byte[] outputBytes = cipher.doFinal(inputBytes);
			
			FileOutputStream outputStream = new FileOutputStream(outputFile);
			outputStream.write(outputBytes);
			
			inputStream.close();
			outputStream.close();
		
		} catch (NoSuchPaddingException | NoSuchAlgorithmException | 
				InvalidKeyException | BadPaddingException | 
				IllegalBlockSizeException | IOException | DecoderException e) {
			LogUtil.error(e);
		}
   }
	
	
	/**
	* @programId :
	* @name : getCryptoFile
	* @date : 2019. 1. 30.
	* @author : hy.jun
	* @table :
	* @return : File
	* @description : 
	* - Cipher.ENCRYPT_MODE / DECRYPT_MODE
	*/
	public static File getCryptoFile(int cipherMode, SecretKey key, File inputFile, File outputFile) {
		return getCryptoFile(cipherMode, key, inputFile, outputFile, "AES");
	}
	
	/**
	* @programId :
	* @name : getCryptoFile
	* @date : 2019. 1. 30.
	* @author : hy.jun
	* @table :
	* @return : File
	* @description :
	* - Cipher.ENCRYPT_MODE / DECRYPT_MODE
	*/
	public static File getCryptoFile(int cipherMode, SecretKey key, File inputFile, File outputFile, String transformation) {
		try {
			Cipher cipher = Cipher.getInstance(transformation);
			cipher.init(cipherMode, key);
			
			byte[] outputBytes = cipher.doFinal(FileUtils.readFileToByteArray(inputFile));
			FileUtils.writeByteArrayToFile(outputFile, outputBytes);
		
		} catch (NoSuchPaddingException | NoSuchAlgorithmException | 
				InvalidKeyException | BadPaddingException | 
				IllegalBlockSizeException | IOException e) {
			LogUtil.error(e);
		}
		
		return outputFile;
   }
	
	/**
	* @programId :
	* @name : getCryptoFile
	* @date : 2019. 1. 30.
	* @author : hy.jun
	* @table :
	* @return : File
	* @description :
	* - Cipher.ENCRYPT_MODE / DECRYPT_MODE
	*/
	public static File getCryptoFile(int cipherMode, String key, File inputFile, File outputFile, String transformation) {
		try {
			Key secretKey = new SecretKeySpec(key.getBytes(), transformation);
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(cipherMode, secretKey);
		
			byte[] outputBytes = cipher.doFinal(FileUtils.readFileToByteArray(inputFile));
			FileUtils.writeByteArrayToFile(outputFile, outputBytes);
		
		} catch (NoSuchPaddingException | NoSuchAlgorithmException | 
				InvalidKeyException | BadPaddingException | 
				IllegalBlockSizeException | IOException e) {
				LogUtil.error(e);
		}
		
		return outputFile;
   }
	
	/**
	* @programId :
	* @name : createCryptoFile
	* @date : 2019. 1. 30.
	* @author : hy.jun
	* @table :
	* @return : void
	* @description :
	* - Cipher.ENCRYPT_MODE / DECRYPT_MODE
	*/
	public static void createCryptoFile(int cipherMode, SecretKey key, File inputFile, File outputFile) {
		createCryptoFile(cipherMode, key, inputFile, outputFile, "AES");
	}
	
	/**
	* @programId :
	* @name : createCryptoFile
	* @date : 2019. 1. 30.
	* @author : hy.jun
	* @table :
	* @return : void
	* @description :
	* - Cipher.ENCRYPT_MODE / DECRYPT_MODE
	*/
	public static void createCryptoFile(int cipherMode, String key, File inputFile, File outputFile) {
		createCryptoFile(cipherMode, key, inputFile, outputFile, "AES");
	}
	
	
	
	/**
	* @programId :
	* @name : encryptFile
	* @date : 2019. 1. 30.
	* @author : hy.jun
	* @table :
	* @return : void
	* @description :
	* - Cipher.ENCRYPT_MODE / DECRYPT_MODE
	*/
	public static void createCryptoFile(int cipherMode, SecretKey key, 
			File inputFile, File outputFile, String transformation) {
		try {
			Cipher cipher = Cipher.getInstance(transformation);
			cipher.init(cipherMode, key);
		
			FileInputStream inputStream = new FileInputStream(inputFile);
			byte[] inputBytes = new byte[(int) inputFile.length()];
			inputStream.read(inputBytes);
			
			byte[] outputBytes = cipher.doFinal(inputBytes);
			
			FileOutputStream outputStream = new FileOutputStream(outputFile);
			outputStream.write(outputBytes);
			
			inputStream.close();
			outputStream.close();
		
		} catch (NoSuchPaddingException | NoSuchAlgorithmException | 
				InvalidKeyException | BadPaddingException | 
				IllegalBlockSizeException | IOException e) {
			LogUtil.error(e);
		}
   }
	
	

	 /*
	  * 1. 메소드명: encodeMD5
	  * 2. 클래스명: SecurityUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 9. 14
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	MD5 Hash 암호화
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param plainText
	 *   @return	
	 */
	public static String encodeMD5(String plainText){

		String encodeText = null; 

		try{

			MessageDigest md = MessageDigest.getInstance("MD5"); 

			md.update(plainText.getBytes()); 

			byte byteData[] = md.digest();

			StringBuffer sb = new StringBuffer(); 

			for(int i = 0 ; i < byteData.length ; i++){

				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));

			}

			encodeText = sb.toString();

			

		}catch(NoSuchAlgorithmException e){
			LogUtil.error(e);
			encodeText = null; 

		}

		return encodeText;

	}


    /*
     * 1. 메소드명: encodePassword
     * 2. 클래스명: SecurityUtil
     * 3. 작성자명: knlee 
     * 4. 작성일자: 2020. 9. 14
     */
   /**
    * <PRE>
    * 1. 설명
    *	  패스워드 암호화 함수
    *   MD5 Hash -> SHA256 Hash
    * 2. 사용법
    *		
    * </PRE>
    *   @param plainText
    *   @return	
    */
   public final static String encodePassword(String plainText) {
   	
   	return encodeSHA256(encodeMD5(plainText));
   }
	
	
	
	
		
	 /*
	  * 1. 메소드명: encodeSHA256
	  * 2. 클래스명: SecurityUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 * 1.설명: 개인정보 데이터 중 단방향 암호화가 필요한 데이터에 대해  암호화 처리 
	 * 2.사용법 :
	 *    		SecurityUtil.encodePassword("1234");
	 * </PRE>
	 *   @param plainText 암호화할 평문 문자열
	 *   @return 암호화된 문자열
	 */
	public final static String encodeSHA256(final String plainText){
		String encData = null; 
        if( StringUtils.isBlank(plainText) ) return "";
		try{

			MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
			sh.update(plainText.getBytes()); 
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			encData = sb.toString();
		}catch(NoSuchAlgorithmException e){
			LogUtil.error(e);
			encData = ""; 
		}
		return encData;
	}
	
	
	
	public static void main(String[] args) {
	//	String dataKey = BeansUtil.getDbEncryptDataKey();
		String dataKey = "5ED0873209E35593BE84FEED228144B71FF4D8DD1A49D7E83C6715DB5C2C67AF";
//		String dataKey = "5ED0873209E35593BE84FEED228144B7";
		
		String plainText = "D8632EF17A41769E48A3208C7A9C36ADD822CAAEF0E9D3894A459E68C1ACBA6B";
		//BC8AE5F4762852F48B3764C726B5E349
		/*String enc_data  = SecurityUtil.encodeDbAES256(dataKey, plainText);
		LogUtil.info("enc_data: " + enc_data);
		String dec_data = SecurityUtil.decodeDbAES256(dataKey, enc_data);
		LogUtil.info("dec_data: " + dec_data);*/
		
		
		String dec_data = SecurityUtil.decodeDbAES256(dataKey, plainText);
		LogUtil.info("dec_data: " + dec_data);
		
		String enc_data = SecurityUtil.encodeDbAES256(dataKey, plainText);
		LogUtil.info("enc_data: " + enc_data);
		
	}

	/**
	 * SecureUtility
	 * */
	/**
	 * 외부입력값에서 경로순회(directory traversal) 문자열을 제거. 상대패스(./) 등  제거함
	 * @param path 
	 * @return String
	 */
	public final static String chkPath(String path){
		
		if (path == null || "".equals(path.trim()) ) return path;		
		return  path.replace("\\", "/").replace("../", "").replace("./", "").replace(";", "").replaceAll("[\\r\\n]","");
		
		
	}
	
	public final static String chkJSTag(String str) {
		return  StringUtils.isEmpty(str) ? "" : str.replace("<", "&lt;").replace(">", "&gt;");
	}
	
	
	/**
	 * ICNSecurityUtil
	 * */
	

	/**
	 * @param msg 수신 전문
	 * @param keyString HMAC 생성 키
	 * @return String 생성된 HMAC 값
	 * @throws UnsupportedEncodingException
	 * @throws NoSuchAlgorithmException
	 * @throws InvalidKeyException
	 * @exception
	 * @description HMAC 생성
	 */
	public static String generateHMAC(String msg, String keyString) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException {
		String digest = null;
		String algo = "HmacSHA256";
		SecretKeySpec key = new SecretKeySpec(keyString.getBytes("UTF-8"), algo);
		Mac mac = Mac.getInstance(algo);
		mac.init(key);
		final byte[] bytes = mac.doFinal(msg.getBytes("UTF-8"));
		StringBuffer hash = new StringBuffer();
		for (int i = 0; i < bytes.length; i ++) {
			String hex = Integer.toHexString(0xFF & bytes[i]);
			if (hex.length() == 1) {
				hash.append('0');
			}
			hash.append(hex);
		}
		digest = hash.toString();
		digest = digest.toUpperCase();
		return digest;
	}

	private static byte[] ivBytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

	/**
	 *
	 * @name : AES256_Encode
	 * @date : 2022. 01. 04.
	 * @author : hr.noh
	 * @description : 스트링 문자를 암호화 처리
	 * @param key : hmac key
	 * @param str : 문자열
	 */
	public synchronized final static String encodeEtcAES256(String key, String str)	{
		String rtnValue = "";
		byte[] textBytes;
		try {
			textBytes = str.getBytes("UTF-8");
			AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);

			SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
			Cipher cipher = null;
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec);
			rtnValue = Base64.encodeBase64String(cipher.doFinal(textBytes));
		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e.getMessage());
		} catch (NoSuchAlgorithmException e) {
			LogUtil.error(e.getMessage());
		} catch (NoSuchPaddingException e) {
			LogUtil.error(e.getMessage());
		} catch (InvalidKeyException e) {
			LogUtil.error(e.getMessage());
		} catch (InvalidAlgorithmParameterException e) {
			LogUtil.error(e.getMessage());
		} catch (IllegalBlockSizeException e) {
			LogUtil.error(e.getMessage());
		} catch (BadPaddingException e) {
			LogUtil.error(e.getMessage());
		}catch(Exception e){
			e.printStackTrace();
		}

		return rtnValue ;
	}

	/**
	 *
	 * @name : AES256_Decode
	 * @date : 2022. 01. 04.
	 * @author : hr.noh
	 * @description : 스트링 문자를 복호화 처리
	 */
	public synchronized final static String decodeEtcAES256(String key, String str) {
		String rtnValue = "";
		byte[] textBytes;
		try {
			textBytes = Base64.decodeBase64(str);
			//byte[] textBytes = str.getBytes("UTF-8");
			AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
			//로컬 프로퍼티에 encrypt.aes.key 가 없어서 추가하였으며 기존 소스로 원복 함
			SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec);
			rtnValue = new String(cipher.doFinal(textBytes), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e.getMessage());
		} catch (NoSuchAlgorithmException e) {
			LogUtil.error(e.getMessage());
		} catch (NoSuchPaddingException e) {
			LogUtil.error(e.getMessage());
		} catch (InvalidKeyException e) {
			LogUtil.error(e.getMessage());
		} catch (InvalidAlgorithmParameterException e) {
			LogUtil.error(e.getMessage());
		} catch (IllegalBlockSizeException e) {
			LogUtil.error(e.getMessage());
		} catch (BadPaddingException e) {
			LogUtil.error(e.getMessage());
		} catch (Exception e) {
			LogUtil.error(e.getMessage());
		}

		return rtnValue ;
	}

	/**
	 * @Method Name : checkHMac
	 * @작성일   	: 2019. 1. 4.
	 * @작성자   	: knlee
	 * @변경이력  	:
	 * @Method 설명 	: HMac 유효성 체크
	 * @param map
	 * @return
	 */
	public static boolean checkHMac(String map, String authorization) {
		String hmacChk = BeansUtil.getApplicationProperty("descente.api.hmac.check");
		if ( StringUtil.isUpperCaseEquals( hmacChk , "Y")) {
			try {
				String hsKeyRslt = SecurityUtil.generateHMAC(map, BeansUtil.getApplicationProperty("descente.api.hmac.key"));
				if(hsKeyRslt.equals(authorization)) return true;
				else return false;
			} catch (InvalidKeyException e) {
				LogUtil.error(e.getMessage());
				return false;
			} catch (UnsupportedEncodingException e) {
				LogUtil.error(e.getMessage());
				return false;
			} catch (NoSuchAlgorithmException e) {
				LogUtil.error(e.getMessage());
				return false;
			} catch (Exception e) {
				LogUtil.error(e.getMessage());
				return false;
			}

		}

		return true;
	}
}

