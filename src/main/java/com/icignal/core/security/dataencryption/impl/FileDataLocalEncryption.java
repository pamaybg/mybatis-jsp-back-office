package com.icignal.core.security.dataencryption.impl;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.security.Key;
import java.util.Optional;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.env.Environment;

import com.icignal.common.util.LogUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.security.dataencryption.DataEncryption;

public class FileDataLocalEncryption implements DataEncryption {

	private Logger log = LoggerFactory.getLogger(this.getClass().getName());

	private static Key keyObject;

	@Override
	public String getDataEncryptionKey(Environment env, StandardPBEStringEncryptor encryptor ) throws Exception {
		log.info("########## File Data 암호화(Local) Key 생성  ##########");

		String fileName = Optional.ofNullable(env.getProperty("icignal.security.data-encryption.file.key-file"))
				.orElseThrow(() -> new NoSuchFieldError(
						"application.properties 항목 [icignal.security.data-encryption.file.key-file]에 대한 value가 셋팅되어 있지 않습니다."));

		if (fileName == null) {
			LogUtil.error("Value for key file name parameter is not set.");
		}

		String stringKey = "";
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		InputStream inputStream = classLoader.getResourceAsStream(fileName);
		try {
			if (inputStream == null) {
				LogUtil.error("Securety Key File does not exist.");
			}
	
			byte[] keyByte = FileDataLocalEncryption.getBytes(inputStream);
	
			FileDataLocalEncryption.keyObject = new SecretKeySpec(keyByte, "AES");
			if (FileDataLocalEncryption.keyObject != null) {
				byte[] keyBate2 = FileDataLocalEncryption.keyObject.getEncoded();
	
				// Base64.getEncoder().encodeToString(keyBate2);
				Base64.encodeBase64String(keyBate2);
				// stringKey =
				// Base64.getEncoder().encodeToString(CryptoManager.keyObject.getEncoded());
				stringKey = Base64.encodeBase64String(FileDataLocalEncryption.keyObject.getEncoded());
	
				// 개행문자 제거
				stringKey = stringKey.replace(System.getProperty("line.separator"), "");
	
				stringKey = SecurityUtil.generateHMAC(stringKey, "123456789012") + "@@@!!!" + stringKey;
			}
		} finally {
			inputStream.close();
		}
		return stringKey;
	}
	public static void main(String[] args) throws Exception {
		FileDataLocalEncryption.makeKeyFile("file_key_dev.dat");
	}

