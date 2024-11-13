package com.icignal.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 암호화 관련 Util 클래스
 * 
 * @author jskim
 *
 */
public class EncryptUtil {
	
	static final Logger logger = LoggerFactory.getLogger(EncryptUtil.class);
	
	public static byte[] ivBytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };


	/**
	 * 문자열 암호화 함수
	 * 
	 * @param str	암호화 할 문자열
	 * @return String
	 */
	public  final static String AES_Encode(String str)	{
		String rtnValue = "";
		byte[] textBytes;
		try {
			textBytes = str.getBytes("UTF-8");
			AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
			     SecretKeySpec newKey = new SecretKeySpec(CommonUtil.getInstance().getEncryptAESKey().getBytes("UTF-8"), "AES");
			     Cipher cipher = null;
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec);
			rtnValue = Base64.encodeBase64String(cipher.doFinal(textBytes));
		} catch (UnsupportedEncodingException e) {
			LogUtil.debug(e.getMessage());
		} catch (NoSuchAlgorithmException e) {
			LogUtil.debug(e.getMessage());
		} catch (NoSuchPaddingException e) {
			LogUtil.debug(e.getMessage());
		} catch (InvalidKeyException e) {
			LogUtil.debug(e.getMessage());
		} catch (InvalidAlgorithmParameterException e) {
			LogUtil.debug(e.getMessage());
		} catch (IllegalBlockSizeException e) {
			LogUtil.debug(e.getMessage());
		} catch (BadPaddingException e) {
			LogUtil.debug(e.getMessage());
		}
		
		return rtnValue ;
	}

	/**
	 * 문자열 복호화 함수
	 * 
	 * @param str	복호화 할 문자열
	 * @return String
	 */
	public  final static String AES_Decode(String str) {
		String rtnValue = "";
		byte[] textBytes;
		try {
			textBytes = Base64.decodeBase64(str);
			//byte[] textBytes = str.getBytes("UTF-8");
			AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
			SecretKeySpec newKey = new SecretKeySpec(CommonUtil.getInstance().getEncryptAESKey().getBytes("UTF-8"), "AES");
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec);
			rtnValue = new String(cipher.doFinal(textBytes), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			LogUtil.debug(e.getMessage());
		} catch (NoSuchAlgorithmException e) {
			LogUtil.debug(e.getMessage());
		} catch (NoSuchPaddingException e) {
			LogUtil.debug(e.getMessage());
		} catch (InvalidKeyException e) {
			LogUtil.debug(e.getMessage());
		} catch (InvalidAlgorithmParameterException e) {
			LogUtil.debug(e.getMessage());
		} catch (IllegalBlockSizeException e) {
			LogUtil.debug(e.getMessage());
		} catch (BadPaddingException e) {
			LogUtil.debug(e.getMessage());
		}
		
		return rtnValue ;
	}
	
	/**
	 * IFVMEncrypUtility
	 * */
	
	/**
	 * 
	 * @name : AES_Encode
	 * @date : 2014. 11. 10.
	 * @author : 장용
	 * @description : 스트링 문자를 암호화 처리
	 */
//	public  final static String AES_Encode(String str)	{
//		String rtnValue = "";
//		byte[] textBytes;
//		
//		try {
//			textBytes = str.getBytes("UTF-8");
//			AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
//			//로컬 프로퍼티에 encrypt.aes.key 가 없어서 추가하였으며 기존 소스로 원복 함
////			SecretKeySpec newKey = new SecretKeySpec(CommonUtil.getInstance().getServletProp("encrypt.aes.key").getBytes("UTF-8"), "AES");
//			SecretKeySpec newKey = new SecretKeySpec(BeansUtil.getPropertyEncryptKey().getBytes("UTF-8"), "AES");
//			Cipher cipher = null;
//			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
//			cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec);
//			rtnValue = Base64.encodeBase64String(cipher.doFinal(textBytes));
//		} catch (UnsupportedEncodingException e) {
//			LogUtil.error(e);
//		} catch (NoSuchAlgorithmException e) {
//			LogUtil.error(e);
//		} catch (NoSuchPaddingException e) {
//			LogUtil.error(e);
//		} catch (InvalidKeyException e) {
//			LogUtil.error(e);
//		} catch (InvalidAlgorithmParameterException e) {
//			LogUtil.error(e);
//		} catch (IllegalBlockSizeException e) {
//			LogUtil.error(e);
//		} catch (BadPaddingException e) {
//			LogUtil.error(e);
//		}
//		
//		return rtnValue ;
//	}

	/**
	 * 
	 * @name : AES_Decode
	 * @date : 2014. 11. 10.
	 * @author : 장용
	 * @description : 스트링 문자를 복호화 처리
	 */
