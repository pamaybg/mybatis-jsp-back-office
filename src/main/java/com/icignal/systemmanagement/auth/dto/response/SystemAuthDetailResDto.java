package com.icignal.systemmanagement.auth.dto.response;

import com.icignal.common.base.dto.request.BaseReqDto;

public class SystemAuthDetailResDto extends BaseReqDto {
	
	private String authNo;
	private String authName;
	private String authDesc;
	private String authCreater;
	private String authCreateDate;
	private String authDataType;
	private String pgmObjType;
	
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
	public String getAuthDataType() {
		return authDataType;
	}
	public void setAuthDataType(String authDataType) {
		this.authDataType = authDataType;
	}
	public String getPgmObjType() {
		return pgmObjType;
	}
	public void setPgmObjType(String pgmObjType) {
		this.pgmObjType = pgmObjType;
	}
	
	

}