	/**
	 * Mysql용 AES key 생성
	 *
	 * @param String key : 데이타 암/복호화용 key 값
	 * @param String key : key에 대한 charset
	 * @return SecretKeySpec : Key Object
	 */
	private static SecretKeySpec generateAESKey(final String key, final String encoding) {
		try {
			final byte[] finalKey = new byte[16];
			int i = 0;
			for (byte b : key.getBytes(encoding))
				finalKey[i++ % 16] ^= b;
			return new SecretKeySpec(finalKey, "AES");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Mysql용 데이타 암/복호화 키를 생성하는 함수
	 *
	 * @param String key : 데이타 암/복호를 위한 키(mysql은 256비트 지원안하므로 26자리, oracle은 32자리로
	 *               사용해야 함)
	 * @param String fileName : 키를 저장할 파일명
	 * @return void
	 */
	private static void makeKeyFile(String fileName) throws Exception {

		int keyLength = 26;

		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
		FileOutputStream fileOutputStream = new FileOutputStream(
				"src/main/resources/security/encryption_key/" + fileName);
		// 키를 콘솔에서 입력받기
		String inputKey = getKeyByConsole(keyLength, bufferedReader);

		// 키를 암호화할 비밀키를 콘솔에서 입력 받기
		String keyPassword = getPasswordKeyByConsole(keyLength, bufferedReader);
		try {
			if (inputKey.getBytes().length != keyLength) {
				throw new IllegalArgumentException("Key length must be " + keyLength + " bits.");
			}
	
			if (keyPassword.getBytes().length != keyLength) {
				throw new IllegalArgumentException("Password length must be " + keyLength + " bits.");
			}
	
			// key를 암호화 시킴
			final Cipher encryptCipher = Cipher.getInstance("AES");
			encryptCipher.init(Cipher.ENCRYPT_MODE, generateAESKey(keyPassword, "UTF-8"));
			byte[] encodedKey = encryptCipher.doFinal(inputKey.getBytes("UTF-8"));
			String hexKey = byteArrayToHex(encodedKey);
	
			byte[] base64Key = Base64.decodeBase64(hexKey);
			SecretKey secretKey = new SecretKeySpec(base64Key, "AES");
			byte[] keyByte = secretKey.getEncoded();
	
			fileOutputStream.write(keyByte);
		} finally {
			bufferedReader.close();
			fileOutputStream.close();
		}
		
	}

	/**
	 * 키를 콘솔에서 입력받기
	 *
	 * @param int            keyLength : Key 사이즈
	 * @param BufferedReader bufferedReader : 콘솔에서 키를 입력받기 위한 BufferedReader
	 * @return String : 키
	 */
	private static String getKeyByConsole(int keyLength, BufferedReader bufferedReader) {
		int iTemp = 0;
		boolean isOk = false;
		String inputKey = "";
		String reinpuKey = "";
		String rtnValue = "";
		String sReFlag = "";

		try {

			iTemp = 1;
			isOk = false;
			while (!isOk) {
				iTemp++;
				LogUtil.info("데이타 암/복호화에 사용할 " + keyLength + "자리 Key를 " + sReFlag + " 입력해 주세요.  : ");
				inputKey = bufferedReader.readLine();
				inputKey = inputKey == null ? "" : inputKey;

				if (inputKey == null || "".equals(inputKey)) {
					LogUtil.info("Key가 입력되지 않았습니다.");
				} else {

					if (inputKey.getBytes().length != keyLength) {
						LogUtil.info(
								"Key는 " + keyLength + "자리여야 합니다.  입력한 Key는 " + inputKey.getBytes().length + "자리입니다. ");
						sReFlag = " 다시";
					} else {
						isOk = true;
						break;
					}
				}

				if (iTemp > 3) {
					LogUtil.info("======== key 입력이 3회 잘못되었습니다. ======== ");
					LogUtil.info("======== 종료합니다. ========= ");
					System.exit(1);
				}
			}

			/* 암호키 확인 */
			iTemp = 1;
			isOk = false;
			sReFlag = "한번더";
			while (!isOk) {
				iTemp++;
				LogUtil.info("확인을 위해 Key를 " + sReFlag + " 입력해 주세요 : ");
				reinpuKey = bufferedReader.readLine();
				reinpuKey = reinpuKey == null ? "" : reinpuKey;

				if (reinpuKey == null || "".equals(reinpuKey)) {
					LogUtil.info("Key를 입력해 주세요.");
				} else {

					if (!inputKey.equals(reinpuKey)) {
						LogUtil.info("========= Key가 서로 맞지 않습니다.=========");
						rtnValue = "";
						sReFlag = "다시";
					} else {
						rtnValue = reinpuKey;
						isOk = true;
						break;
					}
				}

				if (iTemp > 3) {
					LogUtil.info("========= key 확인 입력이 3회 잘못되었습니다. =========");
					LogUtil.info("========= 종료합니다.========= ");
					System.exit(1);
				}
			}

		} catch (IOException ex) {
			LogUtil.info("key 입력 오류.(Exception)");
			LogUtil.error(ex);
			System.exit(1);
		}

		return rtnValue;
	}

	/**
	 * 키를 암호화할 비밀키를 콘솔에서 입력 받기
	 *
	 * @param int            keyLength : Key 사이즈
	 * @param BufferedReader bufferedReader : 콘솔에서 키를 입력받기 위한 BufferedReader
	 * @return String : 키를 암호화할 비밀번호
	 */
	private static String getPasswordKeyByConsole(int keyLength, BufferedReader bufferedReader) {
		int iTemp = 0;
		boolean isOk = false;
		String inputKey = "";
		String reinpuKey = "";
		String rtnValue = "";
		String sReFlag = "";

		try {

			iTemp = 1;
			isOk = false;
			while (!isOk) {
				iTemp++;
				LogUtil.info("입력한 Key를 암호화하기 위해 사용할 " + keyLength + "자리 비밀번호를 " + sReFlag + " 입력해 주세요.  : ");
				inputKey = bufferedReader.readLine();
				inputKey = inputKey == null ? "" : inputKey;

				if (inputKey == null || "".equals(inputKey)) {
					LogUtil.info("Key가 입력되지 않았습니다.");
				} else {

					if (inputKey.getBytes().length != keyLength) {
						LogUtil.info("비밀번호는 " + keyLength + "자리여야 합니다.  입력한 비밀번호는 " + inputKey.getBytes().length
								+ "자리입니다. ");
						sReFlag = " 다시";
					} else {
						isOk = true;
						break;
					}
				}

				if (iTemp > 3) {
					LogUtil.info("======== 비밀번호 입력이 3회 잘못되었습니다. ======== ");
					LogUtil.info("======== 종료합니다. =========");
					System.exit(1);
				}
			}

			/* 암호키 확인 */
			iTemp = 1;
			isOk = false;
			sReFlag = "한번더";
			while (!isOk) {
				iTemp++;
				LogUtil.info("확인을 위해 비밀번호를 " + sReFlag + " 입력해 주세요 : ");
				reinpuKey = bufferedReader.readLine();
				reinpuKey = reinpuKey == null ? "" : reinpuKey;

				if (reinpuKey == null || "".equals(reinpuKey)) {
					LogUtil.info("Key를 입력해 주세요.");
				} else {

					if (!inputKey.equals(reinpuKey)) {
						LogUtil.info("========= 비밀번호가 서로 맞지 않습니다.=========");
						rtnValue = "";
						sReFlag = "다시";
					} else {
						rtnValue = reinpuKey;
						isOk = true;
						break;
					}
				}

				if (iTemp > 3) {
					LogUtil.info("========= 비밀번호 확인 입력이 3회 잘못되었습니다. =========");
					LogUtil.info("=========종료합니다.========= ");
					System.exit(1);
				}
			}

		} catch (IOException ex) {
			LogUtil.info("비밀번호 입력 오류.(Exception)");
			LogUtil.error(ex);
			System.exit(1);
		}

		return rtnValue;
	}

	/**
	 * InputStream에서 읽은 Byte 값을 읽음
	 *
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
	 * Byte값을 Hexa로 변환
	 *
	 * @param String hexValue : Hexa로 변환할 Byte값
	 * @return String : 변환된 Hexa
	 */
	private static String byteArrayToHex(byte[] byteValue) {
		if (byteValue == null || byteValue.length == 0) {
			return null;
		}
		StringBuffer sb = new StringBuffer(byteValue.length * 2);
		String hexNumber;
		for (int x = 0; x < byteValue.length; x++) {
			hexNumber = "0" + Integer.toHexString(0xff & byteValue[x]);
			sb.append(hexNumber.substring(hexNumber.length() - 2));
		}
		return sb.toString();
	}
	public Logger getLog() {
		return log;
	}
	public void setLog(Logger log) {
		this.log = log;
	}
	
	
}
