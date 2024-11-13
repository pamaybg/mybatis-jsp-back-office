package com.icignal.systemmanagement.employee.dto.response;

import java.io.Serializable;

import com.icignal.common.base.dto.request.BaseReqDto;

public class SystemStoreInfoResDto extends BaseReqDto implements Serializable{
		
	/**
	 * 
	 */
	private static final long serialVersionUID = -6761974581507086171L;
	private String storeId;
	private String storeName;
	private String storeDesc;
	private String memId;
	private String storeType;
	private String storeMarkType;
	
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