//	public  final static String AES_Decode(String str) {
//		String rtnValue = "";
//		byte[] textBytes;
//		try {
//			textBytes = Base64.decodeBase64(str);
//			//byte[] textBytes = str.getBytes("UTF-8");
//			AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
//			//로컬 프로퍼티에 encrypt.aes.key 가 없어서 추가하였으며 기존 소스로 원복 함
//			SecretKeySpec newKey = new SecretKeySpec(BeansUtil.getPropertyEncryptKey().getBytes("UTF-8"), "AES");
//			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
//			cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec);
//			rtnValue = new String(cipher.doFinal(textBytes), "UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			logger.debug(e.getMessage());
//		} catch (NoSuchAlgorithmException e) {
//			logger.debug(e.getMessage());
//		} catch (NoSuchPaddingException e) {
//			logger.debug(e.getMessage());
//		} catch (InvalidKeyException e) {
//			logger.debug(e.getMessage());
//		} catch (InvalidAlgorithmParameterException e) {
//			logger.debug(e.getMessage());
//		} catch (IllegalBlockSizeException e) {
//			logger.debug(e.getMessage());
//		} catch (BadPaddingException e) {
//			logger.debug(e.getMessage());
//		}
//		
//		return rtnValue ;
//	}
	
	/**
	 * @name : AES_PBKDF2_Decode
	 * @date : 2017. 6. 20.
	 * @author : "dg.ryu"
	 * @return : String
	 * @description : PBKDF2 방식의 AES 복호화
	 */
	public  final static String AES_PBKDF2_Decode(String ciphertext, 
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
		FileInputStream inputStream = null; 
		FileOutputStream outputStream = null;
		try {
			Cipher cipher = Cipher.getInstance(transformation);
			cipher.init(cipherMode, key);
		
			inputStream = new FileInputStream(inputFile);
			byte[] inputBytes = new byte[(int) inputFile.length()];
			inputStream.read(inputBytes);
			
			byte[] outputBytes = cipher.doFinal(inputBytes);
			
			outputStream = new FileOutputStream(outputFile);
			outputStream.write(outputBytes);
			
			inputStream.close();
			outputStream.close();
			
		} catch (NoSuchPaddingException | NoSuchAlgorithmException | 
				InvalidKeyException | BadPaddingException | 
				IllegalBlockSizeException | IOException e) {
			LogUtil.error(e);
		} finally {
			
				try {
					if(inputStream!=null) inputStream.close();
				} catch (IOException e) {
					LogUtil.error(e);
					inputStream = null;
				}
				
				try {
					if(outputStream!=null) outputStream.close();
				} catch (IOException e) {
					LogUtil.error(e);
					outputStream = null;
				}
			}
		
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
		FileInputStream inputStream = null;
		FileOutputStream outputStream  = null;
		try {
			
			
			Key secretKey = new SecretKeySpec(key.getBytes(), transformation);
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(cipherMode, secretKey);
		
			inputStream = new FileInputStream(inputFile);
			byte[] inputBytes = new byte[(int) inputFile.length()];
			inputStream.read(inputBytes);
			
			byte[] outputBytes = cipher.doFinal(inputBytes);
			
			outputStream = new FileOutputStream(outputFile);
			outputStream.write(outputBytes);
			
			inputStream.close();
			outputStream.close();
		
		} catch (NoSuchPaddingException | NoSuchAlgorithmException | 
				InvalidKeyException | BadPaddingException | 
				IllegalBlockSizeException | IOException e) {
			LogUtil.error(e);
		}  
		finally {
			
			try {
				if(inputStream!=null) inputStream.close();
			} catch (IOException e) {
				LogUtil.error(e);
				inputStream = null;
			}
			
			try {
				if(outputStream!=null) outputStream.close();
			} catch (IOException e) {
				LogUtil.error(e);
				outputStream = null;
			}
			
		}
		
   }
}
