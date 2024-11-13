package com.icignal.systemmanagement.program.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemAuthListResDto extends GridPagingItemResDto {
	//--------사용안함-------------
	private String authNo;
	private String authName;
	private String authDesc;
	private String authCreateDate;
	//-----------------------------	
	private String authCreater;
	private String id;
	
	
	private String autNum;
	private String autNm;
	private String autDesc;
	private String createDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAuthNo() {
		return authNo;
	}
	public void setAuthNo(String authNo) {
		this.authNo = authNo;
	}
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}
	public String getAuthDesc() {
		return authDesc;
	}
	public void setAuthDesc(String authDesc) {
		this.authDesc = authDesc;
	}
	public String getAuthCreater() {
		return authCreater;
	}
	public void setAuthCreater(String authCreater) {
		this.authCreater = authCreater;
	}
	public String getAuthCreateDate() {
		return authCreateDate;
	}
	public void setAuthCreateDate(String authCreateDate) {
		this.authCreateDate = authCreateDate;
	}
	public String getAutNum() {
		return autNum;
	}
	public void setAutNum(String autNum) {
		this.autNum = autNum;
	}
	public String getAutNm() {
		return autNm;
	}
	public void setAutNm(String autNm) {
		this.autNm = autNm;
	}
	public String getAutDesc() {
		return autDesc;
	}
	public void setAutDesc(String autDesc) {
		this.autDesc = autDesc;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	

}
