package com.icignal.common.util;

import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

public class PersonalDataUtil {

	/**
	 * 문자열을 전화번호 마스킹 형태도 리턴 11자리 01012345678 -> 010****5678 9 자리 : 02-123-5678 ->
	 * 02***5678 10자리 : 031-123-5678 -> 031***5678 1~ 8자리 : 그대로 return 010-12-456 ->
	 * 01012456 12자리 이상 : 그대로 return
	 * 
	 * @param plainText
	 * 
	 * @return
	 */
	public static String maskedTelephone(String telNum) {
		
		String tempTelNum = telNum;
		tempTelNum = removeSpecialChar(telNum);
		String regex = "(\\d{2,3})(\\d{3,4})\\d{4}$";
		String result = null;

		Pattern p = Pattern.compile("(^[0-9]*$)");
		Matcher m = p.matcher(tempTelNum);

		if (StringUtils.isBlank(tempTelNum)) {
			return "";
		} else if (m.find()) {
			if (tempTelNum.length() == 10 || tempTelNum.length() == 11) {
				Matcher matcher = Pattern.compile(regex).matcher(tempTelNum);
				if (matcher.find()) {
					String replaceTarget = matcher.group(2);
					char[] c = new char[replaceTarget.length()];
					Arrays.fill(c, '*');
					result = tempTelNum.replace(replaceTarget, String.valueOf(c));
				}
			} else {
				result = tempTelNum;
			}
		}
		return result;
	}

	/**
	 * 3자리 -> 홍*동 4자리 이상 -> 홍**동 2자리 -> 홍* 1자리 -> 홍
	 * 
	 * @param plainText
	 * @return
	 */
	public static String maskedCustNm(String plainText) {
		if (StringUtils.isBlank(plainText))	return "";
		return plainText.length() == 2 ? plainText.substring(0, 1) + "*"
				: plainText.substring(0, plainText.length() - 1).replaceAll("(?<=.{1}).", "*")
						+ plainText.substring(plainText.length() - 1, plainText.length());
	}

	/**
	 * k***@naver.com
	 * 
	 * @param plainText
	 * @return
	 */
	public static String maskedEmail(String plainText) {
		if (StringUtils.isBlank(plainText))	return "";
			if (plainText.contains("@")) {
				int idx = plainText.indexOf('@');
				if (idx != 0) {
					String id = plainText.substring(0, idx).replaceAll("(?<=.{1}).", "*");
					String mail = plainText.substring(idx + 1);
					return id + "@" + mail;
				}
				return plainText;
			}
		
		return plainText;
	}


	 /*
	  * 1. 메소드명: maskedWebId
	  * 2. 클래스명: PersonalDataUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 * WebID문자열에 대해 마스킹 처리
	 *	ex) knlee3  -> k***3
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param plainText
	 *   @return	
	 */
	public static String maskedWebId(String plainText) {
		if (StringUtils.isBlank(plainText)) return "";
		return plainText.substring(0, plainText.length() - 1).replaceAll("(?<=.{1}).", "*")
					+ plainText.substring(plainText.length() - 1, plainText.length());
		
	}


	 /*
	  * 1. 메소드명: maskedCardNum
	  * 2. 클래스명: PersonalDataUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 * 1. 카드번호 문자열에 대한 마스킹 처리
	 *	 ex) 1234567890123456 -> 1****************6
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param plainText
	 *   @return	
	 */
	public static String maskedCardNum(String cardNum) {
		String tempCardNum = cardNum;
		String result = null;
		tempCardNum = removeSpecialChar(tempCardNum);
		// 숫자인지 아닌지 패턴확인
		Pattern p = Pattern.compile("(^[0-9]*$)");
		Matcher m = p.matcher(tempCardNum);
		
		if (m.find() && tempCardNum.length() == 16) {
			result =  tempCardNum.substring(0, tempCardNum.length() - 1).replaceAll("(?<=.{1}).", "*")
			+ tempCardNum.substring(tempCardNum.length() - 1, tempCardNum.length());
		}
		return result;
	}

	/**
	 * 특수문자, 공백 제거
	 * 
	 * @param plainText
	 * @return
	 */
	public static String removeSpecialChar(String str) {
		if (StringUtils.isBlank(str)) {
			return "";
		}
		return str.replaceAll( "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]", "").replaceAll(" ", "");
	}
	
	/**
	 * <PRE>
	 * 상세주소 대해 마스킹 처리
	 *	ex) 의사당대로 1  -> ******
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param plainText
	 *   @return	
	 */
	public static String maskedAddr(String plainText) {
		String tempAddr = plainText;
		String result = null;
		
		if (StringUtils.isBlank(plainText)) return "";
		else removeSpecialChar(plainText);
		
		// 신(구)주소, 도로명 주소 
		String regex = "(([가-힣]+(\\d{1,5}|\\d{1,5}(,|.)\\d{1,5}|)+(읍|면|동|가|리))(^구|)((\\d{1,5}(~|-)\\d{1,5}|\\d{1,5})(가|리|)|))([ ](산(\\d{1,5}(~|-)\\d{1,5}|\\d{1,5}))|)|"; 
		String newRegx = "(([가-힣]|(\\d{1,5}(~|-)\\d{1,5})|\\d{1,5})+(로|길))"; 
		Matcher matcher = Pattern.compile(regex).matcher(tempAddr); 
		Matcher newMatcher = Pattern.compile(newRegx).matcher(tempAddr); 
		
		if(matcher.find()) { 
			result = tempAddr.replaceAll("[0-9]", "*"); 
		} else if(newMatcher.find()) { 
			result = tempAddr.replaceAll("[0-9]", "*"); 
		}
		
		return result;
		
	}	

	public static void main(String[] args) {
		LogUtil.info(maskedTelephone("1252"));
		LogUtil.info(removeSpecialChar("@#$^#@$#12 35 12"));
		LogUtil.info(maskedWebId("asdfdfgghsg"));
		LogUtil.info(maskedCustNm("이승"));
		LogUtil.info(maskedEmail("askfsagsg@naver.com"));
		LogUtil.info(maskedCardNum("11111111  1#$111111%1"));
		LogUtil.info(maskedAddr("서울 영등포구 국회대로 780 엘지여의도에클라트"));
	}

}
