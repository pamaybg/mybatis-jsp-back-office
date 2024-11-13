/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: CryptoManager.java
 * 2. Package	: com.icignal.core.security.crypto
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 10. 7. 오전 10:40:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 10. 7.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.core.security.crypto;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Calendar;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.Mac;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.kms.AWSKMS;
import com.amazonaws.services.kms.AWSKMSClientBuilder;
import com.amazonaws.services.kms.model.DecryptRequest;
import com.amazonaws.services.kms.model.GenerateDataKeyRequest;
import com.amazonaws.services.kms.model.GenerateDataKeyResult;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;



public class CryptoManager {

    private static Key keyObject;
    private static String keyFileName;
    private static String SECURITY_KEY;
    private static SecretKey FILE_SECURITY_KEY;
    static String IV = "1234567890123456"; //16bit
    
	private static String KEYID;
	private static BasicAWSCredentials awsCreds;

    public CryptoManager() {
    	
    	/*LogUtil.debug("============== Key File Initial Loading Start ==============");
    	
    	*//**
    	 * 1.AWS KMS 관련 정보 로드 (Servlet Properties)
    	 * 2.키 파일 생성 - 주석처리. 키파일 생성은 수동으로 한다.
    	 * 3.cipherKey 세팅
    	 *//*
    	
    	KMS_VALUE = Common.getInstance().getServletProp("aws.kms.use");
    	
    	if(KMS_VALUE!="kms"){
    		
    		//1.AWS KMS 관련 정보 로드 (Servlet Properties)
        	StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
            encryptor.setPassword(Common.getInstance().getServletProp("encrypt.aes.key"));
        	
        	keyFileName = Common.getInstance().getServletProp("aws.kms.keyFilePath");
        	KEYID = encryptor.decrypt(Common.getInstance().getServletProp("aws.credentials.masterkey"));
        	
        	String accesskey = encryptor.decrypt(Common.getInstance().getServletProp("aws.credentials.accesskey"));
        	String secretkey = encryptor.decrypt(Common.getInstance().getServletProp("aws.credentials.secretkey"));
        	
        	awsCreds = new BasicAWSCredentials(accesskey, secretkey);
        	
    		try {
    			//2.키 파일 생성
    			//makeAwsKmsKeyFile(keyFileName);
    			//3.cipherKey 세팅
    			SECURITY_KEY = loadCipherKey(keyFileName);
    			FILE_SECURITY_KEY = loadFileCipherKey(
    					AWSSecretsManagerConfig.getSecretValueResult(
    							encryptor.decrypt(Common.getInstance().getServletProp("aws.secretsManager.file.secretName"))).get("key").toString());
    			//LogUtil.info(SECURITY_KEY);
    			
    			LogUtil.debug("============== Key File Initial Loading End ==============");
    			
    		} catch (Exception e) {
    			
    			LogUtil.debug("============== Key File Initial Loading Error ==============");
    			
    			LogUtil.error(e);
    		}
    		
    	} else {
    		try {
				CryptoManager.makeOracleKeyFile("key.dat");
			} catch (Exception e) {
				LogUtil.error("============== Key File Initial Loading Start ==============");
			}
    	}*/
    	
    }
	
