package com.icignal.common.util;

/**
 * 특수문자 관련 Util 클래스
 * 
 * @author jskim
 *
 */
public class ScriptUtils {
	
	/**
	 * 대상 문자열에서 지정된 문자열들을 percent-encoding 하여 반환한다
	 * @param str	대상이 되는 문자열
	 * @return		변환된 문자열
	 */
	public static String getFilter(String str) {
		String tempString = str;
		//str = str.replaceAll("\\'","''");
		tempString = tempString.replaceAll("\\;","");
		tempString = tempString.replaceAll("\\:","&#58;");
		tempString = tempString.replaceAll("\\#","&#35;");
		tempString = tempString.replaceAll("\\%","&#37;");
		tempString = tempString.replaceAll("--","");
		tempString = tempString.replaceAll("\\<","&lt;");
		tempString = tempString.replaceAll("\\>","&gt;");
		tempString = tempString.replaceAll("\"","&quot;");
		tempString = tempString.replaceAll("\\+","");
		tempString = tempString.replaceAll("\\=","&#61;");
		tempString = tempString.replaceAll("\\&","&amp;");
		tempString = tempString.replaceAll("\\(","&#40;");
		tempString = tempString.replaceAll("\\)","&#41;");
		tempString = tempString.replaceAll("\\\"","&quot;");
		tempString = tempString.replaceAll("\\'","&#39;");
		return tempString;
	}
	
	/**
	 * 대상 문자열에서 percent-encoding 된 지정된 문자열을 디코딩하여 반환한다
	 * @param str	대상이 되는 문자열
	 * @return		변환된 문자열
	 */
	public static String decodeFilter(String str) {
		String tempStr = str;
		tempStr = tempStr.replaceAll("&#40;",	"\\(");	
		tempStr = tempStr.replaceAll("&amp;",	"\\&");
		tempStr = tempStr.replaceAll("&#61;",	"\\=");
		tempStr = tempStr.replaceAll("&quot;",	"\"");
		tempStr = tempStr.replaceAll("&gt;",	"\\>");
		tempStr = tempStr.replaceAll("&lt;",	"\\<");
		tempStr = tempStr.replaceAll("&#37;",	"\\%");
		tempStr = tempStr.replaceAll("&#35;",	"\\#");
		tempStr = tempStr.replaceAll("&#58;",	"\\:");
		return tempStr;
	}	

}
