package com.icignal.common.base.dto.response;

import java.io.Serializable;


/**
 * 쿠키 반환 클래스
 * 
 * @author jskim
 * 
 */
public class CookieResDto implements Serializable{
	private static final long serialVersionUID = 2042208777378188929L;

	String id;
	String lang;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	@Override
	public String toString() {
//		return "CookieResponseDTO [id=" + id + ", appServiceId=" + appServiceId + ", country=" + country + ", lang=" + lang + "]";
		return "CookieResponseDTO [id=" + id + ", lang=" + lang + "]";
	}
	
}