	/**
	 * @param args
	 * @throws Exception
	 * @description AWS KMS 키파일 수동생성
	 */
	public static void main(String[] args) throws Exception {
		/**
		 * 암복호화 테스트 시 사용하세요.
		 * ACTION : AWS 자격증명생성 + 키파일생성 + 생성된 키파일로 cipherKey 출력 + 암/복호화 결과 출력 
		 * << env 유형 >>
		 * QUINTET_DAISO_ORACLE : 퀸텟 AWS
		 * AWS_DAISO_ORACLE : 다이소 내부 AWS
		 * << 키파일 신규생성 여부(신규 생성 시 target 폴더 내 생성됨.) >>
		 * isNewKeyFile : true -> 신규생성 / false -> 기존 파일 사용
		 */
		
//		String env = "QUINTET_DAISO_ORACLE";
//		String env = "AWS_DAISO_ORACLE";
//		String env = "AWS_BAT_DEV";
//		String env = "AWS_BAT_REAL";
		//String env = "ICIGNAL_T10_LOY_ORACLE_DEV";
		
		boolean isNewKeyFile = true;
		
		String accesskey = null;
		String secretkey = null;
		keyFileName = "conf/db_key_real.dat";
		
			KEYID = "arn:aws:kms:ap-northeast-2:741933465035:key/4fa7e307-8e66-40e8-b683-b51085099689";
			accesskey = "AKIA2ZPVOHXFRXUGWW3F";
			secretkey = "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";
		
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setPassword("9pwc3dke");
        
		//AWS 자격증명 생성
		awsCreds = new BasicAWSCredentials(accesskey, secretkey);
    	
		//키파일 수동생성
		if(isNewKeyFile) {
			CryptoManager.makeAwsKmsKeyFile(keyFileName);
		}
		
		//키파일 read
		SECURITY_KEY = CryptoManager.loadCipherKey(keyFileName);
		LogUtil.info("key : " + SECURITY_KEY);
		
		//암복호화 테스트 결과 출력
		test();
	}
	
