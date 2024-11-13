package com.icignal.common.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * 네트워크 관련 클래스
 * 
 * @author jskim
 *
 */
public class NetworkUtility {
	/**
	 * 현재 호스트의 IP를 문자열로 반환하는 메소드.
	 * 
	 * @return String	현재 호스트 IP 문자열
	 */
	public  final static String getCurrentIP() {
		String rtnValue = "";
		try {
			rtnValue = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			LogUtil.error(e);
		}
		return rtnValue;
	}
}
