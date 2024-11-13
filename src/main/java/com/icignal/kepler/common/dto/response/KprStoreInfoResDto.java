package com.icignal.kepler.common.dto.response;

import java.io.Serializable;

/*
 * 1. 클래스명	: KPRStoreInfoResponseDTO
 * 2. 파일명	: KPRStoreInfoResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprStoreInfoResDto  implements Serializable{

	private static final long serialVersionUID = -6761974581507086171L;
	
	private String storeId;
	private String storeName;
	private String storeDesc;
	private String memId;
	private String storeType;
	private String storeMarkType;
	private String appServiceId;
	private String country;
	private String lang;

	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStoreDesc() {
		return storeDesc;
	}
	public void setStoreDesc(String storeDesc) {
		this.storeDesc = storeDesc;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getAppServiceId() {
		return appServiceId;
	}
	public void setAppServiceId(String appServiceId) {
		this.appServiceId = appServiceId;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getStoreType() {
		return storeType;
	}
	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}
	public String getStoreMarkType() {
		return storeMarkType;
	}
	public void setStoreMarkType(String storeMarkType) {
		this.storeMarkType = storeMarkType;
	}


}