	private static void test() throws Exception
	{
		final String dataStr = "jun9813@gmail.com";
		
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        
		for (int i=0; i<10; i++)
		{
			cal = Calendar.getInstance();
			LogUtil.info(i +"==>" + dateFormat.format(cal.getTime()));
			
			
			// encrypt and base64
			//ByteBuffer plainTextKey=null;
			String encryptStr = encrypt(dataStr, keyObject);
			LogUtil.info("encrypt[" + encryptStr + "]" + encryptStr.length());
	
			// /////////////////////////////////////////////////////////////////////
	
			// encrypt data key
			/*
			ByteBuffer encryptedKey = dataKeyResult.getCiphertextBlob();
	
			
			DecryptRequest decryptRequest = new DecryptRequest();
			decryptRequest.setRequestCredentials(awsCreds);
			decryptRequest.withCiphertextBlob(encryptedKey);
			plainTextKey = kmsClient.decrypt(decryptRequest).getPlaintext();
			*/
			
			String decryptStr = decrypt(encryptStr, keyObject);
			LogUtil.info("decrypt[" + decryptStr + "]");
			
			
		}
	}
	
	
	/**
	 * AWS KMS용 데이타 암/복호화 키를 생성하는 함수
	 * @param String key : 데이타 암/복호를 위해 KMS에서 제공하는 암호화된 Data Key를 파일에 저장함 
	 * @param String fileName : 키를 저장할 파일명
	 * @return void
	 */
	private static void makeAwsKmsKeyFile(String fileName) throws Exception {

		//데이타키 생성
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(awsCreds);
        AWSKMS kmsClient = AWSKMSClientBuilder.standard().withCredentials(credentialsProvider).withRegion("ap-northeast-2").build();
		
        GenerateDataKeyRequest dataKeyRequest = new GenerateDataKeyRequest();
		dataKeyRequest.setKeyId(KEYID);
		dataKeyRequest.setKeySpec("AES_256");
		dataKeyRequest.setRequestCredentialsProvider(credentialsProvider);
		
		GenerateDataKeyResult dataKeyResult = kmsClient.generateDataKey(dataKeyRequest);
		
		ByteBuffer plainTextKey = dataKeyResult.getPlaintext();
		Key key =  makeKey(plainTextKey);
		//String keyTxt = getDataKeyString(key);
		//LogUtil.info("key=" + keyTxt );
		
		//LogUtil.info("key=" + byteArrayToHex(key.getEncoded()) );
		
		
		ByteBuffer encryptedKey = dataKeyResult.getCiphertextBlob(); //암호화된 데이타키
		byte[] encodedKey = getByteArray(encryptedKey);

		String hexKey = byteArrayToHex(encodedKey);
		LogUtil.info("hexKey : " + hexKey);
		
		byte[] base64Key = Base64.getDecoder().decode(hexKey);
		SecretKey secretKey = new SecretKeySpec(base64Key, "AES");
		byte[] keyByte = secretKey.getEncoded();
		
		
		
		String path = Thread.currentThread().getContextClassLoader().getResource("").getPath();
		String fullPath = path + fileName;
		LogUtil.info("fullPath : " + fullPath);
		
		FileOutputStream fileOutputStream = new FileOutputStream(fullPath);
		fileOutputStream.write(keyByte);
		fileOutputStream.close();
	}
	
	
	
	
	/**
	 * Mysql용 데이타 암/복호화 키를 생성하는 함수
	 * @param String key : 데이타 암/복호를 위한 키(mysql은 256비트 지원안하므로 26자리, oracle은 32자리로 사용해야 함)
	 * @param String fileName : 키를 저장할 파일명
	 * @return void
	 */
	private static void makeMysqlKeyFile(String fileName) throws Exception {
		
		int keyLength=44;
		
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
		
		
		//키를 콘솔에서 입력받기
		String inputKey = getKeyByConsole( keyLength, bufferedReader );
		
		//키를 암호화할 비밀키를 콘솔에서 입력 받기
		String keyPassword = getPasswordKeyByConsole( keyLength, bufferedReader );
		
		if(inputKey.getBytes().length!=keyLength) {
			throw new Exception("Key length must be "+keyLength+" bits.");
		}
		
		if(keyPassword.getBytes().length!=keyLength) {
			throw new Exception("Password length must be "+keyLength+" bits.");
		}
		
		//key를 암호화 시킴
		final Cipher encryptCipher = Cipher.getInstance("AES");	        				
		encryptCipher.init(Cipher.ENCRYPT_MODE, generateMySQLAESKey(keyPassword, "UTF-8"));
		byte[] encodedKey = encryptCipher.doFinal(inputKey.getBytes("UTF-8"));
		String hexKey = byteArrayToHex(encodedKey);
		
		byte[] base64Key = Base64.getDecoder().decode(hexKey);
		SecretKey secretKey = new SecretKeySpec(base64Key, "AES");
		byte[] keyByte = secretKey.getEncoded();
		
		
		FileOutputStream fileOutputStream = new FileOutputStream(fileName);
		fileOutputStream.write(keyByte);
		fileOutputStream.close();
	}
	
	
	/**
	 * key파일명을 설정
	 * @param String keyFileName : key파일명
	 * @return void
	 */
	public static void setKeyFileName(String keyFileName) {
		CryptoManager.keyFileName = keyFileName;
	}
	
	
	/**
	 * Mysql용 AES key 생성
	 * @param String key : 데이타 암/복호화용 key 값
	 * @param String key : key에 대한 charset
	 * @return SecretKeySpec : Key Object
	 */
	private static SecretKeySpec generateMySQLAESKey(final String key, final String encoding) {
		try {
			final byte[] finalKey = new byte[16];
			int i = 0;
			for(byte b : key.getBytes(encoding))
				finalKey[i++%16] ^= b;			
			return new SecretKeySpec(finalKey, "AES");
		} catch(IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	

	
	/**
	 * 파일에서 Key값을 읽는 함수
	 * @param String fileName : 키가 있는 파일명
	 * @return String : 키값
	 */
    private static String loadCipherKey(String fileName) throws Exception {
    	
        if (fileName==null) {
            throw new Exception("Value for key file name parameter is not set.");
        }
    	
    	String stringKey = "";
    	ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
    	InputStream  inputStream = classLoader.getResourceAsStream(fileName);
    	
    	
        if (inputStream==null) {
            throw new Exception("Securety Key File does not exist.");
        }
        
    	byte[] keyByte = CryptoManager.getBytes(inputStream);
    	inputStream.close();
    	
        AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(awsCreds);
        AWSKMS kmsClient = AWSKMSClientBuilder.standard().withCredentials(credentialsProvider).withRegion("ap-northeast-2").build();

        

		//byte => Hex => Base64 byte => SecretKey

    	
        CryptoManager.keyObject = new SecretKeySpec(keyByte, "AES");
        if (CryptoManager.keyObject != null) {
            stringKey = Base64.getEncoder().encodeToString(CryptoManager.keyObject.getEncoded());
            //stringKey = Base64.encodeBase64String(CryptoManager.keyObject.getEncoded());
            
    		DecryptRequest decryptRequest = new DecryptRequest();
    		decryptRequest.setRequestCredentialsProvider(credentialsProvider);
    		decryptRequest.withCiphertextBlob(ByteBuffer.wrap(hexToByteArray(stringKey)));
    		ByteBuffer plainTextKey = kmsClient.decrypt(decryptRequest).getPlaintext();

    		Key key =  makeKey(plainTextKey);
    		
    		CryptoManager.keyObject = key;
    		
            //LogUtil.info("key=" + byteArrayToHex(key.getEncoded()) );
            
            stringKey = byteArrayToHex(key.getEncoded());
            
            stringKey = stringKey.toUpperCase();
            
            stringKey = generateHMAC(stringKey, "123456789012") + "@@@!!!" + stringKey;
            
        }
        
        
        return stringKey;
    }
    
    /**
    * @programId :
    * @name : loadFileCipherKey
    * @date : 2019. 1. 30.
    * @author : hy.jun
    * @table :
    * @return : SecretKey
    * @description : 파일 암복호화키는 AWS Secrets Manager 에서 관리한다.
    * 	1. AWS 자격증명 생성
    * 	2. KMS 복호화서비스 호출
    * 	3. SecretKey 생성
    */
    private static SecretKey loadFileCipherKey(String encryptKeyStr) {
    	SecretKey key = null;
    	
    	//AWS 자격증명 생성
    	AWSCredentialsProvider credentialsProvider = new AWSStaticCredentialsProvider(awsCreds);
    	AWSKMS kmsClient = AWSKMSClientBuilder.standard().withCredentials(credentialsProvider).withRegion("ap-northeast-2").build();
    	
    	//AWS KMS 복호화서비스 호출
    	DecryptRequest decryptRequest = new DecryptRequest();
		decryptRequest.setRequestCredentialsProvider(credentialsProvider);
		decryptRequest.withCiphertextBlob(ByteBuffer.wrap(hexToByteArray(encryptKeyStr)));
		ByteBuffer plainTextKey = kmsClient.decrypt(decryptRequest).getPlaintext();
    	byte[] keyByte = new byte[plainTextKey.remaining()];
    	
    	//SecretKey 생성
    	key = new SecretKeySpec(keyByte, 0, keyByte.length, "AES");
    	
    	return key;
    }
    
    
    
    
    public static String getCipherKey() throws Exception {
    	if(CryptoManager.SECURITY_KEY==null || CryptoManager.SECURITY_KEY.equals("")) {
    		CryptoManager.SECURITY_KEY = CryptoManager.loadCipherKey(keyFileName);
    	}
    	return CryptoManager.SECURITY_KEY;
    }
    
    /**
    * @programId :
    * @name : getFileCipherKey
    * @date : 2019. 1. 30.
    * @author : hy.jun
    * @table :
    * @return : String
    * @description : 파일 암호화용 cipherKey
    */
    public static SecretKey getFileCipherKey() {
    	if(ObjectUtil.isEmpty(FILE_SECURITY_KEY)) {
    		CryptoManager.FILE_SECURITY_KEY = CryptoManager.loadFileCipherKey(keyFileName);
    	}
    	return CryptoManager.FILE_SECURITY_KEY;
    }

    
	/**
	 * 키를 콘솔에서 입력받기
	 * @param int keyLength : Key 사이즈
	 * @param BufferedReader bufferedReader : 콘솔에서 키를 입력받기 위한 BufferedReader
	 * @return String : 키
	 */
    private static String getKeyByConsole( int keyLength, BufferedReader bufferedReader ) {
        int     iTemp       = 0;
        boolean isOk        = false;
        String  inputKey   = "";
        String  reinpuKey = "";
        String  rtnValue    = "";
        String  sReFlag     = "";
        
        try {

        	iTemp = 1;
            isOk  = false;
            while(!isOk) {
                iTemp++;
                LogUtil.info( "데이타 암/복호화에 사용할 "+ keyLength +"자리 Key를 "+ sReFlag +" 입력해 주세요.  : " );
                inputKey = bufferedReader.readLine();
                inputKey = inputKey == null ? "" : inputKey;

                if( inputKey == null || "".equals(inputKey) ) {
                    LogUtil.info("Key가 입력되지 않았습니다.");
                } else {

                    if( inputKey.getBytes().length != keyLength ) {
                        LogUtil.info("Key는 "+ keyLength +"자리여야 합니다.  입력한 Key는 " + inputKey.getBytes().length + "자리입니다. ");
                        sReFlag = " 다시";
                    } else {
                    	isOk = true;
                        break;
                    }
                }

                if( iTemp > 3 ) {
                        LogUtil.info("======== key 입력이 3회 잘못되었습니다. ======== ");
                        LogUtil.info("======== 종료합니다. ========= ");
                        System.exit(1);
                }
            }


            /* 암호키 확인 */
            iTemp   = 1;
            isOk    = false;
            sReFlag = "한번더";
            while(!isOk) {
                iTemp++;
                LogUtil.info( "확인을 위해 Key를 "+ sReFlag +" 입력해 주세요 : " );
                reinpuKey = bufferedReader.readLine();
                reinpuKey = reinpuKey == null ? "" : reinpuKey;

                if( reinpuKey == null || "".equals(reinpuKey) ) {
                    LogUtil.info("Key를 입력해 주세요.");
                } else {

                    if( !inputKey.equals(reinpuKey) ) {
                        LogUtil.info("========= Key가 서로 맞지 않습니다.=========");
                        rtnValue = "";
                        sReFlag = "다시";
                    } else {
                        rtnValue = reinpuKey;
                        isOk     = true;
                        break;
                    }
                }

                if( iTemp > 3 ) {
                    LogUtil.info("========= key 확인 입력이 3회 잘못되었습니다. =========");
                    LogUtil.info("========= 종료합니다.========= ");
                    System.exit(1);
                }
            }


        }  catch (IOException ex) {
            LogUtil.error("key 입력 오류.(Exception)");
            System.exit(1);
        }

        return rtnValue;
    }
    
    
	/**
	 * 키를 암호화할 비밀키를 콘솔에서 입력 받기
	 * @param int keyLength : Key 사이즈
	 * @param BufferedReader bufferedReader : 콘솔에서 키를 입력받기 위한 BufferedReader
	 * @return String : 키를 암호화할 비밀번호
	 */
    private static String getPasswordKeyByConsole( int keyLength, BufferedReader bufferedReader ) {
        int     iTemp       = 0;
        boolean isOk        = false;
        String  inputKey   = "";
        String  reinpuKey = "";
        String  rtnValue    = "";
        String  sReFlag     = "";
        
        try {

        	iTemp = 1;
            isOk  = false;
            while(!isOk) {
                iTemp++;
                LogUtil.info( "입력한 Key를 암호화하기 위해 사용할 "+ keyLength +"자리 비밀번호를 "+ sReFlag +" 입력해 주세요.  : " );
                inputKey = bufferedReader.readLine();
                inputKey = inputKey == null ? "" : inputKey;

                if( inputKey == null || "".equals(inputKey) ) {
                    LogUtil.info("Key가 입력되지 않았습니다.");
                } else {

                    if( inputKey.getBytes().length != keyLength ) {
                        LogUtil.info("비밀번호는 "+ keyLength +"자리여야 합니다.  입력한 비밀번호는 " + inputKey.getBytes().length + "자리입니다. ");
                        sReFlag = " 다시";
                    } else {
                    	isOk = true;
                        break;
                    }
                }

                if( iTemp > 3 ) {
                        LogUtil.info("======== 비밀번호 입력이 3회 잘못되었습니다. ======== ");
                        LogUtil.info("======== 종료합니다. =========");
                        System.exit(1);
                }
            }


            /* 암호키 확인 */
            iTemp   = 1;
            isOk    = false;
            sReFlag = "한번더";
            while(!isOk) {
                iTemp++;
                LogUtil.info( "확인을 위해 비밀번호를 "+ sReFlag +" 입력해 주세요 : " );
                reinpuKey = bufferedReader.readLine();
                reinpuKey = reinpuKey == null ? "" : reinpuKey;

                if( reinpuKey == null || "".equals(reinpuKey) ) {
                    LogUtil.info("Key를 입력해 주세요.");
                } else {

                    if( !inputKey.equals(reinpuKey) ) {
                        LogUtil.info("========= 비밀번호가 서로 맞지 않습니다.=========");
                        rtnValue = "";
                        sReFlag = "다시";
                    } else {
                        rtnValue = reinpuKey;
                        isOk     = true;
                        break;
                    }
                }

                if( iTemp > 3 ) {
                    LogUtil.info("========= 비밀번호 확인 입력이 3회 잘못되었습니다. =========");
                    LogUtil.info("=========종료합니다.========= ");
                    System.exit(1);
                }
            }


        }  catch (IOException ex) {
            LogUtil.error("비밀번호 입력 오류.(Exception)");
            System.exit(1);
        }

        return rtnValue;
    }
    
    
	/**
	 * InputStream에서 읽은 Byte 값을 읽음
	 * @param InputStream inputStream : Byte를 읽기위한 InputStream
	 * @return byte[] : InputStream에서 읽은 바이트
	 */
    private static byte[] getBytes(InputStream inputStream) throws IOException {

        int len;
        int size = 1024;
        byte[] buf;

        if (inputStream instanceof ByteArrayInputStream) {
          size = inputStream.available();
          buf = new byte[size];
          len = inputStream.read(buf, 0, size);
        } else {
          ByteArrayOutputStream bos = new ByteArrayOutputStream();
          buf = new byte[size];
          while ((len = inputStream.read(buf, 0, size)) != -1)
            bos.write(buf, 0, len);
          buf = bos.toByteArray();
        }
        return buf;
      }
    
	/**
	 * Hexa값을 Byte로 변환
	 * @param String hexValue : Byte로 변환할 Hexa값
	 * @return byte[] : 변환된 Byte
	 */
    private static byte[] hexToByteArray(String hexValue) {
        if( hexValue == null || hexValue.length() == 0 ) {
            return null;
        }
        byte[] ba = new byte[hexValue.length()/2];
        for(int i=0; i<ba.length; i++) {
            ba[i] = (byte)Integer.parseInt(hexValue.substring(2*i, 2*i+2), 16);
        }
        return ba;
    }

    
	/**
	 * Byte값을 Hexa로 변환
	 * @param String byteValue : Hexa로 변환할 Byte값
	 * @return String : 변환된 Hexa
	 */
    private static String byteArrayToHex(byte[] byteValue) {
        if( byteValue == null || byteValue.length == 0 ) {
            return null;
        }
        StringBuffer sb = new StringBuffer(byteValue.length*2);
        String hexNumber;
        for(int x=0; x<byteValue.length; x++) {
            hexNumber = "0" + Integer.toHexString(0xff & byteValue[x]);
            sb.append(hexNumber.substring(hexNumber.length() - 2 ));
        }
        return sb.toString();
    }
    
    
	/**
	 * ByteBuffer값을 byte 배열로 변환
	 * @param String buf : 바이트 배열로 변환할 ByteBuffer 값
	 * @return byte[] : 변환된 바이트 배열
	 */
	public static byte[] getByteArray(ByteBuffer buf) {
		buf.rewind();
		byte[] byteArray = new byte[buf.remaining()];
		buf.get(byteArray);
		return byteArray;
	}
	
	
	public static Key makeKey(ByteBuffer key) {
		return new SecretKeySpec(getByteArray(key), "AES");
	}
	
	public static String getDataKeyString(Key key)
	{
		byte[] keyBate2 = key.getEncoded();
		String stringKey = Base64.getEncoder().encodeToString(keyBate2);
		//String stringKey = Base64.encodeBase64String(keyBate2);
		//개행문자 제거
		stringKey = stringKey.replace(System.getProperty("line.separator"), "");
		
		return stringKey;
	}
	
	public static String encrypt(String src, Key key)
			throws Exception {

		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec(IV.getBytes()));

		 byte[] enc = cipher.doFinal(src.getBytes("UTF-8"));
		 String enStr = byteArrayToHex(enc);
		 
		 return enStr;
	}
	
	public static String decrypt(String src, Key key)
			throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException,
			BadPaddingException, InvalidAlgorithmParameterException {

		byte[] decodeBase64src = hexToByteArray(src);

		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");

		cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(IV.getBytes()));
		LogUtil.info(new String(cipher.doFinal(decodeBase64src)));
		return new String(cipher.doFinal(decodeBase64src));
	}
	
	
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
	
