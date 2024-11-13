 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.net.URLDecoder;
import java.nio.ByteBuffer;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.bson.types.ObjectId;
import org.springframework.util.Base64Utils;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.core.exception.DataBadRequestException;
import com.icignal.core.util.DefaultJsonNamingStrategy;

/**
 * 1. FileName	: StringUtils.java
 * 2. Package	: com.icignal.core.util
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 20. 오후 2:09:44
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 20.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: StringUtils
 * 2. 파일명	: StringUtils.java
 * 3. 패키지명	: com.icignal.core.util
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class StringUtil {

	 /*
	  * 1. 메소드명: equals
	  * 2. 클래스명: StringUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	2개의 String 문자열이 값  비교 함수. ( 두 값중 하나라도 null 이거나, 공백(blank) 이면 false)	 *  
	 *  ex) str1 = null ; str2 = null; => false
	 *  str1 = null , str2 = null  => false	   
	 *  str1 = "" , str2 = "" => false
	 *  str1 = "" , str2 = " " => false
	 *  str1 = "a", str2="ab" => false
	 *  str1 = "a", str2="a " => false
	 *  str1 = "a", str2="a" => true
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param str1
	 *   @param str2
	 *   @return	
	 */
	public static boolean compare(String str1, String str2 ) {		
		if(str1 == null || str2 == null ) return false;
		if(StringUtils.isAnyBlank(str1, str2) ) return false;
		if ( StringUtils.compare(str1, str2) == 0 ) return true;		
		return false;
	}

	/*
	 * 1. 메소드명: camelToSnakeCase
	 * 2. 클래스명: StringUtil
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 7. 8.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *	Camel Case인 String을 Snake Case로 변환합니다 *
	 *  ex) custNm -> cust_nm(Camel Case to Snake Case)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param camelWord
	 *   @return snakeWord
	 */
	public static String camelToSnakeCase(String camelWord) {
		String regex = "([a-z])([A-Z]+)";
		String replacement = "$1_$2";
		String snakeWord = "";

		snakeWord = camelWord.replaceAll(regex, replacement).toLowerCase();

		return snakeWord;
	}
	
	 /*
	  * 1. 메소드명: compareLoozy
	  * 2. 클래스명: StringUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 2개의 String 문자열이 값  비교 함수. ( 두 값중 하나라도 null 이거나, 공백(blank) 이면 false)	
	 * 공백제거(trim()) 후  대소문자 구분 안하고 문자열 비교함.  ext) y , Y => true  
	 * 2. 사용법
	 *   ex) str1 = null ; str2 = null; => false
	 *  str1 = null , str2 = null  => false	   
	 *  str1 = "" , str2 = "" => false
	 *  str1 = "" , str2 = " " => false
	 *  str1 = "a", str2="ab" => false
	 *  str1 = "a", str2="a " => true
	 *  str1 = "a", str2=" a" => true
	 *  str1 = "a", str2=" A" => true		
	 * </PRE>
	 *   @param str1
	 *   @param str2
	 *   @return	
	 */
	public static boolean compareLoozy(String str1, String str2 ) {		
		if(str1 == null || str2 == null ) return false;
		return StringUtil.compare(str1.trim().toLowerCase(), str2.trim().toLowerCase()); 
		
	
	}

	/*
	  * 1. 메소드명: main
	  * 2. 클래스명: StringUtils
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param args	
	 */

	public static void main(String[] args) {

		    String pwd=getRandomNum(4);
		    System.out.println(pwd);
		    

	}
	
	/**
	 * StringUtility
	 * */
	/**
	 * 클래스의 collection 이름을 반환한다
	 * 
	 * @param cls	대상이 되는 클래스
	 * @return		collection 이름
	 */
	public final static String getCollectionName(@SuppressWarnings("rawtypes") Class cls) {
		return cls.getAnnotations()[0].toString().substring(cls.getAnnotations()[0].toString().indexOf("collection") + 11, cls.getAnnotations()[0].toString().length() - 1);
	}

	/**
	 * 대상이 되는 문자열의 각 문자가 1byte인지 여부를 판단하여
	 * 각 문자의 길이에 맞도록(문자가 깨지지 않도록) 지정한 길이 만큼 자른다. 
	 * {@link UnsupportedEncodingException} 예외발생시 로그출력
	 * 
	 * @param szText	대상이 되는 UTF-8 문자열
	 * @param nLength	문자열 길이
	 * @return			변환된 문자열
	 */
	public final static String strCut(String szText, int nLength)
	{ // 문자열 자르기
		String r_val = szText;
		int oF = 0, oL = 0, rF = 0, rL = 0;
		int nLengthPrev = 0;
		try
		{
			byte[] bytes = r_val.getBytes("UTF-8"); // 바이트로 보관
			// x부터 y길이만큼 잘라낸다. 한글안깨지게.
			int j = 0;
			if (nLengthPrev > 0) {
				while (j < bytes.length)
				{
					if ((bytes[j] & 0x80) != 0)
					{
						oF += 2;
						rF += 3;
						if (oF + 2 > nLengthPrev)
						{
							break;
						}
						j += 3;
					}
					else
					{
						if (oF + 1 > nLengthPrev)
						{
							break;
						}
						++oF;
						++rF;
						++j;
					}
				}
			}
			j = rF;
			while (j < bytes.length)
			{
				if ((bytes[j] & 0x80) != 0)
				{
					if (oL + 2 > nLength)
					{
						break;
					}
					oL += 2;
					rL += 3;
					j += 3;
				}
				else
				{
					if (oL + 1 > nLength)
					{
						break;
					}
					++oL;
					++rL;
					++j;
				}
			}
			r_val = new String(bytes, rF, rL, "UTF-8"); // charset 옵션
		}
		catch (UnsupportedEncodingException e)
		{
			LogUtil.error(e);
		}
		return r_val;
	}

	/**
	 * 문자열의 byte 길이를 반환한다
	 * 
	 * @param str	대상이 되는 문자열
	 * @return		바이트 길이
	 */
	public final static int checkByte(String str) {
		int len = str.length();
		int cnt = 0;

		for(int i=0; i<len; i++){
			if(str.charAt(i) < 256) {
				cnt++;
			} else {
				cnt = cnt + 2;
			}
		}

		return cnt;
	}

	/**
	 * 대상 문자열을 Base64 방식으로 인코딩하여 반환한다.
	 * {@link UnsupportedEncodingException} 예외발생시 로그출력
	 * 
	 * @param str	대상이 되는 UTF-8 문자열
	 * @return		변환된 문자열
	 */ 
	public final static String encodeBase64(String str) {
		byte[] encodeByte = null;
		try {
			encodeByte = Base64Utils.encode(str.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			
			LogUtil.error(e);
		}
		return new String (encodeByte);
	}

	/**
	 * 대상 문자열을 Base64 방식으로 디코딩하여 반환한다.
	 * {@link UnsupportedEncodingException} 예외발생시 로그출력
	 * 
	 * @param str	대상이 되는 UTF-8 문자열
	 * @return		변환된 문자열
	 */
	public final static String decodeBase64(String str) {
		byte[] decodeByte = null;
		try {
			decodeByte = Base64Utils.decode(str.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			
			LogUtil.error(e);
		}
		return new String (decodeByte);
	}

	/**
	 * 대상 문자열을 UTF-8 방식으로 디코딩하여 반환한다.
	 * {@link UnsupportedEncodingException} 예외발생시 로그출력
	 * 
	 * @param str	대상이 되는 문자열
	 * @return		변환된 문자열
	 */
	public final static String decodeUTF8(String str) {
		String rtnValue = "";
		try {
			rtnValue =URLDecoder.decode(str, "utf-8");
		} catch (UnsupportedEncodingException e) {
			
			LogUtil.error(e);
		}
		return rtnValue;
	}

	/**
	 * 대상 문자열을 지정된 캐릭터셋으로 로그 출력하고
	 * 지정된 캐릭터셋이 아니라면 예외를 던진다
	 * 
	 * @param value		대상 문자열
	 * @throws 			UnsupportedEncodingException
	 */
	public final static void printformat(String value) throws UnsupportedEncodingException {
		String charset[] = {"KSC5601","8859_1", "ascii", "UTF-8", "EUC-KR", "MS949"};


		for(int i=0; i<charset.length ; i++){
			for(int j=0 ; j<charset.length ; j++){
				if(i==j){ continue;}
				else{
					LogUtil.info(charset[i]+" : "+charset[j]+" :" +new String (value.getBytes(charset[i]),charset[j]));
				}
			}
		} 
	}

	/**
	 * jackson 라이브러리를 이용하여 객체를 JSON 형식의 문자열로 반환
	 * 
	 * @param obj	대상이 되는 객체
	 * @return		변환된 문자열
	 */
	public final static String getJSONtoObject(Object obj) {
		String rtnValue = "";
		try { 
			LogUtil.info("obj: " + obj.toString());
			rtnValue = new ObjectMapper().writeValueAsString(obj);

		} catch (JsonGenerationException e) {
			LogUtil.info("e1");
			LogUtil.error(e);
			LogUtil.info(e.getMessage());
		} catch (JsonMappingException e) {
			LogUtil.info("e2");
			LogUtil.error(e);
			LogUtil.info(e.getMessage());
		} catch (IOException e) {
			LogUtil.info("e3");
			LogUtil.error(e);
			LogUtil.info(e.getMessage());
		}
		return rtnValue;
	}

	public final static Object getObjectToJSON(Class<?> theClass, HttpServletRequest request) {
		Object rtnValue = null;
		try {
			if (!theClass.isPrimitive()) {
				rtnValue = theClass.newInstance();
				try {
					String str = request.getParameter("jsonData");
					if (str.startsWith("\"")) {
						str = str.replace("\\", "");
						str = str.substring(1, str.length());
						str = str.substring(0, str.length() - 1);
					}
					rtnValue = new ObjectMapper().readValue(str, theClass);
				} catch (IOException e) {
					LogUtil.error(e.getMessage(), e);
				}

			}
		} catch (InstantiationException | IllegalAccessException e1) {
			LogUtil.error(e1);
		}

		return rtnValue;
	}


	/**
	 * null 을 공백으로 바꾼다
	 * 
	 * @param str	대상이 되는 문자열
	 * @return		변환된 문자열
	 */
	public final static String convertNull(String str) {
		String strdata = str;
		if(strdata == null) {
			strdata = "";
		}

		return strdata;
	}

	/**
	 * 문자열을 ByteBuffer 에 넣는다
	 * 
	 * @param str	대상이 되는 문자열
	 * @return		바이트 버퍼
	 */
	public final static ByteBuffer getByteBuffer(String str) {
		String tmpStr = str;
		byte[] bytes = tmpStr.getBytes();
		ByteBuffer bb = ByteBuffer.allocate(bytes.length);		
		bb.put(bytes,0,bytes.length);		
		return bb;
	}

	/**
	 * 고정길이 숫자형태의 문자열을 얻는다. 남는자리는 '0'
	 * 
	 * @param number	변환할 대상이 되는 문자열
	 * @param len		문자열 길이
	 * @return			변환된 문자열
	 */
	public final static String getFixedNumber(String number, int len) {
		String str = number;
		str = StringUtil.replace(str, " ", "");
		if(str == null) {
			str = "0";
		} else if(str.length() > len) {
			str = str.substring(0, len);
		}

		str = String.valueOf(Integer.parseInt(str));
		StringBuffer sbString = new StringBuffer();

		for(int i=str.length(); i<len; i++) {
			sbString.append("0");
		}

		sbString.append(str);

		return sbString.toString();
	}

	/**
	 * 
	 * @param one_str
	 * @param len
	 * @return String
	 */
	public final static String getFixedOneStr(String one_str, int len) {
		String str = one_str;

		if(str == null) {
			str = "";
		} else if(str.length() > len) {
			str = str.substring(0, len);
		}

		StringBuffer sbString = new StringBuffer();

		for(int i=str.length(); i<len; i++) {
			sbString.append(one_str);
		}

		sbString.append(str);

		return sbString.toString();
	}

	/**
	 * 고정길이 숫자형태의 문자열을 얻는다. 남는자리는 '0'
	 * 
	 * @param number	변환할 대상이 되는 정수
	 * @param len		문자열 길이
	 * @return			변환된 문자열
	 */
	public final static String getFixedNumber(int number, int len) {
		String str = String.valueOf(number);

		if(str == null) {
			str = "";
		} else if(str.length() > len) {
			str = str.substring(0, len);
		}

		StringBuffer sbString = new StringBuffer();

		for(int i=str.length(); i<len; i++) {
			sbString.append("0");
		}

		sbString.append(str);

		return sbString.toString();
	}

	/**
	 * 고정길이 byte 로 자른 문자열 배열을 얻는다
	 * 
	 * @param str			변환할 대상이 되는 문자열
	 * @param byteLength	바이트 길이
	 * @return				변환된 문자열
	 */
	public final static String[] getFixedByteArray(String str, int byteLength) {

		List<String> aList = new ArrayList<String>();
		String tmpStr = str;
		if(tmpStr == null) {
			tmpStr = "";
		}
		if(tmpStr.getBytes().length < byteLength) {
			aList.add(getFixedByte(tmpStr, byteLength));
		} else {
			byte[] byteString = tmpStr.getBytes();
			int startPos = 0;
			int endPos = 0+byteLength;

			while(byteString.length>startPos) {
				String tmp = "";
				if(byteString.length >= (startPos+byteLength)) {
					tmp = new String(byteString,startPos,byteLength);
				} else {
					tmp = new String(byteString,startPos,byteString.length-startPos);
				}

				aList.add(getFixedByte(tmp,byteLength));
				startPos = startPos + byteLength;
				endPos = endPos + byteLength;
			}
		}

		String[] strArray = new String[aList.size()];
		aList.toArray(strArray);
		aList.clear();
		return strArray;
	}

	/**
	 * 고정길이 byte 로 자른 문자열을 얻는다
	 * 
	 * @param str			변환할 대상이 되는 문자열
	 * @param byteLength	바이트 길이
	 * @return				변환된 문자열
	 */
	public final static String getFullFixedByte(String str, int byteLength) {
		String strdata = str;
		int byteLengthdata = byteLength;
		strdata = getFullString(strdata);
		strdata = getFixedByte(strdata, byteLengthdata-2);
		strdata = strdata + "  ";
		return strdata;
	}

	/**
	 * 고정길이 byte 로 자른 문자열을 얻는다
	 * 
	 * @param str			변환할 대상이 되는 문자열
	 * @param byteLength	바이트 길이
	 * @return				변환된 문자열
	 */
	public final static String getFixedByte(String str, int byteLength) {
		StringBuffer sbString = new StringBuffer();
		String tmpStr = str;
		if(tmpStr == null) {
			tmpStr = "";
		}

		sbString.append(tmpStr);

		for(int i=tmpStr.getBytes().length; i<byteLength; i++) {
			sbString.append(" ");
		}
		tmpStr = sbString.toString();
		byte[] byteString = tmpStr.getBytes();

		return new String(byteString,0,byteLength);
	}

	/**
	 * 시작위치로 부터 특정 길이의 고정길이 문자열을 얻는다
	 * 
	 * @param str		변환할 대상이 되는 문자열
	 * @param startPos	시작 위치
	 * @param endPos	끝 위치
	 * @return			변환된 문자열
	 */
	public final static String getFixedByte(String str, int startPos, int endPos) {
		String tmpStr = str;
		tmpStr = getFixedByte(tmpStr, endPos);
		return new String(tmpStr.getBytes(), startPos, endPos-startPos);
	}

	/**
	 * 반자를 전자로 변환한다
	 * 
	 * @param 	strHalf	변환할 대상이 되는 문자열
	 * @return			변환된 문자열
	 */
	public final static String getFullString(String strHalf) {

		if(strHalf == null) {
			return strHalf;
		}

		char[] charArray = strHalf.toCharArray();

		for(int i=0; i<charArray.length; i++) {			
			if(charArray[i] >= 0x21 && charArray[i] <= 0x7E) {
				// 반자 영문 영숫자/문자부호를 골라, 0xFEE0 만큼 더한다.
				charArray[i] += 0xFEE0;
			} else if(charArray[i] == 0x20) {
				// 반자 공백을 전자 공백으로 바꾼다.
				charArray[i] = 0x3000;
			}
		}

		String strFull = new String(charArray);

		return strFull;
	}

	/**
	 * 전자를 반자로 변환한다
	 * 
	 * @param 	strFull	변환할 대상이 되는 문자열
	 * @return			변환된 문자열
	 */
	public final static String getHalfString(String strFull) {

		if(strFull == null) {
			return strFull;
		}

		char[] charArray = strFull.toCharArray();

		for(int i=0; i<charArray.length; i++) {			
			if(charArray[i] >= 0xFF01 && charArray[i] <= 0xFF5E) {
				// 전자 영문 영숫자/문자부호를 골라, 0xFEE0 만큼 뺀다.
				charArray[i] -= 0xFEE0;
			} else if(charArray[i] == 0x3000) {
				// 전자 공백을 반자 공백으로 바꾼다.
				charArray[i] = 0x20;
			}
		}

		String strHalf = new String(charArray);
		return strHalf;
	}	

	/**
	 * 문자열에서 특정 문자열을 찾아서 대체 문자열로 대체하여 반환한다.
	 * 
	 * @param str	변환할 대상이 되는 문자열
	 * @param src	찾을 문자열
	 * @param dst	대체할 문자열
	 * @return		변경된 문자열
	 */
	public static String replace(String str, String src, String dst) 
	{
		String strdata = str;
		String srcdata = src;
		String dstdata = dst;
		if(strdata == null || srcdata == null || dstdata == null || strdata.length() == 0 || srcdata.length() == 0) {
			return strdata;
		}

		int srcLength = srcdata.length(), pos = 0, dstLength = dstdata.length();
		while(true) {
			pos = strdata.indexOf(srcdata,pos);
			if(pos != -1) {
				if((pos+srcLength) < strdata.length()) {
					strdata = strdata.substring(0,pos) + dstdata + strdata.substring(pos+srcLength);
				} else {
					strdata = strdata.substring(0,pos) + dstdata;
				}

				pos = pos + dstLength;

				if(pos > strdata.length()) {
					pos = strdata.length();
				}
			} else {
				break;	
			}	
		}
		return strdata;
	}

	/**
	 * 대상 문자열을 구분자로 나눠서 문자열 배열로 반환
	 * 
	 * @param str			변환할 대상이 되는 문자열
	 * @param separator		문자열 구분자
	 * @return				문자열 배열
	 */
	public final static String[] getStringArray(String str, String separator) {
		String strdata = str;
		String separatordata = separator;
		strdata = StringUtil.replace(strdata, separatordata, " " + separatordata);

		StringTokenizer strToken = new StringTokenizer(strdata, separatordata);
		String[] strArray = null;

		List<String> list = new ArrayList<String>();		

		while (strToken.hasMoreTokens()) {
			list.add(strToken.nextToken().toString().trim()); 
		}

		strArray = new String[list.size()];
		list.toArray(strArray);
		list.clear();

		return strArray;
	}	

	/**
	 * 
	 * @param str
	 * @param separator
	 * @return String[]
	 */
	public final static String[] getStringArrayTelNo(String str, String separator) {
		String strdata = str;
		String separatordata = separator;
		strdata = StringUtil.replace(strdata, separatordata, " " + separatordata);

		StringTokenizer strToken = new StringTokenizer(strdata, separatordata);
		String[] strArray = null;
		String[] strArrayTelNo = new String[3];
		strArrayTelNo[0] = "";
		strArrayTelNo[1] = "";
		strArrayTelNo[2] = "";


		List<String> list = new ArrayList<String>();		

		while (strToken.hasMoreTokens()) {
			list.add(strToken.nextToken().toString().trim()); 
		}

		strArray = new String[list.size()];
		list.toArray(strArray);
		list.clear();

		for(int i=0; i<strArray.length; i++) {
			strArrayTelNo[2-i] = strArray[strArray.length-i-1];
		}

		return strArrayTelNo;
	}	

	/**
	 * 문자열이 최대자릿수 보다 크면,
	 * 문자열을 최대자릿수 만큼 자른 후 '...'을 끝에 붙여서 반환
	 * 
	 * @param str		변환할 대상이 되는 문자열
	 * @param endIndex	변환할 문자열 최대자릿수
	 * @return			변환된 문자열
	 */
	public final static String cutStrInByte(String str, int endIndex)
	{
		StringBuffer sbStr = new StringBuffer(endIndex);
		int iTotal=0;
		char[] chars = str.toCharArray(); 

		for(int i=0; i<chars.length; i++)
		{
			iTotal+=String.valueOf(chars[i]).getBytes().length;
			if(iTotal>endIndex)
			{
				sbStr.append("...");  // ... 붙일것인가 옵션
				break;
			}
			sbStr.append(chars[i]);
		}
		return sbStr.toString();
	}

	/**
	 * 한글을 영문으로 변환한다
	 * 
	 * @param str	변환할 한글 문자열
	 * @return		변환된 영문 문자열
	 */
	public final static String convertHangul_English(String str) {

		String tmpStr = str;
		if(tmpStr.indexOf("사용자") >= 0) {
			tmpStr = tmpStr.replaceAll("사용자","User");
		} else if(tmpStr.indexOf("프로그램") >= 0) {
			tmpStr = tmpStr.replaceAll("프로그램","Pgm");
		} else if(tmpStr.indexOf("재무재표") >= 0) {
			tmpStr = tmpStr.replaceAll("재무재표","BSPL");
		} else if(tmpStr.indexOf("부가가치세") >= 0) {
			tmpStr = tmpStr.replaceAll("부가가치세","VAT");
		} else if(tmpStr.indexOf("생성") >= 0) {
			tmpStr = tmpStr.replaceAll("생성","Crt");
		} else if(tmpStr.indexOf("코드") >= 0) {
			tmpStr = tmpStr.replaceAll("코드","Cd");
		} else if(tmpStr.indexOf("문서") >= 0) {
			tmpStr = tmpStr.replaceAll("문서","Doc");
		} else if(tmpStr.indexOf("보고서") >= 0) {
			tmpStr = tmpStr.replaceAll("보고서","Rpt");
		} else if(tmpStr.indexOf("공지사항") >= 0) {
			tmpStr = tmpStr.replaceAll("공지사항","Notice");
		} else if(tmpStr.indexOf("공지") >= 0) {
			tmpStr = tmpStr.replaceAll("공지","Notice");
		} else if(tmpStr.indexOf("카드") >= 0) {
			tmpStr = tmpStr.replaceAll("카드","Card");
		}

		tmpStr = tmpStr.replaceAll( "가", "Ga");    
		tmpStr = tmpStr.replaceAll( "각", "Gak");   
		tmpStr = tmpStr.replaceAll( "간", "Gan");   
		tmpStr = tmpStr.replaceAll( "갈", "Gal");   
		tmpStr = tmpStr.replaceAll( "감", "Gam");   
		tmpStr = tmpStr.replaceAll( "갑", "Gap");   
		tmpStr = tmpStr.replaceAll( "갓", "Gat");   
		tmpStr = tmpStr.replaceAll( "강", "Gang");  
		tmpStr = tmpStr.replaceAll( "개", "Gae");   
		tmpStr = tmpStr.replaceAll( "객", "Gaek");  
		tmpStr = tmpStr.replaceAll( "거", "Geo");   
		tmpStr = tmpStr.replaceAll( "건", "Geon");  
		tmpStr = tmpStr.replaceAll( "걸", "Geol");  
		tmpStr = tmpStr.replaceAll( "검", "Geom");  
		tmpStr = tmpStr.replaceAll( "겁", "Geop");  
		tmpStr = tmpStr.replaceAll( "게", "Ge");    
		tmpStr = tmpStr.replaceAll( "겨", "Gyeo");  
		tmpStr = tmpStr.replaceAll( "격", "Gyeok"); 
		tmpStr = tmpStr.replaceAll( "견", "Gyeon"); 
		tmpStr = tmpStr.replaceAll( "결", "Gyeol"); 
		tmpStr = tmpStr.replaceAll( "겸", "Gyeom"); 
		tmpStr = tmpStr.replaceAll( "겹", "Gyeop"); 
		tmpStr = tmpStr.replaceAll( "경", "Gyeong");
		tmpStr = tmpStr.replaceAll( "계", "Gye");   
		tmpStr = tmpStr.replaceAll( "고", "Go");    
		tmpStr = tmpStr.replaceAll( "곡", "Gok");   
		tmpStr = tmpStr.replaceAll( "곤", "Gon");   
		tmpStr = tmpStr.replaceAll( "골", "Gol");   
		tmpStr = tmpStr.replaceAll( "곳", "Got");   
		tmpStr = tmpStr.replaceAll( "공", "Gong");  
		tmpStr = tmpStr.replaceAll( "곶", "Got");   
		tmpStr = tmpStr.replaceAll( "과", "Gwa");   
		tmpStr = tmpStr.replaceAll( "곽", "Gwak");  
		tmpStr = tmpStr.replaceAll( "관", "Gwan");  
		tmpStr = tmpStr.replaceAll( "괄", "Gwal");  
		tmpStr = tmpStr.replaceAll( "광", "Gwang"); 
		tmpStr = tmpStr.replaceAll( "괘", "Gwae");  
		tmpStr = tmpStr.replaceAll( "괴", "Goe");   
		tmpStr = tmpStr.replaceAll( "굉", "Goeng"); 
		tmpStr = tmpStr.replaceAll( "교", "Gyo");   
		tmpStr = tmpStr.replaceAll( "구", "Gu");    
		tmpStr = tmpStr.replaceAll( "국", "Guk");   
		tmpStr = tmpStr.replaceAll( "군", "Gun");   
		tmpStr = tmpStr.replaceAll( "굴", "Gul");   
		tmpStr = tmpStr.replaceAll( "굿", "Gut");   
		tmpStr = tmpStr.replaceAll( "궁", "Gung");  
		tmpStr = tmpStr.replaceAll( "권", "Gwon");  
		tmpStr = tmpStr.replaceAll( "궐", "Gwol");  
		tmpStr = tmpStr.replaceAll( "귀", "Gwi");   
		tmpStr = tmpStr.replaceAll( "규", "Gyu");   
		tmpStr = tmpStr.replaceAll( "균", "Gyun");  
		tmpStr = tmpStr.replaceAll( "귤", "Gyul");  
		tmpStr = tmpStr.replaceAll( "그", "Geu");   
		tmpStr = tmpStr.replaceAll( "극", "Geuk");  
		tmpStr = tmpStr.replaceAll( "근", "Geun");  
		tmpStr = tmpStr.replaceAll( "글", "Geul");  
		tmpStr = tmpStr.replaceAll( "금", "Geum");  
		tmpStr = tmpStr.replaceAll( "급", "Geup");  
		tmpStr = tmpStr.replaceAll( "긍", "Geung"); 
		tmpStr = tmpStr.replaceAll( "기", "Gi");    
		tmpStr = tmpStr.replaceAll( "긴", "Gin");   
		tmpStr = tmpStr.replaceAll( "길", "Gil");   
		tmpStr = tmpStr.replaceAll( "김", "Gim");   
		tmpStr = tmpStr.replaceAll( "까", "Kka");   
		tmpStr = tmpStr.replaceAll( "깨", "Kkae");  
		tmpStr = tmpStr.replaceAll( "꼬", "Kko");   
		tmpStr = tmpStr.replaceAll( "꼭", "Kkok");  
		tmpStr = tmpStr.replaceAll( "꽃", "Kkot");  
		tmpStr = tmpStr.replaceAll( "꾀", "Kkoe");  
		tmpStr = tmpStr.replaceAll( "꾸", "Kku");   
		tmpStr = tmpStr.replaceAll( "꿈", "Kkum");  
		tmpStr = tmpStr.replaceAll( "끝", "Kkeut"); 
		tmpStr = tmpStr.replaceAll( "끼", "Kki");   
		tmpStr = tmpStr.replaceAll( "나", "Na");    
		tmpStr = tmpStr.replaceAll( "낙", "Nak");   
		tmpStr = tmpStr.replaceAll( "난", "Nan");   
		tmpStr = tmpStr.replaceAll( "날", "Nal");   
		tmpStr = tmpStr.replaceAll( "남", "Nam");   
		tmpStr = tmpStr.replaceAll( "납", "Nap");   
		tmpStr = tmpStr.replaceAll( "낭", "Nang");  
		tmpStr = tmpStr.replaceAll( "내", "Nae");   
		tmpStr = tmpStr.replaceAll( "냉", "Naeng"); 
		tmpStr = tmpStr.replaceAll( "너", "Neo");   
		tmpStr = tmpStr.replaceAll( "널", "Neol");  
		tmpStr = tmpStr.replaceAll( "네", "Ne");    
		tmpStr = tmpStr.replaceAll( "녀", "Nyeo");  
		tmpStr = tmpStr.replaceAll( "녁", "Nyeok"); 
		tmpStr = tmpStr.replaceAll( "년", "Nyeon"); 
		tmpStr = tmpStr.replaceAll( "념", "Nyeom"); 
		tmpStr = tmpStr.replaceAll( "녕", "Nyeong");
		tmpStr = tmpStr.replaceAll( "노", "No");    
		tmpStr = tmpStr.replaceAll( "녹", "Nok");   
		tmpStr = tmpStr.replaceAll( "논", "Non");   
		tmpStr = tmpStr.replaceAll( "놀", "Nol");   
		tmpStr = tmpStr.replaceAll( "농", "Nong");  
		tmpStr = tmpStr.replaceAll( "뇌", "Noe");   
		tmpStr = tmpStr.replaceAll( "누", "Nu");    
		tmpStr = tmpStr.replaceAll( "눈", "Nun");   
		tmpStr = tmpStr.replaceAll( "눌", "Nul");   
		tmpStr = tmpStr.replaceAll( "느", "Neu");   
		tmpStr = tmpStr.replaceAll( "늑", "Neuk");  
		tmpStr = tmpStr.replaceAll( "늠", "Neum");  
		tmpStr = tmpStr.replaceAll( "능", "Neung"); 
		tmpStr = tmpStr.replaceAll( "늬", "Nui");   
		tmpStr = tmpStr.replaceAll( "니", "Ni");    
		tmpStr = tmpStr.replaceAll( "닉", "Nik");   
		tmpStr = tmpStr.replaceAll( "닌", "Nin");   
		tmpStr = tmpStr.replaceAll( "닐", "Nil");   
		tmpStr = tmpStr.replaceAll( "님", "Nim");   
		tmpStr = tmpStr.replaceAll( "다", "Da");    
		tmpStr = tmpStr.replaceAll( "단", "Dan");   
		tmpStr = tmpStr.replaceAll( "달", "Dal");   
		tmpStr = tmpStr.replaceAll( "담", "Dam");   
		tmpStr = tmpStr.replaceAll( "답", "Dap");   
		tmpStr = tmpStr.replaceAll( "당", "Dang");  
		tmpStr = tmpStr.replaceAll( "대", "Dae");   
		tmpStr = tmpStr.replaceAll( "댁", "Daek");  
		tmpStr = tmpStr.replaceAll( "더", "Deo");   
		tmpStr = tmpStr.replaceAll( "덕", "Deok");  
		tmpStr = tmpStr.replaceAll( "도", "Do");    
		tmpStr = tmpStr.replaceAll( "독", "Dok");   
		tmpStr = tmpStr.replaceAll( "돈", "Don");   
		tmpStr = tmpStr.replaceAll( "돌", "Dol");   
		tmpStr = tmpStr.replaceAll( "동", "Dong");  
		tmpStr = tmpStr.replaceAll( "돼", "Dwae");  
		tmpStr = tmpStr.replaceAll( "되", "Doe");   
		tmpStr = tmpStr.replaceAll( "된", "Doen");  
		tmpStr = tmpStr.replaceAll( "두", "Du");    
		tmpStr = tmpStr.replaceAll( "둑", "Duk");   
		tmpStr = tmpStr.replaceAll( "둔", "Dun");   
		tmpStr = tmpStr.replaceAll( "뒤", "Dwi");   
		tmpStr = tmpStr.replaceAll( "드", "Deu");   
		tmpStr = tmpStr.replaceAll( "득", "Deuk");  
		tmpStr = tmpStr.replaceAll( "들", "Deul");  
		tmpStr = tmpStr.replaceAll( "등", "Deung"); 
		tmpStr = tmpStr.replaceAll( "디", "Di");    
		tmpStr = tmpStr.replaceAll( "따", "Tta");   
		tmpStr = tmpStr.replaceAll( "땅", "Ttang"); 
		tmpStr = tmpStr.replaceAll( "때", "Ttae");  
		tmpStr = tmpStr.replaceAll( "또", "Tto");   
		tmpStr = tmpStr.replaceAll( "뚜", "Ttu");   
		tmpStr = tmpStr.replaceAll( "뚝", "Ttuk");  
		tmpStr = tmpStr.replaceAll( "뜨", "Tteu");  
		tmpStr = tmpStr.replaceAll( "띠", "Tti");   
		tmpStr = tmpStr.replaceAll( "라", "Ra");    
		tmpStr = tmpStr.replaceAll( "락", "Rak");   
		tmpStr = tmpStr.replaceAll( "란", "Ran");   
		tmpStr = tmpStr.replaceAll( "람", "Ram");   
		tmpStr = tmpStr.replaceAll( "랑", "Rang");  
		tmpStr = tmpStr.replaceAll( "래", "Rae");   
		tmpStr = tmpStr.replaceAll( "랭", "Raeng"); 
		tmpStr = tmpStr.replaceAll( "량", "Ryang"); 
		tmpStr = tmpStr.replaceAll( "렁", "Reong"); 
		tmpStr = tmpStr.replaceAll( "레", "Re");    
		tmpStr = tmpStr.replaceAll( "려", "Ryeo");  
		tmpStr = tmpStr.replaceAll( "력", "Ryeok"); 
		tmpStr = tmpStr.replaceAll( "련", "Ryeon"); 
		tmpStr = tmpStr.replaceAll( "렬", "Ryeol"); 
		tmpStr = tmpStr.replaceAll( "렴", "Ryeom"); 
		tmpStr = tmpStr.replaceAll( "렵", "Ryeop"); 
		tmpStr = tmpStr.replaceAll( "령", "Ryeong");
		tmpStr = tmpStr.replaceAll( "례", "Rye");   
		tmpStr = tmpStr.replaceAll( "로", "Ro");    
		tmpStr = tmpStr.replaceAll( "록", "Rok");   
		tmpStr = tmpStr.replaceAll( "론", "Ron");   
		tmpStr = tmpStr.replaceAll( "롱", "Rong");  
		tmpStr = tmpStr.replaceAll( "뢰", "Roe");   
		tmpStr = tmpStr.replaceAll( "료", "Ryo");   
		tmpStr = tmpStr.replaceAll( "룡", "Ryong"); 
		tmpStr = tmpStr.replaceAll( "루", "Ru");    
		tmpStr = tmpStr.replaceAll( "류", "Ryu");   
		tmpStr = tmpStr.replaceAll( "륙", "Ryuk");  
		tmpStr = tmpStr.replaceAll( "륜", "Ryun");  
		tmpStr = tmpStr.replaceAll( "률", "Ryul");  
		tmpStr = tmpStr.replaceAll( "륭", "Ryung"); 
		tmpStr = tmpStr.replaceAll( "르", "Reu");   
		tmpStr = tmpStr.replaceAll( "륵", "Reuk");  
		tmpStr = tmpStr.replaceAll( "른", "Reun");  
		tmpStr = tmpStr.replaceAll( "름", "Reum");  
		tmpStr = tmpStr.replaceAll( "릉", "Reung"); 
		tmpStr = tmpStr.replaceAll( "리", "Ri");    
		tmpStr = tmpStr.replaceAll( "린", "Rin");   
		tmpStr = tmpStr.replaceAll( "림", "Rim");   
		tmpStr = tmpStr.replaceAll( "립", "Rip");   
		tmpStr = tmpStr.replaceAll( "마", "Ma");    
		tmpStr = tmpStr.replaceAll( "막", "Mak");   
		tmpStr = tmpStr.replaceAll( "만", "Man");   
		tmpStr = tmpStr.replaceAll( "말", "Mal");   
		tmpStr = tmpStr.replaceAll( "망", "Mang");  
		tmpStr = tmpStr.replaceAll( "매", "Mae");   
		tmpStr = tmpStr.replaceAll( "맥", "Maek");  
		tmpStr = tmpStr.replaceAll( "맨", "Maen");  
		tmpStr = tmpStr.replaceAll( "맹", "Maeng"); 
		tmpStr = tmpStr.replaceAll( "머", "Meo");   
		tmpStr = tmpStr.replaceAll( "먹", "Meok");  
		tmpStr = tmpStr.replaceAll( "메", "Me");    
		tmpStr = tmpStr.replaceAll( "며", "Myeo");  
		tmpStr = tmpStr.replaceAll( "멱", "Myeok"); 
		tmpStr = tmpStr.replaceAll( "면", "Myeon"); 
		tmpStr = tmpStr.replaceAll( "멸", "Myeol"); 
		tmpStr = tmpStr.replaceAll( "명", "Myeong");
		tmpStr = tmpStr.replaceAll( "모", "Mo");    
		tmpStr = tmpStr.replaceAll( "목", "Mok");   
		tmpStr = tmpStr.replaceAll( "몰", "Mol");   
		tmpStr = tmpStr.replaceAll( "못", "Mot");   
		tmpStr = tmpStr.replaceAll( "몽", "Mong");  
		tmpStr = tmpStr.replaceAll( "뫼", "Moe");   
		tmpStr = tmpStr.replaceAll( "묘", "Myo");   
		tmpStr = tmpStr.replaceAll( "무", "Mu");    
		tmpStr = tmpStr.replaceAll( "묵", "Muk");   
		tmpStr = tmpStr.replaceAll( "문", "Mun");   
		tmpStr = tmpStr.replaceAll( "물", "Mul");   
		tmpStr = tmpStr.replaceAll( "므", "Meu");   
		tmpStr = tmpStr.replaceAll( "미", "Mi");    
		tmpStr = tmpStr.replaceAll( "민", "Min");   
		tmpStr = tmpStr.replaceAll( "밀", "Mil");   
		tmpStr = tmpStr.replaceAll( "바", "Ba");    
		tmpStr = tmpStr.replaceAll( "박", "Bak");   
		tmpStr = tmpStr.replaceAll( "반", "Ban");   
		tmpStr = tmpStr.replaceAll( "발", "Bal");   
		tmpStr = tmpStr.replaceAll( "밥", "Bap");   
		tmpStr = tmpStr.replaceAll( "방", "Bang");  
		tmpStr = tmpStr.replaceAll( "배", "Bae");   
		tmpStr = tmpStr.replaceAll( "백", "Baek");  
		tmpStr = tmpStr.replaceAll( "뱀", "Baem");  
		tmpStr = tmpStr.replaceAll( "버", "Beo");   
		tmpStr = tmpStr.replaceAll( "번", "Beon");  
		tmpStr = tmpStr.replaceAll( "벌", "Beol");  
		tmpStr = tmpStr.replaceAll( "범", "Beom");  
		tmpStr = tmpStr.replaceAll( "법", "Beop");  
		tmpStr = tmpStr.replaceAll( "벼", "Byeo");  
		tmpStr = tmpStr.replaceAll( "벽", "Byeok"); 
		tmpStr = tmpStr.replaceAll( "변", "Byeon"); 
		tmpStr = tmpStr.replaceAll( "별", "Byeol"); 
		tmpStr = tmpStr.replaceAll( "병", "Byeong");
		tmpStr = tmpStr.replaceAll( "보", "Bo");    
		tmpStr = tmpStr.replaceAll( "복", "Bok");   
		tmpStr = tmpStr.replaceAll( "본", "Bon");   
		tmpStr = tmpStr.replaceAll( "봉", "Bong");  
		tmpStr = tmpStr.replaceAll( "부", "Bu");    
		tmpStr = tmpStr.replaceAll( "북", "Buk");   
		tmpStr = tmpStr.replaceAll( "분", "Bun");   
		tmpStr = tmpStr.replaceAll( "불", "Bul");   
		tmpStr = tmpStr.replaceAll( "붕", "Bung");  
		tmpStr = tmpStr.replaceAll( "비", "Bi");    
		tmpStr = tmpStr.replaceAll( "빈", "Bin");   
		tmpStr = tmpStr.replaceAll( "빌", "Bil");   
		tmpStr = tmpStr.replaceAll( "빔", "Bim");   
		tmpStr = tmpStr.replaceAll( "빙", "Bing");  
		tmpStr = tmpStr.replaceAll( "빠", "Ppa");   
		tmpStr = tmpStr.replaceAll( "빼", "Ppae");  
		tmpStr = tmpStr.replaceAll( "뻐", "Ppeo");  
		tmpStr = tmpStr.replaceAll( "뽀", "Ppo");   
		tmpStr = tmpStr.replaceAll( "뿌", "Ppu");   
		tmpStr = tmpStr.replaceAll( "쁘", "Ppeu");  
		tmpStr = tmpStr.replaceAll( "삐", "Ppi");   
		tmpStr = tmpStr.replaceAll( "사", "Sa");    
		tmpStr = tmpStr.replaceAll( "삭", "Sak");   
		tmpStr = tmpStr.replaceAll( "산", "San");   
		tmpStr = tmpStr.replaceAll( "살", "Sal");   
		tmpStr = tmpStr.replaceAll( "삼", "Sam");   
		tmpStr = tmpStr.replaceAll( "삽", "Sap");   
		tmpStr = tmpStr.replaceAll( "상", "Sang");  
		tmpStr = tmpStr.replaceAll( "샅", "Sat");   
		tmpStr = tmpStr.replaceAll( "새", "Sae");   
		tmpStr = tmpStr.replaceAll( "색", "Saek");  
		tmpStr = tmpStr.replaceAll( "생", "Saeng"); 
		tmpStr = tmpStr.replaceAll( "서", "Seo");   
		tmpStr = tmpStr.replaceAll( "석", "Seok");  
		tmpStr = tmpStr.replaceAll( "선", "Seon");  
		tmpStr = tmpStr.replaceAll( "설", "Seol");  
		tmpStr = tmpStr.replaceAll( "섬", "Seom");  
		tmpStr = tmpStr.replaceAll( "섭", "Seop");  
		tmpStr = tmpStr.replaceAll( "성", "Seong"); 
		tmpStr = tmpStr.replaceAll( "세", "Se");    
		tmpStr = tmpStr.replaceAll( "셔", "Syeo");  
		tmpStr = tmpStr.replaceAll( "소", "So");    
		tmpStr = tmpStr.replaceAll( "속", "Sok");   
		tmpStr = tmpStr.replaceAll( "손", "Son");   
		tmpStr = tmpStr.replaceAll( "솔", "Sol");   
		tmpStr = tmpStr.replaceAll( "솟", "Sot");   
		tmpStr = tmpStr.replaceAll( "송", "Song");  
		tmpStr = tmpStr.replaceAll( "쇄", "Swae");  
		tmpStr = tmpStr.replaceAll( "쇠", "Soe");   
		tmpStr = tmpStr.replaceAll( "수", "Su");    
		tmpStr = tmpStr.replaceAll( "숙", "Suk");   
		tmpStr = tmpStr.replaceAll( "순", "Sun");   
		tmpStr = tmpStr.replaceAll( "술", "Sul");   
		tmpStr = tmpStr.replaceAll( "숨", "Sum");   
		tmpStr = tmpStr.replaceAll( "숭", "Sung");  
		tmpStr = tmpStr.replaceAll( "쉬", "Swi");   
		tmpStr = tmpStr.replaceAll( "스", "Seu");   
		tmpStr = tmpStr.replaceAll( "슬", "Seul");  
		tmpStr = tmpStr.replaceAll( "슴", "Seum");  
		tmpStr = tmpStr.replaceAll( "습", "Seup");  
		tmpStr = tmpStr.replaceAll( "승", "Seung"); 
		tmpStr = tmpStr.replaceAll( "시", "Si");    
		tmpStr = tmpStr.replaceAll( "식", "Sik");   
		tmpStr = tmpStr.replaceAll( "신", "Sin");   
		tmpStr = tmpStr.replaceAll( "실", "Sil");   
		tmpStr = tmpStr.replaceAll( "심", "Sim");   
		tmpStr = tmpStr.replaceAll( "십", "Sip");   
		tmpStr = tmpStr.replaceAll( "싱", "Sing");  
		tmpStr = tmpStr.replaceAll( "싸", "Ssa");   
		tmpStr = tmpStr.replaceAll( "쌍", "Ssang"); 
		tmpStr = tmpStr.replaceAll( "쌔", "Ssae");  
		tmpStr = tmpStr.replaceAll( "쏘", "Sso");   
		tmpStr = tmpStr.replaceAll( "쑥", "Ssuk");  
		tmpStr = tmpStr.replaceAll( "씨", "Ssi");   
		tmpStr = tmpStr.replaceAll( "아", "A");     
		tmpStr = tmpStr.replaceAll( "악", "Ak");    
		tmpStr = tmpStr.replaceAll( "안", "An");    
		tmpStr = tmpStr.replaceAll( "알", "Al");    
		tmpStr = tmpStr.replaceAll( "암", "Am");    
		tmpStr = tmpStr.replaceAll( "압", "Ap");    
		tmpStr = tmpStr.replaceAll( "앙", "Ang");   
		tmpStr = tmpStr.replaceAll( "앞", "Ap");    
		tmpStr = tmpStr.replaceAll( "애", "Ae");    
		tmpStr = tmpStr.replaceAll( "액", "Aek");   
		tmpStr = tmpStr.replaceAll( "앵", "Aeng");  
		tmpStr = tmpStr.replaceAll( "야", "Ya");    
		tmpStr = tmpStr.replaceAll( "약", "Yak");   
		tmpStr = tmpStr.replaceAll( "얀", "Yan");   
		tmpStr = tmpStr.replaceAll( "양", "Yang");  
		tmpStr = tmpStr.replaceAll( "어", "Eo");    
		tmpStr = tmpStr.replaceAll( "억", "Eok");   
		tmpStr = tmpStr.replaceAll( "언", "Eon");   
		tmpStr = tmpStr.replaceAll( "얼", "Eol");   
		tmpStr = tmpStr.replaceAll( "엄", "Eom");   
		tmpStr = tmpStr.replaceAll( "업", "Eop");   
		tmpStr = tmpStr.replaceAll( "에", "E");     
		tmpStr = tmpStr.replaceAll( "여", "Yeo");   
		tmpStr = tmpStr.replaceAll( "역", "Yeok");  
		tmpStr = tmpStr.replaceAll( "연", "Yeon");  
		tmpStr = tmpStr.replaceAll( "열", "Yeol");  
		tmpStr = tmpStr.replaceAll( "염", "Yeom");  
		tmpStr = tmpStr.replaceAll( "엽", "Yeop");  
		tmpStr = tmpStr.replaceAll( "영", "Yeong"); 
		tmpStr = tmpStr.replaceAll( "예", "Ye");    
		tmpStr = tmpStr.replaceAll( "오", "O");     
		tmpStr = tmpStr.replaceAll( "옥", "Ok");    
		tmpStr = tmpStr.replaceAll( "온", "On");    
		tmpStr = tmpStr.replaceAll( "올", "Ol");    
		tmpStr = tmpStr.replaceAll( "옴", "Om");    
		tmpStr = tmpStr.replaceAll( "옹", "Ong");   
		tmpStr = tmpStr.replaceAll( "와", "Wa");    
		tmpStr = tmpStr.replaceAll( "완", "Wan");   
		tmpStr = tmpStr.replaceAll( "왈", "Wal");   
		tmpStr = tmpStr.replaceAll( "왕", "Wang");  
		tmpStr = tmpStr.replaceAll( "왜", "Wae");   
		tmpStr = tmpStr.replaceAll( "외", "Oe");    
		tmpStr = tmpStr.replaceAll( "왼", "Oen");   
		tmpStr = tmpStr.replaceAll( "요", "Yo");    
		tmpStr = tmpStr.replaceAll( "욕", "Yok");   
		tmpStr = tmpStr.replaceAll( "용", "Yong");  
		tmpStr = tmpStr.replaceAll( "우", "U");     
		tmpStr = tmpStr.replaceAll( "욱", "Uk");    
		tmpStr = tmpStr.replaceAll( "운", "Un");    
		tmpStr = tmpStr.replaceAll( "울", "Ul");    
		tmpStr = tmpStr.replaceAll( "움", "Um");    
		tmpStr = tmpStr.replaceAll( "웅", "Ung");   
		tmpStr = tmpStr.replaceAll( "워", "Wo");    
		tmpStr = tmpStr.replaceAll( "원", "Won");   
		tmpStr = tmpStr.replaceAll( "월", "Wol");   
		tmpStr = tmpStr.replaceAll( "위", "Wi");    
		tmpStr = tmpStr.replaceAll( "유", "Yu");    
		tmpStr = tmpStr.replaceAll( "육", "Yuk");   
		tmpStr = tmpStr.replaceAll( "윤", "Yun");   
		tmpStr = tmpStr.replaceAll( "율", "Yul");   
		tmpStr = tmpStr.replaceAll( "융", "Yung");  
		tmpStr = tmpStr.replaceAll( "윷", "Yut");   
		tmpStr = tmpStr.replaceAll( "으", "Eu");    
		tmpStr = tmpStr.replaceAll( "은", "Eun");   
		tmpStr = tmpStr.replaceAll( "을", "Eul");   
		tmpStr = tmpStr.replaceAll( "음", "Eum");   
		tmpStr = tmpStr.replaceAll( "읍", "Eup");   
		tmpStr = tmpStr.replaceAll( "응", "Eung");  
		tmpStr = tmpStr.replaceAll( "의", "Ui");    
		tmpStr = tmpStr.replaceAll( "이", "I");     
		tmpStr = tmpStr.replaceAll( "익", "Ik");    
		tmpStr = tmpStr.replaceAll( "인", "In");    
		tmpStr = tmpStr.replaceAll( "일", "Il");    
		tmpStr = tmpStr.replaceAll( "임", "Im");    
		tmpStr = tmpStr.replaceAll( "입", "Ip");    
		tmpStr = tmpStr.replaceAll( "잉", "Ing");   
		tmpStr = tmpStr.replaceAll( "자", "Ja");    
		tmpStr = tmpStr.replaceAll( "작", "Jak");   
		tmpStr = tmpStr.replaceAll( "잔", "Jan");   
		tmpStr = tmpStr.replaceAll( "잠", "Jam");   
		tmpStr = tmpStr.replaceAll( "잡", "Jap");   
		tmpStr = tmpStr.replaceAll( "장", "Jang");  
		tmpStr = tmpStr.replaceAll( "재", "Jae");   
		tmpStr = tmpStr.replaceAll( "쟁", "Jaeng"); 
		tmpStr = tmpStr.replaceAll( "저", "Jeo");   
		tmpStr = tmpStr.replaceAll( "적", "Jeok");  
		tmpStr = tmpStr.replaceAll( "전", "Jeon");  
		tmpStr = tmpStr.replaceAll( "절", "Jeol");  
		tmpStr = tmpStr.replaceAll( "점", "Jeom");  
		tmpStr = tmpStr.replaceAll( "접", "Jeop");  
		tmpStr = tmpStr.replaceAll( "정", "Jeong"); 
		tmpStr = tmpStr.replaceAll( "제", "Je");    
		tmpStr = tmpStr.replaceAll( "조", "Jo");    
		tmpStr = tmpStr.replaceAll( "족", "Jok");   
		tmpStr = tmpStr.replaceAll( "존", "Jon");   
		tmpStr = tmpStr.replaceAll( "졸", "Jol");   
		tmpStr = tmpStr.replaceAll( "종", "Jong");  
		tmpStr = tmpStr.replaceAll( "좌", "Jwa");   
		tmpStr = tmpStr.replaceAll( "죄", "Joe");   
		tmpStr = tmpStr.replaceAll( "주", "Ju");    
		tmpStr = tmpStr.replaceAll( "죽", "Juk");   
		tmpStr = tmpStr.replaceAll( "준", "Jun");   
		tmpStr = tmpStr.replaceAll( "줄", "Jul");   
		tmpStr = tmpStr.replaceAll( "중", "Jung");  
		tmpStr = tmpStr.replaceAll( "쥐", "Jwi");   
		tmpStr = tmpStr.replaceAll( "즈", "Jeu");   
		tmpStr = tmpStr.replaceAll( "즉", "Jeuk");  
		tmpStr = tmpStr.replaceAll( "즐", "Jeul");  
		tmpStr = tmpStr.replaceAll( "즘", "Jeum");  
		tmpStr = tmpStr.replaceAll( "즙", "Jeup");  
		tmpStr = tmpStr.replaceAll( "증", "Jeung"); 
		tmpStr = tmpStr.replaceAll( "지", "Ji");    
		tmpStr = tmpStr.replaceAll( "직", "Jik");   
		tmpStr = tmpStr.replaceAll( "진", "Jin");   
		tmpStr = tmpStr.replaceAll( "질", "Jil");   
		tmpStr = tmpStr.replaceAll( "짐", "Jim");   
		tmpStr = tmpStr.replaceAll( "집", "Jip");   
		tmpStr = tmpStr.replaceAll( "징", "Jing");  
		tmpStr = tmpStr.replaceAll( "짜", "Jja");   
		tmpStr = tmpStr.replaceAll( "째", "Jjae");  
		tmpStr = tmpStr.replaceAll( "쪼", "Jjo");   
		tmpStr = tmpStr.replaceAll( "찌", "Jji");   
		tmpStr = tmpStr.replaceAll( "차", "Cha");   
		tmpStr = tmpStr.replaceAll( "착", "Chak");  
		tmpStr = tmpStr.replaceAll( "찬", "Chan");  
		tmpStr = tmpStr.replaceAll( "찰", "Chal");  
		tmpStr = tmpStr.replaceAll( "참", "Cham");  
		tmpStr = tmpStr.replaceAll( "창", "Chang"); 
		tmpStr = tmpStr.replaceAll( "채", "Chae");  
		tmpStr = tmpStr.replaceAll( "책", "Chaek"); 
		tmpStr = tmpStr.replaceAll( "처", "Cheo");  
		tmpStr = tmpStr.replaceAll( "척", "Cheok"); 
		tmpStr = tmpStr.replaceAll( "천", "Cheon"); 
		tmpStr = tmpStr.replaceAll( "철", "Cheol"); 
		tmpStr = tmpStr.replaceAll( "첨", "Cheom"); 
		tmpStr = tmpStr.replaceAll( "첩", "Cheop"); 
		tmpStr = tmpStr.replaceAll( "청", "Cheong");
		tmpStr = tmpStr.replaceAll( "체", "Che");   
		tmpStr = tmpStr.replaceAll( "초", "Cho");   
		tmpStr = tmpStr.replaceAll( "촉", "Chok");  
		tmpStr = tmpStr.replaceAll( "촌", "Chon");  
		tmpStr = tmpStr.replaceAll( "총", "Chong"); 
		tmpStr = tmpStr.replaceAll( "최", "Choe");  
		tmpStr = tmpStr.replaceAll( "추", "Chu");
		tmpStr = tmpStr.replaceAll( "취", "Chwi");
		tmpStr = tmpStr.replaceAll( "축", "Chuk");  
		tmpStr = tmpStr.replaceAll( "춘", "Chun");  
		tmpStr = tmpStr.replaceAll( "출", "Chul");  
		tmpStr = tmpStr.replaceAll( "춤", "Chum");  
		tmpStr = tmpStr.replaceAll( "충", "Chung"); 
		tmpStr = tmpStr.replaceAll( "측", "Cheuk"); 
		tmpStr = tmpStr.replaceAll( "층", "Cheung");
		tmpStr = tmpStr.replaceAll( "치", "Chi");   
		tmpStr = tmpStr.replaceAll( "칙", "Chik");  
		tmpStr = tmpStr.replaceAll( "친", "Chin");  
		tmpStr = tmpStr.replaceAll( "칠", "Chil");  
		tmpStr = tmpStr.replaceAll( "침", "Chim");  
		tmpStr = tmpStr.replaceAll( "칩", "Chip");  
		tmpStr = tmpStr.replaceAll( "칭", "Ching"); 
		tmpStr = tmpStr.replaceAll( "카", "Ka");   
		tmpStr = tmpStr.replaceAll( "코", "Ko");    
		tmpStr = tmpStr.replaceAll( "쾌", "Kwae");  
		tmpStr = tmpStr.replaceAll( "크", "Keu");   
		tmpStr = tmpStr.replaceAll( "큰", "Keun");  
		tmpStr = tmpStr.replaceAll( "키", "Ki");    
		tmpStr = tmpStr.replaceAll( "타", "Ta");    
		tmpStr = tmpStr.replaceAll( "탁", "Tak");   
		tmpStr = tmpStr.replaceAll( "탄", "Tan");   
		tmpStr = tmpStr.replaceAll( "탈", "Tal");   
		tmpStr = tmpStr.replaceAll( "탐", "Tam");   
		tmpStr = tmpStr.replaceAll( "탑", "Tap");   
		tmpStr = tmpStr.replaceAll( "탕", "Tang");  
		tmpStr = tmpStr.replaceAll( "태", "Tae");   
		tmpStr = tmpStr.replaceAll( "택", "Taek");  
		tmpStr = tmpStr.replaceAll( "탬", "Taem");
		tmpStr = tmpStr.replaceAll( "탱", "Taeng"); 
		tmpStr = tmpStr.replaceAll( "터", "Teo");   
		tmpStr = tmpStr.replaceAll( "테", "Te");   
		tmpStr = tmpStr.replaceAll( "템", "Tem");
		tmpStr = tmpStr.replaceAll( "토", "To");    
		tmpStr = tmpStr.replaceAll( "톤", "Ton");   
		tmpStr = tmpStr.replaceAll( "톨", "Tol");   
		tmpStr = tmpStr.replaceAll( "통", "Tong");  
		tmpStr = tmpStr.replaceAll( "퇴", "Toe");   
		tmpStr = tmpStr.replaceAll( "투", "Tu");    
		tmpStr = tmpStr.replaceAll( "퉁", "Tung");  
		tmpStr = tmpStr.replaceAll( "튀", "Twi");   
		tmpStr = tmpStr.replaceAll( "트", "Teu");   
		tmpStr = tmpStr.replaceAll( "특", "Teuk");  
		tmpStr = tmpStr.replaceAll( "틈", "Teum");  
		tmpStr = tmpStr.replaceAll( "티", "Ti");    
		tmpStr = tmpStr.replaceAll( "파", "Pa");    
		tmpStr = tmpStr.replaceAll( "판", "Pan");   
		tmpStr = tmpStr.replaceAll( "팔", "Pal");   
		tmpStr = tmpStr.replaceAll( "패", "Pae");   
		tmpStr = tmpStr.replaceAll( "팽", "Paeng"); 
		tmpStr = tmpStr.replaceAll( "퍼", "Peo");   
		tmpStr = tmpStr.replaceAll( "페", "Pe");    
		tmpStr = tmpStr.replaceAll( "펴", "Pyeo");  
		tmpStr = tmpStr.replaceAll( "편", "Pyeon"); 
		tmpStr = tmpStr.replaceAll( "폄", "Pyeom"); 
		tmpStr = tmpStr.replaceAll( "평", "Pyeong");
		tmpStr = tmpStr.replaceAll( "폐", "Pye");   
		tmpStr = tmpStr.replaceAll( "포", "Po");    
		tmpStr = tmpStr.replaceAll( "폭", "Pok");   
		tmpStr = tmpStr.replaceAll( "표", "Pyo");   
		tmpStr = tmpStr.replaceAll( "푸", "Pu");    
		tmpStr = tmpStr.replaceAll( "품", "Pum");   
		tmpStr = tmpStr.replaceAll( "풍", "Pung");  
		tmpStr = tmpStr.replaceAll( "프", "Peu");   
		tmpStr = tmpStr.replaceAll( "피", "Pi");    
		tmpStr = tmpStr.replaceAll( "픽", "Pik");   
		tmpStr = tmpStr.replaceAll( "필", "Pil");   
		tmpStr = tmpStr.replaceAll( "핍", "Pip");   
		tmpStr = tmpStr.replaceAll( "하", "Ha");    
		tmpStr = tmpStr.replaceAll( "학", "Hak");   
		tmpStr = tmpStr.replaceAll( "한", "Han");   
		tmpStr = tmpStr.replaceAll( "할", "Hal");   
		tmpStr = tmpStr.replaceAll( "함", "Ham");   
		tmpStr = tmpStr.replaceAll( "합", "Hap");   
		tmpStr = tmpStr.replaceAll( "항", "Hang");  
		tmpStr = tmpStr.replaceAll( "해", "Hae");   
		tmpStr = tmpStr.replaceAll( "핵", "Haek");  
		tmpStr = tmpStr.replaceAll( "행", "Haeng"); 
		tmpStr = tmpStr.replaceAll( "향", "Hyang"); 
		tmpStr = tmpStr.replaceAll( "허", "Heo");   
		tmpStr = tmpStr.replaceAll( "헌", "Heon");  
		tmpStr = tmpStr.replaceAll( "험", "Heom");  
		tmpStr = tmpStr.replaceAll( "헤", "He");    
		tmpStr = tmpStr.replaceAll( "혀", "Hyeo");  
		tmpStr = tmpStr.replaceAll( "혁", "Hyeok"); 
		tmpStr = tmpStr.replaceAll( "현", "Hyeon"); 
		tmpStr = tmpStr.replaceAll( "혈", "Hyeol"); 
		tmpStr = tmpStr.replaceAll( "혐", "Hyeom"); 
		tmpStr = tmpStr.replaceAll( "협", "Hyeop"); 
		tmpStr = tmpStr.replaceAll( "형", "Hyeong");
		tmpStr = tmpStr.replaceAll( "혜", "Hye");   
		tmpStr = tmpStr.replaceAll( "호", "Ho");    
		tmpStr = tmpStr.replaceAll( "혹", "Hok");   
		tmpStr = tmpStr.replaceAll( "혼", "Hon");   
		tmpStr = tmpStr.replaceAll( "홀", "Hol");   
		tmpStr = tmpStr.replaceAll( "홉", "Hop");   
		tmpStr = tmpStr.replaceAll( "홍", "Hong");  
		tmpStr = tmpStr.replaceAll( "화", "Hwa");   
		tmpStr = tmpStr.replaceAll( "확", "Hwak");  
		tmpStr = tmpStr.replaceAll( "환", "Hwan");  
		tmpStr = tmpStr.replaceAll( "활", "Hwal");  
		tmpStr = tmpStr.replaceAll( "황", "Hwang"); 
		tmpStr = tmpStr.replaceAll( "홰", "Hwae");  
		tmpStr = tmpStr.replaceAll( "횃", "Hwaet"); 
		tmpStr = tmpStr.replaceAll( "회", "Hoe");   
		tmpStr = tmpStr.replaceAll( "획", "Hoek");  
		tmpStr = tmpStr.replaceAll( "횡", "Hoeng"); 
		tmpStr = tmpStr.replaceAll( "효", "Hyo");   
		tmpStr = tmpStr.replaceAll( "후", "Hu");    
		tmpStr = tmpStr.replaceAll( "훈", "Hun");   
		tmpStr = tmpStr.replaceAll( "훤", "Hwon");  
		tmpStr = tmpStr.replaceAll( "훼", "Hwe");   
		tmpStr = tmpStr.replaceAll( "휘", "Hwi");   
		tmpStr = tmpStr.replaceAll( "휴", "Hyu");   
		tmpStr = tmpStr.replaceAll( "휼", "Hyul");  
		tmpStr = tmpStr.replaceAll( "흉", "Hyung"); 
		tmpStr = tmpStr.replaceAll( "흐", "Heu");   
		tmpStr = tmpStr.replaceAll( "흑", "Heuk");  
		tmpStr = tmpStr.replaceAll( "흔", "Heun");  
		tmpStr = tmpStr.replaceAll( "흘", "Heul");  
		tmpStr = tmpStr.replaceAll( "흠", "Heum");  
		tmpStr = tmpStr.replaceAll( "흡", "Heup");  
		tmpStr = tmpStr.replaceAll( "흥", "Heung"); 
		tmpStr = tmpStr.replaceAll( "희", "Hui");   
		tmpStr = tmpStr.replaceAll( "흰", "Huin");  
		tmpStr = tmpStr.replaceAll( "히", "Hi");    
		tmpStr = tmpStr.replaceAll( "힘", "Him");   
		tmpStr = tmpStr.replaceAll( "  ", " ");
		tmpStr = tmpStr.replaceAll( " ", "_");


		return tmpStr;	
	}		

	/**
	 * 아이디 생성
	 * 
	 * @return 아이디
	 */
	public final static String genID() {
		return new ObjectId().toString();
	}

	public final static String getBinaryString(String str) {
		String rtnValue = "";

		char[] stringArray = str.toCharArray();
		for (int i = 0; i < stringArray.length; i++) {
			rtnValue += Integer.toBinaryString(stringArray[i]);
		}

		return rtnValue;
	}


	

	
	/**
	  * @name : isNotEmpty
	  * @date : 2017. 1. 11.
	  * @author : knlee
	  * @변경이력 :
	  * @description : 문자열 값이 비어있지 않는지 체크(null , 공백)
	  * @param str 비교할 문자열
	  * @return true: 데이타 존재. false: null 또는 공백
	  */
	public  final static boolean isNotEmpty(String str) {
		if(str == null) return false;
		if("".equals(str.trim())) return false;
		return true;
	}
		


	/**
	  * @name : isEmpty
	  * @date : 2017. 1. 11.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 문자열 값이 비어 있는지 체크(null , 공백)
	  * @param str
	  * @return true: null 또는 공백. false: 데이터 존재
	  */
	public  final static boolean isEmpty(String str) {
		if(str == null) return true;
		if("".equals(str.trim())) return true;
		return false;
	}
	
	/**
	 * 파라미터 값 모두가 비어 있으면 true
	 * @param strings
	 * @return
	 */
	public  final static boolean isEmptyAll(String ... strings ){
		boolean result = false;
		for (int i = 0; i < strings.length; i++) {
		     if(isEmpty(strings[i])) result = true;
		     else result = false;
		}
		
		return result;
	}

	
	/**
	 * 파라미터 값 모두가 값이 존재하면 true
	 * @param strings
	 * @return
	 */
	public  final static boolean isNotEmptyAll(String ... strings ){
		
		return !isEmptyAll(strings);
	}


	/**
	  * @programId :
	  * @name : trim
	  * @date : 2017. 1. 13.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 문자열 공백 제거
	  * @param str
	  * @return
	  */
	public  final static String trim(String str){
	  if(StringUtil.isNotEmpty(str)) return str.trim();
	  return str;
	}




	/**
	  * @programId :
	  * @name : extNumber
	  * @date : 2017. 1. 13.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 문자열에서 숫자만 추출함. ex) 010-1234-5678 -> 01012345678
	  * @param str
	  * @return
	  */
	public  final static String extNumber(String str){

		if(StringUtil.isNotEmpty(str)) return str.replaceAll("\\D+","");
		return str;
	}

	/**
	 * ICNStringUtility
	 * */
	
	/**
	 * 클래스의 collection 이름을 반환한다
	 *
	 * @param cls	대상이 되는 클래스
	 * @return		collection 이름
//	 */
//	public  final static String getCollectionName(@SuppressWarnings("rawtypes") Class cls) {
//		return cls.getAnnotations()[0].toString().substring(cls.getAnnotations()[0].toString().indexOf("collection") + 11, cls.getAnnotations()[0].toString().length() - 1);
//	}

	/**
	 * 대상이 되는 문자열의 각 문자가 1byte인지 여부를 판단하여
	 * 각 문자의 길이에 맞도록(문자가 깨지지 않도록) 지정한 길이 만큼 자른다.
	 * {@link UnsupportedEncodingException} 예외발생시 로그출력
	 *
	 * @param szText	대상이 되는 UTF-8 문자열
	 * @param nLength	문자열 길이
	 * @return			변환된 문자열
	 */
//	public  final static String strCut(String szText, int nLength)
//	{ // 문자열 자르기
//		String r_val = szText;
//		int oF = 0, oL = 0, rF = 0, rL = 0;
//		int nLengthPrev = 0;
//		try
//		{
//			byte[] bytes = r_val.getBytes("UTF-8"); // 바이트로 보관
//			// x부터 y길이만큼 잘라낸다. 한글안깨지게.
//			int j = 0;
//			if (nLengthPrev > 0) {
//				while (j < bytes.length)
//				{
//					if ((bytes[j] & 0x80) != 0)
//					{
//						oF += 2;
//						rF += 3;
//						if (oF + 2 > nLengthPrev)
//						{
//							break;
//						}
//						j += 3;
//					}
//					else
//					{
//						if (oF + 1 > nLengthPrev)
//						{
//							break;
//						}
//						++oF;
//						++rF;
//						++j;
//					}
//				}
//			}
//			j = rF;
//			while (j < bytes.length)
//			{
//				if ((bytes[j] & 0x80) != 0)
//				{
//					if (oL + 2 > nLength)
//					{
//						break;
//					}
//					oL += 2;
//					rL += 3;
//					j += 3;
//				}
//				else
//				{
//					if (oL + 1 > nLength)
//					{
//						break;
//					}
//					++oL;
//					++rL;
//					++j;
//				}
//			}
//			r_val = new String(bytes, rF, rL, "UTF-8"); // charset 옵션
//		}
//		catch (UnsupportedEncodingException e)
//		{
//			LogUtil.error(e);
//		}
//		return r_val;
//	}
//
//	/**
//	 * 문자열의 byte 길이를 반환한다
//	 *
//	 * @param str	대상이 되는 문자열
//	 * @return		바이트 길이
//	 */
//	public  final static int checkByte(String str) {
//		int len = str.length();
//		int cnt = 0;
//
//		for(int i=0; i<len; i++){
//			if(str.charAt(i) < 256) {
//				cnt++;
//			} else {
//				cnt = cnt + 2;
//			}
//		}
//
//		return cnt;
//	}


	/**
	 * 대상 문자열을 Base64 방식으로 인코딩하여 반환한다.
	 * {@link UnsupportedEncodingException} 예외발생시 로그출력
	 *
	 * @param str	대상이 되는 UTF-8 문자열
	 * @return		변환된 문자열
	 */
//	public  final static String encodeBase64(String str) {
//		byte[] encodeByte = null;
//		try {
//			//encodeByte = Base64.encode(str.getBytes("UTF-8"));
//			encodeByte = Base64.getEncoder().encode(str.getBytes("UTF-8"));
//		} catch (UnsupportedEncodingException e) {
//			
//			LogUtil.error(e);
//		}
//		return new String (encodeByte);
//	}
//
//	/**
//	 * 대상 문자열을 Base64 방식으로 디코딩하여 반환한다.
//	 * {@link UnsupportedEncodingException} 예외발생시 로그출력
//	 *
//	 * @param str	대상이 되는 UTF-8 문자열
//	 * @return		변환된 문자열
//	 */
//	public  final static String decodeBase64(String str) {
//		byte[] decodeByte = null;
//		try {
////			decodeByte = Base64.decode(str.getBytes("UTF-8"));
//			decodeByte = Base64.getDecoder().decode(str.getBytes("UTF-8"));
//			
//		} catch (UnsupportedEncodingException e) {
//			
//			LogUtil.error(e);
//		}
//		return new String (decodeByte);
//	}
//
//	
//
//	/**
//	 * 대상 문자열을 UTF-8 방식으로 디코딩하여 반환한다.
//	 * {@link UnsupportedEncodingException} 예외발생시 로그출력
//	 *
//	 * @param str	대상이 되는 문자열
//	 * @return		변환된 문자열
//	 */
//	public  final static String decodeUTF8(String str) {
//		String rtnValue = "";
//		try {
//			rtnValue =URLDecoder.decode(str, "utf-8");
//		} catch (UnsupportedEncodingException e) {
//			
//			LogUtil.error(e);
//		}
//		return rtnValue;
//	}
//
//	/**
//	 * 대상 문자열을 지정된 캐릭터셋으로 로그 출력하고	
//	 * 지정된 캐릭터셋이 아니라면 예외를 던진다
//	 *
//	 * @param value		대상 문자열
//	 * @throws 			UnsupportedEncodingException
//	 */
//	public  final static void printformat(String value) throws UnsupportedEncodingException{
//		String charset[] = {"KSC5601","8859_1", "ascii", "UTF-8", "EUC-KR", "MS949"};
//
//
//		for(int i=0; i<charset.length ; i++){
//			for(int j=0 ; j<charset.length ; j++){
//				if(i==j){ continue;}
//				else{
//					System.out.println(charset[i]+" : "+charset[j]+" :" +new String (value.getBytes(charset[i]),charset[j]));
//				}
//			}
//		}
//	}
//
//	/**
//	 * jackson 라이브러리를 이용하여 객체를 JSON 형식의 문자열로 반환
//	 *
//	 * @param obj	대상이 되는 객체
//	 * @return		변환된 문자열
//	 */
//	@SuppressWarnings("deprecation")
//	public  final static String getJSONtoObject(Object obj) {
//		String rtnValue = "";
//		try {
//			rtnValue = new ObjectMapper().writeValueAsString(obj);
////			rtnValue = new ObjectMapper().defaultPrettyPrintingWriter().writeValueAsString(obj);
//		} catch (JsonGenerationException e) {
//			LogUtil.info(e.getMessage());
//		} catch (JsonMappingException e) {
//			LogUtil.info(e.getMessage());
//		} catch (IOException e) {
//			LogUtil.info(e.getMessage());
//		}
//		return rtnValue;
//	}
//
//	/**
//	 * null 을 공백으로 바꾼다
//	 *
//	 * @param str	대상이 되는 문자열
//	 * @return		변환된 문자열
//	 */
//	public  final static String convertNull(String str) {
//		if(str == null) {
//			str = "";
//		}
//
//		return str;
//	}
//
//
//	/**
//	  * @name : isNotEmpty
//	  * @date : 2017. 1. 11.
//	  * @author : knlee
//	  * @변경이력 :
//	  * @description : 문자열 값이 비어있지 않는지 체크(null , 공백)
//	  * @param str 비교할 문자열
//	  * @return true: 데이타 존재. false: null 또는 공백
//	  */
//	public  final static boolean isNotEmpty(String str) {
//		if(str == null) return false;
//		if("".equals(str.trim())) return false;
//		return true;
//	}
//		
//
//
//	/**
//	  * @name : isEmpty
//	  * @date : 2017. 1. 11.
//	  * @author : knlee
//	  * @table :
//	  * @변경이력 :
//	  * @description : 문자열 값이 비어 있는지 체크(null , 공백)
//	  * @param str
//	  * @return true: null 또는 공백. false: 데이터 존재
//	  */
//	public  final static boolean isEmpty(String str) {
//		if(str == null) return true;
//		if("".equals(str.trim())) return true;
//		return false;
//	}
//	
//	/**
//	 * 파라미터 값 모두가 비어 있으면 true
//	 * @param strings
//	 * @return
//	 */
//	public  final static boolean isEmptyAll(String ... strings ){
//		boolean result = false;
//		for (int i = 0; i < strings.length; i++) {
//		     if(isEmpty(strings[i])) result = true;
//		     else result = false;
//		}
//		
//		return result;
//	}
//	
//	/**
//	  * @programId :
//	  * @name : trim
//	  * @date : 2017. 1. 13.
//	  * @author : knlee
//	  * @table :
//	  * @변경이력 :
//	  * @description : 문자열 공백 제거
//	  * @param str
//	  * @return
//	  */
//	public  final static String trim(String str){
//	  if(ICNStringUtility.isNotEmpty(str)) return str.trim();
//	  return str;
//	}

	
	public  final static boolean isEquals(String str1,  String str2 ){
	    if(str1 == null || str2 == null)  return false;
	    if(str1.equals(str2)) return true;
		return false;
	}
	
	public  final static boolean isUpperCaseEquals(String str1,  String str2 ){
	    if(str1 == null || str2 == null)  return false;
	    if(str1.trim().equalsIgnoreCase(str2.trim())) return true;
		return false;
	}
	
	
	/**
	 * 파라미터 값 모두가 값이 존재하면 true
	 * @param strings
	 * @return
	 */
//	public  final static boolean isNotEmptyAll(String ... strings ){
//		boolean result = false;
//		for (int i = 0; i < strings.length; i++) {
//		     if(isNotEmpty(strings[i])) result = true;
//		     else return false;
//		}
//		return result;
//	}
//
//
//
//
//	/**
//	  * @programId :
//	  * @name : extNumber
//	  * @date : 2017. 1. 13.
//	  * @author : knlee
//	  * @table :
//	  * @변경이력 :
//	  * @description : 문자열에서 숫자만 추출함. ex) 010-1234-5678 -> 01012345678
//	  * @param str
//	  * @return
//	  */
//	public  final static String extNumber(String str){
//
//		if(ICNStringUtility.isNotEmpty(str)) return str.replaceAll("\\D+","");
//		return str;
//	}
//
//
//	/**
//	 * 문자열을 ByteBuffer 에 넣는다
//	 *
//	 * @param str	대상이 되는 문자열
//	 * @return		바이트 버퍼
//	 */
//	public  final static ByteBuffer getByteBuffer(String str) {
//		String tmpStr = str;
//		byte[] bytes = tmpStr.getBytes();
//		ByteBuffer bb = ByteBuffer.allocate(bytes.length);
//		bb.put(bytes,0,bytes.length);
//		return bb;
//	}
//
//	/**
//	 * 고정길이 숫자형태의 문자열을 얻는다. 남는자리는 '0'
//	 *
//	 * @param number	변환할 대상이 되는 문자열
//	 * @param len		문자열 길이
//	 * @return			변환된 문자열
//	 */
//	public  final static String getFixedNumber(String number, int len) {
//		String str = number;
//		str = ICNStringUtility.replace(str, " ", "");
//		if(str == null) {
//			str = "0";
//		} else if(str.length() > len) {
//			str = str.substring(0, len);
//		}
//
//		str = String.valueOf(Integer.parseInt(str));
//		StringBuffer sbString = new StringBuffer();
//
//		for(int i=str.length(); i<len; i++) {
//			sbString.append("0");
//		}
//
//		sbString.append(str);
//
//		return sbString.toString();
//	}
//
//	/**
//	 *
//	 * @param one_str
//	 * @param len
//	 * @return String
//	 */
//	public  final static String getFixedOneStr(String one_str, int len) {
//		String str = one_str;
//
//		if(str == null) {
//			str = "";
//		} else if(str.length() > len) {
//			str = str.substring(0, len);
//		}
//
//		StringBuffer sbString = new StringBuffer();
//
//		for(int i=str.length(); i<len; i++) {
//			sbString.append(one_str);
//		}
//
//		sbString.append(str);
//
//		return sbString.toString();
//	}
//
//	/**
//	 * 고정길이 숫자형태의 문자열을 얻는다. 남는자리는 '0'
//	 *
//	 * @param number	변환할 대상이 되는 정수
//	 * @param len		문자열 길이
//	 * @return			변환된 문자열
//	 */
//	public  final static String getFixedNumber(int number, int len) {
//		String str = String.valueOf(number);
//
//		if(str == null) {
//			str = "";
//		} else if(str.length() > len) {
//			str = str.substring(0, len);
//		}
//
//		StringBuffer sbString = new StringBuffer();
//
//		for(int i=str.length(); i<len; i++) {
//			sbString.append("0");
//		}
//
//		sbString.append(str);
//
//		return sbString.toString();
//	}
//
//	/**
//	 * 고정길이 byte 로 자른 문자열 배열을 얻는다
//	 *
//	 * @param str			변환할 대상이 되는 문자열
//	 * @param byteLength	바이트 길이
//	 * @return				변환된 문자열
//	 */
//	public  final static String[] getFixedByteArray(String str, int byteLength) {
//
//		List<String> aList = new ArrayList<String>();
//		String tmpStr = str;
//		if(tmpStr == null) {
//			tmpStr = "";
//		}
//		if(tmpStr.getBytes().length < byteLength) {
//			aList.add(getFixedByte(tmpStr, byteLength));
//		} else {
//			byte[] byteString = tmpStr.getBytes();
//			int startPos = 0;
//			int endPos = 0+byteLength;
//
//			while(byteString.length>startPos) {
//				String tmp = "";
//				if(byteString.length >= (startPos+byteLength)) {
//					tmp = new String(byteString,startPos,byteLength);
//				} else {
//					tmp = new String(byteString,startPos,byteString.length-startPos);
//				}
//
//				aList.add(getFixedByte(tmp,byteLength));
//				startPos = startPos + byteLength;
//				endPos = endPos + byteLength;
//			}
//		}
//
//		String[] strArray = new String[aList.size()];
//		aList.toArray(strArray);
//		aList.clear();
//		return strArray;
//	}
//
//	/**
//	 * 고정길이 byte 로 자른 문자열을 얻는다
//	 *
//	 * @param str			변환할 대상이 되는 문자열
//	 * @param byteLength	바이트 길이
//	 * @return				변환된 문자열
//	 */
//	public  final static String getFullFixedByte(String str, int byteLength) {
//
//		str = getFullString(str);
//		str = getFixedByte(str, byteLength-2);
//		str = str + "  ";
//		return str;
//	}
//
//	/**
//	 * 고정길이 byte 로 자른 문자열을 얻는다
//	 *
//	 * @param str			변환할 대상이 되는 문자열
//	 * @param byteLength	바이트 길이
//	 * @return				변환된 문자열
//	 */
//	public  final static String getFixedByte(String str, int byteLength) {
//		StringBuffer sbString = new StringBuffer();
//		String tmpStr = str;
//		if(tmpStr == null) {
//			tmpStr = "";
//		}
//
//		sbString.append(tmpStr);
//
//		for(int i=tmpStr.getBytes().length; i<byteLength; i++) {
//			sbString.append(" ");
//		}
//		tmpStr = sbString.toString();
//		byte[] byteString = tmpStr.getBytes();
//
//		return new String(byteString,0,byteLength);
//	}
//
//	/**
//	 * 시작위치로 부터 특정 길이의 고정길이 문자열을 얻는다
//	 *
//	 * @param str		변환할 대상이 되는 문자열
//	 * @param startPos	시작 위치
//	 * @param endPos	끝 위치
//	 * @return			변환된 문자열
//	 */
//	public  final static String getFixedByte(String str, int startPos, int endPos) {
//		String tmpStr = str;
//		tmpStr = getFixedByte(tmpStr, endPos);
//		return new String(tmpStr.getBytes(), startPos, endPos-startPos);
//	}
//
//	/**
//	 * 반자를 전자로 변환한다
//	 *
//	 * @param 	strHalf	변환할 대상이 되는 문자열
//	 * @return			변환된 문자열
//	 */
//	public  final static String getFullString(String strHalf) {
//
//		if(strHalf == null) {
//			return strHalf;
//		}
//
//		char[] charArray = strHalf.toCharArray();
//
//		for(int i=0; i<charArray.length; i++) {
//			if(charArray[i] >= 0x21 && charArray[i] <= 0x7E) {
//				// 반자 영문 영숫자/문자부호를 골라, 0xFEE0 만큼 더한다.
//				charArray[i] += 0xFEE0;
//			} else if(charArray[i] == 0x20) {
//				// 반자 공백을 전자 공백으로 바꾼다.
//				charArray[i] = 0x3000;
//			}
//		}
//
//		String strFull = new String(charArray);
//
//		return strFull;
//	}
//
//	/**
//	 * 전자를 반자로 변환한다
//	 *
//	 * @param 	strFull	변환할 대상이 되는 문자열
//	 * @return			변환된 문자열
//	 */
//	public  final static String getHalfString(String strFull) {
//
//		if(strFull == null) {
//			return strFull;
//		}
//
//		char[] charArray = strFull.toCharArray();
//
//		for(int i=0; i<charArray.length; i++) {
//			if(charArray[i] >= 0xFF01 && charArray[i] <= 0xFF5E) {
//				// 전자 영문 영숫자/문자부호를 골라, 0xFEE0 만큼 뺀다.
//				charArray[i] -= 0xFEE0;
//			} else if(charArray[i] == 0x3000) {
//				// 전자 공백을 반자 공백으로 바꾼다.
//				charArray[i] = 0x20;
//			}
//		}
//
//		String strHalf = new String(charArray);
//		return strHalf;
//	}
//
//	/**
//	 * 문자열에서 특정 문자열을 찾아서 대체 문자열로 대체하여 반환한다.
//	 *
//	 * @param str	변환할 대상이 되는 문자열
//	 * @param src	찾을 문자열
//	 * @param dst	대체할 문자열
//	 * @return		변경된 문자열
//	 */
//	public static String replace(String str, String src, String dst)
//	{
//		if(str == null || src == null || dst == null || str.length() == 0 || src.length() == 0) {
//			return str;
//		}
//
//		int srcLength = src.length(), pos = 0, dstLength = dst.length();
//		while(true) {
//
//			if((pos = str.indexOf(src,pos)) != -1) {
//				if((pos+srcLength) < str.length()) {
//					str = str.substring(0,pos) + dst + str.substring(pos+srcLength);
//				} else {
//					str = str.substring(0,pos) + dst;
//				}
//
//				pos = pos + dstLength;
//
//				if(pos > str.length()) {
//					pos = str.length();
//				}
//			} else {
//				break;
//			}
//		}
//		return str;
//	}
//
//	/**
//	 * 대상 문자열을 구분자로 나눠서 문자열 배열로 반환
//	 *
//	 * @param str			변환할 대상이 되는 문자열
//	 * @param separator		문자열 구분자
//	 * @return				문자열 배열
//	 */
//	public  final static String[] getStringArray(String str, String separator) {
//		str = ICNStringUtility.replace(str, separator, " " + separator);
//
//		StringTokenizer strToken = new StringTokenizer(str, separator);
//		String[] strArray = null;
//
//		List<String> list = new ArrayList<String>();
//
//		while (strToken.hasMoreTokens()) {
//			list.add(strToken.nextToken().toString().trim());
//		}
//
//		strArray = new String[list.size()];
//		list.toArray(strArray);
//		list.clear();
//
//		return strArray;
//	}
//
//	/**
//	 *
//	 * @param str
//	 * @param separator
//	 * @return String[]
//	 */
//	public  final static String[] getStringArrayTelNo(String str, String separator) {
//		str = ICNStringUtility.replace(str, separator, " " + separator);
//
//		StringTokenizer strToken = new StringTokenizer(str, separator);
//		String[] strArray = null;
//		String[] strArrayTelNo = new String[3];
//		strArrayTelNo[0] = "";
//		strArrayTelNo[1] = "";
//		strArrayTelNo[2] = "";
//
//
//		List<String> list = new ArrayList<String>();
//
//		while (strToken.hasMoreTokens()) {
//			list.add(strToken.nextToken().toString().trim());
//		}
//
//		strArray = new String[list.size()];
//		list.toArray(strArray);
//		list.clear();
//
//		for(int i=0; i<strArray.length; i++) {
//			strArrayTelNo[2-i] = strArray[strArray.length-i-1];
//		}
//
//		return strArrayTelNo;
//	}
//
//	/**
//	 * 문자열이 최대자릿수 보다 크면,
//	 * 문자열을 최대자릿수 만큼 자른 후 '...'을 끝에 붙여서 반환
//	 *
//	 * @param str		변환할 대상이 되는 문자열
//	 * @param endIndex	변환할 문자열 최대자릿수
//	 * @return			변환된 문자열
//	 */
//	public  final static String cutStrInByte(String str, int endIndex)
//	{
//		StringBuffer sbStr = new StringBuffer(endIndex);
//		int iTotal=0;
//		char[] chars = str.toCharArray();
//
//		for(int i=0; i<chars.length; i++)
//		{
//			iTotal+=String.valueOf(chars[i]).getBytes().length;
//			if(iTotal>endIndex)
//			{
//				sbStr.append("...");  // ... 붙일것인가 옵션
//				break;
//			}
//			sbStr.append(chars[i]);
//		}
//		return sbStr.toString();
//	}
//	
	
	
	/**
	 * @name : isNotEmpty
	 * @date : 2015. 10. 21.
	 * @author : 류동균
	 * @description : Null 또는 빈값 확인
	 */
	public static boolean isNotEmpty(Object object) {

		return !isEmpty(object);
	}

	/**
	 * @name : isEmpty
	 * @date : 2015. 10. 21.
	 * @author : 류동균
	 * @description : Null 또는 빈값 확인
	 */
	@SuppressWarnings("rawtypes")
	public static boolean isEmpty(Object object) {
		if (object == null) {
			return true;
		}

		if (object instanceof String) {
			String str = (String) object;
			return str.length() == 0;
		}

		if (object instanceof Collection) {		
			Collection collection = (Collection) object;
			return collection.size() == 0;
		}
		
		if (object instanceof Map) {
            return ((Map<?, ?>)object).isEmpty();
        }
		
		if (object instanceof List) {
            return ((List<?>)object).isEmpty();
        }

		if (object.getClass().isArray() && Array.getLength(object) == 0) {
					return true;
		}

		return false;
	}



//	public  final static String getBinaryString(String str) {
//		String rtnValue = "";
//
//		char[] stringArray = str.toCharArray();
//		for (int i = 0; i < stringArray.length; i++) {
//			rtnValue += Integer.toBinaryString(stringArray[i]);
//		}
//		
//
//		return rtnValue;
//	}

	
	/**
	 * 구분자로 구별된 마지막 단어를 가져온다.
	 * @param str
	 * @return
	 */
	public  final static String getStringOfLastSper(String str, String sper) {
	//	String rtnValue = "";
		if(str == null || str.length() == 0) return "";
		
		String arry[] = getStringArray(str, sper);
		

		return arry[arry.length-1];
	}
	
	/**
	 * 특정문자열부터 뒤에서부터 자른다. 예: jobMemberTriger 문자열에서 Triger 문자열 제거-> jobMember
	 * @param src
	 * @param indexStr
	 * @return
	 */
	public  final static String getStringLastCut(String src, String  indexStr) {
		
		return src.substring(0, src.lastIndexOf(indexStr));
		
	}
	
	
	
//	public static void main(String[] args) {
//	//	System.out.println("1111111111111111111");
//	//	String  str ="icignal.batch.b2c.repository.B2CMapper.findOrderProdDailySummary";
//	//	String  str ="mrt.afd,mrt.sdfaml,mrt.sefs";
//	//	System.out.println( str.length());
//	//    System.out.println(getStringOfLastSper(str, "."));
//		
//	    
//	    
////	    List<String> items = Arrays.asList(str.split("\\s*,\\s*"));
//	 /*   List<String> items = Arrays.asList(str.split(","));
//		for(String item : items) {
//			System.out.println("item:" + item );
//			
//		}*/
//		
//		System.out.println(getStringLastCut("jobMemberTrigger", "Trigger"));
//		
//		
//	}

	/**
	 * StringUtil
	 * */
	
	/**
	 * StringUtility 생성자 주석.
	 */
	public StringUtil() {
		super();
	}
	/**
	 * 8859_1 => euc-kr
	 **/
	public static String convert88591_EUCKR(String str)
	{
		String strdata = str;
		try {
			if(strdata != null) strdata = new String(strdata.getBytes("8859_1"),"euc-kr");
		} catch(java.io.UnsupportedEncodingException e) {
			return "Encoding Error";
		}
		return strdata;
	}
	/**
	 * 8859_1 => KSC5601
	 **/
	public static String convert88591_KSC5601(String str)
	{
		String strdata = str;

		try {
			if(strdata != null) strdata = new String(strdata.getBytes("8859_1"),"KSC5601");
		} catch(java.io.UnsupportedEncodingException e) {
			return "Encoding Error";
		}
		return strdata;
	}
	/**
	 * euc-kr => 8859_1
	 **/
	public static String convertEUCKR_88591(String str)
	{
		String strdata = str;

		try {
			if(strdata != null) strdata = new String(strdata.getBytes("euc-kr"),"8859_1");
		} catch(java.io.UnsupportedEncodingException e) {
			return "Encoding Error";
		}
		return strdata;
	}
	/**
	 * KSC5601 => 8859_1
	 **/
	public static String convertKSC5601_88591(String str)
	{
		String strdata = str;

		try {
			if(strdata != null) strdata = new String(strdata.getBytes("KSC5601"),"8859_1");
		} catch(java.io.UnsupportedEncodingException e) {
			return "Encoding Error";
		}
		return strdata;
	}
	/**
	 * Null Check 하여 Null 일경우 replacer로 반환
	 **/
	public static String convertNull(String value, String replacer) // nvl
	{
		String valuedata = value;
		String replacerdata = replacer;

		valuedata = replaceSecurityString(valuedata);

		if(valuedata == null) return replacerdata;
		else return valuedata;
	}
	
//	public static String convertNull(String value) // nvl
//	{
//		if(value == null) return "";
//		else return value;
//	}
	
	/**
	 * 문자열의 앞에 있는 0을 삭제하여 반환
	 **/
	public static String firstZeroDel(String val)
	{
		String valdata = val;

		if(valdata == null || valdata.equals("")) return "";
		while(valdata.charAt(0)=='0') {
			valdata = valdata.substring(1);
		}
		return valdata;
	}
	/**
	 *  number format에 맟춰서 결과를 출력한다.
 	 **/
	public static String formatNumber(double doubleNumber, int fraction)
	{

		String result = "";	// return할 String format

		/* fraction에 따라 NumberFormat을 설정한다. */
		java.text.DecimalFormat numberFormat = new java.text.DecimalFormat();

		switch (fraction)
		{
			case 0 : // 3자리마다 쉼표를 표시하고,  소숫점이 없는 출력
				numberFormat.applyPattern("#,##0");
				break;
			case 1 : // 3자리마다 쉼표를 표시하고,   소숫점 1자리까지 출력
				numberFormat.applyPattern("#,##0.0");
				break;
			case 2 : // 3자리마다 쉼표를 표시하고,   소숫점 2자리까지 출력
				numberFormat.applyPattern("#,##0.00");
				break;
			case 3 : // 3자리마다 쉼표를 표시하고,   소숫점 3자리까지 출력
				numberFormat.applyPattern("#,##0.000");
				break;
			case 4 : // 3자리마다 쉼표를 표시하고,   소숫점 4자리까지 출력
				numberFormat.applyPattern("#,##0.0000");
				break;

			case 10 : // 소숫점이 없는 출력
				numberFormat.applyPattern("0");
				break;
			case 11 : // 소숫점 1자리까지 출력
				numberFormat.applyPattern("0.0");
				break;
			case 12 : // 소숫점 2자리까지 출력
				numberFormat.applyPattern("0.00");
				break;
			case 13 : // 소숫점 3자리까지 출력
				numberFormat.applyPattern("0.000");
				break;
			case 14 : // 소숫점 이하자리 없는  형태
				numberFormat.applyPattern("0.0000");
				break;

			default : // 3자리마다 쉼표를 표시하고,   소숫점 2자리까지 출력
				numberFormat.applyPattern("#,##0.00");
				break;
		}

		try
		{
			result = numberFormat.format(doubleNumber);
		}
		catch (IllegalArgumentException e)
		{
			throw e;
		}

		return result;
	}
	/**
	 *  long형의 숫자를 받아서 number format으로 바꿔 결과를 출력한다.
	 **/
	public static String formatNumber(long number, int fraction)
	{

		Long longNumber = new Long(number);
		double doubleNumber = longNumber.doubleValue();	// data의 double format

		return formatNumber(doubleNumber, fraction);
	}
	/**
	 *  Object를 받아서 number format으로 바꿔 결과를 출력한다.
	 **/
	public static String formatNumber(Object obj, int fraction)  throws Exception
	{

		String stringNumber = "";
		stringNumber = obj != null ? obj.toString().trim() : "";
		double doubleNumber = 0; 						// data의 double format

		if (stringNumber.equals(""))
		{
			stringNumber = "0";
		}

		/* entity의 값을 Double object로 만든다. */
		try
		{
			//doubleNumber = Double.parseDouble(stringNumber);
			doubleNumber = Double.parseDouble(stringNumber);
		}
		catch (NumberFormatException e)
		{
			throw e;
		}

		return formatNumber(doubleNumber, fraction);
	}
	/**
	 *  String 을 받아서 number format으로 바꿔 결과를 출력한다.
	 **/
	public static String formatNumber(String stringNumber,int fraction) throws Exception
	{
		String stringNumberdata = stringNumber;
		int fractiondata = fraction;

		double doubleNumber = 0;

		if(stringNumberdata.equals(""))
		{
			stringNumberdata = "0";
		}

		try
		{
		//		doubleNumber = Double.parseDouble(stringNumber);
			doubleNumber = Double.parseDouble(stringNumberdata);
		}catch(NumberFormatException e)
		{
			throw e;
		}
		return formatNumber(doubleNumber, fraction);
	}
	/**
	 * 전화번호를 구분자를 이용하여 반환
	 **/
	public static String formatTel(String val, String delimeter)
	{
		String resultText = "";
		resultText = StringUtil.replace(val, delimeter, "");

		if(resultText.indexOf(')') >= 0 || resultText.indexOf('-') >= 0 || resultText.length() < 7) {
			return val;
		} else {
			int totalSize = resultText.length();
			if ( resultText.substring(0, 2).equals("02") && totalSize > 7 ) {
				resultText = resultText.substring(0, 2) + delimeter + resultText.substring(2, totalSize- 4) + delimeter + resultText.substring(totalSize - 4, totalSize);
			} else {
				String areaNum = resultText.substring(0, 3);
				if(totalSize > 8 &&
					(areaNum.equals("031") || areaNum.equals("032") || areaNum.equals("033") ||
					 areaNum.equals("041") || areaNum.equals("042") || areaNum.equals("043") ||
					 areaNum.equals("051") || areaNum.equals("052") || areaNum.equals("053") || areaNum.equals("054") || areaNum.equals("055") ||
					 areaNum.equals("061") || areaNum.equals("062") || areaNum.equals("063") || areaNum.equals("064") ||
					 areaNum.equals("011") || areaNum.equals("016") || areaNum.equals("017") || areaNum.equals("018") || areaNum.equals("019") ||
					 areaNum.equals("012") || areaNum.equals("015")
					 || areaNum.equals("010")
					 || areaNum.equals("070") || areaNum.equals("013"))) {
					resultText = resultText.substring(0, 3) + delimeter + resultText.substring(3, totalSize- 4) + delimeter + resultText.substring(totalSize - 4, totalSize);
				} else {
					if(totalSize > 8) {
						resultText = resultText.substring(0,3) + delimeter + resultText.substring(3,totalSize-4) + delimeter + resultText.substring(totalSize-4, totalSize);
					} else {
						if(totalSize > 4) {
							resultText = resultText.substring(0,totalSize-4) + delimeter + resultText.substring(totalSize-4, totalSize);
						} 
					}
				}
			}
			return resultText;
		}
	}
	/**
	 * 입력된 스트링의 길이가 len 보다 작으면 공백으로 나머지 길이를 채우고,
	 * len보다 크면 len길이 만큼만 잘라서 반환한다.
	 **/
	public static String getFixedString(String str, int len)		// makeBlank
	{
		String tempStr = str;
		if(tempStr == null) tempStr = "";
		else if(tempStr.length() > len) tempStr = tempStr.substring(0, len);

		StringBuffer sbString = new StringBuffer();

		sbString.append(tempStr);
		for(int i=tempStr.length(); i<len; i++) {
			sbString.append(" ");
		}

		return sbString.toString();
	}

	/**
	 * 입력된 스트링의 길이가 len 보다 작으면 공백으로 나머지 길이를 채우고,
	 * len보다 크면 len길이 만큼만 잘라서 반환한다.
	 **/
//	public static String getFixedNumber(String str, int len)		// make Zero
//	{
//		if(str == null) str = "";
//		else if(str.length() > len) str = str.substring(0, len);
//
//		StringBuffer sbString = new StringBuffer();
//
//		for(int i=str.length(); i<len; i++) {
//			sbString.append("0");
//		}
//		sbString.append(str);
//
//		return sbString.toString();
//	}

	/**
	 * 입력된 스트링의 길이가 len 보다 작으면 공백으로 나머지 길이를 채우고,
	 * len보다 크면 len길이 만큼만 잘라서 반환한다.
	 **/
	public static String getFixedHangul(String str, int len)		// make 한글, len 은 byte 수
	{
		StringBuffer sbReturn = new StringBuffer();
		char[] cTemp = str.toCharArray();
		int byteLength = 0;
		for(int i=0; i<cTemp.length ; i++)
		{
			byte[] byteTemp = String.valueOf(cTemp[i]).getBytes();
			byteLength += byteTemp.length;


			if(byteLength <= len) {
				sbReturn.append(String.valueOf(cTemp[i]));
			} else {
				int m = 0;
				for(int k=byteLength-byteTemp.length; k<len; k++) {
					sbReturn.append(" ");
					m++;
				}
				byteLength = byteLength + m;
				i = cTemp.length;
			}
		}

		for(int k=byteLength; k<len; k++) {
			sbReturn.append(" ");
		}

		return sbReturn.toString();

	}


	/**
	 * 입력된 문자열중에서 지정된 문자열로 해당문자열을 변환시킨다.
	 **/
//	public static String replace(String str, String src, String dst)
//	{
//		if(str == null || src == null || dst == null || str.length() == 0 || src.length() == 0) return str;
//
//		boolean flag = false;
//
//		int srcLength = src.length(), pos = 0, dstLength = dst.length();
//
//		while(true) {
//			if((pos = str.indexOf(src,pos)) != -1) {
//				flag = true;
//				if((pos+srcLength) < str.length())
//					str = str.substring(0,pos) + dst + str.substring(pos+srcLength);
//				else
//					str = str.substring(0,pos) + dst;
//
//				pos = pos + dstLength;
//
//				if(pos > str.length()) pos = str.length();
//			} else {
//				flag = false;
//				break;
//			}
//		}
//		return str;
//	}
	/**
	 *
	 **/
	public static String substring(String str, int len) throws Exception
	{
		String result = StringUtil.convertNull(str,"");
		if(result.length() > 0 && len <= result.length()) result = result.substring(0,len);
		return result;
	}
	/**
	 * WEB상에서 받아들인 문자열의 특수기호 처리
	 **/
	public static String toDB(String str)
	{

		if ( str == null ) return null;

		StringBuffer buf = new StringBuffer();
		char[] c = str.toCharArray();
		int len = c.length;
		for ( int i=0; i < len; i++) {
			if      ( c[i] == '\'' ) buf.append("''");
			else buf.append(c[i]);
		}
		return buf.toString();

	}
	/**
	 * toDB() 메소드를 이용하여 DB에 저장되어진 데이타를 WEB상에 그냥 뿌릴때 전환
	 **/
	public static String toWEB(String str) {

		if ( str == null ) return null;

		StringBuffer buf = new StringBuffer();
		char[] c = str.toCharArray();
		int len = c.length;
		for ( int i=0; i < len; i++) {
			if      ( c[i] == '&' ) buf.append("&amp;");
			else if ( c[i] == '<' ) buf.append("&lt;");
			else if ( c[i] == '>' ) buf.append("&gt;");
			else if ( c[i] == '"' ) buf.append("&quot;");
			else if ( c[i] == '\'') buf.append("&#039;");
			else if ( c[i] == '\\') buf.append("&#092;");
			else if ( c[i] == '\n') buf.append("<br>");
		//	else if ( c[i] == '\n') buf.append("  ");
		//	else if ( c[i] == '%') buf.append(" 퍼센트 ");
			else buf.append(c[i]);
		}

		return buf.toString();

	}
	/**
	 * toDB() 메소드를 이용하여 DB에 저장되어진 데이타를 WEB상에 input box나 textarea에 뿌릴때 전환
	 **/
	public static String toWEB_BOX(String str) {
		String tempStr = str;
		tempStr = StringUtil.replace(tempStr, "&amp;", "&&");
		tempStr = StringUtil.replace(tempStr, "&lt;", "<");
		tempStr = StringUtil.replace(tempStr, "&gt;", ">");
		tempStr = StringUtil.replace(tempStr, "&quot;", "\\\"");
		tempStr = StringUtil.replace(tempStr, "&#039;", "\\\'");
		tempStr = StringUtil.replace(tempStr, "&#092;", "\\\\");
//		str = StringUtility.replace(str, "<br>", "");
		return tempStr;
	}
	
	public static String toWEB_BOX2(String str) {
		String tempStr = str;
		tempStr = StringUtil.replace(tempStr, "&amp;", "&&");
		tempStr = StringUtil.replace(tempStr, "&lt;", "<");
		tempStr = StringUtil.replace(tempStr, "&gt;", ">");
		tempStr = StringUtil.replace(tempStr, "&quot;", "\"");
		tempStr = StringUtil.replace(tempStr, "&#039;", "\'");
		tempStr = StringUtil.replace(tempStr, "&#092;", "\\");
//		str = StringUtility.replace(str, "<br>", "");
		return tempStr;
	}

	/**
	* toDB() 메소드를 이용하여 DB에 저장되어진 데이타를 WEB상에 그냥 뿌릴때 전환
	**/
	public static String toWEB2(String str) {

	if ( str == null ) return null;

		StringBuffer buf = new StringBuffer();
		char[] c = str.toCharArray();
		int len = c.length;
		for ( int i=0; i < len; i++) {
			if      ( c[i] == '&' ) buf.append("&amp;");
			else if ( c[i] == '\'') buf.append("&#039;");
			else if ( c[i] == '\\') buf.append("&#092;");
			else if ( c[i] == '\n') buf.append("<br>");
			else buf.append(c[i]);
		}

	return buf.toString();

}

	public  final static String replace(String str, String src1, String src2, String dst)
	{
		String tempStr = str;
		tempStr = replace(replace(str, src1, dst),src2,dst);
		return tempStr;
	}

	public  final static boolean isNumber(char c)  {

		if(c != '-' && c != '.' && c < '0' || c > '9') {
			return false;
		}
		return true;
	}

	public  final static boolean isAllNumber(String str)  {
		String result = StringUtil.convertNull(str,"");
		result = StringUtil.replace(result,",",".","");

		if(result.length() == 0) return false;
		char[] c = result.toCharArray();
		for(int i=0; i<c.length; i++) {
			if(!isNumber(c[i])) return false;
		}
		return true;
	}

	public  final static String getNumberFormat(String str) {
		if(isAllNumber(str)) return StringUtil.replace(str,",","");
		else return "0";
	}

	/**
	 * 구분자가 들어가 스트링에 대해 스트링 배열로 넘겨준다.
	 *
	 * <pre>
	 * str = StringUtility.getStringArray("우리나라@좋은나라@","@");
	 * </pre>
	 *
	 * @param str 구분자가 들어가 스트링
	 * @param separator 구분자
	 * @return 스트링배열
	 * @history  [2005-10-12] [윤재광] 최초작성
//	 */
//	public  final static String[] getStringArray(String str, String separator) {
//		str = StringUtil.replace(str, separator, " " + separator);
//
//		StringTokenizer strToken = new StringTokenizer(str, separator);
//		String[] strArray = null;
//
//		List list = new ArrayList();
//
//		while (strToken.hasMoreTokens()) {
//			list.add(strToken.nextToken().toString().trim());
//		}
//
//		strArray = new String[list.size()];
//		list.toArray(strArray);
//		list.clear();
//
//		return strArray;
//	}

	public  final static String getCardNoWithMark(String strCardNo) {
		String tempStrCardNo = strCardNo;
		tempStrCardNo = StringUtil.replace(tempStrCardNo,"-","");
		if(tempStrCardNo.length() == 16) {
			tempStrCardNo = tempStrCardNo.substring(0,4)+"-"+tempStrCardNo.substring(4,8)+"-"+"****"+"-"+tempStrCardNo.substring(12,16);
		}
		return tempStrCardNo;
	}

	public  final static String getCardNo(String strCardNo) {
		String tempStrCardNo = strCardNo;
		tempStrCardNo = StringUtil.replace(tempStrCardNo,"-","");
		if(tempStrCardNo.length() == 16) {
			tempStrCardNo = tempStrCardNo.substring(0,4)+"-"+tempStrCardNo.substring(4,8)+"-"+tempStrCardNo.substring(8,12)+"-"+strCardNo.substring(12);
		}
		return tempStrCardNo;
	}

	// ADD 2009-10-23, 윤재광, [SR-200908-0258]보너스카드 회원 주민등록번호 암호화 구축요청 : START
	// 주민번호, 카드번호, 웹비밀번호, 카드비밀번호에 대한 마스킹여부 관리
	public  final static String getMaskingJuminNo(String strMaskGB, String strJuminNo) {
		boolean isMask = strMaskGB.equals("N")?false:true;
		if(isMask) return getJuminNoWithMark(strJuminNo);
		else return getJuminNo(strJuminNo);
	}

	// ADD 2009-10-23, 윤재광, [SR-200908-0258]보너스카드 회원 주민등록번호 암호화 구축요청 : START
	// 주민번호, 카드번호, 웹비밀번호, 카드비밀번호에 대한 마스킹여부 관리
	public  final static String getMaskingCardNo(String strMaskGB, String strCardNo) {
		boolean isMask = strMaskGB.equals("N")?false:true;
		if(isMask) return getCardNoWithMark(strCardNo);
		else return getCardNo(strCardNo);
	}

	// ADD 2009-10-23, 윤재광, [SR-200908-0258]보너스카드 회원 주민등록번호 암호화 구축요청 : START
	// 주민번호, 카드번호, 웹비밀번호, 카드비밀번호에 대한 마스킹여부 관리
	public  final static String getMaskingCardPassword(String strMaskGB, String strCardPassword) {
		boolean isMask = strMaskGB.equals("N")?false:true;
		if(isMask) return "****";
		else return strCardPassword;
	}

	// ADD 2009-10-23, 윤재광, [SR-200908-0258]보너스카드 회원 주민등록번호 암호화 구축요청 : START
	// 주민번호, 카드번호, 웹비밀번호, 카드비밀번호에 대한 마스킹여부 관리
	public  final static String getMaskingWebPassword(String strMaskGB, String strWebPassword) {
		boolean isMask = strMaskGB.equals("N")?false:true;
		if(isMask) return "******";
		else return strWebPassword;
	}

	public  final static String getJuminNoWithMark(String strJuminNo) {
		String tempStrJuminNo = strJuminNo;
		tempStrJuminNo = StringUtil.replace(tempStrJuminNo,"-","");
		if(tempStrJuminNo.length() == 13) {
			tempStrJuminNo = tempStrJuminNo.substring(0,6)+"-"+"*******";
			//strJuminNo = strJuminNo.substring(0,6)+"-"+strJuminNo.substring(6,13);
		}
		return tempStrJuminNo;
	}

	public  final static String getJuminNo(String strJuminNo) {
		String tempStrJuminNo = strJuminNo;

		tempStrJuminNo = StringUtil.replace(tempStrJuminNo,"-","");
		if(tempStrJuminNo.length() == 13) {
			tempStrJuminNo = tempStrJuminNo.substring(0,6)+"-"+tempStrJuminNo.substring(6,13);
		}
		return tempStrJuminNo;
	}

	public  final static String getCardPassWithMark(String strCardPass) {

		String tmpCardPass = "";
		for(int i=0; i<strCardPass.length(); i++) {
			tmpCardPass = tmpCardPass + "*";
		}

		return tmpCardPass;
	}

	public  final static String getCardPass(String strCardPass) {

		return strCardPass;
	}

	public  final static String getWebPassWithMark(String strWebPass) {

		String tmpWebPass = "";
		for(int i=0; i<strWebPass.length(); i++) {
			tmpWebPass = tmpWebPass + "*";
		}

		return tmpWebPass;
	}

	public  final static String getWebPass(String strWebPass) {

		return strWebPass;
	}

	public  final static String[] getTelNoArray(String str) {
		String[] telNo = new String[3];

		int totalSize = str.length();
		if ( str.substring(0, 2).equals("02") && totalSize > 7) {
			telNo[0] = str.substring(0,2);
			telNo[1] = str.substring(2,totalSize-4);
			telNo[2] = str.substring(totalSize-4, totalSize);

		} else {
			String areaNum = str.substring(0, 3);
			if(totalSize > 8 &&
				(areaNum.equals("031") || areaNum.equals("032") || areaNum.equals("033") ||
				 areaNum.equals("041") || areaNum.equals("042") || areaNum.equals("043") ||
				 areaNum.equals("051") || areaNum.equals("052") || areaNum.equals("053") || areaNum.equals("054") || areaNum.equals("055") ||
				 areaNum.equals("061") || areaNum.equals("062") || areaNum.equals("063") || areaNum.equals("064") ||
				 areaNum.equals("010") || areaNum.equals("011") || areaNum.equals("016") || areaNum.equals("017") || areaNum.equals("018") || areaNum.equals("019") ||
				 areaNum.equals("012") || areaNum.equals("015")
				 || areaNum.equals("010")
				 || areaNum.equals("070") || areaNum.equals("013"))) {

				telNo[0] = str.substring(0,3);
				telNo[1] = str.substring(3,totalSize-4);
				telNo[2] = str.substring(totalSize-4, totalSize);
			} else {
				if(totalSize > 8) {
					telNo[0] = str.substring(0,3);
					telNo[1] = str.substring(3,totalSize-4);
					telNo[2] = str.substring(totalSize-4, totalSize);
				} else {
					if(totalSize > 4) {
						telNo[0] = "";
						telNo[1] = str.substring(0,totalSize-4);
						telNo[2] = str.substring(totalSize-4, totalSize);
					} else {
						telNo[0] = "";
						telNo[1] = "";
						telNo[2] = str;
					}
				}
			}
		}
		return telNo;
	}


	/**
     * 스트링이 숫자로만 이루어져있는지를 점검하는 메소드
     * @param value 검사할 스트링.
     * @return 모두 숫자이면 true 아니면 false를 반환
     */
    public static boolean isNumeric(String value)
	{
        for(int i = 0; i < value.length(); i++)
            if(!Character.isDigit(value.charAt(i)))
                return false;
        return true;
    }

    public static String protectScript(String str) {
    	String tempStr = str;

    	//String[] protectWords = {"html", "meta", "link", "head", "body", "form", "script", "cookie", "document", "on",
    	//		"HTML", "META", "LINK", "HEAD", "BODY", "FORM", "SCRIPT", "COOKIE", "DOCUMENT","ON"};

    	//for(int i=0; i<protectWords.length; i++) {
    	//	str = StringUtility.replace(str, protectWords[i], " ");
    	//}

    	tempStr = StringUtil.safeHTMLForDB(tempStr);
    	return tempStr;
    }

    public static String protectAdminScript(String str) {
    	String tempStr = str;
    	//String[] protectWords = {"html", "meta", "link", "head", "body", "form", "cookie", "document", "on",
    	//		"HTML", "META", "LINK", "HEAD", "BODY", "FORM", "COOKIE", "DOCUMENT", "ON"};

    	//for(int i=0; i<protectWords.length; i++) {
    	//	str = StringUtility.replace(str, protectWords[i], " ");
    	//}

    	tempStr = StringUtil.safeHTMLForDB_Admin(str);
    	return tempStr;
    }

    public static boolean isImageFile(String filename) {
		boolean isImage = false;

		int pos = 0;

		pos = filename.lastIndexOf('.');

		if(filename.substring(pos+1).equalsIgnoreCase("jpg") || filename.substring(pos+1).equalsIgnoreCase("gif")
				|| filename.substring(pos+1).equalsIgnoreCase("png") || filename.substring(pos+1).equalsIgnoreCase("bmp")) {
			isImage = true;
		}

		return isImage;
	}

	/**
	 * Cross Site Script 제거
	 * @param contents
	 * @return
	 */
	public static String safeHTMLForDB(String contents) {
    	if (contents == null) return null;

		String sReturn = contents;

		/**
		 * 주석제거
		 */
		sReturn = replace2(sReturn, "&#40;", "(");
		sReturn = replace2(sReturn, "&#41;", ")");
		sReturn = replace2(sReturn, "&#47;&#42;", "/*");
		sReturn = replace2(sReturn, "&#42;&#47;", "*/");
    	sReturn = replace2(sReturn, "\\", "");
    	sReturn = replace2(sReturn, "<PRE>", "");
    	sReturn = replace2(sReturn, "</PRE>", "");

		for (int i = 0; i < sReturn.length(); i ++) {
			sReturn = StringUtil.replaceComment(sReturn);
		}

		String regex = "[oO][nN][eE][vV][nN][tT][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "REJECTED_EVENT=");

		/**
		 * ONLOAD
		 */
		regex = "[oO][nN][lL][oO][aA][dD][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "REJECTED_LOAD=");

		/**
		 * ONMOUSEOVER
		 */
		regex = "[oO][nN][mM][oO][uU][sS][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "REJECTED_MOUSEOVER=");

		/**
		 * onError
		 */
		regex = "[oO][nN][eE][rR][rR][oO][rR][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "<REJECTED_ERROR ");

		/**
		 * autofucs
		 */
		regex = "<\\s*[aA][uU][tT][oO][fF][oO][cC][uU][sS]\\s*";
		sReturn = sReturn.replaceAll(regex, "<REJECTED_AUTOFOCUS ");

		/**
		 * onfocus
		 */
		regex = "[oO][nN][fF][oO][cC][uU][sS][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "REJECTED_FOCUS=");


		/**
		 * script
		 */
		regex = "<\\s*[sS][cC][rR][iI][pP][tT]\\s*";
		sReturn = sReturn.replaceAll(regex, "<REJECTED_SCRIPT ");

		/**
		 * javascript
		 */
		regex = "\"\\s*[jJ][aA][vV][aA][sS][cC][rR][iI][pP][tT]\\s*:";
		sReturn = sReturn.replaceAll(regex, "\"REJECTED_SCRIPT:");

		/**
		 * iframe
		 */
		regex = "<\\s*[iI][fF][rR][aA][mM][eE]\\s*";
		sReturn = sReturn.replaceAll(regex, "<REJECTED_IFRAME ");

		regex = "\\s*[eE][xX][pP][rR][eE][sS][sS][iI][oO][nN]\\s*\\(";
		sReturn = sReturn.replaceAll(regex, " REJECTED_EXPRESSION(");

		regex = "[eE][xX][pP][rR][eE][sS][sS][iI][oO][nN]";
		sReturn = sReturn.replaceAll(regex, " REJECTED_EXPRESSION(");

		regex = "=\\s*\"[dD][aA][tT][aA]:";
		sReturn = sReturn.replaceAll(regex, "=\"REJECTED_DATA:");

		regex = "=\\s*\'[dD][aA][tT][aA]:";
		sReturn = sReturn.replaceAll(regex, "=\'REJECTED_DATA:");

		regex = "=\\s*[dD][aA][tT][aA]:";
		sReturn = sReturn.replaceAll(regex, "=REJECTED_DATA:");

		regex = "=\\s*[dD][aA][tT][aA]:";
		sReturn = sReturn.replaceAll(regex, "=REJECTED_DATA:");

		sReturn = sReturn.replaceAll(" REJECTED_ ", "");

		return sReturn;
	}

	/**
	 * Cross Site Script 제거
	 * @param contents
	 * @return
	 */
	public static String safeHTMLForDB_Admin(String contents) {
    	if (contents == null) return null;

		String sReturn = contents;

		/**
		 * 주석제거
		 */
		sReturn = replace2(sReturn, "&#40;", "(");
		sReturn = replace2(sReturn, "&#41;", ")");
		sReturn = replace2(sReturn, "&#47;&#42;", "/*");
		sReturn = replace2(sReturn, "&#42;&#47;", "*/");
    	sReturn = replace2(sReturn, "\\", "");
    	sReturn = replace2(sReturn, "<PRE>", "");
    	sReturn = replace2(sReturn, "</PRE>", "");

		for (int i = 0; i < sReturn.length(); i ++) {
			sReturn = StringUtil.replaceComment(sReturn);
		}

		String regex = "[oO][nN][eE][vV][nN][tT][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "REJECTED_EVENT=");

		/**
		 * ONLOAD
		 */
		regex = "[oO][nN][lL][oO][aA][dD][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "REJECTED_LOAD=");

		/**
		 * ONMOUSEOVER
		 */
		regex = "[oO][nN][mM][oO][uU][sS][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "REJECTED_MOUSEOVER=");

		/**
		 * onError
		 */
		regex = "[oO][nN][eE][rR][rR][oO][rR][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "<REJECTED_ERROR ");

		/**
		 * autofucs
		 */
		regex = "<\\s*[aA][uU][tT][oO][fF][oO][cC][uU][sS]\\s*";
		sReturn = sReturn.replaceAll(regex, "<REJECTED_AUTOFOCUS ");

		/**
		 * onfocus
		 */
		regex = "[oO][nN][fF][oO][cC][uU][sS][0-1a-zA-Z\\/\\*]*\\s*=\\s*";
		sReturn = sReturn.replaceAll(regex, "REJECTED_FOCUS=");


		/**
		 * iframe
		 */
		regex = "<\\s*[iI][fF][rR][aA][mM][eE]\\s*";
		sReturn = sReturn.replaceAll(regex, "<REJECTED_IFRAME ");

		regex = "\\s*[eE][xX][pP][rR][eE][sS][sS][iI][oO][nN]\\s*\\(";
		sReturn = sReturn.replaceAll(regex, " REJECTED_EXPRESSION(");

		regex = "[eE][xX][pP][rR][eE][sS][sS][iI][oO][nN]";
		sReturn = sReturn.replaceAll(regex, " REJECTED_EXPRESSION(");

		regex = "=\\s*\"[dD][aA][tT][aA]:";
		sReturn = sReturn.replaceAll(regex, "=\"REJECTED_DATA:");

		regex = "=\\s*\'[dD][aA][tT][aA]:";
		sReturn = sReturn.replaceAll(regex, "=\'REJECTED_DATA:");

		regex = "=\\s*[dD][aA][tT][aA]:";
		sReturn = sReturn.replaceAll(regex, "=REJECTED_DATA:");

		regex = "=\\s*[dD][aA][tT][aA]:";
		sReturn = sReturn.replaceAll(regex, "=REJECTED_DATA:");

		sReturn = sReturn.replaceAll(" REJECTED_ ", "");

		return sReturn;
	}

	/**
	 * 주석을 제거한다.
	 */
	private static String replaceComment(String input) {
		Pattern p = Pattern.compile( "/\\*[^(\\*/)]*\\*/", Pattern.DOTALL);
    	Matcher m = p.matcher( input );
    	String temp = m.replaceAll("");
    	return temp;
	}

	/*
	 * DB 저장할때만 적용
	 */
	public static String replaceBadContent(String str) {
		String tempStr = str;
		if(str == null) tempStr = "";

		if(!tempStr.equals("")) {
			for(int i=0; i<CommonUtil.badWords.length; i++) {
				tempStr = StringUtil.replaceIgnoreCase(tempStr, CommonUtil.badWords[i], "금칙어"+Integer.toString(i));
			}
		}
		return tempStr;
	}

	/*
	 * Parameter 받을때 또는 ResultSet 반환시 적용
	 */
	public static String recoveryBadContent(String str) {
		String tempStr = str;

		if(tempStr == null) tempStr = "";

		if(!tempStr.equals("")) {
			for(int i=CommonUtil.badWords.length-1; i>=0; i--) {
				tempStr = StringUtil.replaceIgnoreCase(tempStr, "금칙어"+Integer.toString(i), CommonUtil.badWords[i]);
			}
		}
		return tempStr;
	}

	/*
	 * Parameter 받을때 또는 ResultSet 반환시 적용
	 */
	public static String replaceCrossSiteScripting(String str) {
		String tempStr = str;
		if(tempStr == null) tempStr = "";

		if(!tempStr.equals("")) {
			for(int i=0; i<CommonUtil.xssWords.length; i++) {
				tempStr = StringUtil.replaceIgnoreCase(tempStr, CommonUtil.xssWords[i], "XSS"+Integer.toString(i));
			}
		}
		return tempStr;
	}

	/*
	 * Parameter 받을때 또는 ResultSet 반환시 적용
	 */
	public static String recoveryCrossSiteScripting(String str) {
		String tempStr = str;
		if(tempStr == null) tempStr = "";

		if(!tempStr.equals("")) {
			for(int i=CommonUtil.xssWords.length-1; i>=0; i--) {
				tempStr = StringUtil.replaceIgnoreCase(tempStr, "XSS"+Integer.toString(i), CommonUtil.xssWords[i]);
			}
		}
		return tempStr;
	}


	/*
	 * 인증된 URL 만 허용
	 * Parameter 받을때 또는 ResultSet 반환시 적용
	 *
	 *
SELECT DISTINCT REPLACE(NVL(SUBSTR(REPLACE(REPLACE(A.PAGE_01, 'http://', ''), 'https://', ''), 0, INSTR(REPLACE(REPLACE(A.PAGE_01, 'http://', ''), 'https://', ''), '/', 1, 1)), REPLACE(REPLACE(A.PAGE_01, 'http://', ''), 'https://', '')), '/', '') AS PAGE
FROM
(
 SELECT PAGE_01 FROM CM_CADP1
UNION ALL
 SELECT PAGE_02 FROM CM_CADP1
UNION ALL
 SELECT PAGE_03 FROM CM_CADP1
UNION ALL
 SELECT WEB_URL1 FROM CM_JCHP1
UNION ALL
SELECT WEB_URL2 FROM CM_JCHP1
UNION ALL
SELECT WEB_URL3 FROM CM_JCHP1
) A
WHERE A.PAGE_01 LIKE 'http%'
ORDER BY PAGE
	 */
	public static String replaceInValidURL(String str) {
		String tempStr = str;

		if(tempStr == null) tempStr = "";



		boolean isExists = false;
		if(tempStr.length() > 8 && (tempStr.toLowerCase().startsWith("http") || tempStr.toLowerCase().startsWith("https"))) {

			for(int i=0; i<CommonUtil.validURL.length; i++) {

				//System.out.println(str.toLowerCase() + " : " + validURL[i] + " : " + str.toLowerCase().indexOf(validURL[i]));
				if(tempStr.toLowerCase().indexOf(CommonUtil.validURL[i]) >= 0) {
					isExists = true;
					i = CommonUtil.validURL.length;
				}
			}

			if(!isExists) {
				if(tempStr.toLowerCase().startsWith("https"))
					tempStr = StringUtil.replaceIgnoreCase(tempStr, "https://", "HURLS://");
				else if(tempStr.toLowerCase().startsWith("http"))
					tempStr = StringUtil.replaceIgnoreCase(tempStr, "http://", "HURL://");
			}

		}
		return tempStr;
	}

	public static String replaceSecurityString(String str) {
		String tempStr = str;
		if(tempStr == null) tempStr = "";
		tempStr = replaceInValidURL(tempStr);
		tempStr = replaceCrossSiteScripting(tempStr);
		return tempStr;
	}

	/**
	 * 입력된 문자열중에서 지정된 문자열로 해당문자열을 변환시킨다.
	 **/
	public static String replaceIgnoreCase(String str, String src, String dst)
	{
		String tempStr = str;
		if(str == null || src == null || dst == null || str.length() == 0 || src.length() == 0) return str;

		boolean flag = false;

		int srcLength = src.length(), pos = 0, dstLength = dst.length();

		while(true) {
			pos = str.toLowerCase().indexOf(src.toLowerCase(),pos);
			if(pos != -1) {
				flag = true;
				if((pos+srcLength) < str.length())
					tempStr = str.substring(0,pos) + dst + str.substring(pos+srcLength);
				else
					tempStr = str.substring(0,pos) + dst;

				pos = pos + dstLength;

				if(pos > tempStr.length()) pos = tempStr.length();
			} else {
				flag = false;
				break;
			}
		}
		return tempStr;
	}

	/**
	 * 제휴업체 고객번호, 웹ID 변경
	 **/
	public static String replaceCharFrom(String str) {
		String tempStr = str;
		char[] sbcs_from = "nF`aP1bB2c3y4tMQ5UO6Td7Vsu8XCJ9N0W-Y=[j]K{wG};'f:x,I./DmRE<h>q?eLS~kH!@A#v$%i^g&l*p(r)z_o+|Z".toCharArray();
		char[] sbcs_to = "Z|+o_z)r(p*l&g^i%$v#A@!Hk~SLe?q>h<ERmD/.I,x:f';}Gw{K]j[=Y-W0N9JCX8usV7dT6OU5QMt4y3c2Bb1Pa`Fn".toCharArray();
		char[] source = tempStr.toCharArray();

		tempStr = "";
		for(int i=0; i<source.length; i++) {
			for(int j=0; j<sbcs_from.length; j++) {
				if(source[i] == sbcs_from[j]) {
					tempStr = tempStr + sbcs_to[j];
				}
			}
		}

		return tempStr;
	}

	/**
	 * 제휴업체 고객번호, 웹ID 변경
	 **/
	public static String replaceCharTo(String str) {
		String tempStr = str;
		char[] sbcs_to = "nF`aP1bB2c3y4tMQ5UO6Td7Vsu8XCJ9N0W-Y=[j]K{wG};'f:x,I./DmRE<h>q?eLS~kH!@A#v$%i^g&l*p(r)z_o+|Z".toCharArray();
		char[] sbcs_from = "Z|+o_z)r(p*l&g^i%$v#A@!Hk~SLe?q>h<ERmD/.I,x:f';}Gw{K]j[=Y-W0N9JCX8usV7dT6OU5QMt4y3c2Bb1Pa`Fn".toCharArray();
		char[] source = tempStr.toCharArray();

		tempStr = "";
		for(int i=0; i<source.length; i++) {
			for(int j=0; j<sbcs_from.length; j++) {
				if(source[i] == sbcs_from[j]) {
					tempStr = tempStr + sbcs_to[j];
				}
			}
		}

		return tempStr;
	}

    public static String replace2(String source, String oldPart, String newPart) {
        if (source == null) return "";
        if (oldPart == null || newPart == null) return source;
        StringBuffer stringbuffer = new StringBuffer();
        int last = 0;
        while (true) {
            int start = source.indexOf(oldPart, last);
            if (start >= 0) {
                stringbuffer.append(source.substring(last, start));
                stringbuffer.append(newPart);
                last = start + oldPart.length();
            } else {
                stringbuffer.append(source.substring(last));
                return stringbuffer.toString();
            }
        }
    }

	/**
	 * @name : getStrWhereValueEncoded
	 * @date : 2017. 2. 7.
	 * @author : dg.ryu
	 * @description : WHERE 절 VALUE 인코드
	 */
	public static String getStrWhereValueEncoded(String str, String type){
		String tempStr = str;
		if (ObjectUtil.isNotEmpty(str)){
			tempStr = tempStr.replaceAll("'", "''");
			if ("LIKE".equals(type)) {
				tempStr = tempStr.replaceAll("%", "\\\\%");
				//tempStr = tempStr.replaceAll("_", "\\\\_");
				tempStr = tempStr.replaceAll("_", "_");
				
				//ms-sql 한글이 있을 경우 N타입으로 변경
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
					if (isHangul(tempStr))
						tempStr = "N'%" + tempStr + "%'";
					else 
						tempStr = "'%" + tempStr + "%'";
				} else 
					tempStr = "'%" + tempStr + "%'";
					
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE)) {
					tempStr += " escape '\\'";
				}
			} else if ("LIKE_L".equals(type)) {
				tempStr = tempStr.replaceAll("%", "\\\\%");
				tempStr = tempStr.replaceAll("_", "\\\\_");
				
				//ms-sql 한글이 있을 경우 N타입으로 변경
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
					if (isHangul(tempStr))
						tempStr = "N'" + tempStr + "%'";
					else 
						tempStr = "'" + tempStr + "%'";
				} else 
					tempStr = "'" + tempStr + "%'";
				
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE)) {
					tempStr += " escape '\\'";
				}
				
			} else if ("LIKE_R".equals(type)) {
				tempStr = tempStr.replaceAll("%", "\\\\%");
				tempStr = tempStr.replaceAll("_", "\\\\_");
				
				//ms-sql 한글이 있을 경우 N타입으로 변경
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
					if (isHangul(tempStr))
						tempStr = "N'%" + tempStr + "'";
					else 
						tempStr = "'%" + tempStr + "'";
				} else 
					tempStr = "'%" + tempStr + "'";
				
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE)) {
					tempStr += " escape '\\'";
				}
				
			} else {
				//ms-sql 한글이 있을 경우 N타입으로 변경
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
					if (isHangul(tempStr))
						tempStr = "N'" + tempStr + "'";
					else 
						tempStr = "'" + tempStr + "'";
				} else 
					tempStr = "'" + tempStr + "'";				
			}
		}

		return tempStr;
	}
	
	/**
	 * @name : getStrWhereSecurityValueEncoded
	 * @date : 2017. 2. 7.
	 * @author : dg.ryu
	 * @description : WHERE 절 VALUE 인코드
	 */
	public static String getStrWhereSecurityValueEncoded(String str, String type){
		String strdata = str;
		String typedata = type;
		if (ObjectUtil.isNotEmpty(strdata)){
			strdata = strdata.replaceAll("'", "''");
			if ("LIKE".equals(typedata)) {
				strdata = strdata.replaceAll("%", "\\\\%");
				strdata = strdata.replaceAll("_", "\\\\_");
				
				//ms-sql 한글이 있을 경우 N타입으로 변경
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
					if (isHangul(strdata))
						strdata = "N'%" + strdata + "%'";
					else 
						strdata = "'%" + strdata + "%'";
				} else 
					strdata = "'%" + strdata + "%'";
				
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE)) {
					strdata += " escape '\\'";
				}
			} else if ("LIKE_L".equals(typedata)) {
					strdata = strdata.replaceAll("%", "\\\\%");
					strdata = strdata.replaceAll("_", "\\\\_");
					
					//ms-sql 한글이 있을 경우 N타입으로 변경
					if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
						if (isHangul(strdata))
							strdata = "N'" + strdata + "%'";
						else 
							strdata = "'" + strdata + "%'";
					} else 
						strdata = "'" + strdata + "%'";
					
					if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE)) {
						strdata += " escape '\\'";
					}
			} else if ("LIKE_R".equals(typedata)) {
				strdata = strdata.replaceAll("%", "\\\\%");
				strdata = strdata.replaceAll("_", "\\\\_");
				
				//ms-sql 한글이 있을 경우 N타입으로 변경
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
					if (isHangul(strdata))
						strdata = "N'%" + strdata + "'";
					else 
						strdata = "'%" + strdata + "'";
				} else 
					strdata = "'%" + strdata + "'";
				
				if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE)) {
					strdata += " escape '\\'";
				}
			}
		}

		return strdata;
	}

	/**
	 * @name : getStrWhereValueDecoded
	 * @date : 2017. 2. 7.
	 * @author : dg.ryu
	 * @description : WHERE 절 VALUE 디코드
	 */
	public static String getStrWhereValueDecoded(String str, String type){
		String strdata = str;
		String typedata = type;
		
		//LogUtil.debug("===== strdata: " + strdata + " typedata: " + typedata);
		
		if(ObjectUtil.isNotEmpty(strdata)){
			//ms-sql 한글이 있을 경우 N타입으로 제거
			if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
				if (isHangul(strdata))
					strdata = strdata.replaceAll("N'", "'");
			}
			
			strdata = strdata.replaceAll("''", "'");
			
			//LogUtil.debug("===== strdata1: " + strdata);
			
			if("LIKE".equals(typedata)) {
				strdata = strdata.replaceAll("\\\\\\%", "%");
				strdata = strdata.replaceAll("\\\\\\_", "_");
				strdata = strdata.replaceAll(" escape '\\\\'", "");

				// '% 제거
				strdata = strdata.substring(2, strdata.length() - 2);
			} else if("LIKE_L".equals(typedata)) {
				strdata = strdata.replaceAll("\\\\\\%", "%");
				strdata = strdata.replaceAll("\\\\\\_", "_");
				strdata = strdata.replaceAll(" escape '\\\\'", "");

				// '% 제거
				strdata = strdata.substring(1, strdata.length()-2);
			} else if("LIKE_R".equals(typedata)) {
				strdata = strdata.replaceAll("\\\\\\%", "%");
				strdata = strdata.replaceAll("\\\\\\_", "_");
				strdata = strdata.replaceAll(" escape '\\\\'", "");

				// '% 제거
				strdata = strdata.substring(2, strdata.length()-1);
			} else {
				// ' 제거
				if ("'".equals(strdata.substring(0, 1)) && "'".equals(strdata.substring(strdata.length()-1))) {
					strdata = strdata.substring(1, strdata.length()-1);
				}
			}
		}
		
		//LogUtil.debug("===== strdata2: " + strdata);
		
		return strdata;
	}

	/**
	 * 숫자로 이루어진 8자리 문자열을 delimeter로 구분된 날짜 문자열을 생성 리턴
	 * @param fieldValue
	 * @param delimeter
	 * @return
	 */
	public static String formatDate(String fieldValue, String delimeter) {
		return fieldValue.substring(0, 4) + delimeter + fieldValue.substring(4, 6) + delimeter + fieldValue.substring(6, 8);
	}

	/**
	 * 정규식 실행
	 * @param target
	 * @param regEx
	 * @return
	 */
	public static boolean isSuccessRegEx(String target, String regEx) {
		return Pattern.matches(regEx, target);
	}

	public static boolean isLessThanMaxLength(String target, int maxLength) {
		return target.length() <= maxLength ? true : false;
	}

	public static boolean isMoreThanMinLength(String target, int minLength) {
		return target.length() >= minLength ? true : false;
	}

	public static boolean isBetweenLength(String target, int minLength, int maxLength) {
        return target.length() >= minLength && target.length() <= maxLength ? true : false;
    }

    /**
     * 인코딩 확인
     */
    public static void charSetCheck(String originalStr) {
        String[] charSet = { "utf-8", "euc-kr", "ksc5601", "iso-8859-1", "x-windows-949" };

        for (int i = 0; i < charSet.length; i++) {
            for (int j = 0; j < charSet.length; j++) {
                try {
                    LogUtil.debug("[" + charSet[i] + "," + charSet[j] + "] = " + new String(originalStr.getBytes(charSet[i]), charSet[j]));
                }
                catch (UnsupportedEncodingException e) {
                    LogUtil.error(e);
                }
            }
        }
    }

	/**
	 * jackson 라이브러리를 이용하여 객체를 JSON 형식의 문자열로 반환
	 *
	 * @param obj	대상이 되는 객체
	 * @return		변환된 문자열
	 */
	public  final static String getObjectToJSON(Object obj) {
		String rtnValue = "";
		try {
			  PropertyNamingStrategy namingStrategy = new UpperCaseJsonNamingStrategy();
	    	  
	    	  ObjectMapper mapper = new ObjectMapper();
	    	  mapper.setPropertyNamingStrategy(namingStrategy);
	    	  rtnValue = mapper.writeValueAsString(obj);
//			rtnValue = new ObjectMapper().defaultPrettyPrintingWriter().writeValueAsString(obj);
		} catch (JsonGenerationException e) {
			LogUtil.info(e.getMessage());
		} catch (JsonMappingException e) {
			LogUtil.info(e.getMessage());
		} catch (IOException e) {
			LogUtil.info(e.getMessage());
		}
		return rtnValue;
	}
	
	/**
	 * jackson 라이브러리를 이용하여 객체를 JSON 형식의 문자열로 반환
	 *
	 * @param obj	대상이 되는 객체
	 * @return		변환된 문자열
	 */
	public synchronized final static String getObjectToJSON2(Object obj) {
		String rtnValue = "";
		try {
			PropertyNamingStrategy namingStrategy = new DefaultJsonNamingStrategy();
	    	  
	    	  ObjectMapper mapper = new ObjectMapper();
	    	  mapper.setPropertyNamingStrategy(namingStrategy);
	    	  rtnValue = mapper.writeValueAsString(obj);
//			rtnValue = new ObjectMapper().defaultPrettyPrintingWriter().writeValueAsString(obj);
		} catch (JsonGenerationException e) {
			LogUtil.info(e.getMessage());
		} catch (JsonMappingException e) {
			LogUtil.info(e.getMessage());
		} catch (IOException e) {
			LogUtil.info(e.getMessage());
		}
		return rtnValue;
	}
	
	
	

    /**
     * @programId
     * @name strJsontoObject
     * @date 2018. 11. 2.
     * @author jh.kim
     * @param strJson
     * @param theClass
     * @return
     * @description jackson 라이브러리를 이용하여 JSON형태의 문자열을 Object로 반환
     */
    public final static Object strJsontoObject(String strJson, Class<?> theClass) {
        Object rtnValue = null;
        ObjectMapper mapper = new ObjectMapper();
        try {
            if (!theClass.isPrimitive()) {
                rtnValue = theClass.newInstance();
            }
            rtnValue = mapper.readValue(strJson, theClass);
        }
        catch (InstantiationException | IllegalAccessException e) {
            LogUtil.error(e);
        }
        catch (IOException e) {
        	LogUtil.error(e);
        }
        return rtnValue;
    }
    
	/**
	* @programId :
	* @name : convertRcptNoFromBarcodeNo
	* @date : 2018. 12. 18.
	* @author : hy.jun
	* @table :
	* @return : String
	* @description : 바코드번호 -> 영수증번호 변환 (다이소 한정)
	*/
	public static String convertRcptNoFromBarcodeNo(String ss_num) {
		String rcptNo = null;
		String ss_numdata = ss_num;
		
		//신규 영수증 바코드 번호는 14byte 고정.
		if(ss_numdata.length() != 14 && ss_numdata.length() != 15) {
			throw new DataBadRequestException("잘못된 영수증 바코드번호입니다. 바코드번호는 14자리 또는 15자리입니다.");
		}
		
		if(ss_numdata.length() == 15) {
			ss_numdata = ss_numdata.substring(0, 11) + ss_numdata.substring(12, ss_numdata.length());
			LogUtil.info(ss_numdata);
			int[] rcptRuleArr15 = {1,12,2,3,13,4,11,5,6,7,14,8,9,10};
			char[] barcodeNoArr15 = ss_numdata.toCharArray();
			String[] rcptNoArr15 = new String[14]; 
			
			barcodeNoArr15 = ss_numdata.toCharArray();
			for(int i=0; i<14; i++) {
				rcptNoArr15[i] = String.valueOf(barcodeNoArr15[rcptRuleArr15[i]-1]);
			}
			
			ss_numdata = String.join("", rcptNoArr15);
			LogUtil.debug("convertRcptNoFromBarcodeNo(15) >> barcode_num : " + ss_numdata);
			
		}
		
		int[] rcptRuleArr = {1,12,2,3,13,4,11,5,6,7,14,8,9,10};
		char[] barcodeNoArr = ss_numdata.toCharArray();
		String[] rcptNoArr = new String[14]; 
		
		barcodeNoArr = ss_numdata.toCharArray();
		for(int i=0; i<14; i++) {
			if(Character.isLetter(barcodeNoArr[i])) {
				rcptNoArr[rcptRuleArr[i]-1] = String.valueOf(Long.parseLong(String.valueOf(barcodeNoArr[i]), 16));
			} else {
//				rcptNoArr[rcptRuleArr[i]-1] = String.valueOf(barcodeNoArr[i]);
				rcptNoArr[rcptRuleArr[i]-1] = i==3? String.valueOf("0"+barcodeNoArr[i]) : String.valueOf(barcodeNoArr[i]);
			}
		}
		
		rcptNo = "20";
		for(String str : rcptNoArr) {
			//YYYYMMDD+포스번호(5)+일련번호(4)
			rcptNo += str; 
		}
		
		//포스번호(5)+YYYYMMDD+일련번호(4)
		rcptNo = rcptNo.substring(8, 13) + rcptNo.substring(0, 8) + rcptNo.substring(13, 17);
		
		LogUtil.debug("convertRcptNoFromBarcodeNo >> barcode_num : " + ss_numdata + " receipt num : " + rcptNo);
		
		return rcptNo;
	}
	
	/**
	* @programId :
	* @name : isLinebreak
	* @date : 2019. 1. 9.
	* @author : hy.jun
	* @table :
	* @return : boolean
	* @description : 개행문자인지 체크
	*/
	public static boolean isLinebreak(String str) {
		boolean isLinebreak = false;
		
		//OS 별 개행문자 선언
		String unixLineBreak  = Character.toString((char)10); //유닉스 텍스트 개행문자: 0A (십진수로는 10)
		String macLineBreak  = Character.toString((char)13); //맥(MAC) 텍스트 개행문자: 0D (십진수로는 13)
		char CR  = (char) 0x0D;
		char LF  = (char) 0x0A; 
		String CRLF  = Integer.toString(CR + LF);
		
		//개행문자 여부 체크
		if(str.equals(unixLineBreak) || str.equals(macLineBreak) || str.equals(CRLF)) {
			isLinebreak = true;
		}
		
		return isLinebreak;
	}
	
	/**
	* @programId :
	* @name : isLinebreakInclude
	* @date : 2019. 1. 9.
	* @author : hy.jun
	* @table :
	* @return : boolean
	* @description : 개행문자 포함여부 체크
	*/
	public static boolean isLinebreakInclude(String str) {
		boolean isLinebreakInclude = false;
		
		//OS 별 개행문자 선언
		String unixLineBreak  = Character.toString((char)10); //유닉스 텍스트 개행문자: 0A (십진수로는 10)
		String macLineBreak  = Character.toString((char)13); //맥(MAC) 텍스트 개행문자: 0D (십진수로는 13)
		char CR  = (char) 0x0D;
		char LF  = (char) 0x0A; 
		String CRLF  = Integer.toString(CR + LF);
		
		//개행문자 포함 여부 체크
		if(str.contains(unixLineBreak) || str.contains(macLineBreak) || str.contains(CRLF)) {
			isLinebreakInclude = true;
		}
		
		return isLinebreakInclude;
	}
	
	/**
	* @programId :
	* @name : removeLinebreak
	* @date : 2019. 1. 9.
	* @author : hy.jun
	* @table :
	* @return : void
	* @description : 개행문자 제거
	*/
	public static String removeLinebreak(String str) {
		
		String data = str;
		
		//OS 별 개행문자 선언
		String unixLineBreak  = Character.toString((char)10); //유닉스 텍스트 개행문자: 0A (십진수로는 10)
		String macLineBreak  = Character.toString((char)13); //맥(MAC) 텍스트 개행문자: 0D (십진수로는 13)
		char CR  = (char) 0x0D;
		char LF  = (char) 0x0A; 
		String CRLF  = Integer.toString(CR+LF);
		data = data.replaceAll(unixLineBreak, "");
		data = data.replaceAll(macLineBreak, "");
		data = data.replaceAll(CRLF, "");
		
		return data;
	}
	
	  /**
	   * Jaccard 유사성 확인
	   * 두 문자열의 유사성을 확인한다.
	   */
	  public static double similarity(String s1, String s2) {
	    String longer = s1, shorter = s2;
	    if (s1.length() < s2.length()) {
	      longer = s2; shorter = s1;
	    }
	    int longerLength = longer.length();
	    if (longerLength == 0) { return 1.0; }
	    return ((longerLength - editDistance(longer, shorter)) / (double) longerLength) * 100;

	  }

	  public static int editDistance(String s1, String s2) {
		String data1 = s1;
		String data2 = s2;
	    data1 = data1.toLowerCase();
	    data2 = data2.toLowerCase();

	    int[] costs = new int[data2.length() + 1];
	    for (int i = 0; i <= data1.length(); i++) {
	      int lastValue = i;
	      for (int j = 0; j <= data2.length(); j++) {
	        if (i == 0)
	          costs[j] = j;
	        else {
	          if (j > 0) {
	            int newValue = costs[j - 1];
	            if (s1.charAt(i - 1) != data2.charAt(j - 1))
	              newValue = Math.min(Math.min(newValue, lastValue),
	                  costs[j]) + 1;
	            costs[j - 1] = lastValue;
	            lastValue = newValue;
	          }
	        }
	      }
	      if (i > 0)
	        costs[data2.length()] = lastValue;
	    }
	    return costs[data2.length()];
	  }
	  
	  		
		  /*
		  * 1. 메소드명: toCamelCase
		  * 2. 클래스명: CamelCaseColumnMapRowMapper
		  * 3. 작성자명: knlee 
		  * 4. 작성일자: 2020. 8. 27
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		카멜케이스로 문자열 변경
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param s 
		 *   @return	
		 */
		public static String toCamelCase(String s){
		        String[] parts = s.split("_");
		        StringBuilder camelCaseString = new StringBuilder();

		        for (int i = 0; i < parts.length ; i++) {
		            String part = parts[i];
		            camelCaseString.append(toProperCase(part, i != 0 ? true : false)) ;
		        }

		        return camelCaseString.toString();
		 }

		 
	   private static String toProperCase(String s, boolean isCapital) {

	        String rtnValue = "";

	        if(isCapital){
	            rtnValue = s.substring(0, 1).toUpperCase() +  s.substring(1).toLowerCase();
	        }else{
	            rtnValue = s.toLowerCase();
	        }
	        return rtnValue;
	    }
	   

		
		

		public final static Object null2Void(Object param) {
			 String str = null;
			 if (param == null) return "";
			  
			  
			  if (param instanceof String) {
			   str = (String) param;
			  } else if (param instanceof String[]) {
			   str = ((String[]) param)[0];
			  } else if (param instanceof Date) {
			   str = ((Date)param).toString();
			  } else {
			   str = String.valueOf(param);
			  }
			  
			  if (str.equals(""))  return str;
			  else  return str.trim();
			  
		}
		
	
	/*
	 * 1. 메소드명: getRandomPwd
	 * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2021.03.30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 임시 비밀번호 (랜덤 비밀번호) 생성 : (숫자 + 영어 소문자만)
	 *	
	 **		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public static String getRandomChar(int len) {
		char[] charSet = new char[] {'1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'd', 'f', 'g', 'h', 'i', 'j', 'k',  'm', 'n',  'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };
		int idx = 0; 
		StringBuffer sb = new StringBuffer();
		
		for (int i = 0; i < len; i++) { 
			idx = (int) (charSet.length * Math.random());
			sb.append(charSet[idx]);
		} 
		
		return sb.toString();
	}
	
	
	/*
	 * 1. 메소드명: getRandomPwdOnlyNum
	 * 3. 작성자명: 2sh.park
	 * 4. 작성일자: 2021.03.30.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 임의의 숫자 len 길이 만큼 반환(중복제외)
	 *	
	 **		
	 * </PRE>
	 *   @param  reqDto
	*   @return resDto	
	*/
	public static String getRandomNum(int len) {
		Random rand = new Random();
        String numStr = ""; 
        
        for(int i=0;i<len;i++) {
            String ran = Integer.toString(rand.nextInt(10));
                 if(!numStr.contains(ran)) {
                    numStr += ran;
                }else {
                    i-=1;
                }
            }
        return numStr;
	}
	
	//ms-sql 한글 구분용
	public static Boolean isHangul(String word) {
		Boolean isHangul = false;
		
		if(word.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*"))
			isHangul = true;
		
        return isHangul;
	}
	
}

		


		