	/**`
	 * Oracle용 데이타 암/복호화 키를 생성하는 함수
	 * @param String key : 요청 받은 Key를 입력한다.
	 * @param String fileName : 키를 저장할 파일명
	 * @return void
	 */
	private static void makeOracleKeyFile(String fileName) throws Exception {
		int keyLength = 16;
		
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
		
		//키를 콘솔에서 입력받기
				String inputKey = getKeyByConsoleOracle( bufferedReader );
				
				/*if(inputKey.getBytes().length!=keyLength) {
					throw new Exception("Key length must be "+keyLength+" bits.");
				}*/
				
				byte[] base64Key = Base64.getDecoder().decode(inputKey);
				SecretKey secretKey = new SecretKeySpec(base64Key, "AES");
				byte[] keyByte = secretKey.getEncoded();
				
				FileOutputStream fileOutputStream = new FileOutputStream(fileName);
				fileOutputStream.write(keyByte);
				fileOutputStream.close();
	}
	
	/**
	 * 키를 콘솔에서 입력받기 Oracle
	 * @param BufferedReader bufferedReader : 콘솔에서 키를 입력받기 위한 BufferedReader
	 * @return String : 키
	 */
    private static String getKeyByConsoleOracle(BufferedReader bufferedReader) {
        int     iTemp       = 0;
        boolean isOk        = false;
        String  inputKey   = "";
        String  reinpuKey = "";
        String  rtnValue    = "";
        String  sReFlag     = "";
        
        try {

        	iTemp = 1;
            isOk  = false;
            while(!isOk) {
            	iTemp++;
		    	LogUtil.info( "데이타 암/복호화에 사용할 Key를 "+ sReFlag +" 입력해 주세요.  : " );
		        inputKey = bufferedReader.readLine();
		        inputKey = inputKey == null ? "" : inputKey;
		        
		        if( inputKey == null || "".equals(inputKey) ) {
                    LogUtil.info("Key가 입력되지 않았습니다.");
                } else {
                	isOk = true;
                    break;
                }
		        
                if( iTemp > 3 ) {
                        LogUtil.info("======== key 입력이 3회 잘못되었습니다. ======== ");
                        LogUtil.info("======== 종료합니다. ========= ");
                        System.exit(1);
                }
            }
            
            iTemp   = 1;
            isOk    = false;
            sReFlag = "한번더";
            while(!isOk) {
                iTemp++;
                LogUtil.info( "확인을 위해 Key를 "+ sReFlag +" 입력해 주세요 : " );
                reinpuKey = bufferedReader.readLine();
                reinpuKey = reinpuKey == null ? "" : reinpuKey;

                if( reinpuKey == null || "".equals(reinpuKey) ) {
                    LogUtil.info("Key를 입력해 주세요.");
                } else {

                    if( !inputKey.equals(reinpuKey) ) {
                        LogUtil.info("========= Key가 서로 맞지 않습니다.=========");
                        rtnValue = "";
                        sReFlag = "다시";
                    } else {
                        rtnValue = reinpuKey;
                        isOk     = true;
                        break;
                    }
                }

                if( iTemp > 3 ) {
                    LogUtil.info("========= key 확인 입력이 3회 잘못되었습니다. =========");
                    LogUtil.info("========= 종료합니다.========= ");
                    System.exit(1);
                }
            }
        
        }  catch (IOException ex) {
            LogUtil.error("key 입력 오류.(Exception)");
            LogUtil.error(ex);
            System.exit(1);
        }

        return rtnValue;
    }
	
	
}